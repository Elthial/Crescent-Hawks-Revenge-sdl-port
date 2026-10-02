#include "REVENGE.h"
#include "revenge/original_data.h"

#include <stdio.h>
#include <stdlib.h>

static int failures;
static byte selectedDrives[0x02];
static word16 selectionCount;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

void DOS_SelectDefaultDrive(byte zeroBasedDrive)
{
	if (selectionCount < 0x02)
		selectedDrives[selectionCount] = zeroBasedDrive;
	++selectionCount;
}

static void ResetSelections(void)
{
	selectedDrives[0x00] = 0xFF;
	selectedDrives[0x01] = 0xFF;
	selectionCount = 0x00;
}

static void TestDisabled(void)
{
	ResetSelections();
	ResourceDriveSelectionDisabled = TRUE;
	SecondaryResourceDriveEnabled = TRUE;
	SelectResourceDrive(0x01);
	Check(selectionCount == 0x00,
		"disabled resource-drive selection performs no DOS call");
}

static void TestPrimaryOnly(void)
{
	ResetSelections();
	ResourceDriveSelectionDisabled = FALSE;
	SecondaryResourceDriveEnabled = FALSE;
	SelectResourceDrive(0x01);
	Check(selectionCount == 0x01 && selectedDrives[0x00] == DOS_DRIVE_A,
		"single-drive resources select only DOS drive A");
}

static void TestNonPositiveIndex(void)
{
	ResetSelections();
	ResourceDriveSelectionDisabled = FALSE;
	SecondaryResourceDriveEnabled = TRUE;
	SelectResourceDrive(-0x01);
	Check(selectionCount == 0x01 && selectedDrives[0x00] == DOS_DRIVE_A,
		"the secondary-drive comparison is signed and strictly positive");
}

static void TestSecondaryDrive(void)
{
	ResetSelections();
	ResourceDriveSelectionDisabled = FALSE;
	SecondaryResourceDriveEnabled = TRUE;
	SelectResourceDrive(0x01);
	Check(selectionCount == 0x02 &&
		selectedDrives[0x00] == DOS_DRIVE_A &&
		selectedDrives[0x01] == DOS_DRIVE_B,
		"a positive secondary resource selects A and then B");
}

int main(void)
{
	TestDisabled();
	TestPrimaryOnly();
	TestNonPositiveIndex();
	TestSecondaryDrive();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
