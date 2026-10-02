# Westwood file formats relevant to Revenge

The local installation looks much closer to Westwood's *Eye of the Beholder*
era than to the later *Dune II* and *Command & Conquer* resource systems. The
highest-value formats are CPS, CMP, Font v2, and the 768-byte palette family.

## Directly confirmed formats

### CPS full-screen images

All 39 local `.CPS` files match the documented [Westwood CPS
format](https://moddingwiki.shikadi.net/wiki/Westwood_CPS_Format):

| Offset | Type | Meaning |
| --- | --- | --- |
| `0x00` | `uint16` | file size |
| `0x02` | `uint16` | compression type |
| `0x04` | `uint32` | uncompressed size |
| `0x08` | `uint16` | embedded palette size |
| `0x0A` | bytes | optional palette, then image data |

Verified locally: the file-size field equals the physical size, all images
declare 64,000 expanded bytes (320×200 at 8 bits per pixel), and all use
external palettes (`PaletteSize = 0`). The local set contains ten files marked
compression type 1, 28 marked type 2, and one marked type 3:
`BTBORDER.CPS`. RevengeTools now bounded-decodes all 39 files to their declared
64,000-byte buffers: type 1 is Westwood LZW-12, type 2 is Westwood LZW-14, and
type 3 is Westwood RLE. The type-3 count byte order is confirmed directly by
the game's `0800:0CDE` decoder (`MOV CX,[SI]` followed by `XCHG CH,CL`), rather
than assumed from a later engine. The earlier claim that only types 1 and 2
occurred in this installation was incorrect.

### CMP full-screen image

`BOOMS.CMP` is 6,278 bytes and starts `84 18 02`: a 6,276-byte payload-size
field followed by compression type 2. This matches the older [Westwood CMP
format](https://moddingwiki.shikadi.net/wiki/Westwood_CMP_Format), whose type 2
is 4-bit vertical run-length encoding. CMP images are fixed at 320×200 and do
not carry a palette.

RevengeTools now consumes all 6,275 payload bytes exactly, reconstructs the
32,000-byte packed image, and expands its high/low nibbles into 64,000 palette
indices. The result is a coherent explosion and projectile sprite sheet using
12 indices in the range `0..15`. The game's `0800:0F74` loop independently
confirms the packed representation by combining `0x7D00` pairs of low nibbles
into exactly 32,000 bytes.

### Westwood Font v2

The [Westwood Font v2
specification](https://moddingwiki.shikadi.net/wiki/Westwood_Font_Format_v2)
explicitly names *The Crescent Hawk's Revenge*. Its layout is:

| Offset | Type | Meaning |
| --- | --- | --- |
| `0x000` | `uint16` | file size minus 2 |
| `0x002` | `uint16[128]` | glyph bitmap offsets |
| `0x102` | `uint8` | glyph height |
| `0x103` | `uint8` | glyph width, maximum 8 |
| `0x104` | bytes | one-bit glyph bitmaps |

Verified locally: `FONT6.FNT` is 1,028 bytes and reports 6×6; `FONT8.FNT` is
1,284 bytes and reports 8×8. Both declared sizes equal the physical size minus
two.

### COL palettes

All 22 `.COL` files are exactly 768 bytes and every channel value is in the
range 0–63. They therefore form 256 sequential three-byte, 6-bit VGA color
entries. This is consistent with the [Eye of the Beholder palette
format](https://moddingwiki.shikadi.net/wiki/Eye_of_the_Beholder_Palette_Format)
used by adjacent-era Westwood games. Convert each channel to display RGB with
`round(value * 255 / 63)`.

Rendering known CPS/COL pairs confirms sequential RGB channel order: the title
screen, map, portrait, and selection sheets all produce coherent reference
colours. An old note's red-blue-green claim is therefore rejected.

## Locally derived formats

### MAP tile grids

Every local `.MAP` file obeys this structure:

| Offset | Type | Meaning |
| --- | --- | --- |
| `0x00` | `uint16` | width |
| `0x02` | `uint16` | height |
| `0x04` | 8 bytes | duplicate of the first eight tile IDs |
| `0x0C` | `width × height` bytes | one tile ID per cell |

The invariant `file_size = 12 + width × height` holds for all 11 maps. Tile IDs
are direct indices into a 250-entry ICN tile set. Row-major composition with
16×16 tiles is visually verified: `MAP0.MAP` plus `ICONSET0.ICN` reproduces the
terrain, river, bridge, shoreline, buildings, and dropship placement in the
supplied `Map 1.jpg` stitched capture. In every one of the eleven MAP files,
bytes `04h..0Bh` exactly duplicate grid bytes `0Ch..13h`. They are therefore a
format-level prefix copy, not resource selectors or eight unknown settings.
`RevengeTools` now verifies this invariant rather than exposing them as opaque
metadata.

The MAP-to-ICONSET relationship is selected outside this format by SCENE
metadata. The complete 30-file corpus proves one unambiguous ICONSET for each
of the eleven MAP filenames, so `export-map` resolves it automatically while
retaining `--icons` as an explicit experimental override.

### CGA runtime translation tables

The CGA path does not use another disk format. At startup, a 32-byte seed at
runtime `DS:03BCh` is copied to `4184:0DD5` and expanded into two 256-byte
packed-pixel phase tables at `4184:0BD5` and `4184:0CD5`. The conversion path
alternates those tables and can replace the second byte of each input pair with
a four-pixel transparency mask. `inspect-cga-translation` reproduces those
tables directly from `REVENGE.EXE`; verification covers both lookup expansion
and mask construction.

### ICN tile and sprite sheets

All 18 `.ICN` files use the older three-byte Westwood envelope with compression
type 1 (horizontal RLE). Each declared stream consumes exactly and expands to
32,000 packed bytes, or 250 sequential 16×16 four-bit tiles. High and low
nibbles are palette indices. The decoded contact sheets visibly resolve terrain,
buildings, vehicles, BattleMechs, UI icons, destruction frames, and effects.

The executable-backed catalog roles are now separated: `ICONSET0..7` are
terrain sheets selected by SCENE metadata, `DESTROY0..7` are the matching
destruction/effect sheets, and `MECHSET1..2` are tactical unit/effect sheets.
For non-infantry unit templates, `MECHTYPE.DAT:+88h` selects the start of an
aligned 16-tile MECHSET row. Friendly facings use local tiles `+0,+2,+4,+6`
and opposing facings use `+8,+Ah,+Ch,+Eh`; the intervening tiles are alternate
animation frames. Infantry forces facing zero and uses compact friendly/enemy
pairs at `D6h/D8h` and `D8h/DAh`. Runtime IDs add `0100h` to these local tile
indices. `RevengeTools inspect-unit-sprites` exports the complete template-to-
sprite mapping.

The two MECHSET sheets use the same 250-tile address space. Their left-side
unit rows are predominantly the shared white player silhouettes; their
opposition rows distinguish a red Inner Sphere/Kurita set (`MECHSET1`) from a
blue/teal Clan set (`MECHSET2`). The direct filename write at `0D73:02B4`
upgrades selection to `[V]`: scenarios `1` through `E` and scenario `T` use
`MECHSET1`, while scenarios `F` through `S` use `MECHSET2`. The paired writes
at `1A1F:03D4` also prove that `DESTROYx` uses the same numeric selector as
`ICONSETx`; see `TACTICAL_ASSET_SELECTION.md` for the complete trace.

The tactical impact producer at `2007:0846` is now verified separately from
file selection. It writes four-word records `(mapX, mapY, impactClass,
spriteId)` to the 80-entry queue at `DS:B2F4`; impact classes `01h`, `06h`, and
`0Ah` select sprite IDs `06h`, `0Ah`, and `0Eh` and sound-effect IDs `04h`,
`02h`, and `0Eh` respectively.

Seventeen stored-length fields cover their complete physical files.
`ICONSET3.ICN` is structurally unusual but internally consistent: its declared
stream ends at `0x55D6`, decodes all 250 tiles, and is followed by 2,941 bytes
which remain preserved and deliberately uninterpreted.

### MUS music

All ten `.MUS` files begin with `MThd` and are ordinary Standard MIDI files:
format 0, one track, 96 ticks per quarter note. The extension is only a naming
choice and does not imply the later Westwood ADL format.

## Useful comparisons, not assumed formats

- [ADL](https://moddingwiki.shikadi.net/wiki/ADL_Format) describes later
  Westwood AdLib music. Revenge's `.MUS` files are MIDI, so an ADL decoder is not
  appropriate here.
- [Dune II](https://moddingwiki.shikadi.net/wiki/Dune_II) documents later PAK,
  SHP, WSA, Font v3, VOC, and ADL resources. These are valuable for recognizing
  Westwood design evolution, not evidence that Revenge uses those layouts.
- The ModdingWiki [Westwood file-format
  category](https://moddingwiki.shikadi.net/wiki/Category:Westwood_Studios_File_Formats)
  is the discovery index for compression algorithms and later containers.

## Decoder priority

1. Recover operand widths and semantics from the SCENE interpreter at `1A1F:2A4E`.
2. Raw sampled audio characterization and export.
