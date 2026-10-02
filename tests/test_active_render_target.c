#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <stdio.h>
#include <stdlib.h>

static int failures;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

static byte primaryBuffer[0x10];
static byte ordinaryBuffer[0x10];
static byte nonPrimaryBuffer[0x10];
static byte egaOffscreenBuffer[0x10];

static void TestOrdinaryTarget(void)
{
	VideoAdapterType = VIDEO_ADAPTER_VGA;
	PrimaryScreenBuffer = primaryBuffer;
	SetActiveRenderTarget(ordinaryBuffer);

	Check(ActiveRenderTarget == ordinaryBuffer,
		"ordinary targets retain the selected buffer");
}

static void TestNonPrimaryEgaTarget(void)
{
	VideoAdapterType = VIDEO_ADAPTER_EGA;
	PrimaryScreenBuffer = primaryBuffer;
	SetActiveRenderTarget(nonPrimaryBuffer);

	Check(ActiveRenderTarget == nonPrimaryBuffer,
		"EGA leaves a non-primary render target unchanged");
}

static void TestPrimaryEgaTarget(void)
{
	VideoAdapterType = VIDEO_ADAPTER_EGA;
	HostFarPointer_Reset();
	HostFarPointer_RegisterAt(egaOffscreenBuffer, sizeof(egaOffscreenBuffer),
		MAKE_DWORD(EGA_OFFSCREEN_FRAMEBUFFER_SEGMENT,
			EGA_OFFSCREEN_FRAMEBUFFER_OFFSET));
	PrimaryScreenBuffer = primaryBuffer;
	SetActiveRenderTarget(primaryBuffer);

	Check(ActiveRenderTarget == egaOffscreenBuffer,
		"EGA maps the primary backing buffer to A200:0000");
}

int main(void)
{
	TestOrdinaryTarget();
	TestNonPrimaryEgaTarget();
	TestPrimaryEgaTarget();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
