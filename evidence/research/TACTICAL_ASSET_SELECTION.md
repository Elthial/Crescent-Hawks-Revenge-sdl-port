# Tactical asset selection

This note records the executable-backed filename selection path for tactical
maps, icon sheets, destruction sheets, unit sheets, and SCENE data. Addresses
refer to the DOS load image and use the project confidence convention.

## Resource descriptor slots

The 12h-byte descriptor table at `DS:10B0` contains these adjacent tactical
resources:

| Index | Filename template | Purpose | Confidence |
| ---: | --- | --- | :---: |
| `3Ch` | `MAPx.MAP` | tactical map/header and terrain data | V |
| `3Dh` | `ICONSETx.ICN` | tactical terrain/icon sheet | V |
| `3Eh` | `DESTROYx.ICN` | matching destroyed-terrain icon sheet | V |
| `3Fh` | `ICONLIST.DAT` | icon metadata used with the two sheets | V |
| `40h` | `MECHTYPE.DAT` | 96h-byte unit template records | V |
| `41h` | `MECHSETX.ICN` | tactical unit sprite sheet | V |
| `42h` | `SCENEx.DAT` | scenario bytecode and message data | V |
| `43h` | `BOOMS.CMP` | tactical explosion data | P |

## Scenario suffix and MECHSET selection

`InitializeTacticalScenario_0214` indexes the byte table at `DS:254C` with
`CampaignStageIndex_24D6`, then adds `ScenarioVariantIndex_24D8`. Stage `08h`
immediately subtracts that variant again, so its base-table entry is used
unchanged. The resulting zero-based ordinal is converted as follows:

- `00h..08h` become ASCII `1`..`9` by adding `31h`.
- `09h` and later become ASCII `A` onward by adding `38h`.

The result is stored in `ScenarioFileSuffix_B581` and later selects
`SCENE1.DAT` through `SCENEU.DAT`. The exact 22-byte `DS:254C` table is:

`00 01 02 03 04 05 07 09 0A 0B 0C 1C 0D 0E 14 16 17 18 19 1A 1B 1D`

Consequently campaign stage `0Bh` selects `SCENET`, while stage `15h`, the
Pacifica training ground, selects `SCENEU`. This is distinct from the roster
recipe switch in `PrepareScenarioUnitRosters_0006`, whose cases end at
`SCENET` (`54h`).

The branch at `0D73:02B4-02CC` also proves the MECHSET rule:

- suffixes `1` through `E`, plus `T`, select `MECHSET1.ICN`;
- suffixes `F` through `S` select `MECHSET2.ICN`.

This upgrades the earlier visual/narrative inference to executable-verified
selection logic. `MECHSET1` is the red Inner Sphere/Kurita opposition sheet;
`MECHSET2` is the blue/teal Clan opposition sheet.

## MAP, ICONSET, and DESTROY mutation

`LoadTacticalIconSetResources_03D4` adds ASCII `0` to its numeric selector and
writes the same byte to character `+07h` of both `ICONSETx.ICN` and
`DESTROYx.ICN`. It then loads descriptor `3Eh`, descriptor `3Dh`, and
`ICONLIST.DAT`. The identical selector and immediate paired load prove that a
DESTROY sheet is the damage-state companion of its ICONSET sheet.

`LoadTacticalMap_0517` writes its map number to character `+03h` of
`MAPx.MAP`. Values below ten add ASCII `0`; later values add ASCII `7`, mapping
`0Ah` to `A`. It opens descriptor `3Ch`, reads the map header, and derives the
runtime map width, height, and packed terrain-damage stride.

## Loader data flow

`LoadTacticalIconResource_0468(path, destinationPage)` advances the secondary
graphics-buffer pointer by `destinationPage * 8000h` bytes. Page `1` uses a
direct three-buffer loader; the other pages decode through the packed display
buffer and then copy into the selected page. On EGA, the selected packed page
is converted into planar video memory at segment `A400h + page * 0200h`.

After mutating the two filenames, `LoadTacticalIconSetResources_03D4` loads
`DESTROYx.ICN` into page `2`, `ICONSETx.ICN` into page `0`, and seeks to
`iconSetNumber * 0300h` in `ICONLIST.DAT`. Exactly `0300h` bytes are read into
the table used by terrain damage and tactical icon selection.

`LoadTacticalMap_0517` reads a `0Ch`-byte header into the terrain-map buffer.
Header bytes `00h` and `02h` are the map width and height. It derives the
packed two-bit damage-map stride as `ceil(width / 4)`, then reads exactly
`width * height` terrain bytes over the header buffer. This verifies the
row-major, one-byte-per-cell interpretation used by RevengeTools.
