#ifndef REVENGE_SAVE_DATA_H
#define REVENGE_SAVE_DATA_H

#include <stddef.h>

#include "revenge/roster.h"
#include "revenge/types.h"
#include "revenge/unit.h"

enum
{
	REVENGE_SAVE_FILE_SIZE = 0x61C0,
	REVENGE_SAVE_BOUNDARY_COUNT = 0x09,
	REVENGE_SAVE_DIRECTORY_OFFSET = 0x0012,
	REVENGE_SAVE_DIRECTORY_PREFIX_SIZE = 0x04,
	REVENGE_SAVE_DESCRIPTOR_OFFSET = 0x0016,
	REVENGE_SAVE_DESCRIPTOR_SIZE = 0x16,
	REVENGE_SAVE_DESCRIPTOR_NAME_SIZE = 0x15,
	REVENGE_SAVE_EDITOR_LABEL_SIZE = 0x11,
	REVENGE_SAVE_SLOT_COUNT = 0x06,
	REVENGE_SAVE_PAYLOAD_SIZE = 0x1031,
	REVENGE_CAMPAIGN_SNAPSHOT_SIZE = 0x0221,
	REVENGE_SAVE_UNIT_BLOCK_OFFSET = 0x0221,
	REVENGE_SAVE_UNIT_COUNT = 0x18,
	REVENGE_SAVE_SCENARIO_RECORD_COUNT = 0x12,
	REVENGE_SAVE_SCENARIO_RECORD_SIZE = 0x0F,
	REVENGE_SAVE_LANCE_ASSIGNMENT_COUNT = 0x0D,
	REVENGE_SAVE_PILOT_COUNT = 0x25
};

#pragma pack(push, 1)
typedef struct RevengeSaveSlotDescriptor
{
	byte occupied;
	char name[REVENGE_SAVE_DESCRIPTOR_NAME_SIZE];
} RevengeSaveSlotDescriptor;

typedef struct RevengeCampaignSnapshot
{
	word16 campaignStageIndex;
	word16 scenarioVariantIndex;
	byte campaignPhase;
	byte trainingSequenceFlag;
	word16 campaignFlags;
	word16 state24E1;
	word16 stateA967;
	word16 scene3RosterSelector9991;
	word16 state88F1;
	word16 state8925;
	word16 state99C5;
	word16 stateA965;
	word16 state8594;
	word16 lrmShipmentLoaded;
	word16 srmShipmentLoaded;
	byte scenarioClock[0x03];
	byte trainingScenarioCompletionFlags[0x06];
	byte scenarioUnitMapX[REVENGE_SAVE_UNIT_COUNT];
	byte scenarioUnitMapY[REVENGE_SAVE_UNIT_COUNT];
	byte state1B85[0x07];
	byte state1B8E;
	byte state1BAD[0x0F];
	UnitSelectionCard scenarioRecords[REVENGE_SAVE_SCENARIO_RECORD_COUNT];
	RevengeUnitLanceAssignment
		lanceAssignments[REVENGE_SAVE_LANCE_ASSIGNMENT_COUNT];
	byte pilotAvailability[REVENGE_SAVE_PILOT_COUNT];
} RevengeCampaignSnapshot;

typedef struct RevengeSaveSlot
{
	RevengeSaveSlotDescriptor descriptor;
	RevengeCampaignSnapshot campaign;
	byte liveUnits[REVENGE_SAVE_UNIT_COUNT][UNIT_RECORD_SIZE];
} RevengeSaveSlot;

typedef struct RevengeSaveGame
{
	byte directoryPrefix[REVENGE_SAVE_DIRECTORY_PREFIX_SIZE];
	RevengeSaveSlot slots[REVENGE_SAVE_SLOT_COUNT];
} RevengeSaveGame;
#pragma pack(pop)

_Static_assert(sizeof(RevengeSaveSlotDescriptor) ==
	REVENGE_SAVE_DESCRIPTOR_SIZE,
	"Save-slot descriptors must retain their DOS file layout");
_Static_assert(offsetof(RevengeSaveSlotDescriptor, name) == 0x01,
	"Save-slot names must remain at descriptor offset 01h");
_Static_assert(sizeof(RevengeCampaignSnapshot) ==
	REVENGE_CAMPAIGN_SNAPSHOT_SIZE,
	"Campaign snapshots must retain their DOS file layout");
_Static_assert(sizeof(UnitSelectionCard) == REVENGE_SAVE_SCENARIO_RECORD_SIZE,
	"Scenario cards must retain their save-file record size");
_Static_assert(offsetof(RevengeCampaignSnapshot, scenarioClock) == 0x1C,
	"Campaign clock must remain at snapshot offset 1Ch");
_Static_assert(offsetof(RevengeCampaignSnapshot, scenarioUnitMapX) == 0x25,
	"Scenario unit X coordinates must remain at snapshot offset 25h");
_Static_assert(offsetof(RevengeCampaignSnapshot, scenarioRecords) == 0x6C,
	"Scenario records must remain at snapshot offset 6Ch");
_Static_assert(offsetof(RevengeCampaignSnapshot, lanceAssignments) == 0x17A,
	"Lance assignments must remain at snapshot offset 17Ah");
_Static_assert(offsetof(RevengeCampaignSnapshot, pilotAvailability) == 0x1FC,
	"Pilot availability must remain at snapshot offset 1FCh");
_Static_assert(sizeof(RevengeSaveSlot) ==
	REVENGE_SAVE_DESCRIPTOR_SIZE + REVENGE_SAVE_PAYLOAD_SIZE,
	"Save slots must remain one descriptor plus one original payload");

#endif
