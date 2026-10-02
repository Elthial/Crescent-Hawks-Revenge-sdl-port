/* Clipped-sprite procedure from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

/* 0D73:566E-57AA */
void DrawClippedSprite(
	byte *destination,
	const byte *encodedSprite,
	int16 x,
	int16 y,
	word16 clippingRegionIndex)
{
	TextWindowContext *clippingRegion;
	int16 clippedX;
	int16 clippedY;

	if (SpriteDrawBusy != FALSE)
		return;

	SpriteDrawBusy = TRUE;
	clippingRegion = &TextWindowContexts[clippingRegionIndex];
	EncodedSpriteClipLeftTile = clippingRegion->leftTile;
	SpriteClipLeftTileMirror = clippingRegion->leftTile;
	SpriteClipRightTile =
		clippingRegion->leftTile + clippingRegion->widthTiles;
	SpriteClipRightTileMirror = SpriteClipRightTile;
	SpriteClipTopPixel = clippingRegion->topTile << 0x03;
	SpriteClipTopPixelMirror = SpriteClipTopPixel;
	EncodedSpriteClipBottomPixel = SpriteClipTopPixel +
		(clippingRegion->heightTiles << 0x03);
	SpriteClipBottomPixelMirror = EncodedSpriteClipBottomPixel;

	clippedX = x + (int16) (EncodedSpriteClipLeftTile << 0x03);
	clippedY = y + (int16) SpriteClipTopPixel;
	if (encodedSprite != NULL)
	{
		if (VideoAdapterType != VIDEO_ADAPTER_EGA)
		{
			if (VideoAdapterType == VIDEO_ADAPTER_VGA)
			{
				DrawVgaRleSprite(
					destination, encodedSprite, clippedX, clippedY);
			}
			else
			{
				DrawCgaTandyEncodedSprite(
					destination, encodedSprite, clippedX, clippedY);
			}
		}
		else
		{
			if (destination == PrimaryScreenBuffer)
				destination = EGA_OFFSCREEN_FRAMEBUFFER;
			DrawEGAEncodedSprite(
				destination, encodedSprite, clippedX, clippedY);
		}
	}
	SpriteDrawBusy = FALSE;
}
