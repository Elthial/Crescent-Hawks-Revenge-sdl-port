# REVENGE.EXE DS 3A6A memory map

This confidence-graded map is retained from the reconstructed data segment.

Human: 3A6A is the program's primary data segment. It contains mutable game
state, lookup tables, and most of the user-facing NUL-terminated text.
Confidence follows Inception: [V] verified, [P] probable, [H] hypothesis,
[U] unknown. Marks apply to the stated interpretation, not merely the address.

DS:00A6  [P] MapWidth; map-cell width used for coordinate bounds and
         row-major indexing.
DS:00A8  [P] MapHeight; matching map-cell height.
DS:00AA  [V] PackedTerrainDamageRowBytes; bytes per row in the packed
         two-bit-per-cell damage-state map.
DS:00AC  [V] VideoPaletteData; 0x300-byte VGA DAC palette containing 256
         consecutive RGB triplets. Scene palette loading can replace this
         region before LoadVideoPalette programs the VGA DAC.
DS:03AC  [V] LogicalPaletteValues; 16 palette-register values consumed by
         the Tandy and EGA branches of LoadVideoPalette. The VGA branch
         does not consume this suffix.
DS:03DC  [V] TacticalSelectedUnitIndex; currently focused tactical unit
         or FFFFh. Unit/lance selection writes it; withdrawal and destruction
         clear it when its referenced unit leaves play.
DS:03DE  [P] EnemyCycleUnitIndex; remembered enemy slot for the visible-
         enemy cycle command, or FFFFh. It is copied into DS:03DC when that
         enemy becomes the active tactical selection.
DS:03E0  [V] WeaponAIHeatLimitByExperience; five byte limits
         14h,10h,0Dh,0Ah,08h indexed by pilot experience plus one, or by
         experience directly while overburn/close assault is active.
DS:03E7  [V] SensorDamageProximityRangeTable; three byte thresholds
         14h,0Ah,00h indexed by an opposing unit record's sensor-hit count.
         UpdateUnitEnemyProximityState latches proximity when tactical
         distance is strictly less than the selected threshold.
DS:03EB  [U] SceneGlobalFlagZero; SCENE opcode CFh sets this byte to one
         when its selector operand is zero. No consumer has established its
         gameplay meaning yet.
DS:03EC  [U] SceneGlobalFlagNonzero; matching flag set when the CFh
         selector is nonzero.

DS:0435  [P] WeaponDefinitions; 23 records of 0x0F bytes. Every record
         begins with a far pointer to its weapon name, followed by 11 bytes
         of weapon characteristics. The name pointers resolve in order to
         Small Laser through SRM-6 at DS:1E38-1EEB.
         Confirmed record fields are +04 heat, +05 damage, +06 minimum
         range, +07 maximum range divided by three, +08 weight in half-ton
         units, +0A missile rack size, +0B ammunition-family ID, +0C critical
         slot count, and +0D recovery delay. +0E is the probable weapon
         effect ID consumed by DispatchWeaponEffect; the refreshed
         ResolveWeaponAttack body verifies that final field directly.
DS:058E  [P] AmmoCapacityMultiplierTable; 14 word entries used to rebuild
         per-weapon ammunition counts in ResetLiveUnitState.
DS:0F46  [V] WeaponPriorityListCounts; 16 word entry counts.
DS:0F66  [V] WeaponPriorityListPointers; 16 far pointers to paired
         availability masks and one-based weapon choices. The executable
         image contains offsets 09C6h through 0F2Eh; each adjacent list begins
         after twice the preceding count of four-byte entries.
DS:0FA6  [V] WeaponPriorityProfileByRangeHeat; maps distance bits
         10h/20h/40h plus heat bits 01h/02h/04h/08h to a list index.
DS:174A  [P] DirectionDeltaXTable; eight signed word X directions used
         to scatter missed weapon traces and position projectile effects.
DS:175A  [P] DirectionDeltaYTable; matching eight signed Y directions.
DS:176A  [V] HeatDissipationBySinkCountQ8_8; word table whose entries
         are 0000h, 0010h, 0020h, ... . UpdateUnitHeatAccumulators
         subtracts entry[effectiveHeatSinkCount] from the unit word at +86h.
DS:197B  [P] SavedScenarioUnitMapX; 24 one-byte unit-slot coordinates copied from 8562.
DS:1993  [P] SavedScenarioUnitMapY; 24 one-byte unit-slot coordinates copied from 857B.
DS:1CCA  [P] UnitLanceAssignmentTable; 13 0x0A-byte records serialized
         in each save and updated when lances compact.
DS:1D4C  [V] PilotRosterTable; 59 four-byte entries through DS:1E37. Bytes +00 identity/name index, +01 experience index, +02 gunnery index, +03 availability/state. AssignPilotRosterEntryToUnit
         stores the entry index at unit +92h, then copies entry +01 to unit
         +93h and entry +02 to gunnery target +8Ah; entry +03 is availability.
DS:1D4F  [V] PilotAvailabilityTable; byte +03 of each PilotRosterTable. Save games serialize only the first 37 availability bytes.
         entry, indexed by unit field +92h (pilot ID), not chassis/type +01h.
DS:2459  [V] MonthNameTable; 12 far pointers to JAN through DEC.
DS:25E5  [V] MenuOptionTextTable; 14 far pointers to New Game through the
         second Game Options string. ShowMainMenu uses entries 0-2;
         later menus address subranges beginning inside the same table.
DS:2ECE  [V] TerrainDamageCellIncrementMask; four byte masks that increment
         the selected two-bit cell in a packed terrain-damage byte.
DS:2ED2  [V] TerrainDamageExtractMask; four masks selecting the cell.
DS:2ED6  [V] TerrainDamageShift; four right-shift counts matching 2ED2.
DS:2EDA  [V] TacticalCursorSearchOffsetX; nine signed word offsets:
         0,0,1,0,-1,-1,1,1,-1. FindUnitAtTacticalCursor pairs
         these with DS:2EEC to inspect the cursor cell before its neighbors.
DS:2EEC  [V] TacticalCursorSearchOffsetY; nine signed word offsets:
         0,-1,0,1,0,-1,-1,1,1.
DS:30CB  [V] UnitAllegianceNameTable; two far pointers: Friendly and Enemy.
DS:30F2  [V] UnitStatAbbreviationTable; six far pointers: LNG, MED, CLS,
         SPD, EXP, and GUN.
DS:32D7  [V] OmniUnitTypeIdList; Puma, Black Hawk, Mad Cat, Elementals,
         FFh. SelectUnitTypeFromList suppresses Elementals for Friendly.
DS:32DC  [V] UnitTypeListByClass; six far pointers selecting the Light,
         Medium, Heavy, Assault, Enhanced, and Omni FFh-terminated ID lists.
DS:32F8  [V] UnitClassMenuTextTable; seven far pointers: Light, Medium,
         Heavy, Assault, Enhanced, Omni, and Cancel.
DS:3D0D  [P] ImprovedMissileDamageBonusTable; byte table indexed by
         weapon index when unit-record +8Ch is nonzero. Only missile indices
         10h..16h reach this lookup in ApplyWeaponDamage.
DS:1038  [V] HitLocationTables; five 18h-byte tables. Each contains 11
         word results for 2d6 rolls 2..12 plus one zero padding word. Tables
         0..3 are rear, right side, front, and left side; table 4 always
         returns internal location 03h for infantry.
DS:3CFE  [V] HitLocationTableByFacing; 16 word selectors with values
         0..3, indexed by target facing plus relative attack direction.
DS:3D2E  [V] UnitNameTable; 89 far pointers matching the 89 0x96-byte
         MECHTYPE.DAT records. Entries run from Locust through BattleMaster+.
DS:58DB  [V] PCSpeakerEffectStreamPointerTable; 16 far pointers indexed by the
         WeaponDefinition.effectId passed to PlayPCSpeakerEffectByIndex. The streams are
         contiguous in image segment 326A and end exactly at this table.
DS:591B  [V] GameTimerTicks; free-running 32-bit BIOS INT 1Ch tick count.
DS:591F  [V] GameAnimationTicks; second free-running 32-bit INT 1Ch
         count. Low-word bit 10h selects the campaign-clock separator color.
DS:5923  [V] TacticalUpdateDelayTicks; decremented by the INT 1Ch
         handler at 18.2065 Hz. Tactical play reloads it from DS:17DA and
         the scenario-result banner reuses it with a value of 0Bh.
DS:5925  [V] TacticalKeyRepeatDelayTicks; five-tick input debounce/countdown.
DS:5928  [V] ScenarioLanceAllegianceTable; three allegiance bytes per
         scenario table row, expanded across the first three four-unit groups
         by AssignScenarioLanceAllegiances.
DS:7A73  [P] TerrainDamageCapabilityTable; far byte table indexed by
         terrain type. A nonzero entry permits the packed damage state to
         advance toward the caller's requested maximum.
DS:24D3  [P] ScenarioRosterPrepared; prevents roster preparation and pending campaign deltas from being applied twice before save/menu transitions
DS:24D4  [P] PendingCampaignStageDelta; applied to CampaignStageIndex after PrepareScenarioUnitRosters
DS:24D5  [P] PendingCampaignPhaseDelta; applied to CampaignPhase after PrepareScenarioUnitRosters
DS:24D6  [P] CampaignStageIndex; winning saves progress from 0001h at
         Scenario 2 through 0014h at Scenario 26 and 0015h at Pacifica.
DS:24D8  [H] ScenarioVariantIndex; training missions use 0,2,4,1,3,5.
DS:24DA  [P] CampaignPhase; values 1-8 across supplied checkpoints.
DS:24DC  [H] TrainingSequenceFlag; set during training T1-T5.
DS:24DF  [P] CampaignFlags; serialized bitfield used by roster setup.
DS:24F4  [V] CampaignStageHandlerTable; 16h far procedure pointers,
         indexed by CampaignStageIndex. RunCampaignLoop supplies
         no stack arguments and consumes each handler's signed AX result.
         Entries 00h..15h target 0D73:0448, 0633, 071A, 07F9, 0883,
         092E, 0B15, 0BC8, 0C2B, 1099, 1212, 1302, 1400, 155F, 171E,
         18F3, 1A9D, 1B7A, 1C5B, 1D18, 1DAD, and 2022 respectively.
DS:8108  [P] LrmShipmentLoaded; D4h selector 02h sets it beside the "Listen-Kill LRM missiles are loaded" event, and save/load serializes it.
DS:810A  [P] SrmShipmentLoaded; D4h selector 01h sets it beside the "All the SRM's are loaded" event. Scenario 38h uses it to install the missile-upgrade byte on unit type 04h.
DS:8104  [V] TacticalOverviewActive; nonzero selects the tactical
         overview-map redraw path. ExitTacticalOverview clears it before
         restoring the ordinary tactical UI. Campaign-clock suppression is
         a consequence of this mode, not the field's primary meaning.
DS:8106  [V] TerrainDamageQueueWordCount; used-word count for the
         32h-word queue at DS:B28E. Each queued item occupies two words.
DS:8328  [P] SceneRuntimeSlotValue; byte array indexed by SCENE opcode
         D0h. The opcode writes its value operand here and resets the two
         matching runtime arrays at DS:99AC and DS:B574.
DS:8331  [V] TacticalCursorViewportX; signed cursor X relative to the
         19-cell tactical viewport. Overflow scrolls TacticalViewportMapX.
DS:8333  [V] TacticalCursorViewportY; signed cursor Y relative to the
         12-cell tactical viewport.
DS:8337  [V] CampaignClockHour; hour of day, 0-23.
DS:8338  [V] CampaignClockMinute; minute, 0-59.
DS:8339  [V] CampaignClockSecond; advanced by two each tactical tick,
         rolls over at 60, and is snapshotted with the clock, but is not
         read or advanced by AdvanceCampaignClock.
DS:833E  [V] CurrentUnitDurabilityTotal; current armor total for normal
         units or current internal-structure total for terminus-state 03h.
DS:8340  [P] UnitRouteFirstX; one byte per unit, set from the first X
         operand of SCENE opcode F9h.
DS:8359  [V] UnitTargetMapX; one byte per unit. SCENE opcode FBh writes
         a ground target here when UnitAttackTarget is 18h.
DS:8374  [V] TacticalOverviewMarkerX; 24 cached map X coordinates for
         unit markers. FFh means that no marker needs erasing.
DS:838C  [V] TacticalOverviewViewportX; previous overview-frame map X,
         copied from TacticalViewportMapX before drawing each frame.
DS:838E  [P] UnitRouteFirstY; matching first Y operand.
DS:83A7  [V] UnitTargetMapY; matching ground-target Y coordinate.
DS:83C0  [V] TacticalOverviewMarkerY; Y-coordinate counterpart to the
         marker cache at DS:8374.
DS:83D8  [V] TacticalOverviewViewportY; previous overview-frame map Y.
DS:83DA  [V] TacticalViewportMapY; current tactical camera map Y used
         to place the overview frame.
DS:83E6  [V] TacticalOverviewMapBuffer; far byte-per-cell color map.
         Rows use the map width rounded up to an eight-byte boundary.
DS:83EA  [V] TerrainTypeMap; far byte-per-cell terrain-type map indexed
         row-major by MapWidth.
DS:84A0  [V] TacticalViewportMapX; current tactical camera map X used
         to place the overview frame.
DS:84A2  [P] TacticalTerrainEffectMode; scenario-supplied mode byte.
         Value 06h suppresses queuing the three special destructible terrain
         types; its broader scenario meaning is still open.
DS:84A3  [P] TacticalSpriteAnimationPhase; toggled after each ordinary
         ground movement step and added to the unit's tactical sprite ID.
DS:84C7  [V] UndamagedUnitCombatEstimate; 96h-byte scratch unit record
         constructed from maximum armor and equipment with damage bits
         removed when exact enemy condition must remain hidden.
DS:849E  [V] TerrainImpactAnimationTypeMaximum; inclusive upper terrain-type bound for random DS:810C animation-record creation.
DS:855D  [V] TerrainImpactAnimationTypeMinimum; inclusive lower terrain-type bound paired with DS:849E.
DS:855F  [P] ScenarioClockSnapshot; three-byte snapshot of DS:8337.
DS:8562  [V] ScenarioUnitMapX; 24 one-byte coordinates indexed by live-unit slot.
DS:857B  [V] ScenarioUnitMapY; 24 one-byte coordinates indexed by live-unit slot.
DS:8596  [V] UnitBelowHalfDurability; one byte per unit. Combat-rating
         refresh latches TRUE when current armor/structure is below half of
         its maximum; the refresh routine does not clear an existing flag.
DS:85B0  [P] EmptyUnitRecord; blank 0x96-byte unit record used to clear slots.
DS:8650  [P] LanceFormationProfile; six scenario-header bytes, one per
         possible four-unit lance, selecting deterministic and randomized
         formation policies in SelectLanceFormationMode.
DS:8657  [P] CampaignUpgradeAwards; four one-byte award slots filled first-free by SCENE D5h selector 04h; exact reward represented by each slot remains unknown.
DS:8667  [V] UnitEnemyVisible; one byte per unit, rebuilt by scanning
         the opposing 12 slots and testing HasUnitLineOfSight.
DS:8680  [P] UnitEnemyInProximityRange; set when a contacted opposing
         unit is closer than the DS:03E7 threshold indexed by record +89h.
DS:869A  [P] ScenarioUnitFacing; one byte per live-unit slot, combined
         with relative attack direction to select a hit-location table.
DS:86BB  [V] MaximumUnitDurabilityTotal; maximum counterpart to DS:833E.
DS:86BE  [V] TerrainLineOfSightBlockingThreshold; terrain IDs at or
         above this value immediately block TraceMapLineOfSight.
DS:86C0  [V] TerrainLineOfSightMaximumSteps; maximum number of map
         cells examined by one line-of-sight trace.
DS:86C1  [P] UnitMovementRoutes; 24 records of 0Bh bytes: route index,
         active X/Y, four waypoint X bytes, and four waypoint Y bytes. SCENE
         opcode F9h initializes them and AdvanceUnitSceneRoute consumes them.
DS:87D4  [V] UnitWasAttackedThisTick; successful weapon AI sets the
         target byte. The frame tail increments DS:B587 when set, resets its
         counter otherwise, then clears this flag. SCENE F8h branches on it.
DS:87ED  [V] UnitEnemyContactEstablished; latched once a unit first
         gains line of sight to any deployed opponent.
DS:8806  [V] UnitEnemyEngagementActive; set with the proximity flag by
         UpdateUnitEnemyProximityState.
DS:8827  [V] UnitJumpingState; one byte per unit. It grants the jumping
         movement cadence, suppresses walk-animation toggling, adds movement
         heat and attack modifiers, and is cleared when either leg is lost.
DS:883F  [P] UnitWithdrawalState; one byte per unit. Bit 01h means a scripted withdrawal route is active; bit 80h means the unit/lance reached its exit. SCENE DBh starts/completes withdrawal and DAh branches for completion or an undeployed unit.
DS:8859  [P] DestructibleTerrainTypeBase; terrain IDs base..base+2 take
         the special destruction path in AdvanceTerrainDamageState.
DS:885B  [V] UnitDestructionMarkers; 24 three-byte records containing
         map X, map Y, and destruction sprite code. DestroyScenarioUnit
         stores DCh for friendly units and DDh for opposing units; the tactical
         renderer draws sprite 0100h + code whenever the code is nonzero.
DS:88A4  [V] UnitTacticalTarget; selected opposing unit index, 18h for
         the ground-coordinate target, or FFh for none. Target selection,
         movement, weapon AI, narration, and lance recovery all consume it.
DS:88BF  [V] UnitWeaponTypeCounts; 23 words indexed by one-based
         equipment/weapon ID minus one. CountUnitWeaponsByType rebuilds it by scanning
         the location-specific equipment slots.
DS:88F3  [V] UnitAttackTarget; one byte per unit. Value 18h means a
         ground-coordinate target held in DS:8359/83A7; FFh clears it.
DS:890C  [V] UnitOverburnOrCloseAssaultEnabled; 24 Boolean bytes. The
         tactical command screen toggles the selected byte and displays
         "Close Assault"/"Cease Assault" for infantry (damage model 03h),
         otherwise "Overburn: Off"/"Overburn: On". The state propagates
         from a lance leader, is cleared by heat shutdown, relaxes the
         weapon-AI heat ceiling, and selects infantry weapon index 0Ah.
DS:8927  [V] NarrationMessageCategory; values 00h-0Ah select one of
         11 generic messages inside a six-speaker bank. SCENE DCh-E1h stores
         10h-0Bh respectively to select the six trailing event strings.
DS:8929  [V] UnitWeaponRecoveryCounters; 24 records x 23 bytes. Firing
         adds WeaponDefinition.recoveryDelayTicks; combat-rating refresh
         reduces the counter by the number of installed weapons of that type.
DS:8B68  [P] UnitTacticalOrderMode; one byte per unit assigned by SCENE FCh and copied from lance leaders. Proposed modes: 00h scripted route/no autonomous target search, 01h hold position while attacking, 02h seek-and-destroy with autonomous target selection and pursuit.
DS:8B81  [P] PersistentUnitRoster; 24 contiguous 0x96-byte unit records.
DS:9993  [V] UnitTerrainType; current terrain ID beneath each unit,
         updated after a successful tactical movement step.
DS:99AC  [P] TacticalSlotSpriteState; per-slot display state written by
         SetTacticalSlotSpriteState. State 06h (not deployed) is stored
         as sprite state 03h; SCENE opcode D0h clears the selected slot.
DS:99C2  [V] DamagedWeaponRangeFlags; three Boolean bytes for long,
         medium, and close range, rebuilt from damaged equipment entries for
         the tactical unit control/status panel.
DS:99C7  [V] UnitMovementHeatExponent; one byte per unit assigned by
         SCENE opcode FAh. Zero disables movement, 02h grants 1.5x base
         movement, and ground movement adds 10h << value to Q8.8 heat.
DS:99E0  [P] LiveScenarioUnits; 24 contiguous 0x96-byte unit records.
DS:A7F1  [V] TacticalOverviewScreenOriginX; horizontal screen offset
         added to every overview-map X coordinate. The entry path derives it
         from (00A0h - MapWidth) / 2.
DS:A7F3  [V] UnitLastNarratedTarget; one byte per unit. Target selection
         stores the target after queuing category 0Ah so the warning is not
         repeated while the same withdrawal target remains selected.
DS:A800  [V] MapEdgeEffectQueue; three four-word records containing map
         X, map Y, sprite ID, and edge direction. DS:B57F is its count.
DS:A818  [V] UnitSpriteBaseId; 24 global MECHSET sprite IDs initialized
         from unit-record +88h plus 0100h. Opposing non-infantry units add
         08h; opposing infantry adds 02h.
DS:A84A  [V] UnitShutdownState; one byte per unit. The heat shutdown
         check sets it and movement/weapon AI skip affected units.
DS:A862  [V] SceneInstructionBaseOffset; file offset 0128h for SCENE1,
         derived from the first data offset plus the reserved word. SCENE
         branch words are absolute offsets relative to this base.
DS:A971  [V] UnitWeaponAvailabilityMaskLow; low 16 weapon bits per unit.
DS:A973  [V] UnitWeaponAvailabilityMaskHigh; high 7 weapon bits per unit.
DS:A9D9  [V] SceneInstructionOffset; offset half of the far bytecode
         cursor consumed and advanced by ExecuteSceneInstructions.
DS:A9DB  [V] SceneInstructionSegment; segment half of that cursor.
DS:AE3D  [V] UnitJumpMovementRemaining; 24 counters initialized from
         unit-record jump movement +03h and decremented during jumping.
DS:AE5F  [V] PackedTerrainDamageMap; far pointer to four two-bit damage
         states per byte. ReadTerrainDamageState caches the selected byte.
DS:AE6B  [V] UnitSpriteId; 24 words derived from A818 plus two times
         the low two facing bits. Infantry always uses facing zero.
DS:AE9D  [P] UnitFormationMode; SCENE opcode D2h fills four consecutive
         unit bytes. RebuildLanceFormationAfterLeaderLoss uses the low
         seven bits to choose formation offsets and their map-cell scale.
DS:AED6  [V] UnitPreferredEngagementMode; 24 bytes selected through the
         DS:08C6 firepower-comparison table. 01h/02h/03h maintain close,
         medium, and long range; 04h withdraws; 05h moves to a position.
DS:AEF1  [V] UnitCombatRatings; 24 derived records of 0x0C bytes built
         from movement, durability, and weapon masks. Fields are +00 walk
         movement, +02 durability/16, +04 close-range rating, +06
         medium-range rating, +08 long-range rating, and +0A sensor hits.
DS:B011  [V] SelectedUnitCombatRatings; scratch record 18h immediately
         after UnitCombatRatings. The status screen reads close-range at
         B015, medium-range at B017, and long-range at B019. Lance comparison
         also uses its first five words as the first aggregate.
DS:B01D  [V] ComparedLanceCombatRatings; five-word second-lance
         aggregate paired with DS:B011 by CompareLanceCombatRatings.
DS:B02C  [V] UnitHeatSinkCount; one byte per combat unit, populated by
         CountOrRemoveUnitHeatSinks while combat ratings are rebuilt.
DS:B047  [V] ActiveTerrainDamageByte; cached far pointer to the packed
         terrain-damage byte selected by ReadTerrainDamageState.
DS:B28E  [V] TerrainDamageQueue; 32h words holding at most 25
         packed-byte/subcell pairs for staged special-terrain damage.
DS:B04B  [H] PendingNarrationDelay; QueueLinkedUnitStatusNarration
         writes 025Dh while scheduling category-eight narration.
DS:B04D  [H] SuppressCampaignClock; nonzero prevents
         DrawCampaignClock from rendering. Exact owner is unresolved.
DS:B04F  [V] UnitCachedWeaponCounts; 25 x 23 byte cache containing the
         low-byte installed count for each weapon type. Slots 00h-17h belong
         to live tactical units and slot 18h is the unit-status scratch slot.
         Combat-rating refresh restores DS:88BF from this table when a full
         equipment scan is skipped. The table ends exactly at DS:B28E.
DS:B574  [P] SceneRuntimeSlotSentinel; D0h writes FFh to the selected
         byte while initializing the corresponding DS:8328 slot. Leaving
         tactical overview also resets the first nine entries to FFh before
         rebuilding the ordinary tactical interface.
DS:B57F  [V] MapEdgeEffectCount; number of occupied records in the
         three-entry queue at DS:A800.
DS:B581  [V] ScenarioFileSuffix; ASCII '1'-'9' and 'A'-'U' select
         SCENE1.DAT-SCENEU.DAT. DS:254C maps campaign stage 15h to U;
         the roster switch at 30F1:0006 only covers recipes through T.
DS:B5D8  [H] FirstLanceOrdersEnabled; HasActiveLanceFollowers
         suppresses its true result for unit slots 00h-03h while this is zero.
DS:B5DC  [V] FailedAllocationSizeLow and DS:B5DE [V]
         FailedAllocationSizeHigh form the 32-bit byte count reported
         by the fatal far-heap allocation error path.
DS:80FC  [V] TacticalImpactQueueCount; bounded to 50h records by QueueTacticalImpactVisual.
DS:701A-701D  [V] FarHeapArenaBase; first physical block header in the Borland far heap.
DS:701E-7021  [V] FarHeapTailBlock; terminal physical block header used by allocation/free growth and release.
DS:7022-7025  [V] FarHeapFreeListHead; root of the circular doubly-linked free-block list.
DS:B2F4  [V] TacticalImpactQueue; 50h four-word records: mapX, mapY, impactClass, spriteId.
DS:B2F2  [P] ActiveNarrationSubject; ordinary combat narration stores a
         unit index here, while SCENE DCh-E1h stores the instruction's byte
         operand. Voice/sound selection compares the value with 01h-04h,
         supporting a speaker role, but exact identities remain unassigned.
DS:B67E  [P] CampaignClockTextBuffer; temporary two-digit decimal text
         rendered at tile columns 23h and 26h by DrawCampaignClock.
DS:2411  [V] TitleCreditTextPointerTable; 12h far string pointers
         consumed in order by AnimateTitleCredits.
DS:2562  [V] ExitConfirmationText; formatted confirmation text passed
         to ShowConfirmationDialog by ConfirmExitToDOS.
DS:2597  [V] RestartConfirmationText; matching formatted confirmation
         text used by ConfirmRestartGame.
DS:2718  [V] TitleTextFadeColorRamp; five overlapping color bytes used
         by AnimateTitleTextLine for its fade-in and fade-out passes.
DS:2B0B  [V] MissionDateSeparator; NUL-terminated space appended before
         the initially displayed mission year.
DS:2B0D  [V] AnimatedMissionDateSeparator; equivalent separator used
         while DisplayMissionDate advances the month and year.
DS:2B0F  [V] TextCursorBlinkGlyph; NUL-terminated underscore rendered
         over the active character while the text-entry cursor is visible.
DS:2B54  [V/P] MissionFollowupMessageTable; five-byte records containing
         a far formatted-text pointer and a one-byte window selector at +04h.
DS:30D9  [V] UnitRosterSpacingText; NUL-terminated space inserted while
         assembling the unit/pilot roster label.
DS:34C2  [V] AllegianceHeaderTextColorTable; byte colors selected by the
         Friendly/Enemy status-panel heading renderer.
DS:35B0  [V] UnitStatusPanelBackgroundColorTable; word colors indexed
         by the status-panel allegiance/style byte.
DS:35B8  [V] UnitStatusPanelDetailColorTable; matching word colors for
         names, equipment, armor, and heat details.
DS:3AD1  [V] VideoConfigurationRecords; five 0Dh-byte MEDIA.CFG records
         with a NUL-padded name at +00h and adapter ID at +0Ch.
DS:3B12  [V] MusicConfigurationRecords; seven 0Dh-byte records with the
         selected music-driver index at +0Ch.
DS:3B6D  [V] InputConfigurationRecords; two 0Dh-byte records mapping
         MOUSE/KEYB names to the input-device byte at +0Ch.
DS:3B87  [V] SoundConfigurationRecords; nine 0Eh-byte records containing
         name, driver index +0Ch, and numeric-parameter-present flag +0Dh.
DS:3CAA  [V] BIOSVideoModeByAdapter; seven words used by
         SetVideoModeForAdapter, with slot six reserved for restoration.
DS:3CB8  [V] VersionTranslationSource; single-character source alphabet
         passed to TranslateCharactersInPlace at startup.
DS:3CBA  [V] VersionTranslationReplacement; matching replacement
         alphabet used to normalize the displayed version text.
DS:3CBC  [V] MediaConfigAssignmentDelimiter; "=" tokenizer delimiter.
DS:3CBE  [V] VideoConfigTokenDelimiters; whitespace delimiters.
DS:3CC2  [V] MusicConfigTokenDelimiters; whitespace delimiters.
DS:3CC6  [V] SoundConfigTokenDelimiters; whitespace delimiters.
DS:3CCA  [V] SoundParameterTokenDelimiters; whitespace delimiters.
DS:3CCE  [V] InputConfigTokenDelimiters; whitespace delimiters.
DS:5DEE  [V] ScenarioDigitalSoundBankCodeLists; NUL-terminated sample
         key lists ending at 5E6Dh and used to assemble the resident bank.
DS:5E6E  [V] ScenarioDigitalSoundPlaybackFragments; NUL-terminated
         fragments ending at 5F6Ah and concatenated for scenario narration.
DS:62BA  [V] MIDIVoiceListSentinelOffset; head/sentinel offset rebuilt
         by ResetMIDIPlaybackState before linking the voice records.
DS:6420  [P] MIDIPlaybackState; 180h-byte state area cleared whenever
         MIDI playback is reset. Its internal channel/controller layout is open.
DS:6D18  [V] PCSpeakerErrorDiffusionCoefficients; seven signed words
         used to build the 256-entry one-bit sample lookup table.
DS:810C  [V] TerrainImpactAnimationRecords; 5Ah six-byte records holding
         signed map X, signed map Y, and animation variant; X=FFFFh is free.
DS:8666  [V] ActiveFontGlyphAdvanceX; cached font-header byte +0103h.
DS:99BB  [V] ActiveFontLineHeight; cached font-header byte +0102h.
DS:84C1  [V] ActiveFontResource; reconstructed host pointer replacing
         the original offset/segment pair at DS:84C1/84C3.
DS:A865  [V] ScenarioTerrainDamageCapabilityMap; runtime byte map built
         from the selected terrain-effect mode and loaded capability table.
DS:B02A  [P] ScenarioRuleMask; shared rule/permission mask consulted by
         experience, movement, and the verified bit-80h environment modifier.
DS:B5E4  [V] BIOSInterruptInputRegisters; register block passed to the
         generic interrupt invoker.
DS:B5F4  [V] BIOSInterruptOutputRegisters; output register block filled
         by the same generic interrupt invoker.
DS:B808  [V] ExitHandlerTable; far callback table popped in reverse
         registration order by RunExitHandlersAndTerminate.
DS:B888  [V] CriticalErrorCallback; retained 16:16 callback invoked by the
         INT 24h dispatcher at 34A7:0021.

Extracted NUL-terminated text catalog (663 entries). Addresses are offsets
from the runtime DS segment 3A6A. Only evidence-backed text ranges are included;
binary tables elsewhere in the segment are deliberately excluded.
DS:1E38  "Small Laser"
DS:1E44  "Sm Pulse"
DS:1E4D  "Medium Laser"
DS:1E5A  "Med Pulse"
DS:1E64  "Large Laser"
DS:1E70  "Lg Pulse"
DS:1E79  "ER Laser"
DS:1E82  "PPC"
DS:1E86  "ER PPC"
DS:1E8D  "AC/2"
DS:1E92  "AC/5"
DS:1E97  "AC/10"
DS:1E9D  "LB-10X A/C"
DS:1EA8  "Gauss Rifle"
DS:1EB4  "AC/20"
DS:1EBA  "Mach. Gun"
DS:1EC4  "LRM-5"
DS:1ECA  "LRM-10"
DS:1ED1  "LRM-15"
DS:1ED8  "LRM-20"
DS:1EDF  "SRM-2"
DS:1EE5  "SRM-4"
DS:1EEB  "SRM-6"
DS:1EF1  "BTBORDER.CPS"
DS:1EFE  "BASEEXT.CPS"
DS:1F0A  "BLAZACE.CPS"
DS:1F16  "DSATTACK.CPS"
DS:1F23  "DSLYONS.CPS"
DS:1F2F  "ENDGAME.CPS"
DS:1F3B  "HAWKLOGO.CPS"
DS:1F48  "JUMPSHIP.CPS"
DS:1F55  "KHBASE.CPS"
DS:1F60  "KHHANGER.CPS"
DS:1F6D  "MECHBAY.CPS"
DS:1F79  "QUADPICS.CPS"
DS:1F86  "RIP.CPS"
DS:1F8E  "SWAMP.CPS"
DS:1F98  "TANK.CPS"
DS:1FA1  "TITLE.CPS"
DS:1FAB  "HALFDS.CPS"
DS:1FB6  "HALFDSSH.CPS"
DS:1FC3  "FINAL.CPS"
DS:1FCD  "BRUSHES.CPS"
DS:1FD9  "MAP1.CPS"
DS:1FE2  "MAP2.CPS"
DS:1FEB  "ISMAP1.CPS"
DS:1FF6  "ISMAP2.CPS"
DS:2001  "ISMAPO.CPS"
DS:200C  "COMM.CPS"
DS:2015  "ORDERS.CPS"
DS:2020  "CHIUN.CPS"
DS:202A  "CHIUN'50.CPS"
DS:2037  "GREASE.CPS"
DS:2042  "JEN.CPS"
DS:204A  "KELL.CPS"
DS:2053  "KURT.CPS"
DS:205C  "REX.CPS"
DS:2064  "SHAW.CPS"
DS:206D  "MECHS1.CPS"
DS:2078  "MECHS2.CPS"
DS:2083  "PILOTS1.CPS"
DS:208F  "PILOTS2.CPS"
DS:209B  "BASEEXT.COL"
DS:20A7  "BLAZACE.COL"
DS:20B3  "DSATTACK.COL"
DS:20C0  "DSLYONS.COL"
DS:20CC  "ENDGAME.COL"
DS:20D8  "HAWKLOGO.COL"
DS:20E5  "JUMPSHIP.COL"
DS:20F2  "KHBASE.COL"
DS:20FD  "KHHANGER.COL"
DS:210A  "MECHBAY.COL"
DS:2116  "QUADPICS.COL"
DS:2123  "RIP.COL"
DS:212B  "SWAMP.COL"
DS:2135  "TANK.COL"
DS:213E  "TITLE.COL"
DS:2148  "HALFDS.COL"
DS:2153  "FINAL.COL"
DS:215D  "MAPS.COL"
DS:2166  "ISMAPS.COL"
DS:2171  "FACES.COL"
DS:217B  "SELCTION.COL"
DS:2188  [V] TacticalMapFileName "MAPx.MAP"; character +03h is written by LoadTacticalMap
DS:2191  [V] TacticalIconSetFileName "ICONSETx.ICN"; character +07h shares the DESTROY selector
DS:219E  [V] TacticalDestroyIconFileName "DESTROYx.ICN"; character +07h is written with ICONSET at 1A1F:03D4
DS:21AB  [V] TacticalIconListFileName "ICONLIST.DAT"
DS:21B8  [V] MechTypeDataFileName "MECHTYPE.DAT"
DS:21C5  [V] TacticalMechSetFileName "MECHSETX.ICN"; character +07h is selected at 0D73:02B4
DS:21D2  [V] ScenarioDataFileName "SCENEx.DAT"; character +05h receives ScenarioFileSuffix
DS:21DD  "BOOMS.CMP"
DS:21E7  "SAVEGAME.DAT"
DS:21F4  "MEDIA.CFG"
DS:21FE  "DETHMEC1.MUS"
DS:220B  "DETHMEC2.MUS"
DS:2218  "MARCH1.MUS"
DS:2223  "MARCH2.MUS"
DS:222E  "SUBTITLE.MUS"
DS:223B  "SUSP1.MUS"
DS:2245  "SUSP2.MUS"
DS:224F  "TITLE.MUS"
DS:2259  "VICTORY.MUS"
DS:2265  "WINGAME.MUS"
DS:2271  "INFOCOM.BIN"
DS:227D  "DPHRASES.BIN"
DS:228A  "INCOMING.BIN"
DS:2297  "LASER3.BIN"
DS:22A2  "LASER4.BIN"
DS:22AD  "LARGEGUN.BIN"
DS:22BA  "LGBOOM1.BIN"
DS:22C6  "SMGUN1.BIN"
DS:22D1  "WARN1.BIN"
DS:22DC  "Allocation error!  Please remove any memory resident programs and try again.\r\n"
DS:232B  "Unable to allocate "
DS:233F  " bytes.\r\n"
DS:2349  "Only "
DS:234F  " bytes free.\r\n"
DS:235E  "Allocation too big!"
DS:2372  "Invalid version of save game.  Please use another save game.\rPress ESC to exit to DOS.\rPress space bar to try another."
DS:23EC  "!"&'+,-./:;?"
DS:261A  "*j2\r\rSaving game ...\r"
DS:2630  "Game saved.\r"
DS:263D  "Game has not been saved yet.\r"
DS:265B  "Rename"
DS:2662  " load"
DS:2668  " save"
DS:266E  " game "
DS:2675  "Cancel"
DS:267D  "Select game to rename.  "
DS:2696  "Enter new name for game."
DS:26AF  "Exit to DOS\r"
DS:26BC  "Are you sure you want to save?"
DS:26DB  "Press return or button"
DS:26F2  "Yes\r No"
DS:26FA  "* Pacifica Training Ground *\r"
DS:27E3  "Developed by:"
DS:27F1  "Westwood Associates"
DS:2805  "Produced by:"
DS:2812  "Tony Van"
DS:281B  "and Scott Berfield"
DS:282E  "Programming by:"
DS:283E  "Barry Green"
DS:284A  "and David R. Dettmer"
DS:285F  "Game Design by:"
DS:286F  "Tony Van"
DS:2878  "Scenario Design by:"
DS:288C  "Michael Moore"
DS:289A  "Music by:"
DS:28A4  "Paul S. Mudra"
DS:28B2  "and Dwight Okahara"
DS:28C5  "Art by:"
DS:28CD  "Joseph B. Hewitt IV"
DS:28E1  "and Jenny Martin"
DS:28F2  "JAN"
DS:28F6  "FEB"
DS:28FA  "MAR"
DS:28FE  "APR"
DS:2902  "MAY"
DS:2906  "JUN"
DS:290A  "JUL"
DS:290E  "AUG"
DS:2912  "SEP"
DS:2916  "OCT"
DS:291A  "NOV"
DS:291E  "DEC"
DS:2922  "Chara III (Pacifica), Lyran Commonwealth"
DS:294B  "Lyons, Lyran Commonwealth"
DS:2965  "Dieron, Draconis Combine"
DS:297E  "Chara III (Pacifica), Lyran Commonwealth"
DS:29A9  "New Avalon, Federated Commonwealth"
DS:29CE  "Arc-Royal, Federated Commonwealth"
DS:29F0  "Kaesong, Draconis Combine"
DS:2A0A  "Luthien, Draconis Combine"
DS:2A24  "Two Lances"
DS:2A2F  "Three Lances"
DS:2A3C  "Drop Lance"
DS:2A47  "Land Ship"
DS:2A51  "Defend City"
DS:2A5D  "Obey Orders"
DS:2A69  "New Game"
DS:2A72  "Load Game"
DS:2A7C  "Game Options"
DS:2A89  "Save"
DS:2A8E  "Load"
DS:2A93  "Continue"
DS:2A9C  "Jump Story"
DS:2AA7  "Save & Continue"
DS:2AB7  "Save & Quit"
DS:2AC3  "Load Game"
DS:2ACD  "Replay Scenario"
DS:2ADD  "Replay Story"
DS:2AEA  "Restart Game"
DS:2AF7  "Game Options"
DS:2B04  "\r   "
DS:30DD  " J"
DS:30E0  "ARMOR:"
DS:30E7  "HEAT:"
DS:30ED  "EXIT"
DS:3644  "Friendly "
DS:364E  "Enemy "
DS:3655  "LNG"
DS:3659  "MED"
DS:365D  "CLS"
DS:3661  "SPD"
DS:3665  "EXP"
DS:3669  "GUN"
DS:366D  "Light"
DS:3673  "Medium"
DS:367A  "Heavy"
DS:3680  "Assault"
DS:3688  "Enhanced"
DS:3691  "Omni"
DS:3696  "Cancel"
DS:369D  "Pacifica Training Facilities"
DS:36BA  "Instructor: Jason Youngblood"
DS:36D7  "Seek & Destroy"
DS:36E6  "Scenario files open..."
DS:36FD  "Choose Friendly"
DS:370D  "Choose Enemy"
DS:371A  "Game Options"
DS:3727  "Begin Training"
DS:3736  "The Gauntlet"
DS:3743  "The Road Run"
DS:3750  "Mountain Pass"
DS:375E  "Forest Path"
DS:376A  "Briefing Room"
DS:3778  "Personnel"
DS:3782  "Mech Bay"
DS:378B  "Exit"
DS:3790  "Longer Distance"
DS:37A0  "Lighter Defenses"
DS:37B1  "Shorter Distance"
DS:37C2  "Heavier Defenses"
DS:37D3  "COMMAND"
DS:37DB  "FIRE"
DS:37E0  "SCOUT"
DS:37E6  "EXIT"
DS:37EB  "Arc-Royal Training Facilities"
DS:3809  "Arena reserved for the Crescent Hawks"
DS:382F  "COMMAND LANCE"
DS:383D  "FIRE LANCE"
DS:3848  "SCOUT LANCE"
DS:3854  "COMPANY"
DS:385C  "OK"
DS:385F  "Re-select"
DS:3869  " Attack Town"
DS:3876  " Defend Town"
DS:3883  " Enemy Advance"
DS:3892  " Advance Fast"
DS:38A0  " Hold Ground"
DS:38AD  " Seize Position"
DS:38CA  "Font6.fnt"
DS:38D7  "Font8.fnt"
DS:38E4  "\r\nBattleTech:  The Crescent Hawks' Revenge.\r\n(C) 1990 Infocom.\r\n"
DS:3925  "Version #"
DS:392F  "\r\nBoard game design, characters and universe (C) 1990 FASA.\r\n\r\nBattleTech, BattleMech, 'Mech and MechWarrior are registered\r\ntrademarks of FASA Corporation and are used under exclusive\r\nlicense from FASA.  All rights reserved."
DS:3A12  "Tandy users need 541K minimum free memory to run this product.\r\n"
DS:3A53  "You need 525K minimum free memory to run this product.\r\n"
DS:3A8C  "\r\n"
DS:3A8F  "." (version-number decimal separator)
DS:3A91  "VIDEO"
DS:3C05  "\r\nError in MEDIA.CFG.  Please run INSTALL.EXE to correct.\r\n"
DS:3C41  "\r\nUnable to load font(s). Reinstall program.\r\n"
DS:3C70  "Please remove any memory resident programs and try again."
DS:40E0  "Nj2+Nj26Nj2Lng:\rMed:\rCls:\rArm:\rSpd:\r"
DS:4105  "Heat:\r"
DS:410C  "Dmg:"
DS:4111  [V] HeatScaleGraphicTable; six far pointers indexed by CalculateUnitWeaponHeatScale's 00h..05h return value and rendered on the unit-status screen
DS:4185  "Oj2!Oj2/Oj25Oj2:Oj2IOj2UOj2dOj2uOj2Done"
DS:41AD  "Fire at: "
DS:41B9  "Objective: "
DS:41E4  "Oj2Disembark"
DS:41F1  "No Troops"
DS:41FB  "Carrying Infantry"
DS:4212  "Pj2View Satellite Map"
DS:4228  "Intelligence\r"
DS:4236  "Shelling"
DS:423F  " coordinates:\r"
DS:424E  "Rolling Barrage:\r"
DS:4260  "Strafing"
DS:4269  "Scanned by BAP"
DS:4278  "Detected by"
DS:4284  "Radar Sensor"
DS:4292  "Pj2-Pj2Enemy Lances:\r\r\r\r\r\rFriendly:"
DS:42B6  "3Pj2;Pj2@Pj2HPj2NPj2TPj2[Pj2aPj2Dead"
DS:42DB  "Ukwn"
DS:42E0  "From the salvage, you are allocated X opportunities to improve your units."
DS:432B  "Improvements:\r"
DS:4367  "Qj2&Qj2Units:\r"
DS:4376  "CH "
DS:437A  "KH "
DS:437E  "Cancel"
DS:4385  "Can't increase infantry speed."
DS:43A4  "Cannot go any faster."
DS:43BA  "Sensors are at maximum already."
DS:43DA  "Computers at maximum accuracy."
DS:43F9  "ECM equipment at maximum."
DS:4413  "No armor added to infantry."
DS:442F  "Can't mount any more armor."
DS:444B  "That unit can already jump."
DS:4467  "Missiles already installed."
DS:4483  "No missile launchers present."
DS:44A1  "Only 'Mechs can add jumping."
DS:44BE  "Applicable only to infantry."
DS:44DB  "Unit already has infernos."
DS:44F6  "No DropShip to uplink to."
DS:4510  "Satellite Uplink already available."
DS:4534  "No satellite uplink available."
DS:4553  "\rCommand: Uplink is jammed.  Try later."
DS:457B  "Unit already BAP-equipped."
DS:4596  "Unit already equipped with that."
DS:45B7  "You already have four sensors."
DS:45D6  "Place your ground sensor."
DS:45F0  "7Qj2EQj2BAP "
DS:45FD  "Arrow TAG "
DS:4608  "Accuracy "
DS:4612  "Double HS "
DS:461D  " J"
DS:4620  "CU "
DS:4624  "MSG"
DS:4628  "CASE "
DS:462E  "Select area to strafe:"
DS:4645  "Artillery to shell at:"
DS:465C  "Artillery to start barrage at:"
DS:467B  "Artillery to end barrage at:"
DS:4698  " to move to:"
DS:46A5  "Fire at:"
DS:4786  "Vj2!Vj2: "
DS:4790  "\rFormation:"
DS:479C  "SATELLITE ZOOM"
DS:47AB  "Continue"
DS:47B6  "Locust"
DS:47BD  "Wasp"
DS:47C2  "Stinger"
DS:47CA  "Commando"
DS:47D3  "Javelin"
DS:47DB  "Spider"
DS:47E2  "UrbanMech"
DS:47EC  "Valkyrie"
DS:47F5  "Firestarter"
DS:4801  "Jenner"
DS:4808  "Ostscout"
DS:4811  "Panther"
DS:4819  "Assassin"
DS:4822  "Cicada"
DS:4829  "Clint"
DS:482F  "Hermes II"
DS:4839  "Vulcan"
DS:4840  "Whitworth"
DS:484A  "Blackjack"
DS:4854  "Hatchetman"
DS:485F  "Phoenix Hawk"
DS:486C  "Vindicator"
DS:4877  "Centurion"
DS:4881  "Enforcer"
DS:488A  "Hunchback"
DS:4894  "Trebuchet"
DS:489E  "Dervish"
DS:48A6  "Griffin"
DS:48AE  "Shadow Hawk"
DS:48BA  "Scorpion"
DS:48C3  "Wolverine"
DS:48CD  "Dragon"
DS:48D4  "Ostroc"
DS:48DB  "Ostsol"
DS:48E2  "Quickdraw"
DS:48EC  "Rifleman"
DS:48F5  "Catapult"
DS:48FE  "Crusader"
DS:4907  "JagerMech"
DS:4911  "Thunderbolt"
DS:491D  "Archer"
DS:4924  "Grasshopper"
DS:4930  "Warhammer"
DS:493A  "Marauder"
DS:4943  "Orion"
DS:4949  "Awesome"
DS:4951  "Charger"
DS:4959  "Goliath"
DS:4961  "Victor"
DS:4968  "Zeus"
DS:496D  "BattleMaster"
DS:497A  "Stalker"
DS:4982  "Cyclops"
DS:498A  "Banshee"
DS:4992  "Atlas"
DS:4998  "Rommel Tank"
DS:49A4  "Pegasus"
DS:49AC  "Drillson"
DS:49B5  "Mobile HQ"
DS:49BF  "APC"
DS:49C3  "Ammo Carrier"
DS:49D0  "Galleon"
DS:49D8  "Skulker"
DS:49E0  "Infantry"
DS:49E9  "Jump Infantry"
DS:49F7  "Elementals"
DS:4A02  "Puma"
DS:4A07  "Black Hawk"
DS:4A12  "Mad Cat"
DS:4A1A  "Locust+"
DS:4A22  "Locust*"
DS:4A2A  "Wasp+"
DS:4A30  "Wasp*"
DS:4A36  "Commando+"
DS:4A40  "Commando*"
DS:4A4A  "Blackjack+"
DS:4A55  "Phoenix Hawk+"
DS:4A63  "Phoenix Hawk*"
DS:4A71  "Griffin+"
DS:4A7A  "Griffin*"
DS:4A83  "Rifleman+"
DS:4A8D  "Rifleman*"
DS:4A97  "Warhammer+"
DS:4AA2  "Warhammer*"
DS:4AAD  "Marauder+"
DS:4AB7  "Jenner+"
DS:4ABF  "Dragon+"
DS:4AC7  "Shadow Hawk+"
DS:4AD4  "BattleMaster+"
DS:4AE2  "Youngblood"
DS:4AED  "Pearce"
DS:4AF4  "Graham"
DS:4AFB  "Anderson"
DS:4B04  "Reilly"
DS:4B0B  "Casey"
DS:4B11  "Corrigan"
DS:4B1A  "Hall"
DS:4B1F  "Hunter"
DS:4B26  "Barth"
DS:4B2C  "Tatum"
DS:4B32  "Ledesma"
DS:4B3A  "Bellamy"
DS:4B42  "Latham"
DS:4B49  "Louie"
DS:4B4F  "Christman"
DS:4B59  "Townsend"
DS:4B62  "Stewart"
DS:4B6A  "Bouy"
DS:4B6F  "Hill"
DS:4B74  "Accardi"
DS:4B7C  "Briggs"
DS:4B83  "Lebling"
DS:4B8B  "Galley"
DS:4B92  "Blank"
DS:4B98  "Meretzky"
DS:4BA1  "Moriarty"
DS:4BAA  "O'Neill"
DS:4BB2  "Berlyn"
DS:4BB9  "Kirsch"
DS:4BC0  "Berez"
DS:4BC6  "Dornbrook"
DS:4BD0  "Montague"
DS:4BD9  "Sgt. Krall"
DS:4BE4  "Youngblood"
DS:4BEF  "Anderson"
DS:4BF8  "Pearce"
DS:4BFF  "Romero"
DS:4C06  "Carpenter"
DS:4C10  "Cronenberg"
DS:4C1B  "DePalma"
DS:4C23  "Dante"
DS:4C29  "Raimi"
DS:4C2F  "Hooper"
DS:4C36  "Cunningham"
DS:4C41  "Chiun"
DS:4C47  "Toranaga"
DS:4C50  "Yamashita"
DS:4C5A  "Ichi"
DS:4C5F  "Hosaka"
DS:4C66  "Higa"
DS:4C6B  "Sanjuro"
DS:4C73  "Takagi"
DS:4C7A  "Jackson"
DS:4C82  "Lewis"
DS:4C88  "Wylie"
DS:4C8E  "Morton"
DS:4C95  "Vandenburg"
DS:4CA0  "Trainee"
DS:4CA8  "Jason"
DS:4CAE  "Rex"
DS:4CB2  "Kurt"
DS:4CB7  ""Grease""
DS:4CC4  "Chuck"
DS:4CCA  "Clark"
DS:4CD0  "Nance"
DS:4CD6  "Carmen"
DS:4CDD  "Tomas"
DS:4CE3  "Mitchel"
DS:4CEB  "Donald"
DS:4CF2  "Christopher"
DS:4CFE  "Wade"
DS:4D03  "Stewart"
DS:4D0B  "Robert"
DS:4D12  "Joseph"
DS:4D19  "Gabby"
DS:4D1F  "Amanda"
DS:4D26  "Darrel"
DS:4D2D  "Stewart"
DS:4D35  "Marco"
DS:4D3B  "Stefan"
DS:4D42  ""Brain""
DS:4D4A  "Geoff"
DS:4D50  "Marcus"
DS:4D57  "Stella"
DS:4D5E  "J.P."
DS:4D63  "Michell"
DS:4D6B  "Carl"
DS:4D71  "Jason"
DS:4D77  ""Grease""
DS:4D80  "Jen"
DS:4D9A  "Crescent Hawks"
DS:4DA9  "Kell Hounds"
DS:4DB5  "Fed. Suns Cav."
DS:4DC4  "Sword of Light"
DS:4DD3  "Green"
DS:4DD9  "Regular"
DS:4DE1  "Veteran"
DS:4DE9  "Elite"
DS:4DEF  "Excellent"
DS:4DF9  "Good"
DS:4DFE  "Fair"
DS:4E03  "Light"
DS:4E09  "Moderate"
DS:4E12  "Heavy"
DS:4E18  "Brutal"
DS:4E1F  "Devastating"
DS:4E2B  "Incredible"
DS:4E36  "None"
DS:4E3B  "None"
DS:4E40  "Warm"
DS:4E45  "Moderate"
DS:4E4E  "Hot"
DS:4E52  "Dangerous"
DS:4E5C  "Extreme"
DS:4E64  "Shutdown"
DS:4E6D  "None"
DS:4E72  "Slow"
DS:4E77  "Average"
DS:4E7F  "Fast"
DS:4E84  "Very Fast"
DS:4E8E  "Light"
DS:4E94  "Medium"
DS:4E9B  "Heavy"
DS:4EA1  "Massive"
DS:4EA9  "Stripped"
DS:4EB2  "Battered"
DS:4EBB  "Patched"
DS:4EC3  "Breached"
DS:4ECC  "Scorched"
DS:4ED5  "Undamaged"
DS:4EDF  "Commands"
DS:4EE8  "Lance Commands"
DS:4EF7  "Target: "
DS:4F00  "Cease Fire At"
DS:4F0E  "Stop"
DS:4F13  "Walking Speed"
DS:4F21  "Running Speed"
DS:4F2F  "Move\r"
DS:4F35  "Stop"
DS:4F3A  "Cruising Speed"
DS:4F49  "Flank Speed"
DS:4F55  "Fire At No One"
DS:4F64  "Fire Defensively"
DS:4F75  "Fire At Will"
DS:4F82  "Shell Coordinate"
DS:4F93  "Call off Shelling"
DS:4FA5  "Rolling Barrage"
DS:4FB5  "Call off Barrage"
DS:4FC6  "Call Strafing"
DS:4FD4  "Call off Strafing"
DS:4FE6  "Close Assault"
DS:4FF4  "Cease Assault"
DS:5002  "Overburn: Off"
DS:5010  "Overburn: On"
DS:501D  "Out of scanning"
DS:502D  "range"
DS:5033  "Command"
DS:503B  "Fire"
DS:5040  "Assault"
DS:5048  "Recon"
DS:504E  "Light"
DS:5054  "Medium"
DS:505B  "Heavy"
DS:5061  "Assault"
DS:5069  "Increased Firepower"
DS:507D  "Increased Speed"
DS:508D  "Increased Armor"
DS:509D  "Increased Sensors"
DS:50AF  "Increased Accuracy"
DS:50C2  "ECM Jamming"
DS:50CE  "Ground Sensors"
DS:50DD  "Improved Missiles"
DS:50EF  "Inferno Rockets"
DS:50FF  "BAP probing"
DS:510B  "Jump capacity"
DS:5119  "Arrow IV TAG"
DS:5126  "Satellite Uplink"
DS:5137  "L-K Missiles "
DS:5145  "FCS "
DS:514A  "Music:\r"
DS:5152  "Sounds:\r"
DS:515B  "Voice:\r"
DS:5163  "Input:\r"
DS:516B  "Quit Scenario\r"
DS:517A  "Exit to DOS\r"
DS:5187  "Done"
DS:518C  "Off\r"
DS:5191  "On\r"
DS:5195  "Off\r"
DS:519A  "Brief\r"
DS:51A1  "Verbose\r"
DS:51AA  "Keyboard\r"
DS:51B4  "Mouse\r"
DS:51BB  "My 'Mech is crippled!"
DS:51D1  "My 'Mech can't move."
DS:51E6  "No go.  Legs shot off."
DS:51FD  "All movement capability is gone."
DS:521E  "I can't move."
DS:522C  "I'm incapacitated."
DS:523F  "Too much damage!  I'm punching out!"
DS:5263  "My unit's gonna blow!"
DS:5279  "This ride's destroyed.  I'm getting out!"
DS:52A2  "Life support has failed!  I'm gonna die!"
DS:52CB  "My reactor's failed and I can't punch out! I'm roasting!"
DS:5304  "Say goodbye to my family for me..."
DS:5327  "All enemies out of scanning range."
DS:534A  "No units in line of sight."
DS:5365  "I can't see anyone to attack."
DS:5383  "We've boarded the APC, Sir."
DS:539F  "Infantry is aboard the APC."
DS:53BB  "We are now in the APC, Sir."
DS:53D7  "The long range weapons are misfiring."
DS:53FD  "Smoke's pouring from its long range weapons!"
DS:542A  "Its main guns are flaking out."
DS:5449  "Looks like the main weapons are down!"
DS:546F  "Some of the smaller weapons are jammed."
DS:5497  "It's lost almost all of its small guns, sir!"
DS:54C4  "Nothing has scratched it yet, sir."
DS:54E7  "It looks like the paint's chipped a bit."
DS:5510  "The 'Mech appears to be limping, sir!"
DS:5536  "A few more leg hits and he'll stop dead!"
DS:555F  "It's looking pretty beat up."
DS:557C  "His legs are blown off!"
DS:5594  "I think he's out of ammo."
DS:55AE  "The infantry are injured."
DS:55C8  "I think he's overheated!"
DS:55E1  "The unit is moving slowly, sir!"
DS:5601  "The unit is struggling to move!"
DS:5621  "The unit is stopped dead!"
DS:5FD0  "Could not create the file on disk..."
DS:5FF5  "Illegal MODE in Open_File..."
DS:6012  "Insert disk _ in drive _: and press a key..."
DS:603F  "Too many files open..."
DS:6056  "Attempting to close unopened file..."
DS:607B  "Attempting to read unopened file..."
DS:609F  "Attempting to write unopened file..."
DS:60C4  "Attempting to seek unopened file..."
DS:60E8  "Illegal starting position in Seek_File..."
DS:6112  "Attempting to write a resident file..."
DS:6139  "Attempting to Find_Disk_Number on unknown file..."
DS:616B  "Attempting to Get_Resident_Index on unknown file..."
DS:619F  "You are exiting with open files..."
DS:61C2  "A write error has occurred.  Press a key."
DS:61EC  "A fatal disk error has occurred.  Now returning to DOS."

BEGIN GENERATED CONSTANT DS REFERENCE MAP
Every unique seg3A6A->0xNNNN offset found in REVENGE_*.c, in order.
XREF DS rows supplement an earlier canonical DS row; they are not
competing definitions and must not carry a second confidence claim.
Confidence: [V] verified, [P] probable, [H] hypothesis, [U] unknown.
Raw bytes are pre-relocation bytes from REVENGE.EXE; use xrefs and
runtime tracing before assigning a semantic field or table name.
DS:0000  [U] unclassified data; bytes 00 00 00 00 54 75 72 62; xrefs REVENGE_31FB_DIGITAL_SOUND.c:203
DS:00A0  [V] TrainingScenarioCompletionFlags; six completion bytes used by RunCampaignStage13 and save/load.
XREF DS:00AA; xrefs ReadTerrainDamageState
XREF DS:0435; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c, ASM 2007:19C0, 2507:4C70, 2B2D:01CB/02AF/02E3, 2D1B:0131/0147/1A12/1A48/1A61/1AD2/1B26/1B67/1D39/1D5F/1EA4/26C7/26EF
DS:0439  [P] inside WeaponDefinitions; record 0, heat at +04h.
DS:043A  [P] inside WeaponDefinitions; record 0, damage at +05h.
DS:0440  [P] inside WeaponDefinitions; record 0, ammunition family at +0Bh.
XREF DS:058E; xrefs ResetLiveUnitState
DS:05AA  [V] CompressedTextFirstByteTable; 16 first bytes for high-bit text codes; xrefs REVENGE_35CE_FORMATTED_TEXT.c:64, RenderFormattedText
DS:05BA  [V] CompressedTextSecondByteTable; 16 groups x 8 second bytes; xrefs computed access in RenderFormattedText
DS:063A  [V] TextWindowContexts +00; left tile in 17h records x 10h bytes; xrefs SelectTextWindow and DrawClippedSprite
DS:063C  [V] TextWindowContexts +02; top tile; xrefs SelectTextWindow and DrawClippedSprite
DS:063E  [V] TextWindowContexts +04; width in tiles; xrefs SelectTextWindow and DrawClippedSprite
DS:0640  [V] TextWindowContexts +06; height in tiles; xrefs SelectTextWindow and DrawClippedSprite
DS:0642  [V] TextWindowContexts +08; foreground palette color; xrefs SelectTextWindow
DS:0644  [V] TextWindowContexts +0A; background palette color; xrefs SelectTextWindow
DS:0646  [V] TextWindowContexts +0C; cursor column; xrefs SelectTextWindow
DS:0648  [V] TextWindowContexts +0E; cursor row; xrefs SelectTextWindow
DS:0730  [V] inside TextWindowContexts; record 15, field +06h; xrefs campaign presentation procedures.
DS:07AA  [V] UiRegionTable +00; left column in 10h-byte records; xrefs REVENGE_34E6_UI_REGION_POLL.c, REVENGE_3599_UI_REGION_HIGHLIGHT.c, REVENGE_35AB_UI_REGION_SETUP.c
DS:07AC  [V] UiRegionTable +02; top row; xrefs REVENGE_34E6_UI_REGION_POLL.c, REVENGE_3599_UI_REGION_HIGHLIGHT.c, REVENGE_35AB_UI_REGION_SETUP.c
DS:07AE  [V] UiRegionTable +04; width in character cells; xrefs REVENGE_34E6_UI_REGION_POLL.c, REVENGE_3599_UI_REGION_HIGHLIGHT.c, REVENGE_35AB_UI_REGION_SETUP.c
DS:07B0  [V] UiRegionTable +06; item count in rows; xrefs REVENGE_34E6_UI_REGION_POLL.c, REVENGE_3599_UI_REGION_HIGHLIGHT.c, REVENGE_35AB_UI_REGION_SETUP.c
DS:07B2  [V] UiRegionTable +08; current row or selection index; xrefs REVENGE_34E6_UI_REGION_POLL.c, REVENGE_3599_UI_REGION_HIGHLIGHT.c, REVENGE_35AB_UI_REGION_SETUP.c
DS:07B6  [V] UiRegionTable +0C; XOR highlight color; xrefs REVENGE_34E6_UI_REGION_POLL.c, REVENGE_3599_UI_REGION_HIGHLIGHT.c, REVENGE_35AB_UI_REGION_SETUP.c
DS:08C2  [V] TextWindowFrameDefinitionTable; far pointers to FFh-separated corner/edge tile sequences; xrefs REVENGE_334D_TEXT_WINDOW_FRAME.c:16, DrawActiveTextWindowFrame and DrawRepeatingFrameTileSequence
DS:10B0  [V] CachedFileDescriptor +00; DosAddress filename.
DS:10B4  [V] CachedFileDescriptor +04; 32-bit file length.
DS:10B8  [V] CachedFileDescriptor +08; DosAddress cached-data base.
DS:10BC  [V] CachedFileDescriptor +0C; resource drive mask.
DS:10BE  [V] CachedFileDescriptor +0E; 32-bit current stream position.
XREF DS:176A; xrefs REVENGE_1A1F_SCENARIO.c:1713
DS:18CE  [V] SaveDirectorySnapshot; slot-zero directory payload containing occupancy/name records and special-entry flags; xrefs WriteSaveSlot and ReadSaveSlot.
DS:1956  [V] SaveCampaignSnapshot [1956-1B76]; 221h bytes assembled before save and unpacked after load; xrefs WriteSaveSlot and ReadSaveSlot.
DS:1972  [P] SavedScenarioClockSnapshot; three bytes copied to/from DS:855F by SaveGame and LoadGame.
XREF DS:197B; xrefs PrepareScenarioUnitRosters
XREF DS:1993; xrefs PrepareScenarioUnitRosters
DS:19C2  [V] SavedScenarioRecordTable; 18 serialized 0Fh-byte records at snapshot +006Ch; xrefs SaveGame and LoadGame
DS:1AD0  [P] SavedUnitLanceAssignmentTable; 13 serialized 0Ah-byte records at snapshot +017Ah; xrefs SaveGame and LoadGame
DS:1B52  [P] SavedPilotAvailability; 25h one-byte values at snapshot +01FCh; xrefs SaveGame and LoadGame
DS:1B85  [P] ReplayCampaignState; seven-byte replay state copied by RunCampaignLoop and save/load.
DS:1BAD  [P] ReplayExtendedCampaignState; fifteen-byte replay state copied by save/load.
DS:1BBC  [V] UnitSelectionCards; 18 packed 0Fh-byte records mirrored by the save snapshot.
XREF DS:1CCA; xrefs SaveGame, LoadGame, DrawUnitRosterScreen, CompactScenarioLances, and campaign transition helpers.
XREF DS:1D4C
XREF DS:1D4F; xrefs SaveGame, LoadGame, UpdatePilotAvailability and campaign transition helpers.
DS:23E9  [V] TextEntryActive; nonzero during interactive text editing; xrefs EditTextField
DS:23EA  [V] TextEntryCursorIndex; insertion/deletion index; xrefs RenameSaveSlot and EditTextField.
XREF DS:23EC; xrefs EditTextField
DS:23F9  [V] TextEntryBuffer; 16h-byte fixed-width editing buffer; xrefs EditTextField and FillTextEntryBuffer
DS:2411  [V] TitleTextPointers; far-string table consumed by PlayTitleTextSequence.
XREF DS:2459; xrefs ASM 0D73:37F8/3947 in DisplayMissionDate
DS:2562  [V] ExitToDosPrompt; xref ConfirmExitToDos.
DS:2597  [V] restart-game confirmation prompt; xref ConfirmRestartGame.
XREF DS:25E5; xrefs 0D73:24DF ShowMainMenu and menu-table subrange users
DS:2718  [V] MissionFadeColorTable; xrefs mission presentation procedures.
DS:2B0B  [V] DateCommaSpaceText; xref DisplayMissionDate.
DS:2B0D  [V] DateSpaceText; xref DisplayMissionDate.
DS:2B0F  [V] save-slot text-entry prefix; xref RenameSaveSlot.
DS:2B54  [V] CampaignMessageTable; five-byte text-pointer/flag records consumed by campaign presentation procedures.
DS:2B58  [V] CampaignMessageTable entry zero presentationFlags byte.
XREF DS:2ECE; xrefs AdvanceTerrainDamageState
XREF DS:2ED2; xrefs ReadTerrainDamageState
XREF DS:2ED6; xrefs ReadTerrainDamageState
XREF DS:2EDA; xrefs FindUnitAtTacticalCursor
XREF DS:2EEC; xrefs FindUnitAtTacticalCursor
XREF DS:30CB; xrefs ASM 2507:0A5B in proposed DrawUnitAllegianceHeader
XREF DS:30D9; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
DS:30DB  [V] RosterPilotUnitSeparator; NUL-terminated "/"; xrefs DrawUnitRosterScreen
XREF DS:30DD; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
XREF DS:30E0; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
XREF DS:30E7; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
XREF DS:30F2; xrefs ASM 2507:60FA/6136 in proposed stat-header renderers
XREF DS:32D7; xrefs SelectUnitTypeFromList
XREF DS:32DC; xrefs SelectUnitClass
XREF DS:32F8; xrefs SelectUnitClass
DS:3354  [V] FixedRosterPilotIds; 2 pilot IDs; xrefs DrawUnitRosterScreen
DS:3356  [V] FixedRosterUnitTypeIds; 2 MECHTYPE.DAT IDs; xrefs DrawUnitRosterScreen
XREF DS:34C2; xrefs REVENGE_2507_TRAINING.c
DS:359C  [V] RosterLeftColumnX; xrefs DrawUnitRosterScreen
DS:359E  [V] RosterRightColumnX; xrefs DrawUnitRosterScreen
XREF DS:35B0; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
XREF DS:35B8; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
XREF DS:3A8F; xrefs REVENGE_2C7F_STARTUP.c:42, REVENGE_2C7F_STARTUP.c:47
XREF DS:3AD1; xrefs REVENGE_2C7F_STARTUP.c:363
DS:3ADD  [U] unclassified data; bytes 03 4D 43 47 41 00 00 00; xrefs REVENGE_2C7F_STARTUP.c:365
XREF DS:3B12; xrefs REVENGE_2C7F_STARTUP.c:397
DS:3B1E  [U] unclassified data; bytes 04 4D 54 33 32 00 00 00; xrefs REVENGE_2C7F_STARTUP.c:399
XREF DS:3B6D; xrefs REVENGE_2C7F_STARTUP.c:468
DS:3B79  [U] unclassified data; bytes 01 4B 45 59 42 00 00 00; xrefs REVENGE_2C7F_STARTUP.c:470
XREF DS:3B87; xrefs REVENGE_2C7F_STARTUP.c:429
DS:3B93  [U] unclassified data; bytes 05 01 47 4D 42 4C 00 00; xrefs REVENGE_2C7F_STARTUP.c:431
DS:3B94  [U] unclassified data; bytes 01 47 4D 42 4C 00 00 00; xrefs REVENGE_2C7F_STARTUP.c:432
XREF DS:3CAA; xrefs REVENGE_2C7F_STARTUP.c:181, REVENGE_2C7F_STARTUP.c:185
XREF DS:3CB8; xrefs REVENGE_2C7F_STARTUP.c:45
XREF DS:3CBA; xrefs REVENGE_2C7F_STARTUP.c:45
XREF DS:3CBC; xrefs REVENGE_2C7F_STARTUP.c:309
XREF DS:3CBE; xrefs REVENGE_2C7F_STARTUP.c:356
XREF DS:3CC2; xrefs REVENGE_2C7F_STARTUP.c:390
XREF DS:3CC6; xrefs REVENGE_2C7F_STARTUP.c:422
XREF DS:3CCA; xrefs REVENGE_2C7F_STARTUP.c:435
XREF DS:3CCE; xrefs REVENGE_2C7F_STARTUP.c:461
XREF DS:3D0D; xrefs REVENGE_2D1B_TACTICAL_COMBAT.c:1565
XREF DS:3D2E; xrefs ASM 1A1F:466D, 2007:0FDD, 2208:01C7/0C2F/28F6, 2507:06FF/0B74/16CB/275F/27DF/285F/28D2/2940/29C8/2A48/2AC8/2B3B/2BA9/4A84/4C0A/5001, 2B2D:06D4
DS:3E92  [V] PilotSurnameTable [3E92-3F7D]; 59 far pointers indexed by pilot identity; xrefs DrawUnitRosterScreen and 2507:5DBE
DS:3F7E  [V] PilotGivenNameTable [3F7E-4079]; 59 pilot-name pointers followed by four faction-name pointers; xref 2507:5DBE
DS:40B3  [V] PilotExperienceNameTable; Green, Regular, Veteran, Elite; indexed by pilot record +01 in 2507:5DBE
DS:40C3  [V] PilotGunneryNameTable; Excellent, Good, Fair; indexed by pilot record +02 minus 2 in 2507:5DBE
DS:412D  [U] unclassified data; bytes 6D 4E 6A 32 72 4E 6A 32; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
DS:4141  [U] unclassified data; bytes 8E 4E 6A 32 94 4E 6A 32; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
DS:45F8  [V] inside string DS:45F0+8 "7Qj2EQj2BAP "; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
XREF DS:4612; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
XREF DS:4628; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c
DS:563C  [V] SpriteDrawBusy; re-entry guard for adapter-dispatched clipped sprite drawing; xrefs DrawClippedSprite
DS:563E  [V] CachedMusicResourceIndex; FFFFh means no cached track; xrefs AllocateMusicStagingBuffer and LoadMusicResource
XREF DS:58DB; xrefs ASM 3037:078C and StartPCSpeakerEffectStream
DS:5C5C  [V/P/U] DigitalWeaponEffectTable; 16 records x 0Ah, with verified scale/offset/length fields; xrefs PlayDigitalWeaponEffect
DS:5CFC  [V] DigitalSoundEntries +00; code byte in 16h records x 0Bh bytes; xrefs REVENGE_31FB_DIGITAL_SOUND.c:232, FindDigitalSoundEntryByCode
DS:5CFD  [V] DigitalSoundEntries +01; resource index word; xrefs REVENGE_31FB_DIGITAL_SOUND.c:306, LoadScenarioDigitalSoundBank
DS:5CFF  [V] DigitalSoundEntries +03; source file offset low word; xrefs REVENGE_31FB_DIGITAL_SOUND.c:309, LoadScenarioDigitalSoundBank
DS:5D01  [V] DigitalSoundEntries +05; source file offset high word; xrefs LoadScenarioDigitalSoundBank
DS:5D03  [V] DigitalSoundEntries +07; sample byte length; xrefs REVENGE_31FB_DIGITAL_SOUND.c:291, REVENGE_31FB_DIGITAL_SOUND.c:313, REVENGE_31FB_DIGITAL_SOUND.c:617, LoadScenarioDigitalSoundBank and PlayScenarioDigitalSoundSequence
DS:5D05  [V] DigitalSoundEntries +09; runtime offset in packed sample buffer; xrefs REVENGE_31FB_DIGITAL_SOUND.c:292, REVENGE_31FB_DIGITAL_SOUND.c:312, REVENGE_31FB_DIGITAL_SOUND.c:616, LoadScenarioDigitalSoundBank and PlayScenarioDigitalSoundSequence
XREF DS:5DEE; xrefs REVENGE_31FB_DIGITAL_SOUND.c:252
DS:5DF0  [U] unclassified data; bytes 54 00 4A 3D 52 4B 2E 21; xrefs REVENGE_31FB_DIGITAL_SOUND.c:255
DS:5DF2  [U] unclassified data; bytes 4A 3D 52 4B 2E 21 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:259
DS:5DF9  [U] unclassified data; bytes 48 4C 3D 53 32 33 6C 2E; xrefs REVENGE_31FB_DIGITAL_SOUND.c:261
DS:5E03  [U] unclassified data; bytes 4E 4C 3D 32 2E 21 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:263
DS:5E0A  [U] unclassified data; bytes 48 4C 3D 4E 32 33 6C 2E; xrefs REVENGE_31FB_DIGITAL_SOUND.c:265
DS:5E14  [U] unclassified data; bytes 4E 4C 3D 48 32 6C 2E 21; xrefs REVENGE_31FB_DIGITAL_SOUND.c:267
DS:5E1D  [U] unclassified data; bytes 48 4C 3D 32 33 34 2E 21; xrefs REVENGE_31FB_DIGITAL_SOUND.c:269
DS:5E26  [U] unclassified data; bytes 48 4C 3D 46 56 32 33 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:271
DS:5E32  [U] unclassified data; bytes 43 4C 3D 66 73 32 33 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:273
DS:5E3E  [U] unclassified data; bytes 48 4C 3D 46 56 32 33 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:275
DS:5E4A  [U] unclassified data; bytes 48 4C 3D 46 72 32 33 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:277
DS:5E56  [U] unclassified data; bytes 48 4C 3D 46 53 32 33 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:279
DS:5E62  [U] unclassified data; bytes 43 4C 3D 66 73 32 33 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:281
XREF DS:5E6E; xrefs REVENGE_31FB_DIGITAL_SOUND.c:334
DS:5E70  [U] unclassified data; bytes 54 00 4A 3D 00 3D 00 52; xrefs REVENGE_31FB_DIGITAL_SOUND.c:337
DS:5E72  [U] unclassified data; bytes 4A 3D 00 3D 00 52 00 4B; xrefs REVENGE_31FB_DIGITAL_SOUND.c:574
DS:5E75  [U] unclassified data; bytes 3D 00 52 00 4B 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:576
DS:5E77  [U] unclassified data; bytes 52 00 4B 00 21 00 2E 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:578
DS:5E79  [U] unclassified data; bytes 4B 00 21 00 2E 00 48 4C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:580
DS:5E7B  [U] unclassified data; bytes 21 00 2E 00 48 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:582
DS:5E7D  [U] unclassified data; bytes 2E 00 48 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:584
DS:5E7F  [U] unclassified data; bytes 48 4C 3D 00 3D 00 48 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:556
DS:5E83  [U] unclassified data; bytes 3D 00 48 32 00 48 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:558
DS:5E85  [U] unclassified data; bytes 48 32 00 48 33 00 53 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:560
DS:5E88  [U] unclassified data; bytes 48 33 00 53 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:562
DS:5E8B  [U] unclassified data; bytes 53 6C 00 21 00 2E 00 4E; xrefs REVENGE_31FB_DIGITAL_SOUND.c:564
DS:5E8E  [U] unclassified data; bytes 21 00 2E 00 4E 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:566
DS:5E90  [U] unclassified data; bytes 2E 00 4E 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:568
DS:5E92  [U] unclassified data; bytes 4E 4C 3D 00 3D 00 4E 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:347
DS:5E96  [U] unclassified data; bytes 3D 00 4E 32 00 21 00 2E; xrefs REVENGE_31FB_DIGITAL_SOUND.c:349
DS:5E98  [U] unclassified data; bytes 4E 32 00 21 00 2E 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:350
DS:5E9B  [U] unclassified data; bytes 21 00 2E 00 48 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:352
DS:5E9D  [U] unclassified data; bytes 2E 00 48 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:354
DS:5E9F  [U] unclassified data; bytes 48 4C 3D 00 3D 00 48 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:538
DS:5EA3  [U] unclassified data; bytes 3D 00 48 32 00 48 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:540
DS:5EA5  [U] unclassified data; bytes 48 32 00 48 33 00 4E 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:542
DS:5EA8  [U] unclassified data; bytes 48 33 00 4E 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:544
DS:5EAB  [U] unclassified data; bytes 4E 6C 00 21 00 2E 00 4E; xrefs REVENGE_31FB_DIGITAL_SOUND.c:546
DS:5EAE  [U] unclassified data; bytes 21 00 2E 00 4E 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:548
DS:5EB0  [U] unclassified data; bytes 2E 00 4E 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:550
DS:5EB2  [U] unclassified data; bytes 4E 4C 3D 00 3D 00 4E 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:522
DS:5EB6  [U] unclassified data; bytes 3D 00 4E 32 00 48 6C 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:524
DS:5EB8  [U] unclassified data; bytes 4E 32 00 48 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:526
DS:5EBB  [U] unclassified data; bytes 48 6C 00 21 00 2E 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:528
DS:5EBE  [U] unclassified data; bytes 21 00 2E 00 48 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:530
DS:5EC0  [U] unclassified data; bytes 2E 00 48 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:532
DS:5EC2  [U] unclassified data; bytes 48 4C 3D 00 3D 00 48 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:504
DS:5EC6  [U] unclassified data; bytes 3D 00 48 32 00 48 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:506
DS:5EC8  [U] unclassified data; bytes 48 32 00 48 33 00 48 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:508
DS:5ECB  [U] unclassified data; bytes 48 33 00 48 34 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:510
DS:5ECE  [U] unclassified data; bytes 48 34 00 21 00 2E 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:512
DS:5ED1  [U] unclassified data; bytes 21 00 2E 00 48 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:514
DS:5ED3  [U] unclassified data; bytes 2E 00 48 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:516
DS:5ED5  [U] unclassified data; bytes 48 4C 3D 00 3D 00 48 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:365
DS:5ED9  [U] unclassified data; bytes 3D 00 48 32 00 48 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:367
DS:5EDB  [U] unclassified data; bytes 48 32 00 48 33 00 48 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:369
DS:5EDE  [U] unclassified data; bytes 48 33 00 48 34 00 46 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:371
DS:5EE1  [U] unclassified data; bytes 48 34 00 46 6C 00 56 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:373
DS:5EE4  [U] unclassified data; bytes 46 6C 00 56 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:375
DS:5EE7  [U] unclassified data; bytes 56 6C 00 21 00 2E 00 43; xrefs REVENGE_31FB_DIGITAL_SOUND.c:377
DS:5EEA  [U] unclassified data; bytes 21 00 2E 00 43 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:379
DS:5EEC  [U] unclassified data; bytes 2E 00 43 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:381
DS:5EEE  [U] unclassified data; bytes 43 4C 3D 00 3D 00 43 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:482
DS:5EF2  [U] unclassified data; bytes 3D 00 43 32 00 43 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:484
DS:5EF4  [U] unclassified data; bytes 43 32 00 43 33 00 43 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:486
DS:5EF7  [U] unclassified data; bytes 43 33 00 43 34 00 66 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:488
DS:5EFA  [U] unclassified data; bytes 43 34 00 66 6C 00 73 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:490
DS:5EFD  [U] unclassified data; bytes 66 6C 00 73 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:492
DS:5F00  [U] unclassified data; bytes 73 6C 00 21 00 2E 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:494
DS:5F03  [U] unclassified data; bytes 21 00 2E 00 48 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:496
DS:5F05  [U] unclassified data; bytes 2E 00 48 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:498
DS:5F07  [U] unclassified data; bytes 48 4C 3D 00 3D 00 48 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:460
DS:5F0B  [U] unclassified data; bytes 3D 00 48 32 00 48 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:462
DS:5F0D  [U] unclassified data; bytes 48 32 00 48 33 00 48 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:464
DS:5F10  [U] unclassified data; bytes 48 33 00 48 34 00 46 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:466
DS:5F13  [U] unclassified data; bytes 48 34 00 46 6C 00 56 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:468
DS:5F16  [U] unclassified data; bytes 46 6C 00 56 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:470
DS:5F19  [U] unclassified data; bytes 56 6C 00 21 00 2E 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:472
DS:5F1C  [U] unclassified data; bytes 21 00 2E 00 48 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:474
DS:5F1E  [U] unclassified data; bytes 2E 00 48 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:476
DS:5F20  [U] unclassified data; bytes 48 4C 3D 00 3D 00 48 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:438
DS:5F24  [U] unclassified data; bytes 3D 00 48 32 00 48 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:440
DS:5F26  [U] unclassified data; bytes 48 32 00 48 33 00 48 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:442
DS:5F29  [U] unclassified data; bytes 48 33 00 48 34 00 46 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:444
DS:5F2C  [U] unclassified data; bytes 48 34 00 46 6C 00 72 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:446
DS:5F2F  [U] unclassified data; bytes 46 6C 00 72 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:448
DS:5F32  [U] unclassified data; bytes 72 6C 00 21 00 2E 00 48; xrefs REVENGE_31FB_DIGITAL_SOUND.c:450
DS:5F35  [U] unclassified data; bytes 21 00 2E 00 48 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:452
DS:5F37  [U] unclassified data; bytes 2E 00 48 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:454
DS:5F39  [U] unclassified data; bytes 48 4C 3D 00 3D 00 48 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:416
DS:5F3D  [U] unclassified data; bytes 3D 00 48 32 00 48 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:418
DS:5F3F  [U] unclassified data; bytes 48 32 00 48 33 00 48 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:420
DS:5F42  [U] unclassified data; bytes 48 33 00 48 34 00 46 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:422
DS:5F45  [U] unclassified data; bytes 48 34 00 46 6C 00 53 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:424
DS:5F48  [U] unclassified data; bytes 46 6C 00 53 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:426
DS:5F4B  [U] unclassified data; bytes 53 6C 00 21 00 2E 00 43; xrefs REVENGE_31FB_DIGITAL_SOUND.c:428
DS:5F4E  [U] unclassified data; bytes 21 00 2E 00 43 4C 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:430
DS:5F50  [U] unclassified data; bytes 2E 00 43 4C 3D 00 3D 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:432
DS:5F52  [U] unclassified data; bytes 43 4C 3D 00 3D 00 43 32; xrefs REVENGE_31FB_DIGITAL_SOUND.c:394
DS:5F56  [U] unclassified data; bytes 3D 00 43 32 00 43 33 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:396
DS:5F58  [U] unclassified data; bytes 43 32 00 43 33 00 43 34; xrefs REVENGE_31FB_DIGITAL_SOUND.c:398
DS:5F5B  [U] unclassified data; bytes 43 33 00 43 34 00 66 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:400
DS:5F5E  [U] unclassified data; bytes 43 34 00 66 6C 00 73 6C; xrefs REVENGE_31FB_DIGITAL_SOUND.c:402
DS:5F61  [U] unclassified data; bytes 66 6C 00 73 6C 00 21 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:404
DS:5F64  [U] unclassified data; bytes 73 6C 00 21 00 2E 00 00; xrefs REVENGE_31FB_DIGITAL_SOUND.c:406
DS:5F67  [U] unclassified data; bytes 21 00 2E 00 00 03 00 01; xrefs REVENGE_31FB_DIGITAL_SOUND.c:408
DS:5F69  [U] unclassified data; bytes 2E 00 00 03 00 01 00 07; xrefs REVENGE_31FB_DIGITAL_SOUND.c:410
DS:5FCA  [V] InvalidSaveDialogBacking; modal save-version dialog's
         captured-video backing buffer (stored as a 16:16 pointer in DOS).
DS:6224  [V] NumericKeypadNavigationEnabled; word flag controlling
         keypad-key remapping in NormalizeNavigationKeyCode.
DS:6226  [V] CgaNarrowStrideMode; word flag passed to the CGA packed-
         pixel mask conversion after direct icon-page decoding.
DS:6228  [V] UiSelectionResetFlagA; forces the initial selected row to
         zero when a region-selection interaction begins.
DS:622A  [V] UiSelectionResetFlagB; second flag with the same observed
         row-reset effect. Their higher-level distinction is not yet known.
DS:622E  [V] ActiveTextWindowIndex; selects one TextWindowContexts record; xrefs SelectTextWindow
DS:6230  [V] ActiveTextWindowLeftTile; horizontal origin in 8-pixel cells; xrefs text/menu rendering paths
DS:6232  [V] ActiveTextWindowTopTile; vertical origin in 8-pixel cells; xrefs text/menu rendering paths
DS:6234  [V] ActiveTextWindowWidthTiles; horizontal extent in 8-pixel cells; xrefs RenderFormattedText and text/menu rendering paths
DS:6242  [V] UiNavigationUpKey; translated key that selects the prior row.
DS:6244  [V] UiNavigationDownKey; translated key that selects the next row.
DS:6246  [V] UiPreviousRegionKey; translated key that selects the prior UI region.
DS:6248  [V] UiNextRegionKey; translated key that selects the next UI region.
DS:6236  [V] ActiveTextWindowHeightTiles; vertical extent in 8-pixel cells; xrefs text/menu rendering paths
DS:6238  [V] ActiveTextForegroundColor; foreground palette index; xrefs RenderFormattedText and text/menu rendering paths
DS:623A  [V] ActiveTextBackgroundColor; background palette index; xrefs RenderFormattedText and text/menu rendering paths
DS:623C  [V] ActiveTextCursorColumn; xrefs RenderFormattedText and text/menu rendering paths
DS:623E  [V] ActiveTextCursorRow; xrefs RenderFormattedText and text/menu rendering paths
DS:6240  [V] TextWindowStateInitialized; suppresses an invalid context save before first selection; xrefs SelectTextWindow
XREF DS:62BA; xrefs REVENGE_3621_MIDI_SEQUENCE.c:462
XREF DS:6420; xrefs REVENGE_3621_MIDI_SEQUENCE.c:458
XREF DS:6D18; xrefs REVENGE_3717_PC_SPEAKER_CONVERSION.c:127
DS:6F4C  [V] DigitalPlaybackTimerQueue; 12h-byte queue/control block bound to the null output descriptor while IRQ0 drives the mixer; xrefs InstallDigitalPlaybackTimer
DS:6F5E  [V] DigitalCalibrationQueue; 12h-byte queue/control block used by playback-rate calibration; xrefs CalibrateDigitalPlaybackRate
DS:6F70  [V] DigitalCalibrationSample; 34h-byte silent descriptor serviced 0E0Dh times; xrefs CalibrateDigitalPlaybackRate
DS:6FA4  [V] PITCalibration; exact 0Ah-byte calibration record.
         +00 channel-0 divisor; +02 saved INT 08h DosAddress;
         +06 saved FLAGS; +08 latched channel-0 count.
XREF DS:7A73; xrefs AdvanceTerrainDamageState
DS:7B1C  [V] SpriteClipLeftTile_7B1C through SpriteClipBottomPixel_7B22; active clipped-sprite bounds; xrefs DrawClippedSprite and adapter-specific sprite decoders
DS:7D67  [P] Sprite clipping-bound mirror at 7D67-7D6D; exact copy of 7B1C-7B22; xrefs DrawClippedSprite
DS:7FA0  [V] MouseButtonState; current button bitmask sampled with interrupts disabled.
DS:7FA4  [V] PendingMouseButtonEvent; latched mouse event cleared after polling.
DS:7FAA  [V] MouseY; current mouse Y coordinate used to select a region row.
DS:7FB2  [V] MouseInputDisabled; nonzero bypasses mouse processing in selection loops.
DS:800A  [V] SoundEffectsEnabled; SOUND option and PC-speaker/digital effect gate; xrefs ServiceMusicAndCheckKeyboardInput, PlayPCSpeakerEffectByIndex, PlayDigitalWeaponEffect
DS:8014  [P] MusicDriverPlaybackMode; 01h for drivers 0-3, 02h for driver 4; xrefs InitializeMusicDriver
XREF DS:8106; xrefs BeginTerrainDamageAtCell and staged updater 2007:042A
XREF DS:810C; xrefs REVENGE_1A1F_SCENARIO.c:1701, REVENGE_1A1F_SCENARIO.c:1702
XREF DS:8337; xrefs REVENGE_1A1F_SCENARIO.c:289, REVENGE_30F1_SCENARIO_ROSTERS.c:59, PrepareScenarioUnitRosters and AdvanceCampaignClock
XREF DS:833E; xrefs CalculateUnitDurabilityTotals and combat/status consumers
XREF DS:83EA; xrefs ReadTerrainDamageState and ApplyTerrainImpact
XREF DS:855F; xrefs REVENGE_1A1F_SCENARIO.c, REVENGE_30F1_SCENARIO_ROSTERS.c, PrepareScenarioUnitRosters and campaign save/load.
XREF DS:8562; xrefs PrepareScenarioUnitRosters
XREF DS:857B; xrefs PrepareScenarioUnitRosters
XREF DS:85B0; xrefs PrepareScenarioUnitRosters and CompactScenarioLances
XREF DS:8650; xrefs SelectLanceFormationMode
XREF DS:8666; xrefs REVENGE_35CE_FORMATTED_TEXT.c:74, REVENGE_35CE_FORMATTED_TEXT.c:90, REVENGE_35CE_FORMATTED_TEXT.c:107, REVENGE_35CE_FORMATTED_TEXT.c:124, REVENGE_35CE_FORMATTED_TEXT.c:163, REVENGE_35CE_FORMATTED_TEXT.c:165, REVENGE_35CE_FORMATTED_TEXT.c:211
XREF DS:86BB; xrefs CalculateUnitDurabilityTotals and combat/status consumers
XREF DS:86BE; xrefs TraceMapLineOfSight
XREF DS:86C0; xrefs TraceMapLineOfSight
DS:8823  [V] TacticalCellTerrainMap; far pointer to the 228-word terrain and terrain-overlay layer; xrefs BuildTacticalTerrainCellMaps and StampTacticalSpriteRectangle
XREF DS:8859; xrefs REVENGE_1A1F_SCENARIO.c:1693, AdvanceTerrainDamageState
XREF DS:88BF; xrefs REVENGE_2507_UNIT_ASSIGNMENT.c, REVENGE_2B34_UNIT_STATUS.c:95, REVENGE_2B34_UNIT_STATUS.c:173, REVENGE_2B34_UNIT_STATUS.c:242, REVENGE_2B34_UNIT_STATUS.c:280
XREF DS:890C; xrefs tactical command panel, ExecuteUnitWeaponAI, UpdateUnitHeatShutdown, RebuildLanceFormationAfterLeaderLoss
XREF DS:8B81; xrefs scenario roster helpers in REVENGE_30F1_SCENARIO_ROSTERS.c
DS:8B83  [P] PersistentUnitRoster record 0 +02h walkMovement; xrefs InvalidateEmptyRosterSlots
DS:8C05  [V] PersistentUnitRoster record 0 +84h tonnage; xrefs UpdatePilotAvailability
DS:8C13  [P] PersistentUnitRoster record 0 +92h pilotId; xrefs UpdatePilotAvailability
DS:99B1  [U] unclassified data; bytes [not initialized in the load image: BSS/runtime data]; xrefs REVENGE_2D1B_TACTICAL_COMBAT.c:1867
DS:99BC  [V] TacticalCellSpriteMap; far pointer to the 228-word unit/effect sprite layer; xrefs BuildTacticalTerrainCellMaps and StampTacticalSpriteRectangle
XREF DS:99E0; xrefs scenario roster helpers and campaign save/load.
DS:99E2  [P] LiveScenarioUnits record 0 +02h walkMovement; xrefs ResetLiveUnitState
DS:9A35  [H] LiveScenarioUnits record 0 +55h critical/equipment group A; xrefs ResetLiveUnitState
DS:9A64  [V] LiveScenarioUnits record 0 +84h tonnage; xrefs campaign transition helpers
DS:9A65  [U] LiveScenarioUnits record 0 +85h runtime state A; xrefs ResetLiveUnitState
DS:9A66  [U] LiveScenarioUnits record 0 +86h runtime state B; xrefs ResetLiveUnitState
DS:9A72  [P] LiveScenarioUnits record 0 +92h pilotId; xrefs campaign transition helpers
XREF DS:A865; xrefs REVENGE_2D1B_TACTICAL_COMBAT.c:1378
XREF DS:AE5F; xrefs ReadTerrainDamageState
XREF DS:AE9D; xrefs RebuildLanceFormationAfterLeaderLoss
XREF DS:B02A; xrefs REVENGE_1A1F_SCENARIO.c:1690, REVENGE_2D1B_TACTICAL_COMBAT.c:530, REVENGE_2D1B_TACTICAL_COMBAT.c:844
XREF DS:B02C; xrefs REVENGE_1A1F_SCENARIO.c:1689
XREF DS:B047; xrefs ReadTerrainDamageState and AdvanceTerrainDamageState
XREF DS:B28E; xrefs ApplyOrQueueTerrainDamage and staged updater 2007:042A
DS:B579  [U] unclassified data; bytes [not initialized in the load image: BSS/runtime data]; xrefs REVENGE_2D1B_TACTICAL_COMBAT.c:1868
XREF DS:B581; xrefs PrepareScenarioUnitRosters and CompactScenarioLances
DS:B587  [V] UnitConsecutiveAttackTicks; 24 counters incremented when the unit was attacked during the frame and reset otherwise; xrefs ExecuteUnitWeaponAI and RebuildLanceFormationAfterLeaderLoss
DS:B5B9  [P] UnitLanceFormationState; per-unit leader/regroup state bytes; xrefs IsCurrentLanceLeader and RebuildLanceFormationAfterLeaderLoss
XREF DS:B5E4; xrefs REVENGE_2C7F_STARTUP.c:164, REVENGE_2C7F_STARTUP.c:181, REVENGE_2C7F_STARTUP.c:186
XREF DS:B5F4; xrefs REVENGE_2C7F_STARTUP.c:164, REVENGE_2C7F_STARTUP.c:186
DS:B60A  [V] MusicStagingBuffer; reconstructed native pointer to the 30D4h-byte music buffer; xrefs REVENGE_3014_MUSIC_RESOURCES.c
DS:B60E  [V] ActiveDigitalSampleDescriptor; current far descriptor pointer during synchronous playback; xrefs PlayScenarioDigitalSoundSequence
DS:B612  [V] DigitalDriverHardwareOffset; selected hardware-descriptor near offset; xrefs InitializeDigitalSoundDriver
DS:B614  [V] DigitalDriverQueue; 12h-byte intrusive-list/control block for active sampled audio; xrefs InitializeDigitalSoundDriver and PlayScenarioDigitalSoundSequence
DS:B626  [V] DigitalPlaybackRateHz; calibrated output rate capped at 8000 Hz; xrefs InitializeDigitalSoundDriver and sampled-audio playback
DS:B628  [V] DigitalWeaponEffectRepeatCount; completion passes for effects 06h and 0Fh; xrefs PlayDigitalWeaponEffect and HandleDigitalWeaponEffectCompletion
DS:B629  [P] DigitalWeaponSampleBuffer; reconstructed host pointer
         replacing the original offset/segment pair at DS:B629/B62B; packed
         weapon-effect PCM bank base; xrefs PlayDigitalWeaponEffect
DS:B632  [V] ResourceFiles.errorText; retained 16:16 error-message pointer.
DS:B636  [V] ResourceFiles.pendingDriveMask; drive requested by the current
         open/retry operation.
DS:B638  [V] ResourceFiles.availableDriveMask; union of descriptor drive masks.
DS:B63A  [V] ResourceFiles.trackedHandles; ten words, 7FFFh free, bit 15
         memory-backed; xrefs REVENGE_3390_RESOURCE_STREAM.c.
DS:B64E  [V] ResourceFiles.preloadFiles; enables cache preloading.
DS:B652  [V] ActiveUiHighlightXorColor; xrefs PollUiRegionSelection, ToggleActiveUiRegionHighlight
DS:B654  [V] ActiveUiHighlightHeight; pixels; xrefs PollUiRegionSelection, ToggleActiveUiRegionHighlight
DS:B656  [V] ActiveUiHighlightWidth; pixels; xrefs PollUiRegionSelection, ToggleActiveUiRegionHighlight
DS:B658  [V] ActiveUiHighlightLeft; pixel coordinate; xrefs PollUiRegionSelection, ToggleActiveUiRegionHighlight
DS:B65A  [V] ActiveUiHighlightTop; pixel coordinate; xrefs PollUiRegionSelection, ToggleActiveUiRegionHighlight
DS:B65E  [V] PrimaryScreenBufferOffset; offset half of the active
         packed screen buffer remapped to A200:0000 for EGA region copies.
DS:B660  [V] PrimaryScreenBufferSegment; matching segment half.
DS:B662  [V] SecondaryResourceDriveEnabled; enables switching to DOS
         drive B for a positive resource-drive index.
DS:B668  [V] ResourceDriveSelectionDisabled; suppresses all DOS drive
         selection when nonzero.
DS:7D3B  [V] ActiveRenderTargetOffset; offset selected by
         SetActiveRenderTarget for drawing operations.
DS:7D3D  [V] ActiveRenderTargetSegment; matching segment half. EGA
         remaps the primary backing buffer to planar A200:0000.
DS:B66A  [V] SavedUiRegionSelectionRows; byte array restored on grouped-selection cancel; xrefs PollUiRegionSelection, HighlightUiRegionSelection, BeginUiRegionSelection
DS:B6CE  [V] VideoAdapterType; word adapter selector: 00h CGA,
         01h Tandy/PCjr, 02h EGA, and 03h VGA. Capture8x8VideoTile
         verifies the adapter-native tile widths and row strides.
DS:B6D0  [V] ActiveUiRegionIndex; indexes 10h-byte UiRegionTable records; xrefs REVENGE_34E6_UI_REGION_POLL.c, REVENGE_3599_UI_REGION_HIGHLIGHT.c, REVENGE_35AB_UI_REGION_SETUP.c
DS:B6D2  [V] ExpandFirstUiRowHighlight; when nonzero and selected row
         is zero, the XOR highlight spans the region's complete row count.
XREF DS:B808; xrefs REVENGE_38C6_PROCESS_EXIT.c:22
END GENERATED CONSTANT DS REFERENCE MAP
