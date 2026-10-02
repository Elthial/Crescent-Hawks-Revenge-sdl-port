// REVENGE_0D73_CAMPAIGN_DRIVER.c
// Procedures reconstructed from REVENGE.EXE segment 0D73.

#include "REVENGE_0D73_CAMPAIGN_INTERNAL.h"

// 0D73:1302: int16 RunCampaignStage11(void)
// VERIFIED against 0D73:1302-13FF.
int16 RunCampaignStage11(void)
{
	PlayMusicResource(0x004D);
	PresentCampaignScene(0x000E, 0x0001, 0x0053);
	ShowCampaignMessageAndWait(0x0054);
	InitializeTacticalScenario();
	if (PersistentUnitRoster[0x08].deploymentState == 0x00)
		CampaignFlags |= 0x0080;
	if ((CampaignFlags & 0x00C0) != 0x0000)
		CampaignFlags &= 0xFFFE;
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004C);
		PresentAnimatedScreenAndMessage(0x001B, 0x0057);
		ShowStoryMessageAndWait(0x0058);
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x0055);
	}
	else if ((CampaignFlags & 0x0040) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x0056);
	}
	else if ((CampaignFlags & 0x0080) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x004D);
	}
	return FALSE;
}

// 0D73:1400: int16 RunCampaignStage12(void)
// VERIFIED against 0D73:1400-155E.
int16 RunCampaignStage12(void)
{
	InitializeTacticalScenario();
	if (PersistentUnitRoster[0x08].deploymentState == 0x00)
		CampaignFlags |= 0x0080;
	if ((CampaignFlags & 0x00C0) != 0x0000)
		CampaignFlags &= 0xFFFE;
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004A);
		PresentAnimatedScreenAndMessage(0x001B, 0x005A);
		ShowStoryMessageAndWait(0x005B);
		PlayMusicResource(0x004E);
		PresentScreenAndMessage(0x0006, 0x005C);
		PlayMusicResource(0x004A);
		PresentMissionBriefing(0x000B, 0x0003, 0x005D);
		DisplayMissionDate(0x0000, 0x0000, 0x0003, 0x0000, 0x0000);
		PlayMusicResource(0x004D);
		PresentScreenAndMessage(0x0006, 0x005E);
		ShowScenarioMessage(0x005F);
		ShowScenarioMessage(0x0060);
		ShowScenarioMessage(0x0061);
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x0055);
	}
	else if ((CampaignFlags & 0x0040) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x0059);
	}
	else if ((CampaignFlags & 0x0080) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x004D);
	}
	return FALSE;
}

// 0D73:155F: int16 RunCampaignStage13(void)
// VERIFIED against 0D73:155F-171D.
int16 RunCampaignStage13(void)
{
	word16 scenarioIndex;

	StopLoadedMusicTrack();
	if (TrainingSequenceFlag == FALSE)
	{
		PlayMusicResource(0x004A);
		DisplayMissionDate(0x0000, -0x0001,
			0x0004, 0x0062, 0x0000);
		DisplayMissionDate(0x0001, -0x0001,
			0x0005, 0x0063, 0x0001);
		DisplayMissionDate(-0x0001, 0x0003,
			0x0006, 0x0064, 0x0000);
		PlayMusicResource(0x004C);
		DisplayMissionDate(0x0002, -0x0001,
			0x0007, 0x0065, 0x0001);
		StopLoadedMusicTrack();
		DisplayMissionDate(0x0003, -0x0001,
			0x0008, 0x0000, 0x0001);
		DisplayMissionDate(-0x0001, 0x0004,
			0x0009, 0x0066, 0x0000);
		PlayMusicResource(0x0049);
		PresentStoryScreenAndMessage(0x001F, 0x0067);
		PrepareLanceSelection(
			0x0002,
			AlternateLanceSelection == FALSE
				? 0x0001 : -0x0001);
		AlternateLanceSelection = FALSE;
		EnableTrainingUnitSelectionSlots();
		PlayMusicResource(0x0048);
		PresentStoryScreenAndMessage(0x001F, 0x0068);
		ShowStoryMessage(0x0069);
	}

	while (RunTrainingScenarioSelection() != FALSE)
		;
	PresentStoryScreenAndMessage(
		0x001F,
		(word16) (0x006A + ScenarioVariantIndex));
	InitializeTacticalScenario();
	HideMouseCursorOverlay();
	ClearActiveVideoBuffer();
	ShowMouseCursorOverlay();
	if (CampaignMenuRequested == FALSE &&
		(CampaignFlags & 0x0001) != 0x0000)
	{
		TrainingScenarioCompletionFlags[ScenarioVariantIndex] = TRUE;
	}

	TrainingSequenceFlag = FALSE;
	PendingCampaignStageDelta = TRUE;
	for (scenarioIndex = 0x0000; scenarioIndex < 0x0006; ++scenarioIndex)
	{
		if (TrainingScenarioCompletionFlags[scenarioIndex] == FALSE)
		{
			PendingCampaignStageDelta = FALSE;
			break;
		}
	}
	if (PendingCampaignStageDelta == FALSE)
		TrainingSequenceFlag = TRUE;
	return TRUE;
}

// 0D73:171E: int16 RunCampaignStage14(void)
// VERIFIED against 0D73:171E-18F2.
int16 RunCampaignStage14(void)
{
	if (ReplayScenarioRequested == FALSE)
		ScenarioVariantIndex = 0x0000;
	PlayMusicResource(0x004A);
	PresentAnimatedScreenAndMessage(0x001F, 0x0070);
	PresentMissionBriefing(0x000B, 0x0000, 0x0071);
	PlayMusicResource(0x004C);
	DisplayMissionDate(0x0004, 0x0005, 0x000A, 0x0072, 0x0000);
	ShowMissionFollowupMessage(0x0073);

	if (ReplayScenarioRequested == FALSE)
	{
		PlayMusicResource(0x0049);
		if (SceneTransitionAbortFlag != FALSE)
		{
			SceneTransitionAbortFlag = FALSE;
			PresentationCallbackOffset = 0x24B3;
		PresentationCallback = RunScenarioVariantSelectionCallback;
			PresentationCallbackSegment = 0x0D73;
			PresentScreenAndMessage(0x0007, 0x0075);
			PresentationCallbackOffset = 0x0000;
		PresentationCallback = NULL;
			PresentationCallbackSegment = 0x0000;
		}
		else
		{
			PresentScreenAndMessage(0x0007, 0x0074);
			PresentationCallbackOffset = 0x24B3;
		PresentationCallback = RunScenarioVariantSelectionCallback;
			PresentationCallbackSegment = 0x0D73;
			ShowScenarioMessage(0x0075);
			PresentationCallbackOffset = 0x0000;
		PresentationCallback = NULL;
			PresentationCallbackSegment = 0x0000;
		}
	}

	PlayMusicResource(0x004D);
	if (ScenarioVariantIndex == 0x0000)
	{
		PresentAnimatedScreenAndMessage(0x001D, 0x0076);
		StopLoadedMusicTrack();
		HideMouseCursorOverlay();
		ClearActiveVideoBuffer();
		ShowMouseCursorOverlay();
		PresentScreenAndMessage(0xFFFF, 0x0077);
		InitializeTacticalScenario();
		if (CampaignMenuRequested != FALSE)
			return FALSE;
		if ((CampaignFlags & 0x0002) != 0x0000)
		{
			PlayMusicResource(0x0047);
			PresentScreenAndMessage(0x000C, 0x0078);
			return FALSE;
		}
	}
	else
	{
		PresentAnimatedScreenAndMessage(0x001D, 0x0079);
		InitializeTacticalScenario();
		if (CampaignMenuRequested != FALSE)
			return FALSE;
		if ((CampaignFlags & 0x0002) != 0x0000)
		{
			PlayMusicResource(0x0047);
			PresentScreenAndMessage(0x000C, 0x007A);
			return FALSE;
		}
	}

	HideMouseCursorOverlay();
	ClearActiveVideoBuffer();
	ShowMouseCursorOverlay();
	PendingCampaignStageDelta = TRUE;
	return TRUE;
}

// 0D73:18F3: int16 RunCampaignStage15(void)
// VERIFIED against 0D73:18F3-1A9C.
int16 RunCampaignStage15(void)
{
	if (ReplayScenarioRequested == FALSE)
		ScenarioVariantIndex = 0x0000;

	PlayMusicResource(0x0047);
	PresentScreenAndMessage(0x0002, 0x007B);
	ShowScenarioMessage(0x007C);
	ShowScenarioMessage(0x007D);
	PlayMusicResource(0x004C);
	if (SceneTransitionAbortFlag == FALSE)
		PresentAnimatedScreenAndMessage(0x001E, 0x007E);
	if (ReplayScenarioRequested == FALSE)
	{
		PresentationCallbackOffset = 0x24C9;
		PresentationCallback = RunAlternateScenarioVariantSelectionCallback;
		PresentationCallbackSegment = 0x0D73;
		ShowScenarioMessage(0x007F);
		PresentationCallbackOffset = 0x0000;
		PresentationCallback = NULL;
		PresentationCallbackSegment = 0x0000;
	}

	if (ScenarioVariantIndex == 0x0000)
	{
		InitializeTacticalScenario();
		if ((CampaignFlags & 0x0001) == 0x0000)
			CampaignFlags |= 0x0002;
		if (CampaignMenuRequested != FALSE)
			return FALSE;
		if ((CampaignFlags & 0x0002) != 0x0000)
		{
			PlayMusicResource(0x0047);
			PresentScreenAndMessage(0x000C, 0x0080);
			return FALSE;
		}
		PlayMusicResource(0x004D);
		PresentScreenAndMessage(0x000A, 0x0081);
		ShowScenarioMessage(0x0082);
	}

	PlayMusicResource(0x004B);
	DisplayMissionDate(0x0004, 0x0006, 0x000B, 0x0083, 0x0000);
	StopLoadedMusicTrack();
	if (SceneTransitionAbortFlag == FALSE)
		DeferredStage16Story = TRUE;
	PresentAnimatedScreenAndMessage(
		0x001F,
		ScenarioVariantIndex == 0x0000
			? 0x0085 : 0x0084);
	ShowStoryMessageAndWait(0x0086);
	PendingCampaignStageDelta = TRUE;
	return TRUE;
}

// 0D73:1A9D: int16 RunCampaignStage16(void)
// VERIFIED against 0D73:1A9D-1B79.
int16 RunCampaignStage16(void)
{
	ScenarioVariantIndex = 0x0000;
	StopLoadedMusicTrack();
	if (DeferredStage16Story != FALSE)
	{
		ShowStoryMessageAndWait(0x0087);
		DeferredStage16Story = FALSE;
	}
	else
		PresentAnimatedScreenAndMessage(0x001F, 0x0087);
	ShowStoryMessageAndWait(0x0088);
	RunLanceConfiguration(0x0000,
		ScenarioVariantIndex);
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004D);
		PresentAnimatedScreenAndMessage(0x001C, 0x008E);
		ScenarioVariantIndex = 0x0000;
	}
	else if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x008C);
		return FALSE;
	}
	else
	{
		PlayMusicResource(0x0046);
		PresentAnimatedScreenAndMessage(0x001C, 0x008D);
		ScenarioVariantIndex = 0x0001;
	}
	PendingCampaignStageDelta = TRUE;
	return TRUE;
}

// 0D73:1B7A: int16 RunCampaignStage17(void)
// VERIFIED against 0D73:1B7A-1C5A.
int16 RunCampaignStage17(void)
{
	word16 scenarioVariant;

	StopLoadedMusicTrack();
	scenarioVariant = ScenarioVariantIndex;
	if (scenarioVariant == 0x0000)
	{
		RunLanceConfiguration(0x0001, scenarioVariant);
		InitializeTacticalScenario();
	}
	else
	{
		RunLanceConfiguration(0x0001, scenarioVariant);
		ScenarioVariantIndex = 0x0000;
		InitializeTacticalScenario();
		ScenarioVariantIndex = 0x0001;
	}

	if (CampaignMenuRequested != FALSE)
		return FALSE;
	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004D);
		PresentScreenAndMessage(0x0006, 0x0091);
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}

	PlayMusicResource(0x0047);
	PresentScreenAndMessage(
		0x000C,
		ScenarioVariantIndex == 0x0000
			? 0x0090 : 0x0093);
	return FALSE;
}

// 0D73:1C5B: int16 RunCampaignStage18(void)
// VERIFIED against 0D73:1C5B-1D17.
int16 RunCampaignStage18(void)
{
	ScenarioVariantIndex = 0x0000;
	StopLoadedMusicTrack();
	RunLanceConfiguration(0x0003,
		ScenarioVariantIndex);
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		if ((CampaignFlags & 0x0100) != 0x0000)
		{
			HideMouseCursorOverlay();
			ClearActiveVideoBuffer();
			ShowMouseCursorOverlay();
			ScenarioVariantIndex = 0x0001;
		}
		else
		{
			PlayMusicResource(0x004A);
			PresentAnimatedScreenAndMessage(0x001C, 0x0097);
			ScenarioVariantIndex = 0x0000;
		}
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x0095);
	}
	else
	{
		PlayMusicResource(0x004A);
		PresentScreenAndMessage(0x0006, 0x0096);
	}
	return FALSE;
}

// 0D73:1D18: int16 RunCampaignStage19(void)
// VERIFIED against 0D73:1D18-1DAC.
int16 RunCampaignStage19(void)
{
	StopLoadedMusicTrack();
	RunLanceConfiguration(0x0004,
		ScenarioVariantIndex);
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004E);
		PresentAnimatedScreenAndMessage(0x001C, 0x009B);
		ScenarioVariantIndex = 0x0000;
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x0099);
	}
	else
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x009A);
	}
	return FALSE;
}

// 0D73:1DAD: int16 RunCampaignStage20(void)
// VERIFIED against 0D73:1DAD-2021.
int16 RunCampaignStage20(void)
{
	word16 savedDismissTimeout;

	StopLoadedMusicTrack();
	RunLanceConfiguration(0x0006,
		ScenarioVariantIndex);
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x009D);
		return FALSE;
	}
	if ((CampaignFlags & 0x0001) == 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x009E);
		return FALSE;
	}

	PlayMusicResource(0x004D);
	LoadGraphicsResourceToBuffers(
		0x0013,
		SecondaryScreenBuffer,
		PrimaryScreenBuffer);
	BuildMissionSpriteBackingBuffer(0x000B);
	savedDismissTimeout = PresentationDismissTimeout;
	PresentationDismissTimeout = 0x0000;
	PresentScreenAndMessage(0x0012, 0x0000);
	HideMouseCursorOverlay();
	DrawClippedSprite(
		ActiveRenderTarget,
		MissionSpriteBacking,
		0x00C0,
		0x0079,
		0x0000);
	ShowMouseCursorOverlay();
	FreeGraphicsBufferRange(0x0011, 0x0011);
	PresentationDismissTimeout = savedDismissTimeout;
	WaitForDismissInputOrTimeout(PresentationDismissTimeout);
	ShowScenarioMessage(0x009F);
	ShowScenarioMessage(0x00A0);
	ShowScenarioMessage(0x00A1);
	ShowScenarioMessage(0x00A2);
	ShowScenarioMessage(0x00A3);
	PlayMusicResource(0x004F);
	PresentScreenAndMessage(0x0005, 0x00A4);
	ShowScenarioMessage(0x00A5);
	UpdatePilotAvailability();

	PrepareActivePilotList();
	PresentationCallbackOffset = 0x214B;
		PresentationCallback = RenderActivePilotList;
	PresentationCallbackSegment = 0x0D73;
	ShowScenarioMessage(0x00A6);
	PresentationCallbackOffset = 0x0000;
		PresentationCallback = NULL;
	PresentationCallbackSegment = 0x0000;
	ShowScenarioMessage(0x00A7);

	PrepareSurvivingCommanderList();
	PresentationCallbackOffset = 0x223D;
		PresentationCallback = RenderSurvivingCommanderList;
	PresentationCallbackSegment = 0x0D73;
	ShowScenarioMessage(0x00A8);
	PresentationCallbackOffset = 0x0000;
		PresentationCallback = NULL;
	PresentationCallbackSegment = 0x0000;
	if (HasFallenPilots() != FALSE)
	{
		ShowScenarioMessage(0x00A9);
		PrepareFallenPilotList();
		PresentationCallbackOffset = 0x2361;
		PresentationCallback = RenderFallenPilotList;
		PresentationCallbackSegment = 0x0D73;
		ShowScenarioMessage(0x00AA);
		PresentationCallbackOffset = 0x0000;
		PresentationCallback = NULL;
		PresentationCallbackSegment = 0x0000;
	}

	ShowScenarioMessage(0x00AB);
	PresentStoryScreenAndMessage(0x001F, 0x00AC);
	ShowStoryMessage(0x00AD);
	ShowStoryMessage(0x00AE);
	ShowStoryMessage(0x00AF);
	PresentScreenAndMessage(0x0006, 0x00B0);
	ShowScenarioMessage(0x00B1);
	SaveTransferState = 0x8000;
	SavedSaveTransferState = SaveTransferState;
	ReadSaveSlot(0x0044, 0x0000);
	WriteSaveSlot(0x0044, 0x0000);
	PendingCampaignStageDelta = TRUE;
	return TRUE;
}

// 0D73:2022: int16 RunCampaignStage21(void)
// VERIFIED against 0D73:2022-2100.
int16 RunCampaignStage21(void)
{
	word16 unitIndex;
	int16 stageRunning;

	SuppressPostStageMenu = TRUE;
	StopLoadedMusicTrack();
	for (unitIndex = 0x0000; unitIndex < 0x0018; ++unitIndex)
	{
		if (TrainingSequenceFlag == FALSE)
		{
			LiveScenarioUnits[unitIndex] = BlankUnitRecord;
		}
		if (LiveScenarioUnits[unitIndex].tonnage == 0x00)
		{
			LiveScenarioUnits[unitIndex].unitTypeId = REVENGE_UNIT_TYPE_NONE;
		}
	}

	stageRunning = PrepareTrainingDeployment();
	if (stageRunning != FALSE)
	{
		for (unitIndex = 0x0000; unitIndex < 0x000C; ++unitIndex)
		{
			LiveScenarioUnits[unitIndex].pilotId = 0x3A;
			LiveScenarioUnits[unitIndex].gunneryTargetNumber =
				PilotRoster[0x3A].gunneryIndex;
			LiveScenarioUnits[unitIndex].pilotExperience =
				PilotRoster[0x3A].experienceIndex;
		}
		InitializeTacticalScenario();
		stageRunning = TRUE;
	}
	else
		stageRunning = FALSE;

	TrainingSequenceFlag = TRUE;
	HideMouseCursorOverlay();
	ClearActiveVideoBuffer();
	ShowMouseCursorOverlay();
	return stageRunning;
}


