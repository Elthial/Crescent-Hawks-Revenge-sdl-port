/* Graphics-resource procedure from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

/* 0D73:4099-4125 */
void LoadGraphicsResourceToBuffers(
	word16 resourceIndex,
	byte *decodeBuffer,
	byte *displayBuffer)
{
	const char *resourceName = (const char *) HostFarPointer_Resolve(
		DosAddress_ToValue(
			CachedFileDescriptors[resourceIndex].fileName));

	if (VideoAdapterType == VIDEO_ADAPTER_VGA)
	{
		LoadAndDecodePackedResource(
			resourceName, decodeBuffer, displayBuffer);
	}
	else
	{
		LoadAndDecodePackedResource(
			resourceName, displayBuffer, decodeBuffer);
		PackLowNibblesTo4Bpp(decodeBuffer, displayBuffer);
	}
	if (VideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		ConvertCgaPackedPixelsAndBuildMask(
			displayBuffer, CgaNarrowStrideMode);
	}
}
