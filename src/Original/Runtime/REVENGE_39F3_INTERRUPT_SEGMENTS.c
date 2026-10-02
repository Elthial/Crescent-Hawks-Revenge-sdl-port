// Reconstructed interrupt segment-state snapshot (segment 39F3).

#include "REVENGE.h"
#include "revenge/interrupts.h"

// 39F3:0000
void CaptureInterruptSegmentState(
	InterruptSegmentState *segmentState)
{
	/* A flat host has no observable ES, CS, SS, or DS values. */
	segmentState->es = 0x0000;
	segmentState->cs = 0x0000;
	segmentState->ss = 0x0000;
	segmentState->ds = 0x0000;
}
