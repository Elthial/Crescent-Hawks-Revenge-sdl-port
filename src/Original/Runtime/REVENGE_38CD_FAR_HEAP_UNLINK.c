// REVENGE_38CD_FAR_HEAP_UNLINK.c
// Reconstructed original Borland far-heap allocator (segment 38CD).

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

#define ResolveBlock FarHeapBridge_ResolveBlock
#define EncodeBlock FarHeapBridge_EncodeBlock
#define GetFarHeapArenaBase FarHeapBridge_GetArenaBase
#define SetFarHeapArenaBase FarHeapBridge_SetArenaBase
#define GetFarHeapTailBlock FarHeapBridge_GetTailBlock
#define SetFarHeapTailBlock FarHeapBridge_SetTailBlock
#define GetFarHeapFreeListHead FarHeapBridge_GetFreeListHead
#define SetFarHeapFreeListHead FarHeapBridge_SetFreeListHead
#define FarHeapPayload FarHeapBridge_GetPayload

byte *AllocateFarHeapBytes(uint32 byteCount);

// 38CD:0002
byte *AllocateFarHeapBytes16(word16 byteCount)
{
	return AllocateFarHeapBytes((uint32) byteCount);
}

// 38CD:0017: remove a block from the circular free list.
void UnlinkFarHeapFreeBlock(FarHeapBlockHeader *blockHeader)
{
	FarHeapBlockHeader *newHead = ResolveBlock(blockHeader->nextFree);
	SetFarHeapFreeListHead(newHead);

	if (CompareNormalizedFarPointers(newHead, blockHeader) == 0x00)
	{
		SetFarHeapFreeListHead(NULL);
		return;
	}

	newHead->previousFree = blockHeader->previousFree;
	ResolveBlock(blockHeader->previousFree)->nextFree = EncodeBlock(newHead);
}

// 38CD:007F: retain the low part as a free block and allocate from its end.
byte *SplitFarHeapFreeBlock(
	FarHeapBlockHeader *blockHeader,
	uint32 allocationSize)
{
	FarHeapBlockHeader *allocatedBlock;
	FarHeapBlockHeader *followingBlock;

	blockHeader->sizeAndAllocated -= allocationSize;
	allocatedBlock = (FarHeapBlockHeader *) AddSignedOffsetToFarPointer(
		blockHeader, blockHeader->sizeAndAllocated);
	allocatedBlock->sizeAndAllocated = allocationSize | FAR_HEAP_ALLOCATED_FLAG;
	allocatedBlock->previousPhysical = EncodeBlock(blockHeader);

	if (CompareNormalizedFarPointers(GetFarHeapTailBlock(), blockHeader) == 0x00)
		SetFarHeapTailBlock(allocatedBlock);
	else
	{
		followingBlock = (FarHeapBlockHeader *) AddSignedOffsetToFarPointer(
			allocatedBlock, allocationSize);
		followingBlock->previousPhysical = EncodeBlock(allocatedBlock);
	}

	return FarHeapPayload(allocatedBlock);
}

// 38CD:012F
byte *ExtendFarHeap(uint32 allocationSize)
{
	FarHeapBlockHeader *newBlock =
		(FarHeapBlockHeader *) AdjustProgramBreak((int32) allocationSize);

	if (FAR_SEGMENT(newBlock) == 0xFFFF && FAR_OFFSET(newBlock) == 0xFFFF)
		return NULL;

	newBlock->previousPhysical = EncodeBlock(GetFarHeapTailBlock());
	newBlock->sizeAndAllocated = allocationSize | FAR_HEAP_ALLOCATED_FLAG;
	SetFarHeapTailBlock(newBlock);
	return FarHeapPayload(newBlock);
}

// 38CD:019D
byte *InitializeFarHeap(uint32 allocationSize)
{
	FarHeapBlockHeader *firstBlock =
		(FarHeapBlockHeader *) AdjustProgramBreak((int32) allocationSize);

	if (FAR_SEGMENT(firstBlock) == 0xFFFF && FAR_OFFSET(firstBlock) == 0xFFFF)
		return NULL;

	SetFarHeapArenaBase(firstBlock);
	SetFarHeapTailBlock(firstBlock);
	firstBlock->sizeAndAllocated = allocationSize | FAR_HEAP_ALLOCATED_FLAG;
	return FarHeapPayload(firstBlock);
}

// 38CD:0203
byte *AllocateFarHeapBytes(uint32 byteCount)
{
	uint32 allocationSize;
	FarHeapBlockHeader *freeListHead;
	FarHeapBlockHeader *block;

	if (byteCount == 0x00)
		return NULL;

	allocationSize = (byteCount + 0x17) & 0xFFFFFFF0UL;
	if (GetFarHeapArenaBase() == NULL)
		return InitializeFarHeap(allocationSize);

	freeListHead = GetFarHeapFreeListHead();
	block = freeListHead;
	if (block != NULL)
	{
		do
		{
			if (block->sizeAndAllocated >= allocationSize + FAR_HEAP_MIN_SPLIT_REMAINDER)
				return SplitFarHeapFreeBlock(block, allocationSize);

			if (block->sizeAndAllocated >= allocationSize)
			{
				UnlinkFarHeapFreeBlock(block);
				block->sizeAndAllocated |= FAR_HEAP_ALLOCATED_FLAG;
				return FarHeapPayload(block);
			}

			block = ResolveBlock(block->nextFree);
		} while (CompareNormalizedFarPointers(block, freeListHead) != 0x00);
	}

	return ExtendFarHeap(allocationSize);
}
