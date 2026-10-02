# Tactical runtime helpers

This pass promotes compact tactical procedures newly emitted by the clean Reko
run. Each C translation was checked against the original 16-bit assembly; names
marked `P` retain a proposed semantic boundary where one surrounding state
field is still unknown.

## Camera and panel restoration

`ScrollTacticalViewportToCursor_182E` treats `DS:8331` and `DS:8333` as signed
cursor coordinates inside a `13h` by `0Ch` cell viewport. Negative coordinates
shift the map origin left/up and clamp to zero. Coordinates beyond the right or
bottom edge shift by the exact overflow and clamp the origin to
`MapWidth - 13h` or `MapHeight - 0Ch`.

`RedrawTacticalStatusPanel_16BA` preserves the selected text window, selects and
clears window `06h`, rebuilds its unit/status contents and side indicator,
redraws the campaign clock, then restores the prior window. This verifies the
callee used when tactical overview mode exits.

## Lance comparison and availability

`CompareLanceCombatRatings_26B1` rounds both supplied unit indices down to a
four-record lance base. It refreshes each deployed unit's derived ratings,
sums the first five words of every `0Ch`-byte `UnitCombatRatings_AEF1` record,
and compares the two aggregate vectors. Each greater field contributes `+1`,
each lesser field `-1`; the final result is normalized to `-1`, `0`, or `1`.

`HasActiveLanceFollowers_2853` verifies that the supplied unit is the current
leader and that a later record in the same four-unit group is deployed. Slots
`00h`-`03h` additionally require `DS:B5D8`; the field is provisionally named
`FirstLanceOrdersEnabled_B5D8` until its writers are traced.

## Arm weapons, routes, and narration

`BuildArmWeaponAvailabilityMasks_2604` is narrower than the general
`CountUnitWeaponsByType_0469` helper. It scans exactly eight left-arm and eight
right-arm equipment slots, ignores destroyed entries (bit `80h`), and builds
the unit's 23-bit mask at `DS:A971/A973`. Weapons with an ammunition family are
available only when the corresponding unit-record ammunition word is nonzero.

`AdvanceUnitRouteWaypoint_2C23` advances route indices zero through three in an
`0Bh`-byte `UnitMovementRoutes_86C1` record, then copies the selected X/Y bytes
to `UnitRouteFirstX_8340` and `UnitRouteFirstY_838E`.

`QueueLanceOrderNarration_296F` writes the established narration delay, subject,
and category fields for a friendly lance leader whose tactical-order mode is
not `02h`. The exact player-facing meaning of category `07h` remains proposed.

| Address | Name | Confidence |
|---|---|---|
| `1A1F:182E` | `ScrollTacticalViewportToCursor_182E` | V |
| `2007:16BA` | `RedrawTacticalStatusPanel_16BA` | V |
| `2208:26B1` | `CompareLanceCombatRatings_26B1` | V |
| `2208:2853` | `HasActiveLanceFollowers_2853` | P |
| `2D1B:2604` | `BuildArmWeaponAvailabilityMasks_2604` | V |
| `2D1B:296F` | `QueueLanceOrderNarration_296F` | P |
| `2D1B:2C23` | `AdvanceUnitRouteWaypoint_2C23` | V |
