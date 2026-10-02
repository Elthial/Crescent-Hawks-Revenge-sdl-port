#ifndef REVENGE_FAR_MEMORY_H
#define REVENGE_FAR_MEMORY_H

#include "revenge/types.h"

/*
 * Mechanical bridge between original 16:16 pointer values and host pointers.
 * It contains no game policy. Unregistered 32-bit values remain literal DOS
 * addresses; registered host blocks receive stable synthetic far addresses.
 */
uint32 HostFarPointer_Register(void *hostPointer, uint32 byteCount);
uint32 HostFarPointer_RegisterAt(
	void *hostPointer, uint32 byteCount, uint32 farAddress);
uint32 HostFarPointer_Encode(const void *hostPointer);
uint32 HostFarPointer_ToLinear(const void *hostPointer);
void *HostFarPointer_Resolve(uint32 farAddress);
void *HostFarPointer_LoadWords(
	const word16 *offsetWord,
	const word16 *segmentWord);
void HostFarPointer_StoreWords(
	word16 *offsetWord,
	word16 *segmentWord,
	const void *hostPointer);
void HostFarPointer_Unregister(const void *hostPointer);
void HostFarPointer_Reset(void);

#endif
