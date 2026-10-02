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

// 2007:042A: void AdvanceTerrainEffects(word16 advanceEffects)
//
// Advance queued two-bit terrain damage, redraw the terrain layer when the
// tactical display permits it, and let active DS:810C animation records spread
// to adjacent cells or expire. The queue stores word pairs: packed damage-map
// byte index followed by the two-bit subcell index.
// Verified against 2007:042A-064F.
void AdvanceTerrainEffects(word16 advanceEffects)
{
	if (advanceEffects != FALSE)
	{
		int16 queueEntryIndex;
		for (queueEntryIndex = 0x00;
			queueEntryIndex < (int16)(TerrainDamageQueueWordCount >> 0x01);
			++queueEntryIndex)
		{
			RevengeTerrainDamageQueueEntry *entry =
				&TerrainDamageQueue[queueEntryIndex];
			word16 packedByteIndex = entry->packedByteIndex;
			word16 subcellIndex = entry->subcellIndex;
			byte occupiedMask = TerrainDamageCellOccupiedMask[subcellIndex];
			byte increment = TerrainDamageStageIncrement[subcellIndex];
			byte *packedDamageByte =
				&PackedTerrainDamageMap[packedByteIndex];

			if ((*packedDamageByte & occupiedMask) != occupiedMask)
			{
				*packedDamageByte += increment;
				continue;
			}

			// The queued cell reached its terminal staged value. Toggle the
			// occupied bits and remove this word pair without leaving a gap.
			*packedDamageByte ^= occupiedMask;
			int16 sourceEntryIndex;
			for (sourceEntryIndex = queueEntryIndex + 0x01;
				sourceEntryIndex <
					(int16)(TerrainDamageQueueWordCount >> 0x01);
				++sourceEntryIndex)
			{
				TerrainDamageQueue[sourceEntryIndex - 0x01] =
					TerrainDamageQueue[sourceEntryIndex];
			}
			TerrainDamageQueueWordCount -= 0x02;
			--queueEntryIndex;
		}
	}

	if (TacticalOverviewViewportDirty == 0x00)
		AdvanceMapEdgeEffects();

	if (advanceEffects != FALSE)
	{
		RevengeTerrainImpactAnimationRecord *records =
			TerrainImpactAnimationRecords;
		word16 recordIndex;
		for (recordIndex = 0x00; recordIndex < 0x5A; ++recordIndex)
		{
			RevengeTerrainImpactAnimationRecord *record =
				&records[recordIndex];
			word16 randomDirection;
			if (record->mapX == -0x01)
				continue;

			randomDirection = GeneratePseudoRandomByte() & 0x7F;
			switch (randomDirection)
			{
			case 0x00:
			case 0x01:
				ApplyTerrainImpact(
					record->mapX - 0x01, record->mapY, FALSE, FALSE);
				break;
			case 0x02:
			case 0x03:
				ApplyTerrainImpact(
					record->mapX + 0x01, record->mapY, FALSE, FALSE);
				break;
			case 0x04:
			case 0x05:
				ApplyTerrainImpact(
					record->mapX, record->mapY - 0x01, FALSE, FALSE);
				break;
			case 0x06:
			case 0x07:
				ApplyTerrainImpact(
					record->mapX, record->mapY + 0x01, FALSE, FALSE);
				break;
			case 0x09:
				record->mapX = -0x01;
				break;
			}
		}
	}

	AdvanceImpactSpriteAnimations();
	AdvanceTacticalProjectiles();
}

// 2007:0846: void QueueTacticalImpactVisual(
//     int16 mapX, int16 mapY, word16 impactClass)
// Verified against 2007:0846-08D4 and all executable call sites.
void QueueTacticalImpactVisual(
	int16 mapX,
	int16 mapY,
	word16 impactClass)
{
	word16 impactSpriteId;
	word16 soundEffectId;
	word16 queueIndex = TacticalImpactQueueCount;
	RevengeTacticalImpactRecord *record;

	if (queueIndex >= 0x50)
		return;

	// V: these are the only classes passed by the four executable call sites.
	switch (impactClass)
	{
	case 0x01:
		impactSpriteId = 0x06;
		soundEffectId = 0x04;
		break;
	case 0x06:
		impactSpriteId = 0x0A;
		soundEffectId = 0x02;
		break;
	case 0x0A:
		impactSpriteId = 0x0E;
		soundEffectId = 0x0E;
		break;
	default:
		// The original leaves DI unchanged for any other value. No known caller
		// exercises that undefined path, so do not manufacture a sprite ID.
		return;
	}

	record = &TacticalImpactQueue[queueIndex];
	record->mapX = mapX;
	record->mapY = mapY;
	record->spriteId = impactClass;
	record->terminalSpriteId = impactSpriteId;
	DispatchWeaponEffect(soundEffectId);
	TacticalImpactQueueCount = queueIndex + 0x01;
}

// 2007:08D5: void QueueMapEdgeEffect(
//     short mapX, short mapY, word16 baseSpriteId, word16 edgeDirection)
void QueueMapEdgeEffect(
	int16 mapX,
	int16 mapY,
	word16 baseSpriteId,
	word16 edgeDirection)
{
	word16 queueCount = MapEdgeEffectCount;
	if (queueCount >= 0x03)
		return;

	RevengeMapEdgeEffectRecord *record =
		&MapEdgeEffectQueue[queueCount];
	record->mapX = mapX;
	record->mapY = mapY;
	record->spriteId = baseSpriteId + (edgeDirection << 0x02);
	record->edgeDirection = edgeDirection;
	MapEdgeEffectCount = queueCount + 0x01;
}

// 2007:0CFB: void ApplyAreaTerrainAndUnitDamage(
//     short mapX, short mapY, word16 visualEffectType, short weaponIndex)
// Verified against 2007:0CFB-0D8F.
void ApplyAreaTerrainAndUnitDamage(
	int16 mapX,
	int16 mapY,
	word16 visualEffectType,
	int16 weaponIndex)
{
	word16 impactMapX = (word16) mapX;
	word16 impactMapY = (word16) mapY;
	word16 adjacentMapX = impactMapX + 0x01;
	word16 adjacentMapY = impactMapY + 0x01;

	QueueTacticalImpactVisual(mapX, mapY, visualEffectType);
	AdvanceTerrainDamageState(mapX, mapY, 0x03);

	word16 unitIndex;
	for (unitIndex = 0x00; unitIndex < 0x18; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord =
			&PersistentUnitRoster[unitIndex];
		if (unitRecord->deploymentState == 0x00)
			continue;

		word16 unitX = ScenarioUnitMapX[unitIndex];
		word16 unitY = ScenarioUnitMapY[unitIndex];
		if ((unitX == impactMapX || unitX == adjacentMapX)
			&& (unitY == impactMapY || unitY == adjacentMapY))
		{
			ApplyWeaponDamage(0x00, weaponIndex, unitIndex);
		}
	}
}

/* 2007:1D06 is reconstructed in Tactical/REVENGE_2007_DISPLAY.c. */

// 2007:1D61: format the selected unit's remaining durability percentage in
// the shared text buffer. Opposing units deliberately expose only 10% steps.
void FormatUnitDurabilityPercentage(int16 unitIndex)
{
	RevengeUnitRecord *unitRecord =
		&PersistentUnitRoster[unitIndex];
	word16 percentage;

	CalculateUnitDurabilityTotals(unitRecord);
	if (unitIndex >= 0x0C)
	{
		percentage = (word16)(
			((uint32)CurrentUnitDurabilityTotal * 0x0A)
			/ MaximumUnitDurabilityTotal) * 0x0A;
	}
	else
	{
		percentage = (word16)(
			((uint32)CurrentUnitDurabilityTotal * 0x64)
			/ MaximumUnitDurabilityTotal);
	}

	IntegerToString(
		percentage,
		SharedNumericTextBuffer,
		0x0A);
	FarStringConcat(
		SharedNumericTextBuffer,
		PercentageSuffixText);
}

// 2007:1DCC: void DrawCampaignClockSeparator(void)
void DrawCampaignClockSeparator(void)
{
	byte separatorColor = (LOW_WORD(GameAnimationTicks) & 0x10) != 0x00
		? 0x0F
		: 0x0C;
	HideMouseCursorOverlay();
	DrawTileAlignedText(
		CampaignClockSeparatorText,
		0x25,
		0x18,
		separatorColor,
		0x0C);
	ShowMouseCursorOverlay();
}

// 2007:15FF: void DrawCampaignClock(void)
// Verified against 2007:15FF-16B9.
void DrawCampaignClock(void)
{
	char *clockText;
	int16 clockValue;
	word16 firstDigitOffset;

	if (SuppressCampaignClock != 0x00
		|| TacticalOverviewActive != 0x00)
	{
		return;
	}

	clockText = SharedNumericTextBuffer;
	clockText[0x00] = '\0';
	clockValue = CampaignClockState[0x00];
	firstDigitOffset = 0x00;
	if (clockValue < 0x0A)
	{
		clockText[0x00] = '0';
		firstDigitOffset = 0x01;
	}
	IntegerToString(
		clockValue,
		clockText + firstDigitOffset,
		0x0A);
	HideMouseCursorOverlay();
	DrawTileAlignedText((char *)clockText, 0x23, 0x18, 0x0F, 0x0C);
	ShowMouseCursorOverlay();

	DrawCampaignClockSeparator();

	clockValue = CampaignClockState[0x01];
	firstDigitOffset = 0x00;
	if (clockValue < 0x0A)
	{
		clockText[0x00] = '0';
		firstDigitOffset = 0x01;
	}
	IntegerToString(
		clockValue,
		clockText + firstDigitOffset,
		0x0A);
	HideMouseCursorOverlay();
	DrawTileAlignedText((char *)clockText, 0x26, 0x18, 0x0F, 0x0C);
	ShowMouseCursorOverlay();
}

// 2007:132C: draw a raised, beveled menu button at a text-cell position.
// Called from:
//      RunMainMenuSelection
void DrawBeveledMenuButton(
	word16 textColumn,
	word16 textRow,
	const char * text,
	word16 widthPixels)
{
	word16 fontHeight = ActiveFontLineHeight;
	word16 glyphAdvance = ActiveFontGlyphAdvanceX;
	word16 leftX = (ActiveTextWindowLeftTile << 0x03)
		+ textColumn * glyphAdvance;
	word16 topY = (ActiveTextWindowTopTile << 0x03)
		+ textRow * fontHeight;

	// Verified against 2007:132C-14DE.
	HideMouseCursorOverlay();
	FillVideoRectangle(leftX - 0x02, topY - 0x02,
		leftX + widthPixels + 0x02, topY + fontHeight + 0x01, 0x0E);
	DrawCenteredClippedText(text, 0x00, leftX, topY,
		widthPixels, 0x0F, 0x00);
	DrawClippedAxisAlignedLine(leftX - 0x04, topY - 0x03,
		leftX + widthPixels + 0x02, topY - 0x03, 0x0F);
	DrawClippedAxisAlignedLine(leftX - 0x03, topY - 0x02,
		leftX + widthPixels + 0x01, topY - 0x02, 0x0F);
	DrawClippedAxisAlignedLine(leftX - 0x04, topY - 0x02,
		leftX - 0x04, topY + fontHeight + 0x01, 0x0F);
	DrawClippedAxisAlignedLine(leftX - 0x03, topY - 0x01,
		leftX - 0x03, topY + fontHeight, 0x0F);
	DrawClippedAxisAlignedLine(leftX + widthPixels + 0x02, topY - 0x02,
		leftX + widthPixels + 0x02, topY + fontHeight + 0x01, 0x0D);
	DrawClippedAxisAlignedLine(leftX + widthPixels + 0x01, topY - 0x01,
		leftX + widthPixels + 0x01, topY + fontHeight, 0x0D);
	DrawClippedAxisAlignedLine(leftX - 0x02, topY + fontHeight,
		leftX + widthPixels + 0x01, topY + fontHeight, 0x0D);
	DrawClippedAxisAlignedLine(leftX - 0x03, topY + fontHeight + 0x01,
		leftX + widthPixels + 0x01, topY + fontHeight + 0x01, 0x0D);
	ShowMouseCursorOverlay();
}

// 2007:0A4D: uint16 DetermineOctant(int16 deltaY, int16 deltaX)
uint16 DetermineOctant(int16 deltaY, int16 deltaX)
{
	int16 negativeX;
	int16 negativeY;

	if (deltaY < 0x00)
	{
		if (deltaX > 0x00)
		{
			negativeY = (int16) (0x0000u - (uint16) deltaY);
			return negativeY > deltaX ? 0x03 : 0x02;
		}
		negativeX = (int16) (0x0000u - (uint16) deltaX);
		negativeY = (int16) (0x0000u - (uint16) deltaY);
		return negativeX > negativeY ? 0x05 : 0x04;
	}

	if (deltaX > 0x00)
		return deltaX > deltaY ? 0x01 : 0x00;

	negativeX = (int16) (0x0000u - (uint16) deltaX);
	return negativeX < deltaY ? 0x07 : 0x06;
}

// 2007:0D90: uint16 CalculateApproximateMapDistance(
//     Stack int16 sourceX, Stack int16 sourceY,
//     Stack int16 targetX, Stack int16 targetY)
// Called from:
//      ResolveWeaponAttack
uint16 CalculateApproximateMapDistance(
	int16 sourceX,
	int16 sourceY,
	int16 targetX,
	int16 targetY)
{
	int16 deltaX;
	int16 deltaY;
	int16 distance;

	deltaX = (int16) ((uint16) sourceX - (uint16) targetX);
	deltaY = (int16) ((uint16) sourceY - (uint16) targetY);
	if (deltaX < 0x00)
		deltaX = (int16) (0x0000u - (uint16) deltaX);
	if (deltaY < 0x00)
		deltaY = (int16) (0x0000u - (uint16) deltaY);

	if (deltaX > deltaY)
		distance = (int16) (deltaX + (deltaY >> 0x01));
	else
		distance = (int16) (deltaY + (deltaX >> 0x01));
	return (uint16) distance;
}

// 2007:0E19: resolve the selected or cursor-contact unit, populate tactical
// text window 6, maintain both status-row highlights, and service the pending
// narration countdown.
// Verified against 2007:0E19-1218.
void DrawSelectedUnitStatusPanel(void)
{
	word16 narrationStatusRow;
	word16 displayedStatusRow;
	word16 selectedUnitIndex;
	word16 cursorSpriteId = 0x0000;
	word16 drawUnitDetails;
	word16 heatScaleIndex;
	word16 textLength;
	word16 narrationColor;
	word16 viewportCellIndex;
	word16 mapX;
	word16 mapY;
	word16 unitIndex;
	int16 blinkCountdown;
	byte unitTypeId;
	RevengeUnitRecord *unitRecord;
	char *statusText;

	narrationStatusRow = 0xFFFF;
	displayedStatusRow = 0xFFFF;
	if (PendingNarrationDelay != 0x0000)
		narrationStatusRow = MapUnitToTacticalStatusSlot(
			ActiveNarrationSubject);

	selectedUnitIndex = TacticalSelectedUnitIndex;
	if (selectedUnitIndex == 0xFFFF)
	{
		viewportCellIndex = (word16)(
			TacticalCursorViewportY *
				TACTICAL_VIEWPORT_WIDTH_CELLS +
			TacticalCursorViewportX);
		cursorSpriteId =
			TacticalCellSpriteMap[viewportCellIndex];
		if (cursorSpriteId != 0x0000)
		{
			mapX = (word16)(TacticalViewportMapX +
				TacticalCursorViewportX);
			mapY = (word16)(TacticalViewportMapY +
				TacticalCursorViewportY);
			for (unitIndex = 0x0000;
				unitIndex < 0x0018 && selectedUnitIndex == 0xFFFF;
				++unitIndex)
			{
				unitRecord = &PersistentUnitRoster[unitIndex];
				if (unitRecord->deploymentState != 0x00 &&
					ScenarioUnitMapX[unitIndex] == mapX &&
					ScenarioUnitMapY[unitIndex] == mapY)
				{
					selectedUnitIndex = unitIndex;
				}
			}
		}
	}

	if (selectedUnitIndex == 0xFFFF)
	{
		HideMouseCursorOverlay();
		DrawTileAlignedText(
			TacticalNoUnitStatusText,
			0x0000, 0x0018, 0x0C, 0x0C);
		ShowMouseCursorOverlay();
		if (DisplayedTacticalStatusRow != 0xFFFF)
		{
			TacticalStatusRowInvalidation[
				DisplayedTacticalStatusRow] = 0xFF;
			DisplayedTacticalStatusRow = 0xFFFF;
		}
	}
	else
	{
		SelectTextWindow(0x0006);
		ActiveTextCursorRow = 0x0000;
		ActiveTextCursorColumn = 0x0000;
		ActiveTextForegroundColor = 0x000F;
		ActiveTextBackgroundColor = 0x000C;
		drawUnitDetails = TRUE;

		if (selectedUnitIndex >= 0x000C)
		{
			HideMouseCursorOverlay();
			if (TacticalSelectedUnitIndex == 0xFFFF &&
				(cursorSpriteId & 0x00FF) == 0x00EF)
			{
				ClearActiveTextWindow();
				DrawCampaignClock();
				RedrawTacticalViewport();
				drawUnitDetails = FALSE;
			}
			else if (UnitEnemyVisible[selectedUnitIndex] ==
					FALSE &&
				UnitEnemyInProximityRange[
					selectedUnitIndex] == FALSE &&
				TacticalOverviewMapMode != 0x0000)
			{
				drawUnitDetails = FALSE;
			}
			ShowMouseCursorOverlay();
		}

		if (drawUnitDetails != FALSE)
		{
			HideMouseCursorOverlay();
			if (selectedUnitIndex < 0x0004 ||
				IsCurrentLanceLeader(selectedUnitIndex) != FALSE)
			{
				RenderFormattedText(selectedUnitIndex < 0x000C
					? FriendlyUnitStatusHeading
					: EnemyUnitStatusHeading);
			}
			if (selectedUnitIndex >= 0x000C)
			{
				ActiveTextForegroundColor = 0x0006;
				EnemyCycleUnitIndex = selectedUnitIndex;
			}

			unitRecord = &PersistentUnitRoster[selectedUnitIndex];
			unitTypeId = unitRecord->unitTypeId;
			RenderFormattedText(UnitNameTable[unitTypeId]);
			RenderFormattedText(
				UnitStatusSeparatorText);
			FormatUnitDurabilityPercentage(selectedUnitIndex);

			statusText = SharedNumericTextBuffer;
			FarStringConcat(
				statusText,
				UnitHeatStatusPrefix);
			heatScaleIndex =
				(word16)(unitRecord->currentHeat / BATTLEMECH_HEAT_SCALE);
			if (heatScaleIndex > 0x0005)
				heatScaleIndex = 0x0005;
			if (UnitShutdownState[selectedUnitIndex] != 0x00)
				heatScaleIndex = 0x0006;
			FarStringConcat(
				statusText,
				(const char *)HeatScaleDescriptionTable[
					heatScaleIndex]);

			textLength = StringLength(statusText);
			while ((word16)(textLength +
				ActiveTextCursorColumn) < 0x001B)
			{
				statusText[textLength] = ' ';
				++textLength;
			}
			statusText[(word16)(0x001B -
				ActiveTextCursorColumn)] = '\0';
			RenderFormattedText(statusText);

			displayedStatusRow =
				MapUnitToTacticalStatusSlot(selectedUnitIndex);
			if (displayedStatusRow != 0xFFFF)
			{
				if (narrationStatusRow == 0xFFFF ||
					displayedStatusRow != narrationStatusRow ||
					TacticalStatusBlinkVisible == 0x00)
				{
					UpdatePrimaryUnitStatusRowHighlight(
						displayedStatusRow);
				}
				DisplayedTacticalStatusRow = displayedStatusRow;
			}
			ShowMouseCursorOverlay();
		}
	}

	blinkCountdown = (int16)(word16)(TacticalStatusBlinkCountdown - 0x0001);
	TacticalStatusBlinkCountdown = (word16)blinkCountdown;
	if (blinkCountdown <= 0x0000)
	{
		TacticalStatusBlinkCountdown = 0x000A;
		TacticalStatusBlinkVisible ^= 0x01;
		CachedPrimaryStatusHighlightColor = 0xFFFF;
		CachedSecondaryStatusHighlightColor = 0xFFFF;
	}

	if (PendingNarrationDelay == 0x0000)
	{
		HideMouseCursorOverlay();
		DrawTileAlignedText(
			TacticalClockBlankText,
			0x001B, 0x0018, 0x0C, 0x0C);
		ShowMouseCursorOverlay();
	}
	else
	{
		if (PendingNarrationDelay == 0x0258)
		{
			if (NarrationMessageCategory == 0x0001)
				DispatchWeaponEffect(0x0000);
			else if (FriendlyUnitDestroyed == 0x0000 &&
				ActiveNarrationSubject != 0x0000)
			{
				PlayScenarioDigitalSoundSequence(
					(int8)ScenarioFileSuffix);
			}
		}

		HideMouseCursorOverlay();
		if (TacticalStatusBlinkVisible != 0x00)
		{
			narrationColor = NarrationEmphasis != 0x0000
				? 0x0008 : 0x000A;
			DrawTileAlignedText(
				TacticalNarrationLabel,
				0x001B, 0x0018, (byte)narrationColor, 0x0C);
			SecondaryStatusHighlightColor = narrationColor;
			if (narrationStatusRow != 0xFFFF)
				UpdateSecondaryUnitStatusRowHighlight(
					narrationStatusRow);
		}
		else
		{
			DrawTileAlignedText(
				TacticalNarrationBlankText,
				0x001B, 0x0018, 0x0C, 0x0C);
			SecondaryStatusHighlightColor = 0x0000;
			if (narrationStatusRow != 0xFFFF &&
				narrationStatusRow != displayedStatusRow)
			{
				UpdateSecondaryUnitStatusRowHighlight(
					narrationStatusRow);
			}
		}
		ShowMouseCursorOverlay();

		--PendingNarrationDelay;
		if (PendingNarrationDelay == 0x0000)
		{
			NarrationEmphasis = 0x0000;
			TacticalStatusRowInvalidation[narrationStatusRow] = 0xFF;
		}
	}

	DrawCampaignClockSeparator();
}

// 2007:159F: draw the eight tactical game-speed bars when the overview is off.
void RedrawTacticalViewport(void)
{
	word16 speedIndex;

	if (TacticalOverviewActive != FALSE)
		return;

	HideMouseCursorOverlay();
	for (speedIndex = 0x00; speedIndex < 0x08; ++speedIndex)
	{
		word16 color = 0x03;
		if (speedIndex == TacticalGameSpeedIndex)
		{
			color = 0x04;
			if (VideoAdapterType == VIDEO_ADAPTER_CGA)
				++color;
		}
		FillVideoRectangle(
			0x00F8 + speedIndex * 0x03,
			0x00C7 - speedIndex,
			0x00F9 + speedIndex * 0x03,
			0x00C7,
			color);
	}
	ShowMouseCursorOverlay();
}

// 2007:16BA: void RedrawTacticalStatusPanel(void)
void RedrawTacticalStatusPanel(void)
{
	word16 previousTextWindow = ActiveTextWindowIndex;

	HideMouseCursorOverlay();
	SelectAndClearTextWindow(0x06);
	DrawSelectedUnitStatusPanel();
	RedrawTacticalViewport();
	DrawCampaignClock();
	ShowMouseCursorOverlay();
	SelectTextWindow(previousTextWindow);
}




