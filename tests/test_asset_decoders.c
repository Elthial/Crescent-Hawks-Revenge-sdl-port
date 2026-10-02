#include "revenge/assets.h"

#include <assert.h>
#include <string.h>

static void WriteDword(byte *destination, uint32 value)
{
    destination[0x00] = (byte)value;
    destination[0x01] = (byte)(value >> 0x08);
    destination[0x02] = (byte)(value >> 0x10);
    destination[0x03] = (byte)(value >> 0x18);
}

static void TestRawBlock(void)
{
    byte block[0x0C] = { 0x00 };
    byte output[0x04] = { 0x00 };

    WriteDword(block + 0x02, sizeof(output));
    block[0x08] = 0x10;
    block[0x09] = 0x20;
    block[0x0A] = 0x30;
    block[0x0B] = 0x40;
    DecodeWestwoodPackedResource(block, output);
    assert(memcmp(output, block + 0x08, sizeof(output)) == 0x00);
}

static void TestRleBlock(void)
{
    byte block[0x12] = { 0x03 };
    const byte expected[] =
    {
        0x10, 0x20, 0x30,
        0x44, 0x44, 0x44,
        0x55, 0x55, 0x55, 0x55
    };
    byte output[sizeof(expected)] = { 0x00 };

    WriteDword(block + 0x02, sizeof(output));
    block[0x08] = 0x03;
    block[0x09] = 0x10;
    block[0x0A] = 0x20;
    block[0x0B] = 0x30;
    block[0x0C] = 0xFD;
    block[0x0D] = 0x44;
    block[0x0E] = 0x00;
    block[0x0F] = 0x00;
    block[0x10] = 0x04;
    block[0x11] = 0x55;
    DecodeRLEBlock(block, output);
    assert(memcmp(output, expected, sizeof(expected)) == 0x00);
}

static void TestLzw12Literals(void)
{
    byte block[0x0E] = { 0x01 };
    byte dictionary[0x3C00] = { 0x00 };
    byte output[0x03] = { 0x00 };

    WriteDword(block + 0x02, sizeof(output));
    block[0x08] = 0x04;
    block[0x09] = 0x10;
    block[0x0A] = 0x42;
    block[0x0B] = 0x04;
    block[0x0C] = 0x3F;
    block[0x0D] = 0xFF;
    DecodeWestwoodLzw12(block, output, dictionary);
    assert(output[0x00] == 0x41);
    assert(output[0x01] == 0x42);
    assert(output[0x02] == 0x43);
}

static void PackFourLzw14Codes(byte *destination, const uint16 *codes)
{
    uint16 bitIndex;

    memset(destination, 0x00, 0x07);
    for (bitIndex = 0x0000; bitIndex < 0x0038; ++bitIndex)
    {
        uint16 codeIndex;
        uint16 codeBit;

        codeIndex = bitIndex / 0x000E;
        codeBit = 0x000D - (bitIndex % 0x000E);
        destination[bitIndex / 0x0008] |= (byte)(
            ((codes[codeIndex] >> codeBit) & 0x01)
            << (0x07 - bitIndex % 0x0008));
    }
}

static void TestLzw14Literals(void)
{
    byte block[0x0F] = { 0x02 };
    byte dictionary[0xBD00] = { 0x00 };
    byte output[0x03] = { 0x00 };
    const uint16 codes[] = { 0x0041, 0x0042, 0x0043, 0x3FFF };

    WriteDword(block + 0x02, sizeof(output));
    PackFourLzw14Codes(block + 0x08, codes);
    DecodeWestwoodLzw14(block, output, dictionary);
    assert(output[0x00] == 0x41);
    assert(output[0x01] == 0x42);
    assert(output[0x02] == 0x43);
}

int main(void)
{
    TestRawBlock();
    TestRleBlock();
    TestLzw12Literals();
    TestLzw14Literals();
    return 0x00;
}
