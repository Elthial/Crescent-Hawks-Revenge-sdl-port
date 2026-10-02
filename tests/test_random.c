#include "revenge/random.h"

#include <assert.h>
#include <stdlib.h>

int main(void)
{
    static const byte ExpectedSequence[0x10] =
    {
        0x3E, 0xC4, 0x55, 0xC4, 0x3F, 0xA5, 0x27, 0x78,
        0xEB, 0xDA, 0x33, 0xA5, 0x2B, 0xE6, 0x14, 0xC4
    };
    uint16 index;

    for (index = 0x00; index < sizeof(ExpectedSequence); ++index)
        assert(GeneratePseudoRandomByte() == ExpectedSequence[index]);
    for (index = 0x00; index < 0x0100; ++index)
    {
        uint16 value;

        value = RandomInRangeInclusive(0x03, 0x0A);
        assert(value >= 0x03 && value <= 0x0A);
    }
    assert(RandomInRangeInclusive(0x09, 0x04) == 0x09);
    return EXIT_SUCCESS;
}
