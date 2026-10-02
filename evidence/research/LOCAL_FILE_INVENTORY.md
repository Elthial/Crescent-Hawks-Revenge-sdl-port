# Local file inventory

This page records observations from the ignored `Chrevenge/` installation. It
contains no original file payloads.

## Inventory

| Extension | Count | Size range | Working interpretation |
| --- | ---: | ---: | --- |
| `.CPS` | 39 | 561–26,387 | compressed 320×200 indexed images |
| `.DAT` | 33 | 1,034–25,024 | scenarios, unit templates, and saves |
| `.COL` | 22 | 768 | 256-color 6-bit palettes |
| `.ICN` | 18 | 6,289–31,645 | map/unit icon or tile graphics; unknown layout |
| `.MAP` | 11 | 3,862–20,012 | 12-byte header plus byte-per-tile grid |
| `.MUS` | 10 | 732–12,451 | Standard MIDI files |
| `.BIN` | 8 | 1,464–72,214 | headerless sampled effects/phrases |
| `.FNT` | 2 | 1,028–1,284 | Westwood Font v2 |
| `.CMP` | 1 | 6,278 | compressed 320×200 image |

There are also executables, installer configuration, text, and later-added
image/reference files.

## Verified invariants

- `MECHTYPE.DAT`: 13,350 bytes = 89 records × 150 bytes.
- `SAVEGAME.DAT`: 25,024 bytes, equal to every supplied completed-game save.
- `SCENE*.DAT`: 30 files, 1,034–2,005 bytes; the old claim that scenarios fit
  within 2,048 bytes holds for this installation. All parse as a 73-offset
  table, `92h` metadata bytes, one scenario bytecode block, 72 message strings,
  zero padding, and one raw trailer byte.
- SCENE metadata offsets `0Fh`/`10h` select all eleven MAP/ICONSET pairings;
  automatic composition succeeds for every pairing.
- `MAP0.MAP` through `MAPA.MAP`: all equal `12 + width × height`.
- `COL`: all 768 bytes; all values 0–63.
- `CPS`: all 39 bounded-decode to 64,000 bytes with no embedded palette: ten
  LZW-12, 28 LZW-14, and one RLE (`BTBORDER.CPS`).
- `BOOMS.CMP`: type-2 vertical RLE consumes its 6,275-byte payload exactly and
  expands to a 32,000-byte packed four-bit explosion/projectile sprite sheet.
- `ICN`: all 18 declared type-1 RLE streams consume exactly and expand to 250
  sequential 16×16 four-bit tiles. Only `ICONSET3.ICN` has physical bytes after
  the declared stream (2,941 bytes).
- `MAP0.MAP` + `ICONSET0.ICN`: row-major 16×16 composition visually matches the
  supplied stitched `Map 1.jpg` reference.
- `.MUS`: all Standard MIDI format 0, one track, 96 PPQN.
- Seventeen `.ICN` files have a leading size word equal to physical length
  minus two. `ICONSET3.ICN` is the exception: its leading stream ends at file
  offset `55D6h`, leaving 2,941 trailing bytes. The toolkit reports this as an
  unresolved trailing region rather than rejecting the installation or
  silently discarding it.

## Map dimensions

| File | Width | Height |
| --- | ---: | ---: |
| `MAP0.MAP` | 55 | 70 |
| `MAP1.MAP` | 50 | 100 |
| `MAP2.MAP` | 100 | 200 |
| `MAP3.MAP` | 200 | 100 |
| `MAP4.MAP` | 60 | 100 |
| `MAP5.MAP` | 100 | 100 |
| `MAP6.MAP` | 100 | 100 |
| `MAP7.MAP` | 100 | 100 |
| `MAP8.MAP` | 160 | 100 |
| `MAP9.MAP` | 100 | 100 |
| `MAPA.MAP` | 125 | 100 |

## Executable string-table lead

At file offset `0x3B056`, `REVENGE.EXE` contains a NUL-separated table beginning
with `Locust`, `Wasp`, and `Stinger`, continuing through vehicles, infantry,
Clan units, upgraded variants, and pilot names. The unit names align with IDs
`0x00`–`0x58` reported by the community. This offset is verified for this local
executable only; it is not yet a version-independent address.
