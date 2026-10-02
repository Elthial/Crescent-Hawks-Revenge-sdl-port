# Revenge reverse-engineering goals

This is the ordered working checklist for the next research cycle. It records
completion criteria so a readable decompile is not mistaken for a verified
result. Confidence continues to use V/P/H/U.

## Current status

| Goal | Status | Remaining evidence/work |
| --- | --- | --- |
| 1. Combat and damage | Core path complete | Presentation/global-state helpers remain P; attack, damage, destruction, lance recovery, and packed terrain damage are translated or bounded. |
| 2. `96h` unit record | Static map complete, verification ongoing | Controlled saves remain necessary for mutable pilot/allegiance state. Core combat proves no separate non-infantry vehicle location projection. |
| 3. Controlled saves | Evidence-gated | Capture isolated before/after pairs for movement, ammunition, armor, heat, internal, and mobility changes. Existing campaign checkpoints change too many variables at once. |
| 4. `REVENGE_0800.c` | High-confidence repair complete | Mouse cursor overlay, nesting, locking, background capture/restore, hotspot, and coordinate state are verified; remaining pseudo-operations preserve real far-pointer, carry-chain, and multiword register behavior. |
| 5. SCENE bytecode | First-pass goal complete | All 48 `CFh..FEh` entries have verified widths and handlers; all 30 files have zero unknown reachable entry points; SCENE1 is traced end to end through resources, roster setup, state changes, branches, and event messages. |
| 6. PC-speaker effect stream | Command semantics complete | All 16 weapon-effect streams have expanded PIT traces; unused `E8h/E9h` arithmetic is verified from assembly and synthetic signed-overflow boundaries. |
| 7. Documentation/Reko sync | Current baseline synchronized | Keep each later semantic promotion aligned across C, toolkit, docs, `REVENGE.dcproject`, and `REVENGE-metadata.inc`; run the consistency validator before commits. |

## Goal 1 — combat and damage path (current pass complete)

- Recover and translate `ResolveWeaponAttack_1854` and
  `ApplyWeaponDamage_1E2B` from the refreshed Reko output and assembly.
- Finish the calling-convention and data-flow pass over
  `RecalculateUnitCombatRatings_0005` and `FindUnitWeaponByOrdinal_01AB`.
- Name weapon damage, heat, range, ammunition, recovery, hit-location, armor,
  internal-structure, critical-hit, and destruction state where supported.
- Use BattleTech vehicle terminology for vehicle locations: front, left side,
  right side, rear, turret, motive system, armor, and internal structure.
- Add confirmed function names and signatures to `REVENGE.dcproject`.

Completion requires a documented attack-to-damage call path, named data
accesses in the maintained C, and V/P/H/U annotations for uncertain behavior.

## Goal 2 — `96h` unit-record map (static pass complete)

- Resolve offsets `85h`, `86h`, `88h`, `89h`, `8Ah`, `8Bh`, `8Ch`, `8Eh`,
  `8Fh`, and `95h`.
- Maintain separate BattleMech and vehicle interpretations when the shared
  record stores different location semantics.
- Correlate templates, persistent roster records, live units, combat code, and
  saves before promoting a field to V.

Completion requires a field-by-field map in `UNIT_RECORD_96H.md`, including
the vehicle projection and citations to code or controlled observations.

## Goal 3 — correlate controlled saves with runtime state

- Compare paired saves after one deliberately isolated action: movement,
  ammunition use, armor damage, heat, internal damage, mobility damage, and a
  scenario or pilot-state change.
- Use `RevengeTools compare-save` and `analyze-save-set` to identify exact
  offsets while preserving unknown bytes.
- Promote only repeatable correlations into the save editor and DS map.

Completion requires evidence sets for each enabled writable field and
byte-exact no-op save round trips. This goal needs suitable captured saves; the
static-analysis work can prepare tooling but cannot manufacture verification.

## Goal 4 — repair `REVENGE_0800.c` (high-confidence pass complete)

- Resolve the remaining `<invalid>` expressions against the assembly.
- Translate high-confidence EGA plane, latch, framebuffer, clipping, line,
  sprite, and RLE operations to ordinary C-style expressions.
- Remove `SEQ`, `SLICE`, `HIGH_WORD`, and artificial `out` arguments only when
  the 16-bit segmented behavior remains explicit and correct.
- Feed verified signatures back into `REVENGE.dcproject`.

Completion requires no known broken expressions in the maintained graphics
routines and annotations on any deliberately retained Reko constructs.

## Goal 5 — decode SCENE instructions (first pass complete)

- Extend the verified container, text, MAP, and ICONSET parsing with a
  conservative instruction decoder.
- Preserve source offsets and raw bytes while proposing opcode widths and
  semantics.
- Link instructions to messages, unit placement, objectives, maps, and scene
  transitions.

Completion requires all 30 files to decode without loss and at least one scene
to be traced end-to-end against executable behavior.

## Goal 6 — PC-speaker effect-stream command semantics (complete)

- Add an evidence-oriented stream disassembler for the command bytes consumed
  by `DecodePCSpeakerEffectTick_00DF`.
- Validate the proposed `CDh`, `CEh`, `D1h`, `D2h`, `E2h`, `E6h`, `E8h`,
  `E9h`, and `FFh` meanings against real streams and PIT writes.
- Retain P/H confidence until command timing and control flow are demonstrated.

Completion requires command-by-command annotated traces for representative
streams and consistent playback-state transitions.

## Goal 7 — keep documentation and Reko inputs synchronized

- Refresh the backlog when work is implemented or disproved.
- Record verified names, signatures, and data types in `REVENGE.dcproject`.
- Keep generated Reko output as evidence; selectively merge only improvements
  into the maintained annotation project.
- Run `RevengeTools.Verification` after toolkit changes and keep extraction
  output in ignored directories.
- Run `C/tools/Test-AnnotationConsistency.ps1`; use `-RunVerification` for the
  full metadata-and-toolkit gate.

This goal remains active throughout the research cycle.

## Current synchronized baseline

- Current verification assertions: **82**.
- Current dcproject procedure entries: **681**.
- Current dcproject address annotations: **918**.
- Current metadata address declarations: **455**.
- Maintained C: **0** `<invalid>` markers.
- Maintained C: 16 `SEQ`, 5 `SLICE`, and 31 Reko-style `out` occurrences.
  These counts are diagnostic, not zero targets: far pointers, carry chains,
  DOS interrupt results, and register-call contracts can legitimately retain
  the notation.
- Runtime-library recovery now includes far-memory fill, CRT open/IOCTL/close,
  text-mode read/write translation, far strings, and integer formatting.
- Baseline immediately before this documentation cycle: `124d3c4` (`Recover
  Revenge integer formatting runtime`).

`C/tools/Test-AnnotationConsistency.ps1` verifies the four bold counts above,
unique procedure/metadata addresses and names, and the absence of old
`fnSEG_OFFSET` aliases for procedures already named in the dcproject. With
`-RunVerification`, it also executes the verification project and checks the
reported assertion total.

## Historical starting baseline

- `RevengeTools.Verification`: 46 assertions passing.
- Maintained C: 50 `<invalid>` markers, 31 of them in `REVENGE_0800.c`.
- Maintained C: 98 `SEQ`, 10 `SLICE`, and 165 Reko-style `out` occurrences.
- `REVENGE.dcproject`: 149 procedure/data annotation entries detected.
- Git baseline: `5da1af6` (`Clean up Revenge Reko pseudocode`).

## Iteration log

### Campaign/menu orchestration — modal and action contracts

- Corrected `RunInGameMenu_274D` to its verified one-argument contract. The
  caller pushes only `firstMenuOption`; the apparent `runState` parameter was
  a Reko artefact. The routine now dispatches the selected menu action after
  adding that visible-submenu base.
- Recovered the Escape retry loops and actual return values for
  `ShowConfirmationDialog_2448` and `RunMainMenuSelection_25F5`.
- Removed false ES outputs and false input arguments from the confirmation,
  modal restore, save-game, and load-game families, then synchronized those
  contracts in both Reko input files.
- Replaced the negative pseudo-case labels with the verified nine-entry action
  order: continue, jump story, save/continue, save/quit, load, replay scenario,
  replay story, restart, and options.

### Tactical AI, slice 1 — target and engagement-mode selection

- Translated `SelectUnitTacticalTargets_08FA` against its complete assembly
  body: explicit targets are validated, visible/contacted opponents are
  searched with explicit-target distance bias, and allies already attacking
  the same target contribute to the comparison.
- Decoded `DS:08C6` as the 256-byte tactical engagement-mode lookup. Its mask
  compares durability plus close-, medium-, and long-range firepower; results
  select close `01h`, medium `02h`, long `03h`, or withdrawal `04h` behavior.
- Verified `DS:AED6` as the 24-byte preferred-engagement-mode array, including
  `05h` positional behavior, and `DS:A7F3` as the last target reported by the
  category-`0Ah` withdrawal narration path.

### Tactical AI, slice 2 — movement and map stepping

- Translated `AdvanceUnitTacticalMovement_0F1F` and
  `MoveUnitTowardMapCell_03EA` against their complete assembly bodies.
  Movement now exposes route, target, withdrawal, formation-following,
  facing, collision, terrain-class, route-completion, and scenario-exit paths.
- Verified `DS:8827` as per-unit jumping state, `DS:AE3D` as remaining jump
  movement initialized from record `+03h`, `DS:9993` as current terrain type,
  and `DS:99C7` as the SCENE-controlled movement/heat exponent.
- Preserved the executable's rotating eight-neighbor search, occupied-cell
  rejection, class-specific impassable terrain checks, Q8.8 movement heat,
  sprite phase/facing updates, and packed-terrain damage dispatch.

### Tactical AI, slice 3 — weapon priority and firing

- Translated `ExecuteUnitWeaponAI_14A4` and corrected its contract from `void`
  to a Boolean word return. It now shows order/target eligibility, shutdown,
  experience-indexed heat limits, fixed range/heat classification, attack-arc
  restrictions, priority-list selection, and attack dispatch.
- Recovered `DS:03E0` as the five weapon-AI heat ceilings and the coordinated
  priority data at `DS:0F46`, `0F66`, and `0FA6`. Each selected far list pairs
  32-bit availability masks with one-based weapon choices.
- Verified `DS:87D4` as `UnitWasAttackedThisTick_87D4` and `DS:B587` as
  `UnitConsecutiveAttackTicks_B587`, replacing the earlier order-state
  hypotheses. The command panel now verifies `DS:890C` as the shared Boolean
  overburn/infantry-close-assault state; the infantry path uses reciprocal
  weapon index `0Ah` resolution.

### Goal 1, slice 1 — combat rating inputs

- Recovered `0800:072C` as `CalculateSelectedWeaponRating_072C`, a 32-bit
  masked weighted sum over the 23 weapon counts.
- Removed its false `dxOut` parameter and translated the mask traversal to C.
- Corrected `RecalculateUnitCombatRatings_0005`: `DS:B02C` receives the actual
  installed heat-sink count rather than zero.
- Verified the `DS:AEF1` derived record's movement, durability, close-, medium-,
  and long-range rating fields; `+0Ah` carries sensor hits.
- Identified unit-record `+85h` as engine hits and `+89h` as sensor hits.
- Identified `+8Ah` as the gunnery target number, `+8Bh` as the target movement
  modifier, and `+95h` as a damage-model/unit-class selector.
- Exposed those fields through `RevengeTools` and increased the verification
  suite from 46 to 49 passing assertions.
- The next combat slice is the assembly-led translation of
  `ResolveWeaponAttack_1854` and `ApplyWeaponDamage_1E2B`; the refreshed Reko
  damage switch is known to be malformed and must not be copied verbatim.

### Goal 1, slice 2 — attack and damage resolution

- Translated `ResolveWeaponAttack_1854` and `ApplyWeaponDamage_1E2B` against
  the assembly rather than copying Reko's malformed register arguments and
  hit-location switch.
- Recovered `CalculateApproximateMapDistance_0D90` as
  `max(abs(dx), abs(dy)) + min(abs(dx), abs(dy)) / 2`.
- Documented the complete attack path: line of sight, indirect LRM spotting,
  to-hit modifiers, range, ammunition, heat, recovery, attack presentation,
  armor penetration, internal damage, critical hits, and destruction.
- Identified unit-record `+8Eh` as the probable indirect-fire spotter flag.
  Rifleman+ is the only immutable template with it enabled.
- Verified that the executable's minimum-range calculation grants a close-range
  bonus (`distance - minimumRange`) rather than the tabletop penalty. This is
  retained as shipped behavior and flagged explicitly.

### Goal 1, slice 3 — equipment lookup

- Replaced the malformed Reko body of `FindUnitWeaponByOrdinal_01AB` with an
  assembly-equivalent scan across all eight equipment-location groups.
- Confirmed its zero-based occurrence argument, one-based weapon-ID return,
  location-index side effect, and optional removal behavior.
- Confirmed that removing the last weapon of an ammunition-using type clears
  both its family-count byte and current-ammunition word.

### Goal 1, slice 4 — directional hit tables and vehicle projection

- Extracted the five embedded hit-location tables at `DS:1038` and the
  16-selector direction ring at `DS:3CFE`.
- Verified tables `00h..03h` as rear, right side, front, and left side
  BattleMech 2d6 charts. Table `04h` is the fixed infantry target.
- Confirmed that every non-infantry damage model, including all vehicles, uses
  these same tables and shared record indices. There is no vehicle-specific
  hit-table branch in `ApplyWeaponDamage_1E2B`.
- Added bounded decoding as `inspect-hit-locations`; malformed result values,
  selector values, or padding now fail verification rather than being accepted.
- The engine projection is verified, but a tabletop front/side/rear/turret/
  motive mapping is not. Vehicle documentation therefore retains raw indices
  rather than inventing record-sheet labels.

### Goal 4, slice 1 — invalid graphics/runtime expressions

- Recovered `ConvertPackedPixelsToEGAPlanar_3498` and its internal
  `ShiftPackedPixelsIntoEGAPlanes_34E3` carry chain. The maintained C now shows
  the in-place packed-pixel to four-plane EGA transpose directly.
- Recovered `CompareNormalizedFarPointers`, including its normalized
  DX:AX output and segment/offset ordering result.
- Reduced maintained-project `<invalid>` markers from 50 to 19 and eliminated
  them completely from `REVENGE_0800.c`. Remaining Reko-style constructs in
  that file still require confidence-by-confidence cleanup; absence of
  `<invalid>` does not imply that every routine is final.

### Goal 2, slice 1 — unit damage-model classes

- Enumerated every immutable template's `+95h` value and exposed it through
  `RevengeTools` as a typed damage-model selector while retaining the raw byte.
- Verified the exact template groupings for BattleMechs, hover combat
  vehicles, conventional combat vehicles, infantry, APC, Ammo Carrier, and
  Mobile HQ.
- Kept the non-infantry behavior names at P: only the `03h` infantry branch is
  currently proven by executable combat logic. Model `02h` spans tracked and
  wheeled vehicles, ruling out a simple propulsion selector.

### Goal 6, slice 1 — executable music-stream disassembler

- Recovered all 16 far pointers at `DS:58DB` / image `326A:58DB` and verified
  that their data spans are contiguous.
- Added a bounded CLI disassembler for note/rest events, two counted loop
  pairs, direct-frequency events, duration-scale set/decrease/increase, and
  end-of-stream.
- The decoded widths consume every real stream exactly through its sole `FFh`
  terminator, with no unknown command. Corrected `D2h` to use a word backward
  displacement and `E6h` to read a word frequency plus a duration byte.
- `RevengeTools.Verification` now passes 53 assertions, and the real executable
  exports 319 decoded instructions across the 16 ignored evidence traces.

### Goal 6, slice 2 — expanded PIT playback traces

- Located the initialized 96-word divisor table at image `3A6B:0020`, which
  relocates to the driver's runtime address `426B:0020`.
- Added a bounded playback simulator that executes both nested counted-loop
  pairs, duration-scale changes, table-note events, direct-frequency events,
  rests, and stream termination.
- All 16 streams terminate: 319 encoded instructions expand to 460 concrete
  PIT/rest events over 2,088 duration ticks. Each ignored report preserves the
  source offset, loop-expanded order, divisor, approximate frequency, scale,
  and effective tick span.
- Corrected the maintained IRQ C translation: after decrementing the event
  counter, `JNS` alone controls the fetch transition; the assembly's following
  `00FFh` comparison is redundant on that negative path.
- `E8h/E9h` were initially retained at P because no supplied stream uses them;
  the later boundary audit below verifies their machine-level state transitions.

### Goal 6, slice 3 — exact duration-scale overflow behavior

- Re-read `30B2:021F-0252` and found that both commands branch on x86 signed
  overflow (`JNO`), not unsigned borrow/carry. The earlier evidence simulator's
  ordinary saturation model was therefore incorrect.
- Corrected `E8h` to preserve the driver's wrapping subtraction and `E9h` to
  clamp to `FFh` only on signed overflow. Thus `02h-03h` becomes `FFh`,
  `7Fh+01h` clamps to `FFh`, and `FEh+02h` wraps to `00h`.
- Added a synthetic playback trace covering all three boundaries and the
  driver's zero-scale event behavior. These commands are now V at the
  machine-state level despite being absent from the 16 embedded streams.

### Goal 2, slice 2 — tactical sprite selector

- Identified unit-record `+88h` as the probable tactical sprite base.
- Deployment converts it to a per-unit word at `DS:A818`; facing updates add
  twice the low two facing bits and write the active sprite ID at `DS:AE6B`.
- Infantry fixes the facing component at zero. Template variants share the
  value of their base chassis, while vehicle and infantry records use distinct
  sprite bases.

### Goal 5, slice 1 — interpreter entry and bytecode envelope

- Located the missing SCENE bytecode interpreter at `1A1F:2A4E`; a caller at
  `1A1F:296B` installs its far cursor in `DS:A9D9/A9DB`.
- Recovered the 48-opcode dispatch domain `CFh..FEh` and `FFh` termination.
- Verified across all 30 files that the block begins with a reserved zero word,
  execution begins at `FCh`, and the block ends at `FFh`.
- Added the interpreter procedure/signature to the Reko project and exposed the
  reserved word and executable bytes separately in `RevengeTools`.
- Operand widths and semantics remain open; embedded `FFh` values prove that a
  delimiter-based decoder would be wrong.

### Goal 2, slice 3 — fixed-point heat and accuracy equipment

- Verified that unit bytes `+86h/+87h` are a single 8.8 fixed-point heat
  accumulator. Movement contributes fractional values, the UI reads the high
  byte, and `DS:176A` subtracts `heatSinkCount * 10h` before clamping at zero.
- Named `1A1F:533A` as `UpdateUnitHeatAccumulators_533A`; its environment/map
  modifier branch remains explicitly proposed pending a map-state trace.
- Verified unit byte `+8Fh` as `hasAccuracyUpgrade`: acquisition lowers the
  gunnery target number by two and the status screen prints `Accuracy`.
- Exposed both fields through `RevengeTools`; remaining unresolved unit-record
  work is now concentrated on the exact special-missile mode and independent
  controlled-save confirmation of pilot/allegiance state.

### Goal 2, slice 4 — class-dependent missile upgrade

- Promoted unit byte `+8Ch` from an opaque special mode to the probable shared
  `missileUpgradeState`. Four immutable upgraded BattleMech templates set it,
  and every one carries missile launchers.
- Normal units use it to add the byte indexed from
  `ImprovedMissileDamageBonusTable_3D0D`; damage-model `03h` infantry instead
  convert the missile attack into 30 target heat with no ordinary damage.
- The upgrade UI independently names `Improved Missiles` and `Inferno Rockets`,
  matching those class-dependent behaviors. The acquisition handler remains a
  future direct-trace item, so the semantic name stays P rather than V.

### Goal 1, slice 4 — unit destruction and leg-loss policy

- Translated `2D1B:2453` as `DestroyScenarioUnit_2453`: it clears the active
  record, invalidates all attackers targeting the removed unit, preserves its
  final map coordinates, selects friendly/enemy event state, and dispatches the
  destruction effect.
- Recovered `2D1B:2CB4` as the exact scenario-suffix predicate called after
  either BattleMech leg is destroyed. The proposed name
  `ShouldDestroyUnitAfterLegLoss_2CB4` describes its sole caller; mission design
  rationale remains P pending a SCENE/campaign trace.
- Added both signatures and DS assumptions to `REVENGE.dcproject`.

### Goal 1, slice 5 — lance leader loss and formation recovery

- Translated `2D1B:2A30` as proposed `FindOperationalLanceLeader_2A30`: it
  searches one four-record lance, prefers the first occupied unit with nonzero
  walk movement, and falls back to the first occupied immobilized unit.
- Added maintained C for segment `2208`. Proposed `IsCurrentLanceLeader_1829`
  combines an explicit first-lance state byte with the first operational record
  in a four-unit block. Proposed `RebuildLanceFormationAfterLeaderLoss_18A1`
  inherits the replacement leader's attack/order state and rebuilds follower
  route points through the signed formation-offset table at `DS:17DE`.
- Initially recorded `DS:B587` as unresolved; the later weapon-AI pass verifies
  it as the per-unit consecutive-attacked-frame counter. `DS:B5B9` remains the
  probable per-unit lance formation/leader state (P).
- Preserved an apparent executable quirk: `DestroyScenarioUnit_2453` masks the
  boolean leader result with `000Ch`, rather than masking the destroyed unit
  index. Thus the regroup routine receives lance base zero whenever invoked.

### Goal 1, slice 6 — packed terrain damage and structure impacts

- Recovered `1A1F:0CF9` as verified `ReadTerrainDamageState_0CF9`. Terrain
  damage is a separate two-bit-per-cell map: four states per byte, row stride
  at `DS:00AA`, far map pointer at `DS:AE5F`, and mask/shift tables at
  `DS:2ED2/2ED6`.
- Recovered `1A1F:0C50` as verified `AdvanceTerrainDamageState_0C50`. It bounds
  coordinates, recognizes three special destructible terrain IDs beginning at
  `DS:8859`, consults a terrain capability table, and increments the packed
  state through `DS:2ECE`.
- Recovered `ApplyTerrainImpact_276F` as a `void` routine managing 90 six-byte
  impact-animation records at `DS:810C`; the completed collapse pass now maps
  its map-specific 2x2/3x3 footprint consumer as well.
- The leader-regroup consumer also promotes `DS:AE9D` from an unknown SCENE
  runtime byte array to probable per-unit formation mode.

### Goal 2, slice 5 — vehicle behavior-class boundary

- Exhaustive references to unit byte `+95h` show that core attack/damage code
  branches only for value `03h`: the infantry hit table and infantry
  Inferno-Rocket behavior. The correlated non-infantry values do not select
  separate vehicle armor charts or location-destruction rules there.
- This verifies that Rommel, Pegasus, Drillson, Mobile HQ, APC, Ammo Carrier,
  Galleon, and Skulker use the common BattleMech-shaped directional hit tables
  and eight-location destruction switch in the shipped combat engine.
- Consequently the documentation keeps BattleTech front/side/rear/turret and
  motive terminology as the desired external model, but leaves the engine's
  vehicle location arrays numbered. A one-to-one record-sheet projection would
  be speculation without live damage evidence or another mapping table.

### Goal 5, slice 2 — first executable SCENE opcodes

- Recorded the complete `CFh..FEh` dispatch-table boundary and decoded 39
  opcode entries directly from cursor movement and side effects, including the
  shared six-entry `DCh..E1h` event family and eight relative-branch forms.
- Verified armor damage, interpreter stop, relative jump, conditional unit
  branch, four-point movement-route setup, ground/unit attack targeting, and
  equipment installation/removal operations.
- Added the affected per-unit runtime arrays to the DS map with conservative
  confidence labels. The next decoder slice should work backward through
  `F4h..EAh` and only then emit a control-flow-aware CLI disassembly.

### Goal 5, slice 3 — reachable control-flow closure

- Verified the interpreter's common default path: every reached byte below
  `CFh`, not only `00h`, finishes the current pass through `1A1F:3A6A`.
- Decoded `D0h` as a three-array scene-runtime slot initializer and `EFh` as a
  conditional branch when a unit lacks a requested equipment/weapon ID.
- Decoded the final reachable unknown, `CFh`, as a selector that sets one of
  the two global flags at `DS:03EB/03EC` and continues the interpreter.
- Extended the evidence decoder to preserve raw out-of-range stop bytes and
  follow both destinations of `EFh`; all semantics remain tied to executable
  cursor movement rather than inferred from SCENE byte frequency.
- Regenerated all 30 evidence reports with zero unknown reachable entry points.
  Unused dispatch-table entries remained a separate completeness task.

### Goal 5, slice 4 — complete dispatch-table widths

- Audited all 48 words at `1A1F:2A84` and corrected the shifted opcode mapping:
  `E8h` calls `1A1F:469C`, while `E9h` is the five-operand unit placement and
  route initializer and `EAh` adds one ammunition-family capacity unit.
- Recovered the six previously omitted handlers: `D5h` sets equipment-upgrade
  flags, `DAh` conditionally branches on unit presence/scene state, `E8h`
  invokes the unit helper, `EAh` restores ammunition, `F0h` tests current
  ammunition, and `F4h` repairs armor.
- Corrected the `CFh` handler address to `1A1F:3A46` and added verification for
  the newly decoded operand widths and both conditional branches.
- Changed coverage accounting to count unique bytes. `SCENEK` deliberately
  branches into an `E2h` operand tail that is a valid `DEh` instruction on the
  alternate path, so summing instruction lengths incorrectly exceeded the
  script size.
- Traced the `E8h` helper as proposed `AdvanceUnitSceneRoute_469C`: it consumes
  the 11-byte route records at `DS:86C1`, selects successive X/Y waypoints, and
  updates the active per-unit destination arrays. Traced `E9h` through proposed
  `InitializeScenarioUnitFromTemplate_2472`, `PrepareUnitTypeResources_5962`,
  and `AssignPilotRosterEntryToUnit_0AFC`, supporting the higher-level
  `SpawnScenarioUnit` opcode name.

### Goal 4, slice 2 — retained graphics pseudo-operation audit

- Confirmed `REVENGE_0800.c` has no remaining `<invalid>` expression.
- Removed redundant `SEQ` constructions from masked four-bit color-table
  indexes; the discarded high halves could not affect the result.
- Retained the remaining `SEQ`/`SLICE` and register-style outputs where they
  encode real far-pointer normalization, carry-chain pixel unpacking, or
  32-bit DX:AX/CX:BX arithmetic. Those are representation artifacts, but
  replacing them without translating the complete routine would hide real
  16-bit behavior rather than improve the annotation project.

### Goal 3, evidence gate

- The current evidence contains campaign checkpoints and broad cross-slot
  differences, not one-action save pairs. They remain useful for structure and
  progression correlations but cannot independently verify movement, one shot
  of ammunition, one armor hit, heat, internal damage, or mobility damage.
- `compare-save` and `analyze-save-set` are ready; field promotion under this
  goal remains pending deliberately isolated captures.

### Cycle checkpoint

- Goals 1 and 4 have met their stated completion criteria for this pass.
- Goal 2 has a complete static `96h` record map; the remaining mutable-field
  promotions are intentionally coupled to Goal 3's controlled-save evidence.
- Goal 5 now has complete structural coverage of all 48 dispatch entries and
  zero unknown reachable entry points across all 30 supplied scripts. Further
  work is semantic refinement rather than decoder recovery.
- Goal 6 has exact traces for all 16 embedded streams and consistent simulated
  PIT/state transitions; unused `E8h/E9h` commands are verified through exact
  assembly flag semantics and synthetic boundary traces.
- Goal 7 is synchronized through this checkpoint: maintained C, data map,
  toolkit, documentation, tests, and `REVENGE.dcproject` agree on promoted
  names and signatures.

### Goal 5, slice 5 — SCENE1 end-to-end trace and message banks

- Verified the 72-message layout as six speaker banks of 11 generic narration
  categories followed by six scene-event messages.
- Linked opcodes `E1h..DCh` to event slots `0..5` and message indices
  `42h..47h`; SCENE1's run-away, Jenner explosion, bridge, DropShip, and hull
  messages independently corroborate their control-flow branches.
- Accounted for all 166 SCENE1 instruction bytes from initial unit damage and
  tactical setup through campaign clock, map polling, unit movement milestones,
  event activation, and termination.
- Added event-message links and bank labels to generated evidence reports.
- Goal 5 now meets its first-pass completion criteria. Remaining helper and
  speaker-identity work is semantic refinement rather than decoder recovery.

### Goal 5, slice 6 — generic narration categories

- Verified that narration subjects/unit indices `0..3` select generic speaker
  banks `0..3`, indices `4..7` select bank 4, and indices 8 or greater select
  bank 5. This does not assume fixed character identities.
- Distinguished `DS:B2F2` as the narration subject from `DS:8927` as the
  message category. SCENE event opcodes store their operand in the former and
  `0Bh + eventSlot` in the latter.
- Proposed conservative names for ten populated generic categories from all 30
  files. Category 5 is unused throughout the supplied corpus; categories 2 and
  8 remain explicitly low confidence.
- Added verified `HasNarrationMessage_5476` to the dcproject. It returns the
  selected string's first byte as an availability test rather than returning
  an offset. Its scope is deliberately limited: the render path at
  `1A1F:4588–45D8` performs special-event category normalization separately.

### Goal 5, slice 7 — interpreter ABI stabilization

- Verified `ExecuteSceneInstructions_2A4E` is a parameterless far procedure.
  Its `16h`-byte BP frame contains only local state; the bytecode cursor at
  `DS:A9DB:A9D9` and ambient `DS=3A6Ah` replace the false arguments previously
  inferred by Reko.
- Audited all 15 distinct direct callees from the interpreter assembly and
  recorded their argument order, widths, pointer distance, and return use in
  `SCENE_INTERPRETER_ABI.md`.
- Corrected `CopyFarMemory`: its byte count is passed in `CX`; only the
  source and destination far pointers occupy the C stack.
- Promoted the recovered SCENE helpers, tactical edge-effect queue, narration
  availability path, and campaign-clock render path into maintained C and the
  DS memory map.
- Completed active signature coverage for all 183 procedures named at that
  checkpoint. The two
  internal RLE/EGA helpers now have explicit input/output register contracts;
  no named procedure is left for Reko to infer from scratch.
- Verified there are no duplicate procedure addresses, names, or normalized
  real-mode physical aliases across the dcproject and metadata include.

### Runtime slice 1 — far-memory fill

- Recovered `3985:0009` as the optimized far-memory byte-fill worker and
  `3985:002F` as its conventional value/count wrapper.
- Removed an uninitialized Reko shadow variable that discarded the caller's
  fill byte in the maintained C.
- Added both contracts to the dcproject and metadata include.

### Runtime slice 2 — CRT file I/O

- Recovered the Borland-style open path, DOS IOCTL wrapper, zero-length
  truncate/extend operation, CRT and DOS close paths, and text-mode write with
  LF-to-CRLF translation.
- Collapsed the duplicated `fileHandle_*` SSA variables in `REVENGE_3915.c`
  without changing its create/open/exclusive/share branches.
- Removed false accumulator arguments from every close call and locked the
  actual stack contracts into the Reko inputs.

### Runtime slice 3 — integer formatting

- Recovered the shared base-2-through-36 conversion core plus the 16-bit
  `IntegerToString` and 32-bit `LongToString` wrappers.
- Corrected their return type: all three return the original destination far
  pointer in `DX:AX` rather than `void`.
- Replaced the generated `SEQ`/division reconstruction with ordinary 32-bit C
  while preserving signed decimal and unsigned nondecimal behavior.

### Goal 7 checkpoint — documentation and consistency gate

- Replaced the obsolete future-work backlog with an evidence-ranked list of
  genuinely outstanding work.
- Synchronized the current verification and Reko-entry counts across the
  research documents.
- Added `Test-AnnotationConsistency.ps1` to detect duplicate metadata keys,
  stale generated aliases, and baseline drift before later annotation commits.

### Input/rendering goal — slices 1–3 complete

- Recovered `0800:398C`, `39FB`, and `3A23` as the uncloaked absolute and
  relative mouse-position helpers. The register worker clamps coordinates,
  forwards the driver-scaled position to INT 33h, and redraws the software
  cursor only when its displayed position changes.
- Recovered `0D73:566E` as `DrawClippedSprite_566E` with its real five-word
  semantic interface: destination far pointer, encoded-sprite far pointer,
  x/y position, and clipping-region index. Adapter dispatch and the EGA A200h
  redirection are explicit; the former ES return is removed.
- Verified `DS:063A` as 17h records of 10h-byte `TextWindowContext` state and
  recovered `SelectTextWindow_0009`, `RenderTextToActiveWindow_000B`, and
  `DrawTextString_470B`. Geometry, palette colors, saved cursor position,
  scrolling, line advance, and wrapping now use named fields.
- Added seven procedure contracts and fifteen net new address annotations to
  the dcproject. Follow-up recovery of the paired clipped-text alignment
  wrappers brings it to 237 unique procedure entries and 477 unique address
  annotations.

### Rendering/UI follow-up — centered text, sprite formats, and selection state

- Recovered `DrawCenteredClippedText_3E35` and its two in-place normalization
  helpers. The wrapper optionally splits an over-width label at an explicit
  index, truncates each rendered line to a maximum pixel width, and centers it.
- Confirmed the common encoded-sprite header used by the native renderers:
  byte 1 plus one is height, byte 2 determines decoded row width, and payload
  starts at byte 4. `DrawVgaRleSprite_50A1` uses nonzero literal palette bytes
  and `00h,count` transparent runs; CGA/Tandy and EGA retain native packed and
  mask streams whose individual tokens still need a resource-backed trace.
- Recovered the modal selection family as `BeginUiRegionSelection_000B`,
  `PollUiRegionSelection_0003`, `RunSingleUiRegionSelection_000C`, and
  `ToggleActiveUiRegionHighlight_0009`.
- Promoted `DS:B652-B65A` to verified cached XOR-highlight geometry and
  `DS:B66A` to the verified saved-row byte array restored when grouped
  selection is cancelled.
- Synchronized nine new procedure contracts and annotations across the
  maintained C, dcproject, metadata include, and DS map, bringing the baseline
  to 246 procedures, 486 annotations, and 84 metadata declarations.

### Music, text-entry, and frame-composition slice

- Recovered the complete `3014` music-resource controller: its fixed `30D4h`
  staging buffer, cached resource index, driver compatibility remaps, and
  start/stop/enable sequence now have maintained names and contracts.
- Recovered the `0D73` string-field utilities and interactive editor. The
  editor's fixed buffer, cursor index, punctuation whitelist, and three
  allowed-character class bits are now verified DS fields.
- Reconstructed active-window clearing and frame composition from assembly.
  Four corner tiles and four `FFh`-terminated repeating edge sequences replace
  Reko's invalid nested-call expression; the retrace delay now performs the
  exact caller-supplied number of waits.
- Established the first digital-audio table contract: `DS:5CFC` contains
  `16h` records of `0Bh` bytes, searchable by their code byte. The scenario
  bank loader calculates packed offsets, allocates one far buffer, and loads
  each referenced sample slice into it.
- Synchronized 19 new procedure contracts and 15 new address annotations,
  bringing the baseline to 265 procedures, 501 annotations, and 103 metadata
  declarations.

## Sampled-audio driver and extraction pass

- Recovered `InitializeDigitalSoundDriver_0005`: the selected descriptor is
  probed/acquired, PIT calibration returns a 32-bit value in `DX:AX`, that
  value is halved and capped at 8,000 Hz, and rates below 3,000 select the
  PC-speaker fallback.
- Recovered `PlayScenarioDigitalSoundSequence_0742` and the narrow `375F`
  service surface used to initialize, queue, synchronously poll, and remove
  34h-byte digital sample descriptors at `DS:5950`.
- Promoted `DS:593E`, `B60E`, `B612`, `B614`, `B626`, and `B62D:B62F` with
  verified driver, descriptor, queue, rate, and packed-buffer roles.
- Added `inspect-digital-sounds` and `export-digital-sounds` to RevengeTools.
  They resolve the 22 `DS:5CFC` records through the executable resource table
  and export byte-exact spans from `INFOCOM.BIN` and `DPHRASES.BIN`.
- Recovered the timer ISR at `375F:0A62`: source bytes are mixed around `80h`,
  advanced through a 16.16 cursor, clipped through `CS:04D6`, and submitted to
  the hardware callback. This verifies unsigned 8-bit mono PCM at 8,000 Hz.
- Mapped every field of the 34h-byte playback descriptor and the queue's active
  count/mix state. RevengeTools now emits canonical WAV derivatives alongside
  the raw byte-exact samples.

## MIDI hardware-driver discovery pass

- Recovered the five DS-resident MIDI driver descriptors and their device
  names: Internal Speaker, Tandy, IBM PS/1, AdLib, and Roland.
- Mapped each descriptor's probe, activation, deactivation, byte-filter, voice,
  reset, patch, and interrupt-service slots to the raw tail of segment `3621`.
- Seeded all 43 unique callback entry points in the DCProject. The next Reko run
  can now emit the previously invisible device-driver routines for maintained-C
  translation and final argument recovery.

## Digital-output hardware-driver discovery pass

- Separated the nine shared hardware descriptors from their nine PCM playback
  descriptors and mapped the selector order at `DS:593E`.
- Recovered device names and probe/acquire/release plus initialize/release/write
  callback addresses for Tandy, IBM PS/1, Sound Blaster, AdLib, CMS, Innovation,
  Covox, and the null driver.
- Seeded all 54 unique `375F:0070-04B5` callback entry points with the register
  contracts proved by the generic dispatchers.

## Audio controller contract pass

- Normalized the `30B2` PC-speaker and IRQ0 names across maintained C and the
  DCProject, and corrected `InstallMusicTimer_02D9` to `void`; its apparent ES
  result was only an incidental register value at return.
- Verified that loader address `3037:078C` aliases executable address
  `30AF:000C`, promoted it to `PlayPCSpeakerEffectByIndex_078C`, and represented
  `DS:58DB` as a 16-entry weapon-effect far-pointer table in the data segment.
- Recovered `ReleaseDigitalHardware_005B` and named the two descriptor layers'
  probe/acquire/release callbacks and reference counters.
- Repaired the high-confidence calibration loop at `375F:05D6`: it services
  exactly `0E0Dh` samples, obtains the elapsed PIT count in `DX:AX`, then divides
  constant `FFD0CE97h` by that elapsed count. The origin of the calibration
  seed left in DX by the lookup builder remains deliberately unabstracted.

## PIT calibration and generic PCM mixer pass

- Recovered the complete `38AE` PIT calibration helper family, including the
  temporary IRQ0 handler, interrupt-vector swap, elapsed-count latch, and
  unsigned 32-by-32 division. The temporary queue and silent sample at
  `DS:6F5E` and `DS:6F70` are now distinct from the normal playback queue at
  `DS:6F4C`.
- Recovered all stack wrappers and register-call cores for the `34h`-byte PCM
  descriptor: initialize, calculate 16.16 step, set loop range, install
  completion callback, link/unlink, reset, finish loop, stop, and read state.
- Corrected an earlier layer error in `InstallDigitalDriverQueueCallback_070C`:
  it reads the playback descriptor's write callback at `+06h` and mix scale at
  `+08h`; its `+00h` field merely points to the separate shared hardware
  descriptor.
- Translated the timer mixer and saturated lookup generator to maintained C,
  preserving the prior-tick output behavior, unsigned `80h` silence centre,
  16.16 cursor arithmetic, loop wrapping, completion callback, and per-driver
  scaling.
- Locked down ten newly named core entry points and their register arguments in
  the DCProject, and synchronized all 13 relevant contracts into metadata.

## Weapon-effect playback pass

- Corrected `DS:800A` from a proposed music-service flag to the verified
  `SoundEffectsEnabled_800A`. The options menu uses it for the SOUND row while
  the separate `DS:800C` controls music.
- Proved that `DS:58DB` is a 16-entry PC-speaker weapon-effect stream table:
  `DispatchWeaponEffect_0567` indexes it with the same effect ID used by the
  digital PCM path. The maintained names, documentation, and toolkit commands
  now reflect sound effects rather than background music.
- Recovered `PlayDigitalWeaponEffect_058D`, the 16-record table at `DS:5C5C`,
  and completion callback `31FB:06E9`. Verified record fields are playback
  scale at `+02h`, packed-buffer offset at `+04h`, and sample length at `+06h`;
  the proposed resource index at `+00h` and unknown word at `+08h` retain their
  lower confidence.
- Verified the special three- and six-pass repetition of effect IDs `06h` and
  `0Fh`, plus the driver/timer teardown performed on final completion.

## Complete audio-driver recovery pass

- Translated the complete `375F:0070-04B5` programmed-I/O callback block for
  Tandy PSG/DAC, IBM PS/1, Sound Blaster direct DAC, AdLib PCM, CMS,
  Innovation, Covox, and the null output. Device-private ports, OPL delays,
  and the CMS amplitude table are fixed in metadata.
- Recovered the hardware descriptor's default/candidate probe parameters and
  corrected `InvokeDigitalHardwareProbe_0006` to return the callback result.
  Sound Blaster base candidates now flow through DX exactly as in assembly.
- Found and corrected a `0Eh` skew in the earlier MIDI callback map: a complete
  null backend occupies `3621:08B6-08C3`, so the PC-speaker backend starts at
  `08C4`. All subsequent Tandy, IBM PS/1, AdLib, and Roland addresses and
  contracts were moved to their verified instruction boundaries.
- Translated the MIDI device callbacks, including PC-speaker PIT scheduling,
  Tandy/PS1 three-voice round robin, OPL2 timer calibration and patch decode,
  and the MPU-401 UART transmit ring plus INT 0Ah handler.
- Replaced the remaining high-confidence audio `SEQ` and `out` artifacts with
  explicit far-pointer and 32-bit DX:AX contracts. Named the bounded resource
  reader used to populate the packed digital-sound bank.

## Scenario sound-sequence semantics

- Verified `DS:5DEE-5E6D` as the scenario bank-load code lists and
  `DS:5E6E-5F6A` as the playback-fragment table. Every character, including
  punctuation, resolves through the 22-entry `DS:5CFC` sample table.
- Identified `6633h` as the unity/reference descriptor scale: narration passes
  it as both stored and requested scale, producing an exact 1.0 scale ratio.
- Extended RevengeTools export with resolved fragment order, aggregate byte
  size, and playback duration; verification now passes 74 assertions.

## Campaign/menu lifecycle spine

- Recovered `RunCampaignLoop_0006`, `RunTitleAndMainMenu_309C`, and
  `RunInGameMenu_274D` as the top-level title, campaign-stage dispatch, and
  in-game transition controllers.
- Removed the broken reconstructed-stack calls around `0D73:274D`; the two
  paths pass explicit first-option values `00h` and `04h`.
- Named the modal-window save/restore, confirmation, title-text animation,
  scenario-message, timed-input, and input-drain helpers and supplied C
  signatures in both Reko metadata sources.
- Proposed `DS:24D3-24D5` as the roster-prepared guard and pending campaign
  stage/phase deltas, based on their repeated preparation/save paths.

## SCENE-to-campaign state bridge

- Refined D4h from a generic flag operation to persistent campaign milestones
  and correlated six used selectors with their neighboring scenario messages.
- Recovered `DS:883F` as per-unit exit/withdrawal state: DBh routes to an exit,
  bit 80h marks arrival, and DAh branches for withdrawn or absent units.
- Initially proposed `DS:87D4` as active-order state; the later weapon-AI pass
  verifies it as the attacked-this-frame flag. `DS:8B68` remains tactical
  order mode, and `DS:8657` remains four campaign-upgrade award slots.
- Updated RevengeTools opcode names so fresh evidence reports expose these
  semantics rather than the earlier generic state labels.
- Exhaustively checked the supplied scripts: D4h selectors `00h`, `01h`,
  `02h`, `03h`, `06h`, and `07h` are present; `04h`/`05h`, D5h, and DAh are
  absent. Promoted `DS:8108/810A` to the probable LRM/SRM shipment flags and
  retained unknown labels where the corpus provides no narrative evidence.

## Graphics asset/runtime bridge

- Separated terrain (`ICONSET0..7`), destruction (`DESTROY0..7`), and tactical
  (`MECHSET1..2`) catalogs. Unit-record `+88h`, side adjustment, facing step,
  and compact infantry pairs now form a verified template-to-sprite map.
- Resolved the MAP bytes at `04h..0Bh` as a duplicate of the first eight tile
  cells in all eleven files, and made the 30-file SCENE resource relationship
  the automatic MAP-to-ICONSET selection source.
- Recovered the CGA two-phase packed-pixel lookup generation, transparency-mask
  construction, alternate-scanline repack, Tandy four-bank fill, and BIOS
  palette wrapper. Their contracts are fixed in both Reko inputs and reproduced
  independently by RevengeTools.
- Recovered `QueueTacticalImpactVisual_0846` and the 80-entry queue at
  `DS:B2F4`, including the complete class-to-sprite and class-to-sound mapping.
  Visual comparison separates the red Inner Sphere/Kurita MECHSET1 from the
  blue/teal Clan MECHSET2. The direct write at `0D73:02B4` now verifies that
  scenarios `1`-`E` and `T` select MECHSET1 while `F`-`S` select MECHSET2;
  `1A1F:03D4` likewise proves paired ICONSET/DESTROY suffix selection.

## Borland far-heap runtime pass

- Recovered the public 16-bit and 32-bit allocation contracts and the core free
  contract without Reko's false ES/DX output arguments.
- Named the free-list unlink/insert, split, initialize/extend, adjacent-block
  coalescing, and terminal-arena release helpers in maintained C and both Reko
  metadata inputs.
- Documented the 16-byte block header, eight-byte payload offset, 16-byte
  request alignment, and the three far-pointer roots at `DS:701A-7025`.

## Mission-date and presentation path

- Recovered the full `0D73:35AA-4155` presentation family: background/resource
  selection, framed heading, date animation, map-region blinking, follow-up
  messages, and indexed sprite backing-buffer capture.
- Promoted the month, title, date, highlight rectangle, sprite geometry, and
  five-byte follow-up message tables in the DS map with verified structural
  roles and conservative semantic confidence.
- Removed false DS/register arguments from four procedures and fixed their C
  signatures in both Reko metadata sources. `2007:132C` is now the verified
  text-cell-to-pixel beveled menu-button renderer.
- Repaired the main-menu division/multiplication artifacts against assembly;
  all three labels now use explicit font metrics and pixel widths.

## Unit-selection and status UI pass

- Recovered the real return contracts for the two-stage class/type selector:
  both return the selected MECHTYPE ID, or FFFFh for Cancel.
- Removed false DS arguments from the selection, status-header, and graphics
  buffer-release helpers. The range/speed and experience/gunnery header
  arguments are verified starting Y coordinates.
- Repaired the armor-condition index in `DrawUnitStatusScreen_483A`: assembly
  divides maximum armor by 46h and clamps the resulting label index to three.
- Named the class/type/name/allegiance/stat table fields and verified the
  inclusive far-buffer release table rooted at DS:83EE.

## Game-options controller pass

- Recovered `RunGameOptionsMenu_417F` as the shared title/in-game options
  controller, including music, sound effects, the unresolved three-state
  `DS:800E` setting, input device switching, and embedded resume/exit actions.
- Replaced Reko's empty jump-table reconstruction with the verified eight-key
  dispatch and preserved the controller's action return values.
- Recovered `RunOptionsMenuSelection_5D5E` as an `int16` selection wrapper
  which waits for the initiating mouse button to be released.
- Promoted the four far-string pointer tables at `DS:46AE-46DE` and locked both
  procedure contracts into the dcproject and metadata include.

## Packed-resource leaf-loader pass

- Recovered the four routines at `21E7:000C-00F4` as whole-file read,
  seek-and-read, packed-resource load, and Westwood compression-dispatch
  helpers. Removed Reko's false `SI` arguments and false ES/DX returns.
- Verified the shared compression selector: `00h` is a far raw copy, `01h` is
  LZW-12 with a `3C00h` workspace, `02h` is LZW-14 with a `BD00h` workspace,
  and `03h` is the existing byte-RLE decoder.
- Corrected `OpenTrackedFile` and `CanOpenFileForRead`: their apparent register
  inputs were local registers, not C arguments. All maintained callers now use
  their stack-only contracts.
- Recovered the screen-resource leaf at `0D73:32F4` as `void` and separated its
  previously entangled DX:AX result from `CaptureVideoTileStrip_000C`, which is
  the routine that actually allocates and returns the title tile backing strip.
- Locked all recovered contracts into both Reko metadata inputs and documented
  the compression paths at their entry addresses.

## Campaign presentation runtime completion

- Recovered the title-line animation and its overlapping five-byte fade-color
  ramp at `DS:2718`, including the exact fade-in/fade-out bounds and restored
  backing strip.
- Corrected the presentation contracts at `0D73:324E`, `33C1`, `341F`, and
  `3C7C`: the two resource presenters are `void`, while the modal wrapper and
  input flush return the actual dismissal key. Callback presence is a separate
  skip-wait flag and is no longer confused with that return value.
- Named and locked the packed-nibble converter, 32-bit far copy, DX:AX shift,
  text-window margin adjustment, exit-handler terminator, and local-clock
  snapshot helpers in maintained C and both Reko inputs.

## SCENE state-semantics refinement

- Replaced the D4h and D5h handler's anonymous selector values with the
  verified campaign-milestone and unit-upgrade operations. Only the narrative
  identities of D4h selectors 04h/05h and the four D5h award slots remain open.
- Refined `DS:883F` to `UnitWithdrawalState_883F`: bit 01h is an active
  scripted exit route and bit 80h records arrival, shared by DBh and DAh.
- Followed every `DS:8B68` consumer through targeting, movement, attacks, and
  lance propagation. Proposed mode labels are now 00h scripted route, 01h
  hold-position attack, and 02h autonomous seek-and-destroy/pursuit; they stay
  at P confidence pending a controlled play trace.

## Tactical terrain-impact presentation pass

- Translated `ApplyTerrainImpact_276F` from assembly and corrected its false
  Reko return contract. The ground-attack caller actually discards the call's
  AX and obtains the terminal state from `ReadTerrainDamageState_0CF9`.
- Mapped `DS:810C` as 90 six-byte animation records containing map X, map Y,
  and a random 00h-02h variant. The routine rejects duplicate coordinates and
  allocates only records whose X word contains the FFFFh free sentinel.
- Preserved the executable's control-flow subtlety: a state-2 structure
  collapse is considered only when the animation-record branch was not taken.
  The scenario modes select terrain ranges 8Ch-94h, E6h-EEh, and A9h-ACh.

## Tactical terrain-collapse completion

- Translated `AdvanceTerrainEffects_042A`: paired entries in the 32h-word
  `DS:B28E` queue now have explicit packed-byte/subcell semantics, including
  terminal removal without leaving a gap.
- Translated `CollapseStructureAtMapCell_2AF3` and corrected its false return
  contract to `void`. Scenario mode 08h derives a 2x2 origin from terrain
  parity; the other supported modes derive a 3x3 origin from the terrain ID.
- Verified that every footprint tile is advanced to terminal damage, receives
  a heavy impact visual, and destroys every deployed unit in its surrounding
  3x3 casualty area.

## Unit combat-rating rebuild completion

- Translated `RecalculateUnitCombatRatings_0005` from assembly and verified its
  four-argument contract: unit record, unit slot, rebuild-counts flag, and
  advance-recovery flag.
- Mapped `DS:B04F` as the 24 x 23 byte installed-weapon-count cache and confirmed
  `DS:B02C` as the per-unit heat-sink count produced during a full equipment scan.
- Verified the `DS:8929` recovery counters, ammunition-family filtering, and the
  23-bit availability mask at `DS:A971`; the latter feeds the close-, medium-,
  and long-range weapon masks used to build each `DS:AEF1` rating record.
- Promoted the six-word `TacticalCombatRatings` layout to verified confidence:
  movement, durability divided by 16, close firepower, medium firepower, long
  firepower, and sensor damage.

## Tactical selection and destruction-state consolidation

- Verified `DS:03DC` as the active tactical unit selection and proposed
  `DS:03DE` as the remembered opposing-unit slot used by visible-enemy cycling.
  Both use FFFFh for no selection and are invalidated on withdrawal or destruction.
- Mapped `DS:885B` as 24 three-byte destruction markers: map X, map Y, and a
  tactical sprite code. Friendly destruction stores DCh, opposing destruction
  stores DDh, and the renderer displays sprite `0100h + code`.
- Replaced raw targeting, coordinate, facing, attack-target, and weapon-recovery
  offsets throughout the maintained combat code with their verified DS names.
- Reconciled stale unknown entries in the generated DS-reference appendix with
  the higher-confidence primary memory map. The two SCENEL-only writes at
  `DS:99B1` and `DS:B579` remain hypotheses because no executable reader exists.

## Tactical input and selection controller

- Recovered the top-level tactical action dispatcher at `1A1F:4A9E`, including
  unit cycling, speed selection, narration prompts, overview zoom, and unit-panel entry.
- Verified the internal translated F1-F10 values and the complete function-key
  dispatch: direct unit selection, three lance groups, visible-enemy cycling,
  and dropship/overview controls. F8 is deliberately unused.
- Mapped `DS:17DC` as the zero-based tactical speed index and preserved the
  executable's key-9 alias of speed 8. Locked the controller and its immediate
  helper contracts into both Reko ingestion inputs.

## Tactical sprite-map composition

- Recovered `ComposeTacticalSpriteMaps_0007` as the complete pre-render pass
  for destruction markers, campaign-upgrade markers, visible units, sensor
  contacts, jump overlays, and queued map-edge effects.
- Recovered `StampTacticalSpriteRectangle_021A` with its exact 19x12 clipping,
  sequential sprite-ID advancement, and one-shot overlay-map behavior.
- Named the four upgrade-marker coordinate pairs, the 24-entry unit sprite-ID
  table, and the transient overlay sprite. Locked both renderer contracts into
  the dcproject and metadata include.

## DOS local-clock conversion

- Recovered `ConvertLocalDateTimeToEpochSeconds_0001` as a true 32-bit DX:AX
  return instead of Reko's artificial output argument. The maintained C now
  expresses the 1980 epoch base, four-year cycles, leap day, month/day, time,
  signed timezone offset, and DST subtraction directly.
- Promoted the DOS date/time register layouts and the ten-byte local-clock
  snapshot to named structures, then removed the split high/low return handling
  from `CaptureLocalClockSnapshot_000F`.
- Named and cleaned `IsDaylightSavingTime_01ED`, including its day-of-year mode
  and the executable's legacy April-through-October transition rule. Both
  contracts are locked into the dcproject and metadata include.

## Far-heap pointer-state naming

- Replaced the anonymous `DS:701A-7025` offset/segment halves with explicit
  arena-base, physical-tail, and circular-free-list-head field names.
- Updated both allocation and release implementations, including descriptive
  setter arguments, so all far-heap pointer reconstruction now reads directly
  in segment:offset order.

## DOS error-state naming

- Replaced the remaining anonymous globals in `TranslateDOSError` with
  `RuntimeErrno_007F`, `RuntimeDOSError_6FAE`, and the signed-byte
  `DOSErrorToErrnoTable_6FB0`.
- Renamed the translated local to `errnoValue`, preserving the distinct path
  for negative Borland errno inputs and the DOS-error clamp to code 57h.

## DOS read-wrapper contract

- Replaced `DOS_ReadFile`'s `Eq_` arguments and AX temporary with
  `fileHandle`, `destinationBuffer`, `byteCount`, and `bytesReadOrError`.
- Corrected its locked return type from unsigned word to signed `int16`, since
  translated INT 21h failures return `-1` while successful calls return the
  number of bytes read.

## DOS write-wrapper contract

- Replaced `DOS_WriteFile`'s `Eq_` arguments and AX temporaries with
  `fileHandle`, `sourceBuffer`, `byteCount`, and `bytesWrittenOrError`.
- Named the append and successful-write handle flags, corrected the return type
  to signed `int16`, and locked the far source-buffer contract into both Reko
  ingestion inputs.

## DOS file-attribute wrapper contract

- Replaced `DOS_GetSetFileAttributes`'s `Eq_` path and AX pseudo-registers
  with `filePath`, `attributesInOut`, and `dosErrorCode`.
- Documented CX as output for operation 0 and input for operation 1, corrected
  the result to signed `int16`, and locked the far path contract into Reko.

## Refreshed-decompile unnamed-procedure burn-down

- Classified all 68 procedures which the refreshed Reko output still emitted
  under raw `fnSEG_OFFSET` names; every entry address now has an evidence-based
  procedure contract in the dcproject.
- Worked dependency-first from graphics, tactical, combat-rating, terrain,
  input, and AdLib leaves toward the larger tactical controllers. Three false
  AdLib entry points and the false `1A1F:0517` map-loader entry are explicitly
  suppressed as internal continuations rather than assigned fabricated APIs.
- Finished with `TranslateTacticalMouseInput_5755`,
  `RunTacticalUnitCommandMenu_000B`, `RunTacticalGameOptionsMenu_148A`, and
  `ValidatePrimaryLanceLeader_2B0E`. The last routine's assembly proves an AX
  Boolean return which the original Reko signature had discarded.
- The raw-name/address audit now reports zero of the original 68 procedures
  without a dcproject entry. Large controllers may still receive deeper C
  translations, but their entry points, stack arguments, returns, and roles
  are no longer unknown.
