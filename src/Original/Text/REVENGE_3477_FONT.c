// Reconstructed original font resource loader and metrics (segment 3477).

#include "REVENGE.h"
#include "revenge/original_data.h"

// 3477:000B: unsigned char *LoadFontResource(
//     const char *fileName)
byte *LoadFontResource(const char *fileName)
{
	word16 totalFileSize = 0x00;
	byte dimensions[0x02];
	byte *fontResource = NULL;
	int16 fileHandle = CRT_OpenFile(fileName, 0x8001);

	if (fileHandle != -0x01)
	{
		word16 headerBytesRead = ReadFileWithTextTranslation(
			(word16) fileHandle,
			(byte *) &totalFileSize,
			0x02);
		totalFileSize = (word16) (totalFileSize + 0x02);
		if (headerBytesRead == 0x02 && totalFileSize > 0x0104)
		{
			int32 physicalFileLength = GetFileLength((word16) fileHandle);
			if (HIGH_WORD(physicalFileLength) == 0x00 &&
				LOW_WORD(physicalFileLength) == totalFileSize)
			{
				int32 seekPosition = (int32) DOS_SeekFile(
					(word16) fileHandle, 0x0102L, 0x00);
				if (seekPosition == 0x0102L)
				{
					word16 dimensionsRead = ReadFileWithTextTranslation(
						(word16) fileHandle,
						dimensions,
						0x02);
					if (dimensionsRead == 0x02)
					{
						int16 glyphHeight = (int8) dimensions[0x00];
						int16 bytesPerGlyphRow =
							((int8) dimensions[0x01] + 0x07) / 0x08;
						word16 glyphDataSize = (word16)
							((word16) glyphHeight *
							(word16) bytesPerGlyphRow << 0x07);
						word16 allocationSize =
							(word16) (glyphDataSize + 0x0104);

						if (allocationSize == totalFileSize)
						{
							fontResource = (byte *)
								AllocateFarHeapBytes16(allocationSize);
							if (fontResource != NULL)
							{
								if ((int32) DOS_SeekFile(
									(word16) fileHandle,
									0x00L,
									0x00) == 0x00L)
								{
									word16 fontBytesRead =
										ReadFileWithTextTranslation(
											(word16) fileHandle,
											fontResource,
											totalFileSize);
									if (fontBytesRead != totalFileSize)
									{
										FreeHeapBlock(fontResource);
										fontResource = NULL;
									}
								}
								else
								{
									FreeHeapBlock(fontResource);
									fontResource = NULL;
								}
							}
						}
					}
				}
			}
		}
		CRT_CloseFile(fileHandle);
	}
	return fontResource;
}

// 3477:018F: void SetActiveFontResource(byte *fontResource)
void SetActiveFontResource(byte *fontResource)
{
	ActiveFontResource = fontResource;
	ActiveFontGlyphAdvanceX = (int8)fontResource[0x0103];
	ActiveFontLineHeight = (int8)fontResource[0x0102];
}

// 3477:01B5: uint16 MeasureTextWidth(const char *text)
uint16 MeasureTextWidth(const char *text)
{
	const byte *activeFont = ActiveFontResource;
	int16 glyphAdvance = (int8) activeFont[0x0103];

	return (word16) (StringLength(text) * glyphAdvance);
}
