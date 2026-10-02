# Reconstruction history

This is a historical summary, not a source of current build or preservation
instructions. Use the repository README and
[`PRESERVATION_PLAN.md`](PRESERVATION_PLAN.md) for current guidance.

## 1. Decompilation and annotation

The executable was segmented, decompiled with Reko and supplemented with
assembly listings where the decompiler failed. Procedure metadata, annotations
and recovered data layouts were maintained separately from the early port.

## 2. Preservation reset

The early behavior-oriented implementation had diverged from the requested
one-to-one historical model. It was renamed `src/Rejected`, audited for useful
evidence and then removed. A new `src/Original` was populated procedure by
procedure from annotations and assembly. Git history retains the rejected tree.

An address-keyed method table introduced three durable outcomes:

- `Verified` for behaviorally matched procedures;
- `Verified [SDL]` where only the DOS or hardware edge differs; and
- `Not a procedure` for two evidence rows initially mistaken for code.

The audit closed at 588 `Verified`, 197 `Verified [SDL]`, no unresolved
procedure status, and two non-procedure rows.

## 3. Complete executable

Work proceeded from the application edges inward: runtime and file I/O,
graphics, input, audio, resource loading, typed unit records, tactical systems,
campaign stages and finally the campaign driver. The resulting C17 program
linked as `Revenge.exe` and used SDL3 only below preserved wrappers.

Focused tests were added for DOS redirects, 16-bit runtime behavior, graphics
primitives, text, resources, MIDI, sampled audio and BattleTech mechanics.

## 4. Reconstructed original C

Commit `10f79d6` marks the verified pre-refactor checkpoint. The following
readability pass adopted the successful Inception style without changing
procedure boundaries:

- grouped `src/Original` into human-readable domains;
- replaced fixed DS access with named objects and packed records;
- typed the 0x96-byte unit record, pilots, weapons, vehicles, lances, tactical
  effects, campaign state and save mappings;
- recovered executable text and pointer tables as readable C data;
- replaced complete typed memory copies with structure assignment;
- retained stored 16:16 values only where their numeric representation matters;
- moved host-only dispatch and representation helpers to `src/Support`; and
- removed addressless game-logic helpers that obscured original procedure
  boundaries.

All 785 procedures reached `Validated` in the source-conversion ledger.

## 5. Acceptance stabilization

The first playable build exposed issues that static verification did not:
window duplication, menu selection IDs, lance-screen redraw and assignment,
palette handling, tactical input, cursor scrolling, projectile/terrain redraw,
timer progress, audio playback and save restoration. Each fix was checked
against assembly or original behavior rather than treated as permission to
redesign the game.

Commit `59f8cdab` is the last behavior-changing acceptance baseline before the
repository/documentation work. Manual play subsequently completed the first
six campaign missions. The full campaign remains unverified.

## 6. Standalone preservation repository preparation

The project was made self-contained by bringing its annotation, metadata and
assembly evidence under `evidence/`, making scripts repository-relative,
adding standalone CI, documenting rights, and creating a configurable
two-file runtime package with SDL3 linked statically:

```text
Revenge.exe
REVENGE.CFG
```

Original executable and game assets remain external.

## Durable lessons

- Decompiler output is evidence, not authority.
- Passing unit tests cannot replace assembly comparison or play testing.
- Readability comes from recovered data relationships, not invented services.
- SDL belongs below preserved wrappers, with explicit exceptions recorded as
  `Verified [SDL]`.
- Historical addresses belong in declarations, comments and ledgers; they do
  not need to dominate ordinary game logic.
- Uncertainty should remain visible rather than being hidden behind a confident
  name.
