/* Font raster procedures from REVENGE_0800. */

#include "revenge/far_memory.h"
#include "revenge/original_data.h"
#include "revenge/text.h"
#include "revenge/video.h"

/* Mutable code-segment state used by 0800:4227 and 0800:470B. */
static byte DrawColor;
static byte BackgroundColor;

/* 0800:4227-470A */
void DrawFontGlyph(uint16 glyphIndex, uint16 x, uint16 y)
{
	byte *font = ActiveFontResource;
	word16 glyphWidth;
	word16 glyphHeight;
	word16 rowByteCount;
	word16 glyphOffset;
	word16 row;

	if (font == NULL || x >= VIDEO_SCREEN_WIDTH || y >= VIDEO_SCREEN_HEIGHT)
		return;
	glyphWidth = font[0x0103];
	glyphHeight = font[0x0102];
	if (glyphWidth == 0x0000 || glyphWidth >= 0x0019 ||
		x + glyphWidth > VIDEO_SCREEN_WIDTH ||
		y + glyphHeight > VIDEO_SCREEN_HEIGHT)
		return;
	rowByteCount = (word16) ((glyphWidth + 0x0007) >> 0x03);
	glyphOffset = (word16) (font[(glyphIndex + 0x0001) << 0x01] |
		((word16) font[((glyphIndex + 0x0001) << 0x01) + 0x0001] << 0x08));

	for (row = 0x0000; row < glyphHeight; ++row)
	{
		word16 column;

		for (column = 0x0000; column < glyphWidth; ++column)
		{
			byte glyphByte = font[glyphOffset +
				(uint32) row * rowByteCount + (column >> 0x03)];
			word16 glyphBitSet =
				(glyphByte & (0x80 >> (column & 0x0007))) != 0x00;
			byte color = glyphBitSet != FALSE
				? DrawColor : BackgroundColor;

			if (color != 0x00)
				DrawClippedPixel(
					(int16) (x + column), (int16) (y + row), color);
		}
	}
}

/* 0800:470B-484D */
void DrawTextString(
	const char *text,
	uint16 x,
	uint16 y,
	byte foregroundColor,
	byte backgroundColor)
{
	byte *font = ActiveFontResource;
	word16 lineStartX = x;
	word16 currentX = x;
	word16 currentY = y;
	word16 glyphWidth;
	word16 lineHeight;

	if (font == NULL || x >= VIDEO_SCREEN_WIDTH)
		return;
	glyphWidth = font[0x0103];
	lineHeight = font[0x0102];
	DrawColor = foregroundColor;
	BackgroundColor = backgroundColor;

	while (*text != '\0')
	{
		if (*text == '\r')
		{
			currentX = lineStartX;
			currentY = (word16) (currentY + lineHeight);
			++text;
			continue;
		}
		if (currentX + glyphWidth > VIDEO_SCREEN_WIDTH)
		{
			currentX = lineStartX;
			currentY = (word16) (currentY + lineHeight);
		}
		if (currentY >= VIDEO_SCREEN_HEIGHT)
			return;
		DrawFontGlyph((byte) *text & 0x7F, currentX, currentY);
		currentX = (word16) (currentX + glyphWidth);
		++text;
	}
}
