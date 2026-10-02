#include "REVENGE.h"
#include "revenge/original_data.h"

#include <assert.h>

static word16 resizeResult;
static word16 resizeCalls;
static word16 resizedSegment;
static word16 resizedParagraphs;

word16 DOS_ResizeMemoryBlock(word16 memorySegment, word16 paragraphCount)
{
	++resizeCalls;
	resizedSegment = memorySegment;
	resizedParagraphs = paragraphCount;
	return resizeResult;
}

void *AddSignedOffsetToFarPointer(
	const void *pointer, int32 displacement)
{
	uint32 address = HostFarPointer_Encode(pointer);
	uint32 linear = ((uint32) HIGH_WORD(address) << 0x04) + LOW_WORD(address);

	linear = (uint32) ((int32) linear + displacement);
	return FAR_POINTER(void, (word16) (linear >> 0x04), (word16) (linear & 0x0F));
}

int16 CompareNormalizedFarPointers(
	const void *left, const void *right)
{
	uint32 leftAddress = HostFarPointer_Encode(left);
	uint32 rightAddress = HostFarPointer_Encode(right);
	uint32 leftLinear = ((uint32) HIGH_WORD(leftAddress) << 0x04) +
		LOW_WORD(leftAddress);
	uint32 rightLinear = ((uint32) HIGH_WORD(rightAddress) << 0x04) +
		LOW_WORD(rightAddress);

	return leftLinear < rightLinear ? -0x01 : leftLinear > rightLinear;
}

static void ResetProgramBreak(void)
{
	MemoryBlockSegment = 0x1000;
	MinimumProgramBreakSegment = 0x1100;
	MinimumProgramBreakOffset = 0x0000;
	CurrentProgramBreakSegment = 0x1200;
	CurrentProgramBreakOffset = 0x0000;
	MaximumProgramBreakSegment = 0x1800;
	MaximumProgramBreakOffset = 0x0000;
	ProgramBreakKilobytes = 0x0008;
	resizeResult = 0xFFFF;
	resizeCalls = 0x0000;
	resizedSegment = 0x0000;
	resizedParagraphs = 0x0000;
}

int main(void)
{
	void *oldBreak;

	ResetProgramBreak();
	assert(ResizeProgramBreak(FAR_POINTER(void, 0x11F0, 0x0004)) == TRUE);
	assert(resizeCalls == 0x0000);
	assert(CurrentProgramBreakSegment == 0x11F0);
	assert(CurrentProgramBreakOffset == 0x0004);

	ResetProgramBreak();
	assert(ResizeProgramBreak(FAR_POINTER(void, 0x1300, 0x0000)) == TRUE);
	assert(resizeCalls == 0x0001);
	assert(resizedSegment == 0x1000);
	assert(resizedParagraphs == 0x0340);
	assert(ProgramBreakKilobytes == 0x000D);

	ResetProgramBreak();
	MaximumProgramBreakSegment = 0x1210;
	assert(ResizeProgramBreak(FAR_POINTER(void, 0x1300, 0x0000)) == TRUE);
	assert(resizedParagraphs == 0x0210);

	ResetProgramBreak();
	resizeResult = 0x0123;
	assert(ResizeProgramBreak(FAR_POINTER(void, 0x1300, 0x0000)) == FALSE);
	assert(MaximumProgramBreakSegment == 0x1123);
	assert(MaximumProgramBreakOffset == 0x0000);

	ResetProgramBreak();
	assert(SetProgramBreak(FAR_POINTER(void, 0x10FF, 0x0000)) == -0x01);
	assert(SetProgramBreak(FAR_POINTER(void, 0x1801, 0x0000)) == -0x01);
	assert(resizeCalls == 0x0000);

	ResetProgramBreak();
	oldBreak = AdjustProgramBreak(0x0020);
	assert(FAR_SEGMENT(oldBreak) == 0x1200);
	assert(FAR_OFFSET(oldBreak) == 0x0000);
	assert(CurrentProgramBreakSegment == 0x1202);
	assert(CurrentProgramBreakOffset == 0x0000);

	ResetProgramBreak();
	oldBreak = AdjustProgramBreak(-0x1001);
	assert(FAR_SEGMENT(oldBreak) == 0xFFFF);
	assert(FAR_OFFSET(oldBreak) == 0xFFFF);

	return 0;
}
