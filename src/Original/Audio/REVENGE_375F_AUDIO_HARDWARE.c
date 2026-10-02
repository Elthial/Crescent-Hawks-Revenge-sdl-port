/* REVENGE_375F_AUDIO_HARDWARE.c -- digital-output drivers and software mixer. */

#include "REVENGE.h"
#include "revenge/digital_bridge.h"
#include "revenge/platform_backend.h"

#include <stdbool.h>

#define SOUND_HARDWARE_AVAILABLE 0x0001
#define SOUND_HARDWARE_UNAVAILABLE 0xFFFF
#define TANDY_PSG_DATA_PORT 0x00C0
#define TANDY_PSG_STEREO_PORT 0x00C1
#define TANDY_DAC_MODE_PORT 0x00C4
#define TANDY_DAC_DATA_PORT 0x00C5
#define TANDY_DAC_CONTROL_PORT 0x00C7
#define IBM_PS1_DAC_DATA_PORT 0x0200
#define IBM_PS1_DAC_CONTROL_PORT 0x0203
#define ADLIB_REGISTER_PORT 0x0388
#define ADLIB_DATA_PORT 0x0389
#define ADLIB_TIMER_STATUS_MASK 0xE0
#define ADLIB_TIMER_OVERFLOW_MASK 0xC0
#define SOUND_BLASTER_DSP_DIRECT_DAC_COMMAND 0x10
#define SOUND_BLASTER_DSP_SPEAKER_ON_COMMAND 0xD1
#define SOUND_BLASTER_DSP_SPEAKER_OFF_COMMAND 0xD3
#define INTERRUPT_SYSTEM_TIMER_IRQ 0x08

#define LEGACY_AUDIO_TANDY 0x01
#define LEGACY_AUDIO_IBM_PS1 0x02
#define LEGACY_AUDIO_ADLIB 0x03
#define LEGACY_AUDIO_SOUND_BLASTER 0x05
#define LEGACY_AUDIO_COVOX 0x06
#define LEGACY_AUDIO_INNOVATION 0x07
#define LEGACY_AUDIO_CMS 0x08

#define ReadLegacyPort SDLBackend_ReadLegacyAudioPort
#define WriteLegacyPort SDLBackend_WriteLegacyAudioPort

/* Exact DOS hardware descriptors and probe lists at DS:6D28-6EA3. */
DigitalHardwareDescriptor NullDigitalHardware =
	{ 0x6D38, 0x0000, 0x0000, 0x0000, 0x0070, 0x0074, 0x0075, 0x0000 };
DigitalHardwareDescriptor Tandy3VoiceHardware =
	{ 0x6D50, 0x0000, 0x0000, 0x0000, 0x0076, 0x0095, 0x0096, 0x0000 };
DigitalHardwareDescriptor TandyDACHardware =
	{ 0x6D7A, 0x0000, 0x0000, 0x0000, 0x0098, 0x00CA, 0x00CB, 0x0000 };
DigitalHardwareDescriptor IBMPS1AudioHardware =
	{ 0x6DB2, 0x0000, 0x0000, 0x0000, 0x00CC, 0x00F3, 0x00F4, 0x0000 };
DigitalHardwareDescriptor SoundBlasterHardware =
	{ 0x6DDE, 0x0220, 0x0006, 0x6DD2, 0x011B, 0x0143, 0x014F, 0x0000 };
DigitalHardwareDescriptor AdLibSoundHardware =
	{ 0x6DFC, 0x0000, 0x0000, 0x0000, 0x0190, 0x01E9, 0x01F5, 0x0000 };
DigitalHardwareDescriptor CMSSoundHardware =
	{ 0x6E2E, 0x0220, 0x0006, 0x6E22, 0x0225, 0x0228, 0x0260, 0x0000 };
DigitalHardwareDescriptor InnovationSoundHardware =
	{ 0x6E6A, 0x0280, 0x0004, 0x6E62, 0x026A, 0x026D, 0x0282, 0x0000 };
DigitalHardwareDescriptor CovoxSoundHardware =
	{ 0x6E9C, 0x0220, 0x0004, 0x6E94, 0x02AB, 0x02AE, 0x02C0, 0x0000 };

const word16 SoundBlasterProbePorts[0x06] =
	{ 0x0210, 0x0220, 0x0230, 0x0240, 0x0250, 0x0260 };
const word16 CMSProbePorts[0x06] =
	{ 0x0210, 0x0220, 0x0230, 0x0240, 0x0250, 0x0260 };
const word16 InnovationProbePorts[0x04] =
	{ 0x0280, 0x02A0, 0x02C0, 0x02E0 };
const word16 CovoxProbePorts[0x04] =
	{ 0x0220, 0x0240, 0x0280, 0x02C0 };

/* Exact DOS sampled-output descriptors at DS:6EB2-6F4B. */
DigitalPlaybackDescriptor NullDigitalPlayback =
	{ 0x6D28, 0x02EE, 0x02EF, 0x02F0, 0x0000, 0x0000 };
DigitalPlaybackDescriptor Tandy3VoicePlayback =
	{ 0x6D40, 0x02F2, 0x02FB, 0x02FC, 0x0200, 0x0000 };
DigitalPlaybackDescriptor TandyDACPlayback =
	{ 0x6D6A, 0x030C, 0x0319, 0x031A, 0x0100, 0x0000 };
DigitalPlaybackDescriptor IBMPS1Playback =
	{ 0x6DA2, 0x031E, 0x0325, 0x0326, 0x0100, 0x0000 };
DigitalPlaybackDescriptor SoundBlasterPlayback =
	{ 0x6DC2, 0x032C, 0x032D, 0x032E, 0x0070, 0x0000 };
DigitalPlaybackDescriptor AdLibPlayback =
	{ 0x6DEC, 0x033A, 0x0366, 0x036C, 0x0200, 0x0000 };
DigitalPlaybackDescriptor CMSPlayback =
	{ 0x6E12, 0x0376, 0x0387, 0x038C, 0x0400, 0x0000 };
DigitalPlaybackDescriptor InnovationPlayback =
	{ 0x6E52, 0x049C, 0x049D, 0x049E, 0x0300, 0x0000 };
DigitalPlaybackDescriptor CovoxPlayback =
	{ 0x6E84, 0x04AE, 0x04B4, 0x04B5, 0x0100, 0x0000 };

// Hardware callback block, reconstructed from 375F:0070-04BB. These routines
// are deliberately kept close to the device descriptors: the generic mixer
// calls the selected writer once per timer tick with one unsigned PCM byte in
// AL. Probe callbacks return 0001h when usable and FFFFh when absent; the CMS,
// Innovation, and Covox descriptors have no reliable software probe and return
// zero as an explicit "not detected" result.

word16 SoundBlasterBasePort;
word16 AdLibRegisterDelay;
word16 AdLibDataDelay;
word16 CMSDataPort0;
word16 CMSRegisterPort0;
word16 CMSDataPort1;
word16 CMSRegisterPort1;
word16 InnovationOutputPort;
word16 CovoxCommandPort;
word16 CovoxDataPort;
const byte CMSAmplitudeLookup[0x100] =
{
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
	0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
	0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
	0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
	0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
	0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
	0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77, 0x77,
	0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
	0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
	0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
	0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB, 0xBB,
	0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC,
	0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD,
	0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE,
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
};

static const word16 AdLibDigitalCarrierRegisters[] =
{
	0x2001, 0x0008, 0x00BD, 0x00A0, 0x00B0, 0x01C0,
	0x2120, 0x0040, 0xF060, 0xF080, 0x00E0, 0x2123,
	0x3F43, 0xF063, 0xF083, 0x00E3, 0x7040, 0x01B0,
	0x6004, 0x8004, 0xB002, 0x33A0, 0x0000
};

word16 ProbeNullSoundHardware(void) { return SOUND_HARDWARE_AVAILABLE; }
void AcquireNullSoundHardware(word16 parameter) { (void) parameter; }
void ReleaseNullSoundHardware(void) {}

word16 ProbeTandy3VoiceHardware(void)
{
	return SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_TANDY)
		? SOUND_HARDWARE_AVAILABLE : SOUND_HARDWARE_UNAVAILABLE;
}
void AcquireTandy3VoiceHardware(word16 parameter) { (void) parameter; }
void ReleaseTandy3VoiceHardware(void) {}

word16 ProbeTandyDACHardware(void)
{
	// V: after the same Tandy ROM test as 0076, INT 15h/AH=C0h must return
	// a system-configuration record whose first word is 0003h and byte +2 FFh.
	// The interrupt register ABI is left explicit pending a common BIOS wrapper.
	return SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_TANDY)
		? SOUND_HARDWARE_AVAILABLE : SOUND_HARDWARE_UNAVAILABLE;
}
void AcquireTandyDACHardware(word16 parameter) { (void) parameter; }
void ReleaseTandyDACHardware(void) {}

word16 ProbeIBMPS1AudioHardware(void)
{
	// V: INT 15h/AH=C0h supplies the system descriptor. The routine accepts
	// model word 0BFCh only when CMOS register 2Fh has feature bit 10h set.
	return SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_IBM_PS1)
		? SOUND_HARDWARE_AVAILABLE : SOUND_HARDWARE_UNAVAILABLE;
}
void AcquireIBMPS1AudioHardware(word16 parameter) { (void) parameter; }
void ReleaseIBMPS1AudioHardware(void) {}

// 375F:0100: wait until the caller-selected DSP write port is ready, then
// write one command/data byte. The original register ABI is AH=value, DX=port.
void WriteSoundBlasterDSPPort(byte value, word16 writePort)
{
	while ((ReadLegacyPort(writePort) & 0x80) != 0x00) {}
	WriteLegacyPort(writePort, value);
}

void WriteSoundBlasterDSP(byte value)
{
	WriteSoundBlasterDSPPort(
		value,
		SoundBlasterBasePort + 0x0C);
}

byte ReadSoundBlasterDSP(void)
{
	word16 port = SoundBlasterBasePort + 0x0E;
	/* SDL's hosted DSP is always ready; DOS polled bit 7 here. */
	return ReadLegacyPort(port - 0x04);
}

word16 ProbeSoundBlasterHardware(word16 candidateBasePort)
{
	word16 delay;
	word16 resetPort;

	if (!SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_SOUND_BLASTER))
		return SOUND_HARDWARE_UNAVAILABLE;
	resetPort = candidateBasePort + 0x06;
	WriteLegacyPort(resetPort, 0x01);
	for (delay = 0x0100; delay != 0x0000; --delay)
		;
	WriteLegacyPort(resetPort, 0x00);
	while ((ReadLegacyPort(candidateBasePort + 0x0E) & 0x80) == 0x00)
		;
	return ReadLegacyPort(candidateBasePort + 0x0A) == 0xAA
		? candidateBasePort : SOUND_HARDWARE_UNAVAILABLE;
}

void AcquireSoundBlasterHardware(word16 basePort)
{
	SoundBlasterBasePort = basePort;
	WriteSoundBlasterDSP(SOUND_BLASTER_DSP_SPEAKER_ON_COMMAND);
}
void ReleaseSoundBlasterHardware(void)
{
	WriteSoundBlasterDSP(SOUND_BLASTER_DSP_SPEAKER_OFF_COMMAND);
}

// 375F:0163: complete an OPL write after the register index has been sent.
// The original register ABI is AH=value, CX=registerDelay, DX=registerPort.
void WriteAdLibDataAtPort(
	byte value,
	word16 registerDelay,
	word16 registerPort)
{
	while (registerDelay-- != 0x0000)
		(void) ReadLegacyPort(registerPort);
	WriteLegacyPort(registerPort + 0x01, value);
	for (volatile word16 delay = AdLibDataDelay;
		delay != 0x0000; --delay)
		(void) ReadLegacyPort(registerPort);
}

// 375F:015B: write a packed OPL register/value pair to a caller-selected
// base port. The original register ABI is AX=registerAndValue, DX=port.
void WriteAdLibRegisterAtPort(
	word16 registerAndValue,
	word16 registerPort)
{
	WriteLegacyPort(registerPort, LOW_BYTE(registerAndValue));
	WriteAdLibDataAtPort(
		HIGH_BYTE(registerAndValue),
		AdLibRegisterDelay,
		registerPort);
}

void WriteAdLibRegister(word16 registerAndValue)
{
	WriteAdLibRegisterAtPort(registerAndValue, ADLIB_REGISTER_PORT);
}

void LoadAdLibRegisterList(const word16 *registerList)
{
	while (*registerList != 0x0000)
		WriteAdLibRegister(*registerList++);
}

word16 ProbeAdLibSoundHardware(void)
{
	// V: canonical OPL2 timer probe. Status must initially have E0h clear and
	// then report C0h after timer 1 is started. The successful pass also derives
	// the two calibrated I/O delay-loop counts stored at 0154h and 0156h.
	if (!SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_ADLIB))
		return SOUND_HARDWARE_UNAVAILABLE;
	AdLibRegisterDelay = 0x0001;
	AdLibDataDelay = 0x0001;
	return SOUND_HARDWARE_AVAILABLE;
}
void AcquireAdLibSoundHardware(word16 parameter)
{
	(void) parameter;
	WriteAdLibRegister(MAKE_WORD(0x20, 0x01));
	WriteAdLibRegister(MAKE_WORD(0x00, 0x08));
}
void ReleaseAdLibSoundHardware(void) {}

void WriteCMSBothChips(word16 registerAndValue)
{
	byte registerIndex = LOW_BYTE(registerAndValue);
	byte value = HIGH_BYTE(registerAndValue);
	WriteLegacyPort(CMSRegisterPort1, registerIndex);
	WriteLegacyPort(CMSRegisterPort0, registerIndex);
	WriteLegacyPort(CMSDataPort1, value);
	WriteLegacyPort(CMSDataPort0, value);
}

word16 ProbeCMSHardware(void)
{
	return SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_CMS)
		? SOUND_HARDWARE_AVAILABLE : SOUND_HARDWARE_UNAVAILABLE;
}
void AcquireCMSHardware(word16 basePort)
{
	CMSDataPort0 = basePort;
	CMSRegisterPort0 = basePort + 0x01;
	CMSDataPort1 = basePort + 0x02;
	CMSRegisterPort1 = basePort + 0x03;
	for (byte registerIndex = 0x00; registerIndex < 0x20; ++registerIndex)
		WriteCMSBothChips(MAKE_WORD(0x00, registerIndex));
	WriteCMSBothChips(MAKE_WORD(0x02, 0x1C));
	WriteCMSBothChips(MAKE_WORD(0x01, 0x1C));
	WriteCMSBothChips(MAKE_WORD(0x3F, 0x14));
	WriteCMSBothChips(MAKE_WORD(0x00, 0x00));
}
void ReleaseCMSHardware(void) { WriteCMSBothChips(MAKE_WORD(0x00, 0x1C)); }

word16 ProbeInnovationHardware(void)
{
	return SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_INNOVATION)
		? SOUND_HARDWARE_AVAILABLE : SOUND_HARDWARE_UNAVAILABLE;
}
void AcquireInnovationHardware(word16 basePort)
{
	word16 port = basePort;
	for (byte index = 0x00; index < 0x19; ++index)
		WriteLegacyPort(port++, 0x00);
	InnovationOutputPort = port - 0x01;
}
void ReleaseInnovationHardware(void)
{
	WriteLegacyPort(InnovationOutputPort, 0x00);
}

word16 ProbeCovoxHardware(void)
{
	return SDLBackend_ProbeLegacyAudioDevice(LEGACY_AUDIO_COVOX)
		? SOUND_HARDWARE_AVAILABLE : SOUND_HARDWARE_UNAVAILABLE;
}
void WriteCovoxControl(word16 commandAndValue)
{
	byte value = LOW_BYTE(commandAndValue);
	byte command = HIGH_BYTE(commandAndValue);
	WriteLegacyPort(CovoxCommandPort, value);
	/* The physical device echoed the command until it latched. */
	WriteLegacyPort(CovoxCommandPort + 0x01, command);
}

void AcquireCovoxHardware(word16 basePort)
{
	CovoxCommandPort = basePort;
	CovoxDataPort = basePort + 0x02;
	WriteCovoxControl(MAKE_WORD(0x0E, 0xFF));
}
void ReleaseCovoxHardware(void) {}

void InitializeNullDigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
}
void ReleaseNullDigitalOutput(void) {}
void WriteNullDigitalSample(byte sample) { (void) sample; }

void InitializeTandy3VoiceDigitalOutput(word16 playbackRateHz)
{
	(void) playbackRateHz;
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
	WriteLegacyPort(TANDY_PSG_DATA_PORT, 0x87);
	WriteLegacyPort(TANDY_PSG_STEREO_PORT, 0x00);
}
void ReleaseTandy3VoiceDigitalOutput(void) {}
void WriteTandy3VoiceDigitalSample(byte sample)
{
	byte attenuation = sample >> 0x04;
	SDLBackend_WriteUnsigned8Sample(sample);
	WriteLegacyPort(TANDY_PSG_DATA_PORT,
		(byte) (0x8F + attenuation + (attenuation < 0x0F ? 0x01 : 0x00)));
}

void InitializeTandyDACDigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
	WriteLegacyPort(TANDY_DAC_MODE_PORT,
		(byte) ((ReadLegacyPort(TANDY_DAC_MODE_PORT) & 0xE0) | 0x03));
	WriteLegacyPort(TANDY_DAC_CONTROL_PORT, 0xE0);
}
void ReleaseTandyDACDigitalOutput(void) {}
void WriteTandyDACDigitalSample(byte sample)
{
	WriteLegacyPort(TANDY_DAC_DATA_PORT, sample);
	SDLBackend_WriteUnsigned8Sample(sample);
}

void InitializeIBMPS1DigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
	WriteLegacyPort(IBM_PS1_DAC_CONTROL_PORT, 0x01);
}
void ReleaseIBMPS1DigitalOutput(void) {}
void WriteIBMPS1DigitalSample(byte sample)
{
	WriteLegacyPort(IBM_PS1_DAC_DATA_PORT, sample);
	SDLBackend_WriteUnsigned8Sample(sample);
}

void InitializeSoundBlasterDigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
}
void ReleaseSoundBlasterDigitalOutput(void) {}
void WriteSoundBlasterDigitalSample(byte sample)
{
	WriteSoundBlasterDSP(SOUND_BLASTER_DSP_DIRECT_DAC_COMMAND);
	WriteSoundBlasterDSP(sample);
	SDLBackend_WriteUnsigned8Sample(sample);
}

void InitializeAdLibDigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
	// V: loads the fixed PCM carrier register list at DS:6EFA, starts OPL
	// timer 1, waits for status C0h, stops the timer, then selects register 40h.
	LoadAdLibRegisterList(AdLibDigitalCarrierRegisters);
	WriteAdLibRegister(MAKE_WORD(0x21, 0x04));
	WriteAdLibRegister(MAKE_WORD(0x23, 0xB0));
	/* SDL acknowledges the OPL timer transition immediately. */
	WriteAdLibRegister(MAKE_WORD(0x20, 0xB0));
	WriteAdLibRegister(MAKE_WORD(0x00, 0x00));
	WriteLegacyPort(ADLIB_REGISTER_PORT, 0x40);
}
void ReleaseAdLibDigitalOutput(void) { WriteAdLibRegister(MAKE_WORD(0x00, 0xB0)); }
void WriteAdLibDigitalSample(byte sample)
{
	WriteLegacyPort(ADLIB_DATA_PORT, sample >> 0x02);
	SDLBackend_WriteUnsigned8Sample(sample);
}

void InitializeCMSDigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
	WriteCMSBothChips(MAKE_WORD(0xFF, 0x08));
	WriteCMSBothChips(MAKE_WORD(0x07, 0x10));
	WriteCMSBothChips(MAKE_WORD(0x00, 0x00));
}
void ReleaseCMSDigitalOutput(void) { WriteCMSBothChips(MAKE_WORD(0x00, 0x00)); }
void WriteCMSDigitalSample(byte sample)
{
	byte amplitude = CMSAmplitudeLookup[sample];
	WriteLegacyPort(CMSDataPort0, amplitude);
	WriteLegacyPort(CMSDataPort1, amplitude);
	SDLBackend_WriteUnsigned8Sample(sample);
}

void InitializeInnovationDigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
}
void ReleaseInnovationDigitalOutput(void) {}
void WriteInnovationDigitalSample(byte sample)
{
	WriteLegacyPort(InnovationOutputPort, sample >> 0x04);
	SDLBackend_WriteUnsigned8Sample(sample);
}

void InitializeCovoxDigitalOutput(word16 playbackRateHz)
{
	SDLBackend_SetDigitalOutputRate(playbackRateHz);
	WriteCovoxControl(MAKE_WORD(0x0F, 0xFF));
}
void ReleaseCovoxDigitalOutput(void) {}
void WriteCovoxDigitalSample(byte sample)
{
	WriteLegacyPort(CovoxDataPort, sample);
	SDLBackend_WriteUnsigned8Sample(sample);
}

#define ResolveDigitalHardwareDescriptor \
	DigitalBridge_ResolveHardwareDescriptor
#define ResolveDigitalPlaybackDescriptor \
	DigitalBridge_ResolvePlaybackDescriptor
#define ResolveProbeCandidateList DigitalBridge_ResolveProbeCandidateList
#define DispatchDigitalHardwareProbe DigitalBridge_DispatchHardwareProbe
#define DispatchDigitalHardwareAcquire DigitalBridge_DispatchHardwareAcquire
#define DispatchDigitalHardwareRelease DigitalBridge_DispatchHardwareRelease

// 375F:0006: invoke the descriptor probe with its default DX parameter.
// Called from:
//      InitializeDigitalSoundDriver
word16 InvokeDigitalHardwareProbe(word16 hardwareOffset)
{
	DigitalHardwareDescriptor *hardware;

	hardware = ResolveDigitalHardwareDescriptor(hardwareOffset);
	return DispatchDigitalHardwareProbe(hardware->ProbeCallbackOffset,
		hardware->DefaultProbeParameter);
}

// 375F:0013: try each DX parameter in the descriptor's candidate list until
// the probe returns a non-negative result. A descriptor without a list uses
// its default parameter directly.
word16 ProbeDigitalHardwareCandidateList(word16 hardwareOffset)
{
	DigitalHardwareDescriptor *hardware;
	const word16 *candidate;
	word16 result;
	word16 index;

	hardware = ResolveDigitalHardwareDescriptor(hardwareOffset);
	if (hardware->ProbeCandidateCount == 0x0000)
		return InvokeDigitalHardwareProbe(hardwareOffset);
	result = SOUND_HARDWARE_UNAVAILABLE;
	candidate = ResolveProbeCandidateList(
		hardware->ProbeCandidateListOffset);
	for (index = 0x0000;
		index < hardware->ProbeCandidateCount && (int16) result < 0x0000;
		++index)
	{
		result = DispatchDigitalHardwareProbe(
			hardware->ProbeCallbackOffset, candidate[index]);
	}
	return result;
}

// 375F:0036: invoke a descriptor probe with a caller-supplied DX parameter.
word16 ProbeDigitalHardwareWithParameter(word16 hardwareOffset,
	word16 probeParameter)
{
	DigitalHardwareDescriptor *hardware;

	hardware = ResolveDigitalHardwareDescriptor(hardwareOffset);
	return DispatchDigitalHardwareProbe(hardware->ProbeCallbackOffset,
		probeParameter);
}

// 375F:0044: reconstructed C signature follows.
// Called from:
//      InitializeDigitalSoundDriver
void AcquireDigitalHardware(word16 hardwareOffset,
	word16 driverParameter)
{
	DigitalHardwareDescriptor *hardware;

	hardware = ResolveDigitalHardwareDescriptor(hardwareOffset);
	++hardware->ReferenceCount;
	if (hardware->ReferenceCount == 0x01)
		DispatchDigitalHardwareAcquire(hardware->AcquireCallbackOffset,
			driverParameter);
}

// 375F:005B: decrement the shared hardware reference count and invoke the
// descriptor's +0C release callback when the final owner leaves.
void ReleaseDigitalHardware(word16 hardwareOffset)
{
	DigitalHardwareDescriptor *hardware;

	hardware = ResolveDigitalHardwareDescriptor(hardwareOffset);
	if (hardware->ReferenceCount != 0x00)
	{
		word16 referenceCount = --hardware->ReferenceCount;
		if (referenceCount == 0x00)
			DispatchDigitalHardwareRelease(hardware->ReleaseCallbackOffset);
	}
}

// 375F:02C2: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void AcquireDigitalPlaybackDriver(word16 driverDescriptorOffset,
	uint16 playbackRateHz)
{
	DigitalPlaybackDescriptor *driver;

	driver = ResolveDigitalPlaybackDescriptor(driverDescriptorOffset);
	++driver->ReferenceCount;
	if (driver->ReferenceCount == 0x01)
	{
		switch (driver->AcquireCallbackOffset)
		{
		case 0x02EE: InitializeNullDigitalOutput(playbackRateHz); break;
		case 0x02F2: InitializeTandy3VoiceDigitalOutput(playbackRateHz); break;
		case 0x030C: InitializeTandyDACDigitalOutput(playbackRateHz); break;
		case 0x031E: InitializeIBMPS1DigitalOutput(playbackRateHz); break;
		case 0x032C: InitializeSoundBlasterDigitalOutput(playbackRateHz); break;
		case 0x033A: InitializeAdLibDigitalOutput(playbackRateHz); break;
		case 0x0376: InitializeCMSDigitalOutput(playbackRateHz); break;
		case 0x049C: InitializeInnovationDigitalOutput(playbackRateHz); break;
		case 0x04AE: InitializeCovoxDigitalOutput(playbackRateHz); break;
		}
	}
}

// 375F:02D9: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void ReleaseDigitalPlaybackDriver(word16 driverDescriptorOffset)
{
	DigitalPlaybackDescriptor *driver;

	driver = ResolveDigitalPlaybackDescriptor(driverDescriptorOffset);
	if (driver->ReferenceCount != 0x00)
	{
		word16 referenceCount = --driver->ReferenceCount;
		if (referenceCount == 0x00)
		{
			switch (driver->ReleaseCallbackOffset)
			{
			case 0x02EF: ReleaseNullDigitalOutput(); break;
			case 0x02FB: ReleaseTandy3VoiceDigitalOutput(); break;
			case 0x0319: ReleaseTandyDACDigitalOutput(); break;
			case 0x0325: ReleaseIBMPS1DigitalOutput(); break;
			case 0x032D: ReleaseSoundBlasterDigitalOutput(); break;
			case 0x0366: ReleaseAdLibDigitalOutput(); break;
			case 0x0387: ReleaseCMSDigitalOutput(); break;
			case 0x049D: ReleaseInnovationDigitalOutput(); break;
			case 0x04B4: ReleaseCovoxDigitalOutput(); break;
			}
		}
	}
}

DigitalPlaybackRuntimeState DigitalPlaybackRuntime =
{
	.SavedSystemTimerVector = { 0x0000, 0x0000 },
	.SystemTimerDivisor = 0x0000,
	.SystemTimerAccumulator = 0x0000,
	.InterruptNestingGuard = 0xFFFF,
	.DigitalTimerReloadMinusOne = 0x0000,
	.PlaybackRateHz = 0x0000,
	.WriteSampleCallbackOffset = 0x0000,
	.ActiveDriverQueue = { 0x0000, 0x0000 },
	.RequestedMixScale = 0x0100,
	.DriverMixScale = 0x0000,
	.ActiveMixScale = 0x0000
};

