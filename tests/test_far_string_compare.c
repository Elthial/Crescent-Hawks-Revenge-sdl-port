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

static void TestOrdinaryComparisons(void)
{
	const byte highLeft[] = { 0xFF, 0x00 };
	const byte highRight[] = { 0x01, 0x00 };

	Check(FarStringCompare("Revenge", "Revenge") == 0x00,
		"equal strings compare as zero");
	Check(FarStringCompare("Revenge", "Revenger") == -'r',
		"a NUL left prefix subtracts the right unsigned byte");
	Check(FarStringCompare("Revenger", "Revenge") == 'r',
		"a NUL right prefix subtracts from the left unsigned byte");
	Check(FarStringCompare(
		(const char *) highLeft, (const char *) highRight) == 0x00FE,
		"mismatching characters are promoted as unsigned bytes");
	Check(FarStringCompare(
		(const char *) highRight, (const char *) highLeft) == -0x00FE,
		"unsigned-byte subtraction retains a negative result");
}

static void TestMaximumBound(void)
{
	char *left = (char *) malloc(0xFFFF);
	char *right = (char *) malloc(0xFFFF);

	Check(left != NULL && right != NULL,
		"maximum compare fixtures allocate");
	if (left == NULL || right == NULL)
	{
		free(left);
		free(right);
		return;
	}

	memset(left, 'X', 0xFFFF);
	memset(right, 'X', 0xFFFF);
	Check(FarStringCompare(left, right) == 0x00,
		"unterminated equal operands stop at the FFFFh byte cap");
	left[0xFFFE] = 'Y';
	Check(FarStringCompare(left, right) == 0x01,
		"the final byte inside the bounded comparison is significant");

	free(left);
	free(right);
}

int main(void)
{
	TestOrdinaryComparisons();
	TestMaximumBound();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
