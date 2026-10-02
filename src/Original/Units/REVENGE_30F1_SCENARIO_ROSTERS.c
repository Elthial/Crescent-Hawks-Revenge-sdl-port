// REVENGE_30F1_SCENARIO_ROSTERS.c
// Reconstructed from REVENGE.EXE and its annotated instruction listing.
// using Reko decompiler version 0.11.4.0.

#include "REVENGE.h"
#include "revenge/original_data.h"

void AdvanceCampaignClock(byte hours, byte minutes);
void ResetLiveUnitState(uint16 unitIndex);
void UpdatePilotAvailability(void);
void InvalidateEmptyRosterSlots(void);
void CompactScenarioLances(void);

#define CAMPAIGN_UNIT_COUNT                0x18
#define ACTIVE_CAMPAIGN_UNIT_COUNT         0x0C
#define PILOT_STATE_COUNT                  0x25
#define INVALID_ROSTER_INDEX               0xFF

#define PILOT_ROSTER_RECORD(index) \
	(&PilotRoster[(word16) (index)])
#define PILOT_STATE_RECORD(index) \
	(&PilotRoster[(word16) (index)].availability)
#define LANCE_ASSIGNMENT_RECORD(index) \
	(&LanceAssignments[(word16) (index)])

// ANNOTATION: campaign/scenario unit-roster preparation. MECHTYPE.DAT is exactly
// 89 * 0x96 bytes; the dominant 0x96-byte copies below therefore move complete
// mech, vehicle, or infantry records. DS:8B81 is the 24-entry persistent roster
// and DS:99E0 is the corresponding 24-entry live/scenario unit array.

// 30F1:0006: void PrepareScenarioUnitRosters(void)
// Called from:
//      RunInGameMenu
//      SaveGame
void PrepareScenarioUnitRosters(void)
{
	// PROPOSED NAME: PrepareScenarioUnitRosters. A future scenario-flow
	// trace should distinguish campaign roster persistence from tactical setup.
	// DS:B581 is the ASCII suffix of SCENE?.DAT: 31h-39h select SCENE1-9,
	// and 41h-54h select SCENEA-T. Each implemented case assembles its force
	// from complete 0x96-byte unit records.
	// [P] DS:8562/857B are parallel 24-byte per-unit map X/Y arrays. Preserve
	// them at DS:197B/1993 before rebuilding the scenario roster. Winning saves
	// contain coordinate-like pairs indexed like the 24 live-unit slots.
	uint16 unitIndex = 0x00;
	while (unitIndex < TACTICAL_UNIT_COUNT)
	{
		SavedScenarioUnitMapX[unitIndex] = ScenarioUnitMapX[unitIndex];
		SavedScenarioUnitMapY[unitIndex] = ScenarioUnitMapY[unitIndex];
		++unitIndex;
	}
	// Preserve the current three-byte campaign clock/state tuple before the
	// scenario-specific changes below. DS:8337 is hours and DS:8338 is minutes.
	CopyFarMemory(0x03, CampaignClockState, SavedCampaignClockState);
	uint16 sceneSuffix = ScenarioFileSuffix;
	uint16 rosterIndex36;
	uint16 rosterIndex37;
	uint16 rosterIndex38;
	uint16 rosterIndex39;
	uint16 rosterIndex42;
	uint16 reserveIndex42;
	uint16 rosterIndex44;
	uint16 liveIndex45;
	uint16 rosterIndex4C;
	uint16 liveIndex4C;
	uint16 rosterIndex4D;
	uint16 rosterIndex4E;
	uint16 lanceSlot4F;
	uint16 lanceSlot50;
	uint16 primaryUnitIndex51;
	uint16 reserveUnitIndex51;
	uint16 rosterIndex52;
	uint16 rosterIndex54;
	if (sceneSuffix <= 0x54)
	{
		switch (sceneSuffix)
		{
		case 0x31:
			// ANNOTATION: blank/default unit record at DS:85B0 -> roster slot.
			LiveScenarioUnits[0x05] =
				BlankUnitRecord;
			ScenarioUnitZeroAvailable = 0x00;
			if ((word16) (PersistentUnitRoster[0x00].deploymentState
				| ((word16) PersistentUnitRoster[0x00].unitTypeId << 0x08)) != 0x00
				&& (word16) (PersistentUnitRoster[0x00].walkMovement
				| ((word16) PersistentUnitRoster[0x00].jumpMovement << 0x08)) != 0x00)
			{
				LiveScenarioUnits[0x05] =
					PersistentUnitRoster[0x00];
				LiveScenarioUnits[0x05].deploymentState = 0x00;
				ScenarioUnitZeroAvailable = 0x01;
			}
			ScenarioUnitFifteenState = (int16)
				PersistentUnitRoster[0x0F].deploymentState;
			if ((CampaignUnitFifteenOverrideFlag & 0x80) != 0x00)
				ScenarioUnitFifteenState = 0x01;
			PersistentUnitRoster[0x0F].deploymentState = 0x00;
			LiveScenarioUnits[0x0F] =
				PersistentUnitRoster[0x0F];
			AdvanceCampaignClock(0x00, 0x14);
			break;
		case 0x32:
			LiveScenarioUnits[0x00] =
				PersistentUnitRoster[0x00];
			LiveScenarioUnits[0x01] =
				PersistentUnitRoster[0x01];
			LiveScenarioUnits[0x0D] =
				PersistentUnitRoster[0x0C];
			LiveScenarioUnits[0x0E] =
				PersistentUnitRoster[0x14];
			ScenarioUnitFourteenEnabled = 0x00;
			ScenarioUnitThirteenEnabled = 0x00;
			if ((CampaignUnitThirteenAvailabilityFlag & 0x80) != 0x00)
				ScenarioUnitThirteenEnabled = 0x01;
			if ((CampaignUnitFourteenAvailabilityFlag & 0x80) != 0x00)
				ScenarioUnitFourteenEnabled = 0x01;
			AdvanceCampaignClock(0x00, 0x03);
			break;
		case 0x33:
			LiveScenarioUnits[0x00] =
				PersistentUnitRoster[0x00];
			LiveScenarioUnits[0x01] =
				PersistentUnitRoster[0x01];
			LiveScenarioUnits[0x04] =
				LiveScenarioUnits[0x02];
			if (EjectedPilotRosterState != 0x00)
			{
				LiveScenarioUnits[0x02] =
					PersistentUnitRoster[0x0C];
				LiveScenarioUnits[0x02].deploymentState = 0x01;
			}
			else
			{
				LiveScenarioUnits[0x02] =
					PersistentUnitRoster[0x02];
				if (StoryUnitDeployedFlag == 0x00
					&& ScenarioUnitZeroAvailable != 0x00)
					LiveScenarioUnits[0x02].deploymentState = 0x01;
			}
			LiveScenarioUnits[0x05] =
				BlankUnitRecord;
			AdvanceCampaignClock(0x00, 0x02);
			break;
		case 0x34:
			LiveScenarioUnits[0x00] =
				PersistentUnitRoster[0x00];
			LiveScenarioUnits[0x01] =
				PersistentUnitRoster[0x01];
			LiveScenarioUnits[0x02] =
				LiveScenarioUnits[0x04];
			LiveScenarioUnits[0x04] =
				PersistentUnitRoster[0x02];
			break;
		case 0x35:
			ResetLiveUnitState(0x00);
			ResetLiveUnitState(0x01);
			ResetLiveUnitState(0x02);
			ResetLiveUnitState(0x03);
			ResetLiveUnitState(0x04);
			if (LiveScenarioUnits[0x01].deploymentState == 0x00)
				LiveScenarioUnits[0x01] =
					LiveScenarioUnits[0x04];
			if (LiveScenarioUnits[0x01].deploymentState == 0x00)
			{
				LiveScenarioUnits[0x01] =
					LiveScenarioUnits[0x03];
				LiveScenarioUnits[0x03] =
					BlankUnitRecord;
			}
			LiveScenarioUnits[0x04] =
				BlankUnitRecord;
			break;
		case 0x36:
			InvalidateEmptyRosterSlots();
			rosterIndex36 = 0x00;
			while (rosterIndex36 < 0x03)
			{
				LiveScenarioUnits[rosterIndex36] =
					PersistentUnitRoster[rosterIndex36];
				LiveScenarioUnits[rosterIndex36 + 0x15] =
					PersistentUnitRoster[rosterIndex36 + 0x15];
				++rosterIndex36;
			}
			LiveScenarioUnits[0x14] =
				BlankUnitRecord;
			break;
		case 0x37:
			InvalidateEmptyRosterSlots();
			LiveScenarioUnits[0x03] =
				PersistentUnitRoster[0x00];
			LiveScenarioUnits[0x04] =
				PersistentUnitRoster[0x01];
			rosterIndex37 = 0x00;
			while (rosterIndex37 < 0x03)
			{
				LiveScenarioUnits[rosterIndex37 + 0x15] =
					PersistentUnitRoster[rosterIndex37 + 0x15];
				++rosterIndex37;
			}
			break;
		case 0x38:
			InvalidateEmptyRosterSlots();
			rosterIndex38 = 0x00;
			while (rosterIndex38 < 0x03)
			{
				LiveScenarioUnits[rosterIndex38] =
					PersistentUnitRoster[rosterIndex38];
				LiveScenarioUnits[rosterIndex38 + 0x15] =
					PersistentUnitRoster[rosterIndex38 + 0x15];
				++rosterIndex38;
			}
			LiveScenarioUnits[0x03] =
				PersistentUnitRoster[0x04];
			break;
		case 0x39:
			InvalidateEmptyRosterSlots();
			LiveScenarioUnits[0x00] =
				PersistentUnitRoster[0x00];
			LiveScenarioUnits[0x03] =
				PersistentUnitRoster[0x01];
			LiveScenarioUnits[0x01] =
				PersistentUnitRoster[0x04];
			LiveScenarioUnits[0x02] =
				PersistentUnitRoster[0x05];
			rosterIndex39 = 0x00;
			while (rosterIndex39 < 0x03)
			{
				LiveScenarioUnits[rosterIndex39 + 0x15] =
					PersistentUnitRoster[rosterIndex39 + 0x15];
				++rosterIndex39;
			}
			break;
		case 0x3A:
		case 0x3B:
		case 0x3C:
		case 0x3D:
		case 0x3E:
		case 0x3F:
		case 0x40:
		case 0x41:
		case 0x46:
		case 0x47:
		case 0x48:
		case 0x49:
		case 0x4A:
		case 0x4B:
			break;
		case 0x42:
			InvalidateEmptyRosterSlots();
			rosterIndex42 = 0x00;
			while (rosterIndex42 < ACTIVE_CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[rosterIndex42] =
					PersistentUnitRoster[rosterIndex42];
				++rosterIndex42;
			}
			reserveIndex42 = 0x10;
			while (reserveIndex42 < CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[reserveIndex42] =
					PersistentUnitRoster[reserveIndex42];
				++reserveIndex42;
			}
			break;
		case 0x43:
			InvalidateEmptyRosterSlots();
			goto l30F1;
		case 0x44:
			rosterIndex44 = 0x00;
			while (rosterIndex44 < CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[rosterIndex44] =
					PersistentUnitRoster[rosterIndex44];
				++rosterIndex44;
			}
			break;
		case 0x45:
			InvalidateEmptyRosterSlots();
			liveIndex45 = 0x00;
			while (liveIndex45 < CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[liveIndex45] =
					BlankUnitRecord;
				++liveIndex45;
			}
			break;
		case 0x4C:
			InvalidateEmptyRosterSlots();
			rosterIndex4C = 0x00;
			while (rosterIndex4C < LANCE_UNIT_COUNT)
			{
				LiveScenarioUnits[rosterIndex4C] =
					PersistentUnitRoster[rosterIndex4C];
				++rosterIndex4C;
			}
			liveIndex4C = ACTIVE_CAMPAIGN_UNIT_COUNT;
			while (liveIndex4C < CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[liveIndex4C] =
					BlankUnitRecord;
				++liveIndex4C;
			}
			break;
		case 0x4D:
			InvalidateEmptyRosterSlots();
			rosterIndex4D = 0x00;
			while (rosterIndex4D < ACTIVE_CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[rosterIndex4D] =
					PersistentUnitRoster[rosterIndex4D];
				++rosterIndex4D;
			}
			break;
		case 0x4E:
			InvalidateEmptyRosterSlots();
			rosterIndex4E = 0x00;
			while (rosterIndex4E < ACTIVE_CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[rosterIndex4E] =
					PersistentUnitRoster[rosterIndex4E];
				if ((CampaignFlags & 0x01) != 0x00)
					ResetLiveUnitState(rosterIndex4E);
				++rosterIndex4E;
			}
			break;
		case 0x4F:
			InvalidateEmptyRosterSlots();
			UpdatePilotAvailability();
			CompactScenarioLances();
			lanceSlot4F = 0x00;
			while (lanceSlot4F < LANCE_UNIT_COUNT)
			{
				LiveScenarioUnits[lanceSlot4F + 0x08] =
					PersistentUnitRoster[lanceSlot4F + 0x04];
				LiveScenarioUnits[lanceSlot4F + 0x0C] =
					PersistentUnitRoster[lanceSlot4F];
				++lanceSlot4F;
			}
			break;
		case 0x50:
			InvalidateEmptyRosterSlots();
			UpdatePilotAvailability();
			CompactScenarioLances();
			lanceSlot50 = 0x00;
			while (lanceSlot50 < LANCE_UNIT_COUNT)
			{
				LiveScenarioUnits[lanceSlot50 + 0x08] =
					PersistentUnitRoster[lanceSlot50 + 0x04];
				LiveScenarioUnits[lanceSlot50 + 0x0C] =
					PersistentUnitRoster[lanceSlot50 + 0x08];
				ResetLiveUnitState(lanceSlot50 + 0x0C);
				++lanceSlot50;
			}
			break;
		case 0x51:
			UpdatePilotAvailability();
			CompactScenarioLances();
			primaryUnitIndex51 = 0x00;
			while (primaryUnitIndex51 < 0x08)
			{
				LiveScenarioUnits[primaryUnitIndex51] =
					PersistentUnitRoster[primaryUnitIndex51];
				ResetLiveUnitState(primaryUnitIndex51);
				++primaryUnitIndex51;
			}
			reserveUnitIndex51 = 0x08;
			while (reserveUnitIndex51 < ACTIVE_CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[reserveUnitIndex51 + 0x04] =
					PersistentUnitRoster[reserveUnitIndex51];
				ResetLiveUnitState(reserveUnitIndex51 + 0x04);
				++reserveUnitIndex51;
			}
			InvalidateEmptyRosterSlots();
			break;
		case 0x52:
		case 0x53:
			UpdatePilotAvailability();
			CompactScenarioLances();
			rosterIndex52 = 0x00;
			while (rosterIndex52 < 0x08)
			{
				LiveScenarioUnits[rosterIndex52] =
					PersistentUnitRoster[rosterIndex52];
				ResetLiveUnitState(rosterIndex52);
				++rosterIndex52;
			}
			InvalidateEmptyRosterSlots();
			break;
		case 0x54:
l30F1:
			rosterIndex54 = 0x00;
			while (rosterIndex54 < ACTIVE_CAMPAIGN_UNIT_COUNT)
			{
				LiveScenarioUnits[rosterIndex54] =
					PersistentUnitRoster[rosterIndex54];
				++rosterIndex54;
			}
			break;
		}
	}
}

// 30F1:0878: void ResetLiveUnitState(uint16 unitIndex)
// Called from:
//      PrepareScenarioUnitRosters
// Verified against 30F1:0878-0A3E.
void ResetLiveUnitState(uint16 unitIndex)
{
	// V: Restore one live unit from its immutable maxima, clear equipment
	// damage bits and runtime engine/heat state, and refill ammunition from
	// the fourteen weapon-family counts and DS:058E capacity multipliers.
	RevengeUnitRecord *unitRecord = &LiveScenarioUnits[unitIndex];
	uint16 fieldIndex;
	for (fieldIndex = 0x00; fieldIndex < AMMUNITION_FAMILY_COUNT; ++fieldIndex)
	{
		if (fieldIndex < BATTLEMECH_LOCATION_COUNT)
		{
			unitRecord->currentInternal[fieldIndex] =
				unitRecord->maximumInternal[fieldIndex];
			unitRecord->leftArmEquipment[fieldIndex] &= EQUIPMENT_ID_MASK;
			unitRecord->rightArmEquipment[fieldIndex] &= EQUIPMENT_ID_MASK;
		}
		if (fieldIndex < BATTLEMECH_ARMOR_LOCATION_COUNT)
			unitRecord->currentArmor[fieldIndex] =
				unitRecord->maximumArmor[fieldIndex];

		word16 ammunitionCapacity =
			AmmoCapacityMultiplierTable[fieldIndex];
		word16 weaponFamilyCount = unitRecord->weaponFamilyCounts[fieldIndex];
		unitRecord->currentAmmunition[fieldIndex] = (word16)((uint32)ammunitionCapacity
			* (uint32)weaponFamilyCount);

		if (fieldIndex < BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT)
		{
			unitRecord->leftTorsoEquipment[fieldIndex] &= EQUIPMENT_ID_MASK;
			unitRecord->rightTorsoEquipment[fieldIndex] &= EQUIPMENT_ID_MASK;
		}
		if (fieldIndex < BATTLEMECH_CENTER_TORSO_EQUIPMENT_SLOT_COUNT)
		{
			unitRecord->leftLegEquipment[fieldIndex] &= EQUIPMENT_ID_MASK;
			unitRecord->rightLegEquipment[fieldIndex] &= EQUIPMENT_ID_MASK;
			unitRecord->centerTorsoEquipment[fieldIndex] &= EQUIPMENT_ID_MASK;
		}
	}
	unitRecord->headEquipment &= EQUIPMENT_ID_MASK;
	unitRecord->engineHits = 0x00;
	unitRecord->heatAccumulator = 0x00;
	unitRecord->currentHeat = 0x00;
	if (unitRecord->walkMovement == 0x00)
		unitRecord->walkMovement = 0x04;
}

// 30F1:0A81: void UpdatePilotAvailability(void)
// Called from:
//      PrepareScenarioUnitRosters
// Verified against 30F1:0A81-0AFB, including signed pilot-ID extension.
void UpdatePilotAvailability(void)
{
	// PROPOSED NAME: UpdatePilotAvailability. Unit record +92h is the
	// pilot ID, not the chassis ID (which is +01h). Future tracing must still
	// distinguish availability, survival, ownership, and selection state.
	// ANNOTATION: walk the first 12 persistent records and update the first
	// byte of each four-byte DS:1D4F pilot-state entry.
	word16 unitIndex;
	for (unitIndex = 0x0000; unitIndex < ACTIVE_CAMPAIGN_UNIT_COUNT; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
		if (unitRecord->tonnage != 0x00)
		{
			int16 pilotId = unitRecord->pilotId;
			if (pilotId < PILOT_STATE_COUNT)
			{
				byte *pilotState = PILOT_STATE_RECORD(pilotId);
				if (unitRecord->deploymentState != 0x00)
					pilotState[0x00] = 0x01;
				else
					pilotState[0x00] = INVALID_ROSTER_INDEX;
			}
		}
	}
}

// 30F1:0AFC: void AssignPilotRosterEntryToUnit(
//     word16 unitIndex, word16 rosterSlot)
// Bind one four-byte pilot-roster entry at DS:1D4C to a persistent unit.
// Bytes +01 and +02 supply pilot experience and the gunnery target number.
void AssignPilotRosterEntryToUnit(
	word16 unitIndex,
	word16 rosterSlot)
{
	RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
	RevengePilotRosterRecord *pilotRecord =
		PILOT_ROSTER_RECORD(rosterSlot);

	unitRecord->pilotId = (RevengePilotId)rosterSlot;
	unitRecord->pilotExperience = pilotRecord->experienceIndex;
	unitRecord->gunneryTargetNumber = pilotRecord->gunneryIndex;
}

// 30F1:0A3F: byte AssignScenarioLanceAllegiances(
//     word16 scenarioAllegianceIndex)
// Called from:
//      LoadTacticalScenarioResources
byte AssignScenarioLanceAllegiances(word16 scenarioAllegianceIndex)
{
	// V: DS:5928 is a table of three allegiance bytes per scenario entry. Each
	// byte is copied to one four-unit group among the first twelve persistent
	// unit records. AX happens to retain the final assigned value on return.
	const byte *scenarioAllegiances = &ScenarioLanceAllegianceTable[0x00][0x00];
	byte assignedAllegiance = 0x00;
	word16 unitIndex;

	for (unitIndex = 0x00;
		unitIndex < ACTIVE_CAMPAIGN_UNIT_COUNT;
		++unitIndex)
	{
		assignedAllegiance = scenarioAllegiances[
			scenarioAllegianceIndex * 0x03 + unitIndex / 0x04];
		PersistentUnitRoster[unitIndex].allegiance =
			assignedAllegiance;
	}

	return assignedAllegiance;
}

// 30F1:0B59: void InvalidateEmptyRosterSlots(void)
// Called from:
//      PrepareScenarioUnitRosters
void InvalidateEmptyRosterSlots(void)
{
	// Invalidate each 0x96-byte persistent record whose walk movement is zero.
	uint16 unitIndex;
	for (unitIndex = 0x00; unitIndex < CAMPAIGN_UNIT_COUNT; ++unitIndex)
	{
		RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
		if (unitRecord->walkMovement == 0x00)
			unitRecord->deploymentState = 0x00;
	}
}

// 30F1:0B8F: void CompactScenarioLances(void)
// Called from:
//      PrepareScenarioUnitRosters
// Verified against 30F1:0B8F-0DE2.
void CompactScenarioLances(void)
{
	// PROPOSED NAME: CompactScenarioLances. Future UI/gameplay tracing must
	// confirm which two four-unit groups the routine treats as lances.
	// ANNOTATION: compact/reorder two four-unit lances. All moves and clears
	// below operate on complete 0x96-byte unit records. DS:1CCA record +07 is
	// the assigned persistent slot, +08 is the live/display slot, and +09 is
	// the pilot ID; the latter two are verified in DrawUnitRosterScreen.
	uint16 lanceIndex;
	for (lanceIndex = 0x00; lanceIndex < 0x02; ++lanceIndex)
	{
		uint16 destinationSlot = lanceIndex << 0x02;
		uint16 sourceSlot = lanceIndex << 0x02;
		uint16 assignmentIndexOffset = 0x00;
		word16 mirrorLiveRecords = FALSE;
		if (ScenarioFileSuffix >= 0x4F
			&& ScenarioFileSuffix <= 0x50)
		{
			if (lanceIndex == 0x00)
				mirrorLiveRecords = TRUE;
			else
				assignmentIndexOffset = 0x04;
		}

		uint16 lanceSlot;
		for (lanceSlot = 0x00; lanceSlot < LANCE_UNIT_COUNT; ++lanceSlot)
		{
			RevengeUnitRecord *sourceUnit =
				&PersistentUnitRoster[sourceSlot];
			RevengeUnitLanceAssignment *sourceAssignment = LANCE_ASSIGNMENT_RECORD(
				sourceSlot + assignmentIndexOffset);
			if (sourceUnit->deploymentState == 0x00)
			{
				if (mirrorLiveRecords)
					LiveScenarioUnits[sourceSlot] =
						BlankUnitRecord;
				*sourceUnit = BlankUnitRecord;
				sourceAssignment->persistentUnitSlot = REVENGE_UNIT_SLOT_NONE;
				sourceAssignment->pilotId = REVENGE_PILOT_ID_NONE;
			}
			else
			{
				if (destinationSlot != sourceSlot)
				{
					RevengeUnitLanceAssignment *destinationAssignment = LANCE_ASSIGNMENT_RECORD(
						destinationSlot + assignmentIndexOffset);
					if (mirrorLiveRecords)
						LiveScenarioUnits[destinationSlot] =
							LiveScenarioUnits[sourceSlot];
					PersistentUnitRoster[destinationSlot] =
						*sourceUnit;
					destinationAssignment->style = sourceAssignment->style;
					destinationAssignment->persistentUnitSlot =
						sourceAssignment->persistentUnitSlot;
					destinationAssignment->pilotId = sourceAssignment->pilotId;
					if (mirrorLiveRecords)
						LiveScenarioUnits[sourceSlot] =
							BlankUnitRecord;
					*sourceUnit = BlankUnitRecord;
					sourceAssignment->persistentUnitSlot = REVENGE_UNIT_SLOT_NONE;
					sourceAssignment->pilotId = REVENGE_PILOT_ID_NONE;
				}
				++destinationSlot;
			}
			++sourceSlot;
		}

		uint16 assignmentSlot = lanceIndex << 0x02;
		for (lanceSlot = 0x00; lanceSlot < LANCE_UNIT_COUNT; ++lanceSlot)
		{
			RevengeUnitLanceAssignment *assignment = LANCE_ASSIGNMENT_RECORD(
				assignmentSlot + assignmentIndexOffset);
			if (assignment->pilotId == REVENGE_PILOT_ID_NONE)
			{
				assignment->style = FALSE;
				assignment->liveUnitSlot = REVENGE_UNIT_SLOT_NONE;
			}
			++assignmentSlot;
		}
	}
}

// 30F1:0DE3: snapshot active late-campaign lances into reserve slots.
// VERIFIED against ASM 30F1:0DE3-0E95.
void SnapshotLateCampaignLanceUnits(void)
{
	word16 unitIndex;
	int16 campaignStage;

	campaignStage = (int16) CampaignStageIndex;
	if (campaignStage >= 0x0010 && campaignStage <= 0x0011)
	{
		for (unitIndex = 0x0000; unitIndex < 0x0004; ++unitIndex)
		{
			LiveScenarioUnits[unitIndex + 0x0010] =
				LiveScenarioUnits[unitIndex];
			LiveScenarioUnits[unitIndex + 0x0014] =
				LiveScenarioUnits[unitIndex + 0x0008];
		}
	}
	else if (campaignStage >= 0x0012 && campaignStage <= 0x0014)
	{
		for (unitIndex = 0x0000; unitIndex < 0x0008; ++unitIndex)
		{
			LiveScenarioUnits[unitIndex + 0x0010] =
				LiveScenarioUnits[unitIndex];
		}
	}
}

// 30F1:0E96: void PromoteReserveUnitsForCampaignStage(void)
// Called from:
//      RunInGameMenu
// Verified against 30F1:0E96-10A6.
void PromoteReserveUnitsForCampaignStage(void)
{
	// PROPOSED NAME: PromoteReserveUnitsForCampaignStage. For campaign
	// stages 10h-14h, copy reserve live-unit slots 16-23 into the visible
	// groups at 0-3/0-7 and 8-11, then invalidate the corresponding 1CCA UI
	// rows when a unit is empty or its pilot-state byte is zero. A gameplay
	// trace must confirm the player's terminology for these reserve groups.
	uint16 reserveIndex;
	if (CampaignStageIndex >= 0x10
		&& CampaignStageIndex <= 0x11)
	{
		for (reserveIndex = 0x00; reserveIndex < 0x04; ++reserveIndex)
		{
			uint16 firstDestination = reserveIndex;
			uint16 secondDestination = reserveIndex + 0x08;
			RevengeUnitRecord *firstUnit;
			RevengeUnitRecord *secondUnit;
			RevengeUnitLanceAssignment *assignment;

			LiveScenarioUnits[firstDestination] =
				LiveScenarioUnits[reserveIndex + 0x10];
			firstUnit = &LiveScenarioUnits[firstDestination];
			assignment = LANCE_ASSIGNMENT_RECORD(firstDestination);
			if (firstUnit->tonnage == 0x00
				|| PILOT_STATE_RECORD(firstUnit->pilotId)[0x00] == 0x00)
				assignment->pilotId = REVENGE_PILOT_ID_NONE;

			LiveScenarioUnits[secondDestination] =
				LiveScenarioUnits[reserveIndex + 0x14];
			secondUnit = &LiveScenarioUnits[secondDestination];
			assignment = LANCE_ASSIGNMENT_RECORD(secondDestination);
			if (secondUnit->tonnage == 0x00
				|| PILOT_STATE_RECORD(secondUnit->pilotId)[0x00] == 0x00)
				assignment->pilotId = REVENGE_PILOT_ID_NONE;
		}
	}
	else if (CampaignStageIndex >= 0x12
		&& CampaignStageIndex <= 0x14)
	{
		for (reserveIndex = 0x00; reserveIndex < 0x08; ++reserveIndex)
		{
			RevengeUnitRecord *unitRecord;
			RevengeUnitLanceAssignment *assignment;
			LiveScenarioUnits[reserveIndex] =
				LiveScenarioUnits[reserveIndex + 0x10];
			unitRecord = &LiveScenarioUnits[reserveIndex];
			assignment = LANCE_ASSIGNMENT_RECORD(reserveIndex);
			if (unitRecord->tonnage == 0x00
				|| PILOT_STATE_RECORD(unitRecord->pilotId)[0x00] == 0x00)
				assignment->pilotId = REVENGE_PILOT_ID_NONE;
		}
	}
}

