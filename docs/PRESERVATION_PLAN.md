# Behavioral-preservation policy

## Objective

Maintain a C17 reconstruction of `REVENGE.EXE` in which every original
assembly procedure has a traceable C procedure with behavior equivalent to the
executable.

This repository is the historical and behavioral reference for later ports.
It is not the place to redesign the game or invent missing behavior. Binary-
identical output is outside the current objective; behavioral identity and
evidence traceability are required.

## Authority of evidence

Resolve disagreements in this order:

1. original `REVENGE.EXE` assembly;
2. observed behavior of the original executable and its data;
3. maintained annotations and recovered data layouts;
4. decompiler output and superseded implementations as working evidence; and
5. external documentation where it agrees with the executable.

Decompiler output, tests and plausible BattleTech behavior are never authority
over the executable.

## Procedure identity

Every executable procedure retains:

- one stable `SEG:OFFSET` key;
- one reconstructed C procedure boundary;
- a leading address comment;
- one row in `METHOD_TABLE.csv`; and
- one row in `SOURCE_CONVERSION_TABLE.csv`.

Descriptive C names omit address suffixes. Files retain their `REVENGE_XXXX`
segment prefix and may be organized by domain or split only between original
procedure boundaries. Procedures may not be combined or decomposed into new
game-logic procedures for stylistic convenience.

The two ledgers answer different questions:

- `METHOD_TABLE.csv`: does the procedure preserve the assembly?
- `SOURCE_CONVERSION_TABLE.csv`: is that verified behavior expressed in the
  approved readable source model?

A move, rename or readability refactor does not change behavioral verification
status by itself.

## Verification states

### `Unchecked`

The procedure is known, but comparison with assembly is incomplete. Partial
understanding belongs in the evidence and uncertainty fields; there is no
intermediate “partially verified” status.

### `Verified`

The procedure matches the executable for its defined inputs and reachable
states, including:

- arguments, return value and calling-convention effects;
- branches, loops and call order;
- global and caller-visible state changes;
- integer widths, signedness, wrapping and carry/borrow-sensitive behavior;
- file, timing, input, graphics and audio effects; and
- reachable error and unusual-input paths.

This does not claim instruction-for-instruction or binary-identical output.

### `Verified [SDL]`

The same standard applies, except that a lowest-level DOS, BIOS, interrupt,
direct-hardware or host-representation operation is redirected to the approved
Support/SDL boundary. The ledger must name the redirect. The original wrapper,
inputs, outputs, control flow and game-visible behavior remain present.

## Source boundaries

### `src/Original`

Contains reconstructed executable procedures and executable-owned data. It may
use packed records, enums, constants and named globals established by evidence.
SDL headers and direct SDL calls are prohibited.

### `src/Support`

Contains necessary host representations with no claimed original procedure
boundary: for example, 16:16 address resolution, native callback dispatch and
indexed-framebuffer views. It may not own game decisions or replace an
original loop, branch or state transition.

### `src/SDL`

Implements the host side of original DOS, BIOS and hardware wrappers. The
normal call chain is:

```text
original game procedure
    -> original low-level wrapper
        -> Support bridge, when representation requires it
            -> SDL3 or operating-system service
```

Documented semantic intercepts, such as hosted AdLib voice synthesis and
cooperative timer servicing, remain exceptional and are marked
`Verified [SDL]`.

## Transcription rules

- Use C17 with conservative, 1990s-style formatting and control flow.
- Prefer literal, readable translation over architectural improvement.
- Preserve meaningful order of calls and writes.
- Use fixed-width types where C promotion or overflow could alter 16-bit
  behavior.
- Use established C terms for implementation details and verified BattleTech
  terms for game concepts.
- Keep uncertain fields and meanings visibly uncertain.
- Preserve observable stored far-pointer and segmented-memory behavior.
- Keep runtime and serialized save layouts distinct.
- Do not add bounds checks, initialization, normalization or error recovery
  absent from the executable unless a documented host boundary requires it.
- Do not change behavior merely to satisfy a new host-side test.

The readable data model and memory rules are detailed in
[`RECONSTRUCTED_C_PLAN.md`](RECONSTRUCTED_C_PLAN.md).

## Change workflow

For any behavioral or structural change:

1. identify the affected `SEG:OFFSET` rows;
2. inspect the complete procedure and relevant callers/callees in assembly;
3. establish arguments, return value, touched memory and platform effects;
4. implement without changing the original procedure boundary;
5. record unresolved facts rather than filling gaps with convenient behavior;
6. add or update focused regression evidence;
7. compare the final C with the complete assembly procedure;
8. update both ledgers and any affected annotation or memory-map names; and
9. commit at a coherent verification boundary.

For a pure documentation or naming change, prove that addresses, procedure
inventory and runtime source are unchanged, then run the ledger and relevant
build checks.

## Tests and acceptance

Tests protect established behavior but do not prove identity by themselves.
Strong evidence includes assembly-to-C control-flow comparison, original/C
state snapshots, original asset and save fixtures, emulator traces and focused
16-bit edge cases.

Manual play testing is required because connected campaign, timing, redraw and
input defects may not appear in isolated tests. Acceptance coverage is recorded
separately in [`CAMPAIGN_SMOKE_TEST.md`](CAMPAIGN_SMOKE_TEST.md).

## Prohibited drift

The preservation project does not permit:

- modern managers, services or context objects inserted into original logic;
- splitting, merging or replacing original game procedures;
- moving game decisions into Support or SDL;
- inferred campaign, tactical or combat behavior without executable evidence;
- treating a passing test as proof of original behavior; or
- using this tree as the architecture of a later C#/Godot redesign.

When clean design conflicts with traceability, this project chooses
traceability. A future redesign should consume this repository as evidence,
not reshape it into its own architecture.

## Commit discipline

Keep behavior, data-model changes, file moves, platform-boundary work and
documentation bookkeeping in separate commits where practical. A behavioral
commit names the affected procedure range and ledger changes. Git history is
the recovery mechanism for superseded experiments and the removed
`src/Rejected` implementation.
