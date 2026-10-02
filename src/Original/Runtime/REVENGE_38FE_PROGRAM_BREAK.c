// REVENGE_38FE_PROGRAM_BREAK.c
// Reconstructed original Borland program-break runtime (segment 38FE).

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

#define GetMinimumProgramBreak ProgramBreakBridge_GetMinimum
#define GetCurrentProgramBreak ProgramBreakBridge_GetCurrent
#define SetCurrentProgramBreak ProgramBreakBridge_SetCurrent
#define GetMaximumProgramBreak ProgramBreakBridge_GetMaximum
#define SetMaximumProgramBreak ProgramBreakBridge_SetMaximum

// 38FE:0002: resize the owning DOS block and record the exact logical break.
word16 ResizeProgramBreak(void *newBreak)
{
	word16 memoryBlockSegment = MemoryBlockSegment;
	word16 requiredParagraphs = FAR_SEGMENT(newBreak) + 0x01 - memoryBlockSegment;
	word16 requiredKilobytes = (requiredParagraphs + 0x3F) >> 0x06;
	word16 roundedParagraphs;
	word16 resizeResult;

	if (requiredKilobytes == ProgramBreakKilobytes)
	{
		SetCurrentProgramBreak(newBreak);
		return TRUE;
	}

	roundedParagraphs = requiredKilobytes << 0x06;
	if (memoryBlockSegment + roundedParagraphs > FAR_SEGMENT(GetMaximumProgramBreak()))
		roundedParagraphs = FAR_SEGMENT(GetMaximumProgramBreak()) - memoryBlockSegment;

	// This wrapper returns FFFFh on success. On failure it returns DOS's
	// maximum available paragraph count from BX.
	resizeResult = DOS_ResizeMemoryBlock(memoryBlockSegment, roundedParagraphs);
	if (resizeResult == 0xFFFF)
	{
		ProgramBreakKilobytes = roundedParagraphs >> 0x06;
		SetCurrentProgramBreak(newBreak);
		return TRUE;
	}

	SetMaximumProgramBreak(FAR_POINTER(
		void, memoryBlockSegment + resizeResult, 0x00));
	return FALSE;
}

// 38FE:0092: Borland brk-style setter. Returns 0 on success and -1 on error.
int16 SetProgramBreak(void *newBreak)
{
	if (CompareNormalizedFarPointers(newBreak, GetMinimumProgramBreak()) < 0 ||
		CompareNormalizedFarPointers(newBreak, GetMaximumProgramBreak()) > 0 ||
		!ResizeProgramBreak(newBreak))
		return -0x01;

	return 0x00;
}

// 38FE:00D9: Borland sbrk-style allocator. Return the old break and advance
// it by increment; FFFF:FFFF reports an invalid range or DOS resize failure.
void *AdjustProgramBreak(int32 increment)
{
	word16 oldBreakSegment = CurrentProgramBreakSegment;
	word16 oldBreakOffset = CurrentProgramBreakOffset;
	void *oldBreak = GetCurrentProgramBreak();
	void *newBreak = AddSignedOffsetToFarPointer(oldBreak, increment);

	if (CompareNormalizedFarPointers(newBreak, GetMinimumProgramBreak()) < 0 ||
		CompareNormalizedFarPointers(newBreak, GetMaximumProgramBreak()) > 0 ||
		!ResizeProgramBreak(newBreak))
		return FAR_POINTER(void, 0xFFFF, 0xFFFF);

	/* A successful native resize may establish or move the host backing block.
	 * Resolve the unchanged original 16:16 value after that lowest-level call. */
	return FAR_POINTER(void, oldBreakSegment, oldBreakOffset);
}
