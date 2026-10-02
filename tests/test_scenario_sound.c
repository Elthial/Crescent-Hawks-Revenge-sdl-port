#include "fake_backend.h"
#include "revenge/audio.h"
#include "revenge/far_memory.h"
#include "revenge/original_data.h"
#include "../src/Original/REVENGE.h"

#include <assert.h>

int main(void)
{
	static byte informationSample[0x3442];

	FakeBackend_Reset();
	HostFarPointer_Reset();

	/* The assertions read the exact DS:5CFC catalog embedded in Original. */
	assert(FindDigitalSoundEntryByCode('I') == 0x00);
	assert(FindDigitalSoundEntryByCode('T') == 0x01);
	assert(FindDigitalSoundEntryByCode('=') == 0x02);
	assert(FindDigitalSoundEntryByCode('.') == 0x03);
	assert(FindDigitalSoundEntryByCode('J') == 0x0A);
	assert(FindDigitalSoundEntryByCode('r') == 0x15);
	assert(FindDigitalSoundEntryByCode('?') == -0x01);

	/* Scenario FFh is the one-code "I" sequence at DS:5E6E. Run it
	 * through the original descriptor builder and PC-speaker boundary. */
	DigitalSoundBuffer = informationSample;
	NarrationMode = 0x01;
	SoundDriverIndex = 0x00;
	PCSpeakerSampleConversion.DelayScale = 0x0001;
	PlayScenarioDigitalSoundSequence(-0x01);
	assert(fakeBackend.buffer == informationSample);
	assert(fakeBackend.secondWord == sizeof(informationSample));
	assert(ActiveDigitalSampleDescriptor != NULL);
	assert(ActiveDigitalSampleDescriptor->SampleLength ==
		sizeof(informationSample));

	NarrationMode = 0x00;
	fakeBackend.buffer = NULL;
	PlayScenarioDigitalSoundSequence(-0x01);
	assert(fakeBackend.buffer == NULL);
	return 0x00;
}
