#ifndef REVENGE_ORIGINAL_AUDIO_DATA_H
#define REVENGE_ORIGINAL_AUDIO_DATA_H

#include "revenge/types.h"

#include <stddef.h>

/*
 * Exact data map used by the shared timer and PC-speaker stream driver.
 * Layout assertions and address comments retain the segment-426B offsets.
 */
#pragma pack(push, 1)
typedef struct RevengeMusicTimerState
{
	byte ReservedTimerPrefix[0x02];
	word16 GameDataSegment;
	byte MusicDriverMode;
	byte SpeakerEffectServiceActive;
	byte ReservedTimerControl;
	byte ChainSystemTimerThisTick;
	word16 SystemTickReload;
	word16 SystemTickCountdown;
	word16 MusicServiceCountdown;
	word16 MusicServiceReload;
	word16 MusicServiceBusy;
	DosAddress ActiveSpeakerEffectStream;
	word16 SpeakerEffectStreamCursor;
	DosAddress PendingSpeakerEffectStream;
	word16 ReservedTimerStreamWord;
	word16 SpeakerEffectTicksRemaining;
	word16 MusicFrequencyDivisorTable[0x60];
	byte SpeakerEffectPlaybackActive;
	byte SpeakerEffectStartRequested;
	byte SpeakerEffectStopRequested;
	byte SpeakerEffectFetchNextEvent;
	byte SpeakerEffectDurationScale;
	byte SpeakerEffectLoop1Remaining;
	byte SpeakerEffectLoop2Remaining;
	word16 MusicElapsedSubtick;
	byte MusicElapsedUnit;
} RevengeMusicTimerState;
#pragma pack(pop)

_Static_assert(sizeof(RevengeMusicTimerState) == 0xEA,
	"The reconstructed 426B:0000-00E9 timer state must be exact.");
_Static_assert(offsetof(RevengeMusicTimerState,
	ActiveSpeakerEffectStream) == 0x12,
	"The active speaker stream must remain at 426B:0012.");
_Static_assert(offsetof(RevengeMusicTimerState,
	MusicFrequencyDivisorTable) == 0x20,
	"The speaker frequency table must remain at 426B:0020.");
_Static_assert(offsetof(RevengeMusicTimerState,
	MusicElapsedSubtick) == 0xE7,
	"The elapsed subtick must remain at 426B:00E7.");

extern RevengeMusicTimerState Seg426B;

/* Exact contiguous game-data block at DS:B6D4-B807. */
#pragma pack(push, 1)
typedef struct PCSpeakerSampleConversionData
{
	byte SampleLookup[0x0100];
	word16 TargetTimerTicks;
	word16 DelayScale;
	word16 CalibrationBitstream[0x18];
} PCSpeakerSampleConversionData;
#pragma pack(pop)

_Static_assert(sizeof(PCSpeakerSampleConversionData) == 0x0134,
	"The reconstructed DS:B6D4-B807 conversion block must be exact.");
_Static_assert(offsetof(PCSpeakerSampleConversionData,
	TargetTimerTicks) == 0x0100,
	"The target timer count must remain at DS:B7D4.");
_Static_assert(offsetof(PCSpeakerSampleConversionData,
	CalibrationBitstream) == 0x0104,
	"The calibration bitstream must remain at DS:B7D8.");

extern PCSpeakerSampleConversionData PCSpeakerSampleConversion;

enum
{
	PC_SPEAKER_EFFECT_STREAM_FIRST_OFFSET = 0x5642,
	PC_SPEAKER_EFFECT_STREAM_BYTE_COUNT = 0x0299,
	PC_SPEAKER_EFFECT_COUNT = 0x10
};

extern const byte PCSpeakerEffectStreamData[
	PC_SPEAKER_EFFECT_STREAM_BYTE_COUNT];
extern const DosAddress PCSpeakerEffectStreamPointerTable[
	PC_SPEAKER_EFFECT_COUNT];

/* Offset and segment words at DS:B60A/B60C. */
extern byte *MusicStagingBuffer;

/* Exact standard-MIDI sequence state at DS:624A-6265. */
#pragma pack(push, 1)
typedef struct MIDISequenceState
{
	word16 MIDIBeatsPerMinute;
	word16 MIDITimerCallsPerMinute;
	word16 MIDITicksPerMinute;
	word16 MIDITickRateRemainder;
	word16 MIDITicksPerBeat;
	word16 MIDIBeatsPerMeasure;
	DosAddress MIDIStreamCursor;
	word16 MIDIPlaybackFlags;
	word16 MIDITicksUntilNextEvent;
	word16 MIDIBeatTickRemainder;
	word16 MIDIMeasureBeatRemainder;
	word16 MIDIMeasureCount;
	byte MIDIPlaybackStateBusy;
	byte MIDIRunningStatus;
} MIDISequenceState;
#pragma pack(pop)

_Static_assert(sizeof(MIDISequenceState) == 0x1C,
	"The reconstructed DS:624A-6265 MIDI sequence state must be exact.");
_Static_assert(offsetof(MIDISequenceState, MIDIStreamCursor) == 0x0C,
	"The MIDI stream cursor must remain at DS:6256.");
_Static_assert(offsetof(MIDISequenceState, MIDIPlaybackFlags) == 0x10,
	"The MIDI playback flags must remain at DS:625A.");

extern MIDISequenceState MIDISequence;

/* Exact MIDI byte-parser state at DS:62B0-62B9. */
#pragma pack(push, 1)
typedef struct MIDIParserState
{
	word16 DispatchOffset;
	word16 CurrentStatus;
	word16 FirstDataByte;
	word16 ControllerValue;
	word16 ActiveDriverOffset;
} MIDIParserState;
#pragma pack(pop)

_Static_assert(sizeof(MIDIParserState) == 0x0A,
	"The reconstructed DS:62B0-62B9 MIDI parser state must be exact.");
_Static_assert(offsetof(MIDIParserState, ActiveDriverOffset) == 0x08,
	"The active MIDI driver offset must remain at DS:62B8.");

extern MIDIParserState MIDIParser;

/* Exact logical-to-physical channel map at DS:6728-6737. */
extern byte MIDIChannelMap[0x10];

/* Exact system-exclusive command parser state at DS:6738-675F. */
#pragma pack(push, 1)
typedef struct MIDISystemExclusiveState
{
	byte CommandBuffer[0x20];
	word16 HandlerOffset;
	word16 CommandOffset;
	byte CommandByteCount;
	byte RemainingByteCount;
	word16 WriteCursorOffset;
} MIDISystemExclusiveState;
#pragma pack(pop)

_Static_assert(sizeof(MIDISystemExclusiveState) == 0x28,
	"The original MIDI SysEx parser record occupies exactly 28h bytes.");
_Static_assert(offsetof(MIDISystemExclusiveState, HandlerOffset) == 0x20,
	"The SysEx handler offset must remain at DS:6758.");
_Static_assert(offsetof(MIDISystemExclusiveState,
	WriteCursorOffset) == 0x26,
	"The SysEx write cursor must remain at DS:675E.");

extern MIDISystemExclusiveState MIDISystemExclusive;

/* Exact 8-byte logical MIDI channel record at DS:6420. */
#pragma pack(push, 1)
typedef struct MIDIChannelState
{
	byte VoiceClass;
	byte AllocationPriority;
	byte ReservedVoiceCount;
	byte Program;
	byte NoteTransposeAndFlags;
	byte AvailableVoiceCount;
	word16 InstrumentOffset;
} MIDIChannelState;
#pragma pack(pop)

_Static_assert(sizeof(MIDIChannelState) == 0x08,
	"An original MIDI channel record occupies exactly 8 bytes.");
_Static_assert(offsetof(MIDIChannelState, InstrumentOffset) == 0x06,
	"The instrument near pointer must remain at channel offset 0006h.");

/* Exact 20h-byte voice allocator record at DS:62C0. */
#pragma pack(push, 1)
typedef struct MIDIVoiceRecord
{
	word16 NextOffset;
	word16 PreviousOffset;
	byte VoiceClass;
	byte AllocationPriority;
	word16 ChannelStateOffset;
	byte SourceNote;
	byte PlaybackNote;
	union
	{
		byte Raw[0x16];
		struct
		{
			word16 PITDivisor;
			byte SpeakerDriverStatePadding[0x14];
		} Speaker;
		struct
		{
			word16 FrequencyLatch;
			byte AttenuationLatch;
			byte VoiceMask;
			byte LegacyPSGDriverStatePadding[0x12];
		} LegacyPSG;
		struct
		{
			byte Channel;
			byte OperatorRegister;
			word16 LoadedPatchOffset;
			word16 Frequency;
			byte AdLibDriverStatePadding[0x10];
		} AdLib;
	} Driver;
} MIDIVoiceRecord;
#pragma pack(pop)

_Static_assert(sizeof(MIDIVoiceRecord) == 0x20,
	"An original MIDI voice allocator record occupies exactly 20h bytes.");
_Static_assert(offsetof(MIDIVoiceRecord, ChannelStateOffset) == 0x06,
	"The channel near pointer must remain at voice offset 0006h.");
_Static_assert(offsetof(MIDIVoiceRecord, PlaybackNote) == 0x09,
	"The transposed note must remain at voice offset 0009h.");
_Static_assert(offsetof(MIDIVoiceRecord, Driver) == 0x0A,
	"Driver-private voice state must remain at voice offset 000Ah.");

/* Exact speaker MIDI scheduler state at DS:67BC-67C1. */
#pragma pack(push, 1)
typedef struct SpeakerMIDIRuntimeState
{
	word16 ActivePITDivisor;
	word16 ServiceVoiceOffset;
	byte ServiceVoiceCountdown;
	byte ReservedSchedulerByte;
} SpeakerMIDIRuntimeState;
#pragma pack(pop)

_Static_assert(sizeof(SpeakerMIDIRuntimeState) == 0x06,
	"The speaker MIDI scheduler state occupies exactly 6 bytes.");

/* Tandy and IBM PS/1 use identical four-byte round-robin state records. */
#pragma pack(push, 1)
typedef struct LegacyPSGMIDIRuntimeState
{
	word16 ServiceVoiceOffset;
	byte ServiceVoiceCountdown;
	byte HardwareVoiceCount;
} LegacyPSGMIDIRuntimeState;
#pragma pack(pop)

_Static_assert(sizeof(LegacyPSGMIDIRuntimeState) == 0x04,
	"A legacy PSG scheduler state occupies exactly 4 bytes.");

extern SpeakerMIDIRuntimeState SpeakerMIDIRuntime;
extern LegacyPSGMIDIRuntimeState TandyMIDIRuntime;
extern LegacyPSGMIDIRuntimeState IBMPS1MIDIRuntime;
extern const word16 SpeakerMIDIFrequencyDivisors[0x72];
extern const word16 TandyMIDIFrequencyWords[0x4C];
extern const word16 IBMPS1MIDIFrequencyWords[0x4A];

/* Exact OPL timing and rhythm state at DS:6A6E-6A73. */
#pragma pack(push, 1)
typedef struct AdLibMIDIRuntimeState
{
	word16 RegisterSelectDelay;
	word16 RegisterDataDelay;
	byte RhythmMask;
	byte ReservedRhythmByte;
} AdLibMIDIRuntimeState;
#pragma pack(pop)

_Static_assert(sizeof(AdLibMIDIRuntimeState) == 0x06,
	"The original AdLib timing/rhythm state occupies exactly 6 bytes.");

extern AdLibMIDIRuntimeState AdLibMIDIRuntime;
extern const word16 AdLibMIDIFrequencyWords[0x73];

#pragma pack(push, 1)
typedef struct AdLibVoiceLayout
{
	byte Channel;
	byte OperatorRegister;
	byte VoiceClass;
} AdLibVoiceLayout;
#pragma pack(pop)

_Static_assert(sizeof(AdLibVoiceLayout) == 0x03,
	"An original AdLib voice-layout entry occupies exactly 3 bytes.");

extern const AdLibVoiceLayout AdLibElevenVoiceLayout[0x0B];
extern const AdLibVoiceLayout AdLibNineVoiceLayout[0x09];
extern const word16 AdLibActivateRegisterList[0x04];
extern const word16 AdLibNineVoiceResetList[0x02];
extern const word16 AdLibElevenVoiceResetList[0x0A];
extern const word16 AdLibDeactivateRegisterList[0x13];

#pragma pack(push, 1)
typedef struct PackedAdLibInstrument
{
	byte Data[0x0B];
} PackedAdLibInstrument;

typedef struct AdLibOperatorPatch
{
	byte Characteristics;
	byte ScaleAndOutputLevel;
	byte SustainAndRelease;
	byte AttackAndDecay;
	byte WaveformSelect;
} AdLibOperatorPatch;

typedef struct AdLibInstrumentPatch
{
	AdLibOperatorPatch Modulator;
	byte FeedbackAndConnection;
	AdLibOperatorPatch Carrier;
	byte ReservedInstrumentByte;
} AdLibInstrumentPatch;
#pragma pack(pop)

_Static_assert(sizeof(PackedAdLibInstrument) == 0x0B,
	"A packed AdLib instrument occupies exactly 0Bh bytes.");
_Static_assert(sizeof(AdLibInstrumentPatch) == 0x0C,
	"A decoded AdLib instrument occupies exactly 0Ch bytes.");
_Static_assert(offsetof(AdLibInstrumentPatch, Carrier) == 0x06,
	"The carrier patch must remain at decoded instrument offset 0006h.");

extern AdLibInstrumentPatch MIDIInstrumentPatches[0x20];

/* Exact MPU-401 saved vector and transmit queue at DS:6C0E-6D17. */
#pragma pack(push, 1)
typedef struct RolandMPU401State
{
	DosAddress SavedIRQVector;
	byte TransmitQueue[0x0100];
	word16 WriteIndex;
	word16 ReadIndex;
	word16 ByteCount;
} RolandMPU401State;
#pragma pack(pop)

_Static_assert(sizeof(RolandMPU401State) == 0x010A,
	"The original MPU-401 state occupies exactly 10Ah bytes.");
_Static_assert(offsetof(RolandMPU401State, TransmitQueue) == 0x04,
	"The MPU-401 transmit queue must remain at DS:6C12.");
_Static_assert(offsetof(RolandMPU401State, WriteIndex) == 0x0104,
	"The MPU-401 write index must remain at DS:6D12.");

extern RolandMPU401State RolandMPU401;

/* Exact 1Bh MIDI driver descriptor used by the near-call dispatch layer. */
#pragma pack(push, 1)
typedef struct MIDIDriverDescriptorData
{
	byte Flags[0x03];
	byte AvailableVoiceCount;
	word16 ProbeOffset;
	word16 ActivateOffset;
	word16 DeactivateOffset;
	word16 FilterByteOffset;
	word16 StartVoiceOffset;
	word16 ReleaseVoiceOffset;
	word16 ResetOffset;
	word16 LoadInstrumentOffset;
	word16 ServiceOffset;
	word16 ActivationArgument;
	word16 VoiceRecordsOffset;
	byte ActiveVoiceCount;
} MIDIDriverDescriptorData;
#pragma pack(pop)

_Static_assert(sizeof(MIDIDriverDescriptorData) == 0x1B,
	"An original MIDI driver descriptor occupies exactly 1Bh bytes.");
_Static_assert(offsetof(MIDIDriverDescriptorData, ProbeOffset) == 0x04,
	"The MIDI probe near pointer must remain at descriptor offset 0004h.");
_Static_assert(offsetof(MIDIDriverDescriptorData,
	ActiveVoiceCount) == 0x1A,
	"The active voice count must remain at descriptor offset 001Ah.");

#endif
