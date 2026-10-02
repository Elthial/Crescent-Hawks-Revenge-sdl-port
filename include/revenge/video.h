#ifndef REVENGE_VIDEO_H
#define REVENGE_VIDEO_H

#include "revenge/types.h"
#include "revenge/far_memory.h"

enum
{
    VIDEO_SCREEN_WIDTH = 0x0140,
    VIDEO_SCREEN_HEIGHT = 0x00C8,
    VIDEO_SCREEN_MIN_X = 0x0000,
    VIDEO_SCREEN_MAX_X = VIDEO_SCREEN_WIDTH - 0x0001,
    VIDEO_SCREEN_MIN_Y = 0x0000,
    VIDEO_SCREEN_MAX_Y = VIDEO_SCREEN_HEIGHT - 0x0001,
    VIDEO_SCREEN_8PX_COLUMN_COUNT = 0x0028,
    VIDEO_SCREEN_MIN_COLUMN = 0x0000,
    EGA_OFFSCREEN_FRAMEBUFFER_OFFSET = 0x0000,
    EGA_OFFSCREEN_FRAMEBUFFER_SEGMENT = 0xA200,
    EGA_LOGICAL_PALETTE_ENTRY_COUNT = 0x10,
    VGA_DAC_ENTRY_COUNT = 0x0100,
    VGA_PALETTE_BYTE_COUNT = 0x0300,
    VIDEO_ADAPTER_CGA = 0x00,
    VIDEO_ADAPTER_TANDY = 0x01,
    VIDEO_ADAPTER_EGA = 0x02,
    VIDEO_ADAPTER_VGA = 0x03,
    VIDEO_ADAPTER_MCGA_CONFIG = 0x07,
    VERTICAL_RETRACE_WAIT_FOR_END = 0x00,
    VERTICAL_RETRACE_WAIT_FOR_START = 0x01
};

/* Native view of the original A200:0000 EGA shadow framebuffer. */
#define EGA_OFFSCREEN_FRAMEBUFFER \
    ((byte *)HostFarPointer_Resolve(MAKE_DWORD( \
        EGA_OFFSCREEN_FRAMEBUFFER_SEGMENT, \
        EGA_OFFSCREEN_FRAMEBUFFER_OFFSET)))

extern word16 VerticalRetraceEdgeMode;

uint16 GetCurrentBIOSVideoMode(void);
void SetVideoModeForAdapter(uint16 adapterOrRestoreSlot);
void BIOS_SelectCgaPalette(byte paletteId);
void EGA_SetPaletteRegister(byte paletteRegister, byte paletteValue);
void VGA_LoadPalette(const byte *paletteRgbTriplets);
void SetVideoAdapterType(uint16 adapterType);
uint16 IsVerticalRetraceActive(void);
void WaitForVerticalRetraceEdge(byte waitForRetraceStart);
void WaitVerticalRetraces(word16 retraceCount);
byte *Video_GetIndexedFramebuffer(void);
void Video_ClearIndexedFramebuffer(byte color);
/* Host termination points for original procedures which address DOS video
 * pages through segment-shaped pointer values. */
byte *Video_ResolveIndexedRenderTarget(const byte *renderTarget);
void Video_DrawIndexedPixelToActiveTarget(word16 x, word16 y, byte color);
/* SDL replacement for the visibility of an immediate write to DOS video
 * memory.  Use only for transient frames which the preserved game draws and
 * then overwrites before the host's ordinary presentation poll. */
void Video_PresentTransientFrame(void);
void DrawClippedPixel(int16 x, int16 y, uint16 color);
void DrawClippedAxisAlignedLine(
    int16 x1,
    int16 y1,
    int16 x2,
    int16 y2,
    uint16 color);
void DrawClippedRectangleOutline(
    int16 left,
    int16 top,
    int16 right,
    int16 bottom,
    uint16 color);
void FillVideoRectangle(
    int16 leftX,
    int16 topY,
    int16 rightX,
    int16 bottomY,
    uint16 color);
void XorVideoRectangle(
    int16 leftX,
    int16 topY,
    int16 rightX,
    int16 bottomY,
    byte color);
void EGA_ConvertPackedScreenToPlanar(
    const byte *packedPixels,
    uint16 destinationVideoSegment);
void CopyBufferToVideoRegion(
    int16 xColumn,
    uint16 yCharacterRow,
    uint16 widthColumns,
    uint16 heightCharacterRows,
    const byte *source);
void CopyVideoRegionToBuffer(
    int16 xColumn,
    uint16 yCharacterRow,
    uint16 widthColumns,
    uint16 heightCharacterRows,
    byte *destination);
void FillVideoTileRectangle(
    int16 tileX,
    uint16 tileY,
    uint16 widthTiles,
    uint16 heightTiles,
    byte color);
void CopyClippedVideoRegion(
    int16 sourceXColumn,
    int16 sourceY,
    int16 destinationXColumn,
    int16 destinationY,
    uint16 widthColumns,
    uint16 heightPixels,
    const byte *source,
    byte *destination);
void ClearActiveVideoBuffer(void);
void FillTandyPackedRectangle(
    int16 leftX,
    int16 topY,
    uint16 packedWidthMinusOne,
    int16 heightMinusOne,
    byte color);
void ReadEGAPlanarTile(
    byte *destination,
    int16 sourceByteColumn,
    uint16 sourceTileRow);
void DrawVerticalSpan(
    uint16 x,
    uint16 yStart,
    uint16 yEnd,
    uint16 color);
void DrawHorizontalVideoRun(
    int16 x,
    word16 y,
    word16 nativeRunLength,
    word16 color);
void DrawNonEgaTacticalTile(
    const byte *spritePage,
    word16 spriteId,
    word16 destinationX,
    word16 destinationY);
void DrawEgaTacticalTile(
    const byte *spritePage,
    word16 spriteId,
    word16 destinationX,
    word16 destinationY);
void DrawTacticalTileSprite(
    const byte *spritePage,
    word16 spriteId,
    word16 destinationX,
    word16 destinationY);
void DrawCgaCompositeTacticalTile(
    word16 foregroundSpriteId,
    word16 backgroundSpriteId,
    const byte *spritePage,
    word16 destinationX,
    word16 destinationY);
void DrawCgaHighSpriteTile(
    const byte *spritePage,
    word16 spriteId,
    word16 destinationX,
    byte destinationY);
void PlotPixel(word16 x, word16 y, byte color);
void DrawCompositeTacticalTile(
    word16 foregroundSpriteId,
    word16 backgroundSpriteId,
    const byte *spritePage,
    word16 destinationX,
    word16 destinationY);
void CompositeEgaSpritePlane(
    byte plane,
    byte firstByteMask,
    byte secondByteMask,
    const byte *foreground,
    const byte *background,
    byte *destination);
void DrawCgaTandyEncodedSprite(
    byte *destination,
    const byte *encodedSprite,
    int16 x,
    int16 y);
void DrawEGAEncodedSprite(
    byte *destination,
    const byte *encodedSprite,
    int16 x,
    int16 y);
void DrawVgaRleSprite(
    byte *destination,
    const byte *encodedSprite,
    int16 x,
    int16 y);

#endif
