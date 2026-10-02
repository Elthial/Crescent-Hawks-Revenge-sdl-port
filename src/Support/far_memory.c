#include "revenge/far_memory.h"

#include <stddef.h>
#include <stdint.h>

enum
{
	HOST_FAR_POINTER_SLOT_COUNT = 0x0200
};

#define HOST_FAR_POINTER_AUTO_LINEAR_START 0x000E0000UL
#define HOST_FAR_POINTER_AUTO_LINEAR_END   0x000FFFF0UL

typedef struct HostFarPointerEntry
{
	byte *hostBase;
	uint32 byteCount;
	uint32 farLinearBase;
} HostFarPointerEntry;

static HostFarPointerEntry hostFarPointers[HOST_FAR_POINTER_SLOT_COUNT];
static uint32 nextAutoFarLinear = HOST_FAR_POINTER_AUTO_LINEAR_START;

static uint32 FarAddressToLinear(uint32 farAddress)
{
	return ((farAddress >> 0x10) << 0x04) + (word16) farAddress;
}

static uint32 LinearToFarAddress(uint32 linearAddress)
{
	return ((linearAddress >> 0x04) << 0x10) |
		(linearAddress & 0x0F);
}

static HostFarPointerEntry *FindHostEntry(
	const void *hostPointer,
	uint32 *displacement)
{
	uintptr_t hostAddress = (uintptr_t) hostPointer;
	word16 index;

	for (index = 0x00; index < HOST_FAR_POINTER_SLOT_COUNT; ++index)
	{
		HostFarPointerEntry *entry = &hostFarPointers[index];
		uintptr_t baseAddress;
		uintptr_t delta;

		if (entry->hostBase == NULL)
			continue;
		baseAddress = (uintptr_t) entry->hostBase;
		if (hostAddress < baseAddress)
			continue;
		delta = hostAddress - baseAddress;
		if (delta >= entry->byteCount)
			continue;
		*displacement = (uint32) delta;
		return entry;
	}

	return NULL;
}

static HostFarPointerEntry *FindFarEntry(
	uint32 farLinearAddress,
	uint32 *displacement)
{
	word16 index;

	for (index = 0x00; index < HOST_FAR_POINTER_SLOT_COUNT; ++index)
	{
		HostFarPointerEntry *entry = &hostFarPointers[index];
		uint32 delta;

		if (entry->hostBase == NULL ||
			farLinearAddress < entry->farLinearBase)
			continue;
		delta = farLinearAddress - entry->farLinearBase;
		if (delta >= entry->byteCount)
			continue;
		*displacement = delta;
		return entry;
	}

	return NULL;
}

static HostFarPointerEntry *FindFreeEntry(void)
{
	word16 index;

	for (index = 0x00; index < HOST_FAR_POINTER_SLOT_COUNT; ++index)
	{
		if (hostFarPointers[index].hostBase == NULL)
			return &hostFarPointers[index];
	}
	return NULL;
}

uint32 HostFarPointer_RegisterAt(
	void *hostPointer,
	uint32 byteCount,
	uint32 farAddress)
{
	HostFarPointerEntry *entry;
	uint32 displacement;

	if (hostPointer == NULL)
		return 0x00000000UL;
	entry = FindHostEntry(hostPointer, &displacement);
	if (entry == NULL)
		entry = FindFreeEntry();
	if (entry == NULL)
		return 0x00000000UL;

	entry->hostBase = (byte *) hostPointer;
	entry->byteCount = byteCount == 0x00 ? 0x01 : byteCount;
	entry->farLinearBase = FarAddressToLinear(farAddress);
	return LinearToFarAddress(entry->farLinearBase);
}

uint32 HostFarPointer_Register(void *hostPointer, uint32 byteCount)
{
	HostFarPointerEntry *existing;
	uint32 displacement;
	uint32 allocationSize;
	uint32 farAddress;

	if (hostPointer == NULL)
		return 0x00000000UL;
	if ((uintptr_t) hostPointer <= UINT32_MAX)
		return (uint32) (uintptr_t) hostPointer;

	existing = FindHostEntry(hostPointer, &displacement);
	if (existing != NULL)
		return LinearToFarAddress(existing->farLinearBase + displacement);

	allocationSize = byteCount == 0x00 ? 0x10 :
		(byteCount + 0x0F) & 0xFFFFFFF0UL;
	if (nextAutoFarLinear + allocationSize > HOST_FAR_POINTER_AUTO_LINEAR_END)
		return 0x00000000UL;
	farAddress = LinearToFarAddress(nextAutoFarLinear);
	nextAutoFarLinear += allocationSize;
	return HostFarPointer_RegisterAt(hostPointer, byteCount, farAddress);
}

uint32 HostFarPointer_Encode(const void *hostPointer)
{
	HostFarPointerEntry *entry;
	uint32 displacement;

	if (hostPointer == NULL)
		return 0x00000000UL;
	if ((uintptr_t) hostPointer <= UINT32_MAX)
		return (uint32) (uintptr_t) hostPointer;

	entry = FindHostEntry(hostPointer, &displacement);
	if (entry == NULL)
		return HostFarPointer_Register((void *) hostPointer, 0x01);
	return LinearToFarAddress(entry->farLinearBase + displacement);
}

uint32 HostFarPointer_ToLinear(const void *hostPointer)
{
	uint32 encoded = HostFarPointer_Encode(hostPointer);

	return FarAddressToLinear(encoded);
}

void *HostFarPointer_Resolve(uint32 farAddress)
{
	uint32 farLinearAddress;
	uint32 displacement;
	HostFarPointerEntry *entry;

	if (farAddress == 0x00000000UL)
		return NULL;
	farLinearAddress = FarAddressToLinear(farAddress);
	entry = FindFarEntry(farLinearAddress, &displacement);
	if (entry == NULL)
		return (void *) (uintptr_t) farAddress;
	return entry->hostBase + displacement;
}

void *HostFarPointer_LoadWords(
	const word16 *offsetWord,
	const word16 *segmentWord)
{
	return HostFarPointer_Resolve(
		((uint32) *segmentWord << 0x10) | *offsetWord);
}

void HostFarPointer_StoreWords(
	word16 *offsetWord,
	word16 *segmentWord,
	const void *hostPointer)
{
	uint32 farAddress = HostFarPointer_Encode(hostPointer);

	*offsetWord = (word16) farAddress;
	*segmentWord = (word16) (farAddress >> 0x10);
}

void HostFarPointer_Unregister(const void *hostPointer)
{
	uint32 displacement;
	HostFarPointerEntry *entry;

	if (hostPointer == NULL || (uintptr_t) hostPointer <= UINT32_MAX)
		return;
	entry = FindHostEntry(hostPointer, &displacement);
	if (entry == NULL || displacement != 0x00)
		return;
	entry->hostBase = NULL;
	entry->byteCount = 0x00;
	entry->farLinearBase = 0x00;
}

void HostFarPointer_Reset(void)
{
	word16 index;

	for (index = 0x00; index < HOST_FAR_POINTER_SLOT_COUNT; ++index)
	{
		hostFarPointers[index].hostBase = NULL;
		hostFarPointers[index].byteCount = 0x00;
		hostFarPointers[index].farLinearBase = 0x00;
	}
	nextAutoFarLinear = HOST_FAR_POINTER_AUTO_LINEAR_START;
}
