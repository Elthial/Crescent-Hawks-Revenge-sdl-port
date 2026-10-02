# Digital-sound hardware and playback drivers

The digital PCM path uses two linked descriptor layers in `Seg3A6A`.
`DigitalSoundDriverDescriptorOffsets_593E` chooses a playback descriptor. Its
first word points to a hardware descriptor used for detection and shared
ownership. The remaining callbacks initialize a device-specific output path
and accept one unsigned PCM byte in `AL` on every mixer tick.

## Hardware descriptor

| Offset | Meaning | Confidence |
|---:|---|:---:|
| `00h` | near pointer to device name | V |
| `02h` | default probe/acquire parameter, normally an I/O base port | V |
| `04h` | count of alternate probe parameters | V |
| `06h` | near pointer to the alternate-parameter word list | V |
| `08h` | probe callback, result in `AX` | V |
| `0Ah` | acquire callback, numeric parameter in `DX` | V |
| `0Ch` | release callback | V |
| `0Eh` | acquisition reference count | V |

## Playback descriptor

| Offset | Meaning | Confidence |
|---:|---|:---:|
| `00h` | hardware-descriptor offset | V |
| `02h` | initialize-output callback; requested rate in `AX` | V |
| `04h` | release-output callback | V |
| `06h` | write-one-sample callback; unsigned PCM byte in `AL` | V |
| `08h` | mixer scale/capability word copied by `375F:070C` | V |
| `0Ah` | playback acquisition reference count | V |

## Driver matrix

All code addresses are near offsets in segment `375F`.

| Index | Playback descriptor | Device | Hardware descriptor | Probe/acquire/release | Initialize/release/write |
|---:|---:|---|---:|---|---|
| `0` | `0000h` | PC-speaker fallback | — | — | handled by segments `3717`/`373D` |
| `1` | `6EBEh` | Tandy 1000 3-Voice Sound | `6D40h` | `0076/0095/0096` | `02F2/02FB/02FC` |
| `2` | `6ED6h` | PS/1 Audio Card | `6DA2h` | `00CC/00F3/00F4` | `031E/0325/0326` |
| `3` | `6ECAh` | Tandy Advanced Digitizing Sound System | `6D6Ah` | `0098/00CA/00CB` | `030C/0319/031A` |
| `4` | `6EEEh` | AdLib PC Music System | `6DECh` | `0190/01E9/01F5` | `033A/0366/036C` |
| `5` | `6EE2h` | Sound Blaster | `6DC2h` | `011B/0143/014F` | `032C/032D/032E` |
| `6` | `6F40h` | Covox PC Sound Master | `6E84h` | `02AB/02AE/02C0` | `04AE/04B4/04B5` |
| `7` | `6F34h` | Innovation Sound Standard | `6E52h` | `026A/026D/0282` | `049C/049D/049E` |
| `8` | `6F28h` | Game Blaster / Creative Music System | `6E12h` | `0225/0228/0260` | `0376/0387/038C` |

The null descriptor at `6EB2h` points to the `Nothing` hardware descriptor at
`6D28h`; it is also used internally while the generic timer mixer is installed.

## Immediate hardware evidence

- Tandy paths use ports `C0h`, `C1h`, `C4h`, `C5h`, and `C7h`.
- IBM PS/1 uses ports `200h` and `203h`.
- Sound Blaster derives ports from the configured base and performs DSP reset,
  status polling, and byte I/O in `011Bh-018Fh`.
- AdLib performs the OPL timer/status probe at base port `388h`.
- CMS initializes paired register banks and writes output through its configured
  base port.
- Innovation writes its DAC port directly.
- Covox writes unsigned output bytes to its configured parallel-port data port.

The complete callback block is translated in `REVENGE_375F.c`. All devices use
programmed I/O: the Sound Blaster path selects DSP command `10h` (direct DAC)
for each sample rather than DMA. The DCProject includes the internal DSP, OPL,
CMS, and Covox helper entry points and the metadata include fixes every
device-private code-segment field and the 100h-byte CMS amplitude table.
