/*
 * Tactical 16x16 tile raster leaves from REVENGE_0800.
 *
 * The original procedures write adapter-specific packed bytes to CGA,
 * Tandy, EGA, or VGA memory.  The host build preserves their source formats,
 * coordinates, bank selection, dispatch, and composition rules, then replaces
 * only the physical video-memory write with the indexed SDL framebuffer.
 */

#include "revenge/original_data.h"
#include "revenge/video.h"

enum
{
	TACTICAL_TILE_WIDTH = 0x0010,
	TACTICAL_TILE_HEIGHT = 0x0010,
	TACTICAL_PACKED_ROW_BYTES = 0x0008,
	TACTICAL_PACKED_TILE_BYTES = 0x0080,
	TACTICAL_CGA_PIXELS_PER_BYTE = 0x0004,
	TACTICAL_CGA_ROW_BYTES_WITH_MASK = 0x0008,
	TACTICAL_HIGH_SPRITE_BANK_OFFSET = 0x8000
};

/* 0800:09BB-0A2D. The packed CGA compositor is the CGA branch of the shared
 * compositor once the physical B800h write is represented as indexed pixels. */
void DrawCgaCompositeTacticalTile(
	word16 foregroundSpriteId,
	word16 backgroundSpriteId,
	const byte *spritePage,
	word16 destinationX,
	word16 destinationY)
{
	DrawCompositeTacticalTile(
		foregroundSpriteId,
		backgroundSpriteId,
		spritePage,
		destinationX,
		destinationY);
}

/* 0800:0A2E-0A88. Sprite IDs 0100h..01FFh select the bank beginning 8000h
 * bytes beyond the ordinary CGA tile page. */
void DrawCgaHighSpriteTile(
	const byte *spritePage,
	word16 spriteId,
	word16 destinationX,
	byte destinationY)
{
	const byte *tile;
	word16 y;

	tile = spritePage + TACTICAL_HIGH_SPRITE_BANK_OFFSET +
		(uint32) (spriteId - 0x0100) * TACTICAL_PACKED_TILE_BYTES;
	for (y = 0x0000; y < TACTICAL_TILE_HEIGHT; ++y)
	{
		word16 x;

		for (x = 0x0000; x < TACTICAL_TILE_WIDTH; ++x)
		{
			byte packedPixels = tile[
				(uint32) y * TACTICAL_CGA_ROW_BYTES_WITH_MASK +
				(x / TACTICAL_CGA_PIXELS_PER_BYTE) * 0x02];
			byte shift = (byte) (0x06 -
				(x % TACTICAL_CGA_PIXELS_PER_BYTE) * 0x02);

			DrawClippedPixel(
				(int16) ((destinationX << 0x03) + x),
				(int16) (destinationY + y),
				(packedPixels >> shift) & 0x03);
		}
	}
}

/* 0800:0B07-0C05. The DOS routine writes one packed two-by-two overview
 * pixel through four adapter layouts. The host expands the same color pair at
 * the final video-memory boundary. */
void PlotPixel(word16 x, word16 y, byte color)
{
	byte leftColor;
	byte rightColor;
	int16 pixelX = (int16) (x << 0x01);
	int16 pixelY = (int16) (y << 0x01);

	if (ActiveVideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		static const byte evenColors[0x10] =
		{
			0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0xAA, 0x22,
			0x00, 0x00, 0xDD, 0xFF, 0x00, 0x55, 0x33, 0x00
		};
		static const byte oddColors[0x10] =
		{
			0x00, 0x00, 0x44, 0x00, 0x00, 0xAA, 0x88, 0x00,
			0x00, 0x77, 0xFF, 0x00, 0x55, 0xCC, 0x00, 0x00
		};
		byte top = evenColors[color & 0x0F];
		byte bottom = oddColors[color & 0x0F];

		leftColor = (byte) ((top >> 0x06) & 0x03);
		rightColor = (byte) ((top >> 0x04) & 0x03);
		DrawClippedPixel(pixelX, pixelY, leftColor);
		DrawClippedPixel(pixelX + 0x01, pixelY, rightColor);
		leftColor = (byte) ((bottom >> 0x06) & 0x03);
		rightColor = (byte) ((bottom >> 0x04) & 0x03);
		DrawClippedPixel(pixelX, pixelY + 0x01, leftColor);
		DrawClippedPixel(pixelX + 0x01, pixelY + 0x01, rightColor);
		return;
	}

	leftColor = (byte) (color >> 0x04);
	rightColor = (byte) (color & 0x0F);
	DrawClippedPixel(pixelX, pixelY, leftColor);
	DrawClippedPixel(pixelX + 0x01, pixelY, rightColor);
	DrawClippedPixel(pixelX, pixelY + 0x01, leftColor);
	DrawClippedPixel(pixelX + 0x01, pixelY + 0x01, rightColor);
}

/* 0800:1040-1116 */
void DrawNonEgaTacticalTile(
	const byte *spritePage,
	word16 spriteId,
	word16 destinationX,
	word16 destinationY)
{
	const byte *tile = spritePage +
		(uint32) spriteId * TACTICAL_PACKED_TILE_BYTES;
	word16 y;

	for (y = 0x0000; y < TACTICAL_TILE_HEIGHT; ++y)
	{
		word16 x;

		for (x = 0x0000; x < TACTICAL_TILE_WIDTH; ++x)
		{
			byte packedPixels;
			byte color;

			if (ActiveVideoAdapterType == VIDEO_ADAPTER_CGA)
			{
				byte shift;

				packedPixels = tile[
					(uint32) y * TACTICAL_CGA_ROW_BYTES_WITH_MASK +
					(x / TACTICAL_CGA_PIXELS_PER_BYTE) * 0x02];
				shift = (byte) (0x06 -
					(x % TACTICAL_CGA_PIXELS_PER_BYTE) * 0x02);
				color = (packedPixels >> shift) & 0x03;
			}
			else
			{
				packedPixels = tile[
					(uint32) y * TACTICAL_PACKED_ROW_BYTES +
					(x >> 0x01)];
				color = (x & 0x0001) == 0x0000
					? packedPixels >> 0x04
					: packedPixels & 0x0F;
			}
			DrawClippedPixel(
				(int16) ((destinationX << 0x03) + x),
				(int16) (destinationY + y), color);
		}
	}
}

/* 0800:1117-116E */
void DrawEgaTacticalTile(
	const byte *spritePage,
	word16 spriteId,
	word16 destinationX,
	word16 destinationY)
{
	const byte *tile = spritePage +
		(uint32) spriteId * TACTICAL_PACKED_TILE_BYTES;
	word16 y;

	/* DOS reads the planar copy prepared in A400h.  On the host the equivalent
	 * packed source page is retained and expanded at the SDL video boundary. */
	for (y = 0x0000; y < TACTICAL_TILE_HEIGHT; ++y)
	{
		word16 x;

		for (x = 0x0000; x < TACTICAL_TILE_WIDTH; ++x)
		{
			byte packedPixels = tile[
				(uint32) y * TACTICAL_PACKED_ROW_BYTES +
				(x >> 0x01)];
			byte color = (x & 0x0001) == 0x0000
				? packedPixels >> 0x04
				: packedPixels & 0x0F;

			DrawClippedPixel(
				(int16) ((destinationX << 0x03) + x),
				(int16) (destinationY + y), color);
		}
	}
}

/* 0800:116F-1184 */
void DrawTacticalTileSprite(
	const byte *spritePage,
	word16 spriteId,
	word16 destinationX,
	word16 destinationY)
{
	if (ActiveVideoAdapterType == VIDEO_ADAPTER_EGA)
	{
		DrawEgaTacticalTile(
			spritePage, spriteId, destinationX, destinationY);
	}
	else
	{
		DrawNonEgaTacticalTile(
			spritePage, spriteId, destinationX, destinationY);
	}
}

/* 0800:264B-2680 */
void CompositeEgaSpritePlane(
	byte plane,
	byte firstByteMask,
	byte secondByteMask,
	const byte *foreground,
	const byte *background,
	byte *destination)
{
	(void) plane;
	destination[0x00] =
		(background[0x00] & firstByteMask) | foreground[0x00];
	destination[0x01] =
		(background[0x01] & secondByteMask) | foreground[0x01];
}

/* 0800:2483-264A */
void DrawCompositeTacticalTile(
	word16 foregroundSpriteId,
	word16 backgroundSpriteId,
	const byte *spritePage,
	word16 destinationX,
	word16 destinationY)
{
	word16 row;

	if (ActiveVideoAdapterType != VIDEO_ADAPTER_EGA &&
		(foregroundSpriteId & 0xFF00) != 0x0000 &&
		(backgroundSpriteId & 0xFF00) != 0x0000)
	{
		foregroundSpriteId -= 0x0100;
		backgroundSpriteId -= 0x0100;
		spritePage += TACTICAL_HIGH_SPRITE_BANK_OFFSET;
	}

	if (ActiveVideoAdapterType == VIDEO_ADAPTER_EGA)
	{
		for (row = 0x0000; row < TACTICAL_TILE_HEIGHT; ++row)
		{
			byte composedPlanes[0x04][0x02];
			byte plane;
			word16 x;

			for (plane = 0x00; plane < 0x04; ++plane)
			{
				byte foreground[0x02] = { 0x00, 0x00 };
				byte background[0x02] = { 0x00, 0x00 };
				byte transparentMask[0x02] = { 0x00, 0x00 };
				word16 sourceX;

				for (sourceX = 0x0000;
					sourceX < TACTICAL_TILE_WIDTH; ++sourceX)
				{
					const byte *foregroundTile = spritePage +
						(uint32) foregroundSpriteId *
						TACTICAL_PACKED_TILE_BYTES;
					const byte *backgroundTile = spritePage +
						(uint32) backgroundSpriteId *
						TACTICAL_PACKED_TILE_BYTES;
					byte foregroundPacked = foregroundTile[
						(uint32) row * TACTICAL_PACKED_ROW_BYTES +
						(sourceX >> 0x01)];
					byte backgroundPacked = backgroundTile[
						(uint32) row * TACTICAL_PACKED_ROW_BYTES +
						(sourceX >> 0x01)];
					byte foregroundColor =
						(sourceX & 0x0001) == 0x0000
						? foregroundPacked >> 0x04
						: foregroundPacked & 0x0F;
					byte backgroundColor =
						(sourceX & 0x0001) == 0x0000
						? backgroundPacked >> 0x04
						: backgroundPacked & 0x0F;
					byte byteIndex = (byte) (sourceX >> 0x03);
					byte bit = (byte) (0x80 >> (sourceX & 0x0007));

					if ((foregroundColor & (0x01 << plane)) != 0x00)
						foreground[byteIndex] |= bit;
					if (foregroundColor == 0x00)
						transparentMask[byteIndex] |= bit;
					if ((backgroundColor & (0x01 << plane)) != 0x00)
						background[byteIndex] |= bit;
				}
				CompositeEgaSpritePlane(
					plane,
					transparentMask[0x00],
					transparentMask[0x01],
					foreground,
					background,
					composedPlanes[plane]);
			}

			for (x = 0x0000; x < TACTICAL_TILE_WIDTH; ++x)
			{
				byte color = 0x00;
				byte byteIndex = (byte) (x >> 0x03);
				byte bit = (byte) (0x80 >> (x & 0x0007));

				for (plane = 0x00; plane < 0x04; ++plane)
				{
					if ((composedPlanes[plane][byteIndex] & bit) != 0x00)
						color |= (byte) (0x01 << plane);
				}
				DrawClippedPixel(
					(int16) ((destinationX << 0x03) + x),
					(int16) (destinationY + row), color);
			}
		}
		return;
	}

	if (ActiveVideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		const byte *foreground = spritePage +
			(uint32) foregroundSpriteId * TACTICAL_PACKED_TILE_BYTES;
		const byte *background = spritePage +
			(uint32) backgroundSpriteId * TACTICAL_PACKED_TILE_BYTES;

		for (row = 0x0000; row < TACTICAL_TILE_HEIGHT; ++row)
		{
			word16 packedByte;

			for (packedByte = 0x0000; packedByte < 0x0004; ++packedByte)
			{
				byte pixels = foreground[row * 0x08 + packedByte * 0x02];
				byte mask = foreground[row * 0x08 + packedByte * 0x02 + 0x01];
				byte composite = pixels |
					(mask & background[row * 0x04 + packedByte]);
				word16 subPixel;

				for (subPixel = 0x0000; subPixel < 0x0004; ++subPixel)
				{
					byte shift = (byte) (0x06 - subPixel * 0x02);
					DrawClippedPixel(
						(int16) ((destinationX << 0x03) +
							packedByte * 0x04 + subPixel),
						(int16) (destinationY + row),
						(composite >> shift) & 0x03);
				}
			}
		}
		return;
	}

	for (row = 0x0000; row < TACTICAL_TILE_HEIGHT; ++row)
	{
		word16 x;

		for (x = 0x0000; x < TACTICAL_TILE_WIDTH; ++x)
		{
			const byte *foregroundTile = spritePage +
				(uint32) foregroundSpriteId * TACTICAL_PACKED_TILE_BYTES;
			const byte *backgroundTile = spritePage +
				(uint32) backgroundSpriteId * TACTICAL_PACKED_TILE_BYTES;
			byte foregroundPacked = foregroundTile[
				(uint32) row * TACTICAL_PACKED_ROW_BYTES +
				(x >> 0x01)];
			byte backgroundPacked = backgroundTile[
				(uint32) row * TACTICAL_PACKED_ROW_BYTES +
				(x >> 0x01)];
			byte foregroundColor = (x & 0x0001) == 0x0000
				? foregroundPacked >> 0x04
				: foregroundPacked & 0x0F;
			byte backgroundColor = (x & 0x0001) == 0x0000
				? backgroundPacked >> 0x04
				: backgroundPacked & 0x0F;
			byte color = foregroundColor != 0x00
				? foregroundColor
				: backgroundColor;

			DrawClippedPixel(
				(int16) ((destinationX << 0x03) + x),
				(int16) (destinationY + row), color);
		}
	}
}
