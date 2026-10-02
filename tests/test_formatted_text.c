#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/original/campaign_data.h"

#include <assert.h>
#include <string.h>

static char renderedText[0x08][0x52];
static word16 renderedAdvance[0x08];
static word16 renderCount;

void RenderTextToActiveWindow(char *text, word16 advanceToNextLine)
{
	size_t length = strlen(text);
	assert(length < sizeof(renderedText[renderCount]));
	memcpy(renderedText[renderCount], text, length + 0x01);
	renderedAdvance[renderCount] = advanceToNextLine;
	++renderCount;
	text[0x00] = '\0';
}

static void ResetRenderer(word16 widthTiles)
{
	memset(renderedText, 0x00, sizeof(renderedText));
	memset(renderedAdvance, 0x00, sizeof(renderedAdvance));
	renderCount = 0x0000;
	ActiveTextWindowWidthTiles = widthTiles;
	ActiveTextCursorColumn = 0x0000;
	ActiveFontGlyphAdvanceX = 0x01;
	ActiveTextForegroundColor = 0x0007;
	ActiveTextBackgroundColor = 0x0000;
}

int main(void)
{
	static const char plain[] = "Hello";
	static const char newline[] = "One\rTwo";
	static const char foreground[] = { 'A', 0x06, 0x05, 'B', 0x00 };
	static const char wrapped[] = "123456789";
	static const byte compressedPair[] = { 0x80, 0x00 };
	word16 messageIndex;

	assert(CompressedTextFirstByteTable[0x00] == ' ');
	assert(CompressedTextFirstByteTable[0x0F] == 'm');
	assert(CompressedTextSecondByteTable[0x00] == 't');
	assert(CompressedTextSecondByteTable[0x7F] == 0x80);
	assert(strstr(CampaignMessageTextTable[0x01],
		"I hope you find your father, Jason.") != NULL);
	for (messageIndex = 0x0000;
		messageIndex < CAMPAIGN_MESSAGE_COUNT;
		++messageIndex)
	{
		const byte *message =
			(const byte *)CampaignMessageTextTable[messageIndex];
		while (*message != 0x00)
		{
			assert((*message & 0x80) == 0x00);
			++message;
		}
	}

	ResetRenderer(0x0028);
	RenderFormattedText(plain);
	assert(renderCount == 0x0001);
	assert(strcmp(renderedText[0x00], "Hello") == 0x00);
	assert(renderedAdvance[0x00] == 0x0000);

	ResetRenderer(0x0028);
	RenderFormattedText(newline);
	assert(renderCount == 0x0002);
	assert(strcmp(renderedText[0x00], "One") == 0x00);
	assert(renderedAdvance[0x00] == 0x0001);
	assert(strcmp(renderedText[0x01], "Two") == 0x00);

	ResetRenderer(0x0028);
	RenderFormattedText(foreground);
	assert(renderCount == 0x0002);
	assert(strcmp(renderedText[0x00], "A") == 0x00);
	assert(strcmp(renderedText[0x01], "B") == 0x00);
	assert(ActiveTextForegroundColor == 0x0005);

	ResetRenderer(0x0001);
	RenderFormattedText(wrapped);
	assert(renderCount == 0x0002);
	assert(strcmp(renderedText[0x00], "12345678") == 0x00);
	assert(renderedAdvance[0x00] == 0x0001);
	assert(strcmp(renderedText[0x01], "9") == 0x00);

	ResetRenderer(0x0028);
	RenderFormattedText((const char *)compressedPair);
	assert(renderCount == 0x0001);
	assert(strcmp(renderedText[0x00], " t") == 0x00);

	return 0x00;
}
