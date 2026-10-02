#include "revenge/far_memory.h"

#include <stdio.h>
#include <stdlib.h>

static int failures;

static void Check(int condition, const char *message)
{
	if (!condition)
	{
		fprintf(stderr, "FAIL: %s\n", message);
		++failures;
	}
}

static void TestNullAndLiteralAddresses(void)
{
	void *literal = (void *) (uintptr_t) 0xA2000000UL;

	Check(HostFarPointer_Encode(NULL) == 0x00000000UL &&
		HostFarPointer_Resolve(0x00000000UL) == NULL,
		"null maps to and from 0000:0000");
	Check(HostFarPointer_Encode(literal) == 0xA2000000UL &&
		HostFarPointer_Resolve(0xA2000000UL) == literal,
		"literal DOS far addresses pass through unchanged");
}

static void TestRegisteredHostBlock(void)
{
	byte *block = (byte *) malloc(0x0200);
	uint32 baseAddress;
	uint32 interiorAddress;

	Check(block != NULL, "host block allocates");
	if (block == NULL)
		return;

	HostFarPointer_Reset();
	baseAddress = HostFarPointer_Register(block, 0x0200);
	interiorAddress = HostFarPointer_Encode(block + 0x0123);
	Check((baseAddress >> 0x10) >= 0xE000 &&
		(word16) baseAddress == 0x0000,
		"host allocation receives a synthetic segment with offset zero");
	Check(HostFarPointer_Register(block, 0x0200) == baseAddress,
		"registering the same block returns its stable far address");
	Check((interiorAddress >> 0x10) == (baseAddress >> 0x10) + 0x12 &&
		(word16) interiorAddress == 0x0003,
		"interior host pointers normalize paragraph displacement");
	Check(HostFarPointer_Resolve(baseAddress) == block &&
		HostFarPointer_Resolve(interiorAddress) == block + 0x0123,
		"synthetic base and interior addresses resolve to host memory");

	HostFarPointer_Unregister(block);
	Check(HostFarPointer_Resolve(baseAddress) ==
		(void *) (uintptr_t) baseAddress,
		"an unregistered token no longer resolves to released host memory");
	free(block);
}

static void TestExplicitOriginalAddress(void)
{
	byte block[0x0200];
	uint32 baseAddress;
	uint32 aliasAddress = 0x50100008UL;

	HostFarPointer_Reset();
	baseAddress = HostFarPointer_RegisterAt(
		block, sizeof(block), 0x50000008UL);
	Check(baseAddress == 0x50000008UL,
		"explicit registration retains the original normalized address");
	Check(HostFarPointer_Resolve(aliasAddress) == block + 0x0100,
		"a segment-adjusted alias resolves within the registered range");
	Check(HostFarPointer_Encode(block + 0x0100) == 0x50100008UL,
		"host interior pointers encode to the normalized original range");
}

static void TestIndependentBlocks(void)
{
	byte first[0x10];
	byte second[0x10];
	uint32 firstAddress;
	uint32 secondAddress;

	HostFarPointer_Reset();
	firstAddress = HostFarPointer_Register(first, sizeof(first));
	secondAddress = HostFarPointer_Register(second, sizeof(second));
	Check(firstAddress != secondAddress,
		"independent host blocks receive distinct far addresses");
	Check(HostFarPointer_Resolve(firstAddress) == first &&
		HostFarPointer_Resolve(secondAddress) == second,
		"distinct tokens retain their respective host blocks");
}

static void TestSplitWordStorage(void)
{
	byte block[0x20];
	word16 offsetWord = 0x0000;
	word16 segmentWord = 0x0000;

	HostFarPointer_Reset();
	HostFarPointer_RegisterAt(block, sizeof(block), 0x51230004UL);
	HostFarPointer_StoreWords(
		&offsetWord, &segmentWord, block + 0x000B);
	Check(offsetWord == 0x000F && segmentWord == 0x5123,
		"split storage receives the encoded 16:16 words");
	Check(HostFarPointer_LoadWords(&offsetWord, &segmentWord) == block + 0x000B,
		"split 16:16 words resolve to the registered host pointer");
}

int main(void)
{
	TestNullAndLiteralAddresses();
	TestRegisteredHostBlock();
	TestExplicitOriginalAddress();
	TestIndependentBlocks();
	TestSplitWordStorage();
	return failures == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
