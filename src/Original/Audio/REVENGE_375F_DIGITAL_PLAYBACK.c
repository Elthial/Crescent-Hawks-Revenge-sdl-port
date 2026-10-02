/* REVENGE_375F_AUDIO_HARDWARE.c -- digital-output drivers and software mixer. */

#include "REVENGE.h"
#include "revenge/digital_bridge.h"
#include "revenge/platform_backend.h"

#include <stdbool.h>

/* Digital descriptor queues, timer service, and software mixer. */

#define INTERRUPT_SYSTEM_TIMER_IRQ 0x08
#define ResolveDigitalHardwareDescriptor \
	DigitalBridge_ResolveHardwareDescriptor
#define ResolveDigitalPlaybackDescriptor \
	DigitalBridge_ResolvePlaybackDescriptor
#define ResolveProbeCandidateList DigitalBridge_ResolveProbeCandidateList
#define DispatchDigitalHardwareProbe DigitalBridge_DispatchHardwareProbe
#define DispatchDigitalHardwareAcquire DigitalBridge_DispatchHardwareAcquire
#define DispatchDigitalHardwareRelease DigitalBridge_DispatchHardwareRelease

void WriteNullDigitalSample(byte sample);
void WriteTandy3VoiceDigitalSample(byte sample);
void WriteTandyDACDigitalSample(byte sample);
void WriteIBMPS1DigitalSample(byte sample);
void WriteSoundBlasterDigitalSample(byte sample);
void WriteAdLibDigitalSample(byte sample);
void WriteCMSDigitalSample(byte sample);
void WriteInnovationDigitalSample(byte sample);
void WriteCovoxDigitalSample(byte sample);

DigitalPlaybackWorkingSet DigitalPlaybackBuffers;
static const word16 DigitalMixBiasOffsets[0x04] =
{
	0x0AF2, 0x0BF2, 0x0DF2, 0x10F2
};

void InitializeDigitalDriverQueueCore(DigitalDriverQueue *queue);
void InstallDigitalDriverQueueCallback(
	DigitalPlaybackDescriptor *playbackDescriptor,
	DigitalDriverQueue *queue);
void InitializeDigitalSampleDescriptorCore(
	DigitalSampleDescriptor *descriptor,
	word16 sampleLength,
	word16 playbackScale,
	word16 sourceRateHz,
	word16 sampleOffset,
	word16 sampleSegment);
void CalculateDigitalSampleStep(
	DigitalSampleDescriptor *descriptor,
	word16 playbackScale);
word16 SetDigitalSampleLoopRange(
	DigitalSampleDescriptor *descriptor,
	word16 loopStart,
	word16 loopEnd);
void SetDigitalSampleCompletionCallback(
	DigitalSampleDescriptor *descriptor,
	word16 argumentLow,
	word16 argumentHigh,
	word16 callbackOffset,
	word16 callbackSegment);
void LinkDigitalSampleDescriptor(
	DigitalDriverQueue *queue,
	DigitalSampleDescriptor *descriptor);
void UnlinkDigitalSampleDescriptor(
	DigitalSampleDescriptor *descriptor);
void ResetDigitalSamplePlayback(
	DigitalSampleDescriptor *descriptor);
void FinishDigitalSampleLoopCore(
	DigitalSampleDescriptor *descriptor);
void StopDigitalSamplePlaybackCore(
	DigitalSampleDescriptor *descriptor);
word16 ReadDigitalSamplePlaybackState(
	DigitalSampleDescriptor *descriptor);
uint32 ApplyDigitalMixScale(uint16 timingScale);
uint32 RebuildDigitalMixLookup(int16 mixScale);
void ServiceDigitalAudioTick(void);
word16 ProgramDigitalPlaybackTimerRate(uint16 playbackRateHz);
void BeginPITCalibration(void);
uint32 EndPITCalibration(void);
void HandleDigitalWeaponEffectCompletion(
	word16 descriptorOffset,
	word16 descriptorSegment);
// 375F:05D6: uint32 CalibrateDigitalPlaybackRate; result is DX:AX
// Called from:
//      InitializeDigitalSoundDriver
uint32 CalibrateDigitalPlaybackRate(word16 playbackScale, word16 sourceRateHz,
	word16 driverDescriptorOffset)
{
	DigitalPlaybackDescriptor *driver;

	DisableHardwareInterrupts();
	InitializeDigitalSampleDescriptorCore(
		&DigitalPlaybackBuffers.CalibrationSample, 0x0E0D,
		playbackScale, sourceRateHz, 0x0000, 0x375F);
	ResetDigitalSamplePlayback(
		&DigitalPlaybackBuffers.CalibrationSample);
	InitializeDigitalDriverQueueCore(
		&DigitalPlaybackBuffers.CalibrationQueue);
	LinkDigitalSampleDescriptor(
		&DigitalPlaybackBuffers.CalibrationQueue,
		&DigitalPlaybackBuffers.CalibrationSample);
	driver = ResolveDigitalPlaybackDescriptor(driverDescriptorOffset);
	InstallDigitalDriverQueueCallback(
		driver, &DigitalPlaybackBuffers.CalibrationQueue);
	BeginPITCalibration();
	{
		word16 serviceTicksRemaining;
		for (serviceTicksRemaining = 0x0E0D;
		serviceTicksRemaining != 0x0000; --serviceTicksRemaining)
			ServiceDigitalAudioTick();
	}

	return DivideUnsigned32By32(0xFFD0CE97UL,
		EndPITCalibration());
}

// 375F:063B: void InstallDigitalPlaybackTimer(Stack uint16 wArg04)
// Called from:
//      PlayScenarioDigitalSoundSequence
void InstallDigitalPlaybackTimer(uint16 playbackRateHz)
{
	InitializeDigitalDriverQueueCore(
		&DigitalPlaybackBuffers.PlaybackTimerQueue);
	InstallDigitalDriverQueueCallback(
		ResolveDigitalPlaybackDescriptor(DIGITAL_DESCRIPTOR_NULL),
		&DigitalPlaybackBuffers.PlaybackTimerQueue);
	DisableHardwareInterrupts();
	uint32 savedIrq0Vector = SwapInterruptVector(
		MAKE_FAR_POINTER(0x375F, 0x0A1D), INTERRUPT_SYSTEM_TIMER_IRQ);
	DigitalPlaybackRuntime.SavedSystemTimerVector =
		DosAddress_FromValue(savedIrq0Vector);
	word16 systemTimerDivisor = ProgramDigitalPlaybackTimerRate(playbackRateHz);
	DigitalPlaybackRuntime.SystemTimerDivisor = systemTimerDivisor;
	DigitalPlaybackRuntime.SystemTimerAccumulator = systemTimerDivisor - 0x01;
}

// 375F:0689: Register word16 ProgramDigitalPlaybackTimerRate(Register uint16 ax)
// Called from:
//      InstallDigitalPlaybackTimer
word16 ProgramDigitalPlaybackTimerRate(uint16 playbackRateHz)
{
	word16 pitDivisor = PITFrequencyToDivisor(playbackRateHz);
	DigitalPlaybackRuntime.PlaybackRateHz =
		PITFrequencyToDivisor(pitDivisor);
	DigitalPlaybackRuntime.DigitalTimerReloadMinusOne =
		pitDivisor - 0x01;
	return SetPITChannel0Divisor(pitDivisor);
}

// 375F:06A9: void RestoreDigitalPlaybackTimer()
// Called from:
//      PlayScenarioDigitalSoundSequence
void RestoreDigitalPlaybackTimer(void)
{
	DisableHardwareInterrupts();
	SwapInterruptVector(
		DosAddress_ToValue(
			DigitalPlaybackRuntime.SavedSystemTimerVector),
		INTERRUPT_SYSTEM_TIMER_IRQ);
	SetPITChannel0Divisor(
		DigitalPlaybackRuntime.SystemTimerDivisor);
}

// 375F:06C7: reconstructed C signature follows.
// Called from:
//      InitializeDigitalSoundDriver
void InitializeDigitalDriverQueue(DigitalDriverQueue *queue)
{
	InitializeDigitalDriverQueueCore(queue);
}

// 375F:06D5: reconstructed C signature follows.
// Called from:
//      CalibrateDigitalPlaybackRate
//      InstallDigitalPlaybackTimer
//      InitializeDigitalDriverQueue
void InitializeDigitalDriverQueueCore(DigitalDriverQueue *queue)
{
	uint32 queueAddress;
	word16 queueOffset;
	word16 queueSegment;

	queueAddress = HostFarPointer_Register(queue, sizeof(*queue));
	queueOffset = LOW_WORD(queueAddress);
	queueSegment = HIGH_WORD(queueAddress);
	queue->FirstDescriptorOffset = queueOffset + 0x04;
	queue->FirstDescriptorSegment = queueSegment;
	queue->SentinelNextOffset = 0x00;
	queue->SentinelNextSegment = 0x00;
	queue->SentinelOwnerOffset = queueOffset;
	queue->SentinelOwnerSegment = queueSegment;
	queue->ActiveDescriptorCount = 0x00;
}

// 375F:06FA: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void AttachDigitalDriverQueue(word16 driverDescriptorOffset,
	DigitalDriverQueue *queue)
{
	InstallDigitalDriverQueueCallback(
		ResolveDigitalPlaybackDescriptor(driverDescriptorOffset), queue);
}

// 375F:070C: reconstructed C signature follows.
// Called from:
//      CalibrateDigitalPlaybackRate
//      InstallDigitalPlaybackTimer
//      AttachDigitalDriverQueue
void InstallDigitalDriverQueueCallback(
	DigitalPlaybackDescriptor *playbackDescriptor,
	DigitalDriverQueue *queue)
{
	uint32 queueAddress;

	DisableHardwareInterrupts();
	queueAddress = HostFarPointer_Register(queue, sizeof(*queue));
	DigitalPlaybackRuntime.WriteSampleCallbackOffset =
		playbackDescriptor->WriteSampleCallbackOffset;
	DigitalPlaybackRuntime.ActiveDriverQueue =
		DosAddress_FromValue(queueAddress);
	DigitalPlaybackRuntime.DriverMixScale =
		playbackDescriptor->MixScale;
	ApplyDigitalMixScale(
		DigitalPlaybackRuntime.RequestedMixScale);
}

// 375F:0735: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void InitializeDigitalSampleDescriptor(DigitalSampleDescriptor *descriptor,
	segptr32 sampleData,
	word16 sampleLength, word16 playbackRateHz, word16 formatScale)
{
	InitializeDigitalSampleDescriptorCore(descriptor, sampleLength, formatScale, playbackRateHz,
		LOW_WORD(sampleData), HIGH_WORD(sampleData));
}

// 375F:0757: reconstructed C signature follows.
// Called from:
//      CalibrateDigitalPlaybackRate
//      InitializeDigitalSampleDescriptor
void InitializeDigitalSampleDescriptorCore(
	DigitalSampleDescriptor *descriptor,
	word16 sampleLength, word16 playbackScale, word16 sourceRateHz,
	word16 sampleOffset, word16 sampleSegment)
{
	HostFarPointer_Register(descriptor, sizeof(*descriptor));
	descriptor->SampleDataOffset = sampleOffset;
	descriptor->SampleDataSegment = sampleSegment;
	descriptor->SampleLength = sampleLength;
	descriptor->SourceRateHz = sourceRateHz;
	descriptor->PlaybackScale = playbackScale;
	descriptor->OwnerQueueOffset = 0x00;
	descriptor->OwnerQueueSegment = 0x00;
	descriptor->SourceStepWhole = 0x01;
	descriptor->SourceStepFraction = 0x00;
	SetDigitalSampleCompletionCallback(descriptor, 0x00,
		SetDigitalSampleLoopRange(descriptor, 0x00, 0x00), 0x00, 0x00);
	descriptor->PlaybackHandlerOffset = DIGITAL_SAMPLE_HANDLER_IDLE;
}

// 375F:078E: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void ConfigureDigitalSampleTiming(DigitalSampleDescriptor *descriptor,
	word16 formatScale)
{
	CalculateDigitalSampleStep(descriptor, formatScale);
}

// 375F:07A2: reconstructed C signature follows.
// Called from:
//      ConfigureDigitalSampleTiming
void CalculateDigitalSampleStep(DigitalSampleDescriptor *descriptor,
	word16 playbackScale)
{
	uint16 timerScale = DigitalPlaybackRuntime.PlaybackRateHz;
	uint32 sourceRate = descriptor->SourceRateHz;
	uint16 descriptorScale = descriptor->PlaybackScale;
	uint32 sourceRemainder = sourceRate % timerScale;
	uint32 scaleRemainder = playbackScale % descriptorScale;
	uint16 sourceFraction = (uint16) ((sourceRemainder << 0x10) / timerScale);
	uint16 scaleFraction = (uint16) ((scaleRemainder << 0x10) / descriptorScale);
	uint16 sourceWhole = (uint16) (sourceRate / timerScale);
	uint16 scaleWhole = playbackScale / descriptorScale;

	// Multiply the two unsigned 16.16 ratios exactly as the four 16-bit MULs
	// at 375F:07C9..07DE. Keeping the partial products explicit avoids a
	// fictitious 64-bit type in this 16-bit DOS source model.
	uint32 wholeProduct = (uint32) sourceWhole * scaleWhole;
	uint32 crossProducts = (uint32) sourceWhole * scaleFraction +
		(uint32) scaleWhole * sourceFraction;
	uint32 fractionalProduct = (uint32) sourceFraction * scaleFraction;
	uint32 fixedPointStep = (wholeProduct << 0x10) + crossProducts +
		(fractionalProduct >> 0x10);
	DisableHardwareInterrupts();
	descriptor->SourceStepWhole = HIGH_WORD(fixedPointStep);
	descriptor->SourceStepFraction = LOW_WORD(fixedPointStep);
}

// 375F:07ED: stack-argument wrapper around the register-call loop-range core.
void ConfigureDigitalSampleLoop(DigitalSampleDescriptor *descriptor,
	word16 loopStart, word16 loopEnd)
{
	SetDigitalSampleLoopRange(descriptor, loopStart, loopEnd);
}

// 375F:0805: reconstructed C signature follows.
// Called from:
//      InitializeDigitalSampleDescriptorCore
word16 SetDigitalSampleLoopRange(DigitalSampleDescriptor *descriptor,
	word16 loopStart, word16 loopEnd)
{
	DisableHardwareInterrupts();
	descriptor->LoopStart = loopStart;
	descriptor->LoopEnd = loopEnd;
	word16 loopLength = loopEnd - loopStart;
	descriptor->LoopLength = loopLength;
	return loopLength;
}

// 375F:0832: reconstructed C signature follows.
// Called from:
//      InitializeDigitalSampleDescriptorCore
void SetDigitalSampleCompletionCallback(
	DigitalSampleDescriptor *descriptor,
	word16 argumentLow,
	word16 argumentHigh,
	word16 callbackOffset,
	word16 callbackSegment)
{
	DisableHardwareInterrupts();
	descriptor->CompletionArgumentLow = argumentLow;
	descriptor->CompletionArgumentHigh = argumentHigh;
	if ((callbackSegment | callbackOffset) == 0x00)
	{
		descriptor->CompletionCallbackSegment = 0x375F;
		descriptor->CompletionCallbackOffset = 0x0AE5;
	}
	else
	{
		descriptor->CompletionCallbackSegment = callbackSegment;
		descriptor->CompletionCallbackOffset = callbackOffset;
	}
}

// 375F:0814: stack-argument wrapper around the register-call callback core.
void ConfigureDigitalSampleCompletion(
	DigitalSampleDescriptor *descriptor,
	segptr32 completionCallback, word16 argumentLow, word16 argumentHigh)
{
	SetDigitalSampleCompletionCallback(descriptor, argumentLow, argumentHigh,
		LOW_WORD(completionCallback), HIGH_WORD(completionCallback));
}

// 375F:0852: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void EnqueueDigitalSampleDescriptor(
	DigitalSampleDescriptor *descriptor,
	DigitalDriverQueue *queue)
{
	LinkDigitalSampleDescriptor(queue, descriptor);
}

// 375F:0868: reconstructed C signature follows.
// Called from:
//      CalibrateDigitalPlaybackRate
//      EnqueueDigitalSampleDescriptor
void LinkDigitalSampleDescriptor(DigitalDriverQueue *queue,
	DigitalSampleDescriptor *descriptor)
{
	uint32 queueAddress;
	uint32 descriptorAddress;
	word16 queueOffset;
	word16 queueSegment;
	DigitalSampleDescriptor *nextDescriptor;

	queueAddress = HostFarPointer_Register(queue, sizeof(*queue));
	descriptorAddress = HostFarPointer_Register(descriptor,
		sizeof(*descriptor));
	queueOffset = LOW_WORD(queueAddress);
	queueSegment = HIGH_WORD(queueAddress);
	if ((descriptor->OwnerQueueOffset | descriptor->OwnerQueueSegment) == 0x0000)
	{
		descriptor->OwnerQueueOffset = queueOffset;
		descriptor->OwnerQueueSegment = queueSegment;
		DisableHardwareInterrupts();
		word16 previousCount = queue->ActiveDescriptorCount;
		queue->ActiveDescriptorCount = previousCount + 0x01;
		queue->MixBias = DigitalMixBiasOffsets[previousCount];
		nextDescriptor = FAR_POINTER(DigitalSampleDescriptor,
			queue->FirstDescriptorSegment, queue->FirstDescriptorOffset);
		descriptor->NextDescriptorOffset =
			LOW_WORD(HostFarPointer_Encode(nextDescriptor));
		descriptor->NextDescriptorSegment = FAR_SEGMENT(nextDescriptor);
		descriptor->PreviousLinkOffset = queueOffset;
		descriptor->PreviousLinkSegment = queueSegment;
		nextDescriptor->PreviousLinkOffset = LOW_WORD(descriptorAddress);
		nextDescriptor->PreviousLinkSegment = HIGH_WORD(descriptorAddress);
		queue->FirstDescriptorOffset = LOW_WORD(descriptorAddress);
		queue->FirstDescriptorSegment = HIGH_WORD(descriptorAddress);
	}
}

// 375F:08B9: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void RemoveDigitalSampleDescriptor(
	DigitalSampleDescriptor *descriptor)
{
	UnlinkDigitalSampleDescriptor(descriptor);
}

// 375F:08C9: reconstructed C signature follows.
// Called from:
//      RemoveDigitalSampleDescriptor
void UnlinkDigitalSampleDescriptor(
	DigitalSampleDescriptor *descriptor)
{
	if ((descriptor->OwnerQueueOffset | descriptor->OwnerQueueSegment) != 0x0000)
	{
		DigitalSampleDescriptor *nextDescriptor;
		word16 *previousLink;
		DigitalDriverQueue *queue;
		word16 activeCount;

		DisableHardwareInterrupts();
		nextDescriptor = FAR_POINTER(DigitalSampleDescriptor,
			descriptor->NextDescriptorSegment, descriptor->NextDescriptorOffset);
		previousLink = FAR_POINTER(word16,
			descriptor->PreviousLinkSegment, descriptor->PreviousLinkOffset);

		nextDescriptor->PreviousLinkOffset = descriptor->PreviousLinkOffset;
		nextDescriptor->PreviousLinkSegment = descriptor->PreviousLinkSegment;
		previousLink[0x00] = descriptor->NextDescriptorOffset;
		previousLink[0x01] = descriptor->NextDescriptorSegment;

		queue = FAR_POINTER(DigitalDriverQueue,
			descriptor->OwnerQueueSegment, descriptor->OwnerQueueOffset);
		activeCount = --queue->ActiveDescriptorCount;
		queue->MixBias = activeCount == 0x0000 ? 0x0AF2 :
			DigitalMixBiasOffsets[activeCount - 0x01];
		descriptor->OwnerQueueOffset = 0x0000;
		descriptor->OwnerQueueSegment = 0x0000;
	}
}

// 375F:0917: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
void PrepareDigitalSamplePlayback(
	DigitalSampleDescriptor *descriptor)
{
	ResetDigitalSamplePlayback(descriptor);
}

// 375F:0927: reconstructed C signature follows.
// Called from:
//      CalibrateDigitalPlaybackRate
//      PrepareDigitalSamplePlayback
void ResetDigitalSamplePlayback(
	DigitalSampleDescriptor *descriptor)
{
	descriptor->PlaybackHandlerOffset = DIGITAL_SAMPLE_HANDLER_IDLE;
	descriptor->SourceCursorOffset = descriptor->SampleDataOffset;
	descriptor->SourceCursorSegment = (word16) descriptor->SampleDataSegment;
	descriptor->SourceCursorFraction = 0x0000;
	descriptor->RemainingFraction = 0x0000;
	if (descriptor->LoopLength != 0x0000)
	{
		descriptor->RemainingWhole = descriptor->LoopEnd;
		descriptor->PlaybackHandlerOffset = DIGITAL_SAMPLE_HANDLER_LOOP;
	}
	else
	{
		descriptor->RemainingWhole = descriptor->SampleLength;
		descriptor->PlaybackHandlerOffset = DIGITAL_SAMPLE_HANDLER_ONESHOT;
	}
}

// 375F:095A: stack-argument wrapper around the register-call loop finisher.
void FinishDigitalSampleLoop(
	DigitalSampleDescriptor *descriptor)
{
	FinishDigitalSampleLoopCore(descriptor);
}

// 375F:096A: when a looping descriptor is active, finish the current pass
// through the source buffer as a one-shot rather than wrapping again.
void FinishDigitalSampleLoopCore(
	DigitalSampleDescriptor *descriptor)
{
	if (descriptor->PlaybackHandlerOffset == DIGITAL_SAMPLE_HANDLER_LOOP)
	{
		DisableHardwareInterrupts();
		descriptor->RemainingWhole = descriptor->SampleDataOffset +
			descriptor->SampleLength - descriptor->SourceCursorOffset;
		descriptor->PlaybackHandlerOffset = DIGITAL_SAMPLE_HANDLER_ONESHOT;
	}
}

// 375F:0986: stack-argument wrapper around the register-call stop core.
void StopDigitalSamplePlayback(
	DigitalSampleDescriptor *descriptor)
{
	StopDigitalSamplePlaybackCore(descriptor);
}

// 375F:0993: immediately mark a descriptor idle.
void StopDigitalSamplePlaybackCore(
	DigitalSampleDescriptor *descriptor)
{
	descriptor->PlaybackHandlerOffset = DIGITAL_SAMPLE_HANDLER_IDLE;
}

// 375F:0999: reconstructed C signature follows.
// Called from:
//      PlayScenarioDigitalSoundSequence
word16 GetDigitalSamplePlaybackState(
	DigitalSampleDescriptor *descriptor)
{
	return ReadDigitalSamplePlaybackState(descriptor);
}

// 375F:09A9: reconstructed C signature follows.
// Called from:
//      GetDigitalSamplePlaybackState
word16 ReadDigitalSamplePlaybackState(
	DigitalSampleDescriptor *descriptor)
{
	word16 result = 0x00;
	word16 handlerOffset = descriptor->PlaybackHandlerOffset;
	if (handlerOffset != DIGITAL_SAMPLE_HANDLER_IDLE)
	{
		result = 0x01;
		if (handlerOffset != DIGITAL_SAMPLE_HANDLER_LOOP)
		{
			result = 0x02;
			if (handlerOffset != DIGITAL_SAMPLE_HANDLER_ONESHOT)
				result = 0xFFFF;
		}
	}
	return result;
}

// 375F:09C6: Register word16 SetDigitalPlaybackTimingScale(Stack uint16 wArg04)
// Called from:
//      InitializeDigitalSoundDriver
//      PlayScenarioDigitalSoundSequence
uint32 SetDigitalPlaybackTimingScale(uint16 timingScale)
{
	word16 mixScale;

	DigitalPlaybackRuntime.RequestedMixScale = timingScale;
	mixScale = (word16) (((uint32) DigitalPlaybackRuntime.DriverMixScale *
		timingScale) >> 0x08);
	return RebuildDigitalMixLookup(mixScale);
}

// 375F:09CC: void ApplyDigitalMixScale(Register uint16 ax)
// Called from:
//      InstallDigitalDriverQueueCallback
uint32 ApplyDigitalMixScale(uint16 timingScale)
{
	word16 mixScale;

	DigitalPlaybackRuntime.RequestedMixScale = timingScale;
	mixScale = (word16) (((uint32) DigitalPlaybackRuntime.DriverMixScale *
		timingScale) >> 0x08);
	if (mixScale == DigitalPlaybackRuntime.ActiveMixScale)
		return 0x00000000;
	return RebuildDigitalMixLookup(mixScale);
}

// 375F:09E0: Register uint16 RebuildDigitalMixLookup(Register word16 ax)
// Called from:
//      SetDigitalPlaybackTimingScale
//      ApplyDigitalMixScale
uint32 RebuildDigitalMixLookup(int16 mixScale)
{
	DigitalPlaybackRuntime.ActiveMixScale = mixScale;
	int32 accumulator = ((int32) 0x0100 - mixScale) << 0x07;
	byte outputSample = 0x00;
	for (word16 inputSample = 0x0000; inputSample < 0x0100; ++inputSample)
	{
		int32 scaledSample = accumulator >> 0x08;
		if (scaledSample < 0x0000)
			outputSample = 0x00;
		else if (scaledSample > 0x00FF)
			outputSample = 0xFF;
		else
			outputSample = (byte) scaledSample;
		DigitalPlaybackRuntime.MixLookup[inputSample] = outputSample;
		accumulator += mixScale;
	}

	// The original exposes the final 24-bit AH:DX accumulator and last output
	// byte in DX:AX. DX is intentionally consumed as the silent calibration
	// descriptor's source-rate seed immediately after a zero-scale rebuild.
	word16 axResult = MAKE_WORD(
		(byte) (((uint32) accumulator >> 0x10) & 0x00FF),
		outputSample);
	return MAKE_DWORD(LOW_WORD(accumulator), axResult);
}

#define InvokeDigitalSampleCompletion DigitalBridge_InvokeSampleCompletion

/*
 * 375F:0A1D: IRQ0 entry installed by InstallDigitalPlaybackTimer.
 * The original acknowledges the master PIC, services one digital sample,
 * and uses a 16-bit accumulator to chain the displaced BIOS timer at its
 * original rate. CS:04C4 is a FFFFh-based nesting guard: only the outermost
 * interrupt advances and chains the BIOS clock.
 */
void ServiceDigitalPlaybackInterrupt(void)
{
	word16 accumulator;

	SDLBackend_AcknowledgeInterrupt(INTERRUPT_SYSTEM_TIMER_IRQ);
	ServiceDigitalAudioTick();
	accumulator = DigitalPlaybackRuntime.SystemTimerAccumulator;
	++DigitalPlaybackRuntime.InterruptNestingGuard;
	if (DigitalPlaybackRuntime.InterruptNestingGuard == 0x0000)
	{
		word16 digitalTimerDivisor =
			DigitalPlaybackRuntime.DigitalTimerReloadMinusOne +
			0x01;
		word16 previousAccumulator = accumulator;

		accumulator -= digitalTimerDivisor;
		if (previousAccumulator < digitalTimerDivisor)
		{
			accumulator +=
				DigitalPlaybackRuntime.SystemTimerDivisor;
			SDLBackend_ChainInterruptVector(DosAddress_ToValue(
				DigitalPlaybackRuntime.SavedSystemTimerVector));
		}
	}
	--DigitalPlaybackRuntime.InterruptNestingGuard;
	DigitalPlaybackRuntime.SystemTimerAccumulator = accumulator;
}

// 375F:0A62: mix and advance one sample for every descriptor in the active
// queue. The hardware receives the byte produced on the previous tick.
void ServiceDigitalAudioTick(void)
{
	DigitalDriverQueue *queue = (DigitalDriverQueue *) HostFarPointer_Resolve(
		DosAddress_ToValue(
			DigitalPlaybackRuntime.ActiveDriverQueue));
	word16 activeDescriptorCount = queue->ActiveDescriptorCount;
	if (activeDescriptorCount == 0x0000)
	{
		EnableHardwareInterrupts();
		return;
	}

	switch (DigitalPlaybackRuntime.WriteSampleCallbackOffset)
	{
	case 0x02F0: WriteNullDigitalSample(queue->OutputSample); break;
	case 0x02FC: WriteTandy3VoiceDigitalSample(queue->OutputSample); break;
	case 0x031A: WriteTandyDACDigitalSample(queue->OutputSample); break;
	case 0x0326: WriteIBMPS1DigitalSample(queue->OutputSample); break;
	case 0x032E: WriteSoundBlasterDigitalSample(queue->OutputSample); break;
	case 0x036C: WriteAdLibDigitalSample(queue->OutputSample); break;
	case 0x038C: WriteCMSDigitalSample(queue->OutputSample); break;
	case 0x049E: WriteInnovationDigitalSample(queue->OutputSample); break;
	case 0x04B5: WriteCovoxDigitalSample(queue->OutputSample); break;
	}
	word16 mixTableOffset = queue->MixBias;
	DigitalSampleDescriptor *descriptor = FAR_POINTER(DigitalSampleDescriptor,
		queue->FirstDescriptorSegment, queue->FirstDescriptorOffset);

	for (word16 descriptorIndex = 0x0000;
		descriptorIndex < activeDescriptorCount; ++descriptorIndex)
	{
		word16 handlerOffset = descriptor->PlaybackHandlerOffset;
		if (handlerOffset == DIGITAL_SAMPLE_HANDLER_IDLE)
			mixTableOffset += 0x0080;
		else if (handlerOffset == DIGITAL_SAMPLE_HANDLER_ONESHOT ||
			handlerOffset == DIGITAL_SAMPLE_HANDLER_LOOP)
		{
			word16 sourceOffset = descriptor->SourceCursorOffset;
			const byte *source = FAR_POINTER(byte,
				descriptor->SourceCursorSegment, sourceOffset);
			uint32 remaining = MAKE_DWORD(descriptor->RemainingWhole,
				descriptor->RemainingFraction);
			uint32 sourceStep = MAKE_DWORD(descriptor->SourceStepWhole,
				descriptor->SourceStepFraction);
			bool exhausted = remaining < sourceStep;
			remaining -= sourceStep;
			descriptor->RemainingWhole = HIGH_WORD(remaining);
			descriptor->RemainingFraction = LOW_WORD(remaining);

			if (exhausted)
			{
				if (handlerOffset == DIGITAL_SAMPLE_HANDLER_LOOP)
				{
					sourceOffset -= descriptor->LoopLength;
					descriptor->RemainingWhole += descriptor->LoopLength;
				}
				else
				{
					descriptor->PlaybackHandlerOffset = DIGITAL_SAMPLE_HANDLER_IDLE;
					InvokeDigitalSampleCompletion(descriptor);
				}
			}

			mixTableOffset += *source;
			uint32 sourceCursor = MAKE_DWORD(sourceOffset,
				descriptor->SourceCursorFraction) + sourceStep;
			descriptor->SourceCursorOffset = HIGH_WORD(sourceCursor);
			descriptor->SourceCursorFraction = LOW_WORD(sourceCursor);
		}
		else
		{
			// Unknown computed-jump targets are invalid descriptor state.
			EnableHardwareInterrupts();
			return;
		}

		descriptor = FAR_POINTER(DigitalSampleDescriptor,
			descriptor->NextDescriptorSegment,
			descriptor->NextDescriptorOffset);
	}

	{
		int32 mixedSample;
		word16 sampleSum;

		sampleSum = mixTableOffset - queue->MixBias;
		mixedSample = (int32) sampleSum -
			(int32) (activeDescriptorCount - 0x01) * 0x80;
		if (mixedSample < 0x00)
			mixedSample = 0x00;
		else if (mixedSample > 0xFF)
			mixedSample = 0xFF;
		queue->OutputSample =
			DigitalPlaybackRuntime.MixLookup[(byte) mixedSample];
	}
	EnableHardwareInterrupts();
}


