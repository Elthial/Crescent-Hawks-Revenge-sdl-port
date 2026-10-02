// REVENGE_0800_GRAPHICS_RUNTIME.c
// Runtime, codec, tactical-map, and video procedures reconstructed from
// REVENGE.EXE segment 0800.

// Tactical geometry and terrain procedures from REVENGE.EXE segment 0800.
#include "REVENGE.h"
#include "revenge/interrupts.h"
#include "revenge/original_data.h"
#include "revenge/platform_backend.h"
#include "revenge/video.h"

#include <stdint.h>
#include <string.h>

enum
{
	EGA_GC_ENABLE_SET_RESET_REGISTER = 0x01,
	EGA_GC_MODE_REGISTER = 0x05,
	EGA_GC_BIT_MASK_REGISTER = 0x08,
	EGA_GC_WRITE_MODE_0 = 0x00,
	EGA_GC_WRITE_MODE_1 = 0x01,
	EGA_GC_WRITE_MODE_2 = 0x02,
	EGA_SEQ_MAP_MASK_REGISTER = 0x02,
	EGA_ALL_PLANES = 0x0F,
	EGA_ALL_WRITABLE_PIXEL_BITS = 0xFF
};

// 0800:06D1: uint16 DetermineRelativeAttackDirection(
//     int16 sourceX, int16 sourceY, int16 targetX, int16 targetY)
uint16 DetermineRelativeAttackDirection(
	int16 sourceX,
	int16 sourceY,
	int16 targetX,
	int16 targetY)
{
	int16 deltaY;
	int16 deltaX;
	int16 absoluteY;
	int16 absoluteX;
	int16 doubledDelta;
	word16 comparisonMask;

	deltaY = (int16) ((uint16) sourceY - (uint16) targetY);
	deltaX = (int16) ((uint16) targetX - (uint16) sourceX);
	absoluteY = deltaY;
	if (absoluteY < 0x0000)
	{
		absoluteY = (int16) (0x0000 - (uint16) absoluteY);
	}
	absoluteX = deltaX;
	if (absoluteX < 0x0000)
	{
		absoluteX = (int16) (0x0000 - (uint16) absoluteX);
	}

	comparisonMask = 0x0000;
	doubledDelta = (int16) ((uint16) deltaY << 0x01);
	if (doubledDelta >= absoluteX)
	{
		comparisonMask |= 0x0008;
	}
	doubledDelta = (int16) (0x0000 - (uint16) doubledDelta);
	if (doubledDelta >= absoluteX)
	{
		comparisonMask |= 0x0004;
	}
	doubledDelta = (int16) ((uint16) deltaX << 0x01);
	if (doubledDelta >= absoluteY)
	{
		comparisonMask |= 0x0002;
	}
	doubledDelta = (int16) (0x0000 - (uint16) doubledDelta);
	if (doubledDelta >= absoluteY)
	{
		comparisonMask |= 0x0001;
	}

	return RelativeAttackDirectionByMask[comparisonMask];
}

// 0800:078C: V TraceMapLineOfSight.
// Walk a Bresenham-like grid line over the active terrain map. Return TRUE on
// reaching the target; return FALSE at the step limit, after three cells in
// the special-terrain range, or at the first terrain ID at/above the blocking
// threshold.
// Verified against 0800:078C-0929.
word16 TraceMapLineOfSight(
	int16 sourceX,
	int16 sourceY,
	int16 targetX,
	int16 targetY,
	const byte *terrainTypeMap,
	byte specialTerrainMinimum,
	byte specialTerrainMaximum,
	byte blockingTerrainThreshold,
	byte maximumSteps)
{
	int16 verticalDelta;
	int16 horizontalDelta;
	int16 absoluteVerticalDelta;
	int16 absoluteHorizontalDelta;
	int16 majorDelta;
	int16 minorDelta;
	int16 error;
	int16 currentX;
	int16 currentY;
	word16 terrainOffset;
	word16 direction;
	byte specialTerrainRemaining;

	currentX = sourceX;
	currentY = sourceY;
	terrainOffset = (word16) (FAR_OFFSET(terrainTypeMap) +
		(word16) sourceX +
		(word16) ((byte) sourceY *
			(byte) TacticalMapRowWidth));
	verticalDelta = (int16) ((word16) sourceY - (word16) targetY);
	horizontalDelta = (int16) ((word16) targetX - (word16) sourceX);
	absoluteVerticalDelta = verticalDelta;
	if (absoluteVerticalDelta < 0x00)
	{
		absoluteVerticalDelta = (int16)
			(0x00 - (word16) absoluteVerticalDelta);
	}
	absoluteHorizontalDelta = horizontalDelta;
	if (absoluteHorizontalDelta < 0x00)
	{
		absoluteHorizontalDelta = (int16)
			(0x00 - (word16) absoluteHorizontalDelta);
	}
	majorDelta = absoluteVerticalDelta;
	minorDelta = absoluteHorizontalDelta;
	if (absoluteHorizontalDelta > absoluteVerticalDelta)
	{
		majorDelta = absoluteHorizontalDelta;
		minorDelta = absoluteVerticalDelta;
	}

	if (verticalDelta < 0x00)
	{
		if (horizontalDelta >= 0x01)
		{
			direction = 0x02;
			if ((int16) (0x00 - (word16) verticalDelta) >
				horizontalDelta)
			{
				++direction;
			}
		}
		else
		{
			direction = 0x04;
			if ((int16) (0x00 - (word16) horizontalDelta) >
				(int16) (0x00 - (word16) verticalDelta))
			{
				++direction;
			}
		}
	}
	else if (horizontalDelta >= 0x01)
	{
		direction = 0x00;
		if (horizontalDelta > verticalDelta)
		{
			++direction;
		}
	}
	else
	{
		direction = 0x06;
		if (verticalDelta >
			(int16) (0x00 - (word16) horizontalDelta))
		{
			++direction;
		}
	}

	error = (int16) ((word16) majorDelta >> 0x01);
	specialTerrainRemaining = 0x03;
	for (;;)
	{
		byte terrainType;
		const byte *terrainCell;

		--maximumSteps;
		if (maximumSteps == 0x00)
		{
			return FALSE;
		}
		if (currentX == targetX && currentY == targetY)
		{
			return TRUE;
		}

		terrainCell = FAR_POINTER(
			const byte, FAR_SEGMENT(terrainTypeMap), terrainOffset);
		terrainType = *terrainCell;
		if (terrainType >= blockingTerrainThreshold)
		{
			return FALSE;
		}
		if (terrainType >= specialTerrainMinimum &&
			terrainType <= specialTerrainMaximum)
		{
			--specialTerrainRemaining;
			if (specialTerrainRemaining == 0x00)
			{
				return FALSE;
			}
		}

		if (currentX != targetX)
		{
			currentX = (int16) ((word16) currentX +
				(word16) LinePrimaryXStep[direction]);
			terrainOffset = (word16) (terrainOffset +
				(word16) LinePrimaryXStep[direction]);
		}
		if (currentY != targetY)
		{
			currentY = (int16) ((word16) currentY +
				(word16) LinePrimaryYStep[direction]);
			terrainOffset = (word16) (terrainOffset +
				(word16) LinePrimaryRowOffset[direction]);
		}

		error = (int16) ((word16) error - (word16) minorDelta);
		if (error >= 0x00)
		{
			continue;
		}
		error = (int16) ((word16) error + (word16) majorDelta);
		if (currentX != targetX)
		{
			currentX = (int16) ((word16) currentX +
				(word16) LineSecondaryXStep[direction]);
			terrainOffset = (word16) (terrainOffset +
				(word16) LineSecondaryXStep[direction]);
		}
		if (currentY != targetY)
		{
			currentY = (int16) ((word16) currentY +
				(word16) LineSecondaryYStep[direction]);
			terrainOffset = (word16) (terrainOffset +
				(word16) LineSecondaryRowOffset[direction]);
		}
	}
}

// 0800:092A: int16 InterpolateLineCoordinate(int16 clipCoordinate,
//     int16 lineStartCoordinate, int16 otherStartCoordinate,
//     int16 otherEndCoordinate, int16 lineEndCoordinate)
int16 InterpolateLineCoordinate(
	int16 clipCoordinate,
	int16 lineStartCoordinate,
	int16 otherStartCoordinate,
	int16 otherEndCoordinate,
	int16 lineEndCoordinate)
{
	int16 boundaryDelta;
	int16 otherDelta;
	int16 lineDelta;
	int32 numerator;
	int16 interpolatedDelta;

	if (lineEndCoordinate == lineStartCoordinate)
	{
		return clipCoordinate;
	}

	boundaryDelta = (int16) ((uint16) clipCoordinate -
		(uint16) lineStartCoordinate);
	otherDelta = (int16) ((uint16) otherStartCoordinate -
		(uint16) otherEndCoordinate);
	lineDelta = (int16) ((uint16) lineEndCoordinate -
		(uint16) lineStartCoordinate);
	numerator = (int32) boundaryDelta * (int32) otherDelta;
	interpolatedDelta = (int16) (numerator / lineDelta);
	return (int16) ((uint16) interpolatedDelta +
		(uint16) otherEndCoordinate);
}


// 0800:0A89: translate the map-cell bytes used by the tactical overview into
// display colors and pad each destination row to an eight-byte boundary.
// The four color bands are the literal CS:04C9 translation table used by XLAT.
void BuildTacticalOverviewMapBuffer(
	const byte *source,
	byte *destination,
	word16 width,
	word16 height)
{
	static const byte overviewPixelTranslation[0x0100] = {
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
		0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE,
		0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE,
		0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE,
		0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE,
		0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
		0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
		0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
		0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
		0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
		0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00
	};
	word16 paddedWidth;
	word16 row;
	word16 column;

	paddedWidth = (width + 0x0007) & 0xFFF8;
	for (row = 0x0000; row < height; ++row)
	{
		for (column = 0x0000; column < width; ++column)
		{
			byte terrainType = *source++;

			if (terrainType < 0x80)
				*destination++ = 0x77;
			else if (terrainType < 0xA0)
				*destination++ = 0xEE;
			else if (terrainType < 0xC0)
				*destination++ = 0x33;
			else if (terrainType < 0xC6)
				*destination++ = 0xAA;
			else
				*destination++ = 0x00;
		}
		for (; column < paddedWidth; ++column)
			*destination++ = overviewPixelTranslation[0x00];
	}
}


#define TACTICAL_VIEWPORT_WIDTH_CELLS       0x0013
#define TACTICAL_VIEWPORT_HEIGHT_CELLS      0x000C
#define TACTICAL_VIEWPORT_CELL_COUNT        0x00E4
#define PACKED_TERRAIN_DAMAGE_MAP_OFFSET    0xA000
#define DAMAGED_TERRAIN_SPRITE_FLAG         0x0200

#define CGA_BYTES_PER_SCANLINE               0x0050
#define TANDY_BYTES_PER_SCANLINE_GROUP       0x00A0
#define EGA_BYTES_PER_SCANLINE               0x0028
#define VGA_BYTES_PER_SCANLINE               0x0140
#define CGA_TANDY_BANK_SIZE                  0x2000

// 0800:0999: clear the 19x12 byte overlay map used while composing transient
// terrain-impact sprites. DS:7978 and 4184:07D8 are physical aliases.
void ClearTacticalEffectOverlayMap(void)
{
	word16 cellIndex;
	for (cellIndex = 0x00;
		cellIndex < TACTICAL_VIEWPORT_CELL_COUNT;
		++cellIndex)
	{
		TacticalEffectOverlayMap[cellIndex] = 0x00;
	}
}

// 0800:05D3: build the two adjacent 19x12 tactical viewport cell maps.
// Called from:
//      RebuildTacticalViewport
void BuildTacticalTerrainCellMaps(
	const byte *terrainTypeMap,
	word16 *tacticalCellSpriteMap,
	word16 viewportX,
	word16 viewportY)
{
	const byte *damagedTerrainSpriteLookup;
	const byte *packedDamageRow;
	const byte *packedDamage;
	const byte *terrainRow;
	word16 *terrainCellMap;
	word16 mapWidth;
	word16 packedRowStride;
	word16 terrainRowOffset;
	word16 packedDamageRowOffset;
	word16 cellIndex;
	word16 row;
	word16 column;
	byte damageMask;
	byte damageState;
	byte shift;
	byte terrainType;
	word16 terrainSprite;

	// Verified against 0800:05D3-06D0. The original byte MUL operations
	// deliberately use only the low bytes of viewportY and the row strides.
	mapWidth = TacticalMapRowWidth;
	packedRowStride = (word16) (((mapWidth + 0x03) & 0x01FC) >> 0x02);
	terrainRowOffset = (word16) (FAR_OFFSET(terrainTypeMap) + viewportX
		+ (byte) viewportY * (byte) mapWidth);
	packedDamageRowOffset = (word16) (FAR_OFFSET(terrainTypeMap)
		+ PACKED_TERRAIN_DAMAGE_MAP_OFFSET + (viewportX >> 0x02)
		+ (byte) viewportY * (byte) packedRowStride);
	terrainRow = FAR_POINTER(
		const byte, FAR_SEGMENT(terrainTypeMap), terrainRowOffset);
	packedDamageRow = FAR_POINTER(
		const byte, FAR_SEGMENT(terrainTypeMap), packedDamageRowOffset);
	terrainCellMap = tacticalCellSpriteMap + TACTICAL_VIEWPORT_CELL_COUNT;
	damagedTerrainSpriteLookup = DamagedTerrainSpriteLookup;

	for (cellIndex = 0x00;
		cellIndex < TACTICAL_VIEWPORT_CELL_COUNT;
		++cellIndex)
	{
		tacticalCellSpriteMap[cellIndex] = 0x0000;
	}

	for (row = 0x00; row < TACTICAL_VIEWPORT_HEIGHT_CELLS; ++row)
	{
		packedDamage = packedDamageRow;
		damageMask = (byte) (0xC0 >> ((viewportX & 0x03) << 0x01));
		for (column = 0x00;
			column < TACTICAL_VIEWPORT_WIDTH_CELLS;
			++column)
		{
			terrainType = *terrainRow++;
			damageState = *packedDamage & damageMask;
			terrainSprite = terrainType;

			if (damageState != 0x00)
			{
				shift = (byte) (
					0x06 - (((viewportX + column) & 0x03) << 0x01));
				damageState = (byte)(damageState >> shift);
				terrainSprite = DAMAGED_TERRAIN_SPRITE_FLAG
					| damagedTerrainSpriteLookup[
						((word16)(damageState - 0x01) << 0x08)
						+ terrainType];
			}
			terrainCellMap[row * TACTICAL_VIEWPORT_WIDTH_CELLS + column] =
				terrainSprite;

			damageMask >>= 0x02;
			if (damageMask == 0x00)
			{
				damageMask = 0xC0;
				++packedDamage;
			}
		}
		terrainRow += mapWidth - TACTICAL_VIEWPORT_WIDTH_CELLS;
		packedDamageRow += packedRowStride;
	}
}


