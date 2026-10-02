#ifndef REVENGE_0D73_CAMPAIGN_INTERNAL_H
#define REVENGE_0D73_CAMPAIGN_INTERNAL_H

#include "REVENGE.h"

void InitializeTacticalScenario(void);
#include "revenge/original/campaign_data.h"
#include "revenge/original/lance_editor_data.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"
#include "revenge/save_data.h"
#include "revenge/video.h"

/* Narrow declaration avoids importing the hosted input-key enum into this
 * segment-local header, which retains the executable's own key constants. */
void SDLBackend_ServiceTimers(void);

#define seg3A6A 0x3A6A
#undef MAKE_FAR_POINTER
#define MAKE_FAR_POINTER(segment, offset) \
	HostFarPointer_Resolve(MAKE_DWORD((segment), (offset)))

#define VIDEO_ADAPTER_VGA                0x0003

enum
{
	KEY_BACKSPACE = 0x08,
	KEY_CARRIAGE_RETURN = 0x0D,
	KEY_ESCAPE = 0x1B,
	KEY_SPACE = 0x20,
	KEY_DELETE = 0x7F,
	KEY_CTRL_S = 0x13
};

#define CACHED_FILE_NAME(index) \
	((char *)HostFarPointer_Resolve( \
		DosAddress_ToValue(CachedFileDescriptors[(index)].fileName)))


#define SAVE_SLOT_COUNT                  0x06
#define SAVE_LOAD_MODE_SAVE              0x03
#define SAVE_LOAD_MODE_LOAD              0x04
#define SAVE_LOAD_ACTION_CANCEL          0x00
#define SAVE_LOAD_ACTION_SLOT            0x01
#define SAVE_LOAD_ACTION_TRAINING        0x02
#define SAVE_LOAD_ACTION_REOPEN_MENU     ((int16)-0x01)
#define SAVE_LOAD_ACTION_EXIT_DOS        ((int16)-0x02)
#define UI_SELECTION_PENDING              0x00FF
#define REVENGE_UNIT_SLOT_COUNT            0x18
#define REVENGE_CAMPAIGN_SNAPSHOT_SIZE     0x0221
#define VGA_DAC_PALETTE_BYTE_COUNT         0x0300
#define IN_GAME_MENU_CONTINUE             0x00
#define IN_GAME_MENU_JUMP_STORY           0x01
#define IN_GAME_MENU_SAVE_CONTINUE        0x02
#define IN_GAME_MENU_SAVE_QUIT            0x03
#define IN_GAME_MENU_LOAD                 0x04
#define IN_GAME_MENU_REPLAY_SCENARIO      0x05
#define IN_GAME_MENU_REPLAY_STORY         0x06
#define IN_GAME_MENU_RESTART              0x07
#define IN_GAME_MENU_OPTIONS              0x08

typedef int16 ( *CampaignStageHandler)(void);

#define DECLARE_CAMPAIGN_STAGE(index) \
	int16 RunCampaignStage##index(void)
DECLARE_CAMPAIGN_STAGE(00);
DECLARE_CAMPAIGN_STAGE(01);
DECLARE_CAMPAIGN_STAGE(02);
DECLARE_CAMPAIGN_STAGE(03);
DECLARE_CAMPAIGN_STAGE(04);
DECLARE_CAMPAIGN_STAGE(05);
DECLARE_CAMPAIGN_STAGE(06);
DECLARE_CAMPAIGN_STAGE(07);
DECLARE_CAMPAIGN_STAGE(08);
DECLARE_CAMPAIGN_STAGE(09);
DECLARE_CAMPAIGN_STAGE(10);
DECLARE_CAMPAIGN_STAGE(11);
DECLARE_CAMPAIGN_STAGE(12);
DECLARE_CAMPAIGN_STAGE(13);
DECLARE_CAMPAIGN_STAGE(14);
DECLARE_CAMPAIGN_STAGE(15);
DECLARE_CAMPAIGN_STAGE(16);
DECLARE_CAMPAIGN_STAGE(17);
DECLARE_CAMPAIGN_STAGE(18);
DECLARE_CAMPAIGN_STAGE(19);
DECLARE_CAMPAIGN_STAGE(20);
DECLARE_CAMPAIGN_STAGE(21);
#undef DECLARE_CAMPAIGN_STAGE

int16 RunSaveLoadMenu(word16 menuMode);
int16 ShowSaveLoadMenu(word16 menuMode);
word16 IsBlankSaveSlotName(const char *slotName);
word16 RenameSaveSlot(int16 slotIndex);
void WaitForAcknowledgement(void);
int16 PromptYesNo(word16 initialSelection);
void ShowStoryMessageAndWait(word16 messageIndex);
void ShowStoryMessage(word16 messageIndex);
void StopLoadedMusicTrack(void);
void LoadScenarioDigitalSoundBank(int8 scenarioCode);
void ReleaseDigitalSoundBuffer(void);
void DispatchWeaponEffect(int16 weaponEffectId);
void LoadUnitTemplateRecord(int16 unitType);
void PlayScenarioDigitalSoundSequence(int8 scenarioCode);
void PromoteReserveUnitsForCampaignStage(void);
word16 WaitForDismissInput(void);
word16 WaitForKeyboardOrMouseInput(void);
void FlushPendingInput(void);
word16 ServiceMusicAndCheckKeyboardInput(void);
void CopyClippedVideoRegion(
	int16 sourceX,
	int16 sourceY,
	int16 destinationX,
	int16 destinationY,
	word16 widthColumns,
	word16 heightPixels,
	const byte *source,
	byte *destination);
void XorVideoRectangle(
	int16 leftX, int16 topY, int16 rightX, int16 bottomY, byte color);
word16 ReadSaveSlot(word16 cachedFileIndex, int16 saveSlot);
word16 WriteSaveSlot(word16 cachedFileIndex, int16 saveSlot);

extern void (*PresentationCallback)(void);
void RunCampaignPathSelectionCallback(void);
void RunScenarioVariantSelectionCallback(void);
void RunAlternateScenarioVariantSelectionCallback(void);
void LoadDigitalWeaponEffectBank(void);
void ReleaseDigitalWeaponEffectBank(void);
void PrepareLanceSelection(word16 firstRosterIndex, int16 selectionMode);
void RunLanceConfiguration(
	word16 selectionFamily,
	word16 scenarioVariantIndex);
void EnableTrainingUnitSelectionSlots(void);
int16 RunTrainingScenarioSelection(void);
int16 PrepareTrainingDeployment(void);
void AssignPilotRosterEntryToUnit(
	word16 unitIndex,
	word16 rosterSlot);
byte PrepareActivePilotList(void);
void RenderActivePilotList(void);
byte PrepareSurvivingCommanderList(void);
void RenderSurvivingCommanderList(void);
word16 HasFallenPilots(void);
byte PrepareFallenPilotList(void);
void RenderFallenPilotList(void);
void RenderPilotName(RevengePilotId pilotId);
void BuildMissionSpriteBackingBuffer(word16 spriteLayoutIndex);
void FreeGraphicsBufferRange(
	int16 firstBufferIndex,
	int16 lastBufferIndex);
void UpdatePilotAvailability(void);
int16 RunTitleAndMainMenu(void);
int16 RunInGameMenu(int16 firstMenuOption);
word16 SaveGame(void);
word16 LoadGame(void);
void OpenModalTextWindow(word16 windowIndex, word16 clearAndFrame);
void RestoreModalTextWindow(void);
word16 RunGameOptionsMenu(word16 embeddedMode);
byte *AddBytesToFarPointer(byte *base, uint32 byteCount);
word16 AnimateTitleTextLine(const char *text);
void PresentAnimatedScreenAndMessage(
	word16 screenResourceIndex,
	word16 messageIndex);
void PresentStoryScreenAndMessage(
	word16 graphicsResourceIndex,
	word16 messageIndex);
void PresentCampaignScene(
	word16 graphicsResourceIndex,
	word16 spriteLayoutIndex,
	word16 messageIndex);
void ShowCampaignMessageAndWait(word16 messageIndex);
void PresentMissionBriefing(
	word16 graphicsResourceIndex,
	word16 spriteLayoutIndex,
	word16 messageIndex);
void DisplayMissionDate(
	int16 presentationMode,
	int16 blinkRegionIndex,
	word16 dateEntryIndex,
	word16 followupMessageIndex,
	word16 redrawPresentation);
int16 SelectScenarioVariant(word16 presentationMode);
word16 RunTwoOptionMenuSelection(
	const char * const menuOptionText[0x02]);
word16 RunMainMenuSelection(const char * const menuOptionText[0x03]);
word16 PlayTitleTextSequence(void);

#endif
