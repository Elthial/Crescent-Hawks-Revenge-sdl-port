// REVENGE_1A1F_SCENARIO_RUNTIME.c
// Procedures preserved from REVENGE_1A1F_SCENARIO.c.

#include "REVENGE_1A1F_INTERNAL.h"

// 1A1F:1C27
word16 IsTacticalFunctionKey(int16 inputAction)
{
	if (TacticalOverviewActive != FALSE)
		return FALSE;
	return inputAction >= TranslatedExtendedKey(KEY_F10) &&
		inputAction <= TranslatedExtendedKey(KEY_F1);
}

// 1A1F:1C48: load the complete tactical scenario resource stream.
// Verified against ASM 1A1F:1C48-2A4D. The two scenario
// switches, cursor advances, unit-record copies, and DGROUP side effects are
// intentionally kept in this original executable boundary.
void LoadTacticalScenarioResources(byte scenarioCode)
{
	SceneFileHeader *sceneHeader;
	byte *scenarioData;
	byte *cursor;
	char *scenarioPath;
	SceneUnitRoute *routeRecord;
	RevengeUnitRecord *unitRecord;
	int16 fileHandle;
	int16 scenarioSize;
	word16 unitIndex;
	word16 recordIndex;
	word16 scenarioCase;
	word16 spriteFacing;
	byte terrainEffectMode;
	byte value;

#define COPY_SCENARIO_RECORD(sourceIndex, destinationIndex) \
	(PersistentUnitRoster[(destinationIndex)] = \
		LiveScenarioUnits[(sourceIndex)])

	TacticalCursorOutlineEnabled = 0x0001;
	TacticalUiSuppressed = 0x0000;
	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		ScenarioUnitMapX[unitIndex] =
			SavedScenarioUnitMapX[unitIndex];
		ScenarioUnitMapY[unitIndex] =
			SavedScenarioUnitMapY[unitIndex];
		PersistentUnitRoster[unitIndex] = BlankUnitRecord;

		ScenarioUnitNeedsUpdate[unitIndex] = 0x00;
		UnitWasAttackedThisTick[unitIndex] = 0x00;
		UnitFormationMode[unitIndex] = 0x00;
		UnitBelowHalfDurability[unitIndex] = 0x00;
		UnitDestructionMarkers[unitIndex][0x02] = 0x00;
		UnitWithdrawalState[unitIndex] = 0x00;
		UnitShutdownState[unitIndex] = 0x00;
		UnitJumpMovementRemaining[unitIndex] = 0x00;
		UnitJumpingState[unitIndex] = 0x00;
		UnitOverburnOrCloseAssaultEnabled[unitIndex] = 0x00;
		UnitEnemyEngagementActive[unitIndex] = 0x00;
		UnitEnemyInProximityRange[unitIndex] = 0x00;
		UnitEnemyVisible[unitIndex] = 0x00;
		UnitEnemyContactEstablished[unitIndex] = 0x00;
		UnitTargetMapY[unitIndex] = 0xFF;
		UnitTargetMapX[unitIndex] = 0xFF;
		UnitAttackTarget[unitIndex] = TACTICAL_TARGET_NONE;
		UnitTacticalTarget[unitIndex] = TACTICAL_TARGET_NONE;
	}

	MapEdgeEffectCount = 0x0000;
	StrafingRunActive = 0x00;
	RollingBarrageActive = 0x00;
	ArtilleryShellingActive = 0x00;
	for (recordIndex = 0x0000; recordIndex < 0x000C; ++recordIndex)
		UnitLastNarratedTarget[recordIndex] = TACTICAL_TARGET_NONE;
	for (recordIndex = 0x0000; recordIndex < 0x0009; ++recordIndex)
	{
		TacticalStatusRowInvalidation[recordIndex] = 0xFF;
		TacticalSlotSpriteState[recordIndex] = 0x00;
	}
	for (recordIndex = 0x0000; recordIndex < 0x0006; ++recordIndex)
		TacticalResourceSlotState[recordIndex] = 0x00;

	EnemyCycleUnitIndex = 0xFFFF;
	TacticalSelectedUnitIndex = 0xFFFF;
	TacticalBattleResult = 0x0000;
	TacticalProjectileCount = 0x0000;
	MapEdgeEffectCount = 0x0000;
	TacticalImpactQueueCount = 0x0000;
	TacticalOverviewClockNoticeActive = 0x0000;
	PendingNarrationDelay = 0x0000;
	TacticalOverviewActive = 0x0000;
	TacticalOverviewViewportDirty = 0x0000;
	TacticalRuntimeState = 0x0000;
	CampaignFlags = 0x0000;
	FirstLanceOrdersEnabled = 0x0001;
	for (recordIndex = 0x0000; recordIndex < 0x005A; ++recordIndex)
	{
		TerrainImpactAnimationRecords[recordIndex].mapX = -0x01;
		TerrainImpactAnimationRecords[recordIndex].mapY = -0x01;
	}

	scenarioPath = ScenarioResourcePathText;
	scenarioPath[0x05] = scenarioCode;
	fileHandle = OpenTrackedFile(scenarioPath, 0x0001);
	scenarioData = LoadedSceneFile.raw;
	ReadTrackedFile(fileHandle, scenarioData, 0x00000002UL);
	scenarioSize = (int16)(word16)(scenarioData[0x00] |
		((word16)scenarioData[0x01] << 0x08));
	if (scenarioSize > 0x07FE)
	{
		DrawTileAlignedText(
			SceneFileTooLargeText, 0x0000, 0x0000, 0x0F, 0x00);
		ReadTranslatedKeypress();
		scenarioSize = 0x07FE;
	}
	ReadTrackedFile(fileHandle, scenarioData + 0x02, (uint32)(int32)scenarioSize);
	CloseTrackedFile(fileHandle);

	sceneHeader = &LoadedSceneFile.header;
	SceneInstructionBaseOffset =
		(word16)(sceneHeader->instructionBlockOffset + 0x0002);
	for (recordIndex = 0x0000; recordIndex < SCENE_LANCE_COUNT; ++recordIndex)
		TacticalScenarioLanceEnabled[recordIndex] =
			sceneHeader->lanceEnabled[recordIndex];
	for (recordIndex = 0x0000; recordIndex < 0x0007; ++recordIndex)
		UnitTypeResourceCode[recordIndex] =
			sceneHeader->initialUnitResourceCode[recordIndex];
	ArtillerySupportAvailable = sceneHeader->artillerySupportAvailable;
	StrafingSupportAvailable = sceneHeader->strafingSupportAvailable;
	TacticalOverviewNoticeChance = sceneHeader->overviewNoticeChance;
	TacticalOverviewActive = 0x0000;
	TacticalOverviewRuntimeState = 0x0000;
	TacticalCursorRuntimeState = 0x0000;
	TacticalOverviewClockNoticeActive = 0x0000;
	LastOverviewNoticeHour = 0x0000;
	TerrainLineOfSightMaximumSteps =
		sceneHeader->lineOfSightMaximumSteps;
	TacticalTerrainEffectMode = sceneHeader->terrainEffectMode;
	terrainEffectMode = sceneHeader->terrainDamageCapabilityMode;
	BuildScenarioTerrainDamageCapabilityMap(terrainEffectMode);
	TacticalOverviewMapMode = sceneHeader->overviewMapMode;
	for (recordIndex = 0x0000; recordIndex < 0x0006; ++recordIndex)
		LanceFormationProfile[recordIndex] =
			sceneHeader->lanceFormationProfile[recordIndex];

	scenarioCase = (word16)(ScenarioFileSuffix - 0x0032);
	switch (scenarioCase)
	{
	case 0x0000:
		COPY_SCENARIO_RECORD(0x00, 0x00);
		COPY_SCENARIO_RECORD(0x01, 0x01);
		break;
	case 0x0001:
		for (unitIndex = 0x0000; unitIndex < 0x0003; ++unitIndex)
		{
			if (unitIndex != 0x0002)
				COPY_SCENARIO_RECORD(unitIndex, unitIndex);
			else
				COPY_SCENARIO_RECORD(0x05, 0x02);
			COPY_SCENARIO_RECORD(unitIndex + 0x000D, unitIndex + 0x000D);
		}
		StoryUnitDeployedFlag = 0x00;
		EjectedPilotRosterState = 0x0000;
		break;
	case 0x0002:
	case 0x0004:
		for (unitIndex = 0x0000; unitIndex < 0x0003; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
		break;
	case 0x0006:
		for (unitIndex = 0x0000; unitIndex < 0x0003; ++unitIndex)
		{
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
			COPY_SCENARIO_RECORD(unitIndex + 0x0015, unitIndex + 0x0015);
		}
		break;
	case 0x0007:
		COPY_SCENARIO_RECORD(0x03, 0x00);
		COPY_SCENARIO_RECORD(0x04, 0x01);
		for (unitIndex = 0x0000; unitIndex < 0x0003; ++unitIndex)
		{
			COPY_SCENARIO_RECORD(unitIndex, unitIndex + 0x0004);
			COPY_SCENARIO_RECORD(unitIndex + 0x0015, unitIndex + 0x0015);
		}
		break;
	case 0x000F:
		for (unitIndex = 0x0000; unitIndex < 0x0003; ++unitIndex)
		{
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
			COPY_SCENARIO_RECORD(unitIndex + 0x0015, unitIndex + 0x0015);
		}
		COPY_SCENARIO_RECORD(0x03, 0x03);
		break;
	case 0x0010:
	case 0x0011:
	case 0x0012:
	case 0x0013:
	case 0x0014:
	case 0x0015:
	case 0x0016:
	case 0x0017:
	case 0x0018:
	case 0x0019:
	case 0x001B:
	case 0x001C:
		for (unitIndex = 0x0000; unitIndex < 0x000C; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
		break;
	case 0x001A:
		for (unitIndex = 0x0000; unitIndex < 0x0004; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
		break;
	case 0x001D:
		for (unitIndex = 0x0000; unitIndex < 0x0004; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex + 0x0008, unitIndex + 0x0004);
		break;
	case 0x001E:
		for (unitIndex = 0x0000; unitIndex < 0x0004; ++unitIndex)
		{
			COPY_SCENARIO_RECORD(unitIndex + 0x000C, unitIndex);
			COPY_SCENARIO_RECORD(unitIndex + 0x0008, unitIndex + 0x0004);
		}
		break;
	case 0x001F:
	case 0x0020:
		for (unitIndex = 0x0000; unitIndex < 0x0008; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
		for (unitIndex = 0x0008; unitIndex < 0x000C; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex + 0x0004, unitIndex);
		break;
	case 0x0021:
		for (unitIndex = 0x0000; unitIndex < 0x0008; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
		break;
	case 0x0022:
	case 0x0023:
		for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
			COPY_SCENARIO_RECORD(unitIndex, unitIndex);
		break;
	default:
		break;
	}

	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		value = sceneHeader->unitType[unitIndex];
		unitRecord = &PersistentUnitRoster[unitIndex];
		if (value < 0xFE)
			InitializeScenarioUnitFromTemplate(value, unitIndex);
		else if (unitRecord->deploymentState != 0x00)
			InitializeScenarioUnitFromTemplate(0xFFFF, unitIndex);
	}

	scenarioCase = (word16)(ScenarioFileSuffix - 0x0031);
	switch (scenarioCase)
	{
	case 0x0000:
		AssignScenarioLanceAllegiances(0x0000);
		break;
	case 0x0001:
	case 0x0003:
	case 0x0010:
	case 0x0015:
	case 0x0016:
	case 0x0017:
	case 0x0018:
	case 0x0019:
	case 0x001A:
	case 0x001B:
	case 0x001C:
	case 0x001D:
		AssignScenarioLanceAllegiances(0x0001);
		break;
	case 0x0002:
		if (ScenarioUnitThirteenEnabled != 0x0000)
		{
			PersistentUnitRoster[0x0D].deploymentState = 0x01;
			InitializeScenarioUnitFromTemplate(0xFFFF, 0x000D);
		}
		else
		{
			LiveScenarioUnits[0x0D] = BlankUnitRecord;
			COPY_SCENARIO_RECORD(0x0D, 0x0D);
		}
		if (ScenarioUnitFourteenEnabled != 0x0000)
		{
			PersistentUnitRoster[0x0E].deploymentState = 0x01;
			InitializeScenarioUnitFromTemplate(0xFFFF, 0x000E);
		}
		else
		{
			LiveScenarioUnits[0x0E] = BlankUnitRecord;
			COPY_SCENARIO_RECORD(0x0E, 0x0E);
		}
		if ((word16)ScenarioUnitFifteenState != 0x0000)
		{
			PersistentUnitRoster[0x0F].deploymentState = 0x01;
			InitializeScenarioUnitFromTemplate(0xFFFF, 0x000F);
		}
		else
		{
			LiveScenarioUnits[0x0F] = BlankUnitRecord;
			COPY_SCENARIO_RECORD(0x0F, 0x0F);
		}
		AssignScenarioLanceAllegiances(0x0001);
		break;
	case 0x0004:
		if (CampaignScenarioState != 0x0000)
		{
			InitializeScenarioUnitFromTemplate(0x003F, 0x000F);
			InitializeScenarioUnitFromTemplate(0x003F, 0x0013);
			InitializeScenarioUnitFromTemplate(0x003F, 0x0017);
		}
		AssignScenarioLanceAllegiances(0x0001);
		break;
	case 0x0005:
	case 0x0006:
	case 0x0007:
		AssignScenarioLanceAllegiances(0x0002);
		ApplyScenarioMissileUpgradeAvailability();
		break;
	case 0x0008:
		AssignScenarioLanceAllegiances(0x0003);
		ApplyScenarioMissileUpgradeAvailability();
		break;
	case 0x0011:
	case 0x0012:
	case 0x0013:
	case 0x0014:
	case 0x0023:
		AssignScenarioLanceAllegiances(0x0004);
		break;
	case 0x001E:
	case 0x001F:
	case 0x0020:
	case 0x0021:
	case 0x0022:
		AssignScenarioLanceAllegiances(0x0006);
		break;
	default:
		break;
	}

	for (unitIndex = 0x0000; unitIndex < 0x000C; ++unitIndex)
	{
		if (sceneHeader->friendlyMapX[unitIndex] != 0xFF)
			ScenarioUnitMapX[unitIndex] =
				sceneHeader->friendlyMapX[unitIndex];
		if (sceneHeader->friendlyMapY[unitIndex] != 0xFF)
			ScenarioUnitMapY[unitIndex] =
				sceneHeader->friendlyMapY[unitIndex];
		if (sceneHeader->enemyMapX[unitIndex] != 0xFF)
			ScenarioUnitMapX[0x0C + unitIndex] =
				sceneHeader->enemyMapX[unitIndex];
		if (sceneHeader->enemyMapY[unitIndex] != 0xFF)
			ScenarioUnitMapY[0x0C + unitIndex] =
				sceneHeader->enemyMapY[unitIndex];
	}

	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		value = ScenarioUnitMapX[unitIndex];
		UnitRouteTargetMapX[unitIndex] = value;
		routeRecord = &SceneUnitRoutes[unitIndex];
		routeRecord->waypointMapX[0x03] = value;
		routeRecord->waypointMapX[0x02] = value;
		routeRecord->waypointMapX[0x01] = value;
		routeRecord->waypointMapX[0x00] = value;
		routeRecord->activeMapX = value;
		value = ScenarioUnitMapY[unitIndex];
		UnitRouteTargetMapY[unitIndex] = value;
		routeRecord->waypointMapY[0x03] = value;
		routeRecord->waypointMapY[0x02] = value;
		routeRecord->waypointMapY[0x01] = value;
		routeRecord->waypointMapY[0x00] = value;
		routeRecord->activeMapY = value;
	}

	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		value = sceneHeader->unitFacing[unitIndex] & 0x07;
		ScenarioUnitFacing[unitIndex] = value;
		if (value == 0x00)
			spriteFacing = 0x0000;
		else if (value <= 0x03)
			spriteFacing = 0x0001;
		else if (value == 0x04)
			spriteFacing = 0x0002;
		else
			spriteFacing = 0x0003;
		UpdateUnitSpriteForFacing(unitIndex, spriteFacing);
	}

	for (unitIndex = 0x0000; unitIndex < 0x000C; ++unitIndex)
	{
		value = sceneHeader->friendlyPilotRosterSlot[unitIndex];
		if (value != 0xFF)
			AssignPilotRosterEntryToUnit(unitIndex, value);
	}
	cursor = scenarioData + sizeof(SceneFileHeader);

	if (ScenarioFileSuffix == 0x0042 &&
		ScenarioVariantIndex != 0x0000)
	{
		for (unitIndex = 0x0000; unitIndex < 0x000C; ++unitIndex)
		{
			value = (byte)(UnitRouteTargetMapY[unitIndex] + 0xCC);
			UnitRouteTargetMapY[unitIndex] = value;
			ScenarioUnitMapY[unitIndex] = value;
			routeRecord = &SceneUnitRoutes[unitIndex];
			routeRecord->waypointMapY[0x03] = value;
			routeRecord->waypointMapY[0x02] = value;
			routeRecord->waypointMapY[0x01] = value;
			routeRecord->waypointMapY[0x00] = value;
			routeRecord->activeMapY = value;
			value = (byte)(UnitRouteTargetMapX[unitIndex] + 0x0D);
			UnitRouteTargetMapX[unitIndex] = value;
			ScenarioUnitMapX[unitIndex] = value;
			routeRecord->waypointMapX[0x03] = value;
			routeRecord->waypointMapX[0x02] = value;
			routeRecord->waypointMapX[0x01] = value;
			routeRecord->waypointMapX[0x00] = value;
			routeRecord->activeMapX = value;
		}
	}

	LoadTacticalMap(TacticalTerrainEffectMode);
	LoadTacticalIconSetResources(terrainEffectMode);
	SceneInstructionCursor.segment = FAR_SEGMENT(cursor);
	SceneInstructionCursor.offset = FAR_OFFSET(cursor);
	ExecuteSceneInstructions();
	TacticalSelectedUnitIndex = 0x0000;
	if (TacticalSelectedUnitIndex != 0xFFFF)
	{
		TacticalCursorMapY = 0x0005;
		TacticalCursorMapX = 0x0005;
	}
	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
		UnitLanceFormationState[unitIndex] =
			(byte)IsCurrentLanceLeader(unitIndex);
	SuppressCampaignClock = 0x0000;
	for (unitIndex = 0x0000; unitIndex < 0x0004; ++unitIndex)
	{
		unitRecord = &PersistentUnitRoster[unitIndex];
		if (unitRecord->deploymentState != 0x00)
			PrepareUnitTypeResources(unitIndex);
		else
			UnitTypeResourceCode[unitIndex] = 0x00;
	}
	if (TacticalTerrainEffectMode == 0x00 &&
		ScenarioFileSuffix != 0x0031)
	{
		for (recordIndex = 0x0039; recordIndex <= 0x003D; ++recordIndex)
		{
			for (unitIndex = 0x000D; unitIndex <= 0x0011; ++unitIndex)
			{
				TerrainTypeMap[
					recordIndex * MapWidth + unitIndex] =
					DestructibleTerrainTypeBase;
			}
		}
	}
	if (ScenarioFileSuffix == 0x0054)
	{
		for (recordIndex = 0x005B; recordIndex <= 0x005D; ++recordIndex)
		{
			for (unitIndex = 0x0036; unitIndex <= 0x0037; ++unitIndex)
			{
				word16 damagePass;
				for (damagePass = 0x0000; damagePass < 0x0003; ++damagePass)
					AdvanceTerrainDamageState(
						unitIndex, recordIndex, 0x0003);
			}
		}
	}

#undef COPY_SCENARIO_RECORD
}

