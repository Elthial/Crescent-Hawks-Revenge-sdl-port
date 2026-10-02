// Reconstructed original available far-heap byte query (segment 398B).

#include "REVENGE.h"
#include "revenge/original_data.h"

// 398B:000F: uint32 GetAvailableHeapBytes(void)
// Called from:
//      PrintAllocationErrorAndExit
//      InitializeGame
uint32 GetAvailableHeapBytes(void)
{
	// V: Return the Borland runtime heap's currently available byte count in
	// DX:AX, minus its eight-byte allocation overhead.
	uint32 heapBytes = CalculateFarPointerByteDistance(
		MaximumProgramBreakOffset,
		CurrentProgramBreakSegment,
		MaximumProgramBreakSegment,
		CurrentProgramBreakOffset);
	return heapBytes - 0x08;
}

