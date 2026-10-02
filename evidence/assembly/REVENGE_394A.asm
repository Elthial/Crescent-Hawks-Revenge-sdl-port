;;; Segment 394A (394A:0000)

l3948_0020:
3948:0020 50              	push	ax
3948:0021 9A 04 00 C3 38  	call	far 38C3h:0004h
3948:0026 EB 00           	jmp	0028h

l3948_0028:
3948:0028 5D              	pop	bp
3948:0029 CB              	retf

;; WriteFileWithTextTranslation: 394A:000A
;;   Called from:
;;     3390:03CF (in WriteTrackedFile)
;;     3390:041A (in WriteTrackedFile)
WriteFileWithTextTranslation proc
394A:000A 55              	push	bp
394A:000B 8B EC           	mov	bp,sp
394A:000D 81 EC 8E 00     	sub	sp,8Eh
394A:0011 56              	push	si
394A:0012 57              	push	di
394A:0013 8B 46 0C        	mov	ax,[bp+0Ch]
394A:0016 40              	inc	ax
394A:0017 3D 02 00        	cmp	ax,2h
394A:001A 73 05           	jnc	0021h

l394A_001C:
394A:001C 33 C0           	xor	ax,ax
394A:001E E9 49 01        	jmp	016Ah

l394A_0021:
394A:0021 8B 5E 06        	mov	bx,[bp+6h]
394A:0024 D1 E3           	shl	bx,1h
394A:0026 F7 87 2A 71 00 80 	test	word ptr [bx+712Ah],8000h
394A:002C 74 17           	jz	0045h

l394A_002E:
394A:002E FF 76 0C        	push	word ptr [bp+0Ch]
394A:0031 FF 76 0A        	push	word ptr [bp+0Ah]
394A:0034 FF 76 08        	push	word ptr [bp+8h]
394A:0037 FF 76 06        	push	word ptr [bp+6h]
394A:003A 9A 00 00 61 39  	call	far 3961h:0000h
394A:003F 83 C4 08        	add	sp,8h
394A:0042 E9 25 01        	jmp	016Ah

l394A_0045:
394A:0045 8B 5E 06        	mov	bx,[bp+6h]
394A:0048 D1 E3           	shl	bx,1h
394A:004A 81 A7 2A 71 FF FD 	and	word ptr [bx+712Ah],0FDFFh
394A:0050 C4 5E 08        	les	bx,[bp+8h]
394A:0053 8C 86 7C FF     	mov	[bp+0FF7Ch],es
394A:0057 89 9E 7A FF     	mov	[bp+0FF7Ah],bx
394A:005B 8B 46 0C        	mov	ax,[bp+0Ch]
394A:005E 89 86 76 FF     	mov	[bp+0FF76h],ax
394A:0062 8C D3           	mov	bx,ss
394A:0064 8E C3           	mov	es,bx
394A:0066 8D 9E 7E FF     	lea	bx,[bp+0FF7Eh]
394A:006A 8C 86 74 FF     	mov	[bp+0FF74h],es
394A:006E 89 9E 72 FF     	mov	[bp+0FF72h],bx
394A:0072 E9 A1 00        	jmp	0116h

l394A_0075:
394A:0075 FF 8E 76 FF     	dec	word ptr [bp+0FF76h]
394A:0079 C4 9E 7A FF     	les	bx,[bp+0FF7Ah]
394A:007D FF 86 7A FF     	inc	word ptr [bp+0FF7Ah]
394A:0081 26 8A 07        	mov	al,es:[bx]
394A:0084 88 86 79 FF     	mov	[bp+0FF79h],al
394A:0088 3C 0A           	cmp	al,0Ah
394A:008A 75 0C           	jnz	0098h

l394A_008C:
394A:008C C4 9E 72 FF     	les	bx,[bp+0FF72h]
394A:0090 26 C6 07 0D     	mov	byte ptr es:[bx],0Dh
394A:0094 FF 86 72 FF     	inc	word ptr [bp+0FF72h]

l394A_0098:
394A:0098 8A 86 79 FF     	mov	al,[bp+0FF79h]
394A:009C C4 9E 72 FF     	les	bx,[bp+0FF72h]
394A:00A0 26 88 07        	mov	es:[bx],al
394A:00A3 FF 86 72 FF     	inc	word ptr [bp+0FF72h]
394A:00A7 8B 86 72 FF     	mov	ax,[bp+0FF72h]
394A:00AB 8C D1           	mov	cx,ss
394A:00AD 8D 9E 7E FF     	lea	bx,[bp+0FF7Eh]
394A:00B1 33 D2           	xor	dx,dx
394A:00B3 2B C3           	sub	ax,bx
394A:00B5 83 DA 00        	sbb	dx,0h
394A:00B8 0B D2           	or	dx,dx
394A:00BA 7C 5A           	jl	0116h

l394A_00BC:
394A:00BC 75 05           	jnz	00C3h

l394A_00BE:
394A:00BE 3D 80 00        	cmp	ax,80h
394A:00C1 72 53           	jc	0116h

l394A_00C3:
394A:00C3 8B 86 72 FF     	mov	ax,[bp+0FF72h]
394A:00C7 8C D1           	mov	cx,ss
394A:00C9 8D 9E 7E FF     	lea	bx,[bp+0FF7Eh]
394A:00CD 33 D2           	xor	dx,dx
394A:00CF 2B C3           	sub	ax,bx
394A:00D1 83 DA 00        	sbb	dx,0h
394A:00D4 8B F0           	mov	si,ax
394A:00D6 56              	push	si
394A:00D7 16              	push	ss
394A:00D8 8D 86 7E FF     	lea	ax,[bp+0FF7Eh]
394A:00DC 50              	push	ax
394A:00DD FF 76 06        	push	word ptr [bp+6h]
394A:00E0 9A 00 00 61 39  	call	far 3961h:0000h
394A:00E5 83 C4 08        	add	sp,8h
394A:00E8 8B F8           	mov	di,ax
394A:00EA 8B C7           	mov	ax,di
394A:00EC 3B C6           	cmp	ax,si
394A:00EE 74 16           	jz	0106h

l394A_00F0:
394A:00F0 0B FF           	or	di,di
394A:00F2 73 05           	jnc	00F9h

l394A_00F4:
394A:00F4 B8 FF FF        	mov	ax,0FFFFh
394A:00F7 EB 0B           	jmp	0104h

l394A_00F9:
394A:00F9 8B 46 0C        	mov	ax,[bp+0Ch]
394A:00FC 2B 86 76 FF     	sub	ax,[bp+0FF76h]
394A:0100 03 C7           	add	ax,di
394A:0102 2B C6           	sub	ax,si

l394A_0104:
394A:0104 EB 64           	jmp	016Ah

l394A_0106:
394A:0106 8C D3           	mov	bx,ss
394A:0108 8E C3           	mov	es,bx
394A:010A 8D 9E 7E FF     	lea	bx,[bp+0FF7Eh]
394A:010E 8C 86 74 FF     	mov	[bp+0FF74h],es
394A:0112 89 9E 72 FF     	mov	[bp+0FF72h],bx

l394A_0116:
394A:0116 83 BE 76 FF 00  	cmp	word ptr [bp+0FF76h],0h
394A:011B 74 03           	jz	0120h

l394A_011D:
394A:011D E9 55 FF        	jmp	0075h

l394A_0120:
394A:0120 8B 86 72 FF     	mov	ax,[bp+0FF72h]
394A:0124 8C D1           	mov	cx,ss
394A:0126 8D 9E 7E FF     	lea	bx,[bp+0FF7Eh]
394A:012A 33 D2           	xor	dx,dx
394A:012C 2B C3           	sub	ax,bx
394A:012E 83 DA 00        	sbb	dx,0h
394A:0131 8B F0           	mov	si,ax
394A:0133 8B C6           	mov	ax,si
394A:0135 0B C0           	or	ax,ax
394A:0137 76 2C           	jbe	0165h

l394A_0139:
394A:0139 56              	push	si
394A:013A 16              	push	ss
394A:013B 8D 86 7E FF     	lea	ax,[bp+0FF7Eh]
394A:013F 50              	push	ax
394A:0140 FF 76 06        	push	word ptr [bp+6h]
394A:0143 9A 00 00 61 39  	call	far 3961h:0000h
394A:0148 83 C4 08        	add	sp,8h
394A:014B 8B F8           	mov	di,ax
394A:014D 8B C7           	mov	ax,di
394A:014F 3B C6           	cmp	ax,si
394A:0151 74 12           	jz	0165h

l394A_0153:
394A:0153 0B FF           	or	di,di
394A:0155 73 05           	jnc	015Ch

l394A_0157:
394A:0157 B8 FF FF        	mov	ax,0FFFFh
394A:015A EB 07           	jmp	0163h

l394A_015C:
394A:015C 8B 46 0C        	mov	ax,[bp+0Ch]
394A:015F 03 C7           	add	ax,di
394A:0161 2B C6           	sub	ax,si

l394A_0163:
394A:0163 EB 05           	jmp	016Ah

l394A_0165:
394A:0165 8B 46 0C        	mov	ax,[bp+0Ch]
394A:0168 EB 00           	jmp	016Ah

l394A_016A:
394A:016A 5F              	pop	di
394A:016B 5E              	pop	si
394A:016C 8B E5           	mov	sp,bp
394A:016E 5D              	pop	bp
394A:016F CB              	retf
