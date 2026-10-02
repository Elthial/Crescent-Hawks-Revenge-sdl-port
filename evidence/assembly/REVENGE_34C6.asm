;;; Segment 34C6 (34C6:0000)
34C6:0000 01 00                                           ..              

l34B8_00E2:
34B8:00E2 5F              	pop	di
34B8:00E3 5E              	pop	si
34B8:00E4 8B E5           	mov	sp,bp
34B8:00E6 5D              	pop	bp
34B8:00E7 CB              	retf

;; RandomInRangeInclusive: 34C6:0008
;;   Called from:
;;     1A1F:0DDA (in DrawWeaponAttackTrace_0D55)
;;     1A1F:1A09 (in CreateRandomAreaImpact_19FD)
;;     1A1F:1A1C (in CreateRandomAreaImpact_19FD)
;;     1A1F:1A32 (in CreateRandomAreaImpact_19FD)
;;     1A1F:1B60 (in AdvanceScenarioAreaEffects_1A83)
;;     1A1F:355E (in ExecuteSceneInstructions_2A4E)
RandomInRangeInclusive proc
34C6:0008 55              	push	bp
34C6:0009 8B EC           	mov	bp,sp
34C6:000B 9A 46 4D 00 08  	call	far 0800h:4D46h
34C6:0010 8B 5E 08        	mov	bx,[bp+8h]
34C6:0013 2B 5E 06        	sub	bx,[bp+6h]
34C6:0016 43              	inc	bx
34C6:0017 99              	cwd
34C6:0018 F7 FB           	idiv	bx
34C6:001A 8B C2           	mov	ax,dx
34C6:001C 03 46 06        	add	ax,[bp+6h]
34C6:001F EB 00           	jmp	0021h
