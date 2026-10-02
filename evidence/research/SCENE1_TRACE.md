# SCENE1 end-to-end trace

`SCENE1.DAT` is the first complete executable-to-data trace for the SCENE
interpreter. It connects the container, resource selectors, scenario-roster
preparation, bytecode control flow, unit mutations, map tests, campaign clock,
and event narration without assigning meanings to untraced metadata.

Confidence follows the project convention: **V** verified, **P** probable,
**H** hypothesis, and **U** unknown.

## Loaded resources and runtime setup

| Item | Value | Evidence | Confidence |
| --- | --- | --- | :---: |
| Scenario suffix | `31h` (`'1'`) | `DS:B581` dispatch in `30F1:0006` | V |
| Scene file | `SCENE1.DAT` | resource descriptor plus suffix | V |
| Tactical map | `MAP0.MAP` | metadata byte `0Fh` | V |
| Icon set | `ICONSET0.ICN` | metadata byte `10h` | V |
| Instruction base | file `0128h` | first data offset `0126h` plus reserved word | V |
| Live unit 5 | optional persistent unit 0 copy, then inactive | scenario case `31h` | V data flow |
| Live unit 15 | persistent unit 15 copy, then inactive | scenario case `31h` | V data flow |
| Campaign advance | 20 minutes | scenario case `31h` | V |

The loader records file offset `0128h` as the base used by SCENE branch words.
Those words are absolute offsets within the executable instruction region, not
displacements from the branch instruction.

## Message-bank layout

The 72 message offsets are not one homogeneous list. The rendering path at
`1A1F:4588–45D8` proves this layout:

- messages `00h..41h`: six speaker banks, each containing eleven generic
  narration categories;
- messages `42h..47h`: six scene-event messages;
- opcodes `E1h..DCh` select event slots `0..5`, so their message index is
  `42h + (E1h - opcode)`.

The `DCh..E1h` handler stores its byte operand at `DS:B2F2`, sets `DS:8927` to
`0Bh + slot`, and activates the corresponding scene state. Thus `DS:B2F2` is
the narration speaker/subject selector, while `DS:8927` is the message
category. Categories `00h..0Ah` select a generic message inside a speaker bank;
categories `0Bh..10h` select the six scene-event strings.

SCENE1 provides unusually strong semantic corroboration:

| Opcode | Slot | Message | Text/effect summary |
| ---: | ---: | ---: | --- |
| `E1` | 0 | 66 | empty in this scene |
| `E0` | 1 | 67 | "He's run away!" |
| `DF` | 2 | 68 | "The Jenner's gonna explode!" |
| `DE` | 3 | 69 | target has reached the bridge |
| `DD` | 4 | 70 | target is attacking the DropShip |
| `DC` | 5 | 71 | target blasted through the hull |

The report generator now labels both banks and appends the linked special
message to every `DCh..E1h` instruction.

## Initialization phase (`0128h..016Ch`)

The opening straight-line sequence prepares units 0 and 15:

- unit 0 receives scene order state 1, movement/heat exponent 2, and five
  explicit armor reductions;
- unit 15 receives scene order state 1, movement/heat exponent 1, two armor
  reductions, pilot experience 1, and gunnery target number 3;
- unit 15 is assigned a ground target at map coordinate `(10h,3Bh)` and a
  four-point route;
- the campaign clock is set to state 0 at `14:25`.

Every field mutation above is dispatched through a handler whose operand width
and destination are verified. The higher-level story reason for the initial
damage and values remains scenario design rather than file-format semantics.

## Repeating tactical phase (`016Dh..01CDh`)

The script then yields and resumes through several branches:

1. It tests unit 15's durability. At or above 65 percent it changes that
   unit's order state from 1 to 2.
2. It tests whether unit 0 is absent or immobile and can jump directly to an
   event/end path.
3. It polls map coordinate `(10h,3Bh)`. A nonzero value activates event slot 4;
   a value below 3 proceeds to later map/event logic.
4. It tests whether unit 15 lacks equipment ID 3 and whether internal structure
   is below 75 percent.
5. It waits for unit 15's Y coordinate to become `31h`, then activates event
   slot 3 and loops back to the tactical tests.
6. A second phase sends unit 15 toward `(24h,00h)`, waits for Y coordinate 1,
   and activates event slot 1.
7. Terminal branches activate slots 2 or 5 before the script finishes its pass
   or ends at `FFh`.

This control-flow interpretation accounts for all 166 instruction bytes.
There are no unknown reachable entry points and no bytes are discarded. The
event text independently agrees with the map tests and movement milestones,
which is why this scene meets the end-to-end trace requirement rather than
being only a structural disassembly.

## Remaining boundaries

- The meaning of many metadata bytes outside the verified map/icon selectors
  is still unknown.
- Generic speaker groups have not been assigned to fixed characters. The
  unit-index-to-bank arithmetic is verified and category meanings are
  conservatively proposed from the full 30-file text corpus in
  `SCENE_FORMAT.md`.
- Several interpreter operations retain proposed higher-level names even where
  their exact writes are verified.
- Story-character identity should be attached only after the unit/pilot roster
  relationship is traced, not inferred from message prose alone.

Generated evidence remains under the ignored
`RevengeTools.Output/scenes/evidence/SCENE1` directory.
