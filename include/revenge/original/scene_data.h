#ifndef REVENGE_ORIGINAL_SCENE_DATA_H
#define REVENGE_ORIGINAL_SCENE_DATA_H

#include "revenge/far_memory.h"
#include "revenge/types.h"

#include <stddef.h>

enum
{
	SCENE_DATA_SEGMENT = 0x3A6A,
	SCENE_FILE_BUFFER_SIZE = 0x08CB,
	SCENE_HEADER_SIZE = 0x0128,
	SCENE_NARRATION_OFFSET_COUNT = 0x48,
	SCENE_UNIT_COUNT = 0x18,
	SCENE_LANCE_COUNT = 0x03,
	SCENE_LANCE_PROFILE_COUNT = 0x06,
	SCENE_FRIENDLY_UNIT_COUNT = 0x0C,
	SCENE_ROUTE_COUNT = 0x19,
	SCENE_ROUTE_WAYPOINT_COUNT = 0x04,
	GAME_OPTION_LABEL_COUNT = 0x07,
	GAME_OPTION_TOGGLE_COUNT = 0x02,
	NARRATION_MODE_LABEL_COUNT = 0x03,
	INPUT_DEVICE_LABEL_COUNT = 0x02,
	UNIT_NARRATION_TEXT_COUNT = 0x03,
	SCENARIO_EVENT_NARRATION_COUNT = 0x1E
};

typedef enum SceneOpcode
{
	SCENE_ENABLE_LANCE = 0xCF,
	SCENE_SET_UNIT_RESOURCE = 0xD0,
	SCENE_CREATE_AREA_IMPACT = 0xD1,
	SCENE_SET_LANCE_FORMATION = 0xD2,
	SCENE_DEPLOY_STORY_UNIT = 0xD3,
	SCENE_SET_CAMPAIGN_MILESTONE = 0xD4,
	SCENE_GRANT_UNIT_UPGRADE = 0xD5,
	SCENE_BRANCH_IF_UNIT_Y_EQUALS = 0xD6,
	SCENE_BRANCH_IF_UNIT_X_EQUALS = 0xD7,
	SCENE_END_BATTLE_RESULT_3 = 0xD8,
	SCENE_END_BATTLE_RESULT_2 = 0xD9,
	SCENE_BRANCH_IF_UNIT_WITHDRAWN = 0xDA,
	SCENE_WITHDRAW_UNIT_AT_LOCATION = 0xDB,
	SCENE_QUEUE_NARRATION_EVENT_24 = 0xDC,
	SCENE_QUEUE_NARRATION_EVENT_23 = 0xDD,
	SCENE_QUEUE_NARRATION_EVENT_22 = 0xDE,
	SCENE_QUEUE_NARRATION_EVENT_21 = 0xDF,
	SCENE_QUEUE_NARRATION_EVENT_20 = 0xE0,
	SCENE_QUEUE_NARRATION_EVENT_19 = 0xE1,
	SCENE_CREATE_RANDOM_EDGE_EFFECT = 0xE2,
	SCENE_SET_UNIT_GUNNERY = 0xE3,
	SCENE_SET_UNIT_PILOT = 0xE4,
	SCENE_SET_UNIT_PILOT_EXPERIENCE = 0xE5,
	SCENE_BRANCH_IF_TERRAIN_DESTROYED = 0xE6,
	SCENE_BRANCH_IF_TERRAIN_DAMAGED = 0xE7,
	SCENE_ADVANCE_UNIT_ROUTE = 0xE8,
	SCENE_DEPLOY_UNIT = 0xE9,
	SCENE_ADD_AMMUNITION = 0xEA,
	SCENE_REMOVE_AMMUNITION = 0xEB,
	SCENE_BRANCH_IF_CLOCK_EQUALS = 0xEC,
	SCENE_BRANCH_IF_CLOCK_REACHED = 0xED,
	SCENE_SET_CLOCK = 0xEE,
	SCENE_BRANCH_IF_WEAPON_ABSENT = 0xEF,
	SCENE_BRANCH_IF_AMMUNITION_PRESENT = 0xF0,
	SCENE_BRANCH_IF_UNIT_OPERATIONAL = 0xF1,
	SCENE_BRANCH_IF_INTERNAL_PERCENT = 0xF2,
	SCENE_BRANCH_IF_DURABILITY_PERCENT = 0xF3,
	SCENE_REPAIR_ARMOR = 0xF4,
	SCENE_DAMAGE_ARMOR = 0xF5,
	SCENE_YIELD = 0xF6,
	SCENE_JUMP = 0xF7,
	SCENE_BRANCH_IF_UNIT_NOT_ATTACKED = 0xF8,
	SCENE_SET_UNIT_ROUTE = 0xF9,
	SCENE_SET_MOVEMENT_HEAT = 0xFA,
	SCENE_SET_UNIT_TARGET = 0xFB,
	SCENE_SET_UNIT_ORDER = 0xFC,
	SCENE_INSTALL_UNIT_EQUIPMENT = 0xFD,
	SCENE_REMOVE_UNIT_WEAPON = 0xFE,
	SCENE_END = 0xFF
} SceneOpcode;

#pragma pack(push, 1)
typedef struct SceneFileHeader
{
	word16 payloadSize;
	word16 instructionBlockOffset;
	word16 narrationMessageOffsets[SCENE_NARRATION_OFFSET_COUNT];
	byte lanceEnabled[SCENE_LANCE_COUNT];
	byte initialUnitResourceCode[0x07];
	byte artillerySupportAvailable;
	byte strafingSupportAvailable;
	byte reservedA0;
	byte overviewNoticeChance;
	byte lineOfSightMaximumSteps;
	byte terrainEffectMode;
	byte terrainDamageCapabilityMode;
	byte overviewMapMode;
	byte lanceFormationProfile[SCENE_LANCE_PROFILE_COUNT];
	byte unitType[SCENE_UNIT_COUNT];
	byte friendlyMapX[SCENE_FRIENDLY_UNIT_COUNT];
	byte friendlyMapY[SCENE_FRIENDLY_UNIT_COUNT];
	byte enemyMapX[SCENE_FRIENDLY_UNIT_COUNT];
	byte enemyMapY[SCENE_FRIENDLY_UNIT_COUNT];
	byte unitFacing[SCENE_UNIT_COUNT];
	byte friendlyPilotRosterSlot[SCENE_FRIENDLY_UNIT_COUNT];
	byte opposingPilotRosterSlot[SCENE_FRIENDLY_UNIT_COUNT];
	byte reserved124[0x04];
} SceneFileHeader;

typedef union SceneFileBuffer
{
	SceneFileHeader header;
	byte raw[SCENE_FILE_BUFFER_SIZE];
} SceneFileBuffer;

typedef union SceneUnitRoute
{
	struct
	{
		int8 waypointIndex;
		byte activeMapX;
		byte activeMapY;
		byte waypointMapX[SCENE_ROUTE_WAYPOINT_COUNT];
		byte waypointMapY[SCENE_ROUTE_WAYPOINT_COUNT];
	};
	byte raw[0x0B];
} SceneUnitRoute;
#pragma pack(pop)

_Static_assert(sizeof(SceneFileHeader) == SCENE_HEADER_SIZE,
	"SCENE header must end where its instruction stream begins");
_Static_assert(offsetof(SceneFileHeader, narrationMessageOffsets) == 0x04,
	"SCENE narration offsets must remain at file offset 04h");
_Static_assert(offsetof(SceneFileHeader, lanceEnabled) == 0x94,
	"SCENE tactical configuration must remain at file offset 94h");
_Static_assert(offsetof(SceneFileHeader, unitType) == 0xAC,
	"SCENE unit types must remain at file offset ACh");
_Static_assert(offsetof(SceneFileHeader, unitFacing) == 0xF4,
	"SCENE unit facings must remain at file offset F4h");
_Static_assert(sizeof(SceneUnitRoute) == 0x0B,
	"SCENE unit routes must retain their original 0Bh layout");

extern SceneFileBuffer LoadedSceneFile;
extern SceneUnitRoute SceneUnitRoutes[SCENE_ROUTE_COUNT];
extern word16 SceneInstructionBaseOffset;
extern DosAddress SceneInstructionCursor;
extern DosAddress ScenarioResourcePathPointer;
extern char ScenarioResourcePathText[];
extern const char SceneFileTooLargeText[];
extern const char * const GameOptionLabelTextTable[GAME_OPTION_LABEL_COUNT];
extern const char * const GameOptionToggleTextTable[GAME_OPTION_TOGGLE_COUNT];
extern const char * const NarrationModeLabelTextTable[NARRATION_MODE_LABEL_COUNT];
extern const char * const InputDeviceLabelTextTable[INPUT_DEVICE_LABEL_COUNT];
extern const char FocusUnitText[];
extern const char FocusLanceText[];
extern char * const DisabledUnitNarrationTextTable[UNIT_NARRATION_TEXT_COUNT];
extern char * const DestroyedUnitNarrationTextTable[UNIT_NARRATION_TEXT_COUNT];
extern char * const ScenarioEventNarrationTextTable[SCENARIO_EVENT_NARRATION_COUNT];
extern const char SceneNarrationSeparatorText[];

#endif
