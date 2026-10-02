#include "fake_backend.h"
#include "revenge/audio.h"
#include "revenge/far_memory.h"
#include "revenge/original_data.h"
#include "../src/Original/REVENGE.h"

#include <assert.h>
#include <stdlib.h>

static DigitalWeaponEffectRecord *WeaponEffectRecord(word16 effectId)
{
	return &DigitalSoundData.Layout.WeaponEffects[effectId];
}

static const byte *PendingSpeakerEffectStream(void)
{
	return (const byte *) HostFarPointer_Resolve(DosAddress_ToValue(
		Seg426B.PendingSpeakerEffectStream));
}

int main(void)
{
	static const uint16 expectedOffsets[0x10] =
	{
		0x0000, 0x0027, 0x0046, 0x0063,
		0x00A2, 0x0118, 0x015B, 0x016D,
		0x017C, 0x0187, 0x019C, 0x01B5,
		0x0208, 0x0221, 0x0250, 0x025B
	};
	byte sampleData[0x08] =
		{ 0x00, 0x40, 0x80, 0xFF, 0x80, 0x80, 0x80, 0x80 };
	const byte *speakerEffectBase;
	DigitalWeaponEffectRecord *effect;
	word16 effectIndex;

	FakeBackend_Reset();
	HostFarPointer_Reset();
	SoundEffectsEnabled = TRUE;
	SoundDriverIndex = 0x00;
	DispatchWeaponEffect(0x03);
	assert(!DosAddress_IsNull(Seg426B.PendingSpeakerEffectStream));
	assert(PendingSpeakerEffectStream()[0x00] == 0xE2);
	assert(PendingSpeakerEffectStream()[0x01] == 0x01);

	PlayPCSpeakerEffectByIndex(0x00);
	speakerEffectBase = PendingSpeakerEffectStream();
	for (effectIndex = 0x00; effectIndex < 0x10; ++effectIndex)
	{
		PlayPCSpeakerEffectByIndex(effectIndex);
		assert(PendingSpeakerEffectStream() ==
			speakerEffectBase + expectedOffsets[effectIndex]);
	}

	/* Exercise the original 31FB descriptor/queue path, not the rejected
	 * object-model shortcut. Effect 06h repeats three times. */
	effect = WeaponEffectRecord(0x06);
	effect->PackedBufferOffset = 0x0000;
	effect->SampleLength = 0x0004;
	effect->PlaybackScale = 0x6633;
	DigitalWeaponSampleBuffer = sampleData;
	HostFarPointer_Register(sampleData, sizeof(sampleData));
	DigitalPlaybackRateHz = 0x1F40;
	InitializeDigitalDriverQueue(&ActiveDigitalDriverQueue);
	DigitalSoundBusy = FALSE;
	SoundDriverIndex = 0x01;
	DispatchWeaponEffect(0x06);
	assert(DigitalSoundBusy == TRUE);
	assert(DigitalWeaponEffectRepeatCount == 0x03);
	assert(ActiveDigitalSampleDescriptor != NULL);
	assert(ActiveDigitalSampleDescriptor->SampleLength == 0x0004);

	ServiceDigitalAudioTick();
	ServiceDigitalAudioTick();
	assert(fakeBackend.firstWord == 0x00C0);
	assert(fakeBackend.firstByte == 0x90);
	HandleDigitalWeaponEffectCompletion(
		FAR_OFFSET(ActiveDigitalSampleDescriptor),
		FAR_SEGMENT(ActiveDigitalSampleDescriptor));
	assert(DigitalWeaponEffectRepeatCount == 0x02);
	assert(GetDigitalSamplePlaybackState(
		ActiveDigitalSampleDescriptor) == 0x02);
	RemoveDigitalSampleDescriptor(ActiveDigitalSampleDescriptor);
	ReleaseDigitalPlaybackDriver(0x6EBE);
	RestoreDigitalPlaybackTimer();
	DigitalSoundBusy = FALSE;

	/* A second combat effect replaces the descriptor currently being mixed.
	 * This is the machine-gun/laser overlap exercised by tactical combat. */
	effect = WeaponEffectRecord(0x0E);
	effect->PackedBufferOffset = 0x0000;
	effect->SampleLength = 0x0004;
	effect->PlaybackScale = 0x6633;
	InitializeDigitalDriverQueue(&ActiveDigitalDriverQueue);
	DispatchWeaponEffect(0x0E);
	ServiceDigitalAudioTick();
	DispatchWeaponEffect(0x0E);
	assert(DigitalSoundBusy == TRUE);
	assert(ActiveDigitalDriverQueue.ActiveDescriptorCount == 0x01);
	for (effectIndex = 0x00;
		effectIndex < 0x20 && DigitalSoundBusy != FALSE;
		++effectIndex)
		ServiceDigitalAudioTick();
	assert(DigitalSoundBusy == FALSE);

	SoundEffectsEnabled = FALSE;
	DigitalSoundBusy = FALSE;
	DispatchWeaponEffect(0x06);
	assert(DigitalSoundBusy == FALSE);
	return EXIT_SUCCESS;
}
