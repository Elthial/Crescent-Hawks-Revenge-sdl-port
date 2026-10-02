// REVENGE_0D73_CAMPAIGN_PRESENTATION.c
// Procedures reconstructed from REVENGE.EXE segment 0D73.

#include "REVENGE_0D73_CAMPAIGN_INTERNAL.h"
#include "revenge/debug.h"

// 0D73:2A5D: void OpenModalTextWindow(Stack word16 wArg04, Stack word16 wArg06)
// Called from:
//      ShowConfirmationDialog
//      RunInGameMenu
//      ShowScenarioMessage
//      SaveGame
//      LoadGame
//      RunGameOptionsMenu
void OpenModalTextWindow(word16 windowIndex, word16 clearAndFrame)
{
	ModalSavedTextWindow = ActiveTextWindowIndex;
	SelectTextWindow(windowIndex);
	ActiveTextBackgroundColor = 0x00;
	ModalBackingX = ActiveTextWindowLeftTile - 0x01;
	ModalBackingY =
		(ActiveTextWindowTopTile - 0x01) << 0x03;
	ModalBackingWidth = (word16) ActiveTextWindowWidthTiles + 0x02;
	ModalBackingHeight =
		((word16)ActiveTextWindowHeightTiles + 0x02) << 0x03;
	HideMouseCursorOverlay();
	CopyClippedVideoRegion(ModalBackingX, ModalBackingY, ModalBackingX, ModalBackingY, ModalBackingWidth, ModalBackingHeight, VideoFramebuffer, PrimaryScreenBuffer);
	if (clearAndFrame != 0x00)
	{
		ClearActiveTextWindow();
		DrawActiveTextWindowFrame(0x00);
	}
	ShowMouseCursorOverlay();
}

// 0D73:2AEE: void RestoreModalTextWindow(void)
// Called from:
//      ShowConfirmationDialog
//      RunInGameMenu
//      ShowScenarioMessage
//      SaveGame
//      LoadGame
//      RunGameOptionsMenu
void RestoreModalTextWindow(void)
{
	HideMouseCursorOverlay();
	CopyClippedVideoRegion(ModalBackingX, ModalBackingY, ModalBackingX, ModalBackingY, ModalBackingWidth, ModalBackingHeight, PrimaryScreenBuffer, VideoFramebuffer);
	ShowMouseCursorOverlay();
	SelectTextWindow(ModalSavedTextWindow);
}

// 0D73:2B33: compose the communications portrait and foreground, present it,
// then display the associated indexed story message.
// Verified against 0D73:2B33-2D00.
void PresentAnimatedScreenAndMessage(
	word16 screenResourceIndex,
	word16 messageIndex)
{
	word16 passIndex;
	byte *workBuffer;
	byte *renderTarget;
	const byte *portraitSprite;
	const byte *foregroundSprite;

	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x00)
		SceneTransitionAbortFlag = FALSE;
	if (SceneTransitionAbortFlag != FALSE)
		return;

	LoadGraphicsResourceToBuffers(
		0x19,
		SecondaryScreenBuffer,
		PrimaryScreenBuffer);
	BuildMissionSpriteBackingBuffer(0x01);
	SavedMissionBacking = MissionSpriteBacking;

	LoadGraphicsResourceToBuffers(
		screenResourceIndex,
		SecondaryScreenBuffer,
		PrimaryScreenBuffer);
	BuildMissionSpriteBackingBuffer(0x00);
	LoadAndPresentScreen(0x19);

	workBuffer = PrimaryScreenBuffer;
	renderTarget = ActiveRenderTarget;
	portraitSprite = MissionSpriteBacking;
	foregroundSprite = SavedMissionBacking;

	HideMouseCursorOverlay();
	DrawClippedSprite(
		workBuffer, portraitSprite, 0x50, 0x08, 0x00);
	DrawClippedSprite(
		workBuffer, foregroundSprite, 0x50, 0x08, 0x00);
	CopyClippedVideoRegion(
		0x0A, 0x08, 0x0A, 0x08, 0x14, 0x88,
		workBuffer,
		VideoFramebuffer);
	DrawClippedSprite(
		workBuffer, portraitSprite, 0x50, 0x08, 0x00);
	CopyClippedVideoRegion(
		0x0A, 0x08, 0x0A, 0x08, 0x14, 0x88,
		workBuffer,
		VideoFramebuffer);
	for (passIndex = 0x00; passIndex < 0x03; ++passIndex)
	{
		DrawClippedSprite(
			renderTarget, foregroundSprite, 0x50, 0x08, 0x00);
		CopyClippedVideoRegion(
			0x0A, 0x08, 0x0A, 0x08, 0x14, 0x88,
			workBuffer,
			VideoFramebuffer);
	}
	ShowMouseCursorOverlay();
	FreeGraphicsBufferRange(0x11, 0x12);
	if (SceneTransitionAbortFlag == FALSE)
		ShowStoryMessageAndWait(messageIndex);
}

// 0D73:2D01: display one indexed story message in a saved modal window.
// Verified against 0D73:2D01-2D9A.
void ShowStoryMessageAndWait(word16 messageIndex)
{
	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x00)
		SceneTransitionAbortFlag = FALSE;
	if (SceneTransitionAbortFlag != FALSE || messageIndex == 0x00)
		return;

	TextWindowContexts[0x0F].heightTiles = 0x06;
	TextWindowContexts[0x0F].topTile = 0x14;
	TextWindowContexts[0x0F].cursorColumn = 0x0000;
	TextWindowContexts[0x0F].cursorRow = 0x0000;
	ActiveTextCursorRow = 0x0000;
	ActiveTextCursorColumn = 0x0000;
	OpenModalTextWindow(0x0F, FALSE);
	HideMouseCursorOverlay();
	RenderFormattedText(
		CampaignMessageTextTable[messageIndex]);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x00)
	{
		PresentationCallback();
		SceneTransitionAbortFlag = FALSE;
	}
	else
	{
		WaitForDismissInput();
	}
	RestoreModalTextWindow();
}

// 0D73:2D9B: present an indexed story screen with its captured portrait.
// Verified against 0D73:2D9B-2E2D.
void PresentStoryScreenAndMessage(
	word16 graphicsResourceIndex,
	word16 messageIndex)
{
	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x00)
		SceneTransitionAbortFlag = FALSE;
	if (SceneTransitionAbortFlag == FALSE)
	{
		LoadGraphicsResourceToBuffers(
			graphicsResourceIndex,
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
		BuildMissionSpriteBackingBuffer(0x02);
		LoadAndPresentScreen(0x1A);
		HideMouseCursorOverlay();
		DrawClippedSprite(
			ActiveRenderTarget,
			MissionSpriteBacking,
			0x08,
			0x08,
			0x00);
		ShowMouseCursorOverlay();
		FreeGraphicsBufferRange(0x11, 0x11);
	}
	if (SceneTransitionAbortFlag == FALSE)
		ShowStoryMessage(messageIndex);
}

// 0D73:2E2E: draw one indexed story message in text window 10h and wait.
// Verified against 0D73:2E2E-2E7B.
void ShowStoryMessage(word16 messageIndex)
{
	if (SceneTransitionAbortFlag != FALSE || messageIndex == 0x00)
		return;

	HideMouseCursorOverlay();
	SelectAndClearTextWindow(0x10);
	RenderFormattedText(
		CampaignMessageTextTable[messageIndex]);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	WaitForDismissInput();
}

/* 0D73:2E7C is reconstructed in Text/REVENGE_0D73_SCENARIO_MESSAGES.c. */

// 0D73:2F16: Register word16 PlayTitleTextSequence()
// Called from:
//      RunTitleAndMainMenu
// Verified against 0D73:2F16-2F5E.
word16 PlayTitleTextSequence(void)
{
	word16 continueSequence = TRUE;
	word16 titleLineIndex = 0x0000;
	while (titleLineIndex < 0x0012 && continueSequence != FALSE)
	{
		const char *text =
			TitleTextTable[titleLineIndex];

		continueSequence = AnimateTitleTextLine(text);
		++titleLineIndex;
	}
	if (continueSequence != FALSE &&
		WaitForDismissInputOrTimeout(PresentationDismissTimeout) != 0x00)
		continueSequence = FALSE;
	return continueSequence;
}

// 0D73:2F5F: Register word16 AnimateTitleTextLine(Stack const char * dwArg04)
// Called from:
//      PlayTitleTextSequence
word16 AnimateTitleTextLine(const char *text)
{
	int16 fontLineHeight = ActiveFontLineHeight;
	word16 windowHeightPixels =
		ActiveTextWindowHeightTiles << 0x03;
	word16 textY = (word16) (((int16) windowHeightPixels / fontLineHeight
		- 0x01) * fontLineHeight - 0x02);

	// Verified against 0D73:2F5F-309B.
	HideMouseCursorOverlay();
	CopyClippedVideoRegion(0x0C, textY, 0x0C, textY, 0x1C, 0x06,
		VideoFramebuffer,
		PrimaryScreenBuffer);
	ShowMouseCursorOverlay();
	word16 completed = TRUE;
	word16 fadeIndex;
	for (fadeIndex = 0x00; fadeIndex < 0x04; ++fadeIndex)
	{
		HideMouseCursorOverlay();
		DrawCenteredClippedText(text, 0x00, 0x00, textY, 0x0140,
			MissionFadeColorTable[fadeIndex], 0x00);
		ShowMouseCursorOverlay();
		WaitVerticalRetraces(0x02);
	}
	if (WaitForDismissInputOrTimeout(0x78) != 0x00)
		completed = FALSE;
	if (completed != FALSE)
	{
		for (fadeIndex = 0x04; (int16)fadeIndex >= 0x00; --fadeIndex)
		{
			HideMouseCursorOverlay();
			DrawCenteredClippedText(text, 0x00, 0x00, textY, 0x0140,
				MissionFadeColorTable[fadeIndex], 0x00);
			ShowMouseCursorOverlay();
			WaitVerticalRetraces(0x02);
		}
	}
	HideMouseCursorOverlay();
	CopyClippedVideoRegion(0x0C, textY, 0x0C, textY, 0x1C, 0x06,
		PrimaryScreenBuffer,
		VideoFramebuffer);
	ShowMouseCursorOverlay();
	return completed;
}

// 0D73:324E: void LoadScreenPalette(word16 screenResourceIndex)
// Called from:
//      LoadAndPresentScreen
void LoadScreenPalette(word16 screenResourceIndex)
{
	if (VideoAdapterType == VIDEO_ADAPTER_VGA)
	{
		int16 paletteResourceIndex =
			ScreenPaletteResourceByScreen[screenResourceIndex];
		ReadWholeResourceFile(
			CACHED_FILE_NAME(paletteResourceIndex),
			VideoPaletteData, VGA_DAC_PALETTE_BYTE_COUNT);
		ClearActiveVideoBuffer();
		LoadVideoPalette(VideoPaletteData);
	}
	else
		ClearActiveVideoBuffer();
}

/* 0D73:329E is reconstructed in Graphics/REVENGE_0D73_PALETTE.c. */

// 0D73:32F4: void LoadScreenAssetToWorkBuffer(word16 resourceIndex)
// Called from:
//      RunCampaignLoop
//      LoadAndPresentScreen
void LoadScreenAssetToWorkBuffer(word16 resourceIndex)
{
	// Verified against 0D73:32F4-33C0.
	if (VideoAdapterType == VIDEO_ADAPTER_VGA)
		LoadAndDecodePackedResource(
			CACHED_FILE_NAME(resourceIndex),
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
	else
	{
		LoadAndDecodePackedResource(
			CACHED_FILE_NAME(resourceIndex),
			PrimaryScreenBuffer,
			SecondaryScreenBuffer);
		PackLowNibblesTo4Bpp(
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
	}
	if (VideoAdapterType == VIDEO_ADAPTER_CGA)
	{
		word16 cgaRowByteCount = 0x50;
		if (CgaNarrowStrideMode != 0x00)
			cgaRowByteCount = 0x04;
		ConvertCgaPackedPixels(
			PrimaryScreenBuffer,
			PrimaryScreenBuffer,
			(byte) cgaRowByteCount,
			0x3E80);
		if (CgaNarrowStrideMode != 0x00)
			RepackCgaAlternateScanlines(
				PrimaryScreenBuffer);
	}
}

// 0D73:33C1: void LoadAndPresentScreen(word16 resourceIndex)
// Called from:
//      PresentScreenAndMessage
void LoadAndPresentScreen(word16 resourceIndex)
{
	LoadScreenAssetToWorkBuffer(resourceIndex);
	if (VideoAdapterType == VIDEO_ADAPTER_EGA)
		ConvertPackedPixelsToEGAPlanar(
			PrimaryScreenBuffer,
			PrimaryScreenBuffer,
			0x3E80);
	HideMouseCursorOverlay();
	LoadScreenPalette(resourceIndex);
	CopyBufferToVideoRegion(
		0x00, 0x00, 0x28, 0x19,
		PrimaryScreenBuffer);
	ShowMouseCursorOverlay();
}

/* 0D73:341F is reconstructed in Campaign/REVENGE_0D73_PRESENTATION.c. */

// 0D73:347D: present a campaign scene with its optional indexed message.
// VERIFIED against 0D73:347D-350F.
void PresentCampaignScene(
	word16 graphicsResourceIndex,
	word16 spriteLayoutIndex,
	word16 messageIndex)
{
	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x0000)
		SceneTransitionAbortFlag = FALSE;
	if (SceneTransitionAbortFlag != FALSE)
		return;

	LoadGraphicsResourceToBuffers(
		graphicsResourceIndex,
		SecondaryScreenBuffer,
		PrimaryScreenBuffer);
	BuildMissionSpriteBackingBuffer(spriteLayoutIndex + 0x0003);
	HideMouseCursorOverlay();
	LoadScreenPalette(graphicsResourceIndex);
	DrawClippedSprite(
		ActiveRenderTarget,
		MissionSpriteBacking,
		0x0000,
		0x0001,
		0x0000);
	ShowMouseCursorOverlay();
	FreeGraphicsBufferRange(0x0011, 0x0011);
	if (SceneTransitionAbortFlag == FALSE)
		ShowCampaignMessageAndWait(messageIndex);
}

// 0D73:3510: display one indexed campaign message and wait or invoke the
// installed presentation callback.
// VERIFIED against 0D73:3510-35A9.
void ShowCampaignMessageAndWait(word16 messageIndex)
{
	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x0000)
		SceneTransitionAbortFlag = FALSE;
	if (SceneTransitionAbortFlag != FALSE || messageIndex == 0x0000)
		return;

	TextWindowContexts[0x0F].heightTiles =
		OriginalData_PresentationMessageRecords()[messageIndex].windowHeight;
	REVENGE_PRESERVATION_TRACE("text: campaign message=%u height=%d text=%p\n",
		messageIndex,
		OriginalData_PresentationMessageRecords()[messageIndex].windowHeight,
		(void *)CampaignMessageTextTable[messageIndex]);
	TextWindowContexts[0x0F].topTile = 0x000E;
	OpenModalTextWindow(0x000F, 0x0001);
	HideMouseCursorOverlay();
	RenderFormattedText(
		CampaignMessageTextTable[messageIndex]);
	ShowMouseCursorOverlay();
	FlushPendingInput();
	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x0000)
	{
		PresentationCallback();
		SceneTransitionAbortFlag = FALSE;
	}
	else
		WaitForDismissInput();
	RestoreModalTextWindow();
}

// 0D73:35AA: prepare the background and optional sprite used by the mission-date panel.
// Called from:
//      DisplayMissionDate
// Verified against 0D73:35AA-365B.
void PrepareMissionDateScreen(int16 presentationMode)
{
	if (presentationMode >= 0x02)
	{
		LoadGraphicsResourceToBuffers(0x18,
			SecondaryScreenBuffer,
			PrimaryScreenBuffer);
		if (presentationMode == 0x02)
			BuildMissionSpriteBackingBuffer(0x09);
		else
			BuildMissionSpriteBackingBuffer(0x0A);
	}
	if (presentationMode < 0x02 || presentationMode == 0x04)
	{
		word16 screenResourceIndex;
		if (presentationMode < 0x02)
			screenResourceIndex = presentationMode + 0x16;
		else
			screenResourceIndex = 0x17;
		LoadAndPresentScreen(screenResourceIndex);
		DrawMissionHeaderFrame();
	}
	if (presentationMode >= 0x02)
	{
		HideMouseCursorOverlay();
		DrawClippedSprite(
			ActiveRenderTarget,
			MissionSpriteBacking,
			0x68, 0x23, 0x00);
		ShowMouseCursorOverlay();
		DrawMissionHeaderFrame();
		FreeGraphicsBufferRange(0x11, 0x11);
	}
}


/* 0D73:365C is reconstructed in Graphics/REVENGE_0D73_MISSION_HEADER.c. */

// 0D73:376C: animate the indexed campaign date and optional map highlight.
void DisplayMissionDate(
	int16 presentationMode,
	int16 blinkRegionIndex,
	word16 dateEntryIndex,
	word16 followupMessageIndex,
	word16 redrawPresentation)
{
	int16 animatedMonth;
	int16 currentMonth;
	int16 rectangleExtent;
	word16 animatedYear;
	word16 currentYear;
	word16 monthsRemaining;
	word16 previousMonthsRemaining;
	word16 previousWaitTicks;
	word16 textColor;
	word16 waitTicks;
	word16 leftX;
	word16 topY;
	char dateText[0x1A];
	char yearText[0x0A];

	// Format a mission date using the indexed JAN-DEC far-pointer table at DS:2459 and render the surrounding mission/date panel.
	if (SceneTransitionAbortFlag == FALSE)
	{
		if (presentationMode != -0x01 && redrawPresentation == FALSE)
			PrepareMissionDateScreen(presentationMode);
		HideMouseCursorOverlay();
		DrawCenteredClippedText(MissionDateLabelTextTable[dateEntryIndex],
			0x00, 0x00, 0x10, 0x0140, 0x0F, 0x0D);
		currentMonth = MissionDateMonthIndex[dateEntryIndex];
		currentYear = MissionDateYear[dateEntryIndex];
		monthsRemaining = MissionDateAdvanceMonths[dateEntryIndex];
		FarStringCopy(dateText, MonthNameTextTable[(word16)currentMonth]);
		FarStringConcat(dateText, DateCommaSpaceText);
		IntegerToString(currentYear, yearText, 0x0A);
		RemoveLeadingSpacesFrom(yearText, 0x01);
		TrimTrailingEncodedSpaces(yearText);
		FarStringConcat(dateText, yearText);
		DrawCenteredClippedText(dateText, 0x00, 0x00, 0x18, 0x0140, 0x0F, 0x0D);
		ShowMouseCursorOverlay();
		FlushInputAndWait(0x39);
		textColor = 0x0F;
		animatedMonth = currentMonth;
		animatedYear = currentYear;
		if (SceneTransitionAbortFlag == FALSE)
		{
			/* The original enters this loop once even when the stored month
			 * count is zero, then tests the pre-decrement value. */
			do
			{
				if (WaitForDismissInputOrTimeout(0x06) != FALSE)
				{
					if (monthsRemaining != 0x00)
					{
						HideMouseCursorOverlay();
						DrawCenteredClippedText(dateText, 0x00, 0x00, 0x18, 0x0140, 0x0D, 0x0D);
						textColor = 0x0F;
						ShowMouseCursorOverlay();
					}
					for (; monthsRemaining != 0x00; --monthsRemaining)
					{
						++animatedMonth;
						if (animatedMonth > 0x0B)
						{
							animatedMonth = 0x00;
							++animatedYear;
						}
					}
				}
				else if (monthsRemaining != 0x00)
				{
					HideMouseCursorOverlay();
					DrawCenteredClippedText(dateText, 0x00, 0x00, 0x18, 0x0140, 0x0D, 0x0D);
					textColor = 0x0F;
					ShowMouseCursorOverlay();
					++animatedMonth;
					if (animatedMonth > 0x0B)
					{
						animatedMonth = 0x00;
						++animatedYear;
					}
				}
				HideMouseCursorOverlay();
				FarStringCopy(dateText, MonthNameTextTable[(word16)animatedMonth]);
				FarStringConcat(dateText, DateSpaceText);
				IntegerToString(animatedYear, yearText, 0x0A);
				RemoveLeadingSpacesFrom(yearText, 0x01);
				TrimTrailingEncodedSpaces(yearText);
				FarStringConcat(dateText, yearText);
				DrawCenteredClippedText(dateText, 0x00, 0x00, 0x18, 0x0140, (byte) textColor, 0x0D);
				ShowMouseCursorOverlay();
				previousMonthsRemaining = monthsRemaining;
				--monthsRemaining;
			} while (previousMonthsRemaining != 0x00);
		}
		if (SceneTransitionAbortFlag == FALSE &&
			presentationMode != -0x01 && redrawPresentation != FALSE)
		{
			PrepareMissionDateScreen(presentationMode);
			HideMouseCursorOverlay();
			DrawCenteredClippedText(MissionDateLabelTextTable[dateEntryIndex],
				0x00, 0x00, 0x10, 0x0140, (byte) textColor, 0x0D);
			DrawCenteredClippedText(dateText, 0x00, 0x00, 0x18, 0x0140, (byte) textColor, 0x0D);
			ShowMouseCursorOverlay();
		}
		if (SceneTransitionAbortFlag == FALSE)
		{
			if (blinkRegionIndex == -0x01 && redrawPresentation == FALSE)
				waitTicks = 0x32;
			else
				waitTicks = 0x64;
			/* Likewise, the blink timeout tests the old value after decrement. */
			for (;;)
			{
				if (WaitForDismissInputOrTimeout(0x06) != FALSE)
					break;
				previousWaitTicks = waitTicks;
				--waitTicks;
				if (previousWaitTicks == 0x00)
					break;
				if (blinkRegionIndex != -0x01)
				{
					leftX = MissionBlinkRectX[blinkRegionIndex];
					topY = MissionBlinkRectY[blinkRegionIndex];
				rectangleExtent = MissionBlinkRectExtent[blinkRegionIndex];
					HideMouseCursorOverlay();
					XorVideoRectangle(leftX, topY,
						leftX + rectangleExtent,
						topY + rectangleExtent, 0x0F);
					ShowMouseCursorOverlay();
				}
			}
		}
	}
	if (SceneTransitionAbortFlag == FALSE)
		ShowMissionFollowupMessage(followupMessageIndex);
}


/* 0D73:3AE4 is reconstructed in Text/REVENGE_0D73_SCENARIO_MESSAGES.c. */

// 0D73:3B7E: present a framed mission briefing and its indexed message.
// VERIFIED against 0D73:3B7E-3C7B.
void PresentMissionBriefing(
	word16 graphicsResourceIndex,
	word16 spriteLayoutIndex,
	word16 messageIndex)
{
	if ((PresentationCallbackOffset | PresentationCallbackSegment) != 0x0000)
		SceneTransitionAbortFlag = FALSE;
	if (SceneTransitionAbortFlag != FALSE)
		return;

	LoadGraphicsResourceToBuffers(
		graphicsResourceIndex,
		SecondaryScreenBuffer,
		PrimaryScreenBuffer);
	BuildMissionSpriteBackingBuffer(spriteLayoutIndex + 0x0005);
	HideMouseCursorOverlay();
	LoadScreenPalette(graphicsResourceIndex);
	DrawClippedSprite(
		ActiveRenderTarget,
		MissionSpriteBacking,
		0x0050,
		0x0001,
		0x0000);
	DrawClippedAxisAlignedLine(0x004F, 0x0000, 0x00F0, 0x0000, 0x000E);
	DrawClippedAxisAlignedLine(0x004F, 0x0000, 0x004F, 0x0065, 0x000E);
	DrawClippedAxisAlignedLine(0x00F0, 0x0000, 0x00F0, 0x0065, 0x000E);
	DrawClippedAxisAlignedLine(0x004F, 0x0065, 0x00F0, 0x0065, 0x000E);
	ShowMouseCursorOverlay();
	FreeGraphicsBufferRange(0x0011, 0x0011);
	if (SceneTransitionAbortFlag == FALSE)
		ShowCampaignMessageAndWait(messageIndex);
}

/* 0D73:3C7C is reconstructed in Input/REVENGE_0D73_WAIT.c. */

// 0D73:3C97: Register byte * WaitForDismissInputOrTimeout(Stack word16 wArg04)
// Called from:
//      PlayTitleTextSequence
//      AnimateTitleTextLine
//      RunTitleAndMainMenu
//      FlushInputAndWait
//      InitializeGame
word16 WaitForDismissInputOrTimeout(word16 timeoutRetraces)
{
	word16 dismissKey = 0x00;
	while (timeoutRetraces-- != 0x00)
	{
		WaitVerticalRetraces(0x01);
		word16 keypress = ServiceMusicAndCheckKeyboardInput();
		if (keypress != 0x00)
		{
			keypress = ReadTranslatedKeypress();
			dismissKey = keypress;
			if (keypress == KEY_ESCAPE || (keypress == KEY_CARRIAGE_RETURN || keypress == KEY_SPACE))
				timeoutRetraces = 0x00;
		}
		if (MouseInputDisabled == 0x00)
		{
			word16 mouseButtonState = MouseButtonState;
			if (PendingMouseButtonEvent != FALSE && mouseButtonState != 0x00)
			{
				PendingMouseButtonEvent = FALSE;
				if ((mouseButtonState & 0x01) != 0x00)
					dismissKey = KEY_CARRIAGE_RETURN;
				else
					dismissKey = KEY_ESCAPE;
				timeoutRetraces = 0x00;
			}
		}
	}
	if (dismissKey == KEY_ESCAPE)
		SceneTransitionAbortFlag = 0x01;
	return dismissKey;
}

// 0D73:3D19: Register word16 WaitForDismissInput()
// Called from:
//      ShowScenarioMessage
//      ShowInvalidSaveVersionDialog
//      WaitForAcknowledgement
word16 WaitForDismissInput(void)
{
	// V: Wait for Escape, Enter, or Space (including mouse events translated
	// to Enter/Escape). Other keyboard events are consumed and ignored.
	word16 dismissKey = 0x00;
	while (dismissKey == 0x00)
	{
		word16 inputKey = WaitForKeyboardOrMouseInput();
		dismissKey = inputKey;
		if (inputKey != KEY_ESCAPE && (inputKey != KEY_CARRIAGE_RETURN && inputKey != KEY_SPACE))
			dismissKey = 0x00;
	}
	return dismissKey;
}

// 0D73:3D40: Register byte * WaitForKeyboardOrMouseInput()
// Called from:
//      WaitForDismissInput
//      EditTextField
word16 WaitForKeyboardOrMouseInput(void)
{
	// V: Block until a translated keyboard event or mouse-button event arrives.
	// Mouse button bit 0 maps to Enter; the other button maps to Escape. While
	// idle, service the active scrolling-text state through UpdateTextEntryCursorBlink.
	word16 keypress = 0x00;
	while (keypress == 0x00)
	{
		if (ServiceMusicAndCheckKeyboardInput() != 0x00)
			keypress = ReadTranslatedKeypress();
		if (MouseInputDisabled == 0x00)
		{
			word16 mouseButtonState = MouseButtonState;
			if (keypress == 0x00 && (PendingMouseButtonEvent != FALSE && mouseButtonState != 0x00))
			{
				PendingMouseButtonEvent = FALSE;
				if ((mouseButtonState & 0x01) != 0x00)
					keypress = KEY_CARRIAGE_RETURN;
				else
					keypress = KEY_ESCAPE;
			}
		}
		if (keypress == 0x00 && TextEntryActive != FALSE)
			UpdateTextEntryCursorBlink();
	}
	if (keypress == KEY_ESCAPE)
		SceneTransitionAbortFlag = 0x01;
	return keypress;
}

/* 0D73:3DA9 is reconstructed in Text/REVENGE_0D73_ENTRY_BLINK.c. */

// 0D73:3E1E: void FlushPendingInput()
// Called from:
//      ShowConfirmationDialog
//      RunMainMenuSelection
//      RunInGameMenu
//      ShowScenarioMessage
//      FlushInputAndWait
//      ShowSaveLoadMenu
//      RenameSaveSlot
//      WaitForAcknowledgement
//      PromptYesNo
//      InitializeGame
//      LoadMediaConfiguration
void FlushPendingInput(void)
{
	uint16 inputPending;

	PendingMouseButtonEvent = FALSE;
	for (;;)
	{
		inputPending = ServiceMusicAndCheckKeyboardInput();
		if (inputPending == FALSE)
			break;
		ReadTranslatedKeypress();
	}
}

// 0D73:3E35: void DrawCenteredClippedText(const char far *sourceText, word16 splitIndex, uint16 leftX, uint16 y, uint16 maximumWidth, byte foregroundColor, byte backgroundColor)
// Called from:
//      RunInGameMenu
//      AnimateTitleTextLine
//      DrawBeveledMenuButton
void DrawCenteredClippedText(
	const char *sourceText,
	word16 splitIndex,
	uint16 leftX,
	uint16 y,
	uint16 maximumWidth,
	byte foregroundColor,
	byte backgroundColor)
{
	char text[0x34];
	int16 centeredOffset;

	// Verified against 0D73:3E35-3F56.
	FarStringNCopy(text, sourceText, 0x32);
	RemoveLeadingSpacesFrom(text, 0x01);
	TrimTrailingEncodedSpaces(text);
	word16 textWidth = MeasureTextWidth(text);
	if (textWidth > maximumWidth)
	{
		if (splitIndex != 0x00)
		{
			text[splitIndex] = 0x00;
			textWidth = MeasureTextWidth(text);
			centeredOffset = (int16) (word16) (maximumWidth - textWidth);
			centeredOffset >>= 0x01;
			DrawTextString(text, (word16) (leftX + centeredOffset), y,
				foregroundColor, backgroundColor);
			y = (word16) (y + ActiveFontLineHeight);
			FarStringNCopy(text, sourceText + splitIndex, 0x32);
			textWidth = MeasureTextWidth(text);
		}
		word16 textLength = StringLength(text);
		while (textWidth > maximumWidth)
		{
			text[textLength] = 0x00;
			--textLength;
			textWidth = MeasureTextWidth(text);
		}
	}
	centeredOffset = (int16) (word16) (maximumWidth - textWidth);
	centeredOffset >>= 0x01;
	DrawTextString(text, (word16) (leftX + centeredOffset), y,
		foregroundColor, backgroundColor);
}

// 0D73:3F57: draw a left-aligned string, truncating it to maximumWidth.
// Called from:
//      DrawUnitStatusScreen
// Verified against 0D73:3F57-3FF1.
void DrawLeftAlignedClippedText(
	const char * sourceText,
	word16 x,
	word16 y,
	word16 maximumWidth,
	byte foregroundColor,
	byte backgroundColor)
{
	char renderText[0x34];
	FarStringNCopy(renderText, sourceText, 0x32);
	RemoveLeadingSpacesFrom(renderText, 0x01);
	TrimTrailingEncodedSpaces(renderText);
	word16 textWidth = MeasureTextWidth(renderText);
	if (textWidth > maximumWidth)
	{
		word16 textLength = StringLength(renderText);
		while (textWidth > maximumWidth)
		{
			renderText[textLength] = '\0';
			--textLength;
			textWidth = MeasureTextWidth(renderText);
		}
	}
	DrawTextString(renderText, x, y, foregroundColor, backgroundColor);
}

// 0D73:3FF2: draw a right-aligned string, truncating it to maximumWidth.
// Called from:
//      DrawUnitStatusScreen
// Verified against 0D73:3FF2-4098.
void DrawRightAlignedClippedText(
	const char * sourceText,
	word16 leftX,
	word16 y,
	word16 maximumWidth,
	byte foregroundColor,
	byte backgroundColor)
{
	char renderText[0x34];
	FarStringNCopy(renderText, sourceText, 0x32);
	RemoveLeadingSpacesFrom(renderText, 0x01);
	TrimTrailingEncodedSpaces(renderText);
	word16 textWidth = MeasureTextWidth(renderText);
	if (textWidth > maximumWidth)
	{
		word16 textLength = StringLength(renderText);
		while (textWidth > maximumWidth)
		{
			renderText[textLength] = '\0';
			--textLength;
			textWidth = MeasureTextWidth(renderText);
		}
	}
	DrawTextString(
		renderText,
		leftX + (maximumWidth - textWidth),
		y,
		foregroundColor,
		backgroundColor);
}

// 0D73:4099: void LoadGraphicsResourceToBuffers(word16 resourceIndex,
//     byte * decodeBuffer, byte * displayBuffer)
// Called from:
//      RunCampaignLoop
/* 0D73:4099-4154 are reconstructed in Graphics/REVENGE_0D73_VIDEO.c. */

/* 0D73:418E is reconstructed in Text/REVENGE_0D73_STARTUP_TEXT.c. */

/* 0D73:41E8 is reconstructed in Text/REVENGE_0D73_STRING_FIELDS.c. */

/* 0D73:4238 is reconstructed in Text/REVENGE_0D73_STRING_FIELDS.c. */

/* 0D73:4288 is reconstructed in Text/REVENGE_0D73_STARTUP_TEXT.c. */

/* 0D73:42E4 is reconstructed in Text/REVENGE_0D73_STRING_FIELDS.c. */

/* 0D73:4317 is reconstructed in Text/REVENGE_0D73_TEXT_EDITOR.c. */

/* 0D73:454A is reconstructed in Text/REVENGE_0D73_STRING_FIELDS.c. */

/* 0D73:4572 is reconstructed in IO/REVENGE_0D73_SAVE_COMPATIBILITY.c. */

/* 0D73:4611 is reconstructed in UI/REVENGE_0D73_INVALID_SAVE_DIALOG.c. */

// 0D73:4155: capture one indexed rectangle from graphics resource 18h.
// Called from:
//      PrepareMissionDateScreen
void BuildMissionSpriteBackingBuffer(word16 spriteLayoutIndex)
{
	byte * allocation = BuildDisplayBackingBuffer(
		MissionSpriteSourceTileX[spriteLayoutIndex],
		MissionSpriteSourcePixelY[spriteLayoutIndex],
		MissionSpriteWidthTiles[spriteLayoutIndex],
		MissionSpriteHeightPixels[spriteLayoutIndex]);
	MissionSpriteBacking = allocation;
}

// 0D73:54B9: capture a display rectangle into the adapter-specific backing-buffer format.
// Called from:
//      RebuildMouseCursorBackingBuffer
/* 0D73:54B9-57AA are reconstructed in Graphics/REVENGE_0D73_VIDEO.c. */

// 0D73:5789: void ShowScenarioCompletionStatus(void)
// Called from:
//      InitializeTacticalScenario
//      RebuildTacticalVideoResources
// Verified against 0D73:5789-57D8 (tail confirmed by the preserved Reko output).
void ShowScenarioCompletionStatus(void)
{
	HideMouseCursorOverlay();
	if ((CampaignFlags & 0x01) != FALSE)
	{
		DrawTileAlignedText(
			ScenarioCompleteHeadingText,
			0x04,
			0x0C,
			0x0F,
			0x0C);
	}
	else
	{
		DrawTileAlignedText(
			ScenarioFailedHeadingText,
			0x03,
			0x0C,
			0x06,
			0x0C);
	}
	ShowMouseCursorOverlay();
	TacticalUpdateDelayTicks = 0x0B;
}
