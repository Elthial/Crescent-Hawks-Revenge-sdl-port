#include "REVENGE.h"
#include "revenge/original_data.h"

#include <assert.h>
#include <string.h>

static word16 hideCallCount;
static word16 showCallCount;
static word16 pollCallCount;
static int16 expectedPollFirstRegion;
static uint16 expectedPollRegionCount;
static int16 xorLeft;
static int16 xorTop;
static int16 xorRight;
static int16 xorBottom;
static byte xorColor;

void HideMouseCursorOverlay(void)
{
	++hideCallCount;
}

void ShowMouseCursorOverlay(void)
{
	++showCallCount;
}

int16 PollUiRegionSelection(
	int16 firstRegionIndex, uint16 regionCount)
{
	assert(firstRegionIndex == expectedPollFirstRegion);
	assert(regionCount == expectedPollRegionCount);
	++pollCallCount;
	return pollCallCount < 0x03 ? ORIGINAL_UI_SELECTION_PENDING : 0x02;
}

void XorVideoRectangle(
	int16 leftX,
	int16 topY,
	int16 rightX,
	int16 bottomY,
	byte color)
{
	xorLeft = leftX;
	xorTop = topY;
	xorRight = rightX;
	xorBottom = bottomY;
	xorColor = color;
}

static void ResetTestState(void)
{
	memset(UiRegionTable, 0x00, sizeof(UiRegionTable));
	memset(SavedUiRegionSelectionRows, 0x00,
		sizeof(SavedUiRegionSelectionRows));
	UiSelectionResetFlagA = 0x0000;
	UiSelectionResetFlagB = 0x0000;
	ActiveTextWindowLeftTile = 0x0002;
	ActiveTextWindowTopTile = 0x0001;
	PendingMouseButtonEvent = 0xFFFF;
	MouseCursorHideDepth = 0x0000;
	ActiveFontGlyphAdvanceX = 0x04;
	ActiveFontLineHeight = 0x06;
	ActiveUiHighlightXorColor = 0x0000;
	ActiveUiHighlightHeight = 0x0000;
	ActiveUiHighlightWidth = 0x0000;
	ActiveUiHighlightLeft = 0x0000;
	ActiveUiHighlightTop = 0x0000;
	ActiveUiRegionIndex = -0x01;
	ExpandFirstUiRowHighlight = 0x0000;
	hideCallCount = 0x0000;
	showCallCount = 0x0000;
	pollCallCount = 0x0000;
	expectedPollFirstRegion = 0x03;
	expectedPollRegionCount = 0x0001;
	xorLeft = -0x01;
	xorTop = -0x01;
	xorRight = -0x01;
	xorBottom = -0x01;
	xorColor = 0x00;
}

static void TestHighlightGeometry(void)
{
	OriginalUiRegionRecord *region;

	ResetTestState();
	region = &UiRegionTable[0x03];
	region->leftColumn = 0x0003;
	region->topRow = 0x0002;
	region->widthColumns = 0x0005;
	region->rowCount = 0x0004;
	region->selectedRow = 0x0001;
	region->xorColor = 0x000E;

	HighlightUiRegionSelection(0x03);

	assert(region->selectedRow == 0x0001);
	assert(SavedUiRegionSelectionRows[0x00] == 0x01);
	assert(xorLeft == 0x001C);
	assert(xorTop == 0x001A);
	assert(xorRight == 0x002F);
	assert(xorBottom == 0x001F);
	assert(xorColor == 0x0E);
	assert(ActiveUiRegionIndex == 0x03);
}

static void TestSelectionResetConditions(void)
{
	OriginalUiRegionRecord *region;

	ResetTestState();
	region = &UiRegionTable[0x03];
	region->rowCount = 0x0002;
	region->selectedRow = 0x0002;
	HighlightUiRegionSelection(0x03);
	assert(region->selectedRow == 0x0000);

	region->selectedRow = 0x0001;
	UiSelectionResetFlagB = 0x0001;
	HighlightUiRegionSelection(0x03);
	assert(region->selectedRow == 0x0000);
}

static void TestSingleSelectionCursorBalance(void)
{
	OriginalUiRegionRecord *region;

	ResetTestState();
	region = &UiRegionTable[0x03];
	region->widthColumns = 0x0001;
	region->rowCount = 0x0001;

	RunSingleUiRegionSelection(0x03);
	assert(hideCallCount == 0x0001);
	assert(showCallCount == 0x0001);
	assert(pollCallCount == 0x0003);
	assert(PendingMouseButtonEvent == 0x0000);

	ResetTestState();
	region = &UiRegionTable[0x03];
	region->widthColumns = 0x0001;
	region->rowCount = 0x0001;
	MouseCursorHideDepth = 0x0002;
	RunSingleUiRegionSelection(0x03);
	assert(hideCallCount == 0x0001);
	assert(showCallCount == 0x0001);
}

static void TestBeginGroupedSelection(void)
{
	OriginalUiRegionRecord *firstRegion;

	ResetTestState();
	firstRegion = &UiRegionTable[0x03];
	firstRegion->leftColumn = 0x0003;
	firstRegion->topRow = 0x0002;
	firstRegion->widthColumns = 0x0005;
	firstRegion->rowCount = 0x0004;
	firstRegion->selectedRow = 0x0001;
	firstRegion->xorColor = 0x000E;
	UiRegionTable[0x04].selectedRow = 0x0002;

	BeginUiRegionSelection(0x03, 0x0002);

	assert(SavedUiRegionSelectionRows[0x00] == 0x01);
	assert(SavedUiRegionSelectionRows[0x01] == 0x02);
	assert(xorLeft == 0x001C);
	assert(xorTop == 0x001A);
	assert(xorRight == 0x002F);
	assert(xorBottom == 0x001F);
	assert(xorColor == 0x0E);
	assert(ActiveUiRegionIndex == 0x03);

	firstRegion->selectedRow = 0x0000;
	ExpandFirstUiRowHighlight = 0x0001;
	BeginUiRegionSelection(0x03, 0x0001);
	assert(xorTop == 0x0014);
	assert(xorBottom == 0x002B);
}

static void TestToggleCachedHighlight(void)
{
	ResetTestState();
	ActiveUiHighlightLeft = 0x000A;
	ActiveUiHighlightTop = 0x0014;
	ActiveUiHighlightWidth = 0x0005;
	ActiveUiHighlightHeight = 0x0006;
	ActiveUiHighlightXorColor = 0x000D;

	ToggleActiveUiRegionHighlight();
	assert(hideCallCount == 0x0001);
	assert(showCallCount == 0x0001);
	assert(xorLeft == 0x000A);
	assert(xorTop == 0x0014);
	assert(xorRight == 0x000E);
	assert(xorBottom == 0x0019);
	assert(xorColor == 0x0D);

	MouseCursorHideDepth = 0x0001;
	hideCallCount = 0x0000;
	showCallCount = 0x0000;
	ToggleActiveUiRegionHighlight();
	assert(hideCallCount == 0x0000);
	assert(showCallCount == 0x0000);
}

static void TestGroupedSelectionLoop(void)
{
	int16 result;

	ResetTestState();
	UiRegionTable[0x03].widthColumns = 0x0001;
	UiRegionTable[0x03].rowCount = 0x0001;
	UiRegionTable[0x04].selectedRow = 0x0001;
	expectedPollRegionCount = 0x0002;

	result = RunUiRegionSelectionLoop(0x03, 0x0002);
	assert(result == 0x02);
	assert(hideCallCount == 0x0001);
	assert(showCallCount == 0x0001);
	assert(pollCallCount == 0x0003);
	assert(PendingMouseButtonEvent == 0x0000);
	assert(SavedUiRegionSelectionRows[0x01] == 0x01);
}

int main(void)
{
	assert(sizeof(OriginalUiRegionRecord) == 0x10);
	TestHighlightGeometry();
	TestSelectionResetConditions();
	TestSingleSelectionCursorBalance();
	TestBeginGroupedSelection();
	TestToggleCachedHighlight();
	TestGroupedSelectionLoop();
	return 0x00;
}
