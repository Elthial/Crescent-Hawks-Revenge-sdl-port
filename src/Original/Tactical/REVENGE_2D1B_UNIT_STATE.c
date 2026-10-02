// REVENGE_2D1B_UNIT_STATE.c
// Procedures preserved from REVENGE_2D1B_TACTICAL_COMBAT.c.

#include "REVENGE_2D1B_INTERNAL.h"

// 2D1B:0005: void RecalculateUnitCombatRatings(Stack RevengeUnitRecord *unitRecord,
//     Stack word16 unitSlot, Stack word16 rebuildWeaponCounts, Stack word16 advanceRecovery)
// Called from:
//      DrawUnitStatusScreen
void RecalculateUnitCombatRatings(
	RevengeUnitRecord *unitRecord,
	word16 unitSlot,
	word16 rebuildWeaponCounts,
	word16 advanceRecovery)
{
	byte *cachedWeaponCounts;
	const RevengeWeaponDefinition *weaponDefinition;
	byte *weaponRecovery;
	word16 *currentAmmunition;
	word16 *weaponCounts;
	RevengeTacticalCombatRatings *ratings;
	int16 ammunitionFamily;
	int16 updatedRecovery;
	word16 ammunitionAvailable;
	word16 recoveryIndex;
	word16 weaponIndex;
	word16 weaponReady;
	uint32 selectedWeaponRating;
	uint32 weaponAvailability;
	uint32 weaponBit;

	weaponCounts = WeaponCountScratch;
	cachedWeaponCounts = UnitCachedWeaponCounts;
	weaponRecovery = UnitWeaponRecoveryCounters;
	ratings = TACTICAL_COMBAT_RATINGS(unitSlot);

	if (rebuildWeaponCounts != FALSE)
	{
		CountUnitWeaponsByType(unitRecord);
		for (weaponIndex = 0x00;
			weaponIndex < WEAPON_DEFINITION_COUNT;
			++weaponIndex)
		{
			cachedWeaponCounts[unitSlot * WEAPON_DEFINITION_COUNT + weaponIndex] =
				(byte)weaponCounts[weaponIndex];
		}
		UnitHeatSinkCount[unitSlot] =
			(byte)CountOrRemoveUnitHeatSinks(unitRecord, FALSE);
	}
	else
	{
		for (weaponIndex = 0x00;
			weaponIndex < WEAPON_DEFINITION_COUNT;
			++weaponIndex)
		{
			weaponCounts[weaponIndex] = cachedWeaponCounts[
					unitSlot * WEAPON_DEFINITION_COUNT + weaponIndex];
		}
	}

	UnitWeaponAvailabilityMask[unitSlot] = 0x00000000UL;
	weaponBit = 0x00000001UL;
	for (weaponIndex = 0x00;
		weaponIndex < WEAPON_DEFINITION_COUNT;
		++weaponIndex, weaponBit <<= 0x01)
	{
		weaponReady = TRUE;
		weaponDefinition = &WeaponDefinitions[weaponIndex];

		if (advanceRecovery != FALSE)
		{
			recoveryIndex =
				unitSlot * WEAPON_DEFINITION_COUNT + weaponIndex;
			updatedRecovery = weaponRecovery[recoveryIndex]
				- weaponCounts[weaponIndex];
			if (updatedRecovery < 0x00)
				updatedRecovery = 0x00;
			weaponRecovery[recoveryIndex] = (byte)updatedRecovery;
			weaponReady = weaponRecovery[recoveryIndex] == 0x00;
		}

		if (weaponCounts[weaponIndex] != 0x00 && weaponReady != FALSE)
		{
			ammunitionFamily = weaponDefinition->ammunitionFamilyId;
			ammunitionAvailable = ammunitionFamily == AMMUNITION_NONE;
			if (ammunitionFamily != AMMUNITION_NONE)
			{
				currentAmmunition = unitRecord->currentAmmunition;
				ammunitionAvailable =
					currentAmmunition[ammunitionFamily - 0x01] != 0x00;
			}
			if (ammunitionAvailable != FALSE)
				UnitWeaponAvailabilityMask[unitSlot] |=
					weaponBit;
		}
	}

	ratings->movement = unitRecord->walkMovement;
	ratings->sensorHits = unitRecord->sensorHits;
	CalculateUnitDurabilityTotals(unitRecord);
	ratings->durabilityDividedBy16 =
		(int16)CurrentUnitDurabilityTotal >> 0x04;
	if ((int16) (word16)
			(CurrentUnitDurabilityTotal << 0x01)
		< (int16) MaximumUnitDurabilityTotal)
		UnitBelowHalfDurability[unitSlot] = TRUE;

	weaponAvailability =
		UnitWeaponAvailabilityMask[unitSlot];
	ratings->closeFirepower = (int16)CalculateSelectedWeaponRating(
		weaponAvailability & WEAPON_CLOSE_FIREPOWER_PRIMARY_MASK,
		weaponCounts);
	ratings->closeFirepower = (int16)(ratings->closeFirepower
		+ (int16)CalculateSelectedWeaponRating(
			weaponAvailability & WEAPON_CLOSE_FIREPOWER_SECONDARY_MASK,
			weaponCounts));
	selectedWeaponRating = CalculateSelectedWeaponRating(
		weaponAvailability & WEAPON_MEDIUM_FIREPOWER_HALF_RATING_MASK,
		weaponCounts);
	ratings->mediumFirepower = (int16)
		((int32) selectedWeaponRating >> 0x01);
	ratings->mediumFirepower = (int16)(ratings->mediumFirepower
		+ (int16)CalculateSelectedWeaponRating(
			weaponAvailability & WEAPON_MEDIUM_FIREPOWER_FULL_RATING_MASK,
			weaponCounts));
	selectedWeaponRating = CalculateSelectedWeaponRating(
		weaponAvailability & WEAPON_LONG_FIREPOWER_HALF_RATING_MASK,
		weaponCounts);
	ratings->longFirepower = (int16)
		((int32) selectedWeaponRating >> 0x01);
	ratings->longFirepower = (int16)(ratings->longFirepower
		+ (int16)CalculateSelectedWeaponRating(
			weaponAvailability & WEAPON_LONG_FIREPOWER_FULL_RATING_MASK,
			weaponCounts));
}

// 2D1B:0379: void CalculateUnitDurabilityTotals(Stack RevengeUnitRecord *unitRecord)
// Called from:
//      DrawUnitStatusScreen
//      RecalculateUnitCombatRatings
// Verified against 2D1B:0379-03E9, including CBW sign extension.
void CalculateUnitDurabilityTotals(RevengeUnitRecord *unitRecord)
{
	word16 locationIndex;

	MaximumUnitDurabilityTotal = 0x0000;
	CurrentUnitDurabilityTotal = 0x0000;
	if (unitRecord->deploymentState == 0x00)
		return;

	if (unitRecord->damageModel != UNIT_DAMAGE_MODEL_INFANTRY)
	{
		for (locationIndex = 0x0000; locationIndex < 0x000B; ++locationIndex)
		{
			CurrentUnitDurabilityTotal = (word16)(
				CurrentUnitDurabilityTotal
				+ unitRecord->currentArmor[locationIndex]);
			MaximumUnitDurabilityTotal = (word16)(
				MaximumUnitDurabilityTotal
				+ unitRecord->maximumArmor[locationIndex]);
		}
	}
	else
	{
		for (locationIndex = 0x0000; locationIndex < 0x000B; ++locationIndex)
		{
			CurrentUnitDurabilityTotal = (word16)(
				CurrentUnitDurabilityTotal
				+ unitRecord->currentInternal[locationIndex]);
			MaximumUnitDurabilityTotal = (word16)(
				MaximumUnitDurabilityTotal
				+ unitRecord->maximumInternal[locationIndex]);
		}
	}
}

// 2D1B:03EA: void MoveUnitTowardMapCell(
//     word16 unitIndex, word16 destinationX, word16 destinationY)
// Try the eight neighboring cells in a rotating direction order. A successful
// step updates map position, terrain, facing, sprite, movement heat, and any
// destructible terrain entered. Reaching a route point advances or closes it.
void MoveUnitTowardMapCell(
	word16 unitIndex, word16 destinationX, word16 destinationY)
{
	RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
	SceneUnitRoute *route = &SceneUnitRoutes[unitIndex];
	word16 lanceUnitIndex = unitIndex;
	int16 directionSearchCountdown = DirectionSearchCountdown - 0x01;
	DirectionSearchCountdown = directionSearchCountdown;
	if (directionSearchCountdown < 0x00)
	{
		DirectionSearchCountdown = 0x0A;
		DirectionSearchMirror ^= 0x08;
	}

	int16 currentX = ScenarioUnitMapX[unitIndex];
	int16 currentY = ScenarioUnitMapY[unitIndex];
	int16 preferredDirection = ScenarioUnitFacing[unitIndex];
	int16 desiredDirection = DetermineRelativeAttackDirection(
		currentX, currentY, destinationX, destinationY);
	if (desiredDirection == 0x08)
		return;

	word16 advancedRoute = FALSE;
	if (DirectionDeltaXTable[desiredDirection] + currentX
			== (int16)destinationX
		&& DirectionDeltaYTable[desiredDirection] + currentY
			== (int16)destinationY)
	{
		preferredDirection = desiredDirection;
		if (UnitLanceFormationState[unitIndex] == 0x00)
		{
			AdvanceUnitRouteWaypoint(unitIndex);
		}
		else if (route->waypointIndex < 0x03)
		{
			AdvanceUnitRouteWaypoint(unitIndex);
			if (UnitRouteTargetMapX[unitIndex] == destinationX
				&& UnitRouteTargetMapY[unitIndex] == destinationY)
			{
				if (IsCurrentLanceLeader(unitIndex) != FALSE)
					SelectLanceFormationMode(unitIndex, FALSE);
				if (route->waypointIndex > 0x01)
					QueueLanceOrderNarration(unitIndex);
			}
			advancedRoute = TRUE;
		}
		else
		{
			if (IsCurrentLanceLeader(unitIndex) != FALSE)
			{
				if ((UnitWithdrawalState[unitIndex] & 0x01) != 0x00)
				{
					do
					{
						RevengeUnitRecord *lanceUnit =
							&PersistentUnitRoster[lanceUnitIndex];
						UnitWithdrawalState[lanceUnitIndex] |= 0x80;
						if (EnemyCycleUnitIndex == lanceUnitIndex)
							EnemyCycleUnitIndex = 0xFFFF;
						if (TacticalSelectedUnitIndex == lanceUnitIndex)
							TacticalSelectedUnitIndex = 0xFFFF;
						lanceUnit->deploymentState = 0x00;
						++lanceUnitIndex;
					} while ((lanceUnitIndex & 0x03) != 0x00);
				}
				else
				{
					SelectLanceFormationMode(unitIndex, FALSE);
				}
			}
			else if ((UnitWithdrawalState[unitIndex] & 0x01) != 0x00)
			{
				if (EnemyCycleUnitIndex == unitIndex)
					EnemyCycleUnitIndex = 0xFFFF;
				if (TacticalSelectedUnitIndex == unitIndex)
					TacticalSelectedUnitIndex = 0xFFFF;
				UnitWithdrawalState[unitIndex] |= 0x80;
				unitRecord->deploymentState = 0x00;
			}
			QueueLanceOrderNarration(unitIndex);
		}
	}

	word16 currentCell = (word16)currentX
		+ MapWidth * (word16)currentY;
	word16 directionDifference = desiredDirection - preferredDirection;
	if (directionDifference != 0x00)
	{
		if ((directionDifference & 0x07) < 0x05)
			++preferredDirection;
		else
			--preferredDirection;
		preferredDirection &= 0x07;
	}

	int16 attempt;
	for (attempt = 0x07; attempt >= 0x00; --attempt)
	{
		int16 directionDelta = DirectionSearchDeltaTable[
			attempt + DirectionSearchMirror];
		word16 candidateDirection = (preferredDirection + directionDelta) & 0x07;
		int16 candidateX = currentX
			+ DirectionDeltaXTable[candidateDirection];
		int16 candidateY = currentY
			+ DirectionDeltaYTable[candidateDirection];
		if (candidateX >= 0x00 && candidateY >= 0x00
			&& candidateX < (int16)MapWidth
			&& candidateY < (int16)MapHeight)
		{
			int16 neighborOffset =
				NeighborMapOffsetTable[candidateDirection];
			word16 candidateTerrain =
				TerrainTypeMap[currentCell + neighborOffset];
			word16 cellResult = 0x00;

			if (candidateTerrain < ImpassableTerrainTypeMinimum)
			{
				cellResult = 0x01;
				if (unitRecord->damageModel != UNIT_DAMAGE_MODEL_BATTLEMECH)
				{
					if (unitRecord->damageModel ==
							UNIT_DAMAGE_MODEL_HOVER_VEHICLE
						&& candidateTerrain >= TerrainImpactAnimationTypeMinimum
						&& candidateTerrain <= TerrainImpactAnimationTypeMaximum)
					{
						cellResult = 0x00;
					}
					else if (unitRecord->damageModel >=
							UNIT_DAMAGE_MODEL_COMBAT_VEHICLE
						&& unitRecord->damageModel <=
							UNIT_DAMAGE_MODEL_MOBILE_HQ
						&& candidateTerrain
							>= DestructibleTerrainTypeBase
						&& candidateTerrain
							<= DestructibleTerrainTypeBase + 0x02)
					{
						cellResult = 0x00;
					}
				}

				if (cellResult != 0x00)
				{
					word16 otherUnit;
					for (otherUnit = 0x00; otherUnit < TACTICAL_UNIT_COUNT;
						++otherUnit)
					{
						RevengeUnitRecord *otherRecord =
							&PersistentUnitRoster[otherUnit];
						if (otherUnit != unitIndex
							&& otherRecord->deploymentState != 0x00
							&& ScenarioUnitMapX[otherUnit]
								== candidateX
							&& ScenarioUnitMapY[otherUnit]
								== candidateY)
						{
							cellResult = 0x00;
						}
					}
				}
			}

			if (cellResult == 0x00
				&& candidateX == (int16)destinationX
				&& candidateY == (int16)destinationY)
			{
				cellResult = 0x02;
				if (UnitRouteTargetMapX[unitIndex] == destinationX
					&& UnitRouteTargetMapY[unitIndex] == destinationY)
				{
					UnitRouteTargetMapX[unitIndex] =
						ScenarioUnitMapX[unitIndex];
					UnitRouteTargetMapY[unitIndex] =
						ScenarioUnitMapY[unitIndex];
				}
			}

			if (cellResult != 0x00)
			{
				if (cellResult == 0x01)
				{
					ScenarioUnitMapX[unitIndex] = (byte)candidateX;
					ScenarioUnitMapY[unitIndex] = (byte)candidateY;
					ScenarioUnitFacing[unitIndex] =
						(byte)candidateDirection;

					word16 spriteFacing = candidateDirection;
					if (advancedRoute != FALSE)
					{
						word16 routeFacing = DetermineRelativeAttackDirection(
							currentX,
							currentY,
							UnitRouteTargetMapX[unitIndex],
							UnitRouteTargetMapY[unitIndex]);
						if (routeFacing != 0x08)
							ScenarioUnitFacing[unitIndex] =
								(byte)routeFacing;
					}
					if (UnitJumpingState[unitIndex] == FALSE)
						TacticalSpriteAnimationPhase ^= 0x01;

					if (spriteFacing >= 0x05)
						spriteFacing = 0x03;
					else if (spriteFacing == 0x04)
						spriteFacing = 0x02;
					else if (spriteFacing != 0x00)
						spriteFacing = 0x01;
					UpdateUnitSpriteForFacing(unitIndex, spriteFacing);

					if (TerrainDamageCapabilityTable[candidateTerrain]
							!= 0x00
						&& unitRecord->damageModel
							!= UNIT_DAMAGE_MODEL_INFANTRY)
					{
						BeginTerrainDamageAtCell(
							candidateX, candidateY, candidateTerrain);
						if (unitRecord->currentHeat < BATTLEMECH_MAXIMUM_HEAT)
						{
							word16 *heatAccumulator =
								&unitRecord->heatAccumulatorQ8_8;
							if (UnitJumpingState[unitIndex] != FALSE)
								*heatAccumulator += 0x00E0;
							else if (UnitMovementHeatExponent[unitIndex]
								!= 0x00)
							{
								*heatAccumulator += 0x0010
									<< UnitMovementHeatExponent[unitIndex];
							}
						}
					}
					UnitTerrainType[unitIndex] =
						(byte)candidateTerrain;
				}
				return;
			}
		}

		preferredDirection = (preferredDirection + directionDelta) & 0x07;
	}
}

// 2D1B:1804: void UpdateUnitSpriteForFacing(
//     Stack word16 unitIndex, Stack word16 facing)
void UpdateUnitSpriteForFacing(word16 unitIndex, word16 facing)
{
	RevengeUnitRecord *unit = &PersistentUnitRoster[unitIndex];
	if (unit->damageModel == UNIT_DAMAGE_MODEL_INFANTRY)
		facing = 0x00;

	UnitSpriteId[unitIndex] =
		UnitSpriteBaseId[unitIndex]
			+ ((facing & 0x03) << 0x01);
	if (TacticalSpriteAnimationPhase != 0x00)
		++UnitSpriteId[unitIndex];
}

// 2D1B:08AF: void RefreshAllUnitCombatState(
//     word16 rebuildWeaponCounts)
// Called by RunTacticalInteractionLoop before and during tactical play.
void RefreshAllUnitCombatState(word16 rebuildWeaponCounts)
{
	word16 unitIndex;
	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
		if (unitRecord->deploymentState != 0x00)
		{
			RecalculateUnitCombatRatings(
				unitRecord, unitIndex, rebuildWeaponCounts, TRUE);
		}
	}
	SelectUnitTacticalTargets();
}

// 2D1B:08FA: void SelectUnitTacticalTargets(void)
// Select or retain an opposing target, compare durability and firepower through
// DS:08C6, and choose close/medium/long/withdraw/position movement behavior.
void SelectUnitTacticalTargets(void)
{
	word16 unitIndex;
	word16 opposingBase = 0x0C;

	for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
		if (unitRecord->deploymentState == 0x00)
			continue;

		if (UnitAttackTarget[unitIndex] != TACTICAL_TARGET_NONE
			&& UnitAttackTarget[unitIndex] < TACTICAL_TARGET_MAP_CELL)
		{
			RevengeUnitRecord *orderedTarget =
				&PersistentUnitRoster[
					UnitAttackTarget[unitIndex]];
			if (orderedTarget->deploymentState == 0x00)
				UnitAttackTarget[unitIndex] = TACTICAL_TARGET_NONE;
		}

		// The unit's pilot-experience entry selects a scenario-permission mask.
		// B02Ah also carries the verified 80h environment/heat modifier; the
		// wider flag meanings remain deliberately unnamed.
		word16 experienceMask = UnitActionMaskByExperience[
			unitRecord->pilotExperience];
		if ((experienceMask & TacticalClockDivider) == 0x00)
			continue;

		if (unitIndex >= ENEMY_FORCE_FIRST_UNIT)
			opposingBase = 0x00;

		word16 unitX = ScenarioUnitMapX[unitIndex];
		word16 unitY = ScenarioUnitMapY[unitIndex];
		int16 selectedTarget = -0x01;
		word16 searchForTarget =
			UnitTacticalOrderMode[unitIndex] !=
				TACTICAL_ORDER_SCRIPTED_ROUTE;

		if (UnitTacticalOrderMode[unitIndex] ==
			TACTICAL_ORDER_SEEK_AND_DESTROY
			&& UnitAttackTarget[unitIndex] != TACTICAL_TARGET_NONE
			&& UnitAttackTarget[unitIndex] < TACTICAL_TARGET_MAP_CELL)
		{
			searchForTarget = FALSE;
			if (UnitEnemyVisible[unitIndex] != FALSE
				|| (UnitEnemyInProximityRange[unitIndex] != FALSE
					&& UnitEnemyContactEstablished[unitIndex] != FALSE))
			{
				selectedTarget = UnitAttackTarget[unitIndex];
			}
			else
			{
				searchForTarget = TRUE;
			}
		}

		if (searchForTarget != FALSE)
		{
			int16 bestDistance = 0x7FFF;
			word16 candidateOffset;

			if (UnitAttackTarget[unitIndex] == TACTICAL_TARGET_MAP_CELL)
			{
				bestDistance = CalculateApproximateMapDistance(
					unitX,
					unitY,
					UnitTargetMapX[unitIndex],
					UnitTargetMapY[unitIndex]) >> 0x01;
				selectedTarget = 0x18;
			}

			for (candidateOffset = 0x00;
				candidateOffset < TACTICAL_FORCE_UNIT_COUNT;
				++candidateOffset)
			{
				word16 candidateIndex = opposingBase + candidateOffset;
				RevengeUnitRecord *candidateRecord =
					&PersistentUnitRoster[candidateIndex];
				if (candidateRecord->deploymentState == 0x00)
					continue;

				int16 candidateDistance = CalculateApproximateMapDistance(
					unitX,
					unitY,
					ScenarioUnitMapX[candidateIndex],
					ScenarioUnitMapY[candidateIndex]);
				if (candidateIndex
					== UnitAttackTarget[unitIndex])
				{
					candidateDistance >>= 0x01;
				}

				if (candidateDistance < bestDistance
					&& (UnitEnemyVisible[candidateIndex] != FALSE
						|| (UnitEnemyContactEstablished[candidateIndex] != FALSE
							&& UnitEnemyInProximityRange[candidateIndex] != FALSE)))
				{
					bestDistance = candidateDistance;
					selectedTarget = candidateIndex;
				}
			}
		}

		UnitTacticalTarget[unitIndex] = (RevengeUnitSlot)selectedTarget;
		UnitPreferredEngagementMode[unitIndex] =
			TACTICAL_ENGAGEMENT_NONE;
		if (UnitTacticalOrderMode[unitIndex] ==
			TACTICAL_ORDER_HOLD_POSITION)
		{
			UnitPreferredEngagementMode[unitIndex] =
				TACTICAL_ENGAGEMENT_POSITION;
		}

		if (selectedTarget != -0x01
			&& UnitTacticalOrderMode[unitIndex] ==
				TACTICAL_ORDER_SEEK_AND_DESTROY)
		{
			RevengeTacticalCombatRatings *unitRatings =
				TACTICAL_COMBAT_RATINGS(unitIndex);
			RevengeTacticalCombatRatings *targetRatings =
				TACTICAL_COMBAT_RATINGS((word16)selectedTarget);
			word16 comparisonMask = 0x00;
			word16 ratingIndex;
			word16 ratingBit = 0x02;

			if (unitRatings->durabilityDividedBy16 >=
				targetRatings->durabilityDividedBy16 - 0x01)
				comparisonMask |= 0x01;
			if (unitRatings->durabilityDividedBy16 != 0x00
				&& unitRatings->durabilityDividedBy16 >=
					targetRatings->durabilityDividedBy16 * 0x02)
			{
				comparisonMask |= 0x10;
			}
			if (selectedTarget == 0x18)
				comparisonMask |= 0x33;

			for (ratingIndex = 0x02; ratingIndex <= 0x04; ++ratingIndex)
			{
				int16 ownRating = ((int16 *)unitRatings)[ratingIndex];
				int16 opposingRating = ((int16 *)targetRatings)[ratingIndex];
				if (ownRating != 0x00)
				{
					if (ownRating >= opposingRating)
						comparisonMask |= ratingBit;
					if (ownRating >= opposingRating * 0x02)
						comparisonMask |= ratingBit << 0x04;
					if (selectedTarget == 0x18)
						comparisonMask |= ratingBit * 0x11;
				}
				ratingBit <<= 0x01;
			}

			UnitPreferredEngagementMode[unitIndex] =
				EngagementModeByComparisonMask[
					comparisonMask & 0x00FF];

			word16 longRangeMissileAmmunition;

			// ASM 2D1B:0C8C-0CBA adds the three words with 16-bit wrap.
			longRangeMissileAmmunition = (word16)
				(unitRecord->lrm5Ammunition
					+ unitRecord->lrm10Ammunition
					+ unitRecord->lrm15Ammunition);
			if (UnitPreferredEngagementMode[unitIndex]
					== TACTICAL_ENGAGEMENT_LONG
				&& longRangeMissileAmmunition != 0x00)
			{
				UnitPreferredEngagementMode[unitIndex] =
					EngagementModeByComparisonMask[
						comparisonMask & 0x007F];
				if (UnitPreferredEngagementMode[unitIndex]
					== TACTICAL_ENGAGEMENT_WITHDRAW)
				{
					UnitPreferredEngagementMode[unitIndex] =
						TACTICAL_ENGAGEMENT_LONG;
				}
			}

			if (UnitPreferredEngagementMode[unitIndex]
				== TACTICAL_ENGAGEMENT_WITHDRAW)
			{
				word16 allyIndex;
				word16 sameSideBase = 0x0C - opposingBase;
				for (allyIndex = sameSideBase; allyIndex < unitIndex; ++allyIndex)
				{
					if (UnitTacticalTarget[allyIndex]
						!= selectedTarget)
					{
						continue;
					}

					RevengeTacticalCombatRatings *allyRatings =
						TACTICAL_COMBAT_RATINGS(allyIndex);
					comparisonMask = 0x00;
					ratingBit = 0x01;
					for (ratingIndex = 0x01; ratingIndex <= 0x04; ++ratingIndex)
					{
						int16 ownRating =
							((int16 *)unitRatings)[ratingIndex];
						int16 combinedRating = (int16)(ownRating
							+ ((int16 *)allyRatings)[ratingIndex]);
						int16 opposingRating =
							((int16 *)targetRatings)[ratingIndex];
						if (combinedRating != 0x00)
						{
							if (combinedRating >= opposingRating)
								comparisonMask |= ratingBit;
							if (ratingIndex != 0x01)
								ownRating = combinedRating;
							if (ownRating >= opposingRating * 0x02)
								comparisonMask |= ratingBit << 0x04;
						}
						ratingBit <<= 0x01;
					}

					ratingBit = 0x22;
					for (ratingIndex = 0x02; ratingIndex <= 0x04; ++ratingIndex)
					{
						if ((comparisonMask & ratingBit) != 0x00
							&& ((int16 *)unitRatings)[ratingIndex] == 0x00)
						{
							comparisonMask &= 0x00FF - ratingBit;
						}
						ratingBit <<= 0x01;
					}

					UnitPreferredEngagementMode[unitIndex] =
						EngagementModeByComparisonMask[
							comparisonMask & 0x00FF];
					break;
				}

				if (UnitPreferredEngagementMode[unitIndex]
						== TACTICAL_ENGAGEMENT_WITHDRAW
					&& unitIndex < ENEMY_FORCE_FIRST_UNIT
					&& UnitLastNarratedTarget[unitIndex]
						!= selectedTarget)
				{
					NarrationEmphasis = FALSE;
					PendingNarrationDelay = 0x025D;
					NarrationMessageCategory = 0x0A;
					ActiveNarrationSubject = unitIndex;
					UnitLastNarratedTarget[unitIndex] =
						(RevengeUnitSlot)selectedTarget;
				}

				if (UnitPreferredEngagementMode[unitIndex]
					== TACTICAL_ENGAGEMENT_WITHDRAW)
				{
					if (unitRatings->closeFirepower != 0x00)
						UnitPreferredEngagementMode[unitIndex] =
							TACTICAL_ENGAGEMENT_CLOSE;
					else if (unitRatings->mediumFirepower != 0x00)
						UnitPreferredEngagementMode[unitIndex] =
							TACTICAL_ENGAGEMENT_MEDIUM;
					else if (unitRatings->longFirepower != 0x00)
						UnitPreferredEngagementMode[unitIndex] =
							TACTICAL_ENGAGEMENT_LONG;
				}
			}
		}

		if (UnitTacticalOrderMode[unitIndex] ==
				TACTICAL_ORDER_SCRIPTED_ROUTE
			&& UnitAttackTarget[unitIndex] == TACTICAL_TARGET_NONE)
		{
			UnitPreferredEngagementMode[unitIndex] =
				TACTICAL_ENGAGEMENT_NONE;
		}
		if (unitRecord->damageModel == UNIT_DAMAGE_MODEL_INFANTRY
			&& UnitOverburnOrCloseAssaultEnabled[unitIndex] != 0x00
			&& UnitTacticalOrderMode[unitIndex] ==
				TACTICAL_ORDER_SEEK_AND_DESTROY)
		{
			UnitPreferredEngagementMode[unitIndex] =
				TACTICAL_ENGAGEMENT_CLOSE;
		}
	}
}

// 2D1B:0F1F: void AdvanceUnitTacticalMovement(word16 unitIndex)
// Derive this tick's movement eligibility, choose target/route/formation or
// withdrawal coordinates, face an observable target, and attempt one map step.
void AdvanceUnitTacticalMovement(word16 unitIndex)
{
	RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
	int16 movementRate = unitRecord->walkMovement;
	word16 jumpStartedThisTick = FALSE;

	if (UnitMovementHeatExponent[unitIndex] == 0x02)
		movementRate += movementRate >> 0x01;
	movementRate -= unitRecord->currentHeat / BATTLEMECH_HEAT_SCALE;
	if (movementRate < 0x00)
		movementRate = 0x00;

	word16 terrainType = UnitTerrainType[unitIndex];
	if (terrainType >= TerrainImpactAnimationTypeMinimum
		&& terrainType <= TerrainImpactAnimationTypeMaximum)
	{
		movementRate >>= 0x02;
		if (UnitJumpingState[unitIndex] == FALSE
			&& unitRecord->walkMovement != 0x00
			&& UnitJumpMovementRemaining[unitIndex] != 0x00
			&& UnitMovementHeatExponent[unitIndex] == 0x02)
		{
			UnitJumpingState[unitIndex] = TRUE;
			jumpStartedThisTick = TRUE;
		}
	}
	if (terrainType >= DestructibleTerrainTypeBase
		&& terrainType <= DestructibleTerrainTypeBase + 0x02)
	{
		movementRate >>= 0x01;
		if (UnitJumpingState[unitIndex] == FALSE
			&& unitRecord->walkMovement != 0x00
			&& UnitJumpMovementRemaining[unitIndex] != 0x00
			&& UnitMovementHeatExponent[unitIndex] == 0x02)
		{
			UnitJumpingState[unitIndex] = TRUE;
			jumpStartedThisTick = TRUE;
		}
	}

	if (movementRate > 0x08)
		movementRate = 0x08;
	if (movementRate < 0x01)
		movementRate = unitRecord->walkMovement == 0x00 ? 0x09 : 0x01;

	if (UnitJumpingState[unitIndex] != FALSE)
	{
		if (UnitJumpMovementRemaining[unitIndex] != 0x00
			&& unitRecord->walkMovement != 0x00)
		{
			--UnitJumpMovementRemaining[unitIndex];
			movementRate = 0x08;
		}
		else
		{
			movementRate = 0x09;
		}
	}

	if (UnitMovementHeatExponent[unitIndex] == 0x00
		|| (MovementTimingMaskTable[movementRate - 0x01]
			& TacticalClockDivider) == 0x00)
	{
		return;
	}

	if (UnitShutdownState[unitIndex] != FALSE)
	{
		if (jumpStartedThisTick != FALSE)
			UnitJumpingState[unitIndex] = FALSE;
		return;
	}

	word16 useRoute =
		UnitLanceFormationState[unitIndex] == 0x00;
	word16 movementAction = 0x00;
	word16 suppressTargetFacing = FALSE;
	word16 destinationX = 0x00;
	word16 destinationY = 0x00;

	if ((UnitTacticalOrderMode[unitIndex] ==
			TACTICAL_ORDER_SEEK_AND_DESTROY
			&& UnitTacticalTarget[unitIndex] != TACTICAL_TARGET_NONE)
		|| UnitLanceFormationState[unitIndex] != 0x00)
	{
		useRoute = FALSE;
		if (UnitAttackTarget[unitIndex] == TACTICAL_TARGET_MAP_CELL
			&& UnitTacticalOrderMode[unitIndex] ==
				TACTICAL_ORDER_SEEK_AND_DESTROY)
		{
			destinationX = UnitTargetMapX[unitIndex];
			destinationY = UnitTargetMapY[unitIndex];
		}
		else if (UnitTacticalTarget[unitIndex] >= 0x00
			&& UnitTacticalTarget[unitIndex] < TACTICAL_TARGET_MAP_CELL)
		{
			word16 targetIndex = UnitTacticalTarget[unitIndex];
			destinationX = ScenarioUnitMapX[targetIndex];
			destinationY = ScenarioUnitMapY[targetIndex];
		}
		else
		{
			useRoute = TRUE;
		}

		if (UnitAttackTarget[unitIndex] == TACTICAL_TARGET_MAP_CELL
			&& UnitTacticalOrderMode[unitIndex] !=
				TACTICAL_ORDER_SEEK_AND_DESTROY
			&& ScenarioUnitMapX[unitIndex]
				== UnitRouteTargetMapX[unitIndex]
			&& ScenarioUnitMapY[unitIndex]
				== UnitRouteTargetMapY[unitIndex]
			&& UnitTacticalTarget[unitIndex] >= 0x00
			&& UnitTacticalTarget[unitIndex] < TACTICAL_TARGET_MAP_CELL)
		{
			word16 targetIndex = UnitTacticalTarget[unitIndex];
			if (UnitEnemyVisible[targetIndex] != FALSE
				|| UnitEnemyInProximityRange[targetIndex] != FALSE)
			{
				word16 facing = DetermineRelativeAttackDirection(
					ScenarioUnitMapX[unitIndex],
					ScenarioUnitMapY[unitIndex],
					UnitTargetMapX[unitIndex],
					UnitTargetMapY[unitIndex]);
				if (facing <= 0x07)
				{
					ScenarioUnitFacing[unitIndex] = (byte)facing;
					UpdateUnitSpriteForFacing(
						unitIndex, SpriteFacingByDirection[facing]);
				}
				suppressTargetFacing = TRUE;
			}
		}

		if (UnitTacticalOrderMode[unitIndex] !=
			TACTICAL_ORDER_SEEK_AND_DESTROY)
			useRoute = TRUE;
	}
	else
	{
		useRoute = TRUE;
	}

	if (useRoute != FALSE)
	{
		destinationX = UnitRouteTargetMapX[unitIndex];
		destinationY = UnitRouteTargetMapY[unitIndex];
		movementAction = 0x01;
	}

	if (UnitLanceFormationState[unitIndex] == 0x00)
	{
		UnitPreferredEngagementMode[unitIndex] =
			TACTICAL_ENGAGEMENT_POSITION;
	}

	word16 currentX = ScenarioUnitMapX[unitIndex];
	word16 currentY = ScenarioUnitMapY[unitIndex];
	word16 distance = CalculateApproximateMapDistance(
		currentX, currentY, destinationX, destinationY);
	if (movementAction == 0x00)
	{
		switch (UnitPreferredEngagementMode[unitIndex])
		{
		case TACTICAL_ENGAGEMENT_CLOSE:
			if (distance > 0x01)
				movementAction = 0x01;
			break;
		case TACTICAL_ENGAGEMENT_MEDIUM:
			if (distance > 0x06)
				movementAction = 0x01;
			else if (distance < 0x05)
				movementAction = 0x02;
			break;
		case TACTICAL_ENGAGEMENT_LONG:
			if (distance > 0x0C)
				movementAction = 0x01;
			else if (distance < 0x0B)
				movementAction = 0x02;
			break;
		case TACTICAL_ENGAGEMENT_WITHDRAW:
			if (distance < 0x0F)
				movementAction = 0x02;
			else
			{
				destinationX = UnitRouteTargetMapX[unitIndex];
				destinationY = UnitRouteTargetMapY[unitIndex];
				movementAction = 0x01;
			}
			break;
		case TACTICAL_ENGAGEMENT_POSITION:
			if (currentX != destinationX || currentY != destinationY)
				movementAction = 0x01;
			break;
		}
	}

	if (UnitLanceFormationState[unitIndex] == 0x02)
	{
		word16 lanceBase = unitIndex & 0x00FC;
		word16 lanceOffset;
		for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
		{
			word16 leaderIndex = lanceBase + lanceOffset;
			if (IsCurrentLanceLeader(leaderIndex) != FALSE
				&& CalculateApproximateMapDistance(
					currentX,
					currentY,
					ScenarioUnitMapX[leaderIndex],
					ScenarioUnitMapY[leaderIndex]) >= 0x06)
			{
				destinationX = ScenarioUnitMapX[leaderIndex];
				destinationY = ScenarioUnitMapY[leaderIndex];
				movementAction = 0x01;
				break;
			}
		}
	}

	if (movementAction == 0x02)
	{
		destinationX = destinationX > currentX ? currentX - 0x02 : currentX + 0x02;
		destinationY = destinationY > currentY ? currentY - 0x02 : currentY + 0x02;
	}

	if (currentX == destinationX && currentY == destinationY)
	{
		movementAction = 0x00;
		if (suppressTargetFacing == FALSE
			&& UnitTacticalTarget[unitIndex] >= 0x00
			&& UnitTacticalTarget[unitIndex] < TACTICAL_TARGET_MAP_CELL)
		{
			word16 targetIndex = UnitTacticalTarget[unitIndex];
			int16 facing = DetermineRelativeAttackDirection(
				currentX,
				currentY,
				ScenarioUnitMapX[targetIndex],
				ScenarioUnitMapY[targetIndex]);
			if (UnitLanceFormationState[unitIndex] == 0x00)
			{
				word16 leader = FindOperationalLanceLeader(unitIndex);
				if (ScenarioUnitMapX[leader]
						== UnitRouteTargetMapX[leader]
					&& ScenarioUnitMapY[leader]
						== UnitRouteTargetMapY[leader])
				{
					facing = ScenarioUnitFacing[leader];
				}
				else
				{
					facing = -0x01;
				}
			}
			else if (UnitEnemyVisible[targetIndex] == FALSE
				&& UnitEnemyInProximityRange[targetIndex] == FALSE)
			{
				facing = -0x01;
			}

			if (facing >= 0x00 && facing <= 0x07)
			{
				ScenarioUnitFacing[unitIndex] = (byte)facing;
				UpdateUnitSpriteForFacing(
					unitIndex, SpriteFacingByDirection[facing]);
			}
		}
	}

	if (movementAction != 0x00)
		MoveUnitTowardMapCell(unitIndex, destinationX, destinationY);
	else if (jumpStartedThisTick != FALSE)
		UnitJumpingState[unitIndex] = FALSE;
}

