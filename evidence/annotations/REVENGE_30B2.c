// REVENGE_30B2.c
// Shared music timer and PC-speaker effect driver reconstructed from REVENGE.EXE.

#include "REVENGE.h"

word16 g_SavedIrq0Offset_0004 = 0x0000; // 30B2:0004
struct Eq_15108 *g_SavedIrq0Segment_0006 = null; // 30B2:0006

// This module has two distinct data segments:
//   Seg30B2 owns the saved IRQ0 vector at 0004:0006 (addressed through CS).
//   Seg426B owns all timer and PC-speaker stream state used by the IRQ handler.
// Seg3A6A is not this module's DS. Its selector is merely saved at 426B:0002
// while installing the handler, then restored around callbacks into the game.

// 30B2:0291
byte EnablePCSpeaker_0291()
{
	byte speakerControl = __in<byte>(PC_SPEAKER_CONTROL_PORT);
	speakerControl |= PC_SPEAKER_ENABLE_MASK;
	__out<byte>(PC_SPEAKER_CONTROL_PORT, speakerControl);
	return speakerControl;
}

// 30B2:0298
void SilencePCSpeaker_0298()
{
	__out<byte>(PC_SPEAKER_CONTROL_PORT,
		__in<byte>(PC_SPEAKER_CONTROL_PORT) & PC_SPEAKER_DISABLE_MASK);
}

// 30B2:029F
void WritePCSpeakerPITDivisor_029F(byte divisorLowByte, byte divisorHighByte)
{
	__out<byte>(PIT_CHANNEL_2_DATA_PORT, divisorLowByte);
	__out<byte>(PIT_CHANNEL_2_DATA_PORT, divisorHighByte);
}

// 30B2:02A6
// Called from StartLoadedMusicTrack_0153.
void StartPCSpeakerFixedTone_02A6()
{
	__cli();
	// PIT channel 2 divisor 000Eh (about 85.2 kHz, above audible range).
	WritePCSpeakerPITDivisor_029F(0x0E, 0x00);
	EnablePCSpeaker_0291();
	__sti();
}

// 30B2:02C1
// Called from StopLoadedMusicTrack_0185, InstallMusicTimer_02D9 and RestoreSystemTimer_0382.
void DisablePCSpeaker_02C1()
{
	__cli();
	SilencePCSpeaker_0298();
	__sti();
}

// 30B2:02D9
// Called from InitializeGame_003C and PlayScenarioDigitalSoundSequence_0742.
void InstallMusicTimer_02D9()
{
	// Entry DS is the game's Seg3A6A. Preserve it so the IRQ handler can switch
	// out of Seg426B before invoking the external music-driver callbacks.
	seg426B->GameDataSegment_0002 = seg3A6A;

	word32 previousIrq0Vector = msdos_get_interrupt_vector(INTERRUPT_SYSTEM_TIMER_IRQ);
	seg30B2->SavedIrq0Offset_0004 = (word16) previousIrq0Vector;
	seg30B2->SavedIrq0Segment_0006 = FAR_SEGMENT(previousIrq0Vector);

	seg426B->SystemTickReload_0008 = MUSIC_SYSTEM_TICK_RELOAD;
	seg426B->SystemTickCountdown_000A = 0x0000;
	seg426B->MusicServiceReload_000E =
		seg426B->MusicDriverMode_0004 == MUSIC_DRIVER_NONE
			? 0x0000
			: MUSIC_SERVICE_RELOAD;
	seg426B->MusicServiceCountdown_000C = 0x0000;
	seg426B->MusicServiceBusy_0010 = 0x0000;

	msdos_set_interrupt_vector(INTERRUPT_SYSTEM_TIMER_IRQ,
		MAKE_FAR_POINTER(seg30B2, 0x0010)); // MusicTimerIRQ0Handler_0010

	__out<byte>(PIT_MODE_COMMAND_PORT, PIT_CHANNEL_0_MODE_3_COMMAND);
	word16 timerDivisor = seg426B->MusicDriverMode_0004 == MUSIC_DRIVER_NONE
		? MUSIC_PIT_DIVISOR_NORMAL_DRIVER
		: MUSIC_PIT_DIVISOR_FAST_DRIVER;
	__out<byte>(PIT_CHANNEL_0_DATA_PORT, (byte) timerDivisor);
	__out<byte>(PIT_CHANNEL_0_DATA_PORT, (byte) (timerDivisor >> 0x08));
	DisablePCSpeaker_02C1();
}

// 30B2:0382
// Called from ShutdownGame_02E3 and PlayScenarioDigitalSoundSequence_0742.
void RestoreSystemTimer_0382()
{
	msdos_set_interrupt_vector(INTERRUPT_SYSTEM_TIMER_IRQ,
		MAKE_FAR_POINTER(seg30B2->SavedIrq0Segment_0006,
			seg30B2->SavedIrq0Offset_0004));

	// A zero PIT divisor encodes 65536 and restores the conventional DOS rate.
	__out<byte>(PIT_MODE_COMMAND_PORT, PIT_CHANNEL_0_MODE_3_COMMAND);
	__out<byte>(PIT_CHANNEL_0_DATA_PORT, 0x00);
	__out<byte>(PIT_CHANNEL_0_DATA_PORT, 0x00);
	DisablePCSpeaker_02C1();
}

// 30B2:03B6
void StartPCSpeakerEffectStream_03B6(const byte __far *effectStream)
{
	seg426B->PendingSpeakerEffectStreamOffset_0018 = (word16) effectStream;
	seg426B->PendingSpeakerEffectStreamSegment_001A = FAR_SEGMENT(effectStream);
	seg426B->SpeakerEffectStartRequested_00E1 = 0x01;
	seg426B->SpeakerEffectStopRequested_00E2 = 0x00;
	seg426B->SpeakerEffectPlaybackActive_00E0 = 0x01;
	seg426B->SpeakerEffectServiceActive_0005 = 0x01;
}

// 30B2:03E1
void RequestPCSpeakerEffectStop_03E1()
{
	seg426B->SpeakerEffectStopRequested_00E2 = 0x01;
}

// 30B2:0010
// Hardware IRQ0 entry: register preservation and IRET are implicit here.
void MusicTimerIRQ0Handler_0010()
{
	// The assembly explicitly executes MOV DS,426Bh on entry.
	if (seg426B->MusicServiceCountdown_000C == 0x0000)
	{
		if (++seg426B->MusicElapsedSubtick_00E7 > MUSIC_ELAPSED_SUBTICK_MAX)
		{
			seg426B->MusicElapsedSubtick_00E7 = 0x0000;
			if (++seg426B->MusicElapsedUnit_00E9 > MUSIC_ELAPSED_UNIT_MAX)
				seg426B->MusicElapsedUnit_00E9 = 0x00;
		}

		DecodePCSpeakerEffectTick_00DF();
		if (seg426B->SystemTickCountdown_000A == 0x0000)
		{
			seg426B->SystemTickCountdown_000A = seg426B->SystemTickReload_0008;
			seg426B->ChainSystemTimerThisTick_0007 = 0x01;
		}
		else
			--seg426B->SystemTickCountdown_000A;
	}

	if (seg426B->MusicDriverMode_0004 != MUSIC_DRIVER_NONE)
		ServiceActiveMIDIDriver_08A1();

	if (seg426B->MusicServiceCountdown_000C != 0x0000)
		--seg426B->MusicServiceCountdown_000C;
	else
		seg426B->MusicServiceCountdown_000C = seg426B->MusicServiceReload_000E;

	if (seg426B->ChainSystemTimerThisTick_0007 != 0x00)
	{
		seg426B->ChainSystemTimerThisTick_0007 = 0x00;
		((void (__far *)(void)) MAKE_FAR_POINTER(
			seg30B2->SavedIrq0Segment_0006,
			seg30B2->SavedIrq0Offset_0004))();
		return;
	}

	__out<byte>(PIC_COMMAND_PORT, PIC_END_OF_INTERRUPT);
	if (seg426B->MusicDriverMode_0004 != MUSIC_DRIVER_NONE &&
		seg426B->MusicServiceCountdown_000C == 0x0001 &&
		(seg426B->SystemTickCountdown_000A & 0x0003) == 0x0001)
	{
		__sti();
		if (seg426B->MusicServiceBusy_0010 == 0x0000)
		{
			seg426B->MusicServiceBusy_0010 = 0x0001;
			ServiceMIDISequenceTick_01E8();
			seg426B->MusicServiceBusy_0010 = 0x0000;
		}
	}
}

static word16 ReadSpeakerEffectStreamWord(const byte __far *stream, word16 offset)
{
	return stream[offset] | ((word16) stream[offset + 0x01] << 0x08);
}

static byte NonZeroEffectCount(byte value)
{
	return value == 0x00 ? 0x01 : value;
}

// 30B2:00DF
// Consume one PC-speaker stream tick. DS is implicit Seg426B, not an argument.
void DecodePCSpeakerEffectTick_00DF()
{
	if (seg426B->SpeakerEffectStartRequested_00E1 != 0x00)
	{
		seg426B->SpeakerEffectServiceActive_0005 = 0x01;
		seg426B->SpeakerEffectPlaybackActive_00E0 = 0x01;
		seg426B->SpeakerEffectFetchNextEvent_00E3 = 0x01;
		seg426B->SpeakerEffectStartRequested_00E1 = 0x00;
		seg426B->SpeakerEffectStopRequested_00E2 = 0x00;
		seg426B->ActiveSpeakerEffectStreamOffset_0012 = seg426B->PendingSpeakerEffectStreamOffset_0018;
		seg426B->ActiveSpeakerEffectStreamSegment_0014 = seg426B->PendingSpeakerEffectStreamSegment_001A;
		seg426B->SpeakerEffectStreamCursor_0016 = 0x0000;
	}

	if (seg426B->SpeakerEffectPlaybackActive_00E0 == 0x00)
		return;

	word16 streamCursor = seg426B->SpeakerEffectStreamCursor_0016;
	if (seg426B->SpeakerEffectFetchNextEvent_00E3 == 0x00)
	{
		--seg426B->SpeakerEffectTicksRemaining_001E;
		// The assembly follows DEC with JNS; its subsequent comparison against
		// 00FFh is redundant on the negative path.
		if ((int16) seg426B->SpeakerEffectTicksRemaining_001E < 0x00)
			seg426B->SpeakerEffectFetchNextEvent_00E3 = 0x01;
		if (seg426B->SpeakerEffectStopRequested_00E2 != 0x00)
			goto stopPlayback;
	}
	else
	{
		const byte __far *effectStream = FAR_POINTER(byte,
			seg426B->ActiveSpeakerEffectStreamSegment_0014,
			seg426B->ActiveSpeakerEffectStreamOffset_0012);
		word16 pitDivisor;

		while (true)
		{
			byte command = effectStream[streamCursor];
			if (command <= SPEAKER_EFFECT_NOTE_MAX)
			{
				pitDivisor = seg426B->MusicFrequencyDivisorTable_0020[command];
				break;
			}

			switch (command)
			{
			case SPEAKER_EFFECT_COMMAND_LOOP1_BEGIN:
				seg426B->SpeakerEffectLoop1Remaining_00E5 = NonZeroEffectCount(effectStream[streamCursor + 0x01]);
				streamCursor += 0x02;
				continue;
			case SPEAKER_EFFECT_COMMAND_LOOP1_END:
				if (--seg426B->SpeakerEffectLoop1Remaining_00E5 != 0x00)
					streamCursor = streamCursor + 0x01 - ReadSpeakerEffectStreamWord(effectStream, streamCursor + 0x01);
				else
					streamCursor += 0x03;
				continue;
			case SPEAKER_EFFECT_COMMAND_LOOP2_BEGIN:
				seg426B->SpeakerEffectLoop2Remaining_00E6 = NonZeroEffectCount(effectStream[streamCursor + 0x01]);
				streamCursor += 0x02;
				continue;
			case SPEAKER_EFFECT_COMMAND_LOOP2_END:
				if (--seg426B->SpeakerEffectLoop2Remaining_00E6 != 0x00)
					streamCursor = streamCursor + 0x01 - ReadSpeakerEffectStreamWord(effectStream, streamCursor + 0x01);
				else
					streamCursor += 0x03;
				continue;
			case SPEAKER_EFFECT_COMMAND_FREQUENCY_HZ:
				pitDivisor = PIT_INPUT_FREQUENCY_HZ /
					ReadSpeakerEffectStreamWord(effectStream, streamCursor + 0x01);
				streamCursor += 0x02;
				goto playEvent;
			case SPEAKER_EFFECT_COMMAND_SET_DURATION_SCALE:
				seg426B->SpeakerEffectDurationScale_00E4 = NonZeroEffectCount(effectStream[streamCursor + 0x01]);
				streamCursor += 0x02;
				continue;
			case SPEAKER_EFFECT_COMMAND_DECREASE_DURATION_SCALE:
			{
				byte oldScale = seg426B->SpeakerEffectDurationScale_00E4;
				byte decrease = effectStream[streamCursor + 0x01];
				byte result = oldScale - decrease;
				bool signedOverflow = ((oldScale ^ decrease) & (oldScale ^ result) & 0x80) != 0x00;
				seg426B->SpeakerEffectDurationScale_00E4 = result;
				// The original uses JNO followed by JNZ, not an unsigned borrow test.
				// Preserve that unusual behavior exactly; in practice this condition
				// cannot be true for SUB, so the byte subtraction wraps normally.
				if (signedOverflow && result == 0x00)
					seg426B->SpeakerEffectDurationScale_00E4 = 0x01;
				streamCursor += 0x02;
				continue;
			}
			case SPEAKER_EFFECT_COMMAND_INCREASE_DURATION_SCALE:
			{
				byte oldScale = seg426B->SpeakerEffectDurationScale_00E4;
				byte increase = effectStream[streamCursor + 0x01];
				byte result = oldScale + increase;
				bool signedOverflow = ((~(oldScale ^ increase) & (oldScale ^ result)) & 0x80) != 0x00;
				seg426B->SpeakerEffectDurationScale_00E4 = signedOverflow ? 0xFF : result;
				streamCursor += 0x02;
				continue;
			}
			case SPEAKER_EFFECT_COMMAND_END:
				++streamCursor;
			default:
				goto stopPlayback;
			}
		}

playEvent:
		if (pitDivisor != 0x0000)
		{
			WritePCSpeakerPITDivisor_029F(
				(byte) pitDivisor, (byte) (pitDivisor >> 0x08));
			EnablePCSpeaker_0291();
		}
		else
			SilencePCSpeaker_0298();

		seg426B->SpeakerEffectTicksRemaining_001E =
			seg426B->SpeakerEffectDurationScale_00E4 * (effectStream[streamCursor + 0x01] + 0x01) - 0x01;
		seg426B->SpeakerEffectFetchNextEvent_00E3 = 0x00;
		streamCursor += 0x02;
	}

	seg426B->SpeakerEffectStreamCursor_0016 = streamCursor;
	return;

stopPlayback:
	SilencePCSpeaker_0298();
	seg426B->SpeakerEffectStopRequested_00E2 = 0x00;
	seg426B->SpeakerEffectPlaybackActive_00E0 = 0x00;
	seg426B->SpeakerEffectServiceActive_0005 = 0x00;
	seg426B->SpeakerEffectStreamCursor_0016 = streamCursor;
}
