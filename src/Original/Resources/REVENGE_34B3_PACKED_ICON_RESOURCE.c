// REVENGE_34B3_PACKED_ICON_RESOURCE.c
// Length-prefixed tactical graphics resource loader.

#include "REVENGE.h"

// 34B3:0008
void LoadPackedIconResource(
	const char *resourcePath,
	byte *packedDisplayBuffer)
{
	word16 packedByteCount;
	int16 fileHandle;

	fileHandle = OpenTrackedFile((char *)resourcePath, 0x0001);
	ReadTrackedFile(fileHandle, &packedByteCount, 0x00000002U);
	ReadTrackedFile(fileHandle, packedDisplayBuffer, packedByteCount);
	CloseTrackedFile(fileHandle);
}
