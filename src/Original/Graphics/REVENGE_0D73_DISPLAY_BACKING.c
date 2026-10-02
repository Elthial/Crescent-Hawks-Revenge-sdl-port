/* Display-backing procedures from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

/* 0D73:54B9-5507 */
byte *BuildDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels)
{
	if (VideoAdapterType == VIDEO_ADAPTER_VGA)
	{
		return BuildVgaDisplayBackingBuffer(
			sourceTileX, sourcePixelY, widthTiles, heightPixels);
	}
	return BuildPlanarDisplayBackingBuffer(
		sourceTileX, sourcePixelY, widthTiles, heightPixels);
}

/* 0D73:5508-566D */
byte *BuildVgaDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels)
{
	byte *encodedBuffer;
	byte *output;
	byte *framebuffer;
	byte *sourceRow;
	uint32 encodedByteCount;
	word16 rowsRemaining;
	byte *allocation;

	encodedBuffer = PlanarScreenBuffer;
	output = encodedBuffer;
	encodedByteCount = 0x00000004UL;
	*output++ = 0x00;
	*output++ = (byte) heightPixels - 0x01;
	*output++ = (byte) widthTiles;
	*output++ = (byte) heightPixels - 0x01;

	framebuffer = PrimaryScreenBuffer;
	sourceRow = framebuffer + sourcePixelY * 0x0140 +
		(sourceTileX << 0x03);
	rowsRemaining = heightPixels;
	while (rowsRemaining-- != 0x0000)
	{
		byte *source = sourceRow;
		word16 sourceBytesRemaining = widthTiles << 0x03;

		while (sourceBytesRemaining != 0x0000)
		{
			if (*source != 0x00)
			{
				*output++ = *source++;
				--sourceBytesRemaining;
				++encodedByteCount;
			}
			else
			{
				word16 zeroRunLength = 0x0001;

				*output++ = 0x00;
				++encodedByteCount;
				while (zeroRunLength < 0x00FF &&
					sourceBytesRemaining - zeroRunLength > 0x0000 &&
					source[zeroRunLength] == 0x00)
				{
					++zeroRunLength;
				}
				source += zeroRunLength;
				*output++ = (byte) zeroRunLength;
				++encodedByteCount;
				sourceBytesRemaining -= zeroRunLength;
			}
		}
		sourceRow += 0x0140;
	}

	allocation = AllocateFarMemory((int32) encodedByteCount);
	if (allocation != NULL)
	{
		CopyFarBytes32(
			encodedBuffer, allocation, encodedByteCount);
	}
	return allocation;
}
