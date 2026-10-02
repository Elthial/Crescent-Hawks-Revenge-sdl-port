# Crescent Hawk's Revenge reverse-engineering notes

This directory is the working reference for the DOS release of *BattleTech: The
Crescent Hawk's Revenge*. It summarizes public research and observations made
against a local installation without committing copyrighted game data.

## Reference pages

- [Reko `.dcproject` reference](REKO_DCPROJECT_REFERENCE.md) — project ingestion,
  signatures, register assumptions, annotations, typed data, jump tables,
  metadata headers, output control, and scripting.
- [Reko pseudocode reference](REKO_PSEUDOCODE_REFERENCE.md) — generated
  expressions, inferred types, SSA names, x86 registers, segmented memory, and
  safe translations into ordinary C-style notation.
- [Westwood file formats](WESTWOOD_FILE_FORMATS.md) — formats that are directly
  present, likely related, or useful only as later-engine comparisons.
- [Tactical icon format](TACTICAL_ICON_FORMAT.md) — length-prefixed `*.ICN`
  resources, signed-run decoding, layout selectors, and adapter conversion.
- [Local file inventory](LOCAL_FILE_INVENTORY.md) — verified sizes, headers, and
  structural invariants from the local installation.
- [Unit records and equipment](UNITS_AND_EQUIPMENT.md) — the 150-byte unit
  record, IDs, loadouts, and open questions.
- [96h-byte unit record](UNIT_RECORD_96H.md) — field-by-field runtime and save
  layout with V/P/H/U confidence.
- [Scenario roster preparation](SCENARIO_ROSTER_REFERENCE.md) — `DS:B581`
  scene mapping, roster recipes, lance compaction, and associated state.
- [High-reference DS triage](DS_HIGH_REFERENCE_TRIAGE.md) — UI regions, active
  text state, cached-file descriptors, handles, and draw geometry.
- [Game and scenario structure](GAME_STRUCTURE.md) — campaign phases, branches,
  and likely scenario boundaries.
- [Characters and forces](CHARACTERS_AND_FORCES.md) — a compact identity and
  faction reference for interpreting scripts and saves.
- [Save-game reference](SAVEGAME_REFERENCE.md) — the attached winning-save set,
  hashes, comparison results, and safe experiment design.
- [Controls](CONTROLS.md) — keyboard and mouse command reference.
- [Audio](AUDIO.md) — MIDI, sampled audio, supported devices, and emulator plan.
- [PC-speaker weapon-effect stream](MUSIC_STREAM_REFERENCE.md) — indexed entry wrapper,
  pointer table, verified IRQ command semantics, and expanded PIT traces.
- [SCENE file structure](SCENE_FORMAT.md) — container, interpreter dispatch,
  operands, control flow, and evidence tooling.
- [SCENE1 end-to-end trace](SCENE1_TRACE.md) — resource selection, roster
  setup, message banks, unit initialization, and objective/event flow.
- [RevengeTools implementation plan](REVENGE_TOOLS_PLAN.md) — CLI architecture,
  asset-extraction milestones, proof requirements, and save-editor safety gates.
- [Reimplementation architecture](REIMPLEMENTATION_ARCHITECTURE.md) — boundary
  between executable evidence, portable binary contracts, runtime subsystems,
  the first playable vertical slice, and fidelity/verification gates.
- [Research backlog](RESEARCH_BACKLOG.md) — confirmed facts, leads, and next
  experiments.
- [Research goals](RESEARCH_GOALS.md) — ordered working milestones and their
  completion criteria, current verification baseline, and iteration history.
- [Sources](SOURCES.md) — provenance, access status, and confidence policy.

## Evidence labels

- **Verified locally** — reproduced from the local game files.
- **Documented** — stated by a format specification or game reference.
- **Community finding** — reverse-engineering result reported by a third party;
  useful, but not yet independently reproduced here.
- **Hypothesis** — an inference or a proposed experiment, not an established
  format fact.

Offsets are hexadecimal unless stated otherwise. Multi-byte values are little
endian unless a page explicitly says otherwise.

## Consistency gate

Run the following from `ReverseEngineering/C` after changing maintained C,
`REVENGE.dcproject`, `REVENGE-metadata.inc`, or the baseline documents:

```powershell
tools/Test-AnnotationConsistency.ps1 -RunVerification
```

Without `-RunVerification` it performs only the fast static metadata and
documentation checks.
