// REVENGE_2208_FORMATIONS.c
// Procedures preserved from REVENGE_2208_TACTICAL_INTERACTION.c.

#include "REVENGE_2208_INTERNAL.h"

// 2208:1829: word16 IsCurrentLanceLeader(word16 unitIndex)
// Called from:
//      ApplyWeaponDamage
//      DestroyScenarioUnit
word16 IsCurrentLanceLeader(word16 unitIndex)
{
	// Test whether this unit is the first deployed, mobile member of its lance;
	// primary-lance formation state 01h also identifies the current leader.
	word16 isCurrentLeader = 0x00;
	word16 lanceBaseUnitIndex = unitIndex & 0x00FC;
	word16 lanceEndUnitIndex = (unitIndex + 0x04) & 0x00FC;

	if (unitIndex < 0x04
		&& UnitLanceFormationState[unitIndex] == 0x01)
	{
		isCurrentLeader = 0x01;
	}

	word16 candidateUnitIndex;
	for (candidateUnitIndex = lanceBaseUnitIndex;
		candidateUnitIndex < lanceEndUnitIndex;
		++candidateUnitIndex)
	{
		RevengeUnitRecord *candidateUnit =
			&PersistentUnitRoster[candidateUnitIndex];
		if (candidateUnit->deploymentState == 0x00
			|| candidateUnit->walkMovement == 0x00)
		{
			continue;
		}

		if (candidateUnitIndex == unitIndex)
			isCurrentLeader = 0x01;
		break;
	}

	return isCurrentLeader;
}

// 2208:1CCC: int16 UpdateUnitEnemyVisibility(word16 unitIndex)
// Called once per unit by RunTacticalInteractionLoop.
int16 UpdateUnitEnemyVisibility(word16 unitIndex)
{
	RevengeUnitRecord *unitRecord;
	RevengeUnitRecord *candidateRecord;
	RevengeUnitRecord *speakerRecord;
	word16 opposingBase;
	int16 opposingOffset;
	word16 candidateIndex;
	word16 hasVisibleEnemy;
	word16 visibleEnemyIndex;
	word16 narrationSubject;
	int16 hadContact;
	int16 orderMode;

	// Verified against 2208:1CCC-1E42.
	UnitEnemyVisible[unitIndex] = FALSE;
	hasVisibleEnemy = FALSE;
	visibleEnemyIndex = 0x00;
	hadContact = UnitEnemyContactEstablished[unitIndex];
	opposingBase = 0x00;
	unitRecord = &PersistentUnitRoster[unitIndex];
	if (unitRecord->deploymentState != 0x00)
	{
		if ((int16) unitIndex < TACTICAL_FORCE_UNIT_COUNT)
			opposingBase = TACTICAL_FORCE_UNIT_COUNT;
		for (opposingOffset = TACTICAL_FORCE_LAST_UNIT_OFFSET;
			opposingOffset >= 0x00;
			--opposingOffset)
		{
			candidateIndex = (word16) (opposingBase + opposingOffset);
			candidateRecord = &PersistentUnitRoster[candidateIndex];
			if (candidateRecord->deploymentState != 0x00
				&& HasUnitLineOfSight(unitIndex, candidateIndex) != FALSE)
			{
				UnitEnemyVisible[unitIndex] = TRUE;
				UnitEnemyContactEstablished[unitIndex] = TRUE;
				hasVisibleEnemy = TRUE;
				visibleEnemyIndex = candidateIndex;
				break;
			}
		}
	}

	// [V] First enemy contact for an opposing slot queues one of three generic
	// narration categories according to the contacted unit's order mode.
	if (hasVisibleEnemy != FALSE
		&& hadContact == FALSE
		&& (int16) unitIndex >= TACTICAL_FORCE_UNIT_COUNT)
	{
		PendingNarrationDelay = CONTACT_NARRATION_DELAY;
		NarrationEmphasis = TRUE;
		orderMode = UnitTacticalOrderMode[visibleEnemyIndex];
		switch (orderMode)
		{
		case TACTICAL_ORDER_SCRIPTED_ROUTE:
			NarrationMessageCategory =
				CONTACT_NARRATION_CATEGORY_SCRIPTED_ROUTE;
			break;
		case TACTICAL_ORDER_HOLD_POSITION:
			NarrationMessageCategory =
				CONTACT_NARRATION_CATEGORY_HOLD_POSITION;
			break;
		case TACTICAL_ORDER_SEEK_AND_DESTROY:
			NarrationMessageCategory =
				CONTACT_NARRATION_CATEGORY_SEEK_AND_DESTROY;
			break;
		default:
			break;
		}
		NarrationSourceUnit = unitIndex;

		narrationSubject = visibleEnemyIndex;
		if ((int16) narrationSubject >= NARRATION_LEADER_SUBSTITUTION_FIRST_UNIT
			&& (int16) narrationSubject < TACTICAL_FORCE_UNIT_COUNT
			&& IsCurrentLanceLeader(narrationSubject) == FALSE)
		{
			narrationSubject = FindOperationalLanceLeader(narrationSubject);
		}
		ActiveNarrationSubject = narrationSubject;

		if (HasNarrationMessage(narrationSubject,
			NarrationMessageCategory) == FALSE)
		{
			ActiveNarrationSubject = NO_UNIT_INDEX;
			for (narrationSubject = TACTICAL_FORCE_LAST_UNIT_OFFSET;
				;
				--narrationSubject)
			{
				speakerRecord = &PersistentUnitRoster[narrationSubject];
				if (speakerRecord->deploymentState != 0x00
					&& HasNarrationMessage(narrationSubject,
						NarrationMessageCategory) != FALSE)
				{
					ActiveNarrationSubject = narrationSubject;
					break;
				}
				if (narrationSubject == 0x00)
					break;
			}
			if (ActiveNarrationSubject == 0x00FF)
				PendingNarrationDelay = 0x00;
		}
	}

	return hasVisibleEnemy;
}

// 2208:1E43: int16 UpdateUnitEnemyProximityState(word16 unitIndex)
// Once contact has been established, test whether any deployed opposing unit
// is closer than the 14h/0Ah/00h range indexed by that opposing record's
// zero/one/two sensor hits at +89h.
int16 UpdateUnitEnemyProximityState(word16 unitIndex)
{
	RevengeUnitRecord *candidateRecord;
	word16 opposingBase;
	word16 opposingOffset;
	word16 candidateIndex;
	int16 separation;
	int16 proximityRange;
	int16 result;

	// Verified against 2208:1E43-1F0B.
	UnitEnemyInProximityRange[unitIndex] = FALSE;
	result = FALSE;
	opposingBase = TACTICAL_FORCE_FIRST_UNIT_OFFSET;
	if ((int16) unitIndex < TACTICAL_FORCE_UNIT_COUNT)
		opposingBase = TACTICAL_FORCE_UNIT_COUNT;

	if (UnitEnemyContactEstablished[unitIndex] == FALSE)
		return result;

	for (opposingOffset = TACTICAL_FORCE_FIRST_UNIT_OFFSET;
		opposingOffset < TACTICAL_FORCE_UNIT_COUNT;
		++opposingOffset)
	{
		candidateIndex = (word16) (opposingBase + opposingOffset);
		candidateRecord = &PersistentUnitRoster[candidateIndex];
		if (candidateRecord->deploymentState == 0x00)
			continue;

		separation = (int16) CalculateApproximateMapDistance(
			ScenarioUnitMapX[candidateIndex],
			ScenarioUnitMapY[candidateIndex],
			ScenarioUnitMapX[unitIndex],
			ScenarioUnitMapY[unitIndex]);
		proximityRange = SensorDamageProximityRangeTable[
			candidateRecord->sensorHits];
		if (separation < proximityRange)
		{
			UnitEnemyInProximityRange[unitIndex] = TRUE;
			UnitEnemyEngagementActive[unitIndex] = TRUE;
			result = TRUE;
			break;
		}
	}

	return result;
}

/* 2208:2472 is reconstructed in Units/REVENGE_2208_INITIALIZATION.c. */

// 2208:18A1: void RebuildLanceFormationAfterLeaderLoss(word16 lanceBaseUnitIndex)
// Called from:
//      DestroyScenarioUnit
void RebuildLanceFormationAfterLeaderLoss(word16 lanceBaseUnitIndex)
{
	// Verified against 2208:18A1-1B32: select the surviving mobile lance leader,
	// copy its tactical order state to active followers, and rebuild follower
	// route points from FormationOffsetTable.
	word16 leaderUnitIndex = FindOperationalLanceLeader(lanceBaseUnitIndex);
	/* ASM compares only with 00FFh. FindOperationalLanceLeader returns
	 * FFFFh for an empty lance, after which 16-bit DGROUP indexing wraps at
	 * each subsequent array access. Separate host C arrays cannot reproduce
	 * that benign aliasing and would instead index 65535 elements forward.
	 * Treat the verified FFFFh no-unit result as the same empty-lance exit. */
	if (leaderUnitIndex == 0x00FF || leaderUnitIndex == 0xFFFF)
		return;

	int16 greatestActiveOrderValue = 0x00;
	word16 lanceOffset;
	for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
	{
		word16 unitIndex = lanceBaseUnitIndex + lanceOffset;
		if (UnitWasAttackedThisTick[unitIndex] != 0x00
			&& (int16)UnitConsecutiveAttackTicks[unitIndex]
				> greatestActiveOrderValue)
		{
			greatestActiveOrderValue =
				(int16)UnitConsecutiveAttackTicks[unitIndex];
		}
	}

	if (greatestActiveOrderValue > 0x03)
	{
		int16 linkedUnitIndex = UnitTacticalTarget[leaderUnitIndex];
		int16 linkedUnitDistance = (int16)CalculateApproximateMapDistance(
			ScenarioUnitMapX[leaderUnitIndex],
			ScenarioUnitMapY[leaderUnitIndex],
			ScenarioUnitMapX[linkedUnitIndex],
			ScenarioUnitMapY[linkedUnitIndex]);
		if (linkedUnitDistance < 0x06
			&& UnitTacticalOrderMode[leaderUnitIndex] !=
				TACTICAL_ORDER_SCRIPTED_ROUTE)
		{
			for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
			{
				word16 unitIndex = lanceBaseUnitIndex + lanceOffset;
				if (unitIndex != leaderUnitIndex)
					UnitLanceFormationState[unitIndex] = 0x02;
			}
		}
	}

	word16 facingBand = ScenarioUnitFacing[leaderUnitIndex];
	if (facingBand >= 0x01 && facingBand <= 0x03)
		facingBand = 0x0A;
	else if (facingBand == 0x04)
		facingBand = 0x14;
	else if (facingBand > 0x04)
		facingBand = 0x1E;

	word16 leaderFormationMode = UnitFormationMode[leaderUnitIndex] & 0x007F;
	word16 formationIndex = facingBand + leaderFormationMode;
	word16 formationSlot = 0x00;
	for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
	{
		word16 followerUnitIndex = lanceBaseUnitIndex + lanceOffset;
		if (followerUnitIndex == leaderUnitIndex
			|| UnitLanceFormationState[followerUnitIndex] != 0x00)
		{
			continue;
		}

		RevengeUnitRecord *followerUnit =
			&PersistentUnitRoster[followerUnitIndex];
		if (followerUnit->deploymentState == 0x00)
			continue;

		UnitTacticalOrderMode[followerUnitIndex] =
			UnitTacticalOrderMode[leaderUnitIndex];
		UnitAttackTarget[followerUnitIndex] =
			UnitAttackTarget[leaderUnitIndex];
		UnitTargetMapX[followerUnitIndex] =
			UnitTargetMapX[leaderUnitIndex];
		UnitTargetMapY[followerUnitIndex] =
			UnitTargetMapY[leaderUnitIndex];
		UnitOverburnOrCloseAssaultEnabled[followerUnitIndex] =
			UnitOverburnOrCloseAssaultEnabled[leaderUnitIndex];

		if (ScenarioUnitMapX[leaderUnitIndex]
				== UnitRouteTargetMapX[leaderUnitIndex]
			&& ScenarioUnitMapY[leaderUnitIndex]
				== UnitRouteTargetMapY[leaderUnitIndex])
		{
			int16 xOffset = FormationOffsetTable[
				formationIndex * 0x06 + formationSlot];
			int16 yOffset = FormationOffsetTable[
				formationIndex * 0x06 + formationSlot + 0x03];
			if (leaderFormationMode != 0x01 && leaderFormationMode != 0x08)
			{
				xOffset *= 0x03;
				yOffset *= 0x03;
			}

			int16 followerX = ScenarioUnitMapX[leaderUnitIndex] + xOffset;
			int16 followerY = ScenarioUnitMapY[leaderUnitIndex] + yOffset;
			if (followerX < 0x00)
				followerX = 0x00;
			else if (followerX >= MapWidth)
				followerX = MapWidth - 0x01;
			if (followerY < 0x00)
				followerY = 0x00;
			else if (followerY >= MapHeight)
				followerY = MapHeight - 0x01;

			UnitRouteTargetMapX[followerUnitIndex] = (byte)followerX;
			UnitRouteTargetMapY[followerUnitIndex] = (byte)followerY;
		}

		++formationSlot;
	}
}

// 2208:1B33: void SelectLanceFormationMode(
//     word16 leaderUnitIndex, word16 randomizeFormation)
// Choose a formation that can accommodate the deployed members of this lance.
// The deterministic path uses the scenario's lance profile, pilot experience,
// and relative lance strength; the randomized path searches a profile table
// for the first legal formation at or below a randomized experience slot.
// Verified against 2208:1B33-1CCB. Lance profile values are constrained by the
// game to 00h-03h; the original leaves its table pointer undefined otherwise.
void SelectLanceFormationMode(
	word16 leaderUnitIndex,
	word16 randomizeFormation)
{
	word16 lanceEndUnitIndex = (leaderUnitIndex + 0x04) & 0x00FC;
	word16 deployedUnitCount = 0x01;
	word16 followerUnitIndex;
	word16 maximumFormationId;
	RevengeUnitRecord *leaderRecord;
	byte lanceProfile;
	int16 formationCandidate;
	const byte *formationTable;

	for (followerUnitIndex = leaderUnitIndex + 0x01;
		followerUnitIndex < lanceEndUnitIndex;
		++followerUnitIndex)
	{
		if (UnitLanceFormationState[followerUnitIndex] != 0x01)
		{
			UnitMovementHeatExponent[followerUnitIndex] =
				UnitMovementHeatExponent[leaderUnitIndex];
		}

		RevengeUnitRecord *followerRecord =
			&PersistentUnitRoster[followerUnitIndex];
		if (followerRecord->deploymentState != 0x00)
			++deployedUnitCount;
	}

	if ((UnitFormationMode[leaderUnitIndex] & 0x80) != 0x00)
		return;

	if (deployedUnitCount <= 0x02)
		maximumFormationId = 0x02;
	else if (deployedUnitCount == 0x03)
		maximumFormationId = 0x05;
	else
		maximumFormationId = 0x0A;

	leaderRecord = &PersistentUnitRoster[leaderUnitIndex];
	lanceProfile = LanceFormationProfile[leaderUnitIndex >> 0x02];

	if (randomizeFormation == FALSE)
	{
		UnitFormationMode[leaderUnitIndex] = 0x08;
		if (lanceProfile == 0x01
			&& leaderRecord->pilotExperience != 0x00)
		{
			UnitFormationMode[leaderUnitIndex] = 0x02;
		}
		if (lanceProfile == 0x00
			&& leaderRecord->pilotExperience >= 0x02
			&& CompareLanceCombatRatings(
				leaderUnitIndex,
				UnitTacticalTarget[leaderUnitIndex]) > 0x00)
		{
			UnitFormationMode[leaderUnitIndex] = 0x06;
		}
		return;
	}

	formationCandidate =
		(GeneratePseudoRandomByte() % 0x03)
		+ leaderRecord->pilotExperience * 0x03;
	if (formationCandidate > 0x0B)
		formationCandidate = 0x0B;

	formationTable = FormationSelectionBalanced;
	if (lanceProfile == 0x01 || lanceProfile == 0x03)
		formationTable = FormationSelectionAggressive;
	else if (lanceProfile == 0x02)
		formationTable = FormationSelectionDefensive;

	for (; formationCandidate >= 0x00; --formationCandidate)
	{
		byte formationId = formationTable[formationCandidate];
		if (formationId <= maximumFormationId)
		{
			UnitFormationMode[leaderUnitIndex] = formationId;
			break;
		}
	}
}

// 2208:26B1: compare the five aggregate combat-rating fields of two lances.
// Verified against 2208:26B1-2828.
int16 CompareLanceCombatRatings(
	word16 firstUnitIndex,
	int16 secondUnitIndex)
{
	int16 *firstTotals = (int16 *)&DisplayedUnitCombatRatings;
	int16 *secondTotals = (int16 *)&ComparedUnitCombatRatings;
	int16 comparisonScore = 0x00;
	word16 lanceOffset;
	word16 ratingIndex;

	if (secondUnitIndex < 0x00 || secondUnitIndex >= 0x18)
		return 0x00;
	for (ratingIndex = 0x00; ratingIndex < 0x05; ++ratingIndex)
	{
		firstTotals[ratingIndex] = 0x00;
		secondTotals[ratingIndex] = 0x00;
	}

	for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
	{
		word16 firstIndex = (firstUnitIndex & 0x00FC) + lanceOffset;
		word16 secondIndex = ((word16) secondUnitIndex & 0x00FC) + lanceOffset;
		RevengeUnitRecord *firstUnit = &PersistentUnitRoster[firstIndex];
		RevengeUnitRecord *secondUnit = &PersistentUnitRoster[secondIndex];

		if (firstUnit->deploymentState != 0x00)
		{
			int16 *ratings = (int16 *)&UnitCombatRatings[firstIndex];
			RecalculateUnitCombatRatings(
				firstUnit,
				firstIndex, TRUE, FALSE);
			for (ratingIndex = 0x00; ratingIndex < 0x05; ++ratingIndex)
				firstTotals[ratingIndex] += ratings[ratingIndex];
		}
		if (secondUnit->deploymentState != 0x00)
		{
			int16 *ratings = (int16 *)&UnitCombatRatings[secondIndex];
			RecalculateUnitCombatRatings(
				secondUnit,
				secondIndex, TRUE, FALSE);
			for (ratingIndex = 0x00; ratingIndex < 0x05; ++ratingIndex)
				secondTotals[ratingIndex] += ratings[ratingIndex];
		}
	}

	for (ratingIndex = 0x00; ratingIndex < 0x05; ++ratingIndex)
	{
		if (firstTotals[ratingIndex] > secondTotals[ratingIndex])
			++comparisonScore;
		else if (firstTotals[ratingIndex] < secondTotals[ratingIndex])
			--comparisonScore;
	}

	return comparisonScore > 0x00 ? 0x01
		: comparisonScore < 0x00 ? -0x01 : 0x00;
}

// 2208:2829: advance the low-seven-bit lance formation mode modulo ten and
// set its high-bit changed/active flag.
void AdvanceLanceFormation(word16 unitIndex)
{
	word16 formationMode;

	formationMode =
		(UnitFormationMode[unitIndex] & 0x7F) + 0x01;
	if (formationMode >= 0x0A)
		formationMode = 0x00;
	UnitFormationMode[unitIndex] =
		(byte)(formationMode | 0x80);
}

// 2208:28A9: prompt for and apply a tactical movement destination. The
// selected coordinates are produced by 2208:0EBC in DS:8340/838E.
word16 SelectTacticalMoveDestination(
	word16 unitIndex, word16 selectionMode)
{
	word16 selectionAccepted;
	byte savedRouteX;
	byte savedRouteY;
	word16 unitType;

	SceneUnitRoutes[0x00] = SavedTacticalRoute;
	savedRouteX = UnitRouteTargetMapX[0x00];
	savedRouteY = UnitRouteTargetMapY[0x00];
	unitType = PersistentUnitRoster[unitIndex].unitTypeId;
	ShowTacticalCommandPrompt(UnitNameTable[unitType]);
	HideMouseCursorOverlay();
	RenderFormattedText(MoveDestinationPromptSuffix);
	ShowMouseCursorOverlay();
	selectionAccepted = SelectTacticalMoveDestinationInput(
		unitIndex, selectionMode);

	if (PendingNarrationDelay != 0x00)
	{
		if (unitIndex >= 0x04)
		{
			if ((unitIndex & 0x00FC) ==
				(ActiveNarrationSubject & 0x00FC))
			{
				PendingNarrationDelay = 0x00;
			}
		}
		else if (unitIndex == ActiveNarrationSubject)
		{
			PendingNarrationDelay = 0x00;
		}
	}

	if (selectionAccepted != FALSE)
	{
		if (unitIndex == 0x00 && FirstLanceOrdersEnabled == 0x00)
		{
			word16 followerIndex;
			for (followerIndex = 0x01; followerIndex < 0x04;
				++followerIndex)
			{
				if (UnitLanceFormationState[followerIndex] == 0x00)
				{
					UnitLanceFormationState[followerIndex] = 0x01;
					UnitConsecutiveAttackTicks[followerIndex] = 0x00;
					SceneUnitRoutes[followerIndex] =
						SavedTacticalRoute;
					UnitRouteTargetMapX[followerIndex] = savedRouteX;
					UnitRouteTargetMapY[followerIndex] = savedRouteY;
				}
			}
		}

		if (ScenarioUnitMapX[unitIndex] !=
			UnitRouteTargetMapX[unitIndex] ||
			ScenarioUnitMapY[unitIndex] !=
			UnitRouteTargetMapY[unitIndex])
		{
			RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
			if (unitRecord->walkMovement == 0x00)
			{
				NarrationEmphasis = 0x01;
				ActiveNarrationSubject = unitIndex;
				NarrationMessageCategory = 0x11;
				PendingNarrationDelay = 0x025D;
			}
			ScenarioUnitFacing[unitIndex] = (byte)
				DetermineRelativeAttackDirection(
					ScenarioUnitMapX[unitIndex],
					ScenarioUnitMapY[unitIndex],
					UnitRouteTargetMapX[unitIndex],
					UnitRouteTargetMapY[unitIndex]);
		}

		if (ValidatePrimaryLanceLeader(unitIndex) != FALSE)
		{
			word16 propagateFormation = unitIndex == 0x00
				? FirstLanceOrdersEnabled : 0x01;
			if (propagateFormation != FALSE)
			{
				word16 followerIndex;
				word16 lanceEnd = (unitIndex + 0x04) & 0x00FC;
				for (followerIndex = unitIndex + 0x01;
					followerIndex < lanceEnd; ++followerIndex)
				{
					UnitConsecutiveAttackTicks[followerIndex] = 0x00;
					UnitLanceFormationState[followerIndex] = 0x00;
				}
				SelectLanceFormationMode(unitIndex, TRUE);
			}
		}
		else if (unitIndex < 0x04)
		{
			UnitLanceFormationState[unitIndex] = 0x01;
		}
	}

	RedrawTacticalStatusPanel();
	return selectionAccepted;
}

// 2208:2853: test whether a selected leader has another deployed member in
// the remainder of its four-record lance. The first lance has an additional
// DS:B5D8 enable gate whose broader owner remains to be traced.
word16 HasActiveLanceFollowers(word16 unitIndex)
{
	word16 hasActiveFollower = FALSE;
	word16 candidateUnitIndex;
	word16 lanceEndUnitIndex;

	if (IsCurrentLanceLeader(unitIndex) != FALSE)
	{
		lanceEndUnitIndex = (unitIndex + 0x04) & 0x00FC;
		for (candidateUnitIndex = unitIndex + 0x01;
			candidateUnitIndex < lanceEndUnitIndex;
			++candidateUnitIndex)
		{
			RevengeUnitRecord *candidateUnit =
				&PersistentUnitRoster[candidateUnitIndex];
			if (candidateUnit->deploymentState != 0x00)
				hasActiveFollower = TRUE;
		}
	}
	if (unitIndex < 0x04
		&& FirstLanceOrdersEnabled == FALSE)
	{
		hasActiveFollower = FALSE;
	}
	return hasActiveFollower;
}

// 2208:2B0E: verify that a unit selected as a leader is still the first
// deployed, mobile member of the player's primary four-unit lance. Unit zero
// receives the same test when it has lost all walking movement. The original
// returns the Boolean in AX; Reko's earlier void signature discarded it.
word16 ValidatePrimaryLanceLeader(word16 unitIndex)
{
	word16 isValidLeader = IsCurrentLanceLeader(unitIndex);
	word16 candidateUnitIndex;

	if (isValidLeader != FALSE && unitIndex > 0x00 && unitIndex < 0x04)
	{
		for (candidateUnitIndex = 0x00;
			candidateUnitIndex < 0x04;
			++candidateUnitIndex)
		{
			RevengeUnitRecord *candidateUnit =
				&PersistentUnitRoster[candidateUnitIndex];
			if (candidateUnit->deploymentState != 0x00
				&& candidateUnit->walkMovement != 0x00)
			{
				if (candidateUnitIndex < unitIndex)
					isValidLeader = FALSE;
				break;
			}
		}
	}

	if (unitIndex == 0x00)
	{
		RevengeUnitRecord *primaryUnit = &PersistentUnitRoster[0x00];
		if (primaryUnit->walkMovement == 0x00)
		{
			for (candidateUnitIndex = 0x01;
				candidateUnitIndex < 0x04;
				++candidateUnitIndex)
			{
				RevengeUnitRecord *candidateUnit =
					&PersistentUnitRoster[candidateUnitIndex];
				if (candidateUnit->deploymentState != 0x00
					&& candidateUnit->walkMovement != 0x00)
				{
					isValidLeader = FALSE;
				}
			}
		}
	}

	return isValidLeader;
}
