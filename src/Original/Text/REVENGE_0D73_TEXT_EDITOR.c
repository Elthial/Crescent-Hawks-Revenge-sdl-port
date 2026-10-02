/* Preserved fixed-width text-field editor from REVENGE_0D73. */

#include "REVENGE.h"

#include "revenge/input.h"
#include "revenge/original_data.h"
#include "revenge/text.h"

/* 0D73:4317-4549 */
word16 EditTextField(
	word16 maximumLength,
	const char *initialText,
	byte allowedCharacterClasses)
{
	word16 punctuationCount;
	int16 glyphAdvance;
	word16 effectiveMaximumLength;
	word16 windowWidthPixels;
	word16 savedCursorColumn;
	word16 savedCursorRow;
	word16 cursorIndex;
	int16 keyCode;
	word16 firstKey;

	HideMouseCursorOverlay();
	TextEntryActive = TRUE;
	punctuationCount = StringLength(TextEntryPunctuation);
	glyphAdvance = ActiveFontGlyphAdvanceX;
	effectiveMaximumLength = maximumLength;
	windowWidthPixels = ActiveTextWindowWidthTiles << 0x03;
	if ((int16) ((maximumLength + ActiveTextCursorColumn) *
		(word16) glyphAdvance) >= (int16) windowWidthPixels)
	{
		effectiveMaximumLength = (word16) ((int16)
			(windowWidthPixels - ActiveTextCursorColumn *
			(word16) glyphAdvance) / glyphAdvance);
	}

	if (*initialText == ' ')
		FillTextEntryBuffer(effectiveMaximumLength, ' ');
	else
		FarStringCopy((char *) TextEntryBuffer, initialText);

	savedCursorColumn = ActiveTextCursorColumn;
	savedCursorRow = ActiveTextCursorRow;
	if (StringLength((const char *) TextEntryBuffer) <
		effectiveMaximumLength)
	{
		PadStringToWidth(
			(char *) TextEntryBuffer, effectiveMaximumLength);
	}
	RenderFormattedText(TextEntryBuffer);
	ActiveTextCursorColumn = savedCursorColumn;
	ActiveTextCursorRow = savedCursorRow;

	cursorIndex = 0x0000;
	keyCode = 0x0000;
	firstKey = TRUE;
	while (cursorIndex <= effectiveMaximumLength && keyCode != KEY_CARRIAGE_RETURN)
	{
		word16 acceptedCharacter;

		TextEntryCursorIndex = cursorIndex;
		keyCode = (int16) WaitForKeyboardOrMouseInput();
		if (firstKey != FALSE)
		{
			firstKey = FALSE;
			if (keyCode != KEY_CARRIAGE_RETURN)
				FillTextEntryBuffer(effectiveMaximumLength, ' ');
		}

		acceptedCharacter = FALSE;
		if (keyCode == KEY_ESCAPE || keyCode == KEY_CTRL_S)
		{
			FillTextEntryBuffer(effectiveMaximumLength, ' ');
			cursorIndex = 0x0000;
		}
		else if (keyCode == KEY_DELETE || keyCode == KEY_BACKSPACE)
		{
			if (cursorIndex > 0x0000)
				--cursorIndex;
			TextEntryBuffer[cursorIndex] = ' ';
		}
		else if (keyCode != KEY_CARRIAGE_RETURN && keyCode >= 0x0000)
		{
			byte characterClass;

			characterClass = CharacterClassTable[(byte) keyCode];
			if ((allowedCharacterClasses & 0x02) != 0x00 &&
				((characterClass & 0x0C) != 0x00 || keyCode == KEY_SPACE))
			{
				keyCode &= 0x007F;
				acceptedCharacter = TRUE;
			}
			if ((allowedCharacterClasses & 0x01) != 0x00 &&
				acceptedCharacter == FALSE &&
				(characterClass & 0x02) != 0x00)
			{
				acceptedCharacter = TRUE;
			}
			if ((allowedCharacterClasses & 0x04) != 0x00 &&
				acceptedCharacter == FALSE)
			{
				word16 punctuationIndex;

				punctuationIndex = 0x0000;
				while (punctuationIndex < punctuationCount &&
					(byte) TextEntryPunctuation[punctuationIndex] !=
					(byte) keyCode)
				{
					++punctuationIndex;
				}
				if (punctuationIndex != punctuationCount)
					acceptedCharacter = TRUE;
			}
			if (acceptedCharacter != FALSE &&
				cursorIndex < effectiveMaximumLength)
			{
				TextEntryBuffer[cursorIndex++] = (byte) keyCode;
				TextEntryBuffer[cursorIndex] = ' ';
			}
		}

		savedCursorColumn = ActiveTextCursorColumn;
		savedCursorRow = ActiveTextCursorRow;
		RenderFormattedText(TextEntryBuffer);
		ActiveTextCursorColumn = savedCursorColumn;
		ActiveTextCursorRow = savedCursorRow;
	}

	TrimTrailingEncodedSpaces((char *) TextEntryBuffer);
	TextEntryActive = FALSE;
	ShowMouseCursorOverlay();
	return StringLength((const char *) TextEntryBuffer);
}
