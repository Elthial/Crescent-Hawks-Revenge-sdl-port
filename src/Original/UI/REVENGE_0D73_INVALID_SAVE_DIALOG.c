/* Preserved invalid-save-version dialog from REVENGE_0D73. */

#include "REVENGE.h"

#include "revenge/input.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

/* 0D73:4611-4865 */
void ShowInvalidSaveVersionDialog(void)
{
	byte *backingBuffer;
	uint32 backingSize;
	word16 savedWindowIndex;
	word16 allocatedHere;
	word16 savedForegroundColor;
	word16 savedBackgroundColor;
	word16 dismissKey;
	int16 leftX;
	int16 topY;
	int16 rightX;
	int16 bottomY;

	savedWindowIndex = ActiveTextWindowIndex;
	SelectTextWindow(StartupResourceState);
	allocatedHere = FALSE;
	if (InvalidSaveDialogBacking == NULL)
	{
		backingSize = (uint32) ActiveTextWindowWidthTiles *
			ActiveTextWindowHeightTiles;
		backingSize = ShiftLeft32_DXAX(
			LOW_WORD(backingSize),
			VideoAdapterType == VIDEO_ADAPTER_VGA ? 0x06 : 0x05,
			HIGH_WORD(backingSize));
		backingBuffer = AllocateParagraphAlignedMemory(backingSize);
		InvalidSaveDialogBacking = backingBuffer;
		allocatedHere = TRUE;
	}
	backingBuffer = InvalidSaveDialogBacking;

	HideMouseCursorOverlay();
	CopyVideoRegionToBuffer(
		(int16) ActiveTextWindowLeftTile,
		ActiveTextWindowTopTile,
		ActiveTextWindowWidthTiles,
		ActiveTextWindowHeightTiles,
		backingBuffer);
	ClearActiveTextWindow();

	leftX = (int16) (ActiveTextWindowLeftTile << 0x03);
	topY = (int16) (ActiveTextWindowTopTile << 0x03);
	rightX = (int16) (((ActiveTextWindowLeftTile +
		ActiveTextWindowWidthTiles) << 0x03) - 0x01);
	bottomY = (int16) (((ActiveTextWindowTopTile +
		ActiveTextWindowHeightTiles) << 0x03) - 0x01);
	DrawClippedAxisAlignedLine(leftX, topY, rightX, topY, 0x000F);
	DrawClippedAxisAlignedLine(leftX, bottomY, rightX, bottomY, 0x000F);
	DrawClippedAxisAlignedLine(leftX, topY, leftX, bottomY, 0x000F);
	DrawClippedAxisAlignedLine(rightX, topY, rightX, bottomY, 0x000F);
	ShowMouseCursorOverlay();

	AdjustActiveTextWindowMargin(0xFFFF);
	savedForegroundColor = ActiveTextForegroundColor;
	savedBackgroundColor = ActiveTextBackgroundColor;
	ActiveTextForegroundColor = 0x000F;
	ActiveTextBackgroundColor = 0x000C;
	HideMouseCursorOverlay();
	RenderFormattedText(InvalidSaveVersionText);
	ShowMouseCursorOverlay();
	ActiveTextForegroundColor = savedForegroundColor;
	ActiveTextBackgroundColor = savedBackgroundColor;
	dismissKey = WaitForDismissInput();

	AdjustActiveTextWindowMargin(0x0001);
	HideMouseCursorOverlay();
	CopyBufferToVideoRegion(
		(int16) ActiveTextWindowLeftTile,
		ActiveTextWindowTopTile,
		ActiveTextWindowWidthTiles,
		ActiveTextWindowHeightTiles,
		backingBuffer);
	ShowMouseCursorOverlay();
	SelectTextWindow(savedWindowIndex);

	if (allocatedHere != FALSE)
	{
		FreeParagraphAlignedMemory(backingBuffer);
		InvalidSaveDialogBacking = NULL;
	}
	if (dismissKey == KEY_ESCAPE)
	{
		ShutdownGame();
		RunExitHandlersAndTerminate(0x0001);
	}
}
