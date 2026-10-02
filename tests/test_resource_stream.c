#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int failures;
static word16 readCalls;
static word16 writeCalls;
static word16 lastReadCount;
static word16 lastWriteCount;
static const void *firstReadPointer;
static const void *secondReadPointer;
static const void *firstWritePointer;
static const void *secondWritePointer;
static int16 nextOpenHandle = 0x0005;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

word16 StringLength(const char *text)
{
	return (word16)strlen(text);
}

short FarStringCompare(const char *left, const char *right)
{
	return (short)strcmp(left, right);
}

void ShutdownGame(void) { }
void RunExitHandlersAndTerminate(word16 exitCode) { (void)exitCode; }
void SelectResourceDrive(int16 resourceDriveIndex)
{
	(void)resourceDriveIndex;
}

int16 CRT_OpenFile(const char *filePath, uint16 openFlags, ...)
{
	(void)filePath;
	(void)openFlags;
	return nextOpenHandle;
}

int16 CRT_CloseFile(int16 fileHandle)
{
	return fileHandle;
}

int16 ReadFileWithTextTranslation(
	word16 fileHandle, byte *buffer, word16 requestedBytes)
{
	(void)fileHandle;
	if (readCalls == 0x0000)
		firstReadPointer = buffer;
	else if (readCalls == 0x0001)
		secondReadPointer = buffer;
	++readCalls;
	lastReadCount = requestedBytes;
	return (int16)requestedBytes;
}

int16 WriteFileWithTextTranslation(
	int16 fileHandle, const byte *buffer, word16 requestedBytes)
{
	(void)fileHandle;
	if (writeCalls == 0x0000)
		firstWritePointer = buffer;
	else if (writeCalls == 0x0001)
		secondWritePointer = buffer;
	++writeCalls;
	lastWriteCount = requestedBytes;
	return (int16)requestedBytes;
}

int16 DOS_DeleteFile(const char *filePath)
{
	(void)filePath;
	return 0x0000;
}

long DOS_SeekFile(uint16 fileHandle, long fileOffset, byte origin)
{
	(void)fileHandle;
	(void)origin;
	return fileOffset;
}

byte *AllocateFarHeapBytes(uint32 byteCount)
{
	return (byte *)malloc(byteCount);
}

void FreeFarHeapAllocation(byte *allocation)
{
	free(allocation);
}

word16 GetLargestFreeConventionalMemoryKB(void)
{
	return 0x0200;
}

uint32 DivideUnsignedLong(uint32 dividend, uint32 divisor)
{
	return dividend / divisor;
}

segptr32 NormalizeFarPointer(word16 offset, word16 segment)
{
	uint32 linearAddress = (uint32)segment * 0x10UL + offset;

	return ((linearAddress >> 0x04) << 0x10) | (linearAddress & 0x0F);
}

void CopyFarBytes32(
	const void *source, void *destination, uint32 byteCount)
{
	memmove(destination, source, byteCount);
}

static void ResetStreamState(void)
{
	word16 index;

	for (index = 0x0000; index < ORIGINAL_TRACKED_FILE_COUNT; ++index)
		ResourceFiles.trackedHandles[index] = ORIGINAL_TRACKED_FILE_UNUSED;
	readCalls = 0x0000;
	writeCalls = 0x0000;
	firstReadPointer = NULL;
	secondReadPointer = NULL;
	firstWritePointer = NULL;
	secondWritePointer = NULL;
}

static void TestDescriptorCatalogue(void)
{
	char path[] = "mechtype.dat";
	word16 index;

	OriginalData_InitializeResourceDescriptorPointers();
	index = FindResourceDescriptorIndex(path);
	Check(index == 0x0040, "MECHTYPE.DAT retains descriptor index 64");
	Check(strcmp(path, "MECHTYPE.DAT") == 0,
		"resource lookup uppercases its caller-owned path");
	Check(CachedFileDescriptors[index].fileLength == 0x000033CDUL,
		"MECHTYPE.DAT retains its executable length");
	Check(*((char *)HostFarPointer_Resolve(
		DosAddress_ToValue(
			CachedFileDescriptors[0x0059].fileName))) == '\0',
		"descriptor 89 is the empty sentinel");
}

static void TestCachedStream(void)
{
	byte source[0x20];
	byte destination[0x10];
	uint32 sourceAddress;
	word16 index;

	for (index = 0x0000; index < sizeof(source); ++index)
		source[index] = (byte)(index + 0x20);
	memset(destination, 0x00, sizeof(destination));
	sourceAddress = HostFarPointer_Register(source, sizeof(source));
	CachedFileDescriptors[0x0000].cachedData =
		DosAddress_FromValue(sourceAddress);
	CachedFileDescriptors[0x0000].fileLength = sizeof(source);
	CachedFileDescriptors[0x0000].currentPosition = 0x00000004UL;

	Check(ReadCachedResource(0x0000, destination, 0x00000008UL) == 0x0008,
		"cached read reports copied byte count");
	Check(memcmp(destination, source + 0x04, 0x08) == 0,
		"cached read copies from current position");
	Check(CachedFileDescriptors[0x0000].currentPosition == 0x0000000CUL,
		"cached read advances descriptor position");

	ResourceFiles.trackedHandles[0x0000] = ORIGINAL_TRACKED_FILE_CACHED;
	SeekTrackedFile(0x0000, -0x02, 0x0001);
	Check(CachedFileDescriptors[0x0000].currentPosition == 0x0000000AUL,
		"cached relative seek uses current position");
	SeekTrackedFile(0x0000, -0x04, 0x0002);
	Check(CachedFileDescriptors[0x0000].currentPosition == 0x0000001CUL,
		"cached end-relative seek uses file length");
	SeekTrackedFile(0x0000, 0x40, 0x0000);
	Check(CachedFileDescriptors[0x0000].currentPosition == sizeof(source),
		"cached absolute seek clamps to file length");
	SeekTrackedFile(0x0000, -0x01, 0x0000);
	Check(CachedFileDescriptors[0x0000].currentPosition == 0xFFFFFFFFUL,
		"cached absolute seek preserves the original signed-high comparison");
}

static void TestChunkedStreams(void)
{
	byte buffer[0x10];

	ResourceFiles.trackedHandles[0x0001] = 0x0005;
	Check(ReadTrackedFile(0x0001, buffer, 0x00010010UL) == 0x00010010UL,
		"tracked read accumulates a 32-bit result");
	Check(readCalls == 0x0002 && lastReadCount == 0x0610,
		"tracked read splits at FA00h");
	Check(firstReadPointer == secondReadPointer,
		"tracked read preserves the assembly's repeated far pointer");

	Check(WriteTrackedFile(0x0001, buffer, 0x00010010UL) == 0x00010010UL,
		"tracked write accumulates a 32-bit result");
	Check(writeCalls == 0x0002 && lastWriteCount == 0x0610,
		"tracked write splits at FA00h");
	Check(firstWritePointer == secondWritePointer,
		"tracked write preserves the assembly's repeated far pointer");
}

static void TestOpenCloseAndWindowMargin(void)
{
	char path[] = "unknown.dat";
	int16 slot;

	nextOpenHandle = 0x0005;
	slot = OpenTrackedFile(path, 0x0001);
	Check(slot == 0x0000 && ResourceFiles.trackedHandles[slot] == 0x0005,
		"ordinary open occupies the first free tracked slot");
	CloseTrackedFile(slot);
	Check(ResourceFiles.trackedHandles[slot] == ORIGINAL_TRACKED_FILE_UNUSED,
		"close releases the tracked slot");

	ActiveTextWindowLeftTile = 0x0005;
	ActiveTextWindowTopTile = 0x0006;
	ActiveTextWindowWidthTiles = 0x000A;
	ActiveTextWindowHeightTiles = 0x000B;
	AdjustActiveTextWindowMargin(0x0002);
	Check(ActiveTextWindowLeftTile == 0x0003 &&
		ActiveTextWindowTopTile == 0x0004 &&
		ActiveTextWindowWidthTiles == 0x000E &&
		ActiveTextWindowHeightTiles == 0x000F,
		"text-window margin expands all four edges");
}

int main(void)
{
	HostFarPointer_Reset();
	ResetStreamState();
	TestDescriptorCatalogue();
	TestCachedStream();
	ResetStreamState();
	TestChunkedStreams();
	ResetStreamState();
	TestOpenCloseAndWindowMargin();
	HostFarPointer_Reset();

	if (failures != 0)
		return EXIT_FAILURE;
	puts("resource-stream tests passed");
	return EXIT_SUCCESS;
}
