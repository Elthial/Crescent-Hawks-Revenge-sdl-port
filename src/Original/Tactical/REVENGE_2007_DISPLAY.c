/* Tactical sprite composition and display procedures from segment 2007. */

#include "REVENGE.h"

#include "revenge/original_data.h"
#include "revenge/video.h"

void AdvanceTerrainEffects(word16 advanceEffects);
void RebuildTacticalViewport(void);
void DrawTacticalCursorOutline(word16 outlineState);
void RefreshTacticalOverview(void);
void DrawSelectedUnitStatusPanel(void);

/* 2007:0DDB-0E18 */
void DrawTacticalEffectSprite(
	word16 spriteId,
	int16 relativeX,
	int16 relativeY)
{
	byte *renderTarget;

	if (TacticalOverviewActive != FALSE)
		return;
	renderTarget = VideoFramebuffer;
	HideMouseCursorOverlay();
	DrawTacticalClippedSprite(
		renderTarget,
		TacticalEffectSpriteTable[spriteId],
		relativeX,
		relativeY,
		0x0002);
	ShowMouseCursorOverlay();
}

/* 2007:0328-0429 */
void DrawTacticalViewportCell(
	int16 viewportColumn,
	int16 viewportRow,
	word16 viewportCellIndex)
{
	const byte *spritePage;
	word16 destinationX;
	word16 destinationY;
	word16 terrainSpriteId;
	word16 unitSpriteId;
	byte terrainEffect;

	unitSpriteId = TacticalCellSpriteMap[viewportCellIndex];
	terrainSpriteId = TacticalCellTerrainMap[viewportCellIndex];
	/* DS:7978 is the same E4h-byte array cleared at 0800:0999 and populated
	 * at 2007:1219.  It is not a second display-side buffer. */
	terrainEffect = TacticalEffectOverlayMap[viewportCellIndex];
	destinationX = (word16) (viewportColumn * 0x0002 + 0x0002);
	destinationY = (word16) (viewportRow << 0x04);
	spritePage = PlanarScreenBuffer;

	if (unitSpriteId != 0x0000)
	{
		DrawCompositeTacticalTile(
			unitSpriteId,
			terrainEffect != 0x00
				? (word16) terrainEffect + 0x01F2
				: terrainSpriteId,
			spritePage,
			destinationX,
			destinationY);
	}
	else if (terrainEffect != 0x00)
	{
		DrawCompositeTacticalTile(
			(word16) terrainEffect + 0x01F2,
			terrainSpriteId,
			spritePage,
			destinationX,
			destinationY);
	}
	else
	{
		DrawTacticalTileSprite(
			spritePage,
			terrainSpriteId,
			destinationX,
			destinationY);
	}
}

/* 2007:1CBD-1D05 */
void DrawTacticalTileSpriteForAdapter(
	const byte *spritePage,
	word16 spriteId,
	word16 destinationX,
	word16 destinationY)
{
	if (VideoAdapterType == VIDEO_ADAPTER_CGA
		&& (int16) spriteId >= 0x0100
		&& (int16) spriteId < 0x0200)
	{
		DrawCgaHighSpriteTile(
			spritePage, spriteId, destinationX, (byte) destinationY);
	}
	else
	{
		DrawTacticalTileSprite(
			spritePage, spriteId, destinationX, destinationY);
	}
}

/* 2007:1D06-1D60 */
void RefreshTacticalDisplay(word16 advanceEffects)
{
	if (TacticalOverviewActive != FALSE)
	{
		AdvanceTerrainEffects(advanceEffects);
		if (TacticalOverviewViewportDirty != FALSE)
		{
			RebuildTacticalViewport();
			DrawTacticalCursorOutline(TacticalCursorOutlineState);
		}
		else
		{
			RefreshTacticalOverview();
		}
	}
	else
	{
		AdvanceTerrainEffects(advanceEffects);
		/* The original draws every projectile and impact directly into
		 * visible A000h memory before rebuilding the viewport.  Publish the
		 * completed effect frame once here; presenting in the individual
		 * sprite primitive exposes only part of a multi-effect frame. */
		Video_PresentTransientFrame();
		HideMouseCursorOverlay();
		RebuildTacticalViewport();
		if (TacticalCursorOutlineEnabled != FALSE)
			DrawTacticalCursorOutline(TacticalCursorOutlineState);
		DrawSelectedUnitStatusPanel();
		ShowMouseCursorOverlay();
	}
}
