/* Preserved save-file compatibility loop from REVENGE_0D73. */

#include "REVENGE.h"

/* 0D73:4572-4610 */
int16 EnsureCompatibleSaveFile(
	int16 fileHandle,
	char *savePath,
	word16 openMode)
{
	int16 nextRecordOffset;
	int16 saveVersion;
	word16 searching;

	searching = TRUE;
	while (searching != FALSE)
	{
		nextRecordOffset = 0x0002;
		SeekTrackedFile(fileHandle, nextRecordOffset, 0x0000);
		ReadTrackedFile(fileHandle, &nextRecordOffset, 0x00000002UL);
		SeekTrackedFile(fileHandle, nextRecordOffset, 0x0000);
		ReadTrackedFile(fileHandle, &saveVersion, 0x00000002UL);
		if (saveVersion >= (int16) 0x0097)
		{
			searching = FALSE;
		}
		else
		{
			CloseTrackedFile(fileHandle);
			ShowInvalidSaveVersionDialog();
			fileHandle = OpenTrackedFile(savePath, openMode);
		}
	}
	return fileHandle;
}
