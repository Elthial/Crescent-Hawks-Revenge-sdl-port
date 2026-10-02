#include "REVENGE.h"
#include "revenge/original_data.h"

#include <assert.h>
#include <string.h>

static byte arena[0x0400];
static uint32 arenaBase;
static uint32 breakAddress;

void SetVideoModeForAdapter(word16 adapterOrRestoreSlot)
{
	(void) adapterOrRestoreSlot;
}

void DOS_PrintString(const char *text)
{
	(void) text;
}

char *LongToString(
	int32 value,
	char *destination,
	uint16 radix)
{
	(void) value;
	(void) radix;
	*destination = '\0';
	return destination;
}

uint32 GetAvailableHeapBytes(void)
{
	return 0x00000000UL;
}

int16 ReadTranslatedKeypress(void)
{
	return 0x0000;
}

void ShutdownGame(void)
{
}

void RunExitHandlersAndTerminate(word16 exitCode)
{
	(void) exitCode;
}

static uint32 LinearAddress(const void *pointer)
{
	uint32 address = HostFarPointer_Encode(pointer);
	return ((uint32) HIGH_WORD(address) << 0x04) + LOW_WORD(address);
}

void *AddSignedOffsetToFarPointer(
	const void *pointer, int32 displacement)
{
	uint32 linear = (uint32) ((int32) LinearAddress(pointer) + displacement);
	return FAR_POINTER(void, (word16) (linear >> 0x04), (word16) (linear & 0x0F));
}

int16 CompareNormalizedFarPointers(
	const void *left, const void *right)
{
	uint32 leftLinear = LinearAddress(left);
	uint32 rightLinear = LinearAddress(right);
	return leftLinear < rightLinear ? -0x01 : leftLinear > rightLinear;
}

void *AdjustProgramBreak(int32 increment)
{
	uint32 oldBreak = breakAddress;
	uint32 newLinear = LinearAddress(
		AddSignedOffsetToFarPointer(HostFarPointer_Resolve(breakAddress), increment));
	uint32 baseLinear = LinearAddress(HostFarPointer_Resolve(arenaBase));

	if (newLinear < baseLinear || newLinear > baseLinear + sizeof(arena))
		return FAR_POINTER(void, 0xFFFF, 0xFFFF);

	breakAddress = HostFarPointer_Encode(
		AddSignedOffsetToFarPointer(HostFarPointer_Resolve(arenaBase),
			(int32) (newLinear - baseLinear)));
	return HostFarPointer_Resolve(oldBreak);
}

int16 SetProgramBreak(void *newBreak)
{
	breakAddress = HostFarPointer_Encode(newBreak);
	return 0x0000;
}

int main(void)
{
	byte *first;
	byte *second;
	byte *reused;
	byte *aligned;

	memset(arena, 0x00, sizeof(arena));
	arenaBase = HostFarPointer_RegisterAt(arena, sizeof(arena),
		MAKE_FAR_POINTER(0x2000, 0x0000));
	breakAddress = arenaBase;

	first = AllocateFarHeapBytes(0x000A);
	second = AllocateFarHeapBytes16(0x0018);
	assert(first == arena + 0x0008);
	assert(second == arena + 0x0028);
	assert(FarHeapArenaBaseSegment == 0x2000);
	assert(FarHeapTailBlockOffset == 0x0000);
	assert(FarHeapTailBlockSegment == 0x2002);

	FreeFarHeapAllocation(first);
	assert(FarHeapFreeListHeadOffset == 0x0000);
	assert(FarHeapFreeListHeadSegment == 0x2000);

	reused = AllocateFarHeapBytes(0x0008);
	assert(reused == arena + 0x0018);
	assert(FarHeapFreeListHeadOffset == 0x0000);
	assert(FarHeapFreeListHeadSegment == 0x2000);

	FreeHeapBlock(second);
	assert(FarHeapTailBlockOffset == 0x0000);
	assert(FarHeapTailBlockSegment == 0x2001);
	FreeHeapBlock(reused);
	assert(FarHeapArenaBaseOffset == 0x0000);
	assert(FarHeapArenaBaseSegment == 0x0000);
	assert(FarHeapTailBlockOffset == 0x0000);
	assert(FarHeapTailBlockSegment == 0x0000);

	aligned = AllocateParagraphAlignedMemory(0x0035);
	assert(aligned == arena + 0x0010);
	assert(FAR_OFFSET(aligned) == 0x0000);
	assert(arena[0x000F] == 0x08);
	FreeParagraphAlignedMemory(aligned);
	assert(FarHeapArenaBaseSegment == 0x0000);

	first = AllocateFarMemory(0x0020);
	assert(first == arena + 0x0008);
	FreeFarMemory(first);
	assert(FarHeapArenaBaseSegment == 0x0000);

	HostFarPointer_Reset();
	return 0;
}
