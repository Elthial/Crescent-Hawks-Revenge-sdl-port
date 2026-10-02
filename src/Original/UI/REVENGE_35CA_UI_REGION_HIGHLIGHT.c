// Reconstructed original active UI-region highlight toggle (segment 35CA).

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

void HideMouseCursorOverlay(void);
void ShowMouseCursorOverlay(void);

// 35CA:0009: void ToggleActiveUiRegionHighlight(void)
// Called from:
//      ShowConfirmationDialog
//      RunMainMenuSelection
//      RunInGameMenu
//      RunGameOptionsMenu
void ToggleActiveUiRegionHighlight(void)
{
	word16 cursorHideDepth;

	cursorHideDepth = MouseCursorHideDepth;
	if (cursorHideDepth == 0x00)
		HideMouseCursorOverlay();
	XorVideoRectangle(
		ActiveUiHighlightLeft,
		ActiveUiHighlightTop,
		(word16) (ActiveUiHighlightLeft +
			ActiveUiHighlightWidth - 0x01),
		(word16) (ActiveUiHighlightTop +
			ActiveUiHighlightHeight - 0x01),
		(byte) ActiveUiHighlightXorColor);
	if (cursorHideDepth == 0x00)
		ShowMouseCursorOverlay();
}

