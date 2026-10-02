// REVENGE_3621_MIDI_SEQUENCE.c
// Standard MIDI sequence parser and selectable music-driver dispatch layer.

#include "REVENGE.h"
#include "revenge/audio.h"
#include "revenge/interrupts.h"
#include "revenge/host_dispatch.h"
#include "revenge/midi_data.h"
#include "revenge/platform_backend.h"
#include "REVENGE_3621_MIDI_INTERNAL.h"

static DOS_InterruptHandler SavedMPU401IRQHandlerHost;

word16 NullMIDIDriverProbe(void) { return SOUND_HARDWARE_AVAILABLE; }
void ActivateNullMIDIDriver(word16 activationArgument)
{
	(void) activationArgument;
}
void DeactivateNullMIDIDriver(void) {}
word16 FilterNullMIDIByte(word16 midiByte) { (void) midiByte; return 0x0000; }
void NullMIDIVoiceOn(
	word16 voiceRecordOffset,
	word16 channelStateOffset,
	word16 velocity)
{
	(void) voiceRecordOffset;
	(void) channelStateOffset;
	(void) velocity;
}
void NullMIDIVoiceOff(word16 voiceRecordOffset)
{
	(void) voiceRecordOffset;
}
void ResetNullMIDIDriver(void) {}
void LoadNullMIDIInstrument(
	const byte *packedInstrument,
	byte *decodedInstrument)
{
	(void) packedInstrument;
	(void) decodedInstrument;
}
void ServiceNullMIDIDriver(void) {}

MIDIDriverDescriptorData NullMIDIDriverDescriptor =
{
	.AvailableVoiceCount = 0x00,
	.ProbeOffset = 0x08A8,
	.ActivateOffset = 0x08AC,
	.DeactivateOffset = 0x08AD,
	.FilterByteOffset = 0x08AE,
	.StartVoiceOffset = 0x08B1,
	.ReleaseVoiceOffset = 0x08B2,
	.ResetOffset = 0x08B3,
	.LoadInstrumentOffset = 0x08B4,
	.ServiceOffset = 0x08B5
};

static const MIDIDriverHostDispatch NullMIDIDriverHostDispatch =
{
	NullMIDIDriverProbe,
	ActivateNullMIDIDriver,
	DeactivateNullMIDIDriver,
	FilterNullMIDIByte,
	NullMIDIVoiceOn,
	NullMIDIVoiceOff,
	ResetNullMIDIDriver,
	LoadNullMIDIInstrument,
	ServiceNullMIDIDriver
};

word16 SpeakerMIDIDriverProbe(void) { return SOUND_HARDWARE_AVAILABLE; }

void ActivateSpeakerMIDIDriver(word16 activationArgument)
{
	(void) activationArgument;
	DisableHardwareInterrupts();
	SpeakerMIDIRuntime.ActivePITDivisor = 0x0014;
	SDLBackend_EnablePCSpeaker();
	SDLBackend_WritePCSpeakerPITDivisor(0x0014);
	EnableHardwareInterrupts();
}

void DeactivateSpeakerMIDIDriver(void)
{
	DisableHardwareInterrupts();
	SDLBackend_SilencePCSpeaker();
	EnableHardwareInterrupts();
}

word16 FilterSpeakerMIDIByte(word16 midiByte)
{
	(void) midiByte;
	return 0x0000;
}

void SpeakerMIDIVoiceOn(
	word16 voiceRecordOffset,
	word16 channelStateOffset,
	word16 velocity)
{
	MIDIVoiceRecord *voiceRecord;
	byte note;
	word16 divisor;

	(void) channelStateOffset;
	(void) velocity;
	voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
	note = voiceRecord->PlaybackNote;
	divisor = 0x0014;
	if (note >= 0x0E)
		divisor = SpeakerMIDIFrequencyDivisors[note - 0x0E];
	voiceRecord->Driver.Speaker.PITDivisor = divisor;
}

void SpeakerMIDIVoiceOff(word16 voiceRecordOffset)
{
	MIDIVoiceRecordAt(voiceRecordOffset)->
		Driver.Speaker.PITDivisor = 0x0014;
}

void ResetSpeakerMIDIDriver(void)
{
	word16 voice;
	byte count;

	voice = SpeakerMIDIDriverDescriptor.VoiceRecordsOffset;
	SpeakerMIDIRuntime.ServiceVoiceOffset = voice;
	SpeakerMIDIRuntime.ServiceVoiceCountdown =
		SpeakerMIDIDriverDescriptor.ActiveVoiceCount;
	for (count = 0x00;
		count < SpeakerMIDIDriverDescriptor.ActiveVoiceCount;
		++count)
	{
		MIDIVoiceRecord *voiceRecord = MIDIVoiceRecordAt(voice);

		voiceRecord->VoiceClass = 0x01;
		voiceRecord->Driver.Speaker.PITDivisor = 0x0014;
		voice += 0x20;
	}
}

void LoadSpeakerMIDIInstrument(
	const byte *packedInstrument,
	byte *decodedInstrument)
{
	(void) packedInstrument;
	(void) decodedInstrument;
}

void ServiceSpeakerMIDIDriver(void)
{
	word16 voice;
	word16 divisor;

	if (SpeakerMIDIDriverDescriptor.ActiveVoiceCount == 0x00)
		return;
	voice = SpeakerMIDIRuntime.ServiceVoiceOffset;
	divisor = MIDIVoiceRecordAt(voice)->
		Driver.Speaker.PITDivisor;
	if (divisor != SpeakerMIDIRuntime.ActivePITDivisor)
	{
		SpeakerMIDIRuntime.ActivePITDivisor = divisor;
		SDLBackend_WritePCSpeakerPITDivisor(divisor);
	}
	voice += 0x20;
	if (--SpeakerMIDIRuntime.ServiceVoiceCountdown == 0x00)
	{
		SpeakerMIDIRuntime.ServiceVoiceCountdown =
			SpeakerMIDIDriverDescriptor.ActiveVoiceCount;
		voice = SpeakerMIDIDriverDescriptor.VoiceRecordsOffset;
	}
	SpeakerMIDIRuntime.ServiceVoiceOffset = voice;
}

MIDIDriverDescriptorData SpeakerMIDIDriverDescriptor =
{
	.Flags = { 0x00, 0x00, 0x7F },
	.AvailableVoiceCount = 0x04,
	.ProbeOffset = 0x08B6,
	.ActivateOffset = 0x08BA,
	.DeactivateOffset = 0x08D3,
	.FilterByteOffset = 0x08DC,
	.StartVoiceOffset = 0x08DF,
	.ReleaseVoiceOffset = 0x08F8,
	.ResetOffset = 0x08FF,
	.LoadInstrumentOffset = 0x0922,
	.ServiceOffset = 0x0923,
	.ActivationArgument = 0x4000
};

static const MIDIDriverHostDispatch SpeakerMIDIDriverHostDispatch =
{
	SpeakerMIDIDriverProbe,
	ActivateSpeakerMIDIDriver,
	DeactivateSpeakerMIDIDriver,
	FilterSpeakerMIDIByte,
	SpeakerMIDIVoiceOn,
	SpeakerMIDIVoiceOff,
	ResetSpeakerMIDIDriver,
	LoadSpeakerMIDIInstrument,
	ServiceSpeakerMIDIDriver
};

// Tandy and IBM PS/1 three-voice backends ---------------------------------

word16 TandyMIDIDriverProbe(void)
{
	/* 0970h checks the BIOS machine byte and C000:0000 signature. */
	return SDLBackend_ProbeLegacyAudioDevice(0x01);
}

void ActivateTandyMIDIDriver(word16 activationArgument)
{
	ActivateSpeakerMIDIDriver(activationArgument);
}

void DeactivateTandyMIDIDriver(void)
{
	word16 voiceRecordOffset;
	byte voiceCount;

	voiceRecordOffset = TandyMIDIDriverDescriptor.VoiceRecordsOffset;
	voiceCount = TandyMIDIRuntime.HardwareVoiceCount;
	while (voiceCount-- != 0x00)
	{
		MIDIVoiceRecord *voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
		byte latch;

		latch = voiceRecord->Driver.LegacyPSG.VoiceMask | 0x9F;
		voiceRecord->Driver.LegacyPSG.AttenuationLatch = latch;
		SDLBackend_WriteLegacyAudioPort(0x00C0, latch);
		voiceRecordOffset += 0x20;
	}
	DeactivateSpeakerMIDIDriver();
}

word16 FilterTandyMIDIByte(word16 midiByte)
{
	(void) midiByte;
	return FALSE;
}

void TandyMIDIVoiceOn(
	word16 voiceRecordOffset,
	word16 channelStateOffset,
	word16 velocity)
{
	MIDIVoiceRecord *voiceRecord;
	byte note;
	byte voiceMask;
	word16 frequencyWord;

	voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
	if (voiceRecord->VoiceClass != 0x02)
	{
		SpeakerMIDIVoiceOn(
			voiceRecordOffset,
			channelStateOffset,
			velocity);
		return;
	}
	note = voiceRecord->PlaybackNote;
	frequencyWord = 0x0081;
	if (note >= 0x2D && note <= 0x78)
		frequencyWord = TandyMIDIFrequencyWords[note - 0x2D];
	voiceMask = voiceRecord->Driver.LegacyPSG.VoiceMask;
	voiceRecord->Driver.LegacyPSG.FrequencyLatch =
		(word16) (frequencyWord | voiceMask);
	voiceRecord->Driver.LegacyPSG.AttenuationLatch =
		0x92 | voiceMask;
}

void TandyMIDIVoiceOff(word16 voiceRecordOffset)
{
	MIDIVoiceRecord *voiceRecord;
	byte voiceMask;

	voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
	if (voiceRecord->VoiceClass != 0x02)
	{
		SpeakerMIDIVoiceOff(voiceRecordOffset);
		return;
	}
	voiceMask = voiceRecord->Driver.LegacyPSG.VoiceMask;
	voiceRecord->Driver.LegacyPSG.FrequencyLatch =
		(word16) (0x0081 | voiceMask);
	voiceRecord->Driver.LegacyPSG.AttenuationLatch =
		0x9F | voiceMask;
}

void ResetTandyMIDIDriver(void)
{
	word16 voice;
	byte softwareVoiceCount;
	byte hardwareVoiceCount;
	byte remaining;

	voice = TandyMIDIDriverDescriptor.VoiceRecordsOffset;
	TandyMIDIRuntime.ServiceVoiceOffset = voice;
	softwareVoiceCount =
		TandyMIDIDriverDescriptor.ActiveVoiceCount;
	softwareVoiceCount = softwareVoiceCount >= 0x03
		? softwareVoiceCount - 0x03 : 0x00;
	SpeakerMIDIDriverDescriptor.ActiveVoiceCount =
		softwareVoiceCount;
	hardwareVoiceCount =
		TandyMIDIDriverDescriptor.ActiveVoiceCount -
		softwareVoiceCount;
	TandyMIDIRuntime.HardwareVoiceCount = hardwareVoiceCount;
	TandyMIDIRuntime.ServiceVoiceCountdown = hardwareVoiceCount;
	for (remaining = hardwareVoiceCount;
		remaining != 0x00;
		--remaining)
	{
		MIDIVoiceRecord *voiceRecord = MIDIVoiceRecordAt(voice);
		byte voiceMask;

		voiceRecord->VoiceClass = 0x02;
		voiceMask = (byte) ((remaining - 0x01) << 0x05);
		voiceRecord->Driver.LegacyPSG.VoiceMask = voiceMask;
		voiceRecord->Driver.LegacyPSG.FrequencyLatch =
			(word16) (voiceMask | 0x0081);
		voiceRecord->Driver.LegacyPSG.AttenuationLatch =
			voiceMask | 0x9F;
		voice += 0x20;
	}
	SpeakerMIDIDriverDescriptor.VoiceRecordsOffset = voice;
	ResetSpeakerMIDIDriver();
}

void LoadTandyMIDIInstrument(
	const byte *packedInstrument,
	byte *decodedInstrument)
{
	(void) packedInstrument;
	(void) decodedInstrument;
}

void ServiceTandyMIDIDriver(void)
{
	if (TandyMIDIRuntime.HardwareVoiceCount != 0x00)
	{
		MIDIVoiceRecord *voiceRecord;
		word16 voice;
		word16 frequencyWord;

		voice = TandyMIDIRuntime.ServiceVoiceOffset;
		voiceRecord = MIDIVoiceRecordAt(voice);
		frequencyWord = voiceRecord->Driver.LegacyPSG.FrequencyLatch;
		SDLBackend_WriteLegacyAudioPort(0x00C0, LOW_BYTE(frequencyWord));
		SDLBackend_WriteLegacyAudioPort(0x00C1, HIGH_BYTE(frequencyWord));
		SDLBackend_WriteLegacyAudioPort(
			0x00C0,
			voiceRecord->Driver.LegacyPSG.AttenuationLatch);
		voice += 0x20;
		if (--TandyMIDIRuntime.ServiceVoiceCountdown == 0x00)
		{
			TandyMIDIRuntime.ServiceVoiceCountdown =
				TandyMIDIRuntime.HardwareVoiceCount;
			voice = TandyMIDIDriverDescriptor.VoiceRecordsOffset;
		}
		TandyMIDIRuntime.ServiceVoiceOffset = voice;
	}
	ServiceSpeakerMIDIDriver();
}

MIDIDriverDescriptorData TandyMIDIDriverDescriptor =
{
	.Flags = { 0x00, 0x00, 0x7E },
	.AvailableVoiceCount = 0x07,
	.ProbeOffset = 0x0970,
	.ActivateOffset = 0x098E,
	.DeactivateOffset = 0x0992,
	.FilterByteOffset = 0x09B1,
	.StartVoiceOffset = 0x09B4,
	.ReleaseVoiceOffset = 0x09E9,
	.ResetOffset = 0x0A05,
	.LoadInstrumentOffset = 0x0A5B,
	.ServiceOffset = 0x0A5C,
	.ActivationArgument = 0x4000
};

static const MIDIDriverHostDispatch TandyMIDIDriverHostDispatch =
{
	TandyMIDIDriverProbe,
	ActivateTandyMIDIDriver,
	DeactivateTandyMIDIDriver,
	FilterTandyMIDIByte,
	TandyMIDIVoiceOn,
	TandyMIDIVoiceOff,
	ResetTandyMIDIDriver,
	LoadTandyMIDIInstrument,
	ServiceTandyMIDIDriver
};

word16 IBMPS1MIDIDriverProbe(void)
{
	/* 0A90h checks INT 15h/C0h model FC0Bh and CMOS 2Fh bit 10h. */
	return SDLBackend_ProbeLegacyAudioDevice(0x02);
}

void ActivateIBMPS1MIDIDriver(word16 activationArgument)
{
	ActivateSpeakerMIDIDriver(activationArgument);
}

void DeactivateIBMPS1MIDIDriver(void)
{
	word16 voice;
	byte count;

	voice = IBMPS1MIDIDriverDescriptor.VoiceRecordsOffset;
	count = IBMPS1MIDIRuntime.HardwareVoiceCount;
	while (count-- != 0x00)
	{
		MIDIVoiceRecord *voiceRecord = MIDIVoiceRecordAt(voice);
		byte latch;

		latch = voiceRecord->Driver.LegacyPSG.VoiceMask | 0x9F;
		voiceRecord->Driver.LegacyPSG.AttenuationLatch = latch;
		SDLBackend_WriteLegacyAudioPort(0x0205, latch);
		voice += 0x20;
	}
	DeactivateSpeakerMIDIDriver();
}

word16 FilterIBMPS1MIDIByte(word16 midiByte)
{
	(void) midiByte;
	return FALSE;
}

void IBMPS1MIDIVoiceOn(
	word16 voiceRecordOffset,
	word16 channelStateOffset,
	word16 velocity)
{
	MIDIVoiceRecord *voiceRecord;
	byte note;
	byte voiceMask;
	word16 frequencyWord;

	voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
	if (voiceRecord->VoiceClass != 0x02)
	{
		SpeakerMIDIVoiceOn(
			voiceRecordOffset,
			channelStateOffset,
			velocity);
		return;
	}
	note = voiceRecord->PlaybackNote;
	frequencyWord = 0x0081;
	if (note >= 0x2F && note <= 0x78)
		frequencyWord = IBMPS1MIDIFrequencyWords[note - 0x2F];
	voiceMask = voiceRecord->Driver.LegacyPSG.VoiceMask;
	voiceRecord->Driver.LegacyPSG.FrequencyLatch =
		(word16) (frequencyWord | voiceMask);
	voiceRecord->Driver.LegacyPSG.AttenuationLatch =
		0x92 | voiceMask;
}

void IBMPS1MIDIVoiceOff(word16 voiceRecordOffset)
{
	MIDIVoiceRecord *voiceRecord;
	byte voiceMask;

	voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
	if (voiceRecord->VoiceClass != 0x02)
	{
		SpeakerMIDIVoiceOff(voiceRecordOffset);
		return;
	}
	voiceMask = voiceRecord->Driver.LegacyPSG.VoiceMask;
	voiceRecord->Driver.LegacyPSG.FrequencyLatch =
		(word16) (0x0081 | voiceMask);
	voiceRecord->Driver.LegacyPSG.AttenuationLatch =
		0x9F | voiceMask;
}

void ResetIBMPS1MIDIDriver(void)
{
	word16 voice;
	byte softwareVoiceCount;
	byte hardwareVoiceCount;
	byte remaining;

	voice = IBMPS1MIDIDriverDescriptor.VoiceRecordsOffset;
	IBMPS1MIDIRuntime.ServiceVoiceOffset = voice;
	softwareVoiceCount =
		IBMPS1MIDIDriverDescriptor.ActiveVoiceCount;
	softwareVoiceCount = softwareVoiceCount >= 0x03
		? softwareVoiceCount - 0x03 : 0x00;
	SpeakerMIDIDriverDescriptor.ActiveVoiceCount =
		softwareVoiceCount;
	hardwareVoiceCount =
		IBMPS1MIDIDriverDescriptor.ActiveVoiceCount -
		softwareVoiceCount;
	IBMPS1MIDIRuntime.HardwareVoiceCount = hardwareVoiceCount;
	IBMPS1MIDIRuntime.ServiceVoiceCountdown = hardwareVoiceCount;
	for (remaining = hardwareVoiceCount;
		remaining != 0x00;
		--remaining)
	{
		MIDIVoiceRecord *voiceRecord = MIDIVoiceRecordAt(voice);
		byte voiceMask;

		voiceRecord->VoiceClass = 0x02;
		voiceMask = (byte) ((remaining - 0x01) << 0x05);
		voiceRecord->Driver.LegacyPSG.VoiceMask = voiceMask;
		voiceRecord->Driver.LegacyPSG.FrequencyLatch =
			(word16) (voiceMask | 0x0081);
		voiceRecord->Driver.LegacyPSG.AttenuationLatch =
			voiceMask | 0x9F;
		voice += 0x20;
	}
	SpeakerMIDIDriverDescriptor.VoiceRecordsOffset = voice;
	ResetSpeakerMIDIDriver();
}

void LoadIBMPS1MIDIInstrument(
	const byte *packedInstrument,
	byte *decodedInstrument)
{
	(void) packedInstrument;
	(void) decodedInstrument;
}

void ServiceIBMPS1MIDIDriver(void)
{
	if (IBMPS1MIDIRuntime.HardwareVoiceCount != 0x00)
	{
		MIDIVoiceRecord *voiceRecord;
		word16 voice;
		word16 frequencyWord;

		voice = IBMPS1MIDIRuntime.ServiceVoiceOffset;
		voiceRecord = MIDIVoiceRecordAt(voice);
		frequencyWord = voiceRecord->Driver.LegacyPSG.FrequencyLatch;
		SDLBackend_WriteLegacyAudioPort(0x0205, LOW_BYTE(frequencyWord));
		SDLBackend_WriteLegacyAudioPort(0x0205, HIGH_BYTE(frequencyWord));
		SDLBackend_WriteLegacyAudioPort(
			0x0205,
			voiceRecord->Driver.LegacyPSG.AttenuationLatch);
		voice += 0x20;
		if (--IBMPS1MIDIRuntime.ServiceVoiceCountdown == 0x00)
		{
			IBMPS1MIDIRuntime.ServiceVoiceCountdown =
				IBMPS1MIDIRuntime.HardwareVoiceCount;
			voice = IBMPS1MIDIDriverDescriptor.VoiceRecordsOffset;
		}
		IBMPS1MIDIRuntime.ServiceVoiceOffset = voice;
	}
	ServiceSpeakerMIDIDriver();
}

MIDIDriverDescriptorData IBMPS1MIDIDriverDescriptor =
{
	.Flags = { 0x00, 0x00, 0x7E },
	.AvailableVoiceCount = 0x07,
	.ProbeOffset = 0x0A90,
	.ActivateOffset = 0x0AB6,
	.DeactivateOffset = 0x0ABA,
	.FilterByteOffset = 0x0ADD,
	.StartVoiceOffset = 0x0AE0,
	.ReleaseVoiceOffset = 0x0B15,
	.ResetOffset = 0x0B31,
	.LoadInstrumentOffset = 0x0B87,
	.ServiceOffset = 0x0B88,
	.ActivationArgument = 0x4000
};

static const MIDIDriverHostDispatch IBMPS1MIDIDriverHostDispatch =
{
	IBMPS1MIDIDriverProbe,
	ActivateIBMPS1MIDIDriver,
	DeactivateIBMPS1MIDIDriver,
	FilterIBMPS1MIDIByte,
	IBMPS1MIDIVoiceOn,
	IBMPS1MIDIVoiceOff,
	ResetIBMPS1MIDIDriver,
	LoadIBMPS1MIDIInstrument,
	ServiceIBMPS1MIDIDriver
};

// AdLib OPL2 MIDI backend --------------------------------------------------

// 3621:0BBE. 0BCC is an internal continuation after the register-port delay.
void WriteAdLibMIDIRegister(word16 registerAndValue)
{
	volatile word16 delay;

	SDLBackend_WriteLegacyAudioPort(0x0388, LOW_BYTE(registerAndValue));
	for (delay = AdLibMIDIRuntime.RegisterSelectDelay;
		delay != 0x0000;
		--delay)
	{
		(void) SDLBackend_ReadLegacyAudioPort(0x0388);
	}
	SDLBackend_WriteLegacyAudioPort(0x0389, HIGH_BYTE(registerAndValue));
	for (delay = AdLibMIDIRuntime.RegisterDataDelay;
		delay != 0x0000;
		--delay)
	{
		(void) SDLBackend_ReadLegacyAudioPort(0x0388);
	}
}

// 3621:0BDF. 0BED is this loop's RET, not a separate procedure entry.
void WriteAdLibMIDIRegisterList(const word16 *registerList)
{
	word16 registerAndValue;

	registerAndValue = *registerList++;
	while (registerAndValue != 0x0000)
	{
		WriteAdLibMIDIRegister(registerAndValue);
		registerAndValue = *registerList++;
	}
}

// 3621:0BEE: program one five-byte OPL operator patch. The 40h total-level
// register is omitted for the zero-flag path, matching TEST CL,30h / JZ 0C02h.
byte ProgramAdLibPatchOperator(
	const AdLibOperatorPatch *operatorPatch,
	byte operatorRegister,
	byte voiceFlags)
{
	byte registerIndex;

	registerIndex = (byte) (operatorRegister + 0x20);
	WriteAdLibMIDIRegister(
		MAKE_WORD(operatorPatch->Characteristics, registerIndex));
	registerIndex += 0x20;
	if ((voiceFlags & 0x30) != 0x00)
		WriteAdLibMIDIRegister(
			MAKE_WORD(operatorPatch->ScaleAndOutputLevel, registerIndex));
	registerIndex += 0x20;
	WriteAdLibMIDIRegister(
		MAKE_WORD(operatorPatch->AttackAndDecay, registerIndex));
	registerIndex += 0x20;
	WriteAdLibMIDIRegister(
		MAKE_WORD(operatorPatch->SustainAndRelease, registerIndex));
	registerIndex += 0x60;
	WriteAdLibMIDIRegister(
		MAKE_WORD(operatorPatch->WaveformSelect, registerIndex));
	return operatorRegister;
}

void AdLibMIDIVoiceOff(word16 voiceRecordOffset);

word16 AdLibMIDIDriverProbe(void)
{
	/* 0C1Dh performs the OPL2 timer/status calibration. */
	if (SDLBackend_ProbeLegacyAudioDevice(0x03) == FALSE)
		return FALSE;
	AdLibMIDIRuntime.RegisterDataDelay = 0x0001;
	AdLibMIDIRuntime.RegisterSelectDelay = 0x0001;
	return SOUND_HARDWARE_AVAILABLE;
}

void ActivateAdLibMIDIDriver(word16 activationArgument)
{
	(void) activationArgument;
#if defined(REVENGE_DOS_OPL)
	WriteAdLibMIDIRegisterList(AdLibActivateRegisterList);
#else
	/* Hosted replacement for the OPL activation list. The original sequence
	 * engine and voice allocator remain above this hardware boundary. */
	SDLBackend_ResetMusicVoices();
#endif
	AdLibMIDIRuntime.RhythmMask = 0x00;
}

void DeactivateAdLibMIDIDriver(void)
{
#if defined(REVENGE_DOS_OPL)
	WriteAdLibMIDIRegisterList(AdLibDeactivateRegisterList);
#else
	SDLBackend_ResetMusicVoices();
#endif
}

word16 FilterAdLibMIDIByte(word16 midiByte)
{
	(void) midiByte;
	return FALSE;
}

void AdLibMIDIVoiceOn(
	word16 voiceRecordOffset,
	word16 instrumentStateOffset,
	word16 velocity)
{
	MIDIChannelState *instrumentState;
	MIDIVoiceRecord *voiceRecord;
	byte note;
#if defined(REVENGE_DOS_OPL)
	const AdLibInstrumentPatch *instrument;
	word16 patchOffset;
	word16 frequency;
	byte flags;
	byte operatorRegister;
	byte level;
#endif

	voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
	instrumentState = MIDIChannelStateAt(instrumentStateOffset);
	note = voiceRecord->PlaybackNote;
	if (note > 0x72)
	{
		AdLibMIDIVoiceOff(voiceRecordOffset);
		return;
	}
#if defined(REVENGE_DOS_OPL)
	flags = voiceRecord->VoiceClass;
	patchOffset = instrumentState->InstrumentOffset;
	instrument = &MIDIInstrumentPatches[
		(patchOffset - 0x65A8) / sizeof(AdLibInstrumentPatch)];
	operatorRegister = voiceRecord->Driver.AdLib.OperatorRegister;
	if (voiceRecord->Driver.AdLib.LoadedPatchOffset != patchOffset)
	{
		voiceRecord->Driver.AdLib.LoadedPatchOffset = patchOffset;
		operatorRegister = ProgramAdLibPatchOperator(
			&instrument->Modulator,
			operatorRegister,
			flags);
		if ((flags & 0x30) != 0x00)
		{
			operatorRegister += 0x03;
			ProgramAdLibPatchOperator(
				&instrument->Carrier,
				operatorRegister,
				0x00);
		}
		WriteAdLibMIDIRegister(MAKE_WORD(
			instrument->FeedbackAndConnection,
			voiceRecord->Driver.AdLib.Channel + 0xC0));
	}

	operatorRegister = voiceRecord->Driver.AdLib.OperatorRegister;
	if ((flags & 0x30) != 0x00)
	{
		operatorRegister += 0x03;
	}
	level = (byte) (((byte) velocity >> 0x01) ^ 0x3F);
	level |= ((flags & 0x30) != 0x00
		? instrument->Carrier.ScaleAndOutputLevel
		: instrument->Modulator.ScaleAndOutputLevel) & 0xC0;
	WriteAdLibMIDIRegister(
		MAKE_WORD(level, operatorRegister + 0x40));

	if ((flags & 0x04) != 0x00 && (flags & 0x20) == 0x00)
	{
		frequency = AdLibMIDIFrequencyWords[note + 0x07];
		WriteAdLibMIDIRegister(
			MAKE_WORD(HIGH_BYTE(frequency), 0xB7));
		WriteAdLibMIDIRegister(
			MAKE_WORD(LOW_BYTE(frequency), 0xA7));
	}
	if ((flags & 0x34) != 0x00)
	{
		byte channel;

		frequency = AdLibMIDIFrequencyWords[note];
		voiceRecord->Driver.AdLib.Frequency = frequency;
		channel = voiceRecord->Driver.AdLib.Channel;
		WriteAdLibMIDIRegister(
			MAKE_WORD(LOW_BYTE(frequency), channel + 0xA0));
		WriteAdLibMIDIRegister(
			MAKE_WORD(HIGH_BYTE(frequency), channel + 0xB0));
		if ((flags & 0x20) != 0x00)
		{
			WriteAdLibMIDIRegister(
				MAKE_WORD(HIGH_BYTE(frequency) | 0x20, channel + 0xB0));
		}
	}
	else
	{
		byte rhythmMask;

		rhythmMask = AdLibMIDIRuntime.RhythmMask;
		WriteAdLibMIDIRegister(
			MAKE_WORD(rhythmMask & (byte) ~flags, 0xBD));
		rhythmMask |= flags;
		WriteAdLibMIDIRegister(MAKE_WORD(rhythmMask, 0xBD));
		AdLibMIDIRuntime.RhythmMask = rhythmMask;
	}
#else
	/* The DOS branch below this semantic boundary converts the same note,
	 * velocity, program, and voice class into OPL register writes. On modern
	 * hardware SDL synthesizes the allocated voice directly. */
	SDLBackend_StartMusicVoice(
		voiceRecordOffset,
		note,
		(byte)velocity,
		instrumentState->Program,
		voiceRecord->VoiceClass);
#endif
}

void AdLibMIDIVoiceOff(word16 voiceRecordOffset)
{
#if defined(REVENGE_DOS_OPL)
	MIDIVoiceRecord *voiceRecord;
	byte flags;

	voiceRecord = MIDIVoiceRecordAt(voiceRecordOffset);
	flags = voiceRecord->VoiceClass;
	if ((flags & 0x20) != 0x00)
	{
		word16 frequency;
		byte channel;

		frequency = voiceRecord->Driver.AdLib.Frequency;
		channel = voiceRecord->Driver.AdLib.Channel;
		WriteAdLibMIDIRegister(
			MAKE_WORD(HIGH_BYTE(frequency), channel + 0xB0));
	}
	else
	{
		AdLibMIDIRuntime.RhythmMask &= (byte) ~flags;
		WriteAdLibMIDIRegister(
			MAKE_WORD(AdLibMIDIRuntime.RhythmMask, 0xBD));
	}
#else
	SDLBackend_StopMusicVoice(voiceRecordOffset);
#endif
}

void ResetAdLibMIDIDriver(void)
{
	word16 voice;
	const word16 *resetList;
	const AdLibVoiceLayout *layout;
	byte count;
	byte index;

#if defined(REVENGE_DOS_OPL)
	WriteAdLibMIDIRegisterList(AdLibDeactivateRegisterList);
#else
	SDLBackend_ResetMusicVoices();
#endif
	voice = AdLibMIDIDriverDescriptor.VoiceRecordsOffset;
	count = AdLibMIDIDriverDescriptor.ActiveVoiceCount;
	resetList = count == 0x0B
		? AdLibElevenVoiceResetList
		: AdLibNineVoiceResetList;
	layout = count == 0x0B
		? AdLibElevenVoiceLayout
		: AdLibNineVoiceLayout;
	AdLibMIDIRuntime.RhythmMask =
		count == 0x0B ? 0x20 : 0x00;
#if defined(REVENGE_DOS_OPL)
	WriteAdLibMIDIRegisterList(resetList);
#else
	(void)resetList;
#endif
	for (index = 0x00; index < count; ++index)
	{
		MIDIVoiceRecord *voiceRecord = MIDIVoiceRecordAt(voice);

		voiceRecord->Driver.AdLib.Channel = layout->Channel;
		voiceRecord->Driver.AdLib.OperatorRegister =
			layout->OperatorRegister;
		voiceRecord->VoiceClass = layout->VoiceClass;
		voiceRecord->Driver.AdLib.LoadedPatchOffset = 0x0000;
		++layout;
		voice += 0x20;
	}
}

void LoadAdLibMIDIInstrument(
	const byte *packedInstrument,
	byte *decodedInstrument)
{
	const PackedAdLibInstrument *source =
		(const PackedAdLibInstrument *) packedInstrument;
	AdLibInstrumentPatch *target =
		(AdLibInstrumentPatch *) decodedInstrument;
	const byte *packed = source->Data;
	// V: exact 11-byte packed-to-12-byte OPL patch expansion performed by the
	// original LODSB stream. Bitfield packing is retained explicitly.
	target->Modulator.Characteristics = packed[0x00];
	target->Modulator.WaveformSelect = packed[0x01] & 0x03;
	target->Modulator.ScaleAndOutputLevel =
		(packed[0x02] & 0x60) << 0x01;
	target->Modulator.SustainAndRelease =
		((packed[0x01] & 0x78) << 0x01) | (packed[0x02] & 0x0F);
	target->FeedbackAndConnection = (packed[0x03] & 0x07) << 0x01;
	target->Modulator.Characteristics |=
		(packed[0x04] & 0x40) << 0x01;
	target->Modulator.AttackAndDecay =
		((packed[0x03] & 0x78) << 0x01) | (packed[0x04] & 0x0F);
	target->Modulator.ScaleAndOutputLevel |= packed[0x05] & 0x3F;
	target->Carrier.Characteristics = packed[0x06];
	target->Carrier.WaveformSelect = packed[0x07] & 0x03;
	target->Carrier.ScaleAndOutputLevel =
		(packed[0x08] & 0x60) << 0x01;
	target->Carrier.SustainAndRelease =
		((packed[0x07] & 0x78) << 0x01) | (packed[0x08] & 0x0F);
	target->Carrier.Characteristics |=
		(packed[0x0A] & 0x40) << 0x01;
	target->Carrier.AttackAndDecay =
		((packed[0x09] & 0x78) << 0x01) | (packed[0x0A] & 0x0F);
}

void ServiceAdLibMIDIDriver(void) {}

MIDIDriverDescriptorData AdLibMIDIDriverDescriptor =
{
	.Flags = { 0x00, 0x00, 0x7A },
	.AvailableVoiceCount = 0x0B,
	.ProbeOffset = 0x0C1D,
	.ActivateOffset = 0x0C76,
	.DeactivateOffset = 0x0C87,
	.FilterByteOffset = 0x0C93,
	.StartVoiceOffset = 0x0C96,
	.ReleaseVoiceOffset = 0x0D5E,
	.ResetOffset = 0x0D86,
	.LoadInstrumentOffset = 0x0DDD,
	.ServiceOffset = 0x0E5E
};

static const MIDIDriverHostDispatch AdLibMIDIDriverHostDispatch =
{
	AdLibMIDIDriverProbe,
	ActivateAdLibMIDIDriver,
	DeactivateAdLibMIDIDriver,
	FilterAdLibMIDIByte,
	AdLibMIDIVoiceOn,
	AdLibMIDIVoiceOff,
	ResetAdLibMIDIDriver,
	LoadAdLibMIDIInstrument,
	ServiceAdLibMIDIDriver
};

// Roland MPU-401 UART MIDI backend ----------------------------------------

void ServiceRolandMIDIDriver(void);

// 3621:0E60. The DOS routine resets the MPU-401 through ports 331h/330h
// and succeeds only after receiving acknowledgement FEh. SDL owns that
// machine boundary in the hosted build.
word16 RolandMIDIDriverProbe(void)
{
	return SDLBackend_ProbeLegacyAudioDevice(0x04);
}

// 3621:0E94. The original enters UART mode, clears the 100h-byte transmit
// queue, installs 3621:0F60 on IRQ 2, drains ten stale input bytes, unmasks
// the PIC line, and returns with interrupts enabled.
void ActivateRolandMIDIDriver(word16 activationArgument)
{
	byte discard;

	(void) activationArgument;
	DisableHardwareInterrupts();
	SDLBackend_WriteLegacyAudioPort(0x0331, 0x3F);
	RolandMPU401.WriteIndex = 0x0000;
	RolandMPU401.ReadIndex = 0x0000;
	RolandMPU401.ByteCount = 0x0000;
	RolandMPU401.SavedIRQVector.offset = 0x0000;
	RolandMPU401.SavedIRQVector.segment = 0x0000;
	SavedMPU401IRQHandlerHost = SDLBackend_SwapInterruptHandler(
		0x0A, MPU401IRQHandler);
	for (discard = 0x00; discard < 0x0A; ++discard)
		(void) SDLBackend_ReadLegacyAudioPort(0x0330);
	EnableHardwareInterrupts();
}

// 3621:0EDA. IRQ-vector restoration remains at the platform boundary; the
// preserved queue is drained exactly as the interrupt-driven DOS path was.
void DeactivateRolandMIDIDriver(void)
{
	while (RolandMPU401.ByteCount != 0x0000)
		ServiceRolandMIDIDriver();
	(void) SDLBackend_SwapInterruptHandler(
		0x0A, SavedMPU401IRQHandlerHost);
}

word16 FilterRolandMIDIByte(word16 midiByte)
{
	word16 writeIndex;
	byte outputByte;

	outputByte = (byte) midiByte;
	if ((outputByte & 0x80) != 0x00 && outputByte < 0xF0)
	{
		outputByte = (byte) ((outputByte & 0xF0) |
			MIDIChannelMap[outputByte & 0x0F]);
	}
	while (RolandMPU401.ByteCount >= 0x0100)
		ServiceRolandMIDIDriver();
	DisableHardwareInterrupts();
	writeIndex = RolandMPU401.WriteIndex;
	RolandMPU401.TransmitQueue[writeIndex] = outputByte;
	++writeIndex;
	if (writeIndex >= 0x0100)
		writeIndex = 0x0000;
	RolandMPU401.WriteIndex = writeIndex;
	++RolandMPU401.ByteCount;
	EnableHardwareInterrupts();
	return TRUE;
}

void ResetRolandMIDIDriver(void)
{
	FilterRolandMIDIByte(0x00FF);
}

// 3621:0F32 is the shared no-op voice-on, voice-off, and instrument-load
// callback. Its arguments are intentionally ignored by the Roland driver.
void RolandMIDIDriverNoOp(void) {}

void ServiceRolandMIDIDriver(void)
{
	word16 readIndex;

	if (RolandMPU401.ByteCount == 0x0000)
		return;
	if ((SDLBackend_ReadLegacyAudioPort(0x0331) & 0x40) != 0x00)
		return;
	readIndex = RolandMPU401.ReadIndex;
	SDLBackend_WriteMIDIByte(
		RolandMPU401.TransmitQueue[readIndex]);
	++readIndex;
	if (readIndex >= 0x0100)
		readIndex = 0x0000;
	RolandMPU401.ReadIndex = readIndex;
	--RolandMPU401.ByteCount;
}

MIDIDriverDescriptorData RolandMIDIDriverDescriptor =
{
	.Flags = { 0x00, 0x00, 0x41 },
	.AvailableVoiceCount = 0x00,
	.ProbeOffset = 0x0E60,
	.ActivateOffset = 0x0E94,
	.DeactivateOffset = 0x0EDA,
	.FilterByteOffset = 0x0EF4,
	.StartVoiceOffset = 0x0F32,
	.ReleaseVoiceOffset = 0x0F32,
	.ResetOffset = 0x0F2E,
	.LoadInstrumentOffset = 0x0F32,
	.ServiceOffset = 0x0F33,
	.ActivationArgument = 0x0200
};

static const MIDIDriverHostDispatch RolandMIDIDriverHostDispatch =
{
	RolandMIDIDriverProbe,
	ActivateRolandMIDIDriver,
	DeactivateRolandMIDIDriver,
	FilterRolandMIDIByte,
	(void (*)(word16, word16, word16)) RolandMIDIDriverNoOp,
	(void (*)(word16)) RolandMIDIDriverNoOp,
	ResetRolandMIDIDriver,
	(void (*)(const byte *, byte *)) RolandMIDIDriverNoOp,
	ServiceRolandMIDIDriver
};

const void *MIDIDriverDescriptorIdentities[0x06] =
{
	&SpeakerMIDIDriverDescriptor,
	&TandyMIDIDriverDescriptor,
	&IBMPS1MIDIDriverDescriptor,
	&AdLibMIDIDriverDescriptor,
	&RolandMIDIDriverDescriptor,
	NULL
};

const void *MIDIDriverHostDispatches[0x06] =
{
	&SpeakerMIDIDriverHostDispatch,
	&TandyMIDIDriverHostDispatch,
	&IBMPS1MIDIDriverHostDispatch,
	&AdLibMIDIDriverHostDispatch,
	&RolandMIDIDriverHostDispatch,
	&NullMIDIDriverHostDispatch
};

// 3621:0F60: IRQ 0Ah handler. The original reads port 330h and acknowledges
// the master PIC. SDL consumes MIDI input at the corresponding low boundary.
void MPU401IRQHandler(void)
{
	(void) SDLBackend_ReadLegacyAudioPort(0x0330);
	SDLBackend_AcknowledgeInterrupt(0x0A);
}


