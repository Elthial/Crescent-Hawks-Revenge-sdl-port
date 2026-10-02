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

static void TestOrdinaryStrings(void)
{
	Check(StringLength("") == 0x0000,
		"an immediate NUL has zero length");
	Check(StringLength("Revenge") == 0x0007,
		"ordinary text returns its character count");
}

static void TestMaximumScan(void)
{
	char *text = (char *) malloc(0xFFFF);
	Check(text != NULL, "maximum-scan fixture allocates");
	if (text == NULL)
		return;

	memset(text, 'X', 0xFFFF);
	text[0xFFFE] = '\0';
	Check(StringLength(text) == 0xFFFE,
		"a NUL in the final scanned byte returns FFFEh");

	text[0xFFFE] = 'X';
	Check(StringLength(text) == 0xFFFE,
		"an exhausted CX=FFFFh scan returns FFFEh like NOT/DEC");
	free(text);
}

int main(void)
{
	TestOrdinaryStrings();
	TestMaximumScan();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
