;;; Segment 398B (398B:0000)
398B:0000 72 03                                           r.              

l3989_0022:
3989:0022 91              	xchg	cx,ax
3989:0023 EB 08           	jmp	002Dh

l3989_0025:
3989:0025 50              	push	ax
3989:0026 9A 04 00 C3 38  	call	far 38C3h:0004h
3989:002B EB 00           	jmp	002Dh

l3989_002D:
3989:002D 5D              	pop	bp
3989:002E CB              	retf

;; GetAvailableHeapBytes: 398B:000F
;;   Called from:
;;     0D56:0076 (in PrintAllocationErrorAndExit)
;;     2C7F:012A (in InitializeGame_003C)
GetAvailableHeapBytes proc
398B:000F 8B 16 91 00     	mov	dx,[0091h]
398B:0013 A1 8F 00        	mov	ax,[008Fh]
398B:0016 8B 0E 8D 00     	mov	cx,[008Dh]
398B:001A 8B 1E 8B 00     	mov	bx,[008Bh]
398B:001E 9A 26 55 00 08  	call	far 0800h:5526h
