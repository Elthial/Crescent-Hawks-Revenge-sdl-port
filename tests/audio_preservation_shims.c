/*
 * Link-only boundaries for preservation tests which exercise the resident
 * 31FB tables and playback path without loading external resource files.
 * None of these routines is reached by the tests; keeping them here avoids
 * admitting unrelated, still-Unchecked translation units merely to satisfy
 * references from other procedures in the same original object file.
 */

#include "../src/Original/REVENGE.h"

byte *AllocateFarMemory(int32 byteCount)
{
	(void) byteCount;
	return (byte *) 0;
}

void FreeFarMemory(byte *allocation)
{
	(void) allocation;
}

word16 ReadWholeResourceFile(
	const char *resourceName,
	void *destination,
	word16 byteCount)
{
	(void) resourceName;
	(void) destination;
	(void) byteCount;
	return 0x0000;
}

void ReadResourceFileSpan(
	const char *resourceName,
	int32 fileOffset,
	void *destination,
	word16 byteCount)
{
	(void) resourceName;
	(void) fileOffset;
	(void) destination;
	(void) byteCount;
}
