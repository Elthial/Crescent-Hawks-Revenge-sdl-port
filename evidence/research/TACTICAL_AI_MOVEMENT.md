# Tactical AI and movement pass

This pass bounds the high-value per-frame procedures in segments `2208` and
`2D1B` and gives their verified arguments to Reko. Confidence follows V/P/H/U.

## Per-frame call order

`RunTacticalInteractionLoop_0613` establishes the following sequence:

1. `RefreshAllUnitCombatState_08AF(rebuildWeaponCounts)` recalculates every
   deployed `96h`-byte record, then calls `SelectUnitTacticalTargets_08FA`.
   Target selection is now translated: it validates explicit targets, searches
   visible/contacted opponents, combines allied firepower against shared
   targets, and maps the resulting comparison mask through `DS:08C6`.
2. `UpdateUnitEnemyVisibility_1CCC(unitIndex)` scans the opposing twelve slots
   and latches first contact when line of sight exists.
3. `UpdateUnitEnemyProximityState_1E43(unitIndex)` tests contacted opponents
   against the threshold table at `DS:03E7`.
4. `AdvanceUnitTacticalMovement_0F1F(unitIndex)` derives movement eligibility
   from walk movement, heat, terrain, movement mode, and jump state; selects
   route/formation/target/withdrawal coordinates; then calls
   `MoveUnitTowardMapCell_03EA` for collision-aware neighbor selection.
5. `ExecuteUnitWeaponAI_14A4(unitIndex)` enforces shutdown and an
   experience-indexed heat ceiling, classifies distance/heat/attack arc,
   chooses the first ready weapon from the selected priority profile, and
   calls `ResolveWeaponAttack_1854`.
6. `UpdateUnitHeatShutdown_256B(unitIndex)` makes the 2d6 shutdown check from
   the integer byte of the unit's Q8.8 heat accumulator.

The adjacent `FocusTacticalViewOnUnit_11F7(unitIndex)` contract is also fixed:
it centers the 19-by-12-cell viewport when necessary, synchronizes the tactical
cursor and selected-unit slot, and positions the mouse over that unit.

All six steps have maintained C translations. The tactical command-screen
trace also resolves `DS:890C`: for infantry it selects close assault and for
other units it selects overburn.

## Per-unit state

| DS range | Meaning | Confidence |
| --- | --- | :---: |
| `8667..867E` | current line-of-sight-to-enemy flags | V |
| `8680..8697` | enemy-within-threshold flags | P |
| `87D4..87EB` | attacked-during-this-frame flags | V |
| `87ED..8804` | first-enemy-contact latches | V |
| `8806..881D` | engagement-active flags paired with proximity | V |
| `8827..883E` | active-jump flags | V |
| `88A4..88BB` | selected target: unit, ground sentinel `18h`, or none `FFh` | V |
| `88F3..890A` | explicit attack target with the same sentinel convention | V |
| `890C..8923` | overburn or infantry close-assault enabled | V |
| `8B68..8B7F` | tactical order mode assigned by SCENE FCh | P |
| `A84A..A861` | heat-shutdown state | V |
| `A7F3..A80A` | last target reported by withdrawal narration | V |
| `AE3D..AE54` | remaining jump movement | V |
| `AED6..AEED` | preferred engagement mode: close, medium, long, withdraw, or position | V |
| `B587..B5B6` | consecutive frames attacked | V |

## Weapon priority selection

`WeaponAIHeatLimitByExperience_03E0` contains `14h, 10h, 0Dh, 0Ah, 08h`.
Ordinary weapon AI indexes it with pilot experience plus one; active
`UnitOverburnOrCloseAssaultEnabled_890C` uses the unincremented experience
value, allowing the higher heat ceiling associated with the preceding table
entry.

## Overburn and close assault

The command panel at `2208:000B` indexes the Boolean byte at `DS:890C + unit`.
When unit-record `+95h` is infantry (`03h`), pointer table `DS:41DF` supplies
`"Close Assault"` for state zero and `"Cease Assault"` for state one. All
other damage models use pointer table `DS:420D`, whose entries are
`"Overburn: Off"` and `"Overburn: On"`. The handler at `2208:043C` XORs the
byte with one, and lance regrouping copies the leader's value to followers.

For infantry, the enabled state forces close engagement and dispatches weapon
index `0Ah`, temporarily supplying its ammunition to both participants so the
target can resolve the reciprocal close assault. For other units, it permits
weapon AI to use the next-higher heat ceiling. Heat shutdown clears the state.

Targets at distance 25 or more are rejected; distances below 19, 10, and 4
cells produce fixed range bits, while heat 0, below 6, below 12, or 12+
produces one of four heat bits. The combined mask
indexes `WeaponPriorityProfileByRangeHeat_0FA6`; `DS:0F46` gives the selected
list's length and `DS:0F66` its far pointer. Each list entry contains a 32-bit
weapon-availability mask and a corresponding one-based weapon choice. The
first mask intersecting `UnitWeaponAvailabilityMask_A971` is fired.

`UnitTacticalTarget_88A4` is no longer described as merely a linked-narration
unit. The target-selection, movement, weapon-AI, narration, and lance-recovery
paths all consume it, which verifies its broader tactical-target role.

## Heat shutdown

`UpdateUnitHeatShutdown_256B` reads unit-record `+87h` (whole heat), caps it at
30, and skips the check below heat 14. At heat 14 and above it rolls 2d6 and
compares against `4 + ((heat - 14) / 2)`. Failure clears overburn/close assault
at `DS:890C[unit]` and
sets `UnitShutdownState_A84A[unit]`. This gives Reko a one-word unit-index
argument and an 8-bit Boolean return without inventing DS as a C argument.

## Formation selection and terrain-damage helpers

`SelectLanceFormationMode_1B33` copies the leader's movement/heat mode to
eligible followers, counts deployed lance members, and respects bit `80h` as
a formation lock. One- or two-unit lances accept formation IDs through `02h`,
three-unit lances through `05h`, and four-unit lances through `0Ah`.

Its deterministic branch uses one of the six scenario-header profile bytes at
`DS:8650`, leader experience, and `CompareLanceCombatRatings_26B1`. Its
randomized branch selects through the twelve-byte tables at `DS:2F72`, `2F7E`,
or `2F8A`, walking backward until it finds an ID legal for the deployed count.

`BeginTerrainDamageAtCell_23AC` maps X/Y into the two-bit packed terrain-damage
map. Ordinary terrain enters state one immediately. Terrain IDs
`DestructibleTerrainTypeBase_8859` through base+2 append a packed-byte and
subcell pair to `TerrainDamageQueue_B28E`; `2007:042A` advances and removes
those staged entries.
