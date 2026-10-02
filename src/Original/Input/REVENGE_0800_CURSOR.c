/* Software-cursor procedures from original segment 0800. */

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/platform_backend.h"
#include "revenge/video.h"

/* 0800:3772: INT 33h event callback. SDL replaces the asynchronous driver
 * boundary, while this retains the original state-update and cursor-redraw
 * behavior at each serviced input poll. */
void ServiceMouseInputCallback(void)
{
	MouseInputState state;
	word16 changedButtons;
	int16 requestedX;
	int16 requestedY;

	/* DOS cannot invoke 0800:3772 until InitializeMouseSupport has
	 * installed it with INT 33h/AX=000Ch. */
	if (MouseDriverInstalled == FALSE ||
		MouseInputDisabled != FALSE)
		return;

	ReadMouseInputState(&state);
	changedButtons = MouseButtonState ^ state.buttonState;
	if (changedButtons != 0x0000 || state.buttonEvent != FALSE)
	{
		PendingMouseButtonEvent |=
			changedButtons | state.buttonEvent;
		MouseButtonState = state.buttonState;
	}

	if (MouseCursorUpdateLock != 0x0000)
		return;

	++MouseCursorUpdateLock;
	requestedX = (int16) state.x;
	requestedY = (int16) state.y;
	if (MouseDriverDoubleX != FALSE)
		requestedX >>= 0x01;
	MouseCursorRequestedX = requestedX;
	MouseY = (word16) requestedY;
	if (requestedX != MouseCursorDisplayedX ||
		requestedY != MouseCursorDisplayedY)
	{
		HideMouseCursorOverlayUnlocked();
		ShowMouseCursorOverlayUnlocked();
	}
	--MouseCursorUpdateLock;
}

/* 0800:3665-36A5 */
void ConfigureMouseCursorOverlay(
	int16 hotspotX,
	int16 hotspotY,
	const byte *cursorBitmap)
{
	while (MouseCursorUpdateLock != 0x0000)
		;
	++MouseCursorUpdateLock;
	HideMouseCursorOverlayUnlocked();
	MouseCursorHotspotX = hotspotX;
	MouseCursorHotspotY = hotspotY;
	MouseCursorBitmap = cursorBitmap;
	ShowMouseCursorOverlayUnlocked();
	--MouseCursorUpdateLock;
}

/* 0800:3825-387C */
word16 IsMouseCursorInsideRectangle(
	int16 left,
	int16 top,
	int16 right,
	int16 bottom)
{
	word16 isInside;

	while (MouseCursorUpdateLock != 0x0000)
		;
	++MouseCursorUpdateLock;
	MouseCursorTestX = MouseCursorDisplayedX;
	MouseCursorTestY = MouseCursorDisplayedY;
	isInside = MouseCursorTestX >= left &&
		MouseCursorTestX <= right &&
		MouseCursorTestY >= top &&
		MouseCursorTestY <= bottom;
	--MouseCursorUpdateLock;
	return isInside;
}

/* 0800:387D-3967 */
void HideMouseCursorOverlayUnlocked(void)
{
	if (MouseInputDisabled != 0x0000)
		return;
	if (MouseCursorHideDepth == 0x0000)
	{
		int16 cursorLeft;
		int16 cursorTop;
		int16 tileLeft;
		int16 tileTop;

		MouseCursorErasedX = MouseCursorDisplayedX;
		MouseCursorErasedY = MouseCursorDisplayedY;
		cursorLeft = MouseCursorDisplayedX - MouseCursorHotspotX;
		cursorTop = MouseCursorDisplayedY - MouseCursorHotspotY;
		tileLeft = cursorLeft >> 0x03;
		if (tileLeft > -0x03 && tileLeft < VIDEO_SCREEN_8PX_COLUMN_COUNT)
		{
			MouseCursorRestoreTileLeft = tileLeft;
			MouseCursorRestoreTileRight = tileLeft + 0x03;
			if (MouseCursorRestoreTileLeft < 0x0000)
				MouseCursorRestoreTileLeft = 0x0000;
			if (MouseCursorRestoreTileRight > VIDEO_SCREEN_8PX_COLUMN_COUNT)
				MouseCursorRestoreTileRight = VIDEO_SCREEN_8PX_COLUMN_COUNT;
			tileTop = cursorTop >> 0x03;
			if (tileTop > -0x03 && tileTop < VIDEO_SCREEN_HEIGHT / 0x0008)
			{
				MouseCursorRestoreTileTop = tileTop;
				MouseCursorRestoreTileBottom = tileTop + 0x03;
				if (MouseCursorRestoreTileTop < 0x0000)
					MouseCursorRestoreTileTop = 0x0000;
				if (MouseCursorRestoreTileBottom > VIDEO_SCREEN_HEIGHT / 0x0008)
					MouseCursorRestoreTileBottom = VIDEO_SCREEN_HEIGHT / 0x0008;
				CopyBufferToVideoRegion(
					MouseCursorRestoreTileLeft,
					(word16) MouseCursorRestoreTileTop,
					(word16) (MouseCursorRestoreTileRight -
						MouseCursorRestoreTileLeft),
					(word16) (MouseCursorRestoreTileBottom -
						MouseCursorRestoreTileTop),
					MouseCursorBackground);
			}
		}
	}
	++MouseCursorHideDepth;
	if (MouseCursorHideDepth == 0x0000)
		--MouseCursorHideDepth;
}

/* 0800:3968-398B */
void HideMouseCursorOverlay(void)
{
	while (MouseCursorUpdateLock != 0x0000)
		;
	++MouseCursorUpdateLock;
	HideMouseCursorOverlayUnlocked();
	--MouseCursorUpdateLock;
}

/* 0800:398C-39FA */
void SetMouseCursorPositionUnlocked(int16 requestedX, int16 requestedY)
{
	if (MouseInputDisabled != 0x0000)
		return;

	if (requestedX < MouseCursorMinX)
		requestedX = MouseCursorMinX;
	else if (requestedX > MouseCursorMaxX)
		requestedX = MouseCursorMaxX;
	MouseCursorRequestedX = requestedX;

	if (requestedY < MouseCursorMinY)
		requestedY = MouseCursorMinY;
	else if (requestedY > MouseCursorMaxY)
		requestedY = MouseCursorMaxY;
	MouseY = (word16) requestedY;

	if (MouseDriverInstalled != 0x0000)
		SDLBackend_SetMousePosition(requestedX, requestedY);

	if (requestedX != MouseCursorDisplayedX ||
		requestedY != MouseCursorDisplayedY)
	{
		HideMouseCursorOverlayUnlocked();
		ShowMouseCursorOverlayUnlocked();
	}
}

/* 0800:39FB-3A22 */
void SetMouseCursorPosition(int16 x, int16 y)
{
	while (MouseCursorUpdateLock != 0x0000)
		;
	++MouseCursorUpdateLock;
	SetMouseCursorPositionUnlocked(x, y);
	--MouseCursorUpdateLock;
}

/* 0800:3A23-3A52 */
void MoveMouseCursorRelative(int16 deltaX, int16 deltaY)
{
	while (MouseCursorUpdateLock != 0x0000)
		;
	++MouseCursorUpdateLock;
	SetMouseCursorPositionUnlocked(
		(int16) (MouseCursorRequestedX + deltaX),
		(int16) ((int16) MouseY + deltaY));
	--MouseCursorUpdateLock;
}

/* 0800:3A53-3B79 */
void ShowMouseCursorOverlayUnlocked(void)
{
	int16 drawLeft;
	int16 drawTop;
	int16 tileLeft;
	int16 tileTop;

	if (MouseInputDisabled != 0x0000 ||
		MouseCursorHideDepth == 0x0000)
		return;
	--MouseCursorHideDepth;
	if (MouseCursorHideDepth != 0x0000)
		return;
	MouseCursorDisplayedX = MouseCursorRequestedX;
	MouseCursorDrawnX = MouseCursorRequestedX;
	MouseCursorDisplayedY = (int16) MouseY;
	MouseCursorDrawnY = (int16) MouseY;
	drawLeft = MouseCursorDisplayedX - MouseCursorHotspotX;
	drawTop = MouseCursorDisplayedY - MouseCursorHotspotY;
	MouseCursorDrawLeft = drawLeft;
	MouseCursorDrawTop = drawTop;
	tileLeft = drawLeft >> 0x03;
	if (tileLeft <= -0x03 || tileLeft >= VIDEO_SCREEN_8PX_COLUMN_COUNT)
		return;
	MouseCursorCaptureTileLeft = tileLeft;
	MouseCursorCaptureTileRight = tileLeft + 0x03;
	if (MouseCursorCaptureTileLeft < 0x0000)
		MouseCursorCaptureTileLeft = 0x0000;
	if (MouseCursorCaptureTileRight > VIDEO_SCREEN_8PX_COLUMN_COUNT)
		MouseCursorCaptureTileRight = VIDEO_SCREEN_8PX_COLUMN_COUNT;
	tileTop = drawTop >> 0x03;
	if (tileTop <= -0x03 || tileTop >= VIDEO_SCREEN_HEIGHT / 0x0008)
		return;
	MouseCursorCaptureTileTop = tileTop;
	MouseCursorCaptureTileBottom = tileTop + 0x03;
	if (MouseCursorCaptureTileTop < 0x0000)
		MouseCursorCaptureTileTop = 0x0000;
	if (MouseCursorCaptureTileBottom > VIDEO_SCREEN_HEIGHT / 0x0008)
		MouseCursorCaptureTileBottom = VIDEO_SCREEN_HEIGHT / 0x0008;
	CopyVideoRegionToBuffer(
		MouseCursorCaptureTileLeft,
		(word16) MouseCursorCaptureTileTop,
		(word16) (MouseCursorCaptureTileRight -
			MouseCursorCaptureTileLeft),
		(word16) (MouseCursorCaptureTileBottom -
			MouseCursorCaptureTileTop),
		MouseCursorBackground);
	DrawClippedSprite(
		Video_GetIndexedFramebuffer(), MouseCursorBitmap,
		drawLeft, drawTop, 0x0000);
}

/* 0800:3B7A-3B9D */
void ShowMouseCursorOverlay(void)
{
	while (MouseCursorUpdateLock != 0x0000)
		;
	++MouseCursorUpdateLock;
	ShowMouseCursorOverlayUnlocked();
	--MouseCursorUpdateLock;
}
