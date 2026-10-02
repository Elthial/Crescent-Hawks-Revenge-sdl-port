;;; Segment 356D (356D:0000)
356D:0000 EB 00                                           ..              

l3568_0052:
3568:0052 5F              	pop	di
3568:0053 5E              	pop	si
3568:0054 5D              	pop	bp
3568:0055 CB              	retf

;; ClearActiveTextWindow_0006: 356D:0006
;;   Called from:
;;     0D73:2AD9 (in OpenModalTextWindow_2A5D)
;;     0D73:46A6 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:4ED4 (in ShowSaveLoadMenu_4EC7)
;;     1A1F:4247 (in RunGameOptionsMenu_417F)
;;     2007:0F3C (in DrawSelectedUnitStatusPanel_0E19)
;;     3349:0015 (in SelectAndClearTextWindow_0009)
ClearActiveTextWindow_0006 proc
356D:0006 FF 36 3A 62     	push	word ptr [623Ah]
356D:000A FF 36 36 62     	push	word ptr [6236h]
356D:000E FF 36 34 62     	push	word ptr [6234h]
356D:0012 FF 36 32 62     	push	word ptr [6232h]
356D:0016 FF 36 30 62     	push	word ptr [6230h]
356D:001A 9A B0 2D 00 08  	call	far 0800h:2DB0h
356D:001F 83 C4 0A        	add	sp,0Ah
