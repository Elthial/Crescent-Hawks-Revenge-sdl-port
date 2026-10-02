// REVENGE_1A1F_SCENARIO_RUNTIME.c
// Procedures preserved from REVENGE_1A1F_SCENARIO.c.

#include "REVENGE_1A1F_INTERNAL.h"
#include "revenge/debug.h"

// 1A1F:0000: void RunTacticalBattle(word16 scenarioCode)
// Called from:
//      InitializeTacticalScenario
void RunTacticalBattle(word16 scenarioCode)
{
	// Verified against ASM 1A1F:0000-0350. The original cleanup deliberately
	// frees only the odd-numbered late backing buffers before freeing buffers
	// 0Dh..01h and the tactical runtime allocation.
	ShowMouseCursorOverlay();
	ScenarioFileSuffix = scenarioCode;

	byte *runtimeMemory =
		AllocateFarMemory((uint32) TACTICAL_RUNTIME_ALLOCATION_SIZE);
	TerrainTypeMap = runtimeMemory;
	TacticalOverviewMapBuffer = AddBytesToFarPointer(
		runtimeMemory, TACTICAL_OVERVIEW_MAP_OFFSET);
	PackedTerrainDamageMap = AddBytesToFarPointer(
		runtimeMemory, PACKED_TERRAIN_DAMAGE_MAP_OFFSET);
	TacticalCellSpriteMap = (word16 *)
		AddBytesToFarPointer(runtimeMemory, TACTICAL_CELL_SPRITE_MAP_OFFSET);
	TacticalCellTerrainMap = (word16 *)
		AddBytesToFarPointer(runtimeMemory, TACTICAL_CELL_TERRAIN_MAP_OFFSET);
	FillRuntimeFarMemoryBytes(
		runtimeMemory,
		TACTICAL_RUNTIME_ALLOCATION_SIZE,
		0x00);
	InstallDamagedTerrainSpriteLookup();

	LoadPackedIconPageDirect(
		(const char *) MAKE_FAR_POINTER(
			TacticalResourcePathSegment, TacticalResourcePathOffset),
		PlanarScreenBuffer,
		PrimaryScreenBuffer);

	word16 bufferIndex;
	for (bufferIndex = 0x01; bufferIndex <= 0x05; ++bufferIndex)
	{
		SET_TACTICAL_BACKING_BUFFER(
			bufferIndex,
			BuildPlanarDisplayBackingBuffer(
				(bufferIndex - 0x01) * 0x05, 0x00, 0x05, 0x28));
	}

	static const byte panelX[0x08] =
		{ 0x00, 0x06, 0x09, 0x0F, 0x00, 0x09, 0x0F, 0x18 };
	static const byte panelY[0x08] =
		{ 0x28, 0x28, 0x28, 0x28, 0x40, 0x40, 0x40, 0x40 };
	for (bufferIndex = 0x00; bufferIndex < 0x08; ++bufferIndex)
	{
		SET_TACTICAL_BACKING_BUFFER(
			bufferIndex + 0x06,
			BuildPlanarDisplayBackingBuffer(
				panelX[bufferIndex], panelY[bufferIndex], 0x03, 0x18));
	}

	for (bufferIndex = 0x00; bufferIndex < 0x08; ++bufferIndex)
	{
		SET_TACTICAL_BACKING_BUFFER(
			0x0E + bufferIndex * 0x02,
			BuildPlanarDisplayBackingBuffer(
				bufferIndex << 0x01, 0x60, 0x02, 0x10));
		SET_TACTICAL_BACKING_BUFFER(
			0x0F + bufferIndex * 0x02,
			BuildPlanarDisplayBackingBuffer(
				bufferIndex << 0x01, 0x70, 0x02, 0x10));
	}

	SuppressCampaignClock = TRUE;
	/* ASM 1A1F:0233-0244 restores the saved scenario clock into the live
	 * tactical clock.  PrepareScenarioUnitRosters performs the opposite
	 * copy when leaving a scenario. */
	CopyFarMemory(0x03, SavedCampaignClockState, CampaignClockState);
	LoadTacticalScenarioResources((byte) scenarioCode);
	REVENGE_PRESERVATION_TRACE("tactical: scenario loaded unit0=%u,%u deployed=%u unit15=%u,%u deployed=%u\n",
		ScenarioUnitMapX[0x00], ScenarioUnitMapY[0x00],
		PersistentUnitRoster[0x00].deploymentState,
		ScenarioUnitMapX[0x0F], ScenarioUnitMapY[0x0F],
		PersistentUnitRoster[0x0F].deploymentState);
	REVENGE_PRESERVATION_TRACE("tactical: map=%ux%u unit0 terrain=%u speed=%u delay=%u\n",
		MapWidth, MapHeight,
		TerrainTypeMap[
			ScenarioUnitMapY[0x00] * MapWidth
			+ ScenarioUnitMapX[0x00]],
		TacticalGameSpeedIndex,
		TacticalUpdateDelayReloadTicks);
	LoadTacticalIconResource(
		TacticalMechSetFileName, 0x01);
	HideMouseCursorOverlay();
	ClearActiveVideoBuffer();
	InstallVgaPaletteBankAnchors();
	ShowMouseCursorOverlay();
	InitializeTacticalUnitRuntime();
	REVENGE_PRESERVATION_TRACE("tactical: unit runtime initialized\n");
	RedrawTacticalViewport();
	REVENGE_PRESERVATION_TRACE("tactical: viewport redrawn\n");

	word16 unitIndex;
	for (unitIndex = 0x00; unitIndex < 0x18; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord =
			&PersistentUnitRoster[unitIndex];
		if (unitRecord->deploymentState != 0x00)
			ScenarioUnitNeedsUpdate[unitIndex] = TRUE;
	}

	UpdateTacticalFrame(0x00, TRUE);
	REVENGE_PRESERVATION_TRACE("tactical: first frame complete viewport=%u,%u cursor=%u,%u\n",
		TacticalViewportMapX, TacticalViewportMapY,
		TacticalCursorViewportX, TacticalCursorViewportY);
	REVENGE_PRESERVATION_TRACE("tactical: selected terrain sprite=%u source=%u\n",
		TacticalCellTerrainMap[
			TacticalCursorViewportY * 0x0013
			+ TacticalCursorViewportX],
		TerrainTypeMap[
			ScenarioUnitMapY[0x00] * MapWidth
			+ ScenarioUnitMapX[0x00]]);
	TacticalStateInitialized = TRUE;
	if (MouseDriverInstalled != FALSE)
	{
		SetMouseCursorPosition(
			(TacticalCursorViewportX << 0x04) + 0x18,
			(TacticalCursorViewportY << 0x04) + 0x08);
	}

	RunTacticalInteractionLoop();

	for (bufferIndex = 0x1D; bufferIndex >= 0x0F; bufferIndex -= 0x02)
		FreeFarMemory(TACTICAL_BACKING_BUFFER(bufferIndex));
	for (bufferIndex = 0x0D; bufferIndex >= 0x01; --bufferIndex)
		FreeFarMemory(TACTICAL_BACKING_BUFFER(bufferIndex));
	FreeFarMemory(runtimeMemory);
}

// 1A1F:0351: void UpdateTacticalFrame(
//     word16 inputAction, word16 advanceUnits)
// Verified against 1A1F:0351-03D3.
void UpdateTacticalFrame(word16 inputAction, word16 advanceUnits)
{
	word16 movementRepeatCount = 0x01;
	word16 repeatIndex;
	word16 unitIndex;

	if (TacticalOverviewActive != 0x00
		&& TacticalMenuInputState != 0x00
		&& TacticalOverviewZoomed == 0x00)
	{
		movementRepeatCount = 0x0A;
	}

	for (repeatIndex = 0x00;
		repeatIndex < movementRepeatCount;
		++repeatIndex)
	{
		MoveTacticalCursorByInput((int16)inputAction);
	}

	if (advanceUnits != 0x00)
	{
		for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
		{
			RevengeUnitRecord *unitRecord =
				&PersistentUnitRoster[unitIndex];
			if (unitRecord->deploymentState != 0x00)
			{
				AdvanceUnitTacticalMovement(unitIndex);
				ScenarioUnitNeedsUpdate[unitIndex] = 0x01;
			}
		}
	}

	KeepTacticalCursorOnSelectedUnit();
	ScrollTacticalViewportToCursor();
	HandleTacticalInput(inputAction);
	RefreshTacticalDisplay(advanceUnits);
}

// 1A1F:0468: void LoadTacticalIconResource(
//     const char far *resourcePath, word16 destinationPage)
// [V] destinationPage selects a 32 KiB page in the secondary graphics buffer.
// Page 1 takes the direct three-buffer loader; the other pages load through the
// packed display buffer and copy into the selected page. EGA additionally
// converts that packed page into the corresponding 8 KiB planar video page.
void LoadTacticalIconResource(
	const char *resourcePath,
	word16 destinationPage)
{
	byte *packedDisplayBuffer = PrimaryScreenBuffer;
	byte *iconPageDestination = PlanarScreenBuffer;
	word16 pageIndex;

	for (pageIndex = 0x00; pageIndex < destinationPage; ++pageIndex)
		iconPageDestination = AdvanceFarPointerBy32K(iconPageDestination);

	CgaNarrowStrideMode = TRUE;
	if (destinationPage == 0x01)
	{
		LoadPackedIconPageDirect(
			resourcePath,
			packedDisplayBuffer,
			iconPageDestination);
	}
	else
	{
		LoadPackedIconResource(resourcePath, packedDisplayBuffer);
		CopyDecodedIconPage(packedDisplayBuffer, iconPageDestination);
	}

	CgaNarrowStrideMode = FALSE;
	if (VideoAdapterType == VIDEO_ADAPTER_EGA)
	{
		EGA_ConvertPackedScreenToPlanar(
			iconPageDestination,
			(word16)(0xA400 + destinationPage * 0x0200));
	}
}

// 1A1F:03D4: void LoadTacticalIconSetResources(word16 iconSetNumber)
// [V] The assembly adds ASCII '0' and writes the resulting selector into the
// same character position of ICONSETx.ICN and DESTROYx.ICN. It then loads the
// DESTROY sheet (resource 3Eh), ICONSET sheet (3Dh), and ICONLIST.DAT (3Fh).
// Verified against 1A1F:03D4-0467.
void LoadTacticalIconSetResources(word16 iconSetNumber)
{
	byte assetSuffix = (byte) iconSetNumber + '0';
	TacticalIconSetFileName[0x07] = assetSuffix;
	TacticalDestroyIconFileName[0x07] = assetSuffix;

	LoadTacticalIconResource(
		TacticalDestroyIconFileName,
		0x02);
	LoadTacticalIconResource(
		TacticalIconSetFileName,
		0x00);

	int16 iconListHandle = OpenTrackedFile(
		TacticalIconListFileName,
		0x01);
	SeekTrackedFile(iconListHandle, (int32)iconSetNumber * 0x0300, 0x00);
	ReadTrackedFile(
		iconListHandle,
		TerrainDamageCapabilityTable,
		0x0300);
	CloseTrackedFile(iconListHandle);
}

// 1A1F:051B: void LoadTacticalMap(word16 mapNumber)
// [V] MAP1..MAP9 use '1'..'9'; values 0Ah and above use 'A' onward. The
// remainder of the routine opens resource 3Ch, reads its 0Ch-byte header, and
// derives MapWidth, MapHeight, and PackedTerrainDamageRowBytes.
// Verified against 1A1F:051B-0612.
void LoadTacticalMap(word16 mapNumber)
{
	byte *mapBuffer = TerrainTypeMap;
	int16 mapFileHandle;
	word16 mapWidth;
	word16 mapHeight;
	word16 negativeMapWidth;
	word16 mapCellByteCount;

	TacticalMapFileName[0x03] =
		(byte) mapNumber + ((int16) mapNumber < 0x0A ? '0' : '7');

	mapFileHandle = OpenTrackedFile(
		TacticalMapFileName,
		0x01);
	ReadTrackedFile(mapFileHandle, mapBuffer, 0x0C);

	// The header stores the map-cell dimensions at bytes 00h and 02h. The
	// payload immediately following it is one terrain-type byte per cell.
	mapWidth = mapBuffer[0x00];
	mapHeight = mapBuffer[0x02];
	MapWidth = mapWidth;
	MapHeight = mapHeight;
	/* 4184:0901 is the row-stride byte consumed by the graphics-overlay
	 * terrain builder.  The DOS overlay patches this writable data for the
	 * active compact MAP payload; keep the reconstructed object synchronized. */
	TacticalMapRowWidth = (byte)mapWidth;

	negativeMapWidth = (word16) (0x00 - mapWidth);
	TacticalMapNegativeStrideQuaternary = negativeMapWidth;
	TacticalMapNegativeStrideTertiary = negativeMapWidth;
	TacticalMapNegativeStrideSecondary = negativeMapWidth;
	TacticalMapNegativeStridePrimary = negativeMapWidth;
	TacticalMapPositiveStrideQuaternary = mapWidth;
	TacticalMapPositiveStrideTertiary = mapWidth;
	TacticalMapPositiveStrideSecondary = mapWidth;
	TacticalMapPositiveStridePrimary = mapWidth;

	// Eight signed linear neighbor deltas. The static +/-1 entries at indices
	// two and six are not rewritten by this procedure.
	NeighborMapOffsetTable[0x00] = (int16)negativeMapWidth;
	NeighborMapOffsetTable[0x01] = (int16)(negativeMapWidth + 0x01);
	NeighborMapOffsetTable[0x03] = (int16)(mapWidth + 0x01);
	NeighborMapOffsetTable[0x04] = (int16)mapWidth;
	NeighborMapOffsetTable[0x05] = (int16)(mapWidth - 0x01);
	NeighborMapOffsetTable[0x07] = (int16)(negativeMapWidth - 0x01);

	PackedTerrainDamageRowBytes =
		((mapWidth + 0x03) & 0x01FC) >> 0x02;
	mapCellByteCount = mapWidth * mapHeight;

	ReadTrackedFile(
		mapFileHandle,
		mapBuffer,
		(int32) (int16) mapCellByteCount);
	CloseTrackedFile(mapFileHandle);
}

// 1A1F:0613: void RunTacticalInteractionLoop(void)
// Verified against ASM 1A1F:0613-0C32. This deliberately remains one
// original procedure; the former Rejected session/tick/finalization split is
// evidence only. The uninitialized enemyForceDefeated stack word is retained
// pending an execution trace of the game-options exit path.
void RunTacticalInteractionLoop(void)
{
	word16 scanUnitIndex;
	word16 previousInput;
	word16 inputAction;
	word16 savedFrameCountdown;
	word16 advanceUnits;
	word16 completionRequested;
	word16 enemyForceDefeated = FALSE;
	word16 changedEnemyRecord;
	word16 unitIndex;

	REVENGE_PRESERVATION_TRACE("tactical: interaction refresh combat begin\n");
	RefreshAllUnitCombatState(TRUE);
	REVENGE_PRESERVATION_TRACE("tactical: interaction refresh combat complete\n");
	TacticalClockDivider = 0x0080;
	scanUnitIndex = 0x0000;
	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		UpdateUnitEnemyVisibility(unitIndex);
		UpdateUnitEnemyProximityState(unitIndex);
	}
	REVENGE_PRESERVATION_TRACE("tactical: interaction visibility complete\n");
	DrawCampaignClock();
	previousInput = 0x0000;
	completionRequested = 0x0000;
	TacticalUpdateDelayTicks = TacticalUpdateDelayReloadTicks;

	while (completionRequested == 0x0000 &&
		TacticalBattleResult == 0x0000)
	{
		inputAction = 0x0000;
		savedFrameCountdown = TacticalUpdateDelayTicks;
		if (SoundEffectsEnabled == 0x0000)
			RequestPCSpeakerEffectStop();

		if (ServiceMusicAndCheckKeyboardInput() != 0x0000)
		{
			inputAction = (word16)ReadTranslatedKeypress();
			TacticalKeyRepeatDelayTicks = 0x0005;
			if (inputAction == previousInput)
				TacticalMenuInputState = 0x0001;
			else
			{
				TacticalMenuInputState = 0x0000;
				previousInput = inputAction;
			}
			while (ServiceMusicAndCheckKeyboardInput() != 0x0000)
				ReadTranslatedKeypress();
		}
		if (TacticalKeyRepeatDelayTicks == 0x0000)
		{
			previousInput = 0x0000;
			TacticalMenuInputState = 0x0000;
		}

		inputAction = (word16)TranslateTacticalMouseInput(
			(int16)inputAction);
		if (inputAction == KEY_ESCAPE)
		{
			if (TacticalOverviewActive != 0x0000)
			{
				if (TacticalOverviewViewportDirty != 0x0000)
				{
					TacticalOverviewViewportDirty = 0x0000;
					TacticalOverviewMapMode = TacticalOverviewDisplayMode;
					DrawTacticalOverviewMap();
				}
				else
					ExitTacticalOverview();
			}
			else
			{
				TacticalCursorOutlineEnabled = 0x0000;
				RefreshTacticalDisplay(FALSE);
				if (RunGameOptionsMenu(TRUE) == 0x0002)
					completionRequested = 0x0001;
				TacticalCursorOutlineEnabled = 0x0001;
			}
		}

		advanceUnits = savedFrameCountdown == 0x0000;
		if (TacticalOverviewViewportDirty != 0x0000)
		{
			advanceUnits = FALSE;
			savedFrameCountdown = 0x0001;
		}
		UpdateTacticalFrame(
			(word16)NormalizeNavigationKeyCode((int16)inputAction),
			advanceUnits);
		RefreshTacticalStatusSlotStates();

		if (savedFrameCountdown == 0x0000)
		{
			REVENGE_PRESERVATION_TRACE("tactical: tick scan=%u\n", scanUnitIndex);
			for (unitIndex = 0x0000; unitIndex < 0x0006; ++unitIndex)
			{
				UpdateUnitEnemyVisibility(scanUnitIndex);
				UpdateUnitEnemyProximityState(scanUnitIndex);
				if (++scanUnitIndex >= 0x0018)
					scanUnitIndex = 0x0000;
			}
			for (unitIndex = 0x0000; unitIndex < 0x0018; unitIndex += 0x0004)
				RebuildLanceFormationAfterLeaderLoss(unitIndex);
			RefreshAllUnitCombatState(FALSE);
			for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
			{
				if (PersistentUnitRoster[unitIndex].deploymentState != 0x00)
				{
					ExecuteUnitWeaponAI(unitIndex);
				}
			}
			AdvanceScenarioAreaEffects();
			ExecuteSceneInstructions();
			++TacticalClockSubtick;
			TacticalClockDivider =
				(word16)((int16)TacticalClockDivider >> 0x01);
			if (TacticalClockDivider == 0x0000)
			{
				TacticalClockDivider = 0x0080;
				AdvanceTacticalCampaignClock();
				for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
				{
					if (UnitWasAttackedThisTick[unitIndex] != 0x00)
						++UnitConsecutiveAttackTicks[unitIndex];
					else
						UnitConsecutiveAttackTicks[unitIndex] = 0x0000;
					UnitJumpingState[unitIndex] = 0x00;
					UnitWasAttackedThisTick[unitIndex] = 0x00;
					UnitJumpMovementRemaining[unitIndex] =
						PersistentUnitRoster[unitIndex].jumpMovement;
					UnitShutdownState[unitIndex] =
						UpdateUnitHeatShutdown(unitIndex);
				}
			}
			UpdateUnitHeatAccumulators();
		}

		if (savedFrameCountdown == 0x0000)
			TacticalUpdateDelayTicks = TacticalUpdateDelayReloadTicks;
		if (completionRequested == 0x0000)
		{
			completionRequested = 0x0001;
			for (unitIndex = 0x0000; unitIndex < 0x000C; ++unitIndex)
			{
				if (PersistentUnitRoster[unitIndex].deploymentState != 0x00)
					completionRequested = 0x0000;
			}
			enemyForceDefeated = 0x0001;
			for (unitIndex = 0x000C; unitIndex < 0x0018; ++unitIndex)
			{
				if (PersistentUnitRoster[unitIndex].deploymentState != 0x00 &&
					PersistentUnitRoster[unitIndex].walkMovement != 0x00)
				{
					enemyForceDefeated = 0x0000;
				}
			}
			if (enemyForceDefeated != 0x0000)
				TacticalBattleResult = 0x0002;
		}
		if (PersistentUnitRoster[0x00].deploymentState == 0x00)
			completionRequested = 0x0001;
	}

	if (PersistentUnitRoster[0x00].deploymentState == 0x00)
		TacticalBattleResult = 0x0003;
	if (ScenarioFileSuffix == 0x0053 &&
		PersistentUnitRoster[0x14].deploymentState != 0x00 &&
		PersistentUnitRoster[0x14].walkMovement == 0x00)
	{
		CampaignFlags &= 0xFDFF;
		CampaignFlags |= 0x0400;
	}
	if (PendingNarrationDelay != 0x0000 &&
		(int16)NarrationMessageCategory >= 0x000B &&
		(int16)NarrationMessageCategory <= 0x0010)
	{
		unitIndex = ActiveNarrationSubject;
		if (PersistentUnitRoster[unitIndex].deploymentState == 0x00)
		{
			ActiveNarrationSubject = 0x0000;
		}
		ShowPendingNarrationPrompt();
		enemyForceDefeated = 0x0000;
	}
	if (TacticalBattleResult == 0x0002 &&
		enemyForceDefeated != 0x0000)
	{
		changedEnemyRecord = 0x0000;
		for (unitIndex = 0x000C; unitIndex < 0x0018; ++unitIndex)
		{
			if (PersistentUnitRoster[unitIndex].deploymentState != 0x00 &&
				PersistentUnitRoster[unitIndex].walkMovement == 0x00)
			{
				changedEnemyRecord = 0x0001;
				NarrationSourceUnit = unitIndex;
				PersistentUnitRoster[unitIndex].deploymentState = 0x00;
				UnitDestructionMarkers[unitIndex][0x00] =
					ScenarioUnitMapX[unitIndex];
				UnitDestructionMarkers[unitIndex][0x01] =
					ScenarioUnitMapY[unitIndex];
				UnitDestructionMarkers[unitIndex][0x02] = 0xDD;
			}
		}
		if (changedEnemyRecord != 0x0000)
		{
			TacticalSelectedUnitIndex = 0xFFFF;
			RefreshTacticalDisplay(FALSE);
			PendingNarrationDelay = 0x025D;
			ActiveNarrationSubject = 0x0000;
			NarrationMessageCategory = 0x0009;
			NarrationEmphasis = 0x0000;
		}
	}
	if (PendingNarrationDelay != 0x0000 &&
		(NarrationMessageCategory == 0x0009 ||
		NarrationMessageCategory == 0x0012))
	{
		ShowPendingNarrationPrompt();
	}

	for (unitIndex = 0x0000;
		(int16)unitIndex < (int16)TacticalProjectileCount;
		++unitIndex)
	{
		RevengeTacticalProjectileRecord *projectile =
			&TacticalProjectileRecords[unitIndex];
		if (projectile->shotHit != 0x00)
		{
			int16 sourceIndex = projectile->targetUnitIndex;
			projectile->destinationMapX =
				ScenarioUnitMapX[sourceIndex];
			projectile->destinationMapY =
				ScenarioUnitMapY[sourceIndex];
		}
		projectile->shotHit = 0x00;
	}
	if (TacticalOverviewActive == 0x0000)
	{
		while (TacticalImpactQueueCount != 0x0000 ||
			TacticalProjectileCount != 0x0000)
		{
			UpdateTacticalFrame(0x0000, 0x0000);
		}
	}
	if (PersistentUnitRoster[0x00].deploymentState == 0x00)
		TacticalBattleResult = 0x0003;
	if (TacticalOverviewActive != 0x0000)
	{
		for (unitIndex = 0x0000; unitIndex < 0x0009; ++unitIndex)
			TacticalStatusRowInvalidation[unitIndex] = 0xFF;
		RedrawTacticalStatusPanel();
		ShowMouseCursorOverlay();
	}

	TacticalOverviewActive = 0x0000;
	TacticalProjectileCount = 0x0000;
	TacticalImpactQueueCount = 0x0000;
	MapEdgeEffectCount = 0x0000;
	TerrainDamageQueueWordCount = 0x0000;
	if (PersistentUnitRoster[0x00].deploymentState == 0x00)
		CampaignFlags |= 0x0002;
	if (PersistentUnitRoster[0x01].deploymentState == 0x00)
		CampaignFlags |= 0x0008;
	if (ScenarioFileSuffix == 0x0037 &&
		PersistentUnitRoster[0x01].deploymentState == 0x00)
	{
		CampaignFlags |= 0x0010;
	}
	if (CampaignClockState[0x00] >= 0x0C)
		CampaignFlags |= 0x0040;
	if ((ScenarioFileSuffix == 0x0036 ||
		ScenarioFileSuffix == 0x0037) &&
		(CampaignClockState[0x00] > 0x07 ||
		(CampaignClockState[0x00] == 0x07 &&
		CampaignClockState[0x01] >= 0x1E)))
	{
		CampaignFlags |= 0x0040;
	}
	TacticalClockSubtick = 0x00;
	if (completionRequested != 0x0000)
		TacticalBattleResult = 0x0003;
	switch (TacticalBattleResult)
	{
	case 0x0002:
		CampaignFlags |= 0x0001;
		break;
	case 0x0004:
		VideoPathUnavailable = 0x01;
		break;
	default:
		break;
	}
	if ((PersistentUnitRoster[0x00].deploymentState == 0x00 ||
		(ScenarioFileSuffix == 0x0035 &&
		PersistentUnitRoster[0x00].walkMovement == 0x00)) &&
		PersistentUnitRoster[LastAttackingUnitIndex].damageModel ==
			UNIT_DAMAGE_MODEL_BATTLEMECH)
	{
		CampaignFlags |= 0x0004;
	}
	while (DigitalSoundBusy != 0x00)
		;
}

// 1A1F:10CD: void LoadUnitTemplateRecord(short unitType)
// VERIFIED from assembly: unitType is the sole stack argument at BP+06. SI is
// assigned the opened file handle inside this routine and is not an argument.
// The routine reads exactly one 0x96-byte template into DS:84C7.
void LoadUnitTemplateRecord(int16 unitType)
{
	char *templatePath = (char *)MAKE_FAR_POINTER(
		UnitTemplatePathSegment,
		UnitTemplatePathOffset);
	int16 fileHandle = OpenTrackedFile(templatePath, 0x01);
	int32 fileOffset = (int32)unitType * UNIT_RECORD_SIZE;

	SeekTrackedFile(fileHandle, fileOffset, 0x00);
	ReadTrackedFile(
		fileHandle,
		&EstimatedUnitRecord,
		UNIT_RECORD_SIZE);
	CloseTrackedFile(fileHandle);
}

// 1A1F:1132: void InitializeTacticalUnitRuntime(void)
// Verified against 1A1F:1132-11F6.
void InitializeTacticalUnitRuntime(void)
{
	word16 unitIndex;
	word16 deployedUnitCount;

	UnitTypeResourceCode[0x04] = 0xED;
	TacticalSlotSpriteState[0x04] = 0x00;
	for (unitIndex = 0x00; unitIndex < 0x04; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord =
			&PersistentUnitRoster[unitIndex];
		TacticalSlotSpriteState[unitIndex] = 0x00;
		if (unitRecord->deploymentState == 0x00)
		{
			UnitTypeResourceCode[unitIndex] = 0x00;
			TacticalSlotSpriteState[unitIndex] = 0x06;
		}
	}

	if (TacticalScenarioLanceEnabled[0x01] != 0x00)
	{
		ScenarioDestructionCompletionState = 0x00;
		deployedUnitCount = 0x00;
		for (unitIndex = 0x04; unitIndex < 0x08; ++unitIndex)
		{
			RevengeUnitRecord *unitRecord =
				&PersistentUnitRoster[unitIndex];
			if (unitRecord->deploymentState != 0x00)
				++deployedUnitCount;
		}
		if (deployedUnitCount == 0x00)
		{
			UnitTypeResourceCode[0x05] = 0x00;
			ScenarioDestructionCompletionState = 0x06;
		}
	}

	if (TacticalScenarioLanceEnabled[0x02] != 0x00)
	{
		TacticalSlotSpriteState[0x06] = 0x00;
		deployedUnitCount = 0x00;
		for (unitIndex = 0x08; unitIndex < 0x0C; ++unitIndex)
		{
			RevengeUnitRecord *unitRecord =
				&PersistentUnitRoster[unitIndex];
			if (unitRecord->deploymentState != 0x00)
				++deployedUnitCount;
		}
		if (deployedUnitCount == 0x00)
		{
			UnitTypeResourceCode[0x06] = 0x00;
			TacticalSlotSpriteState[0x06] = 0x06;
		}
	}

	if (TacticalScenarioLanceEnabled[0x00] != 0x00)
		PrimaryLanceResourceCode = 0xEB;
}

// 1A1F:18C9: void OffsetWeaponTraceEndpoint(
//     int16 *sourceX, int16 *sourceY,
//     int16 *targetX, int16 *targetY)
// Verified against 1A1F:18C9-19FC.
void OffsetWeaponTraceEndpoint(
	int16 *sourceX,
	int16 *sourceY,
	int16 *targetX,
	int16 *targetY)
{
	int16 deltaY = (int16)(word16)((word16)*targetY - (word16)*sourceY);
	int16 deltaX = (int16)(word16)((word16)*sourceX - (word16)*targetX);
	word16 octant = DetermineOctant(deltaY, deltaX);

	switch (octant)
	{
	case 0x00:
	case 0x07:
		*targetX = InterpolateLineCoordinate(
			(int16)(word16)((word16)*targetY - 0x0008),
			*targetY, *sourceX, *targetX, *sourceY);
		*targetY = (int16)(word16)((word16)*targetY - 0x0008);
		break;

	case 0x01:
	case 0x02:
		*targetY = InterpolateLineCoordinate(
			(int16)(word16)((word16)*targetX + 0x0007),
			*targetX, *sourceY, *targetY, *sourceX);
		*targetX = (int16)(word16)((word16)*targetX + 0x0007);
		break;

	case 0x03:
	case 0x04:
		*targetX = InterpolateLineCoordinate(
			(int16)(word16)((word16)*targetY + 0x0007),
			*targetY, *sourceX, *targetX, *sourceY);
		*targetY = (int16)(word16)((word16)*targetY + 0x0007);
		break;

	case 0x05:
	case 0x06:
		*targetY = InterpolateLineCoordinate(
			(int16)(word16)((word16)*targetX - 0x0008),
			*targetX, *sourceY, *targetY, *sourceX);
		*targetX = (int16)(word16)((word16)*targetX - 0x0008);
		break;
	}
}

// 1A1F:19FD: void CreateRandomAreaImpact(
//     short centerX, short centerY, word16 chanceDenominator)
// Verified against 1A1F:19FD-1A82.
void CreateRandomAreaImpact(
	int16 centerX,
	int16 centerY,
	word16 chanceDenominator)
{
	if (RandomInRangeInclusive(0x01, chanceDenominator)
		!= chanceDenominator)
	{
		return;
	}

	int16 mapX = centerX + RandomInRangeInclusive(0x00, 0x03) - 0x02;
	int16 mapY = centerY + RandomInRangeInclusive(0x00, 0x03) - 0x02;
	if (mapX < 0x00)
		mapX = 0x00;
	if (mapY < 0x00)
		mapY = 0x00;
	if (mapX >= MapWidth)
		mapX = MapWidth - 0x01;
	if (mapY >= MapHeight)
		mapY = MapHeight - 0x01;

	ApplyAreaTerrainAndUnitDamage(
		mapX,
		mapY,
		0x01,
		(GeneratePseudoRandomByte() & 0x07) + 0x03);
}

// 1A1F:1A83: void AdvanceScenarioAreaEffects(void)
// Verified against 1A1F:1A83-1C26.
void AdvanceScenarioAreaEffects(void)
{
	int16 direction;
	int16 mapX;
	int16 mapY;

	if (ArtilleryShellingActive != 0x00)
	{
		CreateRandomAreaImpact(
			ArtilleryTargetMapX,
			ArtilleryTargetMapY,
			ArtillerySupportAvailable);
	}

	if (RollingBarrageActive != 0x00)
	{
		CreateRandomAreaImpact(
			RollingBarrageStartMapX,
			RollingBarrageStartMapY,
			ArtillerySupportAvailable);
		if (RollingBarrageStartMapX == RollingBarrageEndMapX
			&& RollingBarrageStartMapY == RollingBarrageEndMapY)
		{
			RollingBarrageStartMapX = ArtilleryTargetMapX;
			RollingBarrageStartMapY = ArtilleryTargetMapY;
		}
		else
		{
			direction = (int16)DetermineRelativeAttackDirection(
				RollingBarrageStartMapX,
				RollingBarrageStartMapY,
				RollingBarrageEndMapX,
				RollingBarrageEndMapY);
			if (direction >= 0x00 && direction <= 0x07)
			{
				if (RollingBarrageStartMapX != RollingBarrageEndMapX)
				{
					RollingBarrageStartMapX +=
						(byte)DirectionDeltaXTable[direction];
				}
				if (RollingBarrageStartMapY != RollingBarrageEndMapY)
				{
					RollingBarrageStartMapY +=
						(byte)DirectionDeltaYTable[direction];
				}
			}
		}
	}

	if (StrafingRunActive == 0x00
		|| MapEdgeEffectCount != 0x00
		|| RandomInRangeInclusive(0x00, StrafingSupportAvailable) == 0x00)
	{
		return;
	}

	direction = (int16)(GeneratePseudoRandomByte() & 0x03);
	switch (direction)
	{
	case 0x00:
		mapX = (int16)(word16)(RollingBarrageEndMapX
			+ (GeneratePseudoRandomByte() & 0x03) - 0x02);
		mapY = (int16)(word16)(MapHeight + 0x01);
		break;

	case 0x01:
		mapX = -0x01;
		mapY = (int16)(word16)(RollingBarrageEndMapY
			+ (GeneratePseudoRandomByte() & 0x03) - 0x02);
		break;

	case 0x02:
		mapX = (int16)(word16)(RollingBarrageEndMapX
			+ (GeneratePseudoRandomByte() & 0x03) - 0x02);
		mapY = -0x01;
		break;

	default:
		mapX = (int16)(word16)(MapWidth + 0x01);
		mapY = (int16)(word16)(RollingBarrageEndMapY
			+ (GeneratePseudoRandomByte() & 0x03) - 0x02);
		break;
	}
	QueueMapEdgeEffect(mapX, mapY, 0x01C0, (word16)direction);
}



