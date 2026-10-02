// REVENGE_2007_TACTICAL_EFFECTS.c - tactical display, projectile, and effect procedures.
// Reconstructed from REVENGE.EXE and its verified annotation project.

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#define TACTICAL_VIEWPORT_WIDTH_CELLS       0x0013
#define TACTICAL_VIEWPORT_HEIGHT_CELLS      0x000C
#define TACTICAL_VIEWPORT_CELL_COUNT        0x00E4
#define NO_TACTICAL_OVERLAY_SPRITE_ID       0x0000
#define TACTICAL_CURSOR_PIXEL_LEFT          0x0010
#define TACTICAL_CELL_PIXEL_SIZE            0x0010
#define TACTICAL_TRACE_DASH_INTERVAL         0x0006
#define TacticalOverlayTerrainSpriteId TacticalRuntimeState
#define TacticalStatusHeaderSpriteId PrimaryLanceResourceCode

void ApplyTerrainImpact(
	int16 mapX, int16 mapY,
	word16 advanceBeforeRecording, word16 forceAnimationRecord);
void ApplyAreaTerrainAndUnitDamage(
	int16 mapX, int16 mapY, word16 visualEffectType, int16 weaponIndex);
void ApplyWeaponDamage(
	int16 attackerUnitIndex, int16 weaponIndex, int16 targetUnitIndex);
word16 AdvanceTerrainDamageState(
	int16 mapX, int16 mapY, word16 requestedDamageState);
// 2007:1AE3 advances and removes the four-word map-edge effect records at
// DS:A800, occasionally emitting secondary impact visuals along their path.
void AdvanceMapEdgeEffects(void);
// 2007:16E8 advances the four-word impact-sprite records at DS:B2F4 and
// compacts the queue when the current sprite reaches its terminal sprite.
void AdvanceImpactSpriteAnimations(void);
void ClearTacticalEffectOverlayMap(void);
// 2007:17DE advances the 0Eh-byte projectile records at DS:A9DD toward their
// target cells, applies damage on arrival, queues an impact and compacts them.
void AdvanceTacticalProjectiles(void);
void QueueTacticalImpactVisual(
	int16 mapX, int16 mapY, word16 impactClass);
uint16 DetermineRelativeAttackDirection(
	int16 sourceX, int16 sourceY, int16 targetX, int16 targetY);
void CopyFarMemory(
	word16 byteCount,
	const byte *source,
	byte *destination);
word16 GeneratePseudoRandomByte(void);
word16 DetermineOctant(int16 deltaY, int16 deltaX);
void DrawClippedAxisAlignedLine(
	int16 x1, int16 y1, int16 x2, int16 y2, word16 color);
void DrawClippedPixel(int16 x, int16 y, word16 color);
void DrawTacticalClippedSprite(
	byte *renderTarget,
	const byte *encodedSprite,
	int16 relativeX,
	int16 relativeY,
	word16 textWindowIndex);
void DrawCgaHighSpriteTile(
	const byte *spritePage, word16 spriteId,
	word16 destinationX, byte destinationY);
void DrawCgaCompositeTacticalTile(
	word16 firstSpriteId,
	word16 secondSpriteId,
	const byte *spritePage,
	word16 destinationX,
	word16 destinationY);
void DrawTacticalTileSprite(
	const byte *spritePage, word16 spriteId,
	word16 destinationX, word16 destinationY);
void DrawCompositeTacticalTile(
	word16 firstSpriteId, word16 secondSpriteId,
	const byte *spritePage,
	word16 destinationX, word16 destinationY);
void BuildTacticalTerrainCellMaps(
	const byte *terrainTypeMap,
	word16 *tacticalCellSpriteMap,
	word16 viewportX,
	word16 viewportY);
void DrawTacticalTileSpriteForAdapter(
	const byte *spritePage,
	word16 spriteId,
	word16 destinationX,
	word16 destinationY);
void DrawSelectedUnitStatusPanel(void);
void RedrawTacticalViewport(void);
void DrawCampaignClock(void);
void FormatUnitDurabilityPercentage(int16 unitIndex);
void DrawCampaignClockSeparator(void);
int16 MapUnitToTacticalStatusSlot(word16 unitIndex);
word16 IsCurrentLanceLeader(word16 unitIndex);
void PlayScenarioDigitalSoundSequence(int8 scenarioCode);
void DispatchWeaponEffect(int16 weaponEffectId);
void RefreshTacticalOverview(void);

/* 2007:0328 is reconstructed in Tactical/REVENGE_2007_DISPLAY.c. */

// 2007:0AA4: queue one 0Eh-byte animated missile/projectile record.
// Verified against ASM 2007:0AA4-0C6E.
void QueueTacticalProjectile(
	word16 attackerUnitIndex,
	byte weaponIndex,
	word16 targetUnitIndex,
	word16 shotHit)
{
	int16 queueCount;
	RevengeTacticalProjectileRecord *record;
	word16 direction;
	word16 destinationX;
	word16 destinationY;
	word16 hasDestination;

	queueCount = (int16) TacticalProjectileCount;
	if (queueCount >= 0x0050)
		return;

	record = &TacticalProjectileRecords[queueCount];
	record->weaponIndex = weaponIndex;
	record->targetUnitIndex = (RevengeUnitSlot)targetUnitIndex;
	record->attackerUnitIndex = (RevengeUnitSlot)attackerUnitIndex;
	destinationX = (word16)record->destinationMapX;
	destinationY = (word16)record->destinationMapY;

	if ((int16)targetUnitIndex < 0x18)
	{
		direction = DetermineOctant(
			(int16)(word16)(
				ScenarioUnitMapY[attackerUnitIndex] -
				ScenarioUnitMapY[targetUnitIndex]),
			(int16)(word16)(
				ScenarioUnitMapX[targetUnitIndex] -
				ScenarioUnitMapX[attackerUnitIndex]));
	}
	else
	{
		direction = DetermineOctant(
			(int16)(word16)(
				ScenarioUnitMapY[attackerUnitIndex] -
				UnitTargetMapY[attackerUnitIndex]),
			(int16)(word16)(
				UnitTargetMapX[attackerUnitIndex] -
				ScenarioUnitMapX[attackerUnitIndex]));
	}

	hasDestination = FALSE;
	if (targetUnitIndex == 0x18)
	{
		destinationX = UnitTargetMapX[attackerUnitIndex];
		destinationY = UnitTargetMapY[attackerUnitIndex];
		hasDestination = TRUE;
	}
	else if (shotHit == FALSE)
	{
		destinationX = (word16)(
			ScenarioUnitMapX[targetUnitIndex] +
			(DirectionDeltaXTable[direction] << 0x01));
		destinationY = (word16)(
			ScenarioUnitMapY[targetUnitIndex] +
			(DirectionDeltaYTable[direction] << 0x01));
		hasDestination = TRUE;
	}

	// On a hit against a live unit the ASM stores the incoming DI register at
	// 0Ah. The sole caller, ResolveWeaponAttack at 2D1B:1D17-1D21, keeps
	// the weapon index in DI and passes that same value as weaponIndex. The word
	// at 0Ch comes from an uninitialized stack local. AdvanceTacticalProjectiles
	// ignores both destination words for a live hit, so retaining the old 0Ch
	// value preserves the executable's observable behavior without introducing
	// undefined C behavior.
	if (hasDestination == FALSE)
	{
		destinationX = (word16)weaponIndex;
	}
	record->destinationMapX = (int16)destinationX;
	record->destinationMapY = (int16)destinationY;

	record->shotHit = (byte)shotHit;
	record->spriteId = (direction << 0x01) + 0x0E;
	record->currentMapX = ScenarioUnitMapX[attackerUnitIndex];
	record->currentMapY = ScenarioUnitMapY[attackerUnitIndex];
	TacticalProjectileCount = (word16) (queueCount + 0x0001);
}

// 2007:07C9: draw the four sides of one 16x16 tactical-cell outline.
void DrawTacticalCellOutline(
	int16 leftX,
	int16 topY,
	word16 color)
{
	HideMouseCursorOverlay();
	DrawClippedAxisAlignedLine(
		leftX, topY, leftX + 0x0F, topY, color);
	DrawClippedAxisAlignedLine(
		leftX, topY, leftX, topY + 0x0F, color);
	DrawClippedAxisAlignedLine(
		leftX + 0x0F, topY, leftX + 0x0F, topY + 0x0F, color);
	DrawClippedAxisAlignedLine(
		leftX, topY + 0x0F, leftX + 0x0F, topY + 0x0F, color);
	ShowMouseCursorOverlay();
}

// 2007:079A: draw the current tactical cursor and alternate its palette color.
void DrawTacticalCursorOutline(word16 color)
{
	DrawTacticalCellOutline(
		TacticalCursorViewportX * TACTICAL_CELL_PIXEL_SIZE
			+ TACTICAL_CURSOR_PIXEL_LEFT,
		TacticalCursorViewportY * TACTICAL_CELL_PIXEL_SIZE,
		color);
	TacticalCursorOutlineState ^= 0x000F;
}

// 2007:0926: draw a clipped Bresenham-style weapon trace. When dashedTrace
// is nonzero, plot one pixel every six steps with a randomized starting phase.
// Verified against 2007:0926-0A4C.
void DrawClippedWeaponTraceLine(
	int16 startX,
	int16 startY,
	int16 endX,
	int16 endY,
	word16 color,
	word16 dashedTrace)
{
	word16 plotInterval = dashedTrace != FALSE
		? TACTICAL_TRACE_DASH_INTERVAL : 0x01;
	word16 stepsUntilPlot = dashedTrace != FALSE
		? (GeneratePseudoRandomByte() & 0x03) + 0x01 : 0x01;
	int16 deltaY = (int16)(word16)((word16)startY - (word16)endY);
	int16 deltaX = (int16)(word16)((word16)endX - (word16)startX);
	int16 absoluteY = deltaY < 0x00
		? (int16)(word16)(0x00 - (word16)deltaY) : deltaY;
	int16 absoluteX = deltaX < 0x00
		? (int16)(word16)(0x00 - (word16)deltaX) : deltaX;
	int16 majorDistance = absoluteY > absoluteX ? absoluteY : absoluteX;
	int16 minorDistance = absoluteY > absoluteX ? absoluteX : absoluteY;
	word16 octant = DetermineOctant(deltaY, deltaX);
	int16 majorStepX = WeaponTraceMajorStepX[octant];
	int16 majorStepY = WeaponTraceMajorStepY[octant];
	int16 minorStepX = WeaponTraceMinorStepX[octant];
	int16 minorStepY = WeaponTraceMinorStepY[octant];
	int16 error = majorDistance >> 0x01;

	HideMouseCursorOverlay();
	while (startX != endX || startY != endY)
	{
		stepsUntilPlot = (word16)(stepsUntilPlot - 0x01);
		if ((int16)stepsUntilPlot <= 0x00)
		{
			DrawClippedPixel(startX, startY, color);
			stepsUntilPlot = plotInterval;
		}
		if (startX != endX)
			startX = (int16)(word16)((word16)startX + (word16)majorStepX);
		if (startY != endY)
			startY = (int16)(word16)((word16)startY + (word16)majorStepY);
		error = (int16)(word16)((word16)error - (word16)minorDistance);
		if (error < 0x00)
		{
			if (startX != endX)
				startX = (int16)(word16)((word16)startX + (word16)minorStepX);
			if (startY != endY)
				startY = (int16)(word16)((word16)startY + (word16)minorStepY);
			error = (int16)(word16)((word16)error + (word16)majorDistance);
		}
	}
	DrawClippedPixel(startX, startY, color);
	ShowMouseCursorOverlay();
}

/* 2007:0DDB is reconstructed in Tactical/REVENGE_2007_DISPLAY.c. */

// 2007:16E8: void AdvanceImpactSpriteAnimations(void)
// Verified against 2007:16E8-17DD.
void AdvanceImpactSpriteAnimations(void)
{
	word16 recordIndex = 0x00;

	HideMouseCursorOverlay();
	while (recordIndex < TacticalImpactQueueCount)
	{
		RevengeTacticalImpactRecord *record =
			&TacticalImpactQueue[recordIndex];
		int16 relativeX = (int16)(word16)(
			(record->mapX - TacticalViewportMapX) << 0x04);
		int16 relativeY = (int16)(word16)(
			(record->mapY - TacticalViewportMapY) << 0x04);
		word16 spriteId = record->spriteId;

		if (spriteId >= 0x01 && spriteId < 0x06)
		{
			relativeX = (int16)(word16)((word16)relativeX - 0x0C);
			relativeY = (int16)(word16)((word16)relativeY - 0x12);
		}
		if (spriteId >= 0x06 && spriteId < 0x0E)
		{
			relativeX = (int16)(word16)((word16)relativeX - 0x04);
			relativeY = (int16)(word16)((word16)relativeY - 0x06);
		}

		DrawTacticalEffectSprite(spriteId, relativeX, relativeY);
		++spriteId;
		record->spriteId = spriteId;
		if (record->terminalSpriteId == spriteId)
		{
			word16 sourceIndex;
			for (sourceIndex = recordIndex + 0x01;
				sourceIndex < TacticalImpactQueueCount;
				++sourceIndex)
			{
				TacticalImpactQueue[sourceIndex - 0x01] =
					TacticalImpactQueue[sourceIndex];
			}
			--TacticalImpactQueueCount;
		}
		else
		{
			++recordIndex;
		}
	}
	ShowMouseCursorOverlay();
}

// 2007:17DE: advance the 0Eh-byte tactical projectile queue.
// Verified against 2007:17DE-1AE2.
void AdvanceTacticalProjectiles(void)
{
	RevengeTacticalProjectileRecord *records;
	int16 projectileIndex;

	records = TacticalProjectileRecords;
	HideMouseCursorOverlay();
	projectileIndex = 0x00;
	while (projectileIndex < (int16)TacticalProjectileCount)
	{
		RevengeTacticalProjectileRecord *projectile;
		int16 destinationMapX;
		int16 destinationMapY;
		int16 viewportPixelX;
		int16 viewportPixelY;

		projectile = &records[projectileIndex];
		viewportPixelX = (int16)(word16)(
			(word16)(projectile->currentMapX -
				(int16)TacticalViewportMapX) << 0x04);
		viewportPixelY = (int16)(word16)(
			(word16)(projectile->currentMapY -
				(int16)TacticalViewportMapY) << 0x04);
		DrawTacticalEffectSprite(
			projectile->spriteId, viewportPixelX, viewportPixelY);

		if (projectile->targetUnitIndex < TACTICAL_TARGET_MAP_CELL &&
			projectile->shotHit != FALSE)
		{
			int16 targetUnitIndex = projectile->targetUnitIndex;
			destinationMapX = ScenarioUnitMapX[targetUnitIndex];
			destinationMapY = ScenarioUnitMapY[targetUnitIndex];
		}
		else
		{
			destinationMapX = projectile->destinationMapX;
			destinationMapY = projectile->destinationMapY;
		}

		if (projectile->currentMapX == destinationMapX &&
			projectile->currentMapY == destinationMapY)
		{
			word16 impactClass;
			int16 sourceIndex;

			if (projectile->shotHit == FALSE ||
				projectile->targetUnitIndex == TACTICAL_TARGET_MAP_CELL)
			{
				AdvanceTerrainDamageState(
					destinationMapX, destinationMapY, 0x03);
			}

			impactClass = 0x0A;
			if (projectile->shotHit != FALSE)
			{
				int16 weaponIndex = projectile->weaponIndex;

				ApplyWeaponDamage(
					projectile->attackerUnitIndex,
					weaponIndex,
					projectile->targetUnitIndex);
				if (WeaponDefinitions[weaponIndex].damage
					> HEAVY_WEAPON_DAMAGE_THRESHOLD)
				{
					impactClass = 0x06;
				}
			}
			QueueTacticalImpactVisual(
				destinationMapX, destinationMapY, impactClass);

			--projectileIndex;
			sourceIndex = projectileIndex + 0x01;
			while (sourceIndex < (int16)TacticalProjectileCount)
			{
				records[sourceIndex] = records[sourceIndex + 0x01];
				++sourceIndex;
			}
			--TacticalProjectileCount;
		}
		else
		{
			word16 direction;

			direction = DetermineRelativeAttackDirection(
				projectile->currentMapX,
				projectile->currentMapY,
				destinationMapX,
				destinationMapY);
			if (projectile->currentMapX != destinationMapX)
			{
				projectile->currentMapX = (int16)(word16)(
					(word16)projectile->currentMapX +
					DirectionDeltaXTable[direction]);
			}
			if (projectile->currentMapY != destinationMapY)
			{
				projectile->currentMapY = (int16)(word16)(
					(word16)projectile->currentMapY +
					DirectionDeltaYTable[direction]);
			}
			projectile->spriteId = (word16)(
				(projectile->spriteId & 0x00FE) |
				((projectile->spriteId + 0x01) & 0x0001));
		}
		++projectileIndex;
	}
	ShowMouseCursorOverlay();
}

// 2007:1219: rebuild the byte overlay map used for the current 19x12 tactical
// viewport. Each active terrain-impact record advances through three variants
// unless animation is paused, then contributes variant+1 to its visible cell.
void BuildTacticalTerrainEffectOverlay(void)
{
	RevengeTerrainImpactAnimationRecord *records;
	RevengeTerrainImpactAnimationRecord *record;
	word16 recordIndex;
	int16 viewportX;
	int16 viewportY;

	// Verified against 2007:1219-132B.
	records = TerrainImpactAnimationRecords;
	ClearTacticalEffectOverlayMap();
	for (recordIndex = 0x00; recordIndex < 0x5A; ++recordIndex)
	{
		record = &records[recordIndex];

		if (TacticalInteractionLocked == 0x00)
		{
			record->animationVariant =
				(word16) (record->animationVariant + 0x01);
			if ((int16) record->animationVariant > 0x02)
				record->animationVariant = 0x00;
		}

		viewportX = record->mapX - (int16)TacticalViewportMapX;
		viewportY = record->mapY - (int16)TacticalViewportMapY;
		if (viewportX >= 0x00 && viewportX < TACTICAL_VIEWPORT_WIDTH_CELLS
			&& viewportY >= 0x00 && viewportY < TACTICAL_VIEWPORT_HEIGHT_CELLS)
		{
			TacticalEffectOverlayMap[
				viewportY * TACTICAL_VIEWPORT_WIDTH_CELLS + viewportX] =
				(byte)(record->animationVariant + 0x01);
		}
	}
}

// 2007:1AE3: void AdvanceMapEdgeEffects(void)
// Verified against 2007:1AE3-1CBC.
void AdvanceMapEdgeEffects(void)
{
	RevengeMapEdgeEffectRecord *effects = MapEdgeEffectQueue;
	word16 effectIndex = 0x00;

	while (effectIndex < MapEdgeEffectCount)
	{
		RevengeMapEdgeEffectRecord *effect = &effects[effectIndex];
		int16 mapX = (int16)effect->mapX;
		int16 mapY = (int16)effect->mapY;
		int16 impactX = mapX;
		int16 impactY = mapY;
		word16 removeEffect = FALSE;

		switch (effect->edgeDirection)
		{
		case 0x00:
			impactX = mapX + (int16)(GeneratePseudoRandomByte() & 0x01);
			impactY = mapY + (int16)(GeneratePseudoRandomByte() & 0x03) - 0x06;
			--mapY;
			if (mapY < -0x01)
				removeEffect = TRUE;
			break;

		case 0x01:
			impactY = mapY - (int16)(GeneratePseudoRandomByte() & 0x01);
			impactX = mapX + (int16)(GeneratePseudoRandomByte() & 0x03) + 0x04;
			++mapX;
			if (mapX >= (int16)MapWidth)
				removeEffect = TRUE;
			break;

		case 0x02:
			impactX = mapX + (int16)(GeneratePseudoRandomByte() & 0x01);
			impactY = mapY + (int16)(GeneratePseudoRandomByte() & 0x03) + 0x06;
			++mapY;
			if (mapY >= (int16)MapHeight)
				removeEffect = TRUE;
			break;

		case 0x03:
			impactY = mapY - (int16)(GeneratePseudoRandomByte() & 0x01);
			impactX = mapX - (int16)(GeneratePseudoRandomByte() & 0x03) - 0x04;
			--mapX;
			if (mapX < -0x01)
				removeEffect = TRUE;
			break;

		default:
			break;
		}

		if ((GeneratePseudoRandomByte() & 0x01) != 0x00)
		{
			word16 weaponIndex = (GeneratePseudoRandomByte() & 0x07)
				+ WEAPON_SMALL_PULSE_LASER;
			word16 visualEffectType = 0x0A;

			if (weaponIndex > WEAPON_SMALL_PULSE_LASER)
				visualEffectType = 0x06;
			if (weaponIndex > WEAPON_MEDIUM_PULSE_LASER)
				visualEffectType = 0x01;
			ApplyAreaTerrainAndUnitDamage(
				impactX, impactY, visualEffectType, (int16)weaponIndex);
		}

		effect->mapX = (word16)mapX;
		effect->mapY = (word16)mapY;
		if (removeEffect != FALSE)
		{
			word16 sourceIndex;

			for (sourceIndex = effectIndex + 0x01;
				sourceIndex < MapEdgeEffectCount; ++sourceIndex)
				effects[sourceIndex - 0x01] = effects[sourceIndex];
			--MapEdgeEffectCount;
		}
		else
			++effectIndex;
	}
}

// 2007:021A: clip a map-cell sprite rectangle to the 19x12 viewport and
// stamp sequential sprite IDs into the display maps.
void StampTacticalSpriteRectangle(
	int16 mapX,
	int16 mapY,
	word16 widthCells,
	word16 heightCells,
	word16 firstSpriteId)
{
	word16 sourceRowStride;
	word16 viewportCellIndex;
	word16 column;
	word16 spriteId;
	int16 viewportMapX;
	int16 viewportMapY;
	int16 viewportX;
	int16 viewportY;
	int16 rectangleRight;
	int16 rectangleBottom;

	// Verified against 2007:021A-0327.
	sourceRowStride = widthCells;
	viewportMapX = (int16) TacticalViewportMapX;
	viewportMapY = (int16) TacticalViewportMapY;
	rectangleRight = (int16) (word16) ((word16) mapX + widthCells);
	rectangleBottom = (int16) (word16) ((word16) mapY + heightCells);

	if (mapX >= (int16) (word16) ((word16) viewportMapX
			+ TACTICAL_VIEWPORT_WIDTH_CELLS)
		|| mapY >= (int16) (word16) ((word16) viewportMapY
			+ TACTICAL_VIEWPORT_HEIGHT_CELLS)
		|| rectangleRight <= viewportMapX
		|| rectangleBottom <= viewportMapY)
		goto clear_overlay;

	viewportX = (int16) (word16) ((word16) mapX - (word16) viewportMapX);
	viewportY = (int16) (word16) ((word16) mapY - (word16) viewportMapY);
	if (viewportY < 0x00)
	{
		heightCells = (word16) (heightCells + (word16) viewportY);
		firstSpriteId = (word16) (firstSpriteId
			+ (word16) ((word16) -viewportY * sourceRowStride));
		viewportY = 0x00;
	}
	if (viewportX < 0x00)
	{
		widthCells = (word16) (widthCells + (word16) viewportX);
		firstSpriteId = (word16) (firstSpriteId - (word16) viewportX);
		viewportX = 0x00;
	}
	if ((int16) (word16) ((word16) viewportX + widthCells)
		> TACTICAL_VIEWPORT_WIDTH_CELLS)
		widthCells = TACTICAL_VIEWPORT_WIDTH_CELLS - viewportX;
	if ((int16) (word16) ((word16) viewportY + heightCells)
		> TACTICAL_VIEWPORT_HEIGHT_CELLS)
		heightCells = TACTICAL_VIEWPORT_HEIGHT_CELLS - viewportY;

	viewportCellIndex = (word16) ((word16) viewportY
		* TACTICAL_VIEWPORT_WIDTH_CELLS + (word16) viewportX);
	while (heightCells-- != 0x00)
	{
		spriteId = firstSpriteId;
		if (TacticalOverlayTerrainSpriteId
			!= NO_TACTICAL_OVERLAY_SPRITE_ID)
		{
			TacticalCellTerrainMap[viewportCellIndex] =
				TacticalOverlayTerrainSpriteId;
		}
		for (column = 0x00; column < widthCells; ++column)
		{
			TacticalCellSpriteMap[viewportCellIndex + column] =
				spriteId++;
		}
		firstSpriteId += sourceRowStride;
		viewportCellIndex += TACTICAL_VIEWPORT_WIDTH_CELLS;
	}

clear_overlay:
	TacticalOverlayTerrainSpriteId =
		NO_TACTICAL_OVERLAY_SPRITE_ID;
}

// 2007:0007: compose destruction, upgrade, unit, and edge-effect sprites into
// the tactical viewport's two 19x12 cell maps.
// VERIFIED against 2007:0007-01ED.
void ComposeTacticalSpriteMaps(void)
{
	RevengeMapEdgeEffectRecord *effects;
	byte *marker;
	RevengeUnitRecord *unitRecord;
	int16 effectCount;
	int16 markerIndex;
	int16 unitIndex;
	word16 drawUnit;
	word16 drewContactMarker;

	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		marker = UnitDestructionMarkers[(word16) unitIndex];
		if (marker[0x02] != 0x00)
			StampTacticalSpriteRectangle(
				marker[0x00], marker[0x01],
				0x0001, 0x0001, 0x0100 + marker[0x02]);
	}
	for (markerIndex = 0x0000; markerIndex < 0x0004; ++markerIndex)
	{
		if (CampaignUpgradeAwards[markerIndex] != 0x00)
			StampTacticalSpriteRectangle(
				CampaignUpgradeMarkerX[markerIndex],
				CampaignUpgradeMarkerY[markerIndex],
				0x0001, 0x0001, 0x01DA);
	}

	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		unitRecord = &PersistentUnitRoster[unitIndex];
		if (unitRecord->deploymentState != 0x01)
			continue;

		drewContactMarker = FALSE;
		if (unitIndex < 0x000C)
			drawUnit = TRUE;
		else if (TacticalOverviewMapMode == FALSE)
			drawUnit = TRUE;
		else
		{
			drawUnit = UnitEnemyVisible[unitIndex];
			if (drawUnit == FALSE &&
				UnitEnemyInProximityRange[unitIndex] != FALSE)
			{
				StampTacticalSpriteRectangle(
					ScenarioUnitMapX[unitIndex],
					ScenarioUnitMapY[unitIndex],
					0x0001, 0x0001, 0x01EF);
				drewContactMarker = TRUE;
			}
		}
		if (drawUnit != FALSE)
		{
			if (UnitJumpingState[unitIndex] != 0x00
				&& UnitJumpMovementRemaining[unitIndex] != 0x00)
				TacticalOverlayTerrainSpriteId =
					((ScenarioUnitMapX[unitIndex]
						^ ScenarioUnitMapY[unitIndex]) & 0x01) + 0x01F1;
			StampTacticalSpriteRectangle(
				ScenarioUnitMapX[unitIndex],
				ScenarioUnitMapY[unitIndex],
				0x0001, 0x0001,
				UnitSpriteId[unitIndex]);
		}
		else if (unitIndex >= 0x000C
			&& unitIndex == TacticalSelectedUnitIndex
			&& drewContactMarker == FALSE)
			TacticalSelectedUnitIndex = 0xFFFF;
	}

	effectCount = (int16) MapEdgeEffectCount;
	effects = MapEdgeEffectQueue;
	for (markerIndex = 0x0000; markerIndex < effectCount; ++markerIndex)
		StampTacticalSpriteRectangle(
			effects[markerIndex].mapX,
			effects[markerIndex].mapY,
			0x0002, 0x0002,
			effects[markerIndex].spriteId);
}

// 2007:0650: void RebuildTacticalViewport(void)
// Verified against 2007:0650-0799.
void RebuildTacticalViewport(void)
{
	const byte *spritePage = PlanarScreenBuffer;
	word16 viewportCellIndex = 0x00;
	word16 row;
	word16 column;
	word16 statusSlot;
	word16 destinationY;

	BuildTacticalTerrainCellMaps(
		TerrainTypeMap,
		TacticalCellSpriteMap,
		TacticalViewportMapX,
		TacticalViewportMapY);
	BuildTacticalTerrainEffectOverlay();
	ComposeTacticalSpriteMaps();

	for (row = 0x00; row < TACTICAL_VIEWPORT_HEIGHT_CELLS; ++row)
	{
		for (column = 0x00; column < TACTICAL_VIEWPORT_WIDTH_CELLS; ++column)
		{
			DrawTacticalViewportCell(column, row, viewportCellIndex);
			++viewportCellIndex;
		}
	}

	if (TacticalOverviewActive != 0x00)
		return;

	destinationY = 0x00;
	for (statusSlot = 0x00; statusSlot < 0x07; ++statusSlot)
	{
		byte runtimeValue = UnitTypeResourceCode[statusSlot];
		int8 runtimeState = TacticalSlotSpriteState[statusSlot];
		if (runtimeValue != 0x00
			&& runtimeState != TacticalStatusRowInvalidation[statusSlot])
		{
			word16 firstSpriteId = 0x0100 + runtimeValue;
			word16 secondSpriteId = 0x01F6 + runtimeState;
			if (VideoAdapterType != VIDEO_ADAPTER_CGA)
			{
				DrawCompositeTacticalTile(
					firstSpriteId, secondSpriteId,
					spritePage, 0x00, destinationY);
			}
			else
			{
				DrawCgaCompositeTacticalTile(
					firstSpriteId, secondSpriteId,
					spritePage, 0x00, destinationY);
			}
			TacticalStatusRowInvalidation[statusSlot] = runtimeState;
		}
		destinationY += 0x14;
		if (statusSlot == 0x04)
			destinationY += 0x04;
	}

	if (TacticalContactMarkerPending == 0xFF)
	{
		DrawTacticalTileSpriteForAdapter(
			spritePage, 0x01EF, 0x00, 0x0098);
		TacticalContactMarkerPending = 0x00;
	}
	if (TacticalStatusHeaderSpriteId != 0x00)
	{
		DrawTacticalTileSpriteForAdapter(
			spritePage,
			0x0100 + TacticalStatusHeaderSpriteId,
			0x00,
			0x00B0);
	}
}

// 2007:01EE: void DrawTileAlignedText(
//     char far *text, word16 tileX, word16 tileY,
//     byte foregroundColor, byte backgroundColor)
void DrawTileAlignedText(
	const char *text,
	word16 tileX,
	word16 tileY,
	byte foregroundColor,
	byte backgroundColor)
{
	DrawTextString(
		text,
		tileX << 0x03,
		tileY << 0x03,
		foregroundColor,
		backgroundColor);
}

// 2007:0C6F: draw a one-pixel border immediately outside the active text
// window's tile rectangle.
// Verified against 2007:0C6F-0CFA.
void DrawActiveTextWindowBorder(word16 color)
{
	word16 leftX = (word16)((word16)(
		ActiveTextWindowLeftTile << 0x03) - 0x01);
	word16 topY = (word16)((word16)(
		ActiveTextWindowTopTile << 0x03) - 0x01);
	word16 rightX = (word16)(leftX + (word16)(
		ActiveTextWindowWidthTiles << 0x03));
	word16 bottomY = (word16)(topY + (word16)(
		ActiveTextWindowHeightTiles << 0x03));

	DrawClippedAxisAlignedLine(leftX, topY, rightX, topY, color);
	DrawClippedAxisAlignedLine(leftX, topY, leftX, bottomY, color);
	DrawClippedAxisAlignedLine(rightX, topY, rightX, bottomY, color);
	DrawClippedAxisAlignedLine(leftX, bottomY, rightX, bottomY, color);
}

/* 2007:1CBD is reconstructed in Tactical/REVENGE_2007_DISPLAY.c. */

// 2007:14DF: update the outline around one primary unit-status row only when
// its row or blink color changed.
void UpdatePrimaryUnitStatusRowHighlight(word16 rowIndex)
{
	word16 previousRow = PrimaryStatusRow;
	word16 color = PrimaryStatusHighlightColor;
	int16 topY;

	if (TacticalUiSuppressed != FALSE
		|| (previousRow == rowIndex && CachedPrimaryStatusHighlightColor == color))
		return;
	topY = rowIndex * 0x14;
	if (rowIndex >= 0x05)
		topY += 0x04;
	if (rowIndex == 0x07)
		topY += 0x08;
	DrawTacticalCellOutline(0x00, topY, color);
	if (previousRow != rowIndex)
		TacticalStatusRowInvalidation[previousRow * 0x02] = 0xFF;
		TacticalStatusRowInvalidation[previousRow * 0x02 + 0x01] = 0xFF;
	PrimaryStatusRow = rowIndex;
	CachedPrimaryStatusHighlightColor = color;
}

// 2007:1544: equivalent cached outline update for the secondary command row.
void UpdateSecondaryUnitStatusRowHighlight(word16 rowIndex)
{
	word16 previousRow = SecondaryStatusRow;
	word16 color = SecondaryStatusHighlightColor;
	int16 topY;

	if (previousRow == rowIndex && CachedSecondaryStatusHighlightColor == color)
		return;
	topY = rowIndex * 0x14;
	if (rowIndex >= 0x05)
		topY += 0x04;
	if (rowIndex >= 0x07)
		return;
	DrawTacticalCellOutline(0x00, topY, color);
	if (previousRow != rowIndex)
		TacticalStatusRowInvalidation[previousRow * 0x02] = 0xFF;
		TacticalStatusRowInvalidation[previousRow * 0x02 + 0x01] = 0xFF;
	SecondaryStatusRow = rowIndex;
	CachedSecondaryStatusHighlightColor = color;
}

