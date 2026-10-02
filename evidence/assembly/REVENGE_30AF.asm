;;; Segment 30AF (30AF:0000)
30AF:0000 16 8F 01 B8 09 25 CD 21 5A 1F 58 CB             .....%.!Z.X.    

;; PlayPCSpeakerEffectByIndex_078C: 3037:078C
;;   Called from:
;;     31FB:057B (in DispatchWeaponEffect_0567)
PlayPCSpeakerEffectByIndex_078C proc
30AF:000C 55              	push	bp
30AF:000D 8B EC           	mov	bp,sp
30AF:000F 83 3E 0A 80 00  	cmp	word ptr [800Ah],0h
30AF:0014 74 16           	jz	002Ch

l30AF_0016:
30AF:0016 8B 5E 06        	mov	bx,[bp+6h]
30AF:0019 D1 E3           	shl	bx,1h
30AF:001B D1 E3           	shl	bx,1h
30AF:001D FF B7 DD 58     	push	word ptr [bx+58DDh]
30AF:0021 FF B7 DB 58     	push	word ptr [bx+58DBh]
30AF:0025 9A B6 03 B2 30  	call	far 30B2h:03B6h
30AF:002A 8B E5           	mov	sp,bp

l30AF_002C:
30AF:002C 5D              	pop	bp
30AF:002D CB              	retf

;; RequestPCSpeakerEffectStop_002E: 30AF:002E
;;   Called from:
;;     1A1F:066F (in RunTacticalInteractionLoop_0613)
;;     2C7F:042F (in ServiceMusicAndCheckKeyboardInput_0427)
RequestPCSpeakerEffectStop_002E proc
30AF:002E 9A E1 03 B2 30  	call	far 30B2h:03E1h
