// REVENGE_1A1F_TACTICAL_CONTROL.c
// Procedures preserved from REVENGE_1A1F_SCENARIO.c.

#include "REVENGE_1A1F_INTERNAL.h"

// 1A1F:5755: translate pending mouse input into a tactical input code.
// Verified against 1A1F:5755-5961.
int16 TranslateTacticalMouseInput(int16 inputAction)
{
	word16 mouseButtonState;
	int16 mouseX;
	int16 mouseY;
	int16 mouseCellX;
	int16 mouseCellY;
	word16 edgeMask;
	int16 maximumViewportX;
	int16 maximumViewportY;

	if (MouseInputDisabled != 0x00)
		return inputAction;
	if (HIGH_WORD(GameTimerTicks) == 0x00
		&& LOW_WORD(GameTimerTicks) < 0x02)
	{
		return inputAction;
	}
	GameTimerTicks = 0x00000000UL;

	if (PendingMouseButtonEvent != 0x00
		&& MouseButtonState != 0x00)
	{
		mouseButtonState = MouseButtonState;
		inputAction = mouseButtonState == 0x01 ? KEY_SPACE : KEY_ESCAPE;
		while ((mouseButtonState & MouseButtonState) != 0x00)
		{
			/* DOS updated the mouse words asynchronously from its interrupt
			 * callback.  SDL updates the same words while its event queue is
			 * serviced, so retain the original release wait while allowing the
			 * replacement mouse boundary to observe the button-up event. */
			(void) ServiceMusicAndCheckKeyboardInput();
		}
		PendingMouseButtonEvent = 0x00;
		return inputAction;
	}

	edgeMask = 0x00;
	mouseX = (int16)(word16)MouseCursorRequestedX;
	mouseY = (int16)MouseY;
	mouseCellX = mouseX - 0x10;
	if (mouseCellX < 0x00)
		mouseCellX = 0x00;
	mouseCellX >>= 0x04;
	mouseCellY = mouseY >> 0x04;
	if (mouseCellY == 0x00 && mouseY < 0x06)
		PreviousMouseCellY = 0xFFFF;
	if (mouseCellY >= 0x0B && mouseY >= 0x00BA)
	{
		PreviousMouseCellY = 0xFFFF;
		mouseCellY = 0x0B;
	}
	if (mouseCellX == 0x00 && mouseX < 0x06)
		PreviousMouseCellX = 0xFFFF;
	if (mouseCellX >= 0x12 && mouseX >= 0x013A)
	{
		PreviousMouseCellX = 0xFFFF;
		mouseCellX = 0x12;
	}
	if (mouseCellX == (int16)PreviousMouseCellX
		&& mouseCellY == (int16)PreviousMouseCellY)
	{
		return inputAction;
	}

	TacticalSelectedUnitIndex = TACTICAL_UNIT_NONE;
	TacticalCursorViewportX = (word16)mouseCellX;
	TacticalCursorViewportY = (word16)mouseCellY;
	if (mouseCellY == 0x00 && mouseY < 0x06)
		edgeMask |= 0x08;
	if (mouseCellX >= 0x12 && mouseX >= 0x013A)
		edgeMask |= 0x04;
	if (mouseCellY >= 0x0B && mouseY >= 0x00BA)
		edgeMask |= 0x02;
	if (mouseCellX == 0x00 && mouseX < 0x06)
		edgeMask |= 0x01;
	if (edgeMask != 0x00)
		inputAction = TacticalMouseEdgeInputByMask[edgeMask];

	if (TacticalOverviewActive != FALSE
		&& TacticalOverviewZoomed == FALSE)
	{
		TacticalViewportMapX = (word16)(
			((int32)(int16)MapWidth * mouseX) / 0x0140);
		if ((int16)TacticalViewportMapX < 0x00)
			TacticalViewportMapX = 0x00;
		maximumViewportX = (int16)MapWidth
			- TACTICAL_VIEWPORT_WIDTH_CELLS;
		if (maximumViewportX
			<= (int16)TacticalViewportMapX)
		{
			TacticalViewportMapX = (word16)maximumViewportX;
		}

		TacticalViewportMapY = (word16)(
			((int32)(int16)MapHeight * mouseY) / 0x00C8);
		if ((int16)TacticalViewportMapY < 0x00)
			TacticalViewportMapY = 0x00;
		maximumViewportY = (int16)MapHeight
			- TACTICAL_VIEWPORT_HEIGHT_CELLS;
		if (maximumViewportY
			<= (int16)TacticalViewportMapY)
		{
			TacticalViewportMapY = (word16)maximumViewportY;
		}
		inputAction = 0x00;
		TacticalCursorViewportX = 0x00;
		TacticalCursorViewportY = 0x00;
	}

	PreviousMouseCellX = (word16)mouseCellX;
	PreviousMouseCellY = (word16)mouseCellY;
	return inputAction;
}

void PrepareUnitTypeResources(word16 unitIndex)
{
	word16 resourceSlot = 0x00FF;
	byte resourceCode = 0xFF;
	byte unitRecordType;

	if (unitIndex < 0x04)
		resourceSlot = unitIndex;
	else if (unitIndex < 0x08)
	{
		if (UnitTypeResourceCode[0x05] == 0x00)
			resourceSlot = 0x05;
	}
	else if (unitIndex < 0x0C && UnitTypeResourceCode[0x06] == 0x00)
		resourceSlot = 0x06;

	if (resourceSlot == 0x00FF)
		return;

	unitRecordType =
		PersistentUnitRoster[unitIndex].unitTypeId;
	if (ScenarioFileSuffix < 0x46 || ScenarioFileSuffix == 0x54)
	{
		switch (unitRecordType)
		{
		case 0x00:
		case 0x45:
		case 0x46:
			resourceCode = 0xDE;
			break;
		case 0x01:
		case 0x47:
		case 0x48:
			resourceCode = 0xDF;
			break;
		case 0x03:
		case 0x49:
		case 0x4A:
			resourceCode = 0xE0;
			break;
		case 0x06:
			resourceCode = 0xE1;
			break;
		case 0x04:
		case 0x09:
		case 0x55:
			resourceCode = 0xE2;
			break;
		case 0x0F:
			resourceCode = 0xE3;
			break;
		case 0x11:
			resourceCode = 0xE4;
			break;
		case 0x17:
			resourceCode = 0xE5;
			break;
		case 0x14:
		case 0x4C:
		case 0x4D:
			resourceCode = 0xE6;
			break;
		case 0x15:
			resourceCode = 0xE7;
			break;
		case 0x1B:
		case 0x4E:
		case 0x4F:
			resourceCode = 0xE8;
			break;
		case 0x3C:
			resourceCode = 0xE9;
			break;
		case 0x37:
			resourceCode = 0xEA;
			break;
		case 0x25:
			resourceCode = 0xEB;
			break;
		case 0x38:
			resourceCode = 0xEC;
			break;
		}
	}
	else if (ScenarioFileSuffix == 0x55)
	{
		switch (unitRecordType)
		{
		case 0x01:
		case 0x02:
		case 0x47:
		case 0x48:
			resourceCode = 0xDE;
			break;
		case 0x03:
		case 0x05:
		case 0x07:
		case 0x49:
		case 0x4A:
			resourceCode = 0xDF;
			break;
		case 0x00:
		case 0x04:
		case 0x09:
		case 0x0A:
		case 0x45:
		case 0x46:
		case 0x55:
			resourceCode = 0xE0;
			break;
		case 0x0F:
		case 0x11:
		case 0x12:
		case 0x4B:
			resourceCode = 0xE1;
			break;
		case 0x14:
		case 0x4C:
		case 0x4D:
			resourceCode = 0xE2;
			break;
		case 0x15:
		case 0x16:
		case 0x17:
			resourceCode = 0xE3;
			break;
		case 0x1B:
		case 0x1E:
		case 0x4E:
		case 0x4F:
			resourceCode = 0xE4;
			break;
		case 0x1C:
		case 0x42:
		case 0x43:
		case 0x57:
			resourceCode = 0xE5;
			break;
		case 0x1F:
		case 0x20:
		case 0x21:
		case 0x22:
		case 0x56:
			resourceCode = 0xE6;
			break;
		case 0x25:
		case 0x26:
		case 0x27:
		case 0x28:
		case 0x2A:
		case 0x2C:
		case 0x52:
		case 0x53:
			resourceCode = 0xE7;
			break;
		case 0x23:
		case 0x50:
		case 0x51:
			resourceCode = 0xE8;
			break;
		case 0x24:
		case 0x2B:
		case 0x33:
		case 0x44:
		case 0x54:
			resourceCode = 0xE9;
			break;
		case 0x2D:
		case 0x2E:
		case 0x31:
		case 0x32:
		case 0x36:
		case 0x58:
			resourceCode = 0xEA;
			break;
		}
	}
	else
	{
		switch (unitRecordType)
		{
		case 0x01:
		case 0x47:
		case 0x48:
			resourceCode = 0xDE;
			break;
		case 0x03:
		case 0x49:
		case 0x4A:
			resourceCode = 0xDF;
			break;
		case 0x09:
		case 0x55:
			resourceCode = 0xE0;
			break;
		case 0x12:
		case 0x4B:
			resourceCode = 0xE1;
			break;
		case 0x14:
		case 0x4C:
		case 0x4D:
			resourceCode = 0xE2;
			break;
		case 0x15:
		case 0x17:
			resourceCode = 0xE3;
			break;
		case 0x1B:
		case 0x4E:
		case 0x4F:
			resourceCode = 0xE4;
			break;
		case 0x1C:
		case 0x57:
			resourceCode = 0xE5;
			break;
		case 0x1F:
		case 0x56:
			resourceCode = 0xE6;
			break;
		case 0x2A:
		case 0x52:
		case 0x53:
			resourceCode = 0xE7;
			break;
		case 0x23:
		case 0x50:
		case 0x51:
			resourceCode = 0xE8;
			break;
		case 0x2B:
		case 0x54:
			resourceCode = 0xE9;
			break;
		case 0x32:
		case 0x58:
			resourceCode = 0xEA;
			break;
		}
	}

	if (resourceCode != 0xFF)
		UnitTypeResourceCode[resourceSlot] = resourceCode;
	TacticalSlotSpriteState[resourceSlot] = 0x00;
	TacticalStatusRowInvalidation[resourceSlot] = 0xFF;
}

// 1A1F:0C50: word16 AdvanceTerrainDamageState(
//     int16 mapX, int16 mapY, word16 maximumDamageState)
// Verified against 1A1F:0C50-0CF8.
word16 AdvanceTerrainDamageState(
	int16 mapX,
	int16 mapY,
	word16 maximumDamageState)
{
	word16 mapCellIndex;
	word16 terrainType;
	word16 destructibleTerrainTypeMaximum;
	word16 damageState;

	// V: each map cell has a two-bit damage state. Invalid coordinates and the
	// three special destructible terrain IDs return state 3.
	if (mapX < 0x00 || mapX >= (int16) MapWidth
		|| mapY < 0x00 || mapY >= (int16) MapHeight)
	{
		return 0x03;
	}

	mapCellIndex = (word16) ((word16) mapY
		* MapWidth + (word16) mapX);
	terrainType = TerrainTypeMap[mapCellIndex];
	destructibleTerrainTypeMaximum =
		DestructibleTerrainTypeBase + 0x02;
	if ((int16) terrainType >=
			(int16) DestructibleTerrainTypeBase
		&& (int16) terrainType <= (int16) destructibleTerrainTypeMaximum)
	{
		BeginTerrainDamageAtCell(mapX, mapY, terrainType);
		return 0x03;
	}

	damageState = ReadTerrainDamageState(mapX, mapY);
	if ((int16) damageState < (int16) maximumDamageState
		&& TerrainDamageCapabilityTable[terrainType] != 0x00)
	{
		*ActiveTerrainDamageByte +=
			TerrainDamageCellIncrementMask[mapX & 0x03];
		++damageState;
	}

	return damageState;
}

// 1A1F:0CF9: word16 ReadTerrainDamageState(int16 mapX, int16 mapY)
word16 ReadTerrainDamageState(int16 mapX, int16 mapY)
{
	// V: four two-bit damage states are packed into each byte. The original
	// routine also caches the selected far byte at DS:B047/B049 for mutation.
	word16 packedByteIndex =
		mapY * PackedTerrainDamageRowBytes + (mapX >> 0x02);
	ActiveTerrainDamageByte =
		PackedTerrainDamageMap + packedByteIndex;

	byte packedDamageStates = *ActiveTerrainDamageByte;
	byte columnWithinByte = (byte)(mapX & 0x03);
	return (packedDamageStates
		& TerrainDamageExtractMask[columnWithinByte])
		>> TerrainDamageShift[columnWithinByte];
}

// 1A1F:52F2: void AdvanceTacticalCampaignClock(void)
void AdvanceTacticalCampaignClock(void)
{
	int16 slotIndex;

	TacticalClockSubtick += 0x02;
	if (TacticalClockSubtick < 0x3C)
		return;

	TacticalClockSubtick = 0x00;
	++CampaignClockState[0x01];
	if (CampaignClockState[0x01] >= 0x3C)
	{
		CampaignClockState[0x01] = 0x00;
		++CampaignClockState[0x00];
		if (CampaignClockState[0x00] == 0x18)
			CampaignClockState[0x00] = 0x00;
		for (slotIndex = 0x00; slotIndex < 0x09; ++slotIndex)
			TacticalStatusRowInvalidation[slotIndex] = 0xFF;
	}
	DrawCampaignClock();
}

// 1A1F:533A: void UpdateUnitHeatAccumulators(void)
// VERIFIED: +86h/+87h is an 8.8 fixed-point heat accumulator. The high byte
// is the whole-heat value used by combat and the UI. DS:176A is a word table
// containing heatSinkCount * 10h, which this routine subtracts before
// clamping the accumulator to zero.
// PROPOSED: B02Ah == 80h enables a terrain/environment modifier. The data flow
// below is exact, but the map-state globals need a future tracing pass.
void UpdateUnitHeatAccumulators(void)
{
	word16 unitIndex;

	// Verified against 1A1F:533A-5475.
	for (unitIndex = 0x00; unitIndex < 0x18; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord =
			&PersistentUnitRoster[unitIndex];
		if (unitRecord->deploymentState == 0x00)
			continue;

		int16 effectiveHeatSinkCount = UnitHeatSinkCount[unitIndex];
		if (TacticalClockDivider == 0x0080)
		{
			word16 terrainType = UnitTerrainType[unitIndex];
			if (effectiveHeatSinkCount < 0x1D
				&& terrainType >= DestructibleTerrainTypeBase
				&& terrainType <= (word16)
					(DestructibleTerrainTypeBase + 0x02))
				effectiveHeatSinkCount += 0x02;

			word16 mapRecordIndex;
			for (mapRecordIndex = 0x00; mapRecordIndex < 0x5A; ++mapRecordIndex)
			{
				if (TerrainImpactAnimationRecords[mapRecordIndex].mapX
						== ScenarioUnitMapX[unitIndex]
					&& TerrainImpactAnimationRecords[mapRecordIndex].mapY
						== ScenarioUnitMapY[unitIndex])
				{
					unitRecord->currentHeat = (byte)
						(unitRecord->currentHeat + 0x0A);
					break;
				}
			}
		}

		int16 heatAccumulator = (int16)unitRecord->heatAccumulatorQ8_8;
		heatAccumulator -= (int16)
			HeatDissipationBySinkCountQ8_8[effectiveHeatSinkCount];
		if (heatAccumulator < 0x00)
			heatAccumulator = 0x00;
		unitRecord->heatAccumulatorQ8_8 = (word16)heatAccumulator;
	}
}

// 1A1F:5577: void BuildScenarioTerrainDamageCapabilityMap(
//     word16 terrainEffectMode)
// Verified against 1A1F:5577-5754.
void BuildScenarioTerrainDamageCapabilityMap(word16 terrainEffectMode)
{
	byte *terrainCapabilityMap = (byte *)TerrainToHitModifier;
	byte *damagedTerrainSpriteMap =
		TerrainDamageCapabilityTable + 0x0300;
	word16 terrainType;

	switch (terrainEffectMode)
	{
	case 0x00:
		ImpassableTerrainTypeMinimum = 0x00C7;
		DestructibleTerrainTypeBase = 0x0080;
		TerrainImpactAnimationTypeMinimum = 0x00A0;
		TerrainImpactAnimationTypeMaximum = 0x00C6;
		TerrainLineOfSightBlockingThreshold = 0x00CC;
		break;
	case 0x01:
		ImpassableTerrainTypeMinimum = 0x0061;
		DestructibleTerrainTypeBase = 0x00FD;
		TerrainImpactAnimationTypeMinimum = 0x0055;
		TerrainImpactAnimationTypeMaximum = 0x0060;
		TerrainLineOfSightBlockingThreshold = 0x0061;
		break;
	case 0x02:
		ImpassableTerrainTypeMinimum = 0x00B6;
		DestructibleTerrainTypeBase = 0x008C;
		TerrainImpactAnimationTypeMinimum = 0x008F;
		TerrainImpactAnimationTypeMaximum = 0x00B5;
		TerrainLineOfSightBlockingThreshold = 0x00C8;
		break;
	case 0x03:
		ImpassableTerrainTypeMinimum = 0x004B;
		DestructibleTerrainTypeBase = 0x00FD;
		TerrainImpactAnimationTypeMinimum = 0x003F;
		TerrainImpactAnimationTypeMaximum = 0x004A;
		TerrainLineOfSightBlockingThreshold = 0x004B;
		break;
	case 0x04:
		ImpassableTerrainTypeMinimum = 0x00AF;
		DestructibleTerrainTypeBase = 0x005E;
		TerrainImpactAnimationTypeMinimum = 0x007B;
		TerrainImpactAnimationTypeMaximum = 0x009E;
		TerrainLineOfSightBlockingThreshold = 0x00AF;
		break;
	case 0x05:
		ImpassableTerrainTypeMinimum = 0x0096;
		DestructibleTerrainTypeBase = 0x0052;
		TerrainImpactAnimationTypeMinimum = 0x0072;
		TerrainImpactAnimationTypeMaximum = 0x0095;
		TerrainLineOfSightBlockingThreshold = 0x0096;
		break;
	case 0x06:
		ImpassableTerrainTypeMinimum = 0x0063;
		DestructibleTerrainTypeBase = 0x00FD;
		TerrainImpactAnimationTypeMinimum = 0x005A;
		TerrainImpactAnimationTypeMaximum = 0x0062;
		TerrainLineOfSightBlockingThreshold = 0x0063;
		break;
	case 0x07:
		ImpassableTerrainTypeMinimum = 0x009F;
		DestructibleTerrainTypeBase = 0x0078;
		TerrainImpactAnimationTypeMinimum = 0x007B;
		TerrainImpactAnimationTypeMaximum = 0x0095;
		TerrainLineOfSightBlockingThreshold = 0x009F;
		break;
	}

	for (terrainType = 0x00; terrainType < 0x0100; ++terrainType)
		terrainCapabilityMap[terrainType] = 0x00;
	for (terrainType = TerrainImpactAnimationTypeMinimum;
		terrainType <= TerrainImpactAnimationTypeMaximum;
		++terrainType)
	{
		terrainCapabilityMap[terrainType] = 0x02;
	}
	for (terrainType = 0x00; terrainType < 0x03; ++terrainType)
	{
		terrainCapabilityMap[
			DestructibleTerrainTypeBase + terrainType] = 0x02;
	}

	for (terrainType = 0x00;
		terrainType < ImpassableTerrainTypeMinimum;
		++terrainType)
	{
		damagedTerrainSpriteMap[terrainType] = 0x77;
	}
	for (terrainType = 0x00; terrainType < 0x03; ++terrainType)
	{
		damagedTerrainSpriteMap[
			DestructibleTerrainTypeBase + terrainType] = 0xBB;
	}
	for (terrainType = TerrainImpactAnimationTypeMinimum;
		terrainType <= TerrainImpactAnimationTypeMaximum;
		++terrainType)
	{
		damagedTerrainSpriteMap[terrainType] = 0x33;
	}
	for (terrainType = ImpassableTerrainTypeMinimum;
		terrainType < TerrainLineOfSightBlockingThreshold;
		++terrainType)
	{
		damagedTerrainSpriteMap[terrainType] = 0xAA;
	}
	for (terrainType = TerrainLineOfSightBlockingThreshold;
		terrainType < 0x0100;
		++terrainType)
	{
		damagedTerrainSpriteMap[terrainType] = 0xCC;
	}
}

// 1A1F:417F: word16 RunGameOptionsMenu(word16 embeddedMode)
// Called from:
//      RunInGameMenu
//      RunTitleAndMainMenu
// Verified against 1A1F:417F-4446.
word16 RunGameOptionsMenu(word16 embeddedMode)
{
	int16 menuAction = 0x00;
	int16 menuEntryCount;
	int16 menuHeightTiles;
	word16 labelIndex;
	int16 selectedOption;
	word16 menuOpen = TRUE;

	// V: The menu cannot safely reconfigure sound while a digitized effect is
	// active. The original busy-waits here before constructing the window.
	do
		;
	while (DigitalSoundBusy != 0x00);

	menuEntryCount = (int16) (embeddedMode + 0x06);
	menuHeightTiles = (int16) (word16)
		((word16) (ActiveFontLineHeight) *
			(word16) menuEntryCount + 0x07);
	menuHeightTiles = (int16) (((word16) menuHeightTiles >> 0x01) |
		((word16) menuHeightTiles & 0x8000));
	menuHeightTiles = (int16) (((word16) menuHeightTiles >> 0x01) |
		((word16) menuHeightTiles & 0x8000));
	menuHeightTiles = (int16) (((word16) menuHeightTiles >> 0x01) |
		((word16) menuHeightTiles & 0x8000));
	GameOptionsMenuHeight = (word16) menuHeightTiles;
	GameOptionsMenuEntryCount = (word16) menuEntryCount;
	CampaignMenuRequested = 0x00;

	while (menuOpen != FALSE)
	{
		if (embeddedMode != FALSE)
		{
			HideMouseCursorOverlay();
			SelectAndClearTextWindow(0x0B);
			DrawActiveTextWindowFrame(0x00);
			ShowMouseCursorOverlay();
		}
		else
			OpenModalTextWindow(0x0B, 0x01);
		HideMouseCursorOverlay();
		for (labelIndex = 0x00; labelIndex < 0x07; ++labelIndex)
		{
			// Standalone mode omits the in-game-only fifth command.
			if (menuEntryCount != 0x06 || labelIndex != 0x04)
				RenderFormattedText(GameOptionLabelTextTable[labelIndex]);
		}
		ShowMouseCursorOverlay();

		menuAction = 0x00;
		while (menuAction == 0x00)
		{
			HideMouseCursorOverlay();
			SelectTextWindow(0x0C);
			ClearActiveTextWindow();
			RenderFormattedText(
				GameOptionToggleTextTable[RequestedMusicEnabled]);
			RenderFormattedText(
				GameOptionToggleTextTable[SoundEffectsEnabled]);
			RenderFormattedText(
				NarrationModeLabelTextTable[NarrationMode]);
			RenderFormattedText(
				InputDeviceLabelTextTable[InputDeviceType]);
			ShowMouseCursorOverlay();
			SelectTextWindow(0x0B);

			selectedOption = RunOptionsMenuSelection(0x05);
			HideMouseCursorOverlay();
			ToggleActiveUiRegionHighlight();
			ShowMouseCursorOverlay();

			switch (selectedOption)
			{
			case 0x00:
				RequestedMusicEnabled ^= 0x01;
				if (RequestedMusicEnabled == FALSE)
					DisableMusicPlayback();
				else
					EnableMusicPlayback();
				AppliedMusicEnabled =
					RequestedMusicEnabled;
				break;

			case 0x01:
				SoundEffectsEnabled ^= 0x01;
				if (SoundEffectsEnabled == FALSE)
					RequestPCSpeakerEffectStop();
				break;

			case 0x02:
				NarrationMode = (NarrationMode + 0x01) % 0x03;
				break;

			case 0x03:
				if (InputDeviceType == 0x00)
				{
					if (MouseDriverInstalled != 0x00)
					{
					MouseInputDisabled = 0x00;
						ShowMouseCursorOverlay();
						InputDeviceType = 0x01;
					}
				}
				else
				{
					HideMouseCursorOverlay();
					MouseInputDisabled = 0x01;
					InputDeviceType = 0x00;
				}
				break;

			case 0x04:
				if (embeddedMode != FALSE)
				{
					CampaignFlags |= 0x02;
					CampaignMenuRequested = 0x01;
					menuAction = 0x02;
				}
				else
				{
					RestoreModalTextWindow();
					if (ConfirmExitToDos() != FALSE)
					{
						menuAction = 0x04;
						TacticalBattleResult = 0x0004;
					}
					else
						menuAction = -0x01;
				}
				break;

			case 0x05:
				if (embeddedMode != FALSE)
				{
					if (ConfirmExitToDos() != FALSE)
					{
						menuAction = 0x04;
						TacticalBattleResult = 0x0004;
					}
					else
						menuAction = -0x01;
				}
				else
					menuAction = 0x01;
				break;

			case 0x06:
			case KEY_ESCAPE:
				menuAction = 0x01;
				break;
			}
		}

		if (menuAction == 0x04)
		{
			menuOpen = FALSE;
		}
		else if (menuAction > 0x00)
		{
			if (embeddedMode == FALSE)
				RestoreModalTextWindow();
			menuOpen = FALSE;
		}
		else
		{
			menuOpen = TRUE;
		}
	}
	return (word16) menuAction;
}
// 1A1F:5D30: void AdvanceCampaignClock(byte hoursToAdvance, byte minutesToAdvance)
// Called from:
//      PrepareScenarioUnitRosters
void AdvanceCampaignClock(byte hoursToAdvance, byte minutesToAdvance)
{
	// V: Add elapsed scenario time to the campaign time-of-day. Carry one full
	// hour when minutes reach 60, then wrap the hour at 24. The assembly does
	// not increment a day/date value when midnight is crossed.
	CampaignClockState[0x01] += minutesToAdvance;
	if (CampaignClockState[0x01] >=
		CAMPAIGN_MINUTES_PER_HOUR)
	{
		CampaignClockState[0x01] -= CAMPAIGN_MINUTES_PER_HOUR;
		++hoursToAdvance;
	}
	CampaignClockState[0x00] += hoursToAdvance;
	if (CampaignClockState[0x00] >=
		CAMPAIGN_HOURS_PER_DAY)
		CampaignClockState[0x00] -= CAMPAIGN_HOURS_PER_DAY;
}

// 1A1F:5D5E: int16 RunOptionsMenuSelection(int16 firstRegionIndex)
// Called from:
//      RunGameOptionsMenu
int16 RunOptionsMenuSelection(int16 firstRegionIndex)
{
	int16 selectedOption = RunSingleUiRegionSelection(firstRegionIndex);
	if (MouseInputDisabled == 0x00)
	{
		word16 pressedMouseButtons = MouseButtonState;
		do
		{
			(void) ServiceMusicAndCheckKeyboardInput();
		}
		while ((MouseButtonState & pressedMouseButtons) != 0x00);
	}
	return selectedOption;
}

// 1A1F:182E: void ScrollTacticalViewportToCursor(void)
void ScrollTacticalViewportToCursor(void)
{
	int16 cursorX = TacticalCursorViewportX;
	int16 cursorY = TacticalCursorViewportY;
	int16 viewportX = (int16) TacticalViewportMapX;
	int16 viewportY = (int16) TacticalViewportMapY;

	// V: keep the cursor in the 19x12 tactical viewport, scrolling the map
	// origin by the exact overflow and clamping it to the map bounds.
	if (cursorX < 0x00)
	{
		viewportX += cursorX;
		if (viewportX < 0x00)
			viewportX = 0x00;
		cursorX = 0x00;
	}
	if (cursorX >= 0x13)
	{
		viewportX += cursorX - 0x12;
		if (viewportX >= (int16) MapWidth - 0x13)
			viewportX = (int16) MapWidth - 0x13;
		cursorX = 0x12;
	}
	if (cursorY < 0x00)
	{
		viewportY += cursorY;
		if (viewportY < 0x00)
			viewportY = 0x00;
		cursorY = 0x00;
	}
	if (cursorY >= 0x0C)
	{
		viewportY += cursorY - 0x0B;
		if (viewportY >= (int16) MapHeight - 0x0C)
			viewportY = (int16) MapHeight - 0x0C;
		cursorY = 0x0B;
	}

	TacticalCursorViewportX = cursorX;
	TacticalCursorViewportY = cursorY;
	TacticalViewportMapX = (word16) viewportX;
	TacticalViewportMapY = (word16) viewportY;
}

// 1A1F:4C3D: set the tactical update delay selected by number keys 1-9.
void SetTacticalGameSpeed(word16 digitKey)
{
	static const word16 updateDelayBySpeed[0x08] = {
		0x0050, 0x0032, 0x0023, 0x0019,
		0x000F, 0x0009, 0x0005, 0x0002
	};
	word16 speedIndex;

	if (digitKey < KEY_ONE || digitKey > KEY_NINE)
		return;
	speedIndex = digitKey - KEY_ONE;
	if (speedIndex >= 0x08)
		speedIndex = 0x07; // Keys 8 and 9 share the fastest setting.
	TacticalUpdateDelayReloadTicks = updateDelayBySpeed[speedIndex];
	TacticalGameSpeedIndex = speedIndex;
	RedrawTacticalViewport();
}

// 1A1F:4CC6: dispatch F1-F10 after Revenge's keyboard translation layer.
// Verified against 1A1F:4CC6-4FA5.
void HandleTacticalFunctionKey(word16 inputAction)
{
	word16 functionIndex = (word16)(-(int16)inputAction - 0x003B);
	word16 unitIndex;
	word16 searchComplete;
	RevengeUnitRecord *unitRecord;

	if (functionIndex > 0x09)
		return;
	if (functionIndex <= 0x03)
	{
		FirstLanceOrdersEnabled = FALSE;
		if (GetPersistentUnitRecord(functionIndex)->deploymentState == 0x01)
		{
			TacticalSelectedUnitIndex = functionIndex;
			FocusTacticalViewOnUnit(functionIndex);
		}
		return;
	}
	if (functionIndex >= 0x04 && functionIndex <= 0x06)
	{
		word16 firstUnit = (functionIndex - 0x04) * 0x04;
		if (functionIndex == 0x04 && UnitTypeResourceCode[0x04] == FALSE)
			return;
		FirstLanceOrdersEnabled = functionIndex == 0x04;
		for (unitIndex = firstUnit; unitIndex < firstUnit + 0x04; ++unitIndex)
		{
			unitRecord = GetPersistentUnitRecord(unitIndex);
			if (unitRecord->deploymentState == 0x01
				&& unitRecord->walkMovement != 0x00)
			{
				TacticalSelectedUnitIndex = unitIndex;
				FocusTacticalViewOnUnit(unitIndex);
				break;
			}
		}
		return;
	}
	if (functionIndex == 0x07)
		return; // F8 is deliberately unassigned.
	if (functionIndex == 0x08)
	{
		word16 rememberedUnit = EnemyCycleUnitIndex;
		word16 selectedUnit = TacticalSelectedUnitIndex;

		if (selectedUnit != TACTICAL_UNIT_NONE
			&& GetPersistentUnitRecord(selectedUnit)->deploymentState == 0x00)
			selectedUnit = TacticalSelectedUnitIndex = TACTICAL_UNIT_NONE;
		if (rememberedUnit != TACTICAL_UNIT_NONE
			&& GetPersistentUnitRecord(rememberedUnit)->deploymentState == 0x00)
			rememberedUnit = EnemyCycleUnitIndex = TACTICAL_UNIT_NONE;

		if (selectedUnit == rememberedUnit && rememberedUnit != TACTICAL_UNIT_NONE)
		{
			searchComplete = FALSE;
			unitIndex = rememberedUnit;
			while (searchComplete == FALSE)
			{
				++unitIndex;
				if (unitIndex >= TACTICAL_UNIT_COUNT)
					unitIndex = TACTICAL_ENEMY_FIRST_UNIT;
				if (unitIndex == rememberedUnit)
				{
					searchComplete = TRUE;
				}
				else
				{
					unitRecord = GetPersistentUnitRecord(unitIndex);
					if (unitRecord->deploymentState != 0x00
						&& ((UpdateUnitEnemyVisibility(unitIndex)
							| UpdateUnitEnemyProximityState(unitIndex)) != 0x00
							|| TacticalOverviewMapMode == 0x00))
					{
						EnemyCycleUnitIndex = unitIndex;
						TacticalSelectedUnitIndex = unitIndex;
						FocusTacticalViewOnUnit(unitIndex);
						searchComplete = TRUE;
					}
				}
			}
		}
		else if (rememberedUnit != TACTICAL_UNIT_NONE)
		{
			unitRecord = GetPersistentUnitRecord(rememberedUnit);
			if (unitRecord->deploymentState != 0x00
				&& ((UpdateUnitEnemyVisibility(rememberedUnit)
					| UpdateUnitEnemyProximityState(rememberedUnit)) != 0x00
					|| TacticalOverviewMapMode == 0x00))
			{
				TacticalSelectedUnitIndex = rememberedUnit;
				FocusTacticalViewOnUnit(rememberedUnit);
				goto enemy_selection_finished;
			}
		}

		if (selectedUnit != rememberedUnit || rememberedUnit == TACTICAL_UNIT_NONE)
		{
			for (unitIndex = TACTICAL_ENEMY_FIRST_UNIT;
				unitIndex < TACTICAL_UNIT_COUNT;
				++unitIndex)
			{
				unitRecord = GetPersistentUnitRecord(unitIndex);
				if (unitRecord->deploymentState != 0x00
					&& ((UpdateUnitEnemyVisibility(unitIndex)
						| UpdateUnitEnemyProximityState(unitIndex)) != 0x00
						|| TacticalOverviewMapMode == 0x00))
				{
					EnemyCycleUnitIndex = unitIndex;
					TacticalSelectedUnitIndex = unitIndex;
					FocusTacticalViewOnUnit(unitIndex);
					break;
				}
			}
		}

enemy_selection_finished:
		if ((int16)TacticalSelectedUnitIndex
			>= TACTICAL_ENEMY_FIRST_UNIT)
			FirstLanceOrdersEnabled = FALSE;
		return;
	}

	// F10 selects the dropship/overview controls.
	FirstLanceOrdersEnabled = FALSE;
	if (TacticalScenarioLanceEnabled[0x00] != FALSE)
		RunTacticalGameOptionsMenu();
	if (TacticalOverviewActive == FALSE)
	{
		RebuildTacticalViewport();
		DrawTacticalCursorOutline(TacticalCursorOutlineState);
	}
}

// 1A1F:5154: open the active unit, or the unit under the tactical cursor.
// Verified against 1A1F:5154-51BF.
void OpenSelectedTacticalUnitPanel(void)
{
	word16 unitIndex = TacticalSelectedUnitIndex;
	int16 unitMapX;
	int16 unitMapY;
	int16 viewportMapX;
	int16 viewportMapY;

	if (unitIndex != TACTICAL_UNIT_NONE)
	{
		OpenTacticalUnitControlPanel(unitIndex);
		return;
	}

	unitIndex = FindUnitAtTacticalCursor();
	if (unitIndex == TACTICAL_UNIT_NONE)
		return;

	FirstLanceOrdersEnabled = FALSE;
	unitMapX = ScenarioUnitMapX[unitIndex];
	unitMapY = ScenarioUnitMapY[unitIndex];
	viewportMapX = (int16) TacticalViewportMapX;
	viewportMapY = (int16) TacticalViewportMapY;
	if (unitMapX < viewportMapX
		|| unitMapX >= viewportMapX + 0x13
		|| unitMapY < viewportMapY
		|| unitMapY >= viewportMapY + 0x0C)
		FocusTacticalViewOnUnit(unitIndex);
	OpenTacticalUnitControlPanel(unitIndex);
}

// 1A1F:4A9E: top-level tactical keyboard/action dispatcher.
// Verified against 1A1F:4A9E-4C3C.
void HandleTacticalInput(word16 inputAction)
{
	word16 previousSelection;
	word16 narrationUnit;
	word16 narrationAvailable;

	if (inputAction == '-' || inputAction == '+')
	{
		previousSelection = TacticalSelectedUnitIndex;
		TacticalSelectedUnitIndex = inputAction == '-'
			? SelectPreviousUnitAtCursor()
			: SelectNextUnitAtCursor();
		if (previousSelection != 0x00 || TacticalSelectedUnitIndex != 0x00)
			FirstLanceOrdersEnabled = FALSE;
	}
	if (inputAction >= KEY_ONE && inputAction <= KEY_NINE)
		SetTacticalGameSpeed(inputAction);
	if (IsTacticalFunctionKey(inputAction) != FALSE)
		HandleTacticalFunctionKey(inputAction);

	narrationUnit = ActiveNarrationSubject;
	if ((int16)narrationUnit < 0x00 || narrationUnit >= 0x0C)
		PendingNarrationDelay = FALSE;
	if (PendingNarrationDelay != FALSE)
	{
		if (GetPersistentUnitRecord(narrationUnit)->deploymentState == 0x00
			&& NarrationMessageCategory != 0x12)
			PendingNarrationDelay = FALSE;
		if (narrationUnit > 0x04 && NarrationMessageCategory != 0x12)
		{
			narrationUnit = FindOperationalLanceLeader(narrationUnit);
			if (narrationUnit == TACTICAL_UNIT_NONE)
				narrationUnit = 0x00;
			narrationUnit &= 0x0C;
		}
		narrationAvailable = HasNarrationMessage(
			ActiveNarrationSubject, NarrationMessageCategory);
		if (NarrationMessageCategory >= 0x0B)
			narrationAvailable = TRUE;
		if (narrationAvailable == FALSE)
			PendingNarrationDelay = FALSE;
		if (narrationUnit == 0x00 && PendingNarrationDelay != FALSE)
			NarrationReady = TRUE;
		if (PendingNarrationDelay != FALSE
			&& NarrationReady != FALSE)
			ShowPendingNarrationPrompt();
	}

	if (TacticalOverviewActive == FALSE
		&& (inputAction == 'M' || inputAction == 'm'))
		ShowPendingNarrationPrompt();
	if (inputAction != KEY_SPACE && inputAction != KEY_CARRIAGE_RETURN)
		return;
	if (TacticalOverviewActive != FALSE
		&& TacticalOverviewZoomed == FALSE)
	{
		TacticalOverviewSavedMode = TacticalOverviewMapMode;
		TacticalOverviewMapMode = 0x00;
		ClearActiveVideoBuffer();
		TacticalOverviewZoomed = TRUE;
		DrawTileAlignedText(
			SatelliteZoomText,
			0x0D, 0x18, 0x0F, 0x0C);
		return;
	}
	OpenSelectedTacticalUnitPanel();
}

// 1A1F:4FA6: display and resolve the pending tactical narration prompt.
// Verified against 1A1F:4FA6-5153.
void ShowPendingNarrationPrompt(void)
{
	TextWindowContext *narrationWindow;
	byte *backingBuffer;
	const char *focusLabel;
	const char *continueLabel;
	word16 focusLabelWidth;
	word16 continueLabelWidth;
	word16 narrationUnit;
	int16 selection;
	word16 focusRequested;

	if (PendingNarrationDelay == FALSE)
	{
		return;
	}

	narrationWindow = &TextWindowContexts[0x0D];
	backingBuffer = PrimaryScreenBuffer;
	HideMouseCursorOverlay();
	CopyVideoRegionToBuffer(
		(int16) (narrationWindow->leftTile - 0x01),
		(word16) (narrationWindow->topTile - 0x01),
		(word16) (narrationWindow->widthTiles + 0x01),
		(word16) (narrationWindow->heightTiles + 0x01),
		backingBuffer);
	SelectAndClearTextWindow(0x0D);
	DrawActiveTextWindowBorder(0x0E);
	RenderPendingNarration();

	narrationUnit = ActiveNarrationSubject;
	if ((int16) narrationUnit > 0x04)
	{
		narrationUnit = FindOperationalLanceLeader(narrationUnit);
	}
	NarrationFocusRegion = 0x0A;
	if (HasActiveLanceFollowers(narrationUnit) != FALSE)
	{
		focusLabel = FocusLanceText;
		NarrationFocusRegion = 0x0B;
	}
	else
	{
		focusLabel = FocusUnitText;
	}
	focusLabelWidth = (word16) (StringLength(focusLabel) *
		ActiveFontGlyphAdvanceX);
	DrawBeveledMenuButton(
		0x18, 0x05, focusLabel, focusLabelWidth);

	continueLabel = ContinueText;
	continueLabelWidth = (word16) (StringLength(continueLabel) *
		ActiveFontGlyphAdvanceX);
	DrawBeveledMenuButton(
		0x04, 0x05, continueLabel, continueLabelWidth);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	focusRequested = FALSE;
	selection = RunUiRegionSelectionLoop(0x0E, 0x02);
	if (selection == KEY_ESCAPE)
	{
		ToggleActiveUiRegionHighlight();
	}
	else if (ActiveUiRegionIndex == 0x0F)
	{
		/* 1A1F:50D4-50DB: region 0Fh is the focus button; region
		 * 0Eh is Continue. The region poller's return value is only the
		 * selected row and therefore cannot distinguish these buttons. */
		focusRequested = TRUE;
	}

	HideMouseCursorOverlay();
	CopyBufferToVideoRegion(
		(int16) (narrationWindow->leftTile - 0x01),
		(word16) (narrationWindow->topTile - 0x01),
		(word16) (narrationWindow->widthTiles + 0x01),
		(word16) (narrationWindow->heightTiles + 0x01),
		backingBuffer);
	ShowMouseCursorOverlay();

	if (focusRequested != FALSE)
	{
		if (TacticalOverviewActive != FALSE)
		{
			ExitTacticalOverview();
		}
		FirstLanceOrdersEnabled = FALSE;
		if ((int16) ActiveNarrationSubject < 0x04 &&
			HasActiveLanceFollowers(ActiveNarrationSubject) != FALSE)
		{
			FirstLanceOrdersEnabled = TRUE;
		}
		FocusTacticalViewOnUnit(narrationUnit);
	}

	NarrationReady = FALSE;
	PendingNarrationDelay = FALSE;
	NarrationEmphasis = FALSE;
}
