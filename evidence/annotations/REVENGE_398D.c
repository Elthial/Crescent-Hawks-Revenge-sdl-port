// REVENGE_398D.c
// Assembly-led translation of the Borland far-heap release path.

#include "REVENGE.h"

void __far *AddSignedOffsetToFarPointer(const void __far *pointer, int32 displacement);
int16 CompareNormalizedFarPointers(const void __far *left, const void __far *right);
int16 SetProgramBreak(void __far *newBreak);
void UnlinkFarHeapFreeBlock_0017(FarHeapBlockHeader __far *blockHeader);

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

// 398D:000C
void FreeFarHeapAllocation(byte __far *allocation);

void FreeHeapBlock(byte __far *allocation)
{
	FreeFarHeapAllocation(allocation);
}

// 398D:001E
void InsertFarHeapFreeBlock_001E(FarHeapBlockHeader __far *blockHeader)
{
	FarHeapBlockHeader __far *head = GetFarHeapFreeListHead();

	if (head == NULL)
	{
		SetFarHeapFreeListHead(blockHeader);
		blockHeader->previousFree = blockHeader;
		blockHeader->nextFree = blockHeader;
		return;
	}

	blockHeader->previousFree = head->previousFree;
	blockHeader->nextFree = head;
	head->previousFree->nextFree = blockHeader;
	head->previousFree = blockHeader;
}

// 398D:00BD
void CoalesceFarHeapSuccessor_00BD(
	FarHeapBlockHeader __far *blockHeader,
	FarHeapBlockHeader __far *successorHeader)
{
	FarHeapBlockHeader __far *followingBlock;

	blockHeader->sizeAndAllocated += successorHeader->sizeAndAllocated;
	if (CompareNormalizedFarPointers(GetFarHeapTailBlock(), successorHeader) == 0x00)
		SetFarHeapTailBlock(blockHeader);
	else
	{
		followingBlock = (FarHeapBlockHeader __far *) AddSignedOffsetToFarPointer(
			successorHeader, successorHeader->sizeAndAllocated);
		followingBlock->previousPhysical = blockHeader;
	}

	UnlinkFarHeapFreeBlock_0017(successorHeader);
}

// 398D:0135
void ReleaseFarHeapTail_0135(void)
{
	FarHeapBlockHeader __far *arenaBase = GetFarHeapArenaBase();
	FarHeapBlockHeader __far *tail = GetFarHeapTailBlock();
	FarHeapBlockHeader __far *previousBlock;

	if (CompareNormalizedFarPointers(arenaBase, tail) == 0x00)
	{
		SetProgramBreak(arenaBase);
		SetFarHeapTailBlock(NULL);
		SetFarHeapArenaBase(NULL);
		return;
	}

	previousBlock = tail->previousPhysical;
	if ((previousBlock->sizeAndAllocated & FAR_HEAP_ALLOCATED_FLAG) == 0x00)
	{
		UnlinkFarHeapFreeBlock_0017(previousBlock);
		if (CompareNormalizedFarPointers(previousBlock, arenaBase) == 0x00)
		{
			SetFarHeapTailBlock(NULL);
			SetFarHeapArenaBase(NULL);
		}
		else
			SetFarHeapTailBlock(previousBlock->previousPhysical);

		SetProgramBreak(previousBlock);
	}
	else
	{
		SetProgramBreak(tail);
		SetFarHeapTailBlock(previousBlock);
	}
}

// 398D:021A
void FreeAndCoalesceFarHeapBlock_021A(FarHeapBlockHeader __far *blockHeader)
{
	FarHeapBlockHeader __far *successorHeader;
	FarHeapBlockHeader __far *previousHeader;

	blockHeader->sizeAndAllocated &= ~FAR_HEAP_ALLOCATED_FLAG;
	successorHeader = (FarHeapBlockHeader __far *) AddSignedOffsetToFarPointer(
		blockHeader, blockHeader->sizeAndAllocated);
	previousHeader = blockHeader->previousPhysical;

	if ((previousHeader->sizeAndAllocated & FAR_HEAP_ALLOCATED_FLAG) == 0x00 &&
		CompareNormalizedFarPointers(blockHeader, GetFarHeapArenaBase()) != 0x00)
	{
		previousHeader->sizeAndAllocated += blockHeader->sizeAndAllocated;
		successorHeader->previousPhysical = previousHeader;
		blockHeader = previousHeader;
	}
	else
		InsertFarHeapFreeBlock_001E(blockHeader);

	if ((successorHeader->sizeAndAllocated & FAR_HEAP_ALLOCATED_FLAG) == 0x00)
		CoalesceFarHeapSuccessor_00BD(blockHeader, successorHeader);
}

// 398D:02E6
void FreeFarHeapAllocation(byte __far *allocation)
{
	FarHeapBlockHeader __far *blockHeader;

	if (allocation == NULL)
		return;

	blockHeader = (FarHeapBlockHeader __far *) AddSignedOffsetToFarPointer(
		allocation, -FAR_HEAP_PAYLOAD_OFFSET);
	if (CompareNormalizedFarPointers(blockHeader, GetFarHeapTailBlock()) == 0x00)
		ReleaseFarHeapTail_0135();
	else
		FreeAndCoalesceFarHeapBlock_021A(blockHeader);
}
