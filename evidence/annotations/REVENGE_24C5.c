// REVENGE_24C5.c
// Tactical overview-map rendering and transition helpers.

#include "REVENGE.h"

#define TACTICAL_UNIT_COUNT                 0x18
#define FIRST_OPPOSING_UNIT_INDEX           0x0C
#define OVERVIEW_VIEWPORT_WIDTH_CELLS       0x13
#define OVERVIEW_VIEWPORT_HEIGHT_CELLS      0x0C
#define OVERVIEW_INVALID_COORDINATE         0xFF
#define OVERVIEW_FRIENDLY_MARKER_COLOR      0xDD
#define OVERVIEW_OPPOSING_MARKER_COLOR      0x66
#define OVERVIEW_SPECIAL_OPPOSING_COLOR     0xAA
#define OVERVIEW_VIEWPORT_FRAME_COLOR       0x0F
#define OVERVIEW_RUNTIME_SLOT_COUNT         0x09

#define REVENGE_DS_BYTE(offset) \
	(*((byte __far *) MAKE_FAR_POINTER(0x3A6A, (offset))))

// These callees are maintained in other segment files or will be promoted in
// the following tactical pass. Their stack contracts are already unambiguous.
void PlotPixel_0B07(word16 x, word16 y, word16 color);
void ScrollTacticalViewportToCursor_182E(void);
void RedrawTacticalStatusPanel_16BA(void);
void DrawTacticalOverviewViewportFrame_02F1(void);

static word16 GetOverviewRowStride(void)
{
	return (seg3A6A->MapWidth_00A6 + 0x07) & 0xFFF8;
}

static byte __far *GetOverviewMapRow(word16 mapY, word16 rowStride)
{
	return seg3A6A->TacticalOverviewMapBuffer_83E6 +
		(word16) (mapY * rowStride);
}

// 24C5:012E
void RefreshTacticalOverview_012E(void)
{
	word16 rowStride = GetOverviewRowStride();
	word16 unitIndex;
	int16 column;
	int16 row;
	word16 opposingMarkerColor = OVERVIEW_OPPOSING_MARKER_COLOR;
	byte __far *viewportTopRow;

	// Restore the terrain pixels under the markers drawn by the previous pass.
	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		byte oldX = seg3A6A->TacticalOverviewMarkerX_8374[unitIndex];
		byte oldY = seg3A6A->TacticalOverviewMarkerY_83C0[unitIndex];

		if (oldX != OVERVIEW_INVALID_COORDINATE
			|| oldY != OVERVIEW_INVALID_COORDINATE)
		{
			byte terrainColor = GetOverviewMapRow(oldY, rowStride)[oldX];
			PlotPixel_0B07(
				seg3A6A->TacticalOverviewScreenOriginX_A7F1 + oldX,
				oldY,
				terrainColor);
			seg3A6A->TacticalOverviewMarkerX_8374[unitIndex] =
				OVERVIEW_INVALID_COORDINATE;
			seg3A6A->TacticalOverviewMarkerY_83C0[unitIndex] =
				OVERVIEW_INVALID_COORDINATE;
		}
	}

	// Restore the terrain beneath the previous 19x12 viewport outline.
	viewportTopRow = GetOverviewMapRow(
		seg3A6A->TacticalOverviewViewportY_83D8,
		rowStride) + seg3A6A->TacticalOverviewViewportX_838C;
	for (column = 0x00; column < OVERVIEW_VIEWPORT_WIDTH_CELLS; ++column)
	{
		PlotPixel_0B07(
			seg3A6A->TacticalOverviewScreenOriginX_A7F1
				+ seg3A6A->TacticalOverviewViewportX_838C + column,
			seg3A6A->TacticalOverviewViewportY_83D8,
			viewportTopRow[column]);
		PlotPixel_0B07(
			seg3A6A->TacticalOverviewScreenOriginX_A7F1
				+ seg3A6A->TacticalOverviewViewportX_838C + column,
			seg3A6A->TacticalOverviewViewportY_83D8
				+ OVERVIEW_VIEWPORT_HEIGHT_CELLS - 0x01,
			viewportTopRow[
				(OVERVIEW_VIEWPORT_HEIGHT_CELLS - 0x01) * rowStride + column]);
	}
	for (row = 0x01; row < OVERVIEW_VIEWPORT_HEIGHT_CELLS - 0x01; ++row)
	{
		byte __far *mapRow = viewportTopRow +
			(word16) ((word16) row * rowStride);
		PlotPixel_0B07(
			seg3A6A->TacticalOverviewScreenOriginX_A7F1
				+ seg3A6A->TacticalOverviewViewportX_838C,
			seg3A6A->TacticalOverviewViewportY_83D8 + row,
			mapRow[0x00]);
		PlotPixel_0B07(
			seg3A6A->TacticalOverviewScreenOriginX_A7F1
				+ seg3A6A->TacticalOverviewViewportX_838C
				+ OVERVIEW_VIEWPORT_WIDTH_CELLS - 0x01,
			seg3A6A->TacticalOverviewViewportY_83D8 + row,
			mapRow[OVERVIEW_VIEWPORT_WIDTH_CELLS - 0x01]);
	}

	DrawTacticalOverviewViewportFrame_02F1();

	if (seg3A6A->ScenarioFileSuffix_wB581 >= 0x46 && seg3A6A->ScenarioFileSuffix_wB581 != 0x54)
		opposingMarkerColor = OVERVIEW_SPECIAL_OPPOSING_COLOR;

	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		byte __far *unitRecord = (byte __far *) &seg3A6A->a8B81[0]
			+ unitIndex * UNIT_RECORD_SIZE;
		word16 markerColor = unitIndex < FIRST_OPPOSING_UNIT_INDEX
			? OVERVIEW_FRIENDLY_MARKER_COLOR
			: opposingMarkerColor;

		if (unitRecord[UNIT_FIELD_DEPLOYMENT_STATE] == 0x00)
			continue;

		seg3A6A->TacticalOverviewMarkerX_8374[unitIndex] =
			seg3A6A->ScenarioUnitMapX_8562[unitIndex];
		seg3A6A->TacticalOverviewMarkerY_83C0[unitIndex] =
			seg3A6A->ScenarioUnitMapY_857B[unitIndex];
		PlotPixel_0B07(
			seg3A6A->TacticalOverviewScreenOriginX_A7F1
				+ seg3A6A->TacticalOverviewMarkerX_8374[unitIndex],
			seg3A6A->TacticalOverviewMarkerY_83C0[unitIndex],
			markerColor);
	}
}

// 24C5:02F1
void DrawTacticalOverviewViewportFrame_02F1(void)
{
	word16 left;
	word16 top;
	word16 right;
	word16 bottom;

	// V: constrain the tactical camera origin before copying it into the
	// overview's previous-frame coordinates.
	ScrollTacticalViewportToCursor_182E();
	seg3A6A->TacticalOverviewViewportX_838C = seg3A6A->TacticalViewportMapX_84A0;
	seg3A6A->TacticalOverviewViewportY_83D8 = seg3A6A->TacticalViewportMapY_83DA;

	left = (seg3A6A->TacticalOverviewScreenOriginX_A7F1
		+ seg3A6A->TacticalViewportMapX_84A0) << 0x01;
	top = seg3A6A->TacticalViewportMapY_83DA << 0x01;
	right = left + ((OVERVIEW_VIEWPORT_WIDTH_CELLS << 0x01) - 0x01);
	bottom = top + ((OVERVIEW_VIEWPORT_HEIGHT_CELLS << 0x01) - 0x01);

	DrawClippedAxisAlignedLine_00A6(left, top, right, top,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
	DrawClippedAxisAlignedLine_00A6(left, top, left, bottom,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
	DrawClippedAxisAlignedLine_00A6(right, top, right, bottom,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
	DrawClippedAxisAlignedLine_00A6(left, bottom, right, bottom,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
}

// 24C5:037F
void DrawTacticalOverviewMap_037F(void)
{
	word16 rowStride = GetOverviewRowStride();
	int16 mapX;
	int16 mapY;
	word16 unitIndex;

	ClearActiveVideoBuffer_2D59();
	for (mapY = 0x00; mapY < (int16) seg3A6A->MapHeight_00A8; ++mapY)
	{
		byte __far *mapRow = GetOverviewMapRow(mapY, rowStride);
		for (mapX = 0x00; mapX < (int16) rowStride; ++mapX)
			PlotPixel_0B07(
				seg3A6A->TacticalOverviewScreenOriginX_A7F1 + mapX,
				mapY,
				mapRow[mapX]);
	}

	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		seg3A6A->TacticalOverviewMarkerX_8374[unitIndex] =
			OVERVIEW_INVALID_COORDINATE;
		seg3A6A->TacticalOverviewMarkerY_83C0[unitIndex] =
			OVERVIEW_INVALID_COORDINATE;
	}
	DrawTacticalOverviewViewportFrame_02F1();
}

// 24C5:0401
void ExitTacticalOverview_0401(void)
{
	word16 runtimeSlot;

	seg3A6A->TacticalOverviewActive_8104 = FALSE;
	ClearActiveVideoBuffer_2D59();
	for (runtimeSlot = 0x00;
		runtimeSlot < OVERVIEW_RUNTIME_SLOT_COUNT;
		++runtimeSlot)
	{
		REVENGE_DS_BYTE(0xB574 + runtimeSlot) = 0xFF;
	}

	// V: restore the ordinary tactical interface after the overview buffer is
	// cleared.
	RedrawTacticalStatusPanel_16BA();
	ShowMouseCursorOverlay_3B7A();
}
