#include "REVENGE.h"
#include "revenge/input.h"
#include "revenge/original_data.h"

#include <assert.h>
#include <string.h>

static word16 keyboardInputAvailable;
static int16 translatedKey;
static word16 mouseInside;
static word16 hideCallCount;
static word16 showCallCount;
static word16 xorCallCount;
static word16 serviceCallCount;

void DisableHardwareInterrupts(void)
{
}

void EnableHardwareInterrupts(void)
{
}

void HideMouseCursorOverlay(void)
{
	++hideCallCount;
}

void ShowMouseCursorOverlay(void)
{
	++showCallCount;
}

word16 IsMouseCursorInsideRectangle(
	int16 left, int16 top, int16 right, int16 bottom)
{
	assert(left <= right);
	assert(top <= bottom);
	return mouseInside;
}

word16 ServiceMusicAndCheckKeyboardInput(void)
{
	++serviceCallCount;
	return keyboardInputAvailable;
}

int16 ReadTranslatedKeypress(void)
{
	return translatedKey;
}

int16 NormalizeNavigationKeyCode(int16 keyCode)
{
	return keyCode;
}

void XorVideoRectangle(
	int16 leftX,
	int16 topY,
	int16 rightX,
	int16 bottomY,
	byte color)
{
	assert(leftX <= rightX);
	assert(topY <= bottomY);
	assert(color == 0x0E);
	++xorCallCount;
}

static void ResetPoller(void)
{
	OriginalUiRegionRecord *region;

	memset(UiRegionTable, 0x00, sizeof(UiRegionTable));
	memset(SavedUiRegionSelectionRows, 0x00,
		sizeof(SavedUiRegionSelectionRows));
	region = &UiRegionTable[0x03];
	region->leftColumn = 0x0002;
	region->topRow = 0x0001;
	region->widthColumns = 0x0004;
	region->rowCount = 0x0003;
	region->selectedRow = 0x0000;
	region->xorColor = 0x000E;
	ActiveTextWindowLeftTile = 0x0001;
	ActiveTextWindowTopTile = 0x0001;
	UiNavigationUpKey = (word16) TranslatedExtendedKey(KEY_UP);
	UiNavigationDownKey = (word16) TranslatedExtendedKey(KEY_DOWN);
	UiPreviousRegionKey = (word16) TranslatedExtendedKey(KEY_LEFT);
	UiNextRegionKey = (word16) TranslatedExtendedKey(KEY_RIGHT);
	PendingMouseButtonEvent = 0x0000;
	MouseButtonState = 0x0000;
	MouseY = 0x0000;
	MouseInputDisabled = 0x0001;
	ActiveFontGlyphAdvanceX = 0x04;
	ActiveFontLineHeight = 0x06;
	ActiveUiRegionIndex = 0x03;
	ExpandFirstUiRowHighlight = 0x0000;
	keyboardInputAvailable = 0x0000;
	translatedKey = 0x0000;
	mouseInside = 0x0000;
	hideCallCount = 0x0000;
	showCallCount = 0x0000;
	xorCallCount = 0x0000;
	serviceCallCount = 0x0000;
}

static void TestIdlePollCachesHighlight(void)
{
	int16 result;

	ResetPoller();
	result = PollUiRegionSelection(0x03, 0x0001);
	assert(result == ORIGINAL_UI_SELECTION_PENDING);
	assert(serviceCallCount == 0x0001);
	assert(showCallCount == 0x0001);
	assert(ActiveUiHighlightLeft == 0x0010);
	assert(ActiveUiHighlightTop == 0x000E);
	assert(ActiveUiHighlightWidth == 0x0010);
	assert(ActiveUiHighlightHeight == 0x0006);
	assert(ActiveUiHighlightXorColor == 0x000E);
}

static void TestKeyboardSelection(void)
{
	int16 result;

	ResetPoller();
	keyboardInputAvailable = 0x0001;
	translatedKey = TranslatedExtendedKey(KEY_DOWN);
	result = PollUiRegionSelection(0x03, 0x0001);
	assert(result == ORIGINAL_UI_SELECTION_PENDING);
	assert(serviceCallCount == 0x0002);
	assert(UiRegionTable[0x03].selectedRow == 0x0001);
	assert(ActiveUiHighlightTop == 0x0014);
	assert(hideCallCount == 0x0002);
	assert(xorCallCount == 0x0002);

	ResetPoller();
	UiRegionTable[0x03].selectedRow = 0x0002;
	keyboardInputAvailable = 0x0001;
	translatedKey = KEY_CARRIAGE_RETURN;
	result = PollUiRegionSelection(0x03, 0x0001);
	assert(result == 0x0002);
}

static void TestEscapeRestoresSelections(void)
{
	int16 result;

	ResetPoller();
	UiRegionTable[0x03].selectedRow = 0x0002;
	UiRegionTable[0x04] = UiRegionTable[0x03];
	UiRegionTable[0x04].selectedRow = 0x0001;
	ActiveUiRegionIndex = 0x04;
	SavedUiRegionSelectionRows[0x00] = 0x01;
	SavedUiRegionSelectionRows[0x01] = 0x00;
	keyboardInputAvailable = 0x0001;
	translatedKey = KEY_ESCAPE;
	result = PollUiRegionSelection(0x03, 0x0002);
	assert(result == KEY_ESCAPE);
	assert(UiRegionTable[0x03].selectedRow == 0x0001);
	assert(UiRegionTable[0x04].selectedRow == 0x0001);
	assert(ActiveUiRegionIndex == 0x04);
}

static void TestMouseHoverAndClick(void)
{
	int16 result;

	ResetPoller();
	MouseInputDisabled = 0x0000;
	PendingMouseButtonEvent = 0x0001;
	MouseButtonState = MOUSE_BUTTON_LEFT;
	MouseY = 0x001A;
	mouseInside = 0x0001;
	result = PollUiRegionSelection(0x03, 0x0001);
	assert(result == 0x0002);
	assert(UiRegionTable[0x03].selectedRow == 0x0002);
	assert(PendingMouseButtonEvent == 0x0000);
	assert(hideCallCount == 0x0002);
	assert(xorCallCount == 0x0002);
}

int main(void)
{
	TestIdlePollCachesHighlight();
	TestKeyboardSelection();
	TestEscapeRestoresSelections();
	TestMouseHoverAndClick();
	return 0x00;
}
