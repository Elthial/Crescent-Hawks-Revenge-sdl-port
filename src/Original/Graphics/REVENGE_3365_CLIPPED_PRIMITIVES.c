// Reconstructed original clipped line and pixel primitives (segment 3365).

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

// 3365:0007
// Draw an inclusive horizontal span while respecting the packed-pixel alignment
// required by the active adapter. Unaligned edge pixels use the generic pixel
// writer; the aligned middle is delegated to the adapter-specific run writer.
void DrawHorizontalSpan(short y, short startX, short endX, unsigned short color)
{
	short x = startX;
	unsigned short adapter = VideoAdapterType;
	unsigned short leadingPixelMask = VideoPixelAlignmentMasks[adapter];

	while ((x & leadingPixelMask) != 0x00 && x <= endX)
		DrawVerticalSpan(x++, y, y, color);

	if (x < endX)
	{
		unsigned short packedRunLength = endX - x;
		if (adapter != VIDEO_ADAPTER_VGA)
			packedRunLength >>= PackedPixelShiftCounts[adapter];

		if (packedRunLength != 0x00)
			DrawHorizontalVideoRun(x, y, packedRunLength, color);

		x = endX & VideoPixelAlignmentMasks[adapter + 0x04];
	}

	while (x <= endX)
		DrawVerticalSpan(x++, y, y, color);
}

// 3365:00A6
// Normalize and clip an orthogonal line to the inclusive 320x200 screen bounds.
void DrawClippedAxisAlignedLine(short x1, short y1, short x2, short y2, unsigned short color)
{
	short leftX = x1;
	short topY = y1;
	short rightX = x2;
	short bottomY = y2;

	if (rightX < leftX)
	{
		short swap = leftX;
		leftX = rightX;
		rightX = swap;
	}
	if (bottomY < topY)
	{
		short swap = topY;
		topY = bottomY;
		bottomY = swap;
	}

	if (leftX < VIDEO_SCREEN_MIN_X)
		leftX = VIDEO_SCREEN_MIN_X;
	if (topY < VIDEO_SCREEN_MIN_Y)
		topY = VIDEO_SCREEN_MIN_Y;
	if (rightX < VIDEO_SCREEN_MIN_X)
		rightX = VIDEO_SCREEN_MIN_X;
	if (bottomY < VIDEO_SCREEN_MIN_Y)
		bottomY = VIDEO_SCREEN_MIN_Y;
	if (leftX > VIDEO_SCREEN_MAX_X)
		leftX = VIDEO_SCREEN_MAX_X;
	if (rightX > VIDEO_SCREEN_MAX_X)
		rightX = VIDEO_SCREEN_MAX_X;
	if (topY > VIDEO_SCREEN_MAX_Y)
		topY = VIDEO_SCREEN_MAX_Y;
	if (bottomY > VIDEO_SCREEN_MAX_Y)
		bottomY = VIDEO_SCREEN_MAX_Y;

	if (leftX == rightX)
		DrawVerticalSpan(leftX, topY, bottomY, color);
	else if (topY == bottomY)
		DrawHorizontalSpan(topY, leftX, rightX, color);
}

// 3365:0157
void DrawClippedPixel(short x, short y, unsigned short color)
{
	DrawClippedAxisAlignedLine(x, y, x, y, color);
}
