#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>

static word16 callOrder;
static word16 loadOrder;
static word16 copyOrder;
static word16 conversionOrder;
static word16 adapterChanges[0x02];
static word16 adapterChangeCount;
static const char *loadedPath;
static byte *loadedPackedBuffer;
static byte *copiedPackedBuffer;
static byte *copiedDestination;
static byte *convertedDestination;
static word16 convertedStrideMode;

void LoadPackedIconResource(
	const char *resourcePath,
	byte *packedDisplayBuffer)
{
	loadOrder = ++callOrder;
	loadedPath = resourcePath;
	loadedPackedBuffer = packedDisplayBuffer;
}

void SetVideoAdapterType(word16 adapterType)
{
	adapterChanges[adapterChangeCount++] = adapterType;
}

void CopyDecodedIconPage(
	const byte *packedDisplayBuffer,
	byte *iconPageDestination)
{
	copyOrder = ++callOrder;
	copiedPackedBuffer = (byte *)packedDisplayBuffer;
	copiedDestination = iconPageDestination;
}

void ConvertCgaPackedPixelsAndBuildMask(
	byte *buffer,
	word16 narrowStrideMode)
{
	conversionOrder = ++callOrder;
	convertedDestination = buffer;
	convertedStrideMode = narrowStrideMode;
}

static void ResetObservations(void)
{
	callOrder = 0x0000;
	loadOrder = 0x0000;
	copyOrder = 0x0000;
	conversionOrder = 0x0000;
	adapterChangeCount = 0x0000;
	loadedPath = 0;
	loadedPackedBuffer = 0;
	copiedPackedBuffer = 0;
	copiedDestination = 0;
	convertedDestination = 0;
	convertedStrideMode = 0x0000;
}

int main(void)
{
	static const char path[] = "ICONS.PAK";
	byte packedBuffer[0x10];
	byte pageBuffer[0x10];

	ResetObservations();
	VideoAdapterType = VIDEO_ADAPTER_VGA;
	LoadPackedIconPageDirect(path, packedBuffer, pageBuffer);
	assert(loadOrder == 0x0001);
	assert(copyOrder == 0x0002);
	assert(conversionOrder == 0x0000);
	assert(adapterChangeCount == 0x0000);
	assert(VideoAdapterType == VIDEO_ADAPTER_VGA);

	ResetObservations();
	CgaNarrowStrideMode = 0x1234;
	VideoAdapterType = VIDEO_ADAPTER_CGA;
	LoadPackedIconPageDirect(path, packedBuffer, pageBuffer);
	assert(loadOrder == 0x0001);
	assert(copyOrder == 0x0002);
	assert(conversionOrder == 0x0003);
	assert(loadedPath == path);
	assert(loadedPackedBuffer == packedBuffer);
	assert(copiedPackedBuffer == packedBuffer);
	assert(copiedDestination == pageBuffer);
	assert(convertedDestination == pageBuffer);
	assert(convertedStrideMode == 0x1234);
	assert(adapterChangeCount == 0x0002);
	assert(adapterChanges[0x00] == VIDEO_ADAPTER_TANDY);
	assert(adapterChanges[0x01] == VIDEO_ADAPTER_CGA);
	assert(VideoAdapterType == VIDEO_ADAPTER_CGA);
	return 0;
}
