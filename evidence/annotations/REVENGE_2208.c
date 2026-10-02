// Decompiled by Reko and maintained by the Revenge annotation project.

#include "REVENGE.h"

#define TACTICAL_ORDER_SCRIPTED_ROUTE   0x00
#define TACTICAL_ORDER_HOLD_POSITION    0x01
#define TACTICAL_ORDER_SEEK_AND_DESTROY 0x02

#define PERSISTENT_UNIT_ROSTER_OFFSET                 0x8B81
#define SENSOR_DAMAGE_PROXIMITY_RANGE_TABLE_OFFSET    0x03E7
#define TACTICAL_FORCE_FIRST_UNIT_OFFSET              0x0000
#define TACTICAL_FORCE_UNIT_COUNT                     0x000C
#define TACTICAL_FORCE_LAST_UNIT_OFFSET               0x000B
#define TACTICAL_ORDER_MODE_COUNT                     0x03
#define NARRATION_LEADER_SUBSTITUTION_FIRST_UNIT      0x0004
#define CONTACT_NARRATION_DELAY                       0x025D
#define CONTACT_NARRATION_CATEGORY_SCRIPTED_ROUTE     0x0006
#define CONTACT_NARRATION_CATEGORY_HOLD_POSITION      0x0004
#define CONTACT_NARRATION_CATEGORY_SEEK_AND_DESTROY   0x0003
#define NO_UNIT_INDEX                                 0xFFFF

void LoadUnitTemplateRecord_10CD(int16 unitType);
void UpdateUnitSpriteForFacing_1804(word16 unitIndex, word16 facing);
void RecalculateUnitCombatRatings_0005(
	byte __far *unitRecord,
	word16 unitSlot,
	word16 rebuildWeaponCounts,
	word16 advanceRecovery);
word16 HasUnitLineOfSight_1DA6(word16 sourceUnitIndex, word16 targetUnitIndex);
uint16 CalculateApproximateMapDistance_0D90(
	int16 sourceX, int16 sourceY, int16 targetX, int16 targetY);
word16 FindOperationalLanceLeader_2A30(word16 unitIndex);
word16 HasNarrationMessage_5476(
	word16 narrationSubject, word16 messageCategory);
byte GeneratePseudoRandomByte(void);
int16 CompareLanceCombatRatings_26B1(
	word16 firstUnitIndex, int16 secondUnitIndex);
void DrawLanceFormationMarker_2224(
	int16 formationCode, word16 tileColumnOffset);
void FormatTacticalMapCoordinates_25F0(word16 mapX, word16 mapY);
void HighlightLanceFollowers_2A8A(word16 leaderUnitIndex);
void RunTacticalUnitCommandMenu_000B(word16 unitIndex);
void RunTacticalGameOptionsMenu_148A(void);
word16 ValidatePrimaryLanceLeader_2B0E(word16 unitIndex);

// 2208:1829: word16 IsCurrentLanceLeader_1829(word16 unitIndex)
// Called from:
//      ApplyWeaponDamage_1E2B
//      DestroyScenarioUnit_2453
word16 IsCurrentLanceLeader_1829(word16 unitIndex)
{
	// V: Test whether this unit is the first deployed, mobile member of its
	// lance; primary-lance formation state 01h also identifies the leader.
	word16 isCurrentLeader = 0x00;
	word16 lanceBaseUnitIndex = unitIndex & 0x00FC;
	word16 lanceEndUnitIndex = (unitIndex + 0x04) & 0x00FC;

	if (unitIndex < 0x04
		&& seg3A6A->UnitLanceFormationState_B5B9[unitIndex] == 0x01)
	{
		isCurrentLeader = 0x01;
	}

	word16 candidateUnitIndex;
	for (candidateUnitIndex = lanceBaseUnitIndex;
		candidateUnitIndex < lanceEndUnitIndex;
		++candidateUnitIndex)
	{
		byte __far *candidateUnit = MAKE_FAR_POINTER(
			seg3A6A,
			0x8B81 + candidateUnitIndex * UNIT_RECORD_SIZE);
		if (candidateUnit[UNIT_FIELD_DEPLOYMENT_STATE] == 0x00
			|| candidateUnit[UNIT_FIELD_WALK_MOVEMENT] == 0x00)
		{
			continue;
		}

		if (candidateUnitIndex == unitIndex)
			isCurrentLeader = 0x01;
		break;
	}

	return isCurrentLeader;
}

// 2208:1CCC: int16 UpdateUnitEnemyVisibility_1CCC(word16 unitIndex)
// Called once per unit by RunTacticalInteractionLoop_0613.
int16 UpdateUnitEnemyVisibility_1CCC(word16 unitIndex)
{
	byte __far *unitRecord;
	byte __far *candidateRecord;
	byte __far *speakerRecord;
	word16 opposingBase;
	int16 opposingOffset;
	word16 candidateIndex;
	word16 hasVisibleEnemy;
	word16 visibleEnemyIndex;
	word16 narrationSubject;
	int16 hadContact;
	int16 orderMode;

	// Verified against 2208:1CCC-1E42.
	seg3A6A->UnitEnemyVisible_8667[unitIndex] = FALSE;
	hasVisibleEnemy = FALSE;
	visibleEnemyIndex = 0x00;
	hadContact = (int8_t)
		seg3A6A->UnitEnemyContactEstablished_87ED[unitIndex];
	opposingBase = 0x00;
	unitRecord = MAKE_FAR_POINTER(seg3A6A,
		(word16) (PERSISTENT_UNIT_ROSTER_OFFSET
			+ unitIndex * UNIT_RECORD_SIZE));
	if (unitRecord[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00)
	{
		if ((int16) unitIndex < TACTICAL_FORCE_UNIT_COUNT)
			opposingBase = TACTICAL_FORCE_UNIT_COUNT;
		for (opposingOffset = TACTICAL_FORCE_LAST_UNIT_OFFSET;
			opposingOffset >= 0x00;
			--opposingOffset)
		{
			candidateIndex = (word16) (opposingBase + opposingOffset);
			candidateRecord = MAKE_FAR_POINTER(
				seg3A6A,
				(word16) (PERSISTENT_UNIT_ROSTER_OFFSET
					+ candidateIndex * UNIT_RECORD_SIZE));
			if (candidateRecord[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00
				&& HasUnitLineOfSight_1DA6(unitIndex, candidateIndex) != FALSE)
			{
				seg3A6A->UnitEnemyVisible_8667[unitIndex] = TRUE;
				seg3A6A->UnitEnemyContactEstablished_87ED[unitIndex] = TRUE;
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
		seg3A6A->NarrationMessageDelay_B04B = CONTACT_NARRATION_DELAY;
		seg3A6A->NarrationEmphasis_wB585 = TRUE;
		orderMode = (int8_t)
			seg3A6A->UnitTacticalOrderMode_8B68[visibleEnemyIndex];
		switch (orderMode)
		{
		case TACTICAL_ORDER_SCRIPTED_ROUTE:
			seg3A6A->NarrationMessageCategory_8927 =
				CONTACT_NARRATION_CATEGORY_SCRIPTED_ROUTE;
			break;
		case TACTICAL_ORDER_HOLD_POSITION:
			seg3A6A->NarrationMessageCategory_8927 =
				CONTACT_NARRATION_CATEGORY_HOLD_POSITION;
			break;
		case TACTICAL_ORDER_SEEK_AND_DESTROY:
			seg3A6A->NarrationMessageCategory_8927 =
				CONTACT_NARRATION_CATEGORY_SEEK_AND_DESTROY;
			break;
		default:
			break;
		}
		seg3A6A->NarrationSourceUnit_B045 = unitIndex;

		narrationSubject = visibleEnemyIndex;
		if ((int16) narrationSubject >= NARRATION_LEADER_SUBSTITUTION_FIRST_UNIT
			&& (int16) narrationSubject < TACTICAL_FORCE_UNIT_COUNT
			&& IsCurrentLanceLeader_1829(narrationSubject) == FALSE)
		{
			narrationSubject = FindOperationalLanceLeader_2A30(narrationSubject);
		}
		seg3A6A->ActiveNarrationSubject_wB2F2 = narrationSubject;

		if (HasNarrationMessage_5476(narrationSubject,
			seg3A6A->NarrationMessageCategory_8927) == FALSE)
		{
			seg3A6A->ActiveNarrationSubject_wB2F2 = NO_UNIT_INDEX;
			for (narrationSubject = TACTICAL_FORCE_LAST_UNIT_OFFSET;
				;
				--narrationSubject)
			{
				speakerRecord = MAKE_FAR_POINTER(
					seg3A6A,
					(word16) (PERSISTENT_UNIT_ROSTER_OFFSET
						+ narrationSubject * UNIT_RECORD_SIZE));
				if (speakerRecord[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00
					&& HasNarrationMessage_5476(narrationSubject,
						seg3A6A->NarrationMessageCategory_8927) != FALSE)
				{
					seg3A6A->ActiveNarrationSubject_wB2F2 = narrationSubject;
					break;
				}
				if (narrationSubject == 0x00)
					break;
			}
			if (seg3A6A->ActiveNarrationSubject_wB2F2 == 0x00FF)
				seg3A6A->NarrationMessageDelay_B04B = 0x00;
		}
	}

	return hasVisibleEnemy;
}

// 2208:1E43: int16 UpdateUnitEnemyProximityState_1E43(word16 unitIndex)
// Once contact has been established, test whether any deployed opposing unit
// is closer than the 14h/0Ah/00h range indexed by that opposing record's
// zero/one/two sensor hits at +89h.
int16 UpdateUnitEnemyProximityState_1E43(word16 unitIndex)
{
	byte __far *candidateRecord;
	word16 opposingBase;
	word16 opposingOffset;
	word16 candidateIndex;
	int16 separation;
	int16 proximityRange;
	int16 result;

	// Verified against 2208:1E43-1F0B.
	seg3A6A->UnitEnemyInProximityRange_8680[unitIndex] = FALSE;
	result = FALSE;
	opposingBase = TACTICAL_FORCE_FIRST_UNIT_OFFSET;
	if ((int16) unitIndex < TACTICAL_FORCE_UNIT_COUNT)
		opposingBase = TACTICAL_FORCE_UNIT_COUNT;

	if (seg3A6A->UnitEnemyContactEstablished_87ED[unitIndex] == FALSE)
		return result;

	for (opposingOffset = TACTICAL_FORCE_FIRST_UNIT_OFFSET;
		opposingOffset < TACTICAL_FORCE_UNIT_COUNT;
		++opposingOffset)
	{
		candidateIndex = (word16) (opposingBase + opposingOffset);
		candidateRecord = MAKE_FAR_POINTER(
			seg3A6A,
			(word16) (PERSISTENT_UNIT_ROSTER_OFFSET
				+ candidateIndex * UNIT_RECORD_SIZE));
		if (candidateRecord[UNIT_FIELD_DEPLOYMENT_STATE] == 0x00)
			continue;

		separation = (int16) CalculateApproximateMapDistance_0D90(
			seg3A6A->ScenarioUnitMapX_8562[candidateIndex],
			seg3A6A->ScenarioUnitMapY_857B[candidateIndex],
			seg3A6A->ScenarioUnitMapX_8562[unitIndex],
			seg3A6A->ScenarioUnitMapY_857B[unitIndex]);
		proximityRange = (int8_t) SEGMENT_BYTE(seg3A6A,
			(word16) (SENSOR_DAMAGE_PROXIMITY_RANGE_TABLE_OFFSET
				+ (int16) (int8_t) candidateRecord[UNIT_FIELD_SENSOR_HITS]));
		if (separation < proximityRange)
		{
			seg3A6A->UnitEnemyInProximityRange_8680[unitIndex] = TRUE;
			seg3A6A->UnitEnemyEngagementActive_8806[unitIndex] = TRUE;
			result = TRUE;
			break;
		}
	}

	return result;
}

// 2208:2472: void InitializeScenarioUnitFromTemplate_2472(
//     word16 unitType, word16 unitIndex)
// PROPOSED: copy a 96h-byte unit template into the persistent roster while
// preserving the scenario-assigned allegiance byte, then initialize the
// tactical sprite, targeting, heat, and derived combat state.
void InitializeScenarioUnitFromTemplate_2472(
	word16 unitType,
	word16 unitIndex)
{
	byte __far *unitRecord = (byte __far *)MAKE_FAR_POINTER(
		seg3A6A,
		0x8B81 + unitIndex * UNIT_RECORD_SIZE);
	byte preservedAllegiance = unitRecord[UNIT_FIELD_ALLEGIANCE];
	word16 byteIndex;

	if (unitType != 0xFFFF)
	{
		byte __far *templateRecord;
		LoadUnitTemplateRecord_10CD((int16)unitType);
		templateRecord = (byte __far *)MAKE_FAR_POINTER(seg3A6A, 0x84C7);
		for (byteIndex = 0x00; byteIndex < UNIT_RECORD_SIZE; ++byteIndex)
			unitRecord[byteIndex] = templateRecord[byteIndex];
		unitRecord[UNIT_FIELD_DEPLOYMENT_STATE] = 0x01;
		unitRecord[UNIT_FIELD_ALLEGIANCE] = preservedAllegiance;
	}

	*(word16 __far *)MAKE_FAR_POINTER(seg3A6A, 0xA818 + unitIndex * 0x02) =
		*(word16 __far *)(unitRecord + UNIT_FIELD_TACTICAL_SPRITE_BASE) + 0x0100;
	if (unitIndex >= 0x0C)
	{
		word16 __far *spriteBase = (word16 __far *)MAKE_FAR_POINTER(
			seg3A6A,
			0xA818 + unitIndex * 0x02);
		if (unitRecord[UNIT_FIELD_DAMAGE_MODEL] == UNIT_DAMAGE_MODEL_INFANTRY)
			*spriteBase += 0x02;
		else
			*spriteBase += 0x08;
	}

	seg3A6A->UnitTacticalOrderMode_8B68[unitIndex] =
		TACTICAL_ORDER_SEEK_AND_DESTROY;
	seg3A6A->UnitAttackTarget_88F3[unitIndex] = 0xFF;
	*(word16 __far *)(unitRecord + UNIT_FIELD_HEAT_ACCUMULATOR_Q8_8) = 0x00;
	UpdateUnitSpriteForFacing_1804(unitIndex, 0x00);
	RecalculateUnitCombatRatings_0005(unitRecord, unitIndex, 0x01, 0x00);
}

// 2208:18A1: void RebuildLanceFormationAfterLeaderLoss_18A1(word16 lanceBaseUnitIndex)
// Called from:
//      DestroyScenarioUnit_2453
void RebuildLanceFormationAfterLeaderLoss_18A1(word16 lanceBaseUnitIndex)
{
	// PROPOSED NAME: select a surviving mobile lance leader, copy its tactical
	// order state to the other three records, and rebuild follower route points
	// from FormationOffsetTable_17DE. A future live trace should verify the exact
	// meanings of the remaining per-unit command-state arrays.
	word16 leaderUnitIndex = FindOperationalLanceLeader_2A30(lanceBaseUnitIndex);
	if (leaderUnitIndex == 0xFFFF)
		return;

	word16 greatestActiveOrderValue = 0x00;
	word16 lanceOffset;
	for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
	{
		word16 unitIndex = lanceBaseUnitIndex + lanceOffset;
		if (seg3A6A->UnitWasAttackedThisTick_87D4[unitIndex] != 0x00
			&& seg3A6A->UnitConsecutiveAttackTicks_B587[unitIndex]
				> greatestActiveOrderValue)
		{
			greatestActiveOrderValue =
				seg3A6A->UnitConsecutiveAttackTicks_B587[unitIndex];
		}
	}

	if (greatestActiveOrderValue > 0x03)
	{
		byte linkedUnitIndex = seg3A6A->UnitTacticalTarget_88A4[leaderUnitIndex];
		word16 linkedUnitDistance = CalculateApproximateMapDistance_0D90(
			seg3A6A->ScenarioUnitMapX_8562[leaderUnitIndex],
			seg3A6A->ScenarioUnitMapY_857B[leaderUnitIndex],
			seg3A6A->ScenarioUnitMapX_8562[linkedUnitIndex],
			seg3A6A->ScenarioUnitMapY_857B[linkedUnitIndex]);
		if (linkedUnitDistance < 0x06
			&& seg3A6A->UnitTacticalOrderMode_8B68[leaderUnitIndex] !=
				TACTICAL_ORDER_SCRIPTED_ROUTE)
		{
			for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
			{
				word16 unitIndex = lanceBaseUnitIndex + lanceOffset;
				if (unitIndex != leaderUnitIndex)
					seg3A6A->UnitLanceFormationState_B5B9[unitIndex] = 0x02;
			}
		}
	}

	word16 facingBand = seg3A6A->ScenarioUnitFacing_869A[leaderUnitIndex];
	if (facingBand >= 0x01 && facingBand <= 0x03)
		facingBand = 0x0A;
	else if (facingBand == 0x04)
		facingBand = 0x14;
	else if (facingBand > 0x04)
		facingBand = 0x1E;

	word16 leaderFormationMode = seg3A6A->UnitFormationMode_AE9D[leaderUnitIndex] & 0x007F;
	word16 formationIndex = facingBand + leaderFormationMode;
	word16 formationSlot = 0x00;
	for (lanceOffset = 0x00; lanceOffset < 0x04; ++lanceOffset)
	{
		word16 followerUnitIndex = lanceBaseUnitIndex + lanceOffset;
		if (followerUnitIndex == leaderUnitIndex
			|| seg3A6A->UnitLanceFormationState_B5B9[followerUnitIndex] != 0x00)
		{
			continue;
		}

		byte __far *followerUnit = MAKE_FAR_POINTER(
			seg3A6A,
			0x8B81 + followerUnitIndex * UNIT_RECORD_SIZE);
		if (followerUnit[UNIT_FIELD_DEPLOYMENT_STATE] == 0x00)
			continue;

		seg3A6A->UnitTacticalOrderMode_8B68[followerUnitIndex] =
			seg3A6A->UnitTacticalOrderMode_8B68[leaderUnitIndex];
		seg3A6A->UnitAttackTarget_88F3[followerUnitIndex] =
			seg3A6A->UnitAttackTarget_88F3[leaderUnitIndex];
		seg3A6A->UnitTargetMapX_8359[followerUnitIndex] =
			seg3A6A->UnitTargetMapX_8359[leaderUnitIndex];
		seg3A6A->UnitTargetMapY_83A7[followerUnitIndex] =
			seg3A6A->UnitTargetMapY_83A7[leaderUnitIndex];
		seg3A6A->UnitOverburnOrCloseAssaultEnabled_890C[followerUnitIndex] =
			seg3A6A->UnitOverburnOrCloseAssaultEnabled_890C[leaderUnitIndex];

		if (seg3A6A->ScenarioUnitMapX_8562[leaderUnitIndex]
				== seg3A6A->UnitRouteFirstX_8340[leaderUnitIndex]
			&& seg3A6A->ScenarioUnitMapY_857B[leaderUnitIndex]
				== seg3A6A->UnitRouteFirstY_838E[leaderUnitIndex])
		{
			int16 xOffset = seg3A6A->FormationOffsetTable_17DE[
				formationIndex * 0x06 + formationSlot];
			int16 yOffset = seg3A6A->FormationOffsetTable_17DE[
				formationIndex * 0x06 + formationSlot + 0x03];
			if (leaderFormationMode != 0x01 && leaderFormationMode != 0x08)
			{
				xOffset *= 0x03;
				yOffset *= 0x03;
			}

			int16 followerX = seg3A6A->ScenarioUnitMapX_8562[leaderUnitIndex] + xOffset;
			int16 followerY = seg3A6A->ScenarioUnitMapY_857B[leaderUnitIndex] + yOffset;
			if (followerX < 0x00)
				followerX = 0x00;
			else if (followerX >= seg3A6A->MapWidth_00A6)
				followerX = seg3A6A->MapWidth_00A6 - 0x01;
			if (followerY < 0x00)
				followerY = 0x00;
			else if (followerY >= seg3A6A->MapHeight_00A8)
				followerY = seg3A6A->MapHeight_00A8 - 0x01;

			seg3A6A->UnitRouteFirstX_8340[followerUnitIndex] = (byte)followerX;
			seg3A6A->UnitRouteFirstY_838E[followerUnitIndex] = (byte)followerY;
		}

		++formationSlot;
	}
}

// 2208:1B33: void SelectLanceFormationMode_1B33(
//     word16 leaderUnitIndex, word16 randomizeFormation)
// Choose a formation that can accommodate the deployed members of this lance.
// The deterministic path uses the scenario's lance profile, pilot experience,
// and relative lance strength; the randomized path searches a profile table
// for the first legal formation at or below a randomized experience slot.
void SelectLanceFormationMode_1B33(
	word16 leaderUnitIndex,
	word16 randomizeFormation)
{
	word16 lanceEndUnitIndex = (leaderUnitIndex + 0x04) & 0x00FC;
	word16 deployedUnitCount = 0x01;
	word16 followerUnitIndex;

	for (followerUnitIndex = leaderUnitIndex + 0x01;
		followerUnitIndex < lanceEndUnitIndex;
		++followerUnitIndex)
	{
		if (seg3A6A->UnitLanceFormationState_B5B9[followerUnitIndex] != 0x01)
		{
			seg3A6A->UnitMovementHeatExponent_99C7[followerUnitIndex] =
				seg3A6A->UnitMovementHeatExponent_99C7[leaderUnitIndex];
		}

		byte __far *followerRecord = MAKE_FAR_POINTER(
			seg3A6A,
			0x8B81 + followerUnitIndex * UNIT_RECORD_SIZE);
		if (followerRecord[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00)
			++deployedUnitCount;
	}

	if ((seg3A6A->UnitFormationMode_AE9D[leaderUnitIndex] & 0x80) != 0x00)
		return;

	word16 maximumFormationId;
	if (deployedUnitCount <= 0x02)
		maximumFormationId = 0x02;
	else if (deployedUnitCount == 0x03)
		maximumFormationId = 0x05;
	else
		maximumFormationId = 0x0A;

	byte __far *leaderRecord = MAKE_FAR_POINTER(
		seg3A6A,
		0x8B81 + leaderUnitIndex * UNIT_RECORD_SIZE);
	byte lanceProfile = seg3A6A->LanceFormationProfile_8650[
		leaderUnitIndex >> 0x02];

	if (randomizeFormation == FALSE)
	{
		seg3A6A->UnitFormationMode_AE9D[leaderUnitIndex] = 0x08;
		if (lanceProfile == 0x01
			&& leaderRecord[UNIT_FIELD_PILOT_EXPERIENCE] != 0x00)
		{
			seg3A6A->UnitFormationMode_AE9D[leaderUnitIndex] = 0x02;
		}
		if (lanceProfile == 0x00
			&& leaderRecord[UNIT_FIELD_PILOT_EXPERIENCE] >= 0x02
			&& CompareLanceCombatRatings_26B1(
				leaderUnitIndex,
				(signed char)seg3A6A->UnitTacticalTarget_88A4[leaderUnitIndex]) > 0x00)
		{
			seg3A6A->UnitFormationMode_AE9D[leaderUnitIndex] = 0x06;
		}
		return;
	}

	int16 formationCandidate =
		(GeneratePseudoRandomByte() % 0x03)
		+ leaderRecord[UNIT_FIELD_PILOT_EXPERIENCE] * 0x03;
	if (formationCandidate > 0x0B)
		formationCandidate = 0x0B;

	word16 formationTableOffset = 0x2F8A;
	if (lanceProfile == 0x01 || lanceProfile == 0x03)
		formationTableOffset = 0x2F72;
	else if (lanceProfile == 0x02)
		formationTableOffset = 0x2F7E;

	for (; formationCandidate >= 0x00; --formationCandidate)
	{
		byte formationId = SEGMENT_BYTE(
			seg3A6A, formationTableOffset + formationCandidate);
		if (formationId <= maximumFormationId)
		{
			seg3A6A->UnitFormationMode_AE9D[leaderUnitIndex] = formationId;
			break;
		}
	}
}

// 2208:26B1: compare the five aggregate combat-rating fields of two lances.
// Verified against 2208:26B1-2828.
int16 CompareLanceCombatRatings_26B1(
	word16 firstUnitIndex,
	int16 secondUnitIndex)
{
	word16 __far *firstTotals = (word16 __far *) MAKE_FAR_POINTER(seg3A6A, 0xB011);
	word16 __far *secondTotals = (word16 __far *) MAKE_FAR_POINTER(seg3A6A, 0xB01D);
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
		word16 firstUnitOffset = (word16)(0x8B81
			+ (word16)(firstIndex * UNIT_RECORD_SIZE));
		word16 secondUnitOffset = (word16)(0x8B81
			+ (word16)(secondIndex * UNIT_RECORD_SIZE));
		byte __far *firstUnit = MAKE_FAR_POINTER(
			seg3A6A, firstUnitOffset);
		byte __far *secondUnit = MAKE_FAR_POINTER(
			seg3A6A, secondUnitOffset);

		if (firstUnit[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00)
		{
			word16 ratingOffset = (word16)(0xAEF1
				+ (word16)(firstIndex * 0x000C));
			word16 __far *ratings = (word16 __far *) MAKE_FAR_POINTER(
				seg3A6A, ratingOffset);
			RecalculateUnitCombatRatings_0005(firstUnit, firstIndex, TRUE, FALSE);
			for (ratingIndex = 0x00; ratingIndex < 0x05; ++ratingIndex)
				firstTotals[ratingIndex] += ratings[ratingIndex];
		}
		if (secondUnit[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00)
		{
			word16 ratingOffset = (word16)(0xAEF1
				+ (word16)(secondIndex * 0x000C));
			word16 __far *ratings = (word16 __far *) MAKE_FAR_POINTER(
				seg3A6A, ratingOffset);
			RecalculateUnitCombatRatings_0005(secondUnit, secondIndex, TRUE, FALSE);
			for (ratingIndex = 0x00; ratingIndex < 0x05; ++ratingIndex)
				secondTotals[ratingIndex] += ratings[ratingIndex];
		}
	}

	for (ratingIndex = 0x00; ratingIndex < 0x05; ++ratingIndex)
	{
		if ((int16)firstTotals[ratingIndex] > (int16)secondTotals[ratingIndex])
			++comparisonScore;
		else if ((int16)firstTotals[ratingIndex] < (int16)secondTotals[ratingIndex])
			--comparisonScore;
	}

	return comparisonScore > 0x00 ? 0x01
		: comparisonScore < 0x00 ? -0x01 : 0x00;
}

// 2208:2853: test whether a selected leader has another deployed member in
// the remainder of its four-record lance. The first lance has an additional
// DS:B5D8 enable gate whose broader owner remains to be traced.
word16 HasActiveLanceFollowers_2853(word16 unitIndex)
{
	word16 hasActiveFollower = FALSE;
	word16 candidateUnitIndex;
	word16 lanceEndUnitIndex;

	if (IsCurrentLanceLeader_1829(unitIndex) != FALSE)
	{
		lanceEndUnitIndex = (unitIndex + 0x04) & 0x00FC;
		for (candidateUnitIndex = unitIndex + 0x01;
			candidateUnitIndex < lanceEndUnitIndex;
			++candidateUnitIndex)
		{
			byte __far *candidateUnit = MAKE_FAR_POINTER(
				seg3A6A, 0x8B81 + candidateUnitIndex * UNIT_RECORD_SIZE);
			if (candidateUnit[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00)
				hasActiveFollower = TRUE;
		}
	}
	if (unitIndex < 0x04
		&& seg3A6A->FirstLanceOrdersEnabled_B5D8 == FALSE)
	{
		hasActiveFollower = FALSE;
	}
	return hasActiveFollower;
}

// 2208:2B0E: verify that a unit selected as a leader is still the first
// deployed, mobile member of the player's primary four-unit lance. Unit zero
// receives the same test when it has lost all walking movement. The original
// returns the Boolean in AX; Reko's earlier void signature discarded it.
word16 ValidatePrimaryLanceLeader_2B0E(word16 unitIndex)
{
	word16 isValidLeader = IsCurrentLanceLeader_1829(unitIndex);
	word16 candidateUnitIndex;

	if (isValidLeader != FALSE && unitIndex > 0x00 && unitIndex < 0x04)
	{
		for (candidateUnitIndex = 0x00;
			candidateUnitIndex < 0x04;
			++candidateUnitIndex)
		{
			byte __far *candidateUnit = MAKE_FAR_POINTER(
				seg3A6A,
				PERSISTENT_UNIT_ROSTER_OFFSET
					+ candidateUnitIndex * UNIT_RECORD_SIZE);
			if (candidateUnit[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00
				&& candidateUnit[UNIT_FIELD_WALK_MOVEMENT] != 0x00)
			{
				if (candidateUnitIndex < unitIndex)
					isValidLeader = FALSE;
				break;
			}
		}
	}

	if (unitIndex == 0x00)
	{
		byte __far *primaryUnit = MAKE_FAR_POINTER(
			seg3A6A, PERSISTENT_UNIT_ROSTER_OFFSET);
		if (primaryUnit[UNIT_FIELD_WALK_MOVEMENT] == 0x00)
		{
			for (candidateUnitIndex = 0x01;
				candidateUnitIndex < 0x04;
				++candidateUnitIndex)
			{
				byte __far *candidateUnit = MAKE_FAR_POINTER(
					seg3A6A,
					PERSISTENT_UNIT_ROSTER_OFFSET
						+ candidateUnitIndex * UNIT_RECORD_SIZE);
				if (candidateUnit[UNIT_FIELD_DEPLOYMENT_STATE] != 0x00
					&& candidateUnit[UNIT_FIELD_WALK_MOVEMENT] != 0x00)
				{
					isValidLeader = FALSE;
				}
			}
		}
	}

	return isValidLeader;
}
