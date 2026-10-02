#include "REVENGE.h"
#include "revenge/original_data.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct DrawCall
{
	const char *text;
	word16 x;
	word16 y;
	byte foregroundColor;
	byte backgroundColor;
} DrawCall;

typedef struct CopyCall
{
	int16 sourceXColumn;
	int16 sourceY;
	int16 destinationXColumn;
	int16 destinationY;
	word16 widthColumns;
	word16 heightPixels;
	const byte *source;
	byte *destination;
} CopyCall;

typedef struct FillCall
{
	int16 leftX;
	int16 topY;
	int16 rightX;
	int16 bottomY;
	word16 color;
} FillCall;

static int failures;
static DrawCall drawCall;
static CopyCall copyCall;
static FillCall fillCall;
static word16 drawCallCount;
static word16 copyCallCount;
static word16 fillCallCount;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

word16 StringLength(const char *text)
{
	return (word16) strlen(text);
}

void DrawTextString(
	const char *text,
	word16 x,
	word16 y,
	byte foregroundColor,
	byte backgroundColor)
{
	++drawCallCount;
	drawCall.text = text;
	drawCall.x = x;
	drawCall.y = y;
	drawCall.foregroundColor = foregroundColor;
	drawCall.backgroundColor = backgroundColor;
}

void CopyClippedVideoRegion(
	int16 sourceXColumn,
	int16 sourceY,
	int16 destinationXColumn,
	int16 destinationY,
	word16 widthColumns,
	word16 heightPixels,
	const byte *source,
	byte *destination)
{
	++copyCallCount;
	copyCall.sourceXColumn = sourceXColumn;
	copyCall.sourceY = sourceY;
	copyCall.destinationXColumn = destinationXColumn;
	copyCall.destinationY = destinationY;
	copyCall.widthColumns = widthColumns;
	copyCall.heightPixels = heightPixels;
	copyCall.source = source;
	copyCall.destination = destination;
}

void FillVideoRectangle(
	int16 leftX,
	int16 topY,
	int16 rightX,
	int16 bottomY,
	word16 color)
{
	++fillCallCount;
	fillCall.leftX = leftX;
	fillCall.topY = topY;
	fillCall.rightX = rightX;
	fillCall.bottomY = bottomY;
	fillCall.color = color;
}

static void ResetCalls(void)
{
	memset(&drawCall, 0x00, sizeof(drawCall));
	memset(&copyCall, 0x00, sizeof(copyCall));
	memset(&fillCall, 0x00, sizeof(fillCall));
	drawCallCount = 0x00;
	copyCallCount = 0x00;
	fillCallCount = 0x00;
}

static void SetWindow(
	word16 leftTile,
	word16 topTile,
	word16 widthTiles,
	word16 heightTiles,
	word16 cursorColumn,
	word16 cursorRow)
{
	ActiveTextWindowLeftTile = leftTile;
	ActiveTextWindowTopTile = topTile;
	ActiveTextWindowWidthTiles = widthTiles;
	ActiveTextWindowHeightTiles = heightTiles;
	ActiveTextForegroundColor = 0x0E;
	ActiveTextBackgroundColor = 0x03;
	ActiveTextCursorColumn = cursorColumn;
	ActiveTextCursorRow = cursorRow;
	ActiveFontGlyphAdvanceX = 0x04;
	ActiveFontLineHeight = 0x06;
	ActiveRenderTarget = (byte *)(uintptr_t)0x12340056UL;
}

static void TestDrawAndAdvanceColumn(void)
{
	char text[] = "AB";

	ResetCalls();
	SetWindow(0x02, 0x01, 0x05, 0x03, 0x02, 0x01);
	RenderTextToActiveWindow(text, FALSE);

	Check(drawCallCount == 0x01, "text is drawn once");
	Check(copyCallCount == 0x00 && fillCallCount == 0x00,
		"an in-range cursor does not scroll the window");
	Check(drawCall.x == 0x0018 && drawCall.y == 0x000E,
		"cursor tile and font metrics select the draw position");
	Check(drawCall.foregroundColor == 0x0E &&
		drawCall.backgroundColor == 0x03,
		"active text colors are forwarded");
	Check(ActiveTextCursorColumn == 0x04 &&
		ActiveTextCursorRow == 0x01,
		"string length advances only the cursor column");
	Check(text[0x00] == '\0', "the mutable source string is consumed");
}

static void TestExplicitLineAdvance(void)
{
	char text[] = "X";

	ResetCalls();
	SetWindow(0x00, 0x00, 0x05, 0x03, 0x02, 0x01);
	RenderTextToActiveWindow(text, TRUE);

	Check(ActiveTextCursorColumn == 0x00 &&
		ActiveTextCursorRow == 0x02,
		"explicit advance resets the column and increments the row");
}

static void TestColumnWrap(void)
{
	char text[] = "AB";

	ResetCalls();
	SetWindow(0x00, 0x00, 0x02, 0x03, 0x03, 0x00);
	RenderTextToActiveWindow(text, FALSE);

	Check(ActiveTextCursorColumn == 0x00 &&
		ActiveTextCursorRow == 0x01,
		"text beyond the last glyph column wraps to the next row");
}

static void TestScroll(void)
{
	char text[] = "A";
	const byte *expectedTarget = (const byte *) (uintptr_t) 0x12340056UL;

	ResetCalls();
	SetWindow(0x02, 0x01, 0x05, 0x02, 0x03, 0x02);
	ActiveFontLineHeight = 0x08;
	RenderTextToActiveWindow(text, FALSE);

	Check(copyCallCount == 0x01 && fillCallCount == 0x01,
		"a cursor below the usable line scrolls and clears once");
	Check(copyCall.sourceXColumn == 0x02 && copyCall.sourceY == 0x0010 &&
		copyCall.destinationXColumn == 0x02 &&
		copyCall.destinationY == 0x0008,
		"scroll copy moves the window up by one font line");
	Check(copyCall.widthColumns == 0x05 &&
		copyCall.heightPixels == 0x0008,
		"scroll copy uses the original column width and remaining height");
	Check(copyCall.source == expectedTarget &&
		copyCall.destination == expectedTarget,
		"scroll copy uses the active render target in place");
	Check(fillCall.leftX == 0x0010 && fillCall.topY == 0x0010 &&
		fillCall.rightX == 0x0037 && fillCall.bottomY == 0x0017 &&
		fillCall.color == 0x03,
		"scroll clears precisely the exposed bottom text line");
	Check(drawCall.x == 0x0010 && drawCall.y == 0x0010,
		"scrolled text draws at the start of the exposed line");
	Check(ActiveTextCursorColumn == 0x04 &&
		ActiveTextCursorRow == 0x01,
		"scrolled cursor is moved to the last line before length advance");
}

int main(void)
{
	TestDrawAndAdvanceColumn();
	TestExplicitLineAdvance();
	TestColumnWrap();
	TestScroll();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
