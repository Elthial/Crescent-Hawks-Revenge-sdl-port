#include "fake_backend.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <assert.h>
#include <string.h>

void SetActiveRenderTarget(byte *renderTarget);
void Draw8x8VideoTile(
    const byte *tilePixels,
    int16 x,
    word16 y);

int main(void)
{
    static byte packedScreen[0x7D00];
    static byte primaryScreen[VIDEO_SCREEN_WIDTH * VIDEO_SCREEN_HEIGHT];
    byte vgaPalette[VGA_PALETTE_BYTE_COUNT];
    byte planarTile[0x20];
    word16 pixel;

    FakeBackend_Reset();
    fakeBackend.videoMode = 0x03;

    assert(GetCurrentBIOSVideoMode() == 0x03);
    SavedBIOSVideoMode = GetCurrentBIOSVideoMode();
    SetVideoModeForAdapter(VIDEO_ADAPTER_CGA);
    assert(fakeBackend.videoAdapter == VIDEO_ADAPTER_CGA);
    assert(fakeBackend.videoMode == 0x04);

    SetVideoModeForAdapter(VIDEO_ADAPTER_EGA);
    assert(fakeBackend.videoAdapter == VIDEO_ADAPTER_EGA);
    assert(fakeBackend.videoMode == 0x0D);

    SetVideoModeForAdapter(0x0004);
    assert(fakeBackend.videoMode == 0x07);
    SetVideoModeForAdapter(0x0005);
    assert(fakeBackend.videoMode == 0x02);
    SetVideoModeForAdapter(0x0006);
    assert(fakeBackend.videoMode == 0x03);

    BIOS_SelectCgaPalette(0x01);
    assert(fakeBackend.paletteValue == 0x01);
    EGA_SetPaletteRegister(0x0A, 0x3E);
    assert(fakeBackend.paletteRegister == 0x0A);
    assert(fakeBackend.paletteValue == 0x3E);
    memset(vgaPalette, 0x2A, sizeof(vgaPalette));
    VGA_LoadPalette(vgaPalette);
    assert(memcmp(fakeBackend.vgaPalette, vgaPalette,
        sizeof(vgaPalette)) == 0x00);
    Video_ClearIndexedFramebuffer(0xA5);
    assert(fakeBackend.indexedFramebuffer[0x0000] == 0xA5);
    DrawClippedPixel(0x0001, 0x0001, 0x00C7);
    assert(fakeBackend.indexedFramebuffer[0x0141] == 0xC7);

    ActiveVideoAdapterType = VIDEO_ADAPTER_TANDY;
    FillTandyPackedRectangle(0x0002, 0x0003, 0x0001, 0x0001, 0x0D);
    assert(fakeBackend.indexedFramebuffer[0x0003 * 0x0140 + 0x0002] == 0x0D);
    assert(fakeBackend.indexedFramebuffer[0x0004 * 0x0140 + 0x0005] == 0x0D);

    ActiveVideoAdapterType = VIDEO_ADAPTER_CGA;
    DrawVerticalSpan(0x0007, 0x0005, 0x0007, 0x0006);
    assert(fakeBackend.indexedFramebuffer[0x0005 * 0x0140 + 0x0007] == 0x02);
    assert(fakeBackend.indexedFramebuffer[0x0007 * 0x0140 + 0x0007] == 0x02);
    DrawHorizontalVideoRun(0x0008, 0x0009, 0x0002, 0x0007);
    assert(fakeBackend.indexedFramebuffer[0x0009 * 0x0140 + 0x0008] == 0x03);
    assert(fakeBackend.indexedFramebuffer[0x0009 * 0x0140 + 0x000F] == 0x03);
    assert(fakeBackend.indexedFramebuffer[0x0009 * 0x0140 + 0x0010] == 0xA5);

    Video_ClearIndexedFramebuffer(0x05);
    ActiveVideoAdapterType = VIDEO_ADAPTER_EGA;
    FillVideoTileRectangle(0x0002, 0x0003, 0x0004, 0x0002, 0x00);
    assert(fakeBackend.indexedFramebuffer[0x0018 * 0x0140 + 0x0010] == 0x00);
    assert(fakeBackend.indexedFramebuffer[0x0027 * 0x0140 + 0x002F] == 0x00);
    assert(fakeBackend.indexedFramebuffer[0x0017 * 0x0140 + 0x0010] == 0x05);
    assert(fakeBackend.indexedFramebuffer[0x0018 * 0x0140 + 0x0030] == 0x05);

    /* EGA's original A200 work page is a separate indexed host buffer. */
    memset(primaryScreen, 0x05, sizeof(primaryScreen));
    PrimaryScreenBuffer = primaryScreen;
    VideoFramebuffer = (byte *)(uintptr_t)0xA0000000UL;
    SetActiveRenderTarget(primaryScreen);
    DrawClippedPixel(0x000A, 0x000B, 0x000C);
    FillVideoTileRectangle(0x0002, 0x0003, 0x0001, 0x0001, 0x00);
    assert(primaryScreen[0x000B * VIDEO_SCREEN_WIDTH + 0x000A] == 0x0C);
    assert(primaryScreen[0x0018 * VIDEO_SCREEN_WIDTH + 0x0010] == 0x00);
    assert(fakeBackend.indexedFramebuffer[0x000B * VIDEO_SCREEN_WIDTH +
        0x000A] == 0x05);
    VideoFramebuffer = NULL;
    ActiveRenderTarget = NULL;

    memset(packedScreen, 0x00, sizeof(packedScreen));
    packedScreen[0x0000] = 0xA5;
    packedScreen[0x7CFF] = 0x3C;
    EGA_ConvertPackedScreenToPlanar(packedScreen, 0xA000);
    assert(fakeBackend.indexedFramebuffer[0x0000] == 0x0A);
    assert(fakeBackend.indexedFramebuffer[0x0001] == 0x05);
    assert(fakeBackend.indexedFramebuffer[0xF9FE] == 0x03);
    assert(fakeBackend.indexedFramebuffer[0xF9FF] == 0x0C);

    Video_ClearIndexedFramebuffer(0x05);
    ActiveVideoAdapterType = VIDEO_ADAPTER_EGA;
    XorVideoRectangle(0x0003, 0x0004, 0x0001, 0x0002, 0x0F);
    assert(fakeBackend.indexedFramebuffer[0x0002 * 0x0140 + 0x0001] == 0x0A);
    assert(fakeBackend.indexedFramebuffer[0x0004 * 0x0140 + 0x0003] == 0x0A);
    assert(fakeBackend.indexedFramebuffer[0x0001 * 0x0140 + 0x0001] == 0x05);

    memset(fakeBackend.indexedFramebuffer, 0x00,
        sizeof(fakeBackend.indexedFramebuffer));
    for (pixel = 0x0000; pixel < 0x0008; ++pixel)
        fakeBackend.indexedFramebuffer[0x0008 * 0x0140 + 0x0008 + pixel] =
            (byte) pixel;
    memset(planarTile, 0x00, sizeof(planarTile));
    ReadEGAPlanarTile(planarTile, 0x0001, 0x0001);
    assert(planarTile[0x00] == 0x55);
    assert(planarTile[0x01] == 0x33);
    assert(planarTile[0x02] == 0x0F);
    assert(planarTile[0x03] == 0x00);

    /* The DOS routine writes four EGA planes through a 40-byte hardware
       scanline.  The SDL boundary must expand those bytes into the linear
       320-byte indexed framebuffer instead of folding the tile toward the
       top-left corner. */
    for (pixel = 0x0000; pixel < 0x0008; ++pixel)
    {
        planarTile[pixel * 0x04 + 0x00] = 0xAA;
        planarTile[pixel * 0x04 + 0x01] = 0xCC;
        planarTile[pixel * 0x04 + 0x02] = 0xF0;
        planarTile[pixel * 0x04 + 0x03] = 0x00;
    }
    Video_ClearIndexedFramebuffer(0xA5);
    Draw8x8VideoTile(planarTile, 0x0005, 0x0003);
    for (pixel = 0x0000; pixel < 0x0008; ++pixel)
    {
        assert(fakeBackend.indexedFramebuffer[
            0x0018 * VIDEO_SCREEN_WIDTH + 0x0028 + pixel] ==
            (byte)(0x07 - pixel));
    }
    assert(fakeBackend.indexedFramebuffer[
        0x0003 * VIDEO_SCREEN_WIDTH + 0x0005] == 0xA5);

    Video_ClearIndexedFramebuffer(0xA5);
    ClearActiveVideoBuffer();
    assert(fakeBackend.indexedFramebuffer[0x0000] == 0x00);
    assert(fakeBackend.indexedFramebuffer[0xF9FF] == 0x00);
    assert(IsVerticalRetraceActive() == 0x0008);

    VerticalRetraceEdgeMode = VERTICAL_RETRACE_WAIT_FOR_END;
    WaitVerticalRetraces(0x0003);
    assert(fakeBackend.retraceCount == 0x0003);
    assert(fakeBackend.firstByte == VERTICAL_RETRACE_WAIT_FOR_END);

    return 0x00;
}
