/* Tactical video-resource rebuild from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

/* 0D73:0387-0447 */
void RebuildTacticalVideoResources(
	word16 adapterType,
	word16 showScenarioCompletion)
{
	byte *primaryScreenBuffer;
	byte *secondaryScreenBuffer;
	byte *oldTileStrip;
	byte *newTileStrip;

	SetVideoModeForAdapter(adapterType);
	LoadVideoPalette(VideoPaletteData);
	if (VideoPathUnavailable != FALSE)
		return;

	if (showScenarioCompletion != FALSE)
	{
		ClearActiveVideoBuffer();
		ShowScenarioCompletionStatus();
	}

	primaryScreenBuffer = PrimaryScreenBuffer;
	secondaryScreenBuffer = SecondaryScreenBuffer;
	if (MouseDriverInstalled != FALSE)
	{
		LoadGraphicsResourceToBuffers(
			0x0000, secondaryScreenBuffer, primaryScreenBuffer);
		RebuildMouseCursorBackingBuffer();
		ConfigureMouseCursorOverlay(
			0x0000,
			0x0000,
			SharedGraphicsBackingBuffers[0x00]);
	}

	LoadScreenAssetToWorkBuffer(0x0000);
	if (VideoAdapterType == VIDEO_ADAPTER_EGA)
	{
		EGA_ConvertPackedScreenToPlanar(
			primaryScreenBuffer, EGA_OFFSCREEN_FRAMEBUFFER_SEGMENT);
	}

	oldTileStrip = TacticalTileStrip;
	FreeFarMemory(oldTileStrip);
	newTileStrip = CaptureVideoTileStrip(
		primaryScreenBuffer, 0x0000, 0x0000, 0x0008);
	TacticalTileStrip = newTileStrip;
}
