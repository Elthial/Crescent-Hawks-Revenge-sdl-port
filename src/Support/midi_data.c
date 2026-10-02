#include "revenge/midi_data.h"

#include <assert.h>
#include <string.h>

enum
{
	MIDI_DATA_FIRST_OFFSET = 0x62BA,
	MIDI_DATA_END_OFFSET = 0x65A8,
	MIDI_DATA_BYTE_COUNT = MIDI_DATA_END_OFFSET - MIDI_DATA_FIRST_OFFSET
};

/*
 * Exact zero-initialized MIDI allocator workspace at DS:62BA-65A7. The
 * frequency tables, driver records, OPL layouts, and MPU-401 queue that once
 * shared the monolithic image now have exact named definitions in Original.
 */
static byte midiData[MIDI_DATA_BYTE_COUNT];

byte *MIDIDataByte(word16 dataSegmentOffset)
{
	assert(dataSegmentOffset >= MIDI_DATA_FIRST_OFFSET);
	assert(dataSegmentOffset < MIDI_DATA_END_OFFSET);
	return &midiData[dataSegmentOffset - MIDI_DATA_FIRST_OFFSET];
}

word16 ReadMIDIDataWord(word16 dataSegmentOffset)
{
	byte *source;

	assert(dataSegmentOffset + 0x01 < MIDI_DATA_END_OFFSET);
	source = MIDIDataByte(dataSegmentOffset);
	return (word16) (source[0x00] | ((word16) source[0x01] << 0x08));
}

void WriteMIDIDataWord(word16 dataSegmentOffset, word16 value)
{
	byte *destination;

	assert(dataSegmentOffset + 0x01 < MIDI_DATA_END_OFFSET);
	destination = MIDIDataByte(dataSegmentOffset);
	destination[0x00] = (byte) value;
	destination[0x01] = (byte) (value >> 0x08);
}

void ClearMIDIData(word16 dataSegmentOffset, word16 byteCount)
{
	assert((uint32) dataSegmentOffset + byteCount <= MIDI_DATA_END_OFFSET);
	memset(MIDIDataByte(dataSegmentOffset), 0x00, byteCount);
}

MIDIChannelState *MIDIChannelStateAt(word16 dataSegmentOffset)
{
	assert(dataSegmentOffset >= 0x6420);
	assert(dataSegmentOffset + sizeof(MIDIChannelState) <=
		MIDI_DATA_END_OFFSET);
	return (MIDIChannelState *) MIDIDataByte(dataSegmentOffset);
}

MIDIVoiceRecord *MIDIVoiceRecordAt(word16 dataSegmentOffset)
{
	assert(dataSegmentOffset >= 0x62C0);
	assert(dataSegmentOffset + sizeof(MIDIVoiceRecord) <=
		MIDI_DATA_END_OFFSET);
	return (MIDIVoiceRecord *) MIDIDataByte(dataSegmentOffset);
}
