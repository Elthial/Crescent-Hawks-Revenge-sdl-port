#include "fake_backend.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>

void DrawClippedSprite(
	byte *destination,
	const byte *encodedSprite,
	int16 x,
	int16 y,
	word16 clippingRegionIndex);

static void ResetState(void)
{
	FakeBackend_Reset();
	SpriteDrawBusy = FALSE;
	TextWindowContexts[0x02].leftTile = 0x0002;
	TextWindowContexts[0x02].topTile = 0x0001;
	TextWindowContexts[0x02].widthTiles = 0x0001;
	TextWindowContexts[0x02].heightTiles = 0x0001;
}

static void TestVgaDispatchAndWindowRelativeCoordinates(void)
{
	const byte sprite[] = {
		0x00, 0x00, 0x01, 0x00,
		0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C
	};
	uint32 row = 0x0008U * VIDEO_SCREEN_WIDTH;

	ResetState();
	VideoAdapterType = VIDEO_ADAPTER_VGA;
	ActiveVideoAdapterType = VIDEO_ADAPTER_VGA;
	DrawClippedSprite(NULL, sprite, 0x0000, 0x0000, 0x0002);

	assert(SpriteDrawBusy == FALSE);
	assert(EncodedSpriteClipLeftTile == 0x0002);
	assert(SpriteClipRightTile == 0x0003);
	assert(SpriteClipTopPixel == 0x0008);
	assert(EncodedSpriteClipBottomPixel == 0x0010);
	assert(SpriteClipLeftTileMirror == EncodedSpriteClipLeftTile);
	assert(SpriteClipRightTileMirror == SpriteClipRightTile);
	assert(SpriteClipTopPixelMirror == SpriteClipTopPixel);
	assert(SpriteClipBottomPixelMirror == EncodedSpriteClipBottomPixel);
	assert(fakeBackend.indexedFramebuffer[row + 0x0010] == 0x05);
	assert(fakeBackend.indexedFramebuffer[row + 0x0017] == 0x0C);
}

static void TestExplicitDestinationIsHonored(void)
{
	const byte sprite[] = {
		0x00, 0x00, 0x01, 0x00,
		0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C
	};
	byte destination[VIDEO_SCREEN_WIDTH * VIDEO_SCREEN_HEIGHT] = { 0x00 };
	uint32 row = 0x0008U * VIDEO_SCREEN_WIDTH;

	ResetState();
	VideoAdapterType = VIDEO_ADAPTER_VGA;
	ActiveVideoAdapterType = VIDEO_ADAPTER_VGA;
	ActiveRenderTarget = fakeBackend.indexedFramebuffer;
	DrawClippedSprite(destination, sprite, 0x0000, 0x0000, 0x0002);

	assert(destination[row + 0x0010] == 0x05);
	assert(destination[row + 0x0017] == 0x0C);
	assert(fakeBackend.indexedFramebuffer[row + 0x0010] == 0x00);
	assert(ActiveRenderTarget == fakeBackend.indexedFramebuffer);
}

static void TestReentryGuardAndNullSprite(void)
{
	ResetState();
	EncodedSpriteClipLeftTile = 0x1234;
	SpriteDrawBusy = TRUE;
	DrawClippedSprite(NULL, NULL, 0x0000, 0x0000, 0x0002);
	assert(SpriteDrawBusy == TRUE);
	assert(EncodedSpriteClipLeftTile == 0x1234);

	SpriteDrawBusy = FALSE;
	DrawClippedSprite(NULL, NULL, 0x0000, 0x0000, 0x0002);
	assert(SpriteDrawBusy == FALSE);
	assert(EncodedSpriteClipLeftTile == 0x0002);
}

static void TestEgaMultipleColorsShareDestinationByte(void)
{
	/* Each pair is an EGA bit mask followed by colour/control flags.
	 * The first colour leaves bit 7 clear and therefore stays in the same
	 * eight-pixel destination byte.  E2h advances and terminates the row. */
	const byte sprite[] = {
		0x00, 0x00, 0x01, 0x00,
		0x80, 0x01,
		0x40, 0xE2
	};
	byte destination[VIDEO_SCREEN_WIDTH * VIDEO_SCREEN_HEIGHT] = { 0x00 };

	ResetState();
	EncodedSpriteClipLeftTile = 0x0000;
	SpriteClipRightTile = VIDEO_SCREEN_8PX_COLUMN_COUNT;
	SpriteClipTopPixel = 0x0000;
	EncodedSpriteClipBottomPixel = VIDEO_SCREEN_HEIGHT;
	DrawEGAEncodedSprite(destination, sprite, 0x0000, 0x0000);

	assert(destination[0x0000] == 0x01);
	assert(destination[0x0001] == 0x02);
	assert(destination[0x0009] == 0x00);
}

int main(void)
{
	TestVgaDispatchAndWindowRelativeCoordinates();
	TestExplicitDestinationIsHonored();
	TestReentryGuardAndNullSprite();
	TestEgaMultipleColorsShareDestinationByte();
	return 0;
}
