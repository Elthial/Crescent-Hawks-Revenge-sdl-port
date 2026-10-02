#include "revenge/platform_backend.h"
#include "revenge/video.h"
#include "revenge/original_data.h"

#include <stdint.h>

byte *Video_GetIndexedFramebuffer(void)
{
	return SDLBackend_GetIndexedFramebuffer();
}

void Video_ClearIndexedFramebuffer(byte color)
{
	SDLBackend_ClearIndexedFramebuffer(color);
}

byte *Video_ResolveIndexedRenderTarget(const byte *renderTarget)
{
	uintptr_t encodedTarget = (uintptr_t) renderTarget;

	if (renderTarget == VideoFramebuffer || encodedTarget == 0xA0000000UL)
		return SDLBackend_GetIndexedFramebuffer();
	if (renderTarget == PrimaryScreenBuffer ||
		encodedTarget == 0xA2000000UL)
		return PrimaryScreenBuffer;
	return (byte *) renderTarget;
}

void Video_DrawIndexedPixelToActiveTarget(word16 x, word16 y, byte color)
{
	byte *target;

	if (x >= VIDEO_SCREEN_WIDTH || y >= VIDEO_SCREEN_HEIGHT)
		return;
	target = Video_ResolveIndexedRenderTarget(ActiveRenderTarget);
	if (target == NULL)
		target = SDLBackend_GetIndexedFramebuffer();
	target[(uint32) y * VIDEO_SCREEN_WIDTH + x] = color;
}
