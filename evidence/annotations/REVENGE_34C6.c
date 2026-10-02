// REVENGE_34C6.c
// Selectively recovered from the refreshed Reko decompile.

#include "REVENGE.h"

// 34C6:0008: int16 RandomInRangeInclusive(uint16 minimum, uint16 maximum)
int16 RandomInRangeInclusive(uint16 minimum, uint16 maximum)
{
	return (int16) ((uint32) GeneratePseudoRandomByte()
		% ((maximum - minimum) + 0x01)) + minimum;
}
