// REVENGE_1A1F_SCENE_INTERPRETER.c
// Procedures preserved from REVENGE_1A1F_SCENARIO.c.

#include "REVENGE_1A1F_INTERNAL.h"
#include "revenge/debug.h"

static byte tracedSceneOpcodeCount;

enum
{
	PERSISTENT_UNIT_ROSTER_ORIGINAL_OFFSET = 0x8B81,
	LIVE_SCENARIO_UNITS_ORIGINAL_OFFSET = 0x99E0
};

static RevengeUnitRecord SceneUnitRecordOverflow;

/*
 * The original procedure performs the address calculation below directly in
 * DGROUP, without limiting the SCENE unit byte to the 0x18 normal tactical
 * slots:
 *
 *     DS:8B81 + unitIndex * 0x96
 *
 * SCENE1 deliberately uses unit index 19h.  Its resulting record view begins
 * at DS:9A27, 47h bytes into LiveScenarioUnits.  Preserve that original
 * alias explicitly now that the reconstructed C gives the two roster regions
 * separate named objects.
 */
RevengeUnitRecord *GetPersistentUnitRecord(word16 unitIndex)
{
	uint32 originalOffset;
	uint32 liveOffset;

	if (unitIndex < TACTICAL_UNIT_COUNT)
		return &PersistentUnitRoster[unitIndex];

	originalOffset = PERSISTENT_UNIT_ROSTER_ORIGINAL_OFFSET
		+ (uint32)unitIndex * sizeof(RevengeUnitRecord);
	if (originalOffset >= LIVE_SCENARIO_UNITS_ORIGINAL_OFFSET)
	{
		liveOffset = originalOffset - LIVE_SCENARIO_UNITS_ORIGINAL_OFFSET;
		if (liveOffset + sizeof(RevengeUnitRecord)
			<= sizeof(LiveScenarioUnits))
		{
			return (RevengeUnitRecord *)
				((byte *)LiveScenarioUnits + liveOffset);
		}
	}

	REVENGE_PRESERVATION_TRACE("scene: unsupported legacy unit alias %u at DS:%04X\n",
		unitIndex, (word16)originalOffset);
	return &SceneUnitRecordOverflow;
}

// 1A1F:2A4E: void ExecuteSceneInstructions(void)
// Verified transcription from the restored zero-error Reko run and ASM
// 1A1F:2A4E-3A89. The FFh terminator is inspected without advancing the
// global cursor, matching the loop test at 3A71-3A81.
// The procedure consumes opcodes CFh-FEh from the global far cursor stored at
// DS:A9DB:A9D9. Word branch operands are offsets relative to the loaded SCENE
// data at DS:71A8 plus SceneInstructionBaseOffset.
void ExecuteSceneInstructions(void)
{
	word16 stopInterpreter = 0x00;

	while (stopInterpreter == 0x00 &&
		*(byte *)MAKE_FAR_POINTER(
			SceneInstructionCursor.segment,
			SceneInstructionCursor.offset) != SCENE_END)
	{
		byte opcode = ReadSceneByte();
		if (tracedSceneOpcodeCount < 0x60)
		{
			REVENGE_PRESERVATION_TRACE("scene: offset=%04X opcode=%02X\n",
				(word16)(SceneInstructionCursor.offset - 0x01), opcode);
			++tracedSceneOpcodeCount;
		}

		switch (opcode)
		{
		case SCENE_ENABLE_LANCE:
			if (ReadSceneByte() == 0x00)
				TacticalScenarioLanceEnabled[0x01] = 0x01;
			else
				TacticalScenarioLanceEnabled[0x02] = 0x01;
			break;

		case SCENE_SET_UNIT_RESOURCE:
		{
			word16 slotIndex = ReadSceneByte();
			UnitTypeResourceCode[slotIndex] = ReadSceneByte();
			TacticalSlotSpriteState[slotIndex] = 0x00;
			TacticalStatusRowInvalidation[slotIndex] = 0xFF;
			break;
		}

		case SCENE_CREATE_AREA_IMPACT:
		{
			int16 centerX = ReadSceneByte();
			int16 centerY = ReadSceneByte();
			word16 chanceDenominator = ReadSceneByte();
			CreateRandomAreaImpact(
				centerX,
				centerY,
				chanceDenominator);
			break;
		}

		case SCENE_SET_LANCE_FORMATION:
		{
			word16 firstUnit = ReadSceneByte();
			byte formationMode = ReadSceneByte();
			word16 unitOffset;
			for (unitOffset = 0x00; unitOffset < 0x04; ++unitOffset)
				UnitFormationMode[firstUnit + unitOffset] =
					formationMode;
			break;
		}

		case SCENE_DEPLOY_STORY_UNIT:
			if (ScenarioUnitZeroAvailable == 0x01)
			{
				StoryUnitDeployedFlag = 0x01;
				GetPersistentUnitRecord(0x02)->deploymentState = 0x01;
			}
			InitializeScenarioUnitFromTemplate(0xFFFF, 0x02);
			AssignPilotRosterEntryToUnit(0x02, 0x02);
			ScenarioUnitMapX[0x02] = ReadSceneByte();
			ScenarioUnitMapY[0x02] = ReadSceneByte();
			UnitTypeResourceCode[0x02] = 0xE2;
			TacticalSlotSpriteState[0x02] = 0x00;
			TacticalStatusRowInvalidation[0x02] = 0xFF;
			break;

		case SCENE_SET_CAMPAIGN_MILESTONE:
			// Milestone selectors are scenario-specific, but their persistent
			// CampaignFlags bits and observed SCENE events are stable:
			// 0 APC crossed bridge; 1 SRMs loaded; 2 LRMs loaded;
			// 3 Whitworth pilot ejected; 6 Clan commander crippled;
			// 7 city/Mech Shop objective reached. Selectors 4 and 5 remain U.
			switch (ReadSceneByte())
			{
			case CAMPAIGN_MILESTONE_APC_BRIDGE:
				CampaignFlags |= 0x0080;
				break;
			case CAMPAIGN_MILESTONE_SRM_SHIPMENT:
				CampaignFlags |= 0x0800;
				SrmShipmentLoaded = 0x01;
				break;
			case CAMPAIGN_MILESTONE_LRM_SHIPMENT:
				CampaignFlags |= 0x1000;
				LrmShipmentLoaded = 0x01;
				break;
			case CAMPAIGN_MILESTONE_PILOT_EJECTED:
				EjectedPilotRosterState =
					PersistentUnitRoster[0x0C].deploymentState;
				EjectedPilotMapX = ScenarioUnitMapX[0x0C];
				EjectedPilotMapY = ScenarioUnitMapY[0x0C];
				EjectedPilotState = PersistentUnitRoster[0x0C].tacticalSpriteBaseLow + 0x08;
				PersistentUnitRoster[0x0C].deploymentState = 0x00;
				if (EjectedPilotRosterState != 0x00)
				{
					EjectedPilotRosterState =
						PersistentUnitRoster[0x0C].walkMovement;
				}
				if (EjectedPilotRosterState != 0x00)
					CampaignFlags |= 0x0020;
				break;
			case CAMPAIGN_MILESTONE_UNKNOWN_04:
				CampaignFlags |= 0x0100;
				break;
			case CAMPAIGN_MILESTONE_UNKNOWN_05:
				CampaignFlags |= 0x0200;
				break;
			case CAMPAIGN_MILESTONE_COMMANDER_CRIPPLED:
				CampaignFlags |= 0x0400;
				break;
			case CAMPAIGN_MILESTONE_MECH_SHOP_REACHED:
				CampaignFlags |= 0x4000;
				break;
			}
			break;

		case SCENE_GRANT_UNIT_UPGRADE:
		{
			word16 unitIndex = ReadSceneByte();
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			switch (ReadSceneByte())
			{
			case UNIT_UPGRADE_MISSILE_SYSTEM:
				unitRecord->missileUpgradeState = 0x01;
				break;
			case UNIT_UPGRADE_BEAGLE_ACTIVE_PROBE:
				unitRecord->beagleActiveProbe = 0x01;
				break;
			case UNIT_UPGRADE_INDIRECT_FIRE_SPOTTER:
				unitRecord->indirectFireSpotter = 0x01;
				break;
			case UNIT_UPGRADE_CASE:
				unitRecord->caseProtection = 0x01;
				break;
			case UNIT_UPGRADE_CAMPAIGN_AWARD:
			{
				word16 slotIndex;
				for (slotIndex = 0x00; slotIndex < 0x04; ++slotIndex)
				{
					if (CampaignUpgradeAwards[slotIndex] == 0x00)
					{
						CampaignUpgradeAwards[slotIndex] = 0x01;
						break;
					}
				}
				break;
			}
			}
			break;
		}

		case SCENE_BRANCH_IF_UNIT_Y_EQUALS:
		{
			word16 unitIndex = ReadSceneByte();
			byte expectedY = ReadSceneByte();
			BranchOrSkipSceneWord(
				ScenarioUnitMapY[unitIndex] == expectedY);
			break;
		}

		case SCENE_BRANCH_IF_UNIT_X_EQUALS:
		{
			word16 unitIndex = ReadSceneByte();
			byte expectedX = ReadSceneByte();
			BranchOrSkipSceneWord(
				ScenarioUnitMapX[unitIndex] == expectedX);
			break;
		}

		case SCENE_END_BATTLE_RESULT_3:
			TacticalBattleResult = 0x03;
			stopInterpreter = 0x01;
			break;

		case SCENE_END_BATTLE_RESULT_2:
			TacticalBattleResult = 0x02;
			stopInterpreter = 0x01;
			break;

		case SCENE_BRANCH_IF_UNIT_WITHDRAWN:
		{
			word16 unitIndex = ReadSceneByte();
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			word16 takeBranch =
				(UnitWithdrawalState[unitIndex] & 0x80) != 0x00
				|| unitRecord->deploymentState == 0x00;
			BranchOrSkipSceneWord(takeBranch);
			break;
		}

		case SCENE_WITHDRAW_UNIT_AT_LOCATION:
		{
			word16 unitIndex = ReadSceneByte();
			byte mapX = ReadSceneByte();
			byte mapY = ReadSceneByte();
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			SceneUnitRoute *route = GetUnitRouteRecord(unitIndex);

			UnitTacticalOrderMode[unitIndex] =
				TACTICAL_ORDER_SCRIPTED_ROUTE;
			UnitMovementHeatExponent[unitIndex] = 0x02;
			if (ScenarioUnitMapX[unitIndex] == mapX
				&& ScenarioUnitMapY[unitIndex] == mapY)
			{
				if (IsCurrentLanceLeader(unitIndex) != 0x00)
				{
					word16 lanceUnit = unitIndex;
					do
					{
						UnitWithdrawalState[lanceUnit] |= 0x80;
						GetPersistentUnitRecord(lanceUnit)->deploymentState =
							0x00;
						++lanceUnit;
					} while ((lanceUnit & 0x03) != 0x00);
				}
				else
				{
					UnitWithdrawalState[unitIndex] |= 0x80;
					unitRecord->deploymentState = 0x00;
				}
			}
			else
			{
				route->waypointMapX[0x03] = mapX;
				UnitRouteTargetMapX[unitIndex] = mapX;
				route->waypointMapY[0x03] = mapY;
				UnitRouteTargetMapY[unitIndex] = mapY;
				route->waypointIndex = 0x03;
				UnitLanceFormationState[unitIndex] = 0x01;
				UnitWithdrawalState[unitIndex] = 0x01;
			}
			QueueLinkedUnitStatusNarration(unitIndex);
			break;
		}

		case SCENE_QUEUE_NARRATION_EVENT_24:
		case SCENE_QUEUE_NARRATION_EVENT_23:
		case SCENE_QUEUE_NARRATION_EVENT_22:
		case SCENE_QUEUE_NARRATION_EVENT_21:
		case SCENE_QUEUE_NARRATION_EVENT_20:
		case SCENE_QUEUE_NARRATION_EVENT_19:
		{
			word16 eventNumber = 0x0100 - opcode;
			word16 eventFlagIndex = eventNumber - 0x001F;
			byte narrationSubject = ReadSceneByte();
			if (SceneNarrationEventFlags[eventFlagIndex] == 0x00)
			{
				ActiveNarrationSubject = narrationSubject;
				NarrationMessageCategory = eventNumber - 0x14;
				PendingNarrationDelay = 0x025D;
				FriendlyUnitDestroyed = 0x0001;
				NarrationEmphasis = 0x01;
			}
			SceneNarrationEventFlags[eventFlagIndex] = 0x01;
			break;
		}

		case SCENE_CREATE_RANDOM_EDGE_EFFECT:
		{
			int16 centerX = ReadSceneByte();
			int16 centerY = ReadSceneByte();
			word16 chanceDenominator = ReadSceneByte();
			if (RandomInRangeInclusive(0x01, chanceDenominator)
				== chanceDenominator)
			{
				QueueRandomMapEdgeEffect(centerX, centerY);
			}
			break;
		}

		case SCENE_SET_UNIT_GUNNERY:
		{
			word16 unitIndex = ReadSceneByte();
			GetPersistentUnitRecord(unitIndex)->gunneryTargetNumber =
				ReadSceneByte();
			break;
		}

		case SCENE_SET_UNIT_PILOT:
		{
			word16 unitIndex = ReadSceneByte();
			GetPersistentUnitRecord(unitIndex)->pilotId =
				ReadSceneByte();
			break;
		}

		case SCENE_SET_UNIT_PILOT_EXPERIENCE:
		{
			word16 unitIndex = ReadSceneByte();
			GetPersistentUnitRecord(unitIndex)->pilotExperience =
				ReadSceneByte();
			break;
		}

		case SCENE_BRANCH_IF_TERRAIN_DESTROYED:
		{
			int16 mapX = ReadSceneByte();
			int16 mapY = ReadSceneByte();
			BranchOrSkipSceneWord(
				ReadTerrainDamageState(mapX, mapY) >= 0x03);
			break;
		}

		case SCENE_BRANCH_IF_TERRAIN_DAMAGED:
		{
			int16 mapX = ReadSceneByte();
			int16 mapY = ReadSceneByte();
			BranchOrSkipSceneWord(
				ReadTerrainDamageState(mapX, mapY) != 0x00);
			break;
		}

		case SCENE_ADVANCE_UNIT_ROUTE:
			AdvanceUnitSceneRoute(ReadSceneByte());
			break;

		case SCENE_DEPLOY_UNIT:
		{
			word16 unitIndex = ReadSceneByte();
			word16 unitType = ReadSceneByte();
			byte mapX;
			byte mapY;
			SceneUnitRoute *route;
			word16 waypointIndex;
			word16 rosterSlot;

			InitializeScenarioUnitFromTemplate(unitType, unitIndex);
			PrepareUnitTypeResources(unitType);
			route = GetUnitRouteRecord(unitIndex);
			mapX = ReadSceneByte();
			route->activeMapX = mapX;
			ScenarioUnitMapX[unitIndex] = mapX;
			UnitRouteTargetMapX[unitIndex] = mapX;
			mapY = ReadSceneByte();
			route->activeMapY = mapY;
			ScenarioUnitMapY[unitIndex] = mapY;
			UnitRouteTargetMapY[unitIndex] = mapY;
			for (waypointIndex = 0x00; waypointIndex < 0x04; ++waypointIndex)
			{
				route->waypointMapX[waypointIndex] = mapX;
				route->waypointMapY[waypointIndex] = mapY;
			}
			UnitLanceFormationState[unitIndex] =
				(byte)IsCurrentLanceLeader(unitIndex);
			rosterSlot = ReadSceneByte();
			if (rosterSlot != 0xFF)
				AssignPilotRosterEntryToUnit(unitIndex, rosterSlot);
			if (ScenarioFileSuffix == 0x38
				&& unitType == 0x04
				&& SrmShipmentLoaded != 0x00)
			{
				GetPersistentUnitRecord(unitIndex)->missileUpgradeState =
					0x01;
			}
			break;
		}

		case SCENE_ADD_AMMUNITION:
		case SCENE_REMOVE_AMMUNITION:
		{
			word16 unitIndex = ReadSceneByte();
			word16 ammunitionFamilyIndex = ReadSceneByte();
			word16 capacityIncrement =
				AmmoCapacityMultiplierTable[ammunitionFamilyIndex];
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			word16 *ammunition =
				&unitRecord->currentAmmunition[ammunitionFamilyIndex];

			if (opcode == SCENE_ADD_AMMUNITION)
				*ammunition += capacityIncrement;
			else
			{
				word16 remaining = *ammunition - capacityIncrement;
				*ammunition = (int16)remaining < 0x0000
					? 0x0000 : remaining;
			}
			break;
		}

		case SCENE_BRANCH_IF_CLOCK_EQUALS:
		case SCENE_BRANCH_IF_CLOCK_REACHED:
		{
			byte expectedDay = ReadSceneByte();
			byte expectedMinute = ReadSceneByte();
			byte expectedHour = ReadSceneByte();
			byte currentDay = TacticalClockSubtick;
			word16 condition;

			if (opcode == SCENE_BRANCH_IF_CLOCK_EQUALS)
			{
				condition = expectedHour == CampaignClockState[0x00]
					&& expectedMinute == CampaignClockState[0x01]
					&& expectedDay == currentDay;
			}
			else
			{
				condition =
					CampaignClockState[0x00] > expectedHour
					|| (CampaignClockState[0x00] == expectedHour &&
						CampaignClockState[0x01] > expectedMinute)
					|| (CampaignClockState[0x00] == expectedHour &&
						CampaignClockState[0x01] == expectedMinute &&
						currentDay >= expectedDay);
			}
			BranchOrSkipSceneWord(condition);
			break;
		}

		case SCENE_SET_CLOCK:
			TacticalClockSubtick = ReadSceneByte();
			CampaignClockState[0x01] = ReadSceneByte();
			CampaignClockState[0x00] = ReadSceneByte();
			DrawCampaignClock();
			break;

		case SCENE_BRANCH_IF_WEAPON_ABSENT:
		{
			/*
			 * The 83 FE FF instruction at 1A1F:308A compares SI with a
			 * sign-extended imm8, hence FFFFh rather than 00FFh. This is the
			 * normal no-match result from FindUnitWeaponByOrdinal.
			 */
			word16 unitIndex = ReadSceneByte();
			word16 requestedWeapon = ReadSceneByte();
			word16 occurrence = 0x00;
			word16 found = 0x00;
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			while (TRUE)
			{
				int16 weapon = FindUnitWeaponByOrdinal(
					unitRecord,
					occurrence,
					0x00);
				if (weapon == (int16)requestedWeapon)
				{
					found = 0x01;
					break;
				}
				if (weapon == -0x01)
					break;
				++occurrence;
			}
			BranchOrSkipSceneWord(found == 0x00);
			break;
		}

		case SCENE_BRANCH_IF_AMMUNITION_PRESENT:
		{
			word16 unitIndex = ReadSceneByte();
			word16 ammunitionFamilyIndex = ReadSceneByte();
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			word16 ammunition =
				unitRecord->currentAmmunition[ammunitionFamilyIndex];
			BranchOrSkipSceneWord(ammunition != 0x00);
			break;
		}

		case SCENE_BRANCH_IF_UNIT_OPERATIONAL:
		{
			word16 unitIndex = ReadSceneByte();
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			word16 takeBranch =
				unitRecord->deploymentState != 0x00
				&& unitRecord->walkMovement != 0x00;
			BranchOrSkipSceneWord(takeBranch);
			break;
		}

		case SCENE_BRANCH_IF_INTERNAL_PERCENT:
		{
			word16 unitIndex = ReadSceneByte();
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			word16 currentStructure = 0x00;
			word16 maximumStructure = 0x00;
			word16 locationIndex;
			word16 percentage = 0x00;
			byte threshold;
			if (unitRecord->deploymentState != 0x00)
			{
				for (locationIndex = 0x00; locationIndex < 0x0B; ++locationIndex)
				{
					currentStructure = (word16)(currentStructure +
						unitRecord->currentDurability[locationIndex]);
					maximumStructure = (word16)(maximumStructure +
						unitRecord->maximumDurability[locationIndex]);
				}
			}
			if (maximumStructure != 0x00)
			{
				int16 wrappedProduct =
					(int16)(word16)(currentStructure * 0x64);
				percentage = (word16)(wrappedProduct / (int16)maximumStructure);
			}
			threshold = ReadSceneByte();
			BranchOrSkipSceneWord(
				(int16)(word16)threshold <= (int16)percentage);
			break;
		}

		case SCENE_BRANCH_IF_DURABILITY_PERCENT:
		{
			word16 unitIndex = ReadSceneByte();
			word16 percentage = 0x00;
			byte threshold;
			CalculateUnitDurabilityTotals(
				GetPersistentUnitRecord(unitIndex));
			if ((word16)MaximumUnitDurabilityTotal != 0x00)
			{
				int16 wrappedProduct = (int16)(word16)(
					(word16)CurrentUnitDurabilityTotal * 0x64);
				percentage = (word16)(wrappedProduct /
					(int16)(word16)MaximumUnitDurabilityTotal);
			}
			threshold = ReadSceneByte();
			BranchOrSkipSceneWord(
				(int16)(word16)threshold <= (int16)percentage);
			break;
		}

		case SCENE_REPAIR_ARMOR:
		case SCENE_DAMAGE_ARMOR:
		{
			word16 unitIndex = ReadSceneByte();
			word16 armorLocation = ReadSceneByte();
			byte amount = ReadSceneByte();
			REVENGE_PRESERVATION_TRACE("scene: armor unit=%u location=%u amount=%u\n",
				unitIndex, armorLocation, amount);
			byte *armor = &GetPersistentUnitRecord(unitIndex)
				->currentArmor[armorLocation];
			if (opcode == SCENE_REPAIR_ARMOR)
				*armor += amount;
			else
			{
				int16 remaining = *armor - amount;
				*armor = remaining < 0x00 ? 0x00 : (byte)remaining;
			}
			break;
		}

		case SCENE_YIELD:
			stopInterpreter = 0x01;
			break;

		case SCENE_JUMP:
			JumpToSceneOffset(ReadSceneWord());
			break;

		case SCENE_BRANCH_IF_UNIT_NOT_ATTACKED:
		{
			word16 unitIndex = ReadSceneByte();
			BranchOrSkipSceneWord(
				UnitWasAttackedThisTick[unitIndex] == 0x00);
			break;
		}

		case SCENE_SET_UNIT_ROUTE:
		{
			word16 unitIndex = ReadSceneByte();
			SceneUnitRoute *route = GetUnitRouteRecord(unitIndex);
			word16 waypointIndex;
			route->activeMapX = ScenarioUnitMapX[unitIndex];
			route->activeMapY = ScenarioUnitMapY[unitIndex];
			for (waypointIndex = 0x00; waypointIndex < 0x04; ++waypointIndex)
			{
				byte waypointX = ReadSceneByte();
				byte waypointY = ReadSceneByte();
				route->waypointMapX[waypointIndex] = waypointX;
				route->waypointMapY[waypointIndex] = waypointY;
				if (waypointIndex == 0x00)
				{
					UnitRouteTargetMapX[unitIndex] = waypointX;
					UnitRouteTargetMapY[unitIndex] = waypointY;
				}
			}
			route->waypointIndex = 0x00;
			if (IsCurrentLanceLeader(unitIndex) != 0x00)
			{
				word16 followerIndex = unitIndex + 0x01;
				while ((followerIndex & 0x03) != 0x00)
				{
					if (UnitLanceFormationState[followerIndex]
						!= 0x01)
					{
						SceneUnitRoute *followerRoute =
							GetUnitRouteRecord(followerIndex);
						*followerRoute = *route;
						UnitRouteTargetMapX[followerIndex] =
							UnitRouteTargetMapX[unitIndex];
						UnitRouteTargetMapY[followerIndex] =
							UnitRouteTargetMapY[unitIndex];
					}
					++followerIndex;
				}
			}
			break;
		}

		case SCENE_SET_MOVEMENT_HEAT:
		{
			word16 unitIndex = ReadSceneByte();
			byte movementHeatExponent = ReadSceneByte();
			UnitMovementHeatExponent[unitIndex] = movementHeatExponent;
			REVENGE_PRESERVATION_TRACE("scene: movement unit=%u exponent=%u\n",
				unitIndex, movementHeatExponent);
			break;
		}

		case SCENE_SET_UNIT_TARGET:
		{
			word16 unitIndex = ReadSceneByte();
			byte targetUnit = ReadSceneByte();
			UnitAttackTarget[unitIndex] = targetUnit;
			if (targetUnit == 0x18)
			{
				UnitTargetMapX[unitIndex] = ReadSceneByte();
				UnitTargetMapY[unitIndex] = ReadSceneByte();
			}
			break;
		}

		case SCENE_SET_UNIT_ORDER:
		{
			word16 unitIndex = ReadSceneByte();
			UnitTacticalOrderMode[unitIndex] = ReadSceneByte();
			break;
		}

		case SCENE_INSTALL_UNIT_EQUIPMENT:
		{
			word16 unitIndex = ReadSceneByte();
			InstallUnitEquipmentInFirstFreeSlot(
				unitIndex,
				ReadSceneByte());
			break;
		}

		case SCENE_REMOVE_UNIT_WEAPON:
		{
			word16 unitIndex = ReadSceneByte();
			word16 requestedWeapon = ReadSceneByte();
			RevengeUnitRecord *unitRecord =
				GetPersistentUnitRecord(unitIndex);
			word16 occurrence;
			for (occurrence = 0x00; occurrence < 0x0C; ++occurrence)
			{
				if (FindUnitWeaponByOrdinal(
						unitRecord,
						occurrence,
						0x00) == (int16)requestedWeapon)
				{
					FindUnitWeaponByOrdinal(
						unitRecord,
						occurrence,
						0x01);
					break;
				}
			}
			break;
		}
		}
	}
}

// 1A1F:3A8A: void InstallUnitEquipmentInFirstFreeSlot(
//     word16 unitIndex, byte equipmentId)
// Verified against 1A1F:3A8A-3B89. Search each slot in left torso,
// right torso, left arm, then right arm order; arm arrays contain eight
// slots while torso arrays contain twelve.
void InstallUnitEquipmentInFirstFreeSlot(
	word16 unitIndex,
	byte equipmentId)
{
	RevengeUnitRecord *unitRecord =
		GetPersistentUnitRecord(unitIndex);
	word16 slotIndex;
	for (slotIndex = 0x00;
		slotIndex < BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT;
		++slotIndex)
	{
		if (unitRecord->leftTorsoEquipment[slotIndex] == EQUIPMENT_SLOT_EMPTY)
		{
			unitRecord->leftTorsoEquipment[slotIndex] = equipmentId;
			return;
		}
		if (unitRecord->rightTorsoEquipment[slotIndex] == EQUIPMENT_SLOT_EMPTY)
		{
			unitRecord->rightTorsoEquipment[slotIndex] = equipmentId;
			return;
		}
		if (slotIndex < BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT
			&& unitRecord->leftArmEquipment[slotIndex] == EQUIPMENT_SLOT_EMPTY)
		{
			unitRecord->leftArmEquipment[slotIndex] = equipmentId;
			return;
		}
		if (slotIndex < BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT
			&& unitRecord->rightArmEquipment[slotIndex] == EQUIPMENT_SLOT_EMPTY)
		{
			unitRecord->rightArmEquipment[slotIndex] = equipmentId;
			return;
		}
	}
}

// 1A1F:4447: render the pending tactical narration line.
// Verified against ASM 1A1F:4447-469B. The method prints the resolved
// speaker's surname, selects either a scene message or one of the fixed
// disabled/destroyed-unit strings, and expands the optional '%' unit-name
// substitution in place.
void RenderPendingNarration(void)
{
	RevengeUnitRecord *speakerRecord;
	RevengeUnitRecord *sourceRecord;
	char *message;
	word16 speakerUnitIndex;
	word16 sourceUnitIndex;
	word16 messageCategory;
	word16 sceneMessageTableIndex;
	word16 messageOffset;
	word16 messageIndex;
	word16 speakerBank;
	word16 savedCursorColumn;
	word16 delimiterIndex;
	word16 hasUnitNameSubstitution;
	word16 adjustedMessageCategory;
	int16 pilotId;
	int16 unitTypeId;

	speakerUnitIndex = ActiveNarrationSubject;
	messageCategory = NarrationMessageCategory;
	if (speakerUnitIndex > 0x04 && messageCategory != 0x12)
	{
		word16 lanceLeaderIndex;

		lanceLeaderIndex =
			FindOperationalLanceLeader(speakerUnitIndex);
		if (lanceLeaderIndex != TACTICAL_UNIT_NONE)
			speakerUnitIndex = lanceLeaderIndex;
		speakerUnitIndex &= 0x000C;
	}

	ActiveTextCursorRow = 0x01;
	ActiveTextCursorColumn = 0x01;
	HideMouseCursorOverlay();
	speakerRecord = &PersistentUnitRoster[speakerUnitIndex];
	pilotId = speakerRecord->pilotId;
	RenderFormattedText(PilotSurnameTable[pilotId]);
	ShowMouseCursorOverlay();

	savedCursorColumn =
		(word16) (ActiveTextCursorColumn - 0x03);
	SelectTextWindow(0x0E);
	ActiveTextCursorColumn = savedCursorColumn;
	ActiveTextCursorRow = 0x00;
	RenderFormattedText(SceneNarrationSeparatorText);

	message = 0;
	if (messageCategory == 0x11)
	{
		messageIndex = (word16) (GeneratePseudoRandomByte() % 0x03);
		if (speakerRecord->damageModel == UNIT_DAMAGE_MODEL_BATTLEMECH)
		{
			message = DisabledUnitNarrationTextTable[messageIndex];
		}
		else
		{
			message = DestroyedUnitNarrationTextTable[messageIndex];
		}
	}
	else if (messageCategory == 0x12)
	{
		messageIndex = 0x00;
		if ((int16) ScenarioFileSuffix >= 0x4F
			&& (int16) ScenarioFileSuffix <= 0x53)
		{
			messageIndex = 0x03;
		}
		messageIndex = (word16) (messageIndex
			+ GeneratePseudoRandomByte() % 0x03);
		message = ScenarioEventNarrationTextTable[messageIndex];
	}
	else if (messageCategory < 0x11)
	{
		sceneMessageTableIndex = 0x00;
		adjustedMessageCategory = FALSE;
		if (messageCategory < 0x0B)
		{
			speakerBank = ActiveNarrationSubject;
			if (speakerBank >= 0x08)
				speakerBank = 0x05;
			else if (speakerBank >= 0x04)
				speakerBank = 0x04;
			sceneMessageTableIndex = (word16) (sceneMessageTableIndex
				+ speakerBank * 0x0B);
		}
		else
		{
			sceneMessageTableIndex = (word16) (sceneMessageTableIndex + 0x42);
			NarrationMessageCategory =
				(word16) (messageCategory - 0x0B);
			adjustedMessageCategory = TRUE;
		}
		sceneMessageTableIndex = (word16) (sceneMessageTableIndex
			+ NarrationMessageCategory);
		messageOffset = LoadedSceneFile.header
			.narrationMessageOffsets[sceneMessageTableIndex];
		message = (char *) MAKE_FAR_POINTER(
			SCENE_DATA_SEGMENT, 0x71A8 + messageOffset);
		if (adjustedMessageCategory != FALSE)
		{
			NarrationMessageCategory =
				(word16) (NarrationMessageCategory + 0x0B);
		}
	}

	hasUnitNameSubstitution = FALSE;
	delimiterIndex = 0x00;
	while (message[delimiterIndex] != 0x00
		&& message[delimiterIndex] != '%')
	{
		++delimiterIndex;
	}
	if (message[delimiterIndex] == '%')
	{
		hasUnitNameSubstitution = TRUE;
		message[delimiterIndex] = 0x00;
	}

	HideMouseCursorOverlay();
	RenderFormattedText(message);
	if (hasUnitNameSubstitution != FALSE)
	{
		message[delimiterIndex] = '%';
		++delimiterIndex;
		sourceUnitIndex = NarrationSourceUnit;
		sourceRecord = &PersistentUnitRoster[sourceUnitIndex];
		unitTypeId = sourceRecord->unitTypeId;
		RenderFormattedText(UnitNameTable[unitTypeId]);
		RenderFormattedText(message + delimiterIndex);
	}
	ShowMouseCursorOverlay();
	SelectTextWindow(0x0D);
}

// 1A1F:469C: void AdvanceUnitSceneRoute(word16 unitIndex)
// Verified against 1A1F:469C-4856. Select the next route waypoint and skip
// any waypoint already occupied by the unit.
void AdvanceUnitSceneRoute(word16 unitIndex)
{
	SceneUnitRoute *route = GetUnitRouteRecord(unitIndex);
	int16 routeIndex = route->waypointIndex;
	word16 routeComplete = 0x00;

	if (routeIndex == 0x02)
		SwapUnitRouteWaypoint(unitIndex, 0x01);
	else if (routeIndex == 0x03)
		SwapUnitRouteWaypoint(unitIndex, 0x02);

	while (route->waypointIndex <= 0x03)
	{
		routeIndex = route->waypointIndex;
		route->waypointMapX[routeIndex] = route->activeMapX;
		route->waypointMapY[routeIndex] = route->activeMapY;
		++route->waypointIndex;
	}

	route->waypointIndex = 0x00;
	while (routeComplete == 0x00)
	{
		routeIndex = route->waypointIndex;
		UnitRouteTargetMapX[unitIndex] =
			route->waypointMapX[routeIndex];
		UnitRouteTargetMapY[unitIndex] =
			route->waypointMapY[routeIndex];
		if (ScenarioUnitMapX[unitIndex]
			== UnitRouteTargetMapX[unitIndex]
			&& ScenarioUnitMapY[unitIndex]
			== UnitRouteTargetMapY[unitIndex])
		{
			++route->waypointIndex;
			if (route->waypointIndex > 0x03)
			{
				route->waypointIndex = 0x03;
				routeComplete = 0x01;
			}
		}
		else
			routeComplete = 0x01;
	}
}

// 1A1F:4857: void SwapUnitRouteWaypoint(
//     word16 unitIndex, word16 waypointIndex)
// Verified against 1A1F:4857-4922. Swap waypoint zero with the selected
// waypoint in both four-byte coordinate arrays of the 0Bh-byte route record.
void SwapUnitRouteWaypoint(word16 unitIndex, word16 waypointIndex)
{
	SceneUnitRoute *routeRecord = GetUnitRouteRecord(unitIndex);
	byte savedCoordinate = routeRecord->waypointMapX[0x00];

	routeRecord->waypointMapX[0x00] =
		routeRecord->waypointMapX[waypointIndex];
	routeRecord->waypointMapX[waypointIndex] = savedCoordinate;

	savedCoordinate = routeRecord->waypointMapY[0x00];
	routeRecord->waypointMapY[0x00] =
		routeRecord->waypointMapY[waypointIndex];
	routeRecord->waypointMapY[waypointIndex] = savedCoordinate;
}

// 1A1F:4923: void QueueRandomMapEdgeEffect(
//     short centerX, short centerY)
void QueueRandomMapEdgeEffect(int16 centerX, int16 centerY)
{
	word16 edgeDirection = GeneratePseudoRandomByte() & 0x03;
	int16 mapX;
	int16 mapY;
	switch (edgeDirection)
	{
	case 0x00:
		mapX = centerX + (GeneratePseudoRandomByte() & 0x03) - 0x02;
		mapY = MapHeight + 0x01;
		break;
	case 0x01:
		mapX = -0x01;
		mapY = centerY + (GeneratePseudoRandomByte() & 0x03) - 0x02;
		break;
	case 0x02:
		mapX = centerX + (GeneratePseudoRandomByte() & 0x03) - 0x02;
		mapY = -0x01;
		break;
	default:
		mapX = MapWidth + 0x01;
		mapY = centerY + (GeneratePseudoRandomByte() & 0x03) - 0x02;
		break;
	}

	QueueMapEdgeEffect(mapX, mapY, 0x01C0, edgeDirection);
}

// 1A1F:5476: word16 HasNarrationMessage(
//     word16 narrationSubject, word16 messageCategory)
word16 HasNarrationMessage(
	word16 narrationSubject,
	word16 messageCategory)
{
	word16 activeCategory = NarrationMessageCategory;
	if (activeCategory == 0x11 || activeCategory == 0x12)
		return 0x01;

	if (IsCurrentLanceLeader(narrationSubject) == 0x00
		&& narrationSubject >= 0x04)
	{
		return 0x00;
	}
	if (activeCategory >= 0x0B)
		return 0x01;

	word16 speakerBank = narrationSubject;
	if (speakerBank >= 0x08)
		speakerBank = 0x05;
	else if (speakerBank >= 0x04)
		speakerBank = 0x04;

	word16 messageOffset = LoadedSceneFile.header.narrationMessageOffsets[
		speakerBank * 0x0B + messageCategory];
	char *message = (char *)MAKE_FAR_POINTER(
		SCENE_DATA_SEGMENT,
		0x71A8 + messageOffset);
	return (byte)message[0x00];
}

// 1A1F:5525: void QueueLinkedUnitStatusNarration(word16 unitIndex)
void QueueLinkedUnitStatusNarration(word16 unitIndex)
{
	if (unitIndex < 0x0C || UnitEnemyVisible[unitIndex] == 0x00)
		return;

	int16 linkedUnitIndex = UnitTacticalTarget[unitIndex];
	if (linkedUnitIndex == 0x18)
		linkedUnitIndex = 0x00;
	if (linkedUnitIndex < 0x00 || linkedUnitIndex >= 0x0C
		|| HasNarrationMessage(linkedUnitIndex, 0x08) == 0x00)
	{
		return;
	}

	PendingNarrationDelay = 0x025D;
	ActiveNarrationSubject = linkedUnitIndex;
	NarrationMessageCategory = 0x08;
	NarrationEmphasis = 0x00;
}

// 1A1F:5962: void PrepareUnitTypeResources(word16 unitType)
// PROPOSED: select one of seven scenario resource slots, map the referenced
// unit record's type ID to a resource code DEh-ECh, and reset that slot's
// runtime state. Three mappings are selected by the current SCENE suffix.
