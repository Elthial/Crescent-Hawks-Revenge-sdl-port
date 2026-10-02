# RevengeTools implementation plan

## Goal

Create a maintained, command-line toolkit for inspecting, extracting, and
safely editing files from a user-supplied installation of *The Crescent Hawk's
Revenge*. The toolkit must do more than produce plausible pictures: each parser
must expose structural evidence, enforce bounds and invariants, and have a
repeatable verification route back to the original files or observed game
behaviour.

The maintained projects should live at the game root, parallel to the
Inception toolkit:

```text
CrescentHawksRevenge/
  RevengeTools/
  RevengeTools.Verification/
  RevengeTools.sln
```

`ReverseEngineering/tools/` remains the home of emulator and analysis hosts
such as `Revenge.Spice86`; it should not contain the user-facing asset toolkit.

## Lessons to carry forward from InceptionTools

Retain these proven design choices:

1. A dependency-free .NET 8 CLI with explicit subcommands rather than an
   interactive menu.
2. A bounds-checked immutable binary reader beneath every parser.
3. Separate format records, semantic inspectors, exporters, and CLI adapters.
4. `--game-dir`, environment-variable, and ignored local-installation discovery.
5. Case-insensitive installation filenames with path traversal rejected.
6. Text and `--json` inspection modes, deterministic output, overwrite refusal,
   and opt-in `--force` for generated artifacts.
7. Synthetic verification fixtures in Git and read-only integration checks
   against the ignored original installation.
8. Save editing by cloning the exact source, preserving unknown bytes, requiring
   a SHA-256 fingerprint, and writing to a different output path.

Do not reference `InceptionTools` as a library. Copy or extract only genuinely
game-independent primitives once their behaviour is covered by tests; keep the
Revenge file models independent so similarly named Westwood formats are not
mistaken for identical layouts.

## Proposed project structure

```text
RevengeTools/
  Program.cs
  Binary/             bounded reads, endian helpers, bit readers
  Installation/       locator, inventory, validation, hashes
  Formats/
    Palettes/          COL
    Graphics/          CPS, CMP, ICN, indexed PNG
    Fonts/             Westwood Font v2
    Maps/              MAP grid and later map composition
    Units/             MECHTYPE 96h-byte records
    Scenes/            SCENE container and eventual instruction records
    Saves/             SAVEGAME container, slots, snapshots, live units
    Audio/             MIDI inspection and raw BIN evidence
  Inspection/         text/JSON reports
  Export/             PNG, JSON, CSV, WAV where verified
  SaveEditing/        typed state, text format, validation, patch/diff service
```

Use `BTCHR_GAME_DIR` for the Revenge installation environment variable and
fall back to an ignored `Chrevenge/` directory. A valid installation must
contain `REVENGE.EXE`; `SAVEGAME.DAT` is optional for installation validity.

## Command surface

The initial public command set should be:

```text
help
inventory [--hash] [--json] [--output FILE]
inspect FILE [--offset N] [--count N]

inspect-palette FILE [--json]
export-palette FILE [--output FILE.png] [--force]
inspect-image FILE [--json]
export-image FILE [--palette FILE.COL] [--output FILE.png] [--force]
export-images [--output-dir DIR] [--force]
inspect-font FILE [--json]
export-font FILE [--output FILE.png] [--force]

inspect-map FILE [--json]
export-map FILE [--output FILE.png] [--metadata FILE.json] [--force]
export-maps [--output-dir DIR] [--force]

dump-unit-types [--json|--csv] [--output FILE]
dump-unit-type ID [--json]
inspect-scene FILE [--json]

dump-save FILE [--json]
dump-save-slot FILE SLOT [--json]
export-save-state FILE SLOT [--output FILE.txt] [--force]
import-save-state FILE SLOT STATE.txt [--output FILE] [--dry-run] [--force]

inspect-midi FILE [--json]
inspect-sample FILE [--json]
export-sample-wav FILE --rate HZ [--output FILE.wav] [--force]
```

Every installation-reading command also accepts `--game-dir PATH`. Numeric
arguments accept decimal and `0x` hexadecimal forms. Inspection is always
read-only. Batch exporters preflight every output before writing any file.

## Delivery phases

### Phase 0 — safe CLI foundation

Create the two projects, solution, locator, bounded reader, generic hex
inspection, inventory, JSON/text reporting, output collision checks, and a
synthetic verification harness.

Inventory must classify all known families and verify the current structural
facts: 39 CPS, 22 COL, 18 ICN, 11 MAP, 30 SCENE, ten MUS, eight BIN, two FNT,
89 `MECHTYPE.DAT` records, and the `61C0h` save-container length when a save is
present. Counts are profile evidence, not a reason to reject an installation
that contains additional files.

**Exit gate:** missing required files and invalid lengths are reported without
reading beyond any file; `inventory --json` is deterministic; synthetic tests
cover malformed paths, truncation, extra files, and hashes.

### Phase 1 — independently viewable assets

Implement formats in increasing dependency order:

1. COL: 256 three-byte 6-bit palette entries and palette-strip PNG export.
2. Font v2: bounded 128-entry glyph-offset table and contact-sheet export.
3. CPS: all three compression markers present locally, with exact 64,000-byte
   decoded-output enforcement.
4. CMP/ICN: first parse the shared length/compression envelope, then establish
   decoded dimensions and pixel packing independently for each family.
5. MUS: Standard MIDI header, track, division, event-count, and duration
   inspection. The source is already a standard interchange file, so copying
   it to another extension is not an extraction feature.

Known palette selection should be an explicit filename-to-palette profile with
its evidence recorded. `--palette` must allow the user to override it. Never
silently choose a palette based only on matching basenames.

**Exit gate:** every local file in a supported family decodes within bounds;
decoded sizes are exact; PNG outputs are deterministic; selected renders match
known screenshots or reference art; malformed synthetic streams fail at the
precise offending offset.

### Phase 2 — units and the save editor

Implement the `96h` unit record once and reuse it for `MECHTYPE.DAT`, persistent
roster analysis, live save-slot units, JSON output, and editing validation.
Fields retain V/P/H/U confidence in the model or accompanying metadata; unknown
bytes remain accessible as raw data but are not casually given semantic names.

Parse the complete `SAVEGAME.DAT` container:

- boundary table and six 22-byte slot descriptors;
- six `1031h` payloads;
- `0221h` campaign snapshot;
- 24 live unit records at payload offset `0221h`;
- slot labels and occupancy state.

The first editor release should expose all mapped fields in its text export but
permit writes only to fields that have passed a controlled in-game mutation
test. Start by proving one field group at a time: slot label, current armor and
internal structure, ammunition, pilot/experience, then campaign fields. Type,
maximum-stat, allegiance, critical-slot, and unknown runtime changes remain
read-only until their cross-field constraints are understood.

Required safety behaviour:

- fingerprint the entire source save and identify the selected slot;
- clone the complete `61C0h` container and patch only changed fields;
- refuse source overwrite even with `--force`;
- support `--dry-run` and print offset, field path, old byte, and new byte;
- enforce record counts, ID ranges, current values not exceeding maxima, and
  derived ammunition limits where known;
- preserve unselected slots and every unknown byte exactly;
- produce a byte-identical output for an unchanged export/import.

**Exit gate:** no-op round trips match SHA-256 for the repository save and all
five winning-save files; one-field synthetic edits change only the expected
bytes; local disposable-copy tests load, display, save, and reload each newly
enabled field group in the original game.

### Phase 3 — map and sprite extraction

Parse the verified MAP header (`width`, `height`, eight raw metadata bytes, then
`width * height` tile IDs). Keep the metadata raw until each byte has evidence.
Determine the scene/map/icon-set/palette relationships from executable calls,
SCENE data, and controlled captures.

Decode ICN sprite/tile sheets before attempting composition. Export both a
labelled sprite sheet and JSON rectangles/indices so later map rendering does
not hide assumptions. Compose maps only after tile dimensions, storage order,
and transparency have explicit tests.

**Exit gate:** raw MAP round trips are byte exact; every tile ID resolves within
the selected ICN catalog; at least one exported map matches a supplied stitched
map at the pixel level or has every remaining mismatch documented by category.

### Phase 4 — SCENE data

Begin with a lossless structural inspector: file length, offset table, bounded
regions, strings, repeated records, and cross-file comparisons. Then trace the
load/dispatch routines before assigning opcode semantics.

The eventual `inspect-scene` output should retain source offsets and raw bytes,
show scene-to-map/resource references, and label uncertain records as raw or
hypothesized. Do not call it a disassembler until control flow and operand
lengths are proved.

**Exit gate:** all 30 files parse without overlap or out-of-range offsets;
re-serialization is byte exact; at least one traced scenario links its file
records to observed map, units, objectives, and transitions.

### Phase 5 — sampled audio and broader extraction

Treat the eight BIN files as raw evidence. The executable's digital-sound table
provides exact spans, and the recovered timer ISR proves unsigned 8-bit mono
PCM at 8,000 Hz. Export byte-exact raw slices and derived WAV files together.
Phrase segmentation still comes from the executable table rather than treating
`DPHRASES.BIN` as one continuous clip.

PC-speaker stream inspection can follow the documented executable decoder.
Standard MIDI playback or conversion should use established MIDI tooling rather
than a bespoke musical-event parser unless exact game-driver behaviour is the
research target.

**Exit gate:** sample rate and phrase boundaries cite executable/emulator
evidence; generated WAV duration and playback match a DOSBox-X or Spice86
capture closely enough to state the remaining timing error.

## How format understanding is proved

Each supported format requires all of the following, not merely a successful
export:

| Proof | Requirement |
| --- | --- |
| Structural | Header fields, lengths, offsets, counts, and bounds agree for every local file. |
| Negative | Truncated, overlapping, impossible, and unknown-variant synthetic inputs are rejected. |
| Deterministic | Repeated JSON, CSV, PNG, and text exports are byte identical. |
| Lossless | Raw structures reserialize exactly, or unsupported bytes are preserved verbatim. |
| Semantic | At least one field or rendering is correlated with executable code or controlled game behaviour. |
| Visual/audio | Rendered assets are compared with screenshots, stitched maps, or emulator captures. |
| Documented | Every inferred field carries V/P/H/U confidence and cites its evidence. |

Commit only synthetic fixtures, compact metadata, hashes, and derived source
code. Original installation assets and routine extraction output remain under
ignored local paths such as `Chrevenge/` and `artifacts/`.

## Implementation progress

Phases 0 through 4 are implemented to their current evidence boundary:

- the installation locator, inventory, bounded reader, deterministic reports,
  collision checks, and synthetic verification harness are complete;
- COL, Font v2, all three local CPS variants, CMP type 2, and all 18 ICN files
  bounded-decode and export deterministic images/manifests;
- ICN-backed MAP composition reproduces the supplied `MAP0.MAP` plus
  `ICONSET0.ICN` evidence; the SCENE corpus now resolves all eleven MAP-to-ICN
  pairs, and the former "metadata" bytes are verified duplicated tile prefixes;
- the shared `96h` unit parser, embedded weapon/hit-table inspectors, complete
  save-container parser, semantic comparison tools, and constrained editor are
  implemented. Slot labels, current armor/internal structure, and ammunition
  are writable; other fields remain read-only pending controlled captures;
- all 30 SCENE files expose their container, resource selectors, message banks,
  bytecode, and control-flow evidence. All 48 dispatch entries have verified
  widths and SCENE1 has an end-to-end trace;
- the 16 embedded PC-speaker streams have bounded encoded and expanded PIT
  traces, including exact loop and signed-overflow behavior.

`RevengeTools.Verification` currently passes 82 assertions. Extraction and
evidence output defaults to the ignored `RevengeTools.Output/` tree.

Phase 5 remains evidence-gated. The next asset-tool extension should follow a
trace of the digital sampled-audio command path and DMA programming, not guess
sample rates or phrase boundaries from the raw BIN files. See
`RESEARCH_BACKLOG.md` for the current prioritized work rather than treating the
completed phase descriptions above as an active queue.
