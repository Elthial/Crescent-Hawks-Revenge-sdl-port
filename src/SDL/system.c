#if defined(_MSC_VER)
#define _CRT_SECURE_NO_WARNINGS
#endif

#include "revenge/platform_backend.h"
#include "revenge/interrupts.h"
#include "revenge/far_memory.h"
#include "revenge/original_data.h"
#include "revenge/original/campaign_data.h"
#include "revenge/original/lance_editor_data.h"
#include "revenge/audio.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static DOS_InterruptHandler interruptHandlers[0x100];
static uint32 legacyInterruptVectors[0x100];
static byte *dosMemoryBlock;
static uint32 dosMemoryBlockBytes;
static uint32 dosMemoryBlockCapacity;
static word16 dosMemoryBlockSegment;
static byte originalDataSegment[0x10000];

void ServiceDigitalPlaybackInterrupt(void);
void PITCalibrationIRQ0Handler(void);

#define ORIGINAL_DATA_SEGMENT_MAPPED_BYTES 0xB8A0

static word16 ReadLittleEndianWord(const byte *bytes)
{
	return (word16)(bytes[0x00] | ((word16)bytes[0x01] << 0x08));
}

static byte *ResolveOriginalDataPointer(word16 dataOffset)
{
	uint32 encodedAddress =
		((uint32)ReadLittleEndianWord(&originalDataSegment[dataOffset + 0x02])
			<< 0x10) |
		ReadLittleEndianWord(&originalDataSegment[dataOffset]);
	return HostFarPointer_Resolve(encodedAddress);
}

static void LoadOriginalModuleImage(byte *programBlock, uint32 blockBytes)
{
	FILE *executable;
	byte mzHeader[0x1C];
	word16 headerParagraphs;
	word16 relocationCount;
	word16 relocationTableOffset;
	long fileSize;
	long moduleSize;
	word16 relocationIndex;

	executable = fopen("REVENGE.EXE", "rb");
	if (executable == NULL)
		return;
	if (fread(mzHeader, sizeof(mzHeader), 0x01, executable) != 0x01 ||
		mzHeader[0x00] != 'M' || mzHeader[0x01] != 'Z')
	{
		fclose(executable);
		return;
	}

	headerParagraphs = ReadLittleEndianWord(&mzHeader[0x08]);
	relocationCount = ReadLittleEndianWord(&mzHeader[0x06]);
	relocationTableOffset = ReadLittleEndianWord(&mzHeader[0x18]);
	fseek(executable, 0x00L, SEEK_END);
	fileSize = ftell(executable);
	moduleSize = fileSize - (long) headerParagraphs * 0x10L;
	/* The DOS PSP occupies the first 100h bytes of the memory block and the
	 * executable module begins at load segment 0800h. */
	if (moduleSize > 0x00 && (uint32) moduleSize + 0x0100UL <= blockBytes)
	{
		fseek(executable, (long) headerParagraphs * 0x10L, SEEK_SET);
		(void) fread(programBlock + 0x0100, 0x01, (size_t) moduleSize,
			executable);
	}

	fseek(executable, relocationTableOffset, SEEK_SET);
	for (relocationIndex = 0x0000; relocationIndex < relocationCount;
		++relocationIndex)
	{
		byte relocation[0x04];
		uint32 targetOffset;
		word16 relocatedSegment;

		if (fread(relocation, sizeof(relocation), 0x01, executable) != 0x01)
			break;
		targetOffset = 0x0100UL +
			(uint32) ReadLittleEndianWord(&relocation[0x02]) * 0x10UL +
			ReadLittleEndianWord(&relocation[0x00]);
		if (targetOffset + 0x01 >= blockBytes)
			continue;
		relocatedSegment = (word16) (
			ReadLittleEndianWord(&programBlock[targetOffset]) + 0x0800);
		programBlock[targetOffset] = (byte) relocatedSegment;
		programBlock[targetOffset + 0x01] = (byte) (relocatedSegment >> 0x08);
	}
	fclose(executable);
}

static void LoadOriginalDataSegment(void)
{
	FILE *executable;
	byte mzHeader[0x1C];
	word16 headerParagraphs;
	word16 relocationCount;
	word16 relocationTableOffset;
	long moduleSize;
	long dataFileOffset;
	word16 relocationIndex;

	memset(originalDataSegment, 0x00, sizeof(originalDataSegment));
	executable = fopen("REVENGE.EXE", "rb");
	if (executable == NULL)
		return;
	if (fread(mzHeader, sizeof(mzHeader), 0x01, executable) != 0x01 ||
		mzHeader[0x00] != 'M' || mzHeader[0x01] != 'Z')
	{
		fclose(executable);
		return;
	}

	headerParagraphs = ReadLittleEndianWord(&mzHeader[0x08]);
	relocationCount = ReadLittleEndianWord(&mzHeader[0x06]);
	relocationTableOffset = ReadLittleEndianWord(&mzHeader[0x18]);
	dataFileOffset = (long)headerParagraphs * 0x10L + 0x326A0L;
	fseek(executable, 0x00L, SEEK_END);
	moduleSize = ftell(executable) - (long)headerParagraphs * 0x10L;
	if (moduleSize > 0x326A0L)
	{
		size_t initializedByteCount = (size_t)(moduleSize - 0x326A0L);
		if (initializedByteCount > sizeof(originalDataSegment))
			initializedByteCount = sizeof(originalDataSegment);
		fseek(executable, dataFileOffset, SEEK_SET);
		(void)fread(originalDataSegment, 0x01, initializedByteCount,
			executable);
	}

	fseek(executable, relocationTableOffset, SEEK_SET);
	for (relocationIndex = 0x0000; relocationIndex < relocationCount;
		++relocationIndex)
	{
		byte relocation[0x04];
		uint32 targetLinear;
		word16 dataOffset;
		word16 relocatedSegment;

		if (fread(relocation, sizeof(relocation), 0x01, executable) != 0x01)
			break;
		targetLinear = (uint32)ReadLittleEndianWord(&relocation[0x02]) *
			0x10UL + ReadLittleEndianWord(&relocation[0x00]);
		if (targetLinear < 0x326A0UL || targetLinear >= 0x4269FUL)
			continue;
		dataOffset = (word16)(targetLinear - 0x326A0UL);
		relocatedSegment = (word16)(
			ReadLittleEndianWord(&originalDataSegment[dataOffset]) + 0x0800);
		originalDataSegment[dataOffset] = (byte)relocatedSegment;
		originalDataSegment[dataOffset + 0x01] = (byte)(relocatedSegment >> 0x08);
	}
	fclose(executable);
}

void SDLBackend_InitializeDOSMemoryArena(void)
{
	word16 graphicsBufferIndex;
	/* Borland establishes these CRT break values before calling main. The host
	 * entry shim supplies the equivalent conventional-memory arena so the
	 * preserved sbrk/far-heap procedures can remain unchanged. */
	/* REVENGE.EXE loads at 0800h with its PSP at 07F0h.  The 3A7Ah-paragraph
	 * load image plus the MZ header's 038Ah minimum allocation reaches 4604h,
	 * which is where Borland establishes the first legal program break. */
	MemoryBlockSegment = 0x07F0;
	MinimumProgramBreakSegment = 0x4604;
	MinimumProgramBreakOffset = 0x0000;
	CurrentProgramBreakSegment = 0x4604;
	CurrentProgramBreakOffset = 0x0000;
	MaximumProgramBreakSegment = 0xA000;
	MaximumProgramBreakOffset = 0x0000;
	ProgramBreakKilobytes = 0x0000;

	/* The DOS loader copied the initialized portion of segment 3A6A from the
	 * MZ image, zero-filled its BSS tail, and applied load-segment relocations.
	 * Recreate that data edge so preserved DS:offset expressions address the
	 * same bytes. Named globals are registered first as overlays where the C17
	 * transcription exposes an independently typed object. */
	LoadOriginalDataSegment();
	HostFarPointer_RegisterAt(&PresentationDismissTimeout,
		sizeof(PresentationDismissTimeout), 0x3A6A240FUL);
	HostFarPointer_RegisterAt(&SceneTransitionAbortFlag,
		sizeof(SceneTransitionAbortFlag), 0x3A6AA864UL);
	HostFarPointer_RegisterAt(TextWindowContexts,
		sizeof(TextWindowContexts), 0x3A6A063AUL);
	HostFarPointer_RegisterAt(UiRegionTable,
		sizeof(UiRegionTable), 0x3A6A07AAUL);
	HostFarPointer_RegisterAt(LiveScenarioUnits,
		sizeof(LiveScenarioUnits), 0x3A6A99E0UL);
	HostFarPointer_RegisterAt(HeatDissipationBySinkCountQ8_8,
		sizeof(HeatDissipationBySinkCountQ8_8), 0x3A6A176AUL);
	HostFarPointer_RegisterAt(&TacticalStatusBlinkCountdown,
		sizeof(TacticalStatusBlinkCountdown), 0x3A6A2F36UL);
	HostFarPointer_RegisterAt(&DisplayedTacticalStatusRow,
		sizeof(DisplayedTacticalStatusRow), 0x3A6A2F38UL);
	HostFarPointer_RegisterAt(TacticalStatusRowInvalidation,
		sizeof(TacticalStatusRowInvalidation), 0x3A6AB574UL);
	HostFarPointer_RegisterAt(TacticalImpactQueue,
		sizeof(TacticalImpactQueue), 0x3A6AB2F4UL);
	HostFarPointer_RegisterAt(&TacticalStatusBlinkVisible,
		sizeof(TacticalStatusBlinkVisible), 0x3A6A86BDUL);
	HostFarPointer_RegisterAt(SceneNarrationEventFlags,
		sizeof(SceneNarrationEventFlags), 0x3A6AAE63UL);
#define REGISTER_DATA_OBJECT(object, offset) \
	HostFarPointer_RegisterAt(&(object), sizeof(object), \
		0x3A6A0000UL + (offset))
	REGISTER_DATA_OBJECT(TrainingScenarioCompletionFlags, 0x00A0);
	REGISTER_DATA_OBJECT(ScreenPaletteResourceByScreen, 0x1703);
	REGISTER_DATA_OBJECT(SaveDirectory, 0x18CE);
	REGISTER_DATA_OBJECT(SaveCampaignSnapshot, 0x1956);
	REGISTER_DATA_OBJECT(InitialCampaignState, 0x1B77);
	REGISTER_DATA_OBJECT(ForwardCampaignState, 0x1B7E);
	REGISTER_DATA_OBJECT(ReplayCampaignState, 0x1B85);
	REGISTER_DATA_OBJECT(InitialExtendedCampaignState, 0x1B8F);
	REGISTER_DATA_OBJECT(ForwardExtendedCampaignState, 0x1B9E);
	REGISTER_DATA_OBJECT(ReplayExtendedCampaignState, 0x1BAD);
	REGISTER_DATA_OBJECT(ScenarioOrdinalBaseByCampaignStage, 0x254C);
	REGISTER_DATA_OBJECT(MissionFadeColorTable, 0x2718);
	REGISTER_DATA_OBJECT(MissionBlinkRectX, 0x271C);
	REGISTER_DATA_OBJECT(MissionBlinkRectY, 0x272A);
	REGISTER_DATA_OBJECT(MissionBlinkRectExtent, 0x2738);
	REGISTER_DATA_OBJECT(MissionDateMonthIndex, 0x273F);
	REGISTER_DATA_OBJECT(MissionDateYear, 0x274B);
	REGISTER_DATA_OBJECT(MissionDateAdvanceMonths, 0x2763);
	REGISTER_DATA_OBJECT(MissionSpriteSourceTileX, 0x2783);
	REGISTER_DATA_OBJECT(MissionSpriteSourcePixelY, 0x279B);
	REGISTER_DATA_OBJECT(MissionSpriteWidthTiles, 0x27B3);
	REGISTER_DATA_OBJECT(MissionSpriteHeightPixels, 0x27CB);
	REGISTER_DATA_OBJECT(CampaignMessageTable, 0x2B54);
	REGISTER_DATA_OBJECT(LoadedSceneFile, 0x71A8);
	REGISTER_DATA_OBJECT(SceneUnitRoutes, 0x86C1);
	REGISTER_DATA_OBJECT(SceneInstructionBaseOffset, 0xA862);
	REGISTER_DATA_OBJECT(SceneInstructionCursor, 0xA9D9);
	REGISTER_DATA_OBJECT(ScenarioResourcePathPointer, 0x1554);
	REGISTER_DATA_OBJECT(RandomSelectionPoolCount, 0x1B8E);
	REGISTER_DATA_OBJECT(UnitSelectionCards, 0x1BBC);
	REGISTER_DATA_OBJECT(LanceAssignments, 0x1CCA);
	REGISTER_DATA_OBJECT(TacticalUpdateDelayReloadTicks, 0x17DA);
	REGISTER_DATA_OBJECT(TacticalGameSpeedIndex, 0x17DC);
	REGISTER_DATA_OBJECT(LanceEditorFirstBriefingPending, 0x30C4);
	REGISTER_DATA_OBJECT(LanceEditorBriefingPresented, 0x30C6);
	REGISTER_DATA_OBJECT(LanceEditorReloadGraphics, 0x30C8);
	REGISTER_DATA_OBJECT(UnitEditorLanceSlotCount, 0x3112);
	REGISTER_DATA_OBJECT(RandomUnitTypeCount, 0x3118);
	REGISTER_DATA_OBJECT(UnitEditorUnitSpriteIndex, 0x3119);
	REGISTER_DATA_OBJECT(UnitMovementClassByType, 0x3172);
	REGISTER_DATA_OBJECT(PredefinedUnitTypeTable, 0x31CB);
	REGISTER_DATA_OBJECT(UnitEditorSectionEnabled, 0x31E9);
	REGISTER_DATA_OBJECT(UnitEditorScenarioCardCountByFamily, 0x3206);
	REGISTER_DATA_OBJECT(RandomUnitTypeCountByFamily, 0x320D);
	REGISTER_DATA_OBJECT(RandomUnitTypePoolByFamily, 0x3217);
	REGISTER_DATA_OBJECT(PilotPortraitIndexById, 0x3248);
	REGISTER_DATA_OBJECT(DefaultPilotIdsByScenario, 0x3269);
	REGISTER_DATA_OBJECT(UnitEditorPilotCardCountByFamily, 0x3291);
	REGISTER_DATA_OBJECT(FixedPilotIds, 0x3354);
	REGISTER_DATA_OBJECT(FixedUnitTypeIds, 0x3356);
	REGISTER_DATA_OBJECT(LanceEditorLayout, 0x3470);
#undef REGISTER_DATA_OBJECT
	HostFarPointer_RegisterAt(originalDataSegment,
		ORIGINAL_DATA_SEGMENT_MAPPED_BYTES, 0x3A6A0000UL);

	/* These initialized DS words are represented as typed C globals because
	 * they are used throughout the preserved UI code.  Hydrate them from the
	 * loaded image just as the DOS loader did for their original storage. */
	UiNavigationUpKey =
		ReadLittleEndianWord(&originalDataSegment[0x6242]);
	UiNavigationDownKey =
		ReadLittleEndianWord(&originalDataSegment[0x6244]);
	UiPreviousRegionKey =
		ReadLittleEndianWord(&originalDataSegment[0x6246]);
	UiNextRegionKey =
		ReadLittleEndianWord(&originalDataSegment[0x6248]);
	memcpy(TextWindowContexts, &originalDataSegment[0x063A],
		sizeof(TextWindowContexts));
	memcpy(UiRegionTable, &originalDataSegment[0x07AA],
		sizeof(UiRegionTable));
	SecondaryScreenBuffer = ResolveOriginalDataPointer(0x83DE);
	PlanarScreenBuffer = ResolveOriginalDataPointer(0x83E2);
	ActiveRenderTarget = ResolveOriginalDataPointer(0x7D3B);
	for (graphicsBufferIndex = 0x00; graphicsBufferIndex < 0x20;
		++graphicsBufferIndex)
	{
		SharedGraphicsBackingBuffers[graphicsBufferIndex] =
			ResolveOriginalDataPointer((word16)(0x83EE + graphicsBufferIndex * 0x04));
	}
	PrimaryScreenBuffer = ResolveOriginalDataPointer(0xB65E);
	VideoFramebuffer = ResolveOriginalDataPointer(0xB664);
	memcpy(HeatDissipationBySinkCountQ8_8,
		&originalDataSegment[0x176A],
		sizeof(HeatDissipationBySinkCountQ8_8));
	TacticalStatusBlinkCountdown =
		ReadLittleEndianWord(&originalDataSegment[0x2F36]);
	DisplayedTacticalStatusRow =
		ReadLittleEndianWord(&originalDataSegment[0x2F38]);
	memcpy(TacticalStatusRowInvalidation,
		&originalDataSegment[0xB574],
		sizeof(TacticalStatusRowInvalidation));
	memcpy(TacticalImpactQueue, &originalDataSegment[0xB2F4],
		sizeof(TacticalImpactQueue));
	TacticalStatusBlinkVisible = originalDataSegment[0x86BD];
	memcpy(SceneNarrationEventFlags,
		&originalDataSegment[0xAE63], sizeof(SceneNarrationEventFlags));

#define HYDRATE_DATA_OBJECT(object, offset) \
	memcpy(&(object), &originalDataSegment[(offset)], sizeof(object))
	HYDRATE_DATA_OBJECT(TrainingScenarioCompletionFlags, 0x00A0);
	HYDRATE_DATA_OBJECT(ScreenPaletteResourceByScreen, 0x1703);
	HYDRATE_DATA_OBJECT(SaveDirectory, 0x18CE);
	HYDRATE_DATA_OBJECT(SaveCampaignSnapshot, 0x1956);
	HYDRATE_DATA_OBJECT(InitialCampaignState, 0x1B77);
	HYDRATE_DATA_OBJECT(ForwardCampaignState, 0x1B7E);
	HYDRATE_DATA_OBJECT(ReplayCampaignState, 0x1B85);
	HYDRATE_DATA_OBJECT(InitialExtendedCampaignState, 0x1B8F);
	HYDRATE_DATA_OBJECT(ForwardExtendedCampaignState, 0x1B9E);
	HYDRATE_DATA_OBJECT(ReplayExtendedCampaignState, 0x1BAD);
	HYDRATE_DATA_OBJECT(ScenarioOrdinalBaseByCampaignStage, 0x254C);
	HYDRATE_DATA_OBJECT(MissionFadeColorTable, 0x2718);
	HYDRATE_DATA_OBJECT(MissionBlinkRectX, 0x271C);
	HYDRATE_DATA_OBJECT(MissionBlinkRectY, 0x272A);
	HYDRATE_DATA_OBJECT(MissionBlinkRectExtent, 0x2738);
	HYDRATE_DATA_OBJECT(MissionDateMonthIndex, 0x273F);
	HYDRATE_DATA_OBJECT(MissionDateYear, 0x274B);
	HYDRATE_DATA_OBJECT(MissionDateAdvanceMonths, 0x2763);
	HYDRATE_DATA_OBJECT(MissionSpriteSourceTileX, 0x2783);
	HYDRATE_DATA_OBJECT(MissionSpriteSourcePixelY, 0x279B);
	HYDRATE_DATA_OBJECT(MissionSpriteWidthTiles, 0x27B3);
	HYDRATE_DATA_OBJECT(MissionSpriteHeightPixels, 0x27CB);
	HYDRATE_DATA_OBJECT(CampaignMessageTable, 0x2B54);
	HYDRATE_DATA_OBJECT(LoadedSceneFile, 0x71A8);
	HYDRATE_DATA_OBJECT(SceneUnitRoutes, 0x86C1);
	HYDRATE_DATA_OBJECT(SceneInstructionBaseOffset, 0xA862);
	HYDRATE_DATA_OBJECT(SceneInstructionCursor, 0xA9D9);
	HYDRATE_DATA_OBJECT(ScenarioResourcePathPointer, 0x1554);
	HYDRATE_DATA_OBJECT(RandomSelectionPoolCount, 0x1B8E);
	HYDRATE_DATA_OBJECT(UnitSelectionCards, 0x1BBC);
	HYDRATE_DATA_OBJECT(LanceAssignments, 0x1CCA);
	HYDRATE_DATA_OBJECT(TacticalUpdateDelayReloadTicks, 0x17DA);
	HYDRATE_DATA_OBJECT(TacticalGameSpeedIndex, 0x17DC);
	HYDRATE_DATA_OBJECT(LanceEditorFirstBriefingPending, 0x30C4);
	HYDRATE_DATA_OBJECT(LanceEditorBriefingPresented, 0x30C6);
	HYDRATE_DATA_OBJECT(LanceEditorReloadGraphics, 0x30C8);
	HYDRATE_DATA_OBJECT(UnitEditorLanceSlotCount, 0x3112);
	HYDRATE_DATA_OBJECT(RandomUnitTypeCount, 0x3118);
	HYDRATE_DATA_OBJECT(UnitEditorUnitSpriteIndex, 0x3119);
	HYDRATE_DATA_OBJECT(UnitMovementClassByType, 0x3172);
	HYDRATE_DATA_OBJECT(PredefinedUnitTypeTable, 0x31CB);
	HYDRATE_DATA_OBJECT(UnitEditorSectionEnabled, 0x31E9);
	HYDRATE_DATA_OBJECT(UnitEditorScenarioCardCountByFamily, 0x3206);
	HYDRATE_DATA_OBJECT(RandomUnitTypeCountByFamily, 0x320D);
	HYDRATE_DATA_OBJECT(RandomUnitTypePoolByFamily, 0x3217);
	HYDRATE_DATA_OBJECT(PilotPortraitIndexById, 0x3248);
	HYDRATE_DATA_OBJECT(DefaultPilotIdsByScenario, 0x3269);
	HYDRATE_DATA_OBJECT(UnitEditorPilotCardCountByFamily, 0x3291);
	HYDRATE_DATA_OBJECT(FixedPilotIds, 0x3354);
	HYDRATE_DATA_OBJECT(FixedUnitTypeIds, 0x3356);
	HYDRATE_DATA_OBJECT(LanceEditorLayout, 0x3470);
#undef HYDRATE_DATA_OBJECT

	/* REVENGE.EXE stores the active driver's 16-bit near offset at DS:62B8. */
	MIDIParser.ActiveDriverOffset =
		ReadLittleEndianWord(&originalDataSegment[0x62B8]);
}

_Noreturn void SDLBackend_TerminateProcess(byte exitCode)
{
	SDLBackend_Close();
	exit((int) exitCode);
}

void RevengeHost_EnableInterruptDelivery(void)
{
    /* Timer services are dispatched cooperatively by the host main loop, so
       they cannot pre-empt an original procedure between these boundaries. */
}

void RevengeHost_DisableInterruptDelivery(void)
{
    /* See RevengeHost_EnableInterruptDelivery. */
}

static int ReadLocalTimeValue(time_t currentTime, struct tm *localTime)
{
#if !defined(_WIN32)
    struct tm *result;
#endif

#if defined(_WIN32)
    if (localtime_s(localTime, &currentTime) != 0)
        return 0;
#else
    result = localtime(&currentTime);
    if (result == 0)
        return 0;

    *localTime = *result;
#endif
    return 1;
}

static int ReadLocalTime(struct tm *localTime)
{
    return ReadLocalTimeValue(time(0), localTime);
}

word16 SDLBackend_ResizeMemoryBlock(
    word16 memorySegment,
    word16 paragraphCount)
{
	uint32 requestedBytes = (uint32) paragraphCount << 0x04;
	uint32 maximumBytes;

	if (requestedBytes == 0x00000000UL)
	{
		if (dosMemoryBlock != NULL)
		{
			HostFarPointer_Unregister(dosMemoryBlock);
			free(dosMemoryBlock);
		}
		dosMemoryBlock = NULL;
		dosMemoryBlockBytes = 0x00000000UL;
		dosMemoryBlockCapacity = 0x00000000UL;
		dosMemoryBlockSegment = 0x0000;
		return 0xFFFF;
	}

	/* DOS AH=4Ah changes the size of an existing conventional-memory block;
	 * its segment and all pointers into it remain stable.  Reserve the complete
	 * segment-to-A000 arena once, then change only the logical byte count. */
	maximumBytes = memorySegment < 0xA000
		? (uint32) (0xA000 - memorySegment) << 0x04
		: 0x00000000UL;
	if (dosMemoryBlock == NULL)
	{
		dosMemoryBlock = (byte *) calloc(0x01, maximumBytes);
		if (dosMemoryBlock == NULL)
			return (word16) (maximumBytes >> 0x04);
		dosMemoryBlockCapacity = maximumBytes;
		dosMemoryBlockSegment = memorySegment;
		LoadOriginalModuleImage(dosMemoryBlock, dosMemoryBlockCapacity);
		HostFarPointer_RegisterAt(dosMemoryBlock, dosMemoryBlockCapacity,
			(uint32) dosMemoryBlockSegment << 0x10);
	}
	if (memorySegment != dosMemoryBlockSegment ||
		requestedBytes > dosMemoryBlockCapacity)
		return (word16) (dosMemoryBlockCapacity >> 0x04);
	dosMemoryBlockBytes = requestedBytes;
	return 0xFFFF;
}

word16 SDLBackend_GetLargestFreeConventionalMemoryParagraphs(
	word16 requestedParagraphs)
{
	/* The host has no DOS conventional-memory arena. Report the requested
	 * capacity at this lowest platform boundary; the preserved caller retains
	 * the original paragraph-to-KiB conversion and 640-KiB cap. */
	return requestedParagraphs;
}

void SDLBackend_GetSystemDate(DOS_Date *date)
{
    struct tm localTime;

    if (date == 0 || !ReadLocalTime(&localTime))
        return;

    date->year = (uint16)(localTime.tm_year + 0x076C);
    date->month = (byte)(localTime.tm_mon + 0x01);
    date->day = (byte)localTime.tm_mday;
}

void SDLBackend_GetSystemTime(DOS_Time *timeValue)
{
    struct timespec currentTime;
    struct tm localTime;

    if (timeValue == 0 ||
        timespec_get(&currentTime, TIME_UTC) != TIME_UTC ||
        !ReadLocalTimeValue(currentTime.tv_sec, &localTime))
        return;

    timeValue->hour = (byte)localTime.tm_hour;
    timeValue->minute = (byte)localTime.tm_min;
    timeValue->second = (byte)localTime.tm_sec;
    timeValue->hundredth = (byte)(currentTime.tv_nsec / 10000000L);
}

const char *SDLBackend_GetEnvironmentVariable(const char *name)
{
	return getenv(name);
}

void SDLBackend_InvokeInterrupt(
	byte interruptNumber,
	const InterruptRegisterBlock *inputRegisters,
	InterruptRegisterBlock *outputRegisters,
	InterruptSegmentState *segmentState)
{
	*outputRegisters = *inputRegisters;
	outputRegisters->carry = FALSE;
	outputRegisters->flags = 0x0000;

	if (interruptNumber == 0x10)
	{
		byte service = (byte) (inputRegisters->ax >> 0x08);
		if (service == 0x00)
			SDLBackend_SetVideoMode((byte) inputRegisters->ax);
		else if (service == 0x0F)
			outputRegisters->ax = SDLBackend_GetVideoMode();
	}
	(void) segmentState;
}

void SDLBackend_SetInterruptVector(
    byte interruptNumber,
    DOS_InterruptHandler handler)
{
    /* Host callbacks replace the DOS IVT. Registration is retained so timer,
     * keyboard, and critical-error seams can be connected incrementally. */
    interruptHandlers[interruptNumber] = handler;
}

void SDLBackend_DispatchInterrupt(byte interruptNumber)
{
	DOS_InterruptHandler handler = interruptHandlers[interruptNumber];

	if (handler != NULL)
		handler();
}

DOS_InterruptHandler SDLBackend_SwapInterruptHandler(
    byte interruptNumber,
    DOS_InterruptHandler handler)
{
    DOS_InterruptHandler previousHandler;

    previousHandler = interruptHandlers[interruptNumber];
    interruptHandlers[interruptNumber] = handler;
    return previousHandler;
}

uint32 SDLBackend_SwapInterruptVector(
    byte interruptNumber,
    uint32 newVector)
{
    uint32 oldVector;

    oldVector = legacyInterruptVectors[interruptNumber];
    legacyInterruptVectors[interruptNumber] = newVector;
    return oldVector;
}

void SDLBackend_ChainInterruptVector(uint32 interruptVector)
{
	DOS_InterruptHandler handler = NULL;

	switch (interruptVector)
	{
	case 0x375F0A1DUL:
		handler = ServiceDigitalPlaybackInterrupt;
		break;
	case 0x38AE00D7UL:
		handler = PITCalibrationIRQ0Handler;
		break;
	}
	if (handler != NULL)
		handler();
}

void SDLBackend_DispatchInstalledInterruptVector(byte interruptNumber)
{
	SDLBackend_ChainInterruptVector(legacyInterruptVectors[interruptNumber]);
}

void SDLBackend_ProgramPITChannel0(word16 divisor)
{
    /* The cooperative host timer has no programmable PIT. The preserved
       procedure still owns the divisor state exchanged around this call. */
    (void)divisor;
}

void SDLBackend_ProgramPITChannel0Mode(byte mode, word16 divisor)
{
    (void)mode;
    (void)divisor;
}

word16 SDLBackend_LatchPITChannel0Count(void)
{
    return 0x0000;
}

void SDLBackend_WaitPITChannel0Interrupt(void)
{
    SDLBackend_Delay(0x0037);
}

word16 SDLBackend_SaveAndDisableInterrupts(void)
{
    RevengeHost_DisableInterruptDelivery();
    return 0x0200;
}

void SDLBackend_RestoreInterruptFlags(word16 flags)
{
    if ((flags & 0x0200) != 0x0000)
        RevengeHost_EnableInterruptDelivery();
}

void SDLBackend_AcknowledgeInterrupt(byte interruptNumber)
{
    /* Host callbacks do not require a programmable-interrupt-controller EOI. */
    (void)interruptNumber;
}

uint32 SDLBackend_GetBIOSTickCount(void)
{
    /* DOS advances 0000:046C about 18.2 times per second. */
    return (uint32)((SDLBackend_Milliseconds() * UINT64_C(0x00B6)) /
        UINT64_C(0x2710));
}
