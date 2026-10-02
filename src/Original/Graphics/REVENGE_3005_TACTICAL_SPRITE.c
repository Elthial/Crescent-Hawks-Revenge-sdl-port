// REVENGE_3005_TACTICAL_SPRITE.c - tactical clipped-sprite dispatch
// Tactical clipped-sprite rendering wrapper.

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

// 3005:0008
void DrawTacticalClippedSprite(
	byte *renderTarget,
	const byte *encodedSprite,
	int16 relativeX,
	int16 relativeY,
	word16 textWindowIndex)
{
	TextWindowContext *textWindow;
	int16 screenX;
	int16 screenY;

	if (SpriteDrawBusy != FALSE)
		return;

	SpriteDrawBusy = TRUE;
	textWindow = &TextWindowContexts[textWindowIndex];
	TacticalSpriteClipLeftTile = textWindow->leftTile;
	SpriteClipLeftTileMirror = textWindow->leftTile;
	TacticalSpriteClipRightTile =
		textWindow->leftTile + textWindow->widthTiles;
	SpriteClipRightTileMirror = TacticalSpriteClipRightTile;
	TacticalSpriteClipTopPixel =
		textWindow->topTile << 0x03;
	SpriteClipTopPixelMirror = TacticalSpriteClipTopPixel;
	TacticalSpriteClipBottomPixel = TacticalSpriteClipTopPixel +
		(textWindow->heightTiles << 0x03);
	SpriteClipBottomPixelMirror = TacticalSpriteClipBottomPixel;

	screenX = relativeX +
		(TacticalSpriteClipLeftTile << 0x03);
	screenY = relativeY + TacticalSpriteClipTopPixel;

	/* The host decoders retain segment 4184's private clipping copies. */
	EncodedSpriteClipLeftTile = TacticalSpriteClipLeftTile;
	SpriteClipRightTile = TacticalSpriteClipRightTile;
	SpriteClipTopPixel = TacticalSpriteClipTopPixel;
	EncodedSpriteClipBottomPixel = TacticalSpriteClipBottomPixel;
	if (VideoAdapterType != VIDEO_ADAPTER_EGA)
		DrawCgaTandyEncodedSprite(
			renderTarget,
			encodedSprite,
			screenX,
			screenY);
	else
	{
		if (renderTarget == PrimaryScreenBuffer)
			renderTarget = EGA_OFFSCREEN_FRAMEBUFFER;
		DrawEGAEncodedSprite(
			renderTarget, encodedSprite, screenX, screenY);
	}

	SpriteDrawBusy = FALSE;
}
