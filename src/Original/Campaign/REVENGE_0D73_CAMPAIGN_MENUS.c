// REVENGE_0D73_CAMPAIGN_MENUS.c
// Procedures reconstructed from REVENGE.EXE segment 0D73.

#include "REVENGE_0D73_CAMPAIGN_INTERNAL.h"
#include "revenge/debug.h"

// 0D73:2414: word16 ConfirmExitToDos(void)
// Called from:
//      RunInGameMenu
//      RunTitleAndMainMenu
word16 ConfirmExitToDos(void)
{
	DialogFramingEnabled = 0x01;
	return ShowConfirmationDialog(ExitToDosPrompt) == 0x00;
}

/* 0D73:242E is reconstructed in UI/REVENGE_0D73_CONFIRMATION.c. */

// 0D73:2448: word16 ShowConfirmationDialog(const char far *message)
// Called from:
//      ConfirmExitToDos
//      ConfirmRestartGame
word16 ShowConfirmationDialog(const char *message)
{
	word16 selection;

	OpenModalTextWindow(0x0E, 0x01);
	HideMouseCursorOverlay();
	RenderFormattedText(message);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	do
	{
		selection = RunSingleUiRegionSelection(0x07);
		if (selection == KEY_ESCAPE)
			ToggleActiveUiRegionHighlight();
	} while (selection == KEY_ESCAPE);
	RestoreModalTextWindow();
	return selection;
}

// 0D73:249E: callback that runs the DS:25CD two-option menu and stores its
// zero-based byte selection at DS:24E5.
// VERIFIED against 0D73:249E-24B2.
void RunCampaignPathSelectionCallback(void)
{
	RunTwoOptionMenuSelection(
		CampaignPathMenuTextTable);
	CampaignRestartState =
		(byte)(ActiveUiRegionIndex - 0x0008);
}

// 0D73:24B3: callback that runs the DS:25D5 two-option menu and stores its
// zero-based word selection at DS:24D8.
// VERIFIED against 0D73:24B3-24C8.
void RunScenarioVariantSelectionCallback(void)
{
	RunTwoOptionMenuSelection(
		ScenarioVariantMenuTextTable);
	ScenarioVariantIndex =
		(word16)(ActiveUiRegionIndex - 0x0008);
}

// 0D73:24C9: callback that runs the DS:25DD two-option menu and stores its
// zero-based word selection at DS:24D8.
// VERIFIED against 0D73:24C9-24DE.
void RunAlternateScenarioVariantSelectionCallback(void)
{
	RunTwoOptionMenuSelection(
		AlternateScenarioMenuTextTable);
	ScenarioVariantIndex =
		(word16)(ActiveUiRegionIndex - 0x0008);
}

// 0D73:24DF: void ShowMainMenu(void)
// Called from:
//      RunTitleAndMainMenu
void ShowMainMenu(void)
{
	RunMainMenuSelection(
		MainMenuTextTable);
	ScenarioVariantIndex =
		(word16) (ActiveUiRegionIndex - 0x0008);
}

// 0D73:24F5: draw and select from a two-option far-string table.
// VERIFIED against 0D73:24F5-25F4.
word16 RunTwoOptionMenuSelection(
	const char * const menuOptionText[0x02])
{
	int16 menuRow;
	int16 secondColumn;
	int16 glyphWidth;
	word16 firstLength;
	word16 secondLength;
	word16 selection;

	HideMouseCursorOverlay();
	menuRow = (int16)((ActiveTextWindowHeightTiles << 0x03)
		/ ActiveFontLineHeight) - 0x0002;
	glyphWidth = ActiveFontGlyphAdvanceX;

	const char *firstText = menuOptionText[0x00];
	const char *secondText = menuOptionText[0x01];
	firstLength = StringLength(firstText);
	DrawBeveledMenuButton(0x0005, menuRow,
		firstText,
		(word16)(glyphWidth * firstLength));
	UiRegionTable[0x08].leftColumn = 0x0005;
	UiRegionTable[0x08].topRow = menuRow;
	UiRegionTable[0x08].widthColumns = StringLength(firstText);

	secondLength = StringLength(secondText);
	secondColumn = (int16)(0x0108 / glyphWidth) - secondLength;
	DrawBeveledMenuButton(secondColumn, menuRow,
		secondText,
		(word16)(glyphWidth * secondLength));
	UiRegionTable[0x09].leftColumn = secondColumn;
	UiRegionTable[0x09].topRow = menuRow;
	UiRegionTable[0x09].widthColumns = secondLength;

	ShowMouseCursorOverlay();
	FlushPendingInput();
	do
	{
		selection = RunUiRegionSelectionLoop(0x0008, 0x0002);
		if (selection == KEY_ESCAPE)
			ToggleActiveUiRegionHighlight();
	} while (selection == KEY_ESCAPE);
	return selection;
}

// 0D73:25F5: word16 RunMainMenuSelection(const far-pointer table menuOptionText)
// Called from:
//      ShowMainMenu
word16 RunMainMenuSelection(const char * const menuOptionText[0x03])
{
	int16 menuRow;
	int16 glyphWidth;
	int16 secondColumn;
	int16 thirdColumn;
	word16 firstLength;
	word16 secondLength;
	word16 thirdLength;
	word16 selection;

	// Verified against 0D73:25F5-274C.
	HideMouseCursorOverlay();
	menuRow = (int16) ((ActiveTextWindowHeightTiles << 0x03)
		/ ActiveFontLineHeight) - 0x02;
	glyphWidth = ActiveFontGlyphAdvanceX;
	const char *firstText = menuOptionText[0x00];
	const char *secondText = menuOptionText[0x01];
	const char *thirdText = menuOptionText[0x02];
	firstLength = StringLength(firstText);
	DrawBeveledMenuButton(0x03, menuRow, firstText,
		(word16) (glyphWidth * firstLength));
	UiRegionTable[0x08].leftColumn = 0x03;
	UiRegionTable[0x08].topRow = menuRow;
	firstLength = StringLength(firstText);
	UiRegionTable[0x08].widthColumns = firstLength;

	secondLength = StringLength(secondText);
	secondColumn = (int16) ((0x0130 / glyphWidth) - secondLength);
	secondColumn >>= 0x01;
	DrawBeveledMenuButton(secondColumn, menuRow, secondText,
		(word16) (secondLength * glyphWidth));
	UiRegionTable[0x09].leftColumn = secondColumn;
	UiRegionTable[0x09].topRow = menuRow;
	UiRegionTable[0x09].widthColumns = secondLength;

	thirdLength = StringLength(thirdText);
	thirdColumn = (int16) ((0x0130 / glyphWidth) - thirdLength);
	DrawBeveledMenuButton(thirdColumn, menuRow, thirdText,
		(word16) (thirdLength * glyphWidth));
	UiRegionTable[0x0A].leftColumn = thirdColumn;
	UiRegionTable[0x0A].topRow = menuRow;
	UiRegionTable[0x0A].widthColumns = thirdLength;
	ShowMouseCursorOverlay();
	FlushPendingInput();
	do
	{
		selection = RunUiRegionSelectionLoop(0x08, 0x03);
		if (selection == KEY_ESCAPE)
			ToggleActiveUiRegionHighlight();
	} while (selection == KEY_ESCAPE);
	return selection;
}

// 0D73:274D: int16 RunInGameMenu(int16 firstMenuOption)
// Called from:
//      RunCampaignLoop
// VERIFIED against 0D73:274D-2A5C.
int16 RunInGameMenu(int16 firstMenuOption)
{
	int16 actionResult;
	int16 result;
	word16 index;
	word16 menuWindowTop;
	word16 menuItemCount;
	word16 menuY;
	word16 optionIndex;
	word16 selection;

	result = -0x0001;

	if (firstMenuOption == 0x00)
	{
		menuWindowTop = 0x09;
		menuItemCount = 0x09;
	}
	else
	{
		menuWindowTop = 0x0A;
		menuItemCount = 0x05;
	}
	TextWindowContexts[0x11].topTile = menuWindowTop;
	TextWindowContexts[0x11].heightTiles = (word16)
		((menuItemCount *
			ActiveFontLineHeight +
			0x0007) >> 0x03);
	OpenModalTextWindow(0x11, 0x01);
	HideMouseCursorOverlay();
	menuY = TextWindowContexts[0x11].topTile << 0x03;
	for (optionIndex = (word16) firstMenuOption;
		optionIndex < 0x0009;
		++optionIndex)
	{
		DrawCenteredClippedText(
			InGameMenuTextTable[optionIndex + 0x02],
			0x00,
			TextWindowContexts[0x11].leftTile << 0x03,
			menuY,
			TextWindowContexts[0x11].widthTiles << 0x03,
			(byte)ActiveTextForegroundColor,
			(byte)ActiveTextBackgroundColor); // TABLE DS:25F9: MenuOptionTextTable entry 5 onward
		menuY += (int16)ActiveFontLineHeight;
	}
	ShowMouseCursorOverlay();
	UiRegionTable[0x0B].rowCount = menuItemCount;
	UiRegionTable[0x0B].widthColumns = 0x11;
	FlushPendingInput();
	do
	{
		selection = RunSingleUiRegionSelection(0x0B);
		if (selection == KEY_ESCAPE)
			ToggleActiveUiRegionHighlight();
	} while (selection == KEY_ESCAPE);
	RestoreModalTextWindow();

	selection += firstMenuOption;
	if (selection > IN_GAME_MENU_OPTIONS)
		return result;

	switch (selection)
	{
	case IN_GAME_MENU_CONTINUE:
	case IN_GAME_MENU_JUMP_STORY:
	{
		if (ScenarioRosterPrepared == FALSE)
		{
			PrepareScenarioUnitRosters();
			CampaignStageIndex += PendingCampaignStageDelta;
			CampaignPhase += PendingCampaignPhaseDelta;
		}
		ReplayScenarioRequested = FALSE;
		SceneTransitionAbortFlag = selection == IN_GAME_MENU_JUMP_STORY;
		result = 0x01;
		break;
	}
	case IN_GAME_MENU_SAVE_CONTINUE:
	{
		actionResult = (int16) SaveGame();
		result = actionResult == 0x0000
			? -0x0001 : actionResult;
		if (actionResult < 0x0000)
			result = ConfirmExitToDos()
				? 0x0000 : -0x0001;
		break;
	}
	case IN_GAME_MENU_SAVE_QUIT:
	{
		actionResult = (int16) SaveGame();
		result = actionResult == 0x0001
			? 0x0000
			: (actionResult == 0x0000
				? -0x0001 : actionResult);
		if (actionResult < 0x0000)
			result = ConfirmExitToDos()
				? 0x0000 : -0x0001;
		break;
	}
	case IN_GAME_MENU_LOAD:
	{
		actionResult = (int16) LoadGame();
		result = actionResult == 0x0000
			? -0x0001 : actionResult;
		if (actionResult < 0x0000)
			result = ConfirmExitToDos()
				? 0x0000 : -0x0001;
		break;
	}
	case IN_GAME_MENU_REPLAY_SCENARIO:
		ReplayCampaignStateRequested = TRUE;
		ReplayScenarioRequested = TRUE;
		result = 0x01;
		break;
	case IN_GAME_MENU_REPLAY_STORY:
		PromoteReserveUnitsForCampaignStage();
		ReplayCampaignStateRequested = TRUE;
		TrainingSequenceFlag = FALSE;
		result = 0x01;
		break;
	case IN_GAME_MENU_RESTART:
		if (!ConfirmRestartGame())
			break;
		CampaignRestartState = FALSE;
		ReplayCampaignStateRequested = FALSE;
		for (index = 0x0000; index < 0x0007; ++index)
		{
			ReplayCampaignState[index] =
				InitialCampaignState[index];
		}
		CampaignState1B8E = CampaignState1B8C;
		for (index = 0x0000; index < 0x000F; ++index)
		{
			ReplayExtendedCampaignState[index] =
				InitialExtendedCampaignState[index];
		}
		CampaignStageIndex = 0x00;
		ScenarioVariantIndex = 0x00;
		CampaignPhase = FALSE;
		TrainingSequenceFlag = FALSE;
		CampaignFlags = 0x00;
		SavedCampaignFlags = 0x00;
		SrmShipmentLoaded = 0x00;
		LrmShipmentLoaded = 0x00;
		CampaignScenarioState = 0x00;
		LastAttackingUnitIndex = 0x00;
		ScenarioUnitThirteenEnabled = 0x00;
		ScenarioUnitFourteenEnabled = 0x00;
		ScenarioUnitFifteenState = 0x00;
		EjectedPilotRosterState = 0x00;
		ScenarioUnitZeroAvailable = 0x00;
		for (index = 0x0000; index < 0x0006; ++index)
			TrainingScenarioCompletionFlags[index] = 0x00;
		result = 0x01;
		break;
	case IN_GAME_MENU_OPTIONS:
		result = RunGameOptionsMenu(0x0000) == 0x0004
			? 0x0000 : -0x0001;
		break;
	}

	ReplayScenarioRequested = selection == IN_GAME_MENU_REPLAY_SCENARIO;
	if (selection != IN_GAME_MENU_CONTINUE && selection != IN_GAME_MENU_JUMP_STORY)
		SceneTransitionAbortFlag = FALSE;
	return result;
}

// 0D73:309C: int16 RunTitleAndMainMenu(void)
// Called from:
//      RunCampaignLoop
// Verified against 0D73:309C-324D.
int16 RunTitleAndMainMenu(void)
{
	int16 selectedGameMode = 0x00;
	word16 transitionPending;
	word16 showTitle;

	SelectTextWindow(0x00);
	LoadScenarioDigitalSoundBank(-0x01);
	PlayScenarioDigitalSoundSequence(~0x00);
	ReleaseDigitalSoundBuffer();
	PresentationDismissTimeout = 0x00;
	transitionPending = PresentScreenAndMessage(0x0F, 0x00);
	LoadScenarioDigitalSoundBank(-0x02);
	PlayScenarioDigitalSoundSequence(~0x01);
	ReleaseDigitalSoundBuffer();
	PlayMusicResource(0x4D);
	PresentationDismissTimeout = 0x01C2;
	transitionPending = WaitForDismissInputOrTimeout(PresentationDismissTimeout);
	PresentationDismissTimeout = 0x0258;
	showTitle = TRUE;
	while (showTitle != FALSE)
	{
		word16 titleCompleted;
		if (SceneTransitionAbortFlag == 0x00 && transitionPending == 0x00)
		{
			titleCompleted = PlayTitleTextSequence();
		}
		else
		{
			transitionPending = 0x00;
			titleCompleted = FALSE;
		}
		showTitle = titleCompleted;
		if (titleCompleted == FALSE)
		{
			SceneTransitionAbortFlag = 0x00;
			HideMouseCursorOverlay();
			CopyClippedVideoRegion(0x01, 0xB7, 0x01, 0xB7, 0x25, 0x0B, VideoFramebuffer, PrimaryScreenBuffer);
			ShowMouseCursorOverlay();
			ShowMainMenu();
			REVENGE_PRESERVATION_TRACE("menu: main selection=%u activeRegion=%d\n",
				ScenarioVariantIndex, ActiveUiRegionIndex);
			if (ScenarioVariantIndex == 0x00)
			{
				CampaignStageIndex = 0x00;
				selectedGameMode = 0x01;
			}
			else if (ScenarioVariantIndex == 0x01)
			{
				int16 loadResult = (int16)LoadGame();
				selectedGameMode = loadResult;
				if (loadResult == 0x00)
					showTitle = TRUE;
				else if (loadResult < 0x00)
				{
					selectedGameMode = ConfirmExitToDos() == FALSE;
					if (selectedGameMode == FALSE)
					{
						VideoPathUnavailable = TRUE;
					}
					else
						showTitle = TRUE;
				}
				ScenarioVariantIndex = 0x00;
			}
			else
			{
				if (RunGameOptionsMenu(0x00) != 0x04)
					showTitle = TRUE;
				else
				{
					selectedGameMode = 0x00;
					showTitle = FALSE;
				}
			}
			HideMouseCursorOverlay();
			CopyClippedVideoRegion(0x01, 0xB7, 0x01, 0xB7, 0x25, 0x0B, PrimaryScreenBuffer, VideoFramebuffer);
			ShowMouseCursorOverlay();
			if (showTitle != FALSE)
				transitionPending = WaitForDismissInputOrTimeout(PresentationDismissTimeout);
		}
	}
	PresentationDismissTimeout = 0x012C;
	return selectedGameMode;
}
