;;; Segment 3349 (3349:0000)
3349:0000 8B 47 0E A3 3E 62 5E 5D CB                      .G..>b^].       

;; SelectAndClearTextWindow_0009: 3349:0009
;;   Called from:
;;     1A1F:41CE (in RunGameOptionsMenu_417F)
;;     1A1F:4FE5 (in ShowPendingNarrationPrompt_4FA6)
;;     2007:16C8 (in RedrawTacticalStatusPanel_16BA)
;;     2208:00D1 (in RunTacticalUnitCommandMenu_000B)
;;     2208:14CD (in RunTacticalGameOptionsMenu_148A)
;;     2B34:0592 (in DrawTacticalUnitControlPanel_04C2)
SelectAndClearTextWindow_0009 proc
3349:0009 55              	push	bp
3349:000A 8B EC           	mov	bp,sp
3349:000C FF 76 06        	push	word ptr [bp+6h]
3349:000F 9A 09 00 38 33  	call	far 3338h:0009h
