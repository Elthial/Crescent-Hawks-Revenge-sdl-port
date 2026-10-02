// REVENGE_2D1B_DAMAGE.c
// Procedures preserved from REVENGE_2D1B_TACTICAL_COMBAT.c.

#include "REVENGE_2D1B_INTERNAL.h"

// 2D1B:2453: void DestroyScenarioUnit(word16 unitIndex)
// Called from:
//      ApplyWeaponDamage
void DestroyScenarioUnit(word16 unitIndex)
{
	RevengeUnitRecord *unit;
	byte *destructionMarker;
	word16 wasCurrentLanceLeader;
	word16 attackerIndex;

	// Verified against 2D1B:2453-256A.
	wasCurrentLanceLeader = IsCurrentLanceLeader(unitIndex);
	unit = &PersistentUnitRoster[unitIndex];
	unit->deploymentState = 0x00;

	if (TacticalSelectedUnitIndex == unitIndex)
		TacticalSelectedUnitIndex = 0xFFFF;
	if (EnemyCycleUnitIndex == unitIndex)
		EnemyCycleUnitIndex = 0xFFFF;

	for (attackerIndex = 0x00; attackerIndex < TACTICAL_UNIT_COUNT;
		++attackerIndex)
	{
		if (UnitAttackTarget[attackerIndex]
			== (int16) unitIndex)
			UnitAttackTarget[attackerIndex] = TACTICAL_TARGET_NONE;
	}

	destructionMarker = UnitDestructionMarkers[unitIndex];
	destructionMarker[0x00] = ScenarioUnitMapX[unitIndex];
	destructionMarker[0x01] = ScenarioUnitMapY[unitIndex];
	destructionMarker[0x02] = 0xDD;

	PendingNarrationDelay = 0x025D;
	NarrationMessageCategory = 0x0009;
	NarrationEmphasis = 0x0000;
	NarrationSourceUnit = unitIndex;
	if ((int16)unitIndex < ENEMY_FORCE_FIRST_UNIT)
	{
		FriendlyUnitDestroyed = 0x0001;
		NarrationEmphasis = 0x0001;
		NarrationMessageCategory = 0x0012;
		ActiveNarrationSubject = unitIndex;
		destructionMarker[0x02] = 0xDC;
	}

	if (wasCurrentLanceLeader != 0x00)
	{
		// V: the original executable masks the boolean result, not unitIndex.
		// Consequently this always passes lance base zero when the predicate is true.
		RebuildLanceFormationAfterLeaderLoss(wasCurrentLanceLeader & 0x000C);
	}
	DispatchWeaponEffect(0x04);

	if (unitIndex == 0x08 && ScenarioFileSuffix == 0x4C)
	{
		// H: SCENEL destruction completion state. These are write-only in the
		// recovered executable, so retain their offsets until a script-side
		// consumer or presentation meaning is observed.
		ScenarioDestructionCompletionState = 0x03;
		ScenarioDestructionCompletionMarker = 0xFF;
	}
}

// 2D1B:2A30: word16 FindOperationalLanceLeader(word16 unitIndex)
// Called from:
//      RebuildLanceFormationAfterLeaderLoss
word16 FindOperationalLanceLeader(word16 unitIndex)
{
	// Verified against 2D1B:2A30-2AA5. The executable initializes its proposed
	// occupied-unit fallback to FFFFh but compares it with 00FFh, so that
	// fallback is never populated or returned. Preserve the resulting behavior:
	// return the first deployed, mobile member, or FFFFh.
	word16 lanceBaseUnitIndex = unitIndex & 0x001C;
	word16 lanceOffset;

	for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
	{
		word16 candidateUnitIndex = lanceBaseUnitIndex + lanceOffset;
		RevengeUnitRecord *candidateUnit =
			&PersistentUnitRoster[candidateUnitIndex];

		if (candidateUnit->deploymentState == 0x00)
			continue;
		if (candidateUnit->walkMovement != 0x00)
			return candidateUnitIndex;
	}

	return 0xFFFF;
}

// 2D1B:2CB4: word16 ShouldDestroyUnitAfterLegLoss(void)
// Called from:
//      ApplyWeaponDamage
word16 ShouldDestroyUnitAfterLegLoss(void)
{
	// PROPOSED NAME: exact scenario-suffix predicate is verified, but why these
	// missions remove an immobilized unit immediately needs a scenario trace.
	int16 scenarioSuffix = (int16)ScenarioFileSuffix;
	return (scenarioSuffix >= 0x36 && scenarioSuffix <= 0x39)
		|| (scenarioSuffix >= 0x42 && scenarioSuffix <= 0x43)
		|| scenarioSuffix == 0x45
		|| (scenarioSuffix >= 0x4C && scenarioSuffix <= 0x53);
}

// 2D1B:2604: rebuild arm-mounted weapon counts and the per-unit availability
// mask, excluding destroyed equipment and ammunition weapons with no rounds.
// Verified against 2D1B:2604-276E.
void BuildArmWeaponAvailabilityMasks(word16 unitIndex)
{
	RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
	word16 *weaponCounts = WeaponCountScratch;
	uint32 weaponBit = 0x00000001UL;
	word16 slotIndex;
	word16 weaponIndex;

	for (weaponIndex = 0x00; weaponIndex < WEAPON_DEFINITION_COUNT; ++weaponIndex)
		weaponCounts[weaponIndex] = 0x00;

	// V: the assembly intentionally scans only the eight left-arm and eight
	// right-arm equipment slots, rather than the complete unit record.
	for (slotIndex = 0x00; slotIndex < 0x08; ++slotIndex)
	{
		byte leftWeapon = unitRecord->leftArmEquipment[slotIndex];
		byte rightWeapon = unitRecord->rightArmEquipment[slotIndex];
		if (leftWeapon != EQUIPMENT_SLOT_EMPTY
			&& (leftWeapon & EQUIPMENT_DAMAGED_FLAG) == 0x00
			&& leftWeapon <= WEAPON_DEFINITION_COUNT)
		{
			++weaponCounts[WEAPON_INDEX_FROM_EQUIPMENT_ID(leftWeapon)];
		}
		if (rightWeapon != EQUIPMENT_SLOT_EMPTY
			&& (rightWeapon & EQUIPMENT_DAMAGED_FLAG) == 0x00
			&& rightWeapon <= WEAPON_DEFINITION_COUNT)
		{
			++weaponCounts[WEAPON_INDEX_FROM_EQUIPMENT_ID(rightWeapon)];
		}
	}

	UnitWeaponAvailabilityMask[unitIndex] = 0x00000000UL;
	for (weaponIndex = 0x00; weaponIndex < WEAPON_DEFINITION_COUNT; ++weaponIndex)
	{
		if (weaponCounts[weaponIndex] != 0x00)
		{
			const RevengeWeaponDefinition *weaponDefinition =
				&WeaponDefinitions[weaponIndex];
			int16 ammunitionFamily =
				weaponDefinition->ammunitionFamilyId;
			word16 ammunitionRemaining = ammunitionFamily == AMMUNITION_NONE
				? 0x01
				: unitRecord->currentAmmunition[
					AMMUNITION_INDEX(ammunitionFamily)];

			if (ammunitionRemaining != 0x00)
				UnitWeaponAvailabilityMask[unitIndex] |= weaponBit;
		}
		weaponBit <<= 0x01;
	}
}

// 2D1B:256B: byte UpdateUnitHeatShutdown(word16 unitIndex)
// Return one when the unit fails its heat shutdown check. Current heat is the
// integer byte of the Q8.8 accumulator and is capped at 30 for this test.
// Verified against 2D1B:256B-2603.
byte UpdateUnitHeatShutdown(word16 unitIndex)
{
	RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
	word16 currentHeat = unitRecord->currentHeat;
	if (currentHeat > BATTLEMECH_MAXIMUM_HEAT)
		currentHeat = BATTLEMECH_MAXIMUM_HEAT;

	word16 shutdownTriggered = TRUE;
	if (currentHeat < BATTLEMECH_SHUTDOWN_HEAT_MINIMUM)
		shutdownTriggered = FALSE;
	else
	{
		word16 shutdownTarget =
			((currentHeat - BATTLEMECH_SHUTDOWN_HEAT_MINIMUM) >> 0x01)
				+ 0x04;
		if ((int16)Roll2D6() >= (int16)shutdownTarget)
			shutdownTriggered = FALSE;
		else
		{
			UnitOverburnOrCloseAssaultEnabled[unitIndex] = FALSE;
			UnitShutdownState[unitIndex] = TRUE;
		}
	}

	// This assembly branch is retained exactly even though setting shutdown
	// state above makes it unreachable for a newly failed check.
	if (unitIndex < ENEMY_FORCE_FIRST_UNIT
		&& IsCurrentLanceLeader(unitIndex) != FALSE
		&& shutdownTriggered != FALSE
		&& UnitShutdownState[unitIndex] == FALSE)
	{
		PendingNarrationDelay = 0x025D;
		ActiveNarrationSubject = unitIndex;
		NarrationEmphasis = TRUE;
		NarrationMessageCategory = 0x01;
	}

	return (byte) shutdownTriggered;
}

#define TERRAIN_IMPACT_RECORD_COUNT 0x5A
#define TERRAIN_IMPACT_UNUSED_X     (-1)

// 2D1B:276F: void ApplyTerrainImpact(
//     int16 mapX, int16 mapY, word16 advanceBeforeRecording,
//     word16 forceAnimationRecord)
//
// Advance one valid, nonterminal terrain cell and optionally allocate one of
// the 90 six-byte animation records at DS:810C. Records are deduplicated by
// coordinate and use mapX == FFFFh as the free sentinel. The apparent AX result
// in older Reko output is incidental; every caller either discards it or reads
// the packed terrain state immediately afterward.
// Verified against 2D1B:276F-296E.
void ApplyTerrainImpact(
	int16 mapX,
	int16 mapY,
	word16 advanceBeforeRecording,
	word16 forceAnimationRecord)
{
	RevengeTerrainImpactAnimationRecord *impactRecords;
	RevengeTerrainImpactAnimationRecord *record;
	int16 previousDamageState;
	int16 recordIndex;
	word16 collapsibleStructure;
	word16 shouldRecordImpact;
	word16 terrainType;

	previousDamageState = (int16) ReadTerrainDamageState(mapX, mapY);
	impactRecords = TerrainImpactAnimationRecords;

	if (mapX < 0x0000 || mapX >= (int16) MapWidth
		|| mapY < 0x0000 || mapY >= (int16) MapHeight
		|| previousDamageState >= 0x0003)
	{
		return;
	}

	if (advanceBeforeRecording != FALSE)
		AdvanceTerrainDamageState(mapX, mapY, 0x03);

	terrainType = TerrainTypeMap[
		(word16) mapY * MapWidth + (word16) mapX];
	shouldRecordImpact = FALSE;
	if (terrainType >= TerrainImpactAnimationTypeMinimum
		&& terrainType <= TerrainImpactAnimationTypeMaximum)
	{
		// Preserve the executable's random draw even when forceAnimationRecord
		// is already true.
		if ((GeneratePseudoRandomByte() & 0x01) != 0x00)
			shouldRecordImpact = TRUE;
	}

	if (shouldRecordImpact != FALSE || forceAnimationRecord != FALSE)
	{
		for (recordIndex = 0x0000;
			recordIndex < TERRAIN_IMPACT_RECORD_COUNT;
			++recordIndex)
		{
			if (impactRecords[recordIndex].mapX == mapX
				&& impactRecords[recordIndex].mapY == mapY)
			{
				return;
			}
		}

		for (recordIndex = 0x0000;
			recordIndex < TERRAIN_IMPACT_RECORD_COUNT;
			++recordIndex)
		{
			record = &impactRecords[recordIndex];
			if (record->mapX != TERRAIN_IMPACT_UNUSED_X)
				continue;

			record->mapX = mapX;
			record->mapY = mapY;
			record->animationVariant = (byte)(GeneratePseudoRandomByte() % 0x03);
			if (advanceBeforeRecording == FALSE)
				AdvanceTerrainDamageState(mapX, mapY, 0x03);
			return;
		}
		return;
	}

	// Transitioning state 2 -> 3 collapses structure footprints only for the
	// scenario-specific terrain-ID bands. Assembly reaches this test only when
	// the animation-record branch above was not taken.
	if (previousDamageState == 0x02 && advanceBeforeRecording != FALSE)
	{
		collapsibleStructure = FALSE;
		switch (TacticalTerrainEffectMode)
		{
		case 0x01:
			collapsibleStructure = terrainType >= 0x8C && terrainType <= 0x94;
			break;
		case 0x05:
			collapsibleStructure = terrainType >= 0xE6 && terrainType <= 0xEE;
			break;
		case 0x08:
			collapsibleStructure = terrainType >= 0xA9 && terrainType <= 0xAC;
			break;
		}
		if (collapsibleStructure != FALSE)
			CollapseStructureAtMapCell(mapX, mapY, terrainType);
	}
}

// 2D1B:2AF3: void CollapseStructureAtMapCell(
//     int16 mapX, int16 mapY, word16 terrainType)
//
// Convert the struck structure tile to its 2x2 or 3x3 footprint origin,
// advance every footprint cell to terminal terrain damage, queue a heavy
// impact visual, and destroy every deployed unit within one cell of each tile.
// Verified against 2D1B:2AF3-2C22.
void CollapseStructureAtMapCell(
	int16 mapX,
	int16 mapY,
	word16 terrainType)
{
	int16 footprintOriginX = mapX;
	int16 footprintOriginY = mapY;
	word16 footprintWidth;
	word16 footprintHeight;
	word16 row;

	if (TacticalTerrainEffectMode == 0x08)
	{
		footprintWidth = 0x02;
		footprintHeight = 0x02;
		if ((terrainType & 0x01) == 0x00)
			--footprintOriginX;
		if (terrainType >= 0xAB)
			--footprintOriginY;
	}
	else
	{
		int16 footprintCell =
			(int16)(word16)(terrainType - 0x8C);
		footprintWidth = 0x03;
		footprintHeight = 0x03;
		if (TacticalTerrainEffectMode == 0x05)
			footprintCell = (int16)(word16)(footprintCell - 0x5A);
		footprintOriginY = (int16)(word16)(
			(word16)footprintOriginY - (word16)(footprintCell / 0x03));
		footprintOriginX = (int16)(word16)(
			(word16)footprintOriginX - (word16)(footprintCell % 0x03));
	}

	for (row = 0x00; row < footprintHeight; ++row)
	{
		word16 column;
		int16 cellY = (int16)(word16)(
			(word16)footprintOriginY + row);
		for (column = 0x00; column < footprintWidth; ++column)
		{
			int16 cellX = (int16)(word16)(
				(word16)footprintOriginX + column);
			int16 minimumUnitX = (int16)(word16)((word16)cellX - 0x01);
			int16 maximumUnitX = (int16)(word16)((word16)cellX + 0x01);
			int16 minimumUnitY = (int16)(word16)((word16)cellY - 0x01);
			int16 maximumUnitY = (int16)(word16)((word16)cellY + 0x01);

			while ((int16)AdvanceTerrainDamageState(
				cellX, cellY, 0x03) < 0x03)
				ApplyTerrainImpact(cellX, cellY, TRUE, TRUE);
			QueueTacticalImpactVisual(cellX, cellY, 0x01);

			word16 unitIndex;
			for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT;
				++unitIndex)
			{
				RevengeUnitRecord *unit = &PersistentUnitRoster[unitIndex];
				if (unit->deploymentState != 0x00
					&& (int16)ScenarioUnitMapX[unitIndex]
						>= minimumUnitX
					&& (int16)ScenarioUnitMapX[unitIndex]
						<= maximumUnitX
					&& (int16)ScenarioUnitMapY[unitIndex]
						>= minimumUnitY
					&& (int16)ScenarioUnitMapY[unitIndex]
						<= maximumUnitY)
				{
					DestroyScenarioUnit(unitIndex);
				}
			}
		}
	}
}

// 2D1B:296F: queue narration category 07h for a friendly lance leader whose
// current tactical order mode is not 02h. The category label remains proposed.
void QueueLanceOrderNarration(word16 unitIndex)
{
	if ((int16)unitIndex >= ENEMY_FORCE_FIRST_UNIT
		|| IsCurrentLanceLeader(unitIndex) == FALSE
		|| UnitTacticalOrderMode[unitIndex] ==
			TACTICAL_ORDER_SEEK_AND_DESTROY)
	{
		return;
	}

	NarrationEmphasis = FALSE;
	PendingNarrationDelay = 0x025D;
	ActiveNarrationSubject = unitIndex;
	NarrationMessageCategory = 0x07;
}

// 2D1B:2C23: advance to the next of the first four route waypoints and copy
// its X/Y coordinates into the unit's active route target.
// Verified against 2D1B:2C23-2CB3, including the signed route-index tests.
void AdvanceUnitRouteWaypoint(word16 unitIndex)
{
	SceneUnitRoute *route = &SceneUnitRoutes[unitIndex];
	int8 routeIndex = route->waypointIndex;

	if (routeIndex >= 0x03)
		return;
	++route->waypointIndex;
	routeIndex = route->waypointIndex;
	UnitRouteTargetMapX[unitIndex] = route->waypointMapX[routeIndex];
	UnitRouteTargetMapY[unitIndex] = route->waypointMapY[routeIndex];
}

// 2D1B:2AA6: word16 HasTacticalReferencePointLineOfSightToUnit(
//     word16 referencePointIndex, word16 unitIndex)
// Called from:
//      DrawTacticalUnitControlPanel
word16 HasTacticalReferencePointLineOfSightToUnit(
	word16 referencePointIndex,
	word16 unitIndex)
{
	// P: the four DS:865B/865F coordinate pairs are independently enabled by
	// DS:8657. Their campaign-facing meaning still needs a SCENE-opcode trace,
	// but this routine's geometric role is verified by its sole LOS call.
	return TraceMapLineOfSight(
		CampaignUpgradeMarkerX[referencePointIndex],
		CampaignUpgradeMarkerY[referencePointIndex],
		ScenarioUnitMapX[unitIndex],
		ScenarioUnitMapY[unitIndex],
		TerrainTypeMap,
		0xFF,
		0xFF,
		0xFF,
		0xFF);
}
