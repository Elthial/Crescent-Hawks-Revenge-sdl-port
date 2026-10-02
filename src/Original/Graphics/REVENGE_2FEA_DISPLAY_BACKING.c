/* REVENGE_2FEA_DISPLAY_BACKING.c -- planar display-backing builder. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

/* 2FEA:000A-01B1 */
byte *BuildPlanarDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels)
{
	word16 height = heightPixels;
	word16 width = widthTiles;
	word16 uncompressedPayloadBytes = width * height << 0x02;
	byte *framebuffer;
	byte *source;
	byte *backingBuffer;
	word16 encodedByteCount;
	word16 sourceRowSkip;

	framebuffer = PrimaryScreenBuffer;
	sourceTileX <<= 0x02;
	source = framebuffer + sourcePixelY * 0x00A0 + sourceTileX;

	if (VideoAdapterType == VIDEO_ADAPTER_EGA)
	{
		byte *encodingBuffer = PlanarScreenBuffer;

		sourceRowSkip = 0x00A0 - (width << 0x02);
		encodedByteCount = EncodeDisplayBackingRows(
			source,
			encodingBuffer,
			width,
			(byte) height,
			(int16) sourceRowSkip);
		backingBuffer = AllocateFarMemory((int32) encodedByteCount + 0x04);
		if (backingBuffer == NULL)
			return NULL;

		backingBuffer[0x01] = (byte) height - 0x01;
		backingBuffer[0x02] = (byte) width;
		backingBuffer[0x03] = (byte) height - 0x01;
		PlanarBackingBufferExtentLow = encodedByteCount;
		PlanarBackingBufferExtentHigh = 0x0000;
		CopyFarBytes32(
			encodingBuffer,
			backingBuffer + 0x04,
			encodedByteCount);
		return backingBuffer;
	}

	backingBuffer = AllocateFarMemory((int32) uncompressedPayloadBytes + 0x04);
	if (backingBuffer == NULL)
		return NULL;

	backingBuffer[0x01] = (byte) height - 0x01;
	backingBuffer[0x02] = (byte) width;
	backingBuffer[0x03] = (byte) height - 0x01;
	width <<= 0x01;
	sourceRowSkip = 0x00A0 - (width << 0x01);
	EncodeDisplayBackingRows(
		source,
		backingBuffer + 0x04,
		width,
		(byte) height,
		(int16) sourceRowSkip);
	if (VideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		EncodeDisplayBackingRows(
			source + 0x01,
			backingBuffer + 0x04 + (uncompressedPayloadBytes >> 0x01),
			width,
			(byte) height,
			(int16) sourceRowSkip);
	}

	{
		uint32 backingBufferExtent = ((uint32) width * height) << 0x02;

		PlanarBackingBufferExtentLow = LOW_WORD(backingBufferExtent);
		PlanarBackingBufferExtentHigh = HIGH_WORD(backingBufferExtent);
	}
	return backingBuffer;
}
