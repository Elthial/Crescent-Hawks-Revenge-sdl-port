#ifndef REVENGE_2507_LANCE_EDITOR_INTERNAL_H
#define REVENGE_2507_LANCE_EDITOR_INTERNAL_H

#include "REVENGE.h"
#include "revenge/input.h"
#include "revenge/original/lance_editor_data.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <stdbool.h>

#define KEY_ESC KEY_ESCAPE
#define KEY_CARRIAGERETURN KEY_CARRIAGE_RETURN
#define seg3A6A 0x3A6A

/* Resolve preserved 16:16 values through the host bridge in this unit. */
#undef MAKE_FAR_POINTER
#define MAKE_FAR_POINTER(segment, offset) \
	HostFarPointer_Resolve(MAKE_DWORD((segment), (offset)))

enum
{
	LIVE_SCENARIO_UNITS_OFFSET = 0x99E0,
	TEXT_WINDOW_TILE_SIZE_PIXELS = 0x0008,
	UNIT_CLASS_COUNT = 0x06,
	UNIT_CLASS_MENU_ENTRY_COUNT = 0x07,
	UNIT_CLASS_MENU_CANCEL_INDEX = 0x06,
	UNIT_SELECTION_TEXT_WINDOW_INDEX = 0x11,
	UNIT_SELECTION_UI_REGION_INDEX = 0x0B,
	UNIT_ALLEGIANCE_ENEMY = 0x01,
	OMNI_UNIT_TYPE_LIST_OFFSET = 0x32D7,
	UNIT_ROSTER_COLUMN_X_ADJUSTMENT = 0x0001,
	UNIT_ROSTER_FIRST_ROW_Y = 0x00B0,
	UNIT_ROSTER_TEXT_WIDTH_PIXELS = 0x009E
};

int16 RandomInRangeInclusive(word16 minimum, word16 maximum);
int16 PopRandomUnitType(void);
int16 PopRandomPilotId(void);
int16 SelectUnitClass(void);
int16 SelectUnitTypeFromList(const byte *unitTypeIdList);
word16 ServiceMusicAndCheckKeyboardInput(void);
word16 RunGameOptionsMenu(word16 embeddedMode);
void DrawUnitAllegianceHeader(word16 headerColorIndex);
void RenderFormattedText(const char *text);
word16 ValidatePilotConfiguration(word16 selectionFamily);
word16 ValidateLanceConfiguration(word16 selectionFamily);
void ShowNoSelectionOptions(void);
void RunPilotSelection(word16 selectionFamily, int16 selectionMode);
void PrepareLanceSelection(word16 firstRosterIndex, int16 selectionMode);
void PresentStoryScreenAndMessage(
	word16 screenResourceIndex,
	word16 messageIndex);
void ShowStoryMessage(word16 messageIndex);
void DrawUnitRosterScreen(
	word16 useAlternateAssignmentLayout,
	word16 textColor);
void DrawRangeAndSpeedStatHeaders(word16 topY);
void DrawExperienceAndGunneryHeaders(word16 topY);
void LoadScreenPalette(word16 paletteIndex);
byte *BuildDisplayBackingBuffer(
	word16 sourceTileX,
	word16 sourcePixelY,
	word16 widthTiles,
	word16 heightPixels);
void LoadGraphicsResourceToBuffers(
	word16 resourceIndex,
	byte *decodeBuffer,
	byte *displayBuffer);
void LoadGraphicsBufferRange(
	int16 firstBufferIndex,
	int16 lastBufferIndex);
void LoadUnitTemplateRecord(int16 unitType);
void CopyFarBytes32(
	const void *source,
	void *destination,
	uint32 byteCount);
void InitializeLanceAssignments(
	word16 firstRosterIndex,
	int16 selectionMode);
void SnapshotLateCampaignLanceUnits(void);
int16 RunLanceConfigurationEditor(
	word16 selectionFamily,
	word16 scenarioVariantIndex);
void PrepareLanceSelectionRecords(
	word16 firstRosterIndex,
	int16 selectionMode,
	word16 loadPresentationResources);
void RunUnitAssignmentEditor(word16 firstRosterIndex);
void DrawSelectionScreenBackground(void);
void DrawLanceSelectionScreen(word16 configurationIndex);
void RefreshLanceSelectionSlots(
	word16 scenarioGroupIndex,
	word16 lanceGroupIndex,
	word16 showSelectionContents);
int16 DrawUnitEditorSectionMenu(word16 configurationIndex);
void ClearUnitEditorSectionPanel(void);
void DrawLanceAssignmentSlot(
	word16 assignmentIndex,
	word16 selected,
	word16 drawExitSlot);
void PreparePilotSelectionRecords(
	word16 selectionFamily,
	int16 selectionMode,
	word16 loadPresentationResources);
void RunPilotAssignmentEditor(word16 selectionFamily);
void DrawPilotSelectionScreen(word16 selectionFamily);
void DrawPilotSelectionSlot(
	word16 pilotRecordIndex,
	word16 redrawBackground,
	int16 displayMode);
void RefreshPilotAssignmentSlots(
	word16 selectionFamily,
	word16 showPilotCards);
void FreeGraphicsBufferRange(
	int16 firstBufferIndex,
	int16 lastBufferIndex);
void LoadScenarioVariantGraphicsBuffers(void);
void LoadLanceConfigurationGraphicsBuffers(void);
void ShowLanceConfigurationBriefing(word16 configurationIndex);
void RunUnitAssignmentGrid(
	word16 scenarioGroupIndex,
	word16 lanceGroupIndex,
	word16 useSeparateScenarioGroups);
void RunPilotAssignmentGrid(word16 lanceGroupIndex);
void DrawUnitStatusScreen(
	uint16 statusPanelIndex,
	word16 redrawBackground,
	word16 displayMode,
	word16 showDetailedStats);
void CountUnitWeaponsByType(const RevengeUnitRecord *unitRecord);
word16 CalculateUnitWeaponHeatScale(RevengeUnitRecord *unitRecord);
void OpenModalTextWindow(word16 windowIndex, word16 saveBackground);
void RestoreModalTextWindow(void);
void DrawTrainingCategoryOption(
	word16 optionIndex,
	word16 selectedState);
void DrawTrainingScenarioOption(
	word16 scenarioIndex,
	word16 selectedState);
void DrawTrainingScenarioSelectionScreen(void);
void DrawTrainingDeploymentSlot(
	word16 slotIndex,
	word16 selectedState);
void DrawTrainingDeploymentScreen(void);
void DrawTrainingUnitChoice(word16 choiceIndex, word16 selectedState);
void DrawTrainingControlChoice(word16 choiceIndex, word16 selectedState);
void DrawTrainingChoiceButton(
	word16 leftX,
	word16 topY,
	const char *label,
	word16 width);


#endif
