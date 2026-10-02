// REVENGE_2507_PILOT_ASSIGNMENT.c
// Reconstructed from the original procedures in segment 2507.

#include "REVENGE_2507_LANCE_EDITOR_INTERNAL.h"

// 2507:5016: prepare pilot-selection records and portrait buffers.
// VERIFIED against ASM 2507:5016-5116.
void PreparePilotSelectionRecords(
	word16 selectionFamily,
	int16 selectionMode,
	word16 loadPresentationResources)
{
	word16 pilotRecordIndex;
	UnitSelectionCard *pilotRecord;
	RevengePilotId pilotId;
	word16 portraitBufferIndex;

	if (loadPresentationResources != FALSE)
	{
		LoadGraphicsResourceToBuffers(
			0x0025,
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
		LoadGraphicsBufferRange(0x0017, 0x001E);
		LoadGraphicsResourceToBuffers(
			0x0026,
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
		LoadGraphicsBufferRange(0x001F, 0x0025);
	}

	if (selectionMode != 0x0000)
	{
		UnitEditorPilotCardCount =
			UnitEditorPilotCardCountByFamily[selectionFamily];
	}

	for (pilotRecordIndex = 0x0000;
		(int16) pilotRecordIndex < (int16) UnitEditorPilotCardCount;
		++pilotRecordIndex)
	{
		pilotRecord = &UnitSelectionCards[pilotRecordIndex];
		if (selectionMode != 0x0000)
		{
			pilotId = (RevengePilotId)PopRandomPilotId();
			pilotRecord->selectionId = pilotId;
			pilotRecord->alternateId = REVENGE_PILOT_ID_NONE;
		}

		pilotRecord->state = 0x01;
		pilotId = pilotRecord->selectionId;
		portraitBufferIndex = PilotPortraitIndexById[pilotId];
		pilotRecord->spriteBuffer = DosAddress_FromValue(HostFarPointer_Encode(
			UnitEditorGraphicsBuffer(portraitBufferIndex)));
	}

	if (selectionMode != 0x0000)
		(void) PopRandomPilotId();
	InitializeLanceAssignments(
		selectionFamily + 0x0003,
		selectionMode);
}

// 2507:5117: prepare, display, and edit one pilot-selection family.
// VERIFIED against ASM 2507:5117-5151.
void RunPilotSelection(
	word16 selectionFamily,
	int16 selectionMode)
{
	SceneTransitionAbortFlag = FALSE;
	PreparePilotSelectionRecords(
		selectionFamily,
		selectionMode,
		TRUE);
	DrawPilotSelectionScreen(selectionFamily);
	RunPilotAssignmentEditor(selectionFamily);
	FreeGraphicsBufferRange(0x0017, 0x0025);
}

// 2507:5152: validate pilot assignments for one selection family.
// VERIFIED against ASM 2507:5152-51EB.
word16 ValidatePilotConfiguration(word16 selectionFamily)
{
	word16 configurationValid;
	word16 lanceGroup;
	word16 unassignedPilotCount;
	word16 pilotRecordIndex;

	configurationValid = TRUE;
	lanceGroup = 0x0000;
	if (UnitEditorPilotCardCount != 0x0000)
	{
		do
		{
			if (UnitEditorSectionEnabled[
				selectionFamily * LANCE_EDITOR_SECTION_COUNT] != FALSE)
			{
				unassignedPilotCount = UnitEditorPilotCardCount;
				for (pilotRecordIndex = 0x0000;
					(int16) pilotRecordIndex <
						(int16) UnitEditorPilotCardCount;
					++pilotRecordIndex)
				{
					if ((UnitSelectionCards[
						pilotRecordIndex].state & 0x01) == 0x00)
					{
						--unassignedPilotCount;
					}
				}

				if (unassignedPilotCount != 0x0000 &&
					(int16) UnitEditorLanceSlotCount[lanceGroup] <
					0x0004)
				{
					configurationValid = FALSE;
				}
			}
			++lanceGroup;
		} while (lanceGroup < 0x0003 && configurationValid != FALSE);
	}

	UnitEditorSectionEnabled[
		selectionFamily * LANCE_EDITOR_SECTION_COUNT + 0x03] =
		(byte)configurationValid;
	return configurationValid;
}

// 2507:51EC: select a lance section and enter its pilot-assignment grid.
// VERIFIED against ASM 2507:51EC-55C5.
void RunPilotAssignmentEditor(word16 selectionFamily)
{
	word16 configurationIndex;
	word16 selectedSection;
	word16 previousSection;
	word16 sectionBeforeInput;
	word16 sectionIndex;
	word16 activateSection;
	word16 finished;
	word16 mouseButtonState;
	word16 mouseButtonEvent;
	int16 inputCode;
	int16 mouseX;
	int16 mouseY;
	int16 textLeftColumn;
	int16 sectionRow;
	int16 fontWidth;
	int16 fontHeight;

	configurationIndex = selectionFamily + 0x0001;
	selectedSection = 0x0000;
	while (UnitEditorSectionEnabled[
		configurationIndex * LANCE_EDITOR_SECTION_COUNT + selectedSection] == 0x00 &&
		selectedSection < 0x0003)
	{
		++selectedSection;
	}
	previousSection = selectedSection;
	textLeftColumn = 0x002B;
	fontWidth = ActiveFontGlyphAdvanceX;
	fontHeight = ActiveFontLineHeight;

	sectionRow = (int16)LanceEditorLayout.PilotEditorSectionRows[selectedSection];
	HideMouseCursorOverlay();
	XorVideoRectangle(
		(int16) (textLeftColumn * fontWidth),
		(int16) (sectionRow * fontHeight),
		(int16) ((textLeftColumn + 0x0007) * fontWidth - 0x0001),
		(int16) ((sectionRow + 0x0001) * fontHeight - 0x0001),
		0x01);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	finished = FALSE;

	while (finished == FALSE)
	{
		activateSection = FALSE;
		sectionBeforeInput = selectedSection;
		inputCode = 0x0000;
		if (ServiceMusicAndCheckKeyboardInput() != 0x0000)
		{
			inputCode = NormalizeNavigationKeyCode(
				ReadTranslatedKeypress());
			if (inputCode == KEY_ESC)
			{
				if (UnitEditorSectionEnabled[
					configurationIndex * LANCE_EDITOR_SECTION_COUNT + 0x03] != 0x00)
					finished = TRUE;
			}
			else if (inputCode == TranslatedExtendedKey(KEY_UP))
			{
				do
				{
					if ((int16) --selectedSection < 0x0000)
						selectedSection = 0x0003;
				} while (UnitEditorSectionEnabled[
					configurationIndex * LANCE_EDITOR_SECTION_COUNT + selectedSection] == 0x00 &&
					selectedSection != sectionBeforeInput);
			}
			else if (inputCode == TranslatedExtendedKey(KEY_DOWN))
			{
				do
				{
					if (++selectedSection > 0x0003)
						selectedSection = 0x0000;
				} while (UnitEditorSectionEnabled[
					configurationIndex * LANCE_EDITOR_SECTION_COUNT + selectedSection] == 0x00 &&
					selectedSection != sectionBeforeInput);
			}
			else if (inputCode == KEY_CARRIAGERETURN || inputCode == KEY_SPACE)
			{
				if (selectedSection == 0x0003)
					finished = TRUE;
				else
					activateSection = TRUE;
			}
		}
		else if (MouseInputDisabled == 0x0000)
		{
			mouseX = (int16) MouseCursorRequestedX;
			mouseY = (int16) MouseY;
			mouseButtonState = MouseButtonState;
			mouseButtonEvent = PendingMouseButtonEvent;
			PendingMouseButtonEvent = 0x0000;

			if (mouseButtonEvent != 0x0000 &&
				(mouseButtonState & MOUSE_BUTTON_RIGHT) != 0x0000 &&
				UnitEditorSectionEnabled[
					configurationIndex * LANCE_EDITOR_SECTION_COUNT + 0x03] != 0x00)
			{
				finished = TRUE;
			}
			else
			{
				for (sectionIndex = 0x0000; sectionIndex < 0x0004;
					++sectionIndex)
				{
					if (UnitEditorSectionEnabled[
						configurationIndex * LANCE_EDITOR_SECTION_COUNT + sectionIndex] == 0x00)
						continue;
					sectionRow = (int16)LanceEditorLayout.PilotEditorSectionRows[sectionIndex];
					if (mouseX >= textLeftColumn * fontWidth &&
						mouseX < (textLeftColumn + 0x0007) * fontWidth &&
						mouseY >= sectionRow * fontHeight &&
						mouseY < (sectionRow + 0x0001) * fontHeight)
					{
						selectedSection = sectionIndex;
						if (mouseButtonEvent != 0x0000 &&
							(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x0000)
						{
							if (selectedSection == 0x0003)
								finished = TRUE;
							else
								activateSection = TRUE;
						}
					}
				}
			}
		}

		if (selectedSection != sectionBeforeInput)
		{
			HideMouseCursorOverlay();
			sectionRow = (int16)LanceEditorLayout.PilotEditorSectionRows[sectionBeforeInput];
			XorVideoRectangle(
				(int16) (textLeftColumn * fontWidth),
				(int16) (sectionRow * fontHeight),
				(int16) ((textLeftColumn + 0x0007) * fontWidth - 0x0001),
				(int16) ((sectionRow + 0x0001) * fontHeight - 0x0001),
				0x01);
			WaitVerticalRetraces(0x0002);
			sectionRow = (int16)LanceEditorLayout.PilotEditorSectionRows[selectedSection];
			XorVideoRectangle(
				(int16) (textLeftColumn * fontWidth),
				(int16) (sectionRow * fontHeight),
				(int16) ((textLeftColumn + 0x0007) * fontWidth - 0x0001),
				(int16) ((sectionRow + 0x0001) * fontHeight - 0x0001),
				0x01);
			ShowMouseCursorOverlay();
		}

		if (selectedSection != previousSection)
		{
			if (previousSection != 0x0003)
				RefreshPilotAssignmentSlots(previousSection, FALSE);
			if (selectedSection != 0x0003)
				RefreshPilotAssignmentSlots(selectedSection, TRUE);
			previousSection = selectedSection;
			FlushPendingInput();
		}

		if (activateSection != FALSE && UnitEditorPilotCardCount != 0x0000)
		{
			RunPilotAssignmentGrid(selectedSection);
			(void) ValidatePilotConfiguration(configurationIndex);
			(void) DrawUnitEditorSectionMenu(configurationIndex);
			HideMouseCursorOverlay();
			sectionRow = (int16)LanceEditorLayout.PilotEditorSectionRows[selectedSection];
			XorVideoRectangle(
				(int16) (textLeftColumn * fontWidth),
				(int16) (sectionRow * fontHeight),
				(int16) ((textLeftColumn + 0x0007) * fontWidth - 0x0001),
				(int16) ((sectionRow + 0x0001) * fontHeight - 0x0001),
				0x01);
			ShowMouseCursorOverlay();
			FlushPendingInput();
		}
	}
}

// 2507:55C6: assign the remaining pilot cards to one lance's unit slots.
// VERIFIED against ASM 2507:55C6-5C25.
void RunPilotAssignmentGrid(word16 lanceGroupIndex)
{
	word16 selectedLanceSlot;
	word16 previousLanceSlot;
	word16 selectedAssignmentIndex;
	word16 previousAssignmentIndex;
	word16 assignmentGroupBase;
	word16 selectedPilotRecord;
	word16 previousPilotRecord;
	word16 sourcePilotRecord;
	word16 destinationPilotRecord;
	word16 actionRequested;
	word16 finished;
	word16 mouseButtonState;
	word16 mouseButtonEvent;
	RevengeUnitLanceAssignment *assignment;
	UnitSelectionCard *pilotCard;
	UnitSelectionCard *sourcePilotCard;
	UnitSelectionCard *destinationPilotCard;
	int16 inputCode;
	int16 mouseX;
	int16 mouseY;

	selectedLanceSlot = 0x0000;
	previousLanceSlot = selectedLanceSlot;
	assignmentGroupBase = lanceGroupIndex * 0x0004;
	selectedAssignmentIndex = assignmentGroupBase + selectedLanceSlot;
	assignment = &LanceAssignments[selectedAssignmentIndex];
	assignment->style |= 0x01;
	DrawLanceAssignmentSlot(selectedAssignmentIndex, TRUE, FALSE);

	selectedPilotRecord = 0x0000;
	previousPilotRecord = selectedPilotRecord;
	pilotCard = &UnitSelectionCards[selectedPilotRecord];
	pilotCard->state |= 0x02;
	DrawPilotSelectionSlot(selectedPilotRecord, TRUE, 0x0001);
	FlushPendingInput();
	finished = FALSE;

	while (finished == FALSE)
	{
		actionRequested = FALSE;
		inputCode = 0x0000;
		if (ServiceMusicAndCheckKeyboardInput() != 0x0000)
		{
			inputCode = NormalizeNavigationKeyCode(
				ReadTranslatedKeypress());
			if (inputCode == KEY_ESC)
			{
				finished = TRUE;
				actionRequested = TRUE;
			}
			else if (inputCode == TranslatedExtendedKey(KEY_UP))
			{
				--selectedLanceSlot;
			}
			else if (inputCode == TranslatedExtendedKey(KEY_DOWN))
			{
				++selectedLanceSlot;
			}
			else if (inputCode == TranslatedExtendedKey(KEY_LEFT))
			{
				--selectedPilotRecord;
			}
			else if (inputCode == TranslatedExtendedKey(KEY_RIGHT))
			{
				++selectedPilotRecord;
			}
			else if (inputCode == KEY_CARRIAGERETURN || inputCode == KEY_SPACE)
			{
				if (selectedLanceSlot == 0x0004)
					finished = TRUE;
				actionRequested = TRUE;
			}
			if (selectedLanceSlot > 0x0004)
				selectedLanceSlot = 0x0000;
			if (selectedLanceSlot > UnitEditorLanceSlotCount[lanceGroupIndex])
				selectedLanceSlot = 0x0004;
			if ((int16) selectedLanceSlot < 0x0000)
				selectedLanceSlot = 0x0004;
			if (selectedPilotRecord >= UnitEditorPilotCardCount)
				selectedPilotRecord = 0x0000;
			if ((int16) selectedPilotRecord < 0x0000)
				selectedPilotRecord = UnitEditorPilotCardCount - 0x0001;
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
				finished = TRUE;
				actionRequested = TRUE;
			}
			else
			{
				for (sourcePilotRecord = 0x0000;
					sourcePilotRecord < UnitEditorPilotCardCount;
					++sourcePilotRecord)
				{
					sourcePilotCard = &UnitSelectionCards[sourcePilotRecord];
					if (mouseX >= (int16)(sourcePilotCard->left + 0x0001) &&
						mouseX < (int16)(sourcePilotCard->left + 0x003F) &&
						mouseY >= (int16)(sourcePilotCard->top + 0x0001) &&
						mouseY < (int16)(sourcePilotCard->top + 0x0037))
					{
						selectedPilotRecord = sourcePilotRecord;
						if (mouseButtonEvent != 0x0000 &&
							(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x0000)
						{
							if (selectedLanceSlot == 0x0004)
								finished = TRUE;
							actionRequested = TRUE;
						}
					}
				}

				for (sourcePilotRecord = 0x0000;
					sourcePilotRecord <= UnitEditorLanceSlotCount[lanceGroupIndex] &&
					sourcePilotRecord < 0x0004;
					++sourcePilotRecord)
				{
					assignment = &LanceAssignments[
						assignmentGroupBase + sourcePilotRecord];
					if (mouseX >= (int16)assignment->left &&
						mouseX < (int16)(assignment->left + 0x0054) &&
						mouseY >= (int16)assignment->top &&
						mouseY < (int16)(assignment->top + 0x0018))
					{
						if (mouseButtonEvent != 0x0000 &&
							(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x0000 &&
							selectedLanceSlot == sourcePilotRecord)
							actionRequested = TRUE;
						selectedLanceSlot = sourcePilotRecord;
					}
				}

				if (mouseX >= (int16) UnitEditorExitButtonLeft &&
					mouseX < (int16) (UnitEditorExitButtonLeft + 0x0054) &&
					mouseY >= (int16) UnitEditorExitButtonTop &&
					mouseY < (int16) (UnitEditorExitButtonTop + 0x0018))
				{
					if (mouseButtonEvent != 0x0000 &&
						(mouseButtonState & MOUSE_BUTTON_LEFT) != 0x0000)
					{
						if (selectedLanceSlot == 0x0004)
							finished = TRUE;
						actionRequested = TRUE;
					}
					selectedLanceSlot = 0x0004;
				}
			}
		}

		selectedAssignmentIndex = assignmentGroupBase + selectedLanceSlot;
		previousAssignmentIndex = assignmentGroupBase + previousLanceSlot;
		if (selectedLanceSlot != previousLanceSlot)
		{
			if (previousLanceSlot == 0x0004)
			{
				UnitEditorExitButtonState &= 0xFE;
				DrawLanceAssignmentSlot(0x0000, TRUE, TRUE);
			}
			else
			{
				LanceAssignments[previousAssignmentIndex].style &= 0xFE;
				DrawLanceAssignmentSlot(
					previousAssignmentIndex, TRUE, FALSE);
			}
			if (selectedLanceSlot == 0x0004)
			{
				UnitEditorExitButtonState |= 0x01;
				DrawLanceAssignmentSlot(0x0000, TRUE, TRUE);
			}
			else
			{
				LanceAssignments[selectedAssignmentIndex].style |= 0x01;
				DrawLanceAssignmentSlot(
					selectedAssignmentIndex, TRUE, FALSE);
			}
			previousLanceSlot = selectedLanceSlot;
		}

		if (selectedPilotRecord != previousPilotRecord)
		{
			UnitSelectionCards[previousPilotRecord].state &= 0xFD;
			DrawPilotSelectionSlot(previousPilotRecord, TRUE, 0x0001);
			UnitSelectionCards[selectedPilotRecord].state |= 0x02;
			DrawPilotSelectionSlot(selectedPilotRecord, TRUE, 0x0001);
			previousPilotRecord = selectedPilotRecord;
		}

		if (actionRequested == FALSE || finished != FALSE ||
			UnitEditorLanceSlotCount[lanceGroupIndex] >= 0x0004)
			continue;
		assignment = &LanceAssignments[selectedAssignmentIndex];
		if ((assignment->style & 0x02) != 0x00)
			continue;

		pilotCard = &UnitSelectionCards[selectedPilotRecord];
		assignment->pilotId = pilotCard->selectionId;
		assignment->style |= 0x02;
		DrawLanceAssignmentSlot(selectedAssignmentIndex, TRUE, FALSE);
		pilotCard->state = 0x00;
		DrawPilotSelectionSlot(selectedPilotRecord, TRUE, 0xFFFF);
		pilotCard->selectionId = REVENGE_PILOT_ID_NONE;
		pilotCard->alternateId = REVENGE_PILOT_ID_NONE;
		++UnitEditorLanceSlotCount[lanceGroupIndex];
		--UnitEditorPilotCardCount;
		if ((int16) UnitEditorPilotCardCount <= 0x0000)
		{
			UnitEditorPilotCardCount = 0x0000;
			finished = TRUE;
			continue;
		}
		if (selectedPilotRecord >= UnitEditorPilotCardCount)
			selectedPilotRecord = UnitEditorPilotCardCount - 0x0001;

		destinationPilotRecord = 0x0000;
		for (sourcePilotRecord = 0x0000;
			sourcePilotRecord <= UnitEditorPilotCardCount;
			++sourcePilotRecord)
		{
			sourcePilotCard = &UnitSelectionCards[sourcePilotRecord];
			if (sourcePilotCard->state == 0x00)
				continue;
			destinationPilotCard = &UnitSelectionCards[destinationPilotRecord];
			if (destinationPilotRecord != sourcePilotRecord)
			{
				destinationPilotCard->state = sourcePilotCard->state;
				destinationPilotCard->selectionId = sourcePilotCard->selectionId;
				destinationPilotCard->alternateId = sourcePilotCard->alternateId;
				destinationPilotCard->spriteBuffer = sourcePilotCard->spriteBuffer;
				DrawPilotSelectionSlot(
					destinationPilotRecord, TRUE, 0x0001);
				sourcePilotCard->state = 0x00;
				DrawPilotSelectionSlot(
					sourcePilotRecord, TRUE, 0xFFFF);
				sourcePilotCard->selectionId = REVENGE_PILOT_ID_NONE;
				sourcePilotCard->alternateId = REVENGE_PILOT_ID_NONE;
			}
			if (destinationPilotRecord == selectedPilotRecord)
			{
				destinationPilotCard->state |= 0x02;
				DrawPilotSelectionSlot(
					destinationPilotRecord, TRUE, 0x0001);
				previousPilotRecord = selectedPilotRecord;
			}
			++destinationPilotRecord;
		}
		if (UnitEditorLanceSlotCount[lanceGroupIndex] == 0x0004)
			finished = TRUE;
	}

	if (selectedLanceSlot != 0x0004)
	{
		previousAssignmentIndex = assignmentGroupBase + previousLanceSlot;
		LanceAssignments[previousAssignmentIndex].style &= 0xFE;
		DrawLanceAssignmentSlot(previousAssignmentIndex, TRUE, FALSE);
		UnitEditorExitButtonState |= 0x01;
		DrawLanceAssignmentSlot(0x0000, TRUE, TRUE);
	}
	UnitEditorExitButtonState &= 0xFE;
	DrawLanceAssignmentSlot(0x0000, TRUE, TRUE);
	if (UnitEditorPilotCardCount != 0x0000)
	{
		UnitSelectionCards[selectedPilotRecord].state &= 0xFD;
		DrawPilotSelectionSlot(selectedPilotRecord, TRUE, 0x0001);
	}
}

// 2507:5C26: draw the complete pilot-selection screen and active family.
// VERIFIED against ASM 2507:5C26-5CE6.
void DrawPilotSelectionScreen(word16 selectionFamily)
{
	int16 selectedLanceGroup;
	word16 pilotSlot;

	HideMouseCursorOverlay();
	SetActiveRenderTarget(PrimaryScreenBuffer);
	DrawSelectionScreenBackground();
	(void) ValidatePilotConfiguration(selectionFamily + 0x0001);
	selectedLanceGroup = DrawUnitEditorSectionMenu(
		selectionFamily + 0x0001);

	for (pilotSlot = 0x0000; pilotSlot < 0x0006; ++pilotSlot)
	{
		if ((int16) pilotSlot >= (int16) UnitEditorPilotCardCount)
		{
			DrawPilotSelectionSlot(
				pilotSlot,
				FALSE,
				-0x0001);
		}
	}
	DrawExperienceAndGunneryHeaders(0x0047);
	DrawExperienceAndGunneryHeaders(0x00AC);

	SetActiveRenderTarget(VideoFramebuffer);
	LoadScreenPalette(0x0025);
	CopyClippedVideoRegion(
		0x0000,
		0x0000,
		0x0000,
		0x0000,
		0x0028,
		0x00C8,
		PrimaryScreenBuffer,
		VideoFramebuffer);
	ShowMouseCursorOverlay();
	RefreshPilotAssignmentSlots(
		(word16) selectedLanceGroup,
		TRUE);
}

// 2507:5CE7: redraw pilot cards and the assignment slots for one family.
// VERIFIED against ASM 2507:5CE7-5DBD.
void RefreshPilotAssignmentSlots(
	word16 selectionFamily,
	word16 showPilotCards)
{
	word16 pilotRecordIndex;
	word16 assignmentIndex;
	word16 lastAssignmentIndex;

	for (pilotRecordIndex = 0x0000;
		(int16) pilotRecordIndex < (int16) UnitEditorPilotCardCount;
		++pilotRecordIndex)
	{
		UnitSelectionCards[pilotRecordIndex].state &= 0xFD;
		DrawPilotSelectionSlot(
			pilotRecordIndex,
			TRUE,
			showPilotCards != FALSE ? 0x0000 : -0x0001);
	}

	assignmentIndex = selectionFamily * 0x0004;
	lastAssignmentIndex = assignmentIndex +
		UnitEditorLanceSlotCount[selectionFamily];
	while ((int16) assignmentIndex < (int16) lastAssignmentIndex)
	{
		LanceAssignments[assignmentIndex].style &= 0xFE;
		DrawLanceAssignmentSlot(
			assignmentIndex,
			showPilotCards != FALSE ? TRUE : FALSE,
			FALSE);
		++assignmentIndex;
	}

	DrawLanceAssignmentSlot(0x0000, TRUE, TRUE);
}

// 2507:5DBE: draw one pilot portrait card and its identifying text.
// VERIFIED against ASM 2507:5DBE-6092.
void DrawPilotSelectionSlot(
	word16 pilotRecordIndex,
	word16 redrawBackground,
	int16 displayMode)
{
	byte *savedRenderTarget;
	UnitSelectionCard *pilotRecord;
	RevengePilotRosterRecord *pilot;
	int16 leftX;
	int16 topY;
	word16 width;
	byte flags;
	word16 textColor;
	int16 pilotId;
	int16 identityIndex;
	int16 labelIndex;
	const char *text;

	HideMouseCursorOverlay();
	savedRenderTarget = ActiveRenderTarget;
	SetActiveRenderTarget(PrimaryScreenBuffer);

	pilotRecord = &UnitSelectionCards[pilotRecordIndex];
	leftX = (int16)pilotRecord->left;
	topY = (int16)pilotRecord->top;
	width = pilotRecord->width;
	flags = pilotRecord->state;
	if (displayMode == -0x0001)
	{
		FillVideoRectangle(
			(int16) (leftX + 0x0002),
			(int16) (topY + 0x0002),
			(int16) (leftX + 0x003D),
			(int16) (topY + 0x0035),
			0x000C);
	}
	else
	{
		DrawClippedSprite(
			ActiveRenderTarget,
			(const byte *)LANCE_EDITOR_FAR(
				const byte, pilotRecord->spriteBuffer),
			leftX,
			topY,
			0x00);
	}

	DrawClippedAxisAlignedLine(
		leftX, topY, (int16) (leftX + 0x003F), topY, 0x000E);
	if ((flags & 0xFE) != 0x00)
	{
		DrawClippedRectangleOutline(
			(int16) (leftX + 0x0001),
			(int16) (topY + 0x0001),
			(int16) (leftX + 0x003E),
			(int16) (topY + 0x0036),
			0x000F);
	}
	else
	{
		DrawClippedAxisAlignedLine(
			(int16) (leftX + 0x0001),
			(int16) (topY + 0x0001),
			(int16) (leftX + 0x0001),
			(int16) (topY + 0x0036),
			0x000C);
		DrawClippedAxisAlignedLine(
			(int16) (leftX + 0x0001),
			(int16) (topY + 0x0001),
			(int16) (leftX + 0x003E),
			(int16) (topY + 0x0001),
			0x000C);
		DrawClippedAxisAlignedLine(
			(int16) (leftX + 0x003E),
			(int16) (topY + 0x0001),
			(int16) (leftX + 0x003E),
			(int16) (topY + 0x0036),
			0x000E);
		DrawClippedAxisAlignedLine(
			(int16) (leftX + 0x0001),
			(int16) (topY + 0x0036),
			(int16) (leftX + 0x003E),
			(int16) (topY + 0x0036),
			0x000E);
	}

	if (redrawBackground != FALSE)
	{
		CopyClippedVideoRegion(
			(int16) (leftX >> 0x03),
			topY,
			(int16) (leftX >> 0x03),
			topY,
			0x0008,
			0x0038,
			PrimaryScreenBuffer,
			VideoFramebuffer);
	}
	SetActiveRenderTarget(savedRenderTarget);
	ShowMouseCursorOverlay();

	if (displayMode == -0x0001)
		textColor = 0x000D;
	else
		textColor = LanceEditorLayout.PilotCardTextColor[flags];

	HideMouseCursorOverlay();
	pilotId = pilotRecord->selectionId;
	pilot = &PilotRoster[pilotId];
	identityIndex = pilot->identityId;
	text = PilotGivenNameTextTable[identityIndex];
	DrawCenteredClippedText(
		text,
		0x0000,
		(word16) (leftX - 0x0001),
		(word16) (topY + 0x0038),
		width,
		(byte) textColor,
		0x00);

	topY = (int16) (topY + ActiveFontLineHeight);
	text = PilotSurnameTextTable[identityIndex];
	DrawCenteredClippedText(
		text,
		0x0000,
		(word16) (leftX - 0x0001),
		(word16) (topY + 0x0038),
		width,
		(byte) textColor,
		0x00);

	topY = (int16) (topY + 0x0047 -
		ActiveFontLineHeight);
	labelIndex = pilot->experienceIndex;
	text = PilotExperienceLabelTextTable[labelIndex];
	DrawLeftAlignedClippedText(
		text,
		(word16) leftX,
		(word16) topY,
		width,
		(byte) textColor,
		0x00);

	topY = (int16) (topY + 0x0009);
	labelIndex = pilot->gunneryIndex - 0x0002;
	text = PilotGunneryLabelTextTable[labelIndex];
	DrawLeftAlignedClippedText(
		text,
		(word16) leftX,
		(word16) topY,
		width,
		(byte) textColor,
		0x00);
	ShowMouseCursorOverlay();
}

// 2507:6093: remove and return one random pilot ID from DS:1BAD.
// VERIFIED against ASM 2507:6093-60D1.
int16 PopRandomPilotId(void)
{
	word16 selectedIndex;
	int16 pilotId;
	word16 randomPilotCount;

	randomPilotCount = RandomSelectionPoolCount;
	selectedIndex = (word16) RandomInRangeInclusive(
		0x0000,
		(word16) (randomPilotCount - 0x0001));
	pilotId = RandomPilotPool[selectedIndex];
	RandomPilotPool[selectedIndex] =
		RandomPilotPool[randomPilotCount - 0x0001];
	RandomPilotPool[randomPilotCount - 0x0001] =
		(byte) REVENGE_PILOT_ID_NONE;
	--RandomSelectionPoolCount;
	return pilotId;
}

