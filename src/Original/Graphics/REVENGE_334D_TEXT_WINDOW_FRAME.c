// Reconstructed original text-window frame renderer (segment 334D).

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

// 334D:0001: void DrawActiveTextWindowFrame(word16 frameStyleIndex)
// Called from:
//      OpenModalTextWindow
//      RunGameOptionsMenu
void DrawActiveTextWindowFrame(word16 frameStyleIndex)
{
	byte tileShift = 0x05;
	if (VideoAdapterType == VIDEO_ADAPTER_VGA)
		tileShift = 0x06;
	const word16 *frameDefinition =
		TextWindowFrameDefinitionTable[frameStyleIndex];
	const byte *tileAtlas = TacticalTileStrip;
	int16 left = ActiveTextWindowLeftTile;
	int16 top = ActiveTextWindowTopTile;
	word16 width = ActiveTextWindowWidthTiles;
	word16 height = ActiveTextWindowHeightTiles;
	Draw8x8VideoTile((const byte *)tileAtlas + (frameDefinition[0x00] << tileShift), left - 0x01, top - 0x01);
	Draw8x8VideoTile((const byte *)tileAtlas + (frameDefinition[0x01] << tileShift), left + width, top - 0x01);
	Draw8x8VideoTile((const byte *)tileAtlas + (frameDefinition[0x02] << tileShift), left - 0x01, top + height);
	Draw8x8VideoTile((const byte *)tileAtlas + (frameDefinition[0x03] << tileShift), left + width, top + height);

	word16 edgeSequenceIndex = 0x04;
	edgeSequenceIndex = DrawRepeatingFrameTileSequence(frameDefinition, edgeSequenceIndex, left, top - 0x01, width, TRUE);
	edgeSequenceIndex = DrawRepeatingFrameTileSequence(frameDefinition, edgeSequenceIndex, left - 0x01, top, height, FALSE);
	edgeSequenceIndex = DrawRepeatingFrameTileSequence(frameDefinition, edgeSequenceIndex, left + width, top, height, FALSE);
	DrawRepeatingFrameTileSequence(frameDefinition, edgeSequenceIndex, left, top + height, width, TRUE);
}

