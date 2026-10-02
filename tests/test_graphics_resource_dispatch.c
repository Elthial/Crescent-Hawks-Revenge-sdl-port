#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>

static char resourceName[] = "TEST.CPS";
static byte decodeBuffer[0x10];
static byte displayBuffer[0x10];
static const char *capturedName;
static void *capturedCompressed;
static void *capturedDestination;
static const byte *packedSource;
static byte *packedDestination;
static byte *cgaBuffer;
static word16 cgaStrideMode;

void LoadAndDecodePackedResource(
	const char *name,
	void *compressedBuffer,
	void *destination)
{
	capturedName = name;
	capturedCompressed = compressedBuffer;
	capturedDestination = destination;
}

void PackLowNibblesTo4Bpp(
	const byte *source,
	byte *destination)
{
	packedSource = source;
	packedDestination = destination;
}

void ConvertCgaPackedPixelsAndBuildMask(
	byte *buffer,
	word16 narrowStrideMode)
{
	cgaBuffer = buffer;
	cgaStrideMode = narrowStrideMode;
}

static void ResetCapture(void)
{
	capturedName = NULL;
	capturedCompressed = NULL;
	capturedDestination = NULL;
	packedSource = NULL;
	packedDestination = NULL;
	cgaBuffer = NULL;
	cgaStrideMode = 0xFFFF;
}

int main(void)
{
	HostFarPointer_Reset();
	CachedFileDescriptors[0x03].fileName =
		DosAddress_FromValue(
			HostFarPointer_Register(resourceName, sizeof(resourceName)));

	ResetCapture();
	VideoAdapterType = VIDEO_ADAPTER_VGA;
	LoadGraphicsResourceToBuffers(
		0x0003, decodeBuffer, displayBuffer);
	assert(capturedName == resourceName);
	assert(capturedCompressed == decodeBuffer);
	assert(capturedDestination == displayBuffer);
	assert(packedSource == NULL);
	assert(cgaBuffer == NULL);

	ResetCapture();
	VideoAdapterType = VIDEO_ADAPTER_TANDY;
	LoadGraphicsResourceToBuffers(
		0x0003, decodeBuffer, displayBuffer);
	assert(capturedCompressed == displayBuffer);
	assert(capturedDestination == decodeBuffer);
	assert(packedSource == decodeBuffer);
	assert(packedDestination == displayBuffer);
	assert(cgaBuffer == NULL);

	ResetCapture();
	VideoAdapterType = VIDEO_ADAPTER_CGA;
	CgaNarrowStrideMode = 0x1234;
	LoadGraphicsResourceToBuffers(
		0x0003, decodeBuffer, displayBuffer);
	assert(capturedCompressed == displayBuffer);
	assert(capturedDestination == decodeBuffer);
	assert(packedSource == decodeBuffer);
	assert(packedDestination == displayBuffer);
	assert(cgaBuffer == displayBuffer);
	assert(cgaStrideMode == 0x1234);

	HostFarPointer_Reset();
	return 0;
}
