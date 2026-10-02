// REVENGE_21E7.c
// Maintained annotation of the packed-resource loading leaf routines.

#include "REVENGE.h"

typedef struct WestwoodCompressionHeader
{
	byte compressionType;          // +00: 0 raw, 1 LZW-12, 2 LZW-14, 3 RLE
	byte reserved_01;
	uint32 uncompressedByteCount;  // +02
	word16 optionalHeaderByteCount;// +06; payload begins at +08 plus this value
} WestwoodCompressionHeader;

// 21E7:000C: word16 ReadWholeResourceFile_000C(
//     const char far *resourceName, void far *destination, word16 byteCount)
// Called from:
//      LoadScreenPalette_324E
//      LoadMusicResource_0197
word16 ReadWholeResourceFile_000C(
	const char __far *resourceName, void __far *destination, word16 byteCount)
{
	int16 fileHandle = OpenTrackedFile((char __far *)resourceName, 0x01);
	word16 bytesRead = (word16)ReadTrackedFile(
		fileHandle, destination, (uint32)byteCount);
	CloseTrackedFile(fileHandle);
	return bytesRead;
}

// 21E7:0044: open a resource, seek to a 32-bit file offset, read a bounded
// span into a far destination, then close the file.
// Called from:
//      LoadScenarioDigitalSoundBank_0297
void ReadResourceFileSpan_0044(
	const char __far *resourceName, int32 fileOffset,
	void __far *destination, word16 byteCount)
{
	int16 fileHandle = OpenTrackedFile((char __far *)resourceName, 0x01);
	SeekTrackedFile(fileHandle, fileOffset, 0x00);
	ReadTrackedFile(fileHandle, destination, (uint32)byteCount);
	CloseTrackedFile(fileHandle);
}

// 21E7:008E: void LoadAndDecodePackedResource_008E(
//     const char far *resourceName, void far *compressedBuffer,
//     void far *destination)
// Called from:
//      LoadScreenAssetToWorkBuffer_32F4
//      LoadGraphicsResourceToBuffers_4099
void LoadAndDecodePackedResource_008E(
	const char __far *resourceName, void __far *compressedBuffer,
	void __far *destination)
{
	word16 storedByteCount;
	int16 fileHandle = OpenTrackedFile((char __far *)resourceName, 0x01);

	// V: The first word is an outer stored-length envelope and is not copied
	// into the workspace. The following bytes begin with the compression header.
	ReadTrackedFile(fileHandle, &storedByteCount, 0x02);
	ReadTrackedFile(
		fileHandle, compressedBuffer, (uint32)storedByteCount);
	CloseTrackedFile(fileHandle);

	DecodeWestwoodPackedResource_00F4(compressedBuffer, destination);
}

// 21E7:00F4: dispatch the common Westwood compression header.
// Both workspaces are paragraph aligned; the four original codecs consume
// segment values and begin at offset zero.
void DecodeWestwoodPackedResource_00F4(
	const void __far *compressedBlock, void __far *destination)
{
	WestwoodCompressionHeader __far *header =
		(WestwoodCompressionHeader __far *)compressedBlock;
	word16 compressedSegment = FAR_SEGMENT(compressedBlock);
	word16 destinationSegment = FAR_SEGMENT(destination);

	switch (header->compressionType)
	{
	case 0x00:
		CopyUncompressedFarBlock_0C34(
			(const byte __far *)compressedBlock + 0x08,
			destination,
			header->uncompressedByteCount);
		break;

	case 0x01:
		if (SharedCompressionDictionaryByteCount_2F70 < 0x3C00)
		{
			byte __far *dictionary = AllocateParagraphAlignedMemory(0x3C00);
			DecodeWestwoodLzw12_0D1A(
				compressedSegment, destinationSegment, FAR_SEGMENT(dictionary));
			FreeParagraphAlignedMemory(dictionary);
		}
		else
			DecodeWestwoodLzw12_0D1A(
				compressedSegment, destinationSegment,
				SharedCompressionDictionarySegment_2F6E);
		break;

	case 0x02:
		if (SharedCompressionDictionaryByteCount_2F70 < 0xBD00)
		{
			byte __far *dictionary = AllocateParagraphAlignedMemory(0xBD00);
			DecodeWestwoodLzw14_0E16(
				compressedSegment, destinationSegment, FAR_SEGMENT(dictionary));
			FreeParagraphAlignedMemory(dictionary);
		}
		else
			DecodeWestwoodLzw14_0E16(
				compressedSegment, destinationSegment,
				SharedCompressionDictionarySegment_2F6E);
		break;

	case 0x03:
		DecodeRLEBlock_0C9A(
			(struct Eq_254 *)compressedSegment,
			(struct seg4184_t *)destinationSegment);
		break;
	}
}
