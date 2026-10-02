// REVENGE_30B2_PC_SPEAKER_TIMER.c
// Shared music timer and PC-speaker effect driver reconstructed from REVENGE.EXE.

#include "REVENGE.h"
#include "revenge/audio.h"
#include "revenge/platform_backend.h"

static DOS_InterruptHandler SavedSystemTimerHandler;

enum
{
	MUSIC_DRIVER_NONE = 0x00,
	MUSIC_DRIVER_MODE_1 = 0x01,
	MUSIC_DRIVER_MODE_2 = 0x02,
	MUSIC_SYSTEM_TICK_RELOAD = 0x000F,
	MUSIC_SERVICE_RELOAD = 0x0003,
	MUSIC_PIT_DIVISOR_NORMAL_DRIVER = 0x1000,
	MUSIC_PIT_DIVISOR_FAST_DRIVER = 0x0400,
	MUSIC_ELAPSED_SUBTICK_MAX = 0x0123,
	MUSIC_ELAPSED_UNIT_MAX = 0x3B
};

// This module has two distinct data segments:
//   Seg30B2 owns the saved IRQ0 vector at 0004:0006 (addressed through CS).
//   Seg426B owns all timer and PC-speaker stream state used by the IRQ handler.
// Seg3A6A is not this module's DS. Its selector is merely saved at 426B:0002
// while installing the handler, then restored around callbacks into the game.

// 30B2:0291
byte EnablePCSpeaker(void)
{
	return SDLBackend_EnablePCSpeaker();
}

// 30B2:0298
void SilencePCSpeaker(void)
{
	SDLBackend_SilencePCSpeaker();
}

// 30B2:029F
void WritePCSpeakerPITDivisor(byte divisorLowByte, byte divisorHighByte)
{
	SDLBackend_WritePCSpeakerPITDivisor(
		(uint16) divisorLowByte | ((uint16) divisorHighByte << 0x08));
}

// 30B2:02A6
// Called from StartLoadedMusicTrack.
void StartPCSpeakerFixedTone(void)
{
	WritePCSpeakerPITDivisor(0x0E, 0x00);
	(void) EnablePCSpeaker();
}

// 30B2:02C1
// Called from StopLoadedMusicTrack, InstallMusicTimer and RestoreSystemTimer.
void DisablePCSpeaker(void)
{
	SilencePCSpeaker();
}

// 30B2:02D9
// Called from InitializeGame and PlayScenarioDigitalSoundSequence.
void InstallMusicTimer(void)
{
	word16 timerDivisor;

	Seg426B.GameDataSegment = 0x3A6A;
	SavedSystemTimerHandler = SDLBackend_SwapInterruptHandler(
		0x08, MusicTimerIRQ0Handler);
	Seg426B.SystemTickReload = MUSIC_SYSTEM_TICK_RELOAD;
	Seg426B.SystemTickCountdown = 0x0000;
	if (Seg426B.MusicDriverMode == MUSIC_DRIVER_MODE_1 ||
		Seg426B.MusicDriverMode == MUSIC_DRIVER_MODE_2)
		Seg426B.MusicServiceReload = MUSIC_SERVICE_RELOAD;
	else
		Seg426B.MusicServiceReload = 0x0000;
	Seg426B.MusicServiceCountdown = 0x0000;
	Seg426B.MusicServiceBusy = 0x0000;

	if (Seg426B.MusicDriverMode == MUSIC_DRIVER_NONE)
		timerDivisor = MUSIC_PIT_DIVISOR_NORMAL_DRIVER;
	else
		timerDivisor = MUSIC_PIT_DIVISOR_FAST_DRIVER;
	SDLBackend_ProgramPITChannel0Mode(0x36, timerDivisor);
	DisablePCSpeaker();
}

// 30B2:0382
// Called from ShutdownGame and PlayScenarioDigitalSoundSequence.
void RestoreSystemTimer(void)
{
	(void) SDLBackend_SwapInterruptHandler(
		0x08, SavedSystemTimerHandler);
	SDLBackend_ProgramPITChannel0Mode(0x36, 0x0000);
	DisablePCSpeaker();
}

// 30B2:03B6
void StartPCSpeakerEffectStream(const byte *effectStream)
{
	Seg426B.PendingSpeakerEffectStream = DosAddress_FromValue(
		HostFarPointer_Encode(effectStream));
	Seg426B.SpeakerEffectStartRequested = 0x01;
	Seg426B.SpeakerEffectPlaybackActive = 0x01;
	Seg426B.SpeakerEffectServiceActive = 0x01;
}

// 30B2:03E1
void SetPCSpeakerEffectStopRequest(void)
{
	Seg426B.SpeakerEffectStopRequested = 0x01;
}

// 30B2:0010
// Hardware IRQ0 entry: register preservation and IRET are implicit here.
void MusicTimerIRQ0Handler(void)
{
	if ((byte) Seg426B.MusicServiceCountdown == 0x00)
	{
		if (++Seg426B.MusicElapsedSubtick > MUSIC_ELAPSED_SUBTICK_MAX)
		{
			Seg426B.MusicElapsedSubtick = 0x0000;
			if (++Seg426B.MusicElapsedUnit > MUSIC_ELAPSED_UNIT_MAX)
				Seg426B.MusicElapsedUnit = 0x00;
		}

		DecodePCSpeakerEffectTick();
		if ((byte) Seg426B.SystemTickCountdown == 0x00)
		{
			Seg426B.SystemTickCountdown =
				Seg426B.SystemTickReload;
			Seg426B.ChainSystemTimerThisTick = 0x01;
		}
		else
			--Seg426B.SystemTickCountdown;
	}

	if (Seg426B.MusicDriverMode != MUSIC_DRIVER_NONE)
		ServiceActiveMIDIDriver();

	if ((byte) Seg426B.MusicServiceCountdown != 0x00)
		--Seg426B.MusicServiceCountdown;
	else
		Seg426B.MusicServiceCountdown =
			Seg426B.MusicServiceReload;

	if (Seg426B.ChainSystemTimerThisTick != 0x00)
	{
		Seg426B.ChainSystemTimerThisTick = 0x00;
		if (SavedSystemTimerHandler != NULL)
			SavedSystemTimerHandler();
		return;
	}

	SDLBackend_AcknowledgeInterrupt(0x08);
	if (Seg426B.MusicDriverMode != MUSIC_DRIVER_NONE &&
		Seg426B.MusicServiceCountdown == 0x0001 &&
		(Seg426B.SystemTickCountdown & 0x0003) == 0x0001)
	{
		EnableHardwareInterrupts();
		if (Seg426B.MusicServiceBusy == 0x0000)
		{
			Seg426B.MusicServiceBusy = 0x0001;
			ServiceMIDISequenceTick();
			Seg426B.MusicServiceBusy = 0x0000;
		}
	}
}

// 30B2:00DF
// Consume one PC-speaker stream tick. DS is implicit Seg426B, not an argument.
// Verified against 30B2:00DF-0290.
void DecodePCSpeakerEffectTick(void)
{
	if (Seg426B.SpeakerEffectStartRequested != 0x00)
	{
		Seg426B.SpeakerEffectServiceActive = 0x01;
		Seg426B.SpeakerEffectPlaybackActive = 0x01;
		Seg426B.SpeakerEffectFetchNextEvent = 0x01;
		Seg426B.SpeakerEffectStartRequested = 0x00;
		Seg426B.SpeakerEffectStopRequested = 0x00;
		Seg426B.ActiveSpeakerEffectStream =
			Seg426B.PendingSpeakerEffectStream;
		Seg426B.SpeakerEffectStreamCursor = 0x0000;
	}

	if (Seg426B.SpeakerEffectPlaybackActive == 0x00)
		return;

	word16 streamCursor = Seg426B.SpeakerEffectStreamCursor;
	if (Seg426B.SpeakerEffectFetchNextEvent == 0x00)
	{
		--Seg426B.SpeakerEffectTicksRemaining;
		if ((int16) Seg426B.SpeakerEffectTicksRemaining < 0x00
			&& Seg426B.SpeakerEffectTicksRemaining != 0xFFFF)
			Seg426B.SpeakerEffectFetchNextEvent = 0x01;
		if (Seg426B.SpeakerEffectStopRequested != 0x00)
			goto stopPlayback;
	}
	else
	{
		const byte *effectStream = (const byte *)
			HostFarPointer_Resolve(DosAddress_ToValue(
				Seg426B.ActiveSpeakerEffectStream));
		word16 pitDivisor;

		while (TRUE)
		{
			byte command = effectStream[streamCursor];
			if (command <= SPEAKER_EFFECT_NOTE_MAX)
			{
				pitDivisor = Seg426B.MusicFrequencyDivisorTable[command];
				break;
			}

			switch (command)
			{
			case SPEAKER_EFFECT_COMMAND_LOOP1_BEGIN:
				Seg426B.SpeakerEffectLoop1Remaining =
					effectStream[streamCursor + 0x01];
				if (Seg426B.SpeakerEffectLoop1Remaining == 0x00)
					Seg426B.SpeakerEffectLoop1Remaining = 0x01;
				streamCursor += 0x02;
				continue;
			case SPEAKER_EFFECT_COMMAND_LOOP1_END:
				if (--Seg426B.SpeakerEffectLoop1Remaining != 0x00)
				{
					word16 loopOrigin = streamCursor + 0x01;
					word16 loopDistance = effectStream[streamCursor + 0x01]
						| ((word16)effectStream[streamCursor + 0x02] << 0x08);
					word16 loopTarget = loopOrigin - loopDistance;

					streamCursor = loopTarget;
					if (((loopOrigin ^ loopDistance)
						& (loopOrigin ^ loopTarget) & 0x8000) != 0x00)
						goto stopPlayback;
				}
				else
					streamCursor += 0x03;
				continue;
			case SPEAKER_EFFECT_COMMAND_LOOP2_BEGIN:
				Seg426B.SpeakerEffectLoop2Remaining =
					effectStream[streamCursor + 0x01];
				if (Seg426B.SpeakerEffectLoop2Remaining == 0x00)
					Seg426B.SpeakerEffectLoop2Remaining = 0x01;
				streamCursor += 0x02;
				continue;
			case SPEAKER_EFFECT_COMMAND_LOOP2_END:
				if (--Seg426B.SpeakerEffectLoop2Remaining != 0x00)
				{
					word16 loopOrigin = streamCursor + 0x01;
					word16 loopDistance = effectStream[streamCursor + 0x01]
						| ((word16)effectStream[streamCursor + 0x02] << 0x08);
					word16 loopTarget = loopOrigin - loopDistance;

					streamCursor = loopTarget;
					if (((loopOrigin ^ loopDistance)
						& (loopOrigin ^ loopTarget) & 0x8000) != 0x00)
						goto stopPlayback;
				}
				else
					streamCursor += 0x03;
				continue;
			case SPEAKER_EFFECT_COMMAND_FREQUENCY_HZ:
				pitDivisor = (word16) (PIT_INPUT_FREQUENCY_HZ /
					(effectStream[streamCursor + 0x01]
						| ((word16)effectStream[streamCursor + 0x02] << 0x08)));
				streamCursor += 0x02;
				goto playEvent;
			case SPEAKER_EFFECT_COMMAND_SET_DURATION_SCALE:
				Seg426B.SpeakerEffectDurationScale =
					effectStream[streamCursor + 0x01];
				if (Seg426B.SpeakerEffectDurationScale == 0x00)
					Seg426B.SpeakerEffectDurationScale = 0x01;
				streamCursor += 0x02;
				continue;
			case SPEAKER_EFFECT_COMMAND_DECREASE_DURATION_SCALE:
			{
				byte oldScale = Seg426B.SpeakerEffectDurationScale;
				byte decrease = effectStream[streamCursor + 0x01];
				byte result = oldScale - decrease;
				byte signedOverflow = (byte) (
					((oldScale ^ decrease) & (oldScale ^ result) & 0x80)
					!= 0x00);
				Seg426B.SpeakerEffectDurationScale = result;
				// The original uses JNO followed by JNZ, not an unsigned borrow test.
				// Preserve that unusual behavior exactly; in practice this condition
				// cannot be true for SUB, so the byte subtraction wraps normally.
				if (signedOverflow && result == 0x00)
					Seg426B.SpeakerEffectDurationScale = 0x01;
				streamCursor += 0x02;
				continue;
			}
			case SPEAKER_EFFECT_COMMAND_INCREASE_DURATION_SCALE:
			{
				byte oldScale = Seg426B.SpeakerEffectDurationScale;
				byte increase = effectStream[streamCursor + 0x01];
				byte result = oldScale + increase;
				byte signedOverflow = (byte) (
					((~(oldScale ^ increase) & (oldScale ^ result)) & 0x80)
					!= 0x00);
				Seg426B.SpeakerEffectDurationScale = signedOverflow ? 0xFF : result;
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
			WritePCSpeakerPITDivisor(
				(byte) pitDivisor, (byte) (pitDivisor >> 0x08));
			EnablePCSpeaker();
		}
		else
			SilencePCSpeaker();

		Seg426B.SpeakerEffectTicksRemaining =
			Seg426B.SpeakerEffectDurationScale
			* (byte)(effectStream[streamCursor + 0x01] + 0x01) - 0x01;
		Seg426B.SpeakerEffectFetchNextEvent = 0x00;
		streamCursor += 0x02;
	}

	Seg426B.SpeakerEffectStreamCursor = streamCursor;
	return;

stopPlayback:
	SilencePCSpeaker();
	Seg426B.SpeakerEffectStopRequested = 0x00;
	Seg426B.SpeakerEffectPlaybackActive = 0x00;
	Seg426B.SpeakerEffectServiceActive = 0x00;
	Seg426B.SpeakerEffectStreamCursor = streamCursor;
}
