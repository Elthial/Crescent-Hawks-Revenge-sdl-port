#ifndef REVENGE_3621_MIDI_INTERNAL_H
#define REVENGE_3621_MIDI_INTERNAL_H

#include "REVENGE.h"

typedef struct MIDIDriverHostDispatch
{
	word16 (*probe)(void);
	void (*activate)(word16 activationArgument);
	void (*deactivate)(void);
	uint16 (*filterByte)(uint16 midiByte);
	void (*startVoice)(word16 voiceRecordOffset,
		word16 channelStateOffset, word16 velocity);
	void (*releaseVoice)(word16 voiceRecordOffset);
	void (*reset)(void);
	void (*loadInstrument)(const byte *packedInstrument,
		byte *decodedInstrument);
	void (*service)(void);
} MIDIDriverHostDispatch;

extern const void *MIDIDriverDescriptorIdentities[0x06];
extern const void *MIDIDriverHostDispatches[0x06];

#endif
