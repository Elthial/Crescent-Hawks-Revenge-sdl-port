// Reconstructed original text-window context selector (segment 3338).

#include "REVENGE.h"
#include "revenge/original_data.h"

// 3338:0009
// Select one of the 23 persistent text-window contexts. The geometry is fixed
// in the context table; the four mutable drawing fields are saved whenever the
// caller changes windows, then restored with the selected window.
void SelectTextWindow(word16 windowIndex)
{
	TextWindowContext *previous;
	TextWindowContext *selected;

	if (TextWindowStateInitialized != FALSE)
	{
		previous = &TextWindowContexts[ActiveTextWindowIndex];
		previous->foregroundColor = ActiveTextForegroundColor;
		previous->backgroundColor = ActiveTextBackgroundColor;
		previous->cursorColumn = ActiveTextCursorColumn;
		previous->cursorRow = ActiveTextCursorRow;
	}
	else
	{
		TextWindowStateInitialized = TRUE;
	}

	selected = &TextWindowContexts[windowIndex];
	ActiveTextWindowIndex = windowIndex;
	ActiveTextWindowLeftTile = selected->leftTile;
	ActiveTextWindowTopTile = selected->topTile;
	ActiveTextWindowWidthTiles = selected->widthTiles;
	ActiveTextWindowHeightTiles = selected->heightTiles;
	ActiveTextForegroundColor = selected->foregroundColor;
	ActiveTextBackgroundColor = selected->backgroundColor;
	ActiveTextCursorColumn = selected->cursorColumn;
	ActiveTextCursorRow = selected->cursorRow;
}
