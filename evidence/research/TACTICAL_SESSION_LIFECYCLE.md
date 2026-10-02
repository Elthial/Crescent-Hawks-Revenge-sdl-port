# Tactical session lifecycle

This note records the assembly-verified ownership boundary from campaign play
through a complete tactical battle and back. Confidence follows the project
V/P/H/U convention.

## Campaign boundary (`0D73:0214`)

`InitializeTacticalScenario_0214` performs these operations in order:

1. Select the 8-pixel tactical font.
2. Derive the scenario ordinal from `DS:254C[CampaignStageIndex_24D6]` plus
   `ScenarioVariantIndex_24D8`. Stage `08h` cancels the variant addition.
3. Convert ordinal `00h..08h` to suffix `1..9` and later ordinals to `A..T`.
4. Stop campaign music, release its staging buffer, and select the tactical
   icon workspace at graphics work buffer `+8000h`.
5. Load the deduplicated weapon-effect bank and scenario sound bank.
6. When `UseEgaTacticalFallback_83DC` is nonzero, enter the EGA tactical path and
   rebuild adapter-specific resources.
7. Select `MECHSET1` or `MECHSET2`, preserve seven campaign-state bytes, and
   call `RunTacticalBattle_0000(scenarioSuffix)`.
8. Release both tactical sound banks.
9. Restore VGA campaign presentation (or clear the current adapter directly),
   display the scenario result, recreate music staging, restore the cursor,
   work-buffer pointers, and 6-pixel campaign font.
10. Wait for `TacticalUpdateDelayTicks_5923` to reach zero.

The adapter flag and countdown are now V. `ApplyVideoConfigOption_0669` owns
the adapter flag, while the installed BIOS `INT 1Ch` callback decrements the
countdown at approximately 18.2065 Hz.

## Tactical allocation (`1A1F:0000`)

`RunTacticalBattle_0000` allocates and clears exactly `CB90h` bytes:

| Relative offset | DS owner | Size/use | Confidence |
| ---: | --- | --- | :---: |
| `0000h` | `TerrainTypeMap_83EA` | base allocation and byte-per-cell terrain map | V |
| `4E20h` | `TacticalOverviewMapBuffer_83E6` | byte-per-cell overview colors | V |
| `A000h` | `PackedTerrainDamageMap_AE5F` | two-bit terrain-damage states | V |
| `C800h` | `TacticalCellSpriteMap_99BC` | 228-word viewport sprite layer | V |
| `C9C8h` | `TacticalCellTerrainMap_8823` | 228-word terrain and terrain-overlay layer | V |

The function additionally captures 29 tactical UI regions into the far-pointer
table following `DS:83EE`. It initializes scenario resources and unit runtime,
draws the first frame, runs the tactical interaction loop, then releases all 29
backing buffers and the `CB90h` allocation before returning.

## Digital weapon-effect bank (`31FB:00B3`)

The 16 ten-byte records at `DS:5C0C` use resource index `+00h`, playback scale
`+02h`, packed-bank offset `+04h`, sample length `+06h`, and load state `+08h`.
Load state is V: zero means pending, one is the primary owner of a resource,
and two aliases an earlier record with the same resource index. The loader
sizes only distinct resources, allocates one bank at `DS:B629:B62B`, and reads
each distinct sample once. `ReleaseDigitalWeaponEffectBank_12A7` frees that
single allocation after the tactical loop.
