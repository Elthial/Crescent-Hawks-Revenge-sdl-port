#ifndef REVENGE_PLATFORM_BACKEND_H
#define REVENGE_PLATFORM_BACKEND_H

#include "revenge/dos.h"
#include "revenge/input.h"
#include "revenge/interrupts.h"

/*
 * Portable declarations for the DOS, BIOS, and direct-hardware boundary.
 * Implementations may use SDL3, but SDL types and game-level services do not
 * cross this interface into the preserved Original source.
 */
uint16 SDLBackend_DirectConsoleIO(byte character);
void SDLBackend_SelectDefaultDrive(byte zeroBasedDrive);

int16 SDLBackend_CreateFile(uint16 attributes, const char *filePath);
int16 SDLBackend_OpenFile(const char *filePath, uint16 openFlags);
int16 SDLBackend_CloseFile(int16 fileHandle);
int16 SDLBackend_ReadFile(
	uint16 fileHandle, void *destinationBuffer, uint16 byteCount);
int16 SDLBackend_WriteFile(
	uint16 fileHandle, const void *sourceBuffer, uint16 byteCount);
long SDLBackend_SeekFile(uint16 fileHandle, long fileOffset, byte origin);
int16 SDLBackend_DeleteFile(const char *filePath);
int16 SDLBackend_GetSetFileAttributes(
	const char *filePath, byte operation, uint16 attributes);
int16 SDLBackend_DeviceIOControl(
	uint16 fileHandle, uint16 operation, void *data, uint16 count);

word16 SDLBackend_ResizeMemoryBlock(
	word16 memorySegment, word16 paragraphCount);
word16 SDLBackend_GetLargestFreeConventionalMemoryParagraphs(
	word16 requestedParagraphs);
void SDLBackend_InitializeDOSMemoryArena(void);
void SDLBackend_GetSystemDate(DOS_Date *date);
void SDLBackend_GetSystemTime(DOS_Time *time);
const char *SDLBackend_GetEnvironmentVariable(const char *name);
void SDLBackend_InvokeInterrupt(
	byte interruptNumber,
	const InterruptRegisterBlock *inputRegisters,
	InterruptRegisterBlock *outputRegisters,
	InterruptSegmentState *segmentState);
void SDLBackend_SetInterruptVector(
	byte interruptNumber, DOS_InterruptHandler handler);
DOS_InterruptHandler SDLBackend_SwapInterruptHandler(
	byte interruptNumber, DOS_InterruptHandler handler);
uint32 SDLBackend_SwapInterruptVector(
	byte interruptNumber, uint32 newVector);
void SDLBackend_ChainInterruptVector(uint32 interruptVector);
void SDLBackend_DispatchInstalledInterruptVector(byte interruptNumber);
void SDLBackend_ProgramPITChannel0(word16 divisor);
void SDLBackend_ProgramPITChannel0Mode(byte mode, word16 divisor);
word16 SDLBackend_LatchPITChannel0Count(void);
void SDLBackend_WaitPITChannel0Interrupt(void);
word16 SDLBackend_SaveAndDisableInterrupts(void);
void SDLBackend_RestoreInterruptFlags(word16 flags);
void SDLBackend_AcknowledgeInterrupt(byte interruptNumber);
uint32 SDLBackend_GetBIOSTickCount(void);
_Noreturn void SDLBackend_TerminateProcess(byte exitCode);

int SDLBackend_Open(void);
void SDLBackend_Close(void);
int SDLBackend_PollQuit(void);
uint64_t SDLBackend_Milliseconds(void);
void SDLBackend_Delay(uint32_t milliseconds);

byte SDLBackend_GetVideoMode(void);
void SDLBackend_SetVideoMode(byte videoMode);
void SDLBackend_SetVideoAdapter(uint16 adapterType);
void SDLBackend_SelectCgaPalette(byte paletteId);
void SDLBackend_SetPaletteRegister(
	byte paletteRegister, byte paletteValue);
void SDLBackend_SetEgaGraphicsControllerRegister(
	byte registerIndex, byte value);
void SDLBackend_SetEgaSequencerRegister(
	byte registerIndex, byte value);
void SDLBackend_LoadVgaPalette(const byte *paletteRgbTriplets);
uint16 SDLBackend_IsVerticalRetraceActive(void);
void SDLBackend_WaitVerticalRetrace(byte waitForRetraceStart);
byte *SDLBackend_GetIndexedFramebuffer(void);
void SDLBackend_ClearIndexedFramebuffer(byte color);
void SDLBackend_DrawIndexedPixel(uint16 x, uint16 y, byte color);
int SDLBackend_PresentIndexedFramebuffer(void);

word16 SDLBackend_InputPending(void);
uint16 SDLBackend_ReadRawKeypress(void);
void SDLBackend_InstallKeyboardHandlers(void);
void SDLBackend_RestoreKeyboardHandlers(void);
void SDLBackend_SetMouseVisible(uint16 visible);
void SDLBackend_SetMousePosition(int16 logicalX, int16 logicalY);

int SDLBackend_OpenAudio(void);
void SDLBackend_CloseAudio(void);
byte SDLBackend_EnablePCSpeaker(void);
void SDLBackend_SilencePCSpeaker(void);
void SDLBackend_WritePCSpeakerPITDivisor(uint16 divisor);
void SDLBackend_SetPCSpeakerSampleRate(uint16 sampleRateHz);
void SDLBackend_BeginPCSpeakerTimedOutput(word16 delayScale);
void SDLBackend_WritePCSpeakerBitstream(
	const byte *sampleData,
	word16 byteCount);
word16 SDLBackend_EndPCSpeakerTimedOutput(void);
void SDLBackend_PlayUnsigned8PCM(
	const byte *sampleData,
	uint16 byteCount,
	uint16 sourceRateHz,
	uint16 playbackScale,
	uint16 repeatCount);
void SDLBackend_WaitForUnsigned8PCM(void);
void SDLBackend_WriteMIDIByte(byte midiByte);
void SDLBackend_StartMusicVoice(
	word16 voiceId,
	byte note,
	byte velocity,
	byte program,
	byte voiceClass);
void SDLBackend_StopMusicVoice(word16 voiceId);
void SDLBackend_ResetMusicVoices(void);
/*
 * Deliver every PIT/BIOS interrupt whose host-time deadline has elapsed.
 * DOS hardware interrupted otherwise empty busy-waits asynchronously; the
 * single-threaded hosted build calls this pump cooperatively at those waits
 * and at existing platform boundaries.
 */
void SDLBackend_ServiceTimers(void);
void SDLBackend_DispatchInterrupt(byte interruptNumber);
word16 SDLBackend_ProbeLegacyAudioDevice(byte deviceId);
byte SDLBackend_ReadLegacyAudioPort(word16 port);
void SDLBackend_WriteLegacyAudioPort(word16 port, byte value);
void SDLBackend_SetDigitalOutputRate(word16 sampleRateHz);
void SDLBackend_WriteUnsigned8Sample(byte sample);

#endif
