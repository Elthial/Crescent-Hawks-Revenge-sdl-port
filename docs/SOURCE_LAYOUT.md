# Source and evidence layout

This document describes the current tree. It does not define new runtime
layers; the preservation rules remain authoritative in
[`PRESERVATION_PLAN.md`](PRESERVATION_PLAN.md).

## Runtime source

```text
src/
    Original/   reconstructed executable procedures and data
    Support/    host representation bridges
    SDL/        SDL3 and operating-system boundary
```

`src/Original` is organized by subject for navigation:

```text
Audio/      Campaign/   Data/       Graphics/   Input/
IO/         Resources/  Runtime/    Tactical/   Text/
UI/         Units/      Utility/
```

These directories do not change the original call graph. Filenames retain the
`REVENGE_XXXX` segment prefix and may add a topic suffix. A large segment may
be split only between original procedure boundaries. Every procedure keeps its
`SEG:OFFSET` in its leading comment and in both ledgers.

`src/Support` contains only facilities that have no original executable
procedure boundary, such as stored 16:16 address resolution, host callback
dispatch and indexed-framebuffer representation. It must not own gameplay
decisions.

`src/SDL` implements the host side of original DOS, BIOS, interrupt, input,
audio, video and filesystem wrappers. SDL headers and direct SDL calls are not
permitted in `src/Original`.

## Evidence and accounting

```text
evidence/
    annotations/  reviewed decompiler output and indexes
    assembly/     per-segment assembly listings
    metadata/     Reko project and procedure metadata
docs/
    METHOD_TABLE.csv
    SOURCE_CONVERSION_TABLE.csv
```

`METHOD_TABLE.csv` records behavioral verification against assembly.
`SOURCE_CONVERSION_TABLE.csv` independently records conversion to readable,
typed reconstructed C. A file move or readability change does not alter ASM
verification status.

Run `tools/Update-MethodTable.ps1` to refresh mechanical inventory fields and
`tools/Test-PreservationLedgers.ps1` to validate both ledgers. Manually audited
evidence and status fields must not be replaced by generated guesses.

## Other directories

- `include/` contains shared interfaces and packed data contracts.
- `tests/` contains focused behavioral and preservation tests.
- `tools/` contains validation, extraction and packaging utilities.
- `assets/original-game/` is an ignored local destination for legally obtained
  game data.
- `config/` contains the runtime configuration template used by packaging.
- `.github/` contains standalone repository CI.

The former `src/Rejected` tree was removed after its audit. Git history is the
recovery mechanism for that non-authoritative implementation.
