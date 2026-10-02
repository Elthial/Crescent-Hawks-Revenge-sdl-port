;;; Segment 3983 (3983:0000)

;; FarStringCopy: 3983:0000
;;   Called from:
;;     0D73:37FF (in DisplayMissionDate_376C)
;;     0D73:394E (in DisplayMissionDate_376C)
;;     0D73:3DEB (in UpdateTextEntryCursorBlink_3DA9)
;;     0D73:4399 (in EditTextField_4317)
;;     0D73:505C (in ShowSaveLoadMenu_4EC7)
;;     0D73:5174 (in ShowSaveLoadMenu_4EC7)
;;     0D73:53C3 (in RenameSaveSlot_5233)
;;     2507:0A62 (in DrawUnitAllegianceHeader_0A20)
;;     2507:2723 (in DrawUnitRosterScreen_26EE)
;;     2507:27A3 (in DrawUnitRosterScreen_26EE)
;;     2507:2823 (in DrawUnitRosterScreen_26EE)
;;     2507:28A8 (in DrawUnitRosterScreen_26EE)
;;     2507:2916 (in DrawUnitRosterScreen_26EE)
;;     2507:298C (in DrawUnitRosterScreen_26EE)
;;     2507:2A0C (in DrawUnitRosterScreen_26EE)
;;     2507:2A8C (in DrawUnitRosterScreen_26EE)
;;     2507:2B11 (in DrawUnitRosterScreen_26EE)
;;     2507:2B7F (in DrawUnitRosterScreen_26EE)
;;     2507:4B5B (in DrawUnitStatusScreen_483A)
;;     2507:4D3A (in DrawUnitStatusScreen_483A)
;;     2507:4DD3 (in DrawUnitStatusScreen_483A)
;;     2B34:069F (in DrawTacticalUnitControlPanel_04C2)
;;     31FB:02B9 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:02D4 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:02F5 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:0310 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:032B (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:0346 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:0361 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:037C (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:03A3 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:03C4 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:03DE (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:03FE (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:0418 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:0432 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:0768 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0783 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:07AF (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:07C3 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0845 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0859 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:08F3 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0907 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:096E (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0982 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0A1F (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0A33 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0AB5 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0AC9 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0B72 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0B86 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0C62 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0C76 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0D49 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0D5D (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0E39 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0E4D (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0F20 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:0F34 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:1007 (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:101B (in PlayScenarioDigitalSoundSequence_0742)
;;     35CE:0426 (in RenderFormattedText_000A)
;;     3A3C:00D5 (in InitializeTimezoneFromEnvironment)
;;     3A3C:00EA (in InitializeTimezoneFromEnvironment)
FarStringCopy proc
3983:0000 55              	push	bp
3983:0001 8B EC           	mov	bp,sp
3983:0003 56              	push	si
3983:0004 57              	push	di
3983:0005 FC              	cld
3983:0006 C4 7E 0A        	les	di,[bp+0Ah]
3983:0009 8B F7           	mov	si,di
3983:000B 32 C0           	xor	al,al
3983:000D B9 FF FF        	mov	cx,0FFFFh

l3983_0010:
3983:0010 F2 AE           	repne scasb

l3983_0012:
3983:0012 F7 D1           	not	cx
3983:0014 1E              	push	ds
3983:0015 06              	push	es
3983:0016 1F              	pop	ds
3983:0017 C4 7E 06        	les	di,[bp+6h]

l3983_001A:
3983:001A F3 A4           	rep movsb

l3983_001C:
3983:001C 1F              	pop	ds
3983:001D 8B 56 08        	mov	dx,[bp+8h]
