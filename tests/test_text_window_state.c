#include "REVENGE.h"
#include "revenge/original_data.h"

#include <assert.h>
#include <string.h>

static word16 fillCallCount;
static word16 fillLeft;
static word16 fillTop;
static word16 fillWidth;
static word16 fillHeight;
static byte fillColor;

void FillVideoTileRectangle(
	int16 tileX,
	uint16 tileY,
	uint16 widthTiles,
	uint16 heightTiles,
	byte color)
{
	++fillCallCount;
	fillLeft = (word16) tileX;
	fillTop = tileY;
	fillWidth = widthTiles;
	fillHeight = heightTiles;
	fillColor = color;
}

static void InitializeContexts(void)
{
	memset(TextWindowContexts, 0x00, sizeof(TextWindowContexts));
	TextWindowContexts[0x00].leftTile = 0x0001;
	TextWindowContexts[0x00].topTile = 0x0002;
	TextWindowContexts[0x00].widthTiles = 0x0003;
	TextWindowContexts[0x00].heightTiles = 0x0004;
	TextWindowContexts[0x00].foregroundColor = 0x0005;
	TextWindowContexts[0x00].backgroundColor = 0x0006;
	TextWindowContexts[0x00].cursorColumn = 0x0007;
	TextWindowContexts[0x00].cursorRow = 0x0008;
	TextWindowContexts[0x01].leftTile = 0x0009;
	TextWindowContexts[0x01].topTile = 0x000A;
	TextWindowContexts[0x01].widthTiles = 0x000B;
	TextWindowContexts[0x01].heightTiles = 0x000C;
	TextWindowContexts[0x01].foregroundColor = 0x000D;
	TextWindowContexts[0x01].backgroundColor = 0x000E;
	TextWindowContexts[0x01].cursorColumn = 0x000F;
	TextWindowContexts[0x01].cursorRow = 0x0010;
	TextWindowStateInitialized = FALSE;
	fillCallCount = 0x0000;
}

int main(void)
{
	assert(sizeof(TextWindowContext) == 0x10);
	GameOptionsMenuHeight = 0x0007;
	GameOptionsMenuEntryCount = 0x0007;
	assert(TextWindowContexts[0x0B].heightTiles == 0x0007);
	assert(UiRegionTable[0x05].rowCount == 0x0007);
	InitializeContexts();

	SelectTextWindow(0x0000);
	assert(TextWindowStateInitialized == TRUE);
	assert(ActiveTextWindowIndex == 0x0000);
	assert(ActiveTextWindowLeftTile == 0x0001);
	assert(ActiveTextWindowTopTile == 0x0002);
	assert(ActiveTextWindowWidthTiles == 0x0003);
	assert(ActiveTextWindowHeightTiles == 0x0004);
	assert(ActiveTextForegroundColor == 0x0005);
	assert(ActiveTextBackgroundColor == 0x0006);
	assert(ActiveTextCursorColumn == 0x0007);
	assert(ActiveTextCursorRow == 0x0008);

	ActiveTextForegroundColor = 0x0011;
	ActiveTextBackgroundColor = 0x0012;
	ActiveTextCursorColumn = 0x0013;
	ActiveTextCursorRow = 0x0014;
	SelectTextWindow(0x0001);
	assert(TextWindowContexts[0x00].foregroundColor == 0x0011);
	assert(TextWindowContexts[0x00].backgroundColor == 0x0012);
	assert(TextWindowContexts[0x00].cursorColumn == 0x0013);
	assert(TextWindowContexts[0x00].cursorRow == 0x0014);
	assert(ActiveTextWindowLeftTile == 0x0009);
	assert(ActiveTextCursorRow == 0x0010);

	ClearActiveTextWindow();
	assert(fillCallCount == 0x0001);
	assert(fillLeft == 0x0009);
	assert(fillTop == 0x000A);
	assert(fillWidth == 0x000B);
	assert(fillHeight == 0x000C);
	assert(fillColor == 0x0E);
	assert(ActiveTextCursorColumn == 0x0000);
	assert(ActiveTextCursorRow == 0x0000);

	SelectAndClearTextWindow(0x0000);
	assert(ActiveTextWindowIndex == 0x0000);
	assert(fillCallCount == 0x0002);
	assert(fillLeft == 0x0001);
	assert(fillTop == 0x0002);
	assert(fillColor == 0x12);
	assert(ActiveTextCursorColumn == 0x0000);
	assert(ActiveTextCursorRow == 0x0000);
	return 0x00;
}
