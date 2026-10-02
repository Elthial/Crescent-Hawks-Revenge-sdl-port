;;; Segment 334A (334A:0000)
334A:0000 09 00 38 33 59 9A 06 00 6D 35 5D CB             ..83Y...m5].    

;; WaitVerticalRetraces_000C: 334A:000C
;;   Called from:
;;     0D73:2FF8 (in AnimateTitleTextLine_2F5F)
;;     0D73:3052 (in AnimateTitleTextLine_2F5F)
;;     0D73:3CA4 (in WaitForDismissInputOrTimeout_3C97)
;;     2C7F:02FC (in ShutdownGame_02E3)
WaitVerticalRetraces_000C proc
334A:000C 55              	push	bp
334A:000D 8B EC           	mov	bp,sp
334A:000F EB 0A           	jmp	001Bh

l334A_0011:
334A:0011 FF 36 EE 7F     	push	word ptr [7FEEh]
334A:0015 9A C2 4E 00 08  	call	far 0800h:4EC2h
334A:001A 59              	pop	cx

l334A_001B:
334A:001B 8B 46 06        	mov	ax,[bp+6h]
334A:001E FF 4E 06        	dec	word ptr [bp+6h]
334A:0021 0B C0           	or	ax,ax
334A:0023 75 EC           	jnz	0011h

l334A_0025:
334A:0025 5D              	pop	bp
334A:0026 CB              	retf
334A:0027                      B8 01 00 50 0E E8 DD FF 59        ...P....Y
