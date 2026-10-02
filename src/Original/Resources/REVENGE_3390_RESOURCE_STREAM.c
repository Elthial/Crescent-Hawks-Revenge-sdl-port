// REVENGE_3390_RESOURCE_STREAM.c
// Assembly-led transcription of the tracked-file and resident-resource layer.

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

// 3390:0002
void AbortRuntimeWithMessage(const char *errorText)
{
	uint32 errorTextPointer = HostFarPointer_Register(
		(void *)errorText, (uint32)StringLength(errorText) + 0x01);

	ResourceFiles.errorText.segment = HIGH_WORD(errorTextPointer);
	ResourceFiles.errorText.offset = LOW_WORD(errorTextPointer);
	if (ResourceErrorDisplayCallback != NULL)
		ResourceErrorDisplayCallback();
	if (ResourceErrorDismissCallback != NULL)
		ResourceErrorDismissCallback();
	ShutdownAndExit(0x0001);
}

// 3390:0024
void ShutdownAndExit(word16 exitCode)
{
	ShutdownGame();
	RunExitHandlersAndTerminate(exitCode);
}

// 3390:0037
int16 OpenTrackedFile(char *path, word16 openMode)
{
	word16 openFlags;
	int16 trackedHandle;
	int16 handleSlot;

	if (openMode == 0x0001)
	{
		if (IsResourceCached(path) == FALSE && CanOpenFileForRead(path) == FALSE)
		{
			ResourceFiles.pendingDriveMask = GetResourceDriveMask(path);
			if (ResourceFiles.availableDriveMask != 0x0000)
				SelectResourceDrive(ResourceFiles.pendingDriveMask);
		}
		openFlags = 0x8001;
	}
	else if (openMode == 0x0002)
	{
		DeleteFileIgnoringErrors(path);
		openFlags = 0x8002;
	}
	else if (openMode == 0x0003)
	{
		word16 retriesRemaining = ResourceRetryCount;
		uint32 errorTextPointer;

		if (CanOpenFileForRead(path) == FALSE)
		{
			do
			{
				if (CanOpenFileForWrite(path) != FALSE)
					break;
				--retriesRemaining;
				if (retriesRemaining == 0x0000)
					break;
				errorTextPointer = HostFarPointer_Register(
					(void *)ResourceCreateFileErrorText,
					(uint32)StringLength(ResourceCreateFileErrorText) + 0x01);
				ResourceFiles.errorText.segment = HIGH_WORD(errorTextPointer);
				ResourceFiles.errorText.offset = LOW_WORD(errorTextPointer);
				if (ResourceErrorDisplayCallback != NULL)
					ResourceErrorDisplayCallback();
			} while (TRUE);

			if (CanOpenFileForRead(path) == FALSE)
			{
				if (ResourceErrorDismissCallback != NULL)
					ResourceErrorDismissCallback();
				ShutdownAndExit(0x0001);
			}
		}
		openFlags = 0x8004;
	}
	else
	{
		uint32 errorTextPointer = HostFarPointer_Register(
			(void *)ResourceIllegalOpenModeErrorText,
			(uint32)StringLength(ResourceIllegalOpenModeErrorText) + 0x01);

		ResourceFiles.errorText.segment = HIGH_WORD(errorTextPointer);
		ResourceFiles.errorText.offset = LOW_WORD(errorTextPointer);
		if (ResourceErrorDisplayCallback != NULL)
			ResourceErrorDisplayCallback();
		if (ResourceErrorDismissCallback != NULL)
			ResourceErrorDismissCallback();
		ShutdownAndExit(0x0001);
		openFlags = 0x0000;
	}

	if (IsResourceCached(path) != FALSE)
	{
		word16 resourceIndex = FindResourceDescriptorIndex(path);

		CachedFileDescriptors[resourceIndex].currentPosition = 0x00000000UL;
		trackedHandle = (int16)(resourceIndex | ORIGINAL_TRACKED_FILE_CACHED);
	}
	else
	{
		word16 retriesRemaining = ResourceRetryCount;
		uint32 errorTextPointer;

		trackedHandle = CRT_OpenFile(path, openFlags, 0x0180);
		while (trackedHandle == -0x01 && retriesRemaining != 0x0000)
		{
			trackedHandle = CRT_OpenFile(path, openFlags, 0x0180);
			if (trackedHandle == -0x01)
			{
				--retriesRemaining;
				ResourceFiles.pendingDriveMask = GetResourceDriveMask(path);
				errorTextPointer = HostFarPointer_Register(
					(void *)ResourceInsertDiskErrorText,
					(uint32)StringLength(ResourceInsertDiskErrorText) + 0x01);
				ResourceFiles.errorText.segment = HIGH_WORD(errorTextPointer);
				ResourceFiles.errorText.offset = LOW_WORD(errorTextPointer);
				if (ResourceErrorDisplayCallback != NULL)
					ResourceErrorDisplayCallback();
			}
		}
		if (trackedHandle == -0x01)
		{
			if (ResourceErrorDismissCallback != NULL)
				ResourceErrorDismissCallback();
			ShutdownAndExit(0x0001);
		}
	}

	handleSlot = ORIGINAL_TRACKED_FILE_COUNT;
	for (int16 slot = 0x0000; slot < ORIGINAL_TRACKED_FILE_COUNT; ++slot)
	{
		if (ResourceFiles.trackedHandles[slot] == ORIGINAL_TRACKED_FILE_UNUSED)
		{
			handleSlot = slot;
			break;
		}
	}
	if (handleSlot == ORIGINAL_TRACKED_FILE_COUNT)
	{
		uint32 errorTextPointer = HostFarPointer_Register(
			(void *)ResourceTooManyOpenFilesErrorText,
			(uint32)StringLength(ResourceTooManyOpenFilesErrorText) + 0x01);

		ResourceFiles.errorText.segment = HIGH_WORD(errorTextPointer);
		ResourceFiles.errorText.offset = LOW_WORD(errorTextPointer);
		if (ResourceErrorDisplayCallback != NULL)
			ResourceErrorDisplayCallback();
		if (ResourceErrorDismissCallback != NULL)
			ResourceErrorDismissCallback();
		/* DS:B64E immediately follows the ten-entry table in the executable. */
		ResourceFiles.preloadFiles = (word16)trackedHandle;
	}
	else
	{
		ResourceFiles.trackedHandles[handleSlot] = (word16)trackedHandle;
	}
	return handleSlot;
}

// 3390:0244
void CloseTrackedFile(int16 handleSlot)
{
	word16 trackedHandle = ResourceFiles.trackedHandles[handleSlot];

	if (trackedHandle == ORIGINAL_TRACKED_FILE_UNUSED)
		AbortRuntimeWithMessage(ResourceCloseUnopenedErrorText);
	if ((trackedHandle & ORIGINAL_TRACKED_FILE_CACHED) == 0x0000)
		CRT_CloseFile((int16)trackedHandle);
	ResourceFiles.trackedHandles[handleSlot] = ORIGINAL_TRACKED_FILE_UNUSED;
}

// 3390:028C
uint32 ReadTrackedFile(int16 handleSlot, void *destination, uint32 byteCount)
{
	word16 trackedHandle = ResourceFiles.trackedHandles[handleSlot];
	uint32 totalBytesRead = 0x00000000UL;

	if (trackedHandle == ORIGINAL_TRACKED_FILE_UNUSED)
		AbortRuntimeWithMessage(ResourceReadUnopenedErrorText);
	if ((trackedHandle & ORIGINAL_TRACKED_FILE_CACHED) != 0x0000)
		return ReadCachedResource(trackedHandle & 0x7FFF, destination, byteCount);

	while ((int16)HIGH_WORD(byteCount) > 0x0000 ||
		(HIGH_WORD(byteCount) == 0x0000 && LOW_WORD(byteCount) > 0xFA00))
	{
		int16 chunkBytesRead = ReadFileWithTextTranslation(
			trackedHandle, destination, 0xFA00);

		byteCount -= 0x0000FA00UL;
		if (chunkBytesRead == -0x01)
			return 0x00000000UL;
		totalBytesRead += (word16)chunkBytesRead;
	}

	{
		int16 finalBytesRead = ReadFileWithTextTranslation(
			trackedHandle, destination, LOW_WORD(byteCount));

		if (finalBytesRead == -0x01)
			return 0x00000000UL;
		return totalBytesRead + (word16)finalBytesRead;
	}
}

// 3390:0372
uint32 WriteTrackedFile(int16 handleSlot, const void *source, uint32 byteCount)
{
	word16 trackedHandle = ResourceFiles.trackedHandles[handleSlot];
	uint32 totalBytesWritten = 0x00000000UL;

	if (trackedHandle == ORIGINAL_TRACKED_FILE_UNUSED)
		AbortRuntimeWithMessage(ResourceWriteUnopenedErrorText);
	if ((trackedHandle & ORIGINAL_TRACKED_FILE_CACHED) != 0x0000)
		AbortRuntimeWithMessage(ResourceWriteCachedErrorText);

	while ((int16)HIGH_WORD(byteCount) > 0x0000 ||
		(HIGH_WORD(byteCount) == 0x0000 && LOW_WORD(byteCount) > 0xFA00))
	{
		int16 chunkBytesWritten = WriteFileWithTextTranslation(
			(int16)trackedHandle, source, 0xFA00);

		if (chunkBytesWritten == -0x01)
			return 0x00000000UL;
		byteCount -= 0x0000FA00UL;
		totalBytesWritten += (word16)chunkBytesWritten;
	}

	{
		int16 finalBytesWritten = WriteFileWithTextTranslation(
			(int16)trackedHandle, source, LOW_WORD(byteCount));

		if (finalBytesWritten == -0x01)
			return 0x00000000UL;
		return totalBytesWritten + (word16)finalBytesWritten;
	}
}

// 3390:0441
void SeekTrackedFile(int16 handleSlot, int32 distance, word16 origin)
{
	word16 trackedHandle = ResourceFiles.trackedHandles[handleSlot];

	if (trackedHandle == ORIGINAL_TRACKED_FILE_UNUSED)
		AbortRuntimeWithMessage(ResourceSeekUnopenedErrorText);
	if (origin > 0x0002)
		AbortRuntimeWithMessage(ResourceIllegalSeekOriginErrorText);

	if ((trackedHandle & ORIGINAL_TRACKED_FILE_CACHED) == 0x0000)
	{
		(void)DOS_SeekFile(trackedHandle, (long)distance, (byte)origin);
	}
	else
	{
		CachedFileDescriptor *resource =
			&CachedFileDescriptors[trackedHandle & 0x7FFF];
		int32 basePosition;
		int32 newPosition;

		if (origin == 0x0000)
		{
			int16 lengthHigh = (int16)HIGH_WORD(resource->fileLength);
			int16 distanceHigh = (int16)HIGH_WORD((uint32)distance);

			if (lengthHigh > distanceHigh ||
				(lengthHigh == distanceHigh &&
				LOW_WORD(resource->fileLength) >= LOW_WORD((uint32)distance)))
			{
				resource->currentPosition = (uint32)distance;
			}
			else
			{
				resource->currentPosition = resource->fileLength;
			}
			return;
		}
		if (origin == 0x0001)
			basePosition = (int32)resource->currentPosition;
		else
			basePosition = (int32)resource->fileLength;

		newPosition = basePosition + distance;
		if (newPosition < 0x00000000L)
			newPosition = 0x00000000L;
		if ((uint32)newPosition > resource->fileLength)
			newPosition = (int32)resource->fileLength;
		resource->currentPosition = (uint32)newPosition;
	}
}

// 3390:061F
word16 CanOpenFileForRead(const char *path)
{
	int16 fileHandle = CRT_OpenFile(path, 0x8001, 0x0000);

	if (fileHandle == -0x01)
		return FALSE;
	CRT_CloseFile(fileHandle);
	return TRUE;
}

// 3390:064F
void DeleteFileIgnoringErrors(char *filePath)
{
	(void)DOS_DeleteFile(filePath);
}

// 3390:0668
word16 CanOpenFileForWrite(const char *path)
{
	int16 fileHandle = CRT_OpenFile(path, 0x8102, 0x0180);

	if (fileHandle == -0x01)
		return FALSE;
	CRT_CloseFile(fileHandle);
	return TRUE;
}

// 3390:069C
word16 GetResourceDriveMask(char *path)
{
	word16 resourceIndex = 0x0000;
	char *normalizedPath = UppercaseStringInPlace(path);

	while (*(char *)HostFarPointer_Resolve(
		DosAddress_ToValue(
			CachedFileDescriptors[resourceIndex].fileName)) != '\0')
	{
		CachedFileDescriptor *resource = &CachedFileDescriptors[resourceIndex];

		if (FarStringCompare(
			(char *)HostFarPointer_Resolve(
				DosAddress_ToValue(resource->fileName)),
			normalizedPath) == 0x0000)
			return resource->resourceDriveMask;
		++resourceIndex;
	}
	AbortRuntimeWithMessage(ResourceUnknownDriveErrorText);
	return 0x0000;
}

// 3390:098C
void ReleaseCachedResources(void)
{
	word16 resourceIndex = 0x0000;
	int16 handleSlot;

	while (*(char *)HostFarPointer_Resolve(
		DosAddress_ToValue(
			CachedFileDescriptors[resourceIndex].fileName)) != '\0')
	{
		CachedFileDescriptor *resource = &CachedFileDescriptors[resourceIndex];

		if (!DosAddress_IsNull(resource->cachedData))
		{
			FreeFarHeapAllocation((byte *)HostFarPointer_Resolve(
				DosAddress_ToValue(resource->cachedData)));
			resource->cachedData = DosAddress_FromValue(0x00000000UL);
		}
		++resourceIndex;
	}

	for (handleSlot = 0x0000; handleSlot < ORIGINAL_TRACKED_FILE_COUNT; ++handleSlot)
	{
		if (ResourceFiles.trackedHandles[handleSlot] != ORIGINAL_TRACKED_FILE_UNUSED)
			AbortRuntimeWithMessage(ResourceOpenFilesAtExitErrorText);
	}
}

// 3390:0A22
void InitializeResourceCache(void)
{
	int16 remainingConventionalMemoryKB;
	word16 resourceIndex;
	int16 handleSlot;

	/* Host-only mechanical registration for the original 16:16 name fields. */
	OriginalData_InitializeResourceDescriptorPointers();
	for (handleSlot = 0x0000; handleSlot < ORIGINAL_TRACKED_FILE_COUNT; ++handleSlot)
		ResourceFiles.trackedHandles[handleSlot] = ORIGINAL_TRACKED_FILE_UNUSED;

	remainingConventionalMemoryKB = (int16)(
		GetLargestFreeConventionalMemoryKB() - ReservedConventionalMemoryKB);
	ResourceFiles.availableDriveMask = 0x0000;
	resourceIndex = 0x0000;
	while (*(char *)HostFarPointer_Resolve(
		DosAddress_ToValue(
			CachedFileDescriptors[resourceIndex].fileName)) != '\0')
	{
		CachedFileDescriptor *resource = &CachedFileDescriptors[resourceIndex];
		word16 allocationKB;
		byte *cachedData;
		int16 fileHandle;
		int32 bytesRead;

		ResourceFiles.availableDriveMask |= resource->resourceDriveMask;
		if (ResourceFiles.preloadFiles == FALSE)
		{
			++resourceIndex;
			continue;
		}

		resource->fileName = DosAddress_FromValue(HostFarPointer_Encode(
			UppercaseStringInPlace((char *)HostFarPointer_Resolve(
				DosAddress_ToValue(resource->fileName)))));
		allocationKB = (word16)DivideUnsignedLong(
			resource->fileLength, 0x00000400UL) + 0x0001;
		cachedData = NULL;
		if (remainingConventionalMemoryKB >= (int16)allocationKB)
			cachedData = AllocateFarHeapBytes(resource->fileLength);
		if (cachedData == NULL)
		{
			++resourceIndex;
			continue;
		}

		fileHandle = CRT_OpenFile(
			(char *)HostFarPointer_Resolve(
				DosAddress_ToValue(resource->fileName)),
			0x8001, 0x0180);
		if (fileHandle == -0x01)
		{
			FreeFarHeapAllocation(cachedData);
			++resourceIndex;
			continue;
		}

		bytesRead = ReadFileWithTextTranslation(
			fileHandle, cachedData, LOW_WORD(resource->fileLength));
		if ((uint32)bytesRead == resource->fileLength)
		{
			resource->cachedData = DosAddress_FromValue(
				HostFarPointer_Encode(cachedData));
			CRT_CloseFile(fileHandle);
			remainingConventionalMemoryKB -= (int16)allocationKB;
		}
		else
		{
			FreeFarHeapAllocation(cachedData);
			CRT_CloseFile(fileHandle);
		}
		++resourceIndex;
	}
}

// 3390:0BFF
word16 IsResourceCached(char *path)
{
	word16 resourceIndex = 0x0000;
	char *normalizedPath = UppercaseStringInPlace(path);

	while (*(char *)HostFarPointer_Resolve(
		DosAddress_ToValue(
			CachedFileDescriptors[resourceIndex].fileName)) != '\0')
	{
		CachedFileDescriptor *resource = &CachedFileDescriptors[resourceIndex];

		if (FarStringCompare(
			(char *)HostFarPointer_Resolve(
				DosAddress_ToValue(resource->fileName)),
			normalizedPath) == 0x0000)
			return !DosAddress_IsNull(resource->cachedData) ? TRUE : FALSE;
		++resourceIndex;
	}
	return FALSE;
}

// 3390:0C86
word16 FindResourceDescriptorIndex(char *path)
{
	word16 resourceIndex = 0x0000;
	char *normalizedPath = UppercaseStringInPlace(path);

	while (*(char *)HostFarPointer_Resolve(
		DosAddress_ToValue(
			CachedFileDescriptors[resourceIndex].fileName)) != '\0')
	{
		if (FarStringCompare(
			(char *)HostFarPointer_Resolve(
				DosAddress_ToValue(
					CachedFileDescriptors[resourceIndex].fileName)),
			normalizedPath) == 0x0000)
			return resourceIndex;
		++resourceIndex;
	}
	AbortRuntimeWithMessage(ResourceUnknownCacheIndexErrorText);
	return resourceIndex;
}

// 3390:0CF7
word16 ReadCachedResource(
	word16 resourceIndex,
	void *destination,
	uint32 requestedBytes)
{
	CachedFileDescriptor *resource = &CachedFileDescriptors[resourceIndex];
	uint32 bytesToRead = requestedBytes;
	uint32 sourcePointer;

	if (resource->currentPosition + bytesToRead > resource->fileLength)
		bytesToRead = resource->fileLength - resource->currentPosition;
	sourcePointer = NormalizeFarPointer(
		(word16)(resource->cachedData.offset +
			LOW_WORD(resource->currentPosition)),
		resource->cachedData.segment);
	CopyFarBytes32(HostFarPointer_Resolve(sourcePointer), destination, bytesToRead);
	resource->currentPosition += bytesToRead;
	return LOW_WORD(bytesToRead);
}

// 3390:0DFC: expand the active text window equally on all four sides.
// Verified against 3390:0DFC-0E1C.
void AdjustActiveTextWindowMargin(word16 marginTiles)
{
	ActiveTextWindowLeftTile -= marginTiles;
	ActiveTextWindowTopTile -= marginTiles;
	ActiveTextWindowWidthTiles += marginTiles << 0x01;
	ActiveTextWindowHeightTiles += marginTiles << 0x01;
}
