# Revenge annotation index

This index records the first evidence-backed pass over the Reko C export. It is
not a claim that every generated prototype or segment attribution is correct.

Confidence marks follow the Inception research convention:

| Mark | Meaning |
|---|---|
| `V` | Verified directly from executable bytes, assembly, or a repeatable trace |
| `P` | Probable: multiple observations agree, but the interpretation is not completely demonstrated |
| `H` | Hypothesis: useful working interpretation with incomplete or ambiguous evidence |
| `U` | Unknown: the address and references are known but its meaning is not |

Confidence applies to each claim. For example, `DS:8337` has verified hour and
minute behavior while its adjacent third byte remains unknown.

## Tactical video transition and scenario result

The latest clean decompile exposed three small `0D73` procedures whose assembly
closes the battle-to-campaign display transition:

| Address | Recovered name | Evidence-backed behavior |
|---|---|---|
| `0D73:0387` | `RebuildTacticalVideoResources_0387` `[V]` | Switches adapter mode, restores the palette, optionally shows the battle result, reloads screen/cursor resources, and replaces the captured title strip. |
| `0D73:329E` | `InstallVgaPaletteBankAnchors_329E` `[V]` | Copies the first 16 RGB triplets into VGA palette entries `00h,10h,...,F0h` and reloads the DAC. |
| `0D73:5789` | `ShowScenarioCompletionStatus_5789` `[V]` | Selects the success/failure string from campaign-flag bit 0 and seeds `DS:5923` with `0Bh`. |

`DS:2B11` and `DS:2B31` are verified text anchors. `DS:5923` is the shared
tactical update countdown: the BIOS `INT 1Ch` callback at `0800:2440`
decrements it at approximately 18.2065 Hz. Its `0Bh` banner value lasts about
0.604 seconds.

## Tactical-session ownership

`InitializeTacticalScenario_0214` is now recovered as the complete battle
boundary rather than a partial resource initializer. It derives the scenario
suffix, loads both digital effect banks, optionally switches a VGA campaign
through the EGA tactical renderer, calls `RunTacticalBattle_0000`, then releases
the battle audio and restores the campaign video, font, cursor, and music
staging state.

`RunTacticalBattle_0000` owns one `CB90h`-byte far allocation. Its verified
layout is `+0000h` terrain cells, `+4E20h` overview colors, `+A000h` packed
terrain damage, `+C800h` tactical cell sprites, and `+C9C8h` tactical cell
overlays. The last two regions are each `1C8h` bytes (228 words, matching the
19-by-12-cell viewport). It also allocates and releases backing-buffer slots
1 through 29 at `DS:83F2..8465`; slot zero at `DS:83EE` remains the campaign
mouse-cursor backing buffer.

Assembly verifies that `1A1F:0000` accepts one scenario-code word and returns
no value. The adjacent frame, interaction-loop, runtime-initialization,
scenario-resource, viewport-redraw, and palette-anchor calls now have matching
C signatures in both Reko metadata sources.

## September 2026 recovery merge

The corrected Reko project recovered 33 procedure bodies that were absent from
the original annotation export. All 33 were selectively imported without
replacing any existing annotated procedure. The new coverage is concentrated
in these areas:

| Segments | Recovered coverage |
|---|---|
| `0800`, `0D73` | one runtime helper and seven menu/date/display helpers |
| `2507` | eight unit-class, allegiance, roster, status, and stat-display routines |
| `2B2D`, `2B34`, `2D1B` | eight unit weapon/loadout and combat-rating routines |
| `2C7F` | SOUND and INPUTDEVICE configuration handlers plus hexadecimal value parsing |
| `30B2`, `3621` | five music interrupt/driver routines |
| `337C`, `3596` | two additional graphics/UI helpers |
| `0800:32ED`, `3327`, `34F8`, `3571`, `35D8` | verified CGA/Tandy row repacking, packed rectangle fill, phase-table initialization, packed-pixel conversion, and mask construction |
| `0800:4D98` | BIOS CGA palette selection (`INT 10h/AH=0Bh`) |

`V`: the merged address set contains all 373 procedures in the corrected Reko
export, with no duplicate entry addresses and none of the previous 340 bodies
lost. Newly recovered bodies retain raw Reko types until each can be checked
against assembly and normalized to the annotation project's data-segment model.

`V`: `2C7F:02B0` and `2C7F:02B5` are consecutive far calls with no intervening
argument push. They are represented as separate calls to `fn31FB_0005()` and
`InitializeMusicDriver_0038()`; the former nested generated expression was not
a real source-level dependency.

## DOS, BIOS, and hardware boundaries

| Generated location | Interface | Interpretation |
|---|---|---|
| `0800:0000` | DOS `INT 21h/AH=4Ch` | Process termination |
| `0800:0172` | DOS `INT 21h/AH=25h` | Installs exception vectors 00h, 04h, 05h, and 06h |
| `0800:0974` | BIOS `INT 10h/AX=1012h` | `VGA_LoadPalette_0974` loads 256 RGB triplets from a single far pointer into VGA DAC registers 0–255 |
| `0800:4DB1` | EGA Attribute Controller at `03C0h` | `EGA_SetPaletteRegister_4DB1` writes one logical palette register/value pair |
| `0800:4E6A` | Tandy video ports `03DAh/03DEh` | `Tandy_LoadPaletteRegisters_4E6A` writes the 16 logical palette values |
| `2B2D:0004` | Adapter-specific palette dispatcher | `LoadVideoPalette_0004` consumes VGA RGB data at `+0000h` and the Tandy/EGA logical palette at `+0300h` |
| `2B34:0422` | Unit combat-rating formatter | `DrawCombatRatingDescription_0422` divides nonzero ratings by nine, caps the band at five, maps zero to `None`, and renders the selected label from `DS:40CF` |
| `0800:23D1`, `0800:241E` | DOS `INT 21h/AH=35h,25h` | Saves, hooks, and restores `INT 1Ch` timer tick |
| `0800:33A8` | DOS `INT 21h/AH=48h,49h` | `GetLargestFreeConventionalMemoryKB` probes and returns the largest contiguous free block in KiB, capped at 640 KiB |
| `0800:34F4/34F6` | CPU interrupt flag | `EnableHardwareInterrupts` and `DisableHardwareInterrupts` are direct STI/CLI wrappers |
| `0800:37C4` | DOS `INT 21h/AH=35h` | Reads vector 33h; used as a mouse-driver presence check |
| `0800:3BBF` | DOS `INT 21h/AH=06h` | Direct console output |
| `0800:4898` | DOS `INT 21h/AH=0Eh` | Selects the default drive |
| `0800:48A6` | BIOS `INT 10h/AH=0Bh` | Sets the CGA palette/border function |
| `0800:4DFD` | EGA Graphics Controller ports `03CEh/03CFh` | `ReadEGAPlanarTile_4DFD` captures eight rows from all four EGA planes into a 32-byte far buffer |
| `0800:4EAA` | Color Input Status Register 1 at `03DAh` | `IsVerticalRetraceActive_4EAA` returns nonzero while vertical retrace status bit 3 is set |
| `0800:4EC2` | Color Input Status Register 1 at `03DAh` | `WaitForVerticalRetraceEdge_4EC2` waits for either the beginning or end of vertical retrace |
| `2C7F:003C` | Program startup coordinator | `InitializeGame_003C` validates memory and `MEDIA.CFG`, loads fonts, allocates screen buffers, initializes graphics/input, and starts music timing |
| `2C7F:02E3` | Program shutdown coordinator | `ShutdownGame_02E3` drains sound activity, removes timer/keyboard hooks, releases runtime resources, and restores the original BIOS video mode |
| `2C7F:032B` | BIOS `INT 10h/AH=0Fh` | `GetCurrentBIOSVideoMode_032B` returns the current BIOS video mode from AL |
| `2C7F:0350` | BIOS `INT 10h` video-mode selection | `SetVideoModeForAdapter_0350` maps adapter slots through `DS:3CAA`; slot 6 restores the saved startup mode |
| `2C7F:039D` | 16-bit far-pointer helper | `AddBytesToFarPointer` adds a 32-bit byte count and normalizes the result to an offset below 10h |
| `2C7F:047A` | `MEDIA.CFG` loader/dispatcher | `LoadMediaConfiguration_047A` recognizes VIDEO, MUSIC, SOUND, and INPUTDEVICE and invokes the callback table at `DS:3A91` |
| `0D56:00B5` | Borland far-heap allocation | `AllocateFarMemory` accepts a 32-bit byte count, rejects requests above `FFFFh`, and reports fatal allocation failures |
| `0D56:0112/01A5` | Paragraph-aligned far heap | `AllocateParagraphAlignedMemory` and `FreeParagraphAlignedMemory` preserve the raw-pointer adjustment in the byte before the aligned allocation |
| `3037:xxxx` | BIOS data area + vectors 09h/23h | Reads keyboard flags, then hooks keyboard IRQ and Ctrl-Break |
| `30B2:xxxx` | vectors 08h + ports 40h/42h/43h/61h | Timer/PIT and PC-speaker sound driver |
| `3327:0007` | DOS console output via `0800:3BBF` | `DOS_PrintString` is the game's far `cputs` equivalent: it writes a NUL-terminated string without appending a newline |
| `35CE:000A` | Game text renderer | `RenderFormattedText_000A` consumes a NUL-terminated far byte stream containing printable text and embedded layout/style control codes |
| `373D:000C-020B` | PC-speaker/PIT ports `61h/43h/40h` | Calibrated packed one-bit sample playback and elapsed PIT timing |
| `38C3:0004` | Borland runtime error state | Translates DOS errors through `DS:6FB0`, setting `_doserrno` at `DS:6FAE` and `errno` at `DS:007F` |
| `3913` | DOS `INT 21h/AH=4Ah` | Resize memory block wrapper |
| `3915`, `392F`, `3939`, `3948`, `3961`, `3965`, `3978`, `39C0` | DOS file API | Create, open, close, read, write, seek, delete, and determine length; `DS:712A` is the per-handle runtime state table |
| `397E:0003` | Runtime far-string helper | `StringLength`, equivalent to far `strlen` |
| `3A04:000C` | Runtime far-string helper | `UppercaseStringInPlace`, equivalent to far `strupr`; converts only ASCII `a`-`z` and returns the original pointer |
| `3390:064F` | DOS delete wrapper | `DeleteFileIgnoringErrors` deletes a far-path string and intentionally discards the DOS result |
| `34B8:000A` | BIOS tick counter `0000:046C` + VGA status `03DAh` | `CalibrateVideoTiming_000A` calibrates the software delay loop into `DS:B650` and selects the vertical-retrace wait edge at `DS:7FEE` |
| `39D9` | DOS `INT 21h/AH=2Ah,2Ch` | Date and time wrappers |
| `39E3` | DOS `INT 21h/AH=25h` | Generic interrupt-vector setter |

Verified video-state fields now include `4184:0B99`/`0B9A` as the restore and
capture re-entry guards, `4184:0B9B`/`0B9D` as the active framebuffer offset
and segment, and `4184:0E4C` as the active video-adapter/layout selector.
Renderer-local state at `0800:2681` retains the current restore source segment;
`0800:3BE4`/`3BE5` and `3C1E`/`3C20` hold draw/background colors and their
adapter-expanded pixel patterns; and `0800:3C22`–`3C28` records text-line X,
font line height, glyph advance, and right clipping boundary.

`DS:84C1/84C3` is the active font far pointer. `DS:8666` caches the font's
horizontal glyph advance and `DS:99BB` caches its line height; `3477:018F`
loads all four values from the selected font resource.

## Software mouse-cursor overlay

The cursor family at `0800:3665`–`3B7A` is verified from assembly and the
INT 33h callback at `0800:3772`. It implements a game-drawn cursor rather than
using the mouse driver's display functions:

- `ConfigureMouseCursorOverlay_3665` erases the old cursor, replaces its
  hotspot and bitmap far pointer, and redraws it while holding the shared lock.
- `HideMouseCursorOverlay_3968` and `ShowMouseCursorOverlay_3B7A` are the
  synchronized public entry points. Their `387D` and `3A53` counterparts are
  lock-free inner operations used by both the wrappers and the mouse callback.
- `4184:0DFE` is the callback/shared-code update lock. `4184:0E0E` is a
  saturating nested hide depth: background restoration occurs on `0 -> 1`,
  while capture and redraw occur on `1 -> 0`.
- `4184:0E24/0E26` points to the allocated `0240h`-byte background buffer.
  The cursor covers at most a clipped 3-by-3 region of 8-pixel tiles; the
  restore rectangle is stored at `0E30`–`0E36` and the capture rectangle at
  `0E3C`–`0E42`, with right and bottom bounds exclusive.
- `4184:0E08/0E0A` is the requested position, `0E20/0E22` is the displayed
  position, `0E1C/0E1E` is the hotspot, and `0E44/0E46` is the final bitmap
  draw origin. `0E0C` records the driver variant whose 0..639 X coordinates
  must be halved for the game's 320-pixel surface.

Reko's former ES return from the two show routines was incidental register
state. Both routines are now represented as `void`, and all callers discard
that non-result.

The adjacent position helpers are also verified. `SetMouseCursorPositionUnlocked_398C`
clamps register arguments `CX`/`DX`, records the requested position, applies
the driver's optional doubled-X convention, and redraws only on a displayed
coordinate change. `SetMouseCursorPosition_39FB` and
`MoveMouseCursorRelative_3A23` are the synchronized absolute and relative
wrappers.

## Text-window and clipped-sprite rendering

`DS:063A` contains 17h `TextWindowContext` records of 10h bytes. Each record
holds left/top tile, width/height tiles, foreground/background palette colors,
and cursor column/row. `SelectTextWindow_0009` saves the mutable four-word tail
of the old record and loads all eight words of the selected record into
`DS:6230–623E`; `DS:6240` suppresses the invalid save before first selection.

`RenderTextToActiveWindow_000B` uses this state to position text, scroll the
window upward by one font line, clear the newly exposed bottom line, and update
the saved cursor. `DrawTextString_470B` is the raw NUL-terminated fixed-font
renderer beneath it, including CR handling and screen-edge wrapping.

`DrawClippedSprite_566E` consumes the same context geometry as a clipping
region. Its semantic arguments are destination and source far pointers, x/y,
and region index. It dispatches the VGA or CGA/Tandy decoder directly and
redirects the primary EGA destination to `A200:0000` before the EGA decoder.
`DS:7B1C–7B22` holds its active bounds; `DS:7D67–7D6D` is a probable mirror
whose downstream compatibility purpose remains open.

The status-screen text wrappers immediately above this renderer are also
resolved. `DrawLeftAlignedClippedText_3F57` truncates normalized text to a
maximum pixel width and draws it at the supplied x/y position.
`DrawRightAlignedClippedText_3FF2` uses the same truncation pass, then places
the result at `leftX + maximumWidth - textWidth`.

`DrawCenteredClippedText_3E35` adds an optional explicit line split before the
same width clipping and centers each line independently. Its normalization
helpers are `RemoveLeadingSpacesFrom_41E8` and
`TrimTrailingEncodedSpaces_4238`; the latter deliberately tests only the low
six bits so renderer attribute bits do not prevent trailing-space removal.

The native sprite header is shared across the adapter paths: byte 1 plus one
is height, byte 2 selects decoded row width, and encoded payload begins at byte
4. `DrawVgaRleSprite_50A1` is now verified as a transparent-run decoder where
nonzero bytes are literal palette indices and `00h,count` skips pixels.
`DrawCgaTandyEncodedSprite_14B7` and `DrawEGAEncodedSprite_30FD` consume packed
and mask-oriented native streams; their token-level grammar remains open.

The `DS:07AA` modal-selection family is now named. Group initialization saves
the current row bytes at `DS:B66A`; the poller updates mouse/keyboard selection
and caches the active XOR rectangle at `DS:B652-B65A`; the toggle routine uses
that cache to erase or redraw the highlight without retaining a backing copy.

The adjoining text-window composition path is also recovered.
`SelectAndClearTextWindow_0009` selects a context then clears it;
`ClearActiveTextWindow_0006` fills its rectangle and resets its cursor;
`DrawActiveTextWindowFrame_0001` draws four corners followed by four repeating
edge sequences through `DrawRepeatingFrameTileSequence_0008`. Each edge
sequence is terminated by `00FFh` in a far definition selected from
`DS:08C2`.

The interactive text editor at `0D73:4317` uses `DS:23F9` as a fixed-width
buffer and `DS:23EA` as its cursor. Its character-class flags admit digits,
letters/space, and the punctuation whitelist at `DS:23EC`.

`3934:0001` is `DOS_DeviceIOControl`. Assembly confirms DOS IOCTL
(`INT 21h/AH=44h`) with the handle in `BX`, operation in `AL`, data in `DS:DX`,
and count in `CX`. Operation `00h` returns the device-information word from
`DX`; the open layer uses operation `01h` to enable raw device mode.

### `30B2` timer and PC-speaker driver

The names in this block follow the established Inception timer/speaker
vocabulary and retain Revenge's original routine offsets:

| Address | Annotated name | Evidence |
|---|---|---|
| `30B2:0291` | `EnablePCSpeaker_0291` | Reads port `61h`, sets bits 0 and 1, and writes it back |
| `30B2:029F` | `WritePCSpeakerPITDivisor_029F` | Writes the low and high divisor bytes to PIT channel 2 at port `42h` |
| `30B2:02A6` | `StartPCSpeakerFixedTone_02A6` | Writes divisor `000Eh`, then enables the speaker gate |
| `30B2:02C1` | `DisablePCSpeaker_02C1` | Clears port `61h` bits 0 and 1 |
| `30B2:02D9` | `InstallMusicTimer_02D9` | Saves vector 08h, installs the segment's IRQ0 handler, and reprograms PIT channel 0 |
| `30B2:0382` | `RestoreSystemTimer_0382` | Restores the saved vector and PIT divisor `0000h` (65536 / approximately 18.2 Hz) |
| `30B2:03E1` | `RequestPCSpeakerEffectStop_03E1` | Sets `426B:00E2`; the IRQ handler consumes it and clears the active effect stream |
| `3621:0035` | `SetMIDITimingDivisor_0035` | Atomically replaces the MIDI fixed-point clock divisor at `DS:624C` and clears its carried remainder at `DS:6250` |

The generated restore routine had lost the saved IRQ0 segment and supplied
only the offset. It now reconstructs the original segment:offset vector, as
shown by the assembly at `30B2:0382`. Timer-handler state at `426B:0002-0010`
has also been named for its observed role: game-data segment, driver mode,
system-tick reload/countdown, music-service reload/countdown, and reentrancy
guard.

`DecodePCSpeakerEffectTick_00DF` consumes the complete PC-speaker command set.
Duration-scale commands `E8h/E9h` use the CPU signed-overflow flag rather than
unsigned saturation: `E8h` wraps its byte subtraction, while `E9h` substitutes
`FFh` only when byte addition has signed overflow. This unusual behavior is
preserved in the maintained C and toolkit simulator.

The periodic MIDI update computes `(remainder + ticksPerMinute) /
timerCallsPerMinute`, stores the division remainder back at `DS:6250`, and
applies the quotient to its event-time counter. MIDI meta event `FF 51`
converts microseconds per quarter note into BPM, then stores `60h * BPM` at
`DS:624E`; this verifies the default `1110h` divisor as the timer-service calls
per minute. Meta event `FF 58` configures the optional tick-to-beat and
beat-to-measure counters at `DS:6252-6262`. The engine also repurposes meta
event `FF 01` as a 16-byte logical-to-physical channel map at `DS:6728`.

## Unit records and tables

- `MECHTYPE.DAT` is 13,350 bytes: exactly 89 records of 150 bytes (`0x96`).
- `REVENGE_30F1.c` repeatedly copies `0x96` bytes while assembling scenario
  rosters. This is strong evidence that these are mech/vehicle/infantry records.
- `PersistentUnitRoster_8B81` and `LiveScenarioUnits_99E0` each contain 24
  contiguous unit records. These remain structural names pending scenario
  tracing.
- Proposed `PrepareScenarioUnitRosters_0006` snapshots clock/state fields,
  switches on verified ASCII `ScenarioFileSuffix_B581` (`SCENE1` through
  `SCENET`), and builds the participating tactical roster from complete records.
- Proposed `ResetLiveUnitState_0878` restores current structure/armour and
  ammunition-like fields from maxima, consistent with unit initialization or
  repair.
- Proposed `InvalidateEmptyRosterSlots_0B59`,
  `UpdatePilotAvailability_0A81`, and `CompactScenarioLances_0B8F` perform
  the visible roster sanitation, pilot-availability bookkeeping, and lance
  compaction steps called by later scenario recipes.
- Proposed `InitializeScenarioUnitFromTemplate_2472` copies the selected
  `96h` template into a live slot and resets its tactical state. SCENE opcode
  `E9h` combines it with proposed `PrepareUnitTypeResources_5962` and
  `AssignPilotRosterEntryToUnit_0AFC` to spawn a scenario unit.
- Verified `ExecuteSceneInstructions_2A4E` consumes the complete contiguous
  opcode range `CFh`-`FEh` through the far cursor at `DS:A9DB:A9D9`; `FFh`
  terminates the stream. Its conditional and unconditional branch words are
  offsets relative to `DS:71A8 + SceneInstructionBaseOffset_A862`. The
  annotation version now represents all 48 opcodes without Reko `Mem`, `SEQ`,
  or synthetic stack-frame expressions.
- Proposed `AdvanceUnitSceneRoute_469C`, called by SCENE opcode `E8h`, consumes
  the 24 `0Bh`-byte route records at `DS:86C1` and advances the indexed unit's
  active destination through its four X/Y waypoints.
- The SCENE narration table is six speaker groups of 11 generic categories,
  followed by six event messages. Opcodes `E1h..DCh` select event slots `0..5`
  and therefore messages `42h..47h`; SCENE1 supplies an end-to-end control-flow
  and message-text cross-check.
- Verified `HasNarrationMessage_5476` maps subject/unit indices `0..3` to
  speaker banks `0..3`, `4..7` to bank 4, and 8 or greater to bank 5. It
  returns the selected string's first byte as an availability test; event
  categories bypass those generic banks.
- Confirmed `CopyFarMemory` is the common far-memory copy routine used for
  every `0x96`-byte record move. Confirmed `AdvanceCampaignClock_5D30` adds
  hours/minutes to `DS:8337/8338` with 60-minute carry and 24-hour wrap.
The executable initializes `DS` to `3A6Ah` at `0800:0000`. A contiguous
unit-name table begins at `DS:47B6` with `Locust`, followed by BattleMechs,
vehicles, and infantry. Confirmed anchors include `Rommel Tank` at `DS:4998`,
`Pegasus` at `DS:49A4`, `Drillson` at `DS:49AC`, `Mobile HQ` at `DS:49B5`,
`Galleon` at `DS:49D0`, `Skulker` at `DS:49D8`, `Puma` at `DS:4A02`,
`Black Hawk` at `DS:4A07`, and `Mad Cat` at `DS:4A12`.

The corresponding `UnitNameTable_3D2E` begins at `DS:3D2E`. Its first entry is
`3A6A:47B6` (`Locust`), followed by 88 more far pointers through
`BattleMaster+`. Assembly cross-references confirm that this is an indexed
name table, including the detailed unit-status routine at `2507:483A` and UI
routines at `2007:0E19`, `RunTacticalUnitCommandMenu_000B`, `2208:28A9`, the proposed
`SelectUnitTypeFromList_0625` at `2507:0625`, `2507:0AB1`,
`2507:152E`, `2507:26EE`, and `2B2D:0532`.

### Identified indexed text/data tables

| DS address | Table | Confirmed consumers |
|---|---|---|
| `DS:0435` | `WeaponDefinitionTable_0435`: 23 records × `0Fh`; far name pointer, heat, damage, minimum/maximum range, half-ton weight, rack size, ammunition family, critical-slot count, recovery delay, and effect ID | heat scale at `2B2D:0191`; combat ratings at `2D1B:0005`; attack resolution at `2D1B:1854`; damage at `2D1B:1E2B`; status UI at `2507:483A` |
| `DS:88BF` | `UnitWeaponTypeCounts_88BF`: 23 words indexed by weapon equipment ID minus one | rebuilt by `CountUnitWeaponsByType_0469`; consumed by heat, status-screen, and combat/equipment paths |
| `DS:8929` | `UnitWeaponRecoveryCounters_8929`: 24 × 23 byte counters | `ResolveWeaponAttack_1854` adds weapon field `+0D`; `RecalculateUnitCombatRatings_0005` advances/clamps them |
| `DS:A971/A973` | proposed low/high weapon-availability bitmasks per unit | built by `RecalculateUnitCombatRatings_0005`, excluding empty-ammunition and recovering weapons |
| `DS:AEF1` | proposed 24 × `0Ch` derived combat-rating records | movement, durability, and close/medium/long weapon-band values |
| `DS:AE5F`, `00AA`, `2ECE`–`2ED9` | packed terrain-damage map, row stride, and four-cell increment/mask/shift tables | `ReadTerrainDamageState_0CF9`; `AdvanceTerrainDamageState_0C50`; proposed `ApplyTerrainImpact_276F` |
| `DS:B587/B5B9` | consecutive attacked-frame count and formation/leader state | `IsCurrentLanceLeader_1829`; `RebuildLanceFormationAfterLeaderLoss_18A1` |
| `DS:2459` | `MonthNameTable_2459`: 12 far pointers, JAN-DEC | `DisplayMissionDate_376C` at `0D73:376C` |
| `DS:25E5` | `MenuOptionTextTable_25E5`: 14 far pointers | `ShowMainMenu_24DF` passes the first three entries to `RunMainMenuSelection_25F5`; other menu code uses subranges inside this table |
| `DS:30CB` | `UnitAllegianceNameTable_30CB`: Friendly/Enemy | proposed `DrawUnitAllegianceHeader_0A20` at `2507:0A20` |
| `DS:30F2` | `UnitStatAbbreviationTable_30F2`: LNG/MED/CLS/SPD/EXP/GUN | header renderers at `2507:60D2` and `2507:6111` |
| `DS:32F8` | `UnitClassMenuTextTable_32F8`: Light/Medium/Heavy/Assault/Enhanced/Omni/Cancel | verified `SelectUnitClass_0501` at `2507:0501` |
| `DS:32D7` | `OmniUnitTypeIdList_32D7`: Puma/Black Hawk/Mad Cat/Elementals/`FFh` | `SelectUnitTypeFromList_0625`; Elementals is offered only for Enemy selection |
| `DS:3D2E` | `UnitNameTable_3D2E`: 89 far pointers aligned with `MECHTYPE.DAT` records | type selection at `2507:0625`; roster display at `2507:26EE`; detailed status at `2507:483A`; other tactical UI consumers |
| `DS:3E92` | `PilotNameTable_3E92`: 37 far pointers indexed by roster pilot ID | `DrawUnitRosterScreen_26EE` combines each pilot name with a unit name using `DS:30DB` `/` |
| `DS:5CFC` | `DigitalSoundEntries_5CFC`: `16h` records × `0Bh`; code, resource index, 32-bit source file offset, sample length, and packed-buffer offset | lookup at `31FB:0256`; packed scenario bank construction at `31FB:0297`; playback descriptor setup at `31FB:0742` |
| `DS:5DEE-5E6D` | `ScenarioDigitalSoundBankCodeLists_5DEE`: NUL-terminated sample-code lists | selected by scenario in `LoadScenarioDigitalSoundBank_0297`; every byte resolves through `DigitalSoundEntries_5CFC` |
| `DS:5E6E-5F6A` | `ScenarioDigitalSoundPlaybackFragments_5E6E`: NUL-terminated sample-code fragments | concatenated by scenario, narration mode, force index, and result state in `PlayScenarioDigitalSoundSequence_0742` |

`2507:483A` directly combines the unit-name table, weapon-definition records,
and the `ARMOR:`, `HEAT:`, and `EXIT` strings. It is therefore named
`DrawUnitStatusScreen_483A`. Names assigned to the smaller header/selection
routines remain proposed until their callers and arguments receive a complete
trace; the `2507:0501`/`0625` class-and-type selection pair is now verified.

The music-resource layer above the MIDI and PC-speaker drivers is recovered in
`REVENGE_3014.c`. It owns a fixed `30D4h`-byte far staging buffer at
`DS:B60A:B60C`, caches its loaded resource index at `DS:563E`, remaps two track
indices for driver modes 0–2, and starts the loaded sequence through
`StartMIDISequence_00C1`.

### Procedures recovered by the refreshed decompile

The refreshed Reko run recovered 31 procedure bodies that were absent from the
previous partial output. The most useful coherent family is the tactical
weapon-resolution path:

| Address | Name/confidence | Evidence |
|---|---|---|
| `0800:06D1` | `DetermineRelativeAttackDirection_06D1` `[P]` | Reduces source/target coordinate deltas to eight directions, translates through `4184:08D7`, and feeds the hit-location path. |
| `0800:078C` | `TraceMapLineOfSight_078C` `[P]` | Walks between two map coordinates while checking terrain bytes against obstruction thresholds and a step limit. |
| `0800:092A` | `InterpolateLineCoordinate_092A` `[V]` | Implements linear interpolation used while clipping a line to the tactical viewport. |
| `1A1F:0D55` | `DrawWeaponAttackTrace_0D55` `[P]` | Converts map coordinates to viewport pixels, optionally scatters the endpoint, clips, and draws the attack trace. |
| `2007:0A4D` | `DetermineOctant_0A4D` `[V]` | Classifies signed X/Y deltas into values `0..7`. |
| `2D1B:1854` | `ResolveWeaponAttack_1854` `[P]` | Now emitted in full; confirms range, ammunition, heat, recovery, hit roll, effect dispatch, and damage stages. |
| `2D1B:1DF4` | `Roll2D6_1DF4` `[V]` | Draws two independent `1..6` values from the byte PRNG and returns their sum. |
| `2D1B:1E2B` | `ApplyWeaponDamage_1E2B` `[P]` | Selects hit location from direction plus 2d6, removes armor, transfers excess damage, and enters critical/destruction handling. |
| `2D1B:2453` | `DestroyScenarioUnit_2453` `[V]` | Clears the persistent active record, invalidates attack targets, preserves the destruction coordinates, and queues friendly/enemy destruction state. |
| `2D1B:23AC` | `BeginTerrainDamageAtCell_23AC` `[V]` | Converts X/Y to a packed two-bit field and begins immediate or queued terrain damage when its state is still zero. |
| `2D1B:2A30` | `FindOperationalLanceLeader_2A30` `[P]` | Selects the first occupied mobile member of a four-unit lance, falling back to its first occupied member. |
| `2208:1829` | `IsCurrentLanceLeader_1829` `[P]` | Tests explicit first-lance state or first operational position in a four-record block. |
| `2208:18A1` | `RebuildLanceFormationAfterLeaderLoss_18A1` `[P]` | Copies replacement-leader orders and rebuilds follower route points from `DS:17DE`. |
| `2208:1B33` | `SelectLanceFormationMode_1B33` `[V]` | Chooses a legal deterministic or randomized formation from deployed count, leader experience, scenario profile, and lance strength. |
| `1A1F:0CF9` | `ReadTerrainDamageState_0CF9` `[V]` | Reads one two-bit state from the packed terrain-damage map and caches its byte pointer. |
| `1A1F:0C50` | `AdvanceTerrainDamageState_0C50` `[V]` | Bounds the map cell and advances its packed damage state when its terrain type permits. |
| `2D1B:276F` | `ApplyTerrainImpact_276F` `[P]` | Manages per-cell impact state and six-byte impact records; structure-collapse edges remain under review. |
| `2D1B:2AF3` | `CollapseStructureAtMapCell_2AF3` `[P]` | Expands a structure footprint, advances every affected cell, plays effects, and removes units in the footprint. |
| `31FB:0567` | `DispatchWeaponEffect_0567` `[P]` | Now emitted; chooses the digital-driver path or indexed music/PC-speaker fallback using the weapon effect ID. |
| `31FB:058D` | `PlayDigitalWeaponEffect_058D` `[P]` | Configures and queues the digital resource selected by the effect table. |
| `34C6:0008` | `RandomInRangeInclusive` `[V]` | Returns `minimum + randomByte % (maximum - minimum + 1)`. |
| `34B3:0008` | `LoadPackedIconResource_0008` `[V]` | Read a 16-bit packed length and its tactical icon RLE payload. |
| `34DF:0003` | `LoadPackedIconPageDirect_0003` `[V]` | Load/decode the direct icon page and apply its CGA mask conversion. |
| `35C2:000B` | `CopyDecodedIconPage_000B` `[V]` | Dispatch the icon layout decoder and perform adapter post-processing. |
| `0800:33D6` | `DecodeLinearRleScreen_33D6` `[V]` | Expand signed runs into 7D00h consecutive bytes. |
| `0800:342D` | `DecodeColumnMajorRleScreen_342D` `[V]` | Expand signed runs down 200-pixel columns of a 160-byte-stride page. |
| `3005:0008` | `DrawTacticalClippedSprite_0008` `[V]` | Apply a text-window clip record and dispatch the tactical sprite renderer. |
| `0800:0B07` | `PlotPixel_0B07` `[V]` | Plot one pixel through the active adapter-specific framebuffer path. |
| `24C5:012E` | `RefreshTacticalOverview_012E` `[V]` | Restore the old overview overlay and plot the current viewport and deployed-unit markers. |
| `24C5:02F1` | `DrawTacticalOverviewViewportFrame_02F1` `[V]` | Snapshot the tactical camera origin and draw its doubled-pixel overview frame. |
| `24C5:037F` | `DrawTacticalOverviewMap_037F` `[V]` | Plot the full aligned overview color map and initialize its overlay caches. |
| `24C5:0401` | `ExitTacticalOverview_0401` `[V]` | Clear overview mode and rebuild the ordinary tactical interface. |
| `1A1F:182E` | `ScrollTacticalViewportToCursor_182E` `[V]` | Keep the cursor within the 19-by-12 viewport while clamping its map origin. |
| `2007:16BA` | `RedrawTacticalStatusPanel_16BA` `[V]` | Rebuild tactical window 06h, its side indicator, and the campaign clock. |
| `2208:26B1` | `CompareLanceCombatRatings_26B1` `[V]` | Compare two four-unit lances across five aggregate derived-rating fields. |
| `2208:2853` | `HasActiveLanceFollowers_2853` `[P]` | Test whether a selected leader has a later deployed member in its lance. |
| `2D1B:2604` | `BuildArmWeaponAvailabilityMasks_2604` `[V]` | Build a 23-bit availability mask from intact left/right-arm weapons and ammunition. |
| `2D1B:296F` | `QueueLanceOrderNarration_296F` `[P]` | Queue category-07h narration for eligible friendly lance leaders. |
| `2D1B:2C23` | `AdvanceUnitRouteWaypoint_2C23` `[V]` | Advance and publish the next X/Y pair in a unit's four-waypoint route. |

The remaining newly recovered bodies are mostly downstream AI, lance movement,
and animation queues. Their arguments are still too entangled for durable names,
so they remain for a later tracing pass.

## String anchors

The initialized data segment is `DS=3A6Ah`. For bytes in the unrelocated
executable image, the observed conversion is:

```text
DS offset = file offset - 0x368A0
```

Verified strings/data names include:

| DS address | Text |
|---|---|
| `DS:1E82` | `PPC` |
| `DS:21B8` | `MECHTYPE.DAT` |
| `DS:21E7` | `SAVEGAME.DAT` |
| `DS:47B6` | `Locust` (start of the contiguous unit-name table) |

Printable byte runs alone are not enough to label a generated memory access.
A call-site comment is added only when the address is used in a compatible
string/file/UI context; indirect references remain candidates for later data-
flow work.

## Identified text blocks

The first systematic string-reference pass treats these initialized ranges as
text blocks and resolves direct `SEQ(ds, address)`/`Mem[ds:address]` accesses
against the containing NUL-terminated string:

| Range | Contents |
|---|---|
| `DS:1E38-23F8` | weapon names, resource filenames, memory/save errors |
| `DS:261A-2717` | save/load/rename menu text |
| `DS:27E3-2B08` | credits |
| `DS:3644-38BC` | allegiance, range, and status text |
| `DS:38CA-3CA9` | fonts, version/copyright, startup errors |
| `DS:40E0-46AD` | tactical UI and orders |
| `DS:4786-4CBF` | formations, unit names, and related tactical UI |
| `DS:4CC4-563A` | character, force, unit, weapon, and damage text |
| `DS:5FD0-6223` | DOS/file error messages |

Calls resolved during this pass use the recovered C string literal and retain
an adjacent `TEXT DS:xxxx` comment as address provenance. Addresses inside a
block that do not begin a confirmed string remain numeric and are labelled as
table/control data rather than being assigned invented text.
