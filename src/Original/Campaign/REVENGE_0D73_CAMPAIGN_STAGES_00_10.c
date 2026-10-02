// REVENGE_0D73_CAMPAIGN_DRIVER.c
// Procedures reconstructed from REVENGE.EXE segment 0D73.

#include "REVENGE_0D73_CAMPAIGN_INTERNAL.h"
#include "revenge/debug.h"

// 0D73:0448: int16 RunCampaignStage00(void)
// First campaign-stage handler selected through DS:24F4.
// VERIFIED [SDL] against ASM 0D73:0448-0632. SDLBackend_ServiceTimers
// cooperatively supplies the asynchronous IRQ0 progress of the DOS waits.
int16 RunCampaignStage00(void)
{
	word16 savedDismissTimeout;
	REVENGE_PRESERVATION_TRACE("stage00: mission date 0\n");

	DisplayMissionDate(0x0000, 0x0000, 0x0000, 0x0001, 0x0000);
	if (AlternateLanceSelection == FALSE)
		PrepareLanceSelection(0x0000, 0x0001);
	else
		PrepareLanceSelection(0x0000, -0x0001);
	REVENGE_PRESERVATION_TRACE("stage00: initial lance selection returned abort=%u\n",
		SceneTransitionAbortFlag);
	AlternateLanceSelection = FALSE;
	DisplayMissionDate(0x0000, 0x0001, 0x0001, 0x0000, 0x0000);
	REVENGE_PRESERVATION_TRACE("stage00: opening presentation\n");

	StopLoadedMusicTrack();
	LoadDigitalWeaponEffectBank();
	REVENGE_PRESERVATION_TRACE("stage00: leopard approach screen/message 4/2\n");
	PresentScreenAndMessage(0x0004, 0x0002);
	REVENGE_PRESERVATION_TRACE("stage00: leopard attack message 3\n");
	ShowScenarioMessage(0x0003);
	if (SceneTransitionAbortFlag == FALSE)
	{
		DispatchWeaponEffect(0x0009);
		while (DigitalSoundBusy != FALSE)
			SDLBackend_ServiceTimers();
		DispatchWeaponEffect(0x0002);
		while (DigitalSoundBusy != FALSE)
			SDLBackend_ServiceTimers();
		DispatchWeaponEffect(0x000F);
		while (DigitalSoundBusy != FALSE)
			SDLBackend_ServiceTimers();
	}

	savedDismissTimeout = PresentationDismissTimeout;
	PresentationDismissTimeout = 0x0000;
	REVENGE_PRESERVATION_TRACE("stage00: attacked leopard screen 3\n");
	PresentScreenAndMessage(0x0003, 0x0000);
	PresentationDismissTimeout = savedDismissTimeout;
	if (SceneTransitionAbortFlag == FALSE)
	{
		DispatchWeaponEffect(0x0009);
		while (DigitalSoundBusy != FALSE)
			SDLBackend_ServiceTimers();
		DispatchWeaponEffect(0x000A);
		while (DigitalSoundBusy != FALSE)
			SDLBackend_ServiceTimers();
		DispatchWeaponEffect(0x0004);
		while (DigitalSoundBusy != FALSE)
			SDLBackend_ServiceTimers();
		WaitForDismissInputOrTimeout(savedDismissTimeout);
	}
	REVENGE_PRESERVATION_TRACE("stage00: leopard damage message 4\n");
	ShowScenarioMessage(0x0004);
	ReleaseDigitalWeaponEffectBank();

	PlayMusicResource(0x0047);
	REVENGE_PRESERVATION_TRACE("stage00: Jenner scene/message 13/5\n");
	PresentCampaignScene(0x000D, 0x0001, 0x0005);
	REVENGE_PRESERVATION_TRACE("stage00: Jenner followup message 6\n");
	ShowCampaignMessageAndWait(0x0006);
	PlayMusicResource(0x0049);
	REVENGE_PRESERVATION_TRACE("stage00: pre-tactical scene/message 13/7\n");
	PresentCampaignScene(0x000D, 0x0000, 0x0007);
	REVENGE_PRESERVATION_TRACE("stage00: pre-tactical followup message 8\n");
	ShowCampaignMessageAndWait(0x0008);
	REVENGE_PRESERVATION_TRACE("stage00: initialize tactical scenario\n");
	InitializeTacticalScenario();
	REVENGE_PRESERVATION_TRACE("stage00: tactical returned flags=%04X menu=%u\n",
		CampaignFlags, CampaignMenuRequested);
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004E);
		PresentScreenAndMessage(0x0006, 0x000B);
		PendingCampaignStageDelta = TRUE;
		PendingCampaignPhaseDelta = TRUE;
		return TRUE;
	}

	PlayMusicResource(0x0046);
	PresentScreenAndMessage(0x000C, 0x0009);
	ShowScenarioMessage(0x000A);
	return FALSE;
}

// 0D73:0633: int16 RunCampaignStage01(void)
// VERIFIED against 0D73:0633-0719.
int16 RunCampaignStage01(void)
{
	if (ScenarioUnitZeroAvailable != 0x0000)
		ScenarioUnitZeroAvailable = 0x0001;

	PlayMusicResource(0x004A);
	PresentMissionBriefing(0x000B, 0x0001, 0x000C);
	ShowCampaignMessageAndWait(0x000D);
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		if ((CampaignFlags & 0x0008) != 0x0000)
			PresentScreenAndMessage(0x0006, 0x000F);
		PresentAnimatedScreenAndMessage(0x0020, 0x0011);
		PendingCampaignStageDelta = TRUE;
		PendingCampaignPhaseDelta = TRUE;
		return TRUE;
	}

	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x000E);
		return FALSE;
	}

	if ((CampaignFlags & 0x0008) != 0x0000)
		PresentScreenAndMessage(0x0006, 0x000F);
	PresentAnimatedScreenAndMessage(0x0020, 0x0010);
	PendingCampaignStageDelta = TRUE;
	if (ScenarioUnitZeroAvailable != 0x0000)
		ScenarioUnitZeroAvailable = 0x0002;
	return TRUE;
}

// 0D73:071A: int16 RunCampaignStage02(void)
// VERIFIED against 0D73:071A-07F8.
int16 RunCampaignStage02(void)
{
	StopLoadedMusicTrack();
	PresentAnimatedScreenAndMessage(0x0021, 0x0012);
	ShowStoryMessageAndWait(0x0013);
	InitializeTacticalScenario();

	if ((CampaignFlags & 0x2000) == 0x0000 &&
		PersistentUnitRoster[0x01].deploymentState == 0x00)
	{
		CampaignFlags |= 0x0008;
	}
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004A);
		PresentAnimatedScreenAndMessage(0x0020, 0x0015);
		ShowStoryMessageAndWait(0x0016);
		if ((CampaignFlags & 0x0020) != 0x0000)
		{
			if ((CampaignFlags & 0x2008) != 0x0000)
				ShowStoryMessageAndWait(0x0017);
			else
				ShowStoryMessageAndWait(0x0018);
		}
		else
		{
			ShowStoryMessageAndWait(0x0019);
		}
		PendingCampaignStageDelta = TRUE;
		PendingCampaignPhaseDelta = TRUE;
		return TRUE;
	}

	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x0014);
	}
	return FALSE;
}

// 0D73:07F9: int16 RunCampaignStage03(void)
// VERIFIED against 0D73:07F9-0882.
int16 RunCampaignStage03(void)
{
	CampaignScenarioState = 0x0000;
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x001A);
		return FALSE;
	}
	if ((CampaignFlags & 0x0080) == 0x0000)
	{
		PlayMusicResource(0x004E);
		PresentAnimatedScreenAndMessage(0x0020, 0x001C);
		PendingCampaignStageDelta = TRUE;
		PendingCampaignPhaseDelta = TRUE;
		return TRUE;
	}

	PresentAnimatedScreenAndMessage(0x0020, 0x001B);
	CampaignScenarioState = 0x0001;
	PendingCampaignStageDelta = TRUE;
	return TRUE;
}

// 0D73:0883: int16 RunCampaignStage04(void)
// VERIFIED against 0D73:0883-092D.
int16 RunCampaignStage04(void)
{
	LrmShipmentLoaded = 0x0000;
	SrmShipmentLoaded = 0x0000;
	PlayMusicResource(0x0049);
	PresentScreenAndMessage(0x0008, 0x001D);
	ShowScenarioMessage(0x001E);
	ShowScenarioMessage(0x001F);
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		PlayMusicResource(0x004E);
		PresentScreenAndMessage(0x0006, 0x0022);
		PendingCampaignStageDelta = TRUE;
		PendingCampaignPhaseDelta = TRUE;
		return TRUE;
	}

	PlayMusicResource(0x0047);
	if ((CampaignFlags & 0x0004) != 0x0000)
		PresentScreenAndMessage(0x000C, 0x0020);
	else
		PresentScreenAndMessage(0x000C, 0x0021);
	return FALSE;
}

// 0D73:092E: int16 RunCampaignStage05(void)
// VERIFIED against 0D73:092E-0B14.
int16 RunCampaignStage05(void)
{
	StopLoadedMusicTrack();
	PresentMissionBriefing(0x000B, 0x0002, 0x0023);
	ShowCampaignMessageAndWait(0x0024);
	PlayMusicResource(0x004A);
	PresentScreenAndMessage(0x0009, 0x0025);
	ShowScenarioMessage(0x0026);
	if ((SavedCampaignFlags & 0x1000) != 0x0000)
		ShowScenarioMessage(0x0028);
	else if ((SavedCampaignFlags & 0x0800) != 0x0000)
		ShowScenarioMessage(0x0027);
	ShowScenarioMessage(0x0029);

	if (ReplayScenarioRequested == FALSE)
		ScenarioVariantIndex = SelectScenarioVariant(0x0000);
	PlayMusicResource(0x0048);

	if (ScenarioVariantIndex == 0x0000)
	{
		PresentStoryScreenAndMessage(0x0022, 0x002A);
		InitializeTacticalScenario();
		if (CampaignMenuRequested != FALSE)
			return FALSE;
		if ((CampaignFlags & 0x0001) == 0x0000)
		{
			PlayMusicResource(0x0047);
			PresentScreenAndMessage(0x000C, 0x002B);
			return FALSE;
		}
		if ((CampaignFlags & 0x0008) != 0x0000)
			PresentScreenAndMessage(0x0006, 0x002C);
		if ((CampaignFlags & 0x0040) != 0x0000)
			PresentAnimatedScreenAndMessage(0x0020, 0x002D);
		PlayMusicResource(0x004B);
		PresentAnimatedScreenAndMessage(0x0021, 0x0033);
	}
	else
	{
		PresentStoryScreenAndMessage(0x0022, 0x002E);
		ShowStoryMessage(0x002F);
		InitializeTacticalScenario();
		if (CampaignMenuRequested != FALSE)
			return FALSE;
		if ((CampaignFlags & 0x0001) == 0x0000)
		{
			PlayMusicResource(0x0047);
			PresentScreenAndMessage(0x000C, 0x0030);
			return FALSE;
		}
		if ((CampaignFlags & 0x0010) != 0x0000)
			PresentScreenAndMessage(0x0006, 0x0031);
		if ((CampaignFlags & 0x0040) != 0x0000)
			PresentAnimatedScreenAndMessage(0x0021, 0x0032);
		PlayMusicResource(0x004B);
		PresentScreenAndMessage(0x0006, 0x0035);
		ShowScenarioMessage(0x0036);
	}

	PendingCampaignStageDelta = TRUE;
	PendingCampaignPhaseDelta = TRUE;
	return TRUE;
}

// 0D73:0B15: int16 RunCampaignStage06(void)
// VERIFIED against 0D73:0B15-0BC7.
int16 RunCampaignStage06(void)
{
	word16 scenarioVariant;

	scenarioVariant = ScenarioVariantIndex;
	InitializeTacticalScenario();
	if (CampaignMenuRequested == FALSE &&
		(CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C,
			scenarioVariant == 0x0000
				? 0x0034 : 0x0037);
	}
	if (CampaignMenuRequested != FALSE ||
		(CampaignFlags & 0x0002) != 0x0000)
	{
		return FALSE;
	}

	PlayMusicResource(0x004C);
	PresentAnimatedScreenAndMessage(0x001B, 0x0038);
	ShowStoryMessageAndWait(0x0039);
	ShowStoryMessageAndWait(0x003A);
	PendingCampaignStageDelta = TRUE;
	PendingCampaignPhaseDelta = TRUE;
	return TRUE;
}

// 0D73:0BC8: int16 RunCampaignStage07(void)
// VERIFIED against 0D73:0BC8-0C2A.
int16 RunCampaignStage07(void)
{
	ScenarioVariantIndex = 0x0000;
	InitializeTacticalScenario();
	if (CampaignMenuRequested != FALSE)
		return FALSE;
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x003B);
		return FALSE;
	}

	PresentAnimatedScreenAndMessage(0x001B, 0x003C);
	ShowStoryMessageAndWait(0x003D);
	PendingCampaignStageDelta = TRUE;
	PendingCampaignPhaseDelta = TRUE;
	return TRUE;
}

// 0D73:0C2B: int16 RunCampaignStage08(void)
// VERIFIED against 0D73:0C2B-1098.
int16 RunCampaignStage08(void)
{
	word16 unitIndex;

	PlayMusicResource(0x004E);
	PresentScreenAndMessage(0x0001, 0x003E);
	StopLoadedMusicTrack();
	PresentMissionBriefing(0x000B, 0x0002, 0x003F);
	ShowCampaignMessageAndWait(0x0040);
	ShowCampaignMessageAndWait(0x0041);
	ShowCampaignMessageAndWait(0x0042);
	ShowCampaignMessageAndWait(0x0043);

	for (unitIndex = 0x0000; unitIndex < 0x000C; ++unitIndex)
		LiveScenarioUnits[unitIndex] = BlankUnitRecord;

	if (CampaignPhase == 0x08)
	{
		if (ReplayScenarioRequested == FALSE)
		{
			PresentationCallbackOffset = 0x249E;
		PresentationCallback = RunCampaignPathSelectionCallback;
			PresentationCallbackSegment = 0x0D73;
			ShowCampaignMessageAndWait(0x0044);
			PresentationCallbackOffset = 0x0000;
		PresentationCallback = NULL;
			PresentationCallbackSegment = 0x0000;
		}
		if (CampaignRestartState == FALSE)
		{
			LoadUnitTemplateRecord(UNIT_TYPE_ROMMEL_TANK);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x00] = EstimatedUnitRecord;
			LiveScenarioUnits[0x01] = EstimatedUnitRecord;
			LiveScenarioUnits[0x02] = EstimatedUnitRecord;
			LoadUnitTemplateRecord(UNIT_TYPE_PEGASUS);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x03] = EstimatedUnitRecord;
			LoadUnitTemplateRecord(UNIT_TYPE_SKULKER);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x09] = EstimatedUnitRecord;
			LiveScenarioUnits[0x0A] = EstimatedUnitRecord;
			LiveScenarioUnits[0x0B] = EstimatedUnitRecord;
			LoadUnitTemplateRecord(UNIT_TYPE_APC);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x08] = EstimatedUnitRecord;
		}
		else
		{
			LoadUnitTemplateRecord(UNIT_TYPE_ROMMEL_TANK);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x00] = EstimatedUnitRecord;
			LiveScenarioUnits[0x01] = EstimatedUnitRecord;
			LoadUnitTemplateRecord(UNIT_TYPE_PEGASUS);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x02] = EstimatedUnitRecord;
			LiveScenarioUnits[0x03] = EstimatedUnitRecord;
			LiveScenarioUnits[0x04] = EstimatedUnitRecord;
			LiveScenarioUnits[0x05] = EstimatedUnitRecord;
			LiveScenarioUnits[0x06] = EstimatedUnitRecord;
			LiveScenarioUnits[0x07] = EstimatedUnitRecord;
			LoadUnitTemplateRecord(UNIT_TYPE_SKULKER);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x09] = EstimatedUnitRecord;
			LoadUnitTemplateRecord(UNIT_TYPE_PEGASUS);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x0A] = EstimatedUnitRecord;
			LiveScenarioUnits[0x0B] = EstimatedUnitRecord;
			LoadUnitTemplateRecord(UNIT_TYPE_APC);
			EstimatedUnitRecord.deploymentState = TRUE;
			LiveScenarioUnits[0x08] = EstimatedUnitRecord;
		}
	}
	else
	{
		LoadUnitTemplateRecord(UNIT_TYPE_ROMMEL_TANK);
		EstimatedUnitRecord.deploymentState = TRUE;
		LiveScenarioUnits[0x00] = EstimatedUnitRecord;
		LiveScenarioUnits[0x01] = EstimatedUnitRecord;
		LoadUnitTemplateRecord(UNIT_TYPE_PEGASUS);
		EstimatedUnitRecord.deploymentState = TRUE;
		LiveScenarioUnits[0x02] = EstimatedUnitRecord;
		LiveScenarioUnits[0x03] = EstimatedUnitRecord;
		LiveScenarioUnits[0x0A] = EstimatedUnitRecord;
		LiveScenarioUnits[0x0B] = EstimatedUnitRecord;
		LoadUnitTemplateRecord(UNIT_TYPE_APC);
		EstimatedUnitRecord.deploymentState = TRUE;
		LiveScenarioUnits[0x08] = EstimatedUnitRecord;
	}

	PlayMusicResource(0x004D);
	DisplayMissionDate(0x0000, 0x0002, 0x0002, 0x0045, 0x0000);
	ShowMissionFollowupMessage(0x0046);
	PlayMusicResource(0x0049);
	PresentStoryScreenAndMessage(0x0022, 0x0047);
	if (ReplayScenarioRequested == FALSE)
		ScenarioVariantIndex = SelectScenarioVariant(0x0001);
	InitializeTacticalScenario();
	if (PersistentUnitRoster[0x08].deploymentState == FALSE)
		CampaignFlags |= 0x0080;
	if ((CampaignFlags & 0x00C0) != 0x0000)
		CampaignFlags &= 0xFFFE;
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		HideMouseCursorOverlay();
		ClearActiveVideoBuffer();
		ShowMouseCursorOverlay();
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x0048);
	}
	else if ((CampaignFlags & 0x0040) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x0049);
	}
	else if ((CampaignFlags & 0x0080) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x004D);
	}
	return FALSE;
}

// 0D73:1099: int16 RunCampaignStage09(void)
// VERIFIED against 0D73:1099-1211.
int16 RunCampaignStage09(void)
{
	word16 unitIndex;

	ScenarioVariantIndex = 0x0000;
	StopLoadedMusicTrack();
	PresentStoryScreenAndMessage(0x0022, 0x004A);
	InitializeTacticalScenario();
	if (PersistentUnitRoster[0x08].deploymentState == FALSE)
		CampaignFlags |= 0x0080;
	if ((CampaignFlags & 0x00C0) != 0x0000)
		CampaignFlags &= 0xFFFE;
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		if ((CampaignFlags & 0x4000) != 0x0000)
		{
			LoadUnitTemplateRecord(0x0025);
			EstimatedUnitRecord.deploymentState = TRUE;
			for (unitIndex = 0x0000; unitIndex < 0x0004; ++unitIndex)
			{
				PersistentUnitRoster[unitIndex] = EstimatedUnitRecord;
				LanceAssignments[unitIndex].pilotId =
					(RevengePilotId)unitIndex;
				AssignPilotRosterEntryToUnit(unitIndex, unitIndex);
			}
			PresentScreenAndMessage(0x0006, 0x004E);
		}
		else
		{
			HideMouseCursorOverlay();
			ClearActiveVideoBuffer();
			ShowMouseCursorOverlay();
		}
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C, 0x004B);
	}
	else if ((CampaignFlags & 0x0040) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x004C);
	}
	else if ((CampaignFlags & 0x0080) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x004D);
	}
	return FALSE;
}

// Apply the repeated post-battle condition used by campaign stages 08h-0Ch.
// This is kept inline in each original procedure below; no game procedure is
// introduced for it.

// 0D73:1212: int16 RunCampaignStage10(void)
// VERIFIED against 0D73:1212-1301.
int16 RunCampaignStage10(void)
{
	StopLoadedMusicTrack();
	PresentStoryScreenAndMessage(0x0022, 0x004F);
	InitializeTacticalScenario();
	if (PersistentUnitRoster[0x08].deploymentState == 0x00)
		CampaignFlags |= 0x0080;
	if ((CampaignFlags & 0x00C0) != 0x0000)
		CampaignFlags &= 0xFFFE;
	if (CampaignMenuRequested != FALSE)
		return FALSE;

	if ((CampaignFlags & 0x0001) != 0x0000)
	{
		HideMouseCursorOverlay();
		ClearActiveVideoBuffer();
		ShowMouseCursorOverlay();
		PendingCampaignStageDelta = TRUE;
		return TRUE;
	}
	if ((CampaignFlags & 0x0002) != 0x0000)
	{
		PlayMusicResource(0x0047);
		PresentScreenAndMessage(0x000C,
			(CampaignFlags & 0x0004) != 0x0000
				? 0x0051 : 0x0050);
	}
	else if ((CampaignFlags & 0x0040) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x0052);
	}
	else if ((CampaignFlags & 0x0080) != 0x0000)
	{
		PlayMusicResource(0x0046);
		PresentScreenAndMessage(0x0006, 0x004D);
	}
	return FALSE;
}

