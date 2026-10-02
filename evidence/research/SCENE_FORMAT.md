# SCENE file structure

All 30 `SCENE*.DAT` files share one bounded container. This page deliberately
keeps the instruction block and unexplained metadata raw until their consumers
are traced.

Confidence labels follow the project convention: **V** verified, **P**
probable, **H** hypothesis, and **U** unknown.

## Container

| File offset | Size | Meaning | Confidence |
| --- | ---: | --- | --- |
| `0000` | 2 | stored file length, excluding this word | V |
| `0002` | `73 × 2` | monotonically increasing absolute data offsets | V |
| `0094` | `0092h` | fixed scene metadata | V |
| `0126` | 2 | reserved zero word before the instruction cursor | V |
| `0128` | variable | scenario bytecode, beginning `FCh` and ending `FFh` | V envelope, U operands |
| offset entry 1 onward | 72 spans | NUL-terminated printable message strings | V |
| after final string | variable | zero padding | V structural, U purpose |
| final byte | 1 | raw trailer byte | U |

Offset entry 0 is always `0126h` and begins the instruction block. Entry 1
ends that block and starts message 0. Entries 1–72 therefore locate exactly 72 messages;
unused entries point to one-byte empty strings. The final byte is outside the
last message and is not currently called a checksum because simple sum and XOR
tests do not explain it.

The message offsets divide into six 11-entry generic speaker banks (`00h..41h`)
and six scene-event messages (`42h..47h`). The rendering path at
`1A1F:4588–45D8` selects a speaker bank for narration categories `00h..0Ah`;
for higher categories it advances past all 66 generic offsets and subtracts
`0Bh` before indexing. The special-event family `DCh..E1h` stores categories
`10h..0Bh`, and its byte operand becomes the active narration subject at
`DS:B2F2`. See
[SCENE1 end-to-end trace](SCENE1_TRACE.md) for the executable/data proof.

For generic categories, both that render path and
`HasNarrationMessage_5476` map narration subject/unit indices `0..3` to speaker
banks `0..3`, indices `4..7` to bank 4, and indices 8 or greater to bank 5.
The helper resolves the table entry internally and returns the first byte of
the selected string as an availability test. This is a verified lookup rule,
not yet a claim about fixed character identities. Text across all 30 files
gives the following conservative labels:

| Category | Proposed meaning | Confidence/evidence |
| ---: | --- | --- |
| `00` | unit damage/armor warning | P; consistently half-damage or severe-damage speech |
| `01` | unit shutdown/overheat | P; consistently shutdown and cooling speech |
| `02` | cancel overburn | H; only one nonempty corpus string |
| `03` | target spotted, engaging | P; engagement/fire-at-will speech |
| `04` | target spotted, holding | P; sighting without a fire request |
| `05` | unknown/unused | U; empty in all supplied files |
| `06` | target spotted, holding fire | P; explicit requests or orders to hold fire |
| `07` | arrived at objective | P; consistently arrival/in-position speech |
| `08` | target status change | H; mostly enemy retreat, but SCENE1 reports internal damage |
| `09` | target destroyed | P; consistently destruction speech |
| `0A` | unsafe engagement warning | P; damage, odds, or disadvantage warnings |

Evidence reports include these proposed labels while preserving category
numbers, so later executable traces can refine a name without changing the
underlying format.

## Verified resource selectors

| File offset | Metadata offset | Meaning | Confidence |
| --- | --- | --- | --- |
| `00A3` | `0F` | map ID: `0..9` → `MAP0..MAP9`, `0A` → `MAPA` | V |
| `00A4` | `10` | icon-set ID: `0..7` → `ICONSET0..ICONSET7` | V |

The selectors produce eleven distinct resource pairs across all files:

| SCENE files | MAP | ICN |
| --- | --- | --- |
| `1–4` | `MAP0.MAP` | `ICONSET0.ICN` |
| `5–7` | `MAP1.MAP` | `ICONSET1.ICN` |
| `8`, `9`, `A` | `MAP2.MAP` | `ICONSET0.ICN` |
| `B`, `C`, `E` | `MAP3.MAP` | `ICONSET2.ICN` |
| `D`, `T` | `MAP4.MAP` | `ICONSET3.ICN` |
| `F–K`, `U` | `MAP5.MAP` | `ICONSET4.ICN` |
| `L`, `M` | `MAP6.MAP` | `ICONSET5.ICN` |
| `N` | `MAP7.MAP` | `ICONSET6.ICN` |
| `O`, `P`, `S` | `MAP8.MAP` | `ICONSET7.ICN` |
| `Q` | `MAP9.MAP` | `ICONSET7.ICN` |
| `R` | `MAPA.MAP` | `ICONSET7.ICN` |

This interpretation is verified by value ranges, exact grouping across all 30
files, successful automatic composition of every pair, and the visual match of
`SCENE1`'s `MAP0`/`ICONSET0` selection to the supplied stitched map evidence.

## Current tooling boundary

The initialized resource-descriptor table at `DS:10B0` uses `12h`-byte
entries. Entry `42h` begins at `DS:1554`, where its far filename pointer
resolves to `DS:21D2`, `"SCENEx.DAT"`. The generic stream layer in
`REVENGE_3390.c` walks these descriptors, populates their file length and
optional memory-cache fields, and serves reads. This verifies how the game
locates the scenario file, but it does not interpret the payload. Constants
that merely resemble metadata offsets are therefore not treated as xrefs.

The instruction consumer is identified at `1A1F:2A4E`. The refreshed Reko run
now emits it, although its large switch still contains malformed stack/member
pointer expressions. Assembly confirms that it takes no C arguments, reads
bytes through the far cursor at `DS:A9D9`, sign-extends the opcode, normalizes
`CFh..FEh` into a 48-entry jump table, and stops on `FFh` or a local completion
flag. A caller at `1A1F:296B` installs the cursor and invokes the interpreter.
Every supplied SCENE block has a zero word at `0126h`, begins execution with
`FCh` at `0128h`, and ends with `FFh`. See `SCENE_INTERPRETER_ABI.md` for its
verified entry and callee contracts.

All 48 dispatch entries now have verified operand widths. Handler bodies advance
the shared cursor directly and several contain loops, so embedded `FFh` bytes
are data rather than additional terminators. The decoder follows those cursor
increments and treats `FFh` as a terminator only when it is fetched as an
opcode.

## Interpreter dispatch and first decoded opcodes

The switch table at `1A1F:2A84` maps every opcode `CFh..FEh` to a handler.
This is now the authoritative opcode inventory; an opcode's operand width is
accepted only after its handler's increments of `SceneInstructionOffset_A9D9`
have been followed on every branch.

| Opcode | Handler | Operands | Proposed operation | Confidence |
| ---: | --- | --- | --- | :---: |
| `CF` | `1A1F:3A46` | `selector` | set one of two global scene flags at `DS:03EB/03EC`, selected by zero/nonzero, then continue interpreting | V assignments, U flag meaning |
| `D0` | `1A1F:3A12` | `slot, value` | initialize a scene-runtime slot: set `DS:8328[slot]`, clear `DS:99AC[slot]`, and set `DS:B574[slot]` to `FFh` | V assignments, P slot name |
| `D1` | `1A1F:39D5` | `centerX, centerY, chanceDenominator` | invoke `CreateRandomAreaImpact_19FD`; on a one-in-N roll, damage terrain and units in a randomly offset 2x2 area | V |
| `D2` | `1A1F:3997` | `startIndex, value` | assign one formation mode to four consecutive unit slots at `DS:AE9D + startIndex` | V assignment, P meaning |
| `D3` | `1A1F:393C` | `x, y` | initialize a special map event and store its coordinates | V width, P name |
| `D4` | `1A1F:3889` | `operation` | set a persistent campaign milestone; observed selectors: 0 APC crossed bridge, 1 SRMs loaded, 2 LRMs loaded, 3 Whitworth pilot ejected, 6 commander crippled, 7 city/Mech Shop reached | V dispatch/bit assignments, P milestone labels |
| `D5` | `1A1F:37C6` | `unit, upgrade` | grant one of four unit equipment flags (`+8Ch`, `+8Dh`, `+8Eh`, or `+91h`); selector four fills the first free award slot at `DS:8657` | V assignments, P operation/array name |
| `D6` | `1A1F:3779` | `unit, y, relativeWord` | jump relative unless the unit's map Y equals `y` | V |
| `D7` | `1A1F:372C` | `unit, x, relativeWord` | jump relative unless the unit's map X equals `x` | V |
| `D8` | `1A1F:371E` | none | finish the pass with scene mode three | V assignment, P mode name |
| `D9` | `1A1F:3710` | none | finish the pass with scene mode two | V assignment, P mode name |
| `DA` | `1A1F:36C2` | `unit, relativeWord` | jump when the unit is absent/undeployed or has completed withdrawal (`UnitWithdrawalState_883F[unit]` bit `80h`) | V control flow, P withdrawal-state name |
| `DB` | `1A1F:35C4` | `unit, x, y` | initialize or update the unit's scene destination, then queue available category-eight narration for an active linked friendly unit | V data flow, P narration meaning |
| `DC–E1` | `1A1F:3579` | `subject` | activate event slot `E1h-opcode`, set category `0Bh+slot`, and link message `42h+slot` | V |
| `E2` | `1A1F:352A` | `centerX, centerY, chanceDenominator` | on a one-in-N roll, invoke `QueueRandomMapEdgeEffect_4923` to queue sprite base `01C0h` at a randomized map edge | V |
| `E3` | `1A1F:34F7` | `unit, value` | set unit `gunneryTargetNumber` (`+8Ah`) | V |
| `E4` | `1A1F:34C4` | `unit, value` | set unit `pilotId` (`+92h`) | V |
| `E5` | `1A1F:3491` | `unit, value` | set unit `pilotExperience` (`+93h`) | V |
| `E6` | `1A1F:343D` | `x, y, relativeWord` | query map cell `(x,y)` and jump if its returned value is below three | V comparison, P map-cell name |
| `E7` | `1A1F:33EA` | `x, y, relativeWord` | query map cell `(x,y)` and jump when its returned value is nonzero | V comparison, P map-cell name |
| `E8` | `1A1F:33D1` | `unit` | advance `unit` through its four-point scene route via proposed `AdvanceUnitSceneRoute_469C` | V width/call, P helper name |
| `E9` | `1A1F:32B4` | `unit, unitType, x, y, rosterSlot` | copy the selected `96h` unit template into the live slot, initialize its repeated scene-route coordinates, prepare its type resources, update lance-leader state, and optionally assign a pilot-roster entry unless `rosterSlot` is `FFh` | V width/data flow, P operation and helper names |
| `EA` | `1A1F:3270` | `unit, ammoFamily` | add one `AmmoCapacityMultiplierTable_058E` quantity to the family's current-ammunition word | V |
| `EB` | `1A1F:31F5` | `unit, ammoFamily` | subtract one `AmmoCapacityMultiplierTable_058E` quantity from the family's current-ammunition word, clamp to zero | V |
| `EC` | `1A1F:3184` | `state, minute, hour, relativeWord` | jump relative unless the campaign clock tuple equals the operands | V |
| `ED` | `1A1F:30FA` | `state, minute, hour, relativeWord` | jump relative while the campaign clock tuple is before the operands | V |
| `EE` | `1A1F:30C8` | `state, minute, hour` | set the three-byte campaign clock and redraw its hour/minute display through `DrawCampaignClock_15FF` | V |
| `EF` | `1A1F:3044` | `unit, equipmentId, relativeWord` | jump unless the unit contains the requested equipment/weapon ID | V control flow and lookup, P equipment label |
| `F0` | `1A1F:2FE7` | `unit, ammoFamily, relativeWord` | jump when the selected current-ammunition word is nonzero | V |
| `F1` | `1A1F:2F8A` | `unit, relativeWord` | jump if the unit is absent or has zero walking movement | V |
| `F2` | `1A1F:2ED4` | `unit, percent, relativeWord` | jump if the unit's current internal total is below `percent` of maximum | V calculation, P label |
| `F3` | `1A1F:2E66` | `unit, percent, relativeWord` | jump if current durability is below `percent` of maximum | V |
| `F4` | `1A1F:2E23` | `unit, armorIndex, amount` | add `amount` to `currentArmor[armorIndex]` | V |
| `F5` | `1A1F:2DB2` | `unit, armorIndex, amount` | subtract `amount` from `currentArmor[armorIndex]`, clamp to zero | V |
| `F6` | `1A1F:3A6A` | none | finish the current interpreter pass | V |
| `F7` | `1A1F:2D96` | signed relative word | unconditional relative script jump | V |
| `F8` | `1A1F:2D5D` | `unit, signed relative word` | branch when `UnitWasAttackedThisTick_87D4[unit]` is zero | V |
| `F9` | `1A1F:2C04` | `unit, x0, y0, x1, y1, x2, y2, x3, y3` | initialize the unit's four-point movement route at `DS:86C1` | V layout, P route meaning |
| `FA` | `1A1F:2BE3` | `unit, value` | set `UnitMovementHeatExponent_99C7[unit]` | P name, V assignment |
| `FB` | `1A1F:2B9D` | `unit, target[, x, y]` | set attack target; target `18h` consumes map coordinates for ground fire | V |
| `FC` | `1A1F:2B7C` | `unit, value` | set `UnitTacticalOrderMode_8B68`: proposed 00h scripted route, 01h hold position/attack, 02h autonomous seek-and-destroy/pursuit | V assignment, P mode labels |
| `FD` | `1A1F:2B4C` | `unit, equipmentId` | install one equipment ID into the first supported free critical slot | V |
| `FE` | `1A1F:2AE4` | `unit, equipmentId` | remove every occurrence of an equipment ID from the unit | V |

### Persistent milestone selectors (`D4h`)

The supplied SCENE corpus uses six of the eight selector arms. The labels below
come from the event message immediately before or after the instruction, while
the destination bit/field comes from the handler. Selectors `04h` and `05h`
exist in the executable but do not occur in the supplied scripts, so their
meanings remain unknown.

| Selector | Supplied scene | Persistent effect | Correlated event | Confidence |
| ---: | --- | --- | --- | :---: |
| `00h` | `SCENE4` | `CampaignFlags_24DF |= 0080h` | APC crossed the bridge | V correlation, P campaign meaning |
| `01h` | `SCENE5` | flags `|= 0800h`; `SrmShipmentLoaded_810A = 1` | all SRMs loaded | V |
| `02h` | `SCENE5` | flags `|= 1000h`; `LrmShipmentLoaded_8108 = 1` | Listen-Kill LRMs loaded | V |
| `03h` | `SCENE3` | transfers the ejected-unit state and conditionally sets bit `0020h` | Whitworth MechWarrior ejected | V event, P transferred-state meaning |
| `04h` | not present | flags `|= 0100h` | unknown | V assignment, U meaning |
| `05h` | not present | flags `|= 0200h` | unknown | V assignment, U meaning |
| `06h` | `SCENES` | flags `|= 0400h` | Galaxy Commander's Mech crippled | V correlation, P campaign meaning |
| `07h` | `SCENEC` | flags `|= 4000h` | city/Mech Shop objective reached | V correlation, P campaign meaning |

No supplied script invokes `D5h` or `DAh`; those operations are nevertheless
verified from their executable handlers. This distinction matters when using
the corpus as evidence: it proves the D4h event correlations and F8h/FC usage,
but not the narrative identity of the D5h awards.

Every conditional/unconditional relative branch terminates the linear prefix
report because its signed relative word changes control flow; its operand
width is still reported. `D2h` remains deliberately structural: its handler proves the four-byte fill,
`RebuildLanceFormationAfterLeaderLoss_18A1` now supplies the missing consumer:
it masks each `AE9Dh` byte to seven bits, combines it with the leader's facing
band, and indexes the signed formation-offset table at `DS:17DE`. Values `01h`
and `08h` use single-cell offsets; other values scale them by three. The field
is therefore retained as probable `UnitFormationMode_AE9D` pending a live trace.
`FB`'s variable width is proven by executable control flow: ordinary unit
targets consume two operands, while target `18h` denotes a map-coordinate
attack and consumes two additional bytes. `F9` is likewise fixed at four X/Y
pairs after the unit index; the current map position is copied separately into
the route record. These widths explain the opening setup sequences in the real
SCENE files without treating operand bytes as opcodes.

The helper at `1A1F:3A8A` is named
`InstallUnitEquipmentInFirstFreeSlot_3A8A`. It scans the shared equipment
groups and writes the requested one-based equipment ID into the first free
supported slot. `FE` uses `FindUnitWeaponByOrdinal_01AB` repeatedly with its
remove flag instead, so the add/remove pair is independently corroborated.

The blocks are not PC-speaker weapon-effect streams: the interpreter at `30B2:0137`
accepts notes `00h..5Fh` plus a small control set (`CDh`, `CEh`, `D1h`, `D2h`,
`E2h`, `E6h`, `E8h`, `E9h`, and `FFh`) and would stop at the first `FCh` in
every SCENE block. This rules out one tempting but incorrect opcode match.

`RevengeTools inspect-scene` exposes the resource selectors, raw metadata,
reserved word, raw instruction length/hash, trailer byte, and all messages. `export-scenes`
creates an ignored JSON manifest, while `export-scene-map` follows the verified
selectors to render the associated map. The bounded prefix decoder recognizes
all 48 dispatch entries and stops after a relative branch; metadata fields and
the effects of explicitly low-confidence helpers stay unnamed.

The control-flow report separately follows both destinations of verified
conditional branches, the destination of `F7h`, and the resume cursor after
`F6h`. Branch words are offsets from the executable instruction block beginning
at file offset `0128h`, not displacements from the branch instruction. Unknown
entry points terminate only their own path, allowing other proven paths to be
reported without guessing an operand width.

Every reached byte below `CFh` is represented explicitly as an out-of-range
pass finish. The executable sign-extends the byte, rejects values outside its
`CFh..FEh` dispatch range, and routes them to the same handler as `F6h`.
The raw value is retained in reports: these bytes are not promoted to general
opcodes or confused with the file's final `FFh` terminator. This explains the
previously suspicious low values (`44h`, `43h`, `3Fh`, and others) without
inventing operand widths or declaring valid control-flow destinations corrupt.
Control-flow traversal reaches no unknown entry point in any of the 30 supplied
SCENE files. The report counts the union of covered bytes because scripts can
deliberately branch into an operand tail that forms a different instruction on
the alternate path (observed in `SCENEK`). This is reachable-corpus closure;
several operation names remain proposed until their called helpers are traced.

`export-scene-evidence` writes the instruction block and metadata as exact binaries,
alongside address-based hex dumps, the known instruction prefix and
control-flow report, the
offset/message boundaries, and a
146-row cross-scene report. This keeps the next executable-tracing pass
reproducible while leaving unknown bytes unknown.

`SCENE1.DAT` is now traced end to end: its resource selection and scenario
roster setup, all 166 executable instruction bytes, campaign-clock setup, unit
state changes, map/condition polling, and six trailing event-message links are
accounted for. The remaining SCENE work is semantic refinement rather than a
decoder-completeness requirement.
