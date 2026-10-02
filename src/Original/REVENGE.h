#ifndef REVENGE_ORIGINAL_H
#define REVENGE_ORIGINAL_H

/*
 * Shared declarations for the preservation transcription of REVENGE.EXE.
 *
 * Only contracts supported by a Verified METHOD_TABLE entry belong here.
 * Reko's generated Eq_* type graph is intentionally not imported: those
 * names describe inference state, not types established by the executable.
 */

#include "revenge/dos.h"
#include "revenge/far_memory.h"
#include "revenge/interrupts.h"
#include "revenge/types.h"
#include "revenge/unit.h"

#include <stddef.h>

#if !defined(__near)
#define __near
#endif

typedef int8_t int8;
typedef uint8_t uint8;
typedef int32_t int32;
typedef uint32_t word32;
typedef uint32_t segptr32;
typedef uint8 ui8;
typedef uint16 ui16;
typedef const uint8 cu8;
typedef const uint16 cui16;
typedef const int16 ci16;

#pragma pack(push, 1)
typedef struct LocalClockSnapshot
{
	uint32 epochSeconds;
	word16 milliseconds;
	int16 timezoneOffsetMinutes;
	word16 daylightSavingActive;
} LocalClockSnapshot;
#pragma pack(pop)

_Static_assert(sizeof(LocalClockSnapshot) == 0x0A,
	"LocalClockSnapshot must retain its DOS layout");

typedef struct FarHeapBlockHeader
{
	uint32 sizeAndAllocated;
	segptr32 previousPhysical;
	segptr32 previousFree;
	segptr32 nextFree;
} FarHeapBlockHeader;

#pragma pack(push, 1)
typedef struct DigitalSampleDescriptor
{
	word16 NextDescriptorOffset;
	word16 NextDescriptorSegment;
	word16 PreviousLinkOffset;
	word16 PreviousLinkSegment;
	word16 OwnerQueueOffset;
	word16 OwnerQueueSegment;
	word16 SampleDataOffset;
	word16 SampleDataSegment;
	word16 SampleLength;
	word16 LoopStart;
	word16 LoopEnd;
	word16 LoopLength;
	word16 SourceRateHz;
	word16 PlaybackScale;
	word16 SourceStepFraction;
	word16 SourceStepWhole;
	word16 PlaybackHandlerOffset;
	word16 SourceCursorFraction;
	word16 SourceCursorOffset;
	word16 SourceCursorSegment;
	word16 RemainingFraction;
	word16 RemainingWhole;
	word16 CompletionCallbackOffset;
	word16 CompletionCallbackSegment;
	word16 CompletionArgumentLow;
	word16 CompletionArgumentHigh;
} DigitalSampleDescriptor;

typedef struct DigitalDriverQueue
{
	word16 FirstDescriptorOffset;
	word16 FirstDescriptorSegment;
	word16 SentinelNextOffset;
	word16 SentinelNextSegment;
	word16 SentinelOwnerOffset;
	word16 SentinelOwnerSegment;
	word16 ActiveDescriptorCount;
	word16 MixBias;
	byte OutputSample;
	byte ReservedOutputByte;
} DigitalDriverQueue;

/* Exact CS:04BC-05D5 digital playback timer/mixer state. */
typedef struct DigitalPlaybackRuntimeState
{
	DosAddress SavedSystemTimerVector;
	word16 SystemTimerDivisor;
	word16 SystemTimerAccumulator;
	word16 InterruptNestingGuard;
	word16 DigitalTimerReloadMinusOne;
	uint16 PlaybackRateHz;
	word16 WriteSampleCallbackOffset;
	DosAddress ActiveDriverQueue;
	uint16 RequestedMixScale;
	uint16 DriverMixScale;
	word16 ActiveMixScale;
	byte MixLookup[0x0100];
} DigitalPlaybackRuntimeState;

/* Exact contiguous DS:6F4C-6FA3 queues and calibration descriptor. */
typedef struct DigitalPlaybackWorkingSet
{
	DigitalDriverQueue PlaybackTimerQueue;
	DigitalDriverQueue CalibrationQueue;
	DigitalSampleDescriptor CalibrationSample;
} DigitalPlaybackWorkingSet;

typedef struct DigitalHardwareDescriptor
{
	word16 DeviceNameOffset;
	word16 DefaultProbeParameter;
	word16 ProbeCandidateCount;
	word16 ProbeCandidateListOffset;
	word16 ProbeCallbackOffset;
	word16 AcquireCallbackOffset;
	word16 ReleaseCallbackOffset;
	word16 ReferenceCount;
} DigitalHardwareDescriptor;

typedef struct DigitalPlaybackDescriptor
{
	word16 HardwareDescriptorOffset;
	word16 AcquireCallbackOffset;
	word16 ReleaseCallbackOffset;
	word16 WriteSampleCallbackOffset;
	word16 MixScale;
	word16 ReferenceCount;
} DigitalPlaybackDescriptor;

typedef struct DigitalWeaponEffectRecord
{
	word16 ResourceIndex;
	word16 PlaybackScale;
	word16 PackedBufferOffset;
	word16 SampleLength;
	word16 LoadState;
} DigitalWeaponEffectRecord;

typedef struct DigitalSoundEntryRecord
{
	byte SoundCode;
	word16 ResourceIndex;
	uint32 SourceFileOffset;
	word16 SampleLength;
	word16 PackedBufferOffset;
} DigitalSoundEntryRecord;

typedef struct DigitalSoundDataLayout
{
	word16 DriverDescriptorOffsets[0x09];
	DigitalSampleDescriptor SampleDescriptors[0x0F];
	DigitalWeaponEffectRecord WeaponEffects[0x10];
	DigitalSoundEntryRecord SoundEntries[0x16];
	byte ScenarioCodeStrings[0x017D];
} DigitalSoundDataLayout;
#pragma pack(pop)

_Static_assert(sizeof(DigitalSampleDescriptor) == 0x34,
	"DigitalSampleDescriptor must retain its DOS layout");
_Static_assert(sizeof(DigitalDriverQueue) == 0x12,
	"DigitalDriverQueue must retain its DOS layout");
_Static_assert(offsetof(DigitalPlaybackRuntimeState,
	InterruptNestingGuard) == 0x08,
	"digital playback IRQ nesting guard must remain at CS:04C4");
_Static_assert(offsetof(DigitalPlaybackRuntimeState, MixLookup) == 0x1A,
	"digital mix lookup must remain at CS:04D6");
_Static_assert(sizeof(DigitalPlaybackRuntimeState) == 0x011A,
	"digital playback state must retain CS:04BC-05D5 layout");
_Static_assert(offsetof(DigitalPlaybackWorkingSet, CalibrationQueue) == 0x12,
	"digital calibration queue must remain at DS:6F5E");
_Static_assert(offsetof(DigitalPlaybackWorkingSet, CalibrationSample) == 0x24,
	"digital calibration sample must remain at DS:6F70");
_Static_assert(sizeof(DigitalPlaybackWorkingSet) == 0x58,
	"digital playback working set must retain DS:6F4C-6FA3 layout");
_Static_assert(sizeof(DigitalHardwareDescriptor) == 0x10,
	"DigitalHardwareDescriptor must retain its DOS layout");
_Static_assert(sizeof(DigitalPlaybackDescriptor) == 0x0C,
	"DigitalPlaybackDescriptor must retain its DOS layout");
_Static_assert(sizeof(DigitalWeaponEffectRecord) == 0x0A,
	"DigitalWeaponEffectRecord must retain its DOS layout");
_Static_assert(sizeof(DigitalSoundEntryRecord) == 0x0B,
	"DigitalSoundEntryRecord must retain its DOS layout");
_Static_assert(offsetof(DigitalSoundDataLayout, SampleDescriptors) == 0x0012,
	"digital sample descriptors must begin at DS:5950");
_Static_assert(offsetof(DigitalSoundDataLayout, WeaponEffects) == 0x031E,
	"weapon effects must begin at DS:5C5C");
_Static_assert(offsetof(DigitalSoundDataLayout, SoundEntries) == 0x03BE,
	"digital sound entries must begin at DS:5CFC");
_Static_assert(offsetof(DigitalSoundDataLayout, ScenarioCodeStrings) == 0x04B0,
	"scenario sound strings must begin at DS:5DEE");
_Static_assert(sizeof(DigitalSoundDataLayout) == 0x062D,
	"digital sound data must retain DS:593E-5F6A layout");

typedef union DigitalSoundDataImage
{
	DigitalSoundDataLayout Layout;
	byte Bytes[0x062D];
} DigitalSoundDataImage;

extern DigitalHardwareDescriptor NullDigitalHardware;
extern DigitalHardwareDescriptor Tandy3VoiceHardware;
extern DigitalHardwareDescriptor TandyDACHardware;
extern DigitalHardwareDescriptor IBMPS1AudioHardware;
extern DigitalHardwareDescriptor SoundBlasterHardware;
extern DigitalHardwareDescriptor AdLibSoundHardware;
extern DigitalHardwareDescriptor CMSSoundHardware;
extern DigitalHardwareDescriptor InnovationSoundHardware;
extern DigitalHardwareDescriptor CovoxSoundHardware;

extern const word16 SoundBlasterProbePorts[0x06];
extern const word16 CMSProbePorts[0x06];
extern const word16 InnovationProbePorts[0x04];
extern const word16 CovoxProbePorts[0x04];

extern DigitalPlaybackDescriptor NullDigitalPlayback;
extern DigitalPlaybackDescriptor Tandy3VoicePlayback;
extern DigitalPlaybackDescriptor TandyDACPlayback;
extern DigitalPlaybackDescriptor IBMPS1Playback;
extern DigitalPlaybackDescriptor SoundBlasterPlayback;
extern DigitalPlaybackDescriptor AdLibPlayback;
extern DigitalPlaybackDescriptor CMSPlayback;
extern DigitalPlaybackDescriptor InnovationPlayback;
extern DigitalPlaybackDescriptor CovoxPlayback;
extern DigitalPlaybackRuntimeState DigitalPlaybackRuntime;
extern DigitalPlaybackWorkingSet DigitalPlaybackBuffers;

enum
{
	DIGITAL_SOUND_DATA_FIRST_OFFSET = 0x593E,
	DIGITAL_SOUND_DATA_END_OFFSET = 0x5F6B,
	DIGITAL_SOUND_DATA_BYTE_COUNT =
		DIGITAL_SOUND_DATA_END_OFFSET - DIGITAL_SOUND_DATA_FIRST_OFFSET
};

extern DigitalSoundDataImage DigitalSoundData;
extern DigitalSampleDescriptor *ActiveDigitalSampleDescriptor;
extern word16 DigitalDriverHardwareOffset;
extern DigitalDriverQueue ActiveDigitalDriverQueue;
extern word16 DigitalPlaybackRateHz;
extern byte DigitalWeaponEffectRepeatCount;
extern byte *DigitalWeaponSampleBuffer;
extern byte *DigitalSoundBuffer;
extern byte DigitalSoundDriverMutationGuard;
extern word16 NarrationMode;
extern word16 ActiveNarrationSubject;
extern word16 NarrationEmphasis;

enum
{
	FAR_HEAP_PAYLOAD_OFFSET = 0x08,
	FAR_HEAP_MIN_SPLIT_REMAINDER = 0x10,
	FAR_HEAP_ALLOCATED_FLAG = 0x01
};

#define LOW_BYTE(value) ((byte) ((uint32) (value) & 0x00FFU))
#define HIGH_BYTE(value) ((byte) (((uint32) (value) >> 0x08) & 0x00FFU))
#define LOW_WORD(value) ((word16) ((uint32) (value) & 0xFFFFU))
#define HIGH_WORD(value) ((word16) (((uint32) (value) >> 0x10) & 0xFFFFU))
#define MAKE_WORD(highByte, lowByte) \
	((word16) (((word16) (byte) (highByte) << 0x08) | \
	(byte) (lowByte)))
#define MAKE_DWORD(highWord, lowWord) \
	((uint32) (((uint32) (word16) (highWord) << 0x10) | \
	(word16) (lowWord)))
#define FAR_SEGMENT(pointer) HIGH_WORD(HostFarPointer_Encode(pointer))
#define FAR_OFFSET(pointer) LOW_WORD(HostFarPointer_Encode(pointer))
#define MAKE_FAR_POINTER(segment, offset) MAKE_DWORD((segment), (offset))
#define FAR_POINTER(type, segment, offset) \
	((type *) HostFarPointer_Resolve( \
		MAKE_FAR_POINTER((segment), (offset))))

enum
{
	DIGITAL_SAMPLE_HANDLER_IDLE = 0x0A7C,
	DIGITAL_SAMPLE_HANDLER_ONESHOT = 0x0A82,
	DIGITAL_SAMPLE_HANDLER_LOOP = 0x0AAB,
	DIGITAL_DESCRIPTOR_NULL = 0x6EB2,
	DIGITAL_DESCRIPTOR_TANDY = 0x6EBE,
	DIGITAL_DESCRIPTOR_TANDY_DAC = 0x6ECA,
	DIGITAL_DESCRIPTOR_IBM_PS1 = 0x6ED6,
	DIGITAL_DESCRIPTOR_SOUND_BLASTER = 0x6EE2,
	DIGITAL_DESCRIPTOR_ADLIB = 0x6EEE,
	DIGITAL_DESCRIPTOR_CMS = 0x6F28,
	DIGITAL_DESCRIPTOR_INNOVATION = 0x6F34,
	DIGITAL_DESCRIPTOR_COVOX = 0x6F40
};

/* Verified DOS and BIOS boundary contracts. */
void EnableHardwareInterrupts(void);
void DisableHardwareInterrupts(void);
void BIOS_SelectCgaPalette(byte paletteId);
void EGA_SetPaletteRegister(byte paletteRegister, byte paletteValue);
void SetVideoAdapterType(word16 adapterType);
word16 GetCurrentBIOSVideoMode(void);
void SetVideoModeForAdapter(word16 adapterOrRestoreSlot);
void RebuildTacticalVideoResources(
	word16 adapterType,
	word16 showScenarioCompletion);
word16 ConfirmRestartGame(void);
word16 ShowConfirmationDialog(const char *message);
void ShowScenarioMessage(word16 messageIndex);
void ShowMissionFollowupMessage(word16 messageIndex);
void LoadAndPresentScreen(word16 resourceIndex);
word16 PresentScreenAndMessage(
	word16 screenResourceIndex,
	word16 messageIndex);
void DrawMissionHeaderFrame(void);
void UpdateTextEntryCursorBlink(void);
word16 EditTextField(
	word16 maximumLength,
	const char *initialText,
	byte allowedCharacterClasses);
void CaptureLocalClockSnapshot(LocalClockSnapshot *snapshot);
void InvokePresentationCallback(void);
int16 EnsureCompatibleSaveFile(
	int16 fileHandle,
	char *savePath,
	word16 openMode);
void ShowInvalidSaveVersionDialog(void);
void DrawCenteredClippedText(
	const char *sourceText,
	word16 splitIndex,
	word16 leftX,
	word16 y,
	word16 maximumWidth,
	byte foregroundColor,
	byte backgroundColor);
void WaitVerticalRetraces(word16 retraceCount);
word16 IsVerticalRetraceActive(void);
void WaitForVerticalRetraceEdge(byte waitForRetraceStart);
void CalibrateVideoTiming(void);

/* Verified interrupt and programmable-timer boundary contracts. */
uint32 SwapInterruptVector(
	uint32 newVector, word16 interruptNumber);
word16 SetPITChannel0Divisor(word16 divisor);
word16 PITFrequencyToDivisor(word16 frequencyHz);
void PITCalibrationIRQ0Handler(void);
uint32 DivideUnsigned32By32(
	uint32 dividend, uint32 divisor);

/* Verified input and utility contracts used across original segment files. */
word16 GeneratePseudoRandomByte(void);
word16 KeyboardInputPending(void);
word16 ReadRawKeypress(void);
int8 TranslateKeyCode(void);
int16 ReadTranslatedKeypress(void);
int16 NormalizeNavigationKeyCode(int16 keyCode);
int16 RandomInRangeInclusive(word16 minimum, word16 maximum);
word16 StringLength(const char *text);
short FarStringCompare(
	const char *left, const char *right);
char *FarStringCopy(
	char *destination, const char *source);
char *FarStringConcat(
	char *destination, const char *source);
void FillRuntimeFarMemoryBytes(
	byte *destination, word16 byteCount, byte value);
void FillFarMemoryBytes(
	byte *destination, word16 byteCount, byte value);
byte *FarMemorySet(
	byte *destination, byte value, word16 byteCount);
segptr32 NormalizeFarPointer(word16 offset, word16 segment);
void *AddSignedOffsetToFarPointer(
	const void *pointer, int32 displacement);
int16 CompareNormalizedFarPointers(
	const void *left, const void *right);
int32 CalculateFarPointerByteDistance(
	word16 endOffset,
	word16 startSegment,
	word16 endSegment,
	word16 startOffset);
byte *AdvanceFarPointerBy32K(byte *pointer);
uint32 MultiplyUnsignedLong(
	word16 leftLow,
	word16 rightHigh,
	word16 leftHigh,
	word16 rightLow);
uint32 ShiftLeft32_DXAX(
	word16 valueLow,
	byte shiftCount,
	word16 valueHigh);
uint32 ShiftRight32_DXAX(
	word16 valueLow,
	byte shiftCount,
	word16 valueHigh);
void CopyFarMemory(
	word16 byteCount,
	const byte *source,
	byte *destination);
void PackLowNibblesTo4Bpp(
	const byte *source,
	byte *destination);
byte ExtractHighNibbleAndShiftLeft(word16 *packedPixels);
word16 EncodeDisplayBackingRows(
	const byte *source,
	byte *destination,
	word16 groupsPerRow,
	byte rowCount,
	int16 sourceRowSkip);
void RepackCgaAlternateScanlines(byte *screenBuffer);
void ShiftPackedPixelsIntoEGAPlanes(
	byte packedPixels,
	byte *plane3,
	byte *plane2,
	byte *plane1,
	byte *plane0);
void ConvertPackedPixelsToEGAPlanar(
	const byte *source,
	byte *destination,
	word16 packedWordCount);
void ConvertCgaPackedPixels(
	const byte *source,
	byte *destination,
	byte phaseRunLength,
	word16 outputByteCount);
void ConvertCgaPackedPixelsAndBuildMask(
	byte *buffer,
	word16 narrowStrideMode);
void BuildTacticalOverviewMapBuffer(
	const byte *source,
	byte *destination,
	word16 width,
	word16 height);
void InstallDamagedTerrainSpriteLookup(void);
void ClearTacticalEffectOverlayMap(void);
void ClearActiveVideoBuffer(void);
void FillTandyPackedRectangle(
	int16 leftX,
	int16 topY,
	word16 packedWidthMinusOne,
	int16 heightMinusOne,
	byte color);
void ReadEGAPlanarTile(
	byte *destination,
	int16 sourceByteColumn,
	word16 sourceTileRow);
void DrawVerticalSpan(
	word16 x,
	word16 yStart,
	word16 yEnd,
	word16 color);
void DrawHorizontalVideoRun(
	int16 x,
	word16 y,
	word16 packedWidth,
	word16 color);
void Draw8x8VideoTile(
	const byte *tilePixels,
	int16 tileX,
	word16 tileY);
void EGA_ConvertPackedScreenToPlanar(
	const byte *packedPixels,
	word16 destinationVideoSegment);
void ConfigureMouseCursorOverlay(
	int16 hotspotX,
	int16 hotspotY,
	const byte *cursorBitmap);
word16 IsMouseCursorInsideRectangle(
	int16 left,
	int16 top,
	int16 right,
	int16 bottom);
void HideMouseCursorOverlay(void);
void SetMouseCursorPositionUnlocked(int16 x, int16 y);
void SetMouseCursorPosition(int16 x, int16 y);
void MoveMouseCursorRelative(int16 deltaX, int16 deltaY);
void ShowMouseCursorOverlay(void);
void HideMouseCursorOverlayUnlocked(void);
void ShowMouseCursorOverlayUnlocked(void);
void CopyBufferToVideoRegion(
	int16 xColumn,
	word16 yCharacterRow,
	word16 widthColumns,
	word16 heightCharacterRows,
	const byte *source);
void CopyVideoRegionToBuffer(
	int16 xColumn,
	word16 yCharacterRow,
	word16 widthColumns,
	word16 heightCharacterRows,
	byte *destination);
void DrawClippedSprite(
	byte *destination,
	const byte *encodedSprite,
	int16 x,
	int16 y,
	word16 preserveExistingPixels);
word16 ResizeProgramBreak(void *newBreak);
int16 SetProgramBreak(void *newBreak);
void *AdjustProgramBreak(int32 increment);
byte *AllocateFarHeapBytes16(word16 byteCount);
byte *AllocateFarHeapBytes(uint32 byteCount);
void FreeHeapBlock(byte *allocation);
void FreeFarHeapAllocation(byte *allocation);
uint32 GetAvailableHeapBytes(void);
void PrintAllocationErrorAndExit(const char *message);
byte *AllocateFarMemory(int32 byteCount);
byte *AllocateParagraphAlignedMemory(uint32 byteCount);
void FreeFarMemory(byte *allocation);
void FreeParagraphAlignedMemory(byte *allocation);
int16 ReadFileWithTextTranslation(
	word16 fileHandle, byte *buffer, word16 requestedBytes);
int16 WriteFileWithTextTranslation(
	int16 fileHandle, const byte *buffer, word16 byteCount);
int32 GetFileLength(word16 fileHandle);
int16 CRT_OpenFile(const char *filePath, uint16 openFlags, ...);
int16 CRT_CloseFile(int16 fileHandle);
char *UppercaseStringInPlace(char *text);
char *FormatLongInteger(
	byte alphabeticDigitBase,
	byte signedConversion,
	uint16 radix,
	char *destination,
	uint32 value);
char *IntegerToString(
	int16 value,
	char *destination,
	uint16 radix);
char *LongToString(
	int32 value,
	char *destination,
	uint16 radix);
char *FarStringTokenize(
	char *string,
	const char *delimiters);
void LoadVideoPalette(const byte *paletteData);
void InstallVgaPaletteBankAnchors(void);
word16 FlushInputAndWait(word16 timeoutRetraces);
word16 WaitForDismissInputOrTimeout(word16 timeoutRetraces);
byte *BuildDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels);
byte *BuildVgaDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels);
byte *BuildPlanarDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels);
void RebuildMouseCursorBackingBuffer(void);
void LoadGraphicsResourceToBuffers(
	word16 resourceIndex,
	byte *decodeBuffer,
	byte *displayBuffer);
void LoadScreenAssetToWorkBuffer(word16 resourceIndex);
void ShowScenarioCompletionStatus(void);
void RequestPCSpeakerEffectStop(void);
void AllocateMusicStagingBuffer(void);
void ReleaseMusicDriverBuffer(void);
void InitializeMusicDriver(void);
void ShutdownMusicDriver(void);
void StartLoadedMusicTrack(void);
void LoadMusicResource(word16 resourceIndex);
void PlayMusicResource(word16 resourceIndex);
void InstallMusicTimer(void);
void RestoreSystemTimer(void);
word16 InitializePCSpeakerSampleConversion(word16 sampleRateHz);
void TranslatePCSpeakerSampleBuffer(
	byte *sampleData,
	word16 byteCount);
void PlayPCSpeakerBitstream(
	const byte *sampleData,
	word16 byteCount);
void PlayPCSpeakerEffectByIndex(word16 effectId);
word16 InvokeDigitalHardwareProbe(word16 hardwareDescriptorOffset);
void AcquireDigitalHardware(
	word16 hardwareDescriptorOffset,
	word16 driverParameter);
void AcquireDigitalPlaybackDriver(
	word16 driverDescriptorOffset,
	word16 playbackRateHz);
void ReleaseDigitalPlaybackDriver(word16 driverDescriptorOffset);
uint32 CalibrateDigitalPlaybackRate(
	word16 playbackScale,
	word16 sourceRateHz,
	word16 driverDescriptorOffset);
void InstallDigitalPlaybackTimer(word16 playbackRateHz);
void RestoreDigitalPlaybackTimer(void);
void InitializeDigitalDriverQueue(DigitalDriverQueue *queue);
void InstallDigitalDriverQueueCallback(
	DigitalPlaybackDescriptor *playbackDescriptor,
	DigitalDriverQueue *queue);
void AttachDigitalDriverQueue(
	word16 driverDescriptorOffset,
	DigitalDriverQueue *queue);
void InitializeDigitalSampleDescriptor(
	DigitalSampleDescriptor *descriptor,
	segptr32 sampleData,
	word16 sampleLength,
	word16 playbackRateHz,
	word16 playbackScale);
void ConfigureDigitalSampleTiming(
	DigitalSampleDescriptor *descriptor,
	word16 playbackScale);
void ConfigureDigitalSampleCompletion(
	DigitalSampleDescriptor *descriptor,
	segptr32 completionCallback,
	word16 argumentLow,
	word16 argumentHigh);
void EnqueueDigitalSampleDescriptor(
	DigitalSampleDescriptor *descriptor,
	DigitalDriverQueue *queue);
void RemoveDigitalSampleDescriptor(
	DigitalSampleDescriptor *descriptor);
void PrepareDigitalSamplePlayback(
	DigitalSampleDescriptor *descriptor);
word16 GetDigitalSamplePlaybackState(
	DigitalSampleDescriptor *descriptor);
uint32 SetDigitalPlaybackTimingScale(word16 timingScale);
void ServiceDigitalAudioTick(void);
void ServiceDigitalPlaybackInterrupt(void);
extern uint32 SavedGameClockVector;
void InstallGameClockTimer(void);
void RestoreGameClockTimer(void);
void GameClockInt1CHandler(void);
void CopyFarBytes32(
	const void *source,
	void *destination,
	uint32 byteCount);
void CopyUncompressedFarBlock(
	const void *source,
	void *destination,
	uint32 byteCount);
word16 GetLargestFreeConventionalMemoryKB(void);
uint32 DivideUnsignedLong(uint32 dividend, uint32 divisor);
word16 ReadWholeResourceFile(
	const char *resourceName,
	void *destination,
	word16 byteCount);
void ReadResourceFileSpan(
	const char *resourceName,
	int32 fileOffset,
	void *destination,
	word16 byteCount);
void LoadAndDecodePackedResource(
	const char *resourceName,
	void *compressedBuffer,
	void *destination);
void DecodeWestwoodPackedResource(
	const void *compressedBlock,
	void *destination);
void RunExitHandlersAndTerminate(word16 exitCode);
void DOS_TerminateProcess(word16 exitCode);
void InstallExceptionHandlers(void);

/* Verified resource-stream contracts from segment 3390. */
void AbortRuntimeWithMessage(const char *errorText);
void ShutdownAndExit(word16 exitCode);
int16 OpenTrackedFile(char *path, word16 openMode);
void CloseTrackedFile(int16 handleSlot);
uint32 ReadTrackedFile(
	int16 handleSlot,
	void *destination,
	uint32 byteCount);
uint32 WriteTrackedFile(
	int16 handleSlot,
	const void *source,
	uint32 byteCount);
void SeekTrackedFile(int16 handleSlot, int32 distance, word16 origin);
word16 CanOpenFileForRead(const char *path);
void DeleteFileIgnoringErrors(char *filePath);
word16 CanOpenFileForWrite(const char *path);
word16 GetResourceDriveMask(char *path);
void ReleaseCachedResources(void);
void InitializeResourceCache(void);
word16 IsResourceCached(char *path);
word16 FindResourceDescriptorIndex(char *path);
word16 ReadCachedResource(
	word16 resourceIndex,
	void *destination,
	uint32 requestedBytes);
void AdjustActiveTextWindowMargin(word16 marginTiles);

/* Verified text and primitive drawing contracts. */
void DrawTextString(
	const char *text,
	word16 x,
	word16 y,
	byte foregroundColor,
	byte backgroundColor);
word16 MeasureTextWidth(const char *text);
void DrawClippedPixel(int16 x, int16 y, word16 color);
void DrawHorizontalSpan(
	int16 y, int16 startX, int16 endX, word16 color);
void DrawClippedAxisAlignedLine(
	int16 x1,
	int16 y1,
	int16 x2,
	int16 y2,
	word16 color);
word16 DrawRepeatingFrameTileSequence(
	const word16 *frameDefinition,
	word16 sequenceIndex,
	int16 x,
	int16 y,
	word16 tileCount,
	word16 horizontal);
void DrawActiveTextWindowFrame(word16 frameStyleIndex);
long ParseSignedDecimalLong(const char *text);
char *FarStringNCopy(
	char *destination,
	const char *source,
	word16 maximumLength);
char *GetEnvironmentVariable(const char *name);
void InitializeTimezoneFromEnvironment(void);
word16 IsDaylightSavingTime(
	word16 yearsSince1970,
	word16 month,
	word16 dayOrDayOfYear,
	byte hour);
uint32 ConvertLocalDateTimeToEpochSeconds(
	const DOS_Date *date,
	const DOS_Time *time);
void CaptureInterruptSegmentState(
	InterruptSegmentState *segmentState);
void InvokeInterruptThunk(
	word16 interruptNumber,
	InterruptRegisterBlock *inputRegisters,
	InterruptRegisterBlock *outputRegisters,
	InterruptSegmentState *segmentState);
void InvokeInterruptWithRegisterBlocks(
	word16 interruptNumber,
	InterruptRegisterBlock *inputRegisters,
	InterruptRegisterBlock *outputRegisters);
void DrawCombatRatingDescription(
	int16 combatRating,
	word16 x,
	word16 y,
	byte foregroundColor,
	byte backgroundColor);
void DrawTacticalUnitControlPanel(word16 unitIndex);
void PrepareScenarioUnitRosters(void);
byte AssignScenarioLanceAllegiances(word16 scenarioAllegianceIndex);
void InitializeScenarioUnitFromTemplate(
	word16 unitType,
	word16 unitIndex);
void PrepareUnitTypeResources(word16 unitIndex);
void SelectTacticalMapCoordinate(word16 unitIndex);
void RefreshTacticalCoordinateSelection(
	word16 unitIndex,
	word16 selectionMode,
	word16 savedCursorColumn);
void CycleTacticalEnemyTarget(void);
word16 SelectTacticalMoveDestinationInput(
	word16 unitIndex,
	word16 mode);
word16 SelectTacticalMoveDestination(
	word16 unitIndex,
	word16 selectionMode);
int16 RunOptionsMenuSelection(int16 firstRegionIndex);
void RunTacticalUnitCommandMenu(word16 unitIndex);
void SelectStrafingArea(void);
void RunTacticalGameOptionsMenu(void);
void RunTacticalInteractionLoop(void);
void CalculateUnitDurabilityTotals(RevengeUnitRecord *unitRecord);
void FormatUnitDurabilityPercentage(int16 unitIndex);
word16 IsCurrentLanceLeader(word16 unitIndex);
word16 ValidatePrimaryLanceLeader(word16 unitIndex);
void LoadTacticalIconResource(
	const char *resourcePath,
	word16 destinationPage);
word16 HasNarrationMessage(
	word16 narrationSubject,
	word16 messageCategory);
void QueueLinkedUnitStatusNarration(word16 unitIndex);
void FlagDamagedWeaponRanges(
	const byte *equipmentSlots,
	word16 slotCount);
void BuildDamagedWeaponRangeFlags(word16 unitIndex);
void DrawTacticalClippedSprite(
	byte *renderTarget,
	const byte *encodedSprite,
	int16 relativeX,
	int16 relativeY,
	word16 textWindowIndex);
void DrawTacticalEffectSprite(
	word16 spriteId,
	int16 relativeX,
	int16 relativeY);
void DrawTacticalViewportCell(
	int16 viewportColumn,
	int16 viewportRow,
	word16 viewportCellIndex);
void DrawTacticalTileSpriteForAdapter(
	const byte *spritePage,
	word16 spriteId,
	word16 destinationX,
	word16 destinationY);
void RefreshTacticalDisplay(word16 advanceEffects);
void RecalculateUnitCombatRatings(
	RevengeUnitRecord *unitRecord,
	word16 unitIndex,
	word16 rebuildWeaponCounts,
	word16 advanceRecovery);
word16 HasUnitLineOfSight(
	int16 sourceUnitIndex,
	int16 targetUnitIndex);
void BuildUndamagedUnitCombatEstimate(word16 unitIndex);
void CalculateLanceAverageCombatRatings(
	word16 leaderUnitIndex,
	word16 useActualUnitData);
word16 PrepareDisplayedUnitCombatRatings(word16 unitIndex);
void DrawClippedRectangleOutline(
	int16 left,
	int16 top,
	int16 right,
	int16 bottom,
	word16 color);
void FillVideoRectangle(
	int16 leftX,
	int16 topY,
	int16 rightX,
	int16 bottomY,
	word16 color);
void Capture8x8VideoTile(
	byte *framebuffer,
	byte *destination,
	int16 tileX,
	word16 tileY);
void LoadPackedIconResource(
	const char *resourcePath,
	byte *packedDisplayBuffer);
void LoadPackedIconPageDirect(
	const char *resourcePath,
	byte *packedDisplayBuffer,
	byte *iconPageDestination);
void InstallDefaultCriticalErrorHandler(void);
void InstallCriticalErrorHandler(void *criticalErrorCallback);
byte *CaptureVideoTileStrip(
	byte *source,
	int16 startTileX,
	word16 startTileY,
	int16 tileCount);
void CopyDecodedIconPage(
	const byte *packedDisplayBuffer,
	byte *iconPageDestination);
int16 RunSingleUiRegionSelection(int16 regionIndex);
void HighlightUiRegionSelection(int16 regionIndex);
void BeginUiRegionSelection(
	int16 firstRegionIndex, uint16 regionCount);
void ToggleActiveUiRegionHighlight(void);
int16 RunUiRegionSelectionLoop(
	int16 firstRegionIndex, uint16 regionCount);
int16 PollUiRegionSelection(
	int16 firstRegionIndex, uint16 regionCount);
void SelectTextWindow(word16 windowIndex);
void SelectAndClearTextWindow(word16 windowIndex);
void ClearActiveTextWindow(void);
byte *LoadFontResource(const char *fileName);
void SetActiveFontResource(byte *fontResource);
word16 MeasureTextWidth(const char *text);
void RenderTextToActiveWindow(
	char *text, word16 advanceToNextLine);
void SelectResourceDrive(int16 resourceDriveIndex);
void SetActiveRenderTarget(byte *renderTarget);

/* Verified original game lifetime. The preserved source owns main(). */
void InitializeGame(void);
void ShutdownGame(void);
void RunCampaignLoop(void);
void RunTacticalBattle(word16 scenarioCode);
void SelectTacticalTextForegroundColor(void);
void SetTacticalSlotSpriteState(
	word16 slotIndex,
	word16 requestedState);
void DrawCampaignClockSeparator(void);
void RenderFormattedLineBreak(void);
void ShowTacticalModalMessage(const char *formattedText);
void QueueRandomMapEdgeEffect(int16 centerX, int16 centerY);
void QueueMapEdgeEffect(
	int16 mapX,
	int16 mapY,
	word16 baseSpriteId,
	word16 edgeDirection);
void DrawTacticalCellOutline(
	int16 leftX,
	int16 topY,
	word16 color);
void UpdatePrimaryUnitStatusRowHighlight(word16 rowIndex);
void UpdateSecondaryUnitStatusRowHighlight(word16 rowIndex);

#endif
