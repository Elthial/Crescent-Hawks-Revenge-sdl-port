// REVENGE_0D73_SAVE_LOAD.c
// Procedures reconstructed from REVENGE.EXE segment 0D73.

#include "REVENGE_0D73_CAMPAIGN_INTERNAL.h"
#include "revenge/debug.h"

// 0D73:4866: word16 SaveGame(void)
// Called from:
//      RunInGameMenu
// VERIFIED against 0D73:4866-4A7D.
word16 SaveGame(void)
{
	RevengeCampaignSnapshot *snapshot;
	word16 lanceIndex;
	word16 menuAction;
	word16 pilotIndex;
	word16 scenarioRecordIndex;
	word16 unitIndex;

	OpenModalTextWindow(0x0016, 0x0001);
	snapshot = &SaveCampaignSnapshot;
	menuAction = UI_SELECTION_PENDING;
	while (menuAction == UI_SELECTION_PENDING)
	{
		menuAction = RunSaveLoadMenu(SAVE_LOAD_MODE_SAVE);
		if ((int16) menuAction > 0x0000)
		{
			ActiveTextCursorRow = 0x000A;
			HideMouseCursorOverlay();
			RenderFormattedText("\r\rSaving game ...\r"); // TEXT DS:261D: "+3 in *j2\r\rSaving game ...\r"
			ShowMouseCursorOverlay();
			if (ScenarioRosterPrepared == FALSE)
			{
				PrepareScenarioUnitRosters();
				CampaignStageIndex += PendingCampaignStageDelta;
				CampaignPhase += PendingCampaignPhaseDelta;
				if ((SavedCampaignFlags & 0x0008) != 0x0000)
					CampaignFlags |= 0x2000;
			}
			ScenarioRosterPrepared = TRUE;
			snapshot->campaignStageIndex = CampaignStageIndex;
			snapshot->scenarioVariantIndex = ScenarioVariantIndex;
			snapshot->campaignPhase = CampaignPhase;
			snapshot->trainingSequenceFlag = TrainingSequenceFlag;
			snapshot->campaignFlags = CampaignFlags;
			snapshot->state24E1 = SavedCampaignFlags;
			snapshot->stateA967 = ScenarioUnitZeroAvailable;
			snapshot->scene3RosterSelector9991 = EjectedPilotRosterState;
			snapshot->state88F1 = ScenarioUnitFifteenState;
			snapshot->state8925 = ScenarioUnitFourteenEnabled;
			snapshot->state99C5 = ScenarioUnitThirteenEnabled;
			snapshot->stateA965 = LastAttackingUnitIndex;
			snapshot->state8594 = CampaignScenarioState;
			snapshot->lrmShipmentLoaded = LrmShipmentLoaded;
			snapshot->srmShipmentLoaded = SrmShipmentLoaded;
			CopyFarMemory(
				sizeof(snapshot->scenarioClock),
				SavedCampaignClockState,
				snapshot->scenarioClock);
			CopyFarMemory(
				sizeof(snapshot->trainingScenarioCompletionFlags),
				TrainingScenarioCompletionFlags,
				snapshot->trainingScenarioCompletionFlags);
			for (unitIndex = 0x0000;
				unitIndex < REVENGE_UNIT_SLOT_COUNT;
				++unitIndex)
			{
				snapshot->scenarioUnitMapX[unitIndex] = ScenarioUnitMapX[unitIndex];
				snapshot->scenarioUnitMapY[unitIndex] = ScenarioUnitMapY[unitIndex];
			}
			CopyFarMemory(
				sizeof(snapshot->state1B85),
				ReplayCampaignState,
				snapshot->state1B85);
			snapshot->state1B8E = CampaignState1B8E;
			CopyFarMemory(
				sizeof(snapshot->state1BAD),
				ReplayExtendedCampaignState,
				snapshot->state1BAD);
			for (scenarioRecordIndex = 0x0000;
				scenarioRecordIndex < 0x0012;
				++scenarioRecordIndex)
			{
				snapshot->scenarioRecords[scenarioRecordIndex] =
					UnitSelectionCards[scenarioRecordIndex];
			}
			for (lanceIndex = 0x0000; lanceIndex < 0x000D; ++lanceIndex)
			{
				snapshot->lanceAssignments[lanceIndex] =
					LanceAssignments[lanceIndex];
			}
			pilotIndex = 0x0000;
			while (pilotIndex < 0x0025)
			{
				snapshot->pilotAvailability[pilotIndex] =
					PilotRoster[pilotIndex].availability;
				++pilotIndex;
			}
			WriteSaveSlot(
				0x0044,
				(int16) SelectedSaveSlotIndex + 0x0001);
			HideMouseCursorOverlay();
			RenderFormattedText("Game saved.\r"); // TEXT DS:2630: "Game saved.\r"
			ShowMouseCursorOverlay();
				SaveDirectory.slots[SelectedSaveSlotIndex].occupied = TRUE;
			SavedSaveTransferState = SaveTransferState;
			WriteSaveSlot(0x0044, 0x0000);
		}
	}
	RestoreModalTextWindow();
	return menuAction;
}

// 0D73:4A7E: word16 WriteSaveSlot(word16 cachedFileIndex, int16 saveSlot)
// Called from:
//      SaveGame
//      ShowSaveLoadMenu
word16 WriteSaveSlot(word16 cachedFileIndex, int16 saveSlot)
{
	word16 slotEndOffset;
	word16 slotStartOffset;
	word16 slotByteCount;
	int16 directoryOffset;
	int16 fileHandle;

	// Verified against 0D73:4A7E-4B85.
	// Write either the save index (slot zero) or a selected serialized game slot.
	fileHandle = EnsureCompatibleSaveFile(
		OpenTrackedFile(
			CACHED_FILE_NAME(cachedFileIndex),
			0x03),
		CACHED_FILE_NAME(cachedFileIndex),
		0x03);
	directoryOffset = (int16) ((word16) (saveSlot + 0x01) << 0x01);
	SeekTrackedFile(fileHandle, (word32) (int32) directoryOffset, 0x00);
	ReadTrackedFile(fileHandle, &slotStartOffset, 0x02);
	ReadTrackedFile(fileHandle, &slotEndOffset, 0x02);
	SeekTrackedFile(
		fileHandle, (word32) (int32) (int16) slotStartOffset, 0x00);
	slotByteCount = slotEndOffset - slotStartOffset;
	if (saveSlot == 0x00)
	{
		WriteTrackedFile(fileHandle, SaveDirectory.raw,
			(word32) (int32) (int16) slotByteCount);
	}
	else
	{
		WriteTrackedFile(fileHandle, &SaveCampaignSnapshot, REVENGE_CAMPAIGN_SNAPSHOT_SIZE);
		WriteTrackedFile(fileHandle, LiveScenarioUnits,
			(word32) (int32) (int16)
				(slotByteCount - REVENGE_CAMPAIGN_SNAPSHOT_SIZE));
	}
	CloseTrackedFile(fileHandle);
	return 0x01;
}

// 0D73:4B86: word16 LoadGame(void)
// Called from:
//      RunInGameMenu
//      RunTitleAndMainMenu
// VERIFIED against 0D73:4B86-4D8E.
word16 LoadGame(void)
{
	RevengeCampaignSnapshot *snapshot;
	byte stateValue;
	word16 lanceIndex;
	word16 menuAction;
	word16 pilotIndex;
	word16 scenarioRecordIndex;
	word16 stateIndex;
	word16 unitIndex;

	OpenModalTextWindow(0x0016, 0x0001);
	snapshot = &SaveCampaignSnapshot;
	menuAction = UI_SELECTION_PENDING;
	while (menuAction == UI_SELECTION_PENDING)
	{
		menuAction = RunSaveLoadMenu(SAVE_LOAD_MODE_LOAD);
		if ((int16) menuAction > 0x0000)
		{
			if (menuAction == SAVE_LOAD_ACTION_TRAINING &&
				SaveTransferState == 0x8000)
			{
				CampaignRestartState = FALSE;
				CampaignStageIndex = 0x0015;
				CampaignPhase = 0x00;
				ScenarioVariantIndex = 0x0000;
				SavedCampaignFlags = 0x0000;
				CampaignFlags = 0x0000;
				ReplayCampaignStateRequested = FALSE;
				TrainingSequenceFlag = FALSE;
				SrmShipmentLoaded = 0x0000;
				LrmShipmentLoaded = 0x0000;
				CampaignScenarioState = 0x0000;
				LastAttackingUnitIndex = 0x0000;
				ScenarioUnitThirteenEnabled = 0x0000;
				ScenarioUnitFourteenEnabled = 0x0000;
				ScenarioUnitFifteenState = 0x0000;
				EjectedPilotRosterState = 0x0000;
				ScenarioUnitZeroAvailable = 0x0000;
				SavedCampaignClockState[0x02] = 0x00;
				SavedCampaignClockState[0x01] = 0x00;
				SavedCampaignClockState[0x00] = 0x00;
				ReplayScenarioRequested = FALSE;
				SceneTransitionAbortFlag = FALSE;
			}
			else if (ReadSaveSlot(
				0x0044,
				SelectedSaveSlotIndex + 0x0001) != FALSE)
			{
				CampaignRestartState = FALSE;
				CampaignStageIndex = snapshot->campaignStageIndex;
				ScenarioVariantIndex = snapshot->scenarioVariantIndex;
				CampaignPhase = snapshot->campaignPhase;
				TrainingSequenceFlag = snapshot->trainingSequenceFlag;
				CampaignFlags = snapshot->campaignFlags;
				SavedCampaignFlags = snapshot->state24E1;
				ScenarioUnitZeroAvailable = snapshot->stateA967;
				EjectedPilotRosterState = snapshot->scene3RosterSelector9991;
				ScenarioUnitFifteenState = snapshot->state88F1;
				ScenarioUnitFourteenEnabled = snapshot->state8925;
				ScenarioUnitThirteenEnabled = snapshot->state99C5;
				LastAttackingUnitIndex = snapshot->stateA965;
				CampaignScenarioState = snapshot->state8594;
				LrmShipmentLoaded = snapshot->lrmShipmentLoaded;
				SrmShipmentLoaded = snapshot->srmShipmentLoaded;
				CopyFarMemory(
					sizeof(snapshot->scenarioClock),
					snapshot->scenarioClock,
					SavedCampaignClockState);
				CopyFarMemory(
					sizeof(snapshot->trainingScenarioCompletionFlags),
					snapshot->trainingScenarioCompletionFlags,
					TrainingScenarioCompletionFlags);
				for (unitIndex = 0x0000;
					unitIndex < REVENGE_UNIT_SLOT_COUNT;
					++unitIndex)
				{
					ScenarioUnitMapX[unitIndex] = snapshot->scenarioUnitMapX[unitIndex];
					ScenarioUnitMapY[unitIndex] = snapshot->scenarioUnitMapY[unitIndex];
				}
				REVENGE_PRESERVATION_TRACE(
					"save: loaded slot=%u stage=%u variant=%u unit0=%u,%u unit1=%u,%u\n",
					SelectedSaveSlotIndex + 0x01,
					CampaignStageIndex, ScenarioVariantIndex,
					ScenarioUnitMapX[0x00],
					ScenarioUnitMapY[0x00],
					ScenarioUnitMapX[0x01],
					ScenarioUnitMapY[0x01]);
				for (stateIndex = 0x0000;
					stateIndex < sizeof(snapshot->state1B85);
					++stateIndex)
				{
					stateValue = snapshot->state1B85[stateIndex];
					ReplayCampaignState[stateIndex] = stateValue;
					ForwardCampaignState[stateIndex] = stateValue;
				}
				CampaignState1B8E = snapshot->state1B8E;
				for (stateIndex = 0x0000;
					stateIndex < sizeof(snapshot->state1BAD);
					++stateIndex)
				{
					stateValue = snapshot->state1BAD[stateIndex];
					ReplayExtendedCampaignState[stateIndex] = stateValue;
					ForwardExtendedCampaignState[stateIndex] = stateValue;
				}
				for (scenarioRecordIndex = 0x0000;
					scenarioRecordIndex < 0x0012;
					++scenarioRecordIndex)
				{
					UnitSelectionCards[scenarioRecordIndex] =
						snapshot->scenarioRecords[scenarioRecordIndex];
				}
				for (lanceIndex = 0x0000; lanceIndex < 0x000D; ++lanceIndex)
				{
					LanceAssignments[lanceIndex] =
						snapshot->lanceAssignments[lanceIndex];
				}
				pilotIndex = 0x0000;
				while (pilotIndex < 0x0025)
				{
					PilotRoster[pilotIndex].availability =
						snapshot->pilotAvailability[pilotIndex];
					++pilotIndex;
				}
			}
		}
	}
	RestoreModalTextWindow();
	return menuAction;
}

// 0D73:4D8F: word16 ReadSaveSlot(word16 cachedFileIndex, int16 saveSlot)
// Called from:
//      LoadGame
//      RunSaveLoadMenu
word16 ReadSaveSlot(word16 cachedFileIndex, int16 saveSlot)
{
	word16 slotEndOffset;
	word16 slotStartOffset;
	word16 slotByteCount;
	word16 readResult;
	int16 directoryOffset;
	int16 fileHandle;

	// Verified against 0D73:4D8F-4E9C.
	// Read either the save index (slot zero) or a selected serialized game slot.
	fileHandle = EnsureCompatibleSaveFile(
		OpenTrackedFile(
			CACHED_FILE_NAME(cachedFileIndex),
			0x01),
		CACHED_FILE_NAME(cachedFileIndex),
		0x01);
	directoryOffset = (int16) ((word16) (saveSlot + 0x01) << 0x01);
	SeekTrackedFile(fileHandle, (word32) (int32) directoryOffset, 0x00);
	ReadTrackedFile(fileHandle, &slotStartOffset, 0x02);
	ReadTrackedFile(fileHandle, &slotEndOffset, 0x02);
	SeekTrackedFile(
		fileHandle, (word32) (int32) (int16) slotStartOffset, 0x00);
	slotByteCount = slotEndOffset - slotStartOffset;
	if (saveSlot == 0x00)
	{
		ReadTrackedFile(fileHandle, SaveDirectory.raw,
			(word32) (int32) (int16) slotByteCount);
		readResult = SavedSaveTransferState;
		SaveTransferState = readResult;
	}
	else
	{
		ReadTrackedFile(fileHandle, &SaveCampaignSnapshot, REVENGE_CAMPAIGN_SNAPSHOT_SIZE);
		ReadTrackedFile(fileHandle, LiveScenarioUnits,
			(word32) (int32) (int16)
				(slotByteCount - REVENGE_CAMPAIGN_SNAPSHOT_SIZE));
	}
	CloseTrackedFile(fileHandle);
	return 0x01;
}

// 0D73:4E9D: int16 RunSaveLoadMenu(word16 menuMode)
// Called from:
//      SaveGame
//      LoadGame
// VERIFIED against 0D73:4E9D-4EC6.
int16 RunSaveLoadMenu(word16 menuMode)
{
	int16 menuAction;

	menuAction = ReadSaveSlot(0x0044, 0x0000);
	if (menuAction == TRUE)
		menuAction = ShowSaveLoadMenu(menuMode);
	return menuAction;
}

// 0D73:4EC7: int16 ShowSaveLoadMenu(word16 menuMode)
// Called from:
//      RunSaveLoadMenu
// VERIFIED against 0D73:4EC7-51F8.
int16 ShowSaveLoadMenu(word16 menuMode)
{
	RevengeSaveSlotDescriptor *selectedSlot;
	char previousSlotName[0x16];
	byte previousDefaultSelection;
	int16 menuAction;
	int16 promptX;
	int16 promptY;
	int16 selectedMenuItem;
	word16 cancelItemIndex;
	word16 directoryChanged;
	word16 exitDosItemIndex;
	word16 menuItemCount;
	word16 previousBackground;
	word16 renameItemIndex;
	word16 slotIndex;
	int16 trainingItemIndex;

	directoryChanged = FALSE;
	menuAction = SAVE_LOAD_ACTION_CANCEL;

	HideMouseCursorOverlay();
	ClearActiveTextWindow();
	previousDefaultSelection = SaveLoadMenuDefaultSelection;

	for (slotIndex = 0x0000; slotIndex < SAVE_SLOT_COUNT; ++slotIndex)
	{
		/* The ASM uses a byte displacement into the packed far-pointer table. */
		RenderFormattedText(
			InGameMenuTextTable[menuMode - SAVE_LOAD_MODE_SAVE]);
		RenderFormattedText(SaveGameSeparatorText);
		RenderFormattedText(SaveDirectory.slots[slotIndex].name);
		RenderFormattedText("\r"); // TEXT DS:47B4: CR before unit-name table; Locust starts at DS:47B6
	}

	menuItemCount = SAVE_SLOT_COUNT;
	renameItemIndex = menuItemCount;
	RenderFormattedText("Rename"); // TEXT DS:265B: "Rename"
	if (menuMode == SAVE_LOAD_MODE_LOAD)
		RenderFormattedText(" load"); // TEXT DS:2662: " load"
	else
		RenderFormattedText(" save"); // TEXT DS:2668: " save"
	RenderFormattedText(SaveGameSeparatorText);
	RenderFormattedText("\r"); // TEXT DS:47B4: CR before unit-name table; Locust starts at DS:47B6

	exitDosItemIndex = ++menuItemCount;
	RenderFormattedText("Exit to DOS\r"); // TEXT DS:26AF: "Exit to DOS\r"
	trainingItemIndex = -0x000A;
	if (menuMode == SAVE_LOAD_MODE_LOAD && SaveTransferState == 0x8000)
	{
		++SaveLoadMenuDefaultSelection;
		trainingItemIndex = ++menuItemCount;
		RenderFormattedText("* Pacifica Training Ground *\r"); // TEXT DS:26FA: "* Pacifica Training Ground *\r"
	}
	cancelItemIndex = ++menuItemCount;
	RenderFormattedText("Cancel"); // TEXT DS:2675: "Cancel"
	RenderFormattedText("\r"); // TEXT DS:47B4: CR before unit-name table; Locust starts at DS:47B6
	ShowMouseCursorOverlay();
	UiRegionTable[0x0C].rowCount = menuItemCount + 0x0001;
	FlushPendingInput();
	selectedMenuItem = RunSingleUiRegionSelection(0x0C);

	if (selectedMenuItem < (int16)renameItemIndex)
	{
		selectedSlot = &SaveDirectory.slots[selectedMenuItem];
		SelectedSaveSlotIndex = (byte)selectedMenuItem;
		if (menuMode == SAVE_LOAD_MODE_LOAD && !selectedSlot->occupied)
		{
			HideMouseCursorOverlay();
			RenderFormattedText("Game has not been saved yet.\r"); // TEXT DS:263D: "Game has not been saved yet.\r"
			ShowMouseCursorOverlay();
			WaitForAcknowledgement();
		}
		else
		{
			menuAction = SAVE_LOAD_ACTION_SLOT;
			if (menuMode == SAVE_LOAD_MODE_SAVE)
			{
				FarStringCopy(previousSlotName, selectedSlot->name);
				directoryChanged = RenameSaveSlot(selectedMenuItem);
				if (directoryChanged != FALSE &&
					(FarStringCompare(previousSlotName, selectedSlot->name) == 0x0000 ||
					 IsBlankSaveSlotName(selectedSlot->name)))
				{
					ActiveTextCursorColumn = 0x0000;
					ActiveTextCursorRow = 0x0009;
					HideMouseCursorOverlay();
					previousBackground =
						ActiveTextBackgroundColor;
					ActiveTextBackgroundColor = 0x0C;
					promptX = (int16)
						(ActiveTextWindowLeftTile << 0x03);
					promptY = (int16)
						((ActiveTextWindowTopTile << 0x03) +
						0x0009 * ActiveFontGlyphAdvanceX);
					RenderFormattedText("Are you sure you want to save?"); // TEXT DS:26BC
					XorVideoRectangle(promptX, promptY,
						(word16) (promptX +
							ActiveFontGlyphAdvanceX *
							StringLength("Are you sure you want to save?") - 0x0001),
						(word16) (promptY +
							ActiveFontLineHeight - 0x0001),
						0x0001);
					ActiveTextBackgroundColor = previousBackground;
					ShowMouseCursorOverlay();
					if (PromptYesNo(0x0000) != FALSE)
					{
						FarStringCopy(selectedSlot->name, previousSlotName);
						directoryChanged = FALSE;
						menuAction = SAVE_LOAD_ACTION_REOPEN_MENU;
					}
				}
			}
			if (directoryChanged != FALSE)
				selectedSlot->occupied = TRUE;
		}
	}
	if (selectedMenuItem == (int16)renameItemIndex)
	{
		directoryChanged = RenameSaveSlot(SAVE_LOAD_ACTION_REOPEN_MENU);
		menuAction = SAVE_LOAD_ACTION_REOPEN_MENU;
	}
	if (selectedMenuItem == (int16)exitDosItemIndex)
		menuAction = SAVE_LOAD_ACTION_EXIT_DOS;
	if (selectedMenuItem == trainingItemIndex)
		menuAction = SAVE_LOAD_ACTION_TRAINING;
	if (selectedMenuItem == (int16)cancelItemIndex)
		menuAction = SAVE_LOAD_ACTION_CANCEL;
	if (directoryChanged != FALSE)
		WriteSaveSlot(0x0044, 0x0000);
	SaveLoadMenuDefaultSelection = previousDefaultSelection;
	return menuAction;
}

// 0D73:51F9: word16 IsBlankSaveSlotName(const char far *slotName)
// Called from:
//      ShowSaveLoadMenu
// VERIFIED against 0D73:51F9-5232.
word16 IsBlankSaveSlotName(const char *slotName)
{
	int16 characterIndex;
	int16 nameLength;
	word16 isBlank;

	isBlank = TRUE;
	nameLength = (int16) StringLength(slotName);
	for (characterIndex = 0x0000;
		characterIndex < nameLength;
		++characterIndex)
	{
		if (slotName[characterIndex] != ' ')
			isBlank = FALSE;
	}
	return isBlank;
}

// 0D73:5233: word16 RenameSaveSlot(int16 slotIndex)
// Called from:
//      ShowSaveLoadMenu
// VERIFIED against 0D73:5233-53E0.
word16 RenameSaveSlot(int16 slotIndex)
{
	RevengeSaveSlotDescriptor *slot;
	int16 promptX;
	int16 promptY;
	word16 previousBackground;
	word16 wasRenamed;

	previousBackground = ActiveTextBackgroundColor;
	ActiveTextBackgroundColor = 0x0C;
	if (slotIndex < 0x0000)
	{
		ActiveTextCursorColumn = 0x0005;
		ActiveTextCursorRow = SaveLoadMenuDefaultSelection;
		promptX = (int16)
			((ActiveTextWindowLeftTile << 0x03) +
			ActiveTextCursorColumn *
			ActiveFontGlyphAdvanceX);
		promptY = (int16)
			((ActiveTextWindowTopTile << 0x03) +
			ActiveTextCursorRow *
			ActiveFontGlyphAdvanceX);
		HideMouseCursorOverlay();
		RenderFormattedText("Select game to rename.  "); // TEXT DS:267D: "Select game to rename.  "
		XorVideoRectangle(
			promptX,
			promptY,
			(word16) (promptX +
				ActiveFontGlyphAdvanceX *
				StringLength("Select game to rename.  ") - 0x0001),
			(word16) (promptY +
				ActiveFontLineHeight -
				0x0001),
			0x0001); // TEXT DS:267D
		ShowMouseCursorOverlay();
		UiRegionTable[0x0C].rowCount = SAVE_SLOT_COUNT;
		UiRegionTable[0x0C].selectedRow = 0x0000;
		FlushPendingInput();
		slotIndex = RunSingleUiRegionSelection(0x0C);
	}

	wasRenamed = FALSE;
	if (slotIndex == KEY_ESCAPE)
		return wasRenamed;

	slot = &SaveDirectory.slots[slotIndex];
	ActiveTextCursorColumn = 0x0005;
	ActiveTextCursorRow = SaveLoadMenuDefaultSelection;
	promptX = (int16)
		((ActiveTextWindowLeftTile << 0x03) +
		ActiveTextCursorColumn *
		ActiveFontGlyphAdvanceX);
	promptY = (int16)
		((ActiveTextWindowTopTile << 0x03) +
		ActiveTextCursorRow *
		ActiveFontGlyphAdvanceX);
	HideMouseCursorOverlay();
	RenderFormattedText("Enter new name for game."); // TEXT DS:2696: "Enter new name for game."
	XorVideoRectangle(
		promptX,
		promptY,
		(word16) (promptX +
			ActiveFontGlyphAdvanceX *
			StringLength("Enter new name for game.") - 0x0001),
		(word16) (promptY +
			ActiveFontLineHeight -
			0x0001),
		0x0001); // TEXT DS:2696
	ShowMouseCursorOverlay();
	ActiveTextCursorColumn = 0x000A;
	ActiveTextCursorRow = slotIndex;
	do
	{
		wasRenamed = EditTextField(0x0014, slot->name, 0x07);
	}
	while (wasRenamed == FALSE);
	FarStringCopy(slot->name, (const char *)TextEntryBuffer);
	ActiveTextBackgroundColor = previousBackground;
	return TRUE;
}

// 0D73:53E1: void WaitForAcknowledgement(void)
// Called from:
//      ShowSaveLoadMenu
// VERIFIED against 0D73:53E1-546E.
void WaitForAcknowledgement(void)
{
	word16 bottomY;
	word16 leftX;
	word16 rightX;
	word16 topY;

	HideMouseCursorOverlay();
	if (ActiveTextCursorColumn != 0x0000)
		RenderFormattedText("\r"); // TEXT DS:47B4: CR before unit-name table; Locust starts at DS:47B6
	leftX = (word16) ((ActiveTextWindowLeftTile << 0x03) +
		ActiveTextCursorColumn *
		ActiveFontGlyphAdvanceX);
	topY = (word16) ((ActiveTextWindowTopTile << 0x03) +
		ActiveTextCursorRow *
		ActiveFontGlyphAdvanceX);
	RenderFormattedText("Press return or button"); // TEXT DS:26DB: "Press return or button"
	rightX = (word16) (leftX +
		ActiveFontGlyphAdvanceX *
		StringLength("Press return or button") - 0x0001);
	bottomY = (word16) (topY +
		ActiveFontLineHeight -
		0x0001);
	XorVideoRectangle(
		leftX,
		topY,
		rightX,
		bottomY,
		0x0001); // TEXT DS:26DB: "Press return or button"
	ShowMouseCursorOverlay();
	FlushPendingInput();
	WaitForDismissInput();
}

// 0D73:546F: int16 PromptYesNo(word16 initialSelection)
// Called from:
//      ShowSaveLoadMenu
// VERIFIED against 0D73:546F-54B8.
int16 PromptYesNo(word16 initialSelection)
{
	HideMouseCursorOverlay();
	if (ActiveTextCursorColumn != 0x00)
		RenderFormattedText("\r"); // TEXT DS:47B4: CR before unit-name table; Locust starts at DS:47B6
	UiRegionTable[0x0D].topRow = ActiveTextCursorRow;
	UiRegionTable[0x0D].selectedRow = initialSelection;
	RenderFormattedText("Yes\r No"); // TEXT DS:26F2: "Yes\r No"
	ShowMouseCursorOverlay();
	FlushPendingInput();
	return RunSingleUiRegionSelection(0x0D);
}
