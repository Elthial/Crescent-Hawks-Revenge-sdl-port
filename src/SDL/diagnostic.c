#include "revenge/platform_backend.h"
#include "revenge/assets.h"
#include "revenge/video.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void DrawDiagnosticPattern(void)
{
    uint16 x;
    uint16 y;

    SDLBackend_ClearIndexedFramebuffer(0x00);
    for (y = 0x0000; y < VIDEO_SCREEN_HEIGHT; ++y)
    {
        for (x = 0x0000; x < VIDEO_SCREEN_WIDTH; ++x)
        {
            SDLBackend_DrawIndexedPixel(
                x,
                y,
                (byte)((x / 0x0014 + y / 0x0019) & 0x0F));
        }
    }
}

static byte *ReadWholeFile(const char *path, size_t *byteCount)
{
    FILE *file;
    long length;
    byte *data;

#if defined(_MSC_VER)
    if (fopen_s(&file, path, "rb") != 0x00)
        file = NULL;
#else
    file = fopen(path, "rb");
#endif
    if (file == NULL)
        return NULL;
    (void)fseek(file, 0x00, SEEK_END);
    length = ftell(file);
    (void)fseek(file, 0x00, SEEK_SET);
    if (length <= 0x00)
    {
        (void)fclose(file);
        return NULL;
    }
    data = (byte *)malloc((size_t)length);
    if (data == NULL || fread(data, 0x01, (size_t)length, file) != (size_t)length)
    {
        free(data);
        (void)fclose(file);
        return NULL;
    }
    (void)fclose(file);
    *byteCount = (size_t)length;
    return data;
}

static int DrawCpsFile(const char *path)
{
    size_t fileByteCount;
    byte *fileData;
    RevengeScreenImage *image;
    RevengeAssetResult result;

    fileData = ReadWholeFile(path, &fileByteCount);
    if (fileData == NULL)
        return FALSE;
    image = (RevengeScreenImage *)malloc(sizeof(*image));
    if (image == NULL)
    {
        free(fileData);
        return FALSE;
    }
    result = DecodeCpsImage(fileData, fileByteCount, image);
    if (result == REVENGE_ASSET_OK)
        memcpy(SDLBackend_GetIndexedFramebuffer(), image->pixels,
            sizeof(image->pixels));
    free(image);
    free(fileData);
    return result == REVENGE_ASSET_OK;
}

static int LoadPaletteFile(const char *path)
{
    size_t fileByteCount;
    byte *fileData;

    fileData = ReadWholeFile(path, &fileByteCount);
    if (fileData == NULL || fileByteCount != VGA_PALETTE_BYTE_COUNT)
    {
        free(fileData);
        return FALSE;
    }
    VGA_LoadPalette(fileData);
    free(fileData);
    return TRUE;
}

int main(int argumentCount, char **arguments)
{
    uint16 frameCount;
    uint16 frame;
    const char *cpsPath;
    const char *palettePath;
    int argument;

    frameCount = 0x0000;
    cpsPath = NULL;
    palettePath = NULL;
    for (argument = 0x01; argument < argumentCount; argument += 0x02)
    {
        if (argument + 0x01 >= argumentCount)
        {
            fputs("Usage: RevengeDiagnostic [--cps file] [--palette file] [--frames count]\n", stderr);
            return 0x02;
        }
        if (strcmp(arguments[argument], "--frames") == 0)
            frameCount = (uint16)strtoul(arguments[argument + 0x01], 0, 0x0A);
        else if (strcmp(arguments[argument], "--cps") == 0)
            cpsPath = arguments[argument + 0x01];
        else if (strcmp(arguments[argument], "--palette") == 0)
            palettePath = arguments[argument + 0x01];
        else
        {
            fputs("Usage: RevengeDiagnostic [--cps file] [--palette file] [--frames count]\n", stderr);
            return 0x02;
        }
    }

    if (!SDLBackend_Open())
    {
        fputs("Unable to open the SDL video backend.\n", stderr);
        return 0x01;
    }

    if (cpsPath == NULL)
        DrawDiagnosticPattern();
    else if (!DrawCpsFile(cpsPath))
    {
        fputs("Unable to decode the CPS image.\n", stderr);
        SDLBackend_Close();
        return 0x01;
    }
    if (palettePath != NULL && !LoadPaletteFile(palettePath))
    {
        fputs("Unable to load the VGA palette.\n", stderr);
        SDLBackend_Close();
        return 0x01;
    }
    if (!SDLBackend_PresentIndexedFramebuffer())
    {
        SDLBackend_Close();
        return 0x01;
    }

    if (frameCount == 0x0000)
    {
        while (!SDLBackend_PollQuit())
            SDLBackend_WaitVerticalRetrace(VERTICAL_RETRACE_WAIT_FOR_START);
    }
    else
    {
        for (frame = 0x0000; frame < frameCount; ++frame)
            SDLBackend_WaitVerticalRetrace(VERTICAL_RETRACE_WAIT_FOR_START);
    }

    SDLBackend_Close();
    return 0x00;
}
