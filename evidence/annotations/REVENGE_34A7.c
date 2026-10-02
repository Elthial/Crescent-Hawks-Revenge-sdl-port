// REVENGE_34A7.c
// DOS critical-error handler installation.

#include "REVENGE.h"

// 34A7:0059: retain the application callback and install the resident INT 24h
// assembly dispatcher at 34A7:0021. The dispatcher preserves all registers,
// switches to the game DS and invokes the retained callback.
void InstallCriticalErrorHandler_0059(void __far *criticalErrorCallback)
{
	struct Eq_20338 *cs;
	seg3A6A->CriticalErrorCallbackOffset_B888 =
		LOW_WORD(criticalErrorCallback);
	seg3A6A->CriticalErrorCallbackSegment_B88A =
		(struct Eq_20337 *)FAR_SEGMENT(criticalErrorCallback);
	DOS_SetInterruptVector(0x24, (char *)cs + 0x21);
}

// 34A7:0014: install the executable's default INT 24h callback at CS:0006.
// Called from InitializeGame_003C.
void InstallDefaultCriticalErrorHandler_0014(void)
{
	struct Eq_20329 *cs;
	InstallCriticalErrorHandler_0059((char *)cs + 0x06);
}
