#include "../Original/REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

byte *OriginalData_DigitalSoundDataAt(word16 dataSegmentOffset)
{
	return &DigitalSoundData.Bytes[
		dataSegmentOffset - DIGITAL_SOUND_DATA_FIRST_OFFSET];
}

word16 *OriginalData_DigitalSoundDriverDescriptorOffsets(void)
{
	return DigitalSoundData.Layout.DriverDescriptorOffsets;
}

struct DigitalSampleDescriptor *
OriginalData_DigitalSamplePlaybackDescriptors(void)
{
	return DigitalSoundData.Layout.SampleDescriptors;
}

struct DigitalWeaponEffectRecord *OriginalData_DigitalWeaponEffectTable(void)
{
	return DigitalSoundData.Layout.WeaponEffects;
}

struct DigitalSoundEntryRecord *OriginalData_DigitalSoundEntries(void)
{
	return DigitalSoundData.Layout.SoundEntries;
}

const char *OriginalData_DigitalSoundString(word16 dataSegmentOffset)
{
	return (const char *)
		OriginalData_DigitalSoundDataAt(dataSegmentOffset);
}

PresentationMessageRecord *OriginalData_PresentationMessageRecords(void)
{
	return (PresentationMessageRecord *) HostFarPointer_Resolve(
		MAKE_DWORD(0x3A6A, 0x2B54));
}

void OriginalData_InitializeResourceDescriptorPointers(void)
{
	word16 resourceIndex;

	for (resourceIndex = 0x0000;
		resourceIndex < ORIGINAL_RESOURCE_DESCRIPTOR_COUNT;
		++resourceIndex)
	{
		CachedFileDescriptors[resourceIndex].fileName =
			DosAddress_FromValue(HostFarPointer_Register(
				ResourceFileNames[resourceIndex], 0x0010));
		CachedFileDescriptors[resourceIndex].fileLength =
			ResourceFileLengths[resourceIndex];
	}
}

