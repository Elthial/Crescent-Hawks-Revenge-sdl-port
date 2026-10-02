// Reconstructed original far-memory fill utilities (segment 3985).

#include "REVENGE.h"

// 3985:0009: void FillFarMemoryBytes(Stack far pointer destination,
//     Stack uint16 byteCount, Stack byte value)
// Called from:
//      FarMemorySet
void FillFarMemoryBytes(byte *destination, uint16 byteCount, byte value)
{
	// Assembly uses an alignment byte, REP STOSW, and a trailing byte.  Those
	// are an optimized implementation of this ordinary far-memory fill.
	while (byteCount-- != 0x00)
		*destination++ = value;
}

// 3985:002F: byte far *FarMemorySet(Stack far pointer destination,
//     Stack byte value, Stack uint16 byteCount)
// Called from:
//      InitializeTimezoneFromEnvironment
byte *FarMemorySet(
	byte *destination,
	byte value,
	uint16 byteCount)
{
	FillFarMemoryBytes(destination, byteCount, value);
	return destination;
}
