#include "revenge/midi_data.h"

#include <assert.h>

int main(void)
{
	MIDIChannelState *channelState;
	MIDIVoiceRecord *voiceRecord;

	assert(sizeof(MIDIChannelState) == 0x08);
	assert(sizeof(MIDIVoiceRecord) == 0x20);

	/* The remaining allocator workspace is zero-initialized in REVENGE.EXE. */
	assert(*MIDIDataByte(0x62BA) == 0x00);
	assert(*MIDIDataByte(0x65A7) == 0x00);
	ClearMIDIData(0x62BA, 0x0040);
	WriteMIDIDataWord(0x62BA, 0x62C0);
	WriteMIDIDataWord(0x62C0, 0x1234);
	*MIDIDataByte(0x62C2) = 0x56;

	assert(ReadMIDIDataWord(0x62BA) == 0x62C0);
	assert(ReadMIDIDataWord(0x62C0) == 0x1234);
	assert(*MIDIDataByte(0x62C2) == 0x56);

	channelState = MIDIChannelStateAt(0x6420);
	channelState->Program = 0x2A;
	channelState->InstrumentOffset = 0x65A8;
	assert(*MIDIDataByte(0x6423) == 0x2A);
	assert(ReadMIDIDataWord(0x6426) == 0x65A8);

	voiceRecord = MIDIVoiceRecordAt(0x62C0);
	voiceRecord->ChannelStateOffset = 0x6420;
	voiceRecord->SourceNote = 0x3C;
	assert(ReadMIDIDataWord(0x62C6) == 0x6420);
	assert(*MIDIDataByte(0x62C8) == 0x3C);
	return 0x00;
}
