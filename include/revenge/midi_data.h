#ifndef REVENGE_MIDI_DATA_H
#define REVENGE_MIDI_DATA_H

#include "revenge/types.h"
#include "revenge/original/audio_data.h"

/*
 * Mechanical host representation of the original DS:62BA-6D18 MIDI work
 * area.  These accessors preserve the executable's little-endian near
 * offsets without putting segmented-pointer operations in Original code.
 */
byte *MIDIDataByte(word16 dataSegmentOffset);
word16 ReadMIDIDataWord(word16 dataSegmentOffset);
void WriteMIDIDataWord(word16 dataSegmentOffset, word16 value);
void ClearMIDIData(word16 dataSegmentOffset, word16 byteCount);
MIDIChannelState *MIDIChannelStateAt(word16 dataSegmentOffset);
MIDIVoiceRecord *MIDIVoiceRecordAt(word16 dataSegmentOffset);

#endif
