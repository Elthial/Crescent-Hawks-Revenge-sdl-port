#include "REVENGE.h"
#include "revenge/digital_bridge.h"
#include "fake_backend.h"

#include <assert.h>

int main(void)
{
	DigitalHardwareDescriptor *hardware;
	DigitalPlaybackDescriptor *playback;
	const word16 *probePorts;

	assert(sizeof(DigitalHardwareDescriptor) == 0x10);
	assert(sizeof(DigitalPlaybackDescriptor) == 0x0C);
	assert(sizeof(DigitalPlaybackRuntimeState) == 0x011A);
	assert(sizeof(DigitalPlaybackWorkingSet) == 0x58);
	assert(DigitalPlaybackRuntime.InterruptNestingGuard ==
		0xFFFF);
	assert(DigitalPlaybackRuntime.RequestedMixScale ==
		0x0100);
	assert((byte *) &DigitalPlaybackBuffers.CalibrationQueue -
		(byte *) &DigitalPlaybackBuffers == 0x12);
	assert((byte *) &DigitalPlaybackBuffers.CalibrationSample -
		(byte *) &DigitalPlaybackBuffers == 0x24);

	hardware = DigitalBridge_ResolveHardwareDescriptor(0x6DC2);
	assert(hardware == &SoundBlasterHardware);
	assert(hardware->DefaultProbeParameter == 0x0220);
	assert(hardware->ProbeCandidateCount == 0x0006);
	assert(hardware->ProbeCandidateListOffset == 0x6DD2);
	assert(hardware->ProbeCallbackOffset == 0x011B);
	assert(hardware->AcquireCallbackOffset == 0x0143);
	assert(hardware->ReleaseCallbackOffset == 0x014F);

	probePorts = DigitalBridge_ResolveProbeCandidateList(0x6DD2);
	assert(probePorts == SoundBlasterProbePorts);
	assert(probePorts[0x00] == 0x0210);
	assert(probePorts[0x05] == 0x0260);

	playback = DigitalBridge_ResolvePlaybackDescriptor(0x6EE2);
	assert(playback == &SoundBlasterPlayback);
	assert(playback->HardwareDescriptorOffset == 0x6DC2);
	assert(playback->AcquireCallbackOffset == 0x032C);
	assert(playback->ReleaseCallbackOffset == 0x032D);
	assert(playback->WriteSampleCallbackOffset == 0x032E);
	assert(playback->MixScale == 0x0070);

	assert(DigitalBridge_ResolveHardwareDescriptor(0xFFFF) == NULL);
	assert(DigitalBridge_ResolvePlaybackDescriptor(0xFFFF) == NULL);

	FakeBackend_Reset();
	InitializeDigitalDriverQueue(
		&DigitalPlaybackBuffers.PlaybackTimerQueue);
	InstallDigitalDriverQueueCallback(&NullDigitalPlayback,
		&DigitalPlaybackBuffers.PlaybackTimerQueue);
	DigitalPlaybackRuntime.SavedSystemTimerVector =
		DosAddress_FromValue(0xF000FFF0UL);
	DigitalPlaybackRuntime.SystemTimerDivisor = 0x1234;
	DigitalPlaybackRuntime.SystemTimerAccumulator = 0x0200;
	DigitalPlaybackRuntime.InterruptNestingGuard = 0xFFFF;
	DigitalPlaybackRuntime.DigitalTimerReloadMinusOne = 0x000F;
	ServiceDigitalPlaybackInterrupt();
	assert(fakeBackend.acknowledgedInterrupt == 0x08);
	assert(DigitalPlaybackRuntime.SystemTimerAccumulator ==
		0x01F0);
	assert(DigitalPlaybackRuntime.InterruptNestingGuard ==
		0xFFFF);
	assert(fakeBackend.chainedInterruptVector == 0x00000000UL);

	DigitalPlaybackRuntime.SystemTimerAccumulator = 0x0005;
	ServiceDigitalPlaybackInterrupt();
	assert(DigitalPlaybackRuntime.SystemTimerAccumulator ==
		0x1229);
	assert(fakeBackend.chainedInterruptVector == 0xF000FFF0UL);
	return 0x00;
}
