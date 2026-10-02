# Scenario roster preparation

`PrepareScenarioUnitRosters_0006` (`30F1:0006`) builds the 24-record live
array at `DS:99E0` from the persistent roster at `DS:8B81`.

## Scenario selector

`DS:B581` is an ASCII scene-file suffix, not a binary scenario ordinal.
`31h–39h` select `SCENE1.DAT` through `SCENE9.DAT`; `41h–54h` select
`SCENEA.DAT` through `SCENET.DAT`. Converting the suffix gives scene ordinals
1–29. `SCENEU.DAT` exists as ordinal 30, but this switch stops at `54h`; its
roster is prepared elsewhere or reuses existing live state.

This mapping is **V**: `1A1F:0000` stores its argument at `DS:B581`, the game
ships the matching filenames, and `30F1:0006` switches on those ASCII values.

## Recipe table

| `B581` | Scene | Roster action | Confidence |
| --- | --- | --- | :---: |
| `31h` | `SCENE1` | Prepare live slot 5 from persistent slot 0 or blank; copy persistent slot 15 to live slot 15 after clearing its active flag. | V |
| `32h` | `SCENE2` | Persistent slots 0, 1, 12, 20 → live slots 0, 1, 13, 14. | V |
| `33h` | `SCENE3` | Persistent 0 and 1 → live 0 and 1; select persistent 12 or 2 for live 2; clear live 5. | V |
| `34h` | `SCENE4` | Persistent 0, 1, and 2 → live 0, 1, and 4; move live 4 → live 2 first. | V |
| `35h` | `SCENE5` | Reset live 0–4, replace empty live 1 from live 4 or 3, then clear live 4. | V |
| `36h` | `SCENE6` | Persistent 0–2 and 21–23 → same live slots; clear live 20. | V |
| `37h` | `SCENE7` | Persistent 0–1 → live 3–4; persistent 21–23 → same live slots. | V |
| `38h` | `SCENE8` | Persistent 0–2 and 21–23 → same live slots; persistent 4 → live 3. | V |
| `39h` | `SCENE9` | Persistent 0 → live 0; 1 → 3; 4 → 1; 5 → 2; 21–23 remain aligned. | V |
| `3Ah–41h` | — / `SCENEA` | No roster operation in this switch. | V |
| `42h` | `SCENEB` | Persistent 0–11 and 16–23 → corresponding live slots. | V |
| `43h` | `SCENEC` | Invalidate empty slots, then share the 12-record copy used by `SCENET`. | V |
| `44h` | `SCENED` | Copy all 24 persistent records to matching live slots. | V |
| `45h` | `SCENEE` | Invalidate empty persistent slots and blank all 24 live records. | V |
| `46h–4Bh` | `SCENEF`–`SCENEK` | No roster operation in this switch. | V |
| `4Ch` | `SCENEL` | Persistent 0–3 → live 0–3; blank live 12–23. | V |
| `4Dh` | `SCENEM` | Persistent 0–11 → live 0–11. | V |
| `4Eh` | `SCENEN` | Persistent 0–11 → live 0–11; optionally reset them when `DS:24DF` bit 0 is set. | V |
| `4Fh` | `SCENEO` | Compact two four-unit lances; persistent 4–7 → live 8–11 and 0–3 → live 12–15. | V |
| `50h` | `SCENEP` | Compact; persistent 4–7 → live 8–11 and 8–11 → live 12–15, resetting the latter. | V |
| `51h` | `SCENEQ` | Compact; persistent 0–7 → live 0–7 and 8–11 → live 12–15; reset copied records. | V |
| `52h–53h` | `SCENER`–`SCENES` | Compact; persistent 0–7 → live 0–7 and reset them. | V |
| `54h` | `SCENET` | Persistent 0–11 → live 0–11. | V |

Narrative mission names are deliberately not asserted yet. Scene suffixes and
copy topology are verified; matching every file to walkthrough prose needs the
checkpoint saves or a file-open trace during play.

## Lance groups and related state

`CompactScenarioLances_0B8F` stably compacts slots `0–3` and `4–7`. Empty
records are removed without changing survivor order. For `SCENEO` and
`SCENEP`, the first group also moves corresponding live records.

The 10-byte table at `DS:1CCA` is serialized as 13 records:

| Field | Confidence | Meaning |
| --- | :---: | --- |
| `+00` | H | UI left/X word; `00EBh` in all supplied assignment rows. |
| `+02` | H | UI top/Y word; rows advance `48h, 62h, 7Ch, 96h`. |
| `+04` | H | UI width word; `0054h` in supplied rows. |
| `+06` | P | row active/style byte; 6 for populated rows and 0 for the sentinel row. |
| `+07` | V | assigned persistent-roster slot; `FFh` when unassigned. `DrawUnitStatusScreen_483A` multiplies it by `96h` and indexes `DS:8B81`. |
| `+08` | V | live-unit slot index. `DrawUnitRosterScreen_26EE` uses it to select a `DS:99E0` record. |
| `+09` | V | pilot ID. `DrawUnitRosterScreen_26EE` uses it to select a pilot-name string; unavailable rows use `FFh`. |

Winning saves show 12 assignment rows followed by a thirteenth sentinel row.
The assignment slots are nonsequential when a lance has gaps, while `+08`
normally remains the fixed display/live slot `0–0Bh`.

`DS:1D4F` is **not** a unit-type table. It is 37 four-byte records indexed by
unit byte `+92` (`pilotId`). The save preserves only the first byte of each
record. `UpdatePilotAvailability_0A81` proves `01h` means the populated
pilot's persistent unit has an active deployment-state byte, while `FFh`
means that unit's deployment-state byte is clear. `00h` is the
unestablished/default state; reserve-promotion code rejects a UI assignment
only when this byte is zero. The remaining three bytes of each runtime record
are still unknown.

`PromoteReserveUnitsForCampaignStage_0E96` is the first downstream consumer
that joins these structures. At campaign stages `10h–11h` it promotes reserve
live-unit slots `16–19` to `0–3` and `20–23` to `8–11`. At stages `12h–14h`
it promotes slots `16–23` to `0–7`. It invalidates the corresponding `1CCA`
UI row when the promoted record is empty or its pilot has state `00h`.

`DS:197B` and `DS:1993` are verified 24-byte save snapshots of runtime arrays
`DS:8562` and `DS:857B`. They are now **P** per-unit map X/Y arrays: the two
parallel bytes form coordinate-like pairs, use the same 24-entry cardinality as
the live roster, and early winning-save checkpoints retain long runs from the
corresponding SCENE metadata. Save/load and roster preparation prove the copy
directions. The X/Y ordering remains proposed until an in-game movement trace
shows which array changes on a horizontal or vertical step.
