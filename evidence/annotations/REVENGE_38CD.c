// REVENGE_38CD.c
// Assembly-led translation of the Borland far-heap allocator.

#include "REVENGE.h"

void __far *AddSignedOffsetToFarPointer(const void __far *pointer, int32 displacement);
int16 CompareNormalizedFarPointers(const void __far *left, const void __far *right);
void __far *AdjustProgramBreak(int32 increment);

static FarHeapBlockHeader __far *GetFarHeapArenaBase(void)
{
	return FAR_POINTER(
		FarHeapBlockHeader,
		seg3A6A->FarHeapArenaBaseSegment_701C,
		seg3A6A->FarHeapArenaBaseOffset_701A);
}

static void SetFarHeapArenaBase(FarHeapBlockHeader __far *arenaBase)
{
	seg3A6A->FarHeapArenaBaseSegment_701C = FAR_SEGMENT(arenaBase);
	seg3A6A->FarHeapArenaBaseOffset_701A = LOW_WORD(arenaBase);
}

static FarHeapBlockHeader __far *GetFarHeapTailBlock(void)
{
	return FAR_POINTER(
		FarHeapBlockHeader,
		seg3A6A->FarHeapTailBlockSegment_7020,
		seg3A6A->FarHeapTailBlockOffset_701E);
}

static void SetFarHeapTailBlock(FarHeapBlockHeader __far *tailBlock)
{
	seg3A6A->FarHeapTailBlockSegment_7020 = FAR_SEGMENT(tailBlock);
	seg3A6A->FarHeapTailBlockOffset_701E = LOW_WORD(tailBlock);
}

static FarHeapBlockHeader __far *GetFarHeapFreeListHead(void)
{
	return FAR_POINTER(
		FarHeapBlockHeader,
		seg3A6A->FarHeapFreeListHeadSegment_7024,
		seg3A6A->FarHeapFreeListHeadOffset_7022);
}

static void SetFarHeapFreeListHead(FarHeapBlockHeader __far *freeListHead)
{
	seg3A6A->FarHeapFreeListHeadSegment_7024 = FAR_SEGMENT(freeListHead);
	seg3A6A->FarHeapFreeListHeadOffset_7022 = LOW_WORD(freeListHead);
}

static byte __far *FarHeapPayload(FarHeapBlockHeader __far *block)
{
	return (byte __far *) AddSignedOffsetToFarPointer(block, FAR_HEAP_PAYLOAD_OFFSET);
}

byte __far *AllocateFarHeapBytes(uint32 byteCount);

// 38CD:0002
byte __far *AllocateFarHeapBytes16(word16 byteCount)
{
	return AllocateFarHeapBytes((uint32) byteCount);
}

// 38CD:0017: remove a block from the circular free list.
void UnlinkFarHeapFreeBlock_0017(FarHeapBlockHeader __far *blockHeader)
{
	FarHeapBlockHeader __far *newHead = blockHeader->nextFree;
	SetFarHeapFreeListHead(newHead);

	if (CompareNormalizedFarPointers(newHead, blockHeader) == 0x00)
	{
		SetFarHeapFreeListHead(NULL);
		return;
	}

	newHead->previousFree = blockHeader->previousFree;
	blockHeader->previousFree->nextFree = newHead;
}

// 38CD:007F: retain the low part as a free block and allocate from its end.
byte __far *SplitFarHeapFreeBlock_007F(
	FarHeapBlockHeader __far *blockHeader,
	uint32 allocationSize)
{
	FarHeapBlockHeader __far *allocatedBlock;
	FarHeapBlockHeader __far *followingBlock;

	blockHeader->sizeAndAllocated -= allocationSize;
	allocatedBlock = (FarHeapBlockHeader __far *) AddSignedOffsetToFarPointer(
		blockHeader, blockHeader->sizeAndAllocated);
	allocatedBlock->sizeAndAllocated = allocationSize | FAR_HEAP_ALLOCATED_FLAG;
	allocatedBlock->previousPhysical = blockHeader;

	if (CompareNormalizedFarPointers(GetFarHeapTailBlock(), blockHeader) == 0x00)
		SetFarHeapTailBlock(allocatedBlock);
	else
	{
		followingBlock = (FarHeapBlockHeader __far *) AddSignedOffsetToFarPointer(
			allocatedBlock, allocationSize);
		followingBlock->previousPhysical = allocatedBlock;
	}

	return FarHeapPayload(allocatedBlock);
}

// 38CD:012F
byte __far *ExtendFarHeap_012F(uint32 allocationSize)
{
	FarHeapBlockHeader __far *newBlock =
		(FarHeapBlockHeader __far *) AdjustProgramBreak((int32) allocationSize);

	if (newBlock == (FarHeapBlockHeader __far *) MAKE_FAR_POINTER(0xFFFF, 0xFFFF))
		return NULL;

	newBlock->previousPhysical = GetFarHeapTailBlock();
	newBlock->sizeAndAllocated = allocationSize | FAR_HEAP_ALLOCATED_FLAG;
	SetFarHeapTailBlock(newBlock);
	return FarHeapPayload(newBlock);
}

// 38CD:019D
byte __far *InitializeFarHeap_019D(uint32 allocationSize)
{
	FarHeapBlockHeader __far *firstBlock =
		(FarHeapBlockHeader __far *) AdjustProgramBreak((int32) allocationSize);

	if (firstBlock == (FarHeapBlockHeader __far *) MAKE_FAR_POINTER(0xFFFF, 0xFFFF))
		return NULL;

	SetFarHeapArenaBase(firstBlock);
	SetFarHeapTailBlock(firstBlock);
	firstBlock->sizeAndAllocated = allocationSize | FAR_HEAP_ALLOCATED_FLAG;
	return FarHeapPayload(firstBlock);
}

// 38CD:0203
byte __far *AllocateFarHeapBytes(uint32 byteCount)
{
	uint32 allocationSize;
	FarHeapBlockHeader __far *freeListHead;
	FarHeapBlockHeader __far *block;

	if (byteCount == 0x00)
		return NULL;

	allocationSize = (byteCount + 0x17) & 0xFFFFFFF0UL;
	if (GetFarHeapArenaBase() == NULL)
		return InitializeFarHeap_019D(allocationSize);

	freeListHead = GetFarHeapFreeListHead();
	block = freeListHead;
	if (block != NULL)
	{
		do
		{
			if (block->sizeAndAllocated >= allocationSize + FAR_HEAP_MIN_SPLIT_REMAINDER)
				return SplitFarHeapFreeBlock_007F(block, allocationSize);

			if (block->sizeAndAllocated >= allocationSize)
			{
				UnlinkFarHeapFreeBlock_0017(block);
				block->sizeAndAllocated |= FAR_HEAP_ALLOCATED_FLAG;
				return FarHeapPayload(block);
			}

			block = block->nextFree;
		} while (CompareNormalizedFarPointers(block, freeListHead) != 0x00);
	}

	return ExtendFarHeap_012F(allocationSize);
}
