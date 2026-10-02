# Reconstructed-C source model

## Purpose

The preservation source should resemble plausible original C rather than a
literal dump of decompiler syntax. Readability must come from recovered types,
names and data relationships—not from redesigning the program.

The readable-C migration is complete: all 785 executable procedures are
`Validated` in [`SOURCE_CONVERSION_TABLE.csv`](SOURCE_CONVERSION_TABLE.csv).
This document now records the resulting design and the rules for maintaining
it.

## Non-negotiable invariants

1. Assembly remains the behavioral source of truth.
2. Every original `SEG:OFFSET` retains one C procedure boundary.
3. Procedure addresses remain in comments and ledgers, not in C identifiers.
4. Control flow, call order, integer widths and observable state changes remain
   recognisable beside the assembly.
5. Known data uses named globals, arrays, enums and packed records.
6. Unknown data remains explicitly uncertain and address-traceable.
7. Support and SDL may represent the host, but may not absorb game decisions.
8. A readability change does not upgrade behavioral verification.

## Source organization

`src/Original` is grouped by domain solely for navigation. Files retain their
original segment prefix and may be split only between original procedures.
See [`SOURCE_LAYOUT.md`](SOURCE_LAYOUT.md) for the current directories.

The desired procedure body uses BattleTech terminology and ordinary C data
access where evidence supports it:

- `PersistentUnitRoster[unitIndex]`, not a raw DS offset;
- structure assignment for complete typed records;
- named weapon, armor, location and campaign constants;
- native strings for recovered text tables; and
- named buffer views for known graphics storage.

Raw address operations remain appropriate when the executable observes the
numeric DOS representation or when a field's meaning is unresolved.

## Memory model

### Canonical storage and aliases

Executable-owned ranges that alias, overlap, relocate or participate in
pointer arithmetic retain a canonical DOS-oriented representation. Named views
must refer to the same bytes rather than silently creating independent state.

Important aliases include:

```text
426A:0000 == 4184:0E60
4184:08D3 == 3A6A:7A73
```

Packed structures use fixed-width fields and `_Static_assert` checks for sizes
and significant offsets.

### Stored 16:16 addresses

Use `DosAddress` or explicit offset/segment words when the original stores,
compares, serializes, wraps or independently modifies either half. Resolve the
address only at the point where the original dereferences or dispatches it.

This applies especially to relocated tables, file/resource descriptors, heap
state, interrupt vectors, hardware apertures and audio descriptors. Ordinary
host pointers are acceptable only after proving that their DOS numeric value
is unobservable.

### Runtime and save data

Runtime records and serialized save records are distinct types. Save/load
procedures retain the original field-by-field mapping; native host structure
layout must never determine the file format.

## Platform boundary

The normal shape is:

```text
original game procedure
    -> original DOS/BIOS/hardware wrapper
        -> Support representation bridge, if required
            -> SDL3 or operating-system implementation
```

The hosted AdLib path is the documented exception: it intercepts the original
semantic voice callbacks before OPL register encoding while leaving the DOS
OPL branch available for provenance. The intercept receives the same voice,
note, velocity, program and voice-class state; it does not replace music
selection or sequencing logic.

Cooperative calls to `SDLBackend_ServiceTimers` emulate asynchronous PIT/BIOS
interrupt progress on the single-threaded host. Procedures containing those
injected service points are `Verified [SDL]`; original timing calculations and
handlers remain unchanged.

## Ledgers and validation

`METHOD_TABLE.csv` answers: “Does this C procedure preserve the assembly?”

`SOURCE_CONVERSION_TABLE.csv` answers: “Has it been expressed in the approved
readable source model?” Its statuses are:

| Status | Meaning |
| --- | --- |
| `Pending` | Not reviewed for the reconstructed-C model |
| `Mapped` | Dependencies are named or typed, but representation remains raw |
| `Converted` | Uses the intended data model and source location |
| `Validated` | Compared with assembly and the prior representation; relevant tests pass |

All rows are currently `Validated`. Future discoveries may legitimately move a
row back to an earlier state while uncertainty is resolved.

## Maintenance rules

- Prefer evidence-backed names over address arithmetic at use sites.
- Preserve the address in the declaration, memory map, annotation and ledger.
- Do not invent helper procedures that split an original procedure's game
  logic. Non-procedural expressions are preferable for small repeated layouts.
- Do not move original adapter algorithms into SDL merely because they concern
  graphics or audio.
- Do not add safety behavior, normalization or error recovery absent from the
  executable without documenting it as a host-boundary requirement.
- Keep unresolved names conservative; clarity about uncertainty is better than
  a plausible but false BattleTech label.
- Update both ledgers and focused tests with any structural change.

The pre-refactor checkpoint is commit `10f79d6`. Later history is summarized in
[`RECONSTRUCTION_HISTORY.md`](RECONSTRUCTION_HISTORY.md).
