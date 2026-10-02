#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>
#include <string.h>

static byte *egaDestination;
static int16 egaByteColumn;
static word16 egaTileRow;

void ReadEGAPlanarTile(
	byte *destination,
	int16 sourceByteColumn,
	word16 sourceTileRow)
{
	egaDestination = destination;
	egaByteColumn = sourceByteColumn;
	egaTileRow = sourceTileRow;
}

static void FillRowMarkers(byte *framebuffer, word16 rowStride,
	word16 firstOffset, word16 copiedBytes)
{
	word16 column;
	word16 row;

	for (row = 0x0000; row < 0x0008; ++row)
	{
		for (column = 0x0000; column < copiedBytes; ++column)
		{
			framebuffer[firstOffset + row * rowStride + column] =
				(byte)(row * 0x10 + column);
		}
	}
}

static void AssertCapturedRows(const byte *destination, word16 copiedBytes)
{
	word16 column;
	word16 row;

	for (row = 0x0000; row < 0x0008; ++row)
	{
		for (column = 0x0000; column < copiedBytes; ++column)
		{
			assert(destination[row * copiedBytes + column] ==
				(byte)(row * 0x10 + column));
		}
	}
}

static void TestPackedAdapter(word16 adapterType, word16 rowStride,
	word16 tileRowStride, word16 tileByteWidth)
{
	byte framebuffer[0x2000];
	byte destination[0x0040];
	word16 firstOffset;

	memset(framebuffer, 0xCC, sizeof(framebuffer));
	memset(destination, 0xDD, sizeof(destination));
	firstOffset = (word16)(tileRowStride + tileByteWidth);
	FillRowMarkers(framebuffer, rowStride, firstOffset, tileByteWidth);
	VideoAdapterType = adapterType;
	Capture8x8VideoTile(framebuffer, destination, 0x0001, 0x0001);
	AssertCapturedRows(destination, tileByteWidth);
}

int main(void)
{
	byte destination[0x0040];

	TestPackedAdapter(VIDEO_ADAPTER_VGA, 0x0140, 0x0A00, 0x0008);
	TestPackedAdapter(VIDEO_ADAPTER_CGA, 0x0050, 0x0280, 0x0002);
	TestPackedAdapter(VIDEO_ADAPTER_TANDY, 0x00A0, 0x0500, 0x0004);

	VideoAdapterType = VIDEO_ADAPTER_EGA;
	Capture8x8VideoTile(0, destination, -0x03, 0x0007);
	assert(egaDestination == destination);
	assert(egaByteColumn == -0x03);
	assert(egaTileRow == 0x0007);
	return 0;
}
