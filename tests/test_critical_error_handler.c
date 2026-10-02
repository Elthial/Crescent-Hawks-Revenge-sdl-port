#include "fake_backend.h"
#include "REVENGE.h"
#include "revenge/interrupts.h"
#include "revenge/original_data.h"

#include <assert.h>
#include <stdint.h>

int main(void)
{
	void *callback;

	FakeBackend_Reset();
	callback = (void *)(uintptr_t)0x12345678U;
	InstallCriticalErrorHandler(callback);
	assert(CriticalErrorCallback.offset == 0x5678);
	assert(CriticalErrorCallback.segment == 0x1234);
	assert(fakeBackend.firstByte == INTERRUPT_DOS_CRITICAL_ERROR);
	assert((uintptr_t)fakeBackend.interruptHandler == 0x34A70021U);

	InstallDefaultCriticalErrorHandler();
	assert(CriticalErrorCallback.offset == 0x0006);
	assert(CriticalErrorCallback.segment == 0x34A7);
	assert(fakeBackend.firstByte == INTERRUPT_DOS_CRITICAL_ERROR);
	assert((uintptr_t)fakeBackend.interruptHandler == 0x34A70021U);
	return 0;
}
