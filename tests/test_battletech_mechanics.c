#include "revenge/combat_data.h"
#include "revenge/original_data.h"
#include "revenge/random.h"
#include "revenge/unit.h"

#include <assert.h>
#include <stdlib.h>
#include <string.h>

uint16 Roll2D6(void);
word16 CountOrRemoveUnitHeatSinks(
	RevengeUnitRecord *unitRecord,
	word16 removeInstalledHeatSinks);
word16 CalculateUnitWeaponHeatScale(RevengeUnitRecord *unitRecord);
void ResetLiveUnitState(uint16 unitIndex);
byte AssignScenarioLanceAllegiances(word16 scenarioAllegianceIndex);
word16 IsCurrentLanceLeader(word16 unitIndex);
void RebuildLanceFormationAfterLeaderLoss(word16 lanceBaseUnitIndex);

static void VerifyDiceSequence(void)
{
	/* The generator starts at 34h:12h:76h in each test process. This checks
	 * die order as well as the original rejection of masked values zero/seven. */
	assert(Roll2D6() == 0x0A);
	assert(Roll2D6() == 0x09);
	assert(Roll2D6() == 0x08);
	assert(GeneratePseudoRandomByte() == 0xDA);
}

static void VerifyHeatSinkAccounting(void)
{
	RevengeUnitRecord unitRecord;

	memset(&unitRecord, 0x00, sizeof(unitRecord));
	unitRecord.engineHeatSinkCapacity = 0x08;
	unitRecord.headEquipment = EQUIPMENT_ID_HEAT_SINK;
	unitRecord.leftArmEquipment[0x00] = EQUIPMENT_ID_HEAT_SINK;
	unitRecord.leftArmEquipment[0x01] =
		EQUIPMENT_ID_HEAT_SINK | EQUIPMENT_DAMAGED_FLAG;

	assert(CountOrRemoveUnitHeatSinks(&unitRecord, FALSE) == 0x0A);
	assert(CountOrRemoveUnitHeatSinks(&unitRecord, TRUE) == 0x0A);
	assert(unitRecord.headEquipment == EQUIPMENT_SLOT_EMPTY);
	assert(unitRecord.leftArmEquipment[0x00] == EQUIPMENT_SLOT_EMPTY);
	assert(unitRecord.leftArmEquipment[0x01] ==
		(EQUIPMENT_ID_HEAT_SINK | EQUIPMENT_DAMAGED_FLAG));
}

static void VerifyWeaponHeatScale(void)
{
	RevengeUnitRecord unitRecord;

	memset(&unitRecord, 0x00, sizeof(unitRecord));
	unitRecord.walkMovement = 0x04;
	unitRecord.engineHeatSinkCapacity = 0x02;
	unitRecord.leftArmEquipment[0x00] =
		WEAPON_EQUIPMENT_ID(WEAPON_MEDIUM_LASER);
	unitRecord.leftArmEquipment[0x01] =
		WEAPON_EQUIPMENT_ID(WEAPON_MEDIUM_LASER);

	/* The original status estimate uses base heat two for a non-jumping unit,
	 * plus two medium lasers at heat three, minus two engine sinks: six. */
	assert(CalculateUnitWeaponHeatScale(&unitRecord) == 0x01);

	unitRecord.jumpMovement = 0x06;
	/* Any nonzero jump MP selects base heat five: 5 + 6 - 2 = 9. */
	assert(CalculateUnitWeaponHeatScale(&unitRecord) == 0x02);
}

static void VerifyUnitRecordViews(void)
{
	RevengeUnitRecord unitRecord;

	memset(&unitRecord, 0x00, sizeof(unitRecord));
	unitRecord.currentBattleMech.centerTorsoInternal = 0x15;
	unitRecord.currentBattleMech.centerRearTorsoArmor = 0x0C;
	unitRecord.lrm10Ammunition = 0x0078;

	assert(unitRecord.currentInternal[BATTLEMECH_LOCATION_CENTER_TORSO] == 0x15);
	assert(unitRecord.currentArmor[BATTLEMECH_ARMOR_CENTER_REAR_TORSO] == 0x0C);
	assert(unitRecord.currentAmmunition[
		AMMUNITION_INDEX(AMMUNITION_LRM_10)] == 0x0078);

	/* Vehicle templates share the executable's BattleMech-shaped durability
	 * storage. Do not imply an unsupported tabletop-facing projection here. */
	unitRecord.currentVehicle.internalSlot[VEHICLE_SHARED_LOCATION_3] = 0x22;
	assert(unitRecord.currentInternal[VEHICLE_SHARED_LOCATION_3] == 0x22);
}

static void VerifyVehicleTypeIdentifiers(void)
{
	assert(UNIT_TYPE_ROMMEL_TANK == 0x37);
	assert(UNIT_TYPE_PEGASUS == 0x38);
	assert(UNIT_TYPE_DRILLSON == 0x39);
	assert(UNIT_TYPE_MOBILE_HQ == 0x3A);
	assert(UNIT_TYPE_APC == 0x3B);
	assert(UNIT_TYPE_AMMO_CARRIER == 0x3C);
	assert(UNIT_TYPE_GALLEON == 0x3D);
	assert(UNIT_TYPE_SKULKER == 0x3E);
}

static void VerifyWeaponPriorityLists(void)
{
	word16 profileIndex;
	word16 expectedOffset = 0x09C6;

	for (profileIndex = 0x00;
		profileIndex < WEAPON_PRIORITY_PROFILE_COUNT;
		++profileIndex)
	{
		assert(WeaponPriorityListPointers[profileIndex].offset ==
			expectedOffset);
		assert(WeaponPriorityListPointers[profileIndex].segment ==
			0x3A6A);
		expectedOffset +=
			WeaponPriorityCountTable[profileIndex] *
			0x02 * sizeof(uint32);
	}

	assert(expectedOffset == 0x0F46);
}

static void VerifyScenarioUnitReset(void)
{
	RevengeUnitRecord *unitRecord = &LiveScenarioUnits[0x00];

	memset(unitRecord, 0x00, sizeof(*unitRecord));
	unitRecord->maximumInternal[BATTLEMECH_LOCATION_HEAD] = 0x09;
	unitRecord->maximumArmor[BATTLEMECH_ARMOR_HEAD] = 0x0C;
	unitRecord->weaponFamilyCounts[
		AMMUNITION_INDEX(AMMUNITION_AUTOCANNON_5)] = 0x02;
	unitRecord->leftArmEquipment[0x00] =
		WEAPON_EQUIPMENT_ID(WEAPON_AUTOCANNON_5) | EQUIPMENT_DAMAGED_FLAG;
	unitRecord->walkMovement = 0x00;
	unitRecord->engineHits = 0x02;
	unitRecord->currentHeat = 0x1E;
	unitRecord->heatAccumulator = 0x34;

	ResetLiveUnitState(0x00);

	assert(unitRecord->currentInternal[BATTLEMECH_LOCATION_HEAD] == 0x09);
	assert(unitRecord->currentArmor[BATTLEMECH_ARMOR_HEAD] == 0x0C);
	assert(unitRecord->autocannon5Ammunition ==
		AmmoCapacityMultiplierTable[
			AMMUNITION_INDEX(AMMUNITION_AUTOCANNON_5)] * 0x02);
	assert(unitRecord->leftArmEquipment[0x00] ==
		WEAPON_EQUIPMENT_ID(WEAPON_AUTOCANNON_5));
	assert(unitRecord->walkMovement == 0x04);
	assert(unitRecord->engineHits == 0x00);
	assert(unitRecord->currentHeat == 0x00);
	assert(unitRecord->heatAccumulator == 0x00);
}

static void VerifyScenarioAllegianceBands(void)
{
	word16 unitIndex;
	byte finalAllegiance = AssignScenarioLanceAllegiances(0x00);

	for (unitIndex = 0x00; unitIndex < 0x0C; ++unitIndex)
	{
		assert(PersistentUnitRoster[unitIndex].allegiance ==
			ScenarioLanceAllegianceTable[0x00][unitIndex / 0x04]);
	}
	assert(finalAllegiance == ScenarioLanceAllegianceTable[0x00][0x02]);
}

static void VerifyLanceFormationPropagation(void)
{
	word16 unitIndex;
	RevengeUnitRecord *leader = &PersistentUnitRoster[0x00];

	memset(PersistentUnitRoster, 0x00,
		0x04 * sizeof(PersistentUnitRoster[0x00]));
	memset(UnitLanceFormationState, 0x00, 0x04);
	for (unitIndex = 0x00; unitIndex < 0x04; ++unitIndex)
	{
		PersistentUnitRoster[unitIndex].deploymentState = 0x01;
		PersistentUnitRoster[unitIndex].walkMovement = 0x04;
	}
	MapWidth = 0x40;
	MapHeight = 0x40;
	ScenarioUnitMapX[0x00] = 0x20;
	ScenarioUnitMapY[0x00] = 0x20;
	UnitRouteTargetMapX[0x00] = 0x20;
	UnitRouteTargetMapY[0x00] = 0x20;
	ScenarioUnitFacing[0x00] = 0x00;
	UnitFormationMode[0x00] = 0x00;
	UnitTacticalOrderMode[0x00] = 0x01;
	UnitAttackTarget[0x00] = 0x0C;
	UnitTargetMapX[0x00] = 0x22;
	UnitTargetMapY[0x00] = 0x23;
	leader->pilotExperience = 0x02;

	assert(IsCurrentLanceLeader(0x00) != FALSE);
	assert(IsCurrentLanceLeader(0x01) == FALSE);
	RebuildLanceFormationAfterLeaderLoss(0x00);

	for (unitIndex = 0x01; unitIndex < 0x04; ++unitIndex)
	{
		word16 formationSlot = unitIndex - 0x01;
		assert(UnitTacticalOrderMode[unitIndex] ==
			0x01);
		assert(UnitAttackTarget[unitIndex] == 0x0C);
		assert(UnitRouteTargetMapX[unitIndex] ==
			0x20 + FormationOffsetTable[formationSlot] * 0x03);
		assert(UnitRouteTargetMapY[unitIndex] ==
			0x20 + FormationOffsetTable[formationSlot + 0x03] * 0x03);
	}
}

int main(void)
{
	VerifyDiceSequence();
	VerifyHeatSinkAccounting();
	VerifyWeaponHeatScale();
	VerifyUnitRecordViews();
	VerifyVehicleTypeIdentifiers();
	VerifyWeaponPriorityLists();
	VerifyScenarioUnitReset();
	VerifyScenarioAllegianceBands();
	VerifyLanceFormationPropagation();
	return EXIT_SUCCESS;
}
