#include "revenge/combat_data.h"
#include "revenge/original_data.h"
#include "revenge/unit.h"
#include "../src/Original/REVENGE.h"

#include <assert.h>
#include <stdlib.h>
#include <string.h>

void ApplyWeaponDamage(
	int16 attackerUnitIndex, int16 weaponIndex, int16 targetUnitIndex);
static word16 SumArmor(const RevengeUnitRecord *unitRecord)
{
	word16 total = 0x00;
	word16 locationIndex;

	for (locationIndex = 0x00;
		locationIndex < BATTLEMECH_ARMOR_LOCATION_COUNT;
		++locationIndex)
	{
		total += unitRecord->currentArmor[locationIndex];
	}
	return total;
}

static void PrepareCombatants(void)
{
	word16 locationIndex;
	RevengeUnitRecord *attacker = &PersistentUnitRoster[0x00];
	RevengeUnitRecord *target =
		&PersistentUnitRoster[ENEMY_FORCE_FIRST_UNIT];

	memset(PersistentUnitRoster, 0x00,
		sizeof(PersistentUnitRoster));
	attacker->deploymentState = 0x01;
	attacker->walkMovement = 0x04;
	target->deploymentState = 0x01;
	target->walkMovement = 0x04;
	for (locationIndex = 0x00;
		locationIndex < BATTLEMECH_LOCATION_COUNT;
		++locationIndex)
	{
		target->currentInternal[locationIndex] = 0x14;
		target->maximumInternal[locationIndex] = 0x14;
	}
	for (locationIndex = 0x00;
		locationIndex < BATTLEMECH_ARMOR_LOCATION_COUNT;
		++locationIndex)
	{
		target->currentArmor[locationIndex] = 0x14;
		target->maximumArmor[locationIndex] = 0x14;
	}
	ScenarioUnitMapX[0x00] = 0x02;
	ScenarioUnitMapY[0x00] = 0x02;
	ScenarioUnitMapX[ENEMY_FORCE_FIRST_UNIT] = 0x03;
	ScenarioUnitMapY[ENEMY_FORCE_FIRST_UNIT] = 0x02;
	ScenarioUnitFacing[ENEMY_FORCE_FIRST_UNIT] = 0x00;
}

static void VerifyHitLocationAndArmorDamage(void)
{
	RevengeUnitRecord *target;
	word16 armorBefore;
	word16 internalBefore;
	word16 locationIndex;

	PrepareCombatants();
	target = &PersistentUnitRoster[ENEMY_FORCE_FIRST_UNIT];
	armorBefore = SumArmor(target);
	internalBefore = 0x00;
	for (locationIndex = 0x00;
		locationIndex < BATTLEMECH_LOCATION_COUNT;
		++locationIndex)
	{
		internalBefore += target->currentInternal[locationIndex];
	}

	/* The initial deterministic 2D6 roll selects a valid directional hit
	 * location. Twenty points of armor prevents penetration, so the machine
	 * gun's two damage must remain entirely in that selected armor location. */
	ApplyWeaponDamage(
		0x00, WEAPON_MACHINE_GUN, ENEMY_FORCE_FIRST_UNIT);
	assert(SumArmor(target) ==
		armorBefore - WeaponDefinitions[WEAPON_MACHINE_GUN].damage);
	for (locationIndex = 0x00;
		locationIndex < BATTLEMECH_LOCATION_COUNT;
		++locationIndex)
	{
		internalBefore -= target->currentInternal[locationIndex];
	}
	assert(internalBefore == 0x00);
}

int main(void)
{
	VerifyHitLocationAndArmorDamage();
	return EXIT_SUCCESS;
}


