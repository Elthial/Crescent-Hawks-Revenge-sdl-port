// REVENGE_3A6A_TACTICAL_DATA.c
// Typed objects recovered from REVENGE.EXE DS segment 3A6A.

#include "revenge/original_data.h"
#include "revenge/audio.h"
#include "revenge/far_memory.h"
#include "revenge/video.h"
#include "REVENGE.h"

byte *DamagedTerrainSpriteLookup;
byte TacticalEffectOverlayMap[0x00E4];
uint32 GameTimerTicks;
uint32 GameAnimationTicks;
int8 TacticalSlotSpriteState[0x18];
byte UnitTypeResourceCode[0x07];
byte UnitTacticalOrderMode[0x18];
int8 UnitAttackTarget[0x18];
word16 UnitSpriteBaseId[0x18];
word16 UnitSpriteId[0x18];
word16 TacticalSpriteAnimationPhase;
word16 TacticalSelectedUnitIndex;
word16 TacticalViewportMapX;
word16 TacticalViewportMapY;
word16 TacticalCursorViewportX;
word16 TacticalCursorViewportY;
byte UnitTargetMapX[0x19];
byte UnitTargetMapY[0x19];
byte UnitRouteTargetMapX[0x19];
byte UnitRouteTargetMapY[0x19];
SceneUnitRoute SavedTacticalRoute;
byte TacticalInteractionLocked;
word16 TacticalMenuInputState;
const char TacticalPaddingSpace[] = " ";
const char TacticalStatusSeparator[] = " ";
const char TacticalStatusPadding[] = " "; /* DS:30C2 */
const char UnitStatusArmorLabel[] = "ARMOR:";
const char UnitStatusHeatLabel[] = "HEAT:";
const char UnitStatusExitLabel[] = "EXIT";
const char UnitStatusHeatDetailLabel[] = "Heat:\r";
const char UnitStatusDamageLabel[] = "Dmg:";
const char UnitStatusRatingLabels[] =
	"Lng:\rMed:\rCls:\rArm:\rSpd:\r";
const char IntelligenceHeading[] = "Intelligence\r";
const char ScannedByActiveProbeText[] = "Scanned by BAP";
const char DetectedByText[] = "Detected by";
const char RadarSensorText[] = "Radar Sensor";
const char EnemyAndFriendlyLancesText[] =
	"Enemy Lances:\r\r\r\r\r\rFriendly:";
const char UnknownUnitText[] = "Ukwn";
const char NoSatelliteUplinkText[] = "No satellite uplink available.";
const char UplinkJammedText[] =
	"\rCommand: Uplink is jammed.  Try later.";
const char OutOfScanningText[] = "Out of scanning";
const char RangeText[] = "range";
const char ArrowTagEquipmentText[] = "Arrow TAG ";
const char BapEquipmentText[] = "BAP ";
const char AccuracyEquipmentText[] = "Accuracy ";
const char DoubleHeatSinkEquipmentText[] = "Double HS ";
const char JumpEquipmentSuffix[] = " J";
const char CaseEquipmentText[] = "CASE ";
const char MoveDestinationPromptSuffix[] = " to move to:";
const char FormationHeading[] = "\rFormation:";
const char SatelliteZoomText[] = "SATELLITE ZOOM";
const char ContinueText[] = "Continue";
const char DoneText[] = "Done";
const char NoTacticalTargetText[] = "?";
const char ViewSatelliteMapText[] = "View Satellite Map";
const char SelectStrafingAreaPrompt[] = "Select area to strafe:";
const char SelectArtilleryTargetPrompt[] = "Artillery to shell at:";
const char SelectBarrageStartPrompt[] =
	"Artillery to start barrage at:";
const char SelectBarrageEndPrompt[] = "Artillery to end barrage at:";
const char SelectFireTargetPrompt[] = "Fire at:";
static const char TacticalCommandsText[] = "Commands";
static const char TacticalLanceCommandsText[] = "Lance Commands";
static const char TacticalTargetText[] = "Target: ";
static const char TacticalCeaseFireAtText[] = "Cease Fire At";
static const char TacticalStopText[] = "Stop";
static const char TacticalWalkingSpeedText[] = "Walking Speed";
static const char TacticalRunningSpeedText[] = "Running Speed";
static const char TacticalMoveText[] = "Move\r";
static const char TacticalStoppedText[] = "Stop";
static const char TacticalCruisingSpeedText[] = "Cruising Speed";
static const char TacticalFlankSpeedText[] = "Flank Speed";
static const char TacticalFireAtNoOneText[] = "Fire At No One";
static const char TacticalFireDefensivelyText[] = "Fire Defensively";
static const char TacticalFireAtWillText[] = "Fire At Will";
const char *TacticalUnitCommandTextTable[0x0E] =
{
	TacticalCommandsText, TacticalLanceCommandsText,
	TacticalTargetText, TacticalCeaseFireAtText,
	TacticalStopText, TacticalWalkingSpeedText,
	TacticalRunningSpeedText, TacticalMoveText,
	TacticalStoppedText, TacticalCruisingSpeedText,
	TacticalFlankSpeedText, TacticalFireAtNoOneText,
	TacticalFireDefensivelyText, TacticalFireAtWillText
};
static const char ShellCoordinateText[] = "Shell Coordinate";
static const char CallOffShellingText[] = "Call off Shelling";
static const char RollingBarrageText[] = "Rolling Barrage";
static const char CallOffBarrageText[] = "Call off Barrage";
static const char CallStrafingText[] = "Call Strafing";
static const char CallOffStrafingText[] = "Call off Strafing";
static const char CloseAssaultText[] = "Close Assault";
static const char CeaseAssaultText[] = "Cease Assault";
const char *TacticalSupportCommandTextTable[0x08] =
{
	ShellCoordinateText, CallOffShellingText,
	RollingBarrageText, CallOffBarrageText,
	CallStrafingText, CallOffStrafingText,
	CloseAssaultText, CeaseAssaultText
};
static const char OverburnOffText[] = "Overburn: Off";
static const char OverburnOnText[] = "Overburn: On";
const char *TacticalOverburnTextTable[0x02] =
	{ OverburnOffText, OverburnOnText };
static const char LanceCommandText[] = "Command";
static const char LanceFireText[] = "Fire";
static const char LanceAssaultText[] = "Assault";
static const char LanceReconText[] = "Recon";
static const char LanceLightText[] = "Light";
static const char LanceMediumText[] = "Medium";
static const char LanceHeavyText[] = "Heavy";
static const char LanceAssaultWeightText[] = "Assault";
const char *LanceStatusTextTable[0x08] =
{
	LanceCommandText, LanceFireText,
	LanceAssaultText, LanceReconText,
	LanceLightText, LanceMediumText,
	LanceHeavyText, LanceAssaultWeightText
};
const char DeadText[] = "Dead";
RevengeMapEdgeEffectRecord MapEdgeEffectQueue[MAP_EDGE_EFFECT_RECORD_COUNT];
word16 MapEdgeEffectCount;
word16 PrimaryStatusRow;
word16 SecondaryStatusRow;
word16 TacticalUiSuppressed;
word16 PrimaryStatusHighlightColor;
word16 CachedPrimaryStatusHighlightColor;
word16 SecondaryStatusHighlightColor;
word16 CachedSecondaryStatusHighlightColor;
byte TacticalStatusRowInvalidation[0x18];
byte TacticalOverviewMarkerX[0x18];
word16 TacticalOverviewViewportX;
byte TacticalOverviewMarkerY[0x18];
word16 TacticalOverviewViewportY;
word16 TacticalOverviewScreenOriginX;
word16 DisplayedTacticalStatusRow;
word16 TacticalStatusBlinkCountdown;
byte TacticalStatusBlinkVisible;
const int8_t WeaponTraceMajorStepX[0x08] =
	{ 0x00, 0x01, 0x01, 0x00, 0x00, -0x01, -0x01, 0x00 };
const int8_t WeaponTraceMajorStepY[0x08] =
	{ -0x01, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, -0x01 };
const int8_t WeaponTraceMinorStepX[0x08] =
	{ 0x01, 0x00, 0x00, 0x01, -0x01, 0x00, 0x00, -0x01 };
const int8_t WeaponTraceMinorStepY[0x08] =
	{ 0x00, -0x01, 0x01, 0x00, 0x00, 0x01, -0x01, 0x00 };
const char TacticalNoUnitStatusText[] =
	"                           ";
const char FriendlyUnitStatusHeading[] = "CU ";
const char EnemyUnitStatusHeading[] = "   ";
const char UnitStatusSeparatorText[] = " ";
const char UnitHeatStatusPrefix[] = "/";
const char TacticalNarrationBlankText[] = "   ";
const char TacticalClockBlankText[] = "   ";
const char TacticalNarrationLabel[] = "MSG";
const char CombatRatingLightText[] = "Light";
const char CombatRatingModerateText[] = "Moderate";
const char CombatRatingHeavyText[] = "Heavy";
const char CombatRatingBrutalText[] = "Brutal";
const char CombatRatingDevastatingText[] = "Devastating";
const char CombatRatingIncredibleText[] = "Incredible";
const char CombatRatingNoneText[] = "None";
const char *CombatRatingDescriptionTable[0x07] =
{
	CombatRatingLightText,
	CombatRatingModerateText,
	CombatRatingHeavyText,
	CombatRatingBrutalText,
	CombatRatingDevastatingText,
	CombatRatingIncredibleText,
	CombatRatingNoneText
};
RevengeUnitRecord PersistentUnitRoster[0x18];
RevengeUnitRecord LiveScenarioUnits[0x18];
RevengeUnitRecord BlankUnitRecord;
byte SavedScenarioUnitMapX[0x18];
byte SavedScenarioUnitMapY[0x18];
byte ScenarioUnitMapX[0x18];
byte ScenarioUnitMapY[0x18];
byte ScenarioUnitFacing[0x18];
byte CampaignClockState[0x03];
byte SavedCampaignClockState[0x03];
RevengePilotRosterRecord PilotRoster[REVENGE_PILOT_ROSTER_COUNT];
RevengeUnitLanceAssignment
	LanceAssignments[REVENGE_LANCE_ASSIGNMENT_COUNT];
const byte ScenarioLanceAllegianceTable[0x08][0x03] = {
	{ 0x01, 0x01, 0x01 }, { 0x00, 0x00, 0x00 },
	{ 0x00, 0x01, 0x01 }, { 0x01, 0x00, 0x01 },
	{ 0x00, 0x02, 0x02 }, { 0x00, 0x03, 0x03 },
	{ 0x00, 0x00, 0x03 }, { 0x00, 0x00, 0x00 }
};
const word16 AmmoCapacityMultiplierTable[0x0E] = {
	0x002D, 0x0014, 0x000A, 0x0008, 0x0008, 0x0005, 0x00C8,
	0x0018, 0x000C, 0x0008, 0x0006, 0x0032, 0x0019, 0x000F
};
word16 CampaignFlags;
word16 CampaignStageIndex;
word16 ScenarioUnitZeroAvailable;
int16 ScenarioUnitFifteenState;
word16 ScenarioUnitFourteenEnabled;
word16 EjectedPilotRosterState;
word16 ScenarioUnitThirteenEnabled;
byte CampaignUnitThirteenAvailabilityFlag;
byte CampaignUnitFifteenOverrideFlag;
byte CampaignUnitFourteenAvailabilityFlag;
byte StoryUnitDeployedFlag;
byte SelectedSaveSlotIndex;
byte SaveLoadMenuDefaultSelection;
byte ScenarioRosterPrepared;
int8 PendingCampaignStageDelta;
byte PendingCampaignPhaseDelta;
int16 ScenarioVariantIndex;
byte CampaignPhase;
byte ReplayCampaignStateRequested;
byte TrainingSequenceFlag;
word16 DeferredStage16Story;
word16 SavedCampaignFlags;
byte AlternateLanceSelection;
byte SuppressPostStageMenu;
byte CampaignRestartState;
word16 ModalSavedTextWindow;
word16 ModalBackingX;
word16 ModalBackingY;
word16 ModalBackingWidth;
word16 ModalBackingHeight;
byte ActivePilotListWindowHeight;
byte CommanderListWindowHeight;
byte FallenPilotListWindowHeight;
byte CampaignState1B8C;
byte CampaignState1B8D;
byte CampaignState1B8E;
word16 SaveTransferState;
word16 SavedSaveTransferState;
word16 CampaignScenarioState;
byte ReplayScenarioRequested;
byte CampaignMenuRequested;
word16 NarrationFocusRegion;
/* Relocated initial far pointers recovered from REVENGE.EXE DS:1530 and
 * DS:1566. */
word16 UnitTemplatePathOffset = 0x21B8;
word16 UnitTemplatePathSegment = 0x3A6A;
word16 TacticalResourcePathOffset = 0x21DD;
word16 TacticalResourcePathSegment = 0x3A6A;
word16 TacticalOverviewClockNoticeActive;
word16 TacticalRuntimeState;
word16 PreviousMouseCellX;
word16 PreviousMouseCellY;
byte TacticalOverviewNoticeChance;
byte EjectedPilotMapX;
byte EjectedPilotMapY;
byte EjectedPilotState;
word16 TacticalCursorRuntimeState;
word16 TacticalCursorMapX;
word16 TacticalCursorMapY;
word16 LastOverviewNoticeHour;
word16 TacticalOverviewRuntimeState;
byte PrimaryLanceResourceCode;
word16 TacticalMapNegativeStridePrimary;
word16 TacticalMapPositiveStridePrimary;
word16 TacticalMapPositiveStrideSecondary;
word16 TacticalMapNegativeStrideSecondary;
word16 TacticalMapNegativeStrideTertiary;
word16 TacticalMapPositiveStrideTertiary;
word16 TacticalMapPositiveStrideQuaternary;
word16 TacticalMapNegativeStrideQuaternary;
byte UnitEditorAllegiance;
word16 UnitEditorScenarioGroupCount;
word16 UnitEditorScenarioCardCount;
word16 UnitEditorPilotCardCount;
word16 UnitEditorLanceGroupCount;
word16 TextOutputMode;
word16 SelectedUnitEquipmentLocation;
RevengeUnitRecord EstimatedUnitRecord;
RevengeTacticalCombatRatings UnitCombatRatings[0x1A];
byte UnitLanceFormationState[0x18];
byte TacticalScenarioLanceEnabled[0x03];
const byte SensorDamageProximityRangeTable[0x03] =
	{ 0x14, 0x0A, 0x00 };
byte LanceFormationProfile[0x06];
byte UnitEnemyEngagementActive[0x18];
byte UnitMovementHeatExponent[0x18];
byte UnitOverburnOrCloseAssaultEnabled[0x18];
byte UnitFormationMode[0x18];
word16 UnitConsecutiveAttackTicks[0x18];
word16 FirstLanceOrdersEnabled;
byte UnitWasAttackedThisTick[0x18];
byte GroundTargetWasAttacked;
byte UnitJumpingState[0x18];
byte UnitJumpMovementRemaining[0x18];
byte UnitDestructionMarkers[0x18][0x03];
word16 ScenarioFileSuffix;
byte CampaignUpgradeAwards[0x04];
byte UnitEnemyInProximityRange[0x18];
byte UnitShutdownState[0x18];
byte UnitEnemyVisible[0x18];
RevengeUnitSlot UnitTacticalTarget[0x18];
word16 EnemyCycleUnitIndex;
byte UnitEnemyContactEstablished[0x18];
byte UnitWithdrawalState[0x18];
RevengeUnitSlot UnitLastNarratedTarget[0x18];
byte UnitPreferredEngagementMode[0x18];
byte UnitTerrainType[0x18];
byte UnitBelowHalfDurability[TACTICAL_UNIT_COUNT + 0x01];
byte UnitCachedWeaponCounts[
	(TACTICAL_UNIT_COUNT + 0x01) * WEAPON_DEFINITION_COUNT];
byte UnitWeaponRecoveryCounters[
	(TACTICAL_UNIT_COUNT + 0x01) * WEAPON_DEFINITION_COUNT];
byte UnitHeatSinkCount[TACTICAL_UNIT_COUNT + 0x01];
uint32 UnitWeaponAvailabilityMask[TACTICAL_UNIT_COUNT + 0x01];
word16 WeaponCountScratch[0x17];
byte *TerrainTypeMap;
byte *TacticalOverviewMapBuffer;
byte *PackedTerrainDamageMap;
byte *ActiveTerrainDamageByte;
byte *TerrainDamageCapabilityTable;
const byte TerrainDamageCellIncrementMask[0x04] =
	{ 0x01, 0x04, 0x10, 0x40 };
const byte TerrainDamageExtractMask[0x04] =
	{ 0x03, 0x0C, 0x30, 0xC0 };
const byte TerrainDamageShift[0x04] =
	{ 0x00, 0x02, 0x04, 0x06 };
const byte TerrainDamageCellOccupiedMask[0x04] =
	{ 0xC0, 0x30, 0x0C, 0x03 };
const byte TerrainDamageStageIncrement[0x04] =
	{ 0x40, 0x10, 0x04, 0x01 };
word16 PackedTerrainDamageRowBytes;
byte DestructibleTerrainTypeBase;
byte TerrainImpactAnimationTypeMinimum;
byte TerrainImpactAnimationTypeMaximum;
word16 TerrainLineOfSightBlockingThreshold;
byte TerrainLineOfSightMaximumSteps;
byte TacticalTerrainEffectMode;
RevengeTerrainDamageQueueEntry TerrainDamageQueue[TERRAIN_DAMAGE_QUEUE_ENTRY_COUNT];
byte CampaignUpgradeMarkerX[0x04];
byte CampaignUpgradeMarkerY[0x04];
word16 FriendlyUnitDestroyed;
byte ScenarioDestructionCompletionState;
byte ScenarioDestructionCompletionMarker;
word16 ProtectUnitZero;
word16 ImpassableTerrainTypeMinimum;
int8_t TerrainToHitModifier[0x100];
RevengeTerrainImpactAnimationRecord
	TerrainImpactAnimationRecords[TERRAIN_IMPACT_ANIMATION_RECORD_COUNT];
word16 NarrationMessageCategory;
word16 PendingNarrationDelay;
byte DamagedWeaponRangeFlags[0x03];
int16 CurrentUnitDurabilityTotal;
int16 MaximumUnitDurabilityTotal;
char SharedNumericTextBuffer[0x20];
const char PercentageSuffixText[] = "%";
word16 TacticalUpdateDelayTicks;
word16 TacticalKeyRepeatDelayTicks;
word16 TacticalUpdateDelayReloadTicks;
word16 TacticalGameSpeedIndex;
byte TacticalClockSubtick;
word16 TacticalBattleResult;
word16 TacticalClockDivider;
word16 TacticalImpactQueueCount;
RevengeTacticalImpactRecord
	TacticalImpactQueue[TACTICAL_IMPACT_RECORD_COUNT];
const int16 TacticalCursorSearchOffsetX[0x09] =
	{ 0x00, 0x00, 0x01, 0x00, -0x01, -0x01, 0x01, 0x01, -0x01 };
const int16 TacticalCursorSearchOffsetY[0x09] =
	{ 0x00, -0x01, 0x00, 0x01, 0x00, -0x01, -0x01, 0x01, 0x01 };
const int8 TacticalMouseEdgeInputByMask[0x10] =
	{ 0x00, 0xB5, 0xB0, 0xB1, 0xB3, 0x00, 0xAF, 0x00,
	  0xB8, 0xB9, 0x00, 0x00, 0xB7, 0x00, 0x00, 0x00 };
byte SceneNarrationEventFlags[0x06];
word16 HeatDissipationBySinkCountQ8_8[0x100];
word16 TerrainDamageQueueWordCount;
word16 TacticalProjectileCount;
RevengeTacticalProjectileRecord
	TacticalProjectileRecords[TACTICAL_PROJECTILE_RECORD_COUNT];
word16 TacticalOverviewDisplayMode;
word16 LrmShipmentLoaded;
word16 SrmShipmentLoaded;
word16 TacticalOverviewMapMode;
word16 NarrationSourceUnit;
word16 LastAttackingUnitIndex;
word16 PendingMouseButtonEvent;
int16 MouseCursorTestX;
int16 MouseCursorTestY;
word16 MouseCursorUpdateLock;
int16 MouseCursorRequestedX;
word16 MouseCursorHideDepth;
word16 MouseDriverDoubleX;
word16 MouseDriverInstalled;
word16 MouseButtonState;
word16 MouseY;
word16 MouseInputDisabled;
int16 MouseCursorMinX;
int16 MouseCursorMaxX;
int16 MouseCursorMinY;
int16 MouseCursorMaxY;
int16 MouseCursorHotspotX;
int16 MouseCursorHotspotY;
int16 MouseCursorDisplayedX;
int16 MouseCursorDisplayedY;
byte *MouseCursorBackground;
const byte *MouseCursorBitmap;
int16 MouseCursorErasedX;
int16 MouseCursorErasedY;
int16 MouseCursorRestoreTileLeft;
int16 MouseCursorRestoreTileTop;
int16 MouseCursorRestoreTileRight;
int16 MouseCursorRestoreTileBottom;
int16 MouseCursorDrawnX;
int16 MouseCursorDrawnY;
int16 MouseCursorCaptureTileLeft;
int16 MouseCursorCaptureTileTop;
int16 MouseCursorCaptureTileRight;
int16 MouseCursorCaptureTileBottom;
int16 MouseCursorDrawLeft;
int16 MouseCursorDrawTop;
byte *ActiveRenderTarget;
word16 SpriteClipLeftTileMirror;
word16 SpriteClipRightTileMirror;
word16 SpriteClipTopPixelMirror;
word16 SpriteClipBottomPixelMirror;
word16 TacticalSpriteClipLeftTile;
word16 TacticalSpriteClipRightTile;
word16 TacticalSpriteClipTopPixel;
word16 TacticalSpriteClipBottomPixel;
/* REVENGE.EXE DS:800C is initialized to 0001h. */
word16 RequestedMusicEnabled = TRUE;
byte MusicDriverPlaybackMode;
word16 CachedMusicResourceIndex;
word16 SpriteDrawBusy;
byte *MusicStagingBuffer;
word16 PlanarBackingBufferExtentLow;
word16 PlanarBackingBufferExtentHigh;
byte SceneTransitionAbortFlag;
word16 PresentationDismissTimeout;
word16 PresentationCallbackOffset;
word16 PresentationCallbackSegment;

word16 TacticalOverviewActive;
byte ArtilleryShellingActive;
byte RollingBarrageActive;
byte StrafingRunActive;
byte ArtilleryTargetMapX;
byte ArtilleryTargetMapY;
byte RollingBarrageEndMapX;
byte RollingBarrageEndMapY;
byte RollingBarrageStartMapX;
byte RollingBarrageStartMapY;
byte DropShipMapX;
byte DropShipMapY;
byte ArtillerySupportAvailable;
byte StrafingSupportAvailable;
word16 TacticalOverviewViewportDirty;
static word16 TacticalCellTerrainStorage[0xE4];
static word16 TacticalCellSpriteStorage[0xE4];
word16 *TacticalCellTerrainMap = TacticalCellTerrainStorage;
word16 *TacticalCellSpriteMap = TacticalCellSpriteStorage;
byte ScenarioUnitNeedsUpdate[0x18];
byte TacticalStateInitialized;
word16 SuppressCampaignClock;
word16 TacticalCursorOutlineEnabled;
word16 TacticalCursorOutlineState;
