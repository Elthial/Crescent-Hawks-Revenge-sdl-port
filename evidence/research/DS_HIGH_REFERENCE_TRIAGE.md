# High-reference DS triage

This is the first semantic pass over heavily referenced data-segment regions.
Confidence uses V/P/H/U.

## `DS:07AA` — UI-region records (P)

The table uses `10h`-byte records:

| Field | Confidence | Meaning |
| --- | :---: | --- |
| `+00` | P | left column in text cells |
| `+02` | P | top row in text cells |
| `+04` | P | width in text cells |
| `+06` | P | visible height or item count in rows |
| `+08` | P | current scroll/selection row |
| `+0A` | U | unused by currently recovered consumers |
| `+0C` | H | rectangle border/fill style |
| `+0E` | U | unused by currently recovered consumers |

Coordinates are converted to pixels with character widths/heights at
`DS:8666` and `DS:99BB`. `DS:B6D0` selects the active record.

## `DS:10B0` — cached-file descriptors (P)

Each record is `12h` bytes:

| Field | Meaning |
| --- | --- |
| `+00:+02` | far filename pointer |
| `+04:+06` | 32-bit file length |
| `+08:+0A` | optional far cached-data pointer |
| `+0C` | descriptor flag/ID mask (H) |
| `+0E:+10` | 32-bit current read/seek position |

`REVENGE_3390.c` uses this table to serve a file either from DOS or from a
memory-backed cache. The companion table at `DS:B63A` holds ten active stream
handles: `7FFFh` means free; bit 15 selects a cached-memory stream.

## `DS:622E–6240` — active text window (V)

This is the live copy of one of 17h `10h`-byte records from
`TextWindowContexts_063A`:

| Address | Meaning |
| --- | --- |
| `622E` | selected context index |
| `6230` | left in 8-pixel cells |
| `6232` | top in 8-pixel cells |
| `6234` | width in 8-pixel cells |
| `6236` | height in 8-pixel cells |
| `6238` | foreground palette color |
| `623A` | background palette color |
| `623C` | cursor column |
| `623E` | cursor row |
| `6240` | active-state initialized flag |

`SelectTextWindow_0009` proves the complete record shape by saving colors and
cursor state to the old record and loading all eight words from the new one.
`RenderTextToActiveWindow_000B` proves the dimensions, colors, and cursor units
through its line scrolling and wrapping behavior. `DrawClippedSprite_566E`
independently consumes the first four words as clipping geometry.

## `DS:B652–B66A` — active UI draw state

| Address | Confidence | Meaning |
| --- | :---: | --- |
| `B652` | P | active rectangle draw style/color |
| `B654` | P | active region pixel height |
| `B656` | P | active region pixel width |
| `B658` | P | active region pixel left |
| `B65A` | P | active region pixel top |
| `B65C–B668` | U/P | framebuffer/copy state; parts are already named elsewhere |
| `B66A` | H | saved selection rows for nested UI regions |

## `DS:B63A` and nearby runtime arrays

`B63A` is resolved as `OpenStreamHandleTable_B63A`, not gameplay state. It is
ten words initialized to `7FFFh`. The open/read/write/seek/close wrappers use
the high bit to distinguish a memory-backed cached stream from a DOS handle.
This separates the file-runtime block from the UI state beginning at `B652`.
