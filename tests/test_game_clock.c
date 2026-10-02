#include "REVENGE.h"
#include "fake_backend.h"
#include "revenge/original_data.h"

#include <assert.h>

static word16 chainedClockTicks;

static void PreviousClockHandler(void)
{
	++chainedClockTicks;
}

int main(void)
{
	FakeBackend_Reset();
	fakeBackend.interruptVectors[0x1C] = 0xF0000100UL;
	fakeBackend.interruptHandler = PreviousClockHandler;
	InstallGameClockTimer();
	assert(SavedGameClockVector == 0xF0000100UL);
	assert(fakeBackend.interruptVectors[0x1C] == 0x08002440UL);
	assert(fakeBackend.interruptHandler == GameClockInt1CHandler);

	TacticalUpdateDelayTicks = 0x0002;
	TacticalKeyRepeatDelayTicks = 0x0001;
	GameTimerTicks = 0x0000FFFFUL;
	GameAnimationTicks = 0x0001FFFFUL;
	fakeBackend.interruptHandler();
	assert(TacticalUpdateDelayTicks == 0x0001);
	assert(TacticalKeyRepeatDelayTicks == 0x0000);
	assert(GameTimerTicks == 0x00010000UL);
	assert(GameAnimationTicks == 0x00020000UL);
	assert(chainedClockTicks == 0x0001);

	RestoreGameClockTimer();
	assert(fakeBackend.interruptVectors[0x1C] == 0xF0000100UL);
	assert(fakeBackend.interruptHandler == PreviousClockHandler);
	return 0x00;
}
