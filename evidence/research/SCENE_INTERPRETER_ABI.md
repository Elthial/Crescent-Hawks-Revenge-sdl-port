# SCENE interpreter ABI

This note records the assembly-verified calling contracts around
`1A1F:2A4E`. Its immediate purpose is to prevent Reko from inventing ambient
segment parameters, output references, or live-register arguments while it
decompiles the large SCENE bytecode dispatcher.

## Interpreter entry

```c
void ExecuteSceneInstructions_2A4E(void);
```

Confidence: **V**.

The far procedure reads no positive BP stack offsets. It allocates `16h` bytes
of local storage, saves SI and DI, and returns with `RETF` rather than a
callee-cleaning return. `DS` is the ambient `3A6Ah` game-data segment, not a C
argument. The instruction stream is read through the global far cursor whose
offset is `DS:A9D9` and whose segment is `DS:A9DB`. Execution stops when the
next byte is `FFh` or an opcode sets the local stop flag at `BP-0Eh`.

The opcodes are sign-extended before dispatch. Reko therefore prints values
such as `~0x24` or `65500`; those are signed representations of byte opcodes,
not 16-bit operands.

## Direct callee contracts

| Address | C signature | Evidence relevant to the dispatcher |
| --- | --- | --- |
| `2B34:01AB` | `short FindUnitWeaponByOrdinal_01AB(byte far *unitRecord, word weaponOccurrence, word removeWeapon)` | Four stack words are removed after each call: one far pointer and two words. |
| `1A1F:3A8A` | `void InstallUnitEquipmentInFirstFreeSlot_3A8A(word unitIndex, byte equipmentId)` | Two bytecode bytes are zero-extended and pushed as words. |
| `2208:1829` | `word IsCurrentLanceLeader_1829(word unitIndex)` | One word is pushed; AX is immediately tested or stored. |
| `0800:554B` | `void CopyFarMemory(register CX word byteCount, byte far *source, byte far *destination)` | The dispatcher places `0Bh` in CX and pushes only two far pointers. The old three-stack-argument signature was wrong. |
| `2D1B:0379` | `void CalculateUnitDurabilityTotals_0379(byte far *unitRecord)` | One far pointer is pushed and four stack bytes are discarded. |
| `2007:15FF` | `void DrawCampaignClock_15FF(void)` | Called immediately after the date/time opcode stores three bytes; no stack operands. |
| `2208:2472` | `void InitializeScenarioUnitFromTemplate_2472(short unitType, word unitIndex)` | Two words are pushed. `FFFFh` is a deliberate sentinel unit type. |
| `1A1F:5962` | `void PrepareUnitTypeResources_5962(word unitType)` | One word is pushed after scenario-unit initialization. |
| `30F1:0AFC` | `void AssignPilotRosterEntryToUnit_0AFC(word unitIndex, word rosterSlot)` | The roster slot is pushed first and the unit index second, so the callee receives unitIndex at BP+06 and rosterSlot at BP+08. |
| `1A1F:469C` | `void AdvanceUnitSceneRoute_469C(word unitIndex)` | One bytecode unit index is zero-extended and pushed. |
| `1A1F:0CF9` | `word ReadTerrainDamageState_0CF9(short mapX, short mapY)` | Two map coordinates are pushed; AX is tested against zero or three. |
| `34C6:0008` | `short RandomInRangeInclusive(word minimum, word maximum)` | The dispatcher pushes one and the bytecode denominator; AX is compared with the denominator. |
| `1A1F:4923` | `void QueueRandomMapEdgeEffect_4923(short centerX, short centerY)` | Two bytecode coordinates are pushed. SI and DI in the old generated C are locals assigned on every switch path, not inputs. |
| `1A1F:5525` | `void QueueLinkedUnitStatusNarration_5525(word unitIndex)` | One discovered unit index is pushed. |
| `1A1F:19FD` | `void CreateRandomAreaImpact_19FD(short centerX, short centerY, word chanceDenominator)` | Three zero-extended bytecode operands are pushed and six bytes are discarded. |

## Newly recovered helper contracts

```c
void LoadUnitTemplateRecord_10CD(short unitType);
void SwapUnitRouteWaypoint_4857(word unitIndex, word waypointIndex);
void QueueMapEdgeEffect_08D5(
    short mapX,
    short mapY,
    word baseSpriteId,
    word edgeDirection);
void ApplyAreaTerrainAndUnitDamage_0CFB(
    short mapX,
    short mapY,
    word visualEffectType,
    short weaponIndex);
word HasNarrationMessage_5476(word narrationSubject, word messageCategory);
void QueueLinkedUnitStatusNarration_5525(word unitIndex);
void DrawTileAlignedText_01EE(
    char far *text,
    word tileX,
    word tileY,
    byte foregroundColor,
    byte backgroundColor);
void DrawCampaignClock_15FF(void);
void DrawCampaignClockSeparator_1DCC(void);
```

All of these contracts are represented as addressed C declarations in
`REVENGE-metadata.inc`. Their `DS=3A6A` entry facts remain in the dcproject's
`registerValues` section so each address has only one procedure declaration.

`LoadUnitTemplateRecord_10CD` deserves special attention: the previous output
showed SI as an input, but the assembly assigns SI from the file-open result
before its first use. Its only source-level argument is `unitType` at BP+06.

`HasNarrationMessage_5476` also had an incorrect earlier name. It resolves a
message-table offset internally, loads the first byte of the selected string,
zero-extends it into AX, and returns that byte as an availability test. It does
not return the offset.

## Remaining interpreter work

- Preserve the now-verified byte values and operand widths for all 48 dispatch
  entries while refining only their higher-level semantics.
- Translate additional dispatcher case families only where doing so clarifies
  a called helper or state field beyond the existing lossless decoder.
- `2007:0846` is now verified as `QueueTacticalImpactVisual_0846(mapX, mapY,
  impactClass)`. It queues an impact visual for the three classes used by known
  callers. The original leaves DI unchanged for other values; the maintained C
  rejects that undefined path instead of inventing a sprite ID.
- Controlled play remains useful only for the narrative identities of D4h
  selectors 04h/05h, the four D5h campaign-award slots, and confirmation of
  the proposed FCh order-mode labels. DAh withdrawal and F8h attacked-this-tick
  state are already verified from their producers and consumers.
- Re-run Reko after each signature batch and compare stack temporaries, call
  argument order, and unresolved `Mem*` expressions without treating their raw
  count as a completeness metric.

## Named-procedure signature coverage

The active machine-readable inventory currently contains 193 procedure entries
in `REVENGE.dcproject` and 66 addressed declarations in
`REVENGE-metadata.inc`. Ordinary Borland stack calls remain as `CSignature`
declarations in the dcproject; assembly-sensitive register calls and selected
SCENE/runtime families live in the include with `reko::address`, `reko::arg`,
and `reko::returns` attributes. Some addresses intentionally appear in both
forms; uniqueness is enforced within each source rather than by adding their
counts together.

Run `C/tools/Test-AnnotationConsistency.ps1` after changing either source. It
also rejects old `fnSEG_OFFSET` aliases for methods already named in the
dcproject.

Two internal graphics/RLE helpers require both input and output bindings for the
same live registers. They are intentionally described as register calls rather
than disguised as ordinary C stack functions:

```c
unsigned long PrepareRLEOutputRun_0CF9(
    DX_BX remainingOutputBytes,
    CX runLength,
    DI destinationOffset,
    ES destinationSegment,
    out DI normalizedOffset,
    out ES normalizedSegment);

byte ShiftPackedPixelsIntoEGAPlanes_34E3(
    AL packedPixels,
    DX plane32Accumulators,
    BX plane10Accumulators,
    out DX updatedPlane32Accumulators,
    out BX updatedPlane10Accumulators);
```

These contracts preserve the register dataflow that Reko previously inferred as
temporary `out` variables and should prevent either helper from acquiring false
stack arguments on later runs.
