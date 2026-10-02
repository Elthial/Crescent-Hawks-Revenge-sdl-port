// REVENGE_39F8.c
// Borland far-string run-time helper recovered from REVENGE.EXE.

#include "REVENGE.h"
#include "revenge/original_data.h"

static word16 IsFarStringDelimiter(byte character, const char __far *delimiters)
{
	while (*delimiters != '\0')
	{
		if ((byte)*delimiters++ == character)
			return TRUE;
	}
	return FALSE;
}

// 39F8:0000: Borland-compatible strtok for far strings.
// Passing a non-null string starts a tokenization sequence; later null calls
// continue from the cursor retained at DS:B88E/B890. Delimiters become NUL.
char __far *FarStringTokenize(
	char __far *string,
	const char __far *delimiters)
{
	char __far *cursor;
	char __far *token;

	if (string != NULL)
	{
		FarStrtokCursorOffset_B88E = FAR_OFFSET(string);
		FarStrtokCursorSegment_B890 = FAR_SEGMENT(string);
	}

	cursor = FAR_POINTER(char,
		FarStrtokCursorSegment_B890,
		FarStrtokCursorOffset_B88E);
	while (*cursor != '\0'
		&& IsFarStringDelimiter((byte)*cursor, delimiters) != FALSE)
	{
		++FarStrtokCursorOffset_B88E;
		cursor = FAR_POINTER(char,
			FarStrtokCursorSegment_B890,
			FarStrtokCursorOffset_B88E);
	}

	if (*cursor == '\0')
		return NULL;

	token = cursor;
	while (*cursor != '\0')
	{
		if (IsFarStringDelimiter((byte)*cursor, delimiters) != FALSE)
		{
			*cursor = '\0';
			++FarStrtokCursorOffset_B88E;
			break;
		}
		++FarStrtokCursorOffset_B88E;
		cursor = FAR_POINTER(char,
			FarStrtokCursorSegment_B890,
			FarStrtokCursorOffset_B88E);
	}

	return token;
}
