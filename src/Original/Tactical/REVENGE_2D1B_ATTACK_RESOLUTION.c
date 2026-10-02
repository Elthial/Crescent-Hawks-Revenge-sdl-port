// Procedures preserved from REVENGE_2D1B_TACTICAL_COMBAT.c.

#include "REVENGE_2D1B_INTERNAL.h"

// 2D1B:1854: int16 ResolveWeaponAttack(
//     Stack int16 attackerUnitIndex, Stack int16 weaponIndex,
//     Stack int16 targetUnitIndex)
int16 ResolveWeaponAttack(
	int16 attackerUnitIndex,
	int16 weaponIndex,
	int16 targetUnitIndex)
{
	// P: complete assembly-led translation of the attack gate, to-hit roll,
	// ammunition/heat/recovery updates, presentation, and damage dispatch.
	// A return value of one means the attack reached the valid to-hit/ammunition
	// stage; it does not mean the shot hit.
	RevengeUnitRecord *attackerUnit;
	RevengeUnitRecord *targetUnit = 0;
	const RevengeWeaponDefinition *weaponDefinition;
	uint16 targetX;
	uint16 targetY;
	uint16 distance;
	word16 hasLineOfSight;
	int16 toHitModifier = 0x00;
	int16 toHitTarget;
	word16 ammunitionFamily;
	word16 shotHit;
	word16 attackWasAccepted = 0x00;

	if (targetUnitIndex == TACTICAL_TARGET_NONE)
		return 0x00;

	attackerUnit = &PersistentUnitRoster[attackerUnitIndex];
	weaponDefinition = &WeaponDefinitions[weaponIndex];

	if (targetUnitIndex == TACTICAL_TARGET_MAP_CELL)
	{
		// Target 18h is a map/structure target rather than a roster unit.
		targetX = UnitTargetMapX[attackerUnitIndex];
		targetY = UnitTargetMapY[attackerUnitIndex];
		hasLineOfSight = TraceMapLineOfSight(
			ScenarioUnitMapX[attackerUnitIndex],
			ScenarioUnitMapY[attackerUnitIndex],
			targetX,
			targetY,
			TerrainTypeMap,
			TerrainImpactAnimationTypeMinimum,
			TerrainImpactAnimationTypeMaximum,
			(byte)TerrainLineOfSightBlockingThreshold,
			TerrainLineOfSightMaximumSteps);
		toHitModifier = -0x04;
	}
	else
	{
		targetUnit = &PersistentUnitRoster[targetUnitIndex];
		targetX = ScenarioUnitMapX[targetUnitIndex];
		targetY = ScenarioUnitMapY[targetUnitIndex];
		hasLineOfSight = HasUnitLineOfSight(
			attackerUnitIndex, targetUnitIndex);
	}

	if (weaponIndex >= WEAPON_LRM_5
		&& weaponIndex <= WEAPON_LRM_20
		&& hasLineOfSight == 0x00)
	{
		// P: LRMs may use another active unit on the attacker's side as a
		// spotter. Record +8Eh gates that capability; Rifleman+ is the only
		// immutable template that starts with it enabled.
		int16 sideStart = attackerUnitIndex >= ENEMY_FORCE_FIRST_UNIT
			? ENEMY_FORCE_FIRST_UNIT : FRIENDLY_FORCE_FIRST_UNIT;
		int16 sideUnit;
		for (sideUnit = 0x00; sideUnit < TACTICAL_FORCE_UNIT_COUNT; ++sideUnit)
		{
			int16 spotterIndex = sideStart + sideUnit;
			RevengeUnitRecord *spotter = &PersistentUnitRoster[spotterIndex];
			if (spotter->deploymentState != 0x00
				&& spotter->indirectFireSpotter != 0x00
				&& HasUnitLineOfSight(
					spotterIndex, targetUnitIndex) != 0x00)
			{
				hasLineOfSight = 0x01;
				toHitModifier = -0x06;
				break;
			}
		}
	}

	if (hasLineOfSight == 0x00)
		return 0x00;

	distance = CalculateApproximateMapDistance(
		ScenarioUnitMapX[attackerUnitIndex],
		ScenarioUnitMapY[attackerUnitIndex],
		targetX,
		targetY);
	toHitTarget = toHitModifier
		+ (int16) (byte) attackerUnit->gunneryTargetNumber;

	if (targetUnitIndex != TACTICAL_TARGET_MAP_CELL)
	{
		toHitTarget +=
			(int16) (byte) targetUnit->targetMovementModifier;
		if (targetUnit->walkMovement == 0x00)
			toHitTarget -= 0x04;
	}

	if (weaponIndex == WEAPON_SMALL_PULSE_LASER
		|| weaponIndex == WEAPON_MEDIUM_PULSE_LASER
		|| weaponIndex == WEAPON_LARGE_PULSE_LASER)
	{
		// V: the three pulse-laser definitions receive a -2 to-hit bonus.
		toHitTarget -= 0x02;
	}

	if (distance > weaponDefinition->maximumRangeUnits)
		toHitTarget += 0x02;
	if (distance > weaponDefinition->maximumRangeUnits * 0x02)
		toHitTarget += 0x02;
	if (distance <= weaponDefinition->minimumRange)
	{
		// V: the executable adds distance - minimumRange. This makes close
		// shots easier, opposite the tabletop minimum-range penalty. Preserve
		// the shipped behavior rather than silently correcting it.
		toHitTarget += distance
			- weaponDefinition->minimumRange;
	}

	toHitTarget += attackerUnit->currentHeat / BATTLEMECH_HEAT_SCALE;
	if (UnitJumpingState[attackerUnitIndex] != 0x00)
		toHitTarget += 0x03;
	if (targetUnitIndex != TACTICAL_TARGET_MAP_CELL)
	{
		toHitTarget +=
			TerrainToHitModifier[UnitTerrainType[targetUnitIndex]];
		toHitTarget += UnitJumpingState[targetUnitIndex];
	}

	if (toHitTarget > BATTLETECH_MAX_TO_HIT_TARGET)
		toHitTarget = BATTLETECH_MAX_TO_HIT_TARGET;
	attackWasAccepted = 0x01;
	ammunitionFamily = weaponDefinition->ammunitionFamilyId;
	if (ammunitionFamily != AMMUNITION_NONE
		&& attackerUnit->currentAmmunition[
			AMMUNITION_INDEX(ammunitionFamily)] == 0x00)
	{
		return attackWasAccepted;
	}

	UnitWeaponRecoveryCounters[
		attackerUnitIndex * WEAPON_DEFINITION_COUNT + weaponIndex]
		+= weaponDefinition->recoveryDelayTicks;
	attackerUnit->currentHeat +=
		weaponDefinition->heat;
	if (ammunitionFamily != AMMUNITION_NONE)
	{
		--attackerUnit->currentAmmunition[
			AMMUNITION_INDEX(ammunitionFamily)];
	}

	shotHit = (int16) Roll2D6() >= toHitTarget;
	if (targetUnitIndex == TACTICAL_TARGET_MAP_CELL && shotHit != 0x00)
	{
		ApplyTerrainImpact(targetX, targetY, TRUE, FALSE);
		if (ReadTerrainDamageState(targetX, targetY) == 0x03)
		{
			int16 unitIndex;
			for (unitIndex = 0x00; unitIndex < TACTICAL_UNIT_COUNT; ++unitIndex)
			{
				RevengeUnitRecord *unit = &PersistentUnitRoster[unitIndex];
				if (unit->deploymentState != 0x00
					&& UnitAttackTarget[unitIndex] == TACTICAL_TARGET_MAP_CELL
					&& UnitTargetMapX[unitIndex] == targetX
					&& UnitTargetMapY[unitIndex] == targetY)
				{
					UnitAttackTarget[unitIndex] = TACTICAL_TARGET_NONE;
				}
			}
		}
	}

	if (weaponIndex <= WEAPON_MACHINE_GUN)
	{
		DrawWeaponAttackTrace(
			attackerUnitIndex,
			targetX,
			targetY,
			0x00,
			shotHit,
			weaponIndex);
	}

	if (weaponIndex >= WEAPON_LRM_5)
	{
		if (attackerUnit->damageModel == UNIT_DAMAGE_MODEL_INFANTRY
			&& attackerUnit->missileUpgradeState != 0x00)
		{
			RevengeUnitRecord *missileTarget =
				&PersistentUnitRoster[targetUnitIndex];
			missileTarget->currentHeat += INFERNO_MISSILE_HEAT;
			shotHit = 0x00;
		}
		QueueTacticalProjectile(
			attackerUnitIndex,
			(byte) weaponIndex,
			targetUnitIndex,
			shotHit);
		shotHit = 0x00;
	}

	DispatchWeaponEffect(weaponDefinition->effectId);
	if (shotHit != 0x00)
	{
		word16 impactScale =
			weaponDefinition->damage > HEAVY_WEAPON_DAMAGE_THRESHOLD
				? 0x01 : 0x0A;
		QueueTacticalImpactVisual(targetX, targetY, impactScale);
		if (targetUnitIndex >= 0x00 && targetUnitIndex < TACTICAL_UNIT_COUNT)
		{
			ApplyWeaponDamage(
				attackerUnitIndex, weaponIndex, targetUnitIndex);
		}
	}

	return attackWasAccepted;
}

// 2D1B:1DA6: word16 HasUnitLineOfSight(
//     Stack int16 sourceUnitIndex, Stack int16 targetUnitIndex)
// Verified against 2D1B:1DA6-1DF3.
word16 HasUnitLineOfSight(
	int16 sourceUnitIndex,
	int16 targetUnitIndex)
{
	return TraceMapLineOfSight(
		ScenarioUnitMapX[(word16) sourceUnitIndex],
		ScenarioUnitMapY[(word16) sourceUnitIndex],
		ScenarioUnitMapX[(word16) targetUnitIndex],
		ScenarioUnitMapY[(word16) targetUnitIndex],
		TerrainTypeMap,
		TerrainImpactAnimationTypeMinimum,
		TerrainImpactAnimationTypeMaximum,
		(byte)TerrainLineOfSightBlockingThreshold,
		TerrainLineOfSightMaximumSteps);
}

