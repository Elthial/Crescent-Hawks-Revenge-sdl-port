// REVENGE_34DF.c
// Direct tactical icon-page loader used by the page-one special case.

#include "REVENGE.h"

void LoadPackedIconResource_0008(
	const char __far *resourcePath,
	byte __far *packedDisplayBuffer);
void CopyDecodedIconPage_000B(
	const byte __far *packedDisplayBuffer,
	byte __far *iconPageDestination);

// 34DF:0003
void LoadPackedIconPageDirect_0003(
	const char __far *resourcePath,
	byte __far *packedDisplayBuffer,
	byte __far *iconPageDestination)
{
	word16 restoredCgaMode = FALSE;

	LoadPackedIconResource_0008(resourcePath, packedDisplayBuffer);
	if (seg3A6A->VideoAdapterType_B6CE.u0 == VIDEO_ADAPTER_CGA)
	{
		// Decode without the ordinary CGA post-pass; this path needs the
		// paired-pixel mask builder after the full page has been expanded.
		seg3A6A->VideoAdapterType_B6CE.u0 = VIDEO_ADAPTER_TANDY;
		SetVideoAdapterType_4DE7(VIDEO_ADAPTER_TANDY);
		restoredCgaMode = TRUE;
	}

	CopyDecodedIconPage_000B(packedDisplayBuffer, iconPageDestination);
	if (restoredCgaMode != FALSE)
	{
		seg3A6A->VideoAdapterType_B6CE.u0 = VIDEO_ADAPTER_CGA;
		SetVideoAdapterType_4DE7(VIDEO_ADAPTER_CGA);
		ConvertCgaPackedPixelsAndBuildMask_35D8(
			iconPageDestination, seg3A6A->CgaNarrowStrideMode_6226);
	}
}
