// REVENGE_2D1B_WEAPONS.c
// Procedures preserved from REVENGE_2D1B_TACTICAL_COMBAT.c.

#include "REVENGE_2D1B_INTERNAL.h"

// 2D1B:14A4: word16 ExecuteUnitWeaponAI(word16 unitIndex)
// Classify range, heat, and attack direction, select the first ready weapon
// from the appropriate priority profile, and return whether an attack occurred.
// Verified against 2D1B:14A4-1803.
word16 ExecuteUnitWeaponAI(word16 unitIndex)
{
	RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
	word16 mayAttack = FALSE;
	word16 attackOccurred = FALSE;

	if (UnitTacticalOrderMode[unitIndex] ==
			TACTICAL_ORDER_SEEK_AND_DESTROY
		|| UnitAttackTarget[unitIndex] != TACTICAL_TARGET_NONE
		|| UnitTacticalOrderMode[unitIndex] ==
			TACTICAL_ORDER_HOLD_POSITION)
	{
		mayAttack = TRUE;
	}

	if (mayAttack != FALSE)
	{
		if (UnitShutdownState[unitIndex] != FALSE)
		{
			mayAttack = FALSE;
		}
		else
		{
			word16 heatLimitIndex =
				unitRecord->pilotExperience + 0x01;
			if (UnitOverburnOrCloseAssaultEnabled[unitIndex] != 0x00)
				--heatLimitIndex;
			if (unitRecord->currentHeat
				> WeaponAIHeatLimitByExperience[heatLimitIndex])
			{
				mayAttack = FALSE;
			}
		}
	}

	if (mayAttack == FALSE)
		return FALSE;

	int16 targetIndex = UnitTacticalTarget[unitIndex];
	if (targetIndex != TACTICAL_TARGET_MAP_CELL
		&& (targetIndex < 0x00 || targetIndex >= TACTICAL_TARGET_MAP_CELL
			|| PersistentUnitRoster[targetIndex].deploymentState == 0x00))
	{
		return FALSE;
	}

	word16 targetX;
	word16 targetY;
	if (targetIndex == TACTICAL_TARGET_MAP_CELL)
	{
		targetX = UnitTargetMapX[unitIndex];
		targetY = UnitTargetMapY[unitIndex];
	}
	else
	{
		targetX = ScenarioUnitMapX[targetIndex];
		targetY = ScenarioUnitMapY[targetIndex];
	}

	word16 distance = CalculateApproximateMapDistance(
		ScenarioUnitMapX[unitIndex],
		ScenarioUnitMapY[unitIndex],
		targetX,
		targetY);
	if (distance > WEAPON_AI_MAXIMUM_ATTACK_DISTANCE)
		return FALSE;

	word16 selectionMask = 0x00;
	if (distance < WEAPON_AI_LONG_RANGE_DISTANCE)
		selectionMask |= 0x40;
	if (distance < WEAPON_AI_MEDIUM_RANGE_DISTANCE)
		selectionMask |= 0x20;
	if (distance < WEAPON_AI_CLOSE_RANGE_DISTANCE)
		selectionMask |= 0x10;

	word16 currentHeat = unitRecord->currentHeat;
	if (currentHeat == 0x00)
		selectionMask |= 0x01;
	else if (currentHeat < WEAPON_AI_LOW_HEAT_LIMIT)
		selectionMask |= 0x02;
	else if (currentHeat < WEAPON_AI_MEDIUM_HEAT_LIMIT)
		selectionMask |= 0x04;
	else
		selectionMask |= 0x08;

	// Preserve the original ground-target quirk: direction classification uses
	// pseudo-slot 18h at the byte immediately after each 24-entry coordinate
	// array rather than UnitTargetMapX/Y, although distance used the latter.
	word16 directionTargetX = targetIndex < TACTICAL_UNIT_COUNT
		? ScenarioUnitMapX[targetIndex]
		: DropShipMapX;
	word16 directionTargetY = targetIndex < TACTICAL_UNIT_COUNT
		? ScenarioUnitMapY[targetIndex]
		: DropShipMapY;
	int16 attackDirection = DetermineRelativeAttackDirection(
		ScenarioUnitMapX[unitIndex],
		ScenarioUnitMapY[unitIndex],
		directionTargetX,
		directionTargetY);
	if (attackDirection < 0x00 || attackDirection >= BATTLETECH_DIRECTION_COUNT)
		attackDirection = 0x00;

	word16 arcDirection = ScenarioUnitFacing[unitIndex] + 0x03;
	word16 arcStep;
	word16 inRestrictedArc = FALSE;
	for (arcStep = 0x00; arcStep < 0x03 && inRestrictedArc == FALSE; ++arcStep)
	{
		if ((arcDirection++ & (BATTLETECH_DIRECTION_COUNT - 0x01)) ==
			(word16)attackDirection)
			inRestrictedArc = TRUE;
	}
	if (inRestrictedArc != FALSE)
		BuildArmWeaponAvailabilityMasks(unitIndex);

	word16 priorityProfile =
		WeaponPriorityProfileByRangeHeat[selectionMask];
	word16 priorityCount = WeaponPriorityCountTable[priorityProfile];
	DosAddress priorityListPointer =
		WeaponPriorityListPointers[priorityProfile];
	const uint32 *priorityTable =
		&WeaponPriorityData.entries[
			(priorityListPointer.offset - 0x09C6) / sizeof(uint32)];
	uint32 availability = UnitWeaponAvailabilityMask[unitIndex];
	word16 priorityIndex;
	word16 selectedWeaponId = 0x00;

	for (priorityIndex = 0x00;
		priorityIndex < priorityCount && selectedWeaponId == 0x00;
		++priorityIndex)
	{
		uint32 priorityMask = priorityTable[priorityIndex];
		if ((priorityMask & availability) != 0x00)
		{
			selectedWeaponId =
				(word16) priorityTable[priorityCount + priorityIndex];
		}
	}

	if (selectedWeaponId == 0x00)
		return FALSE;

	if (unitRecord->damageModel == UNIT_DAMAGE_MODEL_INFANTRY
		&& UnitOverburnOrCloseAssaultEnabled[unitIndex] != 0x00)
	{
		// Close assault temporarily supplies one round for weapon index 0Ah and,
		// if accepted, lets a unit target resolve the reciprocal assault. The
		// command UI labels state zero/one "Close Assault"/"Cease Assault" for
		// infantry; non-infantry uses the same byte for overburn.
		++unitRecord->autocannon5Ammunition;
		attackOccurred = ResolveWeaponAttack(
			unitIndex, WEAPON_AUTOCANNON_5, targetIndex);
		if (attackOccurred != FALSE)
		{
			// The executable performs the reciprocal close-assault access even
			// for pseudo-target 18h; retain that original boundary behavior.
			RevengeUnitRecord *targetRecord = &PersistentUnitRoster[targetIndex];
			++targetRecord->autocannon5Ammunition;
			if (ResolveWeaponAttack(
				targetIndex, WEAPON_AUTOCANNON_5, unitIndex) == FALSE)
			{
				--targetRecord->autocannon5Ammunition;
			}
		}
		else if (attackOccurred == FALSE)
		{
			--unitRecord->autocannon5Ammunition;
		}
	}
	else
	{
		attackOccurred = ResolveWeaponAttack(
			unitIndex, selectedWeaponId - 0x01, targetIndex);
	}

	if (attackOccurred != FALSE)
	{
		if (targetIndex < TACTICAL_UNIT_COUNT)
			UnitWasAttackedThisTick[targetIndex] = TRUE;
		else
			GroundTargetWasAttacked = TRUE;
	}
	return attackOccurred;
}

