// Reconstructed dynamic interrupt register-block wrappers (segment 39E5).

#include "REVENGE.h"
#include "revenge/interrupts.h"
#include "revenge/platform_backend.h"

// 39E5:000F
void InvokeInterruptWithRegisterBlocks(
	word16 interruptNumber,
	InterruptRegisterBlock *inputRegisters,
	InterruptRegisterBlock *outputRegisters)
{
	InterruptSegmentState segmentState;

	CaptureInterruptSegmentState(&segmentState);
	InvokeInterruptThunk(interruptNumber,
		inputRegisters, outputRegisters, &segmentState);
}

// 39E5:0043
void InvokeInterruptThunk(
	word16 interruptNumber,
	InterruptRegisterBlock *inputRegisters,
	InterruptRegisterBlock *outputRegisters,
	InterruptSegmentState *segmentState)
{
	SDLBackend_InvokeInterrupt((byte) interruptNumber,
		inputRegisters, outputRegisters, segmentState);
	if (outputRegisters->carry != FALSE)
		(void) TranslateDOSError((int16) outputRegisters->ax);
}
