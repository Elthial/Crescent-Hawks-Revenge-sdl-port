#ifndef REVENGE_TEST_FAKE_BACKEND_H
#define REVENGE_TEST_FAKE_BACKEND_H

#include "revenge/dos.h"
#include "revenge/input.h"

typedef struct FakeBackendState
{
    byte consoleCharacters[0x40];
    uint16 consoleCharacterCount;
    byte drive;
    const char *path;
    uint16 fileHandle;
    uint16 firstWord;
    uint16 secondWord;
    byte firstByte;
    void *buffer;
    long fileOffset;
    DOS_InterruptHandler interruptHandler;
    uint32 interruptVectors[0x0100];
	uint32 chainedInterruptVector;
    uint32 biosTickCount;
    uint32 biosTickStep;
    word16 pitChannel0Divisor;
    byte pitChannel0Mode;
    word16 latchedPITChannel0Count;
    word16 interruptFlags;
    byte acknowledgedInterrupt;
    uint16 rawKeypress;
    word16 inputPending;
    uint16 queuedRawKeypress;
    word16 queuedInputPending;
    MouseInputState mouse;
    byte videoMode;
    uint16 videoAdapter;
    byte paletteRegister;
    byte paletteValue;
    byte vgaPalette[0x0300];
    uint16 retraceCount;
    byte indexedFramebuffer[0x0140 * 0x00C8];
    byte midiBytes[0x0100];
    uint16 midiByteCount;
	word16 musicVoiceId;
	byte musicNote;
	byte musicVelocity;
	byte musicProgram;
	byte musicVoiceClass;
	uint16 musicVoiceStartCount;
	uint16 musicVoiceStopCount;
	uint16 musicVoiceResetCount;
    const byte *pcmSampleData;
    uint16 pcmByteCount;
    uint16 pcmSourceRateHz;
    uint16 pcmPlaybackScale;
    uint16 pcmRepeatCount;
    uint16 pcmPlayCount;
    uint16 pcmWaitCount;
} FakeBackendState;

extern FakeBackendState fakeBackend;

void FakeBackend_Reset(void);

#endif
