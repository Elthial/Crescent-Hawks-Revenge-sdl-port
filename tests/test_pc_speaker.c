#include "revenge/audio.h"
#include "revenge/far_memory.h"
#include "fake_backend.h"

#include <assert.h>
#include <string.h>

int main(void)
{
    byte samples[] = { 0x00, 0x40, 0x80, 0xFF };
    byte expected[sizeof(samples)];

    FakeBackend_Reset();
    BuildPCSpeakerSampleLookup();
    assert(PCSpeakerSampleConversion.SampleLookup[0x00] == 0x00);
    assert(PCSpeakerSampleConversion.SampleLookup[0xFF] == 0xFF);
    memcpy(expected, samples, sizeof(samples));
    expected[0x00] = PCSpeakerSampleConversion.SampleLookup[expected[0x00]];
    expected[0x01] = PCSpeakerSampleConversion.SampleLookup[expected[0x01]];
    expected[0x02] = PCSpeakerSampleConversion.SampleLookup[expected[0x02]];
    expected[0x03] = PCSpeakerSampleConversion.SampleLookup[expected[0x03]];
    TranslatePCSpeakerSampleBuffer(samples, sizeof(samples));
    assert(memcmp(samples, expected, sizeof(samples)) == 0x00);

    HostFarPointer_RegisterAt(samples, sizeof(samples), 0x50000008UL);
    PCSpeakerSampleConversion.DelayScale = 0x0003;
    PlayPCSpeakerBitstream(
        HostFarPointer_Resolve(0x4FFF0018UL), (word16)sizeof(samples));
    assert(fakeBackend.firstWord == 0x0003);
    assert(fakeBackend.secondWord == sizeof(samples));
    assert(fakeBackend.buffer == samples);
    HostFarPointer_Reset();

    assert(InitializePCSpeakerSampleConversion(0x1F40) == TRUE);
    assert(PCSpeakerSampleConversion.DelayScale != 0x0000);
    return 0x00;
}
