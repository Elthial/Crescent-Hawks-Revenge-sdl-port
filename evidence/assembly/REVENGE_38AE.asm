;;; Segment 38AE (38AE:0000)
38AE:0000 FF FF 8B DC 36 8B 57 08 36 8B 47 06 36 8B 5F 04 ....6.W.6.G.6._.

;; SwapInterruptVector_0010: 38AE:0010
;;   Called from:
;;     375F:0662 (in InstallDigitalPlaybackTimer_063B)
;;     375F:06B7 (in RestoreDigitalPlaybackTimer_06A9)
;;     38AE:006A (in BeginPITCalibration_005C)
;;     38AE:00B5 (in EndPITCalibration_009B)
SwapInterruptVector_0010 proc
38AE:0010 33 C9           	xor	cx,cx
38AE:0012 8E C1           	mov	es,cx
38AE:0014 D1 E3           	shl	bx,1h
38AE:0016 D1 E3           	shl	bx,1h
38AE:0018 9C              	pushf
38AE:0019 FA              	cli
38AE:001A 26 87 07        	xchg	es:[bx],ax
38AE:001D 26 87 57 02     	xchg	es:[bx+2h],dx
38AE:0021 9D              	popf
38AE:0022 CB              	retf
38AE:0023          00 8B DC 36 8B 47 04                      ...6.G.      

;; SetPITChannel0Divisor_002A: 38AE:002A
;;   Called from:
;;     375F:06A2 (in ProgramDigitalPlaybackTimerRate_0689)
;;     375F:06C0 (in RestoreDigitalPlaybackTimer_06A9)
;;     38AE:00BD (in EndPITCalibration_009B)
SetPITChannel0Divisor_002A proc
38AE:002A 9C              	pushf
38AE:002B FA              	cli
38AE:002C 50              	push	ax
38AE:002D B0 36           	mov	al,36h
38AE:002F E6 43           	out	43h,al
38AE:0031 58              	pop	ax
38AE:0032 E6 40           	out	40h,al
38AE:0034 86 C4           	xchg	ah,al
38AE:0036 E6 40           	out	40h,al
38AE:0038 86 E0           	xchg	al,ah
38AE:003A 87 06 A4 6F     	xchg	[6FA4h],ax
38AE:003E 9D              	popf
38AE:003F CB              	retf
38AE:0040 8B DC 36 8B 47 04                               ..6.G.          

;; PITFrequencyToDivisor_0046: 38AE:0046
;;   Called from:
;;     375F:0689 (in ProgramDigitalPlaybackTimerRate_0689)
;;     375F:068E (in ProgramDigitalPlaybackTimerRate_0689)
PITFrequencyToDivisor_0046 proc
38AE:0046 8B C8           	mov	cx,ax
38AE:0048 83 F9 12        	cmp	cx,12h
38AE:004B 76 09           	jbe	0056h

l38AE_004D:
38AE:004D BA 12 00        	mov	dx,12h
38AE:0050 B8 DE 34        	mov	ax,34DEh
38AE:0053 F7 F1           	div	cx
38AE:0055 CB              	retf

l38AE_0056:
38AE:0056 33 C0           	xor	ax,ax
38AE:0058 CB              	retf
38AE:0059                            00 00 00                      ...    

;; BeginPITCalibration_005C: 38AE:005C
;;   Called from:
;;     375F:0610 (in CalibrateDigitalPlaybackRate_05D6)
BeginPITCalibration_005C proc
38AE:005C 9C              	pushf
38AE:005D FA              	cli
38AE:005E 58              	pop	ax
38AE:005F A3 AA 6F        	mov	[6FAAh],ax
38AE:0062 8C CA           	mov	dx,cs
38AE:0064 B8 D7 00        	mov	ax,0D7h
38AE:0067 BB 08 00        	mov	bx,8h
38AE:006A 9A 10 00 AE 38  	call	far 38AEh:0010h
38AE:006F A3 A6 6F        	mov	[6FA6h],ax
38AE:0072 89 16 A8 6F     	mov	[6FA8h],dx
38AE:0076 2E C7 06 5A 00 00 00 	mov	word ptr cs:[005Ah],0h
38AE:007D B0 34           	mov	al,34h
38AE:007F E6 43           	out	43h,al
38AE:0081 33 C0           	xor	ax,ax
38AE:0083 E6 40           	out	40h,al
38AE:0085 E6 40           	out	40h,al
38AE:0087 FB              	sti

l38AE_0088:
38AE:0088 2E 39 06 5A 00  	cmp	cs:[005Ah],ax
38AE:008D 74 F9           	jz	0088h

l38AE_008F:
38AE:008F 2E A3 5A 00     	mov	cs:[005Ah],ax

l38AE_0093:
38AE:0093 2E 39 06 5A 00  	cmp	cs:[005Ah],ax
38AE:0098 74 F9           	jz	0093h

l38AE_009A:
38AE:009A CB              	retf

;; EndPITCalibration_009B: 38AE:009B
;;   Called from:
;;     375F:0621 (in CalibrateDigitalPlaybackRate_05D6)
EndPITCalibration_009B proc
38AE:009B FA              	cli
38AE:009C B0 04           	mov	al,4h
38AE:009E E6 43           	out	43h,al
38AE:00A0 E4 40           	in	al,40h
38AE:00A2 8A E0           	mov	ah,al
38AE:00A4 E4 40           	in	al,40h
38AE:00A6 86 E0           	xchg	al,ah
38AE:00A8 A3 AC 6F        	mov	[6FACh],ax
38AE:00AB A1 A6 6F        	mov	ax,[6FA6h]
38AE:00AE 8B 16 A8 6F     	mov	dx,[6FA8h]
38AE:00B2 BB 08 00        	mov	bx,8h
38AE:00B5 9A 10 00 AE 38  	call	far 38AEh:0010h
38AE:00BA A1 A4 6F        	mov	ax,[6FA4h]
38AE:00BD 9A 2A 00 AE 38  	call	far 38AEh:002Ah
38AE:00C2 33 C0           	xor	ax,ax
38AE:00C4 2E 8B 16 5A 00  	mov	dx,cs:[005Ah]
38AE:00C9 2B 06 AC 6F     	sub	ax,[6FACh]
38AE:00CD 83 DA 00        	sbb	dx,0h
38AE:00D0 8B 0E AA 6F     	mov	cx,[6FAAh]
38AE:00D4 51              	push	cx
38AE:00D5 9D              	popf
38AE:00D6 CB              	retf

;; PITCalibrationIRQ0Handler_00D7: 38AE:00D7
PITCalibrationIRQ0Handler_00D7 proc
38AE:00D7 50              	push	ax
38AE:00D8 2E FF 06 5A 00  	inc	word ptr cs:[005Ah]
38AE:00DD B0 20           	mov	al,20h
38AE:00DF E6 20           	out	20h,al
38AE:00E1 58              	pop	ax
38AE:00E2 CF              	iret
38AE:00E3          00 8B DC 36 8B 57 06 36 8B 47 04 36 8B    ...6.W.6.G.6.
38AE:00F0 4F 0A 36 8B 5F 08                               O.6._.          

;; DivideUnsigned32By32_00F6: 38AE:00F6
;;   Called from:
;;     375F:0630 (in CalibrateDigitalPlaybackRate_05D6)
DivideUnsigned32By32_00F6 proc
38AE:00F6 56              	push	si
38AE:00F7 57              	push	di
38AE:00F8 55              	push	bp
38AE:00F9 8B FA           	mov	di,dx
38AE:00FB 8B F0           	mov	si,ax
38AE:00FD 8B E9           	mov	bp,cx
38AE:00FF 33 D2           	xor	dx,dx
38AE:0101 8B C6           	mov	ax,si
38AE:0103 0B C7           	or	ax,di
38AE:0105 74 49           	jz	0150h

l38AE_0107:
38AE:0107 8B C3           	mov	ax,bx
38AE:0109 0B C5           	or	ax,bp
38AE:010B 74 43           	jz	0150h

l38AE_010D:
38AE:010D 8B C2           	mov	ax,dx
38AE:010F 3B EF           	cmp	bp,di
38AE:0111 75 02           	jnz	0115h

l38AE_0113:
38AE:0113 3B DE           	cmp	bx,si

l38AE_0115:
38AE:0115 77 39           	ja	0150h

l38AE_0117:
38AE:0117 EB 08           	jmp	0121h

l38AE_0119:
38AE:0119 D1 E6           	shl	si,1h
38AE:011B D1 D7           	rcl	di,1h
38AE:011D D1 E3           	shl	bx,1h
38AE:011F D1 D5           	rcl	bp,1h

l38AE_0121:
38AE:0121 0B FF           	or	di,di
38AE:0123 79 F4           	jns	0119h

l38AE_0125:
38AE:0125 33 C9           	xor	cx,cx
38AE:0127 EB 04           	jmp	012Dh

l38AE_0129:
38AE:0129 D1 E3           	shl	bx,1h
38AE:012B D1 D5           	rcl	bp,1h

l38AE_012D:
38AE:012D 41              	inc	cx
38AE:012E 0B ED           	or	bp,bp
38AE:0130 79 F7           	jns	0129h

l38AE_0132:
38AE:0132 EB 08           	jmp	013Ch

l38AE_0134:
38AE:0134 D1 E0           	shl	ax,1h
38AE:0136 D1 D2           	rcl	dx,1h
38AE:0138 D1 ED           	shr	bp,1h
38AE:013A D1 DB           	rcr	bx,1h

l38AE_013C:
38AE:013C 3B EF           	cmp	bp,di
38AE:013E 75 02           	jnz	0142h

l38AE_0140:
38AE:0140 3B DE           	cmp	bx,si

l38AE_0142:
38AE:0142 77 0A           	ja	014Eh

l38AE_0144:
38AE:0144 2B F3           	sub	si,bx
38AE:0146 1B FD           	sbb	di,bp
38AE:0148 05 01 00        	add	ax,1h
38AE:014B 83 D2 00        	adc	dx,0h

l38AE_014E:
38AE:014E E2 E4           	loop	0134h
