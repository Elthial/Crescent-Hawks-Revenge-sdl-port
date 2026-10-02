;;; Segment 3327 (3327:0000)
3327:0000 81 01 56 0D 59 59 CB                            ..V.YY.         

;; DOS_PrintString: 3327:0007
;;   Called from:
;;     0D56:001D (in PrintAllocationErrorAndExit)
;;     0D56:0029 (in PrintAllocationErrorAndExit)
;;     0D56:004E (in PrintAllocationErrorAndExit)
;;     0D56:005A (in PrintAllocationErrorAndExit)
;;     0D56:0066 (in PrintAllocationErrorAndExit)
;;     0D56:008A (in PrintAllocationErrorAndExit)
;;     0D56:0096 (in PrintAllocationErrorAndExit)
;;     2C7F:0066 (in InitializeGame_003C)
;;     2C7F:0072 (in InitializeGame_003C)
;;     2C7F:0093 (in InitializeGame_003C)
;;     2C7F:009F (in InitializeGame_003C)
;;     2C7F:00E7 (in InitializeGame_003C)
;;     2C7F:00F3 (in InitializeGame_003C)
;;     2C7F:00FF (in InitializeGame_003C)
;;     2C7F:010B (in InitializeGame_003C)
;;     2C7F:0117 (in InitializeGame_003C)
;;     2C7F:0123 (in InitializeGame_003C)
;;     2C7F:014E (in InitializeGame_003C)
;;     2C7F:016B (in InitializeGame_003C)
;;     2C7F:017D (in InitializeGame_003C)
;;     2C7F:02CC (in InitializeGame_003C)
;;     2C7F:04A7 (in LoadMediaConfiguration_047A)
;;     2C7F:04DF (in LoadMediaConfiguration_047A)
;;     2C7F:0531 (in LoadMediaConfiguration_047A)
;;     2C7F:061E (in LoadMediaConfiguration_047A)
;;     2C7F:071A (in ApplyVideoConfigOption_0669)
;;     2C7F:07BB (in ApplyMusicConfigOption_072D)
;;     2C7F:08B7 (in ApplySoundConfigOption_07CE)
;;     2C7F:0959 (in ApplyInputDeviceConfigOption_08CA)
DOS_PrintString proc
3327:0007 55              	push	bp
3327:0008 8B EC           	mov	bp,sp
3327:000A 56              	push	si
3327:000B 33 F6           	xor	si,si
3327:000D EB 13           	jmp	0022h

l3327_000F:
3327:000F 8B C6           	mov	ax,si
3327:0011 46              	inc	si
3327:0012 C4 5E 06        	les	bx,[bp+6h]
3327:0015 03 D8           	add	bx,ax
3327:0017 26 8A 07        	mov	al,es:[bx]
3327:001A 98              	cbw
3327:001B 50              	push	ax
3327:001C 9A BF 3B 00 08  	call	far 0800h:3BBFh
