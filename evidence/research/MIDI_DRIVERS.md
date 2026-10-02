# MIDI driver descriptor and callback map

The music controller selects one null and five hardware 1Ch-byte descriptors
in `Seg3A6A`. Each
descriptor has the following verified physical layout. Callback purpose comes
from the generic calls and the callback bodies in `REVENGE_3621.c`.

| Offset | Size | Meaning | Confidence |
|---:|---:|---|:---:|
| `00h` | 2 | near pointer to NUL-terminated device name at `+1Ch` | V |
| `02h` | 1 | capability/configuration byte | P |
| `03h` | 1 | configured voice count, copied to `+1Ah` on activation | V |
| `04h` | 2 | probe/prepare callback | V |
| `06h` | 2 | activation callback; no C argument | V |
| `08h` | 2 | deactivation callback | V |
| `0Ah` | 2 | MIDI-byte filter callback; input and result are `AX` | V |
| `0Ch` | 2 | voice-on callback; `SI` is the 20h-byte voice record; AdLib also uses `DI` for instrument state | V |
| `0Eh` | 2 | voice-off callback; `SI` is the 20h-byte voice record | V |
| `10h` | 2 | reset callback | V |
| `12h` | 2 | instrument/patch loading callback; AdLib expands `SI` source into `DI` destination | V |
| `14h` | 2 | interrupt-time service callback | V |
| `16h` | 2 | device-private activation argument | V |
| `18h` | 2 | runtime first-voice-record offset | V |
| `1Ah` | 1 | runtime active voice count | V |
| `1Ch` | variable | NUL-terminated device name | V |

## Installed descriptors

All callback addresses are near offsets in segment `3621`.

| Descriptor | Device | `+04` | `+06` | `+08` | `+0A` | `+0C` | `+0E` | `+10` | `+12` | `+14` |
|---:|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| `6766h` | None | `08A8` | `08AC` | `08AD` | `08AE` | `08B1` | `08B2` | `08B3` | `08B4` | `08B5` |
| `678Eh` | Internal Speaker | `08B6` | `08BA` | `08D3` | `08DC` | `08DF` | `08F8` | `08FF` | `0922` | `0923` |
| `68A6h` | Tandy | `0970` | `098E` | `0992` | `09B1` | `09B4` | `09E9` | `0A05` | `0A5B` | `0A5C` |
| `6974h` | IBM PS/1 | `0A90` | `0AB6` | `0ABA` | `0ADD` | `0AE0` | `0B15` | `0B31` | `0B87` | `0B88` |
| `6A3Ch` | AdLib | `0C1D` | `0C76` | `0C87` | `0C93` | `0C96` | `0D5E` | `0D86` | `0DDD` | `0E5E` |
| `6BD8h` | Roland | `0E60` | `0E94` | `0EDA` | `0EF4` | `0F32` | `0F32` | `0F2E` | `0F32` | `0F33` |

The Roland descriptor deliberately reuses the one-byte return at `0F32h` for
voice-on, voice-off, and patch-loading slots because the MPU-401 path forwards
whole MIDI messages and does not use the software voice allocator in the same
way as the synthesized drivers.

## Immediate hardware evidence

- Internal Speaker programs PIT channel 2 (`42h`/`43h`) and toggles port `61h`.
- Tandy writes register/data pairs through port `C0h`.
- IBM PS/1 writes through port `205h`.
- AdLib probes and writes the OPL2 ports at `388h`/`389h`.
- Roland probes MPU-401 status/data ports `331h`/`330h`, installs IRQ `0Ah`,
  and maintains a 256-byte transmit ring buffer.

The callback words above are read directly from the six descriptors in the
original executable. Reko frequently starts procedures after their real entry
point in this block (for example it labels the second half of the Tandy probe
at `097Eh`, although the descriptor enters at `0970h`). Labels inside those
callback extents are control-flow blocks, not additional C procedure
boundaries. The descriptor addresses, rather than Reko's inferred entries,
govern the preservation transcription and method inventory.
