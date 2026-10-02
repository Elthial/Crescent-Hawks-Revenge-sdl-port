/* Fixed-width string procedures from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/text.h"

// 0D73:41E8: void RemoveLeadingSpacesFrom(char far *text, word16 oneBasedStart)
// Called from:
//      DrawCenteredClippedText
void RemoveLeadingSpacesFrom(char *text, word16 oneBasedStart)
{
	word16 textLength = StringLength(text);
	word16 sourceIndex = oneBasedStart - 0x01;
	word16 destinationIndex = sourceIndex;

	while (sourceIndex < textLength && text[sourceIndex] == ' ')
		++sourceIndex;
	while (sourceIndex <= textLength)
		text[destinationIndex++] = text[sourceIndex++];
}

// 0D73:4238: void TrimTrailingEncodedSpaces(char far *text)
// Called from:
//      DrawCenteredClippedText
//      EditTextField
void TrimTrailingEncodedSpaces(char *text)
{
	int16 index;
	for (index = StringLength(text) - 0x01; index >= 0x00; --index)
	{
		if ((text[index] & 0x3F) != ' ')
		{
			text[index + 0x01] = '\0';
			return;
		}
	}
	text[0x00] = '\0';
}

// 0D73:42E4: void PadStringToWidth(char far *text, word16 width)
// Called from:
//      EditTextField
void PadStringToWidth(char *text, word16 width)
{
	word16 index = StringLength(text);
	while (index < width)
		text[index++] = ' ';
	text[width] = '\0';
}

// 0D73:454A: void FillTextEntryBuffer(word16 length, byte fillCharacter)
// Called from:
//      EditTextField
void FillTextEntryBuffer(word16 length, byte fillCharacter)
{
	word16 index;
	for (index = 0x00; index < length; ++index)
		TextEntryBuffer[index] = fillCharacter;
	TextEntryBuffer[index++] = '\0';
	if (index <= 0x15)
		TextEntryBuffer[index] = '\0';
}
