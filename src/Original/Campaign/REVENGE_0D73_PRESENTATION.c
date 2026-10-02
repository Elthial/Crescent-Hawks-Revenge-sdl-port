/* Campaign screen/message presentation procedure from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"

/* 0D73:341F-347C */
word16 PresentScreenAndMessage(
	word16 screenResourceIndex,
	word16 messageIndex)
{
	word16 dismissKey;
	word16 skipWait;

	dismissKey = 0x0000;
	skipWait = FALSE;
	if ((PresentationCallbackOffset |
		PresentationCallbackSegment) != 0x0000)
	{
		SceneTransitionAbortFlag = FALSE;
		skipWait = TRUE;
	}
	if (SceneTransitionAbortFlag == FALSE)
	{
		if (screenResourceIndex != 0x00FF)
			LoadAndPresentScreen(screenResourceIndex);
		if (skipWait == FALSE)
			dismissKey = FlushInputAndWait(
				PresentationDismissTimeout);
	}
	if (SceneTransitionAbortFlag == FALSE && messageIndex != 0x0000)
	{
		ShowScenarioMessage(messageIndex);
		dismissKey = 0x0000;
	}
	return dismissKey;
}
