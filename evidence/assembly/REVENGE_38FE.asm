;;; Segment 38FE (38FE:0000)
38FE:0000 5D CB                                           ].              

;; ResizeProgramBreak_0002: 38FE:0002
;;   Called from:
;;     38FE:00C5 (in SetProgramBreak)
;;     38FE:0139 (in AdjustProgramBreak)
ResizeProgramBreak_0002 proc
38FE:0002 55              	push	bp
38FE:0003 8B EC           	mov	bp,sp
38FE:0005 56              	push	si
38FE:0006 57              	push	di
38FE:0007 8B 76 06        	mov	si,[bp+6h]
38FE:000A 46              	inc	si
38FE:000B 2B 36 7B 00     	sub	si,[007Bh]
38FE:000F 8B C6           	mov	ax,si
38FE:0011 05 3F 00        	add	ax,3Fh
38FE:0014 B1 06           	mov	cl,6h
38FE:0016 D3 E8           	shr	ax,cl
38FE:0018 8B F0           	mov	si,ax
38FE:001A 3B 36 26 70     	cmp	si,[7026h]
38FE:001E 75 10           	jnz	0030h

l38FE_0020:
38FE:0020 C4 5E 04        	les	bx,[bp+4h]
38FE:0023 8C 06 8D 00     	mov	[008Dh],es
38FE:0027 89 1E 8B 00     	mov	[008Bh],bx
38FE:002B B8 01 00        	mov	ax,1h
38FE:002E EB 5C           	jmp	008Ch

l38FE_0030:
38FE:0030 B1 06           	mov	cl,6h
38FE:0032 D3 E6           	shl	si,cl
38FE:0034 8B 3E 91 00     	mov	di,[0091h]
38FE:0038 8B C6           	mov	ax,si
38FE:003A 03 06 7B 00     	add	ax,[007Bh]
38FE:003E 3B C7           	cmp	ax,di
38FE:0040 76 06           	jbe	0048h

l38FE_0042:
38FE:0042 8B F7           	mov	si,di
38FE:0044 2B 36 7B 00     	sub	si,[007Bh]

l38FE_0048:
38FE:0048 56              	push	si
38FE:0049 FF 36 7B 00     	push	word ptr [007Bh]
38FE:004D 9A 04 00 13 39  	call	far 3913h:0004h
38FE:0052 59              	pop	cx
38FE:0053 59              	pop	cx
38FE:0054 8B F8           	mov	di,ax
38FE:0056 83 FF FF        	cmp	di,0FFh
38FE:0059 75 1B           	jnz	0076h

l38FE_005B:
38FE:005B 8B C6           	mov	ax,si
38FE:005D B1 06           	mov	cl,6h
38FE:005F D3 E8           	shr	ax,cl
38FE:0061 A3 26 70        	mov	[7026h],ax
38FE:0064 C4 5E 04        	les	bx,[bp+4h]
38FE:0067 8C 06 8D 00     	mov	[008Dh],es
38FE:006B 89 1E 8B 00     	mov	[008Bh],bx
38FE:006F B8 01 00        	mov	ax,1h
38FE:0072 EB 18           	jmp	008Ch
38FE:0074             EB 16                                   ..          

l38FE_0076:
38FE:0076 A1 7B 00        	mov	ax,[007Bh]
38FE:0079 03 C7           	add	ax,di
38FE:007B 33 D2           	xor	dx,dx
38FE:007D 8B D0           	mov	dx,ax
38FE:007F 33 C0           	xor	ax,ax
38FE:0081 89 16 91 00     	mov	[0091h],dx
38FE:0085 A3 8F 00        	mov	[008Fh],ax
38FE:0088 33 C0           	xor	ax,ax
38FE:008A EB 00           	jmp	008Ch

l38FE_008C:
38FE:008C 5F              	pop	di
38FE:008D 5E              	pop	si
38FE:008E 5D              	pop	bp
38FE:008F C2 04 00        	ret	4h

;; SetProgramBreak: 38FE:0092
;;   Called from:
;;     398D:0159 (in ReleaseFarHeapTail_0135)
;;     398D:01F3 (in ReleaseFarHeapTail_0135)
;;     398D:0204 (in ReleaseFarHeapTail_0135)
SetProgramBreak proc
38FE:0092 55              	push	bp
38FE:0093 8B EC           	mov	bp,sp
38FE:0095 8B 0E 89 00     	mov	cx,[0089h]
38FE:0099 8B 1E 87 00     	mov	bx,[0087h]
38FE:009D 8B 56 08        	mov	dx,[bp+8h]
38FE:00A0 8B 46 06        	mov	ax,[bp+6h]
38FE:00A3 9A 0B 54 00 08  	call	far 0800h:540Bh
38FE:00A8 72 22           	jc	00CCh

l38FE_00AA:
38FE:00AA 8B 0E 91 00     	mov	cx,[0091h]
38FE:00AE 8B 1E 8F 00     	mov	bx,[008Fh]
38FE:00B2 8B 56 08        	mov	dx,[bp+8h]
38FE:00B5 8B 46 06        	mov	ax,[bp+6h]
38FE:00B8 9A 0B 54 00 08  	call	far 0800h:540Bh
38FE:00BD 77 0D           	ja	00CCh

l38FE_00BF:
38FE:00BF FF 76 08        	push	word ptr [bp+8h]
38FE:00C2 FF 76 06        	push	word ptr [bp+6h]
38FE:00C5 E8 3A FF        	call	0002h
38FE:00C8 0B C0           	or	ax,ax
38FE:00CA 75 07           	jnz	00D3h

l38FE_00CC:
38FE:00CC B8 FF FF        	mov	ax,0FFFFh
38FE:00CF EB 06           	jmp	00D7h
38FE:00D1    EB 04                                         ..             

l38FE_00D3:
38FE:00D3 33 C0           	xor	ax,ax
38FE:00D5 EB 00           	jmp	00D7h

l38FE_00D7:
38FE:00D7 5D              	pop	bp
38FE:00D8 CB              	retf

;; AdjustProgramBreak: 38FE:00D9
;;   Called from:
;;     38CD:013B (in ExtendFarHeap_012F)
;;     38CD:01A9 (in InitializeFarHeap_019D)
AdjustProgramBreak proc
38FE:00D9 55              	push	bp
38FE:00DA 8B EC           	mov	bp,sp
38FE:00DC 83 EC 08        	sub	sp,8h
38FE:00DF 8B 16 8D 00     	mov	dx,[008Dh]
38FE:00E3 A1 8B 00        	mov	ax,[008Bh]
38FE:00E6 8B 4E 08        	mov	cx,[bp+8h]
38FE:00E9 8B 5E 06        	mov	bx,[bp+6h]
38FE:00EC 9A B0 53 00 08  	call	far 0800h:53B0h
38FE:00F1 89 56 FA        	mov	[bp-6h],dx
38FE:00F4 89 46 F8        	mov	[bp-8h],ax
38FE:00F7 8B 0E 89 00     	mov	cx,[0089h]
38FE:00FB 8B 1E 87 00     	mov	bx,[0087h]
38FE:00FF 8B 56 FA        	mov	dx,[bp-6h]
38FE:0102 8B 46 F8        	mov	ax,[bp-8h]
38FE:0105 9A 0B 54 00 08  	call	far 0800h:540Bh
38FE:010A 72 15           	jc	0121h

l38FE_010C:
38FE:010C 8B 0E 91 00     	mov	cx,[0091h]
38FE:0110 8B 1E 8F 00     	mov	bx,[008Fh]
38FE:0114 8B 56 FA        	mov	dx,[bp-6h]
38FE:0117 8B 46 F8        	mov	ax,[bp-8h]
38FE:011A 9A 0B 54 00 08  	call	far 0800h:540Bh
38FE:011F 76 08           	jbe	0129h

l38FE_0121:
38FE:0121 BA FF FF        	mov	dx,0FFFFh
38FE:0124 B8 FF FF        	mov	ax,0FFFFh
38FE:0127 EB 27           	jmp	0150h

l38FE_0129:
38FE:0129 C4 1E 8B 00     	les	bx,[008Bh]
38FE:012D 8C 46 FE        	mov	[bp-2h],es
38FE:0130 89 5E FC        	mov	[bp-4h],bx
38FE:0133 FF 76 FA        	push	word ptr [bp-6h]
38FE:0136 FF 76 F8        	push	word ptr [bp-8h]
38FE:0139 E8 C6 FE        	call	0002h
38FE:013C 0B C0           	or	ax,ax
38FE:013E 75 08           	jnz	0148h

l38FE_0140:
38FE:0140 BA FF FF        	mov	dx,0FFFFh
38FE:0143 B8 FF FF        	mov	ax,0FFFFh
38FE:0146 EB 08           	jmp	0150h

l38FE_0148:
38FE:0148 8B 56 FE        	mov	dx,[bp-2h]
38FE:014B 8B 46 FC        	mov	ax,[bp-4h]
38FE:014E EB 00           	jmp	0150h
