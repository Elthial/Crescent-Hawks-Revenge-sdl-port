# Winning save-game reference

The supplied winning-save set is preserved under
`ReverseEngineering/Evidence/winning savegame`. It contains five 25,024-byte
replacement saves and a short text index. Each file should be copied over
`SAVEGAME.DAT` only in a disposable game copy.

## Checkpoints and hashes

| File | Coverage stated by supplied index | SHA-256 |
| --- | --- | --- |
| `SAVEGAME.S01` | scenarios 2–7 | `AA2B630AA8F3B2B68EF28A74F522A80BAEE801A066673C701BEDE89A49EE6317` |
| `SAVEGAME.S02` | scenarios 8–13 | `6BC6D7BAA97553B42F02A80D0EA7F68CED1DDCA1311D7AE325CCF50034D14E77` |
| `SAVEGAME.S03` | scenarios 13–18 | `2EC6AF131F26F44941431936BFF0B6F9D1AAC2FD7804E39C93D5F584C6C3887A` |
| `SAVEGAME.S04` | scenarios 19–24 | `3C80B1A5F007CDDB9EBEEFC5C225908CA095D83A0B5784CE248F1B065FD481D2` |
| `SAVEGAME.S05` | scenarios 25–26 and Pacifica training | `2462D214B64B8A4C402ACCA578DCCA7300C7E24210B50BB284CA3B2646E633A6` |

The accompanying `SAVEGAME.TXT` identifies the set as version 1.0 dated 15
December 1998; its SHA-256 is
`94E0A40561C8D92F1FD712CEAC78E486892501CF197FD60D7D678D167375B9F5`.

## First comparison

Using S01 as the baseline:

| Compared file | Differing bytes | First difference | Last difference |
| --- | ---: | ---: | ---: |
| S02 | 5,069 | `0x17` | `0x61B2` |
| S03 | 6,022 | `0x17` | `0x61B4` |
| S04 | 7,570 | `0x17` | `0x61BC` |
| S05 | 9,318 | `0x15` | `0x61BC` |

The changes are broad state snapshots, not a small final-completion flag. S05
contains readable fragments naming scenarios 22–26 and the training ground near
the beginning, which is a strong lead for a scenario/checkpoint directory.

## Relation to unit records

The [community hex
map](https://www.tacticalwargames.net/taccmd/viewtopic.php?f=59&t=3132)
claims that save-game unit instances reuse much of the 150-byte
`MECHTYPE.DAT` record: current structure/armor, ammo, equipment, pilot, and
allegiance. The container/load code and all 30 supplied checkpoints now
independently confirm that each slot embeds 24 complete `96h` live-unit
records. Several mutable field meanings remain probable rather than verified;
single-action saves are still required before promoting or editing those
individual fields.

## Verified container and slot layout

The installed `SAVEGAME.DAT` is `61C0h` (25,024) bytes. Its leading word table
contains these boundaries:

`0007, 0012, 009A, 10CB, 20FC, 312D, 415E, 518F, 61C0`

The six save payloads begin at `009Ah` and are each `1031h` bytes:

| Slot-relative range | Length | Runtime source |
| --- | ---: | --- |
| `0000h–0220h` | `0221h` | Campaign snapshot assembled at `DS:1956`. |
| `0221h–1030h` | `0E10h` | `DS:99E0`, exactly 24 × `96h` live-unit records. |

This is verified from save/load code, the file's offset table, and
`0221h + 18h * 96h = 1031h`. The area `0012h–0099h` contains six 22-byte slot
descriptors: five control bytes and a 17-byte NUL-padded label. Only slot 1 in
the repository copy is occupied; it is labelled `after battle 3`.

The runtime directory buffer begins at `DS:18CE`. Its first four bytes are a
prefix copied as part of the container directory; the word at `DS:18D0` is
mirrored to `DS:0094`, where value `8000h` enables the additional Pacifica
Training Ground load-menu action. Six descriptors begin at `DS:18D2`, each
with the executable-verified layout `{ occupied: byte, name: char[15h] }`.
`ShowSaveLoadMenu_4EC7` indexes them with a `16h`-byte stride, renders the name
at `+01h`, and refuses to load a descriptor whose occupied byte is zero.

The save/load menu action contract is also verified: `0` cancels, `1` selects
a normal save slot, `2` selects Pacifica training, `FFFFh` requests a menu
redisplay after a rename-only operation, and `FFFEh` requests exit to DOS.

## `DS:1956` campaign snapshot

Offsets are relative to the save-slot payload.

| Save offset | Size | Runtime source | Confidence / note |
| --- | ---: | --- | --- |
| `0000` | 2 | `CampaignStageIndex_24D6` | P; monotonically tracks campaign stage, with `10h–14h` corresponding to supplied scenarios 22–26 and `15h` to Pacifica training |
| `0002` | 2 | `ScenarioVariantIndex_24D8` | H; the six training saves use IDs `0,2,4,1,3,5`, indicating mission/variant selection rather than chronology |
| `0004` | 1 | `CampaignPhase_24DA` | P; advances from 1 through 8 across the supplied campaign checkpoints |
| `0005` | 1 | `TrainingSequenceFlag_24DC` | H; one during training scenarios T1–T5 and zero outside them/after T6 |
| `0006` | 2 | `CampaignFlags_24DF` | P bitfield; bit 0 controls unit reset in the `SCENEN` recipe |
| `0008` | 2 | `DS:24E1` | V location, U meaning |
| `000A` | 2 | `DS:A967` | V location, U meaning |
| `000C` | 2 | `DS:9991` | V; affects the `SCENE3` roster selection |
| `000E` | 2 | `DS:88F1` | V location, U meaning |
| `0010` | 2 | `DS:8925` | V location, U meaning |
| `0012` | 2 | `DS:99C5` | V location, U meaning |
| `0014` | 2 | `DS:A965` | V location, U meaning |
| `0016` | 2 | `DS:8594` | V location, U meaning |
| `0018` | 2 | `LrmShipmentLoaded_8108` | P: set by SCENE D4h selector 02h beside the Listen-Kill LRM loading event |
| `001A` | 2 | `SrmShipmentLoaded_810A` | P: set by SCENE D4h selector 01h beside the SRM loading event; consumed by scenario 38h unit setup |
| `001C` | 3 | `DS:855F` | P scenario/campaign clock snapshot |
| `001F` | 6 | `DS:00A0–00A5` | V location, U meaning |
| `0025` | 24 | `DS:8562–8579` | P `ScenarioUnitMapX[24]`, mirrored at `DS:197B`; X/Y order awaits a movement trace |
| `003D` | 24 | `DS:857B–8592` | P `ScenarioUnitMapY[24]`, mirrored at `DS:1993`; X/Y order awaits a movement trace |
| `0055` | 7 | `DS:1B85–1B8B` | V location, U meaning |
| `005C` | 1 | `DS:1B8E` | V location, U meaning |
| `005D` | 15 | `DS:1BAD–1BBB` | V location, U meaning |
| `006C` | 270 | `DS:1BBC`, 18 × 15-byte records | V shape, U semantics |
| `017A` | 130 | `DS:1CCA`, 13 × 10-byte records | P unit/lance assignment metadata |
| `01FC` | 37 | first byte of `DS:1D4F[pilotId * 4]` | P pilot availability/state |

The following `0E10h` bytes are the complete live roster; see
[96h-byte unit record](UNIT_RECORD_96H.md).

## Winning-save correlation

The five supplied files are available read-only under
`ReverseEngineering/Evidence/winning savegame`. All 30 labelled checkpoints
use the same boundaries and exact `1031h` payload size. Their first snapshot
word progresses from `0001h` at “Scenario 2” to `0014h` at “scenario 26”, then
`0015h` at the Pacifica training ground. Training missions T1–T5 hold campaign
stage `000Dh` while the second word selects variants in order `0,2,4,1,3`;
T6 advances to stage `000Eh` with variant 5.

Across the 30 checkpoints, 427 records have nonzero tonnage and a valid
`MECHTYPE.DAT` type ID. Comparing each with its exact template confirms:

- `+01` type ID, `+03` jump movement, maxima `+17–+29`, `+54` engine heat-sink
  capacity, and `+84` tonnage remain invariant;
- damage appears only in current structure/armor `+04–+16` and critical-slot
  high bits, while the maximum values remain unchanged;
- ammunition changes in the word array `+38–+53`;
- pilot `+92`, experience `+93`, allegiance `+94`, and runtime state
  `+85–+8A` vary independently of chassis identity.

`RevengeTools analyze-save-set` now reproduces the 30-checkpoint progression
and emits per-byte value profiles for the proposed unit X/Y arrays and pilot
availability. `compare-save FILE_A SLOT_A FILE_B SLOT_B` produces a semantic
byte diff grouped by campaign header, unit coordinates, lance assignments,
pilot state, and named fields in each `96h` unit record. Both commands default
to the ignored `RevengeTools.Output/save-diffs/` directory.

The supplied checkpoints strengthen the coordinate interpretation of save
offsets `0025h` and `003Dh`: they are parallel 24-byte arrays, contain
coordinate-like pairs, and early checkpoints retain long sequences found in
the corresponding SCENE metadata. This is still **P**, because only a
controlled horizontal/vertical movement capture can verify which array is X
and which is Y.

## Controlled experiment matrix

Create two saves that differ in exactly one action for each test:

1. move one unit one square;
2. fire one ammunition weapon once;
3. take damage in one armor location;
4. change game speed or audio settings without advancing the mission;
5. complete one objective without destroying another unit;
6. finish a mission with one known survivor versus one known casualty.

Compare byte ranges and repeated 150-byte blocks. Never edit or overwrite the
only copy of a supplied save.
