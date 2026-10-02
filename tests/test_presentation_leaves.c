#include "REVENGE.h"

#include "fake_backend.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>
#include <string.h>

static void TestVgaPaletteBankAnchors(void)
{
	byte baseColors[0x30];
	word16 index;

	FakeBackend_Reset();
	for (index = 0x0000; index < 0x0030; ++index)
	{
		baseColors[index] = (byte) (index + 0x01);
		VideoPaletteData[index] = baseColors[index];
	}
	memset(VideoPaletteData + 0x0030, 0x00, 0x02D0);

	VideoAdapterType = VIDEO_ADAPTER_TANDY;
	InstallVgaPaletteBankAnchors();
	assert(fakeBackend.vgaPalette[0x0000] == 0x00);

	VideoAdapterType = VIDEO_ADAPTER_VGA;
	InstallVgaPaletteBankAnchors();
	for (index = 0x0000; index < 0x0010; ++index)
	{
		word16 sourceOffset = index * 0x0003;
		word16 destinationOffset = index * 0x0030;

		assert(memcmp(
			VideoPaletteData + destinationOffset,
			baseColors + sourceOffset,
			0x0003) == 0x00);
	}
	assert(memcmp(fakeBackend.vgaPalette, VideoPaletteData,
		0x0300) == 0x00);
}

static void TestFlushAndZeroDurationWait(void)
{
	FakeBackend_Reset();
	PendingMouseButtonEvent = TRUE;
	assert(FlushInputAndWait(0x0001) == 0x0000);
	assert(PendingMouseButtonEvent == FALSE);
}

int main(void)
{
	TestVgaPaletteBankAnchors();
	TestFlushAndZeroDurationWait();
	return 0;
}
