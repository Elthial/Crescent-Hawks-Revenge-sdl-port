;;; Segment 21E7 (21E7:0000)
21E7:0000 EC E3 83 C4 0C 9A 7A 3B 00 08 5E CB             ......z;..^.    

;; ReadWholeResourceFile_000C: 21E7:000C
;;   Called from:
;;     0D73:327D (in LoadScreenPalette_324E)
;;     3014:01E5 (in LoadMusicResource_0197)
;;     31FB:0243 (in LoadDigitalWeaponEffectBank_00B3)
ReadWholeResourceFile_000C proc
21E7:000C 55              	push	bp
21E7:000D 8B EC           	mov	bp,sp
21E7:000F 56              	push	si
21E7:0010 B8 01 00        	mov	ax,1h
21E7:0013 50              	push	ax
21E7:0014 FF 76 08        	push	word ptr [bp+8h]
21E7:0017 FF 76 06        	push	word ptr [bp+6h]
21E7:001A 9A 37 00 90 33  	call	far 3390h:0037h
21E7:001F 83 C4 06        	add	sp,6h
21E7:0022 8B F0           	mov	si,ax
21E7:0024 8B 46 0E        	mov	ax,[bp+0Eh]
21E7:0027 33 D2           	xor	dx,dx
21E7:0029 52              	push	dx
21E7:002A 50              	push	ax
21E7:002B FF 76 0C        	push	word ptr [bp+0Ch]
21E7:002E FF 76 0A        	push	word ptr [bp+0Ah]
21E7:0031 56              	push	si
21E7:0032 9A 8C 02 90 33  	call	far 3390h:028Ch
21E7:0037 83 C4 0A        	add	sp,0Ah
21E7:003A 56              	push	si
21E7:003B 9A 44 02 90 33  	call	far 3390h:0244h
21E7:0040 59              	pop	cx
21E7:0041 5E              	pop	si
21E7:0042 5D              	pop	bp
21E7:0043 CB              	retf

;; ReadResourceFileSpan_0044: 21E7:0044
;;   Called from:
;;     31FB:052F (in LoadScenarioDigitalSoundBank_0297)
ReadResourceFileSpan_0044 proc
21E7:0044 55              	push	bp
21E7:0045 8B EC           	mov	bp,sp
21E7:0047 56              	push	si
21E7:0048 B8 01 00        	mov	ax,1h
21E7:004B 50              	push	ax
21E7:004C FF 76 08        	push	word ptr [bp+8h]
21E7:004F FF 76 06        	push	word ptr [bp+6h]
21E7:0052 9A 37 00 90 33  	call	far 3390h:0037h
21E7:0057 83 C4 06        	add	sp,6h
21E7:005A 8B F0           	mov	si,ax
21E7:005C 33 C0           	xor	ax,ax
21E7:005E 50              	push	ax
21E7:005F FF 76 0C        	push	word ptr [bp+0Ch]
21E7:0062 FF 76 0A        	push	word ptr [bp+0Ah]
21E7:0065 56              	push	si
21E7:0066 9A 41 04 90 33  	call	far 3390h:0441h
21E7:006B 83 C4 08        	add	sp,8h
21E7:006E 8B 46 12        	mov	ax,[bp+12h]
21E7:0071 33 D2           	xor	dx,dx
21E7:0073 52              	push	dx
21E7:0074 50              	push	ax
21E7:0075 FF 76 10        	push	word ptr [bp+10h]
21E7:0078 FF 76 0E        	push	word ptr [bp+0Eh]
21E7:007B 56              	push	si
21E7:007C 9A 8C 02 90 33  	call	far 3390h:028Ch
21E7:0081 83 C4 0A        	add	sp,0Ah
21E7:0084 56              	push	si
21E7:0085 9A 44 02 90 33  	call	far 3390h:0244h
21E7:008A 59              	pop	cx
21E7:008B 5E              	pop	si
21E7:008C 5D              	pop	bp
21E7:008D CB              	retf

;; LoadAndDecodePackedResource_008E: 21E7:008E
;;   Called from:
;;     0D73:3326 (in LoadScreenAssetToWorkBuffer_32F4)
;;     0D73:3357 (in LoadScreenAssetToWorkBuffer_32F4)
;;     0D73:40C6 (in LoadGraphicsResourceToBuffers_4099)
;;     0D73:40F2 (in LoadGraphicsResourceToBuffers_4099)
LoadAndDecodePackedResource_008E proc
21E7:008E 55              	push	bp
21E7:008F 8B EC           	mov	bp,sp
21E7:0091 83 EC 02        	sub	sp,2h
21E7:0094 56              	push	si
21E7:0095 B8 01 00        	mov	ax,1h
21E7:0098 50              	push	ax
21E7:0099 FF 76 08        	push	word ptr [bp+8h]
21E7:009C FF 76 06        	push	word ptr [bp+6h]
21E7:009F 9A 37 00 90 33  	call	far 3390h:0037h
21E7:00A4 83 C4 06        	add	sp,6h
21E7:00A7 8B F0           	mov	si,ax
21E7:00A9 33 D2           	xor	dx,dx
21E7:00AB B8 02 00        	mov	ax,2h
21E7:00AE 52              	push	dx
21E7:00AF 50              	push	ax
21E7:00B0 16              	push	ss
21E7:00B1 8D 46 FE        	lea	ax,[bp-2h]
21E7:00B4 50              	push	ax
21E7:00B5 56              	push	si
21E7:00B6 9A 8C 02 90 33  	call	far 3390h:028Ch
21E7:00BB 83 C4 0A        	add	sp,0Ah
21E7:00BE 8B 46 FE        	mov	ax,[bp-2h]
21E7:00C1 33 D2           	xor	dx,dx
21E7:00C3 52              	push	dx
21E7:00C4 50              	push	ax
21E7:00C5 FF 76 0C        	push	word ptr [bp+0Ch]
21E7:00C8 FF 76 0A        	push	word ptr [bp+0Ah]
21E7:00CB 56              	push	si
21E7:00CC 9A 8C 02 90 33  	call	far 3390h:028Ch
21E7:00D1 83 C4 0A        	add	sp,0Ah
21E7:00D4 56              	push	si
21E7:00D5 9A 44 02 90 33  	call	far 3390h:0244h
21E7:00DA 59              	pop	cx
21E7:00DB FF 76 10        	push	word ptr [bp+10h]
21E7:00DE FF 76 0E        	push	word ptr [bp+0Eh]
21E7:00E1 FF 76 0C        	push	word ptr [bp+0Ch]
21E7:00E4 FF 76 0A        	push	word ptr [bp+0Ah]
21E7:00E7 9A F4 00 E7 21  	call	far 21E7h:00F4h
21E7:00EC 83 C4 08        	add	sp,8h
21E7:00EF 5E              	pop	si
21E7:00F0 8B E5           	mov	sp,bp
21E7:00F2 5D              	pop	bp
21E7:00F3 CB              	retf

;; DecodeWestwoodPackedResource_00F4: 21E7:00F4
;;   Called from:
;;     21E7:00E7 (in LoadAndDecodePackedResource_008E)
DecodeWestwoodPackedResource_00F4 proc
21E7:00F4 55              	push	bp
21E7:00F5 8B EC           	mov	bp,sp
21E7:00F7 83 EC 04        	sub	sp,4h
21E7:00FA C4 5E 06        	les	bx,[bp+6h]
21E7:00FD 26 8A 07        	mov	al,es:[bx]
21E7:0100 98              	cbw
21E7:0101 99              	cwd
21E7:0102 3D 03 00        	cmp	ax,3h
21E7:0105 76 03           	jbe	010Ah

l21E7_0107:
21E7:0107 E9 F4 00        	jmp	01FEh

l21E7_010A:
21E7:010A 8B D8           	mov	bx,ax
21E7:010C D1 E3           	shl	bx,1h
21E7:010E 2E FF A7 13 01  	jmp	word ptr cs:[bx+113h]
l21E7_0113	dw	0x011B
l21E7_0115	dw	0x0154
l21E7_0117	dw	0x01A9
l21E7_0119	dw	0x0142

l21E7_011B:
21E7:011B C4 5E 06        	les	bx,[bp+6h]
21E7:011E 26 FF 77 04     	push	word ptr es:[bx+4h]
21E7:0122 26 FF 77 02     	push	word ptr es:[bx+2h]
21E7:0126 FF 76 0C        	push	word ptr [bp+0Ch]
21E7:0129 FF 76 0A        	push	word ptr [bp+0Ah]
21E7:012C 8B 56 08        	mov	dx,[bp+8h]
21E7:012F 8B 46 06        	mov	ax,[bp+6h]
21E7:0132 05 08 00        	add	ax,8h
21E7:0135 52              	push	dx
21E7:0136 50              	push	ax
21E7:0137 9A 34 0C 00 08  	call	far 0800h:0C34h
21E7:013C 83 C4 0C        	add	sp,0Ch
21E7:013F E9 BC 00        	jmp	01FEh

l21E7_0142:
21E7:0142 8B 46 0C        	mov	ax,[bp+0Ch]
21E7:0145 50              	push	ax
21E7:0146 8B 46 08        	mov	ax,[bp+8h]
21E7:0149 50              	push	ax
21E7:014A 9A 9A 0C 00 08  	call	far 0800h:0C9Ah
21E7:014F 59              	pop	cx
21E7:0150 59              	pop	cx
21E7:0151 E9 AA 00        	jmp	01FEh

l21E7_0154:
21E7:0154 81 3E 70 2F 00 3C 	cmp	word ptr [2F70h],3C00h
21E7:015A 73 37           	jnc	0193h

l21E7_015C:
21E7:015C 33 D2           	xor	dx,dx
21E7:015E B8 00 3C        	mov	ax,3C00h
21E7:0161 52              	push	dx
21E7:0162 50              	push	ax
21E7:0163 9A 12 01 56 0D  	call	far 0D56h:0112h
21E7:0168 59              	pop	cx
21E7:0169 59              	pop	cx
21E7:016A 89 56 FE        	mov	[bp-2h],dx
21E7:016D 89 46 FC        	mov	[bp-4h],ax
21E7:0170 8B 46 FE        	mov	ax,[bp-2h]
21E7:0173 50              	push	ax
21E7:0174 8B 46 0C        	mov	ax,[bp+0Ch]
21E7:0177 50              	push	ax
21E7:0178 8B 46 08        	mov	ax,[bp+8h]
21E7:017B 50              	push	ax
21E7:017C 9A 1A 0D 00 08  	call	far 0800h:0D1Ah
21E7:0181 83 C4 06        	add	sp,6h
21E7:0184 FF 76 FE        	push	word ptr [bp-2h]
21E7:0187 FF 76 FC        	push	word ptr [bp-4h]
21E7:018A 9A A5 01 56 0D  	call	far 0D56h:01A5h
21E7:018F 59              	pop	cx
21E7:0190 59              	pop	cx
21E7:0191 EB 14           	jmp	01A7h

l21E7_0193:
21E7:0193 FF 36 6E 2F     	push	word ptr [2F6Eh]
21E7:0197 8B 46 0C        	mov	ax,[bp+0Ch]
21E7:019A 50              	push	ax
21E7:019B 8B 46 08        	mov	ax,[bp+8h]
21E7:019E 50              	push	ax
21E7:019F 9A 1A 0D 00 08  	call	far 0800h:0D1Ah
21E7:01A4 83 C4 06        	add	sp,6h

l21E7_01A7:
21E7:01A7 EB 55           	jmp	01FEh

l21E7_01A9:
21E7:01A9 81 3E 70 2F 00 BD 	cmp	word ptr [2F70h],0BD00h
21E7:01AF 73 37           	jnc	01E8h

l21E7_01B1:
21E7:01B1 33 D2           	xor	dx,dx
21E7:01B3 B8 00 BD        	mov	ax,0BD00h
21E7:01B6 52              	push	dx
21E7:01B7 50              	push	ax
21E7:01B8 9A 12 01 56 0D  	call	far 0D56h:0112h
21E7:01BD 59              	pop	cx
21E7:01BE 59              	pop	cx
21E7:01BF 89 56 FE        	mov	[bp-2h],dx
21E7:01C2 89 46 FC        	mov	[bp-4h],ax
21E7:01C5 8B 46 FE        	mov	ax,[bp-2h]
21E7:01C8 50              	push	ax
21E7:01C9 8B 46 0C        	mov	ax,[bp+0Ch]
21E7:01CC 50              	push	ax
21E7:01CD 8B 46 08        	mov	ax,[bp+8h]
21E7:01D0 50              	push	ax
21E7:01D1 9A 16 0E 00 08  	call	far 0800h:0E16h
21E7:01D6 83 C4 06        	add	sp,6h
21E7:01D9 FF 76 FE        	push	word ptr [bp-2h]
21E7:01DC FF 76 FC        	push	word ptr [bp-4h]
21E7:01DF 9A A5 01 56 0D  	call	far 0D56h:01A5h
21E7:01E4 59              	pop	cx
21E7:01E5 59              	pop	cx
21E7:01E6 EB 14           	jmp	01FCh

l21E7_01E8:
21E7:01E8 FF 36 6E 2F     	push	word ptr [2F6Eh]
21E7:01EC 8B 46 0C        	mov	ax,[bp+0Ch]
21E7:01EF 50              	push	ax
21E7:01F0 8B 46 08        	mov	ax,[bp+8h]
21E7:01F3 50              	push	ax
21E7:01F4 9A 16 0E 00 08  	call	far 0800h:0E16h
21E7:01F9 83 C4 06        	add	sp,6h

l21E7_01FC:
21E7:01FC EB 00           	jmp	01FEh

l21E7_01FE:
21E7:01FE 8B E5           	mov	sp,bp
21E7:0200 5D              	pop	bp
21E7:0201 CB              	retf
21E7:0202       55 8B EC 8B 46 06 A3 6E 2F 0B C0 75 00 8B   U...F..n/..u..
