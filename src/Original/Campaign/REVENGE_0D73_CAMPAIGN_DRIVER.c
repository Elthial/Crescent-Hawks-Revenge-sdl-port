// REVENGE_0D73_CAMPAIGN_DRIVER.c
// Procedures reconstructed from REVENGE.EXE segment 0D73.

#include "REVENGE_0D73_CAMPAIGN_INTERNAL.h"
#include "revenge/debug.h"

void (*PresentationCallback)(void);

static const CampaignStageHandler CampaignStageHandlers[0x16] =
{
	RunCampaignStage00, RunCampaignStage01,
	RunCampaignStage02, RunCampaignStage03,
	RunCampaignStage04, RunCampaignStage05,
	RunCampaignStage06, RunCampaignStage07,
	RunCampaignStage08, RunCampaignStage09,
	RunCampaignStage10, RunCampaignStage11,
	RunCampaignStage12, RunCampaignStage13,
	RunCampaignStage14, RunCampaignStage15,
	RunCampaignStage16, RunCampaignStage17,
	RunCampaignStage18, RunCampaignStage19,
	RunCampaignStage20, RunCampaignStage21
};

// 0D73:0006: void RunCampaignLoop(void)
// Called from:
//      main
// VERIFIED against 0D73:0006-0213.
void RunCampaignLoop(void)
{
	CampaignStageHandler stageHandlerEntry;
	byte *titleTileStrip;
	int16 campaignRunning;
	int16 stageResult;
	word16 stateIndex;

	if (MouseDriverInstalled != FALSE)
	{
		LoadGraphicsResourceToBuffers(
			0x0000,
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
		RebuildMouseCursorBackingBuffer();
		ConfigureMouseCursorOverlay(
			0x0000,
			0x0000,
			SharedGraphicsBackingBuffers[0x00]);
		if (InputDeviceType == FALSE)
			MouseInputDisabled = TRUE;
	}
	else
	{
		MouseInputDisabled = TRUE;
		InputDeviceType = FALSE;
	}

	SetActiveFontResource(Font6Resource);
	ShowMouseCursorOverlay();
	LoadScreenAssetToWorkBuffer(0x0000);
	if (VideoAdapterType == VIDEO_ADAPTER_EGA)
	{
		EGA_ConvertPackedScreenToPlanar(
			PrimaryScreenBuffer,
			EGA_OFFSCREEN_FRAMEBUFFER_SEGMENT);
	}
	titleTileStrip = CaptureVideoTileStrip(
		PrimaryScreenBuffer,
		0x0000,
		0x0000,
		0x0008);
	TacticalTileStrip = titleTileStrip;
	SceneTransitionAbortFlag = FALSE;
	campaignRunning = RunTitleAndMainMenu();
	REVENGE_PRESERVATION_TRACE("campaign: title returned running=%d stage=%u variant=%u\n",
		campaignRunning, CampaignStageIndex, ScenarioVariantIndex);
	ReplayCampaignStateRequested = FALSE;
	SceneTransitionAbortFlag = FALSE;
	ReplayScenarioRequested = FALSE;
	CampaignRestartState = FALSE;

	while (campaignRunning != FALSE)
	{
		CampaignMenuRequested = FALSE;
		ScenarioRosterPrepared = FALSE;
		PendingCampaignStageDelta = FALSE;
		PendingCampaignPhaseDelta = FALSE;
		AlternateLanceSelection = FALSE;
		SuppressPostStageMenu = FALSE;

		if (ReplayCampaignStateRequested == FALSE)
		{
			SavedCampaignFlags = CampaignFlags;
			for (stateIndex = 0x0000; stateIndex < 0x0007; ++stateIndex)
			{
				ForwardCampaignState[stateIndex] =
					ReplayCampaignState[stateIndex];
			}
			CampaignState1B8D = CampaignState1B8E;
			for (stateIndex = 0x0000; stateIndex < 0x000F; ++stateIndex)
			{
				ForwardExtendedCampaignState[stateIndex] =
					ReplayExtendedCampaignState[stateIndex];
			}
		}
		else
		{
			if (CampaignStageIndex == 0x0000 ||
				CampaignStageIndex == 0x000D)
			{
				AlternateLanceSelection = TRUE;
			}
			for (stateIndex = 0x0000; stateIndex < 0x0007; ++stateIndex)
			{
				ReplayCampaignState[stateIndex] =
					ForwardCampaignState[stateIndex];
			}
			CampaignState1B8E = CampaignState1B8D;
			for (stateIndex = 0x0000; stateIndex < 0x000F; ++stateIndex)
			{
				ReplayExtendedCampaignState[stateIndex] =
					ForwardExtendedCampaignState[stateIndex];
			}
		}

		ReplayCampaignStateRequested = FALSE;
		CampaignFlags = 0x0000;
		if ((SavedCampaignFlags & 0x0008) != 0x0000)
			CampaignFlags |= 0x2000;
		if (ReplayScenarioRequested != FALSE)
			SceneTransitionAbortFlag = TRUE;

		stageHandlerEntry = CampaignStageHandlers[
			CampaignStageIndex];
		REVENGE_PRESERVATION_TRACE("campaign: enter stage=%u phase=%u\n",
			CampaignStageIndex, CampaignPhase);
		stageResult = stageHandlerEntry();
		REVENGE_PRESERVATION_TRACE("campaign: leave stage=%u result=%d flags=%04X menu=%u videoFail=%u\n",
			CampaignStageIndex, stageResult, CampaignFlags,
			CampaignMenuRequested, VideoPathUnavailable);
		if (VideoPathUnavailable == FALSE)
		{
			campaignRunning = stageResult;
			if (stageResult < 0x0000)
				campaignRunning = FALSE;
			SceneTransitionAbortFlag = FALSE;
			if (CampaignMenuRequested != FALSE)
			{
				HideMouseCursorOverlay();
				ClearActiveVideoBuffer();
				ShowMouseCursorOverlay();
			}
			if (SuppressPostStageMenu == FALSE)
			{
				if (campaignRunning != FALSE)
				{
					do
						campaignRunning = RunInGameMenu(0x0000);
					while (campaignRunning == -0x0001);
				}
				else
				{
					do
						campaignRunning = RunInGameMenu(0x0004);
					while (campaignRunning == -0x0001);
				}
			}
		}
		else
			campaignRunning = FALSE;
	}
	REVENGE_PRESERVATION_TRACE("campaign: loop ended\n");
}

// 0D73:0214: void InitializeTacticalScenario(void)
// Verified [SDL] against 0D73:0214-0386. The final DOS INT 1Ch wait is
// serviced cooperatively by the hosted timer boundary.
void InitializeTacticalScenario(void)
{
	byte scenarioOrdinal;
	byte scenarioSuffix;
	byte campaignStateIndex;
	byte *tacticalIconBuffer;

	SetActiveFontResource(Font8Resource);

	scenarioOrdinal =
		ScenarioOrdinalBaseByCampaignStage[
			CampaignStageIndex]
		+ (byte) ScenarioVariantIndex;
	if (CampaignStageIndex == 0x08)
		scenarioOrdinal -= (byte) ScenarioVariantIndex;

	// [V] Ordinals 0..8 map to '1'..'9'; 9 and above map to 'A' onward.
	scenarioSuffix = scenarioOrdinal < 0x09
		? scenarioOrdinal + '1'
		: scenarioOrdinal + '8';
	ScenarioFileSuffix = scenarioSuffix;

	StopLoadedMusicTrack();
	ReleaseMusicDriverBuffer();
	tacticalIconBuffer = AddBytesToFarPointer(
		PrimaryScreenBuffer,
		0x00008000UL);
	PlanarScreenBuffer = tacticalIconBuffer;

	LoadDigitalWeaponEffectBank();
	LoadScenarioDigitalSoundBank(scenarioSuffix);
	HideMouseCursorOverlay();
	if (UseEgaTacticalFallback != FALSE)
	{
		VideoAdapterType = VIDEO_ADAPTER_EGA;
		RebuildTacticalVideoResources(VIDEO_ADAPTER_EGA, FALSE);
	}

	// [V] MECHSET1 is used by scenarios 1..E and T. Scenarios F..S use
	// MECHSET2. This is the exact branch at 0D73:02B4-02CC.
	TacticalMechSetFileName[0x07] =
		(scenarioSuffix < 'F' || scenarioSuffix == 'T') ? '1' : '2';

	for (campaignStateIndex = 0x00; campaignStateIndex < 0x07;
		++campaignStateIndex)
	{
		ForwardCampaignState[campaignStateIndex] =
			ReplayCampaignState[campaignStateIndex];
	}

	RunTacticalBattle(scenarioSuffix);
	ReleaseDigitalSoundBuffer();
	ReleaseDigitalWeaponEffectBank();
	HideMouseCursorOverlay();

	if (UseEgaTacticalFallback != FALSE)
	{
		VideoAdapterType = VIDEO_ADAPTER_VGA;
		RebuildTacticalVideoResources(VIDEO_ADAPTER_VGA, TRUE);
	}
	else
	{
		ClearActiveVideoBuffer();
		if (VideoPathUnavailable == FALSE)
			ShowScenarioCompletionStatus();
	}

	AllocateMusicStagingBuffer();
	if (VideoPathUnavailable == FALSE)
		ShowMouseCursorOverlay();
	else
		CampaignMenuRequested = TRUE;

	ReplayScenarioRequested = FALSE;
	SceneTransitionAbortFlag = FALSE;
	PlanarScreenBuffer = SecondaryScreenBuffer;
	SetActiveFontResource(Font6Resource);

	/* DOS decrements this word asynchronously from INT 1Ch. The host dispatches
	 * that same installed interrupt cooperatively at its SDL boundary. */
	while (TacticalUpdateDelayTicks != 0x00)
		SDLBackend_ServiceTimers();
}

/* 0D73:0387 is reconstructed in Graphics/REVENGE_0D73_TACTICAL_VIDEO.c. */

