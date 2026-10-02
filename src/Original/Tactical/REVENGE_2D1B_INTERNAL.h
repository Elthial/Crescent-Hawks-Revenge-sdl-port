#ifndef REVENGE_2D1B_INTERNAL_H
#define REVENGE_2D1B_INTERNAL_H

// REVENGE_2D1B_TACTICAL_COMBAT.c
// Tactical movement, targeting, weapon, damage, and terrain procedures
// reconstructed from REVENGE.EXE segment 2D1B.

#include "REVENGE.h"
#include "revenge/original_data.h"

#define TACTICAL_ENGAGEMENT_NONE       0x00
#define TACTICAL_ENGAGEMENT_CLOSE      0x01
#define TACTICAL_ENGAGEMENT_MEDIUM     0x02
#define TACTICAL_ENGAGEMENT_LONG       0x03
#define TACTICAL_ENGAGEMENT_WITHDRAW   0x04
#define TACTICAL_ENGAGEMENT_POSITION   0x05

#define TACTICAL_ORDER_SCRIPTED_ROUTE   0x00
#define TACTICAL_ORDER_HOLD_POSITION    0x01
#define TACTICAL_ORDER_SEEK_AND_DESTROY 0x02

#define UnitRouteFirstX UnitRouteTargetMapX
#define UnitRouteFirstY UnitRouteTargetMapY

#define TACTICAL_COMBAT_RATINGS(unitIndex) \
	(&UnitCombatRatings[(unitIndex)])

void SelectUnitTacticalTargets(void);
void AdvanceUnitTacticalMovement(word16 unitIndex);
word16 ExecuteUnitWeaponAI(word16 unitIndex);
void MoveUnitTowardMapCell(
	word16 unitIndex, word16 destinationX, word16 destinationY);
void UpdateUnitSpriteForFacing(word16 unitIndex, word16 facing);
void AdvanceUnitRouteWaypoint(word16 unitIndex);
void QueueLanceOrderNarration(word16 unitIndex);
void SelectLanceFormationMode(
	word16 leaderUnitIndex, word16 randomizeFormation);
void BeginTerrainDamageAtCell(
	word16 mapX, word16 mapY, word16 terrainType);
void CollapseStructureAtMapCell(
	int16 mapX, int16 mapY, word16 terrainType);
void ApplyTerrainImpact(
	int16 mapX, int16 mapY,
	word16 advanceBeforeRecording, word16 forceAnimationRecord);
word16 GeneratePseudoRandomByte(void);
void BuildArmWeaponAvailabilityMasks(word16 unitIndex);
int16 ResolveWeaponAttack(
	int16 attackerUnitIndex, int16 weaponIndex, int16 targetUnitIndex);
void QueueTacticalProjectile(
	word16 attackerUnitIndex,
	byte weaponIndex,
	word16 targetUnitIndex,
	word16 shotHit);
void DrawWeaponAttackTrace(
	word16 attackerUnitIndex,
	int16 targetMapX,
	int16 targetMapY,
	word16 offsetEndpoints,
	word16 shotHit,
	word16 weaponIndex);
void CountUnitWeaponsByType(const RevengeUnitRecord *unitRecord);
word16 CountOrRemoveUnitHeatSinks(
	RevengeUnitRecord *unitRecord, word16 removeInstalledHeatSinks);
uint32 CalculateSelectedWeaponRating(
	uint32 weaponMask, const uint16 *weaponCounts);
uint16 DetermineRelativeAttackDirection(
	int16 sourceX, int16 sourceY, int16 targetX, int16 targetY);
uint16 CalculateApproximateMapDistance(
	int16 sourceX, int16 sourceY, int16 targetX, int16 targetY);
word16 TraceMapLineOfSight(
	int16 sourceX, int16 sourceY, int16 targetX, int16 targetY,
	const byte *terrainTypeMap,
	byte specialTerrainMinimum, byte specialTerrainMaximum,
	byte blockingTerrainThreshold, byte maximumSteps);
uint16 Roll2D6(void);
word16 ReadTerrainDamageState(int16 mapX, int16 mapY);
void DispatchWeaponEffect(int16 weaponEffectId);
void QueueTacticalImpactVisual(
	int16 mapX, int16 mapY, word16 impactClass);
void ApplyWeaponDamage(
	int16 attackerUnitIndex, int16 weaponIndex, int16 targetUnitIndex);
void DestroyScenarioUnit(word16 unitIndex);
word16 FindOperationalLanceLeader(word16 unitIndex);
word16 ShouldDestroyUnitAfterLegLoss(void);
void RebuildLanceFormationAfterLeaderLoss(word16 firstUnitIndex);
word16 AdvanceTerrainDamageState(
	word16 mapX, word16 mapY, word16 damageAmount);


#endif
