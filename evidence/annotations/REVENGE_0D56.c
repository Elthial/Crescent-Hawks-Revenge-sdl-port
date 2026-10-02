// REVENGE_0D56.c
// Annotated reconstruction of REVENGE.EXE segment 0D56.

#include "REVENGE.h"

// 0D56:0007: void PrintAllocationErrorAndExit(const char __far *message)
// Called from:
//      AllocateFarMemory
//      AllocateParagraphAlignedMemory
void PrintAllocationErrorAndExit(const char __far *message)
{
	char numberText[0x14];

	// V: The assembly switches to text-capable adapter mode 06h, reports the
	// failed request and remaining heap, waits for input, shuts the game down,
	// and terminates with exit status 1. This routine does not return.
	SetVideoModeForAdapter_0350(0x06);
	DOS_PrintString(message);
	DOS_PrintString("Unable to allocate "); // TEXT DS:232B
	LongToString(
		(int32) MAKE_DWORD(
			FailedAllocationSizeHigh_B5DE,
			FailedAllocationSizeLow_B5DC),
		numberText,
		0x0A);
	DOS_PrintString(numberText);
	DOS_PrintString(" bytes.\r\n"); // TEXT DS:233F
	DOS_PrintString("Only "); // TEXT DS:2349

	uint32 availableHeapBytes = GetAvailableHeapBytes();
	LongToString((int32) availableHeapBytes, numberText, 0x0A);
	DOS_PrintString(numberText);
	DOS_PrintString(" bytes free.\r\n"); // TEXT DS:234F
	ReadTranslatedKeypress_045C();
	ShutdownGame_02E3();
	RunExitHandlersAndTerminate_0010(0x01);
}

// 0D56:00B5: byte __far *AllocateFarMemory(int32 byteCount)
// V: Rejects requests that cannot be represented by the underlying 16-bit
// far-heap allocator, then returns its normalized segment:offset pointer.
// Allocation failure is fatal and is reported by PrintAllocationErrorAndExit.
byte __far *AllocateFarMemory(int32 byteCount)
{
	byte __far *allocation;

	// V: The signed high-word comparisons at 00BFh-00CBh are Borland's
	// long-integer implementation of byteCount > 0000FFFFh.
	if (byteCount > 0x0000FFFFL)
	{
		PrintAllocationErrorAndExit("Allocation too big!"); // TEXT DS:235E
		return 0x00; // Unreachable: the error routine terminates the process.
	}

	allocation = AllocateFarHeapBytes16(LOW_WORD(byteCount));
	if (allocation != 0x00)
		return allocation;

	FailedAllocationSizeLow_B5DC = LOW_WORD(byteCount);
	FailedAllocationSizeHigh_B5DE = 0x00;
	PrintAllocationErrorAndExit("allocation/resident-program error"); // TEXT DS:22DC
	return 0x00; // Unreachable.
}

// 0D56:0112: byte __far *AllocateParagraphAlignedMemory(uint32 byteCount)
// V: Over-allocates by one paragraph, advances the returned address to the
// next paragraph boundary, and stores the adjustment byte immediately before
// the aligned address so FreeParagraphAlignedMemory can recover the raw
// heap pointer.
byte __far *AllocateParagraphAlignedMemory(uint32 byteCount)
{
	uint32 allocationSize;
	byte __far *rawAllocation;
	word16 rawOffset;
	word16 rawSegment;
	uint16 alignmentAdjustment;

	allocationSize = byteCount + 0x10;
	rawAllocation = AllocateFarHeapBytes(allocationSize);
	if (rawAllocation == 0x00)
	{
		FailedAllocationSizeLow_B5DC = LOW_WORD(allocationSize);
		FailedAllocationSizeHigh_B5DE = HIGH_WORD(allocationSize);
		PrintAllocationErrorAndExit("allocation/resident-program error"); // TEXT DS:22DC
		return 0x00; // Unreachable.
	}

	rawOffset = FAR_OFFSET(rawAllocation);
	rawSegment = FAR_SEGMENT(rawAllocation);
	alignmentAdjustment = 0x10 - rawOffset;
	rawAllocation[alignmentAdjustment - 0x01] = (byte) alignmentAdjustment;
	return FAR_POINTER(byte, rawSegment + 0x01, 0x00);
}

// 0D56:0181: void FreeFarMemory(byte __far *allocation)
void FreeFarMemory(byte __far *allocation)
{
	// V: The source clears only its private stack copy after freeing. It does
	// not clear the caller's pointer and has no register-based output values.
	if (allocation != 0x00)
		FreeHeapBlock(allocation);
}

// 0D56:01A5: void FreeParagraphAlignedMemory(byte __far *allocation)
void FreeParagraphAlignedMemory(byte __far *allocation)
{
	word16 rawSegment;
	byte __far *adjustmentMarker;
	byte alignmentAdjustment;

	// V: AllocateParagraphAlignedMemory always returns offset zero. The
	// original allocation begins in the preceding segment at the adjustment
	// recorded at offset 000Fh.
	rawSegment = FAR_SEGMENT(allocation) - 0x01;
	adjustmentMarker = FAR_POINTER(byte, rawSegment, 0x0F);
	alignmentAdjustment = *adjustmentMarker;
	FreeFarHeapAllocation(FAR_POINTER(
		byte, rawSegment, alignmentAdjustment));
}
