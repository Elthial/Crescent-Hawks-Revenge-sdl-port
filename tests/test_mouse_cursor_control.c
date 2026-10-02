#include "REVENGE.h"
#include "fake_backend.h"
#include "revenge/original_data.h"

#include <assert.h>

static word16 spriteDrawCalls;

void DrawClippedSprite(
	byte *destination,
	const byte *encodedSprite,
	int16 x,
	int16 y,
	word16 preserveExistingPixels)
{
	(void) encodedSprite;
	(void) preserveExistingPixels;
	++spriteDrawCalls;
	if (x >= 0x0000 && y >= 0x0000)
		destination[(word32) y * 0x0140 + x] = 0x0F;
}

int main(void)
{
	static const byte cursorBitmap[0x20] = { 0x00 };
	static byte cursorBackground[0x0240];

	FakeBackend_Reset();
	MouseCursorUpdateLock = 0x0000;
	MouseInputDisabled = 0x0000;
	MouseCursorMinX = 0x0000;
	MouseCursorMaxX = 0x013F;
	MouseCursorMinY = 0x0000;
	MouseCursorMaxY = 0x00C7;
	MouseDriverInstalled = FALSE;
	MouseCursorDisplayedX = 0x000A;
	MouseCursorDisplayedY = 0x0014;
	MouseCursorRequestedX = 0x000A;
	MouseY = 0x0014;
	MouseCursorHideDepth = 0x0000;
	MouseCursorBackground = cursorBackground;
	MouseCursorBitmap = cursorBitmap;
	fakeBackend.mouse.x = 0x0030;
	fakeBackend.mouse.y = 0x0040;
	ServiceMouseInputCallback();
	assert(MouseCursorRequestedX == 0x000A);
	assert(MouseY == 0x0014);
	MouseDriverInstalled = TRUE;

	assert(IsMouseCursorInsideRectangle(
		0x000A, 0x0014, 0x000A, 0x0014) == 0x0001);
	assert(IsMouseCursorInsideRectangle(
		0x000B, 0x0014, 0x0020, 0x0020) == 0x0000);

	SetMouseCursorPosition(-0x0005, 0x00D0);
	assert(MouseCursorRequestedX == 0x0000);
	assert(MouseY == 0x00C7);
	assert(fakeBackend.mouse.x == 0x0000);
	assert(fakeBackend.mouse.y == 0x00C7);
	assert(spriteDrawCalls == 0x0001);
	assert(fakeBackend.indexedFramebuffer[0x00C7 * 0x0140] == 0x0F);

	MoveMouseCursorRelative(0x0005, -0x0007);
	assert(MouseCursorRequestedX == 0x0005);
	assert(MouseY == 0x00C0);
	assert(fakeBackend.indexedFramebuffer[0x00C7 * 0x0140] == 0x00);
	assert(fakeBackend.indexedFramebuffer[0x00C0 * 0x0140 + 0x0005] == 0x0F);

	ConfigureMouseCursorOverlay(0x0002, 0x0003, cursorBitmap);
	assert(MouseCursorHotspotX == 0x0002);
	assert(MouseCursorHotspotY == 0x0003);
	assert(MouseCursorBitmap == cursorBitmap);

	MouseButtonState = 0x0000;
	PendingMouseButtonEvent = 0x0000;
	fakeBackend.mouse.x = 0x001E;
	fakeBackend.mouse.y = 0x0028;
	fakeBackend.mouse.buttonState = MOUSE_BUTTON_LEFT;
	fakeBackend.mouse.buttonEvent = TRUE;
	ServiceMouseInputCallback();
	assert(MouseCursorRequestedX == 0x001E);
	assert(MouseY == 0x0028);
	assert(MouseButtonState == MOUSE_BUTTON_LEFT);
	assert(PendingMouseButtonEvent != 0x0000);

	PendingMouseButtonEvent = 0x0000;
	fakeBackend.mouse.buttonState = 0x00;
	fakeBackend.mouse.buttonEvent = FALSE;
	ServiceMouseInputCallback();
	assert(MouseButtonState == 0x0000);
	assert(PendingMouseButtonEvent != 0x0000);

	HideMouseCursorOverlay();
	ShowMouseCursorOverlay();
	assert(MouseCursorUpdateLock == 0x0000);
	assert(MouseCursorHideDepth == 0x0000);
	assert(spriteDrawCalls == 0x0005);
	return 0x00;
}
