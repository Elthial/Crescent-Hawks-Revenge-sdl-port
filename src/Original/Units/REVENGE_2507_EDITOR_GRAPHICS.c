// REVENGE_2507_EDITOR_GRAPHICS.c
// Reconstructed from the original procedures in segment 2507.

#include "REVENGE_2507_LANCE_EDITOR_INTERNAL.h"

// 2507:60D2: draw LNG, MED, CLS, and SPD at successive Y coordinates.
void DrawRangeAndSpeedStatHeaders(word16 topY)
{
	word16 yOffset = 0x00;
	word16 labelIndex;
	for (labelIndex = 0x00; labelIndex < 0x04; ++labelIndex)
	{
		DrawTextString(UnitStatHeaderTextTable[labelIndex],
			0x01, topY + yOffset, 0x0F, 0x00);
		yOffset += 0x07;
	}
}

// 2507:6111: draw EXP and GUN at successive Y coordinates.
void DrawExperienceAndGunneryHeaders(word16 topY)
{
	word16 yOffset = 0x00;
	word16 labelIndex;
	for (labelIndex = 0x00; labelIndex < 0x02; ++labelIndex)
	{
		DrawTextString(UnitStatHeaderTextTable[labelIndex + 0x04],
			0x01, topY + yOffset, 0x0F, 0x00);
		yOffset += 0x09;
	}
}

// 2507:6150: allocate the four display backing buffers used by the lance
// configuration editor.
// VERIFIED against ASM 2507:6150-6198.
void LoadLanceConfigurationGraphicsBuffers(void)
{
	word16 tableIndex;
	word16 bufferIndex;
	byte *backingBuffer;

	bufferIndex = 0x0013;
	for (tableIndex = 0x0000; tableIndex < 0x0004; ++tableIndex)
	{
		backingBuffer = BuildDisplayBackingBuffer(
			LanceEditorLayout.LanceBackingSourceTileX[tableIndex],
			LanceEditorLayout.LanceBackingSourcePixelY[tableIndex],
			LanceEditorLayout.LanceBackingWidthTiles[tableIndex],
			LanceEditorLayout.LanceBackingHeightPixels[tableIndex]);
		UnitEditorGraphicsBuffer(bufferIndex) = backingBuffer;
		++bufferIndex;
	}
}

// 2507:6199: allocate the two display backing buffers used by the scenario
// variant selector.
// VERIFIED against ASM 2507:6199-61E1.
void LoadScenarioVariantGraphicsBuffers(void)
{
	word16 tableIndex;
	word16 bufferIndex;
	byte *backingBuffer;

	bufferIndex = 0x0011;
	for (tableIndex = 0x0000; tableIndex < 0x0002; ++tableIndex)
	{
		backingBuffer = BuildDisplayBackingBuffer(
			LanceEditorLayout.ScenarioBackingSourceTileX[tableIndex],
			LanceEditorLayout.ScenarioBackingSourcePixelY[tableIndex],
			LanceEditorLayout.ScenarioBackingWidthTiles[tableIndex],
			LanceEditorLayout.ScenarioBackingHeightPixels[tableIndex]);
		UnitEditorGraphicsBuffer(bufferIndex) = backingBuffer;
		++bufferIndex;
	}
}

// 2507:61E2: build an inclusive indexed range of display backing buffers.
// VERIFIED against ASM 2507:61E2-623C.
void LoadGraphicsBufferRange(
	int16 firstBufferIndex,
	int16 lastBufferIndex)
{
	int16 rangeOffset;
	int16 bufferIndex;
	byte *backingBuffer;

	bufferIndex = firstBufferIndex;
	rangeOffset = 0x0000;
	do
	{
		backingBuffer = BuildDisplayBackingBuffer(
			LanceEditorLayout.EditorBackingSourceTileX[rangeOffset],
			LanceEditorLayout.EditorBackingSourcePixelY[rangeOffset],
			LanceEditorLayout.EditorBackingWidthTiles[rangeOffset],
			LanceEditorLayout.EditorBackingHeightPixels[rangeOffset]);
		UnitEditorGraphicsBuffer((word16)bufferIndex) = backingBuffer;
		++bufferIndex;
		++rangeOffset;
	} while (rangeOffset <= (int16) (lastBufferIndex - firstBufferIndex));
}

// 2507:623D: free an inclusive range of indexed graphics backing buffers.
// Called from:
//      PrepareMissionDateScreen
// VERIFIED against ASM 2507:623D-625F and the segment-end epilogue.
void FreeGraphicsBufferRange(int16 firstBufferIndex, int16 lastBufferIndex)
{
	int16 bufferIndex;
	for (bufferIndex = firstBufferIndex; bufferIndex <= lastBufferIndex; ++bufferIndex)
	{
		FreeHeapBlock(UnitEditorGraphicsBuffer(bufferIndex));
	}
}
