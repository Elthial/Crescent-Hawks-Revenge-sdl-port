#include "fake_backend.h"
#include "revenge/far_memory.h"
#include "revenge/original_data.h"
#include "revenge/text.h"
#include "revenge/video.h"

#include <assert.h>
#include <string.h>

static byte fontResource[0x0200];

static void SetFontWord(word16 offset, word16 value)
{
	fontResource[offset] = (byte) value;
	fontResource[offset + 0x01] = (byte) (value >> 0x08);
}

static void PrepareFont(void)
{
	memset(fontResource, 0x00, sizeof(fontResource));
	FakeBackend_Reset();
	HostFarPointer_Reset();
	ActiveVideoAdapterType = VIDEO_ADAPTER_VGA;
	fontResource[0x0102] = 0x02;
	fontResource[0x0103] = 0x06;
	SetFontWord((0x41 + 0x01) << 0x01, 0x0104);
	fontResource[0x0104] = 0xA8;
	fontResource[0x0105] = 0x54;
	SetActiveFontResource(fontResource);
}

static void TestGlyphRaster(void)
{
	PrepareFont();
	DrawTextString("A", 0x0001, 0x0001, 0x05, 0x02);
	assert(fakeBackend.indexedFramebuffer[0x0001 * 0x0140 + 0x0001] == 0x05);
	assert(fakeBackend.indexedFramebuffer[0x0001 * 0x0140 + 0x0002] == 0x02);
	assert(fakeBackend.indexedFramebuffer[0x0001 * 0x0140 + 0x0003] == 0x05);
	assert(fakeBackend.indexedFramebuffer[0x0002 * 0x0140 + 0x0001] == 0x02);
	assert(fakeBackend.indexedFramebuffer[0x0002 * 0x0140 + 0x0002] == 0x05);
}

static void TestTransparentColors(void)
{
	PrepareFont();
	fakeBackend.indexedFramebuffer[0x0000] = 0x0E;
	fakeBackend.indexedFramebuffer[0x0001] = 0x0D;
	DrawTextString("A", 0x0000, 0x0000, 0x00, 0x00);
	assert(fakeBackend.indexedFramebuffer[0x0000] == 0x0E);
	assert(fakeBackend.indexedFramebuffer[0x0001] == 0x0D);
}

static void TestCarriageReturn(void)
{
	PrepareFont();
	DrawTextString("A\rA", 0x0003, 0x0004, 0x07, 0x00);
	assert(fakeBackend.indexedFramebuffer[0x0004 * 0x0140 + 0x0003] == 0x07);
	assert(fakeBackend.indexedFramebuffer[0x0006 * 0x0140 + 0x0003] == 0x07);
}

int main(void)
{
	TestGlyphRaster();
	TestTransparentColors();
	TestCarriageReturn();
	return 0;
}
