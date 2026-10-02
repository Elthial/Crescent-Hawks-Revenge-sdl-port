// REVENGE_3621.c
// Standard MIDI sequence parser and selectable music-driver dispatch layer.

#include "REVENGE.h"

struct seg3621_t * g_ptr36210 = &g_t5E5F; // 00036210

// 3621:0035: void SetMIDITimingDivisor_0035(uint16 timerCallsPerMinute)
void SetMIDITimingDivisor_0035(uint16 timerCallsPerMinute)
{
	if (timerCallsPerMinute != 0x00)
	{
		__cli();
		seg3A6A->MIDITimerCallsPerMinute_624C = timerCallsPerMinute;
		seg3A6A->MIDITickRateRemainder_6250 = 0x00;
		__sti();
	}
}

// 3621:004B: void ConfigureMIDITempo_004B(
//     uint16 ticksPerQuarterNote, uint16 beatsPerMinute)
void ConfigureMIDITempo_004B(uint16 ticksPerQuarterNote, uint16 beatsPerMinute)
{
	// V: MIDI meta event FF 51 supplies microseconds per quarter note. The
	// caller converts that value to BPM, then this routine converts BPM and
	// the stream's 60h ticks-per-quarter-note division into ticks per minute.
	seg3A6A->MIDIBeatsPerMinute_624A = beatsPerMinute;
	__cli();
	seg3A6A->MIDITicksPerMinute_624E =
		(uint16) (ticksPerQuarterNote * beatsPerMinute);
	seg3A6A->MIDITickRateRemainder_6250 = 0x00;
	__sti();
}

// 3621:0063: void ConfigureMIDITimeSignature_0063(
//     uint16 numerator, uint16 denominator, uint16 beatsPerMeasure)
void ConfigureMIDITimeSignature_0063(
	uint16 numerator,
	uint16 denominator,
	uint16 beatsPerMeasure)
{
	// V: Called for MIDI meta event FF 58. With the game's fixed 60h PPQN
	// stream division, 180h is four quarter notes. The resulting divisors
	// convert elapsed MIDI ticks first into beats and then into measures.
	seg3A6A->MIDIBeatsPerMeasure_6254 = beatsPerMeasure;
	seg3A6A->MIDITicksPerBeat_6252 = (uint16) (
		((uint32) numerator * 0x0180) /
		((uint32) denominator * beatsPerMeasure));
}

// 3621:007E: void SendMIDIAllNotesOff_007E(void)
void SendMIDIAllNotesOff_007E(void)
{
	for (int16 channel = 0x0F; channel >= 0x00; --channel)
	{
		DispatchMIDIByte_03EE(0xB0 | channel);
		DispatchMIDIByte_03EE(0x7B);
		DispatchMIDIByte_03EE(0x00);
	}
}

// 3621:00AA: uint16 ReadMIDIVariableLengthQuantity_00AA(
//     const byte __far **cursor)
uint16 ReadMIDIVariableLengthQuantity_00AA(const byte __far **cursor)
{
	uint16 value = 0x00;
	byte encodedByte;
	do
	{
		encodedByte = **cursor;
		++(*cursor);
		value = (value << 0x07) | (encodedByte & 0x7F);
	} while ((encodedByte & 0x80) != 0x00);
	return value;
}

// 3621:00C1: uint16 StartMIDISequence_00C1(
//     const byte __far *midiData, uint16 playbackFlags)
// Verified against 3621:00C1-0159.
uint16 StartMIDISequence_00C1(const byte __far *midiData, uint16 playbackFlags)
{
	uint16 headerLength;
	const byte __far *track;
	const byte __far *cursor;

	if ((playbackFlags & 0x01) == 0x00)
		return FALSE;
	if (midiData[0x00] != 'M' || midiData[0x01] != 'T' ||
		midiData[0x02] != 'h' || midiData[0x03] != 'd')
		return FALSE;

	headerLength = ((uint16)midiData[0x06] << 0x08) | midiData[0x07];
	if ((((uint16)midiData[0x08] << 0x08) | midiData[0x09]) != 0x0000 ||
		(((uint16)midiData[0x0A] << 0x08) | midiData[0x0B]) != 0x0001 ||
		(((uint16)midiData[0x0C] << 0x08) | midiData[0x0D]) != 0x0060)
		return FALSE;

	track = midiData + 0x08 + headerLength;
	if (track[0x00] != 'M' || track[0x01] != 'T' ||
		track[0x02] != 'r' || track[0x03] != 'k')
		return FALSE;

	seg3A6A->MIDIPlaybackStateBusy_6264 = TRUE;
	if ((seg3A6A->MIDIPlaybackFlags_625A & 0x01) != 0x00)
		SendMIDIAllNotesOff_007E();
	seg3A6A->MIDIPlaybackFlags_625A = 0x00;

	cursor = track + 0x08;
	seg3A6A->MIDITicksUntilNextEvent_625C =
		ReadMIDIVariableLengthQuantity_00AA(&cursor);
	seg3A6A->MIDIStreamCursorOffset_6256 = (word16) cursor;
	seg3A6A->MIDIStreamCursorSegment_6258 =
		(struct Eq_22590 *) FAR_SEGMENT(cursor);
	seg3A6A->MIDIPlaybackFlags_625A = playbackFlags;
	seg3A6A->MIDIBeatTickRemainder_625E = 0x00;
	seg3A6A->MIDIMeasureBeatRemainder_6260 = 0x00;
	seg3A6A->MIDIMeasureCount_6262 = 0x00;
	seg3A6A->MIDIPlaybackStateBusy_6264 = FALSE;
	return playbackFlags;
}

// 3621:0193: void PauseMIDISequence_0193(void)
void PauseMIDISequence_0193(void)
{
	if ((seg3A6A->MIDIPlaybackFlags_625A & 0x05) == 0x01)
	{
		seg3A6A->MIDIPlaybackStateBusy_6264 = TRUE;
		seg3A6A->MIDIPlaybackFlags_625A |= 0x04;
		SendMIDIAllNotesOff_007E();
		seg3A6A->MIDIPlaybackStateBusy_6264 = FALSE;
	}
}

// 3621:01B1: void ResumeMIDISequence_01B1(void)
void ResumeMIDISequence_01B1(void)
{
	if ((seg3A6A->MIDIPlaybackFlags_625A & 0x05) == 0x05)
	{
		seg3A6A->MIDIPlaybackStateBusy_6264 = TRUE;
		seg3A6A->MIDIPlaybackFlags_625A &= ~0x04;
		seg3A6A->MIDIPlaybackStateBusy_6264 = FALSE;
	}
}

// 3621:01CC: void StopMIDISequence_01CC(void)
void StopMIDISequence_01CC(void)
{
	if ((seg3A6A->MIDIPlaybackFlags_625A & 0x01) != 0x00)
	{
		seg3A6A->MIDIPlaybackStateBusy_6264 = TRUE;
		seg3A6A->MIDIPlaybackFlags_625A = 0x00;
		SendMIDIAllNotesOff_007E();
		seg3A6A->MIDIPlaybackStateBusy_6264 = FALSE;
	}
}

// 3621:01E8: void ServiceMIDISequenceTick_01E8(void)
// Called from MusicTimerIRQ0Handler_0010 with DS restored to Seg3A6A.
void ServiceMIDISequenceTick_01E8(void)
{
	__sti();
	if ((seg3A6A->MIDIPlaybackFlags_625A & 0x03) != 0x01)
		return;

	uint32 timingAccumulator =
		(uint32) seg3A6A->MIDITickRateRemainder_6250 + seg3A6A->MIDITicksPerMinute_624E;
	uint16 elapsedTicks =
		(uint16) (timingAccumulator / seg3A6A->MIDITimerCallsPerMinute_624C);
	seg3A6A->MIDITickRateRemainder_6250 =
		(uint16) (timingAccumulator % seg3A6A->MIDITimerCallsPerMinute_624C);
	seg3A6A->MIDITicksUntilNextEvent_625C += elapsedTicks;

	if ((seg3A6A->MIDIPlaybackFlags_625A & 0x08) != 0x00)
	{
		uint32 firstAccumulator =
			(uint32) elapsedTicks + seg3A6A->MIDIBeatTickRemainder_625E;
		uint16 elapsedBeats =
			(uint16) (firstAccumulator / seg3A6A->MIDITicksPerBeat_6252);
		seg3A6A->MIDIBeatTickRemainder_625E =
			(uint16) (firstAccumulator % seg3A6A->MIDITicksPerBeat_6252);
		uint32 measureAccumulator =
			(uint32) elapsedBeats + seg3A6A->MIDIMeasureBeatRemainder_6260;
		seg3A6A->MIDIMeasureCount_6262 +=
			(uint16) (measureAccumulator / seg3A6A->MIDIBeatsPerMeasure_6254);
		seg3A6A->MIDIMeasureBeatRemainder_6260 =
			(uint16) (measureAccumulator % seg3A6A->MIDIBeatsPerMeasure_6254);
	}

	if (seg3A6A->MIDIPlaybackStateBusy_6264 == TRUE)
		return;

	const byte __far *cursor = MAKE_FAR_POINTER(
		seg3A6A->MIDIStreamCursorSegment_6258,
		seg3A6A->MIDIStreamCursorOffset_6256);
	while ((int16) seg3A6A->MIDITicksUntilNextEvent_625C >= 0x00)
	{
		byte status = *cursor++;
		if (status < 0x80)
		{
			status = seg3A6A->MIDIRunningStatus_6265;
			--cursor;
		}

		if (status < 0xF0)
		{
			seg3A6A->MIDIRunningStatus_6265 = status;
			byte messageType = status & 0xF0;
			byte dataByteCount =
				(messageType == 0xC0 || messageType == 0xD0) ? 0x01 : 0x02;

			// The DS:6266 dispatch table sends Note Off, Note On, and
			// Polyphonic Key Pressure to 034Bh, which suppresses those
			// messages while playback flag 04h is set. Other channel messages
			// continue to reach the driver while paused.
			bool suppressWhilePaused =
				messageType == 0x80 || messageType == 0x90 || messageType == 0xA0;
			if (suppressWhilePaused &&
				(seg3A6A->MIDIPlaybackFlags_625A & 0x04) != 0x00)
			{
				cursor += dataByteCount;
			}
			else
			{
				DispatchMIDIByte_03EE(status);
				for (byte index = 0x00; index < dataByteCount; ++index)
					DispatchMIDIByte_03EE(*cursor++);
			}
		}
		else if (status == 0xFF)
		{
			seg3A6A->MIDIRunningStatus_6265 = 0x00;
			byte metaType = *cursor++;
			uint16 metaLength = ReadMIDIVariableLengthQuantity_00AA(&cursor);
			const byte __far *nextEvent = cursor + metaLength;

			switch (metaType)
			{
			case 0x01:
				// This engine repurposes text-event type 01h as a 16-byte
				// logical-to-physical MIDI channel map.
				for (byte channel = 0x00; channel < 0x10; ++channel)
					seg3A6A->MIDIChannelMap_6728[channel] = *cursor++ & 0x0F;
				break;

			case 0x2F:
				cursor = nextEvent;
				StopMIDISequence_01CC();
				seg3A6A->MIDIStreamCursorOffset_6256 = (word16) cursor;
				return;

			case 0x51:
			{
				uint32 microsecondsPerQuarterNote =
					((uint32) cursor[0x00] << 0x10) |
					((uint32) cursor[0x01] << 0x08) |
					cursor[0x02];
				uint16 beatsPerMinute = (uint16) DivideUnsigned32_0388(
					0x03938700UL,
					microsecondsPerQuarterNote);
				ConfigureMIDITempo_004B(0x60, beatsPerMinute);
				break;
			}

			case 0x58:
			{
				uint16 numerator = cursor[0x00];
				uint16 denominator = 0x01 << cursor[0x01];
				uint16 midiClocksPerMetronome = cursor[0x02];
				uint16 beatsPerMeasure = (uint16) (
					((uint32) 0x60 * numerator) /
					((uint32) denominator * midiClocksPerMetronome));
				ConfigureMIDITimeSignature_0063(
					numerator,
					denominator,
					beatsPerMeasure);
				break;
			}
			}

			cursor = nextEvent;
		}
		else
		{
			// DS:6274 maps system statuses onto the in-function handlers at
			// 0285h, 0290h, 0341h, 0358h, 0369h, and 037Ah.
			if (status < 0xF8)
				seg3A6A->MIDIRunningStatus_6265 = 0x00;

			switch (status)
			{
			case 0xF0:
				DispatchMIDIByte_03EE(status);
				// Fall through: F0h dispatches its status before processing the
				// same VLQ-length payload form used by F7h continuation events.
			case 0xF7:
			{
				uint16 payloadLength = ReadMIDIVariableLengthQuantity_00AA(&cursor);
				while (payloadLength-- != 0x00)
					DispatchMIDIByte_03EE(*cursor++);
				break;
			}

			case 0xF1:
			case 0xF3:
				DispatchMIDIByte_03EE(status);
				DispatchMIDIByte_03EE(*cursor++);
				break;

			case 0xF2:
				DispatchMIDIByte_03EE(status);
				DispatchMIDIByte_03EE(*cursor++);
				DispatchMIDIByte_03EE(*cursor++);
				break;

			case 0xF6:
			case 0xF8:
			case 0xFA:
			case 0xFB:
			case 0xFC:
			case 0xFE:
				DispatchMIDIByte_03EE(status);
				break;

			case 0xF4:
			case 0xF5:
			case 0xF9:
			case 0xFD:
				break;
			}
		}

		seg3A6A->MIDITicksUntilNextEvent_625C -=
			ReadMIDIVariableLengthQuantity_00AA(&cursor);
	}

	seg3A6A->MIDIStreamCursorOffset_6256 = (word16) cursor;
}

// 3621:0388: uint32 DivideUnsigned32_0388(uint32 dividend, uint32 divisor)
uint32 DivideUnsigned32_0388(uint32 dividend, uint32 divisor)
{
	// V: Hand-written unsigned 32-bit restoring division. The quotient is
	// returned in DX:AX; zero is returned for a zero divisor or divisor greater
	// than the dividend. ServiceMIDISequenceTick_01E8 uses its low word to turn
	// the FF 51 tempo value into 60,000,000 / microseconds-per-quarter-note.
	if (dividend == 0x00 || divisor == 0x00 || divisor > dividend)
		return 0x00;
	return dividend / divisor;
}

// 3621:03EE: void DispatchMIDIByte_03EE(uint16 midiByte)
void DispatchMIDIByte_03EE(uint16 midiByte)
{
	byte value = (byte) midiByte;
	byte statusHighByte = HIGH_BYTE(midiByte);
	if (MIDIDriverHandlesByte_0550(midiByte) != FALSE)
		return;

	if (value < 0x80)
	{
		word16 parserOffset = seg3A6A->MIDIParserDispatchOffset_62B0.u0;
		(seg3A6A->*((word16) parserOffset + 0x6294))();
		return;
	}

	word16 parserOffset;
	if (value >= 0xF0)
	{
		if (value == 0xF0)
		{
			DispatchMIDISystemByte_06F1(midiByte);
			parserOffset = 0x16;
		}
		else if (value == 0xF7)
		{
			DispatchMIDISystemByte_06F1(midiByte);
			parserOffset = 0x12;
		}
		else if (value == 0xFF)
		{
			ResetMIDIPlaybackState_0832();
			parserOffset = 0x12;
		}
		else
		{
			if (value >= 0xF8)
				return;
			parserOffset = 0x12;
		}
	}
	else
	{
		seg3A6A->MIDICurrentStatus_62B2 =
			MAKE_WORD(statusHighByte, value & 0x0F);
		parserOffset = MAKE_WORD(statusHighByte, value & 0x70) >> 0x02;
	}
	seg3A6A->MIDIParserDispatchOffset_62B0.u0 = parserOffset;
}

// 3621:0514: void PrepareMIDIDriver_0514(uint16 driverDescriptorOffset)
void PrepareMIDIDriver_0514(uint16 driverDescriptorOffset)
{
	// PROPOSED PrepareMIDIDriver_0514. Callback +04h is a pre-activation
	// driver hook; a future driver-specific trace should establish its vendor
	// terminology and whether it performs detection, allocation, or both.
	(seg3621->*(seg3A6A->*driverDescriptorOffset).ptr0004)();
}

// 3621:051E: void ActivateMIDIDriver_051E(uint16 driverDescriptorOffset)
void ActivateMIDIDriver_051E(uint16 driverDescriptorOffset)
{
	word16 previousDriverOffset = seg3A6A->ActiveMIDIDriverDescriptorOffset_62B8;
	(seg3621->*(seg3A6A->*previousDriverOffset).ptr0008)();
	seg3A6A->ActiveMIDIDriverDescriptorOffset_62B8 = driverDescriptorOffset;
	(seg3621->*(seg3A6A->*driverDescriptorOffset).ptr0006)();
	(seg3A6A->*driverDescriptorOffset).b001A =
		(seg3A6A->*driverDescriptorOffset).b0003;
	ResetMIDIPlaybackState_0832();
}

// 3621:0542: void DeactivateMIDIDriver_0542(void)
void DeactivateMIDIDriver_0542(void)
{
	word16 driverDescriptorOffset = seg3A6A->ActiveMIDIDriverDescriptorOffset_62B8;
	(seg3621->*(seg3A6A->*driverDescriptorOffset).ptr0008)();
	seg3A6A->ActiveMIDIDriverDescriptorOffset_62B8 = MIDI_DESCRIPTOR_NULL;
}

// 3621:0550: uint16 MIDIDriverHandlesByte_0550(uint16 midiByte)
uint16 MIDIDriverHandlesByte_0550(uint16 midiByte)
{
	// PROPOSED MIDIDriverHandlesByte_0550. Callback +0Ah receives the byte
	// and returns AX; a driver trace still needs to confirm whether nonzero
	// means consumed, filtered, or unsupported.
	word16 driverDescriptorOffset = seg3A6A->ActiveMIDIDriverDescriptorOffset_62B8;
	uint16 handled;
	(seg3621->*(seg3A6A->*driverDescriptorOffset).ptr000A)();
	return handled;
}

// 3621:06F1: void DispatchMIDISystemByte_06F1(uint16 midiByte)
void DispatchMIDISystemByte_06F1(uint16 midiByte)
{
	byte value = (byte) midiByte;
	if (value == 0xF0)
		seg3A6A->MIDISystemByteHandlerOffset_6758.u0 = 0x0708;
	else if (value == 0xF7)
		seg3A6A->MIDISystemByteHandlerOffset_6758.u0 = 0x0760;
	else
		seg3A6A->MIDISystemByteHandlerOffset_6758.u1();
}

// 3621:0832: void ResetMIDIPlaybackState_0832(void)
void ResetMIDIPlaybackState_0832(void)
{
	seg3A6A->MIDISystemByteHandlerOffset_6758.u0 = 0x0760;
	for (word16 index = 0x00; index < 0x0180; ++index)
		seg3A6A->0x6420[index] = 0x00;
	for (byte channel = 0x00; channel < 0x10; ++channel)
		seg3A6A->MIDIChannelMap_6728[channel] = channel;

	seg3A6A->0x62BA = 0x62BC;
	seg3A6A->MIDIVoiceListSentinelPreviousOffset_w62BE = 0x62BA;
	word16 driverDescriptorOffset = seg3A6A->ActiveMIDIDriverDescriptorOffset_62B8;
	byte voiceCount = (seg3A6A->*driverDescriptorOffset).b001A;
	seg3A6A->MIDIDriverVoiceCount_65A5 = voiceCount;

	word16 previousNodeOffset = 0x62BC;
	word16 nodeOffset = 0x62C0;
	for (byte voice = 0x00; voice < voiceCount; ++voice)
	{
		(seg3A6A->*nodeOffset).w0006 = 0x65A0;
		(seg3A6A->*nodeOffset).b0005 = 0x00;
		(seg3A6A->*nodeOffset).w0000 = previousNodeOffset;
		(seg3A6A->*nodeOffset).w0002 = 0x62BA;
		seg3A6A->MIDIVoiceListSentinelOffset_ptr62BA = nodeOffset;
		(seg3A6A->*previousNodeOffset).w0002 = nodeOffset;
		previousNodeOffset = nodeOffset;
		nodeOffset += 0x20;
	}

	(seg3A6A->*driverDescriptorOffset).w0018 = 0x62C0;
	(seg3621->*(seg3A6A->*driverDescriptorOffset).ptr0010)();
}

// 3621:08A1: void ServiceActiveMIDIDriver_08A1(void)
void ServiceActiveMIDIDriver_08A1(void)
{
	word16 driverDescriptorOffset = seg3A6A->ActiveMIDIDriverDescriptorOffset_62B8;
	(seg3A6A->*driverDescriptorOffset).t0014.u0();
}

// PC-speaker MIDI backend --------------------------------------------------

word16 NullMIDIDriverProbe_08A8(void) { return SOUND_HARDWARE_AVAILABLE; }
void ActivateNullMIDIDriver_08AC(void) {}
void DeactivateNullMIDIDriver_08AD(void) {}
word16 FilterNullMIDIByte_08AE(word16 midiByte) { (void) midiByte; return 0x0000; }
void NullMIDIVoiceOn_08B1(void) {}
void NullMIDIVoiceOff_08B2(void) {}
void ResetNullMIDIDriver_08B3(void) {}
void LoadNullMIDIInstrument_08B4(void) {}
void ServiceNullMIDIDriver_08B5(void) {}

word16 SpeakerMIDIDriverProbe_08B6(void) { return SOUND_HARDWARE_AVAILABLE; }

void ActivateSpeakerMIDIDriver_08BA(void)
{
	__cli();
	__out<byte>(PIT_MODE_COMMAND_PORT, 0xB6);
	seg3A6A->SpeakerMIDICurrentDivisor_67BC = 0x0014;
	__out<byte>(PIT_CHANNEL_2_DATA_PORT, 0x14);
	__out<byte>(PIT_CHANNEL_2_DATA_PORT, 0x00);
	__out<byte>(PC_SPEAKER_CONTROL_PORT,
		__in<byte>(PC_SPEAKER_CONTROL_PORT) | PC_SPEAKER_ENABLE_MASK);
	__sti();
}

void DeactivateSpeakerMIDIDriver_08D3(void)
{
	__cli();
	__out<byte>(PC_SPEAKER_CONTROL_PORT,
		__in<byte>(PC_SPEAKER_CONTROL_PORT) & PC_SPEAKER_DISABLE_MASK);
	__sti();
}

word16 FilterSpeakerMIDIByte_08DC(word16 midiByte)
{
	(void) midiByte;
	return 0x0000;
}

void SpeakerMIDIVoiceOn_08DF(word16 voiceRecordOffset)
{
	byte note = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x09);
	word16 divisor = 0x0014;
	if (note >= 0x0E)
		divisor = seg3A6A->SpeakerMIDIFrequencyDivisors_67C2[note - 0x0E];
	*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0A) = divisor;
}

void SpeakerMIDIVoiceOff_08F8(word16 voiceRecordOffset)
{
	*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0A) = 0x0014;
}

void ResetSpeakerMIDIDriver_08FF(void)
{
	word16 voice = seg3A6A->SpeakerMIDIVoiceRecordsOffset_67A6;
	seg3A6A->SpeakerMIDIServiceCursor_67BE = voice;
	seg3A6A->SpeakerMIDIVoicesRemaining_67C0 =
		seg3A6A->SpeakerMIDIVoiceCount_67A8;
	for (byte count = 0x00; count < seg3A6A->SpeakerMIDIVoiceCount_67A8; ++count)
	{
		SEGMENT_BYTE(seg3A6A, voice + 0x04) = 0x01;
		*(word16 *) &SEGMENT_BYTE(seg3A6A, voice + 0x0A) = 0x0014;
		voice += 0x20;
	}
}

void LoadSpeakerMIDIInstrument_0922(void) {}

void ServiceSpeakerMIDIDriver_0923(void)
{
	if (seg3A6A->SpeakerMIDIVoiceCount_67A8 == 0x00)
		return;
	word16 voice = seg3A6A->SpeakerMIDIServiceCursor_67BE;
	word16 divisor = *(word16 *) &SEGMENT_BYTE(seg3A6A, voice + 0x0A);
	if (divisor != seg3A6A->SpeakerMIDICurrentDivisor_67BC)
	{
		seg3A6A->SpeakerMIDICurrentDivisor_67BC = divisor;
		__out<byte>(PIT_MODE_COMMAND_PORT, 0xB6);
		__out<byte>(PIT_CHANNEL_2_DATA_PORT, LOW_BYTE(divisor));
		__out<byte>(PIT_CHANNEL_2_DATA_PORT, HIGH_BYTE(divisor));
	}
	voice += 0x20;
	if (--seg3A6A->SpeakerMIDIVoicesRemaining_67C0 == 0x00)
	{
		seg3A6A->SpeakerMIDIVoicesRemaining_67C0 =
			seg3A6A->SpeakerMIDIVoiceCount_67A8;
		voice = seg3A6A->SpeakerMIDIVoiceRecordsOffset_67A6;
	}
	seg3A6A->SpeakerMIDIServiceCursor_67BE = voice;
}

// Tandy and IBM PS/1 three-voice backends ---------------------------------

word16 TandyMIDIDriverProbe_097E(void)
{
	return *FAR_POINTER(byte, BIOS_ROM_SEGMENT, BIOS_MACHINE_ID_OFFSET) ==
		TANDY_MACHINE_ID &&
		*FAR_POINTER(byte, TANDY_VIDEO_BIOS_SEGMENT,
			TANDY_VIDEO_BIOS_SIGNATURE_OFFSET) == TANDY_VIDEO_BIOS_SIGNATURE
		? SOUND_HARDWARE_AVAILABLE : 0x0000;
}

void ActivateTandyMIDIDriver_099C(void)
{
	ActivateBaseMIDIDriver_6794();
}

// 3621:099E: register-call shared tail used to silence CX Tandy PSG voices
// beginning at DS:BX, then tail-call the base MIDI-driver deactivation hook.
void SilenceTandyMIDIVoices_099E(
	word16 voiceRecordOffset,
	word16 voiceCount)
{
	while (voiceCount-- != 0x0000)
	{
		byte latch = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0D) | 0x9F;
		SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0C) = latch;
		__out<byte>(TANDY_PSG_DATA_PORT, latch);
		voiceRecordOffset += 0x20;
	}
	DeactivateBaseMIDIDriver_6796();
}

void DeactivateTandyMIDIDriver_09A0(void)
{
	SilenceTandyMIDIVoices_099E(
		seg3A6A->TandyMIDIVoiceRecordsOffset_68BE,
		seg3A6A->TandyMIDIHardwareVoiceCount_68DB);
}

word16 FilterTandyMIDIByte_09BF(word16 midiByte) { (void) midiByte; return 0x0000; }

void TandyMIDIVoiceOn_09C2(word16 voiceRecordOffset)
{
	if (SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x04) != 0x02)
	{
		FallbackMIDIVoiceOn_679A(voiceRecordOffset);
		return;
	}
	byte note = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x09);
	word16 frequencyWord = 0x0081;
	if (note >= 0x2D && note <= 0x78)
		frequencyWord = seg3A6A->TandyMIDIFrequencyWords_68DC[note - 0x2D];
	byte voiceMask = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0D);
	*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0A) =
		frequencyWord | voiceMask;
	SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0C) = 0x92 | voiceMask;
}

void TandyMIDIVoiceOff_09F7(word16 voiceRecordOffset)
{
	if (SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x04) != 0x02)
	{
		FallbackMIDIVoiceOff_679C(voiceRecordOffset);
		return;
	}
	byte voiceMask = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0D);
	*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0A) = 0x0081 | voiceMask;
	SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0C) = 0x9F | voiceMask;
}

static void ResetThreeVoiceMIDIDriverState(
	word16 firstVoiceOffset,
	byte totalVoiceCount,
	word16 *serviceCursor,
	byte *voicesRemaining,
	byte *hardwareVoiceCount)
{
	*serviceCursor = firstVoiceOffset;
	byte softwareVoiceCount = totalVoiceCount > 0x03
		? totalVoiceCount - 0x03 : 0x00;
	seg3A6A->SpeakerMIDIVoiceCount_67A8 = softwareVoiceCount;
	byte hardwareCount = totalVoiceCount - softwareVoiceCount;
	*voicesRemaining = hardwareCount;
	*hardwareVoiceCount = hardwareCount;
	word16 voice = firstVoiceOffset;
	for (byte remaining = hardwareCount; remaining != 0x00; --remaining)
	{
		SEGMENT_BYTE(seg3A6A, voice + 0x04) = 0x02;
		byte voiceMask = (byte) ((remaining - 0x01) << 0x05);
		SEGMENT_BYTE(seg3A6A, voice + 0x0D) = voiceMask;
		*(word16 *) &SEGMENT_BYTE(seg3A6A, voice + 0x0A) =
			(word16) (voiceMask | 0x0081);
		SEGMENT_BYTE(seg3A6A, voice + 0x0C) = voiceMask | 0x9F;
		voice += 0x20;
	}
	seg3A6A->SpeakerMIDIVoiceRecordsOffset_67A6 = voice;
	ResetBaseMIDIDriver_679E();
}

void ResetTandyMIDIDriver_0A13(void)
{
	ResetThreeVoiceMIDIDriverState(
		seg3A6A->TandyMIDIVoiceRecordsOffset_68BE,
		seg3A6A->TandyMIDIVoiceCount_68C0,
		&seg3A6A->TandyMIDIServiceCursor_68D8,
		&seg3A6A->TandyMIDIVoicesRemaining_68DA,
		&seg3A6A->TandyMIDIHardwareVoiceCount_68DB);
}

void LoadTandyMIDIInstrument_0A69(void) {}

// 3621:0A7E: restart the three-voice round-robin scan and immediately service
// the shared MIDI event sequencer. The original procedure is a tail jump to
// ServiceBaseMIDIDriver_67A2.
void RestartTandyMIDIVoiceScan_0A7E(void)
{
	seg3A6A->TandyMIDIVoicesRemaining_68DA =
		seg3A6A->TandyMIDIHardwareVoiceCount_68DB;
	seg3A6A->TandyMIDIServiceCursor_68D8 =
		seg3A6A->TandyMIDIVoiceRecordsOffset_68BE;
	ServiceBaseMIDIDriver_67A2();
}

void ServiceTandyMIDIDriver_0A6A(void)
{
	if (seg3A6A->TandyMIDIHardwareVoiceCount_68DB != 0x00)
	{
		word16 voice = seg3A6A->TandyMIDIServiceCursor_68D8;
		word16 frequencyWord = *(word16 *) &SEGMENT_BYTE(seg3A6A, voice + 0x0A);
		__out<byte>(TANDY_PSG_DATA_PORT, LOW_BYTE(frequencyWord));
		__out<byte>(TANDY_PSG_STEREO_PORT, HIGH_BYTE(frequencyWord));
		__out<byte>(TANDY_PSG_DATA_PORT,
			SEGMENT_BYTE(seg3A6A, voice + 0x0C));
		voice += 0x20;
		if (--seg3A6A->TandyMIDIVoicesRemaining_68DA == 0x00)
		{
			RestartTandyMIDIVoiceScan_0A7E();
			return;
		}
		seg3A6A->TandyMIDIServiceCursor_68D8 = voice;
	}
	ServiceBaseMIDIDriver_67A2();
}

word16 IBMPS1MIDIDriverProbe_0A9E(void)
{
	word16 modelWord;
	BIOS_GetSystemModelWord_C0(&modelWord);
	if (modelWord != 0x0BFC)
		return 0x0000;
	return (ReadCMOSRegister(0x2F) & 0x10) != 0x00
		? SOUND_HARDWARE_AVAILABLE : 0x0000;
}

void ActivateIBMPS1MIDIDriver_0AC4(void)
{
	ActivateBaseMIDIDriver_6794();
}

void DeactivateIBMPS1MIDIDriver_0AC8(void)
{
	word16 voice = seg3A6A->IBMPS1MIDIVoiceRecordsOffset_698C;
	for (byte count = 0x00; count < seg3A6A->IBMPS1MIDIHardwareVoiceCount_69A7; ++count)
	{
		byte latch = SEGMENT_BYTE(seg3A6A, voice + 0x0D) | 0x9F;
		SEGMENT_BYTE(seg3A6A, voice + 0x0C) = latch;
		__out<byte>(0x0205, latch);
		voice += 0x20;
	}
	DeactivateBaseMIDIDriver_6796();
}

word16 FilterIBMPS1MIDIByte_0AEB(word16 midiByte) { (void) midiByte; return 0x0000; }

void IBMPS1MIDIVoiceOn_0AEE(word16 voiceRecordOffset)
{
	if (SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x04) != 0x02)
	{
		FallbackMIDIVoiceOn_679A(voiceRecordOffset);
		return;
	}
	byte note = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x09);
	word16 frequencyWord = 0x0081;
	if (note >= 0x2F && note <= 0x78)
		frequencyWord = seg3A6A->IBMPS1MIDIFrequencyWords_69A8[note - 0x2F];
	byte voiceMask = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0D);
	*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0A) =
		frequencyWord | voiceMask;
	SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0C) = 0x92 | voiceMask;
}

void IBMPS1MIDIVoiceOff_0B23(word16 voiceRecordOffset)
{
	if (SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x04) != 0x02)
	{
		FallbackMIDIVoiceOff_679C(voiceRecordOffset);
		return;
	}
	byte voiceMask = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0D);
	*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0A) = 0x0081 | voiceMask;
	SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0C) = 0x9F | voiceMask;
}

void ResetIBMPS1MIDIDriver_0B3F(void)
{
	ResetThreeVoiceMIDIDriverState(
		seg3A6A->IBMPS1MIDIVoiceRecordsOffset_698C,
		seg3A6A->IBMPS1MIDIVoiceCount_698E,
		&seg3A6A->IBMPS1MIDIServiceCursor_69A4,
		&seg3A6A->IBMPS1MIDIVoicesRemaining_69A6,
		&seg3A6A->IBMPS1MIDIHardwareVoiceCount_69A7);
}

void LoadIBMPS1MIDIInstrument_0B95(void) {}

void ServiceIBMPS1MIDIDriver_0B96(void)
{
	if (seg3A6A->IBMPS1MIDIHardwareVoiceCount_69A7 != 0x00)
	{
		word16 voice = seg3A6A->IBMPS1MIDIServiceCursor_69A4;
		word16 frequencyWord = *(word16 *) &SEGMENT_BYTE(seg3A6A, voice + 0x0A);
		__out<byte>(0x0205, LOW_BYTE(frequencyWord));
		__out<byte>(0x0205, HIGH_BYTE(frequencyWord));
		__out<byte>(0x0205, SEGMENT_BYTE(seg3A6A, voice + 0x0C));
		voice += 0x20;
		if (--seg3A6A->IBMPS1MIDIVoicesRemaining_69A6 == 0x00)
		{
			seg3A6A->IBMPS1MIDIVoicesRemaining_69A6 =
				seg3A6A->IBMPS1MIDIHardwareVoiceCount_69A7;
			voice = seg3A6A->IBMPS1MIDIVoiceRecordsOffset_698C;
		}
		seg3A6A->IBMPS1MIDIServiceCursor_69A4 = voice;
	}
	ServiceBaseMIDIDriver_67A2();
}

// AdLib OPL2 MIDI backend --------------------------------------------------

// 3621:0BBE. 0BCC is an internal continuation after the register-port delay.
void WriteAdLibMIDIRegister_0BBE(word16 registerAndValue)
{
	__out<byte>(ADLIB_REGISTER_PORT, LOW_BYTE(registerAndValue));
	for (volatile word16 delay = seg3A6A->AdLibRegisterDelay_6A6E;
		delay != 0x0000; --delay)
		(void) __in<byte>(ADLIB_REGISTER_PORT);
	__out<byte>(ADLIB_DATA_PORT, HIGH_BYTE(registerAndValue));
	for (volatile word16 delay = seg3A6A->AdLibDataDelay_6A70;
		delay != 0x0000; --delay)
		(void) __in<byte>(ADLIB_REGISTER_PORT);
}

// 3621:0BDF. 0BED is this loop's RET, not a separate procedure entry.
void WriteAdLibMIDIRegisterList_0BDF(word16 registerListOffset)
{
	word16 *entry = (word16 *) &SEGMENT_BYTE(seg3A6A, registerListOffset);
	while (*entry != 0x0000)
		WriteAdLibMIDIRegister_0BBE(*entry++);
}

// 3621:0BFF: write the packed register/value already in AX, then program the
// remaining 60h, 80h and E0h operator groups from DS:DI. AL returns to the
// original operator-register index before RET.
byte ProgramRemainingAdLibOperatorRegisters_0BFF(
	const byte *operatorPatch,
	word16 firstRegisterAndValue)
{
	byte registerIndex = LOW_BYTE(firstRegisterAndValue);
	WriteAdLibMIDIRegister_0BBE(firstRegisterAndValue);
	WriteAdLibMIDIRegister_0BBE(
		MAKE_WORD(operatorPatch[0x03], registerIndex + 0x20));
	WriteAdLibMIDIRegister_0BBE(
		MAKE_WORD(operatorPatch[0x02], registerIndex + 0x40));
	WriteAdLibMIDIRegister_0BBE(
		MAKE_WORD(operatorPatch[0x04], registerIndex + 0xA0));
	return registerIndex - 0x40;
}

// 3621:0BEE: program one five-byte OPL operator patch. The 40h total-level
// register is omitted for the zero-flag path, matching TEST CL,30h / JZ 0C02h.
byte ProgramAdLibPatchOperator_0BEE(
	const byte *operatorPatch,
	byte operatorRegister,
	byte voiceFlags)
{
	WriteAdLibMIDIRegister_0BBE(
		MAKE_WORD(operatorPatch[0x00], operatorRegister + 0x20));
	if ((voiceFlags & 0x30) != 0x00)
	{
		return ProgramRemainingAdLibOperatorRegisters_0BFF(
			operatorPatch,
			MAKE_WORD(operatorPatch[0x01], operatorRegister + 0x40));
	}
	WriteAdLibMIDIRegister_0BBE(
		MAKE_WORD(operatorPatch[0x03], operatorRegister + 0x60));
	WriteAdLibMIDIRegister_0BBE(
		MAKE_WORD(operatorPatch[0x02], operatorRegister + 0x80));
	WriteAdLibMIDIRegister_0BBE(
		MAKE_WORD(operatorPatch[0x04], operatorRegister + 0xE0));
	return operatorRegister;
}

static void ProgramAdLibOperatorPair(
	byte operatorRegister,
	word16 decodedInstrumentOffset,
	byte voiceFlags)
{
	// The clean Reko 0.12.4 refresh still splits 0CA6h, 0CB5h and 0CDEh into
	// anonymous procedures. Assembly confirms they are internal entry blocks of
	// AdLibMIDIVoiceOn_0CA4 with shared saved registers, not callable routines;
	// keep their logic merged into the annotated voice-on implementation below.
	const byte *instrument = &SEGMENT_BYTE(seg3A6A, decodedInstrumentOffset);
	byte secondOperatorRegister = ProgramAdLibPatchOperator_0BEE(
		instrument, operatorRegister, voiceFlags) + 0x03;
	if ((voiceFlags & 0x30) != 0x00)
		ProgramAdLibPatchOperator_0BEE(
			instrument + 0x05, secondOperatorRegister, 0x00);
}

word16 AdLibMIDIDriverProbe_0C2B(void)
{
	// Same verified OPL2 timer-status probe as the digital AdLib backend.
	WriteAdLibMIDIRegister_0BBE(MAKE_WORD(0x60, 0x04));
	WriteAdLibMIDIRegister_0BBE(MAKE_WORD(0x80, 0x04));
	if ((__in<byte>(ADLIB_REGISTER_PORT) & 0xE0) != 0x00)
		return 0x0000;
	WriteAdLibMIDIRegister_0BBE(MAKE_WORD(0xC0, 0x02));
	__out<byte>(ADLIB_REGISTER_PORT, 0x04);
	for (volatile word16 delay = 0x0014; delay != 0x0000; --delay)
		(void) __in<byte>(ADLIB_REGISTER_PORT);
	__out<byte>(ADLIB_DATA_PORT, 0x21);
	word16 calibrationCount = 0x0000;
	while ((__in<byte>(ADLIB_REGISTER_PORT) & 0xE0) != 0xC0)
		--calibrationCount;
	if (calibrationCount == 0x0000)
		return 0x0000;
	seg3A6A->AdLibDataDelay_6A70 = calibrationCount / 0x00E4 + 0x01;
	seg3A6A->AdLibRegisterDelay_6A6E = calibrationCount / 0x060F + 0x01;
	return SOUND_HARDWARE_AVAILABLE;
}

void ActivateAdLibMIDIDriver_0C84(void)
{
	WriteAdLibMIDIRegisterList_0BDF(0x6B96);
	seg3A6A->AdLibRhythmKeyMask_6A72 = 0x00;
}
void DeactivateAdLibMIDIDriver_0C95(void)
{
	WriteAdLibMIDIRegisterList_0BDF(0x6BB2);
}
word16 FilterAdLibMIDIByte_0CA1(word16 midiByte) { (void) midiByte; return 0x0000; }

void AdLibMIDIVoiceOn_0CA4(word16 voiceRecordOffset,
	word16 instrumentStateOffset)
{
	// V: SI is the 20h-byte voice record. DI identifies the channel/instrument
	// state whose +6 word selects a decoded 0Ch-byte OPL patch. Melodic notes
	// program operator registers and A0h/B0h pitch/key-on; rhythm voices update
	// BDh and use the two dedicated pitch tables. Raw record offsets remain
	// here because their shared semantic names still need a parser-wide pass.
	byte note = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x09);
	if (note > 0x72)
	{
		AdLibMIDIVoiceOff_0D6C(voiceRecordOffset);
		return;
	}
	word16 patchOffset = *(word16 *) &SEGMENT_BYTE(seg3A6A,
		instrumentStateOffset + 0x06);
	byte flags = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x04);
	byte operatorRegister = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0B);
	if (*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0C) != patchOffset)
	{
		*(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0C) = patchOffset;
		ProgramAdLibOperatorPair(operatorRegister, patchOffset, flags);
	}
	ProgramAdLibVoicePitchAndKeyOn(voiceRecordOffset, patchOffset, note, flags);
}

void AdLibMIDIVoiceOff_0D6C(word16 voiceRecordOffset)
{
	byte flags = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x04);
	if ((flags & 0x20) != 0x00)
	{
		word16 frequency = *(word16 *) &SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0E);
		byte channel = SEGMENT_BYTE(seg3A6A, voiceRecordOffset + 0x0A);
		WriteAdLibMIDIRegister_0BBE(MAKE_WORD(HIGH_BYTE(frequency), 0xB0 + channel));
	}
	else
	{
		seg3A6A->AdLibRhythmKeyMask_6A72 &= (byte) ~flags;
		WriteAdLibMIDIRegister_0BBE(MAKE_WORD(
			seg3A6A->AdLibRhythmKeyMask_6A72, 0xBD));
	}
}

void ResetAdLibMIDIDriver_0D94(void)
{
	WriteAdLibMIDIRegisterList_0BDF(0x6BB2);
	word16 voice = seg3A6A->AdLibMIDIVoiceRecordsOffset_6A54;
	byte count = seg3A6A->AdLibMIDIVoiceCount_6A56;
	word16 resetList = count == 0x0B ? 0x6B9E : 0x6B9A;
	word16 layout = count == 0x0B ? 0x6B5A : 0x6B7B;
	seg3A6A->AdLibRhythmKeyMask_6A72 = count == 0x0B ? 0x20 : 0x00;
	WriteAdLibMIDIRegisterList_0BDF(resetList);
	for (byte index = 0x00; index < count; ++index)
	{
		SEGMENT_BYTE(seg3A6A, voice + 0x0A) = SEGMENT_BYTE(seg3A6A, layout++);
		SEGMENT_BYTE(seg3A6A, voice + 0x0B) = SEGMENT_BYTE(seg3A6A, layout++);
		SEGMENT_BYTE(seg3A6A, voice + 0x04) = SEGMENT_BYTE(seg3A6A, layout++);
		*(word16 *) &SEGMENT_BYTE(seg3A6A, voice + 0x0C) = 0x0000;
		voice += 0x20;
	}
}

void LoadAdLibMIDIInstrument_0DEB(word16 packedInstrumentOffset,
	word16 decodedInstrumentOffset)
{
	byte *source = &SEGMENT_BYTE(seg3A6A, packedInstrumentOffset);
	byte *target = &SEGMENT_BYTE(seg3A6A, decodedInstrumentOffset);
	// V: exact 11-byte packed-to-12-byte OPL patch expansion performed by the
	// original LODSB stream. Bitfield packing is retained explicitly.
	target[0x00] = source[0x00];
	target[0x04] = source[0x01] & 0x03;
	target[0x01] = (source[0x02] & 0x60) << 0x01;
	target[0x02] = ((source[0x01] & 0x78) << 0x01) | (source[0x02] & 0x0F);
	target[0x05] = (source[0x03] & 0x07) << 0x01;
	target[0x00] |= (source[0x04] & 0x40) << 0x01;
	target[0x03] = ((source[0x03] & 0x78) << 0x01) | (source[0x04] & 0x0F);
	target[0x01] |= source[0x05] & 0x3F;
	target[0x06] = source[0x06];
	target[0x0A] = source[0x07] & 0x03;
	target[0x07] = (source[0x08] & 0x60) << 0x01;
	target[0x08] = ((source[0x07] & 0x78) << 0x01) | (source[0x08] & 0x0F);
	target[0x06] |= (source[0x0A] & 0x40) << 0x01;
	target[0x09] = ((source[0x09] & 0x78) << 0x01) | (source[0x0A] & 0x0F);
}

void ServiceAdLibMIDIDriver_0E6C(void) {}

// Roland MPU-401 UART MIDI backend ----------------------------------------

word16 RolandMIDIDriverProbe_0E6E(void)
{
	__cli();
	while ((__in<byte>(MPU401_STATUS_COMMAND_PORT) & MPU401_STATUS_OUTPUT_BUSY) != 0x00) {}
	__out<byte>(MPU401_STATUS_COMMAND_PORT, MPU401_RESET_COMMAND);
	while ((__in<byte>(MPU401_STATUS_COMMAND_PORT) & MPU401_STATUS_OUTPUT_BUSY) != 0x00) {}
	__out<byte>(MPU401_STATUS_COMMAND_PORT, 0x00);
	while ((__in<byte>(MPU401_STATUS_COMMAND_PORT) & MPU401_STATUS_INPUT_EMPTY) != 0x00) {}
	word16 available = __in<byte>(MPU401_DATA_PORT) == MPU401_COMMAND_ACK
		? SOUND_HARDWARE_AVAILABLE : 0x0000;
	__sti();
	return available;
}

void ActivateRolandMIDIDriver_0EA2(void)
{
	__cli();
	__out<byte>(MPU401_STATUS_COMMAND_PORT, MPU401_UART_MODE_COMMAND);
	seg3A6A->MPU401QueueWriteIndex_6D12 = 0x0000;
	seg3A6A->MPU401QueueReadIndex_6D14 = 0x0000;
	seg3A6A->MPU401QueueCount_6D16 = 0x0000;
	word32 oldVector = msdos_get_interrupt_vector(INTERRUPT_MPU401_IRQ2);
	seg3A6A->SavedMPU401IRQOffset_6C0E = LOW_WORD(oldVector);
	seg3A6A->SavedMPU401IRQSegment_6C10 = HIGH_WORD(oldVector);
	msdos_set_interrupt_vector(INTERRUPT_MPU401_IRQ2,
		MAKE_FAR_POINTER(0x3621, 0x0F60));
	for (byte discard = 0x00; discard < 0x0A; ++discard)
		(void) __in<byte>(MPU401_DATA_PORT);
	__out<byte>(PIC_COMMAND_PORT, PIC_END_OF_INTERRUPT);
	__out<byte>(0x21, 0x00);
	__sti();
}

void DeactivateRolandMIDIDriver_0EE8(void)
{
	while (seg3A6A->MPU401QueueCount_6D16 != 0x0000) {}
	__cli();
	msdos_set_interrupt_vector(INTERRUPT_MPU401_IRQ2,
		MAKE_FAR_POINTER(seg3A6A->SavedMPU401IRQSegment_6C10,
			seg3A6A->SavedMPU401IRQOffset_6C0E));
	__sti();
}

word16 FilterRolandMIDIByte_0F02(byte midiByte)
{
	if ((midiByte & 0x80) != 0x00 && midiByte < 0xF0)
		midiByte = (midiByte & 0xF0) |
			seg3A6A->MIDIChannelMap_6728[midiByte & 0x0F];
	while (seg3A6A->MPU401QueueCount_6D16 >= 0x0100) {}
	__cli();
	seg3A6A->MPU401TransmitQueue_6C12[seg3A6A->MPU401QueueWriteIndex_6D12] = midiByte;
	seg3A6A->MPU401QueueWriteIndex_6D12 =
		(seg3A6A->MPU401QueueWriteIndex_6D12 + 0x01) & 0x00FF;
	++seg3A6A->MPU401QueueCount_6D16;
	__sti();
	return TRUE;
}

void ResetRolandMIDIDriver_0F3C(void) { FilterRolandMIDIByte_0F02(0xFF); }
void RolandMIDIDriverNoOp_0F40(void) {}

// 3621:0F57: commit the next MPU-401 queue cursor and consume the byte that
// ServiceRolandMIDIDriver_0F41 has just transmitted. BX carries the cursor.
void CommitRolandMIDIQueueRead_0F57(word16 nextReadIndex)
{
	seg3A6A->MPU401QueueReadIndex_6D14 = nextReadIndex;
	--seg3A6A->MPU401QueueCount_6D16;
}

// 3621:0F55: wrap the 100h-byte transmit queue cursor to its first entry.
void WrapRolandMIDIQueueReadIndex_0F55(void)
{
	CommitRolandMIDIQueueRead_0F57(0x0000);
}

void ServiceRolandMIDIDriver_0F41(void)
{
	if (seg3A6A->MPU401QueueCount_6D16 == 0x0000 ||
		(__in<byte>(MPU401_STATUS_COMMAND_PORT) & MPU401_STATUS_OUTPUT_BUSY) != 0x00)
		return;
	__out<byte>(MPU401_DATA_PORT,
		seg3A6A->MPU401TransmitQueue_6C12[seg3A6A->MPU401QueueReadIndex_6D14]);
	if (seg3A6A->MPU401QueueReadIndex_6D14 == 0x00FF)
		WrapRolandMIDIQueueReadIndex_0F55();
	else
		CommitRolandMIDIQueueRead_0F57(
			seg3A6A->MPU401QueueReadIndex_6D14 + 0x01);
}

// 3621:0F60: IRQ 0Ah handler installed by ActivateRolandMIDIDriver_0EA2.
void MPU401IRQHandler_0F60(void)
{
	(void) __in<byte>(MPU401_DATA_PORT);
	__out<byte>(PIC_COMMAND_PORT, PIC_END_OF_INTERRUPT);
}
