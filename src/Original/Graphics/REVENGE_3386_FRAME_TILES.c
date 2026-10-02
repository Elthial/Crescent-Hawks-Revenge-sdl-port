// Reconstructed original repeating frame-tile renderer (segment 3386).

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

// 3386:0008: word16 DrawRepeatingFrameTileSequence(...)
// Called from:
//      DrawActiveTextWindowFrame
word16 DrawRepeatingFrameTileSequence(
	const word16 *frameDefinition,
	word16 sequenceIndex,
	int16 x,
	int16 y,
	word16 tileCount,
	word16 horizontal)
{
	byte tileShift = VideoAdapterType == VIDEO_ADAPTER_VGA ? 0x06 : 0x05;
	word16 currentIndex = sequenceIndex;
	word16 drawn;
	for (drawn = 0x00; drawn < tileCount; ++drawn)
	{
		const byte *tileAtlas = TacticalTileStrip;
		Draw8x8VideoTile(
			(const byte *)tileAtlas
				+ (frameDefinition[currentIndex] << tileShift),
			x,
			y);
		if (horizontal != FALSE)
			++x;
		else
			++y;
		++currentIndex;
		if (frameDefinition[currentIndex] == 0x00FF)
			currentIndex = sequenceIndex;
	}
	while (frameDefinition[currentIndex] != 0x00FF)
		++currentIndex;
	return currentIndex + 0x01;
}

