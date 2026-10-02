# Tactical icon resource format

The tactical `*.ICN` path is now recovered end to end from `34B3`, `34DF`,
`35C2`, and the two decoder loops at `0800:33D6/342D`.

## Outer container

| Offset | Size | Meaning | Confidence |
| ---: | ---: | --- | :---: |
| `00h` | 2 | little-endian compressed payload length | V |
| `02h` | variable | packed payload copied into the display work buffer | V |

The packed payload begins with a one-byte layout selector. Value `01h` expands
linearly; every other observed value selects the column-major decoder. Both
decoders produce exactly `7D00h` (32,000) bytes.

## Signed-run stream

Each run begins with a signed byte:

- `01h..7Fh`: copy that many literal bytes;
- `81h..FFh`: repeat the following byte `-control` times;
- `00h`: read a little-endian 16-bit repeat count, then repeat the following
  byte that many times.

`DecodeLinearRleScreen_33D6` writes consecutive output bytes.
`DecodeColumnMajorRleScreen_342D` writes down 200-pixel columns in a 160-byte
row-stride page: output index `i` maps to `(i % 200) * 160 + (i / 200)`.

## Adapter post-processing

`CopyDecodedIconPage_000B` leaves Tandy/EGA data in the decoded layout. In CGA
mode it converts 16,000 packed byte pairs through the alternating phase tables.
When `DS:6226` is set for tactical icon pages, the phase changes every four
bytes and the result is repacked into CGA alternate scanlines. The direct page
loader at `34DF:0003` temporarily selects Tandy decoding, then applies the
paired-pixel transparency-mask conversion required by that special page.
