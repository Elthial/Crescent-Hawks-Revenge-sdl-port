// Supplemental Reko metadata for BattleTech: The Crescent Hawk's Revenge.
// Keep declarations evidence-based: their sizes and addresses come directly
// from the executable's indexed accesses and adjacent procedure boundaries.

typedef unsigned char byte;
typedef unsigned short word;
typedef void (__far *InterruptHandler)(void);

[[reko::address("0800:23F0")]]
void InstallGameClockTimer_23F0(void);

[[reko::address("0800:241E")]]
void RestoreGameClockTimer_241E(void);

[[reko::address("0800:2440")]]
void GameClockInt1CHandler_2440(void);

[[reko::address("0800:0959")]]
void InstallDamagedTerrainSpriteLookup_0959(void);

[[reko::address("0800:05D3")]]
void BuildTacticalTerrainCellMaps_05D3(
	const byte __far *terrainTypeMap,
	word __far *tacticalCellSpriteMap,
	word viewportX,
	word viewportY);

[[reko::address("0800:078C")]]
word TraceMapLineOfSight_078C(
	short sourceX,
	short sourceY,
	short targetX,
	short targetY,
	const byte __far *terrainTypeMap,
	byte specialTerrainMinimum,
	byte specialTerrainMaximum,
	byte blockingTerrainThreshold,
	byte maximumSteps);

[[reko::address("2007:0650")]]
void RebuildTacticalViewport_0650(void);

[[reko::address("1A1F:0000")]]
void RunTacticalBattle_0000(word scenarioCode);

[[reko::address("1A1F:0351")]]
void UpdateTacticalFrame_0351(word inputAction, word initializeUnits);

[[reko::address("1A1F:0613")]]
void RunTacticalInteractionLoop_0613(void);

[[reko::address("1A1F:1132")]]
void InitializeTacticalUnitRuntime_1132(void);

[[reko::address("1A1F:1C48")]]
void LoadTacticalScenarioResources_1C48(byte scenarioCode);

[[reko::address("2007:159F")]]
void RedrawTacticalViewport_159F(void);

[[reko::address("31FB:00B3")]]
void LoadDigitalWeaponEffectBank_00B3(void);

[[reko::address("31FB:12A7")]]
void ReleaseDigitalWeaponEffectBank_12A7(void);

[[reko::address("2208:1CCC")]]
short UpdateUnitEnemyVisibility_1CCC(word unitIndex);

[[reko::address("1A1F:11F7")]]
void FocusTacticalViewOnUnit_11F7(word unitIndex);

[[reko::address("2208:1E43")]]
short UpdateUnitEnemyProximityState_1E43(word unitIndex);

[[reko::address("2D1B:08AF")]]
void RefreshAllUnitCombatState_08AF(word rebuildWeaponCounts);

[[reko::address("2D1B:03EA")]]
void MoveUnitTowardMapCell_03EA(
    word unitIndex, word destinationX, word destinationY);

[[reko::address("2D1B:08FA")]]
void SelectUnitTacticalTargets_08FA(void);

[[reko::address("2D1B:0F1F")]]
void AdvanceUnitTacticalMovement_0F1F(word unitIndex);

[[reko::address("2D1B:14A4")]]
word ExecuteUnitWeaponAI_14A4(word unitIndex);

[[reko::address("2208:1B33")]]
void SelectLanceFormationMode_1B33(
    word leaderUnitIndex, word randomizeFormation);

[[reko::address("2D1B:23AC")]]
void BeginTerrainDamageAtCell_23AC(
    word mapX, word mapY, word terrainType);

[[reko::address("2D1B:23F8")]]
void ApplyOrQueueTerrainDamage_23F8(
    word packedByteIndex, word subcellIndex, word terrainType);

[[reko::address("2D1B:256B")]]
byte UpdateUnitHeatShutdown_256B(word unitIndex);

// Display-backing encoder. 0800:129E is a register helper: DL receives the
// original high nibble while BX is shifted left four places for the next pass.
[[reko::address("0800:1185")]]
word EncodeDisplayBackingRows_1185(
    const byte __far *source,
    byte __far *destination,
    word groupsPerRow,
    byte rowCount,
    short sourceRowSkip);

[[reko::address("0800:129E")]]
[[reko::returns(register, "dl")]]
byte ExtractHighNibbleAndShiftLeft_129E(
    [[reko::arg(register, "bx")]] word packedPixels,
    [[reko::arg(out, register, "bx")]] word shiftedPackedPixels);

// Tactical queues recovered from their record strides, compaction loops and
// terminal actions in the original assembly.
[[reko::address("2007:0E19")]]
void DrawSelectedUnitStatusPanel_0E19(void);

[[reko::address("2007:16E8")]]
void AdvanceImpactSpriteAnimations_16E8(void);

[[reko::address("2007:17DE")]]
void AdvanceTacticalProjectiles_17DE(void);

[[reko::address("2007:1AE3")]]
void AdvanceMapEdgeEffects_1AE3(void);

// Borland/DOS run-time support recovered from the complete assembly bodies.
[[reko::address("34A7:0014")]]
void InstallDefaultCriticalErrorHandler_0014(void);

[[reko::address("34A7:0059")]]
void InstallCriticalErrorHandler_0059(void __far *criticalErrorCallback);

[[reko::address("39E5:0043")]]
void InvokeInterruptThunk_0043(
    word interruptNumber,
    void __far *inputRegisters,
    void __far *outputRegisters,
    void *segmentState);

[[reko::address("39F3:0000")]]
void CaptureInterruptSegmentState_0000(void *segmentState);

[[reko::address("39F8:0000")]]
char __far *FarStringTokenize(
    char __far *string,
    const char __far *delimiters);

// First dependency-ordered pass over the refreshed decompile's remaining
// auto-named procedures.
[[reko::address("0800:29BB")]]
byte __far *AdvanceFarPointerBy32K_29BB(byte __far *pointer);

[[reko::address("0800:0DE8")]]
[[reko::returns(register, "ax")]]
word ReadWestwoodLzw12Code_0DE8(
    [[reko::arg(register, "cl")]] byte nibbleShift,
    [[reko::arg(register, "si")]] word sourceOffset,
    [[reko::arg(out, register, "si")]] word nextSourceOffset);

[[reko::address("0800:0ED9")]]
[[reko::returns(register, "ax")]]
word ReadWestwoodLzw14Code_0ED9(
    [[reko::arg(register, "si")]] word sourceOffset,
    [[reko::arg(out, register, "si")]] word nextSourceOffset);

[[reko::address("1A1F:0C33")]]
void SelectTacticalTextForegroundColor_0C33(void);

[[reko::address("1A1F:146E")]]
void AdvanceTacticalCursorCell_146E(void);

[[reko::address("1A1F:14E1")]]
void RetreatTacticalCursorCell_14E1(void);

[[reko::address("2007:079A")]]
void DrawTacticalCursorOutline_079A(word color);

[[reko::address("2007:07C9")]]
void DrawTacticalCellOutline_07C9(short leftX, short topY, word color);

[[reko::address("2007:0926")]]
void DrawClippedWeaponTraceLine_0926(
    short startX, short startY, short endX, short endY,
    word color, word dashedTrace);

[[reko::address("2007:0DDB")]]
void DrawTacticalEffectSprite_0DDB(
    word spriteId, short relativeX, short relativeY);

[[reko::address("375F:0100")]]
void WriteSoundBlasterDSPPort_0100(
    [[reko::arg(register, "ah")]] byte value,
    [[reko::arg(register, "dx")]] word writePort);

[[reko::address("375F:015B")]]
void WriteAdLibRegisterAtPort_015B(
    [[reko::arg(register, "ax")]] word registerAndValue,
    [[reko::arg(register, "dx")]] word registerPort);

[[reko::address("375F:0163")]]
void WriteAdLibDataAtPort_0163(
    [[reko::arg(register, "ah")]] byte value,
    [[reko::arg(register, "cx")]] word registerDelay,
    [[reko::arg(register, "dx")]] word registerPort);

[[reko::address("3621:0A7E")]]
void RestartTandyMIDIVoiceScan_0A7E(void);

[[reko::address("3621:0F55")]]
void WrapRolandMIDIQueueReadIndex_0F55(void);

[[reko::address("3621:0F57")]]
void CommitRolandMIDIQueueRead_0F57(
    [[reko::arg(register, "bx")]] word nextReadIndex);

[[reko::address("2B34:0FDB")]]
void DrawCenteredTextInActiveWindow_0FDB(
    const char __far *text,
    word rowOffset,
    word foregroundColor,
    word backgroundColor);

[[reko::address("1A1F:5E6D")]]
void SetTacticalSlotSpriteState_5E6D(
    word slotIndex,
    word requestedState);

[[reko::address("0800:0999")]]
void ClearTacticalEffectOverlayMap_0999(void);

[[reko::address("0800:2D37")]]
void FillRuntimeFarMemoryBytes_2D37(
    byte __far *destination,
    word byteCount,
    byte value);

[[reko::address("2007:0C6F")]]
void DrawActiveTextWindowBorder_0C6F(word color);

[[reko::address("2007:1219")]]
void BuildTacticalTerrainEffectOverlay_1219(void);

[[reko::address("2007:1D06")]]
void RefreshTacticalDisplay_1D06(word advanceEffects);

[[reko::address("2007:1D61")]]
void FormatUnitDurabilityPercentage_1D61(word unitIndex);

[[reko::address("0800:09BB")]]
void DrawCgaCompositeTacticalTile_09BB(
    word firstSpriteId,
    word secondSpriteId,
    const byte __far *spritePage,
    word destinationX,
    word destinationY);

[[reko::address("0800:0A2E")]]
void DrawCgaHighSpriteTile_0A2E(
    const byte __far *spritePage,
    word spriteId,
    word destinationX,
    byte destinationY);

[[reko::address("0800:116F")]]
void DrawTacticalTileSprite_116F(
    const byte __far *spritePage,
    word spriteId,
    word destinationX,
    word destinationY);

[[reko::address("0800:2483")]]
void DrawCompositeTacticalTile_2483(
    word firstSpriteId,
    word secondSpriteId,
    const byte __far *spritePage,
    word destinationX,
    word destinationY);

[[reko::address("0800:264B")]]
void CompositeEgaSpritePlane_264B(
    [[reko::arg(seq, "es", "di")]] byte __far *destination,
    [[reko::arg(register, "ah")]] byte sourceMask,
    [[reko::arg(register, "ch")]] byte planeIndex,
    [[reko::arg(register, "bx")]] word firstSpriteOffset,
    [[reko::arg(register, "si")]] word secondSpriteOffset,
    [[reko::arg(register, "ds")]] word spriteSegment);

[[reko::address("2007:1CBD")]]
void DrawTacticalTileSpriteForAdapter_1CBD(
    const byte __far *spritePage,
    word spriteId,
    word destinationX,
    word destinationY);

[[reko::address("2007:14DF")]]
void UpdatePrimaryUnitStatusRowHighlight_14DF(word rowIndex);

[[reko::address("2007:1544")]]
void UpdateSecondaryUnitStatusRowHighlight_1544(word rowIndex);

[[reko::address("3621:099E")]]
void SilenceTandyMIDIVoices_099E(
    [[reko::arg(register, "bx")]] word voiceRecordOffset,
    [[reko::arg(register, "cx")]] word voiceCount);

[[reko::address("3621:0BEE")]]
[[reko::returns(register, "al")]]
byte ProgramAdLibPatchOperator_0BEE(
    [[reko::arg(seq, "ds", "di")]] const byte __far *operatorPatch,
    [[reko::arg(register, "al")]] byte operatorRegister,
    [[reko::arg(register, "cl")]] byte voiceFlags);

[[reko::address("2B34:130C")]]
void BuildDamagedWeaponRangeFlags_130C(word unitIndex);

[[reko::address("2B34:140F")]]
void FlagDamagedWeaponRanges_140F(
    const byte __far *equipmentSlots, word slotCount);

[[reko::address("2B34:1014")]]
word PrepareDisplayedUnitCombatRatings_1014(word unitIndex);

[[reko::address("2B34:10F4")]]
void CalculateLanceAverageCombatRatings_10F4(
    word leaderUnitIndex, word useActualUnitData);

[[reko::address("2B34:11D2")]]
void BuildUndamagedUnitCombatEstimate_11D2(word unitIndex);

[[reko::address("2D1B:2AA6")]]
word HasTacticalReferencePointLineOfSightToUnit_2AA6(
    word referencePointIndex, word unitIndex);

[[reko::address("30F1:0A3F")]]
byte AssignScenarioLanceAllegiances_0A3F(word scenarioAllegianceIndex);

[[reko::address("2B34:04B5")]]
void RenderFormattedLineBreak_04B5(void);

[[reko::address("2B34:04C2")]]
void DrawTacticalUnitControlPanel_04C2(word unitIndex);

[[reko::address("2007:0328")]]
void DrawTacticalViewportCell_0328(
    short viewportColumn, short viewportRow, word viewportCellIndex);

[[reko::address("2007:0AA4")]]
void QueueTacticalProjectile_0AA4(
    word attackerUnitIndex, byte weaponIndex,
    word targetUnitIndex, word shotHit);

[[reko::address("1A1F:1586")]]
short ResolveUnitAtTacticalCursor_1586(void);

[[reko::address("1A1F:1732")]]
void MoveTacticalCursorByInput_1732(short inputCode);

[[reko::address("1A1F:18C9")]]
void OffsetWeaponTraceEndpoint_18C9(
    short __far *sourceX, short __far *sourceY,
    short __far *targetX, short __far *targetY);

[[reko::address("1A1F:1A83")]]
void AdvanceScenarioAreaEffects_1A83(void);

[[reko::address("1A1F:410C")]]
short MapUnitToTacticalStatusSlot_410C(word unitIndex);

[[reko::address("1A1F:49CC")]]
void KeepTacticalCursorOnSelectedUnit_49CC(void);

[[reko::address("1A1F:51C0")]]
void RefreshTacticalStatusSlotStates_51C0(void);

[[reko::address("1A1F:52F2")]]
void AdvanceTacticalCampaignClock_52F2(void);

[[reko::address("1A1F:5577")]]
void BuildScenarioTerrainDamageCapabilityMap_5577(word terrainEffectMode);

[[reko::address("1A1F:5D8A")]]
void ApplyScenarioMissileUpgradeAvailability_5D8A(void);

[[reko::address("2208:2224")]]
void DrawLanceFormationMarker_2224(
    short formationCode, word tileColumnOffset);

[[reko::address("2208:25F0")]]
void FormatTacticalMapCoordinates_25F0(word mapX, word mapY);

[[reko::address("2208:2A8A")]]
void HighlightLanceFollowers_2A8A(word leaderUnitIndex);

[[reko::address("1A1F:5755")]]
short TranslateTacticalMouseInput_5755(void);

[[reko::address("2208:000B")]]
void RunTacticalUnitCommandMenu_000B(word unitIndex);

[[reko::address("2208:148A")]]
void RunTacticalGameOptionsMenu_148A(void);

[[reko::address("2208:2B0E")]]
word ValidatePrimaryLanceLeader_2B0E(word unitIndex);

// Tactical asset selection recovered from direct filename-template writes.
[[reko::address("0D73:0214")]]
void InitializeTacticalScenario_0214(void);

[[reko::address("0D73:0387")]]
void RebuildTacticalVideoResources_0387(
    word adapterType, word showScenarioCompletion);

[[reko::address("0D73:329E")]]
void InstallVgaPaletteBankAnchors_329E(void);

[[reko::address("0D73:5789")]]
void ShowScenarioCompletionStatus_5789(void);

[[reko::address("1A1F:03D4")]]
void LoadTacticalIconSetResources_03D4(unsigned short iconSetNumber);

[[reko::address("1A1F:0468")]]
void LoadTacticalIconResource_0468(
    const char __far *resourcePath, unsigned short destinationPage);

[[reko::address("1A1F:0517")]]
void InvalidPreviousProcedureEpilogue_0517(void);

[[reko::address("1A1F:051B")]]
void LoadTacticalMap_051B(unsigned short mapNumber);

[[reko::address("0D73:324E")]]
void LoadScreenPalette_324E(unsigned short screenResourceIndex);

[[reko::address("0D73:4099")]]
void LoadGraphicsResourceToBuffers_4099(unsigned short resourceIndex,
    void __far *decodeBuffer, void __far *displayBuffer);

[[reko::address("0D73:4126")]]
void RebuildMouseCursorBackingBuffer_4126(void);

[[reko::address("0D73:35AA")]]
void PrepareMissionDateScreen_35AA(unsigned short presentationMode);

[[reko::address("0D73:365C")]]
void DrawMissionHeaderFrame_365C(void);

[[reko::address("0D73:376C")]]
void DisplayMissionDate_376C(short presentationMode, short blinkRegionIndex,
    unsigned short dateEntryIndex, unsigned short followupMessageIndex,
    unsigned short redrawPresentation);

[[reko::address("0D73:3AE4")]]
void ShowMissionFollowupMessage_3AE4(unsigned short messageIndex);

[[reko::address("0D73:4155")]]
void BuildMissionSpriteBackingBuffer_4155(unsigned short spriteLayoutIndex);

[[reko::address("2007:132C")]]
void DrawBeveledMenuButton_132C(unsigned short textColumn,
    unsigned short textRow, const char __far *text, unsigned short widthPixels);

[[reko::address("2507:0501")]]
short SelectUnitClass_0501(void);

[[reko::address("2507:0625")]]
short SelectUnitTypeFromList_0625(const byte __far *unitTypeIdList);

[[reko::address("2507:0A20")]]
void DrawUnitAllegianceHeader_0A20(word headerColorIndex);

[[reko::address("2507:26EE")]]
void DrawUnitRosterScreen_26EE(word useAlternateAssignmentLayout, word textColor);

[[reko::address("2507:483A")]]
void DrawUnitStatusScreen_483A(word statusPanelIndex, word redrawBackground,
    word displayMode, word showDetailedStats);

[[reko::address("2507:60D2")]]
void DrawRangeAndSpeedStatHeaders_60D2(word topY);

[[reko::address("2507:6111")]]
void DrawExperienceAndGunneryHeaders_6111(word topY);

[[reko::address("2507:623D")]]
void FreeGraphicsBufferRange_623D(short firstBufferIndex,
    short lastBufferIndex);

[[reko::address("0D73:4572")]]
short EnsureCompatibleSaveFile_4572(short fileHandle,
    const char __far *savePath, unsigned short openMode);

[[reko::address("0D73:4E9D")]]
short RunSaveLoadMenu_4E9D(unsigned short menuMode);

[[reko::address("0D73:4EC7")]]
short ShowSaveLoadMenu_4EC7(unsigned short menuMode);

[[reko::address("0D73:51F9")]]
unsigned short IsBlankSaveSlotName_51F9(const char __far *slotName);

[[reko::address("0D73:5233")]]
unsigned short RenameSaveSlot_5233(short slotIndex);

[[reko::address("0D73:53E1")]]
void WaitForAcknowledgement_53E1(void);

[[reko::address("0D73:546F")]]
short PromptYesNo_546F(unsigned short initialSelection);

// Borland far-heap allocator. The public entry points return their allocation
// in DX:AX; ES and flags at return are incidental implementation state.
[[reko::address("38CD:0002")]]
void __far *AllocateFarHeapBytes16(word byteCount);

[[reko::address("38CD:0017")]]
void UnlinkFarHeapFreeBlock_0017(void __far *blockHeader);

[[reko::address("38CD:007F")]]
void __far *SplitFarHeapFreeBlock_007F(
    void __far *blockHeader,
    unsigned long allocationSize);

[[reko::address("38CD:012F")]]
void __far *ExtendFarHeap_012F(unsigned long allocationSize);

[[reko::address("38CD:019D")]]
void __far *InitializeFarHeap_019D(unsigned long allocationSize);

[[reko::address("38CD:0203")]]
void __far *AllocateFarHeapBytes(unsigned long byteCount);

[[reko::address("398D:001E")]]
void InsertFarHeapFreeBlock_001E(void __far *blockHeader);

[[reko::address("398D:00BD")]]
void CoalesceFarHeapSuccessor_00BD(
    void __far *blockHeader,
    void __far *successorHeader);

[[reko::address("398D:0135")]]
void ReleaseFarHeapTail_0135(void);

[[reko::address("398D:021A")]]
void FreeAndCoalesceFarHeapBlock_021A(void __far *blockHeader);

[[reko::address("398D:02E6")]]
void FreeFarHeapAllocation(void __far *allocation);

// Borland/DOS file runtime recovered from the INT 21h calls and stack ABI.
[[reko::address("3915:0004")]]
short DOS_CreateFile(unsigned short attributes, const char __far *filePath);

[[reko::address("3915:0023")]]
void SetFileEndAtCurrentPosition(short fileHandle);

[[reko::address("3915:0037")]]
short CRT_OpenFile(
    const char __far *filePath,
    unsigned short openFlags,
    unsigned short creationMode);

[[reko::address("3934:0001")]]
short DOS_DeviceIOControl(
    unsigned short fileHandle,
    unsigned short operation,
    void __far *data,
    unsigned short count);

[[reko::address("3936:000E")]]
short CRT_CloseFile(short fileHandle);

// Westwood resource-file manager. A public handle is a ten-slot table index;
// the stored handle's high bit distinguishes a cached resource descriptor from
// a DOS file handle. DS:10B0 descriptors are 12h bytes each.
[[reko::address("3390:0002")]]
void AbortRuntimeWithMessage(const char __far *errorText);

[[reko::address("3390:0024")]]
void ShutdownAndExit(unsigned short exitCode);

[[reko::address("3390:0037")]]
short OpenTrackedFile(const char __far *path, unsigned short openMode);

[[reko::address("3390:0244")]]
void CloseTrackedFile(short handleSlot);

[[reko::address("3390:028C")]]
unsigned short ReadTrackedFile(short handleSlot, void __far *destination,
    unsigned long byteCount);

[[reko::address("3390:0372")]]
unsigned short WriteTrackedFile(short handleSlot, const void __far *source,
    unsigned long byteCount);

[[reko::address("3390:0441")]]
void SeekTrackedFile(short handleSlot, long distance, unsigned short origin);

[[reko::address("3390:061F")]]
unsigned short CanOpenFileForRead(const char __far *path);

// Common resource-file wrappers and Westwood compression dispatch.
[[reko::address("21E7:000C")]]
word ReadWholeResourceFile_000C(
    const char __far *resourceName, void __far *destination, word byteCount);

[[reko::address("21E7:0044")]]
void ReadResourceFileSpan_0044(
    const char __far *resourceName, long fileOffset,
    void __far *destination, word byteCount);

[[reko::address("21E7:008E")]]
void LoadAndDecodePackedResource_008E(
    const char __far *resourceName, void __far *compressedBuffer,
    void __far *destination);

[[reko::address("21E7:00F4")]]
void DecodeWestwoodPackedResource_00F4(
    const void __far *compressedBlock, void __far *destination);

[[reko::address("0800:0C34")]]
void CopyUncompressedFarBlock_0C34(
    const void __far *source, void __far *destination,
    unsigned long byteCount);

[[reko::address("0800:0D1A")]]
void DecodeWestwoodLzw12_0D1A(
    unsigned short compressedSegment, unsigned short destinationSegment,
    unsigned short dictionarySegment);

[[reko::address("0800:0E16")]]
void DecodeWestwoodLzw14_0E16(
    unsigned short compressedSegment, unsigned short destinationSegment,
    unsigned short dictionarySegment);

[[reko::address("0D73:32F4")]]
void LoadScreenAssetToWorkBuffer_32F4(word resourceIndex);

[[reko::address("34D5:000C")]]
void __far *CaptureVideoTileStrip_000C(
    const void __far *source, short startTileX,
    word startTileY, short tileCount);

[[reko::address("3390:0668")]]
unsigned short CanOpenFileForWrite(const char __far *path);

[[reko::address("3390:069C")]]
unsigned short GetResourceDriveMask(const char __far *path);

[[reko::address("3390:098C")]]
void ReleaseCachedResources(void);

[[reko::address("3390:0A22")]]
void InitializeResourceCache(void);

[[reko::address("3390:0BFF")]]
unsigned short IsResourceCached(const char __far *path);

[[reko::address("3390:0C86")]]
unsigned short FindResourceDescriptorIndex(const char __far *path);

[[reko::address("3390:0CF7")]]
unsigned short ReadCachedResource(unsigned short resourceIndex,
    void __far *destination, unsigned long requestedBytes);

[[reko::address("3939:000F")]]
short DOS_CloseFile(short fileHandle);

[[reko::address("394A:000A")]]
short WriteFileWithTextTranslation(
    short fileHandle,
    const unsigned char __far *buffer,
    unsigned short byteCount);

// Borland integer-to-string family. All three routines return the original
// destination in DX:AX. Decimal conversions are signed; other bases use the
// same bit pattern as an unsigned value and emit lowercase alphabetic digits.
[[reko::address("3968:0009")]]
char __far *FormatLongInteger(
    unsigned char alphabeticDigitBase,
    unsigned char signedConversion,
    unsigned short radix,
    char __far *destination,
    unsigned long value);

[[reko::address("3968:008D")]]
char __far *IntegerToString(
    short value,
    char __far *destination,
    unsigned short radix);

[[reko::address("3968:00DA")]]
char __far *LongToString(
    long value,
    char __far *destination,
    unsigned short radix);

[[reko::address("393C:0005")]]
short ReadFileWithTextTranslation(
    unsigned short fileHandle,
    unsigned char __far *buffer,
    unsigned short requestedBytes);

[[reko::address("39C4:0005")]]
long ParseSignedDecimalLong(const char __far *text);

[[reko::address("39DC:0009")]]
char __far *GetEnvironmentVariable(const char __far *name);

[[reko::address("3A3C:0008")]]
void InitializeTimezoneFromEnvironment(void);

[[reko::address("3329:000E")]]
void CopyClippedVideoRegion_000E(
    short sourceX,
    short sourceY,
    short destinationX,
    short destinationY,
    unsigned short widthColumns,
    unsigned short heightPixels,
    unsigned char __far *source,
    unsigned char __far *destination);

// Software-cursor positioning. The lock-free worker receives coordinates in
// CX/DX; its public wrappers use the ordinary far C stack ABI.
[[reko::address("0800:398C")]]
void SetMouseCursorPositionUnlocked_398C(
    [[reko::arg(register, "cx")]] short x,
    [[reko::arg(register, "dx")]] short y);

[[reko::address("0800:39FB")]]
void SetMouseCursorPosition_39FB(short x, short y);

[[reko::address("0800:3A23")]]
void MoveMouseCursorRelative_3A23(short deltaX, short deltaY);

// Fixed-font and context-managed text rendering.
[[reko::address("0800:470B")]]
void DrawTextString_470B(
    const char __far *text,
    unsigned short x,
    unsigned short y,
    unsigned char foregroundColor,
    unsigned char backgroundColor);

[[reko::address("3338:0009")]]
void SelectTextWindow_0009(unsigned short windowIndex);

[[reko::address("356F:000B")]]
void RenderTextToActiveWindow_000B(
    char __far *text,
    unsigned short advanceToNextLine);

// Adapter-dispatched encoded-sprite renderer using TextWindowContexts_063A as
// clipping geometry.
[[reko::address("0D73:566E")]]
void DrawClippedSprite_566E(
    unsigned char __far *destination,
    const unsigned char __far *sprite,
    short x,
    short y,
    unsigned short clippingRegionIndex);

[[reko::address("0D73:3F57")]]
void DrawLeftAlignedClippedText_3F57(
    const char __far *sourceText,
    unsigned short x,
    unsigned short y,
    unsigned short maximumWidth,
    unsigned char foregroundColor,
    unsigned char backgroundColor);

[[reko::address("0D73:3FF2")]]
void DrawRightAlignedClippedText_3FF2(
    const char __far *sourceText,
    unsigned short leftX,
    unsigned short y,
    unsigned short maximumWidth,
    unsigned char foregroundColor,
    unsigned char backgroundColor);

[[reko::address("0D73:3E35")]]
void DrawCenteredClippedText_3E35(
    const char __far *sourceText,
    unsigned short splitIndex,
    unsigned short leftX,
    unsigned short y,
    unsigned short maximumWidth,
    unsigned char foregroundColor,
    unsigned char backgroundColor);

[[reko::address("0D73:41E8")]]
void RemoveLeadingSpacesFrom_41E8(
    char __far *text,
    unsigned short oneBasedStart);

[[reko::address("0D73:4238")]]
void TrimTrailingEncodedSpaces_4238(char __far *text);

[[reko::address("0D73:418E")]]
void RightAlignStringField_418E(char __far *text, word fieldWidth);

[[reko::address("0D73:4288")]]
void TranslateCharactersInPlace_4288(
    char __far *text,
    const char __far *sourceAlphabet,
    const char __far *replacementAlphabet);

[[reko::address("0D73:42E4")]]
void PadStringToWidth_42E4(char __far *text, word width);

[[reko::address("0D73:4317")]]
word EditTextField_4317(
    word maximumLength,
    const char __far *initialText,
    byte allowedCharacterClasses);

[[reko::address("0D73:454A")]]
void FillTextEntryBuffer_454A(word length, byte fillCharacter);

// Music-resource staging and playback controller.
[[reko::address("3014:000E")]] void DisableMusicPlayback_000E(void);
[[reko::address("3014:001A")]] void EnableMusicPlayback_001A(void);
[[reko::address("3014:0117")]] void AllocateMusicStagingBuffer_0117(void);
[[reko::address("3014:0153")]] void StartLoadedMusicTrack_0153(void);
[[reko::address("3014:0185")]] void StopLoadedMusicTrack_0185(void);
[[reko::address("3014:0197")]] void LoadMusicResource_0197(word resourceIndex);
[[reko::address("3014:01F5")]] void PlayMusicResource_01F5(word resourceIndex);

// Shared timer and PC-speaker weapon-effect stream controller.
[[reko::address("30AF:002E")]]
void RequestPCSpeakerEffectStop_002E(void);

[[reko::address("30B2:00DF")]]
void DecodePCSpeakerEffectTick_00DF(void);

[[reko::address("30B2:03B6")]]
void StartPCSpeakerEffectStream_03B6(const byte __far *effectStream);

[[reko::address("30B2:03E1")]]
void RequestPCSpeakerEffectStop_03E1(void);

[[reko::address("3037:078C")]]
void PlayPCSpeakerEffectByIndex_078C(word effectId);

[[reko::address("31FB:0567")]]
void DispatchWeaponEffect_0567(short weaponEffectId);

// Campaign and menu lifecycle recovered from segment 0D73.
[[reko::address("0D73:0006")]] void RunCampaignLoop_0006(void);
[[reko::address("0D73:2414")]] word ConfirmExitToDos_2414(void);
[[reko::address("0D73:242E")]] word ConfirmRestartGame_242E(void);
[[reko::address("0D73:2448")]] word ShowConfirmationDialog_2448(const char __far *message);
[[reko::address("0D73:25F5")]] word RunMainMenuSelection_25F5(const char __far * __far *menuOptionText);
[[reko::address("0D73:274D")]] short RunInGameMenu_274D(short firstMenuOption);
[[reko::address("0D73:2A5D")]] void OpenModalTextWindow_2A5D(word windowIndex, word clearAndFrame);
[[reko::address("0D73:2AEE")]] void RestoreModalTextWindow_2AEE(void);
[[reko::address("0D73:2E7C")]] void ShowScenarioMessage_2E7C(word messageIndex);
[[reko::address("0D73:2F16")]] word PlayTitleTextSequence_2F16(void);
[[reko::address("0D73:2F5F")]] word AnimateTitleTextLine_2F5F(const char __far *text);
[[reko::address("0D73:309C")]] short RunTitleAndMainMenu_309C(void);

// Options-menu controller and its UI-region selection wrapper.
[[reko::address("1A1F:417F")]]
word RunGameOptionsMenu_417F(word embeddedMode);

[[reko::address("1A1F:5D5E")]]
short RunOptionsMenuSelection_5D5E(short firstRegionIndex);
[[reko::address("0D73:33C1")]] void LoadAndPresentScreen_33C1(word resourceIndex);
[[reko::address("0D73:341F")]] word PresentScreenAndMessage_341F(word screenResourceIndex, word messageIndex);
[[reko::address("0D73:3C7C")]] word FlushInputAndWait_3C7C(word timeoutRetraces);
[[reko::address("0D73:3C97")]] word WaitForDismissInputOrTimeout_3C97(word timeoutRetraces);
[[reko::address("0D73:3DA9")]] void UpdateTextEntryCursorBlink_3DA9(void);
[[reko::address("0D73:3E1E")]] void FlushPendingInput_3E1E(void);

[[reko::address("31FB:058D")]]
void PlayDigitalWeaponEffect_058D(word weaponEffectId);

[[reko::address("31FB:06E9")]]
void HandleDigitalWeaponEffectCompletion_06E9(
    word descriptorOffset, word descriptorSegment);

// Context-managed text-window composition.
[[reko::address("3349:0009")]]
void SelectAndClearTextWindow_0009(word windowIndex);

[[reko::address("334A:000C")]]
void WaitVerticalRetraces_000C(word retraceCount);

[[reko::address("334D:0001")]]
void DrawActiveTextWindowFrame_0001(word frameStyleIndex);

[[reko::address("3386:0008")]]
word DrawRepeatingFrameTileSequence_0008(
    const word __far *frameDefinition,
    word sequenceIndex,
    short x,
    short y,
    word tileCount,
    word horizontal);

[[reko::address("356D:0006")]]
void ClearActiveTextWindow_0006(void);

// The digital-sound table contains 16h fixed 0Bh-byte records.
[[reko::address("31FB:0256")]]
short FindDigitalSoundEntryByCode_0256(byte soundCode);

[[reko::address("31FB:0297")]]
void LoadScenarioDigitalSoundBank_0297(signed char scenarioCode);

[[reko::address("0800:14B7")]]
void DrawCgaTandyEncodedSprite_14B7(
    unsigned char __far *destination,
    const unsigned char __far *encodedSprite,
    short x,
    short y);

[[reko::address("0800:2683")]]
void CopyBufferToVideoRegion_2683(
    short xColumn, word yCharacterRow, word widthColumns,
    word heightCharacterRows, const byte __far *source);

[[reko::address("0800:2835")]]
void CopyVideoRegionToBuffer_2835(
    short xColumn, word yCharacterRow, word widthColumns,
    word heightCharacterRows, byte __far *destination);

[[reko::address("0800:29D5")]]
void DrawHorizontalVideoRun_29D5(
    word x, word y, word nativeRunLength, byte color);

[[reko::address("0800:2B00")]]
void CopyVideoRegion_2B00(
    short sourceX, short sourceY, short destinationX, short destinationY,
    word width, word height, const byte __far *source,
    byte __far *destination);

[[reko::address("0800:2DB0")]]
void FillVideoRectangle_2DB0(
    short x, word y, word width, word height, byte color);

[[reko::address("0800:2F05")]]
void Draw8x8VideoTile_2F05(
    const byte __far *tilePixels, short x, word y);

[[reko::address("0800:50A1")]]
void DrawVgaRleSprite_50A1(
    unsigned char __far *destination,
    const unsigned char __far *encodedSprite,
    short x,
    short y);

[[reko::address("34E6:0003")]]
short PollUiRegionSelection_0003(short firstRegionIndex, unsigned short regionCount);

[[reko::address("35AB:000B")]]
void BeginUiRegionSelection_000B(short firstRegionIndex, unsigned short regionCount);

[[reko::address("3599:0009")]]
void HighlightUiRegionSelection_0009(short regionIndex);

[[reko::address("3596:0004")]]
void SetActiveRenderTarget_0004(unsigned char __far *renderTarget);

[[reko::address("3593:0008")]]
void SelectResourceDrive_0008(short resourceDriveIndex);

[[reko::address("3568:0007")]]
short RunUiRegionSelectionLoop_0007(short firstRegionIndex, unsigned short regionCount);

[[reko::address("358E:000C")]]
void RunSingleUiRegionSelection_000C(short regionIndex);

[[reko::address("35CA:0009")]]
void ToggleActiveUiRegionHighlight_0009(void);

[[reko::address("3365:0007")]]
void DrawHorizontalSpan_0007(
    short y,
    short startX,
    short endX,
    unsigned short color);

[[reko::address("3365:0157")]]
void DrawClippedPixel_0157(short x, short y, unsigned short color);

[[reko::address("3495:000B")]]
void Capture8x8VideoTile_000B(
    unsigned char __far *framebuffer,
    unsigned char __far *destination,
    short tileX,
    unsigned short tileY);

// Borland far-string runtime helpers. Their REPNE SCASB / REP MOVSB / REPE
// CMPSB implementations are exact analogues of strcpy, strcat, strcmp, and
// strncpy operating on 16:16 far pointers.
[[reko::address("397A:0001")]]
char __far *FarStringConcat(char __far *destination, const char __far *source);

[[reko::address("397F:000E")]]
short FarStringCompare(const char __far *left, const char __far *right);

[[reko::address("3983:0000")]]
char __far *FarStringCopy(char __far *destination, const char __far *source);

[[reko::address("39F4:000D")]]
char __far *FarStringNCopy(
	char __far *destination,
	const char __far *source,
	unsigned short maximumLength);

// Borland far-memory fill. The internal worker aligns ES:DI before using
// REP STOSW; the public wrapper presents the conventional value/count order.
[[reko::address("3985:0009")]]
void FillFarMemoryBytes(
    unsigned char __far *destination,
    unsigned short byteCount,
    unsigned char value);

[[reko::address("3985:002F")]]
void FarMemorySet(
    unsigned char __far *destination,
    unsigned char value,
    unsigned short byteCount);

// Assembly-verified procedure contracts. Keep ordinary C stack arguments here
// and keep ambient segment state in the dcproject's registerValues section.
// This avoids both inferred DS parameters and duplicate procedure keys.

[[reko::address("0800:32ED")]]
void RepackCgaAlternateScanlines_32ED(unsigned char __far *screenBuffer);

[[reko::address("0800:3327")]]
void FillTandyPackedRectangle_3327(
    short leftX,
    short topY,
    unsigned short packedWidthMinusOne,
    short heightMinusOne,
    unsigned char color);

[[reko::address("0800:34F8")]]
void InitializeCgaPixelTranslationTables_34F8(
    const unsigned char __far *seedTable);

[[reko::address("0800:35D8")]]
void ConvertCgaPackedPixelsAndBuildMask_35D8(
    unsigned char __far *buffer,
    unsigned short narrowStrideMode);

[[reko::address("0800:3571")]]
void ConvertCgaPackedPixels_3571(
    const unsigned char __far *source,
    unsigned char __far *destination,
    unsigned char phaseRunLength,
    unsigned short outputByteCount);

[[reko::address("0800:4D81")]]
void DOS_SelectDefaultDrive(unsigned char zeroBasedDrive);

[[reko::address("0800:4D98")]]
void BIOS_SelectCgaPalette(unsigned char paletteId);

// Near register-call helper used only by DecodeRLEBlock_0C9A. DX:BX is the
// remaining decoded byte count, CX is the run length, and ES:DI is normalized
// in place without changing the physical destination address.
[[reko::address("0800:0CF9")]]
[[reko::returns(seq, "dx", "bx")]]
unsigned long __near PrepareRLEOutputRun_0CF9(
    [[reko::arg(seq, "dx", "bx")]] unsigned long remainingOutputBytes,
    [[reko::arg(register, "cx")]] word runLength,
    [[reko::arg(register, "di")]] word destinationOffset,
    [[reko::arg(register, "es")]] word destinationSegment,
    [[reko::arg(out, register, "di")]] word normalizedOffset,
    [[reko::arg(out, register, "es")]] word normalizedSegment);

// Near carry-chain helper used by ConvertPackedPixelsToEGAPlanar_3498. AL is
// shifted four places while the four carry bits are accumulated in DH, DL, BH,
// and BL. The updated plane accumulators leave in DX and BX.
[[reko::address("0800:34E3")]]
[[reko::returns(register, "al")]]
byte __near ShiftPackedPixelsIntoEGAPlanes_34E3(
    [[reko::arg(register, "al")]] byte packedPixels,
    [[reko::arg(register, "dx")]] word plane32Accumulators,
    [[reko::arg(register, "bx")]] word plane10Accumulators,
    [[reko::arg(out, register, "dx")]] word updatedPlane32Accumulators,
    [[reko::arg(out, register, "bx")]] word updatedPlane10Accumulators);

[[reko::address("1A1F:10CD")]]
void LoadUnitTemplateRecord_10CD(short unitType);

[[reko::address("1A1F:19FD")]]
void CreateRandomAreaImpact_19FD(
    short centerX,
    short centerY,
    word chanceDenominator);

[[reko::address("1A1F:4857")]]
void SwapUnitRouteWaypoint_4857(word unitIndex, word waypointIndex);

[[reko::address("1A1F:4923")]]
void QueueRandomMapEdgeEffect_4923(short centerX, short centerY);

[[reko::address("1A1F:5476")]]
word HasNarrationMessage_5476(word narrationSubject, word messageCategory);

[[reko::address("1A1F:5525")]]
void QueueLinkedUnitStatusNarration_5525(word unitIndex);

[[reko::address("2007:01EE")]]
void DrawTileAlignedText_01EE(
    char __far *text,
    word tileX,
    word tileY,
    byte foregroundColor,
    byte backgroundColor);

[[reko::address("2007:08D5")]]
void QueueMapEdgeEffect_08D5(
    short mapX,
    short mapY,
    word baseSpriteId,
    word edgeDirection);

[[reko::address("2007:0846")]]
void QueueTacticalImpactVisual_0846(
    short mapX,
    short mapY,
    word impactClass);

[[reko::address("2007:042A")]]
void AdvanceTerrainEffects_042A(word advanceEffects);

[[reko::address("2007:0CFB")]]
void ApplyAreaTerrainAndUnitDamage_0CFB(
    short mapX,
    short mapY,
    word visualEffectType,
    short weaponIndex);

[[reko::address("2D1B:276F")]]
void ApplyTerrainImpact_276F(
    short mapX,
    short mapY,
    word advanceBeforeRecording,
    word forceAnimationRecord);

[[reko::address("2D1B:2AF3")]]
void CollapseStructureAtMapCell_2AF3(
    short mapX,
    short mapY,
    word terrainType);

[[reko::address("2007:15FF")]]
void DrawCampaignClock_15FF(void);

[[reko::address("2007:1DCC")]]
void DrawCampaignClockSeparator_1DCC(void);

[[reko::address("0800:540B")]]
[[reko::returns(flag, "Z")]]
byte CompareNormalizedFarPointers(
    [[reko::arg(seq, "dx", "ax")]] const void __far *left,
    [[reko::arg(seq, "cx", "bx")]] const void __far *right);

[[reko::address("0800:53B0")]]
[[reko::returns(seq, "dx", "ax")]]
void __far *AddSignedOffsetToFarPointer(
    [[reko::arg(seq, "dx", "ax")]] const void __far *pointer,
    [[reko::arg(seq, "cx", "bx")]] long displacement);

// Borland brk/sbrk layer beneath the far-heap allocator.
[[reko::address("38FE:0002")]]
word ResizeProgramBreak_0002(void __far *newBreak);

[[reko::address("38FE:0092")]]
short SetProgramBreak(void __far *newBreak);

[[reko::address("38FE:00D9")]]
void __far *AdjustProgramBreak(long increment);

// Tactical icon resource and sprite helpers recovered from the new segments.
[[reko::address("34B3:0008")]]
void LoadPackedIconResource_0008(
    const char __far *resourcePath,
    byte __far *packedDisplayBuffer);

// Tactical overview-map rendering. These routines consume the resident DS
// state directly; DS is not a C stack argument in the original 16-bit ABI.
[[reko::address("0800:0B07")]]
void PlotPixel_0B07(word x, word y, word color);

[[reko::address("24C5:012E")]]
void RefreshTacticalOverview_012E(void);

[[reko::address("24C5:02F1")]]
void DrawTacticalOverviewViewportFrame_02F1(void);

[[reko::address("24C5:037F")]]
void DrawTacticalOverviewMap_037F(void);

[[reko::address("24C5:0401")]]
void ExitTacticalOverview_0401(void);

[[reko::address("1A1F:182E")]]
void ScrollTacticalViewportToCursor_182E(void);

[[reko::address("2007:16BA")]]
void RedrawTacticalStatusPanel_16BA(void);

[[reko::address("2208:26B1")]]
short CompareLanceCombatRatings_26B1(word firstUnitIndex, short secondUnitIndex);

[[reko::address("2208:2853")]]
word HasActiveLanceFollowers_2853(word unitIndex);

[[reko::address("2D1B:2604")]]
void BuildArmWeaponAvailabilityMasks_2604(word unitIndex);

[[reko::address("2D1B:296F")]]
void QueueLanceOrderNarration_296F(word unitIndex);

[[reko::address("2D1B:2C23")]]
void AdvanceUnitRouteWaypoint_2C23(word unitIndex);

[[reko::address("35C2:000B")]]
void CopyDecodedIconPage_000B(
    const byte __far *packedDisplayBuffer,
    byte __far *iconPageDestination);

[[reko::address("34DF:0003")]]
void LoadPackedIconPageDirect_0003(
    const char __far *resourcePath,
    byte __far *packedDisplayBuffer,
    byte __far *iconPageDestination);

[[reko::address("3005:0008")]]
void DrawTacticalClippedSprite_0008(
    byte __far *renderTarget,
    const byte __far *encodedSprite,
    short relativeX,
    short relativeY,
    word textWindowIndex);

[[reko::address("0800:33D6")]]
void DecodeLinearRleScreen_33D6(
    const byte __far *compressedData,
    byte __far *destination);

[[reko::address("0800:342D")]]
void DecodeColumnMajorRleScreen_342D(
    const byte __far *compressedData,
    byte __far *destination);

// Register-call PIT/interrupt primitives. These do not use the C stack ABI.

[[reko::address("38AE:0010")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long SwapInterruptVector_0010(
    [[reko::arg(seq, "dx", "ax")]] unsigned long newVector,
    [[reko::arg(register, "bx")]] word interruptNumber);

[[reko::address("38AE:002A")]]
[[reko::returns(register, "ax")]]
word SetPITChannel0Divisor_002A(
    [[reko::arg(register, "ax")]] word divisor);

[[reko::address("38AE:0046")]]
[[reko::returns(register, "ax")]]
word PITFrequencyToDivisor_0046(
    [[reko::arg(register, "ax")]] word frequencyHz);

[[reko::address("38AE:005C")]]
void BeginPITCalibration_005C(void);

[[reko::address("38AE:009B")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long EndPITCalibration_009B(void);

[[reko::address("38AE:00D7")]]
void PITCalibrationIRQ0Handler_00D7(void);

[[reko::address("38AE:00F6")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long DivideUnsigned32By32_00F6(
    [[reko::arg(seq, "dx", "ax")]] unsigned long dividend,
    [[reko::arg(seq, "cx", "bx")]] unsigned long divisor);

[[reko::address("375F:07ED")]]
void ConfigureDigitalSampleLoop_07ED(
    void __far *descriptor, word loopStart, word loopEnd);

[[reko::address("375F:06D5")]]
void InitializeDigitalDriverQueueCore_06D5(
    [[reko::arg(seq, "es", "di")]] void __far *queue);

[[reko::address("375F:070C")]]
void InstallDigitalDriverQueueCallback_070C(
    [[reko::arg(register, "bx")]] word playbackDescriptorOffset,
    [[reko::arg(seq, "es", "di")]] void __far *queue);

[[reko::address("375F:0757")]]
void InitializeDigitalSampleDescriptorCore_0757(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor,
    [[reko::arg(register, "ax")]] word sampleLength,
    [[reko::arg(register, "cx")]] word playbackScale,
    [[reko::arg(register, "dx")]] word sourceRateHz,
    [[reko::arg(seq, "es", "di")]] byte __far *sampleData);

[[reko::address("375F:07A2")]]
void CalculateDigitalSampleStep_07A2(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor,
    [[reko::arg(register, "ax")]] word playbackScale);

[[reko::address("375F:0805")]]
[[reko::returns(register, "dx")]]
word SetDigitalSampleLoopRange_0805(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor,
    [[reko::arg(register, "ax")]] word loopStart,
    [[reko::arg(register, "dx")]] word loopEnd);

[[reko::address("375F:0814")]]
void ConfigureDigitalSampleCompletion_0814(
    void __far *descriptor, void __far *completionCallback,
    word argumentLow, word argumentHigh);

[[reko::address("375F:0832")]]
void SetDigitalSampleCompletionCallback_0832(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor,
    [[reko::arg(register, "ax")]] word argumentLow,
    [[reko::arg(register, "dx")]] word argumentHigh,
    [[reko::arg(seq, "es", "di")]] void __far *completionCallback);

[[reko::address("375F:0868")]]
void LinkDigitalSampleDescriptor_0868(
    [[reko::arg(seq, "es", "di")]] void __far *queue,
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor);

[[reko::address("375F:08C9")]]
void UnlinkDigitalSampleDescriptor_08C9(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor);

[[reko::address("375F:0927")]]
void ResetDigitalSamplePlayback_0927(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor);

[[reko::address("375F:095A")]]
void FinishDigitalSampleLoop_095A(void __far *descriptor);

[[reko::address("375F:096A")]]
void FinishDigitalSampleLoopCore_096A(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor);

[[reko::address("375F:0986")]]
void StopDigitalSamplePlayback_0986(void __far *descriptor);

[[reko::address("375F:0993")]]
void StopDigitalSamplePlaybackCore_0993(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor);

[[reko::address("375F:09A9")]]
[[reko::returns(register, "ax")]]
short ReadDigitalSamplePlaybackState_09A9(
    [[reko::arg(seq, "ds", "si")]] void __far *descriptor);

[[reko::address("375F:09C6")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long SetDigitalPlaybackTimingScale_09C6(word timingScale);

[[reko::address("375F:09CC")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long ApplyDigitalMixScale_09CC(
    [[reko::arg(register, "ax")]] word timingScale);

// Do not declare BIOS Data Area addresses (0040:xxxx) as metadata globals.
// They are valid real-mode addresses but lie outside REVENGE.EXE's image;
// Reko 0.12.4 aborts scanning when it tries to install them as program globals.
// The corresponding "Selector 0040 has no known segment" diagnostics are
// preferable to terminating discovery of the remaining procedures.

// MEDIA.CFG option records are 10h bytes: a twelve-byte key followed by a
// far callback. InitializeGame scans exactly four records.
typedef word (__far *ConfigOptionHandler)(void);
typedef struct ConfigOptionHandlerRecord {
    char optionName[12];
    ConfigOptionHandler handler;
} ConfigOptionHandlerRecord;

[[reko::address("0800:0F74")]]
void PackLowNibblesTo4Bpp_0F74(const byte __far *source, byte __far *destination);

[[reko::address("0800:2EC8")]]
void CopyFarBytes32_2EC8(
    const void __far *source,
    void __far *destination,
    unsigned long byteCount);

[[reko::address("0800:54E8")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long ShiftLeft32_DXAX_54E8(
    [[reko::arg(register, "ax")]] word valueLow,
    [[reko::arg(register, "cl")]] byte shiftCount,
    [[reko::arg(register, "dx")]] word valueHigh);

[[reko::address("0800:0C87")]]
[[reko::returns(seq, "dx", "ax")]]
void __far *NormalizeSegmentOffset_0C87(
    [[reko::arg(register, "ax")]] word offset,
    [[reko::arg(register, "dx")]] word segment);

[[reko::address("0800:3B9E")]]
[[reko::returns(seq, "dx", "ax")]]
void __far *NormalizeFarPointer_3B9E(word offset, word segment);

[[reko::address("0800:542C")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long MultiplyUnsignedLong_542C(
    [[reko::arg(register, "ax")]] word leftLow,
    [[reko::arg(register, "cx")]] word rightHigh,
    [[reko::arg(register, "dx")]] word leftHigh,
    [[reko::arg(register, "bx")]] word rightLow);

[[reko::address("0800:5445")]]
unsigned long DivideUnsignedLong_5445(
    unsigned long dividend,
    unsigned long divisor);

[[reko::address("0800:5507")]]
[[reko::returns(seq, "dx", "ax")]]
unsigned long ShiftRight32_DXAX_5507(
    [[reko::arg(register, "ax")]] word valueLow,
    [[reko::arg(register, "cl")]] byte shiftCount,
    [[reko::arg(register, "dx")]] word valueHigh);

[[reko::address("0800:5526")]]
[[reko::returns(seq, "dx", "ax")]]
long CalculateFarPointerByteDistance_5526(
    [[reko::arg(register, "ax")]] word endOffset,
    [[reko::arg(register, "cx")]] word startSegment,
    [[reko::arg(register, "dx")]] word endSegment,
    [[reko::arg(register, "bx")]] word startOffset);

[[reko::address("0800:554B")]]
void CopyFarMemory(
    [[reko::arg(register, "cx")]] word byteCount,
    const byte __far *source,
    byte __far *destination);

[[reko::address("3390:0DFC")]]
void AdjustActiveTextWindowMargin_0DFC(word marginTiles);

[[reko::address("38C6:0010")]]
void RunExitHandlersAndTerminate_0010(word exitCode);

[[reko::address("39CC:000F")]]
void CaptureLocalClockSnapshot_000F(void __far *snapshot);
[[reko::address("3A07:0001")]] unsigned long ConvertLocalDateTimeToEpochSeconds_0001(const void __far *date, const void __far *time);
[[reko::address("3A3C:01ED")]] unsigned short IsDaylightSavingTime_01ED(unsigned short yearsSince1970, unsigned short month, unsigned short dayOrDayOfYear, unsigned char hour);
[[reko::address("3948:000A")]] short DOS_ReadFile(unsigned short fileHandle, void __far *destinationBuffer, unsigned short byteCount);
[[reko::address("3961:0000")]] short DOS_WriteFile(unsigned short fileHandle, const void __far *sourceBuffer, unsigned short byteCount);
[[reko::address("3989:000E")]] short DOS_GetSetFileAttributes(const char __far *filePath, unsigned char operation, unsigned short attributes);

[[reko::address("1A1F:141E")]] unsigned short SelectNextUnitAtCursor_141E(void);
[[reko::address("1A1F:1491")]] unsigned short SelectPreviousUnitAtCursor_1491(void);
[[reko::address("1A1F:1504")]] unsigned short FindUnitAtTacticalCursor_1504(void);
[[reko::address("1A1F:1697")]] void OpenTacticalUnitControlPanel_1697(unsigned short unitIndex);
[[reko::address("1A1F:1C27")]] unsigned short IsTacticalFunctionKey_1C27(short inputAction);
[[reko::address("1A1F:4447")]] void RenderPendingNarration_4447(void);
[[reko::address("1A1F:4A9E")]] void HandleTacticalInput_4A9E(short inputAction);
[[reko::address("1A1F:4C3D")]] void SetTacticalGameSpeed_4C3D(unsigned short digitKey);
[[reko::address("1A1F:4CC6")]] void HandleTacticalFunctionKey_4CC6(unsigned short inputAction);
[[reko::address("1A1F:4FA6")]] void ShowPendingNarrationPrompt_4FA6(void);
[[reko::address("1A1F:5154")]] void OpenSelectedTacticalUnitPanel_5154(void);
[[reko::address("2007:0007")]] void ComposeTacticalSpriteMaps_0007(void);
[[reko::address("2007:021A")]] void StampTacticalSpriteRectangle_021A(short mapX, short mapY, unsigned short widthCells, unsigned short heightCells, unsigned short firstSpriteId);

[[reko::address("3A6A:3A91")]]
ConfigOptionHandlerRecord ConfigOptionHandlerTable_3A91[4];

// Reko 0.12.4 infers Borland's stored offset:segment pair as an internal
// MemberPointer, whose global-data scanner and C writer are not implemented.
// Describe the physical representation instead.  This remains semantically a
// far pointer, but scanning it as two value fields avoids the MemberPointer
// visitor while retaining both halves and their byte order.
typedef struct FarAddress16 {
    word offset;
    word segment;
} FarAddress16;

[[reko::address("2A6A:84C1")]]
FarAddress16 ActiveFontResource_84C1;

// Music driver selector consumed by the five-way dispatch at 3014:0049.
// Like the adjacent active-font pointer, Reko's image-global address is based
// on 2A6A even though generated instructions access it through runtime DS=3A6A.
[[reko::address("2A6A:85AF")]] byte MusicDriverIndex_85AF;

// Fixed video lookup tables.
[[reko::address("0800:12B1")]] byte VideoMaskTable_12B1[256];
[[reko::address("0800:13B1")]] byte VideoMergeTable_13B1[256];
[[reko::address("0800:3BF6")]] word FourColorPlaneMaskTable_3BF6[4];
[[reko::address("0800:3BFE")]] word SixteenColorPlaneMaskTable_3BFE[16];

// Scratch state used by the tactical terrain-map builder at 0800:05D3.
// These are scalar CS words; in particular 05CD is a byte offset held in BX,
// not a pointer-sized global.
[[reko::address("0800:05C9")]] word PackedTerrainDamageMask_05C9;
[[reko::address("0800:05CB")]] word TacticalViewportRowsRemaining_05CB;
[[reko::address("0800:05CD")]] word PackedTerrainDamageRowOffset_05CD;
[[reko::address("0800:05CF")]] word PackedTerrainDamageRowStride_05CF;
[[reko::address("0800:05D1")]] word TerrainTypeRowAdvance_05D1;

[[reko::address("0800:01C9")]]
const byte DamagedTerrainSpriteLookup_01C9[768];

[[reko::address("4184:08D3")]]
const byte __far *DamagedTerrainSpriteLookup_08D3;

[[reko::address("4184:0901")]] word TacticalMapRowWidth_0901;

[[reko::address("3A6A:833E")]] word CurrentUnitDurabilityTotal_833E;
[[reko::address("3A6A:86BB")]] word MaximumUnitDurabilityTotal_86BB;
[[reko::address("3A6A:86BE")]] byte TerrainLineOfSightBlockingThreshold_86BE;
[[reko::address("3A6A:86C0")]] byte TerrainLineOfSightMaximumSteps_86C0;
[[reko::address("3A6A:8823")]] word __far *TacticalCellTerrainMap_8823;
[[reko::address("3A6A:99BC")]] word __far *TacticalCellSpriteMap_99BC;
[[reko::address("0800:3C2F")]] word VideoWidthRoutineOffsetTable_3C2F[24];
[[reko::address("0800:4007")]] word ByteToPlanarMaskTable_4007[256];
[[reko::address("0800:4207")]] word NibbleToPlanarMaskTable_4207[16];

// Generated at startup from the 20h-byte packed-pixel seed table.  The two
// 100h-byte tables translate alternating packed pixels into planar values.
[[reko::address("4184:0BD5")]] byte EvenPixelPlanarLookup_0BD5[256];
[[reko::address("4184:0CD5")]] byte OddPixelPlanarLookup_0CD5[256];
[[reko::address("4184:0DD5")]] byte PackedPixelSeedTable_0DD5[32];

// DS:24F4 contains these 16h far handlers in campaign-stage order.  The
// dispatcher supplies no stack arguments and consumes signed AX on return.
// Stage-index names remain provisional until their recovered bodies are
// traced against the scenario/story resources.
[[reko::address("0D73:0448")]] short RunCampaignStage00_0448(void);
[[reko::address("0D73:0633")]] short RunCampaignStage01_0633(void);
[[reko::address("0D73:071A")]] short RunCampaignStage02_071A(void);
[[reko::address("0D73:07F9")]] short RunCampaignStage03_07F9(void);
[[reko::address("0D73:0883")]] short RunCampaignStage04_0883(void);
[[reko::address("0D73:092E")]] short RunCampaignStage05_092E(void);
[[reko::address("0D73:0B15")]] short RunCampaignStage06_0B15(void);
[[reko::address("0D73:0BC8")]] short RunCampaignStage07_0BC8(void);
[[reko::address("0D73:0C2B")]] short RunCampaignStage08_0C2B(void);
[[reko::address("0D73:1099")]] short RunCampaignStage09_1099(void);
[[reko::address("0D73:1212")]] short RunCampaignStage10_1212(void);
[[reko::address("0D73:1302")]] short RunCampaignStage11_1302(void);
[[reko::address("0D73:1400")]] short RunCampaignStage12_1400(void);
[[reko::address("0D73:155F")]] short RunCampaignStage13_155F(void);
[[reko::address("0D73:171E")]] short RunCampaignStage14_171E(void);
[[reko::address("0D73:18F3")]] short RunCampaignStage15_18F3(void);
[[reko::address("0D73:1A9D")]] short RunCampaignStage16_1A9D(void);
[[reko::address("0D73:1B7A")]] short RunCampaignStage17_1B7A(void);
[[reko::address("0D73:1C5B")]] short RunCampaignStage18_1C5B(void);
[[reko::address("0D73:1D18")]] short RunCampaignStage19_1D18(void);
[[reko::address("0D73:1DAD")]] short RunCampaignStage20_1DAD(void);
[[reko::address("0D73:2022")]] short RunCampaignStage21_2022(void);

// ASM-verified story presentation helpers.  2B33 accepts the screen resource
// followed by the optional message index; 2D01 displays one indexed story
// message in a modal window and waits for the configured input path.
[[reko::address("0D73:2B33")]]
void PresentAnimatedScreenAndMessage_2B33(
    unsigned short screenResourceIndex,
    unsigned short messageIndex);
[[reko::address("0D73:2D01")]]
void ShowStoryMessageAndWait_2D01(unsigned short messageIndex);
[[reko::address("0D73:3510")]]
void ShowCampaignMessageAndWait_3510(unsigned short messageIndex);
[[reko::address("0D73:3B7E")]]
void PresentMissionBriefing_3B7E(
    unsigned short graphicsResourceIndex,
    unsigned short spriteLayoutIndex,
    unsigned short messageIndex);
[[reko::address("2507:1848")]]
void RunLanceConfiguration_1848(
    unsigned short firstRosterIndex,
    unsigned short lanceSize);
[[reko::address("2507:2FCD")]]
void PrepareLanceSelection_2FCD(
    unsigned short firstRosterIndex,
    short selectionMode);
[[reko::address("0D73:347D")]]
void PresentCampaignScene_347D(
    unsigned short graphicsResourceIndex,
    unsigned short spriteLayoutIndex,
    unsigned short messageIndex);
[[reko::address("2507:2005")]]
short SelectScenarioVariant_2005(unsigned short presentationMode);
[[reko::address("0D73:2D9B")]]
void PresentStoryScreenAndMessage_2D9B(
    unsigned short graphicsResourceIndex,
    unsigned short messageIndex);
[[reko::address("0D73:2E2E")]]
void ShowStoryMessage_2E2E(unsigned short messageIndex);

// CopyVideoRegion_2B00 stores and adjusts the offset half independently from
// the source segment at 0BA7h.  It is an integer offset, not a C pointer.
[[reko::address("4184:0BB5")]] word VideoCopySourceOffset_0BB5;

// Initial bytes 34h, 12h, 76h are advanced together by
// GeneratePseudoRandomByte.
[[reko::address("4184:0E48")]] byte PseudoRandomState_0E48[3];

// Paired discriminator and destination tables used by near dispatches.
[[reko::address("1A1F:42EA")]] word GameStateDispatchValues_42EA[8];
[[reko::address("1A1F:42FA")]] word GameStateDispatchOffsets_42FA[8];
[[reko::address("34C8:0021")]] word KeyDispatchValues_0021[14];
[[reko::address("34C8:003D")]] word KeyDispatchOffsets_003D[14];

// TranslateKeyCode_01D7 indexes scan codes 5Ah through 6Dh here.
[[reko::address("3037:007C")]] word KeyboardEventBuffer_007C[64];
[[reko::address("3037:00FC")]] word KeyboardBufferReadOffset_00FC;
[[reko::address("3037:00FE")]] word KeyboardBufferWriteOffset_00FE;
[[reko::address("3037:01B5")]] unsigned short ReadRawKeypress_01B5(void);
[[reko::address("3037:032E")]] byte KeypadTranslationTable_032E[20];

// Unit-selection tables consumed by SelectUnitClass_0501 and
// SelectUnitTypeFromList_0625.
[[reko::address("3A6A:32D7")]] const byte OmniUnitTypeIdList_32D7[5];
[[reko::address("3A6A:32DC")]] const byte __far *UnitTypeListByClass_32DC[6];
[[reko::address("3A6A:32F8")]] const char __far *UnitClassMenuTextTable_32F8[7];
[[reko::address("3A6A:1CCA")]] byte UnitLanceAssignmentTable_1CCA[130];
[[reko::address("3A6A:30DB")]] const char RosterPilotUnitSeparator_30DB[2];
[[reko::address("3A6A:3354")]] byte FixedRosterPilotIds_3354[2];
[[reko::address("3A6A:3356")]] byte FixedRosterUnitTypeIds_3356[2];
[[reko::address("3A6A:359C")]] word RosterLeftColumnX_359C;
[[reko::address("3A6A:359E")]] word RosterRightColumnX_359E;
[[reko::address("3A6A:3E92")]] const char __far *PilotNameTable_3E92[37];
[[reko::address("3A6A:5928")]] const byte ScenarioLanceAllegianceTable_5928[24];
[[reko::address("3A6A:84C7")]] byte UndamagedUnitCombatEstimate_84C7[150];
[[reko::address("3A6A:99C2")]] byte DamagedWeaponRangeFlags_99C2[3];

// 96 word frequency/divisor values end immediately before driver state at E0h.
[[reko::address("426B:0020")]] word MusicFrequencyDivisorTable_0020[96];

// A near callback offset stored and invoked inside segment 375F. The callback
// receives its event byte in AL rather than through the C stack ABI.
typedef void (__near *TimerDriverCallback)(
    [[reko::arg(register, "al")]] byte eventCode);
[[reko::address("375F:04CA")]]
TimerDriverCallback TimerDriverCallback_04CA;

// Digital-device private state embedded in the 375F code segment. Naming
// these values prevents Reko from folding port arithmetic into unrelated
// globals when the hardware callback block is regenerated.
[[reko::address("375F:00F6")]] word SoundBlasterBasePort_00F6;
[[reko::address("375F:0154")]] word AdLibRegisterDelay_0154;
[[reko::address("375F:0156")]] word AdLibDataDelay_0156;
[[reko::address("375F:01F6")]] word CMSDataPort0_01F6;
[[reko::address("375F:01F8")]] word CMSRegisterPort0_01F8;
[[reko::address("375F:01FA")]] word CMSDataPort1_01FA;
[[reko::address("375F:01FC")]] word CMSRegisterPort1_01FC;
[[reko::address("375F:0268")]] word InnovationOutputPort_0268;
[[reko::address("375F:028C")]] word CovoxCommandPort_028C;
[[reko::address("375F:028E")]] word CovoxDataPort_028E;
[[reko::address("375F:039B")]] byte CMSAmplitudeLookup_039B[256];
