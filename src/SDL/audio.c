#include "revenge/platform_backend.h"
#include "revenge/audio.h"
#include "revenge/debug.h"

#include <SDL3/SDL.h>
#include <limits.h>
#include <math.h>
#include <string.h>

enum
{
    AudioSampleRate = 0xBB80,
    AudioQueueCapacity = 0x20000,
    AudioChunkSampleCount = 0x0200,
    SpeakerAmplitude = 0x2000,
	MIDIEnvelopeMaximum = 0xFFFF,
	MIDIEnvelopeAttackStep = 0x0100,
	MIDIEnvelopeReleaseStep = 0x0040
};

#define MIDI_TWO_PI 6.28318530717958647692

typedef struct MIDIVoice
{
    uint32 phase;
    uint32 phaseStep;
	uint32 noiseState;
	word16 semanticVoiceId;
	word16 envelopeLevel;
    byte channel;
    byte note;
    byte velocity;
	byte program;
	byte voiceClass;
	byte semanticVoice;
	byte releasing;
    byte active;
} MIDIVoice;

static SDL_AudioStream *audioStream;
static SDL_Mutex *audioMutex;
static int16_t digitalQueue[AudioQueueCapacity];
static size_t digitalQueueRead;
static size_t digitalQueueCount;
static uint16 speakerDivisor = 0x0000;
static uint16 digitalSampleRate = 0x1F40;
static uint32 digitalOutputPhase;
static uint64_t speakerPhase;
static byte speakerEnabled;
static byte speakerControlState;
static word16 timedDelayScale;
static word16 timedByteCount;
static MIDIVoice midiVoices[0x20];
static byte midiStatus;
static byte midiData[0x02];
static byte midiDataCount;
static byte midiDataExpected;
static byte tracedMusicVoiceCount;
static int32_t midiFilterSample;

static uint32 MIDIPhaseStep(byte note)
{
    static const uint16 baseFrequencyHundredths[0x0C] =
    {
        0x0331, 0x0362, 0x0395, 0x03CC,
        0x0406, 0x0443, 0x0484, 0x04C9,
        0x0512, 0x055F, 0x05B1, 0x0608
    };
    uint64_t frequencyHundredths;

    frequencyHundredths = (uint64_t)baseFrequencyHundredths[note % 0x0C]
        << (note / 0x0C);
    return (uint32)((frequencyHundredths << 0x20)
        / (AudioSampleRate * 0x64ULL));
}

static void StopMIDINote(byte channel, byte note)
{
    byte voice;

    for (voice = 0x00; voice < 0x20; ++voice)
    {
        if (midiVoices[voice].active != FALSE
            && midiVoices[voice].channel == channel
            && midiVoices[voice].note == note)
			midiVoices[voice].releasing = TRUE;
    }
}

static void StartSynthMIDINote(byte channel, byte note, byte velocity)
{
    byte voice;
    byte selectedVoice;

    StopMIDINote(channel, note);
    selectedVoice = 0x00;
    for (voice = 0x00; voice < 0x20; ++voice)
    {
        selectedVoice = voice;
        if (midiVoices[voice].active == FALSE)
            break;
    }
    midiVoices[selectedVoice].phase = 0x00000000UL;
    midiVoices[selectedVoice].phaseStep = MIDIPhaseStep(note);
	midiVoices[selectedVoice].noiseState =
		0x9E3779B9UL ^ ((uint32)channel << 0x10) ^ note;
	midiVoices[selectedVoice].envelopeLevel = 0x0000;
    midiVoices[selectedVoice].channel = channel;
    midiVoices[selectedVoice].note = note;
    midiVoices[selectedVoice].velocity = velocity;
	midiVoices[selectedVoice].program = channel;
	midiVoices[selectedVoice].voiceClass = 0x20;
	midiVoices[selectedVoice].semanticVoice = FALSE;
	midiVoices[selectedVoice].releasing = FALSE;
    midiVoices[selectedVoice].active = TRUE;
}

static void ApplyMIDIMessage(void)
{
    byte messageType;
    byte channel;

    messageType = midiStatus & 0xF0;
    channel = midiStatus & 0x0F;
    if (messageType == 0x80)
        StopMIDINote(channel, midiData[0x00]);
    else if (messageType == 0x90)
    {
        if (midiData[0x01] == 0x00)
            StopMIDINote(channel, midiData[0x00]);
        else
            StartSynthMIDINote(channel, midiData[0x00], midiData[0x01]);
    }
    else if (messageType == 0xB0 && midiData[0x00] == 0x7B)
    {
        byte voice;

        for (voice = 0x00; voice < 0x20; ++voice)
        {
            if (midiVoices[voice].channel == channel)
				midiVoices[voice].releasing = TRUE;
        }
    }
}

static int16_t NextMIDISample(void)
{
    int32_t mixedSample;
    byte voice;

    mixedSample = 0x00000000L;
    for (voice = 0x00; voice < 0x20; ++voice)
    {
        if (midiVoices[voice].active == FALSE)
            continue;
		{
			int16_t waveformSample;
			uint32 envelope;

			if (midiVoices[voice].releasing != FALSE)
			{
				if (midiVoices[voice].envelopeLevel <=
					MIDIEnvelopeReleaseStep)
				{
					midiVoices[voice].envelopeLevel = 0x0000;
					midiVoices[voice].active = FALSE;
					continue;
				}
				midiVoices[voice].envelopeLevel -=
					MIDIEnvelopeReleaseStep;
			}
			else if (midiVoices[voice].envelopeLevel <
				MIDIEnvelopeMaximum - MIDIEnvelopeAttackStep)
			{
				midiVoices[voice].envelopeLevel += MIDIEnvelopeAttackStep;
			}
			else
			{
				midiVoices[voice].envelopeLevel = MIDIEnvelopeMaximum;
			}
			envelope = midiVoices[voice].envelopeLevel;
			if ((midiVoices[voice].voiceClass & 0x20) == 0x00)
			{
				uint32 noise;

				noise = midiVoices[voice].noiseState;
				noise ^= noise << 0x0D;
				noise ^= noise >> 0x11;
				noise ^= noise << 0x05;
				midiVoices[voice].noiseState = noise;
				waveformSample = (int16_t)((int32_t)(noise >> 0x18)
					- 0x0080) * 0x02;
			}
			else
			{
				double carrierPhase;
				double modulationIndex;
				double modulator;

				carrierPhase = (double)midiVoices[voice].phase
					* MIDI_TWO_PI / 4294967296.0;
				modulationIndex = 0.15
					+ (double)(midiVoices[voice].program & 0x07) * 0.08;
				modulator = sin(carrierPhase * 0x02) * modulationIndex;
				waveformSample = (int16_t)(
					sin(carrierPhase + modulator) * 0x0200);
			}
			mixedSample += (int32_t)waveformSample
				* midiVoices[voice].velocity * envelope
				/ (0x20L * MIDIEnvelopeMaximum);
		}
        midiVoices[voice].phase += midiVoices[voice].phaseStep;
    }
	midiFilterSample = (midiFilterSample * 0x03 + mixedSample) / 0x04;
	mixedSample = midiFilterSample;
    if (mixedSample > INT16_MAX)
        mixedSample = INT16_MAX;
    else if (mixedSample < INT16_MIN)
        mixedSample = INT16_MIN;
    return (int16_t)mixedSample;
}

static int16_t NextToneSample(void)
{
    uint64_t period;
    int16_t sample;

    if (speakerEnabled == FALSE)
        return 0x0000;
    period = (uint64_t)AudioSampleRate
        * (speakerDivisor == 0x0000 ? 0x10000UL : speakerDivisor);
    sample = speakerPhase < period / 0x02
        ? SpeakerAmplitude : -SpeakerAmplitude;
    speakerPhase = (speakerPhase + PIT_INPUT_FREQUENCY_HZ) % period;
    return sample;
}

static void SDLCALL FeedAudio(
    void *userData,
    SDL_AudioStream *stream,
    int additionalAmount,
    int totalAmount)
{
    int16_t samples[AudioChunkSampleCount];

    (void)userData;
    (void)totalAmount;
    while (additionalAmount > 0x00)
    {
        int sampleCount;
        int sample;

        sampleCount = additionalAmount / (int)sizeof(samples[0x00]);
        if (sampleCount > AudioChunkSampleCount)
            sampleCount = AudioChunkSampleCount;
        if (sampleCount == 0x00)
            break;
        SDL_LockMutex(audioMutex);
        for (sample = 0x00; sample < sampleCount; ++sample)
        {
            {
				int32_t mixedSample;

				mixedSample = (int32_t)NextToneSample() + NextMIDISample();
				if (digitalQueueCount != 0x0000)
				{
					mixedSample += digitalQueue[digitalQueueRead];
					digitalQueueRead = (digitalQueueRead + 0x0001)
						% AudioQueueCapacity;
					--digitalQueueCount;
				}
				if (mixedSample > INT16_MAX)
					mixedSample = INT16_MAX;
				else if (mixedSample < INT16_MIN)
					mixedSample = INT16_MIN;
				samples[sample] = (int16_t)mixedSample;
			}
        }
        SDL_UnlockMutex(audioMutex);
        if (!SDL_PutAudioStreamData(
            stream, samples, sampleCount * (int)sizeof(samples[0x00])))
            break;
        additionalAmount -= sampleCount * (int)sizeof(samples[0x00]);
    }
}

int SDLBackend_OpenAudio(void)
{
    SDL_AudioSpec specification;

    if (audioStream != NULL)
        return TRUE;
    specification.format = SDL_AUDIO_S16;
    specification.channels = 0x01;
    specification.freq = AudioSampleRate;
    audioMutex = SDL_CreateMutex();
    if (audioMutex == NULL)
        return FALSE;
    audioStream = SDL_OpenAudioDeviceStream(
        SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK,
        &specification,
        FeedAudio,
        NULL);
    if (audioStream == NULL || !SDL_ResumeAudioStreamDevice(audioStream))
    {
        SDLBackend_CloseAudio();
        return FALSE;
    }
    return TRUE;
}

void SDLBackend_CloseAudio(void)
{
    SDL_DestroyAudioStream(audioStream);
    audioStream = NULL;
    SDL_DestroyMutex(audioMutex);
    audioMutex = NULL;
    digitalQueueRead = 0x0000;
    digitalQueueCount = 0x0000;
    digitalOutputPhase = 0x00000000UL;
    speakerControlState = 0x00;
    speakerEnabled = FALSE;
    memset(midiVoices, 0x00, sizeof(midiVoices));
	midiFilterSample = 0x00000000L;
    midiStatus = 0x00;
    midiDataCount = 0x00;
    midiDataExpected = 0x00;
}

byte SDLBackend_EnablePCSpeaker(void)
{
    if (audioMutex != NULL)
        SDL_LockMutex(audioMutex);
    speakerControlState |= 0x03;
    speakerEnabled = TRUE;
    if (audioMutex != NULL)
        SDL_UnlockMutex(audioMutex);
    return speakerControlState;
}

void SDLBackend_SilencePCSpeaker(void)
{
    if (audioMutex != NULL)
        SDL_LockMutex(audioMutex);
    speakerControlState &= 0xFC;
    speakerEnabled = FALSE;
    if (audioMutex != NULL)
        SDL_UnlockMutex(audioMutex);
}

void SDLBackend_WritePCSpeakerPITDivisor(uint16 divisor)
{
    uint64_t period;

    if (audioMutex != NULL)
        SDL_LockMutex(audioMutex);
    speakerDivisor = divisor;
    period = (uint64_t)AudioSampleRate
        * (divisor == 0x0000 ? 0x10000UL : divisor);
    speakerPhase %= period;
    if (audioMutex != NULL)
        SDL_UnlockMutex(audioMutex);
}

void SDLBackend_SetPCSpeakerSampleRate(uint16 sampleRateHz)
{
    if (sampleRateHz != 0x0000)
        digitalSampleRate = sampleRateHz;
}

void SDLBackend_BeginPCSpeakerTimedOutput(word16 delayScale)
{
    /* 373D:000E loads the word argument into DX, but every delay loop uses
     * DL/DH/AH. The high argument byte is therefore discarded by the DOS
     * routine before any timed output is produced. */
    timedDelayScale = (word16)(byte)delayScale;
    timedByteCount = 0x0000;
}

void SDLBackend_WritePCSpeakerBitstream(
    const byte *sampleData,
    word16 byteCount)
{
    word16 consumedByteCount;
    uint32 sourceBit;
    uint32 outputSampleCount;
    uint32 outputSample;

    /* 373D:0057-005A converts the byte count to a word count. The original
     * unrolled loop therefore consumes complete little-endian words only. */
    consumedByteCount = (word16)(byteCount & 0xFFFE);
    timedByteCount = (word16)(timedByteCount + consumedByteCount);
    if (audioMutex == NULL || sampleData == NULL)
        return;
    outputSampleCount = (uint32)(((uint64_t)consumedByteCount * 0x08
        * AudioSampleRate) / digitalSampleRate);
    SDL_LockMutex(audioMutex);
    if (outputSampleCount > AudioQueueCapacity - digitalQueueCount)
        outputSampleCount = (uint32)(AudioQueueCapacity - digitalQueueCount);
    for (outputSample = 0x00000000UL;
        outputSample < outputSampleCount;
        ++outputSample)
    {
        size_t writeOffset;

        sourceBit = (uint32)(((uint64_t)outputSample * digitalSampleRate)
            / AudioSampleRate);
        writeOffset = (digitalQueueRead + digitalQueueCount)
            % AudioQueueCapacity;
        digitalQueue[writeOffset] =
            (sampleData[sourceBit >> 0x03]
                & (0x01 << (sourceBit & 0x07))) != 0x00
            ? SpeakerAmplitude : -SpeakerAmplitude;
        ++digitalQueueCount;
    }
    SDL_UnlockMutex(audioMutex);
}

word16 SDLBackend_EndPCSpeakerTimedOutput(void)
{
    /* The DOS routine measured calibration output with PIT channel zero. The
     * host has no corresponding busy-loop cost, so report the instruction-
     * proportional count used by the recovered scale search. */
    return (word16)((uint32)timedByteCount * 0x08 * timedDelayScale);
}

void SDLBackend_PlayUnsigned8PCM(
    const byte *sampleData,
    uint16 byteCount,
    uint16 sourceRateHz,
    uint16 playbackScale,
    uint16 repeatCount)
{
    uint32 effectiveRateHz;
    uint16 pass;

    if (audioMutex == NULL || sampleData == NULL || byteCount == 0x0000
        || sourceRateHz == 0x0000 || playbackScale == 0x0000)
    {
        return;
    }
    effectiveRateHz = (uint32)(((uint64_t)sourceRateHz * playbackScale)
        / DIGITAL_WEAPON_EFFECT_UNITY_SCALE);
    if (effectiveRateHz == 0x00000000UL)
        effectiveRateHz = 0x00000001UL;

    SDL_LockMutex(audioMutex);
    digitalQueueRead = 0x0000;
    digitalQueueCount = 0x0000;
    for (pass = 0x0000; pass <= repeatCount; ++pass)
    {
        uint32 outputSampleCount;
        uint32 outputSample;

        outputSampleCount = (uint32)(((uint64_t)byteCount
            * AudioSampleRate) / effectiveRateHz);
        if (outputSampleCount > AudioQueueCapacity - digitalQueueCount)
            outputSampleCount = (uint32)(AudioQueueCapacity
                - digitalQueueCount);
        for (outputSample = 0x00000000UL;
            outputSample < outputSampleCount;
            ++outputSample)
        {
            uint32 sourceSample;
            size_t writeOffset;

            sourceSample = (uint32)(((uint64_t)outputSample
                * effectiveRateHz) / AudioSampleRate);
            if (sourceSample >= byteCount)
                sourceSample = byteCount - 0x0001;
            writeOffset = (digitalQueueRead + digitalQueueCount)
                % AudioQueueCapacity;
            digitalQueue[writeOffset] = (int16_t)(
                ((int16)sampleData[sourceSample] - 0x0080) * 0x0100);
            ++digitalQueueCount;
        }
        if (digitalQueueCount == AudioQueueCapacity)
            break;
    }
    SDL_UnlockMutex(audioMutex);
}

void SDLBackend_WaitForUnsigned8PCM(void)
{
    for (;;)
    {
        size_t queuedSampleCount;

        if (audioMutex == NULL)
            return;
        SDL_LockMutex(audioMutex);
        queuedSampleCount = digitalQueueCount;
        SDL_UnlockMutex(audioMutex);
        if (queuedSampleCount == 0x0000)
            return;
        SDL_Delay(0x01);
    }
}

void SDLBackend_WriteMIDIByte(byte midiByte)
{
    if (audioMutex != NULL)
        SDL_LockMutex(audioMutex);
    if ((midiByte & 0x80) != 0x00)
    {
        midiStatus = midiByte;
        midiDataCount = 0x00;
        if (midiByte < 0xF0)
        {
            byte messageType;

            messageType = midiByte & 0xF0;
            midiDataExpected = messageType == 0xC0 || messageType == 0xD0
                ? 0x01 : 0x02;
        }
        else
            midiDataExpected = 0x00;
    }
    else if (midiDataExpected != 0x00)
    {
        midiData[midiDataCount++] = midiByte;
        if (midiDataCount == midiDataExpected)
        {
            ApplyMIDIMessage();
            midiDataCount = 0x00;
        }
    }
    if (audioMutex != NULL)
        SDL_UnlockMutex(audioMutex);
}

void SDLBackend_StartMusicVoice(
	word16 voiceId,
	byte note,
	byte velocity,
	byte program,
	byte voiceClass)
{
	byte voice;
	byte selectedVoice;

	if (audioMutex != NULL)
		SDL_LockMutex(audioMutex);
	selectedVoice = 0x00;
	for (voice = 0x00; voice < 0x20; ++voice)
	{
		if (midiVoices[voice].active != FALSE
			&& midiVoices[voice].semanticVoice != FALSE
			&& midiVoices[voice].semanticVoiceId == voiceId)
		{
			selectedVoice = voice;
			break;
		}
		selectedVoice = voice;
		if (midiVoices[voice].active == FALSE)
			break;
	}
	midiVoices[selectedVoice].phase = 0x00000000UL;
	midiVoices[selectedVoice].phaseStep = MIDIPhaseStep(note);
	midiVoices[selectedVoice].noiseState =
		0x9E3779B9UL ^ ((uint32)voiceId << 0x08) ^ note;
	midiVoices[selectedVoice].envelopeLevel = 0x0000;
	midiVoices[selectedVoice].semanticVoiceId = voiceId;
	midiVoices[selectedVoice].channel = 0x00;
	midiVoices[selectedVoice].note = note;
	midiVoices[selectedVoice].velocity = velocity;
	midiVoices[selectedVoice].program = program;
	midiVoices[selectedVoice].voiceClass = voiceClass;
	midiVoices[selectedVoice].semanticVoice = TRUE;
	midiVoices[selectedVoice].releasing = FALSE;
	midiVoices[selectedVoice].active = TRUE;
	if (tracedMusicVoiceCount < 0x10)
	{
		RevengeTrace(
			"audio: voice=%04X note=%u velocity=%u program=%u class=%02X\n",
			voiceId, note, velocity, program, voiceClass);
		++tracedMusicVoiceCount;
	}
	if (audioMutex != NULL)
		SDL_UnlockMutex(audioMutex);
}

void SDLBackend_StopMusicVoice(word16 voiceId)
{
	byte voice;

	if (audioMutex != NULL)
		SDL_LockMutex(audioMutex);
	for (voice = 0x00; voice < 0x20; ++voice)
	{
		if (midiVoices[voice].semanticVoice != FALSE
			&& midiVoices[voice].semanticVoiceId == voiceId)
		{
			midiVoices[voice].releasing = TRUE;
		}
	}
	if (audioMutex != NULL)
		SDL_UnlockMutex(audioMutex);
}

void SDLBackend_ResetMusicVoices(void)
{
	byte voice;

	if (audioMutex != NULL)
		SDL_LockMutex(audioMutex);
	for (voice = 0x00; voice < 0x20; ++voice)
	{
		if (midiVoices[voice].semanticVoice != FALSE)
		{
			midiVoices[voice].active = FALSE;
			midiVoices[voice].releasing = FALSE;
			midiVoices[voice].envelopeLevel = 0x0000;
		}
	}
	if (audioMutex != NULL)
		SDL_UnlockMutex(audioMutex);
}

word16 SDLBackend_ProbeLegacyAudioDevice(byte deviceId)
{
	/* Device 03h is the original AdLib selection. Hosted builds intercept its
	 * semantic voice operations before they become OPL register writes. Device
	 * 04h remains the byte-oriented MPU-401 path. */
	return deviceId == 0x03 || deviceId == 0x04 ? TRUE : FALSE;
}

byte SDLBackend_ReadLegacyAudioPort(word16 port)
{
	(void) port;
	return 0x00;
}

void SDLBackend_WriteLegacyAudioPort(word16 port, byte value)
{
	(void) port;
	(void) value;
}

void SDLBackend_SetDigitalOutputRate(word16 sampleRateHz)
{
    if (sampleRateHz != 0x0000)
        digitalSampleRate = sampleRateHz;
    digitalOutputPhase = 0x00000000UL;
}

void SDLBackend_WriteUnsigned8Sample(byte sample)
{
    if (audioMutex == NULL || digitalSampleRate == 0x0000)
        return;
    SDL_LockMutex(audioMutex);
    digitalOutputPhase += AudioSampleRate;
    while (digitalOutputPhase >= digitalSampleRate &&
        digitalQueueCount < AudioQueueCapacity)
    {
        size_t writeOffset;

        writeOffset = (digitalQueueRead + digitalQueueCount)
            % AudioQueueCapacity;
        digitalQueue[writeOffset] =
            (int16_t)(((int16)sample - 0x0080) * 0x0100);
        ++digitalQueueCount;
        digitalOutputPhase -= digitalSampleRate;
    }
    SDL_UnlockMutex(audioMutex);
}
