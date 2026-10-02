#ifndef REVENGE_ORIGINAL_RESOURCE_DATA_H
#define REVENGE_ORIGINAL_RESOURCE_DATA_H

#include <stddef.h>

#include "revenge/types.h"

enum
{
	ORIGINAL_RESOURCE_DESCRIPTOR_COUNT = 0x5A,
	ORIGINAL_TRACKED_FILE_COUNT = 0x0A,
	ORIGINAL_TRACKED_FILE_UNUSED = 0x7FFF,
	ORIGINAL_TRACKED_FILE_CACHED = 0x8000
};

#pragma pack(push, 1)
typedef struct ResourceFileRuntime
{
	DosAddress errorText; /* DS:B632 */
	word16 pendingDriveMask; /* DS:B636 */
	word16 availableDriveMask; /* DS:B638 */
	word16 trackedHandles[ORIGINAL_TRACKED_FILE_COUNT]; /* DS:B63A */
	word16 preloadFiles; /* DS:B64E */
} ResourceFileRuntime;

typedef struct CachedFileDescriptor
{
	DosAddress fileName; /* DS:10B0 */
	uint32 fileLength; /* DS:10B4 */
	DosAddress cachedData; /* DS:10B8 */
	word16 resourceDriveMask; /* DS:10BC */
	uint32 currentPosition; /* DS:10BE */
} CachedFileDescriptor;
#pragma pack(pop)

_Static_assert(offsetof(ResourceFileRuntime, pendingDriveMask) == 0x04,
	"DS:B636 must follow the retained error-text far pointer.");
_Static_assert(offsetof(ResourceFileRuntime, availableDriveMask) == 0x06,
	"DS:B638 must follow the pending drive mask.");
_Static_assert(offsetof(ResourceFileRuntime, trackedHandles) == 0x08,
	"DS:B63A must begin the ten tracked handles.");
_Static_assert(offsetof(ResourceFileRuntime, preloadFiles) == 0x1C,
	"DS:B64E must immediately follow the tracked-handle table.");
_Static_assert(sizeof(ResourceFileRuntime) == 0x1E,
	"The reconstructed DS:B632-B64F resource runtime block must be exact.");
_Static_assert(offsetof(CachedFileDescriptor, fileLength) == 0x04,
	"The resource length must remain at descriptor offset 04h.");
_Static_assert(offsetof(CachedFileDescriptor, cachedData) == 0x08,
	"The cache far pointer must remain at descriptor offset 08h.");
_Static_assert(offsetof(CachedFileDescriptor, resourceDriveMask) == 0x0C,
	"The resource drive mask must remain at descriptor offset 0Ch.");
_Static_assert(offsetof(CachedFileDescriptor, currentPosition) == 0x0E,
	"The stream position must remain at descriptor offset 0Eh.");
_Static_assert(sizeof(CachedFileDescriptor) == 0x12,
	"CachedFileDescriptor must retain its DOS layout.");

extern ResourceFileRuntime ResourceFiles;
extern CachedFileDescriptor CachedFileDescriptors[
	ORIGINAL_RESOURCE_DESCRIPTOR_COUNT];
extern char ResourceFileNames[
	ORIGINAL_RESOURCE_DESCRIPTOR_COUNT][0x10];
extern const uint32 ResourceFileLengths[
	ORIGINAL_RESOURCE_DESCRIPTOR_COUNT];

#endif
