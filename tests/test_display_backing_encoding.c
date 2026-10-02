#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int failures;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

static void TestPackLowNibbles(void)
{
	static byte source[0xFA00];
	static byte destination[0x7D00];
	word16 index;

	for (index = 0x0000; index < 0x7D00; ++index)
	{
		source[index * 0x02] = (byte) (index + 0xA0);
		source[index * 0x02 + 0x01] = (byte) (index + 0x05);
	}
	PackLowNibblesTo4Bpp(source, destination);
	Check(destination[0x0000] == 0x05,
		"packed screen combines the first two low nibbles");
	Check(destination[0x0001] == 0x16,
		"packed screen advances by two source bytes");
	Check(destination[0x7CFF] == 0xF4,
		"packed screen processes exactly 7D00h output bytes");
}

static void TestTacticalOverviewTranslation(void)
{
	const byte source[] =
	{
		0x00, 0x7F, 0x80, 0x9F, 0xA0,
		0xBF, 0xC0, 0xC5, 0xC6, 0xFF
	};
	const byte expected[] =
	{
		0x77, 0x77, 0xEE, 0xEE, 0x33, 0x33, 0xAA, 0xAA,
		0x00, 0x00, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77
	};
	byte destination[0x10];

	memset(destination, 0xCC, sizeof(destination));
	BuildTacticalOverviewMapBuffer(
		source, destination, 0x0008, 0x0001);
	BuildTacticalOverviewMapBuffer(
		source + 0x0008, destination + 0x0008, 0x0002, 0x0001);
	Check(memcmp(destination, expected, sizeof(expected)) == 0x00,
		"overview map uses the CS:04C9 colors and pads rows to eight bytes");
}

static void TestTacticalLookupAndOverlayState(void)
{
	memset(TacticalEffectOverlayMap, 0xA5,
		sizeof(TacticalEffectOverlayMap));
	ClearTacticalEffectOverlayMap();
	Check(TacticalEffectOverlayMap[0x0000] == 0x00 &&
		TacticalEffectOverlayMap[0x00E3] == 0x00,
		"overlay clear covers the complete E4h-byte tactical map");

	DamagedTerrainSpriteLookup = NULL;
	InstallDamagedTerrainSpriteLookup();
	Check(DamagedTerrainSpriteLookup ==
		(byte *) HostFarPointer_Resolve(0x080001C9UL),
		"damaged-terrain lookup installer publishes CS:01C9 itself");
}

static void TestPackedAdapterRows(void)
{
	const byte source[] =
	{
		0x10, 0x11, 0x20, 0x21, 0xEE,
		0x30, 0x31, 0x40, 0x41, 0xDD
	};
	byte destination[0x10];
	word16 length;

	memset(destination, 0xCC, sizeof(destination));
	ActiveVideoAdapterType = VIDEO_ADAPTER_CGA;
	length = EncodeDisplayBackingRows(
		source, destination, 0x02, 0x02, 0x01);
	Check(length == 0x04 && destination[0x00] == 0x10 &&
		destination[0x01] == 0x20 && destination[0x02] == 0x30 &&
		destination[0x03] == 0x40,
		"CGA rows retain every other packed source byte");

	memset(destination, 0xCC, sizeof(destination));
	ActiveVideoAdapterType = VIDEO_ADAPTER_TANDY;
	length = EncodeDisplayBackingRows(
		source, destination, 0x02, 0x02, 0x01);
	Check(length == 0x08 &&
		memcmp(destination, "\x10\x11\x20\x21\x30\x31\x40\x41", 0x08) == 0x00,
		"Tandy rows retain both bytes in each source group");
}

static void TestEgaSparseRows(void)
{
	const byte source[] =
	{
		0x12, 0x34, 0x12, 0x34,
		0x00, 0x00, 0x00, 0x00
	};
	const byte expected[] =
	{
		0x88, 0x01,
		0x44, 0x02,
		0x22, 0x03,
		0x11, 0x84,
		0x00, 0xE0
	};
	byte destination[0x20];
	word16 packedPixels = 0xABCD;
	word16 length;

	Check(ExtractHighNibbleAndShiftLeft(&packedPixels) == 0x0A &&
		packedPixels == 0xBCD0,
		"nibble helper returns bits 15..12 and shifts BX left four times");

	memset(destination, 0xCC, sizeof(destination));
	ActiveVideoAdapterType = VIDEO_ADAPTER_EGA;
	length = EncodeDisplayBackingRows(
		source, destination, 0x02, 0x01, 0x00);
	Check(length == sizeof(expected),
		"EGA sparse encoding returns its emitted byte count");
	Check(memcmp(destination, expected, sizeof(expected)) == 0x00,
		"EGA sparse encoding preserves color masks and terminator flags");
}

static void TestCgaAlternateScanlines(void)
{
	static byte screenBuffer[0x7CC0];
	word16 row;

	memset(screenBuffer, 0xCC, sizeof(screenBuffer));
	for (row = 0x0000; row < 0x00FA; ++row)
		memset(screenBuffer + row * 0x0040, (byte) row, 0x0040);
	RepackCgaAlternateScanlines(screenBuffer);
	Check(screenBuffer[0x0000] == 0x00 && screenBuffer[0x003F] == 0x00,
		"CGA repack retains the first packed scanline");
	Check(screenBuffer[0x0080] == 0x01 && screenBuffer[0x00BF] == 0x01,
		"CGA repack doubles the destination row stride");
	Check(screenBuffer[0x7C80] == 0xF9 && screenBuffer[0x7CBF] == 0xF9,
		"CGA repack copies backwards through all FAh rows");
}

static void TestEgaPlaneTranspose(void)
{
	const byte source[0x04] = { 0x12, 0x34, 0x56, 0x78 };
	const byte expected[0x04] = { 0xAA, 0x66, 0x1E, 0x01 };
	byte destination[0x04] = { 0x00 };
	byte plane0 = 0x00;
	byte plane1 = 0x00;
	byte plane2 = 0x00;
	byte plane3 = 0x00;

	ShiftPackedPixelsIntoEGAPlanes(
		0xD0, &plane3, &plane2, &plane1, &plane0);
	Check(plane3 == 0x01 && plane2 == 0x01 &&
		plane1 == 0x00 && plane0 == 0x01,
		"EGA carry-chain helper distributes a high nibble across planes");

	ConvertPackedPixelsToEGAPlanar(source, destination, 0x02);
	Check(memcmp(destination, expected, sizeof(expected)) == 0x00,
		"packed pixels transpose to the original four EGA plane bytes");
}

static void InstallTestCgaLookups(void)
{
	word16 value;

	for (value = 0x0000; value < 0x0100; ++value)
	{
		CgaEvenPixelPhaseLookup[value] = (byte) (value & 0x0F);
		CgaOddPixelPhaseLookup[value] = (byte) (value >> 0x04);
	}
}

static void TestCgaPixelConversion(void)
{
	const byte source[] = { 0x12, 0x34, 0x56, 0x78 };
	byte destination[0x02] = { 0x00 };
	static byte maskedBuffer[0x7D00];
	word16 pair;

	InstallTestCgaLookups();
	ConvertCgaPackedPixels(source, destination, 0x01, 0x02);
	Check(destination[0x00] == 0x24 && destination[0x01] == 0x57,
		"CGA conversion alternates even and odd lookup phases");

	for (pair = 0x0000; pair < 0x3E80; ++pair)
	{
		maskedBuffer[pair * 0x02] = 0x12;
		maskedBuffer[pair * 0x02 + 0x01] = 0x34;
	}
	ConvertCgaPackedPixelsAndBuildMask(maskedBuffer, FALSE);
	Check(maskedBuffer[0x0000] == 0x24 && maskedBuffer[0x0001] == 0x00,
		"CGA masked conversion emits even-phase pixels and opacity mask");
	Check(maskedBuffer[0x00A0] == 0x13 && maskedBuffer[0x00A1] == 0x00,
		"CGA masked conversion changes phase after 50h pairs");
}

int main(void)
{
	TestTacticalOverviewTranslation();
	TestTacticalLookupAndOverlayState();
	TestPackLowNibbles();
	TestPackedAdapterRows();
	TestEgaSparseRows();
	TestCgaAlternateScanlines();
	TestEgaPlaneTranspose();
	TestCgaPixelConversion();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
