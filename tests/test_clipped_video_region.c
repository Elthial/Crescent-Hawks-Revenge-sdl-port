#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>

typedef struct CopyCall
{
	int16 sourceX;
	int16 sourceY;
	int16 destinationX;
	int16 destinationY;
	word16 width;
	word16 height;
	const byte *source;
	byte *destination;
} CopyCall;

static CopyCall copyCall;

void CopyVideoRegion(
	int16 sourceX,
	int16 sourceY,
	int16 destinationX,
	int16 destinationY,
	word16 width,
	word16 height,
	const byte *source,
	byte *destination)
{
	copyCall.sourceX = sourceX;
	copyCall.sourceY = sourceY;
	copyCall.destinationX = destinationX;
	copyCall.destinationY = destinationY;
	copyCall.width = width;
	copyCall.height = height;
	copyCall.source = source;
	copyCall.destination = destination;
}

int main(void)
{
	byte sourceBuffer[0x01];
	byte destinationBuffer[0x01];
	byte *primaryScreenBuffer;
	byte *egaShadowBuffer;

	VideoAdapterType = VIDEO_ADAPTER_CGA;
	CopyClippedVideoRegion(
		-0x0002,
		-0x0003,
		0x0003,
		0x0004,
		0x0032,
		0x00FA,
		sourceBuffer,
		destinationBuffer);
	assert(copyCall.sourceX == 0x0000);
	assert(copyCall.sourceY == 0x0000);
	assert(copyCall.destinationX == 0x0005);
	assert(copyCall.destinationY == 0x0007);
	assert(copyCall.width == 0x0026);
	assert(copyCall.height == 0x00C5);
	assert(copyCall.source == sourceBuffer);
	assert(copyCall.destination == destinationBuffer);
	CopyClippedVideoRegion(
		0x0005,
		0x0006,
		-0x0002,
		-0x0003,
		0x000A,
		0x0014,
		sourceBuffer,
		destinationBuffer);
	assert(copyCall.sourceX == 0x0007);
	assert(copyCall.sourceY == 0x0009);
	assert(copyCall.destinationX == 0x0000);
	assert(copyCall.destinationY == 0x0000);
	assert(copyCall.width == 0x0008);
	assert(copyCall.height == 0x0011);

	primaryScreenBuffer = FAR_POINTER(byte, 0x1234, 0x5678);
	PrimaryScreenBuffer = primaryScreenBuffer;
	egaShadowBuffer = FAR_POINTER(
		byte,
		EGA_OFFSCREEN_FRAMEBUFFER_SEGMENT,
		EGA_OFFSCREEN_FRAMEBUFFER_OFFSET);
	VideoAdapterType = VIDEO_ADAPTER_EGA;
	CopyClippedVideoRegion(
		0x0001,
		0x0002,
		0x0003,
		0x0004,
		0x0005,
		0x0006,
		primaryScreenBuffer,
		primaryScreenBuffer);
	assert(copyCall.source == egaShadowBuffer);
	assert(copyCall.destination == egaShadowBuffer);
	return 0x00;
}
