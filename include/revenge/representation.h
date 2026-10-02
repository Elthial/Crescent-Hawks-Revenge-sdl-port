#ifndef REVENGE_REPRESENTATION_H
#define REVENGE_REPRESENTATION_H

#include "revenge/types.h"

struct DigitalSampleDescriptor;
struct DigitalWeaponEffectRecord;
struct DigitalSoundEntryRecord;
struct FarHeapBlockHeader;
struct PresentationMessageRecord;

byte *OriginalData_DigitalSoundDataAt(word16 dataSegmentOffset);
word16 *OriginalData_DigitalSoundDriverDescriptorOffsets(void);
struct DigitalSampleDescriptor *
	OriginalData_DigitalSamplePlaybackDescriptors(void);
struct DigitalWeaponEffectRecord *OriginalData_DigitalWeaponEffectTable(void);
struct DigitalSoundEntryRecord *OriginalData_DigitalSoundEntries(void);
const char *OriginalData_DigitalSoundString(word16 dataSegmentOffset);
void OriginalData_InitializeResourceDescriptorPointers(void);
struct PresentationMessageRecord *OriginalData_PresentationMessageRecords(void);

struct FarHeapBlockHeader *FarHeapBridge_ResolveBlock(uint32 address);
uint32 FarHeapBridge_EncodeBlock(const struct FarHeapBlockHeader *block);
struct FarHeapBlockHeader *FarHeapBridge_GetArenaBase(void);
void FarHeapBridge_SetArenaBase(struct FarHeapBlockHeader *arenaBase);
struct FarHeapBlockHeader *FarHeapBridge_GetTailBlock(void);
void FarHeapBridge_SetTailBlock(struct FarHeapBlockHeader *tailBlock);
struct FarHeapBlockHeader *FarHeapBridge_GetFreeListHead(void);
void FarHeapBridge_SetFreeListHead(struct FarHeapBlockHeader *freeListHead);
byte *FarHeapBridge_GetPayload(struct FarHeapBlockHeader *block);

void *ProgramBreakBridge_GetMinimum(void);
void *ProgramBreakBridge_GetCurrent(void);
void ProgramBreakBridge_SetCurrent(void *programBreak);
void *ProgramBreakBridge_GetMaximum(void);
void ProgramBreakBridge_SetMaximum(void *programBreak);

#endif
