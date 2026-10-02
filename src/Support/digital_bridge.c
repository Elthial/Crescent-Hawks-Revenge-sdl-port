#include "../Original/REVENGE.h"
#include "revenge/audio.h"
#include "revenge/digital_bridge.h"

#define SOUND_HARDWARE_UNAVAILABLE 0xFFFF

word16 ProbeNullSoundHardware(void);
word16 ProbeTandy3VoiceHardware(void);
word16 ProbeTandyDACHardware(void);
word16 ProbeIBMPS1AudioHardware(void);
word16 ProbeSoundBlasterHardware(word16 probeParameter);
word16 ProbeAdLibSoundHardware(void);
word16 ProbeCMSHardware(void);
word16 ProbeInnovationHardware(void);
word16 ProbeCovoxHardware(void);
void AcquireNullSoundHardware(word16 parameter);
void AcquireTandy3VoiceHardware(word16 parameter);
void AcquireTandyDACHardware(word16 parameter);
void AcquireIBMPS1AudioHardware(word16 parameter);
void AcquireSoundBlasterHardware(word16 parameter);
void AcquireAdLibSoundHardware(word16 parameter);
void AcquireCMSHardware(word16 parameter);
void AcquireInnovationHardware(word16 parameter);
void AcquireCovoxHardware(word16 parameter);
void ReleaseNullSoundHardware(void);
void ReleaseTandy3VoiceHardware(void);
void ReleaseTandyDACHardware(void);
void ReleaseIBMPS1AudioHardware(void);
void ReleaseSoundBlasterHardware(void);
void ReleaseAdLibSoundHardware(void);
void ReleaseCMSHardware(void);
void ReleaseInnovationHardware(void);
void ReleaseCovoxHardware(void);

struct DigitalHardwareDescriptor *
DigitalBridge_ResolveHardwareDescriptor(word16 descriptorOffset)
{
	switch (descriptorOffset)
	{
	case 0x6D28: return &NullDigitalHardware;
	case 0x6D40: return &Tandy3VoiceHardware;
	case 0x6D6A: return &TandyDACHardware;
	case 0x6DA2: return &IBMPS1AudioHardware;
	case 0x6DC2: return &SoundBlasterHardware;
	case 0x6DEC: return &AdLibSoundHardware;
	case 0x6E12: return &CMSSoundHardware;
	case 0x6E52: return &InnovationSoundHardware;
	case 0x6E84: return &CovoxSoundHardware;
	default: return NULL;
	}
}

struct DigitalPlaybackDescriptor *
DigitalBridge_ResolvePlaybackDescriptor(word16 descriptorOffset)
{
	switch (descriptorOffset)
	{
	case 0x6EB2: return &NullDigitalPlayback;
	case 0x6EBE: return &Tandy3VoicePlayback;
	case 0x6ECA: return &TandyDACPlayback;
	case 0x6ED6: return &IBMPS1Playback;
	case 0x6EE2: return &SoundBlasterPlayback;
	case 0x6EEE: return &AdLibPlayback;
	case 0x6F28: return &CMSPlayback;
	case 0x6F34: return &InnovationPlayback;
	case 0x6F40: return &CovoxPlayback;
	default: return NULL;
	}
}

const word16 *DigitalBridge_ResolveProbeCandidateList(word16 listOffset)
{
	switch (listOffset)
	{
	case 0x6DD2: return SoundBlasterProbePorts;
	case 0x6E22: return CMSProbePorts;
	case 0x6E62: return InnovationProbePorts;
	case 0x6E94: return CovoxProbePorts;
	default: return NULL;
	}
}

word16 DigitalBridge_DispatchHardwareProbe(
	word16 callbackOffset, word16 probeParameter)
{
	switch (callbackOffset)
	{
	case 0x0070: return ProbeNullSoundHardware();
	case 0x0076: return ProbeTandy3VoiceHardware();
	case 0x0098: return ProbeTandyDACHardware();
	case 0x00CC: return ProbeIBMPS1AudioHardware();
	case 0x011B: return ProbeSoundBlasterHardware(probeParameter);
	case 0x0190: return ProbeAdLibSoundHardware();
	case 0x0225: return ProbeCMSHardware();
	case 0x026A: return ProbeInnovationHardware();
	case 0x02AB: return ProbeCovoxHardware();
	default: return SOUND_HARDWARE_UNAVAILABLE;
	}
}

void DigitalBridge_DispatchHardwareAcquire(
	word16 callbackOffset, word16 parameter)
{
	switch (callbackOffset)
	{
	case 0x0074: AcquireNullSoundHardware(parameter); break;
	case 0x0095: AcquireTandy3VoiceHardware(parameter); break;
	case 0x00CA: AcquireTandyDACHardware(parameter); break;
	case 0x00F3: AcquireIBMPS1AudioHardware(parameter); break;
	case 0x0143: AcquireSoundBlasterHardware(parameter); break;
	case 0x01E9: AcquireAdLibSoundHardware(parameter); break;
	case 0x0228: AcquireCMSHardware(parameter); break;
	case 0x026D: AcquireInnovationHardware(parameter); break;
	case 0x02AE: AcquireCovoxHardware(parameter); break;
	}
}

void DigitalBridge_DispatchHardwareRelease(word16 callbackOffset)
{
	switch (callbackOffset)
	{
	case 0x0075: ReleaseNullSoundHardware(); break;
	case 0x0096: ReleaseTandy3VoiceHardware(); break;
	case 0x00CB: ReleaseTandyDACHardware(); break;
	case 0x00F4: ReleaseIBMPS1AudioHardware(); break;
	case 0x014F: ReleaseSoundBlasterHardware(); break;
	case 0x01F5: ReleaseAdLibSoundHardware(); break;
	case 0x0260: ReleaseCMSHardware(); break;
	case 0x0282: ReleaseInnovationHardware(); break;
	case 0x02C0: ReleaseCovoxHardware(); break;
	}
}

void DigitalBridge_InvokeSampleCompletion(
	struct DigitalSampleDescriptor *descriptor)
{
	if (descriptor->CompletionCallbackSegment == 0x31FB &&
		descriptor->CompletionCallbackOffset == 0x06E9)
	{
		HandleDigitalWeaponEffectCompletion(
			descriptor->CompletionArgumentLow,
			descriptor->CompletionArgumentHigh);
	}
}
