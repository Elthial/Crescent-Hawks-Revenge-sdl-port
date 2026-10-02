;;; Segment 2B34 (2B34:0000)
2B34:0000 08 59 59                                        .YY             

l2B2D_0073:
2B2D:0073 5F              	pop	di
2B2D:0074 5E              	pop	si
2B2D:0075 5D              	pop	bp
2B2D:0076 CB              	retf

;; CountOrRemoveUnitHeatSinks_0077: 2B2D:0077
;;   Called from:
;;     2B2D:01EA (in CalculateUnitWeaponHeatScale_0191)
;;     2D1B:0052 (in RecalculateUnitCombatRatings_0005)
CountOrRemoveUnitHeatSinks_0077 proc
2B34:0007 55              	push	bp
2B34:0008 8B EC           	mov	bp,sp
2B34:000A 56              	push	si
2B34:000B 57              	push	di
2B34:000C C4 5E 06        	les	bx,[bp+6h]
2B34:000F 26 8A 47 54     	mov	al,es:[bx+54h]
2B34:0013 98              	cbw
2B34:0014 8B F8           	mov	di,ax
2B34:0016 33 F6           	xor	si,si
2B34:0018 E9 DD 00        	jmp	00F8h

l2B34_001B:
2B34:001B C4 5E 06        	les	bx,[bp+6h]
2B34:001E 03 DE           	add	bx,si
2B34:0020 26 80 7F 5E 18  	cmp	byte ptr es:[bx+5Eh],18h
2B34:0025 75 11           	jnz	0038h

l2B34_0027:
2B34:0027 47              	inc	di
2B34:0028 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:002C 74 0A           	jz	0038h

l2B34_002E:
2B34:002E C4 5E 06        	les	bx,[bp+6h]
2B34:0031 03 DE           	add	bx,si
2B34:0033 26 C6 47 5E 00  	mov	byte ptr es:[bx+5Eh],0h

l2B34_0038:
2B34:0038 C4 5E 06        	les	bx,[bp+6h]
2B34:003B 03 DE           	add	bx,si
2B34:003D 26 80 7F 6C 18  	cmp	byte ptr es:[bx+6Ch],18h
2B34:0042 75 11           	jnz	0055h

l2B34_0044:
2B34:0044 47              	inc	di
2B34:0045 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:0049 74 0A           	jz	0055h

l2B34_004B:
2B34:004B C4 5E 06        	les	bx,[bp+6h]
2B34:004E 03 DE           	add	bx,si
2B34:0050 26 C6 47 6C 00  	mov	byte ptr es:[bx+6Ch],0h

l2B34_0055:
2B34:0055 83 FE 08        	cmp	si,8h
2B34:0058 7C 03           	jl	005Dh

l2B34_005A:
2B34:005A E9 9A 00        	jmp	00F7h

l2B34_005D:
2B34:005D C4 5E 06        	les	bx,[bp+6h]
2B34:0060 03 DE           	add	bx,si
2B34:0062 26 80 7F 56 18  	cmp	byte ptr es:[bx+56h],18h
2B34:0067 75 11           	jnz	007Ah

l2B34_0069:
2B34:0069 47              	inc	di
2B34:006A 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:006E 74 0A           	jz	007Ah

l2B34_0070:
2B34:0070 C4 5E 06        	les	bx,[bp+6h]
2B34:0073 03 DE           	add	bx,si
2B34:0075 26 C6 47 56 00  	mov	byte ptr es:[bx+56h],0h

l2B34_007A:
2B34:007A C4 5E 06        	les	bx,[bp+6h]
2B34:007D 03 DE           	add	bx,si
2B34:007F 26 80 7F 78 18  	cmp	byte ptr es:[bx+78h],18h
2B34:0084 75 11           	jnz	0097h

l2B34_0086:
2B34:0086 47              	inc	di
2B34:0087 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:008B 74 0A           	jz	0097h

l2B34_008D:
2B34:008D C4 5E 06        	les	bx,[bp+6h]
2B34:0090 03 DE           	add	bx,si
2B34:0092 26 C6 47 78 00  	mov	byte ptr es:[bx+78h],0h

l2B34_0097:
2B34:0097 83 FE 02        	cmp	si,2h
2B34:009A 7D 5B           	jge	00F7h

l2B34_009C:
2B34:009C C4 5E 06        	les	bx,[bp+6h]
2B34:009F 03 DE           	add	bx,si
2B34:00A1 26 80 7F 6A 18  	cmp	byte ptr es:[bx+6Ah],18h
2B34:00A6 75 11           	jnz	00B9h

l2B34_00A8:
2B34:00A8 47              	inc	di
2B34:00A9 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:00AD 74 0A           	jz	00B9h

l2B34_00AF:
2B34:00AF C4 5E 06        	les	bx,[bp+6h]
2B34:00B2 03 DE           	add	bx,si
2B34:00B4 26 C6 47 6A 00  	mov	byte ptr es:[bx+6Ah],0h

l2B34_00B9:
2B34:00B9 C4 5E 06        	les	bx,[bp+6h]
2B34:00BC 03 DE           	add	bx,si
2B34:00BE 26 80 BF 80 00 18 	cmp	byte ptr es:[bx+80h],18h
2B34:00C4 75 12           	jnz	00D8h

l2B34_00C6:
2B34:00C6 47              	inc	di
2B34:00C7 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:00CB 74 0B           	jz	00D8h

l2B34_00CD:
2B34:00CD C4 5E 06        	les	bx,[bp+6h]
2B34:00D0 03 DE           	add	bx,si
2B34:00D2 26 C6 87 80 00 00 	mov	byte ptr es:[bx+80h],0h

l2B34_00D8:
2B34:00D8 C4 5E 06        	les	bx,[bp+6h]
2B34:00DB 03 DE           	add	bx,si
2B34:00DD 26 80 BF 82 00 18 	cmp	byte ptr es:[bx+82h],18h
2B34:00E3 75 12           	jnz	00F7h

l2B34_00E5:
2B34:00E5 47              	inc	di
2B34:00E6 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:00EA 74 0B           	jz	00F7h

l2B34_00EC:
2B34:00EC C4 5E 06        	les	bx,[bp+6h]
2B34:00EF 03 DE           	add	bx,si
2B34:00F1 26 C6 87 82 00 00 	mov	byte ptr es:[bx+82h],0h

l2B34_00F7:
2B34:00F7 46              	inc	si

l2B34_00F8:
2B34:00F8 83 FE 0C        	cmp	si,0Ch
2B34:00FB 7D 03           	jge	0100h

l2B34_00FD:
2B34:00FD E9 1B FF        	jmp	001Bh

l2B34_0100:
2B34:0100 C4 5E 06        	les	bx,[bp+6h]
2B34:0103 26 80 7F 55 18  	cmp	byte ptr es:[bx+55h],18h
2B34:0108 75 0F           	jnz	0119h

l2B34_010A:
2B34:010A 47              	inc	di
2B34:010B 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2B34:010F 74 08           	jz	0119h

l2B34_0111:
2B34:0111 C4 5E 06        	les	bx,[bp+6h]
2B34:0114 26 C6 47 55 00  	mov	byte ptr es:[bx+55h],0h

l2B34_0119:
2B34:0119 8B C7           	mov	ax,di
2B34:011B EB 00           	jmp	011Dh

l2B34_011D:
2B34:011D 5F              	pop	di
2B34:011E 5E              	pop	si
2B34:011F 5D              	pop	bp
2B34:0120 CB              	retf

;; CalculateUnitWeaponHeatScale_0191: 2B2D:0191
;;   Called from:
;;     2507:4DF6 (in DrawUnitStatusScreen_483A)
CalculateUnitWeaponHeatScale_0191 proc
2B2D:0191 55              	push	bp
2B2D:0192 8B EC           	mov	bp,sp
2B2D:0194 56              	push	si
2B2D:0195 57              	push	di
2B2D:0196 FF 76 08        	push	word ptr [bp+8h]
2B2D:0199 FF 76 06        	push	word ptr [bp+6h]
2B2D:019C 9A 69 04 34 2B  	call	far 2B34h:0469h
2B2D:01A1 59              	pop	cx
2B2D:01A2 59              	pop	cx
2B2D:01A3 BE 02 00        	mov	si,2h
2B2D:01A6 C4 5E 06        	les	bx,[bp+6h]
2B2D:01A9 26 80 7F 03 00  	cmp	byte ptr es:[bx+3h],0h
2B2D:01AE 74 03           	jz	01B3h

l2B2D_01B0:
2B2D:01B0 83 C6 03        	add	si,3h

l2B2D_01B3:
2B2D:01B3 33 FF           	xor	di,di
2B2D:01B5 EB 25           	jmp	01DCh

l2B2D_01B7:
2B2D:01B7 8B DF           	mov	bx,di
2B2D:01B9 D1 E3           	shl	bx,1h
2B2D:01BB 8B 87 BF 88     	mov	ax,[bx+88BFh]
2B2D:01BF 50              	push	ax
2B2D:01C0 8B C7           	mov	ax,di
2B2D:01C2 BA 0F 00        	mov	dx,0Fh
2B2D:01C5 F7 E2           	mul	dx
2B2D:01C7 8B D8           	mov	bx,ax
2B2D:01C9 81 C3 35 04     	add	bx,435h
2B2D:01CD 1E              	push	ds
2B2D:01CE 07              	pop	es
2B2D:01CF 26 8A 47 04     	mov	al,es:[bx+4h]
2B2D:01D3 98              	cbw
2B2D:01D4 8B D0           	mov	dx,ax
2B2D:01D6 58              	pop	ax
2B2D:01D7 F7 E2           	mul	dx
2B2D:01D9 03 F0           	add	si,ax
2B2D:01DB 47              	inc	di

l2B2D_01DC:
2B2D:01DC 83 FF 17        	cmp	di,17h
2B2D:01DF 7C D6           	jl	01B7h

l2B2D_01E1:
2B2D:01E1 33 C0           	xor	ax,ax
2B2D:01E3 50              	push	ax
2B2D:01E4 FF 76 08        	push	word ptr [bp+8h]
2B2D:01E7 FF 76 06        	push	word ptr [bp+6h]
2B2D:01EA 0E              	push	cs
2B2D:01EB E8 89 FE        	call	0077h
2B2D:01EE 83 C4 06        	add	sp,6h
2B2D:01F1 2B F0           	sub	si,ax
2B2D:01F3 0B F6           	or	si,si
2B2D:01F5 7D 02           	jge	01F9h

l2B2D_01F7:
2B2D:01F7 33 F6           	xor	si,si

l2B2D_01F9:
2B2D:01F9 83 FE 1E        	cmp	si,1Eh
2B2D:01FC 7E 03           	jle	0201h

l2B2D_01FE:
2B2D:01FE BE 1E 00        	mov	si,1Eh

l2B2D_0201:
2B2D:0201 8B C6           	mov	ax,si
2B2D:0203 BB 04 00        	mov	bx,4h
2B2D:0206 99              	cwd
2B2D:0207 F7 FB           	idiv	bx
2B2D:0209 8B F0           	mov	si,ax
2B2D:020B 83 FE 05        	cmp	si,5h
2B2D:020E 7E 03           	jle	0213h

l2B2D_0210:
2B2D:0210 BE 05 00        	mov	si,5h

l2B2D_0213:
2B2D:0213 8B C6           	mov	ax,si
2B2D:0215 EB 00           	jmp	0217h

l2B2D_0217:
2B2D:0217 5F              	pop	di
2B2D:0218 5E              	pop	si
2B2D:0219 5D              	pop	bp
2B2D:021A CB              	retf

;; FindUnitWeaponByOrdinal_01AB: 2B34:01AB
;;   Called from:
;;     1A1F:2B19 (in ExecuteSceneInstructions_2A4E)
;;     1A1F:2B38 (in ExecuteSceneInstructions_2A4E)
;;     1A1F:3080 (in ExecuteSceneInstructions_2A4E)
;;     2B34:04A0 (in CountUnitWeaponsByType_0469)
FindUnitWeaponByOrdinal_01AB proc
2B34:01AB 55              	push	bp
2B34:01AC 8B EC           	mov	bp,sp
2B34:01AE 83 EC 10        	sub	sp,10h
2B34:01B1 56              	push	si
2B34:01B2 57              	push	di
2B34:01B3 C4 5E 06        	les	bx,[bp+6h]
2B34:01B6 83 C3 55        	add	bx,55h
2B34:01B9 8C 46 FC        	mov	[bp-4h],es
2B34:01BC 89 5E FA        	mov	[bp-6h],bx
2B34:01BF BE 01 00        	mov	si,1h
2B34:01C2 33 C0           	xor	ax,ax
2B34:01C4 89 46 F4        	mov	[bp-0Ch],ax
2B34:01C7 89 46 F2        	mov	[bp-0Eh],ax
2B34:01CA 89 46 F0        	mov	[bp-10h],ax
2B34:01CD E9 91 01        	jmp	0361h

l2B34_01D0:
2B34:01D0 33 FF           	xor	di,di
2B34:01D2 E9 CC 00        	jmp	02A1h

l2B34_01D5:
2B34:01D5 C4 5E FA        	les	bx,[bp-6h]
2B34:01D8 26 8A 01        	mov	al,es:[bx+di]
2B34:01DB 88 46 FF        	mov	[bp-1h],al
2B34:01DE 80 7E FF 01     	cmp	byte ptr [bp-1h],1h
2B34:01E2 7D 03           	jge	01E7h

l2B34_01E4:
2B34:01E4 E9 B9 00        	jmp	02A0h

l2B34_01E7:
2B34:01E7 80 7E FF 17     	cmp	byte ptr [bp-1h],17h
2B34:01EB 7E 03           	jle	01F0h

l2B34_01ED:
2B34:01ED E9 B0 00        	jmp	02A0h

l2B34_01F0:
2B34:01F0 8B 46 F0        	mov	ax,[bp-10h]
2B34:01F3 3B 46 0A        	cmp	ax,[bp+0Ah]
2B34:01F6 74 03           	jz	01FBh

l2B34_01F8:
2B34:01F8 E9 A2 00        	jmp	029Dh

l2B34_01FB:
2B34:01FB 8A 46 FF        	mov	al,[bp-1h]
2B34:01FE 98              	cbw
2B34:01FF 89 46 F6        	mov	[bp-0Ah],ax
2B34:0202 C7 46 F4 01 00  	mov	word ptr [bp-0Ch],1h
2B34:0207 8B 46 F2        	mov	ax,[bp-0Eh]
2B34:020A A3 63 86        	mov	[8663h],ax
2B34:020D 83 7E 0C 00     	cmp	word ptr [bp+0Ch],0h
2B34:0211 75 03           	jnz	0216h

l2B34_0213:
2B34:0213 E9 85 00        	jmp	029Bh

l2B34_0216:
2B34:0216 FE 4E FF        	dec	byte ptr [bp-1h]
2B34:0219 C7 46 F8 01 00  	mov	word ptr [bp-8h],1h
2B34:021E EB 08           	jmp	0228h

l2B34_0220:
2B34:0220 C4 5E FA        	les	bx,[bp-6h]
2B34:0223 26 C6 01 00     	mov	byte ptr es:[bx+di],0h
2B34:0227 47              	inc	di

l2B34_0228:
2B34:0228 8B 46 F8        	mov	ax,[bp-8h]
2B34:022B FF 4E F8        	dec	word ptr [bp-8h]
2B34:022E 0B C0           	or	ax,ax
2B34:0230 75 EE           	jnz	0220h

l2B34_0232:
2B34:0232 8A 46 FF        	mov	al,[bp-1h]
2B34:0235 98              	cbw
2B34:0236 BA 0F 00        	mov	dx,0Fh
2B34:0239 F7 E2           	mul	dx
2B34:023B 8B D8           	mov	bx,ax
2B34:023D 81 C3 35 04     	add	bx,435h
2B34:0241 1E              	push	ds
2B34:0242 07              	pop	es
2B34:0243 26 80 7F 0B 00  	cmp	byte ptr es:[bx+0Bh],0h
2B34:0248 74 51           	jz	029Bh

l2B34_024A:
2B34:024A FF 76 08        	push	word ptr [bp+8h]
2B34:024D FF 76 06        	push	word ptr [bp+6h]
2B34:0250 9A 69 04 34 2B  	call	far 2B34h:0469h
2B34:0255 59              	pop	cx
2B34:0256 59              	pop	cx
2B34:0257 8A 46 FF        	mov	al,[bp-1h]
2B34:025A 98              	cbw
2B34:025B 8B D8           	mov	bx,ax
2B34:025D D1 E3           	shl	bx,1h
2B34:025F 83 BF BF 88 00  	cmp	word ptr [bx+88BFh],0h
2B34:0264 75 35           	jnz	029Bh

l2B34_0266:
2B34:0266 8A 46 FF        	mov	al,[bp-1h]
2B34:0269 98              	cbw
2B34:026A BA 0F 00        	mov	dx,0Fh
2B34:026D F7 E2           	mul	dx
2B34:026F 8B D8           	mov	bx,ax
2B34:0271 81 C3 35 04     	add	bx,435h
2B34:0275 1E              	push	ds
2B34:0276 07              	pop	es
2B34:0277 26 8A 47 0B     	mov	al,es:[bx+0Bh]
2B34:027B 98              	cbw
2B34:027C 48              	dec	ax
2B34:027D 89 46 F8        	mov	[bp-8h],ax
2B34:0280 B0 00           	mov	al,0h
2B34:0282 C4 5E 06        	les	bx,[bp+6h]
2B34:0285 03 5E F8        	add	bx,[bp-8h]
2B34:0288 26 88 47 2A     	mov	es:[bx+2Ah],al
2B34:028C 98              	cbw
2B34:028D 8B 56 F8        	mov	dx,[bp-8h]
2B34:0290 D1 E2           	shl	dx,1h
2B34:0292 C4 5E 06        	les	bx,[bp+6h]
2B34:0295 03 DA           	add	bx,dx
2B34:0297 26 89 47 38     	mov	es:[bx+38h],ax

l2B34_029B:
2B34:029B EB 03           	jmp	02A0h

l2B34_029D:
2B34:029D FF 46 F0        	inc	word ptr [bp-10h]

l2B34_02A0:
2B34:02A0 47              	inc	di

l2B34_02A1:
2B34:02A1 3B FE           	cmp	di,si
2B34:02A3 7D 09           	jge	02AEh

l2B34_02A5:
2B34:02A5 83 7E F4 00     	cmp	word ptr [bp-0Ch],0h
2B34:02A9 75 03           	jnz	02AEh

l2B34_02AB:
2B34:02AB E9 27 FF        	jmp	01D5h

l2B34_02AE:
2B34:02AE 83 7E F4 00     	cmp	word ptr [bp-0Ch],0h
2B34:02B2 74 03           	jz	02B7h

l2B34_02B4:
2B34:02B4 E9 A7 00        	jmp	035Eh

l2B34_02B7:
2B34:02B7 8B 46 F2        	mov	ax,[bp-0Eh]
2B34:02BA 3D 06 00        	cmp	ax,6h
2B34:02BD 76 03           	jbe	02C2h

l2B34_02BF:
2B34:02BF E9 90 00        	jmp	0352h

l2B34_02C2:
2B34:02C2 8B D8           	mov	bx,ax
2B34:02C4 D1 E3           	shl	bx,1h
2B34:02C6 2E FF A7 CB 02  	jmp	word ptr cs:[bx+2CBh]
l2B34_02CB	dw	0x02D9
l2B34_02CD	dw	0x02EA
l2B34_02CF	dw	0x02FB
l2B34_02D1	dw	0x030C
l2B34_02D3	dw	0x031D
l2B34_02D5	dw	0x032E
l2B34_02D7	dw	0x0340

l2B34_02D9:
2B34:02D9 C4 5E 06        	les	bx,[bp+6h]
2B34:02DC 83 C3 56        	add	bx,56h
2B34:02DF 8C 46 FC        	mov	[bp-4h],es
2B34:02E2 89 5E FA        	mov	[bp-6h],bx
2B34:02E5 BE 08 00        	mov	si,8h
2B34:02E8 EB 74           	jmp	035Eh

l2B34_02EA:
2B34:02EA C4 5E 06        	les	bx,[bp+6h]
2B34:02ED 83 C3 5E        	add	bx,5Eh
2B34:02F0 8C 46 FC        	mov	[bp-4h],es
2B34:02F3 89 5E FA        	mov	[bp-6h],bx
2B34:02F6 BE 0C 00        	mov	si,0Ch
2B34:02F9 EB 63           	jmp	035Eh

l2B34_02FB:
2B34:02FB C4 5E 06        	les	bx,[bp+6h]
2B34:02FE 83 C3 6A        	add	bx,6Ah
2B34:0301 8C 46 FC        	mov	[bp-4h],es
2B34:0304 89 5E FA        	mov	[bp-6h],bx
2B34:0307 BE 02 00        	mov	si,2h
2B34:030A EB 52           	jmp	035Eh

l2B34_030C:
2B34:030C C4 5E 06        	les	bx,[bp+6h]
2B34:030F 83 C3 6C        	add	bx,6Ch
2B34:0312 8C 46 FC        	mov	[bp-4h],es
2B34:0315 89 5E FA        	mov	[bp-6h],bx
2B34:0318 BE 0C 00        	mov	si,0Ch
2B34:031B EB 41           	jmp	035Eh

l2B34_031D:
2B34:031D C4 5E 06        	les	bx,[bp+6h]
2B34:0320 83 C3 78        	add	bx,78h
2B34:0323 8C 46 FC        	mov	[bp-4h],es
2B34:0326 89 5E FA        	mov	[bp-6h],bx
2B34:0329 BE 08 00        	mov	si,8h
2B34:032C EB 30           	jmp	035Eh

l2B34_032E:
2B34:032E C4 5E 06        	les	bx,[bp+6h]
2B34:0331 81 C3 80 00     	add	bx,80h
2B34:0335 8C 46 FC        	mov	[bp-4h],es
2B34:0338 89 5E FA        	mov	[bp-6h],bx
2B34:033B BE 02 00        	mov	si,2h
2B34:033E EB 1E           	jmp	035Eh

l2B34_0340:
2B34:0340 C4 5E 06        	les	bx,[bp+6h]
2B34:0343 81 C3 82 00     	add	bx,82h
2B34:0347 8C 46 FC        	mov	[bp-4h],es
2B34:034A 89 5E FA        	mov	[bp-6h],bx
2B34:034D BE 02 00        	mov	si,2h
2B34:0350 EB 0C           	jmp	035Eh

l2B34_0352:
2B34:0352 C7 46 F4 01 00  	mov	word ptr [bp-0Ch],1h
2B34:0357 C7 46 F6 FF FF  	mov	word ptr [bp-0Ah],0FFFFh
2B34:035C EB 00           	jmp	035Eh

l2B34_035E:
2B34:035E FF 46 F2        	inc	word ptr [bp-0Eh]

l2B34_0361:
2B34:0361 83 7E F4 00     	cmp	word ptr [bp-0Ch],0h
2B34:0365 75 03           	jnz	036Ah

l2B34_0367:
2B34:0367 E9 66 FE        	jmp	01D0h

l2B34_036A:
2B34:036A 8B 46 F6        	mov	ax,[bp-0Ah]
2B34:036D EB 00           	jmp	036Fh

l2B34_036F:
2B34:036F 5F              	pop	di
2B34:0370 5E              	pop	si
2B34:0371 8B E5           	mov	sp,bp
2B34:0373 5D              	pop	bp
2B34:0374 CB              	retf
2B34:0375                55 8B EC 56 57 33 F6 EB 0B 8B DE      U..VW3.....
2B34:0380 D1 E3 C7 87 55 AE 00 00 46 83 FE 05 7C F0 33 FF ....U...F...|.3.
2B34:0390 E9 83 00 C4 5E 06 26 8A 01 98 48 3D 16 00 77 63 ....^.&...H=..wc
2B34:03A0 8B D8 D1 E3 2E FF A7 A9 03 E0 03 E0 03 DB 03 DB ................
2B34:03B0 03 D7 03 D7 03 D7 03 D7 03 D7 03 DB 03 D7 03 D7 ................
2B34:03C0 03 D7 03 D7 03 D7 03 E0 03 F1 03 ED 03 E9 03 E5 ................
2B34:03D0 03 FE 03 FA 03 F6 03 33 F6 EB 2D BE 03 00 EB 28 .......3..-....(
2B34:03E0 BE 04 00 EB 23 FF 06 57 AE FF 06 57 AE FF 06 57 ....#..W...W...W
2B34:03F0 AE BE 01 00 EB 12 FF 06 59 AE FF 06 59 AE BE 02 ........Y...Y...
2B34:0400 00 EB 05 BE FF FF EB 00 83 FE FF 74 08 8B DE D1 ...........t....
2B34:0410 E3 FF 87 55 AE 47 3B 7E 0A 7D 03 E9 75 FF 5F 5E ...U.G;~.}..u._^
2B34:0420 5D CB                                           ].              

;; DrawCombatRatingDescription_0422: 2B34:0422
;;   Called from:
;;     2507:4AD0 (in DrawUnitStatusScreen_483A)
;;     2507:4AFC (in DrawUnitStatusScreen_483A)
;;     2507:4B28 (in DrawUnitStatusScreen_483A)
;;     2B34:086D (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:08CD (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:092D (in DrawTacticalUnitControlPanel_04C2)
DrawCombatRatingDescription_0422 proc
2B34:0422 55              	push	bp
2B34:0423 8B EC           	mov	bp,sp
2B34:0425 56              	push	si
2B34:0426 8B 76 06        	mov	si,[bp+6h]
2B34:0429 0B F6           	or	si,si
2B34:042B 74 14           	jz	0441h

l2B34_042D:
2B34:042D 8B C6           	mov	ax,si
2B34:042F BB 09 00        	mov	bx,9h
2B34:0432 99              	cwd
2B34:0433 F7 FB           	idiv	bx
2B34:0435 8B F0           	mov	si,ax
2B34:0437 83 FE 05        	cmp	si,5h
2B34:043A 7E 03           	jle	043Fh

l2B34_043C:
2B34:043C BE 05 00        	mov	si,5h

l2B34_043F:
2B34:043F EB 03           	jmp	0444h

l2B34_0441:
2B34:0441 BE 06 00        	mov	si,6h

l2B34_0444:
2B34:0444 FF 76 0E        	push	word ptr [bp+0Eh]
2B34:0447 FF 76 0C        	push	word ptr [bp+0Ch]
2B34:044A FF 76 0A        	push	word ptr [bp+0Ah]
2B34:044D FF 76 08        	push	word ptr [bp+8h]
2B34:0450 8B DE           	mov	bx,si
2B34:0452 D1 E3           	shl	bx,1h
2B34:0454 D1 E3           	shl	bx,1h
2B34:0456 FF B7 D1 40     	push	word ptr [bx+40D1h]
2B34:045A FF B7 CF 40     	push	word ptr [bx+40CFh]
2B34:045E 9A 0B 47 00 08  	call	far 0800h:470Bh
2B34:0463 83 C4 0C        	add	sp,0Ch
2B34:0466 5E              	pop	si
2B34:0467 5D              	pop	bp
2B34:0468 CB              	retf

;; CountUnitWeaponsByType_0469: 2B34:0469
;;   Called from:
;;     2507:4C1D (in DrawUnitStatusScreen_483A)
;;     2B2D:019C (in CalculateUnitWeaponHeatScale_0191)
;;     2B34:0250 (in FindUnitWeaponByOrdinal_01AB)
;;     2D1B:001C (in RecalculateUnitCombatRatings_0005)
CountUnitWeaponsByType_0469 proc
2B34:0469 55              	push	bp
2B34:046A 8B EC           	mov	bp,sp
2B34:046C 83 EC 02        	sub	sp,2h
2B34:046F 56              	push	si
2B34:0470 57              	push	di
2B34:0471 33 F6           	xor	si,si
2B34:0473 EB 0B           	jmp	0480h

l2B34_0475:
2B34:0475 8B DE           	mov	bx,si
2B34:0477 D1 E3           	shl	bx,1h
2B34:0479 C7 87 BF 88 00 00 	mov	word ptr [bx+88BFh],0h
2B34:047F 46              	inc	si

l2B34_0480:
2B34:0480 83 FE 17        	cmp	si,17h
2B34:0483 7C F0           	jl	0475h

l2B34_0485:
2B34:0485 33 FF           	xor	di,di
2B34:0487 EB 0A           	jmp	0493h

l2B34_0489:
2B34:0489 8B 5E FE        	mov	bx,[bp-2h]
2B34:048C 4B              	dec	bx
2B34:048D D1 E3           	shl	bx,1h
2B34:048F FF 87 BF 88     	inc	word ptr [bx+88BFh]

l2B34_0493:
2B34:0493 33 C0           	xor	ax,ax
2B34:0495 50              	push	ax
2B34:0496 8B C7           	mov	ax,di
2B34:0498 47              	inc	di
2B34:0499 50              	push	ax
2B34:049A FF 76 08        	push	word ptr [bp+8h]
2B34:049D FF 76 06        	push	word ptr [bp+6h]
2B34:04A0 0E              	push	cs
2B34:04A1 E8 07 FD        	call	01ABh
2B34:04A4 83 C4 08        	add	sp,8h
2B34:04A7 89 46 FE        	mov	[bp-2h],ax
2B34:04AA 3D FF FF        	cmp	ax,0FFFFh
2B34:04AD 75 DA           	jnz	0489h

l2B34_04AF:
2B34:04AF 5F              	pop	di
2B34:04B0 5E              	pop	si
2B34:04B1 8B E5           	mov	sp,bp
2B34:04B3 5D              	pop	bp
2B34:04B4 CB              	retf

;; RenderFormattedLineBreak_04B5: 2B34:04B5
;;   Called from:
;;     2208:011D (in RunTacticalUnitCommandMenu_000B)
;;     2208:017E (in RunTacticalUnitCommandMenu_000B)
;;     2208:0218 (in RunTacticalUnitCommandMenu_000B)
;;     2208:0272 (in RunTacticalUnitCommandMenu_000B)
;;     2208:02A6 (in RunTacticalUnitCommandMenu_000B)
;;     2208:02F9 (in RunTacticalUnitCommandMenu_000B)
;;     2208:150A (in RunTacticalGameOptionsMenu_148A)
;;     2208:1555 (in RunTacticalGameOptionsMenu_148A)
;;     2208:1594 (in RunTacticalGameOptionsMenu_148A)
RenderFormattedLineBreak_04B5 proc
2B34:04B5 1E              	push	ds
2B34:04B6 B8 BE 38        	mov	ax,38BEh
2B34:04B9 50              	push	ax
2B34:04BA 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:04BF 59              	pop	cx
2B34:04C0 59              	pop	cx
2B34:04C1 CB              	retf

;; DrawTacticalUnitControlPanel_04C2: 2B34:04C2
;;   Called from:
;;     1A1F:16CB (in OpenTacticalUnitControlPanel_1697)
DrawTacticalUnitControlPanel_04C2 proc
2B34:04C2 55              	push	bp
2B34:04C3 8B EC           	mov	bp,sp
2B34:04C5 83 EC 1E        	sub	sp,1Eh
2B34:04C8 56              	push	si
2B34:04C9 57              	push	di
2B34:04CA 8B 76 06        	mov	si,[bp+6h]
2B34:04CD C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2B34:04D2 83 3E 81 B5 46  	cmp	word ptr [0B581h],46h
2B34:04D7 7C 0C           	jl	04E5h

l2B34_04D9:
2B34:04D9 83 3E 81 B5 54  	cmp	word ptr [0B581h],54h
2B34:04DE 7D 05           	jge	04E5h

l2B34_04E0:
2B34:04E0 C7 46 FE 01 00  	mov	word ptr [bp-2h],1h

l2B34_04E5:
2B34:04E5 83 FE 0C        	cmp	si,0Ch
2B34:04E8 7C 05           	jl	04EFh

l2B34_04EA:
2B34:04EA B8 01 00        	mov	ax,1h
2B34:04ED EB 02           	jmp	04F1h

l2B34_04EF:
2B34:04EF 33 C0           	xor	ax,ax

l2B34_04F1:
2B34:04F1 89 46 F6        	mov	[bp-0Ah],ax
2B34:04F4 C7 46 F8 02 00  	mov	word ptr [bp-8h],2h
2B34:04F9 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2B34:04FD 74 05           	jz	0504h

l2B34_04FF:
2B34:04FF C7 46 F8 00 00  	mov	word ptr [bp-8h],0h

l2B34_0504:
2B34:0504 9A 68 39 00 08  	call	far 0800h:3968h
2B34:0509 C7 46 EC 00 00  	mov	word ptr [bp-14h],0h
2B34:050E C7 46 E6 00 00  	mov	word ptr [bp-1Ah],0h
2B34:0513 EB 45           	jmp	055Ah

l2B34_0515:
2B34:0515 8B 46 E6        	mov	ax,[bp-1Ah]
2B34:0518 BA 96 00        	mov	dx,96h
2B34:051B F7 E2           	mul	dx
2B34:051D 8B D8           	mov	bx,ax
2B34:051F 81 C3 81 8B     	add	bx,8B81h
2B34:0523 1E              	push	ds
2B34:0524 07              	pop	es
2B34:0525 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2B34:0529 74 2C           	jz	0557h

l2B34_052B:
2B34:052B 8B 46 E6        	mov	ax,[bp-1Ah]
2B34:052E BA 96 00        	mov	dx,96h
2B34:0531 F7 E2           	mul	dx
2B34:0533 8B D8           	mov	bx,ax
2B34:0535 81 C3 81 8B     	add	bx,8B81h
2B34:0539 1E              	push	ds
2B34:053A 07              	pop	es
2B34:053B 26 80 BF 8D 00 00 	cmp	byte ptr es:[bx+8Dh],0h
2B34:0541 74 14           	jz	0557h

l2B34_0543:
2B34:0543 56              	push	si
2B34:0544 FF 76 E6        	push	word ptr [bp-1Ah]
2B34:0547 9A A6 1D 1B 2D  	call	far 2D1Bh:1DA6h
2B34:054C 59              	pop	cx
2B34:054D 59              	pop	cx
2B34:054E 0B C0           	or	ax,ax
2B34:0550 74 05           	jz	0557h

l2B34_0552:
2B34:0552 C7 46 EC 01 00  	mov	word ptr [bp-14h],1h

l2B34_0557:
2B34:0557 FF 46 E6        	inc	word ptr [bp-1Ah]

l2B34_055A:
2B34:055A 83 7E E6 0C     	cmp	word ptr [bp-1Ah],0Ch
2B34:055E 7C B5           	jl	0515h

l2B34_0560:
2B34:0560 C7 46 F0 01 00  	mov	word ptr [bp-10h],1h
2B34:0565 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2B34:0569 74 12           	jz	057Dh

l2B34_056B:
2B34:056B 83 7E EC 00     	cmp	word ptr [bp-14h],0h
2B34:056F 75 0C           	jnz	057Dh

l2B34_0571:
2B34:0571 80 BC 80 86 00  	cmp	byte ptr [si+8680h],0h
2B34:0576 75 05           	jnz	057Dh

l2B34_0578:
2B34:0578 C7 46 F0 00 00  	mov	word ptr [bp-10h],0h

l2B34_057D:
2B34:057D 56              	push	si
2B34:057E 9A 14 10 34 2B  	call	far 2B34h:1014h
2B34:0583 59              	pop	cx
2B34:0584 89 46 EA        	mov	[bp-16h],ax
2B34:0587 56              	push	si
2B34:0588 9A 0C 13 34 2B  	call	far 2B34h:130Ch
2B34:058D 59              	pop	cx
2B34:058E B8 03 00        	mov	ax,3h
2B34:0591 50              	push	ax
2B34:0592 9A 09 00 49 33  	call	far 3349h:0009h
2B34:0597 59              	pop	cx
2B34:0598 B8 0E 00        	mov	ax,0Eh
2B34:059B 50              	push	ax
2B34:059C 9A 6F 0C 07 20  	call	far 2007h:0C6Fh
2B34:05A1 59              	pop	cx
2B34:05A2 C7 06 38 62 0F 00 	mov	word ptr [6238h],0Fh
2B34:05A8 C7 46 FA 00 00  	mov	word ptr [bp-6h],0h
2B34:05AD 83 FE 0C        	cmp	si,0Ch
2B34:05B0 7D 03           	jge	05B5h

l2B34_05B2:
2B34:05B2 E9 78 00        	jmp	062Dh

l2B34_05B5:
2B34:05B5 56              	push	si
2B34:05B6 9A 43 1E 08 22  	call	far 2208h:1E43h
2B34:05BB 59              	pop	cx
2B34:05BC 0B C0           	or	ax,ax
2B34:05BE 75 6D           	jnz	062Dh

l2B34_05C0:
2B34:05C0 56              	push	si
2B34:05C1 9A CC 1C 08 22  	call	far 2208h:1CCCh
2B34:05C6 59              	pop	cx
2B34:05C7 0B C0           	or	ax,ax
2B34:05C9 75 62           	jnz	062Dh

l2B34_05CB:
2B34:05CB C7 46 E6 00 00  	mov	word ptr [bp-1Ah],0h
2B34:05D0 EB 55           	jmp	0627h

l2B34_05D2:
2B34:05D2 8B 5E E6        	mov	bx,[bp-1Ah]
2B34:05D5 80 BF 57 86 00  	cmp	byte ptr [bx+8657h],0h
2B34:05DA 74 48           	jz	0624h

l2B34_05DC:
2B34:05DC 56              	push	si
2B34:05DD FF 76 E6        	push	word ptr [bp-1Ah]
2B34:05E0 9A A6 2A 1B 2D  	call	far 2D1Bh:2AA6h
2B34:05E5 59              	pop	cx
2B34:05E6 59              	pop	cx
2B34:05E7 0B C0           	or	ax,ax
2B34:05E9 74 39           	jz	0624h

l2B34_05EB:
2B34:05EB 33 C0           	xor	ax,ax
2B34:05ED 50              	push	ax
2B34:05EE B8 0F 00        	mov	ax,0Fh
2B34:05F1 50              	push	ax
2B34:05F2 B8 05 00        	mov	ax,5h
2B34:05F5 50              	push	ax
2B34:05F6 1E              	push	ds
2B34:05F7 B8 78 42        	mov	ax,4278h
2B34:05FA 50              	push	ax
2B34:05FB 9A DB 0F 34 2B  	call	far 2B34h:0FDBh
2B34:0600 83 C4 0A        	add	sp,0Ah
2B34:0603 33 C0           	xor	ax,ax
2B34:0605 50              	push	ax
2B34:0606 B8 0F 00        	mov	ax,0Fh
2B34:0609 50              	push	ax
2B34:060A B8 06 00        	mov	ax,6h
2B34:060D 50              	push	ax
2B34:060E 1E              	push	ds
2B34:060F B8 84 42        	mov	ax,4284h
2B34:0612 50              	push	ax
2B34:0613 9A DB 0F 34 2B  	call	far 2B34h:0FDBh
2B34:0618 83 C4 0A        	add	sp,0Ah
2B34:061B B8 05 00        	mov	ax,5h
2B34:061E 89 46 FA        	mov	[bp-6h],ax
2B34:0621 89 46 E6        	mov	[bp-1Ah],ax

l2B34_0624:
2B34:0624 FF 46 E6        	inc	word ptr [bp-1Ah]

l2B34_0627:
2B34:0627 83 7E E6 04     	cmp	word ptr [bp-1Ah],4h
2B34:062B 7C A5           	jl	05D2h

l2B34_062D:
2B34:062D 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2B34:0631 74 03           	jz	0636h

l2B34_0633:
2B34:0633 E9 7E 09        	jmp	0FB4h

l2B34_0636:
2B34:0636 8B C6           	mov	ax,si
2B34:0638 BA 96 00        	mov	dx,96h
2B34:063B F7 E2           	mul	dx
2B34:063D 8B D8           	mov	bx,ax
2B34:063F 81 C3 81 8B     	add	bx,8B81h
2B34:0643 1E              	push	ds
2B34:0644 07              	pop	es
2B34:0645 26 8A 47 01     	mov	al,es:[bx+1h]
2B34:0649 98              	cbw
2B34:064A 89 46 E2        	mov	[bp-1Eh],ax
2B34:064D 33 C0           	xor	ax,ax
2B34:064F 50              	push	ax
2B34:0650 B8 0F 00        	mov	ax,0Fh
2B34:0653 50              	push	ax
2B34:0654 33 C0           	xor	ax,ax
2B34:0656 50              	push	ax
2B34:0657 8B 5E E2        	mov	bx,[bp-1Eh]
2B34:065A D1 E3           	shl	bx,1h
2B34:065C D1 E3           	shl	bx,1h
2B34:065E FF B7 30 3D     	push	word ptr [bx+3D30h]
2B34:0662 FF B7 2E 3D     	push	word ptr [bx+3D2Eh]
2B34:0666 9A DB 0F 34 2B  	call	far 2B34h:0FDBh
2B34:066B 83 C4 0A        	add	sp,0Ah
2B34:066E 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2B34:0672 74 03           	jz	0677h

l2B34_0674:
2B34:0674 E9 C0 00        	jmp	0737h

l2B34_0677:
2B34:0677 8B C6           	mov	ax,si
2B34:0679 BA 96 00        	mov	dx,96h
2B34:067C F7 E2           	mul	dx
2B34:067E 8B D8           	mov	bx,ax
2B34:0680 81 C3 81 8B     	add	bx,8B81h
2B34:0684 1E              	push	ds
2B34:0685 07              	pop	es
2B34:0686 26 8A 87 92 00  	mov	al,es:[bx+92h]
2B34:068B 98              	cbw
2B34:068C 8B D8           	mov	bx,ax
2B34:068E D1 E3           	shl	bx,1h
2B34:0690 D1 E3           	shl	bx,1h
2B34:0692 FF B7 94 3E     	push	word ptr [bx+3E94h]
2B34:0696 FF B7 92 3E     	push	word ptr [bx+3E92h]
2B34:069A 1E              	push	ds
2B34:069B B8 7E B6        	mov	ax,0B67Eh
2B34:069E 50              	push	ax
2B34:069F 9A 00 00 83 39  	call	far 3983h:0000h
2B34:06A4 83 C4 08        	add	sp,8h
2B34:06A7 1E              	push	ds
2B34:06A8 B8 C0 38        	mov	ax,38C0h
2B34:06AB 50              	push	ax
2B34:06AC 1E              	push	ds
2B34:06AD B8 7E B6        	mov	ax,0B67Eh
2B34:06B0 50              	push	ax
2B34:06B1 9A 01 00 7A 39  	call	far 397Ah:0001h
2B34:06B6 83 C4 08        	add	sp,8h
2B34:06B9 8B C6           	mov	ax,si
2B34:06BB BA 96 00        	mov	dx,96h
2B34:06BE F7 E2           	mul	dx
2B34:06C0 8B D8           	mov	bx,ax
2B34:06C2 81 C3 81 8B     	add	bx,8B81h
2B34:06C6 1E              	push	ds
2B34:06C7 07              	pop	es
2B34:06C8 26 8A 87 93 00  	mov	al,es:[bx+93h]
2B34:06CD 98              	cbw
2B34:06CE 8B D8           	mov	bx,ax
2B34:06D0 D1 E3           	shl	bx,1h
2B34:06D2 D1 E3           	shl	bx,1h
2B34:06D4 FF B7 B5 40     	push	word ptr [bx+40B5h]
2B34:06D8 FF B7 B3 40     	push	word ptr [bx+40B3h]
2B34:06DC 1E              	push	ds
2B34:06DD B8 7E B6        	mov	ax,0B67Eh
2B34:06E0 50              	push	ax
2B34:06E1 9A 01 00 7A 39  	call	far 397Ah:0001h
2B34:06E6 83 C4 08        	add	sp,8h
2B34:06E9 33 C0           	xor	ax,ax
2B34:06EB 50              	push	ax
2B34:06EC B8 0F 00        	mov	ax,0Fh
2B34:06EF 50              	push	ax
2B34:06F0 B8 01 00        	mov	ax,1h
2B34:06F3 50              	push	ax
2B34:06F4 1E              	push	ds
2B34:06F5 B8 7E B6        	mov	ax,0B67Eh
2B34:06F8 50              	push	ax
2B34:06F9 9A DB 0F 34 2B  	call	far 2B34h:0FDBh
2B34:06FE 83 C4 0A        	add	sp,0Ah
2B34:0701 33 C0           	xor	ax,ax
2B34:0703 50              	push	ax
2B34:0704 B8 0F 00        	mov	ax,0Fh
2B34:0707 50              	push	ax
2B34:0708 B8 02 00        	mov	ax,2h
2B34:070B 50              	push	ax
2B34:070C 8B C6           	mov	ax,si
2B34:070E BA 96 00        	mov	dx,96h
2B34:0711 F7 E2           	mul	dx
2B34:0713 8B D8           	mov	bx,ax
2B34:0715 81 C3 81 8B     	add	bx,8B81h
2B34:0719 1E              	push	ds
2B34:071A 07              	pop	es
2B34:071B 26 8A 87 94 00  	mov	al,es:[bx+94h]
2B34:0720 98              	cbw
2B34:0721 8B D8           	mov	bx,ax
2B34:0723 D1 E3           	shl	bx,1h
2B34:0725 D1 E3           	shl	bx,1h
2B34:0727 FF B7 6C 40     	push	word ptr [bx+406Ch]
2B34:072B FF B7 6A 40     	push	word ptr [bx+406Ah]
2B34:072F 9A DB 0F 34 2B  	call	far 2B34h:0FDBh
2B34:0734 83 C4 0A        	add	sp,0Ah

l2B34_0737:
2B34:0737 9A 33 0C 1F 1A  	call	far 1A1Fh:0C33h
2B34:073C 33 C0           	xor	ax,ax
2B34:073E 50              	push	ax
2B34:073F FF 36 38 62     	push	word ptr [6238h]
2B34:0743 A1 32 62        	mov	ax,[6232h]
2B34:0746 03 46 F8        	add	ax,[bp-8h]
2B34:0749 40              	inc	ax
2B34:074A 40              	inc	ax
2B34:074B 50              	push	ax
2B34:074C FF 36 30 62     	push	word ptr [6230h]
2B34:0750 1E              	push	ds
2B34:0751 B8 EB 40        	mov	ax,40EBh
2B34:0754 50              	push	ax
2B34:0755 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:075A 83 C4 0C        	add	sp,0Ch
2B34:075D 83 7E EA 00     	cmp	word ptr [bp-16h],0h
2B34:0761 74 03           	jz	0766h

l2B34_0763:
2B34:0763 E9 85 00        	jmp	07EBh

l2B34_0766:
2B34:0766 33 C0           	xor	ax,ax
2B34:0768 50              	push	ax
2B34:0769 FF 36 38 62     	push	word ptr [6238h]
2B34:076D A1 32 62        	mov	ax,[6232h]
2B34:0770 05 09 00        	add	ax,9h
2B34:0773 50              	push	ax
2B34:0774 FF 36 30 62     	push	word ptr [6230h]
2B34:0778 1E              	push	ds
2B34:0779 B8 05 41        	mov	ax,4105h
2B34:077C 50              	push	ax
2B34:077D 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0782 83 C4 0C        	add	sp,0Ch
2B34:0785 8B C6           	mov	ax,si
2B34:0787 BA 96 00        	mov	dx,96h
2B34:078A F7 E2           	mul	dx
2B34:078C 8B D8           	mov	bx,ax
2B34:078E 81 C3 81 8B     	add	bx,8B81h
2B34:0792 1E              	push	ds
2B34:0793 07              	pop	es
2B34:0794 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2B34:0799 25 FF 00        	and	ax,0FFh
2B34:079C BB 05 00        	mov	bx,5h
2B34:079F 33 D2           	xor	dx,dx
2B34:07A1 F7 F3           	div	bx
2B34:07A3 89 46 F2        	mov	[bp-0Eh],ax
2B34:07A6 83 7E F2 05     	cmp	word ptr [bp-0Eh],5h
2B34:07AA 7E 05           	jle	07B1h

l2B34_07AC:
2B34:07AC C7 46 F2 05 00  	mov	word ptr [bp-0Eh],5h

l2B34_07B1:
2B34:07B1 80 BC 4A A8 00  	cmp	byte ptr [si+0A84Ah],0h
2B34:07B6 74 05           	jz	07BDh

l2B34_07B8:
2B34:07B8 C7 46 F2 06 00  	mov	word ptr [bp-0Eh],6h

l2B34_07BD:
2B34:07BD 33 C0           	xor	ax,ax
2B34:07BF 50              	push	ax
2B34:07C0 B8 0F 00        	mov	ax,0Fh
2B34:07C3 50              	push	ax
2B34:07C4 A1 32 62        	mov	ax,[6232h]
2B34:07C7 05 09 00        	add	ax,9h
2B34:07CA 50              	push	ax
2B34:07CB A1 30 62        	mov	ax,[6230h]
2B34:07CE 05 05 00        	add	ax,5h
2B34:07D1 50              	push	ax
2B34:07D2 8B 5E F2        	mov	bx,[bp-0Eh]
2B34:07D5 D1 E3           	shl	bx,1h
2B34:07D7 D1 E3           	shl	bx,1h
2B34:07D9 FF B7 13 41     	push	word ptr [bx+4113h]
2B34:07DD FF B7 11 41     	push	word ptr [bx+4111h]
2B34:07E1 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:07E6 83 C4 0C        	add	sp,0Ch
2B34:07E9 EB 2A           	jmp	0815h

l2B34_07EB:
2B34:07EB 56              	push	si
2B34:07EC 9A 43 1E 08 22  	call	far 2208h:1E43h
2B34:07F1 59              	pop	cx
2B34:07F2 0B C0           	or	ax,ax
2B34:07F4 74 1F           	jz	0815h

l2B34_07F6:
2B34:07F6 33 C0           	xor	ax,ax
2B34:07F8 50              	push	ax
2B34:07F9 FF 36 38 62     	push	word ptr [6238h]
2B34:07FD A1 32 62        	mov	ax,[6232h]
2B34:0800 05 08 00        	add	ax,8h
2B34:0803 50              	push	ax
2B34:0804 FF 36 30 62     	push	word ptr [6230h]
2B34:0808 1E              	push	ds
2B34:0809 B8 0C 41        	mov	ax,410Ch
2B34:080C 50              	push	ax
2B34:080D 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0812 83 C4 0C        	add	sp,0Ch

l2B34_0815:
2B34:0815 80 3E C2 99 00  	cmp	byte ptr [99C2h],0h
2B34:081A 75 05           	jnz	0821h

l2B34_081C:
2B34:081C B8 0F 00        	mov	ax,0Fh
2B34:081F EB 03           	jmp	0824h

l2B34_0821:
2B34:0821 B8 0E 00        	mov	ax,0Eh

l2B34_0824:
2B34:0824 89 46 EE        	mov	[bp-12h],ax
2B34:0827 83 7E F0 00     	cmp	word ptr [bp-10h],0h
2B34:082B 75 05           	jnz	0832h

l2B34_082D:
2B34:082D B8 0F 00        	mov	ax,0Fh
2B34:0830 EB 03           	jmp	0835h

l2B34_0832:
2B34:0832 8B 46 EE        	mov	ax,[bp-12h]

l2B34_0835:
2B34:0835 89 46 EE        	mov	[bp-12h],ax
2B34:0838 33 C0           	xor	ax,ax
2B34:083A 50              	push	ax
2B34:083B FF 76 EE        	push	word ptr [bp-12h]
2B34:083E A1 32 62        	mov	ax,[6232h]
2B34:0841 03 46 F8        	add	ax,[bp-8h]
2B34:0844 40              	inc	ax
2B34:0845 40              	inc	ax
2B34:0846 D1 E0           	shl	ax,1h
2B34:0848 D1 E0           	shl	ax,1h
2B34:084A D1 E0           	shl	ax,1h
2B34:084C 50              	push	ax
2B34:084D A1 30 62        	mov	ax,[6230h]
2B34:0850 05 04 00        	add	ax,4h
2B34:0853 D1 E0           	shl	ax,1h
2B34:0855 D1 E0           	shl	ax,1h
2B34:0857 D1 E0           	shl	ax,1h
2B34:0859 50              	push	ax
2B34:085A 8B C6           	mov	ax,si
2B34:085C BA 0C 00        	mov	dx,0Ch
2B34:085F F7 E2           	mul	dx
2B34:0861 8B D8           	mov	bx,ax
2B34:0863 81 C3 F1 AE     	add	bx,0AEF1h
2B34:0867 1E              	push	ds
2B34:0868 07              	pop	es
2B34:0869 26 FF 77 08     	push	word ptr es:[bx+8h]
2B34:086D 0E              	push	cs
2B34:086E E8 B1 FB        	call	0422h
2B34:0871 83 C4 0A        	add	sp,0Ah
2B34:0874 80 3E C3 99 00  	cmp	byte ptr [99C3h],0h
2B34:0879 75 05           	jnz	0880h

l2B34_087B:
2B34:087B B8 0F 00        	mov	ax,0Fh
2B34:087E EB 03           	jmp	0883h

l2B34_0880:
2B34:0880 B8 0E 00        	mov	ax,0Eh

l2B34_0883:
2B34:0883 89 46 EE        	mov	[bp-12h],ax
2B34:0886 83 7E F0 00     	cmp	word ptr [bp-10h],0h
2B34:088A 75 05           	jnz	0891h

l2B34_088C:
2B34:088C B8 0F 00        	mov	ax,0Fh
2B34:088F EB 03           	jmp	0894h

l2B34_0891:
2B34:0891 8B 46 EE        	mov	ax,[bp-12h]

l2B34_0894:
2B34:0894 89 46 EE        	mov	[bp-12h],ax
2B34:0897 33 C0           	xor	ax,ax
2B34:0899 50              	push	ax
2B34:089A FF 76 EE        	push	word ptr [bp-12h]
2B34:089D A1 32 62        	mov	ax,[6232h]
2B34:08A0 03 46 F8        	add	ax,[bp-8h]
2B34:08A3 05 03 00        	add	ax,3h
2B34:08A6 D1 E0           	shl	ax,1h
2B34:08A8 D1 E0           	shl	ax,1h
2B34:08AA D1 E0           	shl	ax,1h
2B34:08AC 50              	push	ax
2B34:08AD A1 30 62        	mov	ax,[6230h]
2B34:08B0 05 04 00        	add	ax,4h
2B34:08B3 D1 E0           	shl	ax,1h
2B34:08B5 D1 E0           	shl	ax,1h
2B34:08B7 D1 E0           	shl	ax,1h
2B34:08B9 50              	push	ax
2B34:08BA 8B C6           	mov	ax,si
2B34:08BC BA 0C 00        	mov	dx,0Ch
2B34:08BF F7 E2           	mul	dx
2B34:08C1 8B D8           	mov	bx,ax
2B34:08C3 81 C3 F1 AE     	add	bx,0AEF1h
2B34:08C7 1E              	push	ds
2B34:08C8 07              	pop	es
2B34:08C9 26 FF 77 06     	push	word ptr es:[bx+6h]
2B34:08CD 0E              	push	cs
2B34:08CE E8 51 FB        	call	0422h
2B34:08D1 83 C4 0A        	add	sp,0Ah
2B34:08D4 80 3E C4 99 00  	cmp	byte ptr [99C4h],0h
2B34:08D9 75 05           	jnz	08E0h

l2B34_08DB:
2B34:08DB B8 0F 00        	mov	ax,0Fh
2B34:08DE EB 03           	jmp	08E3h

l2B34_08E0:
2B34:08E0 B8 0E 00        	mov	ax,0Eh

l2B34_08E3:
2B34:08E3 89 46 EE        	mov	[bp-12h],ax
2B34:08E6 83 7E F0 00     	cmp	word ptr [bp-10h],0h
2B34:08EA 75 05           	jnz	08F1h

l2B34_08EC:
2B34:08EC B8 0F 00        	mov	ax,0Fh
2B34:08EF EB 03           	jmp	08F4h

l2B34_08F1:
2B34:08F1 8B 46 EE        	mov	ax,[bp-12h]

l2B34_08F4:
2B34:08F4 89 46 EE        	mov	[bp-12h],ax
2B34:08F7 33 C0           	xor	ax,ax
2B34:08F9 50              	push	ax
2B34:08FA FF 76 EE        	push	word ptr [bp-12h]
2B34:08FD A1 32 62        	mov	ax,[6232h]
2B34:0900 03 46 F8        	add	ax,[bp-8h]
2B34:0903 05 04 00        	add	ax,4h
2B34:0906 D1 E0           	shl	ax,1h
2B34:0908 D1 E0           	shl	ax,1h
2B34:090A D1 E0           	shl	ax,1h
2B34:090C 50              	push	ax
2B34:090D A1 30 62        	mov	ax,[6230h]
2B34:0910 05 04 00        	add	ax,4h
2B34:0913 D1 E0           	shl	ax,1h
2B34:0915 D1 E0           	shl	ax,1h
2B34:0917 D1 E0           	shl	ax,1h
2B34:0919 50              	push	ax
2B34:091A 8B C6           	mov	ax,si
2B34:091C BA 0C 00        	mov	dx,0Ch
2B34:091F F7 E2           	mul	dx
2B34:0921 8B D8           	mov	bx,ax
2B34:0923 81 C3 F1 AE     	add	bx,0AEF1h
2B34:0927 1E              	push	ds
2B34:0928 07              	pop	es
2B34:0929 26 FF 77 04     	push	word ptr es:[bx+4h]
2B34:092D 0E              	push	cs
2B34:092E E8 F1 FA        	call	0422h
2B34:0931 83 C4 0A        	add	sp,0Ah
2B34:0934 33 C0           	xor	ax,ax
2B34:0936 89 46 E8        	mov	[bp-18h],ax
2B34:0939 89 46 E2        	mov	[bp-1Eh],ax
2B34:093C 89 46 E4        	mov	[bp-1Ch],ax
2B34:093F E9 84 00        	jmp	09C6h

l2B34_0942:
2B34:0942 8B C6           	mov	ax,si
2B34:0944 BA 96 00        	mov	dx,96h
2B34:0947 F7 E2           	mul	dx
2B34:0949 8B D8           	mov	bx,ax
2B34:094B 81 C3 81 8B     	add	bx,8B81h
2B34:094F 1E              	push	ds
2B34:0950 07              	pop	es
2B34:0951 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2B34:0957 74 36           	jz	098Fh

l2B34_0959:
2B34:0959 8B C6           	mov	ax,si
2B34:095B BA 96 00        	mov	dx,96h
2B34:095E F7 E2           	mul	dx
2B34:0960 8B D8           	mov	bx,ax
2B34:0962 81 C3 81 8B     	add	bx,8B81h
2B34:0966 1E              	push	ds
2B34:0967 07              	pop	es
2B34:0968 03 5E E4        	add	bx,[bp-1Ch]
2B34:096B 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2B34:096F 98              	cbw
2B34:0970 01 46 E2        	add	[bp-1Eh],ax
2B34:0973 8B C6           	mov	ax,si
2B34:0975 BA 96 00        	mov	dx,96h
2B34:0978 F7 E2           	mul	dx
2B34:097A 8B D8           	mov	bx,ax
2B34:097C 81 C3 81 8B     	add	bx,8B81h
2B34:0980 1E              	push	ds
2B34:0981 07              	pop	es
2B34:0982 03 5E E4        	add	bx,[bp-1Ch]
2B34:0985 26 8A 47 1F     	mov	al,es:[bx+1Fh]
2B34:0989 98              	cbw
2B34:098A 01 46 E8        	add	[bp-18h],ax
2B34:098D EB 34           	jmp	09C3h

l2B34_098F:
2B34:098F 8B C6           	mov	ax,si
2B34:0991 BA 96 00        	mov	dx,96h
2B34:0994 F7 E2           	mul	dx
2B34:0996 8B D8           	mov	bx,ax
2B34:0998 81 C3 81 8B     	add	bx,8B81h
2B34:099C 1E              	push	ds
2B34:099D 07              	pop	es
2B34:099E 03 5E E4        	add	bx,[bp-1Ch]
2B34:09A1 26 8A 47 04     	mov	al,es:[bx+4h]
2B34:09A5 98              	cbw
2B34:09A6 01 46 E2        	add	[bp-1Eh],ax
2B34:09A9 8B C6           	mov	ax,si
2B34:09AB BA 96 00        	mov	dx,96h
2B34:09AE F7 E2           	mul	dx
2B34:09B0 8B D8           	mov	bx,ax
2B34:09B2 81 C3 81 8B     	add	bx,8B81h
2B34:09B6 1E              	push	ds
2B34:09B7 07              	pop	es
2B34:09B8 03 5E E4        	add	bx,[bp-1Ch]
2B34:09BB 26 8A 47 17     	mov	al,es:[bx+17h]
2B34:09BF 98              	cbw
2B34:09C0 01 46 E8        	add	[bp-18h],ax

l2B34_09C3:
2B34:09C3 FF 46 E4        	inc	word ptr [bp-1Ch]

l2B34_09C6:
2B34:09C6 83 7E E4 0B     	cmp	word ptr [bp-1Ch],0Bh
2B34:09CA 7D 03           	jge	09CFh

l2B34_09CC:
2B34:09CC E9 73 FF        	jmp	0942h

l2B34_09CF:
2B34:09CF 8B 46 E8        	mov	ax,[bp-18h]
2B34:09D2 BB 46 00        	mov	bx,46h
2B34:09D5 99              	cwd
2B34:09D6 F7 FB           	idiv	bx
2B34:09D8 89 46 E4        	mov	[bp-1Ch],ax
2B34:09DB 83 7E E4 03     	cmp	word ptr [bp-1Ch],3h
2B34:09DF 7E 05           	jle	09E6h

l2B34_09E1:
2B34:09E1 C7 46 E4 03 00  	mov	word ptr [bp-1Ch],3h

l2B34_09E6:
2B34:09E6 33 C0           	xor	ax,ax
2B34:09E8 50              	push	ax
2B34:09E9 B8 0F 00        	mov	ax,0Fh
2B34:09EC 50              	push	ax
2B34:09ED A1 32 62        	mov	ax,[6232h]
2B34:09F0 03 46 F8        	add	ax,[bp-8h]
2B34:09F3 05 05 00        	add	ax,5h
2B34:09F6 50              	push	ax
2B34:09F7 A1 30 62        	mov	ax,[6230h]
2B34:09FA 05 04 00        	add	ax,4h
2B34:09FD 50              	push	ax
2B34:09FE 8B 5E E4        	mov	bx,[bp-1Ch]
2B34:0A01 D1 E3           	shl	bx,1h
2B34:0A03 D1 E3           	shl	bx,1h
2B34:0A05 FF B7 43 41     	push	word ptr [bx+4143h]
2B34:0A09 FF B7 41 41     	push	word ptr [bx+4141h]
2B34:0A0D 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0A12 83 C4 0C        	add	sp,0Ch
2B34:0A15 83 7E EA 00     	cmp	word ptr [bp-16h],0h
2B34:0A19 74 16           	jz	0A31h

l2B34_0A1B:
2B34:0A1B 8B 46 E2        	mov	ax,[bp-1Eh]
2B34:0A1E BA 0A 00        	mov	dx,0Ah
2B34:0A21 F7 E2           	mul	dx
2B34:0A23 99              	cwd
2B34:0A24 F7 7E E8        	idiv	word ptr [bp-18h]
2B34:0A27 BA 0A 00        	mov	dx,0Ah
2B34:0A2A F7 E2           	mul	dx
2B34:0A2C 89 46 F4        	mov	[bp-0Ch],ax
2B34:0A2F EB 0F           	jmp	0A40h

l2B34_0A31:
2B34:0A31 8B 46 E2        	mov	ax,[bp-1Eh]
2B34:0A34 BA 64 00        	mov	dx,64h
2B34:0A37 F7 E2           	mul	dx
2B34:0A39 99              	cwd
2B34:0A3A F7 7E E8        	idiv	word ptr [bp-18h]
2B34:0A3D 89 46 F4        	mov	[bp-0Ch],ax

l2B34_0A40:
2B34:0A40 C6 06 7E B6 28  	mov	byte ptr [0B67Eh],28h
2B34:0A45 B8 0A 00        	mov	ax,0Ah
2B34:0A48 50              	push	ax
2B34:0A49 1E              	push	ds
2B34:0A4A B8 7F B6        	mov	ax,0B67Fh
2B34:0A4D 50              	push	ax
2B34:0A4E FF 76 F4        	push	word ptr [bp-0Ch]
2B34:0A51 9A 8D 00 68 39  	call	far 3968h:008Dh
2B34:0A56 83 C4 08        	add	sp,8h
2B34:0A59 1E              	push	ds
2B34:0A5A B8 C2 38        	mov	ax,38C2h
2B34:0A5D 50              	push	ax
2B34:0A5E 1E              	push	ds
2B34:0A5F B8 7E B6        	mov	ax,0B67Eh
2B34:0A62 50              	push	ax
2B34:0A63 9A 01 00 7A 39  	call	far 397Ah:0001h
2B34:0A68 83 C4 08        	add	sp,8h
2B34:0A6B 83 7E EA 00     	cmp	word ptr [bp-16h],0h
2B34:0A6F 74 0B           	jz	0A7Ch

l2B34_0A71:
2B34:0A71 56              	push	si
2B34:0A72 9A 43 1E 08 22  	call	far 2208h:1E43h
2B34:0A77 59              	pop	cx
2B34:0A78 0B C0           	or	ax,ax
2B34:0A7A 74 3E           	jz	0ABAh

l2B34_0A7C:
2B34:0A7C 33 C0           	xor	ax,ax
2B34:0A7E 50              	push	ax
2B34:0A7F B8 0F 00        	mov	ax,0Fh
2B34:0A82 50              	push	ax
2B34:0A83 A1 32 62        	mov	ax,[6232h]
2B34:0A86 03 46 F8        	add	ax,[bp-8h]
2B34:0A89 05 05 00        	add	ax,5h
2B34:0A8C 50              	push	ax
2B34:0A8D 8B 5E E4        	mov	bx,[bp-1Ch]
2B34:0A90 D1 E3           	shl	bx,1h
2B34:0A92 D1 E3           	shl	bx,1h
2B34:0A94 FF B7 43 41     	push	word ptr [bx+4143h]
2B34:0A98 FF B7 41 41     	push	word ptr [bx+4141h]
2B34:0A9C 9A 03 00 7E 39  	call	far 397Eh:0003h
2B34:0AA1 59              	pop	cx
2B34:0AA2 59              	pop	cx
2B34:0AA3 8B 16 30 62     	mov	dx,[6230h]
2B34:0AA7 83 C2 05        	add	dx,5h
2B34:0AAA 03 C2           	add	ax,dx
2B34:0AAC 50              	push	ax
2B34:0AAD 1E              	push	ds
2B34:0AAE B8 7E B6        	mov	ax,0B67Eh
2B34:0AB1 50              	push	ax
2B34:0AB2 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0AB7 83 C4 0C        	add	sp,0Ch

l2B34_0ABA:
2B34:0ABA 83 7E EA 00     	cmp	word ptr [bp-16h],0h
2B34:0ABE 74 3F           	jz	0AFFh

l2B34_0AC0:
2B34:0AC0 56              	push	si
2B34:0AC1 9A 43 1E 08 22  	call	far 2208h:1E43h
2B34:0AC6 59              	pop	cx
2B34:0AC7 0B C0           	or	ax,ax
2B34:0AC9 74 34           	jz	0AFFh

l2B34_0ACB:
2B34:0ACB 33 C0           	xor	ax,ax
2B34:0ACD 50              	push	ax
2B34:0ACE B8 0F 00        	mov	ax,0Fh
2B34:0AD1 50              	push	ax
2B34:0AD2 A1 32 62        	mov	ax,[6232h]
2B34:0AD5 05 08 00        	add	ax,8h
2B34:0AD8 50              	push	ax
2B34:0AD9 A1 30 62        	mov	ax,[6230h]
2B34:0ADC 05 04 00        	add	ax,4h
2B34:0ADF 50              	push	ax
2B34:0AE0 8B 46 F4        	mov	ax,[bp-0Ch]
2B34:0AE3 BB 14 00        	mov	bx,14h
2B34:0AE6 99              	cwd
2B34:0AE7 F7 FB           	idiv	bx
2B34:0AE9 8B D8           	mov	bx,ax
2B34:0AEB D1 E3           	shl	bx,1h
2B34:0AED D1 E3           	shl	bx,1h
2B34:0AEF FF B7 53 41     	push	word ptr [bx+4153h]
2B34:0AF3 FF B7 51 41     	push	word ptr [bx+4151h]
2B34:0AF7 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0AFC 83 C4 0C        	add	sp,0Ch

l2B34_0AFF:
2B34:0AFF C7 46 EE 0F 00  	mov	word ptr [bp-12h],0Fh
2B34:0B04 8B C6           	mov	ax,si
2B34:0B06 BA 96 00        	mov	dx,96h
2B34:0B09 F7 E2           	mul	dx
2B34:0B0B 8B D8           	mov	bx,ax
2B34:0B0D 81 C3 81 8B     	add	bx,8B81h
2B34:0B11 1E              	push	ds
2B34:0B12 07              	pop	es
2B34:0B13 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2B34:0B18 75 05           	jnz	0B1Fh

l2B34_0B1A:
2B34:0B1A C7 46 EE 0E 00  	mov	word ptr [bp-12h],0Eh

l2B34_0B1F:
2B34:0B1F 8B C6           	mov	ax,si
2B34:0B21 BA 96 00        	mov	dx,96h
2B34:0B24 F7 E2           	mul	dx
2B34:0B26 8B D8           	mov	bx,ax
2B34:0B28 81 C3 81 8B     	add	bx,8B81h
2B34:0B2C 1E              	push	ds
2B34:0B2D 07              	pop	es
2B34:0B2E 26 8A 47 02     	mov	al,es:[bx+2h]
2B34:0B32 98              	cbw
2B34:0B33 8B D8           	mov	bx,ax
2B34:0B35 8A 87 97 00     	mov	al,[bx+97h]
2B34:0B39 98              	cbw
2B34:0B3A 89 46 FC        	mov	[bp-4h],ax
2B34:0B3D 33 C0           	xor	ax,ax
2B34:0B3F 50              	push	ax
2B34:0B40 FF 76 EE        	push	word ptr [bp-12h]
2B34:0B43 A1 32 62        	mov	ax,[6232h]
2B34:0B46 03 46 F8        	add	ax,[bp-8h]
2B34:0B49 05 06 00        	add	ax,6h
2B34:0B4C 50              	push	ax
2B34:0B4D A1 30 62        	mov	ax,[6230h]
2B34:0B50 05 04 00        	add	ax,4h
2B34:0B53 50              	push	ax
2B34:0B54 8B 5E FC        	mov	bx,[bp-4h]
2B34:0B57 D1 E3           	shl	bx,1h
2B34:0B59 D1 E3           	shl	bx,1h
2B34:0B5B FF B7 2F 41     	push	word ptr [bx+412Fh]
2B34:0B5F FF B7 2D 41     	push	word ptr [bx+412Dh]
2B34:0B63 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0B68 83 C4 0C        	add	sp,0Ch
2B34:0B6B 8B C6           	mov	ax,si
2B34:0B6D BA 96 00        	mov	dx,96h
2B34:0B70 F7 E2           	mul	dx
2B34:0B72 8B D8           	mov	bx,ax
2B34:0B74 81 C3 81 8B     	add	bx,8B81h
2B34:0B78 1E              	push	ds
2B34:0B79 07              	pop	es
2B34:0B7A 26 80 7F 03 00  	cmp	byte ptr es:[bx+3h],0h
2B34:0B7F 74 3D           	jz	0BBEh

l2B34_0B81:
2B34:0B81 33 C0           	xor	ax,ax
2B34:0B83 50              	push	ax
2B34:0B84 FF 76 EE        	push	word ptr [bp-12h]
2B34:0B87 A1 32 62        	mov	ax,[6232h]
2B34:0B8A 03 46 F8        	add	ax,[bp-8h]
2B34:0B8D 05 06 00        	add	ax,6h
2B34:0B90 50              	push	ax
2B34:0B91 8B 5E FC        	mov	bx,[bp-4h]
2B34:0B94 D1 E3           	shl	bx,1h
2B34:0B96 D1 E3           	shl	bx,1h
2B34:0B98 FF B7 2F 41     	push	word ptr [bx+412Fh]
2B34:0B9C FF B7 2D 41     	push	word ptr [bx+412Dh]
2B34:0BA0 9A 03 00 7E 39  	call	far 397Eh:0003h
2B34:0BA5 59              	pop	cx
2B34:0BA6 59              	pop	cx
2B34:0BA7 8B 16 30 62     	mov	dx,[6230h]
2B34:0BAB 83 C2 04        	add	dx,4h
2B34:0BAE 03 C2           	add	ax,dx
2B34:0BB0 50              	push	ax
2B34:0BB1 1E              	push	ds
2B34:0BB2 B8 1D 46        	mov	ax,461Dh
2B34:0BB5 50              	push	ax
2B34:0BB6 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0BBB 83 C4 0C        	add	sp,0Ch

l2B34_0BBE:
2B34:0BBE 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2B34:0BC2 74 71           	jz	0C35h

l2B34_0BC4:
2B34:0BC4 83 7E EC 00     	cmp	word ptr [bp-14h],0h
2B34:0BC8 74 21           	jz	0BEBh

l2B34_0BCA:
2B34:0BCA 33 C0           	xor	ax,ax
2B34:0BCC 50              	push	ax
2B34:0BCD B8 0F 00        	mov	ax,0Fh
2B34:0BD0 50              	push	ax
2B34:0BD1 A1 32 62        	mov	ax,[6232h]
2B34:0BD4 05 0B 00        	add	ax,0Bh
2B34:0BD7 50              	push	ax
2B34:0BD8 FF 36 30 62     	push	word ptr [6230h]
2B34:0BDC 1E              	push	ds
2B34:0BDD B8 69 42        	mov	ax,4269h
2B34:0BE0 50              	push	ax
2B34:0BE1 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:0BE6 83 C4 0C        	add	sp,0Ch
2B34:0BE9 EB 47           	jmp	0C32h

l2B34_0BEB:
2B34:0BEB 83 7E EA 00     	cmp	word ptr [bp-16h],0h
2B34:0BEF 74 41           	jz	0C32h

l2B34_0BF1:
2B34:0BF1 56              	push	si
2B34:0BF2 9A 43 1E 08 22  	call	far 2208h:1E43h
2B34:0BF7 59              	pop	cx
2B34:0BF8 0B C0           	or	ax,ax
2B34:0BFA 75 36           	jnz	0C32h

l2B34_0BFC:
2B34:0BFC 33 C0           	xor	ax,ax
2B34:0BFE 50              	push	ax
2B34:0BFF B8 0F 00        	mov	ax,0Fh
2B34:0C02 50              	push	ax
2B34:0C03 B8 09 00        	mov	ax,9h
2B34:0C06 50              	push	ax
2B34:0C07 FF 36 93 42     	push	word ptr [4293h]
2B34:0C0B FF 36 91 42     	push	word ptr [4291h]
2B34:0C0F 9A DB 0F 34 2B  	call	far 2B34h:0FDBh
2B34:0C14 83 C4 0A        	add	sp,0Ah
2B34:0C17 33 C0           	xor	ax,ax
2B34:0C19 50              	push	ax
2B34:0C1A B8 0F 00        	mov	ax,0Fh
2B34:0C1D 50              	push	ax
2B34:0C1E B8 0A 00        	mov	ax,0Ah
2B34:0C21 50              	push	ax
2B34:0C22 FF 36 97 42     	push	word ptr [4297h]
2B34:0C26 FF 36 95 42     	push	word ptr [4295h]
2B34:0C2A 9A DB 0F 34 2B  	call	far 2B34h:0FDBh
2B34:0C2F 83 C4 0A        	add	sp,0Ah

l2B34_0C32:
2B34:0C32 E9 EE 00        	jmp	0D23h

l2B34_0C35:
2B34:0C35 C7 06 38 62 0F 00 	mov	word ptr [6238h],0Fh
2B34:0C3B C7 06 3C 62 00 00 	mov	word ptr [623Ch],0h
2B34:0C41 C7 06 3E 62 0A 00 	mov	word ptr [623Eh],0Ah
2B34:0C47 8B C6           	mov	ax,si
2B34:0C49 BA 96 00        	mov	dx,96h
2B34:0C4C F7 E2           	mul	dx
2B34:0C4E 8B D8           	mov	bx,ax
2B34:0C50 81 C3 81 8B     	add	bx,8B81h
2B34:0C54 1E              	push	ds
2B34:0C55 07              	pop	es
2B34:0C56 26 80 BF 8C 00 00 	cmp	byte ptr es:[bx+8Ch],0h
2B34:0C5C 74 16           	jz	0C74h

l2B34_0C5E:
2B34:0C5E 8B 5E FE        	mov	bx,[bp-2h]
2B34:0C61 D1 E3           	shl	bx,1h
2B34:0C63 D1 E3           	shl	bx,1h
2B34:0C65 FF B7 F2 45     	push	word ptr [bx+45F2h]
2B34:0C69 FF B7 F0 45     	push	word ptr [bx+45F0h]
2B34:0C6D 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:0C72 59              	pop	cx
2B34:0C73 59              	pop	cx

l2B34_0C74:
2B34:0C74 8B C6           	mov	ax,si
2B34:0C76 BA 96 00        	mov	dx,96h
2B34:0C79 F7 E2           	mul	dx
2B34:0C7B 8B D8           	mov	bx,ax
2B34:0C7D 81 C3 81 8B     	add	bx,8B81h
2B34:0C81 1E              	push	ds
2B34:0C82 07              	pop	es
2B34:0C83 26 80 BF 8D 00 00 	cmp	byte ptr es:[bx+8Dh],0h
2B34:0C89 74 0C           	jz	0C97h

l2B34_0C8B:
2B34:0C8B 1E              	push	ds
2B34:0C8C B8 F8 45        	mov	ax,45F8h
2B34:0C8F 50              	push	ax
2B34:0C90 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:0C95 59              	pop	cx
2B34:0C96 59              	pop	cx

l2B34_0C97:
2B34:0C97 8B C6           	mov	ax,si
2B34:0C99 BA 96 00        	mov	dx,96h
2B34:0C9C F7 E2           	mul	dx
2B34:0C9E 8B D8           	mov	bx,ax
2B34:0CA0 81 C3 81 8B     	add	bx,8B81h
2B34:0CA4 1E              	push	ds
2B34:0CA5 07              	pop	es
2B34:0CA6 26 80 BF 8E 00 00 	cmp	byte ptr es:[bx+8Eh],0h
2B34:0CAC 74 0C           	jz	0CBAh

l2B34_0CAE:
2B34:0CAE 1E              	push	ds
2B34:0CAF B8 FD 45        	mov	ax,45FDh
2B34:0CB2 50              	push	ax
2B34:0CB3 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:0CB8 59              	pop	cx
2B34:0CB9 59              	pop	cx

l2B34_0CBA:
2B34:0CBA 8B C6           	mov	ax,si
2B34:0CBC BA 96 00        	mov	dx,96h
2B34:0CBF F7 E2           	mul	dx
2B34:0CC1 8B D8           	mov	bx,ax
2B34:0CC3 81 C3 81 8B     	add	bx,8B81h
2B34:0CC7 1E              	push	ds
2B34:0CC8 07              	pop	es
2B34:0CC9 26 80 BF 8F 00 00 	cmp	byte ptr es:[bx+8Fh],0h
2B34:0CCF 74 0C           	jz	0CDDh

l2B34_0CD1:
2B34:0CD1 1E              	push	ds
2B34:0CD2 B8 08 46        	mov	ax,4608h
2B34:0CD5 50              	push	ax
2B34:0CD6 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:0CDB 59              	pop	cx
2B34:0CDC 59              	pop	cx

l2B34_0CDD:
2B34:0CDD 8B C6           	mov	ax,si
2B34:0CDF BA 96 00        	mov	dx,96h
2B34:0CE2 F7 E2           	mul	dx
2B34:0CE4 8B D8           	mov	bx,ax
2B34:0CE6 81 C3 81 8B     	add	bx,8B81h
2B34:0CEA 1E              	push	ds
2B34:0CEB 07              	pop	es
2B34:0CEC 26 80 BF 90 00 00 	cmp	byte ptr es:[bx+90h],0h
2B34:0CF2 74 0C           	jz	0D00h

l2B34_0CF4:
2B34:0CF4 1E              	push	ds
2B34:0CF5 B8 12 46        	mov	ax,4612h
2B34:0CF8 50              	push	ax
2B34:0CF9 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:0CFE 59              	pop	cx
2B34:0CFF 59              	pop	cx

l2B34_0D00:
2B34:0D00 8B C6           	mov	ax,si
2B34:0D02 BA 96 00        	mov	dx,96h
2B34:0D05 F7 E2           	mul	dx
2B34:0D07 8B D8           	mov	bx,ax
2B34:0D09 81 C3 81 8B     	add	bx,8B81h
2B34:0D0D 1E              	push	ds
2B34:0D0E 07              	pop	es
2B34:0D0F 26 80 BF 91 00 00 	cmp	byte ptr es:[bx+91h],0h
2B34:0D15 74 0C           	jz	0D23h

l2B34_0D17:
2B34:0D17 1E              	push	ds
2B34:0D18 B8 28 46        	mov	ax,4628h
2B34:0D1B 50              	push	ax
2B34:0D1C 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:0D21 59              	pop	cx
2B34:0D22 59              	pop	cx

l2B34_0D23:
2B34:0D23 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2B34:0D27 75 03           	jnz	0D2Ch

l2B34_0D29:
2B34:0D29 E9 88 02        	jmp	0FB4h

l2B34_0D2C:
2B34:0D2C 83 7E EA 00     	cmp	word ptr [bp-16h],0h
2B34:0D30 75 03           	jnz	0D35h

l2B34_0D32:
2B34:0D32 E9 7F 02        	jmp	0FB4h

l2B34_0D35:
2B34:0D35 56              	push	si
2B34:0D36 9A 43 1E 08 22  	call	far 2208h:1E43h
2B34:0D3B 59              	pop	cx
2B34:0D3C 0B C0           	or	ax,ax
2B34:0D3E 75 03           	jnz	0D43h

l2B34_0D40:
2B34:0D40 E9 71 02        	jmp	0FB4h

l2B34_0D43:
2B34:0D43 C7 06 3C 62 00 00 	mov	word ptr [623Ch],0h
2B34:0D49 C7 06 3E 62 0A 00 	mov	word ptr [623Eh],0Ah
2B34:0D4F BF 06 00        	mov	di,6h
2B34:0D52 83 7E F4 64     	cmp	word ptr [bp-0Ch],64h
2B34:0D56 75 03           	jnz	0D5Bh

l2B34_0D58:
2B34:0D58 E9 E4 01        	jmp	0F3Fh

l2B34_0D5B:
2B34:0D5B BF 07 00        	mov	di,7h
2B34:0D5E 8B C6           	mov	ax,si
2B34:0D60 BA 96 00        	mov	dx,96h
2B34:0D63 F7 E2           	mul	dx
2B34:0D65 8B D8           	mov	bx,ax
2B34:0D67 81 C3 81 8B     	add	bx,8B81h
2B34:0D6B 1E              	push	ds
2B34:0D6C 07              	pop	es
2B34:0D6D 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2B34:0D72 75 06           	jnz	0D7Ah

l2B34_0D74:
2B34:0D74 BF 0B 00        	mov	di,0Bh
2B34:0D77 E9 6C 00        	jmp	0DE6h

l2B34_0D7A:
2B34:0D7A 80 3E C2 99 00  	cmp	byte ptr [99C2h],0h
2B34:0D7F 74 1D           	jz	0D9Eh

l2B34_0D81:
2B34:0D81 33 FF           	xor	di,di
2B34:0D83 8B C6           	mov	ax,si
2B34:0D85 BA 0C 00        	mov	dx,0Ch
2B34:0D88 F7 E2           	mul	dx
2B34:0D8A 8B D8           	mov	bx,ax
2B34:0D8C 81 C3 F1 AE     	add	bx,0AEF1h
2B34:0D90 1E              	push	ds
2B34:0D91 07              	pop	es
2B34:0D92 26 83 7F 08 00  	cmp	word ptr es:[bx+8h],0h
2B34:0D97 75 03           	jnz	0D9Ch

l2B34_0D99:
2B34:0D99 BF 01 00        	mov	di,1h

l2B34_0D9C:
2B34:0D9C EB 48           	jmp	0DE6h

l2B34_0D9E:
2B34:0D9E 80 3E C3 99 00  	cmp	byte ptr [99C3h],0h
2B34:0DA3 74 1E           	jz	0DC3h

l2B34_0DA5:
2B34:0DA5 BF 02 00        	mov	di,2h
2B34:0DA8 8B C6           	mov	ax,si
2B34:0DAA BA 0C 00        	mov	dx,0Ch
2B34:0DAD F7 E2           	mul	dx
2B34:0DAF 8B D8           	mov	bx,ax
2B34:0DB1 81 C3 F1 AE     	add	bx,0AEF1h
2B34:0DB5 1E              	push	ds
2B34:0DB6 07              	pop	es
2B34:0DB7 26 83 7F 06 00  	cmp	word ptr es:[bx+6h],0h
2B34:0DBC 75 03           	jnz	0DC1h

l2B34_0DBE:
2B34:0DBE BF 03 00        	mov	di,3h

l2B34_0DC1:
2B34:0DC1 EB 23           	jmp	0DE6h

l2B34_0DC3:
2B34:0DC3 80 3E C4 99 00  	cmp	byte ptr [99C4h],0h
2B34:0DC8 74 1C           	jz	0DE6h

l2B34_0DCA:
2B34:0DCA BF 04 00        	mov	di,4h
2B34:0DCD 8B C6           	mov	ax,si
2B34:0DCF BA 0C 00        	mov	dx,0Ch
2B34:0DD2 F7 E2           	mul	dx
2B34:0DD4 8B D8           	mov	bx,ax
2B34:0DD6 81 C3 F1 AE     	add	bx,0AEF1h
2B34:0DDA 1E              	push	ds
2B34:0DDB 07              	pop	es
2B34:0DDC 26 83 7F 04 00  	cmp	word ptr es:[bx+4h],0h
2B34:0DE1 75 03           	jnz	0DE6h

l2B34_0DE3:
2B34:0DE3 BF 05 00        	mov	di,5h

l2B34_0DE6:
2B34:0DE6 83 FF 07        	cmp	di,7h
2B34:0DE9 75 1A           	jnz	0E05h

l2B34_0DEB:
2B34:0DEB 8B C6           	mov	ax,si
2B34:0DED BA 96 00        	mov	dx,96h
2B34:0DF0 F7 E2           	mul	dx
2B34:0DF2 8B D8           	mov	bx,ax
2B34:0DF4 81 C3 81 8B     	add	bx,8B81h
2B34:0DF8 1E              	push	ds
2B34:0DF9 07              	pop	es
2B34:0DFA 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2B34:0E00 75 03           	jnz	0E05h

l2B34_0E02:
2B34:0E02 BF 0D 00        	mov	di,0Dh

l2B34_0E05:
2B34:0E05 83 FF 07        	cmp	di,7h
2B34:0E08 74 03           	jz	0E0Dh

l2B34_0E0A:
2B34:0E0A E9 32 01        	jmp	0F3Fh

l2B34_0E0D:
2B34:0E0D 8B C6           	mov	ax,si
2B34:0E0F BA 96 00        	mov	dx,96h
2B34:0E12 F7 E2           	mul	dx
2B34:0E14 8B D8           	mov	bx,ax
2B34:0E16 81 C3 81 8B     	add	bx,8B81h
2B34:0E1A 1E              	push	ds
2B34:0E1B 07              	pop	es
2B34:0E1C 26 8A 47 12     	mov	al,es:[bx+12h]
2B34:0E20 98              	cbw
2B34:0E21 50              	push	ax
2B34:0E22 8B C6           	mov	ax,si
2B34:0E24 BA 96 00        	mov	dx,96h
2B34:0E27 F7 E2           	mul	dx
2B34:0E29 8B D8           	mov	bx,ax
2B34:0E2B 81 C3 81 8B     	add	bx,8B81h
2B34:0E2F 1E              	push	ds
2B34:0E30 07              	pop	es
2B34:0E31 26 8A 47 13     	mov	al,es:[bx+13h]
2B34:0E35 98              	cbw
2B34:0E36 5A              	pop	dx
2B34:0E37 03 D0           	add	dx,ax
2B34:0E39 89 56 E4        	mov	[bp-1Ch],dx
2B34:0E3C 8B C6           	mov	ax,si
2B34:0E3E BA 96 00        	mov	dx,96h
2B34:0E41 F7 E2           	mul	dx
2B34:0E43 8B D8           	mov	bx,ax
2B34:0E45 81 C3 81 8B     	add	bx,8B81h
2B34:0E49 1E              	push	ds
2B34:0E4A 07              	pop	es
2B34:0E4B 26 8A 47 25     	mov	al,es:[bx+25h]
2B34:0E4F 98              	cbw
2B34:0E50 50              	push	ax
2B34:0E51 8B C6           	mov	ax,si
2B34:0E53 BA 96 00        	mov	dx,96h
2B34:0E56 F7 E2           	mul	dx
2B34:0E58 8B D8           	mov	bx,ax
2B34:0E5A 81 C3 81 8B     	add	bx,8B81h
2B34:0E5E 1E              	push	ds
2B34:0E5F 07              	pop	es
2B34:0E60 26 8A 47 26     	mov	al,es:[bx+26h]
2B34:0E64 98              	cbw
2B34:0E65 5A              	pop	dx
2B34:0E66 03 D0           	add	dx,ax
2B34:0E68 89 56 E6        	mov	[bp-1Ah],dx
2B34:0E6B 8B 46 E4        	mov	ax,[bp-1Ch]
2B34:0E6E 3B 46 E6        	cmp	ax,[bp-1Ah]
2B34:0E71 74 10           	jz	0E83h

l2B34_0E73:
2B34:0E73 BF 08 00        	mov	di,8h
2B34:0E76 8B 46 E4        	mov	ax,[bp-1Ch]
2B34:0E79 D1 E0           	shl	ax,1h
2B34:0E7B 3B 46 E6        	cmp	ax,[bp-1Ah]
2B34:0E7E 7D 03           	jge	0E83h

l2B34_0E80:
2B34:0E80 BF 09 00        	mov	di,9h

l2B34_0E83:
2B34:0E83 83 FF 07        	cmp	di,7h
2B34:0E86 74 03           	jz	0E8Bh

l2B34_0E88:
2B34:0E88 E9 B4 00        	jmp	0F3Fh

l2B34_0E8B:
2B34:0E8B 80 BC 4A A8 00  	cmp	byte ptr [si+0A84Ah],0h
2B34:0E90 74 06           	jz	0E98h

l2B34_0E92:
2B34:0E92 BF 0E 00        	mov	di,0Eh
2B34:0E95 E9 A7 00        	jmp	0F3Fh

l2B34_0E98:
2B34:0E98 8B C6           	mov	ax,si
2B34:0E9A BA 96 00        	mov	dx,96h
2B34:0E9D F7 E2           	mul	dx
2B34:0E9F 8B D8           	mov	bx,ax
2B34:0EA1 81 C3 81 8B     	add	bx,8B81h
2B34:0EA5 1E              	push	ds
2B34:0EA6 07              	pop	es
2B34:0EA7 26 80 7F 05 00  	cmp	byte ptr es:[bx+5h],0h
2B34:0EAC 74 16           	jz	0EC4h

l2B34_0EAE:
2B34:0EAE 8B C6           	mov	ax,si
2B34:0EB0 BA 96 00        	mov	dx,96h
2B34:0EB3 F7 E2           	mul	dx
2B34:0EB5 8B D8           	mov	bx,ax
2B34:0EB7 81 C3 81 8B     	add	bx,8B81h
2B34:0EBB 1E              	push	ds
2B34:0EBC 07              	pop	es
2B34:0EBD 26 80 7F 09 00  	cmp	byte ptr es:[bx+9h],0h
2B34:0EC2 75 1C           	jnz	0EE0h

l2B34_0EC4:
2B34:0EC4 8B C6           	mov	ax,si
2B34:0EC6 BA 96 00        	mov	dx,96h
2B34:0EC9 F7 E2           	mul	dx
2B34:0ECB 8B D8           	mov	bx,ax
2B34:0ECD 81 C3 81 8B     	add	bx,8B81h
2B34:0ED1 1E              	push	ds
2B34:0ED2 07              	pop	es
2B34:0ED3 26 80 BF 95 00 00 	cmp	byte ptr es:[bx+95h],0h
2B34:0ED9 75 05           	jnz	0EE0h

l2B34_0EDB:
2B34:0EDB BF 0A 00        	mov	di,0Ah
2B34:0EDE EB 5F           	jmp	0F3Fh

l2B34_0EE0:
2B34:0EE0 C7 46 E6 00 00  	mov	word ptr [bp-1Ah],0h
2B34:0EE5 C7 46 E4 00 00  	mov	word ptr [bp-1Ch],0h
2B34:0EEA EB 43           	jmp	0F2Fh

l2B34_0EEC:
2B34:0EEC 8B C6           	mov	ax,si
2B34:0EEE BA 96 00        	mov	dx,96h
2B34:0EF1 F7 E2           	mul	dx
2B34:0EF3 8B D8           	mov	bx,ax
2B34:0EF5 81 C3 81 8B     	add	bx,8B81h
2B34:0EF9 1E              	push	ds
2B34:0EFA 07              	pop	es
2B34:0EFB 03 5E E4        	add	bx,[bp-1Ch]
2B34:0EFE 26 80 7F 2A 00  	cmp	byte ptr es:[bx+2Ah],0h
2B34:0F03 74 27           	jz	0F2Ch

l2B34_0F05:
2B34:0F05 81 4E E6 80 00  	or	word ptr [bp-1Ah],80h
2B34:0F0A 8B C6           	mov	ax,si
2B34:0F0C BA 96 00        	mov	dx,96h
2B34:0F0F F7 E2           	mul	dx
2B34:0F11 8B D8           	mov	bx,ax
2B34:0F13 81 C3 81 8B     	add	bx,8B81h
2B34:0F17 1E              	push	ds
2B34:0F18 07              	pop	es
2B34:0F19 8B 46 E4        	mov	ax,[bp-1Ch]
2B34:0F1C D1 E0           	shl	ax,1h
2B34:0F1E 03 D8           	add	bx,ax
2B34:0F20 26 83 7F 38 00  	cmp	word ptr es:[bx+38h],0h
2B34:0F25 74 05           	jz	0F2Ch

l2B34_0F27:
2B34:0F27 81 4E E6 01 00  	or	word ptr [bp-1Ah],1h

l2B34_0F2C:
2B34:0F2C FF 46 E4        	inc	word ptr [bp-1Ch]

l2B34_0F2F:
2B34:0F2F 83 7E E4 0E     	cmp	word ptr [bp-1Ch],0Eh
2B34:0F33 7C B7           	jl	0EECh

l2B34_0F35:
2B34:0F35 81 7E E6 80 00  	cmp	word ptr [bp-1Ah],80h
2B34:0F3A 75 03           	jnz	0F3Fh

l2B34_0F3C:
2B34:0F3C BF 0C 00        	mov	di,0Ch

l2B34_0F3F:
2B34:0F3F 83 FF 0E        	cmp	di,0Eh
2B34:0F42 7E 03           	jle	0F47h

l2B34_0F44:
2B34:0F44 E9 6D 00        	jmp	0FB4h

l2B34_0F47:
2B34:0F47 0B FF           	or	di,di
2B34:0F49 7C 69           	jl	0FB4h

l2B34_0F4B:
2B34:0F4B 83 FF 08        	cmp	di,8h
2B34:0F4E 74 0A           	jz	0F5Ah

l2B34_0F50:
2B34:0F50 83 FF 09        	cmp	di,9h
2B34:0F53 74 05           	jz	0F5Ah

l2B34_0F55:
2B34:0F55 83 FF 0B        	cmp	di,0Bh
2B34:0F58 75 2F           	jnz	0F89h

l2B34_0F5A:
2B34:0F5A 8B C6           	mov	ax,si
2B34:0F5C BA 96 00        	mov	dx,96h
2B34:0F5F F7 E2           	mul	dx
2B34:0F61 8B D8           	mov	bx,ax
2B34:0F63 81 C3 81 8B     	add	bx,8B81h
2B34:0F67 1E              	push	ds
2B34:0F68 07              	pop	es
2B34:0F69 26 80 BF 95 00 00 	cmp	byte ptr es:[bx+95h],0h
2B34:0F6F 74 18           	jz	0F89h

l2B34_0F71:
2B34:0F71 83 FF 0B        	cmp	di,0Bh
2B34:0F74 75 03           	jnz	0F79h

l2B34_0F76:
2B34:0F76 BF 11 00        	mov	di,11h

l2B34_0F79:
2B34:0F79 83 FF 08        	cmp	di,8h
2B34:0F7C 75 03           	jnz	0F81h

l2B34_0F7E:
2B34:0F7E BF 0F 00        	mov	di,0Fh

l2B34_0F81:
2B34:0F81 83 FF 09        	cmp	di,9h
2B34:0F84 75 03           	jnz	0F89h

l2B34_0F86:
2B34:0F86 BF 10 00        	mov	di,10h

l2B34_0F89:
2B34:0F89 B8 15 00        	mov	ax,15h
2B34:0F8C 50              	push	ax
2B34:0F8D 9A 09 00 38 33  	call	far 3338h:0009h
2B34:0F92 59              	pop	cx
2B34:0F93 C7 06 3E 62 00 00 	mov	word ptr [623Eh],0h
2B34:0F99 C7 06 3C 62 02 00 	mov	word ptr [623Ch],2h
2B34:0F9F 8B DF           	mov	bx,di
2B34:0FA1 D1 E3           	shl	bx,1h
2B34:0FA3 D1 E3           	shl	bx,1h
2B34:0FA5 FF B7 47 47     	push	word ptr [bx+4747h]
2B34:0FA9 FF B7 45 47     	push	word ptr [bx+4745h]
2B34:0FAD 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2B34:0FB2 59              	pop	cx
2B34:0FB3 59              	pop	cx

l2B34_0FB4:
2B34:0FB4 33 C0           	xor	ax,ax
2B34:0FB6 50              	push	ax
2B34:0FB7 B8 01 00        	mov	ax,1h
2B34:0FBA 50              	push	ax
2B34:0FBB 56              	push	si
2B34:0FBC 1E              	push	ds
2B34:0FBD 8B C6           	mov	ax,si
2B34:0FBF BA 96 00        	mov	dx,96h
2B34:0FC2 F7 E2           	mul	dx
2B34:0FC4 05 81 8B        	add	ax,8B81h
2B34:0FC7 50              	push	ax
2B34:0FC8 9A 05 00 1B 2D  	call	far 2D1Bh:0005h
2B34:0FCD 83 C4 0A        	add	sp,0Ah
2B34:0FD0 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2B34:0FD5 5F              	pop	di
2B34:0FD6 5E              	pop	si
2B34:0FD7 8B E5           	mov	sp,bp
2B34:0FD9 5D              	pop	bp
2B34:0FDA CB              	retf

;; DrawCenteredTextInActiveWindow_0FDB: 2B34:0FDB
;;   Called from:
;;     2208:00F9 (in RunTacticalUnitCommandMenu_000B)
;;     2208:0115 (in RunTacticalUnitCommandMenu_000B)
;;     2208:1502 (in RunTacticalGameOptionsMenu_148A)
;;     2B34:05FB (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0613 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0666 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:06F9 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:072F (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0C0F (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0C2A (in DrawTacticalUnitControlPanel_04C2)
DrawCenteredTextInActiveWindow_0FDB proc
2B34:0FDB 55              	push	bp
2B34:0FDC 8B EC           	mov	bp,sp
2B34:0FDE FF 76 0E        	push	word ptr [bp+0Eh]
2B34:0FE1 FF 76 0C        	push	word ptr [bp+0Ch]
2B34:0FE4 A1 32 62        	mov	ax,[6232h]
2B34:0FE7 03 46 0A        	add	ax,[bp+0Ah]
2B34:0FEA 50              	push	ax
2B34:0FEB FF 76 08        	push	word ptr [bp+8h]
2B34:0FEE FF 76 06        	push	word ptr [bp+6h]
2B34:0FF1 9A 03 00 7E 39  	call	far 397Eh:0003h
2B34:0FF6 59              	pop	cx
2B34:0FF7 59              	pop	cx
2B34:0FF8 8B 16 34 62     	mov	dx,[6234h]
2B34:0FFC 2B D0           	sub	dx,ax
2B34:0FFE D1 EA           	shr	dx,1h
2B34:1000 03 16 30 62     	add	dx,[6230h]
2B34:1004 52              	push	dx
2B34:1005 FF 76 08        	push	word ptr [bp+8h]
2B34:1008 FF 76 06        	push	word ptr [bp+6h]
2B34:100B 9A EE 01 07 20  	call	far 2007h:01EEh
2B34:1010 8B E5           	mov	sp,bp
2B34:1012 5D              	pop	bp
2B34:1013 CB              	retf

;; PrepareDisplayedUnitCombatRatings_1014: 2B34:1014
;;   Called from:
;;     2B34:057E (in DrawTacticalUnitControlPanel_04C2)
PrepareDisplayedUnitCombatRatings_1014 proc
2B34:1014 55              	push	bp
2B34:1015 8B EC           	mov	bp,sp
2B34:1017 83 EC 04        	sub	sp,4h
2B34:101A 56              	push	si
2B34:101B 57              	push	di
2B34:101C 8B 76 06        	mov	si,[bp+6h]
2B34:101F C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2B34:1024 83 FE 0C        	cmp	si,0Ch
2B34:1027 7D 07           	jge	1030h

l2B34_1029:
2B34:1029 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2B34:102E EB 48           	jmp	1078h

l2B34_1030:
2B34:1030 33 FF           	xor	di,di
2B34:1032 EB 3F           	jmp	1073h

l2B34_1034:
2B34:1034 8B C7           	mov	ax,di
2B34:1036 BA 96 00        	mov	dx,96h
2B34:1039 F7 E2           	mul	dx
2B34:103B 8B D8           	mov	bx,ax
2B34:103D 81 C3 81 8B     	add	bx,8B81h
2B34:1041 1E              	push	ds
2B34:1042 07              	pop	es
2B34:1043 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2B34:1047 74 29           	jz	1072h

l2B34_1049:
2B34:1049 8B C7           	mov	ax,di
2B34:104B BA 96 00        	mov	dx,96h
2B34:104E F7 E2           	mul	dx
2B34:1050 8B D8           	mov	bx,ax
2B34:1052 81 C3 81 8B     	add	bx,8B81h
2B34:1056 1E              	push	ds
2B34:1057 07              	pop	es
2B34:1058 26 80 BF 8D 00 00 	cmp	byte ptr es:[bx+8Dh],0h
2B34:105E 74 12           	jz	1072h

l2B34_1060:
2B34:1060 56              	push	si
2B34:1061 57              	push	di
2B34:1062 9A A6 1D 1B 2D  	call	far 2D1Bh:1DA6h
2B34:1067 59              	pop	cx
2B34:1068 59              	pop	cx
2B34:1069 0B C0           	or	ax,ax
2B34:106B 74 05           	jz	1072h

l2B34_106D:
2B34:106D C7 46 FE 00 00  	mov	word ptr [bp-2h],0h

l2B34_1072:
2B34:1072 47              	inc	di

l2B34_1073:
2B34:1073 83 FF 0C        	cmp	di,0Ch
2B34:1076 7C BC           	jl	1034h

l2B34_1078:
2B34:1078 56              	push	si
2B34:1079 9A 29 18 08 22  	call	far 2208h:1829h
2B34:107E 59              	pop	cx
2B34:107F 89 46 FC        	mov	[bp-4h],ax
2B34:1082 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2B34:1086 74 31           	jz	10B9h

l2B34_1088:
2B34:1088 83 7E FC 00     	cmp	word ptr [bp-4h],0h
2B34:108C 74 0D           	jz	109Bh

l2B34_108E:
2B34:108E 33 C0           	xor	ax,ax
2B34:1090 50              	push	ax
2B34:1091 56              	push	si
2B34:1092 9A F4 10 34 2B  	call	far 2B34h:10F4h
2B34:1097 59              	pop	cx
2B34:1098 59              	pop	cx
2B34:1099 EB 1C           	jmp	10B7h

l2B34_109B:
2B34:109B 56              	push	si
2B34:109C 9A D2 11 34 2B  	call	far 2B34h:11D2h
2B34:10A1 59              	pop	cx
2B34:10A2 33 C0           	xor	ax,ax
2B34:10A4 50              	push	ax
2B34:10A5 B8 01 00        	mov	ax,1h
2B34:10A8 50              	push	ax
2B34:10A9 56              	push	si
2B34:10AA 1E              	push	ds
2B34:10AB B8 C7 84        	mov	ax,84C7h
2B34:10AE 50              	push	ax
2B34:10AF 9A 05 00 1B 2D  	call	far 2D1Bh:0005h
2B34:10B4 83 C4 0A        	add	sp,0Ah

l2B34_10B7:
2B34:10B7 EB 30           	jmp	10E9h

l2B34_10B9:
2B34:10B9 83 7E FC 00     	cmp	word ptr [bp-4h],0h
2B34:10BD 74 0E           	jz	10CDh

l2B34_10BF:
2B34:10BF B8 01 00        	mov	ax,1h
2B34:10C2 50              	push	ax
2B34:10C3 56              	push	si
2B34:10C4 9A F4 10 34 2B  	call	far 2B34h:10F4h
2B34:10C9 59              	pop	cx
2B34:10CA 59              	pop	cx
2B34:10CB EB 1C           	jmp	10E9h

l2B34_10CD:
2B34:10CD 33 C0           	xor	ax,ax
2B34:10CF 50              	push	ax
2B34:10D0 B8 01 00        	mov	ax,1h
2B34:10D3 50              	push	ax
2B34:10D4 56              	push	si
2B34:10D5 1E              	push	ds
2B34:10D6 8B C6           	mov	ax,si
2B34:10D8 BA 96 00        	mov	dx,96h
2B34:10DB F7 E2           	mul	dx
2B34:10DD 05 81 8B        	add	ax,8B81h
2B34:10E0 50              	push	ax
2B34:10E1 9A 05 00 1B 2D  	call	far 2D1Bh:0005h
2B34:10E6 83 C4 0A        	add	sp,0Ah

l2B34_10E9:
2B34:10E9 8B 46 FE        	mov	ax,[bp-2h]
2B34:10EC EB 00           	jmp	10EEh

l2B34_10EE:
2B34:10EE 5F              	pop	di
2B34:10EF 5E              	pop	si
2B34:10F0 8B E5           	mov	sp,bp
2B34:10F2 5D              	pop	bp
2B34:10F3 CB              	retf

;; CalculateLanceAverageCombatRatings_10F4: 2B34:10F4
;;   Called from:
;;     2B34:1092 (in PrepareDisplayedUnitCombatRatings_1014)
;;     2B34:10C4 (in PrepareDisplayedUnitCombatRatings_1014)
CalculateLanceAverageCombatRatings_10F4 proc
2B34:10F4 55              	push	bp
2B34:10F5 8B EC           	mov	bp,sp
2B34:10F7 83 EC 02        	sub	sp,2h
2B34:10FA 56              	push	si
2B34:10FB 57              	push	di
2B34:10FC C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2B34:1101 33 F6           	xor	si,si
2B34:1103 EB 0B           	jmp	1110h

l2B34_1105:
2B34:1105 8B DE           	mov	bx,si
2B34:1107 D1 E3           	shl	bx,1h
2B34:1109 C7 87 11 B0 00 00 	mov	word ptr [bx+0B011h],0h
2B34:110F 46              	inc	si

l2B34_1110:
2B34:1110 83 FE 06        	cmp	si,6h
2B34:1113 7C F0           	jl	1105h

l2B34_1115:
2B34:1115 8B 7E 06        	mov	di,[bp+6h]
2B34:1118 E9 83 00        	jmp	119Eh

l2B34_111B:
2B34:111B 8B C7           	mov	ax,di
2B34:111D BA 96 00        	mov	dx,96h
2B34:1120 F7 E2           	mul	dx
2B34:1122 8B D8           	mov	bx,ax
2B34:1124 81 C3 81 8B     	add	bx,8B81h
2B34:1128 1E              	push	ds
2B34:1129 07              	pop	es
2B34:112A 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2B34:112E 74 6D           	jz	119Dh

l2B34_1130:
2B34:1130 83 7E 08 00     	cmp	word ptr [bp+8h],0h
2B34:1134 74 1E           	jz	1154h

l2B34_1136:
2B34:1136 33 C0           	xor	ax,ax
2B34:1138 50              	push	ax
2B34:1139 B8 01 00        	mov	ax,1h
2B34:113C 50              	push	ax
2B34:113D 57              	push	di
2B34:113E 1E              	push	ds
2B34:113F 8B C7           	mov	ax,di
2B34:1141 BA 96 00        	mov	dx,96h
2B34:1144 F7 E2           	mul	dx
2B34:1146 05 81 8B        	add	ax,8B81h
2B34:1149 50              	push	ax
2B34:114A 9A 05 00 1B 2D  	call	far 2D1Bh:0005h
2B34:114F 83 C4 0A        	add	sp,0Ah
2B34:1152 EB 1C           	jmp	1170h

l2B34_1154:
2B34:1154 57              	push	di
2B34:1155 9A D2 11 34 2B  	call	far 2B34h:11D2h
2B34:115A 59              	pop	cx
2B34:115B 33 C0           	xor	ax,ax
2B34:115D 50              	push	ax
2B34:115E B8 01 00        	mov	ax,1h
2B34:1161 50              	push	ax
2B34:1162 57              	push	di
2B34:1163 1E              	push	ds
2B34:1164 B8 C7 84        	mov	ax,84C7h
2B34:1167 50              	push	ax
2B34:1168 9A 05 00 1B 2D  	call	far 2D1Bh:0005h
2B34:116D 83 C4 0A        	add	sp,0Ah

l2B34_1170:
2B34:1170 33 F6           	xor	si,si
2B34:1172 EB 21           	jmp	1195h

l2B34_1174:
2B34:1174 8B C7           	mov	ax,di
2B34:1176 BA 0C 00        	mov	dx,0Ch
2B34:1179 F7 E2           	mul	dx
2B34:117B 8B D8           	mov	bx,ax
2B34:117D 81 C3 F1 AE     	add	bx,0AEF1h
2B34:1181 1E              	push	ds
2B34:1182 07              	pop	es
2B34:1183 8B C6           	mov	ax,si
2B34:1185 D1 E0           	shl	ax,1h
2B34:1187 03 D8           	add	bx,ax
2B34:1189 26 8B 07        	mov	ax,es:[bx]
2B34:118C 8B DE           	mov	bx,si
2B34:118E D1 E3           	shl	bx,1h
2B34:1190 01 87 11 B0     	add	[bx+0B011h],ax
2B34:1194 46              	inc	si

l2B34_1195:
2B34:1195 83 FE 06        	cmp	si,6h
2B34:1198 7C DA           	jl	1174h

l2B34_119A:
2B34:119A FF 46 FE        	inc	word ptr [bp-2h]

l2B34_119D:
2B34:119D 47              	inc	di

l2B34_119E:
2B34:119E 8B 46 06        	mov	ax,[bp+6h]
2B34:11A1 05 04 00        	add	ax,4h
2B34:11A4 25 FC 00        	and	ax,0FCh
2B34:11A7 3B C7           	cmp	ax,di
2B34:11A9 7E 03           	jle	11AEh

l2B34_11AB:
2B34:11AB E9 6D FF        	jmp	111Bh

l2B34_11AE:
2B34:11AE 33 F6           	xor	si,si
2B34:11B0 EB 15           	jmp	11C7h

l2B34_11B2:
2B34:11B2 8B DE           	mov	bx,si
2B34:11B4 D1 E3           	shl	bx,1h
2B34:11B6 8B 87 11 B0     	mov	ax,[bx+0B011h]
2B34:11BA 99              	cwd
2B34:11BB F7 7E FE        	idiv	word ptr [bp-2h]
2B34:11BE 8B DE           	mov	bx,si
2B34:11C0 D1 E3           	shl	bx,1h
2B34:11C2 89 87 11 B0     	mov	[bx+0B011h],ax
2B34:11C6 46              	inc	si

l2B34_11C7:
2B34:11C7 83 FE 06        	cmp	si,6h
2B34:11CA 7C E6           	jl	11B2h

l2B34_11CC:
2B34:11CC 5F              	pop	di
2B34:11CD 5E              	pop	si
2B34:11CE 8B E5           	mov	sp,bp
2B34:11D0 5D              	pop	bp
2B34:11D1 CB              	retf

;; BuildUndamagedUnitCombatEstimate_11D2: 2B34:11D2
;;   Called from:
;;     2B34:109C (in PrepareDisplayedUnitCombatRatings_1014)
;;     2B34:1155 (in CalculateLanceAverageCombatRatings_10F4)
BuildUndamagedUnitCombatEstimate_11D2 proc
2B34:11D2 55              	push	bp
2B34:11D3 8B EC           	mov	bp,sp
2B34:11D5 56              	push	si
2B34:11D6 57              	push	di
2B34:11D7 8B 7E 06        	mov	di,[bp+6h]
2B34:11DA 33 F6           	xor	si,si
2B34:11DC E9 09 01        	jmp	12E8h

l2B34_11DF:
2B34:11DF 83 FE 0B        	cmp	si,0Bh
2B34:11E2 7D 19           	jge	11FDh

l2B34_11E4:
2B34:11E4 8B C7           	mov	ax,di
2B34:11E6 BA 96 00        	mov	dx,96h
2B34:11E9 F7 E2           	mul	dx
2B34:11EB 8B D8           	mov	bx,ax
2B34:11ED 81 C3 81 8B     	add	bx,8B81h
2B34:11F1 1E              	push	ds
2B34:11F2 07              	pop	es
2B34:11F3 03 DE           	add	bx,si
2B34:11F5 26 8A 47 1F     	mov	al,es:[bx+1Fh]
2B34:11F9 88 84 D3 84     	mov	[si+84D3h],al

l2B34_11FD:
2B34:11FD 8B C7           	mov	ax,di
2B34:11FF BA 96 00        	mov	dx,96h
2B34:1202 F7 E2           	mul	dx
2B34:1204 8B D8           	mov	bx,ax
2B34:1206 81 C3 81 8B     	add	bx,8B81h
2B34:120A 1E              	push	ds
2B34:120B 07              	pop	es
2B34:120C 03 DE           	add	bx,si
2B34:120E 26 8A 47 2A     	mov	al,es:[bx+2Ah]
2B34:1212 98              	cbw
2B34:1213 8B DE           	mov	bx,si
2B34:1215 D1 E3           	shl	bx,1h
2B34:1217 89 87 FF 84     	mov	[bx+84FFh],ax
2B34:121B 8B C7           	mov	ax,di
2B34:121D BA 96 00        	mov	dx,96h
2B34:1220 F7 E2           	mul	dx
2B34:1222 8B D8           	mov	bx,ax
2B34:1224 81 C3 81 8B     	add	bx,8B81h
2B34:1228 1E              	push	ds
2B34:1229 07              	pop	es
2B34:122A 03 DE           	add	bx,si
2B34:122C 26 8A 47 5E     	mov	al,es:[bx+5Eh]
2B34:1230 24 7F           	and	al,7Fh
2B34:1232 88 84 25 85     	mov	[si+8525h],al
2B34:1236 8B C7           	mov	ax,di
2B34:1238 BA 96 00        	mov	dx,96h
2B34:123B F7 E2           	mul	dx
2B34:123D 8B D8           	mov	bx,ax
2B34:123F 81 C3 81 8B     	add	bx,8B81h
2B34:1243 1E              	push	ds
2B34:1244 07              	pop	es
2B34:1245 03 DE           	add	bx,si
2B34:1247 26 8A 47 6C     	mov	al,es:[bx+6Ch]
2B34:124B 24 7F           	and	al,7Fh
2B34:124D 88 84 33 85     	mov	[si+8533h],al
2B34:1251 83 FE 08        	cmp	si,8h
2B34:1254 7C 03           	jl	1259h

l2B34_1256:
2B34:1256 E9 8E 00        	jmp	12E7h

l2B34_1259:
2B34:1259 8B C7           	mov	ax,di
2B34:125B BA 96 00        	mov	dx,96h
2B34:125E F7 E2           	mul	dx
2B34:1260 8B D8           	mov	bx,ax
2B34:1262 81 C3 81 8B     	add	bx,8B81h
2B34:1266 1E              	push	ds
2B34:1267 07              	pop	es
2B34:1268 03 DE           	add	bx,si
2B34:126A 26 8A 47 56     	mov	al,es:[bx+56h]
2B34:126E 24 7F           	and	al,7Fh
2B34:1270 88 84 1D 85     	mov	[si+851Dh],al
2B34:1274 8B C7           	mov	ax,di
2B34:1276 BA 96 00        	mov	dx,96h
2B34:1279 F7 E2           	mul	dx
2B34:127B 8B D8           	mov	bx,ax
2B34:127D 81 C3 81 8B     	add	bx,8B81h
2B34:1281 1E              	push	ds
2B34:1282 07              	pop	es
2B34:1283 03 DE           	add	bx,si
2B34:1285 26 8A 47 78     	mov	al,es:[bx+78h]
2B34:1289 24 7F           	and	al,7Fh
2B34:128B 88 84 3F 85     	mov	[si+853Fh],al
2B34:128F 83 FE 02        	cmp	si,2h
2B34:1292 7D 53           	jge	12E7h

l2B34_1294:
2B34:1294 8B C7           	mov	ax,di
2B34:1296 BA 96 00        	mov	dx,96h
2B34:1299 F7 E2           	mul	dx
2B34:129B 8B D8           	mov	bx,ax
2B34:129D 81 C3 81 8B     	add	bx,8B81h
2B34:12A1 1E              	push	ds
2B34:12A2 07              	pop	es
2B34:12A3 03 DE           	add	bx,si
2B34:12A5 26 8A 47 6A     	mov	al,es:[bx+6Ah]
2B34:12A9 24 7F           	and	al,7Fh
2B34:12AB 88 84 31 85     	mov	[si+8531h],al
2B34:12AF 8B C7           	mov	ax,di
2B34:12B1 BA 96 00        	mov	dx,96h
2B34:12B4 F7 E2           	mul	dx
2B34:12B6 8B D8           	mov	bx,ax
2B34:12B8 81 C3 81 8B     	add	bx,8B81h
2B34:12BC 1E              	push	ds
2B34:12BD 07              	pop	es
2B34:12BE 03 DE           	add	bx,si
2B34:12C0 26 8A 87 80 00  	mov	al,es:[bx+80h]
2B34:12C5 24 7F           	and	al,7Fh
2B34:12C7 88 84 47 85     	mov	[si+8547h],al
2B34:12CB 8B C7           	mov	ax,di
2B34:12CD BA 96 00        	mov	dx,96h
2B34:12D0 F7 E2           	mul	dx
2B34:12D2 8B D8           	mov	bx,ax
2B34:12D4 81 C3 81 8B     	add	bx,8B81h
2B34:12D8 1E              	push	ds
2B34:12D9 07              	pop	es
2B34:12DA 03 DE           	add	bx,si
2B34:12DC 26 8A 87 82 00  	mov	al,es:[bx+82h]
2B34:12E1 24 7F           	and	al,7Fh
2B34:12E3 88 84 49 85     	mov	[si+8549h],al

l2B34_12E7:
2B34:12E7 46              	inc	si

l2B34_12E8:
2B34:12E8 83 FE 0C        	cmp	si,0Ch
2B34:12EB 7D 03           	jge	12F0h

l2B34_12ED:
2B34:12ED E9 EF FE        	jmp	11DFh

l2B34_12F0:
2B34:12F0 8B C7           	mov	ax,di
2B34:12F2 BA 96 00        	mov	dx,96h
2B34:12F5 F7 E2           	mul	dx
2B34:12F7 8B D8           	mov	bx,ax
2B34:12F9 81 C3 81 8B     	add	bx,8B81h
2B34:12FD 1E              	push	ds
2B34:12FE 07              	pop	es
2B34:12FF 26 8A 47 55     	mov	al,es:[bx+55h]
2B34:1303 24 7F           	and	al,7Fh
2B34:1305 A2 1C 85        	mov	[851Ch],al
2B34:1308 5F              	pop	di
2B34:1309 5E              	pop	si
2B34:130A 5D              	pop	bp
2B34:130B CB              	retf

;; BuildDamagedWeaponRangeFlags_130C: 2B34:130C
;;   Called from:
;;     2B34:0588 (in DrawTacticalUnitControlPanel_04C2)
BuildDamagedWeaponRangeFlags_130C proc
2B34:130C 55              	push	bp
2B34:130D 8B EC           	mov	bp,sp
2B34:130F 56              	push	si
2B34:1310 57              	push	di
2B34:1311 8B 76 06        	mov	si,[bp+6h]
2B34:1314 33 FF           	xor	di,di
2B34:1316 EB 06           	jmp	131Eh

l2B34_1318:
2B34:1318 C6 85 C2 99 00  	mov	byte ptr [di+99C2h],0h
2B34:131D 47              	inc	di

l2B34_131E:
2B34:131E 83 FF 03        	cmp	di,3h
2B34:1321 7C F5           	jl	1318h

l2B34_1323:
2B34:1323 B8 08 00        	mov	ax,8h
2B34:1326 50              	push	ax
2B34:1327 8B C6           	mov	ax,si
2B34:1329 BA 96 00        	mov	dx,96h
2B34:132C F7 E2           	mul	dx
2B34:132E 05 81 8B        	add	ax,8B81h
2B34:1331 8C DA           	mov	dx,ds
2B34:1333 05 56 00        	add	ax,56h
2B34:1336 52              	push	dx
2B34:1337 50              	push	ax
2B34:1338 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:133D 83 C4 06        	add	sp,6h
2B34:1340 B8 08 00        	mov	ax,8h
2B34:1343 50              	push	ax
2B34:1344 8B C6           	mov	ax,si
2B34:1346 BA 96 00        	mov	dx,96h
2B34:1349 F7 E2           	mul	dx
2B34:134B 05 81 8B        	add	ax,8B81h
2B34:134E 8C DA           	mov	dx,ds
2B34:1350 05 78 00        	add	ax,78h
2B34:1353 52              	push	dx
2B34:1354 50              	push	ax
2B34:1355 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:135A 83 C4 06        	add	sp,6h
2B34:135D B8 0C 00        	mov	ax,0Ch
2B34:1360 50              	push	ax
2B34:1361 8B C6           	mov	ax,si
2B34:1363 BA 96 00        	mov	dx,96h
2B34:1366 F7 E2           	mul	dx
2B34:1368 05 81 8B        	add	ax,8B81h
2B34:136B 8C DA           	mov	dx,ds
2B34:136D 05 5E 00        	add	ax,5Eh
2B34:1370 52              	push	dx
2B34:1371 50              	push	ax
2B34:1372 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:1377 83 C4 06        	add	sp,6h
2B34:137A B8 0C 00        	mov	ax,0Ch
2B34:137D 50              	push	ax
2B34:137E 8B C6           	mov	ax,si
2B34:1380 BA 96 00        	mov	dx,96h
2B34:1383 F7 E2           	mul	dx
2B34:1385 05 81 8B        	add	ax,8B81h
2B34:1388 8C DA           	mov	dx,ds
2B34:138A 05 6C 00        	add	ax,6Ch
2B34:138D 52              	push	dx
2B34:138E 50              	push	ax
2B34:138F 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:1394 83 C4 06        	add	sp,6h
2B34:1397 B8 02 00        	mov	ax,2h
2B34:139A 50              	push	ax
2B34:139B 8B C6           	mov	ax,si
2B34:139D BA 96 00        	mov	dx,96h
2B34:13A0 F7 E2           	mul	dx
2B34:13A2 05 81 8B        	add	ax,8B81h
2B34:13A5 8C DA           	mov	dx,ds
2B34:13A7 05 6A 00        	add	ax,6Ah
2B34:13AA 52              	push	dx
2B34:13AB 50              	push	ax
2B34:13AC 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:13B1 83 C4 06        	add	sp,6h
2B34:13B4 B8 02 00        	mov	ax,2h
2B34:13B7 50              	push	ax
2B34:13B8 8B C6           	mov	ax,si
2B34:13BA BA 96 00        	mov	dx,96h
2B34:13BD F7 E2           	mul	dx
2B34:13BF 05 81 8B        	add	ax,8B81h
2B34:13C2 8C DA           	mov	dx,ds
2B34:13C4 05 80 00        	add	ax,80h
2B34:13C7 52              	push	dx
2B34:13C8 50              	push	ax
2B34:13C9 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:13CE 83 C4 06        	add	sp,6h
2B34:13D1 B8 02 00        	mov	ax,2h
2B34:13D4 50              	push	ax
2B34:13D5 8B C6           	mov	ax,si
2B34:13D7 BA 96 00        	mov	dx,96h
2B34:13DA F7 E2           	mul	dx
2B34:13DC 05 81 8B        	add	ax,8B81h
2B34:13DF 8C DA           	mov	dx,ds
2B34:13E1 05 82 00        	add	ax,82h
2B34:13E4 52              	push	dx
2B34:13E5 50              	push	ax
2B34:13E6 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:13EB 83 C4 06        	add	sp,6h
2B34:13EE B8 01 00        	mov	ax,1h
2B34:13F1 50              	push	ax
2B34:13F2 8B C6           	mov	ax,si
2B34:13F4 BA 96 00        	mov	dx,96h
2B34:13F7 F7 E2           	mul	dx
2B34:13F9 05 81 8B        	add	ax,8B81h
2B34:13FC 8C DA           	mov	dx,ds
2B34:13FE 05 55 00        	add	ax,55h
2B34:1401 52              	push	dx
2B34:1402 50              	push	ax
2B34:1403 9A 0F 14 34 2B  	call	far 2B34h:140Fh
2B34:1408 83 C4 06        	add	sp,6h
2B34:140B 5F              	pop	di
2B34:140C 5E              	pop	si
2B34:140D 5D              	pop	bp
2B34:140E CB              	retf

;; FlagDamagedWeaponRanges_140F: 2B34:140F
;;   Called from:
;;     2B34:1338 (in BuildDamagedWeaponRangeFlags_130C)
;;     2B34:1355 (in BuildDamagedWeaponRangeFlags_130C)
;;     2B34:1372 (in BuildDamagedWeaponRangeFlags_130C)
;;     2B34:138F (in BuildDamagedWeaponRangeFlags_130C)
;;     2B34:13AC (in BuildDamagedWeaponRangeFlags_130C)
;;     2B34:13C9 (in BuildDamagedWeaponRangeFlags_130C)
;;     2B34:13E6 (in BuildDamagedWeaponRangeFlags_130C)
;;     2B34:1403 (in BuildDamagedWeaponRangeFlags_130C)
FlagDamagedWeaponRanges_140F proc
2B34:140F 55              	push	bp
2B34:1410 8B EC           	mov	bp,sp
2B34:1412 56              	push	si
2B34:1413 57              	push	di
2B34:1414 33 FF           	xor	di,di
2B34:1416 E9 9A 00        	jmp	14B3h

l2B34_1419:
2B34:1419 C4 5E 06        	les	bx,[bp+6h]
2B34:141C 26 F6 01 80     	test	byte ptr es:[bx+di],80h
2B34:1420 75 03           	jnz	1425h

l2B34_1422:
2B34:1422 E9 8D 00        	jmp	14B2h

l2B34_1425:
2B34:1425 C4 5E 06        	les	bx,[bp+6h]
2B34:1428 26 8A 01        	mov	al,es:[bx+di]
2B34:142B 98              	cbw
2B34:142C 25 7F 00        	and	ax,7Fh
2B34:142F 48              	dec	ax
2B34:1430 3D 16 00        	cmp	ax,16h
2B34:1433 77 6E           	ja	14A3h

l2B34_1435:
2B34:1435 8B D8           	mov	bx,ax
2B34:1437 D1 E3           	shl	bx,1h
2B34:1439 2E FF A7 3E 14  	jmp	word ptr cs:[bx+143Eh]
l2B34_143E	dw	0x1495
l2B34_1440	dw	0x1495
l2B34_1442	dw	0x1495
l2B34_1444	dw	0x148C
l2B34_1446	dw	0x1474
l2B34_1448	dw	0x1487
l2B34_144A	dw	0x1483
l2B34_144C	dw	0x146C
l2B34_144E	dw	0x1483
l2B34_1450	dw	0x1491
l2B34_1452	dw	0x1470
l2B34_1454	dw	0x1479
l2B34_1456	dw	0x1483
l2B34_1458	dw	0x1483
l2B34_145A	dw	0x147E
l2B34_145C	dw	0x1495
l2B34_145E	dw	0x149A
l2B34_1460	dw	0x149A
l2B34_1462	dw	0x149A
l2B34_1464	dw	0x149A
l2B34_1466	dw	0x149E
l2B34_1468	dw	0x149E
l2B34_146A	dw	0x149E

l2B34_146C:
2B34:146C 33 F6           	xor	si,si
2B34:146E EB 38           	jmp	14A8h

l2B34_1470:
2B34:1470 33 F6           	xor	si,si
2B34:1472 EB 34           	jmp	14A8h

l2B34_1474:
2B34:1474 BE 01 00        	mov	si,1h
2B34:1477 EB 2F           	jmp	14A8h

l2B34_1479:
2B34:1479 BE 01 00        	mov	si,1h
2B34:147C EB 2A           	jmp	14A8h

l2B34_147E:
2B34:147E BE 02 00        	mov	si,2h
2B34:1481 EB 25           	jmp	14A8h

l2B34_1483:
2B34:1483 33 F6           	xor	si,si
2B34:1485 EB 21           	jmp	14A8h

l2B34_1487:
2B34:1487 BE 01 00        	mov	si,1h
2B34:148A EB 1C           	jmp	14A8h

l2B34_148C:
2B34:148C BE 02 00        	mov	si,2h
2B34:148F EB 17           	jmp	14A8h

l2B34_1491:
2B34:1491 33 F6           	xor	si,si
2B34:1493 EB 13           	jmp	14A8h

l2B34_1495:
2B34:1495 BE 02 00        	mov	si,2h
2B34:1498 EB 0E           	jmp	14A8h

l2B34_149A:
2B34:149A 33 F6           	xor	si,si
2B34:149C EB 0A           	jmp	14A8h

l2B34_149E:
2B34:149E BE 02 00        	mov	si,2h
2B34:14A1 EB 05           	jmp	14A8h

l2B34_14A3:
2B34:14A3 BE FF FF        	mov	si,0FFFFh
2B34:14A6 EB 00           	jmp	14A8h

l2B34_14A8:
2B34:14A8 83 FE FF        	cmp	si,0FFh
2B34:14AB 74 05           	jz	14B2h

l2B34_14AD:
2B34:14AD C6 84 C2 99 01  	mov	byte ptr [si+99C2h],1h
