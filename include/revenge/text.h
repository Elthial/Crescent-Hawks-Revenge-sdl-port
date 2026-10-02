#ifndef REVENGE_TEXT_H
#define REVENGE_TEXT_H

#include "revenge/types.h"

enum
{
    REVENGE_FONT_GLYPH_COUNT = 0x80,
    REVENGE_TEXT_WINDOW_COUNT = 0x17
};

typedef struct TextWindowContext
{
    uint16 leftTile;
    uint16 topTile;
    uint16 widthTiles;
    uint16 heightTiles;
    uint16 foregroundColor;
    uint16 backgroundColor;
    uint16 cursorColumn;
    uint16 cursorRow;
} TextWindowContext;

typedef struct ActiveTextWindowState
{
    uint16 index;
    uint16 leftTile;
    uint16 topTile;
    uint16 widthTiles;
    uint16 heightTiles;
    uint16 foregroundColor;
    uint16 backgroundColor;
    uint16 cursorColumn;
    uint16 cursorRow;
} ActiveTextWindowState;

byte *LoadFontResource(const char *fileName);
void SetActiveFontResource(byte *fontResource);
uint16 MeasureTextWidth(const char *text);
byte TextSystem_GetActiveFontWidth(void);
byte TextSystem_GetActiveFontHeight(void);

void DrawFontGlyph(uint16 glyphIndex, uint16 x, uint16 y);
void DrawTextString(
    const char *text,
    uint16 x,
    uint16 y,
    byte foregroundColor,
    byte backgroundColor);
void RemoveLeadingSpacesFrom(char *text, word16 oneBasedStart);
void TrimTrailingEncodedSpaces(char *text);
void PadStringToWidth(char *text, word16 width);
void FillTextEntryBuffer(word16 length, byte fillCharacter);

void TextSystem_SetWindowContexts(
    const TextWindowContext *contexts,
    uint16 contextCount);
void TextSystem_SetWindowContext(
    uint16 windowIndex,
    const TextWindowContext *context);
void TextSystem_SetCompressionTables(
    const byte firstByteTable[0x10],
    const byte secondByteTable[0x80]);
const ActiveTextWindowState *TextSystem_GetActiveWindow(void);
void SelectTextWindow(uint16 windowIndex);
void SelectAndClearTextWindow(uint16 windowIndex);
void ClearActiveTextWindow(void);
void RenderTextToActiveWindow(char *text, uint16 advanceToNextLine);
void RenderFormattedText(const char *formattedText);
void DrawTileAlignedText(
    const char *text,
    uint16 tileX,
    uint16 tileY,
    byte foregroundColor,
    byte backgroundColor);
void DrawCenteredTextInActiveWindow(
    const char *text,
    uint16 rowOffset,
    uint16 foregroundColor,
    uint16 backgroundColor);
void DrawCenteredClippedText(
    const char *sourceText,
    uint16 splitIndex,
    uint16 leftX,
    uint16 y,
    uint16 maximumWidth,
    byte foregroundColor,
    byte backgroundColor);
void DrawLeftAlignedClippedText(
    const char *sourceText,
    uint16 x,
    uint16 y,
    uint16 maximumWidth,
    byte foregroundColor,
    byte backgroundColor);
void DrawRightAlignedClippedText(
    const char *sourceText,
    uint16 leftX,
    uint16 y,
    uint16 maximumWidth,
    byte foregroundColor,
    byte backgroundColor);
void DrawActiveTextWindowBorder(uint16 color);
void DrawBeveledMenuButton(
    uint16 textColumn,
    uint16 textRow,
    const char *text,
    uint16 widthPixels);

#endif
