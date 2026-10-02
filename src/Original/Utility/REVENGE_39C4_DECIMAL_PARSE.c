// Reconstructed original signed decimal parser (segment 39C4).

#include "REVENGE.h"
#include "revenge/original_data.h"

// 39C4:0005
// Borland atol implementation: skip CRT whitespace, accept one optional sign,
// accumulate decimal digits in DX:AX, and return the signed 32-bit result.
long ParseSignedDecimalLong(const char * text)
{
	long value = 0x00;
	word16 negative = FALSE;

	while ((CharacterClassTable[(unsigned char) *text] & 0x01) != 0x00)
		++text;

	if (*text == '+' || *text == '-')
	{
		negative = *text == '-';
		++text;
	}

	while (*text >= '0' && *text <= '9')
	{
		value = value * 0x0A + (*text - '0');
		++text;
	}

	return negative ? -value : value;
}
