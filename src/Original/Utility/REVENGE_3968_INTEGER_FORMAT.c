// Reconstructed original integer formatting utilities (segment 3968).

#include "REVENGE.h"

// 3968:0009: Register far pointer FormatLongInteger(
//     Stack byte alphabeticDigitBase, Stack byte signedConversion,
//     Stack uint16 radix, Stack far pointer destination, Stack uint32 value)
// Called from:
//      IntegerToString
//      LongToString
char *FormatLongInteger(
	byte alphabeticDigitBase,
	byte signedConversion,
	uint16 radix,
	char *destination,
	uint32 value)
{
	char *result;
	byte reversedDigits[0x22];
	uint16 digitCount;
	uint32 magnitude;

	result = destination;
	digitCount = 0x00;

	if (radix < 0x02 || radix > 0x24)
	{
		*destination = 0x00;
		return result;
	}

	magnitude = value;
	if (signedConversion != 0x00 && (int32) value < 0x00)
	{
		*destination++ = '-';
		magnitude = 0x00UL - value;
	}

	do
	{
		reversedDigits[digitCount++] = (byte) (magnitude % radix);
		magnitude /= radix;
	} while (magnitude != 0x00);

	while (digitCount != 0x00)
	{
		byte digit;

		digit = reversedDigits[--digitCount];
		if (digit < 0x0A)
			*destination++ = (char) ('0' + digit);
		else
			*destination++ = (char) (alphabeticDigitBase + digit - 0x0A);
	}

	*destination = 0x00;
	return result;
}

// 3968:008D: Register far pointer IntegerToString(
//     Stack int16 value, Stack far pointer destination, Stack uint16 radix)
// Called from mission-date, campaign-clock, unit-status, and startup rendering.
char *IntegerToString(
	int16 value,
	char *destination,
	uint16 radix)
{
	uint32 extendedValue;

	if (radix == 0x0A)
		extendedValue = (uint32) (int32) value;
	else
		extendedValue = (uint16) value;

	return FormatLongInteger(
		'a',
		0x01,
		radix,
		destination,
		extendedValue);
}

// 3968:00DA: Register far pointer LongToString(
//     Stack int32 value, Stack far pointer destination, Stack uint16 radix)
// Called from:
//      PrintAllocationErrorAndExit
char *LongToString(
	int32 value,
	char *destination,
	uint16 radix)
{
	return FormatLongInteger(
		'a',
		radix == 0x0A,
		radix,
		destination,
		(uint32) value);
}
