// Reconstructed original inclusive random-range utility (segment 34C6).

#include "REVENGE.h"

// 34C6:0008: int16 RandomInRangeInclusive(uint16 minimum, uint16 maximum)
int16 RandomInRangeInclusive(uint16 minimum, uint16 maximum)
{
	int16 range;
	int16 randomValue;
	int16 remainder;

	range = (int16) (maximum - minimum + 0x01);
	randomValue = (int16) GeneratePseudoRandomByte();
	remainder = randomValue % range;
	return (int16) (remainder + (int16) minimum);
}
