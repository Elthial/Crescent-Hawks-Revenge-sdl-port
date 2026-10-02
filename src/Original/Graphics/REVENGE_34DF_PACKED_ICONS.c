// REVENGE_34DF_PACKED_ICONS.c - direct packed icon-page loading
// Direct tactical icon-page loader used by the page-one special case.

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

void LoadPackedIconResource(
	const char *resourcePath,
	byte *packedDisplayBuffer);
void ConvertCgaPackedPixelsAndBuildMask(
	byte *buffer,
	word16 narrowStrideMode);

// 34DF:0003
void LoadPackedIconPageDirect(
	const char *resourcePath,
	byte *packedDisplayBuffer,
	byte *iconPageDestination)
{
	word16 restoredCgaMode = FALSE;

	LoadPackedIconResource(resourcePath, packedDisplayBuffer);
	if (VideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		// Decode without the ordinary CGA post-pass; this path needs the
		// paired-pixel mask builder after the full page has been expanded.
		VideoAdapterType = VIDEO_ADAPTER_TANDY;
		SetVideoAdapterType(VIDEO_ADAPTER_TANDY);
		restoredCgaMode = TRUE;
	}

	CopyDecodedIconPage(packedDisplayBuffer, iconPageDestination);
	if (restoredCgaMode != FALSE)
	{
		VideoAdapterType = VIDEO_ADAPTER_CGA;
		SetVideoAdapterType(VIDEO_ADAPTER_CGA);
		ConvertCgaPackedPixelsAndBuildMask(
			iconPageDestination, CgaNarrowStrideMode);
	}
}
