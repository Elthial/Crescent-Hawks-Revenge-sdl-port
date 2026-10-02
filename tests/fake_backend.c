#include "fake_backend.h"
#include "revenge/platform_backend.h"
#include "revenge/interrupts.h"

#include <stdlib.h>
#include <string.h>

FakeBackendState fakeBackend;

_Noreturn void SDLBackend_TerminateProcess(byte exitCode)
{
	exit((int) exitCode);
}

void RevengeHost_EnableInterruptDelivery(void)
{
}

void RevengeHost_DisableInterruptDelivery(void)
{
}

void FakeBackend_Reset(void)
{
    memset(&fakeBackend, 0, sizeof(fakeBackend));
    fakeBackend.biosTickStep = 0x00000001U;
    fakeBackend.interruptFlags = 0x0200;
}

uint16 SDLBackend_DirectConsoleIO(byte character)
{
    fakeBackend.consoleCharacters[fakeBackend.consoleCharacterCount++] = character;
    return (uint16)(0x0600 | character);
}

void SDLBackend_SelectDefaultDrive(byte zeroBasedDrive)
{
    fakeBackend.drive = zeroBasedDrive;
}

int16 SDLBackend_CreateFile(uint16 attributes, const char *filePath)
{
    fakeBackend.firstWord = attributes;
    fakeBackend.path = filePath;
    return 0x0005;
}

int16 SDLBackend_OpenFile(const char *filePath, uint16 openFlags)
{
    fakeBackend.path = filePath;
    fakeBackend.firstWord = openFlags;
    return 0x0006;
}

int16 SDLBackend_CloseFile(int16 fileHandle)
{
    fakeBackend.fileHandle = (uint16)fileHandle;
    return 0x0000;
}

int16 SDLBackend_ReadFile(
    uint16 fileHandle,
    void *destinationBuffer,
    uint16 byteCount)
{
    fakeBackend.fileHandle = fileHandle;
    fakeBackend.buffer = destinationBuffer;
    fakeBackend.firstWord = byteCount;
    return (int16)byteCount;
}

int16 SDLBackend_WriteFile(
    uint16 fileHandle,
    const void *sourceBuffer,
    uint16 byteCount)
{
    fakeBackend.fileHandle = fileHandle;
    fakeBackend.buffer = (void *)sourceBuffer;
    fakeBackend.firstWord = byteCount;
    return (int16)byteCount;
}

long SDLBackend_SeekFile(uint16 fileHandle, long fileOffset, byte origin)
{
    fakeBackend.fileHandle = fileHandle;
    fakeBackend.fileOffset = fileOffset;
    fakeBackend.firstByte = origin;
    return 0x12345678L;
}

int16 SDLBackend_DeleteFile(const char *filePath)
{
    fakeBackend.path = filePath;
    return 0x0000;
}

int16 SDLBackend_GetSetFileAttributes(
    const char *filePath,
    byte operation,
    uint16 attributes)
{
    fakeBackend.path = filePath;
    fakeBackend.firstByte = operation;
    fakeBackend.firstWord = attributes;
    return 0x0021;
}

int16 SDLBackend_DeviceIOControl(
    uint16 fileHandle,
    uint16 operation,
    void *data,
    uint16 count)
{
    fakeBackend.fileHandle = fileHandle;
    fakeBackend.firstWord = operation;
    fakeBackend.buffer = data;
    fakeBackend.secondWord = count;
    return 0x0080;
}

word16 SDLBackend_ResizeMemoryBlock(
    word16 memorySegment,
    word16 paragraphCount)
{
    fakeBackend.firstWord = memorySegment;
    fakeBackend.secondWord = paragraphCount;
    return 0xFFFF;
}

word16 SDLBackend_GetLargestFreeConventionalMemoryParagraphs(
	word16 requestedParagraphs)
{
	return requestedParagraphs;
}

void SDLBackend_GetSystemDate(DOS_Date *date)
{
    date->year = 0x07EA;
    date->month = 0x09;
    date->day = 0x1A;
}

void SDLBackend_GetSystemTime(DOS_Time *timeValue)
{
    timeValue->hour = 0x0C;
    timeValue->minute = 0x22;
    timeValue->second = 0x38;
    timeValue->hundredth = 0x4E;
}

const char *SDLBackend_GetEnvironmentVariable(const char *name)
{
	(void) name;
	return 0;
}

void SDLBackend_InvokeInterrupt(
	byte interruptNumber,
	const InterruptRegisterBlock *inputRegisters,
	InterruptRegisterBlock *outputRegisters,
	InterruptSegmentState *segmentState)
{
	*outputRegisters = *inputRegisters;
	outputRegisters->carry = FALSE;
	outputRegisters->flags = 0x0000;
	fakeBackend.firstByte = interruptNumber;
	(void) segmentState;
}

void SDLBackend_SetInterruptVector(
    byte interruptNumber,
    DOS_InterruptHandler handler)
{
    fakeBackend.firstByte = interruptNumber;
    fakeBackend.interruptHandler = handler;
}

DOS_InterruptHandler SDLBackend_SwapInterruptHandler(
    byte interruptNumber,
    DOS_InterruptHandler handler)
{
    DOS_InterruptHandler previousHandler;

    fakeBackend.firstByte = interruptNumber;
    previousHandler = fakeBackend.interruptHandler;
    fakeBackend.interruptHandler = handler;
    return previousHandler;
}

uint32 SDLBackend_SwapInterruptVector(
    byte interruptNumber,
    uint32 newVector)
{
    uint32 oldVector;

    oldVector = fakeBackend.interruptVectors[interruptNumber];
    fakeBackend.interruptVectors[interruptNumber] = newVector;
    return oldVector;
}

void SDLBackend_ChainInterruptVector(uint32 interruptVector)
{
	fakeBackend.chainedInterruptVector = interruptVector;
}

void SDLBackend_ProgramPITChannel0(word16 divisor)
{
    fakeBackend.pitChannel0Divisor = divisor;
}

void SDLBackend_ProgramPITChannel0Mode(byte mode, word16 divisor)
{
    fakeBackend.pitChannel0Mode = mode;
    fakeBackend.pitChannel0Divisor = divisor;
}

word16 SDLBackend_LatchPITChannel0Count(void)
{
    return fakeBackend.latchedPITChannel0Count;
}

void SDLBackend_WaitPITChannel0Interrupt(void)
{
}

word16 SDLBackend_SaveAndDisableInterrupts(void)
{
    word16 oldFlags;

    oldFlags = fakeBackend.interruptFlags;
    fakeBackend.interruptFlags &= (word16)~0x0200;
    return oldFlags;
}

void SDLBackend_RestoreInterruptFlags(word16 flags)
{
    fakeBackend.interruptFlags = flags;
}

void SDLBackend_AcknowledgeInterrupt(byte interruptNumber)
{
    fakeBackend.acknowledgedInterrupt = interruptNumber;
}

uint32 SDLBackend_GetBIOSTickCount(void)
{
    uint32 result;

    result = fakeBackend.biosTickCount;
    fakeBackend.biosTickCount += fakeBackend.biosTickStep;
    return result;
}

word16 SDLBackend_InputPending(void)
{
    return fakeBackend.inputPending;
}

uint16 SDLBackend_ReadRawKeypress(void)
{
    fakeBackend.inputPending = FALSE;
    return fakeBackend.rawKeypress;
}

int SDLBackend_PollQuit(void)
{
    return FALSE;
}

uint64_t SDLBackend_Milliseconds(void)
{
    return 0x00000000U;
}

void SDLBackend_Delay(uint32_t milliseconds)
{
    (void)milliseconds;
    if (fakeBackend.queuedInputPending != FALSE)
    {
        fakeBackend.rawKeypress = fakeBackend.queuedRawKeypress;
        fakeBackend.inputPending = TRUE;
        fakeBackend.queuedInputPending = FALSE;
    }
}

void SDLBackend_InstallKeyboardHandlers(void)
{
}

void SDLBackend_RestoreKeyboardHandlers(void)
{
}

void ReadMouseInputState(MouseInputState *state)
{
    *state = fakeBackend.mouse;
    fakeBackend.mouse.buttonEvent = FALSE;
}

byte SDLBackend_GetVideoMode(void)
{
    return fakeBackend.videoMode;
}

void SDLBackend_SetVideoMode(byte videoMode)
{
    fakeBackend.videoMode = videoMode;
}

void SDLBackend_SetVideoAdapter(uint16 adapterType)
{
    fakeBackend.videoAdapter = adapterType;
}

void SDLBackend_SelectCgaPalette(byte paletteId)
{
    fakeBackend.paletteValue = paletteId;
}

void SDLBackend_SetPaletteRegister(byte paletteRegister, byte paletteValue)
{
    fakeBackend.paletteRegister = paletteRegister;
    fakeBackend.paletteValue = paletteValue;
}

void SDLBackend_SetEgaGraphicsControllerRegister(byte registerIndex, byte value)
{
    fakeBackend.paletteRegister = registerIndex;
    fakeBackend.paletteValue = value;
}

void SDLBackend_SetEgaSequencerRegister(byte registerIndex, byte value)
{
	(void) registerIndex;
	(void) value;
}

void SDLBackend_LoadVgaPalette(const byte *paletteRgbTriplets)
{
    memcpy(fakeBackend.vgaPalette, paletteRgbTriplets,
        sizeof(fakeBackend.vgaPalette));
}

uint16 SDLBackend_IsVerticalRetraceActive(void)
{
    return 0x0008;
}

void SDLBackend_WaitVerticalRetrace(byte waitForRetraceStart)
{
    fakeBackend.firstByte = waitForRetraceStart;
    ++fakeBackend.retraceCount;
}

void SDLBackend_SetMouseVisible(uint16 visible)
{
	(void) visible;
}

void SDLBackend_SetMousePosition(int16 logicalX, int16 logicalY)
{
	fakeBackend.mouse.x = logicalX;
	fakeBackend.mouse.y = logicalY;
}

byte *SDLBackend_GetIndexedFramebuffer(void)
{
    return fakeBackend.indexedFramebuffer;
}

void SDLBackend_ClearIndexedFramebuffer(byte color)
{
    memset(fakeBackend.indexedFramebuffer, color,
        sizeof(fakeBackend.indexedFramebuffer));
}

void SDLBackend_DrawIndexedPixel(uint16 x, uint16 y, byte color)
{
    if (x < 0x0140 && y < 0x00C8)
        fakeBackend.indexedFramebuffer[(uint32)y * 0x0140 + x] = color;
}

int SDLBackend_PresentIndexedFramebuffer(void)
{
    return TRUE;
}

void Video_PresentTransientFrame(void)
{
}

int SDLBackend_OpenAudio(void)
{
    return TRUE;
}

void SDLBackend_CloseAudio(void)
{
}

byte SDLBackend_EnablePCSpeaker(void)
{
    return 0x03;
}

void SDLBackend_SilencePCSpeaker(void)
{
}

void SDLBackend_WritePCSpeakerPITDivisor(uint16 divisor)
{
    fakeBackend.firstWord = divisor;
}

void SDLBackend_SetPCSpeakerSampleRate(uint16 sampleRateHz)
{
    fakeBackend.firstWord = sampleRateHz;
}

void SDLBackend_BeginPCSpeakerTimedOutput(word16 delayScale)
{
    fakeBackend.firstWord = delayScale;
    fakeBackend.secondWord = 0x0000;
}

void SDLBackend_WritePCSpeakerBitstream(
    const byte *sampleData,
    word16 byteCount)
{
    fakeBackend.buffer = (void *)sampleData;
    fakeBackend.secondWord = (word16)(fakeBackend.secondWord + byteCount);
}

word16 SDLBackend_EndPCSpeakerTimedOutput(void)
{
    return (word16)((uint32)fakeBackend.firstWord
        * fakeBackend.secondWord * 0x08);
}

void SDLBackend_PlayUnsigned8PCM(
    const byte *sampleData,
    uint16 byteCount,
    uint16 sourceRateHz,
    uint16 playbackScale,
    uint16 repeatCount)
{
    ++fakeBackend.pcmPlayCount;
    fakeBackend.pcmSampleData = sampleData;
    fakeBackend.pcmByteCount = byteCount;
    fakeBackend.pcmSourceRateHz = sourceRateHz;
    fakeBackend.pcmPlaybackScale = playbackScale;
    fakeBackend.pcmRepeatCount = repeatCount;
}

void SDLBackend_WaitForUnsigned8PCM(void)
{
    ++fakeBackend.pcmWaitCount;
}

void SDLBackend_WriteMIDIByte(byte midiByte)
{
    fakeBackend.midiBytes[fakeBackend.midiByteCount++] = midiByte;
}

void SDLBackend_StartMusicVoice(
	word16 voiceId,
	byte note,
	byte velocity,
	byte program,
	byte voiceClass)
{
	fakeBackend.musicVoiceId = voiceId;
	fakeBackend.musicNote = note;
	fakeBackend.musicVelocity = velocity;
	fakeBackend.musicProgram = program;
	fakeBackend.musicVoiceClass = voiceClass;
	++fakeBackend.musicVoiceStartCount;
}

void SDLBackend_StopMusicVoice(word16 voiceId)
{
	fakeBackend.musicVoiceId = voiceId;
	++fakeBackend.musicVoiceStopCount;
}

void SDLBackend_ResetMusicVoices(void)
{
	++fakeBackend.musicVoiceResetCount;
}

word16 SDLBackend_ProbeLegacyAudioDevice(byte deviceId)
{
	(void) deviceId;
	return TRUE;
}

byte SDLBackend_ReadLegacyAudioPort(word16 port)
{
	fakeBackend.firstWord = port;
	return fakeBackend.firstByte;
}

void SDLBackend_WriteLegacyAudioPort(word16 port, byte value)
{
	fakeBackend.firstWord = port;
	fakeBackend.firstByte = value;
}

void SDLBackend_SetDigitalOutputRate(word16 sampleRateHz)
{
	fakeBackend.firstWord = sampleRateHz;
}

void SDLBackend_WriteUnsigned8Sample(byte sample)
{
	fakeBackend.firstByte = sample;
}

void SDLBackend_ServiceTimers(void)
{
}
