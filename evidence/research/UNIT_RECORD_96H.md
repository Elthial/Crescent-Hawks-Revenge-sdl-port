# 96h-byte unit record

This is the working map for the 150-byte (`96h`) record shared by
`MECHTYPE.DAT`, `PersistentUnitRoster_8B81`, `LiveScenarioUnits_99E0`, and the
unit block in each save slot. Confidence is **V** verified, **P** probable,
**H** hypothesis, or **U** unknown.

## Storage sites

| Location | Count | Confidence | Purpose |
| --- | ---: | :---: | --- |
| `MECHTYPE.DAT` | 89 | V | Immutable templates; exactly `89 * 96h = 3426h` bytes. |
| `DS:8B81` | 24 | P | Persistent campaign roster. |
| `DS:99E0` | 24 | P | Live/scenario unit instances. |
| save slot `+0221h` | 24 | V | Exact serialized copy of `DS:99E0`. |
| `DS:85B0` | 1 | P | Blank record used to clear roster slots. |

The template index is byte `+01`. In `MECHTYPE.DAT` it runs from `00h`
(Locust) through `58h` (BattleMaster+), matching the 89-entry name table at
`DS:3D2E`. Populated save records retain this index and differ from the matching
template mainly in damage, ammunition, runtime state, pilot, and experience.

## Field map

| Offset | Size | Confidence | Proposed field | Evidence |
| --- | ---: | :---: | --- | --- |
| `00` | 1 | P | `deploymentState` / occupied-active flag | Templates are zero; live player records are commonly one. Roster preparation and compaction test or clear it. Exact bit meanings remain open. |
| `01` | 1 | V | `unitTypeId` | Monotonic `00h..58h` in `MECHTYPE.DAT`; indexes `UnitNameTable_3D2E`. |
| `02` | 1 | P | `walkMovement` | Values match known chassis walking movement. Zero is also treated as an invalid/dead persistent slot. |
| `03` | 1 | P | `jumpMovement` / jump-jet count | Values match known jumping capability and movement. |
| `04–0B` | 8 | V | `currentInternal[8]` | `ResetLiveUnitState_0878` copies `17h–1Eh` here. |
| `0C–16` | 11 | V | `currentArmor[11]` | Reset copies `1Fh–29h` here; the count includes rear-torso facings. |
| `17–1E` | 8 | V | `maximumInternal[8]` | Source for the current-internal bytes. |
| `1F–29` | 11 | V | `maximumArmor[11]` | Source for the current-armor bytes. |
| `2A–37` | 14 | P | `weaponFamilyCount[14]` | Each byte is multiplied by the corresponding word in `AmmoCapacityMultiplierTable_058E`. |
| `38–53` | 28 | V/P | `currentAmmo[14]` as words | Reset computes `multiplier[i] * weaponFamilyCount[i]`; the word layout is verified. |
| `54` | 1 | P | `engineHeatSinkCapacity` | Values correlate with heat sinks accommodated by engine rating: Locust 6, Wasp 4, Ostscout 10. |
| `55` | 1 | P | head equipment slot | First group scanned by the weapon enumerator; ordering and maximum-structure arrays match the BattleMech head location. |
| `56–5D` | 8 | P | left-arm equipment slots | Second scanned group; location ordering matches the internal-structure and armor arrays. |
| `5E–69` | 12 | P | left-torso equipment slots | Third scanned group. |
| `6A–6B` | 2 | P | center-torso equipment slots | Fourth scanned group. |
| `6C–77` | 12 | P | right-torso equipment slots | Fifth scanned group. |
| `78–7F` | 8 | P | right-arm equipment slots | Sixth scanned group. |
| `80–81` | 2 | P | left-leg equipment slots | Seventh scanned group. |
| `82–83` | 2 | P | right-leg equipment slots | Eighth scanned group. |
| `84` | 1 | V | `tonnage` | Values match chassis tonnage; nonzero also identifies a populated record. |
| `85` | 1 | V | `engineHits` | Cleared by reset. A center-torso internal critical increments it; reaching three forces catastrophic damage, matching BattleTech engine-critical rules. |
| `86–87` | 2 | V | `heatAccumulatorQ8_8` | Heat maintenance reads and writes a signed word at `+86h`. `DS:176A` supplies `heatSinkCount * 10h` as the cooling decrement, movement adds fractional values such as `00E0h`, and negative results clamp to zero. This is an 8.8 fixed-point accumulator: `+86h` is the fractional byte and `+87h` is whole heat. |
| `87` | 1 | V | `currentHeat` / integer half of accumulator | Combat adds `WeaponDefinition.heat` to this byte while preserving `+88h`; targeting and UI logic read it as whole heat. |
| `88` | 1 | V | `tacticalSpriteBase` | Deployment stores global MECHSET ID `0100h + value` at `DS:A818`. Opposing non-infantry units add `08h`; opposing infantry adds `02h`. `UpdateUnitSpriteForFacing_1804` adds twice the low two facing bits at `DS:AE6B`, while infantry forces facing zero. Non-infantry values select aligned 16-tile rows; infantry uses compact pairs at `D6h` and `D8h`. |
| `89` | 1 | P | `sensorHits` | A head internal critical can increment it up to two; the alternate head-critical branch is catastrophic. It is copied into word `+0Ah` of `DS:AEF1`, consistent with a targeting penalty. |
| `8A` | 1 | P | `gunneryTargetNumber` | Templates normally contain four. `ResolveWeaponAttack_1854` adds the attacker's value directly to the weapon to-hit target. Pilot/experience initialization still needs tracing. |
| `8B` | 1 | P | `targetMovementModifier` | `ResolveWeaponAttack_1854` adds the target's value directly to the weapon to-hit target. The movement updater that derives it is not yet identified. |
| `8C` | 1 | P | `missileUpgradeState` | Class-dependent upgrade flag. For ordinary units, nonzero adds the indexed `ImprovedMissileDamageBonusTable_3D0D` value to missile damage; four immutable `+/*` BattleMech templates with missile launchers carry it. For damage-model `03h` infantry, the same byte makes a missile attack add 30 heat and suppress ordinary damage. Upgrade UI strings independently name `Improved Missiles` and `Inferno Rockets`, supporting those two interpretations; the acquisition method still needs a direct trace. |
| `8D` | 1 | V | `hasBeagleActiveProbe` | `DrawUnitStatusScreen_483A` renders the `BAP` label when nonzero. |
| `8E` | 1 | P | `canSpotIndirectFire` | When LRMs lack direct line of sight, `ResolveWeaponAttack_1854` scans the attacker's 12-unit side for an active record with this flag and line of sight to the target. Rifleman+ is the only immutable template with the flag set. Exact in-game equipment terminology remains unresolved. |
| `8F` | 1 | V | `hasAccuracyUpgrade` | The unit-upgrade path subtracts two from `gunneryTargetNumber` and sets this flag. `DrawUnitStatusScreen_483A` renders `DS:4608`, `Accuracy`, when it is nonzero. |
| `90` | 1 | V | `hasDoubleHeatSinks` | Status screen renders `Double HS` when nonzero. |
| `91` | 1 | V | `hasCASE` | Status screen renders `CASE` when nonzero. |
| `92` | 1 | P | `pilotId` | Values are `<25h`; `UpdatePilotAvailability_0A81` uses this byte to index 37 four-byte entries at `DS:1D4F`. |
| `93` | 1 | P | `pilotExperience` | Save values `00h..03h` agree with green through elite. |
| `94` | 1 | P | `allegiance` | Community map and faction/name rendering agree; controlled correlation remains desirable. |
| `95` | 1 | P | `damageModel` / unit-class behavior selector | The immutable templates map `00h` to all BattleMechs, `01h` to Pegasus/Drillson hover vehicles, `02h` to Rommel/Galleon/Skulker conventional combat vehicles, `03h` to all infantry, `04h` to APC, `05h` to Ammo Carrier, and `06h` to Mobile HQ. Combat code proves the infantry branch; the remaining class labels are exact template correlations but their distinct runtime effects still need tracing. |

### Damage-model selector values

| Value | Templates | Confidence |
| ---: | --- | :---: |
| `00h` | every BattleMech, including Clan and `+`/`*` variants | V correlation; P behavior name |
| `01h` | Pegasus, Drillson | V correlation; P hover-combat-vehicle behavior |
| `02h` | Rommel Tank, Galleon, Skulker | V correlation; P conventional-combat-vehicle behavior |
| `03h` | Infantry, Jump Infantry, Elementals | V correlation and V infantry combat branch |
| `04h` | APC | V correlation; P APC-specific behavior |
| `05h` | Ammo Carrier | V correlation; P ammunition-carrier behavior |
| `06h` | Mobile HQ | V correlation; P mobile-HQ behavior |

The selector is not a propulsion code: model `02h` contains both tracked and
wheeled vehicles. It is therefore retained as a damage/behavior class rather
than being renamed to a movement type.

## Repository save comparison

The installed `SAVEGAME.DAT` has one occupied slot, labelled `after battle 3`.
The five winning-save files add 30 checkpoints and 427 populated records
(nonzero tonnage). Byte `+01` selects each record's exact template. Across that
set, maximum structure/armor `17h–29h`, jump movement `03h`, heat-sink capacity
`54h`, and tonnage `84h` never differ. Current structure/armor and ammunition
decrease, critical entries acquire bit 7, and pilot/experience change
independently of chassis identity. This proves that saves embed complete live
records rather than template references.

## BattleTech vehicle locations

Unit IDs `37h..3Eh` are combat vehicles and should use BattleTech vehicle
record-sheet vocabulary: **front**, **left side**, **right side**, **rear**, and
**turret** where fitted, plus any motive-system-specific location. The engine
nevertheless stores them in the same eight internal, eleven armor, and eight
equipment groups used by BattleMechs.

Damage resolution proves that every non-infantry damage model uses the same
four directional BattleMech 2d6 tables without a vehicle-specific branch.
Those tables produce the shared eight internal and eleven armor indices, and
location destruction disables the corresponding shared equipment group.
This verifies the engine-level projection but does **not** establish a safe
one-to-one translation to front, left side, right side, rear, turret, or motive
system. Vehicle fields therefore remain numbered raw indices; they must not be
mislabeled as BattleMech limbs or replaced by generic `locationA` names.

The immutable records reinforce that caution. All vehicle templates populate
all eight internal indices. Their weapons are distributed across several
BattleMech equipment groups, and the Rommel has nonzero values in all three
rear-torso armor slots. This is an abstraction chosen by the game rather than
a direct encoding of a tabletop vehicle record sheet.

A complete reference search adds a useful limit to the interpretation of
`+95h`: the attack/damage family branches on it only for value `03h`
(infantry). The other correlated vehicle values do not select their own hit
charts, armor-location projection, or destruction switch there. They may still
differentiate movement, mission, or presentation behavior elsewhere, but they
cannot currently justify renaming raw location indices to BattleTech vehicle
record-sheet locations. This is retained as a verified absence in the core
combat path rather than filled with speculative labels.

### Directional hit-location tables

`DS:1038` contains five `18h`-byte tables: 11 word results for 2d6 rolls 2..12
and a zero padding word. Tables `00h..03h` are rear, right side, front, and left
side. Table `04h`, forced only for damage model `03h`, always returns shared
internal location `03h`. The 16 words at `DS:3CFE` select tables `00h..03h`
from target facing plus relative attack direction. The front and rear results
match the BattleTech BattleMech hit charts exactly, including rear armor codes
`08h..0Ah`; those normalize to internal torso indices `02h..04h` by subtracting
six after armor is applied.

## Weapon and ammunition bridge

Critical/equipment values `01h..17h` are one-based IDs into the 23 records at
`WeaponDefinitionTable_0435`. Each weapon record contains an ammunition-family
ID: `00h` for energy/no-ammunition weapons, or `01h..0Eh` selecting the fourteen
count bytes at `+2Ah` and ammunition words at `+38h`. The same family selects a
word from `AmmoCapacityMultiplierTable_058E` when ammunition is reset. This
distinguishes the 23 weapon types from the 14 ammunition families and provides
safe names for both sets of loop variables.

`ResolveWeaponAttack_1854` establishes the central combat data flow. It reads
minimum and maximum range, checks the ammunition family and decrements the
matching `currentAmmo` word, adds weapon heat to `currentHeat`, adds the weapon
recovery delay to the corresponding byte in the 24 × 23 recovery table at
`DS:8929`, dispatches the weapon effect, and passes weapon damage into the
target-damage family. `RecalculateUnitCombatRatings_0005` later filters weapons
that are recovering or out of ammunition and builds availability masks.

The same routine also documents one shipped rules quirk: when distance is at
or below a weapon's `+06h` minimum range, it adds `distance - minimumRange` to
the target number. That is a bonus rather than the tabletop minimum-range
penalty. The assembly is unambiguous, so the maintained C preserves the game
behavior and calls out the discrepancy instead of silently correcting it.

## Next verification work

1. Trace vehicle damage/targeting to project raw indices onto front, left side,
   right side, rear, turret, and motive-system record-sheet locations.
2. Fire each ammunition weapon once to map `2Ah–53h`.
3. Use controlled movement, standing, falling, and environmental-heat saves to
   verify the exact fractional additions made to `heatAccumulatorQ8_8`.
4. Change one pilot and faction independently to upgrade `92h–94h` to V.
