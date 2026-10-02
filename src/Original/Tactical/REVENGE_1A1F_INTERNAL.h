#ifndef REVENGE_1A1F_INTERNAL_H
#define REVENGE_1A1F_INTERNAL_H

// REVENGE_1A1F_SCENARIO.c
// Tactical battle orchestration, SCENE interpretation, input, and campaign
// clock procedures reconstructed from REVENGE.EXE segment 1A1F.

#include "REVENGE.h"
#include "revenge/input.h"
#include "revenge/original/scene_data.h"
#include "revenge/original_data.h"
#include "revenge/video.h"


word16 ReadTerrainDamageState(int16 mapX, int16 mapY);
void BeginTerrainDamageAtCell(
	word16 mapX, word16 mapY, word16 terrainType);

int16 ResolveUnitAtTacticalCursor(void);
void MoveTacticalCursorByInput(int16 inputCode);
uint16 DetermineOctant(int16 deltaY, int16 deltaX);
int16 InterpolateLineCoordinate(
	int16 clipCoordinate,
	int16 targetCoordinate,
	int16 sourceValue,
	int16 targetValue,
	int16 sourceCoordinate);
uint16 DetermineRelativeAttackDirection(
	int16 sourceX,
	int16 sourceY,
	int16 targetX,
	int16 targetY);
void OffsetWeaponTraceEndpoint(
	int16 *sourceX, int16 *sourceY,
	int16 *targetX, int16 *targetY);
void AdvanceScenarioAreaEffects(void);
int16 MapUnitToTacticalStatusSlot(word16 unitIndex);
void KeepTacticalCursorOnSelectedUnit(void);
void RefreshTacticalStatusSlotStates(void);
void AdvanceTacticalCampaignClock(void);
void BuildScenarioTerrainDamageCapabilityMap(word16 terrainEffectMode);
void ApplyScenarioMissileUpgradeAvailability(void);
int16 TranslateTacticalMouseInput(int16 inputAction);
void DrawClippedWeaponTraceLine(
	int16 startX, int16 startY,
	int16 endX, int16 endY,
	word16 color, word16 dashedTrace);
void DrawTileAlignedText(
	const char *text,
	word16 tileX,
	word16 tileY,
	byte foregroundColor,
	byte backgroundColor);
void LoadTacticalMap(word16 mapNumber);
void LoadTacticalIconSetResources(word16 iconSetNumber);
void ExecuteSceneInstructions(void);
word16 AdvanceTerrainDamageState(
	int16 mapX, int16 mapY, word16 damageAmount);
void UpdateUnitSpriteForFacing(word16 unitIndex, word16 facing);
byte *AddBytesToFarPointer(byte *base, uint32 byteCount);
void DrawTacticalOverviewMap(void);
word16 RunGameOptionsMenu(word16 embeddedMode);
void UpdateUnitHeatAccumulators(void);
void ApplyAreaTerrainAndUnitDamage(
	int16 mapX, int16 mapY, word16 radius, word16 damageAmount);
void OpenModalTextWindow(word16 windowIndex, word16 clearAndFrame);
void RestoreModalTextWindow(void);
word16 ConfirmExitToDos(void);
void DisableMusicPlayback(void);
void EnableMusicPlayback(void);

#define TacticalResourceSlotState SceneNarrationEventFlags
#define TacticalOverviewZoomed TacticalOverviewViewportDirty
#define TacticalOverviewSavedMode TacticalOverviewDisplayMode
#define NarrationReady FriendlyUnitDestroyed

#undef MAKE_FAR_POINTER
#define MAKE_FAR_POINTER(segment, offset) \
	HostFarPointer_Resolve(MAKE_DWORD((segment), (offset)))

#define TACTICAL_RUNTIME_ALLOCATION_SIZE     0xCB90
#define TACTICAL_VIEWPORT_WIDTH_CELLS        0x0013
#define TACTICAL_VIEWPORT_HEIGHT_CELLS       0x000C
#define CAMPAIGN_MINUTES_PER_HOUR            0x003C
#define CAMPAIGN_HOURS_PER_DAY               0x0018
#define TACTICAL_OVERVIEW_MAP_OFFSET         0x4E20
#define PACKED_TERRAIN_DAMAGE_MAP_OFFSET     0xA000
#define TACTICAL_CELL_SPRITE_MAP_OFFSET      0xC800
#define TACTICAL_CELL_TERRAIN_MAP_OFFSET     0xC9C8
#define TACTICAL_BACKING_BUFFER(index) \
	SharedGraphicsBackingBuffers[(index)]
#define SET_TACTICAL_BACKING_BUFFER(index, buffer) \
	(SharedGraphicsBackingBuffers[(index)] = (buffer))

// Proposed behavioral names from the complete tactical-AI consumer pass.
// 00 follows only the scripted route, 01 attacks without autonomous pursuit,
// and 02 selects and pursues targets autonomously.
#define TACTICAL_ORDER_SCRIPTED_ROUTE         0x00
#define TACTICAL_ORDER_HOLD_POSITION          0x01
#define TACTICAL_ORDER_SEEK_AND_DESTROY       0x02

#define CAMPAIGN_MILESTONE_APC_BRIDGE         0x00
#define CAMPAIGN_MILESTONE_SRM_SHIPMENT       0x01
#define CAMPAIGN_MILESTONE_LRM_SHIPMENT       0x02
#define CAMPAIGN_MILESTONE_PILOT_EJECTED      0x03
#define CAMPAIGN_MILESTONE_UNKNOWN_04         0x04
#define CAMPAIGN_MILESTONE_UNKNOWN_05         0x05
#define CAMPAIGN_MILESTONE_COMMANDER_CRIPPLED 0x06
#define CAMPAIGN_MILESTONE_MECH_SHOP_REACHED  0x07

#define UNIT_UPGRADE_MISSILE_SYSTEM           0x00
#define UNIT_UPGRADE_BEAGLE_ACTIVE_PROBE      0x01
#define UNIT_UPGRADE_INDIRECT_FIRE_SPOTTER    0x02
#define UNIT_UPGRADE_CASE                     0x03
#define UNIT_UPGRADE_CAMPAIGN_AWARD           0x04

void AssignPilotRosterEntryToUnit(
	word16 unitIndex,
	word16 rosterSlot);
void AdvanceUnitSceneRoute(word16 unitIndex);
void SwapUnitRouteWaypoint(word16 unitIndex, word16 waypointIndex);
void InstallUnitEquipmentInFirstFreeSlot(
	word16 unitIndex,
	byte equipmentId);
int16 FindUnitWeaponByOrdinal(
	RevengeUnitRecord *unitRecord,
	word16 weaponOccurrence,
	word16 removeWeapon);
word16 FindOperationalLanceLeader(word16 unitIndex);
void RenderFormattedText(const char *formattedText);
word16 WaitForDismissInput(void);
word16 ServiceMusicAndCheckKeyboardInput(void);
void DrawCampaignClock(void);
void RefreshAllUnitCombatState(word16 rebuildWeaponCounts);
int16 UpdateUnitEnemyVisibility(word16 unitIndex);
int16 UpdateUnitEnemyProximityState(word16 unitIndex);
void RebuildLanceFormationAfterLeaderLoss(word16 lanceBaseUnitIndex);
word16 ExecuteUnitWeaponAI(word16 unitIndex);
byte UpdateUnitHeatShutdown(word16 unitIndex);
void RedrawTacticalStatusPanel(void);

// Assembly-verified tactical icon resource helpers.
void RebuildTacticalViewport(void);
void UpdateTacticalFrame(word16 inputAction, word16 advanceUnits);
void InitializeTacticalUnitRuntime(void);
void LoadTacticalScenarioResources(byte scenarioCode);
void RedrawTacticalViewport(void);
void DrawTacticalCursorOutline(word16 color);
void DrawSelectedUnitStatusPanel(void);
void AdvanceUnitTacticalMovement(word16 unitIndex);
void ScrollTacticalViewportToCursor(void);
void HandleTacticalInput(word16 inputAction);
word16 HasActiveLanceFollowers(word16 unitIndex);
void HighlightLanceFollowers(word16 leaderUnitIndex);

void ShowPendingNarrationPrompt(void);
void ExitTacticalOverview(void);
void FocusTacticalViewOnUnit(word16 unitIndex);
word16 SelectNextUnitAtCursor(void);
word16 SelectPreviousUnitAtCursor(void);
word16 FindUnitAtTacticalCursor(void);
void OpenTacticalUnitControlPanel(word16 unitIndex);
word16 IsTacticalFunctionKey(int16 inputAction);
void RenderPendingNarration(void);
void CreateRandomAreaImpact(
	int16 centerX,
	int16 centerY,
	word16 chanceDenominator);

#define TACTICAL_UNIT_NONE                   0xFFFF
#define TACTICAL_ENEMY_FIRST_UNIT            0x000C
#define TACTICAL_ENEMY_SPRITE_LIMIT          0x00DC
#define TACTICAL_ENEMY_SPRITE_EXCLUDED_FIRST 0x00C0
#define TACTICAL_ENEMY_SPRITE_EXCLUDED_END   0x00D0
#define NARRATION_READY_OFFSET               0xB5D2
#define TACTICAL_OVERVIEW_ZOOMED_OFFSET      0x8335
#define TACTICAL_OVERVIEW_SAVED_UNIT_OFFSET  0x8102

#define PERSISTENT_UNIT_RECORD(unitIndex) \
	(&PersistentUnitRoster[(unitIndex)])
#define NEXT_SCENE_BYTE() \
	(*(byte *)MAKE_FAR_POINTER( \
		SceneInstructionCursor.segment, \
		SceneInstructionCursor.offset++))
RevengeUnitRecord *GetPersistentUnitRecord(word16 unitIndex);
#define GetUnitRouteRecord(unitIndex) (&SceneUnitRoutes[(unitIndex)])
#define ReadSceneByte() NEXT_SCENE_BYTE()
#define ReadSceneWord() \
	((word16)(NEXT_SCENE_BYTE() | ((word16)NEXT_SCENE_BYTE() << 0x08)))
#define JumpToSceneOffset(sceneOffset) \
	do \
	{ \
		SceneInstructionCursor.segment = SCENE_DATA_SEGMENT; \
		SceneInstructionCursor.offset = \
			0x71A8 \
			+ SceneInstructionBaseOffset \
			+ (sceneOffset); \
	} while (0)
#define BranchOrSkipSceneWord(takeBranch) \
	do \
	{ \
		word16 branchOffset = ReadSceneWord(); \
		if ((takeBranch) != 0x00) \
			JumpToSceneOffset(branchOffset); \
	} while (0)


#endif
