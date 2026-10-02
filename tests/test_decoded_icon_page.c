#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>

static word16 linearDecodeCount;
static word16 columnDecodeCount;
static word16 conversionCount;
static word16 repackCount;
static const byte *decoderSource;
static byte *decoderDestination;
static word16 conversionPhaseRunLength;
static word16 conversionByteCount;

void DecodeLinearRleScreen(
	const byte *compressedData,
	byte *destination)
{
	++linearDecodeCount;
	decoderSource = compressedData;
	decoderDestination = destination;
}

void DecodeColumnMajorRleScreen(
	const byte *compressedData,
	byte *destination)
{
	++columnDecodeCount;
	decoderSource = compressedData;
	decoderDestination = destination;
}

void ConvertCgaPackedPixels(
	const byte *source,
	byte *destination,
	byte phaseRunLength,
	word16 byteCount)
{
	assert(source == destination);
	assert(destination == decoderDestination);
	++conversionCount;
	conversionPhaseRunLength = phaseRunLength;
	conversionByteCount = byteCount;
}

void RepackCgaAlternateScanlines(byte *screenBuffer)
{
	assert(screenBuffer == decoderDestination);
	++repackCount;
}

static void ResetObservations(void)
{
	linearDecodeCount = 0x0000;
	columnDecodeCount = 0x0000;
	conversionCount = 0x0000;
	repackCount = 0x0000;
	decoderSource = 0;
	decoderDestination = 0;
	conversionPhaseRunLength = 0x0000;
	conversionByteCount = 0x0000;
}

static void TestPage(byte layoutType, word16 adapterType,
	word16 narrowStrideMode)
{
	byte packedDisplayBuffer[0x10] = { 0x00 };
	byte iconPageDestination[0x10];

	ResetObservations();
	packedDisplayBuffer[0x00] = layoutType;
	VideoAdapterType = adapterType;
	CgaNarrowStrideMode = narrowStrideMode;
	CopyDecodedIconPage(packedDisplayBuffer, iconPageDestination);

	assert(decoderSource == packedDisplayBuffer + 0x01);
	assert(decoderDestination == iconPageDestination);
	assert(linearDecodeCount == (layoutType == 0x01 ? 0x0001 : 0x0000));
	assert(columnDecodeCount == (layoutType == 0x01 ? 0x0000 : 0x0001));
	assert(conversionCount ==
		(adapterType == VIDEO_ADAPTER_CGA ? 0x0001 : 0x0000));
	assert(repackCount ==
		(adapterType == VIDEO_ADAPTER_CGA && narrowStrideMode != FALSE
			? 0x0001
			: 0x0000));
	if (adapterType == VIDEO_ADAPTER_CGA)
	{
		assert(conversionPhaseRunLength ==
			(narrowStrideMode != FALSE ? 0x0004 : 0x0050));
		assert(conversionByteCount == 0x3E80);
	}
}

int main(void)
{
	TestPage(0x01, VIDEO_ADAPTER_VGA, FALSE);
	TestPage(0x02, VIDEO_ADAPTER_EGA, FALSE);
	TestPage(0x01, VIDEO_ADAPTER_CGA, FALSE);
	TestPage(0x02, VIDEO_ADAPTER_CGA, TRUE);
	return 0;
}
