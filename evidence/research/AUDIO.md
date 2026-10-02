# Audio

## Verified local formats

All ten `.MUS` files are Standard MIDI format 0, with one track and 96 ticks per
quarter note. They can be parsed with any ordinary MIDI library; no Westwood
ADL decoder is needed.

The digital-sound table at `DS:5CFC` contains 22 records of 0Bh bytes and gives
the source resource, 32-bit file offset, byte length, and packed-buffer offset
for each sample. `REVENGE_31FB.c` requests 8,000 Hz (`1F40h`) playback.

The timer ISR at `375F:0A62` verifies the encoding: it reads source bytes
directly, mixes them around an `80h` silence centre, advances a 16.16 source
cursor, clamps/scales through a generated 256-byte table, and submits one byte
to the selected driver's hardware callback. These assets are therefore
unsigned 8-bit mono PCM at 8,000 Hz. `RevengeTools export-digital-sounds`
preserves byte-exact `.bin` slices and also emits canonical PCM `.wav` files.

`DS:5DEE-5E6Dh` is a packed set of NUL-terminated code lists used to select
the samples loaded into a scenario's resident narration bank.
`DS:5E6E-5F6Ah` is a second set of fragments concatenated according to the
scenario, narration mode, force index, and alternate-result state. Every byte
in both ranges—including `=`, `.`, and `!`—is a lookup key in the 22-record
sound table, not an interpreter opcode. RevengeTools resolves and reports every
fragment in `sequences.txt` and `manifest.json`.

The repeated `6633h` value is the descriptor's unity/reference playback scale.
Scenario narration stores `6633h` in the descriptor and requests `6633h` from
`CalculateDigitalSampleStep_07A2`, so the requested/stored scale ratio is
exactly 1.0. Weapon effects retain the same reference value but can supply a
different per-effect requested scale from `DS:5C5C`.

Weapon effects share IDs across two implementations. With a digital driver,
`PlayDigitalWeaponEffect_058D` indexes the 16 records at `DS:5C5C`; with the
PC-speaker driver (and always for sentinel effect `03h`),
`PlayPCSpeakerEffectByIndex_078C` indexes the 16 far streams at `DS:58DB`.
This proves that the latter streams are sound effects, not background music.
`DS:800A` is consequently `SoundEffectsEnabled_800A`; music enablement remains
the separate word at `DS:800C`.

## Digital sample descriptor (`34h` bytes)

Confidence `V` means verified directly against the `375F` assembly.

| Offset | Size | Meaning | Confidence |
|---:|---:|---|:---:|
| `00h` | 4 | next descriptor far pointer | V |
| `04h` | 4 | intrusive-list previous link | V |
| `08h` | 4 | owning queue far pointer; zero when unlinked | V |
| `0Ch` | 4 | original sample-data far pointer | V |
| `10h` | 2 | sample byte length | V |
| `12h` | 2 | loop/range start | V |
| `14h` | 2 | loop/range end | V |
| `16h` | 2 | loop/range length (`end - start`) | V |
| `18h` | 2 | source rate in Hz | V |
| `1Ah` | 2 | playback timing scale | V |
| `1Ch` | 4 | 16.16 source step (fraction, whole) | V |
| `20h` | 2 | near playback-handler offset | V |
| `22h` | 2 | fractional source cursor | V |
| `24h` | 4 | current source far pointer | V |
| `28h` | 4 | 16.16 remaining/range accumulator | V |
| `2Ch` | 4 | completion callback far pointer | V |
| `30h` | 4 | completion-callback argument | V |

Handler `0A7Ch` is idle, `0A82h` is one-shot playback, and `0AABh` is the
loop/range handler. The queue control block contains the first descriptor at
`+00h`, active descriptor count at `+0Ch`, mix bias at `+0Eh`, and the current
output sample at `+10h`.

## Generic PCM queue and mixer

The public stack-call routines in `375F:06C7-0999` are thin wrappers around a
register-call core. Those core contracts are now recorded explicitly in both
the DCProject and metadata include: queues arrive in `ES:DI`, descriptors in
`DS:SI`, and sample data or callbacks in `ES:DI` where applicable.

`InstallDigitalDriverQueueCallback_070C` consumes the nine-byte playback
descriptor selected through `DS:593E`. Its `+06h` field is the near write-byte
callback and `+08h` is the driver mix scale; the `+00h` hardware-descriptor
offset belongs to the separate acquire/release layer and must not be
dereferenced here. The routine binds the queue at `CS:04CC`, then combines the
driver and requested scales to rebuild the 256-byte saturated PCM lookup.

`CalculateDigitalSampleStep_07A2` forms two unsigned 16.16 ratios and
multiplies them using the exact four 16-bit partial products visible in the
assembly. The timer mixer subtracts that step from each descriptor's remaining
range, advances its source cursor, wraps looping ranges, calls completion
callbacks for exhausted one-shots, and emits the previous tick's mixed byte.

## Playback-rate calibration

`CalibrateDigitalPlaybackRate_05D6` builds a silent `34h`-byte descriptor at
`DS:6F70`, links it through the temporary queue at `DS:6F5E`, installs the
short-lived IRQ0 handler at `38AE:00D7`, and services exactly `0E0Dh` mixer
ticks. `EndPITCalibration_009B` latches PIT channel 0 and returns the elapsed
count in `DX:AX`; the caller divides `FFD0CE97h` by that count, halves the
result, and caps the selected playback rate at 8,000 Hz.

The normal digital playback timer has a separate queue at `DS:6F4C`. The
calibration code preserves the previous INT 08h vector, PIT divisor, and FLAGS
in `DS:6FA4-6FAA` and restores all three before returning.

## Supported devices

The local installer configuration lists:

- music: LAPC-I, MT-32, Sound Blaster, AdLib, IBM PS/1, Tandy, and PC speaker;
- sound: Sound Blaster, Game Blaster/CMS, Innovation, Covox PC Sound Master,
  AdLib, IBM PS/1, Tandy DAC/Tandy, and PC speaker.

The local active configuration selects Sound Blaster at port `0x220` for both
music and sound. Executable strings independently name the same major devices.

## PC-speaker bitstream path

Segment `373D` is now translated into ordinary C. It is a calibrated one-bit
sample player rather than a conventional PIT square-wave tone routine:

- `BeginPCSpeakerTimedOutput_000C` saves port `61h`, derives three busy-loop
  delays, disables the speaker output bit, and latches PIT channel 0.
- `WritePCSpeakerBitstream_004E` consumes packed sample bytes least-significant
  bit first and switches port `61h` between speaker-off and speaker-on values.
- `EndPCSpeakerTimedOutput_020B` restores port `61h` and returns the elapsed
  PIT channel-0 count used by the calibration routines in segment `3717`.

The assembly shifts the byte count right once and then consumes one 16-bit
packed word per iteration. The 48-byte calibration buffer is therefore played
as 24 words containing 384 one-bit samples.

The [Creative Music System for MiSTer compatibility
project](https://github.com/r-bengtsson/Creative-Music-Sound-System-for-MiSTer)
lists *The Crescent Hawk's Revenge* as confirmed with CMS for sound effects
only. It is a hardware-compatibility reference, not source code for the game's
audio format.

## Hardware-driver result

The device callback bodies are now maintained C rather than merely seeded.
Every sampled-audio backend uses programmed I/O. In particular, Sound Blaster
emits DSP direct-DAC command `10h` followed by one byte per mixer tick; there is
no DMA transfer in this implementation. DOSBox-X remains useful as a behavioral
oracle for audible comparisons, especially OPL and CMS volume response.

Derived WAV files remain confined to the gitignored tool output directory;
original resources are untouched.

## MIDI device drivers

The generic Standard MIDI parser dispatches through one null and five hardware
callback descriptors. Their corrected address map, hardware ports, maintained
C implementations, and register ABIs are documented in
[MIDI_DRIVERS.md](MIDI_DRIVERS.md). The device families are Internal Speaker,
Tandy, IBM PS/1, AdLib OPL2, and Roland MPU-401.

The separate PCM output layer is mapped in
[DIGITAL_SOUND_DRIVERS.md](DIGITAL_SOUND_DRIVERS.md). It covers nine hardware
families and distinguishes shared probe/acquire/release callbacks from the
initialize/release/write-byte callbacks consumed by the generic mixer.
