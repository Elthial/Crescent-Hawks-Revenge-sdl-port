// REVENGE_34B3.c
// Length-prefixed tactical graphics resource loader.

#include "REVENGE.h"

// 34B3:0008
void LoadPackedIconResource_0008(
	const char __far *resourcePath,
	byte __far *packedDisplayBuffer)
{
	word16 packedByteCount;
	int16 fileHandle = OpenTrackedFile((Eq_8249) resourcePath, 0x01);

	// V: the on-disk stream begins with a little-endian 16-bit compressed
	// length, followed immediately by that many bytes of RLE payload.
	ReadTrackedFile(fileHandle, (Eq_168) &packedByteCount, 0x02);
	ReadTrackedFile(fileHandle, (Eq_168) packedDisplayBuffer, packedByteCount);
	CloseTrackedFile(fileHandle);
}
