// Reconstructed original formatted text interpreter (segment 35CE).

#include "REVENGE.h"
#include "revenge/original_data.h"

enum FormattedTextControl
{
	FORMATTED_TEXT_END = 0x00,
	FORMATTED_TEXT_SET_BACKGROUND = 0x02,
	FORMATTED_TEXT_SET_FOREGROUND = 0x06,
	FORMATTED_TEXT_SET_COLUMN = 0x09,
	FORMATTED_TEXT_NEWLINE = 0x0D,
	FORMATTED_TEXT_PAD_TO_COLUMN = 0x13,
	FORMATTED_TEXT_SPACE = 0x20
};

// 35CE:000A: void RenderFormattedText(Stack far pointer formattedText)
// Called from:
//      ShowConfirmationDialog
//      ShowScenarioMessage
//      UpdateTextEntryCursorBlink
//      EditTextField
//      ShowInvalidSaveVersionDialog
//      SaveGame
//      ShowSaveLoadMenu
//      RenameSaveSlot
//      WaitForAcknowledgement
//      PromptYesNo
//      RunGameOptionsMenu
void RenderFormattedText(const char *formattedText)
{
	// Verified against ASM 35CE:000A-0530. Render the encoded NUL-terminated
	// text stream, including the original two-byte dictionary expansion,
	// wrapping, layout controls, color controls and mutable render buffers.
	char composedLine[0x52];
	char tokenBuffer[0x52];
	// V: 35CE:0031 explicitly writes this terminator; Reko omitted it.
	composedLine[0x00] = '\0';
	word16 allowLeadingSpace = 0x01;
	word16 reachedEnd = 0x00;
	word16 hasPendingExpandedByte = 0x00;
	byte pendingExpandedByte = 0x00;
	word16 tokenLength = 0x00;
	word16 textOffset = 0x00;
	word16 lineColumn = ActiveTextCursorColumn;
	word16 requestedColumn;
	word16 paddingTargetColumn;
	word16 remainingPaddingColumns;
	while (reachedEnd == 0x00)
	{
		byte formatByte;
		if (hasPendingExpandedByte == 0x00)
		{
			formatByte = (byte) formattedText[textOffset];
			++textOffset;
		}
		else
		{
			formatByte = pendingExpandedByte;
			hasPendingExpandedByte = 0x00;
		}
		if ((formatByte & 0x80) != 0x00)
		{
			byte dictionaryIndex = (byte) (((int16) formatByte & 0x7F) >> 0x03);
			pendingExpandedByte = CompressedTextSecondByteTable[
				(word16) dictionaryIndex * 0x08 + (formatByte & 0x07)];
			formatByte = CompressedTextFirstByteTable[dictionaryIndex];
			hasPendingExpandedByte = 0x01;
		}
		switch (formatByte)
		{
		case FORMATTED_TEXT_END:
			reachedEnd = 0x01;
			break;
		case FORMATTED_TEXT_NEWLINE:
			tokenBuffer[tokenLength] = 0x00;
			if (ActiveFontGlyphAdvanceX
				* (tokenLength + lineColumn)
				<= ActiveTextWindowWidthTiles << 0x03)
			{
				FarStringConcat(composedLine, tokenBuffer);
				RenderTextToActiveWindow(composedLine, 0x01);
			}
			else
			{
				RenderTextToActiveWindow(composedLine, 0x01);
				RenderTextToActiveWindow(tokenBuffer, 0x01);
			}
			tokenLength = 0x00;
			lineColumn = 0x00;
			allowLeadingSpace = 0x01;
			break;
		case FORMATTED_TEXT_SET_BACKGROUND:
			tokenBuffer[tokenLength] = 0x00;
			if (ActiveFontGlyphAdvanceX
				* (tokenLength + lineColumn)
				<= ActiveTextWindowWidthTiles << 0x03)
			{
				FarStringConcat(composedLine, tokenBuffer);
				RenderTextToActiveWindow(composedLine, 0x00);
			}
			else
			{
				RenderTextToActiveWindow(composedLine, 0x01);
				RenderTextToActiveWindow(tokenBuffer, 0x00);
			}
			lineColumn = ActiveTextCursorColumn;
			ActiveTextBackgroundColor =
				(word16) (int8) formattedText[textOffset];
			tokenLength = 0x00;
			++textOffset;
			break;
		case FORMATTED_TEXT_SET_FOREGROUND:
			tokenBuffer[tokenLength] = 0x00;
			if (ActiveFontGlyphAdvanceX
				* (tokenLength + lineColumn)
				<= ActiveTextWindowWidthTiles << 0x03)
			{
				FarStringConcat(composedLine, tokenBuffer);
				RenderTextToActiveWindow(composedLine, 0x00);
			}
			else
			{
				RenderTextToActiveWindow(composedLine, 0x01);
				RenderTextToActiveWindow(tokenBuffer, 0x00);
			}
			lineColumn = ActiveTextCursorColumn;
			ActiveTextForegroundColor =
				(word16) (int8) formattedText[textOffset];
			tokenLength = 0x00;
			++textOffset;
			break;
		case FORMATTED_TEXT_SET_COLUMN:
			tokenBuffer[tokenLength] = 0x00;
			if (ActiveFontGlyphAdvanceX
				* (tokenLength + lineColumn)
				<= ActiveTextWindowWidthTiles << 0x03)
			{
				FarStringConcat(composedLine, tokenBuffer);
				RenderTextToActiveWindow(composedLine, 0x00);
			}
			else
			{
				RenderTextToActiveWindow(composedLine, 0x01);
				RenderTextToActiveWindow(tokenBuffer, 0x00);
			}
			requestedColumn = (word16) (int8) formattedText[textOffset];
			ActiveTextCursorColumn = requestedColumn;
			tokenLength = 0x00;
			lineColumn = requestedColumn;
			++textOffset;
			if (ActiveFontGlyphAdvanceX
				* (ActiveTextCursorColumn + 0x01)
				>= ActiveTextWindowWidthTiles << 0x03)
			{
				ActiveTextCursorColumn = 0x00;
				lineColumn = 0x00;
			}
			break;
		case FORMATTED_TEXT_PAD_TO_COLUMN:
			paddingTargetColumn = (word16) (int8) formattedText[textOffset];
			remainingPaddingColumns = paddingTargetColumn;
			++textOffset;
			if ((int16) ActiveTextCursorColumn < (int16) paddingTargetColumn)
			{
				for (;
					(int16) ActiveTextCursorColumn
						< (int16) remainingPaddingColumns;
					--remainingPaddingColumns)
				{
					tokenBuffer[tokenLength] = 0x20;
					tokenLength = (word16) tokenLength + 0x01;
				}
				tokenBuffer[tokenLength] = 0x00;
				FarStringConcat(composedLine, tokenBuffer);
				lineColumn += tokenLength;
				tokenLength = 0x00;
			}
			break;
		case FORMATTED_TEXT_SPACE:
			if (ActiveFontGlyphAdvanceX
				* (tokenLength + lineColumn)
				<= ActiveTextWindowWidthTiles << 0x03)
			{
				if (ActiveFontGlyphAdvanceX
					* ((tokenLength + lineColumn) + 0x01)
					<= ActiveTextWindowWidthTiles << 0x03
					&& (tokenLength + lineColumn != 0x00 || allowLeadingSpace != 0x00))
				{
					tokenBuffer[tokenLength] = 0x20;
					tokenLength = (word16) tokenLength + 0x01;
				}
				tokenBuffer[tokenLength] = 0x00;
				FarStringConcat(composedLine, tokenBuffer);
			}
			else
			{
				if (ActiveFontGlyphAdvanceX
					* ((word16) tokenLength + 0x01)
					<= ActiveTextWindowWidthTiles << 0x03
					&& tokenLength != 0x00)
				{
					tokenBuffer[tokenLength] = 0x20;
					tokenLength = (word16) tokenLength + 0x01;
				}
				tokenBuffer[tokenLength] = 0x00;
				RenderTextToActiveWindow(composedLine, 0x01);
				FarStringCopy(composedLine, tokenBuffer);
				lineColumn = 0x00;
			}
			lineColumn += tokenLength;
			tokenLength = 0x00;
			allowLeadingSpace = 0x00;
			break;
		default:
			if (tokenLength * ActiveFontGlyphAdvanceX
				>= ActiveTextWindowWidthTiles << 0x03)
			{
				if (composedLine[0x00] != 0x00)
					RenderTextToActiveWindow(composedLine, 0x01);
				tokenBuffer[tokenLength] = 0x00;
				FarStringConcat(composedLine, tokenBuffer);
				RenderTextToActiveWindow(composedLine, 0x01);
				lineColumn = 0x00;
				tokenBuffer[0x00] = formatByte;
				tokenLength = 0x01;
			}
			else
			{
				tokenBuffer[tokenLength] = formatByte;
				tokenLength = (word16) tokenLength + 0x01;
			}
			break;
		}
	}
	if (tokenLength != 0x00 || composedLine[0x00] != 0x00)
	{
		tokenBuffer[tokenLength] = 0x00;
		if ((ActiveTextWindowWidthTiles << 0x03)
				- ActiveFontGlyphAdvanceX
			>= ActiveFontGlyphAdvanceX
				* (tokenLength + lineColumn))
		{
			FarStringConcat(composedLine, tokenBuffer);
			RenderTextToActiveWindow(composedLine, 0x00);
		}
		else
		{
			RenderTextToActiveWindow(composedLine, 0x01);
			RenderTextToActiveWindow(tokenBuffer, 0x00);
		}
	}
}
