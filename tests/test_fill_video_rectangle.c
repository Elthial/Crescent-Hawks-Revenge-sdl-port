#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <stdio.h>
#include <stdlib.h>

typedef struct SpanCall
{
	int16 y;
	int16 leftX;
	int16 rightX;
	word16 color;
} SpanCall;

typedef struct TandyCall
{
	int16 leftX;
	int16 topY;
	int16 widthWords;
	int16 heightDelta;
	byte color;
} TandyCall;

static int failures;
static SpanCall spanCalls[0x08];
static TandyCall tandyCall;
static word16 spanCallCount;
static word16 tandyCallCount;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

void DrawHorizontalSpan(
	int16 y, int16 leftX, int16 rightX, word16 color)
{
	SpanCall *call = &spanCalls[spanCallCount++];
	call->y = y;
	call->leftX = leftX;
	call->rightX = rightX;
	call->color = color;
}

void FillTandyPackedRectangle(
	int16 leftX,
	int16 topY,
	word16 widthWords,
	int16 heightDelta,
	byte color)
{
	++tandyCallCount;
	tandyCall.leftX = leftX;
	tandyCall.topY = topY;
	tandyCall.widthWords = widthWords;
	tandyCall.heightDelta = heightDelta;
	tandyCall.color = color;
}

static void ResetCalls(void)
{
	spanCallCount = 0x00;
	tandyCallCount = 0x00;
}

static void TestInclusiveSpanFallback(void)
{
	ResetCalls();
	VideoAdapterType = VIDEO_ADAPTER_VGA;
	FillVideoRectangle(0x02, 0x03, 0x07, 0x05, 0x0123);

	Check(tandyCallCount == 0x00 && spanCallCount == 0x03,
		"ordinary adapters draw every inclusive scanline");
	Check(spanCalls[0x00].y == 0x03 &&
		spanCalls[0x02].y == 0x05,
		"fallback scanline loop includes both vertical endpoints");
	Check(spanCalls[0x01].leftX == 0x02 &&
		spanCalls[0x01].rightX == 0x07 &&
		spanCalls[0x01].color == 0x0123,
		"fallback forwards horizontal bounds and the full color word");
}

static void TestTandyPackedFastPath(void)
{
	ResetCalls();
	VideoAdapterType = VIDEO_ADAPTER_TANDY;
	FillVideoRectangle(0x02, 0x03, 0x07, 0x08, 0x0123);

	Check(spanCallCount == 0x00 && tandyCallCount == 0x01,
		"aligned Tandy rectangles use the packed fast path");
	Check(tandyCall.leftX == 0x02 && tandyCall.topY == 0x03 &&
		tandyCall.widthWords == 0x03 && tandyCall.heightDelta == 0x05 &&
		tandyCall.color == 0x23,
		"Tandy fast path uses packed width, height delta, and low color byte");
}

static void TestTandyAlignmentGuards(void)
{
	ResetCalls();
	VideoAdapterType = VIDEO_ADAPTER_TANDY;
	FillVideoRectangle(0x03, 0x01, 0x07, 0x01, 0x04);
	Check(tandyCallCount == 0x00 && spanCallCount == 0x01,
		"an odd left edge disables the Tandy fast path");

	ResetCalls();
	FillVideoRectangle(0x02, 0x01, 0x08, 0x01, 0x04);
	Check(tandyCallCount == 0x00 && spanCallCount == 0x01,
		"an even right edge disables the Tandy fast path");
}

int main(void)
{
	TestInclusiveSpanFallback();
	TestTandyPackedFastPath();
	TestTandyAlignmentGuards();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
