# Units and equipment

## The 150-byte record

`MECHTYPE.DAT` is exactly 13,350 bytes, proving 89 fixed records of 150 bytes.
The local executable contains 89 corresponding unit names: ordinary
BattleMechs, vehicles, infantry, three Clan designs, and upgraded variants.
This reconciles the file count with Sarna's statement that the game encodes 88
BattleMechs: the raw table is a broader unit-template table, not 89 unique
BattleMech chassis.

The following layout is a **community finding** from the [Tactical Command hex
discussion](https://www.tacticalwargames.net/taccmd/viewtopic.php?f=59&t=3132),
corroborated in broad outline by [Sarna's BattleMech data
page](https://www.sarna.net/wiki/BattleTech:_The_Crescent_Hawks%27_Revenge/BattleMechs):

| Record offset | Meaning |
| --- | --- |
| `0x00` | allegiance/function flag; exact meaning disputed |
| `0x01` | unit type ID |
| `0x02` | walking speed |
| `0x03` | jump-jet count |
| `0x04–0x0B` | current internal structure |
| `0x0C–0x16` | current armor |
| `0x17–0x1E` | maximum internal structure |
| `0x1F–0x29` | maximum armor, including rear torso |
| `0x2A–0x37` | unresolved, apparently loadout-related |
| `0x38–0x53` | paired ammo counters for weapon families |
| `0x54` | engine heat sinks, capped at 10 |
| `0x55–0x83` | location-specific hardpoints |
| `0x84` | tonnage |
| `0x85–0x8A` | unresolved status fields, including sprite/state |
| `0x8B–0x91` | equipment flags such as Listen-Kill, BAP, DHS, CASE |
| `0x92` | pilot-name ID |
| `0x93` | pilot experience: green through elite |
| `0x94` | allegiance |
| `0x95` | record terminus/unknown depending on indexing convention |

Before implementing an editor, verify each field by changing one value in a
copy and observing both UI and combat behavior. The forum itself marks several
fields as guesses.

## Unit ID ranges

- `0x00–0x36`: standard Inner Sphere BattleMechs, Locust through Atlas.
- `0x37–0x3E`: Rommel, Pegasus, Drillson, Mobile HQ, APC, Ammo Carrier,
  Galleon, and Skulker.
- `0x3F–0x41`: infantry, jump infantry, and Elementals.
- `0x42–0x44`: Puma, Black Hawk, and Mad Cat.
- `0x45–0x58`: `+` and `*` upgraded Inner Sphere variants.

The exact names and ordering are present in `REVENGE.EXE` at `0x3B056` in the
local version. Sarna identifies some encoded chassis as never normally
available or encountered, which is useful when testing whether the table is an
authoring superset.

## Combat vocabulary

[Sarna's equipment page](https://www.sarna.net/wiki/BattleTech:_The_Crescent_Hawks%27_Revenge/Equipment)
records the player's-guide range bands:

- close: 0–90 m, 1–3 squares;
- medium: 91–300 m, 4–10 squares;
- long: 301–600 m, 11–20 squares.

Exact internal range values remain unresolved. Damage and heat are presented
as ordinal labels, not published numeric values. The 3050 additions are ER
large laser, ER PPC, Gauss rifle, LB 10-X AC, and small/medium/large pulse
lasers; equipment includes Artemis IV, BAP, CASE, double heat sinks, and TAG.

## Embedded weapon-definition table

`REVENGE.EXE` stores 23 `0Fh`-byte weapon definitions at runtime `DS:0435`.
The records resolve in name order from Small Laser through SRM-6. Confirmed
fields include the far name pointer, heat, damage, stored minimum/maximum
range, half-ton weight, rack/projectile count, ammunition-family ID, critical
slot count, recovery delay, and weapon-effect ID.
Equipment IDs `01h..17h` select these records directly from a unit's
location-specific equipment slots.

The ammunition-family ID is a separate namespace: zero means no ammunition,
while `01h..0Eh` select the fourteen unit-record family counts and ammunition
words. This explains why the unit record has fourteen family fields despite
the executable defining 23 weapons. `RevengeTools export-weapon-evidence`
exports the decoded table and its cross-template equipment frequencies.

The attack routine at `2D1B:1854` consumes these fields directly: range gates
the shot; ammunition family selects and decrements the unit's ammunition word;
heat is added to unit offset `+87h`; recovery delay is added to the unit/weapon
counter at `DS:8929`; effect ID selects the presentation dispatcher; and damage
enters the target damage-resolution path. This is executable behavior rather
than a correlation against published BattleTech statistics.

## Verified code consumers

| Address | Proposed name | Tables and fields consumed | Confidence |
| --- | --- | --- | --- |
| `2B34:0469` | `CountUnitWeaponsByType_0469(unitRecord)` | verified void function taking one far unit-record pointer; equipment slots `+55h..+83h`; builds the 23-word count table at `DS:88BF` | V |
| `2B34:0422` | `DrawCombatRatingDescription_0422(combatRating, x, y, foregroundColor, backgroundColor)` | maps nonzero ratings into six nine-point bands, maps zero to `None`, and renders through the seven-entry far-pointer table at `DS:40CF` | V |
| `2B2D:0077` | `CountOrRemoveUnitHeatSinks_0077(unitRecord, removeInstalledHeatSinks)` | starts with engine heat-sink capacity at `+54h`, counts equipment ID `18h`, optionally removes installed sinks, and returns the total | V |
| `2B2D:0191` | `CalculateUnitWeaponHeatScale_0191(unitRecord)` | adds the movement baseline and `DS:88BF` counts × weapon heat `+04h`, subtracts heat sinks, then returns the clamped `00h`–`05h` status-screen graphic index | V |
| `2D1B:0005` | `RecalculateUnitCombatRatings_0005` | equipment counts, ammo family `+0Bh`, live ammo `+38h`, recovery counters `DS:8929`, walking movement `+02h`, and armor totals | P |
| `2D1B:1854` | `ResolveWeaponAttack_1854` | minimum/maximum range, ammo family, recovery delay, heat, effect ID, and damage | P |
| `2D1B:1E2B` | `ApplyWeaponDamage_1E2B` | direction plus 2d6 hit location, armor penetration, internal damage, critical effects, and unit destruction | P |
| `2507:483A` | `DrawUnitStatusScreen_483A` | unit type/name, installed weapons, armor, heat, BAP, CASE, and double heat sinks | V |
| `2507:0501` | `SelectUnitClass_0501` | six class labels plus Cancel at `DS:32F8`; returns the selected unit-type ID | V |
| `2507:0625` | `SelectUnitTypeFromList_0625` | FFh-terminated unit-type ID list and `UnitNameTable_3D2E`; suppresses Elementals from the Friendly Omni list | V |
| `2507:26EE` | `DrawUnitRosterScreen_26EE` | five `pilot/unit` labels from assignment records and fixed pairs, with a verified alternate assignment layout | V |

`DS:A971/A973` form a 23-bit availability mask for the current unit. A weapon
bit is present only when that weapon is installed, its recovery counter is
ready, and any required ammunition family has a nonzero current-ammunition
word. `DS:AEF1` is a 24-record, `0Ch`-byte derived combat-rating table. Its
first word is copied from unit-record walking movement `+02h`; later words are
computed from durability and grouped weapon-availability masks. The exact
meaning of those later rating words remains deliberately unnamed.

The selection path establishes that the same type-ID namespace is used by
`MECHTYPE.DAT`, `UnitNameTable_3D2E`, BattleMechs, and vehicles. Vehicle names
must therefore remain BattleTech chassis/vehicle names even though their raw
armor arrays share the generic 150-byte unit layout.

## Vehicle reference

The campaign and executable consistently identify APC, Drillson, Galleon,
Mobile HQ, Ammo Carrier, Pegasus, Rommel, and Skulker units. These share the
150-byte template table but use a separate sprite-ID interpretation from
BattleMechs. See Sarna's [vehicle
reference](https://www.sarna.net/wiki/BattleTech:_The_Crescent_Hawks%27_Revenge/Vehicles).

Names applied to vehicle fields should follow BattleTech vehicle record sheets:
front, left side, right side, rear, turret where present, and motive-system
locations. The game reuses the BattleMech-shaped raw arrays, so the exact
index projection must be established from vehicle damage and targeting code;
raw indices remain numbered until that evidence exists.

The complete core attack/damage trace now establishes an important negative
result: unit byte `+95h` is consulted only to force the infantry hit table and
to enable the infantry Inferno-Rocket behavior. Values `01h`, `02h`, `04h`,
`05h`, and `06h` do not select separate vehicle hit tables or location logic in
the core resolver. All non-infantry vehicles therefore pass through the same
BattleMech-shaped directional tables and eight-location destruction switch.
BattleTech vehicle vocabulary remains the documentation target, but the game
does not expose a defensible front/side/rear/turret projection in this path.

## Lost-feature strings

An attached historical note reports executable strings referring to salvage,
customization, infantry/APC command, base building, Arrow IV, infernos, and
cease-fire/cease-assault behavior. These are **leads, not proof of implemented
features**. Strings may represent removed code, abandoned UI, or generic engine
vocabulary. Cross-reference each string and its callers before assigning it a
feature status.
