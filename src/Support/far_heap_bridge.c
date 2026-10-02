#include "../Original/REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

struct FarHeapBlockHeader *FarHeapBridge_ResolveBlock(uint32 address)
{
	return (FarHeapBlockHeader *) HostFarPointer_Resolve(address);
}

uint32 FarHeapBridge_EncodeBlock(const struct FarHeapBlockHeader *block)
{
	return block == NULL ? 0x00000000UL : HostFarPointer_Encode(block);
}

struct FarHeapBlockHeader *FarHeapBridge_GetArenaBase(void)
{
	return FAR_POINTER(FarHeapBlockHeader,
		FarHeapArenaBaseSegment, FarHeapArenaBaseOffset);
}

void FarHeapBridge_SetArenaBase(struct FarHeapBlockHeader *arenaBase)
{
	FarHeapArenaBaseSegment =
		arenaBase == NULL ? 0x0000 : FAR_SEGMENT(arenaBase);
	FarHeapArenaBaseOffset =
		arenaBase == NULL ? 0x0000 : FAR_OFFSET(arenaBase);
}

struct FarHeapBlockHeader *FarHeapBridge_GetTailBlock(void)
{
	return FAR_POINTER(FarHeapBlockHeader,
		FarHeapTailBlockSegment, FarHeapTailBlockOffset);
}

void FarHeapBridge_SetTailBlock(struct FarHeapBlockHeader *tailBlock)
{
	FarHeapTailBlockSegment =
		tailBlock == NULL ? 0x0000 : FAR_SEGMENT(tailBlock);
	FarHeapTailBlockOffset =
		tailBlock == NULL ? 0x0000 : FAR_OFFSET(tailBlock);
}

struct FarHeapBlockHeader *FarHeapBridge_GetFreeListHead(void)
{
	return FAR_POINTER(FarHeapBlockHeader,
		FarHeapFreeListHeadSegment, FarHeapFreeListHeadOffset);
}

void FarHeapBridge_SetFreeListHead(struct FarHeapBlockHeader *freeListHead)
{
	FarHeapFreeListHeadSegment =
		freeListHead == NULL ? 0x0000 : FAR_SEGMENT(freeListHead);
	FarHeapFreeListHeadOffset =
		freeListHead == NULL ? 0x0000 : FAR_OFFSET(freeListHead);
}

byte *FarHeapBridge_GetPayload(struct FarHeapBlockHeader *block)
{
	return (byte *) AddSignedOffsetToFarPointer(
		block, FAR_HEAP_PAYLOAD_OFFSET);
}
