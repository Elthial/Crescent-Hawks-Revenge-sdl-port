// REVENGE_398D_FAR_HEAP.c
// Reconstructed original Borland far-heap release path (segment 398D).

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

void UnlinkFarHeapFreeBlock(FarHeapBlockHeader *blockHeader);

#define ResolveBlock FarHeapBridge_ResolveBlock
#define EncodeBlock FarHeapBridge_EncodeBlock
#define GetFarHeapArenaBase FarHeapBridge_GetArenaBase
#define SetFarHeapArenaBase FarHeapBridge_SetArenaBase
#define GetFarHeapTailBlock FarHeapBridge_GetTailBlock
#define SetFarHeapTailBlock FarHeapBridge_SetTailBlock
#define GetFarHeapFreeListHead FarHeapBridge_GetFreeListHead
#define SetFarHeapFreeListHead FarHeapBridge_SetFreeListHead

// 398D:000C
void FreeFarHeapAllocation(byte *allocation);

void FreeHeapBlock(byte *allocation)
{
	FreeFarHeapAllocation(allocation);
}

// 398D:001E
void InsertFarHeapFreeBlock(FarHeapBlockHeader *blockHeader)
{
	FarHeapBlockHeader *head = GetFarHeapFreeListHead();

	if (head == NULL)
	{
		SetFarHeapFreeListHead(blockHeader);
		blockHeader->previousFree = EncodeBlock(blockHeader);
		blockHeader->nextFree = EncodeBlock(blockHeader);
		return;
	}

	blockHeader->previousFree = head->previousFree;
	blockHeader->nextFree = EncodeBlock(head);
	ResolveBlock(head->previousFree)->nextFree = EncodeBlock(blockHeader);
	head->previousFree = EncodeBlock(blockHeader);
}

// 398D:00BD
void CoalesceFarHeapSuccessor(
	FarHeapBlockHeader *blockHeader,
	FarHeapBlockHeader *successorHeader)
{
	FarHeapBlockHeader *followingBlock;

	blockHeader->sizeAndAllocated += successorHeader->sizeAndAllocated;
	if (CompareNormalizedFarPointers(GetFarHeapTailBlock(), successorHeader) == 0x00)
		SetFarHeapTailBlock(blockHeader);
	else
	{
		followingBlock = (FarHeapBlockHeader *) AddSignedOffsetToFarPointer(
			successorHeader, successorHeader->sizeAndAllocated);
		followingBlock->previousPhysical = EncodeBlock(blockHeader);
	}

	UnlinkFarHeapFreeBlock(successorHeader);
}

// 398D:0135
void ReleaseFarHeapTail(void)
{
	FarHeapBlockHeader *arenaBase = GetFarHeapArenaBase();
	FarHeapBlockHeader *tail = GetFarHeapTailBlock();
	FarHeapBlockHeader *previousBlock;

	if (CompareNormalizedFarPointers(arenaBase, tail) == 0x00)
	{
		SetProgramBreak(arenaBase);
		SetFarHeapTailBlock(NULL);
		SetFarHeapArenaBase(NULL);
		return;
	}

	previousBlock = ResolveBlock(tail->previousPhysical);
	if ((previousBlock->sizeAndAllocated & FAR_HEAP_ALLOCATED_FLAG) == 0x00)
	{
		UnlinkFarHeapFreeBlock(previousBlock);
		if (CompareNormalizedFarPointers(previousBlock, arenaBase) == 0x00)
		{
			SetFarHeapTailBlock(NULL);
			SetFarHeapArenaBase(NULL);
		}
		else
			SetFarHeapTailBlock(ResolveBlock(previousBlock->previousPhysical));

		SetProgramBreak(previousBlock);
	}
	else
	{
		SetProgramBreak(tail);
		SetFarHeapTailBlock(previousBlock);
	}
}

// 398D:021A
void FreeAndCoalesceFarHeapBlock(FarHeapBlockHeader *blockHeader)
{
	FarHeapBlockHeader *successorHeader;
	FarHeapBlockHeader *previousHeader;

	blockHeader->sizeAndAllocated &= ~FAR_HEAP_ALLOCATED_FLAG;
	successorHeader = (FarHeapBlockHeader *) AddSignedOffsetToFarPointer(
		blockHeader, blockHeader->sizeAndAllocated);
	previousHeader = ResolveBlock(blockHeader->previousPhysical);

	if (CompareNormalizedFarPointers(blockHeader, GetFarHeapArenaBase()) != 0x00 &&
		(previousHeader->sizeAndAllocated & FAR_HEAP_ALLOCATED_FLAG) == 0x00)
	{
		previousHeader->sizeAndAllocated += blockHeader->sizeAndAllocated;
		successorHeader->previousPhysical = EncodeBlock(previousHeader);
		blockHeader = previousHeader;
	}
	else
		InsertFarHeapFreeBlock(blockHeader);

	if ((successorHeader->sizeAndAllocated & FAR_HEAP_ALLOCATED_FLAG) == 0x00)
		CoalesceFarHeapSuccessor(blockHeader, successorHeader);
}

// 398D:02E6
void FreeFarHeapAllocation(byte *allocation)
{
	FarHeapBlockHeader *blockHeader;

	if (allocation == NULL)
		return;

	blockHeader = (FarHeapBlockHeader *) AddSignedOffsetToFarPointer(
		allocation, -FAR_HEAP_PAYLOAD_OFFSET);
	if (CompareNormalizedFarPointers(blockHeader, GetFarHeapTailBlock()) == 0x00)
		ReleaseFarHeapTail();
	else
		FreeAndCoalesceFarHeapBlock(blockHeader);
}
