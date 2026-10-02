# Research backlog

This backlog contains only work that remains open after the September 2026
toolkit, SCENE, combat, graphics, music, save-layout, and runtime-library
passes. Completed capabilities are summarized first so they are not repeatedly
proposed as future work. Confidence remains V/P/H/U.

## Completed foundations

- `RevengeTools` inventories installations and bounded-decodes COL, Font v2,
  CPS, CMP, ICN, MAP, SCENE, `MECHTYPE.DAT`, save containers, embedded weapon
  definitions, hit-location tables, and PC-speaker weapon-effect streams.
- CPS/CMP/ICN assets and composed maps export to deterministic PNGs in ignored
  output directories. `MAP0.MAP` plus `ICONSET0.ICN` has a visual evidence
  match.
- The `96h` unit record has a complete static field map. The save container,
  campaign snapshot, 24-record live roster, and constrained editor are
  implemented; unknown bytes are preserved and no-op imports are byte exact.
- All 48 SCENE dispatch entries have verified operand widths. All 30 supplied
  files close under control-flow traversal, and SCENE1 has an end-to-end trace.
- The combat/damage core, music-stream command set, high-confidence graphics
  path, far-string/memory runtime, CRT file I/O, and integer-formatting runtime
  have maintained C translations and Reko contracts.
- The tactical AI frame is translated from contact and target selection through
  preferred-range policy, route/formation/jump movement, weapon-priority
  selection, attack resolution, and heat shutdown. Its range/heat weapon lists,
  attacked-frame counters, and shared overburn/infantry-close-assault state at
  DS:890C are mapped.
- The music resource controller, interactive fixed-width text editor, and
  active text-window clear/frame composition paths have maintained C and Reko
  contracts. `DS:5CFC` is verified as 16h digital-sound records of 0Bh bytes;
  RevengeTools resolves their resource descriptors and exports all 22 exact
  sample spans from `INFOCOM.BIN` and `DPHRASES.BIN`.
- The current verification suite passes 82 assertions. The consistency gate is
  `C/tools/Test-AnnotationConsistency.ps1 -RunVerification`.
- The complete programmed-I/O PCM and MIDI hardware callback blocks are
  maintained C. This includes nine PCM outputs, the null MIDI backend, PC
  speaker, Tandy, IBM PS/1, AdLib OPL2, and Roland MPU-401 UART/IRQ handling.

## Active high-value work

The sampled-audio sequence tables are complete. `DS:5DEE-5E6D` contains the
scenario bank-load code lists and `DS:5E6E-5F6A` contains playback fragments;
every byte is a `DS:5CFC` sample key. `6633h` is the hardware-independent unity
reference scale used by the descriptor step calculation. RevengeTools exports
the resolved fragments, byte totals, and durations with the sample evidence.

The modal UI selection and text-window families are complete enough to stop
appearing as generic low-hanging work; revisit them only from a concrete
caller that exposes a still-unknown record field.

### 1. Remaining whole-routine pseudocode repair

The current retained markers are not suitable for another blind mechanical
pass. Work assembly-first, one complete routine at a time, prioritizing files
where a repaired contract will improve several callers:

1. date/time and locale helpers in `REVENGE_3A07.c` where DOS/BIOS contracts
   expose complete behavior;
2. lower-reference campaign helpers only when a concrete caller exposes their
   record fields;
3. lower-reference graphics helpers only when their far-pointer or carry-chain
   behavior can be represented without loss.

`SEQ`, `SLICE`, `out`, and segmented expressions are not defects by
themselves. Remove them only when the full data flow is understood.

### 2. SCENE semantic refinement

Decoder completeness is finished. Remaining work is to replace conservative
operation labels with verified game semantics by tracing their helpers and
live effects, especially:

- controlled-play identities for the unused `D4h` selectors 04h/05h;
- the narrative identity of the four campaign-award slots touched by `D5h`;
- controlled confirmation of the proposed `FCh` tactical-order labels;
- the impact-visual queue contract at `2007:0846` and the MECHSET filename
  selector at `0D73:02B4` are complete; remaining work is loader translation;
- speaker-bank identities where executable or controlled evidence exists.

Do not change opcode widths or control-flow behavior without contradictory
assembly evidence.

## Evidence-gated experiments

These items cannot be promoted safely from the current broad campaign
checkpoints. They require deliberately isolated saves or emulator captures.

### Controlled save pairs

Capture before/after pairs for exactly one change at a time:

1. horizontal movement;
2. vertical movement;
3. one ammunition-consuming shot;
4. one armor hit without internal damage;
5. one internal hit;
6. heat gain and one cooling step;
7. mobility/engine/sensor damage;
8. pilot, experience, and allegiance changes;
9. one scenario/completion flag transition.

Run `compare-save` and `analyze-save-set` over each evidence set. Promote a
field to V or make it editor-writable only when the changed offsets repeat and
all correlated constraints are known.

### Vehicle record-sheet projection

The executable proves that vehicles reuse the BattleMech-shaped arrays and
directional hit tables, but it does not yet prove how raw indices project onto
front, left side, right side, rear, turret, and motive-system locations.
Capture controlled attacks from each direction against turreted and turretless
vehicles before applying BattleTech vehicle names to those indices.

### Audio phrase identification

The direct-DAC programmed-I/O path, 8,000 Hz rate, exact sample boundaries,
and scenario code sequences are verified. A DOSBox-X or Spice86 capture is now
useful only for assigning human-readable spoken text to the 20 `DPHRASES.BIN`
samples and checking audible backend differences; no DMA or boundary discovery
remains.

## Open questions

- Why does the original MAP writer preserve a duplicate of the first eight
  tile IDs between the dimensions and the complete tile grid?
- What are the semantic roles of the effect/UI rows after the unit sprite
  ranges in the two now-mapped MECHSET profiles?
- What are the exact meanings of mutable unit bytes `00h`, `8Bh`, `8Ch`,
  `8Eh`, and `92h–95h` under controlled play?
- Which “lost feature” strings still have reachable code paths?
- Which unresolved campaign snapshot fields at save offsets `0008h–006Bh`
  drive branches rather than presentation?

## Research discipline

- Preserve hashes for every source binary used in an experiment.
- Prefer a pair of files differing in one controlled action.
- Keep decoders read-only until round-trip semantics are proven.
- Record executable version/hash with every absolute offset.
- Separate observed bytes from interpretation in schemas and code.
- Update C, docs, toolkit models, `REVENGE.dcproject`, and
  `REVENGE-metadata.inc` in the same semantic commit.
- Run the annotation consistency gate before committing.
