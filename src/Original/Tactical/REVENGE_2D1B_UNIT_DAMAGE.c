// Procedures preserved from REVENGE_2D1B_TACTICAL_COMBAT.c.

#include "REVENGE_2D1B_INTERNAL.h"

// 2D1B:1E2B: void ApplyWeaponDamage(
//     Stack int16 attackerUnitIndex, Stack int16 weaponIndex,
//     Stack int16 targetUnitIndex)
// Called from:
//      ResolveWeaponAttack
void ApplyWeaponDamage(
	int16 attackerUnitIndex,
	int16 weaponIndex,
	int16 targetUnitIndex)
{
	// P: complete assembly-led translation. The overall attack/damage behavior
	// is established; a few global event flags and the special missile mode
	// remain named conservatively pending their controlling UI/state paths.
	RevengeUnitRecord *targetUnit;
	RevengeUnitRecord *attackerUnit;
	int16 damageRemaining;
	word16 durabilityBeforeHit = 0x00;
	word16 maximumDurabilityBeforeHit = 0x00;
	word16 relativeDirection;
	word16 hitTableSelector;
	word16 hitLocationCode;
	word16 internalLocation;
	word16 penetratedArmor;
	word16 equipmentSlotCount;
	word16 removeDestroyedUnit;
	byte *destroyedLocationEquipment;

	if (targetUnitIndex == 0x00 && ProtectUnitZero != 0x00)
		return;
	if (targetUnitIndex < 0x00 || targetUnitIndex >= TACTICAL_UNIT_COUNT)
		return;

	targetUnit = &PersistentUnitRoster[targetUnitIndex];
	if (targetUnit->deploymentState == 0x00)
		return;

	attackerUnit = &PersistentUnitRoster[attackerUnitIndex];

	if (targetUnitIndex < ENEMY_FORCE_FIRST_UNIT)
	{
		CalculateUnitDurabilityTotals(targetUnit);
		durabilityBeforeHit = CurrentUnitDurabilityTotal;
		maximumDurabilityBeforeHit = MaximumUnitDurabilityTotal;
	}

	damageRemaining = (int16) (byte)WeaponDefinitions[weaponIndex].damage;
	if (weaponIndex >= WEAPON_LRM_5
		&& attackerUnit->missileUpgradeState != 0x00)
	{
		// P: the shared upgrade byte means Improved Missiles for normal units;
		// infantry interpret it as Inferno Rockets in ResolveWeaponAttack.
		damageRemaining += (int16) (byte)
			ImprovedMissileDamageBonusTable[weaponIndex]; // P: ImprovedMissileDamageBonusTable
	}

	relativeDirection = DetermineRelativeAttackDirection(
		ScenarioUnitMapX[attackerUnitIndex],
		ScenarioUnitMapY[attackerUnitIndex],
		ScenarioUnitMapX[targetUnitIndex],
		ScenarioUnitMapY[targetUnitIndex]);
	if (relativeDirection >= BATTLETECH_DIRECTION_COUNT)
		relativeDirection = 0x00;

	hitTableSelector = HitLocationDirectionSelectorTable[
		BATTLETECH_DIRECTION_COUNT - relativeDirection
			+ ScenarioUnitFacing[targetUnitIndex]];
	if (targetUnit->damageModel == UNIT_DAMAGE_MODEL_INFANTRY)
		hitTableSelector = HIT_LOCATION_TABLE_INFANTRY;

	// A destroyed location cannot be selected again. Rear-facing armor codes
	// 08h and above normalize to their shared internal location with -06h.
	do
	{
		const word16 *hitLocations =
			HitLocationTable[hitTableSelector];
		hitLocationCode = hitLocations[
			Roll2D6() - BATTLETECH_2D6_MINIMUM];
		internalLocation = hitLocationCode >= BATTLEMECH_LOCATION_COUNT
			? hitLocationCode - 0x06
			: hitLocationCode;
	} while (targetUnit->currentInternal[internalLocation] == 0x00);

	if (targetUnitIndex == 0x00)
		LastAttackingUnitIndex = attackerUnitIndex;

	penetratedArmor = 0x01;
	if (targetUnit->currentArmor[hitLocationCode] != 0x00)
	{
		byte armorBeforeHit =
			targetUnit->currentArmor[hitLocationCode];
		penetratedArmor = 0x00;

		if (armorBeforeHit < damageRemaining)
		{
			damageRemaining -= armorBeforeHit;
			targetUnit->currentArmor[hitLocationCode] = 0x00;
			penetratedArmor = 0x01;
		}
		else
		{
			targetUnit->currentArmor[hitLocationCode] -=
				(byte) damageRemaining;
		}

		// V: the original grants a location-destroying result on a natural 12
		// for the head, arms, and legs, but not torso or rear-facing codes.
		if (Roll2D6() == BATTLETECH_2D6_NATURAL_TWELVE
			&& hitLocationCode < BATTLEMECH_LOCATION_COUNT
			&& (hitLocationCode < 0x02 || hitLocationCode > 0x04))
		{
			damageRemaining = BATTLETECH_CATASTROPHIC_LOCATION_DAMAGE;
			penetratedArmor = 0x01;
		}
	}

	if (penetratedArmor == 0x00
		|| targetUnit->currentInternal[internalLocation] == 0x00)
		goto CheckHalfDurabilityThreshold;

	if (internalLocation == BATTLEMECH_LOCATION_HEAD
		&& Roll2D6() >= BATTLETECH_2D6_CRITICAL_TARGET)
	{
		// V: head criticals select either one of two sensor hits or a
		// catastrophic cockpit/location result.
		if (((byte) GeneratePseudoRandomByte() & 0x01) != 0x00)
		{
			if (targetUnit->sensorHits < BATTLEMECH_MAX_SENSOR_HITS)
				++targetUnit->sensorHits;
		}
		else
		{
			damageRemaining = BATTLETECH_CATASTROPHIC_LOCATION_DAMAGE;
		}
	}

	if (internalLocation == BATTLEMECH_LOCATION_CENTER_TORSO
		&& Roll2D6() >= BATTLETECH_2D6_CRITICAL_TARGET
		&& Roll2D6() < 0x07)
	{
		// V: three center-torso engine criticals destroy the unit.
		++targetUnit->engineHits;
		if (targetUnit->engineHits >= BATTLEMECH_ENGINE_HITS_DESTROYED)
			damageRemaining = BATTLETECH_CATASTROPHIC_LOCATION_DAMAGE;
	}

	if (targetUnit->currentInternal[internalLocation]
		> damageRemaining)
	{
		targetUnit->currentInternal[internalLocation] -=
			(byte) damageRemaining;
		goto CheckHalfDurabilityThreshold;
	}

	targetUnit->currentInternal[internalLocation] = 0x00;
	equipmentSlotCount = 0x00;
	removeDestroyedUnit = 0x00;
	destroyedLocationEquipment = 0;

	switch (internalLocation)
	{
	case BATTLEMECH_LOCATION_HEAD:
		destroyedLocationEquipment = &targetUnit->headEquipment;
		equipmentSlotCount = BATTLEMECH_HEAD_EQUIPMENT_SLOT_COUNT;
		removeDestroyedUnit = 0x01;
		break;
	case BATTLEMECH_LOCATION_LEFT_ARM:
		destroyedLocationEquipment = targetUnit->leftArmEquipment;
		equipmentSlotCount = BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT;
		break;
	case BATTLEMECH_LOCATION_LEFT_TORSO:
		destroyedLocationEquipment = targetUnit->leftTorsoEquipment;
		equipmentSlotCount = BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT;
		break;
	case BATTLEMECH_LOCATION_CENTER_TORSO:
		destroyedLocationEquipment = targetUnit->centerTorsoEquipment;
		equipmentSlotCount = BATTLEMECH_CENTER_TORSO_EQUIPMENT_SLOT_COUNT;
		removeDestroyedUnit = 0x01;
		break;
	case BATTLEMECH_LOCATION_RIGHT_TORSO:
		destroyedLocationEquipment = targetUnit->rightTorsoEquipment;
		equipmentSlotCount = BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT;
		break;
	case BATTLEMECH_LOCATION_RIGHT_ARM:
		destroyedLocationEquipment = targetUnit->rightArmEquipment;
		equipmentSlotCount = BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT;
		break;
	case BATTLEMECH_LOCATION_LEFT_LEG:
		UnitJumpingState[targetUnitIndex] = 0x00;
		targetUnit->walkMovement = 0x00;
		destroyedLocationEquipment = targetUnit->leftLegEquipment;
		equipmentSlotCount = BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT;
		removeDestroyedUnit = ShouldDestroyUnitAfterLegLoss();
		break;
	case BATTLEMECH_LOCATION_RIGHT_LEG:
		UnitJumpingState[targetUnitIndex] = 0x00;
		targetUnit->walkMovement = 0x00;
		destroyedLocationEquipment = targetUnit->rightLegEquipment;
		equipmentSlotCount = BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT;
		removeDestroyedUnit = ShouldDestroyUnitAfterLegLoss();
		break;
	}

	ActiveNarrationSubject = attackerUnitIndex;
	if (removeDestroyedUnit != 0x00)
		DestroyScenarioUnit(targetUnitIndex);

	if (destroyedLocationEquipment != 0)
	{
		word16 equipmentIndex;
		byte firstEquipmentId = destroyedLocationEquipment[0x00];

		for (equipmentIndex = 0x00;
			 equipmentIndex < equipmentSlotCount;
			 ++equipmentIndex)
		{
			// V: this deliberately preserves the executable's unusual test of
			// firstEquipmentId + equipmentIndex, rather than testing each slot.
			// A later behavioral pass should determine whether this is an
			// original-game defect or a packed-location convention.
			if ((int16) firstEquipmentId + equipmentIndex != 0x00)
				destroyedLocationEquipment[equipmentIndex] |=
					EQUIPMENT_DAMAGED_FLAG;
		}
	}

	RecalculateUnitCombatRatings(
		targetUnit, targetUnitIndex, 0x01, 0x01);

CheckHalfDurabilityThreshold:
	if (targetUnit->deploymentState != 0x00
		&& targetUnitIndex < ENEMY_FORCE_FIRST_UNIT
		&& IsCurrentLanceLeader(targetUnitIndex) != 0x00
		&& durabilityBeforeHit << 0x01 >= maximumDurabilityBeforeHit)
	{
		CalculateUnitDurabilityTotals(targetUnit);
		if (CurrentUnitDurabilityTotal << 0x01
			< MaximumUnitDurabilityTotal)
		{
			// P: queue the first friendly-unit-below-half-durability event.
			NarrationMessageCategory = 0x00;
			ActiveNarrationSubject = targetUnitIndex;
			NarrationEmphasis = 0x01;
			PendingNarrationDelay = 0x025D;
		}
	}
}

