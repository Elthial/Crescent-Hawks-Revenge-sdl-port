#include "REVENGE.h"
#include "revenge/original_data.h"

#include <assert.h>

static char printedCharacters[0x10];
static word16 printedCharacterCount;
static byte retraceModes[0x10];
static word16 retraceCallCount;

uint16 DOS_PrintCharacter(char character)
{
	printedCharacters[printedCharacterCount++] = character;
	return (word16) (byte) character;
}

void WaitForVerticalRetraceEdge(byte waitForRetraceStart)
{
	retraceModes[retraceCallCount++] = waitForRetraceStart;
}

int main(void)
{
	DOS_PrintString("REVENGE");
	assert(printedCharacterCount == 0x0007);
	assert(printedCharacters[0x00] == 'R');
	assert(printedCharacters[0x06] == 'E');

	VerticalRetraceEdgeMode = 0x0001;
	WaitVerticalRetraces(0x0003);
	assert(retraceCallCount == 0x0003);
	assert(retraceModes[0x00] == 0x01);
	assert(retraceModes[0x02] == 0x01);
	WaitVerticalRetraces(0x0000);
	assert(retraceCallCount == 0x0003);
	return 0x00;
}
