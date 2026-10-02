#include "REVENGE.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int failures;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

static void TestFarStringCopy(void)
{
	char destination[0x10];
	char *result;
	char *source;
	char *largeDestination;

	memset(destination, 0x55, sizeof(destination));
	result = FarStringCopy(destination, "Revenge");
	Check(result == destination, "far string copy returns its destination");
	Check(memcmp(destination, "Revenge\0", 0x08) == 0,
		"far string copy includes the terminating NUL");
	Check((byte) destination[0x08] == 0x55,
		"far string copy stops immediately after the NUL");

	source = (char *) malloc(0xFFFF);
	largeDestination = (char *) malloc(0xFFFF);
	Check(source != NULL && largeDestination != NULL,
		"maximum-copy fixtures allocate");
	if (source == NULL || largeDestination == NULL)
	{
		free(source);
		free(largeDestination);
		return;
	}
	memset(source, 'X', 0xFFFF);
	memset(largeDestination, 0x00, 0xFFFF);
	FarStringCopy(largeDestination, source);
	Check(memcmp(largeDestination, source, 0xFFFF) == 0,
		"unterminated source copies exactly the FFFFh scan cap");
	free(source);
	free(largeDestination);
}

static void TestFarMemoryFill(void)
{
	byte bytes[0x08];

	memset(bytes, 0x11, sizeof(bytes));
	FillFarMemoryBytes(&bytes[0x01], 0x00, 0xAA);
	Check(bytes[0x01] == 0x11, "a zero byte count writes nothing");

	FillFarMemoryBytes(&bytes[0x01], 0x03, 0xAA);
	Check(bytes[0x00] == 0x11 && bytes[0x01] == 0xAA &&
		bytes[0x03] == 0xAA && bytes[0x04] == 0x11,
		"odd fill count changes exactly the requested bytes");

	memset(bytes, 0x11, sizeof(bytes));
	Check(FarMemorySet(&bytes[0x02], 0xCC, 0x04) == &bytes[0x02],
		"far memory set returns the original destination");
	Check(bytes[0x01] == 0x11 && bytes[0x02] == 0xCC &&
		bytes[0x05] == 0xCC && bytes[0x06] == 0x11,
		"far memory set forwards value and even byte count");

	memset(bytes, 0x11, sizeof(bytes));
	FillRuntimeFarMemoryBytes(&bytes[0x02], 0x03, 0x5A);
	Check(bytes[0x01] == 0x11 && bytes[0x02] == 0x5A &&
		bytes[0x04] == 0x5A && bytes[0x05] == 0x11,
		"0800 far fill preserves the REP STOSB extent");
}

static void TestFarMemoryCopy(void)
{
	byte source[0x08] = { 0x10, 0x21, 0x32, 0x43, 0x54, 0x65, 0x76, 0x87 };
	byte destination[0x08];

	memset(destination, 0xCC, sizeof(destination));
	CopyFarMemory(0x05, source + 0x01, destination + 0x02);
	Check(destination[0x01] == 0xCC && destination[0x02] == 0x21 &&
		destination[0x06] == 0x65 && destination[0x07] == 0xCC,
		"far copy handles the MOVSW body and odd MOVSB tail");
}

static void TestLongArithmeticHelpers(void)
{
	Check(MultiplyUnsignedLong(0x5678, 0x0000, 0x1234, 0x0003) ==
		0x369D0368UL,
		"unsigned long multiply returns the low 32 product bits");
	Check(ShiftLeft32_DXAX(0x5678, 0x04, 0x1234) == 0x23456780UL,
		"DX:AX left shift crosses the word boundary");
	Check(ShiftLeft32_DXAX(0x5678, 0x14, 0x1234) == 0x67800000UL,
		"DX:AX left shift follows the count-at-least-16 branch");
	Check(ShiftRight32_DXAX(0x5678, 0x04, 0x1234) == 0x01234567UL,
		"DX:AX right shift crosses the word boundary");
	Check(ShiftRight32_DXAX(0x5678, 0x14, 0x1234) == 0x00000123UL,
		"DX:AX right shift follows the count-at-least-16 branch");
}

int main(void)
{
	TestFarStringCopy();
	TestFarMemoryFill();
	TestFarMemoryCopy();
	TestLongArithmeticHelpers();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
