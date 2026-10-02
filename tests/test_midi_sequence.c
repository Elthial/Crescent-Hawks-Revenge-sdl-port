#include "fake_backend.h"
#include "revenge/audio.h"
#include "revenge/midi_data.h"

#include <assert.h>

static void TestVariableLengthQuantity(void)
{
    const byte encoded[] = { 0x81, 0x00 };
    const byte *cursor;

    cursor = encoded;
    assert(ReadMIDIVariableLengthQuantity(&cursor) == 0x0080);
    assert(cursor == encoded + sizeof(encoded));
}

static void TestAdLibInstrumentExpansion(void)
{
	const byte packed[0x0B] =
	{
		0x01, 0x02, 0x63, 0x74, 0x45, 0x26,
		0x07, 0x08, 0x69, 0x7A, 0x4B
	};
	AdLibInstrumentPatch decoded;

	decoded.ReservedInstrumentByte = 0xA5;
	LoadAdLibMIDIInstrument(packed, (byte *) &decoded);
	assert(decoded.Modulator.Characteristics == 0x81);
	assert(decoded.Modulator.ScaleAndOutputLevel == 0xE6);
	assert(decoded.Modulator.WaveformSelect == 0x02);
	assert(decoded.FeedbackAndConnection == 0x08);
	assert(decoded.Carrier.Characteristics == 0x87);
	assert(decoded.Carrier.WaveformSelect == 0x00);
	assert(decoded.ReservedInstrumentByte == 0xA5);
}

static void TestAdLibInstrumentSystemCommand(void)
{
	const byte packed[0x0B] =
	{
		0x01, 0x02, 0x63, 0x74, 0x45, 0x26,
		0x07, 0x08, 0x69, 0x7A, 0x4B
	};
	byte index;

	FakeBackend_Reset();
	ActivateMIDIDriver(&AdLibMIDIDriverDescriptor);
	DispatchMIDISystemByte(0xF0);
	DispatchMIDISystemByte(0x7A);
	DispatchMIDISystemByte(0x01);
	DispatchMIDISystemByte(0x0C);
	DispatchMIDISystemByte(0x03);
	for (index = 0x00; index < sizeof(packed); ++index)
		DispatchMIDISystemByte(packed[index]);
	assert(MIDIInstrumentPatches[0x03].
		Modulator.Characteristics == 0x81);
	assert(MIDIInstrumentPatches[0x03].
		Carrier.Characteristics == 0x87);
	DeactivateMIDIDriver();
}

static void TestHostedAdLibVoiceInterception(void)
{
	MIDIChannelState *channelState;
	MIDIVoiceRecord *voiceRecord;

	FakeBackend_Reset();
	channelState = MIDIChannelStateAt(0x6420);
	voiceRecord = MIDIVoiceRecordAt(0x62C0);
	channelState->Program = 0x16;
	voiceRecord->PlaybackNote = 0x3C;
	voiceRecord->VoiceClass = 0x20;
	AdLibMIDIVoiceOn(0x62C0, 0x6420, 0x005A);
	assert(fakeBackend.musicVoiceStartCount == 0x0001);
	assert(fakeBackend.musicVoiceId == 0x62C0);
	assert(fakeBackend.musicNote == 0x3C);
	assert(fakeBackend.musicVelocity == 0x5A);
	assert(fakeBackend.musicProgram == 0x16);
	assert(fakeBackend.musicVoiceClass == 0x20);
	AdLibMIDIVoiceOff(0x62C0);
	assert(fakeBackend.musicVoiceStopCount == 0x0001);
	assert(fakeBackend.musicVoiceId == 0x62C0);
	ResetAdLibMIDIDriver();
	assert(fakeBackend.musicVoiceResetCount == 0x0001);
}

static void TestAdLibVoiceAllocation(void)
{
	static const byte channelSetup[] =
	{
		0xF0, 0x7A, 0x00, 0x06,
		0x00, 0x20, 0x01, 0x01, 0x00, 0x00,
		0xF7
	};
	byte index;

	FakeBackend_Reset();
	ActivateMIDIDriver(&AdLibMIDIDriverDescriptor);
	for (index = 0x00; index < sizeof(channelSetup); ++index)
		DispatchMIDISystemByte(channelSetup[index]);
	assert(MIDIChannelStateAt(0x6420)->ReservedVoiceCount == 0x01);
	assert(MIDIVoiceRecordAt(0x62C0)->VoiceClass == 0x20);
	assert(StartMIDINote(0x0000, 0x003C, 0x005A) == TRUE);
	assert(fakeBackend.musicVoiceStartCount == 0x0001);
	DeactivateMIDIDriver();
}

static void TestAdLibUnreservedVoiceAllocation(void)
{
	MIDIChannelState *channelState;

	FakeBackend_Reset();
	ActivateMIDIDriver(&AdLibMIDIDriverDescriptor);
	channelState = MIDIChannelStateAt(0x6420);
	channelState->VoiceClass = 0x20;
	channelState->AllocationPriority = 0x64;
	assert(channelState->ReservedVoiceCount == 0x00);
	assert(MIDIChannelStateAt(0x65A0)->AvailableVoiceCount == 0x0B);
	assert(StartMIDINote(0x0000, 0x003C, 0x005A) == TRUE);
	assert(fakeBackend.musicVoiceStartCount == 0x0001);
	assert(channelState->AvailableVoiceCount == 0x01);
	assert(MIDIChannelStateAt(0x65A0)->AvailableVoiceCount == 0x0A);
	DeactivateMIDIDriver();
}

static void TestSingleTrackSequence(void)
{
    static const byte sequence[] =
    {
        'M', 'T', 'h', 'd', 0x00, 0x00, 0x00, 0x06,
        0x00, 0x00, 0x00, 0x01, 0x00, 0x60,
        'M', 'T', 'r', 'k', 0x00, 0x00, 0x00, 0x0C,
        0x00, 0x90, 0x3C, 0x40,
        0x01, 0x80, 0x3C, 0x00,
        0x00, 0xFF, 0x2F, 0x00
    };

    uint16 queuedByte;

    FakeBackend_Reset();
	assert(sizeof(MIDIDriverDescriptorData) == 0x1B);
	assert(sizeof(MIDISystemExclusiveState) == 0x28);
	assert(sizeof(SpeakerMIDIRuntimeState) == 0x06);
	assert(sizeof(LegacyPSGMIDIRuntimeState) == 0x04);
	assert(sizeof(AdLibMIDIRuntimeState) == 0x06);
	assert(AdLibMIDIRuntime.RegisterSelectDelay == 0x000A);
	assert(AdLibMIDIRuntime.RegisterDataDelay == 0x0050);
	assert(AdLibMIDIFrequencyWords[0x00] == 0x00AB);
	assert(AdLibMIDIFrequencyWords[0x72] == 0x1FCA);
	assert(AdLibElevenVoiceLayout[0x0A].VoiceClass == 0x01);
	assert(AdLibNineVoiceLayout[0x08].OperatorRegister == 0x12);
	assert(AdLibActivateRegisterList[0x03] == 0x0000);
	assert(AdLibDeactivateRegisterList[0x12] == 0x0000);
	assert(sizeof(RolandMPU401State) == 0x010A);
	assert(SpeakerMIDIFrequencyDivisors[0x00] == 0xFDF1);
	assert(SpeakerMIDIFrequencyDivisors[0x71] == 0x005F);
	assert(TandyMIDIFrequencyWords[0x00] == 0x3F89);
	assert(TandyMIDIFrequencyWords[0x4B] == 0x008D);
	assert(IBMPS1MIDIFrequencyWords[0x00] == 0x3F84);
	assert(IBMPS1MIDIFrequencyWords[0x49] == 0x008E);
	assert(SpeakerMIDIDriverDescriptor.ProbeOffset == 0x08B6);
	assert(AdLibMIDIDriverDescriptor.StartVoiceOffset == 0x0C96);
	assert(RolandMIDIDriverDescriptor.ServiceOffset == 0x0F33);
    ActivateMIDIDriver(&RolandMIDIDriverDescriptor);
	assert(MIDIParser.ActiveDriverOffset == 0x6BD8);
	assert(MIDISystemExclusive.HandlerOffset == 0x0760);
	assert(MIDIChannelMap[0x00] == 0x00);
	assert(MIDIChannelMap[0x0F] == 0x0F);
    ServiceActiveMIDIDriver();
    FakeBackend_Reset();
    SetMIDITimingDivisor(0x0001);
    ConfigureMIDITempo(0x0001, 0x0001);
    assert(StartMIDISequence(sequence, 0x0001) == 0x0001);
    ServiceMIDISequenceTick();
    for (queuedByte = 0x0000; queuedByte < 0x0036; ++queuedByte)
        ServiceActiveMIDIDriver();
    assert(fakeBackend.midiByteCount == 0x0036);
    assert(fakeBackend.midiBytes[0x00] == 0x90);
    assert(fakeBackend.midiBytes[0x01] == 0x3C);
    assert(fakeBackend.midiBytes[0x02] == 0x40);
    assert(fakeBackend.midiBytes[0x03] == 0x80);
    assert(fakeBackend.midiBytes[0x04] == 0x3C);
    assert(fakeBackend.midiBytes[0x05] == 0x00);
	assert(RolandMPU401.ByteCount == 0x0000);
    assert(MIDISequence.MIDIPlaybackFlags == 0x0000);
	DeactivateMIDIDriver();
	assert(MIDIParser.ActiveDriverOffset == 0x6766);
}

int main(void)
{
	assert(MIDISequence.MIDIBeatsPerMinute == 0x0078);
	assert(MIDISequence.MIDITimerCallsPerMinute == 0x1110);
	assert(MIDISequence.MIDITicksPerMinute == 0x2D00);
	assert(MIDISequence.MIDITicksPerBeat == 0x0060);
	assert(MIDISequence.MIDIBeatsPerMeasure == 0x0004);
    TestVariableLengthQuantity();
	TestAdLibInstrumentExpansion();
	TestAdLibInstrumentSystemCommand();
	TestHostedAdLibVoiceInterception();
	TestAdLibVoiceAllocation();
	TestAdLibUnreservedVoiceAllocation();
    TestSingleTrackSequence();
    return 0x00;
}
