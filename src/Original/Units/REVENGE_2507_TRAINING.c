// REVENGE_2507_TRAINING.c
// Reconstructed from the original procedures in segment 2507.

#include "REVENGE_2507_LANCE_EDITOR_INTERNAL.h"

// 2507:0008: enable the pilots used by the three training-selection rows.
// VERIFIED against physical-alias ASM 24C5:0428-0475 (2507:0008-0055).
void EnableTrainingUnitSelectionSlots(void)
{
	word16 pilotRow;
	word16 lanceSlot;
	word16 pilotId;

	for (pilotRow = 0x0002; pilotRow < 0x0005; ++pilotRow)
	{
		for (lanceSlot = 0x0000; lanceSlot < 0x0004; ++lanceSlot)
		{
			pilotId = DefaultPilotIdsByScenario[
				pilotRow * 0x0004 + lanceSlot];
			PilotRoster[pilotId].availability = 0x01;
		}
	}
}

// 2507:16E9: draw one entry in the two-choice training category window.
// Verified against 2507:16E9-1777.
void DrawTrainingCategoryOption(
	word16 optionIndex,
	word16 selectedState)
{
	word16 previousWindow = ActiveTextWindowIndex;
	word16 leftX;
	word16 topY;
	word16 width;
	const char *label;

	SelectTextWindow(0x13);
	HideMouseCursorOverlay();
	leftX = ActiveTextWindowLeftTile << 0x03;
	topY = (word16) ((ActiveTextWindowTopTile + 0x02) << 0x03);
	topY = (word16) (topY + optionIndex *
		(ActiveFontLineHeight + 0x02));
	width = ActiveTextWindowWidthTiles << 0x03;
	label = TrainingCategoryLabelTextTable[optionIndex];
	DrawCenteredClippedText(label, 0x00, leftX, topY, width,
		(byte) LanceEditorLayout.TrainingCategoryTextColor[selectedState],
		(byte) LanceEditorLayout.TrainingCategoryBackgroundColor[selectedState]);
	ShowMouseCursorOverlay();
	SelectTextWindow(previousWindow);
}

// 2507:1778: draw one entry in the six-choice training scenario window.
// Verified against 2507:1778-1847.
void DrawTrainingScenarioOption(
	word16 scenarioIndex,
	word16 selectedState)
{
	word16 previousWindow = ActiveTextWindowIndex;
	word16 leftX;
	word16 topY;
	word16 width;
	char *label;

	SelectTextWindow(0x14);
	HideMouseCursorOverlay();
	leftX = (word16) (ActiveTextWindowLeftTile << 0x03);
	leftX = (word16) (leftX +
		(scenarioIndex & 0x01) * (ActiveTextWindowWidthTiles << 0x02));
	topY = (word16) ((ActiveTextWindowTopTile + 0x02) << 0x03);
	topY = (word16) (topY + (scenarioIndex >> 0x01) *
		(ActiveFontLineHeight + 0x02));
	width = ActiveTextWindowWidthTiles << 0x02;
	label = TrainingScenarioLabelTextTable[scenarioIndex];
	label[0x00] = TrainingScenarioAvailability[scenarioIndex] == 0x01
		? '*' : ' ';
	DrawCenteredClippedText(label, 0x00, leftX, topY, width,
		(byte) LanceEditorLayout.TrainingScenarioTextColor[selectedState],
		(byte) LanceEditorLayout.TrainingScenarioBackgroundColor[selectedState]);
	ShowMouseCursorOverlay();
	SelectTextWindow(previousWindow);
}

// 2507:0E04: select the training mode and, for normal training, its scenario.
// Verified against 2507:0E04-1141.
int16 RunTrainingScenarioSelection(void)
{
	word16 previousWindow;
	word16 categoryIndex = 0x00;
	word16 previousIndex = 0x00;
	word16 accepted;
	word16 chooseLance = FALSE;
	word16 inputCode;
	word16 mouseButtonState;
	word16 mouseButtonEvent;
	int16 mouseX;
	int16 mouseY;
	word16 entryIndex;
	int16 leftX;
	int16 topY;
	int16 width;
	int16 height;

	ReplayScenarioRequested = FALSE;
	SceneTransitionAbortFlag = FALSE;
	previousWindow = ActiveTextWindowIndex;
	SelectTextWindow(0x12);
	DrawTrainingScenarioSelectionScreen();
	FlushPendingInput();
	SelectTextWindow(0x13);
	DrawTrainingCategoryOption(categoryIndex, TRUE);
	FlushPendingInput();
	accepted = FALSE;
	while (accepted == FALSE)
	{
		if (ServiceMusicAndCheckKeyboardInput() != FALSE)
		{
			inputCode = (word16) NormalizeNavigationKeyCode(
				ReadTranslatedKeypress());
			if ((int16) inputCode == TranslatedExtendedKey(KEY_UP))
				--categoryIndex;
			else if ((int16) inputCode == TranslatedExtendedKey(KEY_DOWN))
				++categoryIndex;
			else if (inputCode == KEY_CARRIAGE_RETURN || inputCode == KEY_SPACE)
			{
				if (categoryIndex == 0x01)
					chooseLance = TRUE;
				accepted = TRUE;
			}
			if ((int16) categoryIndex < 0x00)
				categoryIndex = 0x01;
			if (categoryIndex > 0x01)
				categoryIndex = 0x00;
		}
		else if (MouseInputDisabled == FALSE)
		{
			mouseX = MouseCursorRequestedX;
			mouseY = (int16) MouseY;
			mouseButtonState = MouseButtonState;
			mouseButtonEvent = PendingMouseButtonEvent;
			PendingMouseButtonEvent = FALSE;
			for (entryIndex = 0x00; entryIndex < 0x02; ++entryIndex)
			{
				leftX = (int16) ((ActiveTextWindowLeftTile << 0x03) +
					LanceEditorLayout.TrainingCategoryRegionLeft[entryIndex]);
				topY = (int16) ((ActiveTextWindowTopTile << 0x03) +
					LanceEditorLayout.TrainingCategoryRegionTop[entryIndex]);
				width = (int16) LanceEditorLayout.TrainingCategoryRegionWidth[entryIndex];
				height = (int16) LanceEditorLayout.TrainingCategoryRegionHeight[entryIndex];
				if (mouseX >= leftX && mouseX < leftX + width &&
					mouseY >= topY && mouseY < topY + height)
				{
					categoryIndex = entryIndex;
					if (mouseButtonEvent != FALSE &&
						(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x00)
					{
						if (categoryIndex == 0x01)
							chooseLance = TRUE;
						accepted = TRUE;
					}
				}
			}
		}
		if (categoryIndex != previousIndex)
		{
			DrawTrainingCategoryOption(previousIndex, FALSE);
			DrawTrainingCategoryOption(categoryIndex, TRUE);
			previousIndex = categoryIndex;
		}
	}

	if (chooseLance == FALSE)
	{
		word16 scenarioIndex = 0x00;
		previousIndex = 0x00;
		SelectTextWindow(0x14);
		DrawTrainingScenarioOption(scenarioIndex, TRUE);
		FlushPendingInput();
		accepted = FALSE;
		while (accepted == FALSE)
		{
			if (ServiceMusicAndCheckKeyboardInput() != FALSE)
			{
				inputCode = (word16) NormalizeNavigationKeyCode(
					ReadTranslatedKeypress());
				if ((int16) inputCode == TranslatedExtendedKey(KEY_UP))
					scenarioIndex -= 0x02;
				else if ((int16) inputCode == TranslatedExtendedKey(KEY_DOWN))
					scenarioIndex += 0x02;
				else if ((int16) inputCode == TranslatedExtendedKey(KEY_LEFT) ||
					(int16) inputCode == TranslatedExtendedKey(KEY_RIGHT))
					scenarioIndex ^= 0x01;
				else if (inputCode == KEY_CARRIAGE_RETURN || inputCode == KEY_SPACE)
					accepted = TRUE;
				if ((int16) scenarioIndex < 0x00)
					scenarioIndex += 0x06;
				if (scenarioIndex > 0x05)
					scenarioIndex -= 0x06;
			}
			else if (MouseInputDisabled == FALSE)
			{
				mouseX = MouseCursorRequestedX;
				mouseY = (int16) MouseY;
				mouseButtonState = MouseButtonState;
				mouseButtonEvent = PendingMouseButtonEvent;
				PendingMouseButtonEvent = FALSE;
				for (entryIndex = 0x00; entryIndex < 0x06; ++entryIndex)
				{
					leftX = (int16) ((ActiveTextWindowLeftTile << 0x03) +
						LanceEditorLayout.TrainingScenarioRegionLeft[entryIndex]);
					topY = (int16) ((ActiveTextWindowTopTile << 0x03) +
						LanceEditorLayout.TrainingScenarioRegionTop[entryIndex]);
					width = (int16) LanceEditorLayout.TrainingScenarioRegionWidth[entryIndex];
					height = (int16) LanceEditorLayout.TrainingScenarioRegionHeight[entryIndex];
					if (mouseX >= leftX && mouseX < leftX + width &&
						mouseY >= topY && mouseY < topY + height)
					{
						scenarioIndex = entryIndex;
						if (mouseButtonEvent != FALSE &&
							(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x00)
							accepted = TRUE;
					}
				}
			}
			if (scenarioIndex != previousIndex)
			{
				DrawTrainingScenarioOption(previousIndex, FALSE);
				DrawTrainingScenarioOption(scenarioIndex, TRUE);
				previousIndex = scenarioIndex;
			}
		}
		ScenarioVariantIndex = scenarioIndex;
	}
	SelectTextWindow(previousWindow);
	if (chooseLance != FALSE)
		PrepareLanceSelection(0x02, -0x01);
	return (int16) chooseLance;
}

// 2507:1142: compose the training deployment/scenario selection screen.
// Verified against 2507:1142-152D.
void DrawTrainingScenarioSelectionScreen(void)
{
	word16 previousWindow = ActiveTextWindowIndex;
	word16 leftX;
	word16 topY;
	word16 width;
	word16 gridTopY;
	word16 gridX;
	word16 groupIndex;
	word16 rowIndex;
	word16 halfLineOffset;
	word16 fullLineOffset;
	word16 index;
	const char *label;
	byte *displayBuffer = PrimaryScreenBuffer;
	byte *videoBuffer = VideoFramebuffer;

	HideMouseCursorOverlay();
	SetActiveRenderTarget(displayBuffer);
	SelectTextWindow(0x12);
	FillVideoRectangle(
		(int16) (ActiveTextWindowLeftTile << 0x03),
		(int16) (ActiveTextWindowTopTile << 0x03),
		(int16) (((ActiveTextWindowLeftTile + ActiveTextWindowWidthTiles) << 0x03) - 0x01),
		(int16) (((ActiveTextWindowTopTile + ActiveTextWindowHeightTiles) << 0x03) - 0x01),
		0x0C);
	leftX = ActiveTextWindowLeftTile << 0x03;
	topY = ActiveTextWindowTopTile << 0x03;
	width = ActiveTextWindowWidthTiles << 0x03;
	for (index = 0x00; index < 0x02; ++index)
	{
		label = TrainingDeploymentRosterLabelTextTable[index];
		DrawCenteredClippedText(label, 0x00, leftX, topY, width,
			0x0F, 0x00);
		topY = (word16) (topY +
			(ActiveFontLineHeight << 0x01));
	}
	gridTopY = (word16) (((ActiveTextWindowTopTile + 0x04) << 0x03) +
		ActiveFontLineHeight);
	halfLineOffset = (word16)
		(((byte) ActiveFontLineHeight >> 0x01) - 0x02);
	fullLineOffset = (word16)
		(ActiveFontLineHeight - 0x02);
	DrawClippedAxisAlignedLine(
		(int16) LanceEditorLayout.TrainingDeploymentFrameLeft[0x00],
		(int16) (gridTopY + halfLineOffset),
		(int16) (LanceEditorLayout.TrainingDeploymentFrameBottom + 0x01),
		(int16) (gridTopY + halfLineOffset), 0x0D);
	DrawClippedAxisAlignedLine(
		(int16) LanceEditorLayout.TrainingDeploymentFrameLeft[0x00],
		(int16) (gridTopY + halfLineOffset + 0x01),
		(int16) (LanceEditorLayout.TrainingDeploymentFrameBottom + 0x01),
		(int16) (gridTopY + halfLineOffset + 0x01), 0x0D);
	for (groupIndex = 0x00; groupIndex < 0x03; ++groupIndex)
	{
		gridX = LanceEditorLayout.TrainingDeploymentFrameLeft[groupIndex];
		topY = gridTopY;
		for (rowIndex = 0x00; rowIndex < 0x05; ++rowIndex)
		{
			word16 lineTopY = topY;
			if (rowIndex == 0x00 && groupIndex != 0x01)
				lineTopY = (word16) (topY + halfLineOffset);
			DrawClippedAxisAlignedLine((int16) gridX,
				(int16) lineTopY, (int16) gridX,
				(int16) (topY + fullLineOffset), 0x0D);
			DrawClippedAxisAlignedLine((int16) (gridX + 0x01),
				(int16) lineTopY, (int16) (gridX + 0x01),
				(int16) (topY + fullLineOffset), 0x0D);
			topY = (word16) (topY +
				(ActiveFontLineHeight *
					(rowIndex == 0x00 ? 0x02 : 0x03)));
		}
	}
	for (index = 0x00; index < 0x10; ++index)
		DrawTrainingDeploymentSlot(index, FALSE);

	SelectTextWindow(0x13);
	FillVideoRectangle(
		(int16) (ActiveTextWindowLeftTile << 0x03),
		(int16) (ActiveTextWindowTopTile << 0x03),
		(int16) (((ActiveTextWindowLeftTile + ActiveTextWindowWidthTiles) << 0x03) - 0x01),
		(int16) (((ActiveTextWindowTopTile + ActiveTextWindowHeightTiles) << 0x03) - 0x01),
		0x0C);
	label = TrainingCategoryHeadingText;
	DrawCenteredClippedText(label, 0x00,
		ActiveTextWindowLeftTile << 0x03,
		ActiveTextWindowTopTile << 0x03,
		ActiveTextWindowWidthTiles << 0x03, 0x0F, 0x00);
	for (index = 0x00; index < 0x02; ++index)
		DrawTrainingCategoryOption(index, FALSE);

	SelectTextWindow(0x14);
	FillVideoRectangle(
		(int16) (ActiveTextWindowLeftTile << 0x03),
		(int16) (ActiveTextWindowTopTile << 0x03),
		(int16) (((ActiveTextWindowLeftTile + ActiveTextWindowWidthTiles) << 0x03) - 0x01),
		(int16) (((ActiveTextWindowTopTile + ActiveTextWindowHeightTiles) << 0x03) - 0x01),
		0x0C);
	label = TrainingScenarioHeadingText;
	DrawCenteredClippedText(label, 0x00,
		ActiveTextWindowLeftTile << 0x03,
		ActiveTextWindowTopTile << 0x03,
		ActiveTextWindowWidthTiles << 0x03, 0x0F, 0x00);
	for (index = 0x00; index < 0x06; ++index)
		DrawTrainingScenarioOption(index, FALSE);

	DrawClippedAxisAlignedLine(0x00, 0x9F, 0x013F, 0x9F, 0x0D);
	DrawClippedAxisAlignedLine(0x57, 0x9F, 0x57, 0xC7, 0x0D);
	CopyClippedVideoRegion(0x00, 0x00, 0x00, 0x00,
		0x28, 0xC8, displayBuffer, videoBuffer);
	SetActiveRenderTarget(videoBuffer);
	ShowMouseCursorOverlay();
	SelectTextWindow(previousWindow);
}

// 2507:152E: draw one of the sixteen training deployment roster cells.
// Verified against 2507:152E-16E8.
void DrawTrainingDeploymentSlot(
	word16 slotIndex,
	word16 selectedState)
{
	word16 previousWindow = ActiveTextWindowIndex;
	word16 groupIndex;
	word16 groupSlot;
	word16 rosterIndex;
	word16 leftX;
	word16 topY;
	word16 width;
	const char *label;
	RevengeUnitRecord *unitRecord;

	SelectTextWindow(0x12);
	HideMouseCursorOverlay();
	topY = (word16) ((ActiveTextWindowTopTile + 0x04) << 0x03);
	groupIndex = slotIndex / 0x05;
	groupSlot = slotIndex % 0x05;
	if (groupIndex == 0x03)
	{
		leftX = ActiveTextWindowLeftTile << 0x03;
		width = ActiveTextWindowWidthTiles << 0x03;
		label = UnitRosterColumnLabelTextTable[groupIndex];
	}
	else
	{
		leftX = LanceEditorLayout.TrainingRosterLabelLeft[groupIndex];
		width = LanceEditorLayout.TrainingRosterLabelWidth[groupIndex];
		if (groupSlot == 0x04)
		{
			topY = (word16) (topY +
				(ActiveFontLineHeight << 0x01));
			label = UnitRosterColumnLabelTextTable[groupIndex];
		}
		else
		{
			topY = (word16) (topY +
				(groupSlot * 0x03 + 0x04) *
				ActiveFontLineHeight);
			rosterIndex = groupIndex * 0x04 + groupSlot;
			unitRecord = &LiveScenarioUnits[rosterIndex];
			label = PilotSurnameTextTable[unitRecord->pilotId];
			DrawCenteredClippedText(label, 0x00, leftX, topY, width,
				(byte) LanceEditorLayout.TrainingDeploymentTextColor[selectedState],
				(byte) LanceEditorLayout.TrainingDeploymentBackgroundColor[selectedState]);
			topY = (word16) (topY + ActiveFontLineHeight);
			label = UnitNameTable[unitRecord->unitTypeId];
		}
	}
	DrawCenteredClippedText(label, 0x00, leftX, topY, width,
		(byte) LanceEditorLayout.TrainingDeploymentTextColor[selectedState],
		(byte) LanceEditorLayout.TrainingDeploymentBackgroundColor[selectedState]);
	ShowMouseCursorOverlay();
	SelectTextWindow(previousWindow);
}

// 2507:0C70: draw the raised frame and centered label used by training choices.
// Verified against 2507:0C70-0E03.
void DrawTrainingChoiceButton(
	word16 leftX,
	word16 topY,
	const char *label,
	word16 width)
{
	word16 lineHeight = ActiveFontLineHeight;

	HideMouseCursorOverlay();
	FillVideoRectangle((int16) (leftX - 0x02),
		(int16) (topY - 0x02),
		(int16) (leftX + width + 0x02),
		(int16) (topY + lineHeight + 0x01), 0x0E);
	DrawCenteredClippedText(label, 0x00, leftX, topY, width, 0x0F, 0x00);
	DrawClippedAxisAlignedLine((int16) (leftX - 0x04),
		(int16) (topY - 0x03), (int16) (leftX + width + 0x02),
		(int16) (topY - 0x03), 0x0F);
	DrawClippedAxisAlignedLine((int16) (leftX - 0x03),
		(int16) (topY - 0x02), (int16) (leftX + width + 0x01),
		(int16) (topY - 0x02), 0x0F);
	DrawClippedAxisAlignedLine((int16) (leftX - 0x04),
		(int16) (topY - 0x02), (int16) (leftX - 0x04),
		(int16) (topY + lineHeight + 0x01), 0x0F);
	DrawClippedAxisAlignedLine((int16) (leftX - 0x03),
		(int16) (topY - 0x01), (int16) (leftX - 0x03),
		(int16) (topY + lineHeight), 0x0F);
	DrawClippedAxisAlignedLine((int16) (leftX + width + 0x02),
		(int16) (topY + lineHeight + 0x02),
		(int16) (leftX + width + 0x02),
		(int16) (topY - 0x02), 0x0D);
	DrawClippedAxisAlignedLine((int16) (leftX + width + 0x01),
		(int16) (topY + lineHeight + 0x01),
		(int16) (leftX + width + 0x01),
		(int16) (topY - 0x01), 0x0D);
	DrawClippedAxisAlignedLine((int16) (leftX - 0x02),
		(int16) (topY + lineHeight + 0x01),
		(int16) (leftX + width + 0x01),
		(int16) (topY + lineHeight + 0x01), 0x0D);
	DrawClippedAxisAlignedLine((int16) (leftX - 0x01),
		(int16) (topY + lineHeight + 0x02),
		(int16) (leftX + width + 0x02),
		(int16) (topY + lineHeight + 0x02), 0x0D);
	ShowMouseCursorOverlay();
}

// 2507:0AB1: draw or toggle one of twelve training unit choices.
// Verified against 2507:0AB1-0BC2.
void DrawTrainingUnitChoice(word16 choiceIndex, word16 selectedState)
{
	word16 row = choiceIndex / 0x04;
	word16 column = choiceIndex % 0x04;
	word16 unitIndex = (word16) (UnitEditorAllegiance *
		0x0C + choiceIndex);
	word16 leftX = LanceEditorLayout.TrainingDeploymentSlotLeft[row];
	word16 topY = (word16) (((ActiveTextWindowTopTile + 0x07) << 0x03) +
		(ActiveFontLineHeight * (column * 0x03 + 0x05)) - 0x03);
	RevengeUnitRecord *unitRecord = &LiveScenarioUnits[unitIndex];
	const char *label;

	HideMouseCursorOverlay();
	if (selectedState != FALSE)
	{
		if (unitRecord->unitTypeId == REVENGE_UNIT_TYPE_NONE)
			label = UnknownUnitLabel;
		else
			label = UnitNameTable[unitRecord->unitTypeId];
		DrawTrainingChoiceButton(leftX, topY, label, 0x4E);
	}
	else
	{
		XorVideoRectangle((int16) leftX, (int16) topY,
			(int16) (leftX + 0x4D),
			(int16) (topY + ActiveFontLineHeight - 0x01),
			0x01);
	}
	ShowMouseCursorOverlay();
}

// 2507:0BC3: draw or toggle one of four training control choices.
// Verified against 2507:0BC3-0C6F.
void DrawTrainingControlChoice(word16 choiceIndex, word16 selectedState)
{
	word16 group = choiceIndex / 0x02;
	word16 row = choiceIndex % 0x02;
	word16 leftX = LanceEditorLayout.TrainingControlChoiceColumn[group];
	word16 topY = (word16) (((ActiveTextWindowTopTile + 0x07) << 0x03) +
		(ActiveFontLineHeight * (row * 0x03 + 0x13)) - 0x03);
	const char *label = TrainingControlLabelTextTable[choiceIndex];

	HideMouseCursorOverlay();
	if (selectedState != FALSE)
		DrawTrainingChoiceButton(leftX, topY, label, 0x5A);
	else
		XorVideoRectangle((int16) leftX, (int16) topY,
			(int16) (leftX + 0x59),
			(int16) (topY + ActiveFontLineHeight - 0x01),
			0x01);
	ShowMouseCursorOverlay();
}

// 2507:0794: compose the training unit-selection screen.
// Verified against 2507:0794-0AB0.
void DrawTrainingDeploymentScreen(void)
{
	word16 index;
	word16 leftX;
	word16 topY;
	word16 width;
	word16 gridTopY;
	word16 gridX;
	word16 groupIndex;
	word16 rowIndex;
	word16 halfLineOffset;
	word16 fullLineOffset;
	const char *label;
	byte *displayBuffer = PrimaryScreenBuffer;
	byte *videoBuffer = VideoFramebuffer;

	HideMouseCursorOverlay();
	SetActiveRenderTarget(displayBuffer);
	SelectAndClearTextWindow(0x00);
	leftX = ActiveTextWindowLeftTile << 0x03;
	topY = ActiveTextWindowTopTile << 0x03;
	width = ActiveTextWindowWidthTiles << 0x03;
	for (index = 0x00; index < 0x04; ++index)
	{
		label = TrainingDeploymentLabelTextTable[index];
		DrawCenteredClippedText(label, 0x00, leftX, topY, width,
			0x0F, 0x00);
		topY = (word16) (topY +
			(ActiveFontLineHeight << 0x01));
	}
	topY = (word16) ((ActiveTextWindowTopTile + 0x07) << 0x03);
	UnitEditorAllegiance = 0x00;
	DrawUnitAllegianceHeader(TRUE);
	gridTopY = (word16) (topY +
		ActiveFontLineHeight);
	halfLineOffset = (word16)
		(((byte) ActiveFontLineHeight >> 0x01) - 0x02);
	fullLineOffset = (word16)
		(ActiveFontLineHeight - 0x02);
	DrawClippedAxisAlignedLine(
		(int16) LanceEditorLayout.TrainingUnitGroupLeft[0x00],
		(int16) (gridTopY + halfLineOffset),
		(int16) (LanceEditorLayout.TrainingUnitGroupBottom + 0x01),
		(int16) (gridTopY + halfLineOffset), 0x0D);
	DrawClippedAxisAlignedLine(
		(int16) LanceEditorLayout.TrainingUnitGroupLeft[0x00],
		(int16) (gridTopY + halfLineOffset + 0x01),
		(int16) (LanceEditorLayout.TrainingUnitGroupBottom + 0x01),
		(int16) (gridTopY + halfLineOffset + 0x01), 0x0D);
	for (groupIndex = 0x00; groupIndex < 0x03; ++groupIndex)
	{
		gridX = LanceEditorLayout.TrainingUnitGroupLabelLeft[groupIndex];
		width = LanceEditorLayout.TrainingUnitGroupLabelWidth[groupIndex];
		label = UnitRosterColumnLabelTextTable[groupIndex];
		DrawCenteredClippedText(label, 0x00, gridX,
			(word16) (gridTopY +
				ActiveFontLineHeight),
			width, 0x0E, 0x0C);
		gridX = LanceEditorLayout.TrainingUnitGroupLeft[groupIndex];
		topY = gridTopY;
		for (rowIndex = 0x00; rowIndex < 0x05; ++rowIndex)
		{
			word16 lineTopY = topY;
			if (rowIndex == 0x00 && groupIndex != 0x01)
				lineTopY = (word16) (topY + halfLineOffset);
			DrawClippedAxisAlignedLine((int16) gridX,
				(int16) lineTopY, (int16) gridX,
				(int16) (topY + fullLineOffset), 0x0D);
			DrawClippedAxisAlignedLine((int16) (gridX + 0x01),
				(int16) lineTopY, (int16) (gridX + 0x01),
				(int16) (topY + fullLineOffset), 0x0D);
			topY = (word16) (topY +
				(ActiveFontLineHeight *
					(rowIndex == 0x00 ? 0x02 : 0x03)));
		}
	}
	for (index = 0x00; index < 0x0C; ++index)
		DrawTrainingUnitChoice(index, TRUE);
	for (index = 0x00; index < 0x04; ++index)
		DrawTrainingControlChoice(index, TRUE);
	CopyClippedVideoRegion(0x00, 0x00, 0x00, 0x00,
		0x28, 0xC8, displayBuffer, videoBuffer);
	SetActiveRenderTarget(videoBuffer);
	ShowMouseCursorOverlay();
}

// 2507:0057: configure the two twelve-unit training forces.
// Verified against 2507:0057-0500.
int16 PrepareTrainingDeployment(void)
{
	word16 previousWindow;
	word16 selectedChoice = 0x00;
	word16 previousChoice = 0x00;
	word16 row;
	word16 column;
	word16 activated;
	word16 finished = FALSE;
	word16 result = FALSE;
	word16 inputCode;
	word16 index;
	word16 mouseButtonState;
	word16 mouseButtonEvent;
	int16 mouseX;
	int16 mouseY;
	int16 leftX;
	int16 topY;
	int16 width;
	int16 height;
	RevengeUnitRecord *unitRecord;
	int16 unitType;

	ReplayScenarioRequested = FALSE;
	SceneTransitionAbortFlag = FALSE;
	previousWindow = ActiveTextWindowIndex;
	DrawTrainingDeploymentScreen();
	DrawTrainingUnitChoice(selectedChoice, FALSE);
	FlushPendingInput();
	while (finished == FALSE)
	{
		activated = FALSE;
		if (ServiceMusicAndCheckKeyboardInput() != FALSE)
		{
			inputCode = (word16) NormalizeNavigationKeyCode(
				ReadTranslatedKeypress());
			row = selectedChoice / 0x04;
			column = selectedChoice % 0x04;
			if ((int16) inputCode == TranslatedExtendedKey(KEY_UP))
			{
				if (row == 0x03)
				{
					if (column == 0x00)
						selectedChoice = 0x03;
					else if (column == 0x02)
						selectedChoice = 0x0B;
					else
						--selectedChoice;
				}
				else if (column == 0x00)
					selectedChoice = row == 0x02 ? 0x0F : 0x0D;
				else
					--selectedChoice;
			}
			else if ((int16) inputCode == TranslatedExtendedKey(KEY_DOWN))
			{
				if (row == 0x03)
				{
					if (column == 0x01)
						selectedChoice = 0x00;
					else if (column == 0x03)
						selectedChoice = 0x08;
					else
						++selectedChoice;
				}
				else if (column == 0x03)
					selectedChoice = row == 0x02 ? 0x0E : 0x0C;
				else
					++selectedChoice;
			}
			else if ((int16) inputCode == TranslatedExtendedKey(KEY_LEFT) ||
				(int16) inputCode == TranslatedExtendedKey(KEY_RIGHT))
			{
				if (row == 0x03)
					selectedChoice = column < 0x02
						? (word16) (selectedChoice + 0x02)
						: (word16) (selectedChoice - 0x02);
				else if ((int16) inputCode == TranslatedExtendedKey(KEY_LEFT))
					selectedChoice = row == 0x00
						? (word16) (selectedChoice + 0x08)
						: (word16) (selectedChoice - 0x04);
				else
					selectedChoice = row == 0x02
						? (word16) (selectedChoice - 0x08)
						: (word16) (selectedChoice + 0x04);
			}
			else if (inputCode == KEY_CARRIAGE_RETURN || inputCode == KEY_SPACE)
				activated = TRUE;
			else if (inputCode == KEY_ESCAPE)
			{
				selectedChoice = 0x0F;
				activated = TRUE;
			}
		}
		else if (MouseInputDisabled == FALSE)
		{
			mouseX = MouseCursorRequestedX;
			mouseY = (int16) MouseY;
			mouseButtonState = MouseButtonState;
			mouseButtonEvent = PendingMouseButtonEvent;
			PendingMouseButtonEvent = FALSE;
			for (index = 0x00; index < 0x0C; ++index)
			{
				leftX = (int16) LanceEditorLayout.TrainingUnitChoiceLeft[index];
				topY = (int16) LanceEditorLayout.TrainingUnitChoiceTop[index];
				if (mouseX >= leftX && mouseX < leftX + 0x4E &&
					mouseY >= topY && mouseY < topY +
						ActiveFontLineHeight)
				{
					selectedChoice = index;
					if (mouseButtonEvent != FALSE &&
						(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x00)
						activated = TRUE;
				}
			}
			for (index = 0x00; index < 0x04; ++index)
			{
				leftX = (int16) LanceEditorLayout.TrainingControlChoiceLeft[index];
				topY = (int16) LanceEditorLayout.TrainingControlChoiceTop[index];
				width = 0x5A;
				height = ActiveFontLineHeight;
				if (mouseX >= leftX && mouseX < leftX + width &&
					mouseY >= topY && mouseY < topY + height)
				{
					selectedChoice = (word16) (index + 0x0C);
					if (mouseButtonEvent != FALSE &&
						(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x00)
						activated = TRUE;
				}
			}
		}

		if (selectedChoice != previousChoice)
		{
			if (previousChoice < 0x0C)
				DrawTrainingUnitChoice(previousChoice, FALSE);
			else
				DrawTrainingControlChoice(
					(word16) (previousChoice - 0x0C), FALSE);
			if (selectedChoice < 0x0C)
				DrawTrainingUnitChoice(selectedChoice, FALSE);
			else
				DrawTrainingControlChoice(
					(word16) (selectedChoice - 0x0C), FALSE);
			previousChoice = selectedChoice;
		}
		if (activated == FALSE)
			continue;

		if (selectedChoice == 0x0C || selectedChoice == 0x0D)
		{
			DrawUnitAllegianceHeader(FALSE);
			UnitEditorAllegiance = selectedChoice == 0x0C ? 0x00 : 0x01;
			DrawUnitAllegianceHeader(TRUE);
			for (index = 0x00; index < 0x0C; ++index)
				DrawTrainingUnitChoice(index, TRUE);
			continue;
		}
		if (selectedChoice == 0x0E)
		{
			result = RunGameOptionsMenu(FALSE);
			if (result != 0x04)
				result = TRUE;
			else
			{
				result = FALSE;
				finished = TRUE;
			}
			continue;
		}
		if (selectedChoice == 0x0F)
		{
			if (LiveScenarioUnits[0x00].unitTypeId != REVENGE_UNIT_TYPE_NONE &&
				LiveScenarioUnits[0x0C].unitTypeId != REVENGE_UNIT_TYPE_NONE)
			{
				result = TRUE;
				finished = TRUE;
			}
			else
			{
				word16 previousTextMode = TextOutputMode;
				TextOutputMode = 0x03;
				OpenModalTextWindow(0x0E, TRUE);
				HideMouseCursorOverlay();
				RenderFormattedText(TrainingUnitSelectionPrompt);
				ShowMouseCursorOverlay();
				WaitForDismissInput();
				RestoreModalTextWindow();
				TextOutputMode = previousTextMode;
			}
			continue;
		}

		unitType = SelectUnitClass();
		unitRecord = &LiveScenarioUnits[
			UnitEditorAllegiance * 0x0C +
			selectedChoice];
		unitRecord->unitTypeId = (byte) unitType;
		DrawTrainingUnitChoice(selectedChoice, TRUE);
		DrawTrainingUnitChoice(selectedChoice, FALSE);
	}

	for (index = 0x00; index < 0x18; ++index)
	{
		unitRecord = &LiveScenarioUnits[index];
		if (unitRecord->unitTypeId == REVENGE_UNIT_TYPE_NONE)
			*unitRecord = BlankUnitRecord;
		else
		{
			LoadUnitTemplateRecord(unitRecord->unitTypeId);
			EstimatedUnitRecord.deploymentState = 0x01;
			CopyFarBytes32(&EstimatedUnitRecord,
				unitRecord, UNIT_RECORD_SIZE);
			if (index < 0x0C)
				unitRecord->pilotId = 0x3A;
		}
	}
	SelectTextWindow(previousWindow);
	return (int16) result;
}

// 2507:0501: select one of six unit classes, then a type from that class.
// Returns the selected MECHTYPE.DAT type ID, or -1 for Cancel.
// Verified against 2507:0501-0624.
int16 SelectUnitClass(void)
{
	TextWindowContext *menuWindow =
		&TextWindowContexts[UNIT_SELECTION_TEXT_WINDOW_INDEX];
	OriginalUiRegionRecord *menuRegion =
		&UiRegionTable[UNIT_SELECTION_UI_REGION_INDEX];
	word16 menuHeightTiles =
		((ActiveFontLineHeight * UNIT_CLASS_MENU_ENTRY_COUNT) +
			(TEXT_WINDOW_TILE_SIZE_PIXELS - 0x01)) >> 0x03;
	menuWindow->heightTiles = menuHeightTiles;
	menuWindow->topTile =
		(VIDEO_SCREEN_HEIGHT / TEXT_WINDOW_TILE_SIZE_PIXELS - menuHeightTiles) >> 0x01;
	OpenModalTextWindow(UNIT_SELECTION_TEXT_WINDOW_INDEX, TRUE);
	HideMouseCursorOverlay();
	word16 textWidth = menuWindow->widthTiles * TEXT_WINDOW_TILE_SIZE_PIXELS;
	word16 textLeft = menuWindow->leftTile * TEXT_WINDOW_TILE_SIZE_PIXELS;
	word16 textTop = menuWindow->topTile * TEXT_WINDOW_TILE_SIZE_PIXELS;
	word16 classIndex;
	for (classIndex = 0x00; classIndex < UNIT_CLASS_MENU_ENTRY_COUNT; ++classIndex)
	{
		const char *label = UnitClassLabelTextTable[classIndex];
		DrawCenteredClippedText(
			label,
			0x00, textLeft, textTop, textWidth,
			(byte)ActiveTextForegroundColor,
			(byte)ActiveTextBackgroundColor);
		textTop += ActiveFontLineHeight;
	}
	ShowMouseCursorOverlay();
	menuRegion->rowCount = UNIT_CLASS_MENU_ENTRY_COUNT;
	menuRegion->widthColumns = UNIT_SELECTION_TEXT_WINDOW_INDEX;
	FlushPendingInput();
	int16 selectedMenuEntry;
	do {
		selectedMenuEntry =
			RunSingleUiRegionSelection(UNIT_SELECTION_UI_REGION_INDEX);
		if (selectedMenuEntry == KEY_ESCAPE)
			ToggleActiveUiRegionHighlight();
	} while (selectedMenuEntry == KEY_ESCAPE);
	RestoreModalTextWindow();

	if (selectedMenuEntry == UNIT_CLASS_MENU_CANCEL_INDEX)
		return -0x01;
	if (selectedMenuEntry >= 0x00 && selectedMenuEntry < UNIT_CLASS_COUNT)
	{
		const byte *unitTypeList = UnitClassTypeLists[selectedMenuEntry];
		return SelectUnitTypeFromList(
			unitTypeList);
	}
	return -0x01;
}

// 2507:0625: int16 SelectUnitTypeFromList(const byte far *unitTypeIdList)
// Called from:
//      SelectUnitClass
// Verified against 2507:0625-0793.
int16 SelectUnitTypeFromList(const byte *unitTypeIdList)
{
	// The FFh-terminated input contains MECHTYPE.DAT / UnitNameTable
	// type IDs. The Omni list ends with Elementals, which are offered only
	// while choosing an Enemy unit. Every displayed list ends with Cancel.
	word16 unitTypeCount = 0x00;
	while (unitTypeIdList[unitTypeCount] != 0xFF)
		++unitTypeCount;

	bool isOmniUnitTypeList =
		FAR_SEGMENT(unitTypeIdList) == 0x3A6A &&
		FAR_OFFSET(unitTypeIdList) == OMNI_UNIT_TYPE_LIST_OFFSET;
	word16 selectableUnitTypeCount = unitTypeCount;
	if (isOmniUnitTypeList &&
		UnitEditorAllegiance != UNIT_ALLEGIANCE_ENEMY)
		--selectableUnitTypeCount;
	word16 menuEntryCount = selectableUnitTypeCount + 0x01;

	TextWindowContext *menuWindow =
		&TextWindowContexts[UNIT_SELECTION_TEXT_WINDOW_INDEX];
	OriginalUiRegionRecord *menuRegion =
		&UiRegionTable[UNIT_SELECTION_UI_REGION_INDEX];
	int16 menuHeightTiles = (int16) (word16)
		((word16) (ActiveFontLineHeight) *
			menuEntryCount + (TEXT_WINDOW_TILE_SIZE_PIXELS - 0x01));
	menuHeightTiles = (int16) (((word16) menuHeightTiles >> 0x01) |
		((word16) menuHeightTiles & 0x8000));
	menuHeightTiles = (int16) (((word16) menuHeightTiles >> 0x01) |
		((word16) menuHeightTiles & 0x8000));
	menuHeightTiles = (int16) (((word16) menuHeightTiles >> 0x01) |
		((word16) menuHeightTiles & 0x8000));
	menuWindow->heightTiles = menuHeightTiles;
	menuWindow->topTile = (word16) ((int16)
		(VIDEO_SCREEN_HEIGHT / TEXT_WINDOW_TILE_SIZE_PIXELS -
			menuHeightTiles) >> 0x01);
	OpenModalTextWindow(UNIT_SELECTION_TEXT_WINDOW_INDEX, TRUE);
	HideMouseCursorOverlay();
	word16 textWidth = menuWindow->widthTiles * TEXT_WINDOW_TILE_SIZE_PIXELS;
	word16 textLeft = menuWindow->leftTile * TEXT_WINDOW_TILE_SIZE_PIXELS;
	word16 textTop = menuWindow->topTile * TEXT_WINDOW_TILE_SIZE_PIXELS;
	word16 menuEntryIndex;
	for (menuEntryIndex = 0x00; menuEntryIndex < menuEntryCount; ++menuEntryIndex)
	{
		const char *label;
		if (menuEntryIndex < selectableUnitTypeCount)
			label = UnitNameTable[unitTypeIdList[menuEntryIndex]];
		else
			label = "Cancel"; // TEXT DS:437E
		DrawCenteredClippedText(label, 0x00, textLeft, textTop, textWidth,
			(byte)ActiveTextForegroundColor,
			(byte)ActiveTextBackgroundColor);
		textTop += ActiveFontLineHeight;
	}
	ShowMouseCursorOverlay();
	menuRegion->rowCount = menuEntryCount;
	menuRegion->widthColumns = UNIT_SELECTION_TEXT_WINDOW_INDEX;
	FlushPendingInput();
	int16 selectedEntry;
	do {
		selectedEntry =
			RunSingleUiRegionSelection(UNIT_SELECTION_UI_REGION_INDEX);
		if (selectedEntry == KEY_ESCAPE)
			ToggleActiveUiRegionHighlight();
	} while (selectedEntry == KEY_ESCAPE);
	RestoreModalTextWindow();
	if ((int16)selectableUnitTypeCount <= selectedEntry)
		return -0x01;
	return unitTypeIdList[selectedEntry];
}

// 2507:0A20: draw the active Friendly/Enemy heading for a unit-panel row.
// VERIFIED against ASM 2507:0A20-0AB0.
void DrawUnitAllegianceHeader(word16 headerColorIndex)
{
	char headerText[0x14];
	int16 allegianceIndex;
	word16 textLeft;
	word16 textTop;
	word16 textWidth;
	const char *allegianceText;
	const char *suffixText;

	textLeft = (word16)(ActiveTextWindowLeftTile << 0x03);
	textTop = (word16)((ActiveTextWindowTopTile + 0x07) << 0x03);
	textWidth = (word16)(ActiveTextWindowWidthTiles << 0x03);
	allegianceIndex = UnitEditorAllegiance;
	allegianceText = UnitAllegianceLabelTextTable[allegianceIndex];
	suffixText = FriendlyEnemySuffixText;
	FarStringCopy(headerText, allegianceText);
	FarStringConcat(headerText, suffixText);
	HideMouseCursorOverlay();
	DrawCenteredClippedText(
		headerText,
		0x0000,
		textLeft,
		textTop,
		textWidth,
		LanceEditorLayout.AllegianceHeaderColor[headerColorIndex],
		0x0C);
	ShowMouseCursorOverlay();
}

