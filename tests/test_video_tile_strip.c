#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>

typedef struct CaptureCall
{
	byte *framebuffer;
	byte *destination;
	int16 tileX;
	word16 tileY;
} CaptureCall;

static byte allocation[0x0200];
static int32 requestedAllocationSize;
static CaptureCall captureCalls[0x08];
static word16 captureCallCount;

byte *AllocateFarMemory(int32 byteCount)
{
	requestedAllocationSize = byteCount;
	return allocation;
}

void Capture8x8VideoTile(
	byte *framebuffer,
	byte *destination,
	int16 tileX,
	word16 tileY)
{
	CaptureCall *call;

	call = &captureCalls[captureCallCount++];
	call->framebuffer = framebuffer;
	call->destination = destination;
	call->tileX = tileX;
	call->tileY = tileY;
}

static void TestStrip(word16 adapterType, int32 expectedAllocation,
	word16 expectedTileStride)
{
	byte framebuffer[0x10];
	byte *result;

	captureCallCount = 0x0000;
	requestedAllocationSize = 0x00000000;
	VideoAdapterType = adapterType;
	result = CaptureVideoTileStrip(
		framebuffer, 0x0027, 0x0005, 0x0003);

	assert(result == allocation);
	assert(requestedAllocationSize == expectedAllocation);
	assert(captureCallCount == 0x0003);
	assert(captureCalls[0x00].framebuffer == framebuffer);
	assert(captureCalls[0x00].destination == allocation);
	assert(captureCalls[0x00].tileX == 0x0027);
	assert(captureCalls[0x00].tileY == 0x0005);
	assert(captureCalls[0x01].destination == allocation + expectedTileStride);
	assert(captureCalls[0x01].tileX == 0x0000);
	assert(captureCalls[0x01].tileY == 0x0006);
	assert(captureCalls[0x02].destination ==
		allocation + expectedTileStride * 0x02);
	assert(captureCalls[0x02].tileX == 0x0001);
	assert(captureCalls[0x02].tileY == 0x0006);
}

int main(void)
{
	TestStrip(VIDEO_ADAPTER_CGA, 0x00000060, 0x0020);
	TestStrip(VIDEO_ADAPTER_EGA, 0x00000060, 0x0020);
	TestStrip(VIDEO_ADAPTER_TANDY, 0x00000060, 0x0020);
	TestStrip(VIDEO_ADAPTER_VGA, 0x000000C0, 0x0040);
	return 0;
}
