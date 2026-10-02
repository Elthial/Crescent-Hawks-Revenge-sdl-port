// REVENGE_35C2.c
// Tactical icon-page decompression and adapter conversion.

#include "REVENGE.h"

void DecodeLinearRleScreen_33D6(
	const byte __far *compressedData,
	byte __far *destination);
void DecodeColumnMajorRleScreen_342D(
	const byte __far *compressedData,
	byte __far *destination);

// 35C2:000B
void CopyDecodedIconPage_000B(
	const byte __far *packedDisplayBuffer,
	byte __far *iconPageDestination)
{
	byte layoutType = packedDisplayBuffer[0x00];
	const byte __far *compressedData = packedDisplayBuffer + 0x01;

	if (layoutType == 0x01)
		DecodeLinearRleScreen_33D6(compressedData, iconPageDestination);
	else
		DecodeColumnMajorRleScreen_342D(compressedData, iconPageDestination);

	if (seg3A6A->VideoAdapterType_B6CE.u0 == VIDEO_ADAPTER_CGA)
	{
		byte phaseRunLength = seg3A6A->CgaNarrowStrideMode_6226 != FALSE ? 0x04 : 0x50;
		ConvertCgaPackedPixels_3571(
			iconPageDestination,
			iconPageDestination,
			phaseRunLength,
			0x3E80);
		if (seg3A6A->CgaNarrowStrideMode_6226 != FALSE)
			RepackCgaAlternateScanlines_32ED(iconPageDestination);
	}
}
