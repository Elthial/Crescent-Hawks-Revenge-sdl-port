// REVENGE_373D.c
// Hand-cleaned C translation of the PC-speaker bitstream output segment.

#include "REVENGE.h"

word16 g_pitStartCount_0004 = 0x0000; // 373D:0004
word16 g_bitAndByteDelayCounts_0006 = 0x0000; // 373D:0006: DL bit, DH byte
word16 g_savedSpeakerStateAndWordDelay_0008 = 0x0000; // AL port 61h, AH word delay
word16 g_speakerOffOnValues_000A = 0x0000; // BL off, BH on

static void WaitPCSpeakerDelay(byte delayCount)
{
	word16 remaining = delayCount;
	do
		--remaining;
	while (remaining != 0x0000);
}

static word16 ReadPITChannel0Count(void)
{
	byte lowByte = __in<byte>(PIT_CHANNEL_0_DATA_PORT);
	byte highByte = __in<byte>(PIT_CHANNEL_0_DATA_PORT);
	return MAKE_WORD(highByte, lowByte);
}

// 373D:000C: void BeginPCSpeakerTimedOutput_000C(Stack word16 delayScale)
// Called from:
//      PlayPCSpeakerBitstream_007E
//      FindPCSpeakerDelayScale_00A8
//      PCSpeakerCalibrationExceedsTolerance_0116
void BeginPCSpeakerTimedOutput_000C(word16 delayScale)
{
	byte bitDelay = LOW_BYTE(delayScale);
	byte byteDelay = bitDelay - 0x01;
	if (byteDelay == 0x00)
		byteDelay = 0x01;
	byte wordDelay = byteDelay - 0x01;
	if (wordDelay == 0x00)
		wordDelay = 0x01;

	__cli();
	byte savedPort61 = __in<byte>(PC_SPEAKER_CONTROL_PORT);
	byte speakerOff = savedPort61 & PC_SPEAKER_DISABLE_MASK;
	byte speakerOn = speakerOff ^ 0x02;

	g_savedSpeakerStateAndWordDelay_0008 = MAKE_WORD(wordDelay, savedPort61);
	g_bitAndByteDelayCounts_0006 = MAKE_WORD(byteDelay, bitDelay);
	g_speakerOffOnValues_000A = MAKE_WORD(speakerOn, speakerOff);
	__out<byte>(PC_SPEAKER_CONTROL_PORT, speakerOff);

	__out<byte>(PIT_MODE_COMMAND_PORT, 0x00); // latch PIT channel 0
	g_pitStartCount_0004 = ReadPITChannel0Count();
}

// 373D:004E: void WritePCSpeakerBitstream_004E(Stack far pointer sampleData,
//                                               Stack word16 byteCount)
// The assembly consumes 16 packed sample bits per source word, LSB first.
void WritePCSpeakerBitstream_004E(const byte __far *sampleData, word16 byteCount)
{
	word16 remainingWords = byteCount >> 0x01;
	byte bitDelay = LOW_BYTE(g_bitAndByteDelayCounts_0006);
	byte byteDelay = HIGH_BYTE(g_bitAndByteDelayCounts_0006);
	byte wordDelay = HIGH_BYTE(g_savedSpeakerStateAndWordDelay_0008);
	byte speakerOff = LOW_BYTE(g_speakerOffOnValues_000A);
	byte speakerOn = HIGH_BYTE(g_speakerOffOnValues_000A);

	while (remainingWords != 0x00)
	{
		word16 packedSamples = *((const word16 __far *) sampleData);
		sampleData += 0x02;
		WaitPCSpeakerDelay(wordDelay);

		byte bitIndex;
		for (bitIndex = 0x00; bitIndex < 0x10; ++bitIndex)
		{
			__out<byte>(PC_SPEAKER_CONTROL_PORT,
				(packedSamples & 0x0001) != 0x00 ? speakerOn : speakerOff);
			packedSamples >>= 0x01;
			if (bitIndex == 0x07)
				WaitPCSpeakerDelay(byteDelay);
			else if (bitIndex != 0x0F)
				WaitPCSpeakerDelay(bitDelay);
		}

		--remainingWords;
	}
}

// 373D:020B: Register word16 EndPCSpeakerTimedOutput_020B()
// Called from:
//      PlayPCSpeakerBitstream_007E
//      FindPCSpeakerDelayScale_00A8
//      PCSpeakerCalibrationExceedsTolerance_0116
word16 EndPCSpeakerTimedOutput_020B(void)
{
	__out<byte>(PC_SPEAKER_CONTROL_PORT,
		LOW_BYTE(g_savedSpeakerStateAndWordDelay_0008));
	__out<byte>(PIT_MODE_COMMAND_PORT, 0x00); // latch PIT channel 0
	word16 elapsedCounts = g_pitStartCount_0004 - ReadPITChannel0Count();
	__sti();
	return elapsedCounts;
}
