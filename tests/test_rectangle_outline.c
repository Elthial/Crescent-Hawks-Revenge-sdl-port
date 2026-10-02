#include "REVENGE.h"
#include "revenge/video.h"

#include <assert.h>

typedef struct LineCall
{
	int16 x1;
	int16 y1;
	int16 x2;
	int16 y2;
	word16 color;
} LineCall;

static LineCall lineCalls[0x04];
static word16 lineCallCount;

void DrawClippedAxisAlignedLine(
	int16 x1,
	int16 y1,
	int16 x2,
	int16 y2,
	word16 color)
{
	LineCall *call;

	call = &lineCalls[lineCallCount++];
	call->x1 = x1;
	call->y1 = y1;
	call->x2 = x2;
	call->y2 = y2;
	call->color = color;
}

int main(void)
{
	DrawClippedRectangleOutline(
		-0x0005, -0x0007, 0x0200, 0x0100, 0x000E);
	assert(lineCallCount == 0x0004);
	assert(lineCalls[0x00].x1 == VIDEO_SCREEN_MIN_X);
	assert(lineCalls[0x00].y1 == VIDEO_SCREEN_MIN_Y);
	assert(lineCalls[0x00].x2 == VIDEO_SCREEN_MAX_X);
	assert(lineCalls[0x00].y2 == VIDEO_SCREEN_MIN_Y);
	assert(lineCalls[0x01].x1 == VIDEO_SCREEN_MIN_X);
	assert(lineCalls[0x01].y1 == VIDEO_SCREEN_MAX_Y);
	assert(lineCalls[0x01].x2 == VIDEO_SCREEN_MAX_X);
	assert(lineCalls[0x01].y2 == VIDEO_SCREEN_MAX_Y);
	assert(lineCalls[0x02].x1 == VIDEO_SCREEN_MIN_X);
	assert(lineCalls[0x02].y1 == VIDEO_SCREEN_MIN_Y);
	assert(lineCalls[0x02].x2 == VIDEO_SCREEN_MIN_X);
	assert(lineCalls[0x02].y2 == VIDEO_SCREEN_MAX_Y);
	assert(lineCalls[0x03].x1 == VIDEO_SCREEN_MAX_X);
	assert(lineCalls[0x03].y1 == VIDEO_SCREEN_MIN_Y);
	assert(lineCalls[0x03].x2 == VIDEO_SCREEN_MAX_X);
	assert(lineCalls[0x03].y2 == VIDEO_SCREEN_MAX_Y);
	assert(lineCalls[0x03].color == 0x000E);
	return 0x00;
}
