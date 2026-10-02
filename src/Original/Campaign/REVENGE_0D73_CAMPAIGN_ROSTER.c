// REVENGE_0D73_CAMPAIGN_ROSTER.c
// Procedures reconstructed from REVENGE.EXE segment 0D73.

#include "REVENGE_0D73_CAMPAIGN_INTERNAL.h"

// 0D73:2101: byte PrepareActivePilotList(void)
// VERIFIED against 0D73:2101-214A.
byte PrepareActivePilotList(void)
{
	word16 pilotSlot;
	word16 lineCount;
	word16 windowHeight;

	lineCount = 0x0003;
	for (pilotSlot = 0x0000; pilotSlot < 0x0025; ++pilotSlot)
	{
		if (PilotRoster[pilotSlot].availability == 0x01)
		{
			++lineCount;
		}
	}
	windowHeight = (word16)
		((ActiveFontLineHeight * lineCount +
		0x0007) >> 0x03);
	ActivePilotListWindowHeight = (byte) windowHeight;
	return (byte) windowHeight;
}

// 0D73:214B: void RenderActivePilotList(void)
// VERIFIED against 0D73:214B-21A4.
void RenderActivePilotList(void)
{
	word16 pilotSlot;

	HideMouseCursorOverlay();
	RenderFormattedText(PilotRosterHeadingText);
	ShowMouseCursorOverlay();
	for (pilotSlot = 0x0000; pilotSlot < 0x0025; ++pilotSlot)
	{
		if (PilotRoster[pilotSlot].availability == 0x01)
		{
			RenderPilotName(
				PilotRoster[pilotSlot].identityId);
		}
	}
	WaitForDismissInput();
}

// 0D73:21A5: byte PrepareSurvivingCommanderList(void)
// VERIFIED against 0D73:21A5-223C.
byte PrepareSurvivingCommanderList(void)
{
	word16 firstUnitIndex;
	word16 unitSlot;
	word16 lineCount;
	word16 windowHeight;

	lineCount = 0x0003;
	for (firstUnitIndex = 0x0000;
		firstUnitIndex < 0x000C;
		firstUnitIndex += 0x0004)
	{
		for (unitSlot = 0x0000; unitSlot < 0x0004; ++unitSlot)
		{
			RevengeUnitRecord *unitRecord = firstUnitIndex < 0x0008
				? &PersistentUnitRoster[firstUnitIndex + unitSlot]
				: &LiveScenarioUnits[firstUnitIndex + unitSlot];
			if (unitRecord->tonnage != 0x00 &&
				unitRecord->deploymentState != 0x00)
			{
				++lineCount;
				break;
			}
		}
	}
	windowHeight = (word16)
		((ActiveFontLineHeight * lineCount +
		0x0007) >> 0x03);
	CommanderListWindowHeight = (byte) windowHeight;
	return (byte) windowHeight;
}

// 0D73:223D: void RenderSurvivingCommanderList(void)
// VERIFIED against 0D73:223D-22E7.
void RenderSurvivingCommanderList(void)
{
	word16 firstUnitIndex;
	word16 unitSlot;

	HideMouseCursorOverlay();
	RenderFormattedText(PilotRosterHeadingText);
	ShowMouseCursorOverlay();
	for (firstUnitIndex = 0x0000;
		firstUnitIndex < 0x000C;
		firstUnitIndex += 0x0004)
	{
		for (unitSlot = 0x0000; unitSlot < 0x0004; ++unitSlot)
		{
			RevengeUnitRecord *unitRecord = firstUnitIndex < 0x0008
				? &PersistentUnitRoster[firstUnitIndex + unitSlot]
				: &LiveScenarioUnits[firstUnitIndex + unitSlot];
			if (unitRecord->tonnage != 0x00 &&
				unitRecord->deploymentState != 0x00)
			{
				RenderPilotName(unitRecord->pilotId);
				break;
			}
		}
	}
	WaitForDismissInput();
}

// 0D73:22E8: word16 HasFallenPilots(void)
// VERIFIED against 0D73:22E8-2316.
word16 HasFallenPilots(void)
{
	word16 pilotSlot;

	for (pilotSlot = 0x0000; pilotSlot < 0x0025; ++pilotSlot)
	{
		if (PilotRoster[pilotSlot].availability == 0xFF)
		{
			return TRUE;
		}
	}
	return FALSE;
}

// 0D73:2317: byte PrepareFallenPilotList(void)
// VERIFIED against 0D73:2317-2360.
byte PrepareFallenPilotList(void)
{
	word16 pilotSlot;
	word16 lineCount;
	word16 windowHeight;

	lineCount = 0x0002;
	for (pilotSlot = 0x0000; pilotSlot < 0x0025; ++pilotSlot)
	{
		if (PilotRoster[pilotSlot].availability == 0xFF)
		{
			++lineCount;
		}
	}
	windowHeight = (word16)
		((ActiveFontLineHeight * lineCount +
		0x0007) >> 0x03);
	FallenPilotListWindowHeight = (byte) windowHeight;
	return (byte) windowHeight;
}

// 0D73:2361: void RenderFallenPilotList(void)
// VERIFIED against 0D73:2361-23BA.
void RenderFallenPilotList(void)
{
	word16 pilotSlot;

	HideMouseCursorOverlay();
	RenderFormattedText(PilotRosterHeadingText);
	ShowMouseCursorOverlay();
	for (pilotSlot = 0x0000; pilotSlot < 0x0025; ++pilotSlot)
	{
		if (PilotRoster[pilotSlot].availability == 0xFF)
		{
			RenderPilotName(
				PilotRoster[pilotSlot].identityId);
		}
	}
	WaitForDismissInput();
}

// 0D73:23BB: void RenderPilotName(RevengePilotId pilotId)
// VERIFIED against 0D73:23BB-2413.
void RenderPilotName(RevengePilotId pilotId)
{
	HideMouseCursorOverlay();
	RenderFormattedText(PilotIdentityPrefixText);
	RenderFormattedText(PilotGivenNameTextTable[pilotId]);
	RenderFormattedText(PilotNamePrefixText);
	RenderFormattedText(PilotSurnameTextTable[pilotId]);
	ShowMouseCursorOverlay();
}
