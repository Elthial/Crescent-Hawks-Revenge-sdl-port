;;; Segment 397E (397E:0000)
397E:0000 5E 5D CB                                        ^].             

;; StringLength: 397E:0003
;;   Called from:
;;     0D73:2629 (in RunMainMenuSelection_25F5)
;;     0D73:2665 (in RunMainMenuSelection_25F5)
;;     0D73:267A (in RunMainMenuSelection_25F5)
;;     0D73:26CE (in RunMainMenuSelection_25F5)
;;     0D73:3F02 (in DrawCenteredClippedText_3E35)
;;     0D73:3FAF (in DrawLeftAlignedClippedText_3F57)
;;     0D73:404A (in DrawRightAlignedClippedText_3FF2)
;;     0D73:419C (in RightAlignStringField_418E)
;;     0D73:41F9 (in RemoveLeadingSpacesFrom_41E8)
;;     0D73:4246 (in TrimTrailingEncodedSpaces_4238)
;;     0D73:4296 (in TranslateCharactersInPlace_4288)
;;     0D73:42A6 (in TranslateCharactersInPlace_4288)
;;     0D73:42EF (in PadStringToWidth_42E4)
;;     0D73:4331 (in EditTextField_4317)
;;     0D73:43B2 (in EditTextField_4317)
;;     0D73:453B (in EditTextField_4317)
;;     0D73:5123 (in ShowSaveLoadMenu_4EC7)
;;     0D73:520A (in IsBlankSaveSlotName_51F9)
;;     0D73:52AC (in RenameSaveSlot_5233)
;;     0D73:535C (in RenameSaveSlot_5233)
;;     0D73:5440 (in WaitForAcknowledgement_53E1)
;;     1A1F:5021 (in ShowPendingNarrationPrompt_4FA6)
;;     1A1F:5055 (in ShowPendingNarrationPrompt_4FA6)
;;     1A1F:5081 (in ShowPendingNarrationPrompt_4FA6)
;;     2007:1064 (in DrawSelectedUnitStatusPanel_0E19)
;;     2B34:0A9C (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0BA0 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0FF1 (in DrawCenteredTextInActiveWindow_0FDB)
;;     3477:01D7 (in MeasureTextWidth_01B5)
;;     356F:012D (in RenderTextToActiveWindow_000B)
;;     356F:01BE (in RenderTextToActiveWindow_000B)
;;     3A3C:002E (in InitializeTimezoneFromEnvironment)
;;     3A3C:0178 (in InitializeTimezoneFromEnvironment)
StringLength proc
397E:0003 55              	push	bp
397E:0004 8B EC           	mov	bp,sp
397E:0006 56              	push	si
397E:0007 57              	push	di
397E:0008 FC              	cld
397E:0009 C4 7E 06        	les	di,[bp+6h]
397E:000C 32 C0           	xor	al,al
397E:000E B9 FF FF        	mov	cx,0FFFFh
