// REVENGE_0800_GRAPHICS_RUNTIME.c
// Runtime, codec, tactical-map, and video procedures reconstructed from
// REVENGE.EXE segment 0800.

// Packed-resource codecs and DOS runtime edges from segment 0800.
#include "REVENGE.h"
#include "revenge/interrupts.h"
#include "revenge/original_data.h"
#include "revenge/platform_backend.h"
#include "revenge/video.h"

#include <stdint.h>
#include <string.h>

enum
{
	EGA_GC_ENABLE_SET_RESET_REGISTER = 0x01,
	EGA_GC_MODE_REGISTER = 0x05,
	EGA_GC_BIT_MASK_REGISTER = 0x08,
	EGA_GC_WRITE_MODE_0 = 0x00,
	EGA_GC_WRITE_MODE_1 = 0x01,
	EGA_GC_WRITE_MODE_2 = 0x02,
	EGA_SEQ_MAP_MASK_REGISTER = 0x02,
	EGA_ALL_PLANES = 0x0F,
	EGA_ALL_WRITABLE_PIXEL_BITS = 0xFF
};

// 0800:010D: void DOS_TerminateProcess(word16 exitCode)
// Called from:
//      RunExitHandlersAndTerminate
void DOS_TerminateProcess(word16 exitCode)
{
	InstallExceptionHandlers();
	RuntimeTerminationHook();
	// ANNOTATION: DOS INT 21h/AH=4Ch process termination.
	SDLBackend_TerminateProcess((byte) exitCode);
}

// 0800:0172: void InstallExceptionHandlers()
// Called from:
//      TerminateProcess
void InstallExceptionHandlers()
{
	// ANNOTATION: DOS INT 21h/AH=25h installs startup exception handlers:
	// 00h divide, 04h overflow, 05h bounds/Print Screen, 06h invalid opcode.
	DOS_SetInterruptVector(0x00, SavedDivideErrorHandler);
	DOS_SetInterruptVector(0x04, SavedOverflowHandler);
	DOS_SetInterruptVector(0x05, SavedBoundsHandler);
	DOS_SetInterruptVector(0x06, SavedInvalidOpcodeHandler);
}


// 0800:0C34: copy a 32-bit byte count between normalized far buffers.
// Called from:
//      DecodeWestwoodPackedResource
void CopyUncompressedFarBlock(
	const void *source,
	void *destination,
	uint32 byteCount)
{
	const byte *sourceByte = (const byte *) source;
	byte *destinationByte = (byte *) destination;

	/* 0800:0C34-0C86 uses the low word with REP MOVSW/MOVSB, then
	 * normalizes both far pointers before every high-word 10000h-byte block. */
	while (byteCount != 0x00000000UL)
	{
		*destinationByte = *sourceByte;
		++sourceByte;
		++destinationByte;
		--byteCount;
	}
}

// 0800:0C87: normalize DX:AX as a real-mode segment:offset pointer.
// Called from:
//      CopyUncompressedFarBlock
segptr32 NormalizeSegmentOffset(word16 offset, word16 segment)
{
	return MAKE_FAR_POINTER(
		segment + (offset >> 0x04),
		offset & 0x000F);
}

// 0800:0C9A: decode signed literal/repeat runs until the header's 32-bit
// output count is exhausted.
void DecodeRLEBlock(
	const byte *compressedBlock,
	byte *destination)
{
	uint32 remainingOutputBytes;
	word16 sourceOffset;

	memcpy(&remainingOutputBytes, compressedBlock + 0x02,
		sizeof(remainingOutputBytes));
	memcpy(&sourceOffset, compressedBlock + 0x06, sizeof(sourceOffset));
	compressedBlock += sourceOffset + 0x08;
	while (remainingOutputBytes != 0x00000000UL)
	{
		byte command = *compressedBlock++;
		word16 runLength;

		if (command == 0x00)
		{
			runLength = ((word16) compressedBlock[0x00] << 0x08) |
				compressedBlock[0x01];
			compressedBlock += 0x02;
			memset(destination, *compressedBlock++, runLength);
		}
		else if (command <= 0x7F)
		{
			runLength = command;
			memcpy(destination, compressedBlock, runLength);
			compressedBlock += runLength;
		}
		else
		{
			runLength = (word16) (byte) -command;
			memset(destination, *compressedBlock++, runLength);
		}
		destination += runLength;
		remainingOutputBytes -= runLength;
	}
}


#pragma pack(push, 1)
typedef struct WestwoodLzwDecoderState
{
	word16 OutputByteCount;
	word16 Reserved;
	word16 CompressedStreamSegment;
	byte CodePhase;
} WestwoodLzwDecoderState;
#pragma pack(pop)

_Static_assert(sizeof(WestwoodLzwDecoderState) == 0x07,
	"Westwood decoder state must retain CS:0C93-0C99 layout");

static WestwoodLzwDecoderState WestwoodLzwDecoder;

uint16 ReadWestwoodLzw12Code(
	byte nibbleShift,
	word16 sourceOffset,
	word16 *nextSourceOffset);
uint16 ReadWestwoodLzw14Code(
	word16 sourceOffset,
	word16 *nextSourceOffset);


uint32 PrepareRLEOutputRun(
	uint32 remainingOutputBytes,
	word16 runLength,
	word16 destinationOffset,
	word16 destinationSegment,
	word16 *normalizedOffsetOut,
	word16 *normalizedSegmentOut)
{
	uint32 nextRemainingOutputBytes;

	nextRemainingOutputBytes = remainingOutputBytes - (uint32) runLength;
	*normalizedOffsetOut = destinationOffset & 0x000F;
	*normalizedSegmentOut = destinationSegment + (destinationOffset >> 0x04);
	return nextRemainingOutputBytes;
}

// 0800:0D1A: expand the original 12-bit Westwood dictionary stream.
void DecodeWestwoodLzw12(
	const byte *compressed,
	byte *destination,
	byte *dictionary)
{
	uint32 compressedAddress;
	word16 sourceOffset;
	word16 outputOffset;
	word16 nextCode;
	word16 previousCode;
	byte previousFirst;

	memcpy(&WestwoodLzwDecoder.OutputByteCount,
		compressed + 0x02, sizeof(word16));
	memcpy(&sourceOffset, compressed + 0x06, sizeof(sourceOffset));
	compressedAddress = HostFarPointer_Register((void *) compressed,
		(uint32) WestwoodLzwDecoder.OutputByteCount * 0x02 +
		sourceOffset + 0x08);
	WestwoodLzwDecoder.CompressedStreamSegment =
		HIGH_WORD(compressedAddress);
	WestwoodLzwDecoder.CodePhase = 0x00;
	sourceOffset = LOW_WORD(compressedAddress) + sourceOffset + 0x08;
	outputOffset = 0x0000;
	nextCode = 0x0100;
	previousCode = ReadWestwoodLzw12Code(
		0x04, sourceOffset, &sourceOffset);
	previousFirst = (byte) previousCode;
	destination[outputOffset++] = previousFirst;
	while (outputOffset < WestwoodLzwDecoder.OutputByteCount)
	{
		word16 code = ReadWestwoodLzw12Code(
			0x04, sourceOffset, &sourceOffset);
		word16 expandedCode = code;
		word16 sequenceStart = outputOffset;
		word16 left;
		word16 right;

		if (code >= nextCode)
		{
			destination[outputOffset++] = previousFirst;
			expandedCode = previousCode;
		}
		while (expandedCode >= 0x0100)
		{
			word16 dictionaryOffset = (expandedCode - 0x0100) << 0x02;

			destination[outputOffset++] = dictionary[dictionaryOffset + 0x02];
			memcpy(&expandedCode, dictionary + dictionaryOffset,
				sizeof(expandedCode));
		}
		previousFirst = (byte) expandedCode;
		destination[outputOffset++] = previousFirst;
		left = sequenceStart;
		right = outputOffset - 0x01;
		while (left < right)
		{
			byte swap = destination[left];

			destination[left++] = destination[right];
			destination[right--] = swap;
		}
		if (nextCode < 0x1000)
		{
			word16 dictionaryOffset = (nextCode - 0x0100) << 0x02;

			memcpy(dictionary + dictionaryOffset, &previousCode,
				sizeof(previousCode));
			dictionary[dictionaryOffset + 0x02] = previousFirst;
			++nextCode;
		}
		previousCode = code;
	}
}

uint16 ReadWestwoodLzw12Code(
	byte nibbleShift,
	word16 sourceOffset,
	word16 *nextSourceOffset)
{
	const byte *compressedData;
	word16 packedCode;

	compressedData = FAR_POINTER(
		const byte,
		WestwoodLzwDecoder.CompressedStreamSegment,
		sourceOffset);
	++WestwoodLzwDecoder.CodePhase;
	if ((WestwoodLzwDecoder.CodePhase & 0x01) != 0x00)
	{
		packedCode = ((word16) compressedData[0x00] << 0x08)
			| compressedData[0x01];
		*nextSourceOffset = sourceOffset + 0x01;
		return packedCode >> nibbleShift;
	}

	*nextSourceOffset = sourceOffset + 0x02;
	return ((word16) (compressedData[0x00] & 0x0F) << 0x08)
		| compressedData[0x01];
}

// 0800:0E16: expand the original 14-bit Westwood dictionary stream.
void DecodeWestwoodLzw14(
	const byte *compressed,
	byte *destination,
	byte *dictionary)
{
	uint32 compressedAddress;
	word16 sourceOffset;
	word16 outputOffset;
	word16 nextCode;
	word16 previousCode;
	byte previousFirst;

	memcpy(&WestwoodLzwDecoder.OutputByteCount,
		compressed + 0x02, sizeof(word16));
	memcpy(&sourceOffset, compressed + 0x06, sizeof(sourceOffset));
	compressedAddress = HostFarPointer_Register((void *) compressed,
		(uint32) WestwoodLzwDecoder.OutputByteCount * 0x02 +
		sourceOffset + 0x08);
	WestwoodLzwDecoder.CompressedStreamSegment =
		HIGH_WORD(compressedAddress);
	WestwoodLzwDecoder.CodePhase = 0x00;
	sourceOffset = LOW_WORD(compressedAddress) + sourceOffset + 0x08;
	outputOffset = 0x0000;
	nextCode = 0x0100;
	previousCode = ReadWestwoodLzw14Code(sourceOffset, &sourceOffset);
	previousFirst = (byte) previousCode;
	destination[outputOffset++] = previousFirst;
	while (outputOffset < WestwoodLzwDecoder.OutputByteCount)
	{
		word16 code = ReadWestwoodLzw14Code(
			sourceOffset, &sourceOffset);
		word16 expandedCode = code;
		word16 sequenceStart = outputOffset;
		word16 left;
		word16 right;

		if (code >= nextCode)
		{
			destination[outputOffset++] = previousFirst;
			expandedCode = previousCode;
		}
		while (expandedCode >= 0x0100)
		{
			word16 dictionaryIndex = expandedCode - 0x0100;

			destination[outputOffset++] = dictionary[
				0x7E00 + dictionaryIndex];
			memcpy(&expandedCode,
				dictionary + (dictionaryIndex << 0x01),
				sizeof(expandedCode));
		}
		previousFirst = (byte) expandedCode;
		destination[outputOffset++] = previousFirst;
		left = sequenceStart;
		right = outputOffset - 0x01;
		while (left < right)
		{
			byte swap = destination[left];

			destination[left++] = destination[right];
			destination[right--] = swap;
		}
		if (nextCode < 0x4000)
		{
			word16 dictionaryIndex = nextCode - 0x0100;

			memcpy(dictionary + (dictionaryIndex << 0x01),
				&previousCode, sizeof(previousCode));
			dictionary[0x7E00 + dictionaryIndex] = previousFirst;
			++nextCode;
		}
		previousCode = code;
	}
}

uint16 ReadWestwoodLzw14Code(
	word16 sourceOffset,
	word16 *nextSourceOffset)
{
	const byte *compressedData;
	byte phase;

	compressedData = FAR_POINTER(
		const byte,
		WestwoodLzwDecoder.CompressedStreamSegment,
		sourceOffset);
	phase = (WestwoodLzwDecoder.CodePhase + 0x01) & 0x03;
	WestwoodLzwDecoder.CodePhase = phase;
	switch (phase)
	{
	case 0x01:
		*nextSourceOffset = sourceOffset + 0x01;
		return ((word16) compressedData[0x00] << 0x06)
			| (compressedData[0x01] >> 0x02);
	case 0x02:
		*nextSourceOffset = sourceOffset + 0x02;
		return ((word16) (compressedData[0x00] & 0x03) << 0x0C)
			| ((word16) compressedData[0x01] << 0x04)
			| (compressedData[0x02] >> 0x04);
	case 0x03:
		*nextSourceOffset = sourceOffset + 0x02;
		return ((word16) (compressedData[0x00] & 0x0F) << 0x0A)
			| ((word16) compressedData[0x01] << 0x02)
			| (compressedData[0x02] >> 0x06);
	default:
		*nextSourceOffset = sourceOffset + 0x02;
		return ((word16) (compressedData[0x00] & 0x3F) << 0x08)
			| compressedData[0x01];
	}
}




