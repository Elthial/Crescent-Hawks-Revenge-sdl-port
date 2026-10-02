// REVENGE_1A1F_TACTICAL_VIEW.c
// Procedures preserved from REVENGE_1A1F_SCENARIO.c.

#include "REVENGE_1A1F_INTERNAL.h"

// 1A1F:0D55: draw and clip a tactical weapon trace.
// Verified against ASM 1A1F:0D55-10CC.
void DrawWeaponAttackTrace(
	word16 attackerUnitIndex,
	int16 targetMapX,
	int16 targetMapY,
	word16 offsetEndpoints,
	word16 shotHit,
	word16 weaponIndex)
{
	int16 sourceX;
	int16 sourceY;
	int16 targetX;
	int16 targetY;
	word16 sourceOutCode;
	word16 targetOutCode;
	word16 direction;
	word16 shiftCount;
	word16 traceColor;

	sourceX = (int16)(word16)(
		((word16)ScenarioUnitMapX[attackerUnitIndex] -
		 TacticalViewportMapX) << 0x04);
	sourceY = (int16)(word16)(
		((word16)ScenarioUnitMapY[attackerUnitIndex] -
		 TacticalViewportMapY) << 0x04);
	targetX = (int16)(word16)(
		((word16)targetMapX - TacticalViewportMapX) << 0x04);
	targetY = (int16)(word16)(
		((word16)targetMapY - TacticalViewportMapY) << 0x04);

	sourceX = (int16)(word16)(sourceX + 0x14);
	sourceY = (int16)(word16)(sourceY + 0x04);
	targetX = (int16)(word16)(targetX + 0x18);
	targetY = (int16)(word16)(targetY + 0x08);

	if (shotHit == FALSE)
	{
		direction = DetermineOctant(
			(int16)(word16)(sourceY - targetY),
			(int16)(word16)(targetX - sourceX));
		direction = (word16)(direction + 0x01 -
			RandomInRangeInclusive(0x00, 0x02)) & 0x07;
		shiftCount = (GeneratePseudoRandomByte() & 0x03) + 0x02;
		targetX = (int16)(word16)(targetX +
			(word16)((word16)DirectionDeltaXTable[direction] << shiftCount));
		shiftCount = (GeneratePseudoRandomByte() & 0x03) + 0x02;
		targetY = (int16)(word16)(targetY +
			(word16)((word16)DirectionDeltaYTable[direction] << shiftCount));
	}

	if (offsetEndpoints != FALSE)
	{
		sourceX = (int16)(word16)(sourceX + 0x04);
		sourceY = (int16)(word16)(sourceY + 0x04);
		OffsetWeaponTraceEndpoint(
			&sourceX, &sourceY, &targetX, &targetY);
		OffsetWeaponTraceEndpoint(
			&targetX, &targetY, &sourceX, &sourceY);
	}

	sourceOutCode = 0x00;
	if (sourceY < 0x00)
		sourceOutCode |= 0x01;
	if (sourceX >= 0x0140)
		sourceOutCode |= 0x02;
	if (sourceY >= 0xC0)
		sourceOutCode |= 0x04;
	if (sourceX < 0x10)
		sourceOutCode |= 0x08;
	targetOutCode = 0x00;
	if (targetY < 0x00)
		targetOutCode |= 0x01;
	if (targetX >= 0x0140)
		targetOutCode |= 0x02;
	if (targetY >= 0xC0)
		targetOutCode |= 0x04;
	if (targetX < 0x10)
		targetOutCode |= 0x08;
	if ((sourceOutCode & targetOutCode) != 0x00)
		return;

	if (sourceX < 0x10)
	{
		sourceY = InterpolateLineCoordinate(
			0x10, sourceX, targetY, sourceY, targetX);
		sourceX = 0x10;
	}
	else if (sourceX >= 0x0140)
	{
		sourceY = InterpolateLineCoordinate(
			0x013F, sourceX, targetY, sourceY, targetX);
		sourceX = 0x013F;
	}
	if (targetX < 0x10)
	{
		targetY = InterpolateLineCoordinate(
			0x10, targetX, sourceY, targetY, sourceX);
		targetX = 0x10;
	}
	else if (targetX >= 0x0140)
	{
		targetY = InterpolateLineCoordinate(
			0x013F, targetX, sourceY, targetY, sourceX);
		targetX = 0x013F;
	}
	if (sourceY < 0x00)
	{
		sourceX = InterpolateLineCoordinate(
			0x00, sourceY, targetX, sourceX, targetY);
		sourceY = 0x00;
	}
	else if (sourceY >= 0xC0)
	{
		sourceX = InterpolateLineCoordinate(
			0xBF, sourceY, targetX, sourceX, targetY);
		sourceY = 0xBF;
	}
	if (targetY < 0x00)
	{
		targetX = InterpolateLineCoordinate(
			0x00, targetY, sourceX, targetX, sourceY);
		targetY = 0x00;
	}
	else if (targetY >= 0xC0)
	{
		targetX = InterpolateLineCoordinate(
			0xBF, targetY, sourceX, targetX, sourceY);
		targetY = 0xBF;
	}

	if (TacticalOverviewActive != FALSE)
		return;
	traceColor = attackerUnitIndex < 0x0C ? 0x05 : 0x08;
	if (offsetEndpoints != FALSE)
		traceColor = (LOW_WORD(GameAnimationTicks) & 0x08) ^ 0x0F;
	if (weaponIndex <= WEAPON_ER_PPC)
	{
		if (offsetEndpoints == FALSE && weaponIndex >= WEAPON_PPC)
			DrawClippedWeaponTraceLine(
				(int16)(word16)(sourceX + 0x02), sourceY,
				(int16)(word16)(targetX + 0x02), targetY,
				attackerUnitIndex < 0x0C ? 0x04 : 0x06, FALSE);
		if (offsetEndpoints == FALSE && weaponIndex >= WEAPON_LARGE_LASER)
			DrawClippedWeaponTraceLine(
				(int16)(word16)(sourceX + 0x01), sourceY,
				(int16)(word16)(targetX + 0x01), targetY,
				traceColor, FALSE);
		DrawClippedWeaponTraceLine(
			sourceX, sourceY, targetX, targetY, traceColor, FALSE);
	}
	else
	{
		DrawClippedWeaponTraceLine(
			sourceX, sourceY, targetX, targetY, traceColor, TRUE);
	}
}
// 1A1F:11F7: center the 19x12 tactical viewport on the selected unit when it
// lies off-screen, update cursor-relative coordinates and the selected-unit
// slot, then move the mouse cursor to that map cell. [P] The smooth camera
// stepping loop remains in the Reko evidence pending names for its redraw
// helper and the fallback coordinates at DS:885B.
void FocusTacticalViewOnUnit(word16 unitIndex);
word16 SelectNextUnitAtCursor(void);
word16 SelectPreviousUnitAtCursor(void);
word16 FindUnitAtTacticalCursor(void);
void OpenTacticalUnitControlPanel(word16 unitIndex);
word16 IsTacticalFunctionKey(int16 inputAction);
void RenderPendingNarration(void);
void ShowPendingNarrationPrompt(void);
void ExitTacticalOverview(void);
void OpenSelectedTacticalUnitPanel(void);
void RunTacticalGameOptionsMenu(void);

// 0800:29BB: add 0800h paragraphs (32 KiB) while preserving the offset.
byte *AdvanceFarPointerBy32K(byte *pointer)
{
	return (byte *)MAKE_FAR_POINTER(
		FAR_SEGMENT(pointer) + 0x0800,
		FAR_OFFSET(pointer));
}

// 1A1F:0C33: select the tactical text foreground palette entry used by the
// unit-control panel. CGA uses 03h; every other configured adapter uses 05h.
void SelectTacticalTextForegroundColor(void)
{
	ActiveTextForegroundColor =
		VideoAdapterType == VIDEO_ADAPTER_CGA
			? 0x03 : 0x05;
}

// 1A1F:3BF7: display a formatted modal message in tactical text window 6,
// wait for dismissal, then restore the previously selected text window.
void ShowTacticalModalMessage(const char *formattedText)
{
	word16 previousTextWindow;

	previousTextWindow = ActiveTextWindowIndex;
	SelectAndClearTextWindow(0x0006);
	SelectTacticalTextForegroundColor();
	RenderFormattedText(formattedText);
	ActiveTextForegroundColor = 0x000F;
	(void) WaitForDismissInput();
	ActiveTextWindowIndex = previousTextWindow;
}

// 1A1F:5E6D: store the rendering state for one tactical runtime slot. State
// 06h means the unit is not deployed; its sprite-table representation is 03h.
void SetTacticalSlotSpriteState(
	word16 slotIndex,
	word16 requestedState)
{
	byte spriteState = (byte) requestedState;
	if (requestedState == 0x0006)
		spriteState = 0x03;
	TacticalSlotSpriteState[slotIndex] = spriteState;
}

// 1A1F:410C: map one of the 24 tactical unit slots to the eight status-panel
// positions. Verified against ASM 1A1F:410C-417E.
int16 MapUnitToTacticalStatusSlot(word16 unitIndex)
{
	int16 statusSlot;
	word16 lanceBase;

	statusSlot = -0x01;
	if ((int16) unitIndex >= 0x0C)
		return 0x07;

	if ((int16) unitIndex < 0x04)
	{
		statusSlot = (int16) unitIndex;
		if (unitIndex == 0x00 && FirstLanceOrdersEnabled != 0x00)
			statusSlot = 0x04;
	}
	else if (IsCurrentLanceLeader(unitIndex) != FALSE)
	{
		statusSlot = (int16) (unitIndex < 0x08 ? 0x05 : 0x06);
	}

	if (statusSlot == -0x01)
	{
		lanceBase = unitIndex & 0x0C;
		if (lanceBase == 0x04 && TacticalScenarioLanceEnabled[0x01] != FALSE)
			statusSlot = 0x05;
		if (lanceBase == 0x08 && TacticalScenarioLanceEnabled[0x02] != FALSE)
			statusSlot = 0x06;
	}

	return statusSlot;
}

// 1A1F:51C0: rebuild the eight tactical status-panel sprite states from the
// twelve friendly-unit runtime slots. Verified against ASM 1A1F:51C0-52F1.
void RefreshTacticalStatusSlotStates(void)
{
	word16 savedPrimaryLeaderOverride;
	word16 unitIndex;
	int16 statusSlot;
	word16 spriteState;
	word16 lanceBase;
	word16 candidateUnit;
	word16 wholeLanceUnavailable;
	int8 previousSpriteState;

	savedPrimaryLeaderOverride = FirstLanceOrdersEnabled;
	FirstLanceOrdersEnabled = 0x00;
	PrimaryStatusHighlightColor = 0x0F;

	for (unitIndex = 0x00; unitIndex < 0x0C; ++unitIndex)
	{
		statusSlot = MapUnitToTacticalStatusSlot(unitIndex);
		if (statusSlot == -0x01)
			continue;

		spriteState = 0x00;
		if (UnitEnemyVisible[unitIndex] != FALSE)
			spriteState = 0x01;
		if (UnitBelowHalfDurability[unitIndex] != FALSE)
			spriteState = 0x02;
		if (PersistentUnitRoster[unitIndex].deploymentState == FALSE)
		{
			spriteState = 0x06;
		}

		if (statusSlot < 0x04)
		{
			SetTacticalSlotSpriteState(
				(word16) statusSlot, spriteState);
			if (unitIndex == 0x00)
				SetTacticalSlotSpriteState(0x04, spriteState);
			statusSlot = 0x00;
		}
		else if ((unitIndex & 0x03) == 0x00)
		{
			SetTacticalSlotSpriteState(
				(word16) statusSlot, spriteState);
		}

		if (spriteState == 0x06)
		{
			lanceBase = unitIndex & 0x0C;
			wholeLanceUnavailable = TRUE;
			for (candidateUnit = lanceBase;
				candidateUnit < lanceBase + 0x04;
				++candidateUnit)
			{
				if (PersistentUnitRoster[candidateUnit].deploymentState != FALSE)
				{
					wholeLanceUnavailable = FALSE;
				}
			}
			if (wholeLanceUnavailable != FALSE)
			{
				SetTacticalSlotSpriteState(
					(word16) statusSlot, 0x06);
			}
		}
		else
		{
			previousSpriteState =
				TacticalSlotSpriteState[(word16)statusSlot];
			if (previousSpriteState < (int16)spriteState ||
				UnitBelowHalfDurability[unitIndex] != FALSE ||
				previousSpriteState != 0x03)
			{
				SetTacticalSlotSpriteState(
					(word16) statusSlot, spriteState);
			}
		}
	}

	TacticalSlotSpriteState[0x07] = FALSE;
	FirstLanceOrdersEnabled = savedPrimaryLeaderOverride;
}

// 1A1F:5D8A: enable the recovered missile-system upgrade for units carrying
// an eligible SRM or LRM family after the corresponding campaign shipment.
// Verified against ASM 1A1F:5D8A-5E6C.
void ApplyScenarioMissileUpgradeAvailability(void)
{
	word16 unitIndex;
	RevengeUnitRecord *unitRecord;
	word16 hasEligibleSrm;
	word16 hasEligibleLrm;

	for (unitIndex = 0x00; unitIndex < 0x0C; ++unitIndex)
	{
		unitRecord = &PersistentUnitRoster[unitIndex];
		hasEligibleSrm =
			unitRecord->srm2Ammunition != 0x00 ||
			unitRecord->srm4Ammunition != 0x00 ||
			unitRecord->srm6Ammunition != 0x00;
		if (hasEligibleSrm != FALSE &&
			SrmShipmentLoaded != FALSE)
		{
			unitRecord->missileUpgradeState = TRUE;
		}

		hasEligibleLrm =
			unitRecord->lrm5Ammunition != 0x00 ||
			unitRecord->lrm10Ammunition != 0x00 ||
			unitRecord->lrm15Ammunition != 0x00 ||
			unitRecord->lrm20Ammunition != 0x00;
		if (hasEligibleLrm != FALSE &&
			LrmShipmentLoaded != FALSE)
		{
			unitRecord->missileUpgradeState = TRUE;
		}
	}
}

// 1A1F:146E: move the 19x12 tactical cursor one cell forward, wrapping rows.
void AdvanceTacticalCursorCell(void)
{
	if (++TacticalCursorViewportX
		>= TACTICAL_VIEWPORT_WIDTH_CELLS)
	{
		TacticalCursorViewportX = 0x00;
		if (++TacticalCursorViewportY
			>= TACTICAL_VIEWPORT_HEIGHT_CELLS)
		{
			TacticalCursorViewportY = 0x00;
		}
	}
}

// 1A1F:14E1: move the 19x12 tactical cursor one cell backward, wrapping rows.
void RetreatTacticalCursorCell(void)
{
	if (--TacticalCursorViewportX < 0x00)
	{
		TacticalCursorViewportX =
			TACTICAL_VIEWPORT_WIDTH_CELLS - 0x01;
		if (--TacticalCursorViewportY < 0x00)
		{
			TacticalCursorViewportY =
				TACTICAL_VIEWPORT_HEIGHT_CELLS - 0x01;
		}
	}
}

// 1A1F:11F7: center the tactical viewport on a unit and select it when it is
// still deployed. Verified against 1A1F:11F7-141D.
void FocusTacticalViewOnUnit(word16 unitIndex)
{
	RevengeUnitRecord *unitRecord;
	byte *destructionMarker;
	int16 unitMapX;
	int16 unitMapY;
	int16 cursorX;
	int16 cursorY;
	int16 desiredViewportX;
	int16 desiredViewportY;
	int16 mouseCellX;
	int16 mouseCellY;

	HideMouseCursorOverlay();
	if ((int16)unitIndex < 0x00 || unitIndex >= TACTICAL_UNIT_COUNT)
	{
		ShowMouseCursorOverlay();
		return;
	}

	unitRecord = &PersistentUnitRoster[unitIndex];
	if (unitRecord->deploymentState == 0x00)
	{
		destructionMarker = UnitDestructionMarkers[unitIndex];
		ScenarioUnitMapX[unitIndex] = destructionMarker[0x00];
		ScenarioUnitMapY[unitIndex] = destructionMarker[0x01];
	}

	unitMapX = ScenarioUnitMapX[unitIndex];
	unitMapY = ScenarioUnitMapY[unitIndex];
	cursorX = unitMapX - (int16)TacticalViewportMapX;
	cursorY = unitMapY - (int16)TacticalViewportMapY;
	if (cursorX < 0x00 || cursorX >= TACTICAL_VIEWPORT_WIDTH_CELLS
		|| cursorY < 0x00 || cursorY >= TACTICAL_VIEWPORT_HEIGHT_CELLS)
	{
		desiredViewportX = unitMapX - 0x09;
		desiredViewportY = unitMapY - 0x06;
		if (desiredViewportX < 0x00)
			desiredViewportX = 0x00;
		if (desiredViewportY < 0x00)
			desiredViewportY = 0x00;
		if (desiredViewportX
			> (int16)MapWidth - TACTICAL_VIEWPORT_WIDTH_CELLS)
		{
			desiredViewportX = (int16)MapWidth
				- TACTICAL_VIEWPORT_WIDTH_CELLS;
		}
		if (desiredViewportY
			> (int16)MapHeight - TACTICAL_VIEWPORT_HEIGHT_CELLS)
		{
			desiredViewportY = (int16)MapHeight
				- TACTICAL_VIEWPORT_HEIGHT_CELLS;
		}

		TacticalCursorViewportX = 0x09;
		TacticalCursorViewportY = 0x06;
		while ((int16)TacticalViewportMapX != desiredViewportX
			|| (int16)TacticalViewportMapY != desiredViewportY)
		{
			if ((int16)TacticalViewportMapX < desiredViewportX)
			{
				++TacticalViewportMapX;
				if ((int16)TacticalViewportMapX + 0x0A
					< desiredViewportX)
					TacticalViewportMapX += 0x03;
			}
			if ((int16)TacticalViewportMapX > desiredViewportX)
			{
				--TacticalViewportMapX;
				if (desiredViewportX + 0x0A
					< (int16)TacticalViewportMapX)
					TacticalViewportMapX -= 0x03;
			}
			if ((int16)TacticalViewportMapY < desiredViewportY)
			{
				++TacticalViewportMapY;
				if ((int16)TacticalViewportMapY + 0x0A
					< desiredViewportY)
					TacticalViewportMapY += 0x03;
			}
			if ((int16)TacticalViewportMapY > desiredViewportY)
			{
				--TacticalViewportMapY;
				if (desiredViewportY + 0x0F
					< (int16)TacticalViewportMapY)
					TacticalViewportMapY -= 0x03;
			}
			RebuildTacticalViewport();
		}
	}

	cursorX = unitMapX - (int16)TacticalViewportMapX;
	cursorY = unitMapY - (int16)TacticalViewportMapY;
	TacticalCursorMapX = (word16)cursorX;
	TacticalCursorViewportX = (word16)cursorX;
	TacticalCursorMapY = (word16)cursorY;
	TacticalCursorViewportY = (word16)cursorY;
	TacticalSelectedUnitIndex =
		unitRecord->deploymentState != 0x00
			? unitIndex : TACTICAL_UNIT_NONE;

	if (MouseDriverInstalled != 0x00)
	{
		mouseCellX = (int16)(cursorX * 0x10 + 0x08);
		if (mouseCellX < 0x00)
			mouseCellX = 0x00;
		mouseCellX >>= 0x04;
		PreviousMouseCellX = (word16)mouseCellX;
		mouseCellY = (int16)(cursorY * 0x10 + 0x08);
		mouseCellY >>= 0x04;
		PreviousMouseCellY = (word16)mouseCellY;
		SetMouseCursorPosition(
			(int16)(cursorX * 0x10 + 0x18),
			(int16)(cursorY * 0x10 + 0x08));
	}

	ShowMouseCursorOverlay();
}

// 1A1F:141E: scan forward through viewport cells for a selectable unit.
word16 SelectNextUnitAtCursor(void)
{
	word16 originalCursorX = TacticalCursorViewportX;
	word16 originalCursorY = TacticalCursorViewportY;
	int16 selectedUnitIndex;

	AdvanceTacticalCursorCell();
	do
	{
		selectedUnitIndex = ResolveUnitAtTacticalCursor();
		if (selectedUnitIndex != -0x01)
			break;
		AdvanceTacticalCursorCell();
	} while (TacticalCursorViewportX != originalCursorX
		|| TacticalCursorViewportY != originalCursorY);

	if (selectedUnitIndex == -0x01)
		selectedUnitIndex = TacticalSelectedUnitIndex;
	return (word16) selectedUnitIndex;
}

// 1A1F:1491: scan backward through viewport cells for a selectable unit.
word16 SelectPreviousUnitAtCursor(void)
{
	word16 originalCursorX = TacticalCursorViewportX;
	word16 originalCursorY = TacticalCursorViewportY;
	int16 selectedUnitIndex;

	RetreatTacticalCursorCell();
	do
	{
		selectedUnitIndex = ResolveUnitAtTacticalCursor();
		if (selectedUnitIndex != -0x01)
			break;
		RetreatTacticalCursorCell();
	} while (TacticalCursorViewportX != originalCursorX
		|| TacticalCursorViewportY != originalCursorY);

	if (selectedUnitIndex == -0x01)
		selectedUnitIndex = TacticalSelectedUnitIndex;
	return (word16) selectedUnitIndex;
}

// 1A1F:1504: inspect the cursor cell and its eight neighbors for a unit.
word16 FindUnitAtTacticalCursor(void)
{
	word16 originalCursorX = TacticalCursorViewportX;
	word16 originalCursorY = TacticalCursorViewportY;
	word16 restoredCursorX = originalCursorX;
	word16 restoredCursorY = originalCursorY;
	int16 selectedUnitIndex = -0x01;
	word16 offsetIndex;

	for (offsetIndex = 0x00; offsetIndex < 0x09; ++offsetIndex)
	{
		TacticalCursorViewportX = originalCursorX
			+ (int16) (word16)TacticalCursorSearchOffsetX[offsetIndex];
		TacticalCursorViewportY = originalCursorY
			+ (int16) (word16)TacticalCursorSearchOffsetY[offsetIndex];
		selectedUnitIndex = ResolveUnitAtTacticalCursor();
		if (selectedUnitIndex != -0x01)
		{
			restoredCursorX = TacticalCursorViewportX;
			restoredCursorY = TacticalCursorViewportY;
			if (TacticalOverviewActive == FALSE)
			{
				RebuildTacticalViewport();
				DrawTacticalCursorOutline(TacticalCursorOutlineState);
				DrawSelectedUnitStatusPanel();
			}
			break;
		}
	}

	TacticalCursorViewportX = restoredCursorX;
	TacticalCursorViewportY = restoredCursorY;
	return (word16) selectedUnitIndex;
}

// 1A1F:1586: resolve the unit occupying the current tactical cursor cell.
int16 ResolveUnitAtTacticalCursor(void)
{
	int16 cursorMapX = TacticalViewportMapX
		+ TacticalCursorViewportX;
	int16 cursorMapY = TacticalViewportMapY
		+ TacticalCursorViewportY;
	int16 selectedUnitIndex = -0x01;
	word16 unitIndex = 0x00;

	while (unitIndex < TACTICAL_ENEMY_FIRST_UNIT
		&& selectedUnitIndex == -0x01)
	{
		if (PersistentUnitRoster[unitIndex].deploymentState == 0x01
			&& ScenarioUnitMapX[unitIndex] == cursorMapX
			&& ScenarioUnitMapY[unitIndex] == cursorMapY)
		{
			selectedUnitIndex = unitIndex;
			TacticalSelectedUnitIndex = unitIndex;
		}
		++unitIndex;
	}

	if (selectedUnitIndex == -0x01)
	{
		for (unitIndex = TACTICAL_ENEMY_FIRST_UNIT;
			unitIndex < TACTICAL_UNIT_COUNT;
			++unitIndex)
		{
			if (PersistentUnitRoster[unitIndex].deploymentState != 0x00
				&& ScenarioUnitMapX[unitIndex] == cursorMapX
				&& ScenarioUnitMapY[unitIndex] == cursorMapY)
			{
				word16 cellIndex =
					TacticalCursorViewportY
						* TACTICAL_VIEWPORT_WIDTH_CELLS
					+ TacticalCursorViewportX;
				word16 spriteId =
					TacticalCellSpriteMap[cellIndex];

				if (spriteId != 0x00)
				{
					spriteId &= 0x00FF;
					if (spriteId < TACTICAL_ENEMY_SPRITE_LIMIT
						&& (spriteId < TACTICAL_ENEMY_SPRITE_EXCLUDED_FIRST
							|| spriteId >= TACTICAL_ENEMY_SPRITE_EXCLUDED_END))
					{
						selectedUnitIndex = unitIndex;
						TacticalSelectedUnitIndex = unitIndex;
					}
				}
			}
		}
	}

	if (selectedUnitIndex != -0x01)
	{
		word16 selectedViewportX =
			ScenarioUnitMapX[selectedUnitIndex]
			- TacticalViewportMapX;
		word16 selectedViewportY =
			ScenarioUnitMapY[selectedUnitIndex]
			- TacticalViewportMapY;

		TacticalCursorMapX = selectedViewportX;
		TacticalCursorViewportX = selectedViewportX;
		TacticalCursorMapY = selectedViewportY;
		TacticalCursorViewportY = selectedViewportY;
	}

	return selectedUnitIndex;
}

// 1A1F:1697: draw a unit's tactical panel and enter its command menu only
// when the unit's lance and current overview state permit issuing orders.
void OpenTacticalUnitControlPanel(word16 unitIndex)
{
	word16 commandsEnabled = FALSE;

	RefreshTacticalDisplay(FALSE);
	if (unitIndex < TACTICAL_ENEMY_FIRST_UNIT
		&& IsCurrentLanceLeader(unitIndex) != FALSE
		&& HasActiveLanceFollowers(unitIndex) != FALSE)
	{
		HighlightLanceFollowers(unitIndex);
	}

	DrawTacticalUnitControlPanel(unitIndex);
	if (unitIndex < 0x04)
	{
		commandsEnabled = TRUE;
	}
	else if (unitIndex < 0x08)
	{
		if (TacticalScenarioLanceEnabled[0x01] != FALSE
			&& IsCurrentLanceLeader(unitIndex) != FALSE)
		{
			commandsEnabled = TRUE;
		}
	}
	else if (unitIndex < TACTICAL_ENEMY_FIRST_UNIT
		&& TacticalScenarioLanceEnabled[0x02] != FALSE
		&& IsCurrentLanceLeader(unitIndex) != FALSE)
	{
		commandsEnabled = TRUE;
	}

	if (TacticalOverviewActive != FALSE)
		commandsEnabled = FALSE;
	if (commandsEnabled != FALSE)
		RunTacticalUnitCommandMenu(unitIndex);
	else
		WaitForDismissInput();
}

// 1A1F:1732: apply a translated keypad direction to the tactical cursor or
// overview viewport. Diagonal keys deliberately pass through two branches.
void MoveTacticalCursorByInput(int16 inputCode)
{
	if (inputCode == TranslatedExtendedKey(KEY_LEFT)
		|| inputCode == TranslatedExtendedKey(KEY_HOME)
		|| inputCode == TranslatedExtendedKey(KEY_END))
	{
		if (TacticalOverviewActive != FALSE)
		{
			if (TacticalOverviewZoomed != FALSE)
				--TacticalCursorViewportX;
			else if (TacticalViewportMapX != 0x00)
				--TacticalViewportMapX;
		}
		else
		{
			--TacticalCursorViewportX;
		}
		TacticalSelectedUnitIndex = TACTICAL_UNIT_NONE;
	}

	if (inputCode == TranslatedExtendedKey(KEY_RIGHT)
		|| inputCode == TranslatedExtendedKey(KEY_PAGE_UP)
		|| inputCode == TranslatedExtendedKey(KEY_PAGE_DOWN))
	{
		if (TacticalOverviewActive != FALSE)
		{
			if (TacticalOverviewZoomed != FALSE)
				++TacticalCursorViewportX;
			else if ((int16) TacticalViewportMapX
				+ TACTICAL_VIEWPORT_WIDTH_CELLS
				< (int16) MapWidth)
			{
				++TacticalViewportMapX;
			}
		}
		else
		{
			++TacticalCursorViewportX;
		}
		TacticalSelectedUnitIndex = TACTICAL_UNIT_NONE;
	}

	if (inputCode == TranslatedExtendedKey(KEY_UP)
		|| inputCode == TranslatedExtendedKey(KEY_HOME)
		|| inputCode == TranslatedExtendedKey(KEY_PAGE_UP))
	{
		if (TacticalOverviewActive != FALSE)
		{
			if (TacticalOverviewZoomed != FALSE)
				--TacticalCursorViewportY;
			else if (TacticalViewportMapY != 0x00)
				--TacticalViewportMapY;
		}
		else
		{
			--TacticalCursorViewportY;
		}
		TacticalSelectedUnitIndex = TACTICAL_UNIT_NONE;
	}

	if (inputCode == TranslatedExtendedKey(KEY_DOWN)
		|| inputCode == TranslatedExtendedKey(KEY_END)
		|| inputCode == TranslatedExtendedKey(KEY_PAGE_DOWN))
	{
		if (TacticalOverviewActive != FALSE)
		{
			if (TacticalOverviewZoomed != FALSE)
				++TacticalCursorViewportY;
			else if ((int16) TacticalViewportMapY
				+ TACTICAL_VIEWPORT_HEIGHT_CELLS
				< (int16) MapHeight)
			{
				++TacticalViewportMapY;
			}
		}
		else
		{
			++TacticalCursorViewportY;
		}
		TacticalSelectedUnitIndex = TACTICAL_UNIT_NONE;
	}
}

// 1A1F:49CC: keep the tactical viewport centered on the selected unit's
// remembered cursor-relative position, clamped to the current map bounds.
void KeepTacticalCursorOnSelectedUnit(void)
{
	word16 selectedUnitIndex =
		TacticalSelectedUnitIndex;
	int16 maximumViewportX;
	int16 maximumViewportY;

	if (selectedUnitIndex == TACTICAL_UNIT_NONE)
	{
		FirstLanceOrdersEnabled = FALSE;
		return;
	}

	if (PersistentUnitRoster[selectedUnitIndex].deploymentState == 0x00)
	{
		TacticalSelectedUnitIndex = TACTICAL_UNIT_NONE;
		return;
	}

	TacticalCursorViewportX =
		ScenarioUnitMapX[selectedUnitIndex]
		- TacticalViewportMapX;
	TacticalCursorViewportY =
		ScenarioUnitMapY[selectedUnitIndex]
		- TacticalViewportMapY;
	TacticalViewportMapX +=
		TacticalCursorViewportX
		- TacticalCursorMapX;
	TacticalViewportMapY +=
		TacticalCursorViewportY
		- TacticalCursorMapY;

	if ((int16) TacticalViewportMapX < 0x00)
		TacticalViewportMapX = 0x00;
	if ((int16) TacticalViewportMapY < 0x00)
		TacticalViewportMapY = 0x00;

	maximumViewportX = (int16) MapWidth
		- TACTICAL_VIEWPORT_WIDTH_CELLS;
	maximumViewportY = (int16) MapHeight
		- TACTICAL_VIEWPORT_HEIGHT_CELLS;
	if ((int16) TacticalViewportMapX > maximumViewportX)
		TacticalViewportMapX = maximumViewportX;
	if ((int16) TacticalViewportMapY > maximumViewportY)
		TacticalViewportMapY = maximumViewportY;

	TacticalCursorViewportX =
		ScenarioUnitMapX[selectedUnitIndex]
		- TacticalViewportMapX;
	TacticalCursorViewportY =
		ScenarioUnitMapY[selectedUnitIndex]
		- TacticalViewportMapY;
}

