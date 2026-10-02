#ifndef REVENGE_2208_INTERNAL_H
#define REVENGE_2208_INTERNAL_H

// Tactical input, command, formation, and intelligence procedures reconstructed
// from REVENGE.EXE and the Revenge annotation project.

#include "REVENGE.h"
#include "revenge/input.h"
#include "revenge/original_data.h"

#define TACTICAL_ORDER_SCRIPTED_ROUTE   0x00
#define TACTICAL_ORDER_HOLD_POSITION    0x01
#define TACTICAL_ORDER_SEEK_AND_DESTROY 0x02

#define TACTICAL_FORCE_FIRST_UNIT_OFFSET              FRIENDLY_FORCE_FIRST_UNIT
#define TACTICAL_ORDER_MODE_COUNT                     0x03
#define NARRATION_LEADER_SUBSTITUTION_FIRST_UNIT      0x0004
#define CONTACT_NARRATION_DELAY                       0x025D
#define CONTACT_NARRATION_CATEGORY_SCRIPTED_ROUTE     0x0006
#define CONTACT_NARRATION_CATEGORY_HOLD_POSITION      0x0004
#define CONTACT_NARRATION_CATEGORY_SEEK_AND_DESTROY   0x0003
#define NO_UNIT_INDEX                                 0xFFFF

void LoadUnitTemplateRecord(int16 unitType);
void UpdateUnitSpriteForFacing(word16 unitIndex, word16 facing);
void RecalculateUnitCombatRatings(
	RevengeUnitRecord *unitRecord,
	word16 unitSlot,
	word16 rebuildWeaponCounts,
	word16 advanceRecovery);
word16 HasUnitLineOfSight(int16 sourceUnitIndex, int16 targetUnitIndex);
uint16 CalculateApproximateMapDistance(
	int16 sourceX, int16 sourceY, int16 targetX, int16 targetY);
uint16 DetermineRelativeAttackDirection(
	int16 sourceX, int16 sourceY, int16 targetX, int16 targetY);
word16 FindOperationalLanceLeader(word16 unitIndex);
word16 HasNarrationMessage(
	word16 narrationSubject, word16 messageCategory);
word16 GeneratePseudoRandomByte(void);
int16 CompareLanceCombatRatings(
	word16 firstUnitIndex, int16 secondUnitIndex);
void DrawLanceFormationMarker(
	int16 formationCode, word16 tileColumnOffset);
void DrawTacticalUnitControlPanel(word16 unitIndex);
void FormatTacticalMapCoordinates(word16 mapX, word16 mapY);
void HighlightLanceFollowers(word16 leaderUnitIndex);
word16 HasActiveLanceFollowers(word16 unitIndex);
void SelectLanceFormationMode(
	word16 leaderUnitIndex, word16 randomizeFormation);
void RunTacticalUnitCommandMenu(word16 unitIndex);
void RunTacticalGameOptionsMenu(void);
word16 ValidatePrimaryLanceLeader(word16 unitIndex);
void RefreshTacticalDisplay(word16 advanceEffects);
void RedrawTacticalStatusPanel(void);
void RebuildTacticalViewport(void);
void HideMouseCursorOverlay(void);
void ShowMouseCursorOverlay(void);
void SelectAndClearTextWindow(word16 windowIndex);
void DrawActiveTextWindowBorder(word16 color);
void DrawTacticalCellOutline(int16 leftX, int16 topY, word16 color);
void DrawClippedPixel(int16 x, int16 y, word16 color);
void DrawTacticalCursorOutline(word16 color);
void DrawClippedWeaponTraceLine(
	int16 startX,
	int16 startY,
	int16 endX,
	int16 endY,
	word16 color,
	word16 dashedTrace);
void DrawWeaponAttackTrace(
	word16 unitIndex,
	word16 targetX,
	word16 targetY,
	word16 traceMode,
	word16 traceWidth,
	word16 dashedTrace);
void DrawCenteredTextInActiveWindow(
	const char *text,
	word16 rowOffset,
	word16 foregroundColor,
	word16 backgroundColor);
void RenderFormattedLineBreak(void);
void RenderFormattedText(const char *formattedText);
void FormatUnitDurabilityPercentage(int16 unitIndex);
void DrawTileAlignedText(
	const char *text,
	word16 tileX,
	word16 tileY,
	byte foregroundColor,
	byte backgroundColor);
int16 RunOptionsMenuSelection(int16 firstRegionIndex);
void EnterTacticalOverview(void);
void SelectTacticalMapCoordinate(word16 unitIndex);
word16 SelectTacticalMoveDestinationInput(word16 unitIndex, word16 mode);
void SelectStrafingArea(void);
void DisplayDropShipIntelligence(void);
void RenderLanceIntelligenceSummary(word16 firstUnitIndex);
void DrawUnitFacingAndMovementVectors(word16 unitIndex);
int16 UpdateUnitEnemyVisibility(word16 unitIndex);
int16 UpdateUnitEnemyProximityState(word16 unitIndex);
word16 WaitForDismissInput(void);
word16 ServiceMusicAndCheckKeyboardInput(void);
int16 TranslateTacticalMouseInput(int16 inputAction);
void MoveTacticalCursorByInput(int16 inputCode);
void ScrollTacticalViewportToCursor(void);
void FocusTacticalViewOnUnit(word16 unitIndex);
void RefreshTacticalCoordinateSelection(
	word16 unitIndex,
	word16 selectionMode,
	word16 savedCursorColumn);
void CycleTacticalEnemyTarget(void);
void ShowTacticalCommandPrompt(const char *prompt);
void AdvanceLanceFormation(word16 unitIndex);
word16 SelectTacticalMoveDestination(
	word16 unitIndex, word16 selectionMode);
void CopyFarMemory(
	word16 byteCount,
	const byte *source,
	byte *destination);
char *FarStringNCopy(
	char *destination,
	const char *source,
	word16 maximumLength);


#endif
