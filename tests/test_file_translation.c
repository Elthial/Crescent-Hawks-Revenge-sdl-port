#include "REVENGE.h"
#include "revenge/original_data.h"

#include <assert.h>
#include <string.h>

static const byte *inputBytes;
static word16 inputLength;
static int32 filePosition;
static byte writtenBytes[0x0200];
static word16 writtenLength;

int16 DOS_ReadFile(word16 fileHandle, void *destination, word16 byteCount)
{
	word16 available;
	word16 count;
	(void) fileHandle;
	available = (word16) (inputLength - (word16) filePosition);
	count = byteCount < available ? byteCount : available;
	memcpy(destination, inputBytes + filePosition, count);
	filePosition += count;
	return (int16) count;
}

int16 DOS_WriteFile(word16 fileHandle, const void *source, word16 byteCount)
{
	(void) fileHandle;
	memcpy(writtenBytes + writtenLength, source, byteCount);
	writtenLength = (word16) (writtenLength + byteCount);
	return (int16) byteCount;
}

long DOS_SeekFile(word16 fileHandle, long offset, byte origin)
{
	(void) fileHandle;
	if (origin == 0x00)
		filePosition = offset;
	else if (origin == 0x01)
		filePosition += offset;
	else
		filePosition = inputLength + offset;
	return filePosition;
}

static void SetInput(const byte *bytes, word16 byteCount)
{
	inputBytes = bytes;
	inputLength = byteCount;
	filePosition = 0x00000000L;
	writtenLength = 0x0000;
	memset(writtenBytes, 0x00, sizeof(writtenBytes));
	memset(FileRuntime.handleState, 0x00, sizeof(FileRuntime.handleState));
}

int main(void)
{
	static const byte translatedInput[] =
		{ 'A', 0x0D, 0x0A, 'B', 0x1A, 'C' };
	static const byte trailingCarriageReturn[] = { 'A', 0x0D, 0x0A };
	static const byte outputText[] = { 'A', 0x0A, 'B' };
	byte buffer[0x10];
	uint32 bufferAddress;

	bufferAddress = HostFarPointer_RegisterAt(
		buffer, sizeof(buffer), MAKE_DWORD(0x5100, 0x0004));
	SetInput(translatedInput, sizeof(translatedInput));
	assert(ReadFileWithTextTranslation(0x0003,
		HostFarPointer_Resolve(bufferAddress), sizeof(translatedInput)) == 0x0003);
	assert(memcmp(buffer, "A\nB", 0x0003) == 0x00);
	assert(filePosition == 0x00000004L);
	assert((FileRuntime.handleState[0x0003] &
		CRT_FILE_STATE_TEXT_EOF) != 0x0000);
	assert(ReadFileWithTextTranslation(0x0003, buffer, 0x0001) == 0x0000);

	SetInput(translatedInput, sizeof(translatedInput));
	FileRuntime.handleState[0x0003] = CRT_FILE_STATE_BINARY;
	assert(ReadFileWithTextTranslation(0x0003, buffer,
		sizeof(translatedInput)) == sizeof(translatedInput));
	assert(memcmp(buffer, translatedInput, sizeof(translatedInput)) == 0x00);

	SetInput(trailingCarriageReturn, sizeof(trailingCarriageReturn));
	assert(ReadFileWithTextTranslation(0x0003, buffer, 0x0002) == 0x0002);
	assert(buffer[0x00] == 'A' && buffer[0x01] == 0x0A);

	SetInput(outputText, sizeof(outputText));
	assert(WriteFileWithTextTranslation(0x0003, outputText,
		sizeof(outputText)) == sizeof(outputText));
	assert(writtenLength == 0x0004);
	assert(memcmp(writtenBytes, "A\r\nB", 0x0004) == 0x00);

	SetInput(translatedInput, sizeof(translatedInput));
	filePosition = 0x00000002L;
	assert(GetFileLength(0x0003) == sizeof(translatedInput));
	assert(filePosition == 0x00000002L);

	HostFarPointer_Reset();
	return 0x00;
}
