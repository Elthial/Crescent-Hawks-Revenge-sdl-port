#include "fake_backend.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>

static void ResetSpriteState(void)
{
	FakeBackend_Reset();
	EncodedSpriteClipLeftTile = 0x0000;
	SpriteClipRightTile = VIDEO_SCREEN_8PX_COLUMN_COUNT;
	SpriteClipTopPixel = 0x0000;
	EncodedSpriteClipBottomPixel = VIDEO_SCREEN_HEIGHT;
	SpritePreserveMode = FALSE;
}

static void TestTandyPackedSprite(void)
{
	const byte sprite[] = {
		0x00, 0x00, 0x01, 0x00,
		0xA0, 0x03, 0x40, 0x50
	};

	ResetSpriteState();
	ActiveVideoAdapterType = VIDEO_ADAPTER_TANDY;
	fakeBackend.indexedFramebuffer[0x0001 * VIDEO_SCREEN_WIDTH + 0x0003] = 0x07;
	DrawCgaTandyEncodedSprite(NULL, sprite, 0x0002, 0x0001);
	assert(fakeBackend.indexedFramebuffer[0x0001 * VIDEO_SCREEN_WIDTH + 0x0002] == 0x0A);
	assert(fakeBackend.indexedFramebuffer[0x0001 * VIDEO_SCREEN_WIDTH + 0x0003] == 0x07);
	assert(fakeBackend.indexedFramebuffer[0x0001 * VIDEO_SCREEN_WIDTH + 0x0005] == 0x03);
	assert(fakeBackend.indexedFramebuffer[0x0001 * VIDEO_SCREEN_WIDTH + 0x0008] == 0x05);
}

static void TestCgaMaskedSprite(void)
{
	const byte sprite[] = {
		0x00, 0x00, 0x01, 0x00,
		0x1B, 0x30,
		0x00, 0xCF
	};

	ResetSpriteState();
	ActiveVideoAdapterType = VIDEO_ADAPTER_CGA;
	fakeBackend.indexedFramebuffer[0x0000] = 0x03;
	fakeBackend.indexedFramebuffer[0x0004] = 0x03;
	fakeBackend.indexedFramebuffer[0x0006] = 0x02;
	DrawCgaTandyEncodedSprite(NULL, sprite, 0x0000, 0x0000);
	assert(fakeBackend.indexedFramebuffer[0x0000] == 0x00);
	assert(fakeBackend.indexedFramebuffer[0x0001] == 0x01);
	assert(fakeBackend.indexedFramebuffer[0x0002] == 0x02);
	assert(fakeBackend.indexedFramebuffer[0x0003] == 0x03);
	assert(fakeBackend.indexedFramebuffer[0x0004] == 0x03);
	assert(fakeBackend.indexedFramebuffer[0x0006] == 0x02);
}

static void TestEgaTokenSprite(void)
{
	const byte sprite[] = {
		0x00, 0x00, 0x00, 0x00,
		0x81, 0xE3
	};

	ResetSpriteState();
	ActiveVideoAdapterType = VIDEO_ADAPTER_EGA;
	fakeBackend.indexedFramebuffer[0x0001] = 0x06;
	DrawEGAEncodedSprite(NULL, sprite, 0x0000, 0x0000);
	assert(fakeBackend.indexedFramebuffer[0x0000] == 0x03);
	assert(fakeBackend.indexedFramebuffer[0x0001] == 0x06);
	assert(fakeBackend.indexedFramebuffer[0x0007] == 0x03);
}

static void TestVgaRleSprite(void)
{
	const byte sprite[] = {
		0x00, 0x00, 0x01, 0x00,
		0x05, 0x00, 0x03, 0x07, 0x08, 0x09, 0x0A
	};

	ResetSpriteState();
	ActiveVideoAdapterType = VIDEO_ADAPTER_VGA;
	fakeBackend.indexedFramebuffer[0x0003] = 0x0E;
	DrawVgaRleSprite(NULL, sprite, 0x0000, 0x0000);
	assert(fakeBackend.indexedFramebuffer[0x0000] == 0x05);
	assert(fakeBackend.indexedFramebuffer[0x0001] == 0x00);
	assert(fakeBackend.indexedFramebuffer[0x0003] == 0x0E);
	assert(fakeBackend.indexedFramebuffer[0x0004] == 0x07);
	assert(fakeBackend.indexedFramebuffer[0x0007] == 0x0A);
}

static void TestSpriteClipRectangle(void)
{
	const byte sprite[] = {
		0x00, 0x00, 0x01, 0x00,
		0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08
	};

	ResetSpriteState();
	ActiveVideoAdapterType = VIDEO_ADAPTER_VGA;
	EncodedSpriteClipLeftTile = 0x0001;
	SpriteClipRightTile = 0x0002;
	DrawVgaRleSprite(NULL, sprite, 0x0004, 0x0000);
	assert(fakeBackend.indexedFramebuffer[0x0007] == 0x00);
	assert(fakeBackend.indexedFramebuffer[0x0008] == 0x05);
	assert(fakeBackend.indexedFramebuffer[0x000B] == 0x08);
}

int main(void)
{
	TestTandyPackedSprite();
	TestCgaMaskedSprite();
	TestEgaTokenSprite();
	TestVgaRleSprite();
	TestSpriteClipRectangle();
	return 0;
}
