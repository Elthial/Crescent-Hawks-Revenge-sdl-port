// REVENGE_3005.c
// Tactical clipped-sprite rendering wrapper.

#include "REVENGE.h"

// 3005:0008
void DrawTacticalClippedSprite_0008(
	byte __far *renderTarget,
	const byte __far *encodedSprite,
	int16 relativeX,
	int16 relativeY,
	word16 textWindowIndex)
{
	TextWindowContext *textWindow;
	int16 screenX;
	int16 screenY;

	if (seg3A6A->SpriteDrawBusy_563C != FALSE)
		return;

	seg3A6A->SpriteDrawBusy_563C = TRUE;
	textWindow = &seg3A6A->TextWindowContexts_063A[textWindowIndex];
	seg3A6A->SpriteClipLeftTile_7B1C = textWindow->leftTile;
	seg3A6A->SpriteClipLeftTileMirror_7D67 = textWindow->leftTile;
	seg3A6A->SpriteClipRightTile_7B1E =
		textWindow->leftTile + textWindow->widthTiles;
	seg3A6A->SpriteClipRightTileMirror_7D69 = seg3A6A->SpriteClipRightTile_7B1E;
	seg3A6A->SpriteClipTopPixel_7B20 =
		textWindow->topTile * TEXT_WINDOW_TILE_SIZE_PIXELS;
	seg3A6A->SpriteClipTopPixelMirror_7D6B = seg3A6A->SpriteClipTopPixel_7B20;
	seg3A6A->SpriteClipBottomPixel_7B22 = seg3A6A->SpriteClipTopPixel_7B20 +
		(textWindow->heightTiles * TEXT_WINDOW_TILE_SIZE_PIXELS);
	seg3A6A->SpriteClipBottomPixelMirror_7D6D = seg3A6A->SpriteClipBottomPixel_7B22;

	screenX = relativeX +
		(seg3A6A->SpriteClipLeftTile_7B1C * TEXT_WINDOW_TILE_SIZE_PIXELS);
	screenY = relativeY + seg3A6A->SpriteClipTopPixel_7B20;
	if (seg3A6A->VideoAdapterType_B6CE.u0 != VIDEO_ADAPTER_EGA)
		DrawCgaTandyEncodedSprite_14B7(
			renderTarget,
			encodedSprite,
			screenX,
			screenY);
	else
	{
		if (renderTarget == (byte __far *) MAKE_FAR_POINTER(
			seg3A6A->PrimaryScreenBufferSegment_ptrB660, seg3A6A->PrimaryScreenBuffer_tB65E.u0))
			renderTarget = FAR_POINTER(
				byte,
				EGA_OFFSCREEN_FRAMEBUFFER_SEGMENT,
				EGA_OFFSCREEN_FRAMEBUFFER_OFFSET);
		DrawEGAEncodedSprite_30FD(
			LOW_WORD(renderTarget),
			(struct seg4184_t *) FAR_SEGMENT(renderTarget),
			LOW_WORD(encodedSprite),
			(struct Eq_1132 *) FAR_SEGMENT(encodedSprite),
			screenX,
			screenY);
	}

	seg3A6A->SpriteDrawBusy_563C = FALSE;
}
