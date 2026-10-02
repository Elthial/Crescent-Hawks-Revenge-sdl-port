// REVENGE_21E7_PACKED_RESOURCES.c
// Maintained annotation of the packed-resource loading leaf routines.

#include "REVENGE.h"
#include "revenge/original_data.h"

#pragma pack(push, 1)
typedef struct WestwoodCompressionHeader
{
	byte compressionType;          // +00: 0 raw, 1 LZW-12, 2 LZW-14, 3 RLE
	byte reserved_01;
	uint32 uncompressedByteCount;  // +02
	word16 optionalHeaderByteCount;// +06; codec-specific header byte count
} WestwoodCompressionHeader;
#pragma pack(pop)

_Static_assert(sizeof(WestwoodCompressionHeader) == 0x08,
	"WestwoodCompressionHeader must retain its DOS layout");

void CopyUncompressedFarBlock(
	const void *source,
	void *destination,
	uint32 byteCount);
void DecodeRLEBlock(
	const byte *compressedBlock,
	byte *destination);
void DecodeWestwoodLzw12(
	const byte *compressedBlock,
	byte *destination,
	byte *dictionary);
void DecodeWestwoodLzw14(
	const byte *compressedBlock,
	byte *destination,
	byte *dictionary);

// 21E7:000C: word16 ReadWholeResourceFile(
//     const char far *resourceName, void far *destination, word16 byteCount)
// Called from:
//      LoadScreenPalette
//      LoadMusicResource
word16 ReadWholeResourceFile(
	const char *resourceName,
	void *destination,
	word16 byteCount)
{
	int16 fileHandle;
	word16 bytesRead;

	fileHandle = OpenTrackedFile((char *) resourceName, 0x01);
	bytesRead = (word16) ReadTrackedFile(
		fileHandle, destination, (uint32) byteCount);
	CloseTrackedFile(fileHandle);
	return bytesRead;
}

// 21E7:0044: open a resource, seek to a 32-bit file offset, read a bounded
// span into a far destination, then close the file.
// Called from:
//      LoadScenarioDigitalSoundBank
void ReadResourceFileSpan(
	const char *resourceName,
	int32 fileOffset,
	void *destination,
	word16 byteCount)
{
	int16 fileHandle;

	fileHandle = OpenTrackedFile((char *) resourceName, 0x01);
	SeekTrackedFile(fileHandle, fileOffset, 0x00);
	ReadTrackedFile(fileHandle, destination, (uint32) byteCount);
	CloseTrackedFile(fileHandle);
}

// 21E7:008E: void LoadAndDecodePackedResource(
//     const char far *resourceName, void far *compressedBuffer,
//     void far *destination)
// Called from:
//      LoadScreenAssetToWorkBuffer
//      LoadGraphicsResourceToBuffers
void LoadAndDecodePackedResource(
	const char *resourceName,
	void *compressedBuffer,
	void *destination)
{
	word16 storedByteCount;
	int16 fileHandle;

	fileHandle = OpenTrackedFile((char *) resourceName, 0x01);
	ReadTrackedFile(fileHandle, &storedByteCount, 0x02);
	ReadTrackedFile(
		fileHandle, compressedBuffer, (uint32) storedByteCount);
	CloseTrackedFile(fileHandle);

	DecodeWestwoodPackedResource(compressedBuffer, destination);
}

// 21E7:00F4: dispatch the common Westwood compression header.
// Both workspaces are paragraph aligned; the four original codecs consume
// segment values and begin at offset zero.
void DecodeWestwoodPackedResource(
	const void *compressedBlock,
	void *destination)
{
	const WestwoodCompressionHeader *header =
		(const WestwoodCompressionHeader *)compressedBlock;

	// Verified against 21E7:00F4-0201.
	switch (header->compressionType)
	{
	case 0x00:
		CopyUncompressedFarBlock(
			(const byte *) compressedBlock + 0x08,
			destination,
			header->uncompressedByteCount);
		break;

	case 0x01:
		if (SharedCompressionDictionaryByteCount < 0x3C00)
		{
			byte *dictionary = AllocateParagraphAlignedMemory(0x3C00);
			DecodeWestwoodLzw12(
				compressedBlock, destination, dictionary);
			FreeParagraphAlignedMemory(dictionary);
		}
		else
			DecodeWestwoodLzw12(
				compressedBlock, destination,
				FAR_POINTER(byte, SharedCompressionDictionarySegment, 0x0000));
		break;

	case 0x02:
		if (SharedCompressionDictionaryByteCount < 0xBD00)
		{
			byte *dictionary = AllocateParagraphAlignedMemory(0xBD00);
			DecodeWestwoodLzw14(
				compressedBlock, destination, dictionary);
			FreeParagraphAlignedMemory(dictionary);
		}
		else
			DecodeWestwoodLzw14(
				compressedBlock, destination,
				FAR_POINTER(byte, SharedCompressionDictionarySegment, 0x0000));
		break;

	case 0x03:
		DecodeRLEBlock(compressedBlock, destination);
		break;
	}
}
