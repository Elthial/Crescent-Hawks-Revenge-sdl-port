/* Startup string procedures from original segment 0D73. */

#include "REVENGE.h"

// 0D73:418E: void RightAlignStringField(char far *text, word16 fieldWidth)
// Called from:
//      InitializeGame
void RightAlignStringField(char *text, word16 fieldWidth)
{
	word16 textLength = StringLength(text);
	if (textLength >= fieldWidth)
		return;
	word16 leadingSpaces = fieldWidth - textLength;
	int16 index;

	// The original moves the NUL and one following byte, preserving the
	// double-NUL convention used by the startup version buffer.
	for (index = textLength + 0x01; index >= 0x00; --index)
		text[index + leadingSpaces] = text[index];
	for (index = 0x00; index < leadingSpaces; ++index)
		text[index] = ' ';
}

// 0D73:4288: void TranslateCharactersInPlace(char far *text, const char far *sourceAlphabet, const char far *replacementAlphabet)
// Called from:
//      InitializeGame
void TranslateCharactersInPlace(
	char *text,
	const char *sourceAlphabet,
	const char *replacementAlphabet)
{
	word16 textLength = StringLength(text);
	word16 alphabetLength = StringLength(sourceAlphabet);
	word16 textIndex;
	for (textIndex = 0x00; textIndex < textLength; ++textIndex)
	{
		word16 alphabetIndex;
		for (alphabetIndex = 0x00; alphabetIndex < alphabetLength; ++alphabetIndex)
		{
			if (text[textIndex] == sourceAlphabet[alphabetIndex])
				text[textIndex] = replacementAlphabet[alphabetIndex];
		}
	}
}
