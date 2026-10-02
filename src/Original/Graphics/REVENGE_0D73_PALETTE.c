/* Palette procedure from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

// 0D73:329E: void InstallVgaPaletteBankAnchors(void)
// Called from:
//      InitializeTacticalBattle
void InstallVgaPaletteBankAnchors(void)
{
	// [V] Copy the first 16 RGB triplets into palette entries
	// 00h,10h,20h,...,F0h, then install the resulting VGA DAC palette.
	if (VideoAdapterType != VIDEO_ADAPTER_VGA)
		return;

	byte *palette = VideoPaletteData;
	word16 baseColor;
	for (baseColor = 0x00; baseColor < 0x10; ++baseColor)
	{
		word16 source = baseColor * 0x03;
		word16 destination = baseColor * 0x30;
		palette[destination] = palette[source];
		palette[destination + 0x01] = palette[source + 0x01];
		palette[destination + 0x02] = palette[source + 0x02];
	}
	LoadVideoPalette(palette);
}
