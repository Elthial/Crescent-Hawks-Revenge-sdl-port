#include "fake_backend.h"
#include "REVENGE.h"
#include "revenge/interrupts.h"
#include "revenge/original_data.h"
#include "revenge/platform_backend.h"
#include "revenge/video.h"

#include <assert.h>

extern word16 CalibrationIRQCount;

static void TestInterruptVectorExchange(void)
{
	uint32 oldVector;

	fakeBackend.interruptVectors[INTERRUPT_SYSTEM_TIMER_IRQ] = 0x12345678U;
	oldVector = SwapInterruptVector(
		0x38AE00D7U, INTERRUPT_SYSTEM_TIMER_IRQ);
	assert(oldVector == 0x12345678U);
	assert(fakeBackend.interruptVectors[INTERRUPT_SYSTEM_TIMER_IRQ] ==
		0x38AE00D7U);
}

static void TestPITDivisorExchange(void)
{
	word16 oldDivisor;

	PITCalibration.Channel0Divisor = 0x1234;
	oldDivisor = SetPITChannel0Divisor(0x5678);
	assert(oldDivisor == 0x1234);
	assert(PITCalibration.Channel0Divisor == 0x5678);
	assert(fakeBackend.pitChannel0Divisor == 0x5678);
}

static void TestPITMath(void)
{
	assert(PITFrequencyToDivisor(0x0012) == 0x0000);
	assert(PITFrequencyToDivisor(0x0013) ==
		(word16)(0x001234DEUL / 0x0013));
	assert(PITFrequencyToDivisor(0x4440) ==
		(word16)(0x001234DEUL / 0x4440));

	assert(DivideUnsigned32By32(0x00000000U, 0x00000001U) ==
		0x00000000U);
	assert(DivideUnsigned32By32(0x00000001U, 0x00000000U) ==
		0x00000000U);
	assert(DivideUnsigned32By32(0x00000001U, 0x00000002U) ==
		0x00000000U);
	assert(DivideUnsigned32By32(0xFEDCBA98U, 0x00001234U) ==
		0xFEDCBA98U / 0x00001234U);
}

static void TestCalibrationIRQ(void)
{
	CalibrationIRQCount = 0xFFFF;
	PITCalibrationIRQ0Handler();
	assert(CalibrationIRQCount == 0x0000);
	assert(fakeBackend.acknowledgedInterrupt == INTERRUPT_SYSTEM_TIMER_IRQ);
}

static void TestVideoTimingCalibration(void)
{
	fakeBackend.biosTickCount = 0x00000100U;
	fakeBackend.biosTickStep = 0x00000001U;
	VerticalRetraceEdgeMode = VERTICAL_RETRACE_WAIT_FOR_END;
	BusyWaitLoopCalibration = -0x01;

	CalibrateVideoTiming();

	assert(BusyWaitLoopCalibration == 0x0000);
	assert(VerticalRetraceEdgeMode ==
		VERTICAL_RETRACE_WAIT_FOR_START);
}

int main(void)
{
	FakeBackend_Reset();
	TestInterruptVectorExchange();
	TestPITDivisorExchange();
	TestPITMath();
	TestCalibrationIRQ();
	TestVideoTimingCalibration();
	return 0;
}
