#include "REVENGE.h"

#include <assert.h>
#include <string.h>

static const char *openedPath;
static word16 openedMode;
static int16 closedHandle;
static word16 readCallCount;
static uint32 readLengths[0x02];
static void *readDestinations[0x02];

int16 OpenTrackedFile(char *path, word16 openMode)
{
	openedPath = path;
	openedMode = openMode;
	return 0x0003;
}

uint32 ReadTrackedFile(
	int16 handleSlot,
	void *destination,
	uint32 byteCount)
{
	assert(handleSlot == 0x0003);
	assert(readCallCount < 0x0002);
	readDestinations[readCallCount] = destination;
	readLengths[readCallCount] = byteCount;
	if (readCallCount == 0x0000)
		*(word16 *)destination = 0x0005;
	else
		memcpy(destination, "CHREV", 0x0005);
	++readCallCount;
	return byteCount;
}

void CloseTrackedFile(int16 handleSlot)
{
	closedHandle = handleSlot;
}

int main(void)
{
	static const char path[] = "TACTICAL.ICN";
	byte packedDisplayBuffer[0x0010] = { 0x00 };

	LoadPackedIconResource(path, packedDisplayBuffer);

	assert(openedPath == path);
	assert(openedMode == 0x0001);
	assert(readCallCount == 0x0002);
	assert(readLengths[0x00] == 0x00000002U);
	assert(readLengths[0x01] == 0x00000005U);
	assert(readDestinations[0x01] == packedDisplayBuffer);
	assert(memcmp(packedDisplayBuffer, "CHREV", 0x0005) == 0x00);
	assert(closedHandle == 0x0003);
	return 0;
}
