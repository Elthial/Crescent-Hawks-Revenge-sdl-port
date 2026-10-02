// REVENGE_38FE.c
// Assembly-led translation of the Borland program-break runtime.

#include "REVENGE.h"

void __far *AddSignedOffsetToFarPointer(const void __far *pointer, int32 displacement);
int16 CompareNormalizedFarPointers(const void __far *left, const void __far *right);
word16 DOS_ResizeMemoryBlock(word16 memorySegment, word16 paragraphCount);

static void __far *GetMinimumProgramBreak(void)
{
	return (void __far *) MAKE_FAR_POINTER((word16) seg3A6A->MinimumProgramBreakSegment_ptr0089, seg3A6A->MinimumProgramBreakOffset_t0087.u0);
}

static void __far *GetCurrentProgramBreak(void)
{
	return (void __far *) MAKE_FAR_POINTER((word16) seg3A6A->CurrentProgramBreakSegment_ptr008D, seg3A6A->CurrentProgramBreakOffset_t008B.u0);
}

static void SetCurrentProgramBreak(void __far *programBreak)
{
	seg3A6A->CurrentProgramBreakSegment_ptr008D = (struct Eq_1132 *) FAR_SEGMENT(programBreak);
	seg3A6A->CurrentProgramBreakOffset_t008B.u0 = LOW_WORD(programBreak);
}

static void __far *GetMaximumProgramBreak(void)
{
	return (void __far *) MAKE_FAR_POINTER((word16) seg3A6A->MaximumProgramBreakSegment_ptr0091, seg3A6A->MaximumProgramBreakOffset_t008F.u0);
}

static void SetMaximumProgramBreak(void __far *programBreak)
{
	seg3A6A->MaximumProgramBreakSegment_ptr0091 = (struct Eq_1132 *) FAR_SEGMENT(programBreak);
	seg3A6A->MaximumProgramBreakOffset_t008F.u0 = LOW_WORD(programBreak);
}

// 38FE:0002: resize the owning DOS block and record the exact logical break.
static word16 ResizeProgramBreak_0002(void __far *newBreak)
{
	word16 memoryBlockSegment = (word16) seg3A6A->MemoryBlockSegment_ptr007B;
	word16 requiredParagraphs = FAR_SEGMENT(newBreak) + 0x01 - memoryBlockSegment;
	word16 requiredKilobytes = (requiredParagraphs + 0x3F) >> 0x06;
	word16 roundedParagraphs;
	word16 resizeResult;

	if (requiredKilobytes == seg3A6A->ProgramBreakKilobytes_w7026)
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
		seg3A6A->ProgramBreakKilobytes_w7026 = roundedParagraphs >> 0x06;
		SetCurrentProgramBreak(newBreak);
		return TRUE;
	}

	SetMaximumProgramBreak((void __far *) MAKE_FAR_POINTER(
		memoryBlockSegment + resizeResult, 0x00));
	return FALSE;
}

// 38FE:0092: Borland brk-style setter. Returns 0 on success and -1 on error.
int16 SetProgramBreak(void __far *newBreak)
{
	if (CompareNormalizedFarPointers(newBreak, GetMinimumProgramBreak()) < 0 ||
		CompareNormalizedFarPointers(newBreak, GetMaximumProgramBreak()) > 0 ||
		!ResizeProgramBreak_0002(newBreak))
		return -0x01;

	return 0x00;
}

// 38FE:00D9: Borland sbrk-style allocator. Return the old break and advance
// it by increment; FFFF:FFFF reports an invalid range or DOS resize failure.
void __far *AdjustProgramBreak(int32 increment)
{
	void __far *oldBreak = GetCurrentProgramBreak();
	void __far *newBreak = AddSignedOffsetToFarPointer(oldBreak, increment);

	if (CompareNormalizedFarPointers(newBreak, GetMinimumProgramBreak()) < 0 ||
		CompareNormalizedFarPointers(newBreak, GetMaximumProgramBreak()) > 0 ||
		!ResizeProgramBreak_0002(newBreak))
		return (void __far *) MAKE_FAR_POINTER(0xFFFF, 0xFFFF);

	return oldBreak;
}
