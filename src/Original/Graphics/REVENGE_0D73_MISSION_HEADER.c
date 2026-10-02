/* Mission-header graphics procedure from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"

/* 0D73:365C-376B */
void DrawMissionHeaderFrame(void)
{
	HideMouseCursorOverlay();
	FillVideoRectangle(0x0001, 0x0001, 0x013E, 0x0020, 0x000D);
	DrawClippedAxisAlignedLine(0x0001, 0x0001, 0x013E, 0x0001, 0x000E);
	DrawClippedAxisAlignedLine(0x0001, 0x0002, 0x013D, 0x0002, 0x000E);
	DrawClippedAxisAlignedLine(0x0001, 0x0003, 0x0001, 0x0020, 0x000E);
	DrawClippedAxisAlignedLine(0x0002, 0x0003, 0x0002, 0x001F, 0x000E);
	DrawClippedAxisAlignedLine(0x0004, 0x001F, 0x013D, 0x001F, 0x000C);
	DrawClippedAxisAlignedLine(0x013D, 0x0004, 0x013D, 0x001F, 0x000C);
	SetActiveFontResource(Font8Resource);
	DrawCenteredClippedText(
		MissionMapHeaderText,
		0x0000,
		0x0000,
		0x0005,
		0x0140,
		0x0F,
		0x0D);
	SetActiveFontResource(Font6Resource);
	ShowMouseCursorOverlay();
}
