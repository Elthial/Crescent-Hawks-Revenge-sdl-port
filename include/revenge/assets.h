#ifndef REVENGE_ASSETS_H
#define REVENGE_ASSETS_H

#include "revenge/types.h"

#include <stddef.h>

enum
{
    REVENGE_SCREEN_WIDTH = 0x0140,
    REVENGE_SCREEN_HEIGHT = 0x00C8,
    REVENGE_SCREEN_PIXEL_COUNT = 0xFA00,
    REVENGE_PALETTE_BYTE_COUNT = 0x0300,
    REVENGE_PACKED_SCREEN_BYTE_COUNT = 0x7D00,
    REVENGE_ICON_WIDTH = 0x0010,
    REVENGE_ICON_HEIGHT = 0x0010,
    REVENGE_ICON_COUNT = 0x00FA
};

typedef enum RevengeAssetResult
{
    REVENGE_ASSET_OK = 0x00,
    REVENGE_ASSET_BAD_ARGUMENT = 0x01,
    REVENGE_ASSET_TRUNCATED = 0x02,
    REVENGE_ASSET_BAD_LENGTH = 0x03,
    REVENGE_ASSET_BAD_COMPRESSION = 0x04,
    REVENGE_ASSET_BAD_OUTPUT_SIZE = 0x05,
    REVENGE_ASSET_BAD_PALETTE_SIZE = 0x06
} RevengeAssetResult;

typedef struct RevengeScreenImage
{
    byte pixels[REVENGE_SCREEN_PIXEL_COUNT];
    byte palette[REVENGE_PALETTE_BYTE_COUNT];
    uint16 paletteByteCount;
    byte compressionType;
} RevengeScreenImage;

/* Original REVENGE 0800 codec entry points. The compressed block starts at
 * its eight-byte Westwood header, exactly as it did at offset zero of a DOS
 * segment. Callers validate the surrounding file container first. */
void DecodeRLEBlock(const byte *compressedBlock, byte *destination);
void DecodeWestwoodLzw12(
    const byte *compressedBlock,
    byte *destination,
    byte *dictionary);
void DecodeWestwoodLzw14(
    const byte *compressedBlock,
    byte *destination,
    byte *dictionary);
void DecodeWestwoodPackedResource(
    const byte *compressedBlock,
    byte *destination);

/* Host-side container adapters. These replace no game logic; they validate
 * the original file envelope and then call the recovered routines above. */
RevengeAssetResult DecodeCpsImage(
    const byte *fileData,
    size_t fileByteCount,
    RevengeScreenImage *image);
RevengeAssetResult DecodeCmpImage(
    const byte *fileData,
    size_t fileByteCount,
    RevengeScreenImage *image);
RevengeAssetResult DecodeIcnTiles(
    const byte *fileData,
    size_t fileByteCount,
    byte *tilePixels,
    size_t tilePixelCapacity);

#endif
