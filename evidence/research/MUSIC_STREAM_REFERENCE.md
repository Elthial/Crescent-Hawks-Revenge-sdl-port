# PC-speaker weapon-effect stream

## Entry path

`PlayPCSpeakerEffectByIndex_078C` at `3037:078C` is a far wrapper omitted from Reko's C
output. The assembly is short and unambiguous:

1. return immediately when `SoundEffectsEnabled_800A` is zero;
2. multiply the word argument by four;
3. load a far pointer from `PCSpeakerEffectStreamPointerTable_58DB[index]`;
4. call `StartPCSpeakerEffectStream_03B6` with that pointer.

`DS:58DB` is therefore a table of four-byte far weapon-effect stream pointers.
The index is the same `WeaponDefinition.effectId` used by the digital path.

`StartPCSpeakerEffectStream_03B6` stores the requested pointer in shared audio-timer state at
`426B:0018/001A`, clears the stop request, and raises the start request. On the
next timer service, `DecodePCSpeakerEffectTick_00DF` copies the pending pointer to
the active pointer at `426B:0012/0014` and begins at stream offset zero.

## IRQ consumption

`MusicTimerIRQ0Handler_0010`, installed on INT 08h by
`InstallMusicTimer_02D9`, calls `DecodePCSpeakerEffectTick_00DF`. Nonnegative
stream bytes `00h–5Fh` are pitch/note indices into the word divisor table at
`426B:0020`; the following byte supplies duration. A zero divisor silences the
speaker, otherwise it is written to PIT channel 2 and the speaker is enabled.
The initialized table is stored at executable image `3A6B:0020`; DOS relocation
by `0800h` paragraphs gives its runtime address `426B:0020`.

The high-byte command map is a first-pass reading of the handler:

| Opcode | Confidence | Action |
| --- | :---: | --- |
| `CDh` | V | Set loop/repeat counter `00E5` from next byte (zero becomes one). |
| `CEh` | V | Counted backward branch using counter `00E5` and a following word displacement. |
| `D1h` | V | Set loop/repeat counter `00E6` from next byte. |
| `D2h` | V | Counted backward branch using counter `00E6` and a following word displacement. |
| `E2h` | V | Set duration multiplier `00E4` from next byte. |
| `E6h` | V | Read a following word frequency in Hz, use `1193180 / frequency` as the PIT divisor, then read one duration byte. |
| `E8h` | V | Subtract the next byte from duration scale with byte wrapping. The original `JNO/JNZ` fallback can only select `01h` for an unreachable flag/result combination, so this is not unsigned saturation. |
| `E9h` | V | Add the next byte to duration scale; replace the result with `FFh` only on x86 signed overflow, otherwise retain the wrapped byte result. |
| `FFh` | V | End stream. |

`RequestPCSpeakerEffectStop_03E1` sets `426B:00E2`; the IRQ consumer silences the
speaker and clears active playback state.

The pointer table contains 16 monotonically ordered streams at image addresses
`326A:5642` through `326A:589D`; the final stream ends exactly where the table
begins at `326A:58DB`. Applying the widths above consumes every span exactly to
one `FFh` terminator. Across the real streams this accounts for ordinary note
events and every command byte actually present without an unknown opcode.
`E8h` and `E9h` do not occur in these 16 streams, but their state transitions
are now verified directly from `30B2:021F-0252` and with synthetic boundary
traces. Notably, `E8h` can produce zero or wrap to `FFh`; `E9h` clamps on signed
overflow (`7Fh + 01h`) but wraps on an unsigned-only carry (`FEh + 02h`). This
is executable behavior, even if the original composer never emitted the edge
cases.

The evidence exporter now executes both counted-loop pairs and the duration
state, including the exact signed-overflow behavior of `E8h/E9h`, resolves note indices through the exact divisor table, and emits the PIT
divisor, approximate integer frequency, source offset, duration scale, and
effective tick span for every expanded event. All 16 streams terminate within
the safety bound: 319 encoded instructions expand to 460 playback events and
2,088 duration ticks. Stream `02h` exercises nested loop counters; stream `0Fh`
expands 25 encoded instructions into 126 events over 1,464 ticks. These traces
verify the playback-state transitions without claiming a musical note naming
scheme that the driver itself does not store.

`RevengeTools inspect-speaker-effect` emits a source-offset-preserving trace for
one table index. `export-speaker-effect-evidence` writes all 16 encoded traces, expanded
playback traces, and a manifest to the ignored output directory.
