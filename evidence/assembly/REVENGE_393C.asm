;;; Segment 393C (393C:0000)
393C:0000 EB 00                                           ..              

l3939_0032:
3939:0032 5E              	pop	si
3939:0033 5D              	pop	bp
3939:0034 CB              	retf

;; ReadFileWithTextTranslation: 393C:0005
;;   Called from:
;;     2C7F:0516 (in LoadMediaConfiguration_047A)
;;     3390:02FE (in ReadTrackedFile)
;;     3390:034B (in ReadTrackedFile)
;;     3390:0B72 (in InitializeResourceCache)
;;     3477:0043 (in LoadFontResource_000B)
;;     3477:00B3 (in LoadFontResource_000B)
;;     3477:013B (in LoadFontResource_000B)
ReadFileWithTextTranslation proc
393C:0005 55              	push	bp
393C:0006 8B EC           	mov	bp,sp
393C:0008 83 EC 04        	sub	sp,4h
393C:000B 56              	push	si
393C:000C 57              	push	di
393C:000D 8B 46 0C        	mov	ax,[bp+0Ch]
393C:0010 40              	inc	ax
393C:0011 3D 02 00        	cmp	ax,2h
393C:0014 72 0D           	jc	0023h

l393C_0016:
393C:0016 8B 5E 06        	mov	bx,[bp+6h]
393C:0019 D1 E3           	shl	bx,1h
393C:001B F7 87 2A 71 00 02 	test	word ptr [bx+712Ah],200h
393C:0021 74 05           	jz	0028h

l393C_0023:
393C:0023 33 C0           	xor	ax,ax
393C:0025 E9 9C 00        	jmp	00C4h

l393C_0028:
393C:0028 FF 76 0C        	push	word ptr [bp+0Ch]
393C:002B FF 76 0A        	push	word ptr [bp+0Ah]
393C:002E FF 76 08        	push	word ptr [bp+8h]
393C:0031 FF 76 06        	push	word ptr [bp+6h]
393C:0034 9A 0A 00 48 39  	call	far 3948h:000Ah
393C:0039 83 C4 08        	add	sp,8h
393C:003C 89 46 FC        	mov	[bp-4h],ax
393C:003F 8B 46 FC        	mov	ax,[bp-4h]
393C:0042 40              	inc	ax
393C:0043 3D 02 00        	cmp	ax,2h
393C:0046 72 0D           	jc	0055h

l393C_0048:
393C:0048 8B 5E 06        	mov	bx,[bp+6h]
393C:004B D1 E3           	shl	bx,1h
393C:004D F7 87 2A 71 00 80 	test	word ptr [bx+712Ah],8000h
393C:0053 74 06           	jz	005Bh

l393C_0055:
393C:0055 8B 46 FC        	mov	ax,[bp-4h]
393C:0058 EB 6A           	jmp	00C4h
393C:005A                               90                          .     

l393C_005B:
393C:005B 8B 4E FC        	mov	cx,[bp-4h]
393C:005E C4 76 08        	les	si,[bp+8h]
393C:0061 8B FE           	mov	di,si
393C:0063 8B DE           	mov	bx,si
393C:0065 FC              	cld

l393C_0066:
393C:0066 26 AC           	lodsb
393C:0068 3C 1A           	cmp	al,1Ah
393C:006A 74 30           	jz	009Ch

l393C_006C:
393C:006C 3C 0D           	cmp	al,0Dh
393C:006E 74 05           	jz	0075h

l393C_0070:
393C:0070 AA              	stosb
393C:0071 E2 F3           	loop	0066h

l393C_0073:
393C:0073 EB 1F           	jmp	0094h

l393C_0075:
393C:0075 E2 EF           	loop	0066h

l393C_0077:
393C:0077 06              	push	es
393C:0078 53              	push	bx
393C:0079 B8 01 00        	mov	ax,1h
393C:007C 50              	push	ax
393C:007D 8D 46 FF        	lea	ax,[bp-1h]
393C:0080 16              	push	ss
393C:0081 50              	push	ax
393C:0082 FF 76 06        	push	word ptr [bp+6h]
393C:0085 9A 0A 00 48 39  	call	far 3948h:000Ah
393C:008A 83 C4 08        	add	sp,8h
393C:008D 5B              	pop	bx
393C:008E 07              	pop	es
393C:008F FC              	cld
393C:0090 8A 46 FF        	mov	al,[bp-1h]
393C:0093 AA              	stosb

l393C_0094:
393C:0094 3B FB           	cmp	di,bx
393C:0096 75 02           	jnz	009Ah

l393C_0098:
393C:0098 EB 8E           	jmp	0028h

l393C_009A:
393C:009A EB 22           	jmp	00BEh

l393C_009C:
393C:009C 53              	push	bx
393C:009D B8 02 00        	mov	ax,2h
393C:00A0 50              	push	ax
393C:00A1 F7 D9           	neg	cx
393C:00A3 1B C0           	sbb	ax,ax
393C:00A5 50              	push	ax
393C:00A6 51              	push	cx
393C:00A7 FF 76 06        	push	word ptr [bp+6h]
393C:00AA 9A 0C 00 65 39  	call	far 3965h:000Ch
393C:00AF 83 C4 08        	add	sp,8h
393C:00B2 8B 5E 06        	mov	bx,[bp+6h]
393C:00B5 D1 E3           	shl	bx,1h
393C:00B7 81 8F 2A 71 00 02 	or	word ptr [bx+712Ah],200h
393C:00BD 5B              	pop	bx

l393C_00BE:
393C:00BE 8B C7           	mov	ax,di
