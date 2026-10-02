/* Preserved text-entry cursor blink from REVENGE_0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"

/* 0D73:3DA9-3E1D */
void UpdateTextEntryCursorBlink(void)
{
	LocalClockSnapshot clockSnapshot;
	word16 savedCursorColumn;
	word16 savedCursorRow;
	char cursorText[0x02];

	CaptureLocalClockSnapshot(&clockSnapshot);
	savedCursorColumn = ActiveTextCursorColumn;
	savedCursorRow = ActiveTextCursorRow;
	cursorText[0x00] = TextEntryBuffer[TextEntryCursorIndex];
	cursorText[0x01] = '\0';
	if ((clockSnapshot.milliseconds & 0x0200) != 0x0000)
		FarStringCopy(cursorText, TextCursorBlinkGlyph);
	ActiveTextCursorColumn += TextEntryCursorIndex;
	HideMouseCursorOverlay();
	RenderFormattedText(cursorText);
	ShowMouseCursorOverlay();
	ActiveTextCursorColumn = savedCursorColumn;
	ActiveTextCursorRow = savedCursorRow;
}
