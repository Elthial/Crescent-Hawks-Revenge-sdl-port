#include "REVENGE.h"

#include "revenge/original_data.h"

#include <assert.h>

static byte oldBacking[0x10];
static byte replacementBacking[0x10];
static byte *freedBacking;
static word16 capturedSourceTileX;
static word16 capturedSourcePixelY;
static word16 capturedWidthTiles;
static word16 capturedHeightPixels;

void FreeFarMemory(byte *allocation)
{
	freedBacking = allocation;
}

byte *BuildDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels)
{
	capturedSourceTileX = sourceTileX;
	capturedSourcePixelY = sourcePixelY;
	capturedWidthTiles = widthTiles;
	capturedHeightPixels = heightPixels;
	return replacementBacking;
}

int main(void)
{
	assert(MouseCursorBackingSourceTileX == 0x0000);
	assert(MouseCursorBackingSourcePixelY == 0x0008);
	assert(MouseCursorBackingWidthTiles == 0x0002);
	assert(MouseCursorBackingHeightPixels == 0x0010);
	InputDeviceType = 0x0001;
	assert(TacticalCursorAutoScroll == 0x0001);

	HostFarPointer_Reset();
	HostFarPointer_Register(oldBacking, sizeof(oldBacking));
	HostFarPointer_Register(replacementBacking, sizeof(replacementBacking));
	SharedGraphicsBackingBuffers[0x00] = oldBacking;
	MouseCursorBackingSourceTileX = 0x0011;
	MouseCursorBackingSourcePixelY = 0x0022;
	MouseCursorBackingWidthTiles = 0x0033;
	MouseCursorBackingHeightPixels = 0x0044;

	RebuildMouseCursorBackingBuffer();
	assert(freedBacking == oldBacking);
	assert(capturedSourceTileX == 0x0011);
	assert(capturedSourcePixelY == 0x0022);
	assert(capturedWidthTiles == 0x0033);
	assert(capturedHeightPixels == 0x0044);
	assert(SharedGraphicsBackingBuffers[0x00] == replacementBacking);

	HostFarPointer_Reset();
	return 0;
}
