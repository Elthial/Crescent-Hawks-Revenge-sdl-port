// REVENGE_2507_LANCE_CONFIGURATION.c
// Reconstructed from the original procedures in segment 2507.

#include "REVENGE_2507_LANCE_EDITOR_INTERNAL.h"

// 2507:1848: prepare and run the combined unit/pilot lance editor.
// VERIFIED against ASM 2507:1848-18AF.
void RunLanceConfiguration(
	word16 selectionFamily,
	word16 scenarioVariantIndex)
{
	if (ReplayScenarioRequested != FALSE)
		return;

	SceneTransitionAbortFlag = FALSE;
	LanceEditorFirstBriefingPending = 0x0001;
	LanceEditorBriefingPresented = 0x0000;
	SnapshotLateCampaignLanceUnits();
	PrepareLanceSelectionRecords(
		selectionFamily + 0x0003,
		0x0001,
		FALSE);
	PreparePilotSelectionRecords(
		selectionFamily,
		0x0001,
		FALSE);
	LanceEditorReloadGraphics = 0x0001;
	do
	{
		/* The editor returns nonzero while another pass is required. */
	} while (RunLanceConfigurationEditor(
		selectionFamily, scenarioVariantIndex) != FALSE);
	SceneTransitionAbortFlag = FALSE;
}

// 2507:18B0: run the four-section lance configuration menu.
// VERIFIED against ASM 2507:18B0-1EBD.
int16 RunLanceConfigurationEditor(
	word16 selectionFamily,
	word16 scenarioVariantIndex)
{
	word16 repeatEditor;
	word16 selectedSection;
	word16 previousSection;
	word16 selectionActivated;
	word16 highlightPhase;
	word16 sectionIndex;
	word16 mouseButtonState;
	word16 mouseButtonEvent;
	int16 mouseX;
	int16 mouseY;
	int16 leftX;
	int16 topY;
	int16 width;
	int16 heightMinusOne;
	int16 inputCode;
	word16 configurationIndex;
	const char *sectionLabel;
	byte *primaryFramebuffer;
	byte *displayBuffer;
	byte *sectionSprite;

	repeatEditor = TRUE;
	configurationIndex = selectionFamily + scenarioVariantIndex;
	primaryFramebuffer = VideoFramebuffer;
	displayBuffer = PrimaryScreenBuffer;

	if (LanceEditorReloadGraphics != 0x0000)
	{
		LoadGraphicsResourceToBuffers(
			0x0011,
			SecondaryScreenBuffer,
			displayBuffer);
		LoadLanceConfigurationGraphicsBuffers();
		LoadAndPresentScreen(0x0010);
		primaryFramebuffer = VideoFramebuffer;
		displayBuffer = PrimaryScreenBuffer;
		HideMouseCursorOverlay();
		CopyClippedVideoRegion(
			0x0000, 0x0000, 0x0000, 0x0000, 0x0028, 0x00C8,
			primaryFramebuffer, displayBuffer);
	}
	else
	{
		HideMouseCursorOverlay();
	}

	selectedSection = 0x0000;
	previousSection = selectedSection;
	sectionSprite = UnitEditorGraphicsBuffer(0x0013 + selectedSection);
	DrawClippedSprite(
		primaryFramebuffer,
		sectionSprite,
		(int16) (LanceEditorLayout.UnitEditorSectionLeft[selectedSection] << 0x03),
		(int16) LanceEditorLayout.UnitEditorSectionTop[selectedSection],
		0x0000);
	sectionLabel = UnitEditorSectionLabelTextTable[selectedSection];
	DrawTextString(
		sectionLabel,
		LanceEditorLayout.UnitEditorSectionLeft[selectedSection + 0x0004] << 0x03,
		LanceEditorLayout.UnitEditorSectionTop[selectedSection + 0x0004],
		0x0F,
		0x00);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	highlightPhase = 0x0000;
	selectionActivated = FALSE;
	inputCode = 0x0000;

	while (selectionActivated == FALSE)
	{
		if (ServiceMusicAndCheckKeyboardInput() != 0x0000)
		{
			inputCode = NormalizeNavigationKeyCode(
				ReadTranslatedKeypress());
			if (inputCode == TranslatedExtendedKey(KEY_UP))
			{
				--selectedSection;
			}
			else if (inputCode == TranslatedExtendedKey(KEY_DOWN))
			{
				++selectedSection;
			}
			else if (inputCode == KEY_CARRIAGERETURN || inputCode == KEY_SPACE)
			{
				if (selectedSection == 0x0003)
				{
					if (ValidatePilotConfiguration(
						configurationIndex + 0x0001) == FALSE)
					{
						selectedSection = 0x0001;
					}
					else if (ValidateLanceConfiguration(
						configurationIndex + 0x0001) == FALSE)
					{
						selectedSection = 0x0002;
					}
					else
					{
						selectionActivated = TRUE;
					}
				}
				else
				{
					selectionActivated = TRUE;
				}
			}
			else if (inputCode == KEY_ESC)
			{
				if (ValidatePilotConfiguration(
					configurationIndex + 0x0001) == FALSE)
				{
					selectedSection = 0x0001;
				}
				else if (ValidateLanceConfiguration(
					configurationIndex + 0x0001) == FALSE)
				{
					selectedSection = 0x0002;
				}
				else
				{
					selectedSection = 0x0003;
					selectionActivated = TRUE;
					repeatEditor = FALSE;
				}
			}

			if ((int16) selectedSection < 0x0000)
				selectedSection = 0x0003;
			if ((int16) selectedSection > 0x0003)
				selectedSection = 0x0000;
		}
		else if (MouseInputDisabled == 0x0000)
		{
			mouseX = (int16) MouseCursorRequestedX;
			mouseY = (int16) MouseY;
			mouseButtonState = MouseButtonState;
			mouseButtonEvent = PendingMouseButtonEvent;
			PendingMouseButtonEvent = 0x0000;

			if (mouseButtonEvent != 0x0000 &&
				(mouseButtonState & MOUSE_BUTTON_RIGHT) != 0x0000)
			{
				if (ValidatePilotConfiguration(
					configurationIndex + 0x0001) == FALSE)
				{
					selectedSection = 0x0001;
				}
				else if (ValidateLanceConfiguration(
					configurationIndex + 0x0001) == FALSE)
				{
					selectedSection = 0x0002;
				}
				else
				{
					selectedSection = 0x0003;
					selectionActivated = TRUE;
					repeatEditor = FALSE;
				}
			}
			else
			{
				for (sectionIndex = 0x0000; sectionIndex < 0x0004;
					++sectionIndex)
				{
					leftX = (int16) (LanceEditorLayout.UnitEditorSectionLeft[sectionIndex] << 0x03);
					topY = (int16) LanceEditorLayout.UnitEditorSectionTop[sectionIndex];
					width = (int16) (LanceEditorLayout.UnitEditorSectionWidth[sectionIndex] << 0x03);
					heightMinusOne = (int16)
						(LanceEditorLayout.UnitEditorSectionHeight[sectionIndex] - 0x0001);
					if (mouseX >= leftX && mouseX < leftX + width &&
						mouseY >= topY && mouseY < topY + heightMinusOne)
					{
						selectedSection = sectionIndex;
						if (mouseButtonEvent != 0x0000 &&
							(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x0000)
						{
							if (selectedSection == 0x0003)
							{
								if (ValidatePilotConfiguration(
									configurationIndex + 0x0001) == FALSE)
									selectedSection = 0x0001;
								else if (ValidateLanceConfiguration(
									configurationIndex + 0x0001) == FALSE)
									selectedSection = 0x0002;
								else
									selectionActivated = TRUE;
							}
							else
							{
								selectionActivated = TRUE;
							}
						}
					}
				}
			}
		}

		if (selectedSection != previousSection)
		{
			HideMouseCursorOverlay();
			CopyClippedVideoRegion(
				(int16) LanceEditorLayout.UnitEditorSectionLeft[previousSection],
				(int16) LanceEditorLayout.UnitEditorSectionTop[previousSection],
				(int16) LanceEditorLayout.UnitEditorSectionLeft[previousSection],
				(int16) LanceEditorLayout.UnitEditorSectionTop[previousSection],
				LanceEditorLayout.UnitEditorSectionWidth[previousSection],
				LanceEditorLayout.UnitEditorSectionHeight[previousSection],
				displayBuffer,
				primaryFramebuffer);
			sectionSprite = UnitEditorGraphicsBuffer(0x0013 + selectedSection);
			DrawClippedSprite(
				primaryFramebuffer,
				sectionSprite,
				(int16) (LanceEditorLayout.UnitEditorSectionLeft[selectedSection] << 0x03),
				(int16) LanceEditorLayout.UnitEditorSectionTop[selectedSection],
				0x0000);

			sectionIndex = previousSection + 0x0004;
			CopyClippedVideoRegion(
				(int16) LanceEditorLayout.UnitEditorSectionLeft[sectionIndex],
				(int16) LanceEditorLayout.UnitEditorSectionTop[sectionIndex],
				(int16) LanceEditorLayout.UnitEditorSectionLeft[sectionIndex],
				(int16) LanceEditorLayout.UnitEditorSectionTop[sectionIndex],
				LanceEditorLayout.UnitEditorSectionWidth[sectionIndex],
				LanceEditorLayout.UnitEditorSectionHeight[sectionIndex],
				displayBuffer,
				primaryFramebuffer);
			sectionLabel = UnitEditorSectionLabelTextTable[selectedSection];
			DrawTextString(
				sectionLabel,
				LanceEditorLayout.UnitEditorSectionLeft[selectedSection + 0x0004] << 0x03,
				LanceEditorLayout.UnitEditorSectionTop[selectedSection + 0x0004],
				0x0F,
				0x00);
			highlightPhase = 0x0000;
			previousSection = selectedSection;
			ShowMouseCursorOverlay();
		}

		if (selectionActivated != FALSE)
		{
			HideMouseCursorOverlay();
			sectionIndex = previousSection + 0x0004;
			CopyClippedVideoRegion(
				(int16) LanceEditorLayout.UnitEditorSectionLeft[sectionIndex],
				(int16) LanceEditorLayout.UnitEditorSectionTop[sectionIndex],
				(int16) LanceEditorLayout.UnitEditorSectionLeft[sectionIndex],
				(int16) LanceEditorLayout.UnitEditorSectionTop[sectionIndex],
				LanceEditorLayout.UnitEditorSectionWidth[sectionIndex],
				LanceEditorLayout.UnitEditorSectionHeight[sectionIndex],
				displayBuffer,
				primaryFramebuffer);
			previousSection = selectedSection;
			highlightPhase = 0x0000;
			ShowMouseCursorOverlay();
		}

		WaitVerticalRetraces(0x0002);
		HideMouseCursorOverlay();
		if (highlightPhase != 0x0000)
		{
			sectionSprite = UnitEditorGraphicsBuffer(0x0013 + selectedSection);
			DrawClippedSprite(
				primaryFramebuffer,
				sectionSprite,
				(int16) (LanceEditorLayout.UnitEditorSectionLeft[selectedSection] << 0x03),
				(int16) LanceEditorLayout.UnitEditorSectionTop[selectedSection],
				0x0000);
		}
		else
		{
			CopyClippedVideoRegion(
				(int16) LanceEditorLayout.UnitEditorSectionLeft[selectedSection],
				(int16) LanceEditorLayout.UnitEditorSectionTop[selectedSection],
				(int16) LanceEditorLayout.UnitEditorSectionLeft[selectedSection],
				(int16) LanceEditorLayout.UnitEditorSectionTop[selectedSection],
				LanceEditorLayout.UnitEditorSectionWidth[selectedSection],
				LanceEditorLayout.UnitEditorSectionHeight[selectedSection],
				displayBuffer,
				primaryFramebuffer);
		}
		ShowMouseCursorOverlay();
		highlightPhase ^= 0x0001;
	}

	if (inputCode == KEY_ESC || selectedSection == 0x0000 ||
		selectedSection == 0x0003 ||
		(selectedSection == 0x0001 && UnitEditorPilotCardCount != 0x0000) ||
		(selectedSection == 0x0002 && UnitEditorScenarioCardCount != 0x0000))
	{
		FreeGraphicsBufferRange(0x0013, 0x0016);
		LanceEditorReloadGraphics = 0x0001;
	}
	else
	{
		LanceEditorReloadGraphics = 0x0000;
	}

	if (inputCode == KEY_ESC)
	{
		if (LanceEditorBriefingPresented == 0x0000)
			ShowLanceConfigurationBriefing(configurationIndex);
		repeatEditor = FALSE;
	}
	else if (selectedSection == 0x0000)
	{
		ShowLanceConfigurationBriefing(configurationIndex);
	}
	else if (selectedSection == 0x0001)
	{
		if (UnitEditorPilotCardCount != 0x0000)
			RunPilotSelection(configurationIndex, 0x0000);
		else
			ShowNoSelectionOptions();
	}
	else if (selectedSection == 0x0002)
	{
		if (UnitEditorScenarioCardCount != 0x0000)
			PrepareLanceSelection(configurationIndex + 0x0003, 0x0000);
		else
			ShowNoSelectionOptions();
	}
	else
	{
		if (LanceEditorBriefingPresented == 0x0000)
			ShowLanceConfigurationBriefing(configurationIndex);
		repeatEditor = FALSE;
	}

	return (int16) repeatEditor;
}

// 2507:1EBE: show the unavailable-selection message and wait for dismissal.
// Verified against 2507:1EBE-1F04.
void ShowNoSelectionOptions(void)
{
	word16 savedTextOutputMode;

	savedTextOutputMode = TextOutputMode;
	TextOutputMode = 0x0001;
	OpenModalTextWindow(0x000E, TRUE);
	HideMouseCursorOverlay();
	RenderFormattedText(NoSelectionOptionsText);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	WaitForKeyboardOrMouseInput();
	RestoreModalTextWindow();
	TextOutputMode = savedTextOutputMode;
}

// 2507:1F03: show the briefing associated with a lance configuration.
// VERIFIED against ASM 2507:1F03-2004, including the seven-entry jump table.
void ShowLanceConfigurationBriefing(word16 configurationIndex)
{
	switch (configurationIndex)
	{
	case 0x0000:
		PlayMusicResource(0x004C);
		if (LanceEditorFirstBriefingPending != 0x0000)
		{
			PresentStoryScreenAndMessage(0x001C, 0x0089);
			ShowStoryMessage(0x008A);
			ShowStoryMessage(0x008B);
			LanceEditorFirstBriefingPending = 0x0000;
		}
		else
		{
			PresentStoryScreenAndMessage(0x001C, 0x008B);
		}
		break;

	case 0x0001:
		PlayMusicResource(0x004C);
		PresentStoryScreenAndMessage(0x001C, 0x008F);
		break;

	case 0x0002:
		PlayMusicResource(0x004C);
		PresentStoryScreenAndMessage(0x001C, 0x0092);
		break;

	case 0x0003:
		PlayMusicResource(0x004A);
		PresentStoryScreenAndMessage(0x001C, 0x0094);
		break;

	case 0x0004:
	case 0x0005:
		PlayMusicResource(0x004A);
		PresentStoryScreenAndMessage(0x001C, 0x0098);
		break;

	case 0x0006:
		PlayMusicResource(0x004A);
		PresentStoryScreenAndMessage(0x001C, 0x009C);
		break;
	}

	LanceEditorBriefingPresented = 0x0001;
}

// 2507:2005: present one of two scenario-route choices and return its index.
// VERIFIED against ASM 2507:2005-26ED.
int16 SelectScenarioVariant(word16 presentationMode)
{
	word16 selectedVariant;
	word16 previousVariant;
	word16 selectionComplete;
	word16 highlightPhase;
	word16 variantIndex;
	word16 variantTextBaseIndex;
	int16 leftX;
	int16 topY;
	int16 width;
	int16 height;
	int16 mouseX;
	int16 mouseY;
	word16 mouseButtonState;
	word16 mouseButtonEvent;
	int16 inputCode;
	const char *label;
	byte *primaryFramebuffer;
	byte *displayBuffer;
	byte *selectionSprite;

	SceneTransitionAbortFlag = FALSE;
	primaryFramebuffer = VideoFramebuffer;
	displayBuffer = PrimaryScreenBuffer;

	if (presentationMode != 0x0000)
	{
		LoadGraphicsResourceToBuffers(
			0x0013,
			SecondaryScreenBuffer,
			displayBuffer);
		LoadScenarioVariantGraphicsBuffers();
	}

	LoadAndPresentScreen(presentationMode + 0x0014);
	primaryFramebuffer = VideoFramebuffer;
	displayBuffer = PrimaryScreenBuffer;
	HideMouseCursorOverlay();
	FillVideoRectangle(0x0000, 0x00A8, 0x013F, 0x00AE, 0x000E);
	FillVideoRectangle(0x009F, 0x00A8, 0x00A0, 0x00C7, 0x000D);

	selectedVariant = 0x0000;
	previousVariant = selectedVariant;
	leftX = 0x0000;
	topY = 0x0000;
	width = 0x009F;
	height = 0x00A7;

	if (presentationMode == 0x0000)
	{
		DrawClippedRectangleOutline(
			(int16) LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant],
			(int16) topY,
			(int16) (LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant] + width),
			(int16) (topY + height),
			LanceEditorLayout.ScenarioVariantNormalColor);
		selectedVariant ^= 0x0001;
		DrawClippedRectangleOutline(
			(int16) LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant],
			(int16) topY,
			(int16) (LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant] + width),
			(int16) (topY + height),
			LanceEditorLayout.ScenarioVariantNormalColor);
	}
	else
	{
		for (selectedVariant = 0x0000; selectedVariant < 0x0002;
			++selectedVariant)
		{
			CopyClippedVideoRegion(
				(int16) LanceEditorLayout.ScenarioVariantRegionLeft[selectedVariant],
				(int16) LanceEditorLayout.ScenarioVariantRegionTop[selectedVariant],
				(int16) LanceEditorLayout.ScenarioVariantRegionLeft[selectedVariant],
				(int16) LanceEditorLayout.ScenarioVariantRegionTop[selectedVariant],
				LanceEditorLayout.ScenarioVariantRegionWidth[selectedVariant],
				LanceEditorLayout.ScenarioVariantRegionHeight[selectedVariant],
				primaryFramebuffer,
				displayBuffer);
		}
		selectedVariant = 0x0000;
		selectionSprite = UnitEditorGraphicsBuffer(0x0011);
		DrawClippedSprite(
			primaryFramebuffer,
			selectionSprite,
			(int16) (LanceEditorLayout.ScenarioVariantRegionLeft[0x00] << 0x03),
			(int16) LanceEditorLayout.ScenarioVariantRegionTop[0x00],
			0x0000);
	}

	variantTextBaseIndex = presentationMode << 0x01;
	label = ScenarioVariantDescriptionTextTable[variantTextBaseIndex];
	DrawCenteredClippedText(
		label, 0x0000, 0x0000, 0x00A9, 0x00A0, 0x0F, 0x00);
	label = ScenarioVariantDescriptionTextTable[variantTextBaseIndex + 0x0001];
	DrawCenteredClippedText(
		label, 0x0000, 0x00A0, 0x00A9, 0x00A0, 0x0F, 0x00);

	highlightPhase = 0x0000;
	selectedVariant = 0x0000;
	if (presentationMode == 0x0000)
	{
		DrawUnitRosterScreen(selectedVariant, 0x000F);
	}
	else
	{
		for (variantIndex = 0x0000; variantIndex < 0x0004; ++variantIndex)
		{
			label = ScenarioRouteLabelTextTable[variantIndex];
			DrawCenteredClippedText(
				label,
				0x0000,
				LanceEditorLayout.ScenarioVariantTextLeft[variantIndex >> 0x01] + 0x0001,
				(variantIndex & 0x0001) == 0x0000 ? 0x00B0 : 0x00B8,
				(word16) (StringLength(label) *
					ActiveFontGlyphAdvanceX),
				0x0F,
				0x00);
		}
	}

	ShowMouseCursorOverlay();
	FlushPendingInput();
	selectionComplete = FALSE;
	while (selectionComplete == FALSE)
	{
		if (ServiceMusicAndCheckKeyboardInput() != 0x0000)
		{
			inputCode = NormalizeNavigationKeyCode(
				ReadTranslatedKeypress());
			if (inputCode == TranslatedExtendedKey(KEY_UP) ||
				inputCode == TranslatedExtendedKey(KEY_DOWN) ||
				inputCode == TranslatedExtendedKey(KEY_LEFT) ||
				inputCode == TranslatedExtendedKey(KEY_RIGHT))
			{
				selectedVariant ^= 0x0001;
			}
			else if (inputCode == KEY_CARRIAGERETURN || inputCode == KEY_SPACE)
			{
				selectionComplete = TRUE;
			}
		}
		else if (MouseInputDisabled == 0x0000)
		{
			mouseX = (int16) MouseCursorRequestedX;
			mouseY = (int16) MouseY;
			mouseButtonState = MouseButtonState;
			mouseButtonEvent = PendingMouseButtonEvent;
			PendingMouseButtonEvent = 0x0000;

			for (variantIndex = 0x0000; variantIndex < 0x0002; ++variantIndex)
			{
				if (presentationMode == 0x0000)
				{
					leftX = LanceEditorLayout.ScenarioVariantTextLeft[variantIndex];
					topY = 0x0000;
				}
				else
				{
					leftX = 0x0000;
					topY = LanceEditorLayout.ScenarioVariantTextTop[variantIndex];
					width = 0x013F;
					height = 0x0053;
				}

				if (mouseX >= leftX && mouseX <= leftX + width &&
					mouseY >= topY && mouseY <= topY + height)
				{
					selectedVariant = variantIndex;
					if (mouseButtonEvent != 0x0000 &&
						(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x0000)
						selectionComplete = TRUE;
				}
			}
		}

		if (selectedVariant != previousVariant)
		{
			HideMouseCursorOverlay();
			if (presentationMode == 0x0000)
			{
				DrawClippedRectangleOutline(
					(int16) LanceEditorLayout.ScenarioVariantTextLeft[previousVariant],
					(int16) topY,
					(int16) (LanceEditorLayout.ScenarioVariantTextLeft[previousVariant] + width),
					(int16) (topY + height),
					LanceEditorLayout.ScenarioVariantNormalColor);
				DrawUnitRosterScreen(previousVariant, 0x000C);
				DrawClippedRectangleOutline(
					(int16) LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant],
					(int16) topY,
					(int16) (LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant] + width),
					(int16) (topY + height),
					LanceEditorLayout.ScenarioVariantSelectedColor);
				DrawUnitRosterScreen(selectedVariant, 0x000F);
			}
			else
			{
				CopyClippedVideoRegion(
					(int16) LanceEditorLayout.ScenarioVariantRegionLeft[previousVariant],
					(int16) LanceEditorLayout.ScenarioVariantRegionTop[previousVariant],
					(int16) LanceEditorLayout.ScenarioVariantRegionLeft[previousVariant],
					(int16) LanceEditorLayout.ScenarioVariantRegionTop[previousVariant],
					LanceEditorLayout.ScenarioVariantRegionWidth[previousVariant],
					LanceEditorLayout.ScenarioVariantRegionHeight[previousVariant],
					displayBuffer,
					primaryFramebuffer);
				label = ScenarioVariantDescriptionTextTable[
					variantTextBaseIndex + previousVariant];
				DrawCenteredClippedText(
					label, 0x0000,
					LanceEditorLayout.ScenarioVariantTextLeft[previousVariant],
					0x00A9, 0x00A0, 0x0F, 0x00);

				selectionSprite = UnitEditorGraphicsBuffer(
					0x0011 + selectedVariant);
				DrawClippedSprite(
					primaryFramebuffer,
					selectionSprite,
					(int16) (LanceEditorLayout.ScenarioVariantRegionLeft[selectedVariant] << 0x03),
					(int16) LanceEditorLayout.ScenarioVariantRegionTop[selectedVariant],
					0x0000);
				label = ScenarioVariantDescriptionTextTable[
					variantTextBaseIndex + selectedVariant];
				DrawCenteredClippedText(
					label, 0x0000,
					LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant],
					0x00A9, 0x00A0, 0x0F, 0x00);
			}

			highlightPhase = 0x0000;
			previousVariant = selectedVariant;
			ShowMouseCursorOverlay();
		}

		WaitVerticalRetraces(0x0005);
		if (selectionComplete != FALSE)
			highlightPhase = 0x0001;
		HideMouseCursorOverlay();

		if (presentationMode == 0x0000)
		{
			DrawClippedRectangleOutline(
				(int16) LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant],
				(int16) topY,
				(int16) (LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant] + width),
				(int16) (topY + height),
				highlightPhase == 0x0000
					? LanceEditorLayout.ScenarioVariantNormalColor
					: LanceEditorLayout.ScenarioVariantSelectedColor);
		}
		else if (highlightPhase != 0x0000)
		{
			selectionSprite = UnitEditorGraphicsBuffer(
				0x0011 + selectedVariant);
			DrawClippedSprite(
				primaryFramebuffer,
				selectionSprite,
				(int16) (LanceEditorLayout.ScenarioVariantRegionLeft[selectedVariant] << 0x03),
				(int16) LanceEditorLayout.ScenarioVariantRegionTop[selectedVariant],
				0x0000);
			label = ScenarioVariantDescriptionTextTable[
				variantTextBaseIndex + selectedVariant];
			DrawCenteredClippedText(
				label, 0x0000,
				LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant],
				0x00A9, 0x00A0,
				(byte) LanceEditorLayout.ScenarioVariantLabelColor[
					variantTextBaseIndex + selectedVariant],
				(byte)0x00);
		}
		else
		{
			CopyClippedVideoRegion(
				(int16) LanceEditorLayout.ScenarioVariantRegionLeft[selectedVariant],
				(int16) LanceEditorLayout.ScenarioVariantRegionTop[selectedVariant],
				(int16) LanceEditorLayout.ScenarioVariantRegionLeft[selectedVariant],
				(int16) LanceEditorLayout.ScenarioVariantRegionTop[selectedVariant],
				LanceEditorLayout.ScenarioVariantRegionWidth[selectedVariant],
				LanceEditorLayout.ScenarioVariantRegionHeight[selectedVariant],
				displayBuffer,
				primaryFramebuffer);
			label = ScenarioVariantDescriptionTextTable[
				variantTextBaseIndex + selectedVariant];
			DrawCenteredClippedText(
				label, 0x0000,
				LanceEditorLayout.ScenarioVariantTextLeft[selectedVariant],
				0x00A9, 0x00A0, 0x0F, 0x00);
		}

		ShowMouseCursorOverlay();
		highlightPhase ^= 0x0001;
	}

	if (presentationMode != 0x0000)
		FreeGraphicsBufferRange(0x0011, 0x0012);
	return (int16) selectedVariant;
}

// 2507:26EE: draw five pilot/unit roster labels in the normal or alternate
// assignment layout. VERIFIED against ASM 2507:26EE-2BD8.
void DrawUnitRosterScreen(word16 useAlternateAssignmentLayout, word16 textColor)
{
	char rosterLine[0x2A];
	byte assignedUnitTypeIds[0x03];
	byte assignedPilotIds[0x03];
	byte fixedPilotIds[0x02];
	byte fixedUnitTypeIds[0x02];
	word16 assignmentIndex;
	word16 leftX;
	word16 rightX;
	const char *pilotName;
	const char *unitName;
	const char *separator;

	for (assignmentIndex = 0x0000; assignmentIndex < 0x0003;
		++assignmentIndex)
	{
		word16 liveUnitSlot =
			LanceAssignments[assignmentIndex].liveUnitSlot;
		assignedPilotIds[assignmentIndex] =
			LanceAssignments[assignmentIndex].pilotId;
		assignedUnitTypeIds[assignmentIndex] =
			LiveScenarioUnits[liveUnitSlot].unitTypeId;
	}
	fixedPilotIds[0x00] = FixedPilotIds[0x00];
	fixedPilotIds[0x01] = FixedPilotIds[0x01];
	fixedUnitTypeIds[0x00] = FixedUnitTypeIds[0x00];
	fixedUnitTypeIds[0x01] = FixedUnitTypeIds[0x01];
	leftX = LanceEditorLayout.UnitRosterLeftColumn;
	rightX = LanceEditorLayout.UnitRosterRightColumn;
	separator = UnitRosterSeparator;

	if (useAlternateAssignmentLayout == FALSE)
	{
		pilotName = PilotSurnameTextTable[assignedPilotIds[0x00]];
		unitName = UnitNameTable[assignedUnitTypeIds[0x00]];
		FarStringCopy(rosterLine, pilotName);
		FarStringConcat(rosterLine, separator);
		FarStringConcat(rosterLine, unitName);
		DrawCenteredClippedText(rosterLine, 0x00,
			leftX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
			UNIT_ROSTER_FIRST_ROW_Y, UNIT_ROSTER_TEXT_WIDTH_PIXELS,
			(byte)textColor, 0x00);

		pilotName = PilotSurnameTextTable[assignedPilotIds[0x01]];
		unitName = UnitNameTable[assignedUnitTypeIds[0x01]];
		FarStringCopy(rosterLine, pilotName);
		FarStringConcat(rosterLine, separator);
		FarStringConcat(rosterLine, unitName);
		DrawCenteredClippedText(rosterLine, 0x00,
			leftX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
			UNIT_ROSTER_FIRST_ROW_Y + 0x08,
			UNIT_ROSTER_TEXT_WIDTH_PIXELS, (byte)textColor, 0x00);

		pilotName = PilotSurnameTextTable[assignedPilotIds[0x02]];
		unitName = UnitNameTable[assignedUnitTypeIds[0x02]];
		FarStringCopy(rosterLine, pilotName);
		FarStringConcat(rosterLine, separator);
		FarStringConcat(rosterLine, unitName);
		DrawCenteredClippedText(rosterLine, 0x00,
			leftX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
			UNIT_ROSTER_FIRST_ROW_Y + 0x10,
			UNIT_ROSTER_TEXT_WIDTH_PIXELS, (byte)textColor, 0x00);

		pilotName = PilotSurnameTextTable[fixedPilotIds[0x00]];
		unitName = UnitNameTable[fixedUnitTypeIds[0x00]];
		FarStringCopy(rosterLine, pilotName);
		FarStringConcat(rosterLine, separator);
		FarStringConcat(rosterLine, unitName);
		DrawCenteredClippedText(rosterLine, 0x00,
			rightX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
			UNIT_ROSTER_FIRST_ROW_Y, UNIT_ROSTER_TEXT_WIDTH_PIXELS,
			(byte)textColor, 0x00);

		pilotName = PilotSurnameTextTable[fixedPilotIds[0x01]];
		unitName = UnitNameTable[fixedUnitTypeIds[0x01]];
		FarStringCopy(rosterLine, pilotName);
		FarStringConcat(rosterLine, separator);
		FarStringConcat(rosterLine, unitName);
		DrawCenteredClippedText(rosterLine, 0x00,
			rightX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
			UNIT_ROSTER_FIRST_ROW_Y + 0x08,
			UNIT_ROSTER_TEXT_WIDTH_PIXELS, (byte)textColor, 0x00);
		return;
	}

	pilotName = PilotSurnameTextTable[assignedPilotIds[0x01]];
	unitName = UnitNameTable[assignedUnitTypeIds[0x01]];
	FarStringCopy(rosterLine, pilotName);
	FarStringConcat(rosterLine, separator);
	FarStringConcat(rosterLine, unitName);
	DrawCenteredClippedText(rosterLine, 0x00,
		leftX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
		UNIT_ROSTER_FIRST_ROW_Y, UNIT_ROSTER_TEXT_WIDTH_PIXELS,
		(byte)textColor, 0x00);

	pilotName = PilotSurnameTextTable[assignedPilotIds[0x02]];
	unitName = UnitNameTable[assignedUnitTypeIds[0x02]];
	FarStringCopy(rosterLine, pilotName);
	FarStringConcat(rosterLine, separator);
	FarStringConcat(rosterLine, unitName);
	DrawCenteredClippedText(rosterLine, 0x00,
		leftX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
		UNIT_ROSTER_FIRST_ROW_Y + 0x08,
		UNIT_ROSTER_TEXT_WIDTH_PIXELS, (byte)textColor, 0x00);

	pilotName = PilotSurnameTextTable[fixedPilotIds[0x00]];
	unitName = UnitNameTable[assignedUnitTypeIds[0x00]];
	FarStringCopy(rosterLine, pilotName);
	FarStringConcat(rosterLine, separator);
	FarStringConcat(rosterLine, unitName);
	DrawCenteredClippedText(rosterLine, 0x00,
		leftX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
		UNIT_ROSTER_FIRST_ROW_Y + 0x10,
		UNIT_ROSTER_TEXT_WIDTH_PIXELS, (byte)textColor, 0x00);

	pilotName = PilotSurnameTextTable[assignedPilotIds[0x00]];
	unitName = UnitNameTable[fixedUnitTypeIds[0x00]];
	FarStringCopy(rosterLine, pilotName);
	FarStringConcat(rosterLine, separator);
	FarStringConcat(rosterLine, unitName);
	DrawCenteredClippedText(rosterLine, 0x00,
		rightX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
		UNIT_ROSTER_FIRST_ROW_Y, UNIT_ROSTER_TEXT_WIDTH_PIXELS,
		(byte)textColor, 0x00);

	pilotName = PilotSurnameTextTable[fixedPilotIds[0x01]];
	unitName = UnitNameTable[fixedUnitTypeIds[0x01]];
	FarStringCopy(rosterLine, pilotName);
	FarStringConcat(rosterLine, separator);
	FarStringConcat(rosterLine, unitName);
	DrawCenteredClippedText(rosterLine, 0x00,
		rightX + UNIT_ROSTER_COLUMN_X_ADJUSTMENT,
		UNIT_ROSTER_FIRST_ROW_Y + 0x08,
		UNIT_ROSTER_TEXT_WIDTH_PIXELS, (byte)textColor, 0x00);
}

// 2507:2BD9: prepare unit-selection records and their sprite buffers.
// VERIFIED against ASM 2507:2BD9-2E49.
void PrepareLanceSelectionRecords(
	word16 firstRosterIndex,
	int16 selectionMode,
	word16 loadPresentationResources)
{
	word16 lanceGroup;
	word16 scenarioSlot;
	word16 unitType;
	word16 persistentUnitSlot;
	word16 unitTypeId;
	word16 graphicsBufferIndex;
	word16 poolIndex;
	UnitSelectionCard *scenarioRecord;

	if (loadPresentationResources != FALSE)
	{
		LoadGraphicsResourceToBuffers(
			0x0023,
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
		LoadGraphicsBufferRange(0x0001, 0x0008);
		LoadGraphicsResourceToBuffers(
			0x0024,
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
		LoadGraphicsBufferRange(0x0009, 0x0010);
	}

	if ((int16) firstRosterIndex < 0x0003)
	{
		UnitEditorScenarioCardCount = 0x0006;
		if (firstRosterIndex == 0x0000)
		{
			UnitEditorScenarioGroupCount = 0x0001;
			UnitEditorLanceGroupCount = 0x0001;
			if (selectionMode != 0x0000)
				UnitEditorLanceSlotCount[0x00] = 0x0004;
		}
		else if (firstRosterIndex == 0x0001)
		{
			UnitEditorScenarioCardCount = 0x0004;
			UnitEditorScenarioGroupCount = 0x0001;
			UnitEditorLanceGroupCount = 0x0001;
			if (selectionMode != 0x0000)
				UnitEditorLanceSlotCount[0x00] = 0x0004;
		}
		else
		{
			UnitEditorScenarioGroupCount = 0x0003;
			UnitEditorLanceGroupCount = 0x0003;
			if (selectionMode != 0x0000)
			{
				UnitEditorLanceSlotCount[0x00] = 0x0004;
				UnitEditorLanceSlotCount[0x01] = 0x0004;
				UnitEditorLanceSlotCount[0x02] = 0x0004;
			}
		}
	}
	else
	{
		UnitEditorScenarioCardCount =
			UnitEditorScenarioCardCountByFamily[firstRosterIndex];
		UnitEditorScenarioGroupCount = 0x0001;
		UnitEditorLanceGroupCount = 0x0003;
		if (selectionMode != 0x0000)
		{
			RandomUnitTypeCount =
				RandomUnitTypeCountByFamily[firstRosterIndex];
			for (poolIndex = 0x0000; poolIndex < 0x0007; ++poolIndex)
			{
				RandomUnitTypePool[poolIndex] =
					RandomUnitTypePoolByFamily[
						(firstRosterIndex - 0x0003) * 0x0007 + poolIndex];
			}
			UnitEditorLanceSlotCount[0x00] = 0x0004;
			UnitEditorLanceSlotCount[0x01] = 0x0004;
			UnitEditorLanceSlotCount[0x02] = 0x0004;
		}
	}

	for (lanceGroup = 0x0000;
		(int16) lanceGroup < (int16) UnitEditorScenarioGroupCount;
		++lanceGroup)
	{
		for (scenarioSlot = 0x0000; scenarioSlot < 0x0006; ++scenarioSlot)
		{
			scenarioRecord = &UnitSelectionCards[
				lanceGroup * 0x0006 + scenarioSlot];
			if ((int16) scenarioSlot < (int16) UnitEditorScenarioCardCount)
			{
				if (selectionMode != 0x0000)
				{
					if ((int16) firstRosterIndex < 0x0003)
					{
						unitType = PredefinedUnitTypeTable[
								(firstRosterIndex + lanceGroup) * 0x0006 +
								scenarioSlot];
					}
					else
					{
						unitType = (word16) PopRandomUnitType();
					}

					if (selectionMode == 0x0001)
					{
						persistentUnitSlot =
							lanceGroup * 0x0006 + scenarioSlot;
						scenarioRecord->persistentUnitSlot =
							(RevengeUnitSlot)persistentUnitSlot;
						scenarioRecord->assignmentSlot =
							REVENGE_ASSIGNMENT_SLOT_NONE;
					}

					LoadUnitTemplateRecord((int16) unitType);
					persistentUnitSlot = scenarioRecord->persistentUnitSlot;
					PersistentUnitRoster[persistentUnitSlot] =
						EstimatedUnitRecord;
				}

				if (scenarioRecord->assignmentSlot != REVENGE_ASSIGNMENT_SLOT_NONE)
					scenarioRecord->state = 0x00;
				else
					scenarioRecord->state = 0x01;

				persistentUnitSlot = scenarioRecord->persistentUnitSlot;
				unitTypeId =
					PersistentUnitRoster[persistentUnitSlot].unitTypeId;
				graphicsBufferIndex = UnitEditorUnitSpriteIndex[unitTypeId];
				scenarioRecord->spriteBuffer = DosAddress_FromValue(
					HostFarPointer_Encode(
						UnitEditorGraphicsBuffer(graphicsBufferIndex)));
			}
			else
			{
				scenarioRecord->state = 0x00;
			}
		}
	}

	InitializeLanceAssignments(firstRosterIndex, selectionMode);
}

// 2507:2E4A: initialize the active lance-assignment records.
// VERIFIED against ASM 2507:2E4A-2FCC.
void InitializeLanceAssignments(
	word16 firstRosterIndex,
	int16 selectionMode)
{
	word16 lanceGroup;
	word16 lanceSlot;
	word16 assignmentIndex;
	RevengePilotId pilotId;
	RevengeUnitSlot liveUnitSlot;
	RevengeUnitLanceAssignment *assignment;

	for (lanceGroup = 0x0000;
		(int16) lanceGroup < (int16) UnitEditorLanceGroupCount;
		++lanceGroup)
	{
		for (lanceSlot = 0x0000; lanceSlot < 0x0004; ++lanceSlot)
		{
			assignmentIndex = lanceGroup * 0x0004 + lanceSlot;
			assignment = &LanceAssignments[assignmentIndex];

			if ((int16) UnitEditorLanceSlotCount[lanceGroup] >
				(int16) lanceSlot)
			{
				if (selectionMode == 0x0001 && firstRosterIndex < 0x0003)
				{
					if (firstRosterIndex == 0x0001)
					{
						assignment->style = 0x06;
						assignment->liveUnitSlot = REVENGE_UNIT_SLOT_UNAVAILABLE;
					}
					else
					{
						assignment->style = 0x02;
						assignment->liveUnitSlot = REVENGE_UNIT_SLOT_NONE;
					}

					assignment->pilotId = (RevengePilotId)
						DefaultPilotIdsByScenario[
							(firstRosterIndex + lanceGroup) * 0x0004 +
							lanceSlot];
					assignment->persistentUnitSlot = REVENGE_UNIT_SLOT_NONE;
				}
				else
				{
					assignment->style = 0x00;
					pilotId = assignment->pilotId;
					if (pilotId != REVENGE_PILOT_ID_NONE)
					{
						if (PilotRoster[pilotId].availability !=
							0xFF)
						{
							assignment->style |= 0x02;
						}
						else
						{
							assignment->pilotId = REVENGE_PILOT_ID_NONE;
						}
					}

					liveUnitSlot = assignment->liveUnitSlot;
					if (liveUnitSlot != REVENGE_UNIT_SLOT_NONE)
					{
						if (LiveScenarioUnits[liveUnitSlot].deploymentState != FALSE)
						{
							assignment->style |= 0x04;
						}
						else
						{
							assignment->liveUnitSlot = REVENGE_UNIT_SLOT_NONE;
						}
					}

					if (assignment->pilotId == REVENGE_PILOT_ID_NONE)
					{
						UnitEditorLanceSlotCount[lanceGroup] =
							lanceSlot;
					}
				}
			}
			else
			{
				assignment->style = 0x00;
				assignment->persistentUnitSlot = REVENGE_UNIT_SLOT_NONE;
				assignment->liveUnitSlot = REVENGE_UNIT_SLOT_NONE;
				assignment->pilotId = REVENGE_PILOT_ID_NONE;
			}
		}
	}
}

// 2507:2FCD: prepare, display, and edit one lance-selection configuration.
// VERIFIED against ASM 2507:2FCD-300E.
void PrepareLanceSelection(
	word16 firstRosterIndex,
	int16 selectionMode)
{
	if (ReplayScenarioRequested != FALSE)
		return;

	SceneTransitionAbortFlag = FALSE;
	(void) PrepareLanceSelectionRecords(
		firstRosterIndex,
		selectionMode,
		TRUE);
	DrawLanceSelectionScreen(firstRosterIndex);
	RunUnitAssignmentEditor(firstRosterIndex);
	FreeGraphicsBufferRange(0x0001, 0x0010);
}

// 2507:300F: validate the currently assigned live-unit slots for one
// lance-selection family.
// VERIFIED against ASM 2507:300F-30FB.
word16 ValidateLanceConfiguration(word16 selectionFamily)
{
	word16 configurationValid;
	word16 lanceGroup;
	word16 remainingScenarioUnits;
	word16 firstScenarioRecord;
	word16 scenarioSlot;
	word16 firstAssignmentRecord;
	word16 assignmentSlot;

	configurationValid = TRUE;
	if (UnitEditorScenarioCardCount != 0x0000)
	{
		lanceGroup = 0x0000;
		do
		{
			if (UnitEditorSectionEnabled[
				selectionFamily * LANCE_EDITOR_SECTION_COUNT] != FALSE)
			{
				remainingScenarioUnits = UnitEditorScenarioCardCount;
				if (UnitEditorScenarioGroupCount == 0x0001)
					firstScenarioRecord = 0x0000;
				else
					firstScenarioRecord = lanceGroup * 0x0006;

				for (scenarioSlot = 0x0000;
					(int16) scenarioSlot <
						(int16) UnitEditorScenarioCardCount;
					++scenarioSlot)
				{
					if ((UnitSelectionCards[
						firstScenarioRecord + scenarioSlot].state &
						0x01) == 0x00)
					{
						--remainingScenarioUnits;
					}
				}

				if (remainingScenarioUnits != 0x0000)
				{
					firstAssignmentRecord = lanceGroup * 0x0004;
					assignmentSlot = 0x0000;
					do
					{
						if (LanceAssignments[
							firstAssignmentRecord + assignmentSlot].liveUnitSlot ==
							REVENGE_UNIT_SLOT_NONE)
						{
							configurationValid = FALSE;
						}
						++assignmentSlot;
					} while ((int16) assignmentSlot < (int16)
						UnitEditorLanceSlotCount[lanceGroup] &&
						configurationValid != FALSE);
				}
			}
			++lanceGroup;
		} while (lanceGroup < 0x0003 && configurationValid != FALSE);
	}

	UnitEditorSectionEnabled[
		selectionFamily * LANCE_EDITOR_SECTION_COUNT + 0x03] =
		(byte) configurationValid;
	return configurationValid;
}

