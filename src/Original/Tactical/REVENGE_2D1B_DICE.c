// Procedures preserved from REVENGE_2D1B_TACTICAL_COMBAT.c.

#include "REVENGE_2D1B_INTERNAL.h"

// 2D1B:1DF4: uint16 Roll2D6(void)
uint16 Roll2D6(void)
{
	uint16 firstDie;
	uint16 secondDie;

	do
		firstDie = (uint16)(byte)GeneratePseudoRandomByte()
			& BATTLETECH_D6_CANDIDATE_MASK;
	while (firstDie == 0x00 || firstDie > BATTLETECH_D6_FACE_COUNT);

	do
		secondDie = (uint16)(byte)GeneratePseudoRandomByte()
			& BATTLETECH_D6_CANDIDATE_MASK;
	while (secondDie == 0x00 || secondDie > BATTLETECH_D6_FACE_COUNT);

	return firstDie + secondDie;
}

