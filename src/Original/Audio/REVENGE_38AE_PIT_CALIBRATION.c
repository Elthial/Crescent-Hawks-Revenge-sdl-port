// Reconstructed original PIT calibration and interrupt utilities (segment 38AE).

#include "REVENGE.h"
#include "revenge/interrupts.h"
#include "revenge/original_data.h"
#include "revenge/platform_backend.h"

#define PIT_MODE_RATE_GENERATOR 0x34

void PITCalibrationIRQ0Handler(void);

// 38AE:0010: reconstructed C signature follows.
// Called from:
//      InstallDigitalPlaybackTimer
//      RestoreDigitalPlaybackTimer
//      BeginPITCalibration
//      EndPITCalibration
uint32 SwapInterruptVector(uint32 newVector, word16 interruptNumber)
{
	// The assembly exchanges the two words of the IVT entry atomically under
	// CLI/PUSHF/POPF. The host boundary retains the same 16:16 token exchange.
	return SDLBackend_SwapInterruptVector((byte)interruptNumber, newVector);
}

// 38AE:002A: Register word16 SetPITChannel0Divisor(Register word16 ax)
// Called from:
//      ProgramDigitalPlaybackTimerRate
//      RestoreDigitalPlaybackTimer
//      EndPITCalibration
word16 SetPITChannel0Divisor(word16 divisor)
{
	word16 previousDivisor;

	// OUT 43h,36h followed by the low and high divisor bytes is confined to
	// the host boundary; the original XCHG with DS:6FA4 remains here.
	SDLBackend_ProgramPITChannel0(divisor);
	previousDivisor = PITCalibration.Channel0Divisor;
	PITCalibration.Channel0Divisor = divisor;
	return previousDivisor;
}

// 38AE:0046: Register uint16 PITFrequencyToDivisor(Register uint16 frequencyHz)
// Called from:
//      ProgramDigitalPlaybackTimerRate
uint16 PITFrequencyToDivisor(uint16 frequencyHz)
{
	if (frequencyHz <= 0x12)
		return 0x00;
	return (uint16) (0x1234DEUL / frequencyHz);
}

word16 CalibrationIRQCount = 0x0000; // 38AE:005A
// 38AE:005C: void BeginPITCalibration()
// Called from:
//      CalibrateDigitalPlaybackRate
void BeginPITCalibration(void)
{
	uint32 savedIrq0Vector;

	// Temporarily hook IRQ0 and run PIT channel 0 at its full 16-bit period.
	PITCalibration.SavedInterruptFlags =
		SDLBackend_SaveAndDisableInterrupts();
	savedIrq0Vector = SwapInterruptVector(
		MAKE_FAR_POINTER(0x38AE, 0x00D7), INTERRUPT_SYSTEM_TIMER_IRQ);
	PITCalibration.SavedIRQ0Vector =
		DosAddress_FromValue(savedIrq0Vector);
	CalibrationIRQCount = 0x0000;
	SDLBackend_ProgramPITChannel0Mode(PIT_MODE_RATE_GENERATOR, 0x0000);
	EnableHardwareInterrupts();
	while (CalibrationIRQCount == 0x0000)
	{
		SDLBackend_WaitPITChannel0Interrupt();
		PITCalibrationIRQ0Handler();
	}
	CalibrationIRQCount = 0x0000;
	while (CalibrationIRQCount == 0x0000)
	{
		SDLBackend_WaitPITChannel0Interrupt();
		PITCalibrationIRQ0Handler();
	}
}

// 38AE:009B: uint32 EndPITCalibration(void), returned in DX:AX
// Called from:
//      CalibrateDigitalPlaybackRate
uint32 EndPITCalibration(void)
{
	uint32 elapsedCount;

	// Latch the current count, restore IRQ0 and the previous PIT divisor, and
	// return the elapsed 32-bit count as DX:AX.
	DisableHardwareInterrupts();
	PITCalibration.LatchedChannel0Count =
		SDLBackend_LatchPITChannel0Count();
	SwapInterruptVector(
		DosAddress_ToValue(PITCalibration.SavedIRQ0Vector),
		INTERRUPT_SYSTEM_TIMER_IRQ);
	SetPITChannel0Divisor(PITCalibration.Channel0Divisor);
	elapsedCount = MAKE_DWORD(CalibrationIRQCount, 0x0000) -
		(uint32) PITCalibration.LatchedChannel0Count;
	SDLBackend_RestoreInterruptFlags(
		PITCalibration.SavedInterruptFlags);
	return elapsedCount;
}

// 38AE:00D7: temporary IRQ0 handler used only during playback-rate
// calibration. Count the wrap, acknowledge the master PIC, and IRET.
void PITCalibrationIRQ0Handler(void)
{
	++CalibrationIRQCount;
	SDLBackend_AcknowledgeInterrupt(INTERRUPT_SYSTEM_TIMER_IRQ);
}

// 38AE:00F6: uint32 DivideUnsigned32By32(uint32 dividend, uint32 divisor)
// Called from:
//      CalibrateDigitalPlaybackRate
uint32 DivideUnsigned32By32(uint32 dividend, uint32 divisor)
{
	// Unsigned 32-bit division helper. Inputs are dividend DX:AX and divisor
	// CX:BX; the quotient is returned in DX:AX.
	if (dividend == 0x00000000 ||
		divisor == 0x00000000 ||
		divisor > dividend)
		return 0x00000000;
	return dividend / divisor;
}

