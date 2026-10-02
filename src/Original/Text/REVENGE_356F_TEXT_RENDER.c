// Reconstructed original active text-window string renderer (segment 356F).

#include "REVENGE.h"
#include "revenge/debug.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

word16 StringLength(const char *text);

// 356F:000B
// Draw a mutable string in the active text window. When its cursor is below the
// last usable line, scroll the window by one font line before drawing. The
// source buffer is consumed: its first byte is cleared before returning.
void RenderTextToActiveWindow(char *text, word16 advanceToNextLine)
{
	int16 glyphWidth = ActiveFontGlyphAdvanceX;
	int16 lineHeight = ActiveFontLineHeight;
	word16 leftX = ActiveTextWindowLeftTile << 0x03;
	word16 topY = ActiveTextWindowTopTile << 0x03;
	word16 widthPixels = ActiveTextWindowWidthTiles << 0x03;
	word16 heightPixels = ActiveTextWindowHeightTiles << 0x03;
	word16 lastLineY = (word16) (lineHeight
		* ((int16) heightPixels / lineHeight - 0x01));
	word16 drawX;
	word16 drawY;
	word16 windowScrolled =
		(int16) (word16) (heightPixels - lineHeight)
		< (int16) (word16) (ActiveTextCursorRow * lineHeight);

	REVENGE_PRESERVATION_TRACE(
		"text: draw '%s' window=%u xy=%u,%u size=%u,%u cursor=%u,%u colors=%u,%u font=%p target=%p\n",
		text, ActiveTextWindowIndex,
		ActiveTextWindowLeftTile, ActiveTextWindowTopTile,
		ActiveTextWindowWidthTiles, ActiveTextWindowHeightTiles,
		ActiveTextCursorColumn, ActiveTextCursorRow,
		ActiveTextForegroundColor, ActiveTextBackgroundColor,
		(void *)ActiveFontResource, (void *)ActiveRenderTarget);

	// Verified against 356F:000B-01F2; the final clear/epilogue is confirmed
	// by the Reko low-level output where the segment listing ends.

	if (windowScrolled)
	{
		byte *renderTarget = ActiveRenderTarget;
		CopyClippedVideoRegion(
			ActiveTextWindowLeftTile,
			topY + lineHeight,
			ActiveTextWindowLeftTile,
			topY,
			ActiveTextWindowWidthTiles,
			lastLineY,
			renderTarget,
			renderTarget);
		FillVideoRectangle(
			leftX,
			topY + lastLineY,
			leftX + widthPixels - 0x01,
			topY + lastLineY + lineHeight - 0x01,
			(byte) ActiveTextBackgroundColor);
		drawX = leftX;
		drawY = topY + lastLineY;
	}
	else
	{
		drawX = leftX + ActiveTextCursorColumn * glyphWidth;
		drawY = topY + ActiveTextCursorRow * lineHeight;
	}

	DrawTextString(
		text,
		drawX,
		drawY,
		(byte) ActiveTextForegroundColor,
		(byte) ActiveTextBackgroundColor);

	if (advanceToNextLine != FALSE)
	{
		ActiveTextCursorColumn = 0x00;
		++ActiveTextCursorRow;
	}
	else
	{
		if (windowScrolled)
			ActiveTextCursorRow =
				(word16) ((int16) lastLineY / lineHeight);
		ActiveTextCursorColumn += StringLength(text);
		if ((int16) (word16) (widthPixels - glyphWidth)
			< (int16) (word16)
				(ActiveTextCursorColumn * glyphWidth))
		{
			ActiveTextCursorColumn = 0x00;
			++ActiveTextCursorRow;
		}
	}

	text[0x00] = '\0';
}
