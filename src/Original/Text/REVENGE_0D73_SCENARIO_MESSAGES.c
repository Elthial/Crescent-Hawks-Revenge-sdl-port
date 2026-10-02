/* Indexed scenario-message procedures from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/input.h"
#include "revenge/debug.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

void OpenModalTextWindow(word16 windowIndex, word16 clearAndFrame);
void RestoreModalTextWindow(void);

/* 0D73:2E7C-2F15 */
void ShowScenarioMessage(word16 messageIndex)
{
	const PresentationMessageRecord *message;

	if ((PresentationCallbackOffset |
		PresentationCallbackSegment) != 0x0000)
	{
		SceneTransitionAbortFlag = FALSE;
	}
	if (SceneTransitionAbortFlag != FALSE || messageIndex == 0x0000)
		return;

	message = &OriginalData_PresentationMessageRecords()[messageIndex];
	REVENGE_PRESERVATION_TRACE(
		"text: scenario message=%u height=%d pointer=%08lX\n",
		messageIndex, message->windowHeight,
		(unsigned long)message->textPointer);
	TextWindowContexts[0x0F].heightTiles =
		(word16) (int16) message->windowHeight;
	TextWindowContexts[0x0F].topTile = 0x0001;
	OpenModalTextWindow(0x000F, TRUE);
	HideMouseCursorOverlay();
	RenderFormattedText((const char *) HostFarPointer_Resolve(
		message->textPointer));
	ShowMouseCursorOverlay();
	FlushPendingInput();
	if ((PresentationCallbackOffset |
		PresentationCallbackSegment) != 0x0000)
	{
		InvokePresentationCallback();
		SceneTransitionAbortFlag = FALSE;
	}
	else
	{
		WaitForDismissInput();
	}
	RestoreModalTextWindow();
}

/* 0D73:3AE4-3B7D */
void ShowMissionFollowupMessage(word16 messageIndex)
{
	const PresentationMessageRecord *message;

	if ((PresentationCallbackOffset |
		PresentationCallbackSegment) != 0x0000)
	{
		SceneTransitionAbortFlag = FALSE;
	}
	if (SceneTransitionAbortFlag != FALSE || messageIndex == 0x0000)
		return;

	message = &OriginalData_PresentationMessageRecords()[messageIndex];
	TextWindowContexts[0x0F].heightTiles =
		(word16) (int16) message->windowHeight;
	TextWindowContexts[0x0F].topTile = 0x0006;
	OpenModalTextWindow(0x000F, TRUE);
	HideMouseCursorOverlay();
	RenderFormattedText((const char *) HostFarPointer_Resolve(
		message->textPointer));
	ShowMouseCursorOverlay();
	FlushPendingInput();
	if ((PresentationCallbackOffset |
		PresentationCallbackSegment) != 0x0000)
	{
		InvokePresentationCallback();
		SceneTransitionAbortFlag = FALSE;
	}
	else
	{
		WaitForDismissInput();
	}
	RestoreModalTextWindow();
}
