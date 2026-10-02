# Completed non-original helper audit

Audit date: 2026-09-28

This is a completed preservation audit retained as evidence. Current policy is
defined in `PRESERVATION_PLAN.md`; the tables below record why each former
addressless helper was inlined, moved below the Original boundary or removed.

`src/Original` contained 62 C function definitions without an original
`SEG:OFFSET` identity in `METHOD_TABLE.csv`. None may be treated as an original
procedure. This audit assigns a preservation-safe disposition to every one.

The audit does not claim that the helpers currently change game behavior. It
identifies a traceability defect: function-shaped decompositions inside
`src/Original` can be mistaken for original procedure boundaries and can hide
the control flow that must remain comparable with the assembly.

## Result

| Classification | Count | Required disposition |
| --- | ---: | --- |
| Game/data-flow decomposition | 22 | Inline into the owning original procedure; retain the ASM order and widths. |
| Host or 16:16 representation adapter | 39 | Move below `src/Original` into Support/SDL, or replace with a non-procedural expression/macro where that is clearer. No game decision may move with it. |
| Disabled Reko artifact | 1 | Delete the `#if 0` pseudo-code block after confirming the annotation/ASM remains available. |

## Game/data-flow decompositions to inline

| File | Helper | Owning procedure/family | Reason |
| --- | --- | --- | --- |
| `REVENGE_0800_GRAPHICS_RUNTIME.c` | `GetVideoScanlineOffset` | video copy/fill/tile procedures | Adapter layout arithmetic belongs at each original call site. |
| `REVENGE_0800_GRAPHICS_RUNTIME.c` | `GetAdapterByteX` | video copy/fill/tile procedures | Invented shared coordinate conversion. |
| `REVENGE_0800_GRAPHICS_RUNTIME.c` | `GetAdapterRowByteCount` | video copy/fill/tile procedures | Wrapper around the invented coordinate conversion. |
| `REVENGE_0800_GRAPHICS_RUNTIME.c` | `ReadRleRunLength` | `DecodeRLEBlock_33D6` family | Splits original decoder control flow. |
| `REVENGE_0D73_SAVE_LOAD.c` | `GetSaveSlotDescriptor` | save/load menu procedures | Game-specific DS record selection. |
| `REVENGE_1A1F_INTERNAL.h` | `GetPersistentUnitRecord` | scene interpreter `2A4E` | Game-record addressing inside the interpreter. |
| `REVENGE_1A1F_INTERNAL.h` | `GetUnitRouteRecord` | scene interpreter `2A4E` | Game-record addressing inside the interpreter. |
| `REVENGE_1A1F_INTERNAL.h` | `ReadSceneByte` | scene interpreter `2A4E` | Hides instruction-pointer mutation repeated by the ASM. |
| `REVENGE_1A1F_INTERNAL.h` | `ReadSceneWord` | scene interpreter `2A4E` | Hides two byte reads and their ordering. |
| `REVENGE_1A1F_INTERNAL.h` | `JumpToSceneOffset` | scene interpreter `2A4E` | Hides interpreter branch state changes. |
| `REVENGE_1A1F_INTERNAL.h` | `BranchOrSkipSceneWord` | scene interpreter `2A4E` | Invented branch abstraction over original opcode cases. |
| `REVENGE_24C5_OVERVIEW_MAP.c` | `GetOverviewRowStride` | tactical overview renderer | Game/video layout decision rather than a host boundary. |
| `REVENGE_24C5_OVERVIEW_MAP.c` | `GetOverviewMapRow` | tactical overview renderer | Invented map-row abstraction. |
| `REVENGE_2507_LANCE_CONFIGURATION.c` | `DrawRosterPilotUnitLabel` | lance/roster presentation | Extracted game presentation logic. |
| `REVENGE_2507_LANCE_CONFIGURATION.c` | `GetLiveScenarioUnitTypeId` | lance/roster presentation | Game-record lookup. |
| `REVENGE_2D1B_UNIT_STATE.c` | `LookupTacticalEngagementMode` | tactical engagement procedure | Extracted game decision table. |
| `REVENGE_3621_MIDI_SEQUENCE.c` | `ConfigureMIDIChannelFromSysEx` | MIDI SysEx service procedure | Splits original MIDI command handling. |
| `REVENGE_3621_MIDI_SEQUENCE.c` | `LoadMIDIInstrumentFromSysEx` | MIDI SysEx service procedure | Splits original MIDI command handling. |
| `REVENGE_3621_MIDI_SEQUENCE.c` | `SetMIDIVoiceCountFromSysEx` | MIDI SysEx service procedure | Splits original MIDI command handling. |
| `REVENGE_3621_MIDI_SEQUENCE.c` | `RebuildMIDIVoiceList` | MIDI allocation/service procedures | Extracted original voice-list loop. |
| `REVENGE_39F8_STRING_TOKENIZE.c` | `IsFarStringDelimiter` | `FarStringTokenize` | Splits the original delimiter scans. |
| `REVENGE_3A3C_TIMEZONE.c` | `ReadCalendarBoundary` | calendar conversion procedure | Extracted DS table access from the original arithmetic. |

Applied on 2026-09-28:

- `GetSaveSlotDescriptor`
- `ReadCalendarBoundary`
- `IsFarStringDelimiter`
- `LookupTacticalEngagementMode`
- `DrawRosterPilotUnitLabel`
- `GetLiveScenarioUnitTypeId`
- `GetVideoScanlineOffset`
- `GetAdapterByteX`
- `GetAdapterRowByteCount`
- `ReadRleRunLength`

Their expressions and control flow now appear directly inside their owning
original procedures.

Applied on 2026-09-28 (final structural pass):

- The six scene-interpreter access/branch decompositions are now
  non-procedural expressions expanded within the original segment file; the
  only C procedure boundary remains `ExecuteSceneInstructions`.
- Tactical-overview row-stride and map-row arithmetic is written directly in
  `RefreshTacticalOverview` and `DrawTacticalOverviewMap`.
- MIDI SysEx channel, instrument, and voice-list control flow is written
  directly in `DispatchMIDISystemByte` and
  `ResetMIDIPlaybackState`.

No game/data-flow helper function definitions remain in `src/Original`.

## Host and representation adapters

| File | Helpers | Count | Required destination |
| --- | --- | ---: | --- |
| `REVENGE_1A1F_INTERNAL.h` | `GetTacticalBackingBuffer`, `SetTacticalBackingBuffer` | 2 | Replace with explicit DS far-pointer loads/stores or a Support-level 16:16 bridge. |
| `REVENGE_3037_KEYBOARD.c` | `PumpHostKeyboardEvent` | 1 | SDL input boundary. |
| `REVENGE_31FB_DIGITAL_SOUND.c` | `DigitalSoundDataAt`, `DigitalSoundDriverDescriptorOffsets`, `DigitalSamplePlaybackDescriptors`, `DigitalWeaponEffectTable`, `DigitalSoundEntries`, `DigitalSoundString` | 6 | Typed views/macros over the recovered DS image in Support; no playback decisions. |
| `REVENGE_375F_AUDIO_HARDWARE.c` | `ResolveDigitalHardwareDescriptor`, `ResolveDigitalPlaybackDescriptor`, `ResolveProbeCandidateList`, `DispatchDigitalHardwareProbe`, `DispatchDigitalHardwareAcquire`, `DispatchDigitalHardwareRelease`, `InvokeDigitalSampleCompletion` | 7 | Host callback/far-pointer dispatch bridge in Support/SDL. Original wrapper calls remain in `REVENGE_375F_AUDIO_HARDWARE.c`. |
| `REVENGE_38CD_FAR_HEAP_UNLINK.c` | `ResolveBlock`, `EncodeBlock`, `GetFarHeapArenaBase`, `SetFarHeapArenaBase`, `GetFarHeapTailBlock`, `SetFarHeapTailBlock`, `GetFarHeapFreeListHead`, `SetFarHeapFreeListHead`, `FarHeapPayload` | 9 | Shared far-heap representation macros or Support primitives. Preserve allocator branches in the original procedures. |
| `REVENGE_38FE_PROGRAM_BREAK.c` | `GetMinimumProgramBreak`, `GetCurrentProgramBreak`, `SetCurrentProgramBreak`, `GetMaximumProgramBreak`, `SetMaximumProgramBreak` | 5 | Explicit far-pointer state expressions or Support primitives. |
| `REVENGE_398D_FAR_HEAP.c` | `ResolveBlock`, `EncodeBlock`, `GetFarHeapArenaBase`, `SetFarHeapArenaBase`, `GetFarHeapTailBlock`, `SetFarHeapTailBlock`, `GetFarHeapFreeListHead`, `SetFarHeapFreeListHead` | 8 | Share the same far-heap representation layer as `REVENGE_38CD_FAR_HEAP_UNLINK.c`. |
| `src/Support/representation.c` | `InitializeOriginalResourceDescriptorPointers` | 1 | Host DS-image initialization in Support; retain the original resource procedure that invokes it. |

Applied on 2026-09-28:

- The tactical backing-buffer accessors now use the generic split-word
  `HostFarPointer_LoadWords`/`HostFarPointer_StoreWords` Support bridge.
- Keyboard host polling terminates directly at `SDLBackend_InputPending` and
  `SDLBackend_ReadRawKeypress`; DOS ring-buffer control remains in the two
  original keyboard procedures.
- Digital-audio DS views and resource-descriptor initialization moved to
  `src/Support/representation.c`.
- Digital descriptor/callback resolution moved to
  `src/Support/digital_bridge.c`.
- Far-heap 16:16 state access moved to `src/Support/far_heap_bridge.c` and is
  shared by the allocation and release translation units.
- Program-break 16:16 state access moved to
  `src/Support/program_break_bridge.c`.

All 39 audited host/representation helpers have therefore been removed as C
function definitions from `src/Original`. The original procedures retain all
branching, iteration, queue, allocation, and resource-selection decisions.

## Disabled artifact

| File | Helper | Disposition |
| --- | --- | --- |
| `REVENGE_0800_GRAPHICS_RUNTIME.c` | `RekoArtifact_ExtractHighNibbleAndShiftLeft` | It exists only inside disabled Reko pseudo-code. Delete that archival block; the annotation and executable remain the evidence. |

Applied: the disabled block containing this artifact was removed on
2026-09-28. It is no longer part of `src/Original`.

## Verification observations

- All 785 known executable procedures remain inventoried by original address.
- Two non-procedure evidence rows are retained explicitly: `1A1F:29BB` is a
  reference to `0800:29BB`, while `2D1B:0000` is a segment-leading data byte.
- Annotation and preservation filenames have one-to-one parity.
- No SDL header or direct SDL call appears in `src/Original`.
- All 197 `Verified [SDL]` rows name their platform redirect.
- The behavioral audit is complete: 588 rows are `Verified`, 197 are
  `Verified [SDL]`, and none remain `Unchecked`.
- Every flat `src/Original` translation unit is admitted to the runtime.

## 2026-09-29 regression audit

The Inception-style data refactor exposed nine later-added addressless static
helpers. They are not original procedure boundaries and therefore are not
eligible for `Verified` status in `METHOD_TABLE.csv`.

| Helper | Classification | Preservation disposition |
| --- | --- | --- |
| `MIDIDriverDataOffset` | 16:16 representation expression | Applied: inlined into `ActivateMIDIDriver`; no extra procedure boundary remains. |
| `FarPointerLinearAddress` | 16:16 representation expression | Applied: moved to the generic Support bridge as `HostFarPointer_ToLinear`; the three original pointer primitives retain their arithmetic. |
| `ReadPackedFourBitPixel` | Graphics-loop decomposition | Applied: packed-nibble reads now appear in each owning `0800` raster procedure. |
| `ReadCgaPixel` | Graphics-loop decomposition | Applied: CGA packed-pixel extraction now appears in each owning procedure. |
| `DrawPackedTacticalTile` | Graphics-loop decomposition | Applied: its loops are restored at the three original call sites with their adapter branches intact. |
| `PackEgaPlaneRow` | Graphics-loop decomposition | Applied: plane packing is inlined into `DrawCompositeTacticalTile`. |
| `DrawEgaCompositeRow` | Graphics-loop decomposition | Applied: row composition is inlined into `DrawCompositeTacticalTile`. |
| `SpritePixelIsInsideClip` | Graphics-loop decomposition | Applied: the original bounds expression appears at each sprite-decoder use. |
| `ReadFramebufferPixel` | Graphics-loop decomposition | Applied: the sole CGA decoder use reads the indexed framebuffer directly after its bounds test. |

This audit deliberately did not move the seven raster helpers into SDL: they
encode original adapter behavior, not a host boundary. Their logic now lives
inside the addressed procedures whose assembly contains it.

A follow-up inventory also found `MIDIDriverDispatch`, an older addressless
host callback selector not included in the nine-helper regression count. Its
selection loop now lives in `src/Support/host_dispatch.c`; `REVENGE_3621`
retains only the descriptor-to-native-table identity data required because
host function pointers cannot occupy the original DOS descriptor words.

After these dispositions, `src/Original` contains no addressless static C
function definitions. The strict C17 build and all preservation tests pass.

## 2026-10-02 accounting and boundary regression

The ledger audit distinguished the two executable byte-fill procedures which
had accidentally shared one reconstructed name. `0800:2D37` is now
`FillRuntimeFarMemoryBytes` (the short `REP STOSB` implementation), while
`3985:0009` remains `FillFarMemoryBytes` (the alignment plus `REP STOSW`
implementation). Their callers, metadata, annotations and focused test now
preserve those separate identities.

The same audit found two later host-only framebuffer helpers in segment 0800:
`ResolveHostIndexedRenderTarget` and `DrawHostIndexedPixel`. They now terminate
in `src/Support/video_bridge.c` as `Video_ResolveIndexedRenderTarget` and
`Video_DrawIndexedPixelToActiveTarget`; no new Original procedure boundary is
claimed for either adapter.

`tools/Test-PreservationLedgers.ps1` now prevents recurrence by checking all
787 evidence rows and 785 executable procedure rows for missing paths,
duplicate addresses, unexplained duplicate C names, non-final verification
statuses, addressless static functions, and direct SDL use in `src/Original`.

`METHOD_TABLE.csv` remains authoritative for behavioral verification status.
