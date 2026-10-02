#ifndef REVENGE_DIGITAL_BRIDGE_H
#define REVENGE_DIGITAL_BRIDGE_H

#include "revenge/types.h"

struct DigitalHardwareDescriptor;
struct DigitalPlaybackDescriptor;
struct DigitalSampleDescriptor;

struct DigitalHardwareDescriptor *
	DigitalBridge_ResolveHardwareDescriptor(word16 descriptorOffset);
struct DigitalPlaybackDescriptor *
	DigitalBridge_ResolvePlaybackDescriptor(word16 descriptorOffset);
const word16 *DigitalBridge_ResolveProbeCandidateList(word16 listOffset);
word16 DigitalBridge_DispatchHardwareProbe(
	word16 callbackOffset, word16 probeParameter);
void DigitalBridge_DispatchHardwareAcquire(
	word16 callbackOffset, word16 parameter);
void DigitalBridge_DispatchHardwareRelease(word16 callbackOffset);
void DigitalBridge_InvokeSampleCompletion(
	struct DigitalSampleDescriptor *descriptor);

#endif
