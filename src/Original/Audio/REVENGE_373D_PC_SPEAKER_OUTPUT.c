// REVENGE_373D_PC_SPEAKER_OUTPUT.c
// C17 preservation transcription of the PC-speaker hardware boundary.

#include "revenge/audio.h"
#include "revenge/platform_backend.h"

// 373D:000C: void BeginPCSpeakerTimedOutput(word16 delayScale)
void BeginPCSpeakerTimedOutput(word16 delayScale)
{
	SDLBackend_BeginPCSpeakerTimedOutput(delayScale);
}

// 373D:004E: void WritePCSpeakerBitstream(
//     const byte *sampleData, word16 byteCount)
void WritePCSpeakerBitstream(
	const byte *sampleData,
	word16 byteCount)
{
	/* 373D:0057-005A consumes byteCount >> 1 complete words. The platform
	 * boundary preserves that truncation before producing host audio. */
	SDLBackend_WritePCSpeakerBitstream(sampleData, byteCount);
}

// 373D:020B: word16 EndPCSpeakerTimedOutput(void)
word16 EndPCSpeakerTimedOutput(void)
{
	return SDLBackend_EndPCSpeakerTimedOutput();
}
