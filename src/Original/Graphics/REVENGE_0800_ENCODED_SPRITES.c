/* Adapter sprite decoders from REVENGE_0800. */

#include "revenge/original_data.h"
#include "revenge/video.h"

/* 0800:14B7-1B10 */
void DrawCgaTandyEncodedSprite(
	byte *destination,
	const byte *encodedSprite,
	int16 x,
	int16 y)
{
	word16 height = (word16) encodedSprite[0x01] + 0x0001;
	word16 widthUnits = encodedSprite[0x02];
	const byte *pixels = encodedSprite + 0x04;
	word16 row;
	byte *savedRenderTarget = ActiveRenderTarget;

	/* Host replacement for the original ES:DI destination addressing. */
	ActiveRenderTarget = destination;
	if (ActiveVideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		word16 rowByteCount = widthUnits << 0x01;
		const byte *masks = pixels + (uint32) rowByteCount * height;

		for (row = 0x0000; row < height; ++row)
		{
			word16 packedX;

			for (packedX = 0x0000; packedX < rowByteCount; ++packedX)
			{
				byte packedPixels = pixels[(uint32) row * rowByteCount + packedX];
				byte packedMask = masks[(uint32) row * rowByteCount + packedX];
				word16 subPixel;

				for (subPixel = 0x0000; subPixel < 0x0004; ++subPixel)
				{
					byte shift = (byte) (0x06 - subPixel * 0x02);
					byte sourceColor = (packedPixels >> shift) & 0x03;
					byte preserveMask = (packedMask >> shift) & 0x03;
					int16 pixelX = (int16) (x + packedX * 0x04 + subPixel);
					int16 pixelY = (int16) (y + row);
					byte framebufferColor = 0x00;
					byte color;

					if (pixelX < (int16) (EncodedSpriteClipLeftTile << 0x03) ||
						pixelX >= (int16) (SpriteClipRightTile << 0x03) ||
						pixelY < (int16) SpriteClipTopPixel ||
						pixelY >= (int16) EncodedSpriteClipBottomPixel)
						continue;
					if (pixelX >= VIDEO_SCREEN_MIN_X &&
						pixelX <= VIDEO_SCREEN_MAX_X &&
						pixelY >= VIDEO_SCREEN_MIN_Y &&
						pixelY <= VIDEO_SCREEN_MAX_Y)
					{
						framebufferColor = Video_GetIndexedFramebuffer()[
							(uint32) pixelY * VIDEO_SCREEN_WIDTH + pixelX];
					}
					color = (byte) (sourceColor |
						(preserveMask & framebufferColor));
					DrawClippedPixel(pixelX, pixelY, color);
				}
			}
		}
		ActiveRenderTarget = savedRenderTarget;
		return;
	}

	{
		word16 rowByteCount = widthUnits << 0x02;

		for (row = 0x0000; row < height; ++row)
		{
			word16 packedX;

			for (packedX = 0x0000; packedX < rowByteCount; ++packedX)
			{
				byte packedPixels = pixels[(uint32) row * rowByteCount + packedX];
				byte highColor = packedPixels >> 0x04;
				byte lowColor = packedPixels & 0x0F;
				int16 pixelX = (int16) (x + (packedX << 0x01));
				int16 pixelY = (int16) (y + row);

				if (highColor != 0x00 &&
					pixelX >= (int16) (EncodedSpriteClipLeftTile << 0x03) &&
					pixelX < (int16) (SpriteClipRightTile << 0x03) &&
					pixelY >= (int16) SpriteClipTopPixel &&
					pixelY < (int16) EncodedSpriteClipBottomPixel)
					DrawClippedPixel(pixelX, pixelY, highColor);
				if (lowColor != 0x00 &&
					pixelX + 0x01 >=
						(int16) (EncodedSpriteClipLeftTile << 0x03) &&
					pixelX + 0x01 <
						(int16) (SpriteClipRightTile << 0x03) &&
					pixelY >= (int16) SpriteClipTopPixel &&
					pixelY < (int16) EncodedSpriteClipBottomPixel)
					DrawClippedPixel(pixelX + 0x01, pixelY, lowColor);
			}
		}
	}
	ActiveRenderTarget = savedRenderTarget;
}

/* 0800:30FD-3255 */
void DrawEGAEncodedSprite(
	byte *destination,
	const byte *encodedSprite,
	int16 x,
	int16 y)
{
	word16 height = (word16) encodedSprite[0x01] + 0x0001;
	const byte *rowData = encodedSprite + 0x04;
	word16 row;
	byte *savedRenderTarget = ActiveRenderTarget;

	/* Host replacement for the original ES:DI destination addressing. */
	ActiveRenderTarget = destination;
	for (row = 0x0000; row < height; ++row)
	{
		const byte *token = rowData;
		word16 rowFinished = FALSE;
		word16 byteColumn = 0x0000;

		while (rowFinished == FALSE)
		{
			byte pixelMask = *token++;
			byte colorAndFlags = *token++;
			word16 bit;

			for (bit = 0x0000; bit < 0x0008; ++bit)
			{
				int16 pixelX = (int16) (x + (byteColumn << 0x03) + bit);
				int16 pixelY = (int16) (y + row);

				if ((pixelMask & (0x80 >> bit)) != 0x00 &&
					pixelX >= (int16) (EncodedSpriteClipLeftTile << 0x03) &&
					pixelX < (int16) (SpriteClipRightTile << 0x03) &&
					pixelY >= (int16) SpriteClipTopPixel &&
					pixelY < (int16) EncodedSpriteClipBottomPixel)
				{
					DrawClippedPixel(
						pixelX, pixelY, colorAndFlags & 0x0F);
				}
			}
			/* ASM 0800:31E1-31ED applies multiple colour masks to the
			 * same destination byte until bit 7 requests an advance.  Only
			 * after that advance can bit 6 terminate the row; bit 5 marks
			 * the final row, which the header height also bounds here. */
			if ((colorAndFlags & 0x80) != 0x00)
			{
				++byteColumn;
				if ((colorAndFlags & 0x40) != 0x00)
					rowFinished = TRUE;
			}
		}
		rowData = token;
	}
	ActiveRenderTarget = savedRenderTarget;
}

/* 0800:50A1-5265 */
void DrawVgaRleSprite(
	byte *destination,
	const byte *encodedSprite,
	int16 x,
	int16 y)
{
	word16 height = (word16) encodedSprite[0x01] + 0x0001;
	word16 rowWidth = (word16) encodedSprite[0x02] << 0x03;
	const byte *source = encodedSprite + 0x04;
	word16 row;
	byte *savedRenderTarget = ActiveRenderTarget;

	/* Host replacement for the original ES:DI destination addressing. */
	ActiveRenderTarget = destination;
	for (row = 0x0000; row < height; ++row)
	{
		word16 column = 0x0000;

		while (column < rowWidth)
		{
			byte token = *source++;

			if (token == 0x00)
			{
				byte transparentRun = *source++;

				column = (word16) (column + transparentRun);
				continue;
			}
			if ((int16) (x + column) >=
					(int16) (EncodedSpriteClipLeftTile << 0x03) &&
				(int16) (x + column) <
					(int16) (SpriteClipRightTile << 0x03) &&
				(int16) (y + row) >= (int16) SpriteClipTopPixel &&
				(int16) (y + row) < (int16) EncodedSpriteClipBottomPixel)
			{
				DrawClippedPixel(
					(int16) (x + column), (int16) (y + row), token);
			}
			++column;
		}
	}
	ActiveRenderTarget = savedRenderTarget;
}
