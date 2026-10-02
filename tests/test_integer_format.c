#include "REVENGE.h"

#include <assert.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
	char text[0x40];

	assert(IntegerToString(0x0000, text, 0x000A) == text);
	assert(strcmp(text, "0") == 0x00);
	IntegerToString(-0x3039, text, 0x000A);
	assert(strcmp(text, "-12345") == 0x00);
	IntegerToString(-0x0001, text, 0x0010);
	assert(strcmp(text, "ffff") == 0x00);
	LongToString((int32) 0x80000000UL, text, 0x000A);
	assert(strcmp(text, "-2147483648") == 0x00);
	FormatLongInteger('A', FALSE, 0x0010, text, 0xDEADBEEFUL);
	assert(strcmp(text, "DEADBEEF") == 0x00);
	FormatLongInteger('a', FALSE, 0x0001, text, 0x00000001UL);
	assert(strcmp(text, "") == 0x00);

	return EXIT_SUCCESS;
}
