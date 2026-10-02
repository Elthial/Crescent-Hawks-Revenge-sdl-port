// REVENGE_24C5_OVERVIEW_MAP.c
// Tactical overview-map rendering and transition helpers.

#include "REVENGE.h"
#include "revenge/original_data.h"

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
#define TACTICAL_OVERVIEW_MAP_BUFFER TacticalOverviewMapBuffer

// These callees are maintained in other segment files or will be promoted in
// the following tactical pass. Their stack contracts are already unambiguous.
void PlotPixel(word16 x, word16 y, word16 color);
void ScrollTacticalViewportToCursor(void);
void RedrawTacticalStatusPanel(void);
void DrawTacticalOverviewViewportFrame(void);
word16 GeneratePseudoRandomByte(void);
void BuildTacticalOverviewMapBuffer(
	const byte *source,
	byte *destination,
	word16 width,
	word16 height);
void ShowTacticalModalMessage(const char *formattedText);
void CopyVideoRegionToBuffer(
	int16 xColumn,
	word16 yCharacterRow,
	word16 widthColumns,
	word16 heightCharacterRows,
	byte *destination);
void CopyBufferToVideoRegion(
	int16 xColumn,
	word16 yCharacterRow,
	word16 widthColumns,
	word16 heightCharacterRows,
	const byte *source);
void SelectAndClearTextWindow(word16 windowIndex);
void DrawActiveTextWindowBorder(word16 color);
void RenderFormattedText(const char *formattedText);
word16 WaitForDismissInput(void);
void HideMouseCursorOverlay(void);
void ShowMouseCursorOverlay(void);
void ClearActiveVideoBuffer(void);
void RefreshTacticalDisplay(word16 advanceEffects);
void DrawTacticalOverviewMap(void);
void DrawClippedAxisAlignedLine(
	int16 x1, int16 y1, int16 x2, int16 y2, word16 color);

// 24C5:0002
void EnterTacticalOverview(void)
{
	word16 showClockNotice;
	byte *screenBuffer;

	showClockNotice = FALSE;
	TacticalOverviewViewportDirty = FALSE;
	if (TacticalOverviewClockNoticeActive != FALSE
		&& CampaignClockState[0x01]
			== (int16)LastOverviewNoticeHour)
	{
		showClockNotice = TRUE;
	}

	if (showClockNotice == FALSE)
	{
		TacticalOverviewClockNoticeActive = FALSE;
		if (CampaignClockState[0x01]
			!= (int16)LastOverviewNoticeHour
			&& GeneratePseudoRandomByte() >= TacticalOverviewNoticeChance)
		{
			showClockNotice = TRUE;
			TacticalOverviewClockNoticeActive = TRUE;
			LastOverviewNoticeHour = CampaignClockState[0x01];
		}
	}

	if (TacticalStateInitialized == FALSE)
	{
		ShowTacticalModalMessage(NoSatelliteUplinkText);
		return;
	}

	if (showClockNotice == FALSE)
	{
		TacticalOverviewActive = TRUE;
		TacticalSelectedUnitIndex = 0xFFFF;
		TacticalOverviewScreenOriginX =
			(word16)(((int16)0x00A0 - (int16)MapWidth) >> 0x01);
		BuildTacticalOverviewMapBuffer(
			TerrainTypeMap,
			TacticalOverviewMapBuffer,
			MapWidth,
			MapHeight);
		HideMouseCursorOverlay();
		DrawTacticalOverviewMap();
		return;
	}

	HideMouseCursorOverlay();
	screenBuffer = PrimaryScreenBuffer;
	CopyVideoRegionToBuffer(0x01, 0x00, 0x03, 0x0B, screenBuffer);
	SelectAndClearTextWindow(0x0D);
	DrawActiveTextWindowBorder(0x0E);
	RenderFormattedText(UplinkJammedText);
	ShowMouseCursorOverlay();
	(void)WaitForDismissInput();
	HideMouseCursorOverlay();
	CopyBufferToVideoRegion(0x01, 0x00, 0x03, 0x0B, screenBuffer);
	RefreshTacticalDisplay(FALSE);
	ShowMouseCursorOverlay();
}

// 24C5:012E
void RefreshTacticalOverview(void)
{
	word16 rowStride = (MapWidth + 0x07) & 0xFFF8;
	word16 unitIndex;
	int16 column;
	int16 row;
	word16 opposingMarkerColor = OVERVIEW_OPPOSING_MARKER_COLOR;
	byte *viewportTopRow;

	// Restore the terrain pixels under the markers drawn by the previous pass.
	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		byte oldX = TacticalOverviewMarkerX[unitIndex];
		byte oldY = TacticalOverviewMarkerY[unitIndex];

		if (oldX != OVERVIEW_INVALID_COORDINATE
			|| oldY != OVERVIEW_INVALID_COORDINATE)
		{
			byte terrainColor = TACTICAL_OVERVIEW_MAP_BUFFER[
				(word16)(oldY * rowStride) + oldX];
			PlotPixel(
				TacticalOverviewScreenOriginX + oldX,
				oldY,
				terrainColor);
			TacticalOverviewMarkerX[unitIndex] =
				OVERVIEW_INVALID_COORDINATE;
			TacticalOverviewMarkerY[unitIndex] =
				OVERVIEW_INVALID_COORDINATE;
		}
	}

	// Restore the terrain beneath the previous 19x12 viewport outline.
	viewportTopRow = TACTICAL_OVERVIEW_MAP_BUFFER
		+ (word16)(TacticalOverviewViewportY * rowStride)
		+ TacticalOverviewViewportX;
	for (column = 0x00; column < OVERVIEW_VIEWPORT_WIDTH_CELLS; ++column)
	{
		PlotPixel(
			TacticalOverviewScreenOriginX
				+ TacticalOverviewViewportX + column,
			TacticalOverviewViewportY,
			viewportTopRow[column]);
		PlotPixel(
			TacticalOverviewScreenOriginX
				+ TacticalOverviewViewportX + column,
			TacticalOverviewViewportY
				+ OVERVIEW_VIEWPORT_HEIGHT_CELLS - 0x01,
			viewportTopRow[
				(OVERVIEW_VIEWPORT_HEIGHT_CELLS - 0x01) * rowStride + column]);
	}
	for (row = 0x01; row < OVERVIEW_VIEWPORT_HEIGHT_CELLS - 0x01; ++row)
	{
		byte *mapRow = viewportTopRow +
			(word16) ((word16) row * rowStride);
		PlotPixel(
			TacticalOverviewScreenOriginX
				+ TacticalOverviewViewportX,
			TacticalOverviewViewportY + row,
			mapRow[0x00]);
		PlotPixel(
			TacticalOverviewScreenOriginX
				+ TacticalOverviewViewportX
				+ OVERVIEW_VIEWPORT_WIDTH_CELLS - 0x01,
			TacticalOverviewViewportY + row,
			mapRow[OVERVIEW_VIEWPORT_WIDTH_CELLS - 0x01]);
	}

	DrawTacticalOverviewViewportFrame();

	if (ScenarioFileSuffix >= 0x46 && ScenarioFileSuffix != 0x54)
		opposingMarkerColor = OVERVIEW_SPECIAL_OPPOSING_COLOR;

	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord =
			&PersistentUnitRoster[unitIndex];
		word16 markerColor = unitIndex < FIRST_OPPOSING_UNIT_INDEX
			? OVERVIEW_FRIENDLY_MARKER_COLOR
			: opposingMarkerColor;

		if (unitRecord->deploymentState == 0x00)
			continue;

		TacticalOverviewMarkerX[unitIndex] =
			ScenarioUnitMapX[unitIndex];
		TacticalOverviewMarkerY[unitIndex] =
			ScenarioUnitMapY[unitIndex];
		PlotPixel(
			TacticalOverviewScreenOriginX
				+ TacticalOverviewMarkerX[unitIndex],
			TacticalOverviewMarkerY[unitIndex],
			markerColor);
	}
}

// 24C5:02F1
void DrawTacticalOverviewViewportFrame(void)
{
	word16 left;
	word16 top;
	word16 right;
	word16 bottom;

	// V: constrain the tactical camera origin before copying it into the
	// overview's previous-frame coordinates.
	ScrollTacticalViewportToCursor();
	TacticalOverviewViewportX = TacticalViewportMapX;
	TacticalOverviewViewportY = TacticalViewportMapY;

	left = (TacticalOverviewScreenOriginX
		+ TacticalViewportMapX) << 0x01;
	top = TacticalViewportMapY << 0x01;
	right = left + ((OVERVIEW_VIEWPORT_WIDTH_CELLS << 0x01) - 0x01);
	bottom = top + ((OVERVIEW_VIEWPORT_HEIGHT_CELLS << 0x01) - 0x01);

	DrawClippedAxisAlignedLine(left, top, right, top,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
	DrawClippedAxisAlignedLine(left, top, left, bottom,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
	DrawClippedAxisAlignedLine(right, top, right, bottom,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
	DrawClippedAxisAlignedLine(left, bottom, right, bottom,
		OVERVIEW_VIEWPORT_FRAME_COLOR);
}

// 24C5:037F
void DrawTacticalOverviewMap(void)
{
	word16 rowStride = (MapWidth + 0x07) & 0xFFF8;
	int16 mapX;
	int16 mapY;
	word16 unitIndex;

	ClearActiveVideoBuffer();
	for (mapY = 0x00; mapY < (int16) MapHeight; ++mapY)
	{
		byte *mapRow = TACTICAL_OVERVIEW_MAP_BUFFER
			+ (word16)((word16)mapY * rowStride);
		for (mapX = 0x00; mapX < (int16) rowStride; ++mapX)
			PlotPixel(
				TacticalOverviewScreenOriginX + mapX,
				mapY,
				mapRow[mapX]);
	}

	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		TacticalOverviewMarkerX[unitIndex] =
			OVERVIEW_INVALID_COORDINATE;
		TacticalOverviewMarkerY[unitIndex] =
			OVERVIEW_INVALID_COORDINATE;
	}
	DrawTacticalOverviewViewportFrame();
}

// 24C5:0401
void ExitTacticalOverview(void)
{
	word16 runtimeSlot;

	TacticalOverviewActive = FALSE;
	ClearActiveVideoBuffer();
	for (runtimeSlot = 0x00;
		runtimeSlot < OVERVIEW_RUNTIME_SLOT_COUNT;
		++runtimeSlot)
	{
		TacticalStatusRowInvalidation[runtimeSlot] = 0xFF;
	}

	// V: restore the ordinary tactical interface after the overview buffer is
	// cleared.
	RedrawTacticalStatusPanel();
	ShowMouseCursorOverlay();
}
