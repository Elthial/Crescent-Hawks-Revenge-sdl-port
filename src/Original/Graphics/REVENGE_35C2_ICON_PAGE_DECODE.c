// REVENGE_35C2_ICON_PAGE_DECODE.c - icon-page decoding and adapter conversion
// Tactical icon-page decompression and adapter conversion.

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

void DecodeLinearRleScreen(
	const byte *compressedData,
	byte *destination);
void DecodeColumnMajorRleScreen(
	const byte *compressedData,
	byte *destination);
// 35C2:000B
void CopyDecodedIconPage(
	const byte *packedDisplayBuffer,
	byte *iconPageDestination)
{
	byte layoutType;
	byte phaseRunLength;
	const byte *compressedData;

	layoutType = packedDisplayBuffer[0x00];
	compressedData = packedDisplayBuffer + 0x01;

	if (layoutType == 0x01)
		DecodeLinearRleScreen(compressedData, iconPageDestination);
	else
		DecodeColumnMajorRleScreen(compressedData, iconPageDestination);

	if (VideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		phaseRunLength = CgaNarrowStrideMode != FALSE ? 0x04 : 0x50;
		ConvertCgaPackedPixels(
			iconPageDestination,
			iconPageDestination,
			phaseRunLength,
			0x3E80);
		if (CgaNarrowStrideMode != FALSE)
			RepackCgaAlternateScanlines(iconPageDestination);
	}
}
