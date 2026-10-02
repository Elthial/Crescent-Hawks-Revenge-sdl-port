// REVENGE_39F8_STRING_TOKENIZE.c - far-string tokenization
// Borland far-string run-time helper recovered from REVENGE.EXE.

#include "REVENGE.h"
#include "revenge/original_data.h"

// 39F8:0000: Borland-compatible strtok for far strings.
// Passing a non-null string starts a tokenization sequence; later null calls
// continue from the cursor retained at DS:B88E/B890. Delimiters become NUL.
char *FarStringTokenize(
	char *string,
	const char *delimiters)
{
	char *cursor;
	char *token;

	if (string != NULL)
		FarStrtokCursor = string;

	cursor = FarStrtokCursor;
	while (*cursor != '\0')
	{
		const char *delimiter = delimiters;
		word16 isDelimiter = FALSE;

		while (*delimiter != '\0')
		{
			if ((byte)*delimiter++ == (byte)*cursor)
			{
				isDelimiter = TRUE;
				break;
			}
		}
		if (isDelimiter == FALSE)
			break;
		cursor = ++FarStrtokCursor;
	}

	if (*cursor == '\0')
		return NULL;

	token = cursor;
	while (*cursor != '\0')
	{
		const char *delimiter = delimiters;
		word16 isDelimiter = FALSE;

		while (*delimiter != '\0')
		{
			if ((byte)*delimiter++ == (byte)*cursor)
			{
				isDelimiter = TRUE;
				break;
			}
		}
		if (isDelimiter != FALSE)
		{
			*cursor = '\0';
			FarStrtokCursor = cursor + 0x01;
			break;
		}
		cursor = ++FarStrtokCursor;
	}

	return token;
}
