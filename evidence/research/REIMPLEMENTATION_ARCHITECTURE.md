# Revenge reimplementation architecture

This is the hand-off boundary between the evidence-preserving annotation tree
and a future playable implementation. The annotation C remains a translation
of the 16-bit executable; it is not the source tree for the new game. New code
should consume explicit binary contracts and reproduce observable behavior
without inheriting Reko's equivalence types, segmented-pointer syntax, global
register state, or compiler-runtime scaffolding.

## Source-of-truth layers

| Layer | Purpose | May be redesigned? |
|---|---|:---:|
| Original executable and data | Final oracle for bytes and DOS behavior | No |
| `Revenge-Reko-Expanded` | Regenerable disassembly/decompiler evidence | No |
| `ReverseEngineering/C` | Maintained semantic annotation of that evidence | Only when assembly supports it |
| `C/REVENGE_MODEL.h` | Portable packed binary contracts | Additively, with size/offset assertions |
| `RevengeTools` | Executable format proof, extraction, inspection, and safe editing | Yes |
| Future game runtime | Modern implementation of game behavior | Yes |

The future runtime must not include `REVENGE.h`. That header is Reko's type
graph and intentionally contains compiler artifacts. `REVENGE_MODEL.h` is the
small bridge: it currently fixes the layouts of weapon definitions, 96h-byte
unit records, UI regions, text windows, cached files, sound tables, tactical
ratings, save directories, the 221h-byte campaign snapshot, and far-heap
headers.

## Proposed runtime boundaries

1. **Formats** reads immutable DOS resources and writes only formats with a
   byte-exact round-trip proof. It owns little-endian decoding, record bounds,
   and preservation of unknown bytes.
2. **Campaign** owns campaign phase/stage, scenario selection, clock, pilots,
   persistent roster, save/load projection, and SCENE-driven state changes.
3. **Tactical** owns live 24-slot unit state, movement, visibility, AI,
   weapons, heat, damage, objectives, terrain effects, and lance assignment.
4. **Presentation** owns text windows, formatted-text control codes, menus,
   palettes, sprites, cursor overlays, and adapter-independent draw commands.
5. **Audio** owns Standard MIDI playback, unsigned 8-bit PCM mixing, the
   PC-speaker effect interpreter, and modern device backends.
6. **Platform** supplies input, timing, files, graphics surfaces, and audio
   sinks. No game rule should depend directly on DOS interrupts or I/O ports.

The original program's large `Seg3A6A` should become explicit state objects at
these boundaries. During migration, every extracted field retains its DS
offset and V/P/H/U confidence in a comment or schema table until tests replace
that provenance.

## First vertical slice

The lowest-risk playable slice is title/menu to campaign load, then one
scenario rendered without combat:

1. parse the resource directory and required images/fonts;
2. implement the 10h-byte text-window and UI-region records;
3. implement formatted text controls `00h`, `02h`, `06h`, `09h`, `0Dh`,
   `13h`, and `20h`, including the executable's packed high-bit expansion;
4. load the 221h-byte campaign snapshot and 24 96h-byte live unit records;
5. interpret one verified SCENE path and construct its two lance groups;
6. render the tactical map and unit sprites with deterministic input;
7. compare screenshots, state dumps, and save round trips against DOSBox-X.

Combat, AI, and audio can then be introduced behind the same state boundaries
without changing the binary readers.

## Fidelity policy

- Preserve shipped behavior where it differs from tabletop BattleTech. The
  verified minimum-range bonus is one example.
- Keep raw IDs and unknown bytes alongside semantic projections. Editors must
  never rebuild a record from only understood fields.
- Model coordinates, timers, heat, and arithmetic at their observed widths.
  Use wider host temporaries only when the original wrap/truncation point is
  applied explicitly.
- Keep asset decoding deterministic and side-effect free. Adapter-specific
  CGA/Tandy/EGA/VGA paths should decode to a common indexed surface, with
  compatibility renderers retained as test fixtures.
- Treat interrupts and port I/O as platform adapters: keyboard events, PIT
  ticks, vertical retrace, MIDI bytes, PCM samples, and speaker transitions.

## Verification gates

Before a subsystem is considered reimplemented it should have:

- bounds-checked parsing and malformed-input tests;
- byte-exact parse/serialize round trips where writing is supported;
- fixtures produced from original files in the gitignored output directory;
- state-transition tests using DS offsets and assembly traces as oracles;
- at least one end-to-end DOSBox-X comparison for visible or audible behavior;
- no dependency on Reko `Eq_*`, `Mem*`, `SEQ`, `SLICE`, artificial `out`
  parameters, or implicit segment registers.

The current annotation gate remains:

```powershell
C/tools/Test-AnnotationConsistency.ps1 -RunVerification
```

The current portable model can also be parsed as C11 with its compile-time
size and offset assertions enabled. Those assertions should be mirrored by
managed-language tests if the implementation remains C#.

## Remaining evidence risks

- controlled before/after saves are still required to promote mutable unit
  and pilot fields from P/H to V;
- several campaign snapshot subranges have verified geometry but unknown game
  semantics;
- the SCENE interpreter is structurally decoded, but not every opcode has an
  independently observed behavioral trace;
- some graphics routines retain segmented carry/pointer expressions because a
  pretty rewrite would currently be less accurate than the annotation;
- vehicle record locations use the executable's shared unit projection, not a
  proven tabletop vehicle-location mapping.

These are test-plan items, not reasons to carry decompiler syntax into the new
runtime.
