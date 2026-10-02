/* Scenario-unit initialization procedure from original segment 2208. */

#include "REVENGE.h"

#include "revenge/original_data.h"

enum
{
	TACTICAL_ORDER_SEEK_AND_DESTROY = 0x02
};

void LoadUnitTemplateRecord(int16 unitType);
void UpdateUnitSpriteForFacing(word16 unitIndex, word16 facing);
void RecalculateUnitCombatRatings(
	RevengeUnitRecord *unitRecord,
	word16 unitIndex,
	word16 rebuildWeaponCounts,
	word16 advanceRecovery);

/* 2208:2472-2587 */
void InitializeScenarioUnitFromTemplate(
	word16 unitType,
	word16 unitIndex)
{
	RevengeUnitRecord *unitRecord;
	byte preservedAllegiance;
	word16 tacticalSpriteBase;

	unitRecord = &PersistentUnitRoster[unitIndex];
	preservedAllegiance = unitRecord->allegiance;
	if (unitType != 0xFFFF)
	{
		LoadUnitTemplateRecord((int16) unitType);
		*unitRecord = EstimatedUnitRecord;
		unitRecord->deploymentState = 0x01;
		unitRecord->allegiance = preservedAllegiance;
	}

	tacticalSpriteBase = unitRecord->tacticalSpriteBase;
	UnitSpriteBaseId[unitIndex] = tacticalSpriteBase + 0x0100;
	if (unitIndex >= 0x000C)
	{
		if (unitRecord->damageModel == UNIT_DAMAGE_MODEL_INFANTRY)
			UnitSpriteBaseId[unitIndex] += 0x0002;
		else
			UnitSpriteBaseId[unitIndex] += 0x0008;
	}

	UnitTacticalOrderMode[unitIndex] = TACTICAL_ORDER_SEEK_AND_DESTROY;
	UnitAttackTarget[unitIndex] = TACTICAL_TARGET_NONE;
	unitRecord->heatAccumulatorQ8_8 = 0x0000;
	UpdateUnitSpriteForFacing(unitIndex, 0x0000);
	RecalculateUnitCombatRatings(
		unitRecord, unitIndex, 0x0001, 0x0000);
}
