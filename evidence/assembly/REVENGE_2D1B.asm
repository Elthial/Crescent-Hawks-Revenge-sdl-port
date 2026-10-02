;;; Segment 2D1B (2D1B:0000)
2D1B:0000 00                                              .               

l2C7F_09C1:
2C7F:09C1 5F              	pop	di
2C7F:09C2 5E              	pop	si
2C7F:09C3 5D              	pop	bp
2C7F:09C4 CB              	retf

;; RecalculateUnitCombatRatings_0005: 2D1B:0005
;;   Called from:
;;     2208:257B (in InitializeScenarioUnitFromTemplate_2472)
;;     2208:2729 (in CompareLanceCombatRatings_26B1)
;;     2208:2794 (in CompareLanceCombatRatings_26B1)
;;     2507:4AA4 (in DrawUnitStatusScreen_483A)
;;     2B34:0FC8 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:10AF (in PrepareDisplayedUnitCombatRatings_1014)
;;     2B34:10E1 (in PrepareDisplayedUnitCombatRatings_1014)
;;     2B34:114A (in CalculateLanceAverageCombatRatings_10F4)
;;     2B34:1168 (in CalculateLanceAverageCombatRatings_10F4)
;;     2D1B:08E3 (in RefreshAllUnitCombatState_08AF)
;;     2D1B:2320 (in ApplyWeaponDamage_1E2B)
RecalculateUnitCombatRatings_0005 proc
2D1B:0005 55              	push	bp
2D1B:0006 8B EC           	mov	bp,sp
2D1B:0008 83 EC 06        	sub	sp,6h
2D1B:000B 56              	push	si
2D1B:000C 57              	push	di
2D1B:000D 8B 76 0A        	mov	si,[bp+0Ah]
2D1B:0010 83 7E 0C 00     	cmp	word ptr [bp+0Ch],0h
2D1B:0014 74 4A           	jz	0060h

l2D1B_0016:
2D1B:0016 FF 76 08        	push	word ptr [bp+8h]
2D1B:0019 FF 76 06        	push	word ptr [bp+6h]
2D1B:001C 9A 69 04 34 2B  	call	far 2B34h:0469h
2D1B:0021 59              	pop	cx
2D1B:0022 59              	pop	cx
2D1B:0023 33 FF           	xor	di,di
2D1B:0025 EB 1D           	jmp	0044h

l2D1B_0027:
2D1B:0027 8B DF           	mov	bx,di
2D1B:0029 D1 E3           	shl	bx,1h
2D1B:002B 8A 87 BF 88     	mov	al,[bx+88BFh]
2D1B:002F 50              	push	ax
2D1B:0030 8B C6           	mov	ax,si
2D1B:0032 BA 17 00        	mov	dx,17h
2D1B:0035 F7 E2           	mul	dx
2D1B:0037 8B D8           	mov	bx,ax
2D1B:0039 81 C3 4F B0     	add	bx,0B04Fh
2D1B:003D 1E              	push	ds
2D1B:003E 07              	pop	es
2D1B:003F 58              	pop	ax
2D1B:0040 26 88 01        	mov	es:[bx+di],al
2D1B:0043 47              	inc	di

l2D1B_0044:
2D1B:0044 83 FF 17        	cmp	di,17h
2D1B:0047 7C DE           	jl	0027h

l2D1B_0049:
2D1B:0049 33 C0           	xor	ax,ax
2D1B:004B 50              	push	ax
2D1B:004C FF 76 08        	push	word ptr [bp+8h]
2D1B:004F FF 76 06        	push	word ptr [bp+6h]
2D1B:0052 9A 07 00 34 2B  	call	far 2B34h:0007h
2D1B:0057 83 C4 06        	add	sp,6h
2D1B:005A 88 84 2C B0     	mov	[si+0B02Ch],al
2D1B:005E EB 25           	jmp	0085h

l2D1B_0060:
2D1B:0060 33 FF           	xor	di,di
2D1B:0062 EB 1C           	jmp	0080h

l2D1B_0064:
2D1B:0064 8B C6           	mov	ax,si
2D1B:0066 BA 17 00        	mov	dx,17h
2D1B:0069 F7 E2           	mul	dx
2D1B:006B 8B D8           	mov	bx,ax
2D1B:006D 81 C3 4F B0     	add	bx,0B04Fh
2D1B:0071 1E              	push	ds
2D1B:0072 07              	pop	es
2D1B:0073 26 8A 01        	mov	al,es:[bx+di]
2D1B:0076 98              	cbw
2D1B:0077 8B DF           	mov	bx,di
2D1B:0079 D1 E3           	shl	bx,1h
2D1B:007B 89 87 BF 88     	mov	[bx+88BFh],ax
2D1B:007F 47              	inc	di

l2D1B_0080:
2D1B:0080 83 FF 17        	cmp	di,17h
2D1B:0083 7C DF           	jl	0064h

l2D1B_0085:
2D1B:0085 8B DE           	mov	bx,si
2D1B:0087 D1 E3           	shl	bx,1h
2D1B:0089 D1 E3           	shl	bx,1h
2D1B:008B C7 87 73 A9 00 00 	mov	word ptr [bx+0A973h],0h
2D1B:0091 C7 87 71 A9 00 00 	mov	word ptr [bx+0A971h],0h
2D1B:0097 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2D1B:009C C7 46 FC 01 00  	mov	word ptr [bp-4h],1h
2D1B:00A1 33 FF           	xor	di,di
2D1B:00A3 E9 10 01        	jmp	01B6h

l2D1B_00A6:
2D1B:00A6 C7 46 FA 01 00  	mov	word ptr [bp-6h],1h
2D1B:00AB 83 7E 0E 00     	cmp	word ptr [bp+0Eh],0h
2D1B:00AF 74 5E           	jz	010Fh

l2D1B_00B1:
2D1B:00B1 8B DF           	mov	bx,di
2D1B:00B3 D1 E3           	shl	bx,1h
2D1B:00B5 8A 87 BF 88     	mov	al,[bx+88BFh]
2D1B:00B9 50              	push	ax
2D1B:00BA 8B C6           	mov	ax,si
2D1B:00BC BA 17 00        	mov	dx,17h
2D1B:00BF F7 E2           	mul	dx
2D1B:00C1 8B D8           	mov	bx,ax
2D1B:00C3 81 C3 29 89     	add	bx,8929h
2D1B:00C7 1E              	push	ds
2D1B:00C8 07              	pop	es
2D1B:00C9 58              	pop	ax
2D1B:00CA 26 28 01        	sub	es:[bx+di],al
2D1B:00CD 8B C6           	mov	ax,si
2D1B:00CF BA 17 00        	mov	dx,17h
2D1B:00D2 F7 E2           	mul	dx
2D1B:00D4 8B D8           	mov	bx,ax
2D1B:00D6 81 C3 29 89     	add	bx,8929h
2D1B:00DA 1E              	push	ds
2D1B:00DB 07              	pop	es
2D1B:00DC 26 80 39 00     	cmp	byte ptr es:[bx+di],0h
2D1B:00E0 7D 13           	jge	00F5h

l2D1B_00E2:
2D1B:00E2 8B C6           	mov	ax,si
2D1B:00E4 BA 17 00        	mov	dx,17h
2D1B:00E7 F7 E2           	mul	dx
2D1B:00E9 8B D8           	mov	bx,ax
2D1B:00EB 81 C3 29 89     	add	bx,8929h
2D1B:00EF 1E              	push	ds
2D1B:00F0 07              	pop	es
2D1B:00F1 26 C6 01 00     	mov	byte ptr es:[bx+di],0h

l2D1B_00F5:
2D1B:00F5 8B C6           	mov	ax,si
2D1B:00F7 BA 17 00        	mov	dx,17h
2D1B:00FA F7 E2           	mul	dx
2D1B:00FC 8B D8           	mov	bx,ax
2D1B:00FE 81 C3 29 89     	add	bx,8929h
2D1B:0102 1E              	push	ds
2D1B:0103 07              	pop	es
2D1B:0104 26 80 39 00     	cmp	byte ptr es:[bx+di],0h
2D1B:0108 74 05           	jz	010Fh

l2D1B_010A:
2D1B:010A C7 46 FA 00 00  	mov	word ptr [bp-6h],0h

l2D1B_010F:
2D1B:010F 8B DF           	mov	bx,di
2D1B:0111 D1 E3           	shl	bx,1h
2D1B:0113 83 BF BF 88 00  	cmp	word ptr [bx+88BFh],0h
2D1B:0118 75 03           	jnz	011Dh

l2D1B_011A:
2D1B:011A E9 88 00        	jmp	01A5h

l2D1B_011D:
2D1B:011D 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:0121 75 03           	jnz	0126h

l2D1B_0123:
2D1B:0123 E9 7F 00        	jmp	01A5h

l2D1B_0126:
2D1B:0126 8B C7           	mov	ax,di
2D1B:0128 BA 0F 00        	mov	dx,0Fh
2D1B:012B F7 E2           	mul	dx
2D1B:012D 8B D8           	mov	bx,ax
2D1B:012F 81 C3 35 04     	add	bx,435h
2D1B:0133 1E              	push	ds
2D1B:0134 07              	pop	es
2D1B:0135 26 80 7F 0B 00  	cmp	byte ptr es:[bx+0Bh],0h
2D1B:013A 74 47           	jz	0183h

l2D1B_013C:
2D1B:013C 8B C7           	mov	ax,di
2D1B:013E BA 0F 00        	mov	dx,0Fh
2D1B:0141 F7 E2           	mul	dx
2D1B:0143 8B D8           	mov	bx,ax
2D1B:0145 81 C3 35 04     	add	bx,435h
2D1B:0149 1E              	push	ds
2D1B:014A 07              	pop	es
2D1B:014B 26 8A 47 0B     	mov	al,es:[bx+0Bh]
2D1B:014F 98              	cbw
2D1B:0150 48              	dec	ax
2D1B:0151 D1 E0           	shl	ax,1h
2D1B:0153 C4 5E 06        	les	bx,[bp+6h]
2D1B:0156 03 D8           	add	bx,ax
2D1B:0158 26 83 7F 38 00  	cmp	word ptr es:[bx+38h],0h
2D1B:015D 74 22           	jz	0181h

l2D1B_015F:
2D1B:015F 8B DE           	mov	bx,si
2D1B:0161 D1 E3           	shl	bx,1h
2D1B:0163 D1 E3           	shl	bx,1h
2D1B:0165 8B 97 73 A9     	mov	dx,[bx+0A973h]
2D1B:0169 8B 87 71 A9     	mov	ax,[bx+0A971h]
2D1B:016D 0B 46 FC        	or	ax,[bp-4h]
2D1B:0170 0B 56 FE        	or	dx,[bp-2h]
2D1B:0173 8B DE           	mov	bx,si
2D1B:0175 D1 E3           	shl	bx,1h
2D1B:0177 D1 E3           	shl	bx,1h
2D1B:0179 89 97 73 A9     	mov	[bx+0A973h],dx
2D1B:017D 89 87 71 A9     	mov	[bx+0A971h],ax

l2D1B_0181:
2D1B:0181 EB 22           	jmp	01A5h

l2D1B_0183:
2D1B:0183 8B DE           	mov	bx,si
2D1B:0185 D1 E3           	shl	bx,1h
2D1B:0187 D1 E3           	shl	bx,1h
2D1B:0189 8B 97 73 A9     	mov	dx,[bx+0A973h]
2D1B:018D 8B 87 71 A9     	mov	ax,[bx+0A971h]
2D1B:0191 0B 46 FC        	or	ax,[bp-4h]
2D1B:0194 0B 56 FE        	or	dx,[bp-2h]
2D1B:0197 8B DE           	mov	bx,si
2D1B:0199 D1 E3           	shl	bx,1h
2D1B:019B D1 E3           	shl	bx,1h
2D1B:019D 89 97 73 A9     	mov	[bx+0A973h],dx
2D1B:01A1 89 87 71 A9     	mov	[bx+0A971h],ax

l2D1B_01A5:
2D1B:01A5 8B 56 FE        	mov	dx,[bp-2h]
2D1B:01A8 8B 46 FC        	mov	ax,[bp-4h]
2D1B:01AB D1 E0           	shl	ax,1h
2D1B:01AD D1 D2           	rcl	dx,1h
2D1B:01AF 89 56 FE        	mov	[bp-2h],dx
2D1B:01B2 89 46 FC        	mov	[bp-4h],ax
2D1B:01B5 47              	inc	di

l2D1B_01B6:
2D1B:01B6 83 FF 17        	cmp	di,17h
2D1B:01B9 7D 03           	jge	01BEh

l2D1B_01BB:
2D1B:01BB E9 E8 FE        	jmp	00A6h

l2D1B_01BE:
2D1B:01BE 8B DE           	mov	bx,si
2D1B:01C0 D1 E3           	shl	bx,1h
2D1B:01C2 D1 E3           	shl	bx,1h
2D1B:01C4 8B 97 73 A9     	mov	dx,[bx+0A973h]
2D1B:01C8 8B 87 71 A9     	mov	ax,[bx+0A971h]
2D1B:01CC 89 56 FE        	mov	[bp-2h],dx
2D1B:01CF 89 46 FC        	mov	[bp-4h],ax
2D1B:01D2 C4 5E 06        	les	bx,[bp+6h]
2D1B:01D5 26 8A 47 02     	mov	al,es:[bx+2h]
2D1B:01D9 98              	cbw
2D1B:01DA 50              	push	ax
2D1B:01DB 8B C6           	mov	ax,si
2D1B:01DD BA 0C 00        	mov	dx,0Ch
2D1B:01E0 F7 E2           	mul	dx
2D1B:01E2 8B D8           	mov	bx,ax
2D1B:01E4 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:01E8 1E              	push	ds
2D1B:01E9 07              	pop	es
2D1B:01EA 58              	pop	ax
2D1B:01EB 26 89 07        	mov	es:[bx],ax
2D1B:01EE C4 5E 06        	les	bx,[bp+6h]
2D1B:01F1 26 8A 87 89 00  	mov	al,es:[bx+89h]
2D1B:01F6 98              	cbw
2D1B:01F7 50              	push	ax
2D1B:01F8 8B C6           	mov	ax,si
2D1B:01FA BA 0C 00        	mov	dx,0Ch
2D1B:01FD F7 E2           	mul	dx
2D1B:01FF 8B D8           	mov	bx,ax
2D1B:0201 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0205 1E              	push	ds
2D1B:0206 07              	pop	es
2D1B:0207 58              	pop	ax
2D1B:0208 26 89 47 0A     	mov	es:[bx+0Ah],ax
2D1B:020C FF 76 08        	push	word ptr [bp+8h]
2D1B:020F FF 76 06        	push	word ptr [bp+6h]
2D1B:0212 9A 79 03 1B 2D  	call	far 2D1Bh:0379h
2D1B:0217 59              	pop	cx
2D1B:0218 59              	pop	cx
2D1B:0219 A1 3E 83        	mov	ax,[833Eh]
2D1B:021C B1 04           	mov	cl,4h
2D1B:021E D3 F8           	sar	ax,cl
2D1B:0220 50              	push	ax
2D1B:0221 8B C6           	mov	ax,si
2D1B:0223 BA 0C 00        	mov	dx,0Ch
2D1B:0226 F7 E2           	mul	dx
2D1B:0228 8B D8           	mov	bx,ax
2D1B:022A 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:022E 1E              	push	ds
2D1B:022F 07              	pop	es
2D1B:0230 58              	pop	ax
2D1B:0231 26 89 47 02     	mov	es:[bx+2h],ax
2D1B:0235 A1 3E 83        	mov	ax,[833Eh]
2D1B:0238 D1 E0           	shl	ax,1h
2D1B:023A 3B 06 BB 86     	cmp	ax,[86BBh]
2D1B:023E 7D 05           	jge	0245h

l2D1B_0240:
2D1B:0240 C6 84 96 85 01  	mov	byte ptr [si+8596h],1h

l2D1B_0245:
2D1B:0245 1E              	push	ds
2D1B:0246 B8 BF 88        	mov	ax,88BFh
2D1B:0249 50              	push	ax
2D1B:024A 8B 56 FE        	mov	dx,[bp-2h]
2D1B:024D 8B 46 FC        	mov	ax,[bp-4h]
2D1B:0250 25 03 80        	and	ax,8003h
2D1B:0253 81 E2 00 00     	and	dx,0h
2D1B:0257 52              	push	dx
2D1B:0258 50              	push	ax
2D1B:0259 9A 2C 07 00 08  	call	far 0800h:072Ch
2D1B:025E 83 C4 08        	add	sp,8h
2D1B:0261 50              	push	ax
2D1B:0262 8B C6           	mov	ax,si
2D1B:0264 BA 0C 00        	mov	dx,0Ch
2D1B:0267 F7 E2           	mul	dx
2D1B:0269 8B D8           	mov	bx,ax
2D1B:026B 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:026F 1E              	push	ds
2D1B:0270 07              	pop	es
2D1B:0271 58              	pop	ax
2D1B:0272 26 89 47 04     	mov	es:[bx+4h],ax
2D1B:0276 1E              	push	ds
2D1B:0277 B8 BF 88        	mov	ax,88BFh
2D1B:027A 50              	push	ax
2D1B:027B 8B 56 FE        	mov	dx,[bp-2h]
2D1B:027E 8B 46 FC        	mov	ax,[bp-4h]
2D1B:0281 25 FC 49        	and	ax,49FCh
2D1B:0284 81 E2 70 00     	and	dx,70h
2D1B:0288 52              	push	dx
2D1B:0289 50              	push	ax
2D1B:028A 9A 2C 07 00 08  	call	far 0800h:072Ch
2D1B:028F 83 C4 08        	add	sp,8h
2D1B:0292 50              	push	ax
2D1B:0293 8B C6           	mov	ax,si
2D1B:0295 BA 0C 00        	mov	dx,0Ch
2D1B:0298 F7 E2           	mul	dx
2D1B:029A 8B D8           	mov	bx,ax
2D1B:029C 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:02A0 1E              	push	ds
2D1B:02A1 07              	pop	es
2D1B:02A2 58              	pop	ax
2D1B:02A3 26 01 47 04     	add	es:[bx+4h],ax
2D1B:02A7 1E              	push	ds
2D1B:02A8 B8 BF 88        	mov	ax,88BFh
2D1B:02AB 50              	push	ax
2D1B:02AC 8B 56 FE        	mov	dx,[bp-2h]
2D1B:02AF 8B 46 FC        	mov	ax,[bp-4h]
2D1B:02B2 25 0C 40        	and	ax,400Ch
2D1B:02B5 81 E2 70 00     	and	dx,70h
2D1B:02B9 52              	push	dx
2D1B:02BA 50              	push	ax
2D1B:02BB 9A 2C 07 00 08  	call	far 0800h:072Ch
2D1B:02C0 83 C4 08        	add	sp,8h
2D1B:02C3 D1 FA           	sar	dx,1h
2D1B:02C5 D1 D8           	rcr	ax,1h
2D1B:02C7 50              	push	ax
2D1B:02C8 8B C6           	mov	ax,si
2D1B:02CA BA 0C 00        	mov	dx,0Ch
2D1B:02CD F7 E2           	mul	dx
2D1B:02CF 8B D8           	mov	bx,ax
2D1B:02D1 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:02D5 1E              	push	ds
2D1B:02D6 07              	pop	es
2D1B:02D7 58              	pop	ax
2D1B:02D8 26 89 47 06     	mov	es:[bx+6h],ax
2D1B:02DC 1E              	push	ds
2D1B:02DD B8 BF 88        	mov	ax,88BFh
2D1B:02E0 50              	push	ax
2D1B:02E1 8B 56 FE        	mov	dx,[bp-2h]
2D1B:02E4 8B 46 FC        	mov	ax,[bp-4h]
2D1B:02E7 25 F0 3F        	and	ax,3FF0h
2D1B:02EA 81 E2 0F 00     	and	dx,0Fh
2D1B:02EE 52              	push	dx
2D1B:02EF 50              	push	ax
2D1B:02F0 9A 2C 07 00 08  	call	far 0800h:072Ch
2D1B:02F5 83 C4 08        	add	sp,8h
2D1B:02F8 50              	push	ax
2D1B:02F9 8B C6           	mov	ax,si
2D1B:02FB BA 0C 00        	mov	dx,0Ch
2D1B:02FE F7 E2           	mul	dx
2D1B:0300 8B D8           	mov	bx,ax
2D1B:0302 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0306 1E              	push	ds
2D1B:0307 07              	pop	es
2D1B:0308 58              	pop	ax
2D1B:0309 26 01 47 06     	add	es:[bx+6h],ax
2D1B:030D 1E              	push	ds
2D1B:030E B8 BF 88        	mov	ax,88BFh
2D1B:0311 50              	push	ax
2D1B:0312 8B 56 FE        	mov	dx,[bp-2h]
2D1B:0315 8B 46 FC        	mov	ax,[bp-4h]
2D1B:0318 25 10 08        	and	ax,810h
2D1B:031B 81 E2 00 00     	and	dx,0h
2D1B:031F 52              	push	dx
2D1B:0320 50              	push	ax
2D1B:0321 9A 2C 07 00 08  	call	far 0800h:072Ch
2D1B:0326 83 C4 08        	add	sp,8h
2D1B:0329 D1 FA           	sar	dx,1h
2D1B:032B D1 D8           	rcr	ax,1h
2D1B:032D 50              	push	ax
2D1B:032E 8B C6           	mov	ax,si
2D1B:0330 BA 0C 00        	mov	dx,0Ch
2D1B:0333 F7 E2           	mul	dx
2D1B:0335 8B D8           	mov	bx,ax
2D1B:0337 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:033B 1E              	push	ds
2D1B:033C 07              	pop	es
2D1B:033D 58              	pop	ax
2D1B:033E 26 89 47 08     	mov	es:[bx+8h],ax
2D1B:0342 1E              	push	ds
2D1B:0343 B8 BF 88        	mov	ax,88BFh
2D1B:0346 50              	push	ax
2D1B:0347 8B 56 FE        	mov	dx,[bp-2h]
2D1B:034A 8B 46 FC        	mov	ax,[bp-4h]
2D1B:034D 25 E0 37        	and	ax,37E0h
2D1B:0350 81 E2 0F 00     	and	dx,0Fh
2D1B:0354 52              	push	dx
2D1B:0355 50              	push	ax
2D1B:0356 9A 2C 07 00 08  	call	far 0800h:072Ch
2D1B:035B 83 C4 08        	add	sp,8h
2D1B:035E 50              	push	ax
2D1B:035F 8B C6           	mov	ax,si
2D1B:0361 BA 0C 00        	mov	dx,0Ch
2D1B:0364 F7 E2           	mul	dx
2D1B:0366 8B D8           	mov	bx,ax
2D1B:0368 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:036C 1E              	push	ds
2D1B:036D 07              	pop	es
2D1B:036E 58              	pop	ax
2D1B:036F 26 01 47 08     	add	es:[bx+8h],ax
2D1B:0373 5F              	pop	di
2D1B:0374 5E              	pop	si
2D1B:0375 8B E5           	mov	sp,bp
2D1B:0377 5D              	pop	bp
2D1B:0378 CB              	retf

;; CalculateUnitDurabilityTotals_0379: 2D1B:0379
;;   Called from:
;;     1A1F:2E81 (in ExecuteSceneInstructions_2A4E)
;;     2007:1D71 (in FormatUnitDurabilityPercentage_1D61)
;;     2507:4D64 (in DrawUnitStatusScreen_483A)
;;     2D1B:0212 (in RecalculateUnitCombatRatings_0005)
;;     2D1B:1E8C (in ApplyWeaponDamage_1E2B)
;;     2D1B:237F (in ApplyWeaponDamage_1E2B)
CalculateUnitDurabilityTotals_0379 proc
2D1B:0379 55              	push	bp
2D1B:037A 8B EC           	mov	bp,sp
2D1B:037C 56              	push	si
2D1B:037D 33 C0           	xor	ax,ax
2D1B:037F A3 BB 86        	mov	[86BBh],ax
2D1B:0382 A3 3E 83        	mov	[833Eh],ax
2D1B:0385 C4 5E 06        	les	bx,[bp+6h]
2D1B:0388 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:038C 74 59           	jz	03E7h

l2D1B_038E:
2D1B:038E C4 5E 06        	les	bx,[bp+6h]
2D1B:0391 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2D1B:0397 74 28           	jz	03C1h

l2D1B_0399:
2D1B:0399 33 F6           	xor	si,si
2D1B:039B EB 1D           	jmp	03BAh

l2D1B_039D:
2D1B:039D C4 5E 06        	les	bx,[bp+6h]
2D1B:03A0 03 DE           	add	bx,si
2D1B:03A2 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2D1B:03A6 98              	cbw
2D1B:03A7 01 06 3E 83     	add	[833Eh],ax
2D1B:03AB C4 5E 06        	les	bx,[bp+6h]
2D1B:03AE 03 DE           	add	bx,si
2D1B:03B0 26 8A 47 1F     	mov	al,es:[bx+1Fh]
2D1B:03B4 98              	cbw
2D1B:03B5 01 06 BB 86     	add	[86BBh],ax
2D1B:03B9 46              	inc	si

l2D1B_03BA:
2D1B:03BA 83 FE 0B        	cmp	si,0Bh
2D1B:03BD 7C DE           	jl	039Dh

l2D1B_03BF:
2D1B:03BF EB 26           	jmp	03E7h

l2D1B_03C1:
2D1B:03C1 33 F6           	xor	si,si
2D1B:03C3 EB 1D           	jmp	03E2h

l2D1B_03C5:
2D1B:03C5 C4 5E 06        	les	bx,[bp+6h]
2D1B:03C8 03 DE           	add	bx,si
2D1B:03CA 26 8A 47 04     	mov	al,es:[bx+4h]
2D1B:03CE 98              	cbw
2D1B:03CF 01 06 3E 83     	add	[833Eh],ax
2D1B:03D3 C4 5E 06        	les	bx,[bp+6h]
2D1B:03D6 03 DE           	add	bx,si
2D1B:03D8 26 8A 47 17     	mov	al,es:[bx+17h]
2D1B:03DC 98              	cbw
2D1B:03DD 01 06 BB 86     	add	[86BBh],ax
2D1B:03E1 46              	inc	si

l2D1B_03E2:
2D1B:03E2 83 FE 0B        	cmp	si,0Bh
2D1B:03E5 7C DE           	jl	03C5h

l2D1B_03E7:
2D1B:03E7 5E              	pop	si
2D1B:03E8 5D              	pop	bp
2D1B:03E9 CB              	retf

;; MoveUnitTowardMapCell_03EA: 2D1B:03EA
;;   Called from:
;;     2D1B:147D (in AdvanceUnitTacticalMovement_0F1F)
MoveUnitTowardMapCell_03EA proc
2D1B:03EA 55              	push	bp
2D1B:03EB 8B EC           	mov	bp,sp
2D1B:03ED 83 EC 1C        	sub	sp,1Ch
2D1B:03F0 56              	push	si
2D1B:03F1 57              	push	di
2D1B:03F2 8B 76 06        	mov	si,[bp+6h]
2D1B:03F5 FF 0E D4 3C     	dec	word ptr [3CD4h]
2D1B:03F9 7D 0C           	jge	0407h

l2D1B_03FB:
2D1B:03FB C7 06 D4 3C 0A 00 	mov	word ptr [3CD4h],0Ah
2D1B:0401 81 36 D2 3C 08 00 	xor	word ptr [3CD2h],8h

l2D1B_0407:
2D1B:0407 8A 84 9A 86     	mov	al,[si+869Ah]
2D1B:040B 98              	cbw
2D1B:040C 89 46 EE        	mov	[bp-12h],ax
2D1B:040F 8A 84 62 85     	mov	al,[si+8562h]
2D1B:0413 B4 00           	mov	ah,0h
2D1B:0415 89 46 F0        	mov	[bp-10h],ax
2D1B:0418 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:041C B4 00           	mov	ah,0h
2D1B:041E 89 46 F2        	mov	[bp-0Eh],ax
2D1B:0421 FF 76 0A        	push	word ptr [bp+0Ah]
2D1B:0424 FF 76 08        	push	word ptr [bp+8h]
2D1B:0427 FF 76 F2        	push	word ptr [bp-0Eh]
2D1B:042A FF 76 F0        	push	word ptr [bp-10h]
2D1B:042D 9A D1 06 00 08  	call	far 0800h:06D1h
2D1B:0432 83 C4 08        	add	sp,8h
2D1B:0435 89 46 E4        	mov	[bp-1Ch],ax
2D1B:0438 3D 08 00        	cmp	ax,8h
2D1B:043B 75 03           	jnz	0440h

l2D1B_043D:
2D1B:043D E9 69 04        	jmp	08A9h

l2D1B_0440:
2D1B:0440 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2D1B:0445 8B 5E E4        	mov	bx,[bp-1Ch]
2D1B:0448 D1 E3           	shl	bx,1h
2D1B:044A 8B 87 4A 17     	mov	ax,[bx+174Ah]
2D1B:044E 03 46 F0        	add	ax,[bp-10h]
2D1B:0451 3B 46 08        	cmp	ax,[bp+8h]
2D1B:0454 74 03           	jz	0459h

l2D1B_0456:
2D1B:0456 E9 39 01        	jmp	0592h

l2D1B_0459:
2D1B:0459 8B 5E E4        	mov	bx,[bp-1Ch]
2D1B:045C D1 E3           	shl	bx,1h
2D1B:045E 8B 87 5A 17     	mov	ax,[bx+175Ah]
2D1B:0462 03 46 F2        	add	ax,[bp-0Eh]
2D1B:0465 3B 46 0A        	cmp	ax,[bp+0Ah]
2D1B:0468 74 03           	jz	046Dh

l2D1B_046A:
2D1B:046A E9 25 01        	jmp	0592h

l2D1B_046D:
2D1B:046D 8B 46 E4        	mov	ax,[bp-1Ch]
2D1B:0470 89 46 EE        	mov	[bp-12h],ax
2D1B:0473 80 BC B9 B5 00  	cmp	byte ptr [si+0B5B9h],0h
2D1B:0478 75 03           	jnz	047Dh

l2D1B_047A:
2D1B:047A E9 0E 01        	jmp	058Bh

l2D1B_047D:
2D1B:047D 8B C6           	mov	ax,si
2D1B:047F BA 0B 00        	mov	dx,0Bh
2D1B:0482 F7 E2           	mul	dx
2D1B:0484 8B D8           	mov	bx,ax
2D1B:0486 81 C3 C1 86     	add	bx,86C1h
2D1B:048A 1E              	push	ds
2D1B:048B 07              	pop	es
2D1B:048C 26 80 3F 03     	cmp	byte ptr es:[bx],3h
2D1B:0490 7D 57           	jge	04E9h

l2D1B_0492:
2D1B:0492 56              	push	si
2D1B:0493 9A 23 2C 1B 2D  	call	far 2D1Bh:2C23h
2D1B:0498 59              	pop	cx
2D1B:0499 8A 84 40 83     	mov	al,[si+8340h]
2D1B:049D B4 00           	mov	ah,0h
2D1B:049F 3B 46 08        	cmp	ax,[bp+8h]
2D1B:04A2 75 3D           	jnz	04E1h

l2D1B_04A4:
2D1B:04A4 8A 84 8E 83     	mov	al,[si+838Eh]
2D1B:04A8 B4 00           	mov	ah,0h
2D1B:04AA 3B 46 0A        	cmp	ax,[bp+0Ah]
2D1B:04AD 75 32           	jnz	04E1h

l2D1B_04AF:
2D1B:04AF 56              	push	si
2D1B:04B0 9A 29 18 08 22  	call	far 2208h:1829h
2D1B:04B5 59              	pop	cx
2D1B:04B6 0B C0           	or	ax,ax
2D1B:04B8 74 0B           	jz	04C5h

l2D1B_04BA:
2D1B:04BA 33 C0           	xor	ax,ax
2D1B:04BC 50              	push	ax
2D1B:04BD 56              	push	si
2D1B:04BE 9A 33 1B 08 22  	call	far 2208h:1B33h
2D1B:04C3 59              	pop	cx
2D1B:04C4 59              	pop	cx

l2D1B_04C5:
2D1B:04C5 8B C6           	mov	ax,si
2D1B:04C7 BA 0B 00        	mov	dx,0Bh
2D1B:04CA F7 E2           	mul	dx
2D1B:04CC 8B D8           	mov	bx,ax
2D1B:04CE 81 C3 C1 86     	add	bx,86C1h
2D1B:04D2 1E              	push	ds
2D1B:04D3 07              	pop	es
2D1B:04D4 26 80 3F 01     	cmp	byte ptr es:[bx],1h
2D1B:04D8 7E 07           	jle	04E1h

l2D1B_04DA:
2D1B:04DA 56              	push	si
2D1B:04DB 9A 6F 29 1B 2D  	call	far 2D1Bh:296Fh
2D1B:04E0 59              	pop	cx

l2D1B_04E1:
2D1B:04E1 C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2D1B:04E6 E9 A0 00        	jmp	0589h

l2D1B_04E9:
2D1B:04E9 56              	push	si
2D1B:04EA 9A 29 18 08 22  	call	far 2208h:1829h
2D1B:04EF 59              	pop	cx
2D1B:04F0 0B C0           	or	ax,ax
2D1B:04F2 74 55           	jz	0549h

l2D1B_04F4:
2D1B:04F4 F6 84 3F 88 01  	test	byte ptr [si+883Fh],1h
2D1B:04F9 74 41           	jz	053Ch

l2D1B_04FB:
2D1B:04FB 89 76 F6        	mov	[bp-0Ah],si

l2D1B_04FE:
2D1B:04FE 80 8C 3F 88 80  	or	byte ptr [si+883Fh],80h
2D1B:0503 A1 DE 03        	mov	ax,[03DEh]
2D1B:0506 3B C6           	cmp	ax,si
2D1B:0508 75 06           	jnz	0510h

l2D1B_050A:
2D1B:050A C7 06 DE 03 FF FF 	mov	word ptr [03DEh],0FFFFh

l2D1B_0510:
2D1B:0510 A1 DC 03        	mov	ax,[03DCh]
2D1B:0513 3B C6           	cmp	ax,si
2D1B:0515 75 06           	jnz	051Dh

l2D1B_0517:
2D1B:0517 C7 06 DC 03 FF FF 	mov	word ptr [03DCh],0FFFFh

l2D1B_051D:
2D1B:051D 8B C6           	mov	ax,si
2D1B:051F BA 96 00        	mov	dx,96h
2D1B:0522 F7 E2           	mul	dx
2D1B:0524 8B D8           	mov	bx,ax
2D1B:0526 81 C3 81 8B     	add	bx,8B81h
2D1B:052A 1E              	push	ds
2D1B:052B 07              	pop	es
2D1B:052C 26 C6 07 00     	mov	byte ptr es:[bx],0h
2D1B:0530 46              	inc	si
2D1B:0531 F7 C6 03 00     	test	si,3h
2D1B:0535 75 C7           	jnz	04FEh

l2D1B_0537:
2D1B:0537 8B 76 F6        	mov	si,[bp-0Ah]
2D1B:053A EB 0B           	jmp	0547h

l2D1B_053C:
2D1B:053C 33 C0           	xor	ax,ax
2D1B:053E 50              	push	ax
2D1B:053F 56              	push	si
2D1B:0540 9A 33 1B 08 22  	call	far 2208h:1B33h
2D1B:0545 59              	pop	cx
2D1B:0546 59              	pop	cx

l2D1B_0547:
2D1B:0547 EB 39           	jmp	0582h

l2D1B_0549:
2D1B:0549 F6 84 3F 88 01  	test	byte ptr [si+883Fh],1h
2D1B:054E 74 32           	jz	0582h

l2D1B_0550:
2D1B:0550 A1 DE 03        	mov	ax,[03DEh]
2D1B:0553 3B C6           	cmp	ax,si
2D1B:0555 75 06           	jnz	055Dh

l2D1B_0557:
2D1B:0557 C7 06 DE 03 FF FF 	mov	word ptr [03DEh],0FFFFh

l2D1B_055D:
2D1B:055D A1 DC 03        	mov	ax,[03DCh]
2D1B:0560 3B C6           	cmp	ax,si
2D1B:0562 75 06           	jnz	056Ah

l2D1B_0564:
2D1B:0564 C7 06 DC 03 FF FF 	mov	word ptr [03DCh],0FFFFh

l2D1B_056A:
2D1B:056A 80 8C 3F 88 80  	or	byte ptr [si+883Fh],80h
2D1B:056F 8B C6           	mov	ax,si
2D1B:0571 BA 96 00        	mov	dx,96h
2D1B:0574 F7 E2           	mul	dx
2D1B:0576 8B D8           	mov	bx,ax
2D1B:0578 81 C3 81 8B     	add	bx,8B81h
2D1B:057C 1E              	push	ds
2D1B:057D 07              	pop	es
2D1B:057E 26 C6 07 00     	mov	byte ptr es:[bx],0h

l2D1B_0582:
2D1B:0582 56              	push	si
2D1B:0583 9A 6F 29 1B 2D  	call	far 2D1Bh:296Fh
2D1B:0588 59              	pop	cx

l2D1B_0589:
2D1B:0589 EB 07           	jmp	0592h

l2D1B_058B:
2D1B:058B 56              	push	si
2D1B:058C 9A 23 2C 1B 2D  	call	far 2D1Bh:2C23h
2D1B:0591 59              	pop	cx

l2D1B_0592:
2D1B:0592 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:0595 F7 26 A6 00     	mul	word ptr [00A6h]
2D1B:0599 03 46 F0        	add	ax,[bp-10h]
2D1B:059C 89 46 FA        	mov	[bp-6h],ax
2D1B:059F 8B 46 E4        	mov	ax,[bp-1Ch]
2D1B:05A2 2B 46 EE        	sub	ax,[bp-12h]
2D1B:05A5 89 46 F4        	mov	[bp-0Ch],ax
2D1B:05A8 83 7E F4 00     	cmp	word ptr [bp-0Ch],0h
2D1B:05AC 74 18           	jz	05C6h

l2D1B_05AE:
2D1B:05AE 81 66 F4 07 00  	and	word ptr [bp-0Ch],7h
2D1B:05B3 83 7E F4 05     	cmp	word ptr [bp-0Ch],5h
2D1B:05B7 7D 05           	jge	05BEh

l2D1B_05B9:
2D1B:05B9 FF 46 EE        	inc	word ptr [bp-12h]
2D1B:05BC EB 03           	jmp	05C1h

l2D1B_05BE:
2D1B:05BE FF 4E EE        	dec	word ptr [bp-12h]

l2D1B_05C1:
2D1B:05C1 81 66 EE 07 00  	and	word ptr [bp-12h],7h

l2D1B_05C6:
2D1B:05C6 C7 46 EA 07 00  	mov	word ptr [bp-16h],7h
2D1B:05CB E9 D2 02        	jmp	08A0h

l2D1B_05CE:
2D1B:05CE 8B 5E EA        	mov	bx,[bp-16h]
2D1B:05D1 03 1E D2 3C     	add	bx,[3CD2h]
2D1B:05D5 D1 E3           	shl	bx,1h
2D1B:05D7 8B 87 D6 3C     	mov	ax,[bx+3CD6h]
2D1B:05DB 03 46 EE        	add	ax,[bp-12h]
2D1B:05DE 25 07 00        	and	ax,7h
2D1B:05E1 89 46 EE        	mov	[bp-12h],ax
2D1B:05E4 8B 5E EE        	mov	bx,[bp-12h]
2D1B:05E7 D1 E3           	shl	bx,1h
2D1B:05E9 8B 87 4A 17     	mov	ax,[bx+174Ah]
2D1B:05ED 03 46 F0        	add	ax,[bp-10h]
2D1B:05F0 89 46 E6        	mov	[bp-1Ah],ax
2D1B:05F3 8B 5E EE        	mov	bx,[bp-12h]
2D1B:05F6 D1 E3           	shl	bx,1h
2D1B:05F8 8B 87 5A 17     	mov	ax,[bx+175Ah]
2D1B:05FC 03 46 F2        	add	ax,[bp-0Eh]
2D1B:05FF 89 46 E8        	mov	[bp-18h],ax
2D1B:0602 83 7E E6 00     	cmp	word ptr [bp-1Ah],0h
2D1B:0606 7D 03           	jge	060Bh

l2D1B_0608:
2D1B:0608 E9 92 02        	jmp	089Dh

l2D1B_060B:
2D1B:060B 83 7E E8 00     	cmp	word ptr [bp-18h],0h
2D1B:060F 7D 03           	jge	0614h

l2D1B_0611:
2D1B:0611 E9 89 02        	jmp	089Dh

l2D1B_0614:
2D1B:0614 8B 46 E6        	mov	ax,[bp-1Ah]
2D1B:0617 3B 06 A6 00     	cmp	ax,[00A6h]
2D1B:061B 7C 03           	jl	0620h

l2D1B_061D:
2D1B:061D E9 7D 02        	jmp	089Dh

l2D1B_0620:
2D1B:0620 8B 46 E8        	mov	ax,[bp-18h]
2D1B:0623 3B 06 A8 00     	cmp	ax,[00A8h]
2D1B:0627 7C 03           	jl	062Ch

l2D1B_0629:
2D1B:0629 E9 71 02        	jmp	089Dh

l2D1B_062C:
2D1B:062C 8B 5E EE        	mov	bx,[bp-12h]
2D1B:062F D1 E3           	shl	bx,1h
2D1B:0631 8B 87 CA 17     	mov	ax,[bx+17CAh]
2D1B:0635 03 46 FA        	add	ax,[bp-6h]
2D1B:0638 89 46 FC        	mov	[bp-4h],ax
2D1B:063B C4 1E EA 83     	les	bx,[83EAh]
2D1B:063F 03 5E FC        	add	bx,[bp-4h]
2D1B:0642 26 8A 07        	mov	al,es:[bx]
2D1B:0645 B4 00           	mov	ah,0h
2D1B:0647 89 46 F8        	mov	[bp-8h],ax
2D1B:064A 33 FF           	xor	di,di
2D1B:064C 8B 46 F8        	mov	ax,[bp-8h]
2D1B:064F 3B 06 21 88     	cmp	ax,[8821h]
2D1B:0653 7C 03           	jl	0658h

l2D1B_0655:
2D1B:0655 E9 C8 00        	jmp	0720h

l2D1B_0658:
2D1B:0658 BF 01 00        	mov	di,1h
2D1B:065B 8B C6           	mov	ax,si
2D1B:065D BA 96 00        	mov	dx,96h
2D1B:0660 F7 E2           	mul	dx
2D1B:0662 8B D8           	mov	bx,ax
2D1B:0664 81 C3 81 8B     	add	bx,8B81h
2D1B:0668 1E              	push	ds
2D1B:0669 07              	pop	es
2D1B:066A 26 80 BF 95 00 00 	cmp	byte ptr es:[bx+95h],0h
2D1B:0670 74 5F           	jz	06D1h

l2D1B_0672:
2D1B:0672 8B C6           	mov	ax,si
2D1B:0674 BA 96 00        	mov	dx,96h
2D1B:0677 F7 E2           	mul	dx
2D1B:0679 8B D8           	mov	bx,ax
2D1B:067B 81 C3 81 8B     	add	bx,8B81h
2D1B:067F 1E              	push	ds
2D1B:0680 07              	pop	es
2D1B:0681 26 8A 87 95 00  	mov	al,es:[bx+95h]
2D1B:0686 98              	cbw
2D1B:0687 48              	dec	ax
2D1B:0688 3D 05 00        	cmp	ax,5h
2D1B:068B 77 42           	ja	06CFh

l2D1B_068D:
2D1B:068D 8B D8           	mov	bx,ax
2D1B:068F D1 E3           	shl	bx,1h
2D1B:0691 2E FF A7 96 06  	jmp	word ptr cs:[bx+696h]
l2D1B_0696	dw	0x06A2
l2D1B_0698	dw	0x06B8
l2D1B_069A	dw	0x06B8
l2D1B_069C	dw	0x06B8
l2D1B_069E	dw	0x06B8
l2D1B_06A0	dw	0x06B8

l2D1B_06A2:
2D1B:06A2 8B 46 F8        	mov	ax,[bp-8h]
2D1B:06A5 3B 06 5D 85     	cmp	ax,[855Dh]
2D1B:06A9 7C 0B           	jl	06B6h

l2D1B_06AB:
2D1B:06AB 8B 46 F8        	mov	ax,[bp-8h]
2D1B:06AE 3B 06 9E 84     	cmp	ax,[849Eh]
2D1B:06B2 7F 02           	jg	06B6h

l2D1B_06B4:
2D1B:06B4 33 FF           	xor	di,di

l2D1B_06B6:
2D1B:06B6 EB 19           	jmp	06D1h

l2D1B_06B8:
2D1B:06B8 8B 46 F8        	mov	ax,[bp-8h]
2D1B:06BB 3B 06 59 88     	cmp	ax,[8859h]
2D1B:06BF 7C 0C           	jl	06CDh

l2D1B_06C1:
2D1B:06C1 A1 59 88        	mov	ax,[8859h]
2D1B:06C4 40              	inc	ax
2D1B:06C5 40              	inc	ax
2D1B:06C6 3B 46 F8        	cmp	ax,[bp-8h]
2D1B:06C9 7C 02           	jl	06CDh

l2D1B_06CB:
2D1B:06CB 33 FF           	xor	di,di

l2D1B_06CD:
2D1B:06CD EB 02           	jmp	06D1h

l2D1B_06CF:
2D1B:06CF EB 00           	jmp	06D1h

l2D1B_06D1:
2D1B:06D1 0B FF           	or	di,di
2D1B:06D3 74 4B           	jz	0720h

l2D1B_06D5:
2D1B:06D5 C7 46 EC 00 00  	mov	word ptr [bp-14h],0h
2D1B:06DA EB 3E           	jmp	071Ah

l2D1B_06DC:
2D1B:06DC 8B 46 EC        	mov	ax,[bp-14h]
2D1B:06DF 3B C6           	cmp	ax,si
2D1B:06E1 74 34           	jz	0717h

l2D1B_06E3:
2D1B:06E3 8B 46 EC        	mov	ax,[bp-14h]
2D1B:06E6 BA 96 00        	mov	dx,96h
2D1B:06E9 F7 E2           	mul	dx
2D1B:06EB 8B D8           	mov	bx,ax
2D1B:06ED 81 C3 81 8B     	add	bx,8B81h
2D1B:06F1 1E              	push	ds
2D1B:06F2 07              	pop	es
2D1B:06F3 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:06F7 74 1E           	jz	0717h

l2D1B_06F9:
2D1B:06F9 8B 5E EC        	mov	bx,[bp-14h]
2D1B:06FC 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:0700 B4 00           	mov	ah,0h
2D1B:0702 3B 46 E6        	cmp	ax,[bp-1Ah]
2D1B:0705 75 10           	jnz	0717h

l2D1B_0707:
2D1B:0707 8B 5E EC        	mov	bx,[bp-14h]
2D1B:070A 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:070E B4 00           	mov	ah,0h
2D1B:0710 3B 46 E8        	cmp	ax,[bp-18h]
2D1B:0713 75 02           	jnz	0717h

l2D1B_0715:
2D1B:0715 33 FF           	xor	di,di

l2D1B_0717:
2D1B:0717 FF 46 EC        	inc	word ptr [bp-14h]

l2D1B_071A:
2D1B:071A 83 7E EC 18     	cmp	word ptr [bp-14h],18h
2D1B:071E 7C BC           	jl	06DCh

l2D1B_0720:
2D1B:0720 0B FF           	or	di,di
2D1B:0722 75 39           	jnz	075Dh

l2D1B_0724:
2D1B:0724 8B 46 E6        	mov	ax,[bp-1Ah]
2D1B:0727 3B 46 08        	cmp	ax,[bp+8h]
2D1B:072A 75 31           	jnz	075Dh

l2D1B_072C:
2D1B:072C 8B 46 E8        	mov	ax,[bp-18h]
2D1B:072F 3B 46 0A        	cmp	ax,[bp+0Ah]
2D1B:0732 75 29           	jnz	075Dh

l2D1B_0734:
2D1B:0734 BF 02 00        	mov	di,2h
2D1B:0737 8A 84 40 83     	mov	al,[si+8340h]
2D1B:073B B4 00           	mov	ah,0h
2D1B:073D 3B 46 08        	cmp	ax,[bp+8h]
2D1B:0740 75 1B           	jnz	075Dh

l2D1B_0742:
2D1B:0742 8A 84 8E 83     	mov	al,[si+838Eh]
2D1B:0746 B4 00           	mov	ah,0h
2D1B:0748 3B 46 0A        	cmp	ax,[bp+0Ah]
2D1B:074B 75 10           	jnz	075Dh

l2D1B_074D:
2D1B:074D 8A 84 62 85     	mov	al,[si+8562h]
2D1B:0751 88 84 40 83     	mov	[si+8340h],al
2D1B:0755 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:0759 88 84 8E 83     	mov	[si+838Eh],al

l2D1B_075D:
2D1B:075D 0B FF           	or	di,di
2D1B:075F 75 03           	jnz	0764h

l2D1B_0761:
2D1B:0761 E9 39 01        	jmp	089Dh

l2D1B_0764:
2D1B:0764 83 FF 01        	cmp	di,1h
2D1B:0767 74 03           	jz	076Ch

l2D1B_0769:
2D1B:0769 E9 2F 01        	jmp	089Bh

l2D1B_076C:
2D1B:076C 8A 46 E6        	mov	al,[bp-1Ah]
2D1B:076F 88 84 62 85     	mov	[si+8562h],al
2D1B:0773 8A 46 E8        	mov	al,[bp-18h]
2D1B:0776 88 84 7B 85     	mov	[si+857Bh],al
2D1B:077A 8A 46 EE        	mov	al,[bp-12h]
2D1B:077D 88 84 9A 86     	mov	[si+869Ah],al
2D1B:0781 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2D1B:0785 74 2B           	jz	07B2h

l2D1B_0787:
2D1B:0787 8A 84 8E 83     	mov	al,[si+838Eh]
2D1B:078B B4 00           	mov	ah,0h
2D1B:078D 50              	push	ax
2D1B:078E 8A 84 40 83     	mov	al,[si+8340h]
2D1B:0792 B4 00           	mov	ah,0h
2D1B:0794 50              	push	ax
2D1B:0795 FF 76 F2        	push	word ptr [bp-0Eh]
2D1B:0798 FF 76 F0        	push	word ptr [bp-10h]
2D1B:079B 9A D1 06 00 08  	call	far 0800h:06D1h
2D1B:07A0 83 C4 08        	add	sp,8h
2D1B:07A3 89 46 E4        	mov	[bp-1Ch],ax
2D1B:07A6 3D 08 00        	cmp	ax,8h
2D1B:07A9 74 07           	jz	07B2h

l2D1B_07AB:
2D1B:07AB 8A 46 E4        	mov	al,[bp-1Ch]
2D1B:07AE 88 84 9A 86     	mov	[si+869Ah],al

l2D1B_07B2:
2D1B:07B2 80 BC 27 88 00  	cmp	byte ptr [si+8827h],0h
2D1B:07B7 75 05           	jnz	07BEh

l2D1B_07B9:
2D1B:07B9 80 B4 A3 84 01  	xor	byte ptr [si+84A3h],1h

l2D1B_07BE:
2D1B:07BE 8B 46 EE        	mov	ax,[bp-12h]
2D1B:07C1 3D 04 00        	cmp	ax,4h
2D1B:07C4 77 23           	ja	07E9h

l2D1B_07C6:
2D1B:07C6 8B D8           	mov	bx,ax
2D1B:07C8 D1 E3           	shl	bx,1h
2D1B:07CA 2E FF A7 CF 07  	jmp	word ptr cs:[bx+7CFh]
l2D1B_07CF	dw	0x07D9
l2D1B_07D1	dw	0x07DB
l2D1B_07D3	dw	0x07DB
l2D1B_07D5	dw	0x07DB
l2D1B_07D7	dw	0x07E2

l2D1B_07D9:
2D1B:07D9 EB 15           	jmp	07F0h

l2D1B_07DB:
2D1B:07DB C7 46 EE 01 00  	mov	word ptr [bp-12h],1h
2D1B:07E0 EB 0E           	jmp	07F0h

l2D1B_07E2:
2D1B:07E2 C7 46 EE 02 00  	mov	word ptr [bp-12h],2h
2D1B:07E7 EB 07           	jmp	07F0h

l2D1B_07E9:
2D1B:07E9 C7 46 EE 03 00  	mov	word ptr [bp-12h],3h
2D1B:07EE EB 00           	jmp	07F0h

l2D1B_07F0:
2D1B:07F0 FF 76 EE        	push	word ptr [bp-12h]
2D1B:07F3 56              	push	si
2D1B:07F4 9A 04 18 1B 2D  	call	far 2D1Bh:1804h
2D1B:07F9 59              	pop	cx
2D1B:07FA 59              	pop	cx
2D1B:07FB C4 1E 73 7A     	les	bx,[7A73h]
2D1B:07FF 03 5E F8        	add	bx,[bp-8h]
2D1B:0802 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:0806 75 03           	jnz	080Bh

l2D1B_0808:
2D1B:0808 E9 89 00        	jmp	0894h

l2D1B_080B:
2D1B:080B 8B C6           	mov	ax,si
2D1B:080D BA 96 00        	mov	dx,96h
2D1B:0810 F7 E2           	mul	dx
2D1B:0812 8B D8           	mov	bx,ax
2D1B:0814 81 C3 81 8B     	add	bx,8B81h
2D1B:0818 1E              	push	ds
2D1B:0819 07              	pop	es
2D1B:081A 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2D1B:0820 74 72           	jz	0894h

l2D1B_0822:
2D1B:0822 FF 76 F8        	push	word ptr [bp-8h]
2D1B:0825 FF 76 E8        	push	word ptr [bp-18h]
2D1B:0828 FF 76 E6        	push	word ptr [bp-1Ah]
2D1B:082B 9A AC 23 1B 2D  	call	far 2D1Bh:23ACh
2D1B:0830 83 C4 06        	add	sp,6h
2D1B:0833 8B C6           	mov	ax,si
2D1B:0835 BA 96 00        	mov	dx,96h
2D1B:0838 F7 E2           	mul	dx
2D1B:083A 8B D8           	mov	bx,ax
2D1B:083C 81 C3 81 8B     	add	bx,8B81h
2D1B:0840 1E              	push	ds
2D1B:0841 07              	pop	es
2D1B:0842 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:0847 25 FF 00        	and	ax,0FFh
2D1B:084A 3D 1E 00        	cmp	ax,1Eh
2D1B:084D 73 45           	jnc	0894h

l2D1B_084F:
2D1B:084F 80 BC 27 88 00  	cmp	byte ptr [si+8827h],0h
2D1B:0854 74 18           	jz	086Eh

l2D1B_0856:
2D1B:0856 8B C6           	mov	ax,si
2D1B:0858 BA 96 00        	mov	dx,96h
2D1B:085B F7 E2           	mul	dx
2D1B:085D 8B D8           	mov	bx,ax
2D1B:085F 81 C3 81 8B     	add	bx,8B81h
2D1B:0863 1E              	push	ds
2D1B:0864 07              	pop	es
2D1B:0865 26 81 87 86 00 E0 00 	add	word ptr es:[bx+86h],0E0h
2D1B:086C EB 26           	jmp	0894h

l2D1B_086E:
2D1B:086E 80 BC C7 99 00  	cmp	byte ptr [si+99C7h],0h
2D1B:0873 74 1F           	jz	0894h

l2D1B_0875:
2D1B:0875 8A 8C C7 99     	mov	cl,[si+99C7h]
2D1B:0879 B8 10 00        	mov	ax,10h
2D1B:087C D3 E0           	shl	ax,cl
2D1B:087E 50              	push	ax
2D1B:087F 8B C6           	mov	ax,si
2D1B:0881 BA 96 00        	mov	dx,96h
2D1B:0884 F7 E2           	mul	dx
2D1B:0886 8B D8           	mov	bx,ax
2D1B:0888 81 C3 81 8B     	add	bx,8B81h
2D1B:088C 1E              	push	ds
2D1B:088D 07              	pop	es
2D1B:088E 58              	pop	ax
2D1B:088F 26 01 87 86 00  	add	es:[bx+86h],ax

l2D1B_0894:
2D1B:0894 8A 46 F8        	mov	al,[bp-8h]
2D1B:0897 88 84 93 99     	mov	[si+9993h],al

l2D1B_089B:
2D1B:089B EB 0C           	jmp	08A9h

l2D1B_089D:
2D1B:089D FF 4E EA        	dec	word ptr [bp-16h]

l2D1B_08A0:
2D1B:08A0 83 7E EA FF     	cmp	word ptr [bp-16h],0FFh
2D1B:08A4 7E 03           	jle	08A9h

l2D1B_08A6:
2D1B:08A6 E9 25 FD        	jmp	05CEh

l2D1B_08A9:
2D1B:08A9 5F              	pop	di
2D1B:08AA 5E              	pop	si
2D1B:08AB 8B E5           	mov	sp,bp
2D1B:08AD 5D              	pop	bp
2D1B:08AE CB              	retf

;; RefreshAllUnitCombatState_08AF: 2D1B:08AF
;;   Called from:
;;     1A1F:061F (in RunTacticalInteractionLoop_0613)
;;     1A1F:07AA (in RunTacticalInteractionLoop_0613)
RefreshAllUnitCombatState_08AF proc
2D1B:08AF 55              	push	bp
2D1B:08B0 8B EC           	mov	bp,sp
2D1B:08B2 56              	push	si
2D1B:08B3 57              	push	di
2D1B:08B4 33 FF           	xor	di,di
2D1B:08B6 33 F6           	xor	si,si
2D1B:08B8 EB 32           	jmp	08ECh

l2D1B_08BA:
2D1B:08BA 8B C6           	mov	ax,si
2D1B:08BC BA 96 00        	mov	dx,96h
2D1B:08BF F7 E2           	mul	dx
2D1B:08C1 8B D8           	mov	bx,ax
2D1B:08C3 81 C3 81 8B     	add	bx,8B81h
2D1B:08C7 1E              	push	ds
2D1B:08C8 07              	pop	es
2D1B:08C9 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:08CD 74 1C           	jz	08EBh

l2D1B_08CF:
2D1B:08CF B8 01 00        	mov	ax,1h
2D1B:08D2 50              	push	ax
2D1B:08D3 FF 76 06        	push	word ptr [bp+6h]
2D1B:08D6 56              	push	si
2D1B:08D7 1E              	push	ds
2D1B:08D8 8B C6           	mov	ax,si
2D1B:08DA BA 96 00        	mov	dx,96h
2D1B:08DD F7 E2           	mul	dx
2D1B:08DF 05 81 8B        	add	ax,8B81h
2D1B:08E2 50              	push	ax
2D1B:08E3 0E              	push	cs
2D1B:08E4 E8 1E F7        	call	0005h
2D1B:08E7 83 C4 0A        	add	sp,0Ah
2D1B:08EA 47              	inc	di

l2D1B_08EB:
2D1B:08EB 46              	inc	si

l2D1B_08EC:
2D1B:08EC 83 FE 18        	cmp	si,18h
2D1B:08EF 7C C9           	jl	08BAh

l2D1B_08F1:
2D1B:08F1 9A FA 08 1B 2D  	call	far 2D1Bh:08FAh
2D1B:08F6 5F              	pop	di
2D1B:08F7 5E              	pop	si
2D1B:08F8 5D              	pop	bp
2D1B:08F9 CB              	retf

;; SelectUnitTacticalTargets_08FA: 2D1B:08FA
;;   Called from:
;;     2D1B:08F1 (in RefreshAllUnitCombatState_08AF)
SelectUnitTacticalTargets_08FA proc
2D1B:08FA 55              	push	bp
2D1B:08FB 8B EC           	mov	bp,sp
2D1B:08FD 83 EC 18        	sub	sp,18h
2D1B:0900 56              	push	si
2D1B:0901 57              	push	di
2D1B:0902 C7 46 E8 0C 00  	mov	word ptr [bp-18h],0Ch
2D1B:0907 33 F6           	xor	si,si
2D1B:0909 E9 05 06        	jmp	0F11h

l2D1B_090C:
2D1B:090C 8B C6           	mov	ax,si
2D1B:090E BA 96 00        	mov	dx,96h
2D1B:0911 F7 E2           	mul	dx
2D1B:0913 8B D8           	mov	bx,ax
2D1B:0915 81 C3 81 8B     	add	bx,8B81h
2D1B:0919 1E              	push	ds
2D1B:091A 07              	pop	es
2D1B:091B 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:091F 75 03           	jnz	0924h

l2D1B_0921:
2D1B:0921 E9 EC 05        	jmp	0F10h

l2D1B_0924:
2D1B:0924 80 BC F3 88 FF  	cmp	byte ptr [si+88F3h],0FFh
2D1B:0929 74 24           	jz	094Fh

l2D1B_092B:
2D1B:092B 80 BC F3 88 18  	cmp	byte ptr [si+88F3h],18h
2D1B:0930 7D 1D           	jge	094Fh

l2D1B_0932:
2D1B:0932 8A 84 F3 88     	mov	al,[si+88F3h]
2D1B:0936 98              	cbw
2D1B:0937 BA 96 00        	mov	dx,96h
2D1B:093A F7 E2           	mul	dx
2D1B:093C 8B D8           	mov	bx,ax
2D1B:093E 81 C3 81 8B     	add	bx,8B81h
2D1B:0942 1E              	push	ds
2D1B:0943 07              	pop	es
2D1B:0944 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:0948 75 05           	jnz	094Fh

l2D1B_094A:
2D1B:094A C6 84 F3 88 FF  	mov	byte ptr [si+88F3h],0FFh

l2D1B_094F:
2D1B:094F A1 2A B0        	mov	ax,[0B02Ah]
2D1B:0952 50              	push	ax
2D1B:0953 8B C6           	mov	ax,si
2D1B:0955 BA 96 00        	mov	dx,96h
2D1B:0958 F7 E2           	mul	dx
2D1B:095A 8B D8           	mov	bx,ax
2D1B:095C 81 C3 81 8B     	add	bx,8B81h
2D1B:0960 1E              	push	ds
2D1B:0961 07              	pop	es
2D1B:0962 26 8A 87 93 00  	mov	al,es:[bx+93h]
2D1B:0967 98              	cbw
2D1B:0968 8B D8           	mov	bx,ax
2D1B:096A D1 E3           	shl	bx,1h
2D1B:096C 58              	pop	ax
2D1B:096D 85 87 F6 3C     	test	[bx+3CF6h],ax
2D1B:0971 75 03           	jnz	0976h

l2D1B_0973:
2D1B:0973 E9 9A 05        	jmp	0F10h

l2D1B_0976:
2D1B:0976 83 FE 0C        	cmp	si,0Ch
2D1B:0979 7C 05           	jl	0980h

l2D1B_097B:
2D1B:097B C7 46 E8 00 00  	mov	word ptr [bp-18h],0h

l2D1B_0980:
2D1B:0980 8A 84 62 85     	mov	al,[si+8562h]
2D1B:0984 B4 00           	mov	ah,0h
2D1B:0986 89 46 EC        	mov	[bp-14h],ax
2D1B:0989 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:098D B4 00           	mov	ah,0h
2D1B:098F 89 46 EE        	mov	[bp-12h],ax
2D1B:0992 C7 46 F2 FF FF  	mov	word ptr [bp-0Eh],0FFFFh
2D1B:0997 C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h
2D1B:099C 80 BC 68 8B 00  	cmp	byte ptr [si+8B68h],0h
2D1B:09A1 75 05           	jnz	09A8h

l2D1B_09A3:
2D1B:09A3 C7 46 F6 00 00  	mov	word ptr [bp-0Ah],0h

l2D1B_09A8:
2D1B:09A8 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:09AD 75 41           	jnz	09F0h

l2D1B_09AF:
2D1B:09AF 80 BC F3 88 FF  	cmp	byte ptr [si+88F3h],0FFh
2D1B:09B4 7E 3A           	jle	09F0h

l2D1B_09B6:
2D1B:09B6 80 BC F3 88 18  	cmp	byte ptr [si+88F3h],18h
2D1B:09BB 7D 33           	jge	09F0h

l2D1B_09BD:
2D1B:09BD C7 46 F6 00 00  	mov	word ptr [bp-0Ah],0h
2D1B:09C2 80 BC 67 86 00  	cmp	byte ptr [si+8667h],0h
2D1B:09C7 74 0A           	jz	09D3h

l2D1B_09C9:
2D1B:09C9 8A 84 F3 88     	mov	al,[si+88F3h]
2D1B:09CD 98              	cbw
2D1B:09CE 89 46 F2        	mov	[bp-0Eh],ax
2D1B:09D1 EB 1D           	jmp	09F0h

l2D1B_09D3:
2D1B:09D3 80 BC 80 86 00  	cmp	byte ptr [si+8680h],0h
2D1B:09D8 74 11           	jz	09EBh

l2D1B_09DA:
2D1B:09DA 80 BC ED 87 00  	cmp	byte ptr [si+87EDh],0h
2D1B:09DF 74 0A           	jz	09EBh

l2D1B_09E1:
2D1B:09E1 8A 84 F3 88     	mov	al,[si+88F3h]
2D1B:09E5 98              	cbw
2D1B:09E6 89 46 F2        	mov	[bp-0Eh],ax
2D1B:09E9 EB 05           	jmp	09F0h

l2D1B_09EB:
2D1B:09EB C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h

l2D1B_09F0:
2D1B:09F0 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2D1B:09F4 75 03           	jnz	09F9h

l2D1B_09F6:
2D1B:09F6 E9 F0 00        	jmp	0AE9h

l2D1B_09F9:
2D1B:09F9 C7 46 F0 FF 7F  	mov	word ptr [bp-10h],7FFFh
2D1B:09FE 80 BC F3 88 18  	cmp	byte ptr [si+88F3h],18h
2D1B:0A03 75 26           	jnz	0A2Bh

l2D1B_0A05:
2D1B:0A05 8A 84 A7 83     	mov	al,[si+83A7h]
2D1B:0A09 B4 00           	mov	ah,0h
2D1B:0A0B 50              	push	ax
2D1B:0A0C 8A 84 59 83     	mov	al,[si+8359h]
2D1B:0A10 B4 00           	mov	ah,0h
2D1B:0A12 50              	push	ax
2D1B:0A13 FF 76 EE        	push	word ptr [bp-12h]
2D1B:0A16 FF 76 EC        	push	word ptr [bp-14h]
2D1B:0A19 9A 90 0D 07 20  	call	far 2007h:0D90h
2D1B:0A1E 83 C4 08        	add	sp,8h
2D1B:0A21 D1 F8           	sar	ax,1h
2D1B:0A23 89 46 F0        	mov	[bp-10h],ax
2D1B:0A26 C7 46 F2 18 00  	mov	word ptr [bp-0Eh],18h

l2D1B_0A2B:
2D1B:0A2B C7 46 EA 00 00  	mov	word ptr [bp-16h],0h
2D1B:0A30 E9 AD 00        	jmp	0AE0h

l2D1B_0A33:
2D1B:0A33 8B 46 E8        	mov	ax,[bp-18h]
2D1B:0A36 03 46 EA        	add	ax,[bp-16h]
2D1B:0A39 BA 96 00        	mov	dx,96h
2D1B:0A3C F7 E2           	mul	dx
2D1B:0A3E 8B D8           	mov	bx,ax
2D1B:0A40 81 C3 81 8B     	add	bx,8B81h
2D1B:0A44 1E              	push	ds
2D1B:0A45 07              	pop	es
2D1B:0A46 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:0A4A 75 03           	jnz	0A4Fh

l2D1B_0A4C:
2D1B:0A4C E9 8E 00        	jmp	0ADDh

l2D1B_0A4F:
2D1B:0A4F 8B 5E E8        	mov	bx,[bp-18h]
2D1B:0A52 03 5E EA        	add	bx,[bp-16h]
2D1B:0A55 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:0A59 B4 00           	mov	ah,0h
2D1B:0A5B 50              	push	ax
2D1B:0A5C 8B 5E E8        	mov	bx,[bp-18h]
2D1B:0A5F 03 5E EA        	add	bx,[bp-16h]
2D1B:0A62 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:0A66 B4 00           	mov	ah,0h
2D1B:0A68 50              	push	ax
2D1B:0A69 FF 76 EE        	push	word ptr [bp-12h]
2D1B:0A6C FF 76 EC        	push	word ptr [bp-14h]
2D1B:0A6F 9A 90 0D 07 20  	call	far 2007h:0D90h
2D1B:0A74 83 C4 08        	add	sp,8h
2D1B:0A77 89 46 F4        	mov	[bp-0Ch],ax
2D1B:0A7A 8B 46 E8        	mov	ax,[bp-18h]
2D1B:0A7D 03 46 EA        	add	ax,[bp-16h]
2D1B:0A80 50              	push	ax
2D1B:0A81 8A 84 F3 88     	mov	al,[si+88F3h]
2D1B:0A85 98              	cbw
2D1B:0A86 5A              	pop	dx
2D1B:0A87 3B D0           	cmp	dx,ax
2D1B:0A89 75 03           	jnz	0A8Eh

l2D1B_0A8B:
2D1B:0A8B D1 7E F4        	sar	word ptr [bp-0Ch],1h

l2D1B_0A8E:
2D1B:0A8E 8B 46 F4        	mov	ax,[bp-0Ch]
2D1B:0A91 3B 46 F0        	cmp	ax,[bp-10h]
2D1B:0A94 7D 47           	jge	0ADDh

l2D1B_0A96:
2D1B:0A96 8B 5E E8        	mov	bx,[bp-18h]
2D1B:0A99 03 5E EA        	add	bx,[bp-16h]
2D1B:0A9C 80 BF 67 86 00  	cmp	byte ptr [bx+8667h],0h
2D1B:0AA1 74 11           	jz	0AB4h

l2D1B_0AA3:
2D1B:0AA3 8B 46 F4        	mov	ax,[bp-0Ch]
2D1B:0AA6 89 46 F0        	mov	[bp-10h],ax
2D1B:0AA9 8B 46 E8        	mov	ax,[bp-18h]
2D1B:0AAC 03 46 EA        	add	ax,[bp-16h]
2D1B:0AAF 89 46 F2        	mov	[bp-0Eh],ax
2D1B:0AB2 EB 29           	jmp	0ADDh

l2D1B_0AB4:
2D1B:0AB4 8B 5E E8        	mov	bx,[bp-18h]
2D1B:0AB7 03 5E EA        	add	bx,[bp-16h]
2D1B:0ABA 80 BF ED 87 00  	cmp	byte ptr [bx+87EDh],0h
2D1B:0ABF 74 1C           	jz	0ADDh

l2D1B_0AC1:
2D1B:0AC1 8B 5E E8        	mov	bx,[bp-18h]
2D1B:0AC4 03 5E EA        	add	bx,[bp-16h]
2D1B:0AC7 80 BF 80 86 00  	cmp	byte ptr [bx+8680h],0h
2D1B:0ACC 74 0F           	jz	0ADDh

l2D1B_0ACE:
2D1B:0ACE 8B 46 F4        	mov	ax,[bp-0Ch]
2D1B:0AD1 89 46 F0        	mov	[bp-10h],ax
2D1B:0AD4 8B 46 E8        	mov	ax,[bp-18h]
2D1B:0AD7 03 46 EA        	add	ax,[bp-16h]
2D1B:0ADA 89 46 F2        	mov	[bp-0Eh],ax

l2D1B_0ADD:
2D1B:0ADD FF 46 EA        	inc	word ptr [bp-16h]

l2D1B_0AE0:
2D1B:0AE0 83 7E EA 0C     	cmp	word ptr [bp-16h],0Ch
2D1B:0AE4 7D 03           	jge	0AE9h

l2D1B_0AE6:
2D1B:0AE6 E9 4A FF        	jmp	0A33h

l2D1B_0AE9:
2D1B:0AE9 8A 46 F2        	mov	al,[bp-0Eh]
2D1B:0AEC 88 84 A4 88     	mov	[si+88A4h],al
2D1B:0AF0 C6 84 D6 AE 00  	mov	byte ptr [si+0AED6h],0h
2D1B:0AF5 80 BC 68 8B 01  	cmp	byte ptr [si+8B68h],1h
2D1B:0AFA 75 05           	jnz	0B01h

l2D1B_0AFC:
2D1B:0AFC C6 84 D6 AE 05  	mov	byte ptr [si+0AED6h],5h

l2D1B_0B01:
2D1B:0B01 83 7E F2 FF     	cmp	word ptr [bp-0Eh],0FFh
2D1B:0B05 75 03           	jnz	0B0Ah

l2D1B_0B07:
2D1B:0B07 E9 C9 03        	jmp	0ED3h

l2D1B_0B0A:
2D1B:0B0A 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:0B0F 74 03           	jz	0B14h

l2D1B_0B11:
2D1B:0B11 E9 BF 03        	jmp	0ED3h

l2D1B_0B14:
2D1B:0B14 C7 46 F8 00 00  	mov	word ptr [bp-8h],0h
2D1B:0B19 8B C6           	mov	ax,si
2D1B:0B1B BA 0C 00        	mov	dx,0Ch
2D1B:0B1E F7 E2           	mul	dx
2D1B:0B20 8B D8           	mov	bx,ax
2D1B:0B22 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0B26 1E              	push	ds
2D1B:0B27 07              	pop	es
2D1B:0B28 26 8B 47 02     	mov	ax,es:[bx+2h]
2D1B:0B2C 50              	push	ax
2D1B:0B2D 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:0B30 BA 0C 00        	mov	dx,0Ch
2D1B:0B33 F7 E2           	mul	dx
2D1B:0B35 8B D8           	mov	bx,ax
2D1B:0B37 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0B3B 1E              	push	ds
2D1B:0B3C 07              	pop	es
2D1B:0B3D 26 8B 47 02     	mov	ax,es:[bx+2h]
2D1B:0B41 48              	dec	ax
2D1B:0B42 5A              	pop	dx
2D1B:0B43 3B D0           	cmp	dx,ax
2D1B:0B45 7C 05           	jl	0B4Ch

l2D1B_0B47:
2D1B:0B47 81 4E F8 01 00  	or	word ptr [bp-8h],1h

l2D1B_0B4C:
2D1B:0B4C 8B C6           	mov	ax,si
2D1B:0B4E BA 0C 00        	mov	dx,0Ch
2D1B:0B51 F7 E2           	mul	dx
2D1B:0B53 8B D8           	mov	bx,ax
2D1B:0B55 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0B59 1E              	push	ds
2D1B:0B5A 07              	pop	es
2D1B:0B5B 26 83 7F 02 00  	cmp	word ptr es:[bx+2h],0h
2D1B:0B60 74 34           	jz	0B96h

l2D1B_0B62:
2D1B:0B62 8B C6           	mov	ax,si
2D1B:0B64 BA 0C 00        	mov	dx,0Ch
2D1B:0B67 F7 E2           	mul	dx
2D1B:0B69 8B D8           	mov	bx,ax
2D1B:0B6B 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0B6F 1E              	push	ds
2D1B:0B70 07              	pop	es
2D1B:0B71 26 8B 47 02     	mov	ax,es:[bx+2h]
2D1B:0B75 50              	push	ax
2D1B:0B76 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:0B79 BA 0C 00        	mov	dx,0Ch
2D1B:0B7C F7 E2           	mul	dx
2D1B:0B7E 8B D8           	mov	bx,ax
2D1B:0B80 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0B84 1E              	push	ds
2D1B:0B85 07              	pop	es
2D1B:0B86 26 8B 47 02     	mov	ax,es:[bx+2h]
2D1B:0B8A D1 E0           	shl	ax,1h
2D1B:0B8C 5A              	pop	dx
2D1B:0B8D 3B D0           	cmp	dx,ax
2D1B:0B8F 7C 05           	jl	0B96h

l2D1B_0B91:
2D1B:0B91 81 4E F8 10 00  	or	word ptr [bp-8h],10h

l2D1B_0B96:
2D1B:0B96 83 7E F2 18     	cmp	word ptr [bp-0Eh],18h
2D1B:0B9A 75 05           	jnz	0BA1h

l2D1B_0B9C:
2D1B:0B9C 81 4E F8 33 00  	or	word ptr [bp-8h],33h

l2D1B_0BA1:
2D1B:0BA1 C7 46 FA 02 00  	mov	word ptr [bp-6h],2h
2D1B:0BA6 BF 02 00        	mov	di,2h
2D1B:0BA9 E9 B3 00        	jmp	0C5Fh

l2D1B_0BAC:
2D1B:0BAC 8B C6           	mov	ax,si
2D1B:0BAE BA 0C 00        	mov	dx,0Ch
2D1B:0BB1 F7 E2           	mul	dx
2D1B:0BB3 8B D8           	mov	bx,ax
2D1B:0BB5 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0BB9 1E              	push	ds
2D1B:0BBA 07              	pop	es
2D1B:0BBB 8B C7           	mov	ax,di
2D1B:0BBD D1 E0           	shl	ax,1h
2D1B:0BBF 03 D8           	add	bx,ax
2D1B:0BC1 26 83 3F 00     	cmp	word ptr es:[bx],0h
2D1B:0BC5 75 03           	jnz	0BCAh

l2D1B_0BC7:
2D1B:0BC7 E9 91 00        	jmp	0C5Bh

l2D1B_0BCA:
2D1B:0BCA 8B C6           	mov	ax,si
2D1B:0BCC BA 0C 00        	mov	dx,0Ch
2D1B:0BCF F7 E2           	mul	dx
2D1B:0BD1 8B D8           	mov	bx,ax
2D1B:0BD3 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0BD7 1E              	push	ds
2D1B:0BD8 07              	pop	es
2D1B:0BD9 8B C7           	mov	ax,di
2D1B:0BDB D1 E0           	shl	ax,1h
2D1B:0BDD 03 D8           	add	bx,ax
2D1B:0BDF 26 8B 07        	mov	ax,es:[bx]
2D1B:0BE2 50              	push	ax
2D1B:0BE3 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:0BE6 BA 0C 00        	mov	dx,0Ch
2D1B:0BE9 F7 E2           	mul	dx
2D1B:0BEB 8B D8           	mov	bx,ax
2D1B:0BED 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0BF1 1E              	push	ds
2D1B:0BF2 07              	pop	es
2D1B:0BF3 8B C7           	mov	ax,di
2D1B:0BF5 D1 E0           	shl	ax,1h
2D1B:0BF7 03 D8           	add	bx,ax
2D1B:0BF9 58              	pop	ax
2D1B:0BFA 26 3B 07        	cmp	ax,es:[bx]
2D1B:0BFD 7C 06           	jl	0C05h

l2D1B_0BFF:
2D1B:0BFF 8B 46 FA        	mov	ax,[bp-6h]
2D1B:0C02 09 46 F8        	or	[bp-8h],ax

l2D1B_0C05:
2D1B:0C05 8B C6           	mov	ax,si
2D1B:0C07 BA 0C 00        	mov	dx,0Ch
2D1B:0C0A F7 E2           	mul	dx
2D1B:0C0C 8B D8           	mov	bx,ax
2D1B:0C0E 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0C12 1E              	push	ds
2D1B:0C13 07              	pop	es
2D1B:0C14 8B C7           	mov	ax,di
2D1B:0C16 D1 E0           	shl	ax,1h
2D1B:0C18 03 D8           	add	bx,ax
2D1B:0C1A 26 8B 07        	mov	ax,es:[bx]
2D1B:0C1D 50              	push	ax
2D1B:0C1E 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:0C21 BA 0C 00        	mov	dx,0Ch
2D1B:0C24 F7 E2           	mul	dx
2D1B:0C26 8B D8           	mov	bx,ax
2D1B:0C28 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0C2C 1E              	push	ds
2D1B:0C2D 07              	pop	es
2D1B:0C2E 8B C7           	mov	ax,di
2D1B:0C30 D1 E0           	shl	ax,1h
2D1B:0C32 03 D8           	add	bx,ax
2D1B:0C34 26 8B 07        	mov	ax,es:[bx]
2D1B:0C37 D1 E0           	shl	ax,1h
2D1B:0C39 5A              	pop	dx
2D1B:0C3A 3B D0           	cmp	dx,ax
2D1B:0C3C 7C 0A           	jl	0C48h

l2D1B_0C3E:
2D1B:0C3E 8B 46 FA        	mov	ax,[bp-6h]
2D1B:0C41 B1 04           	mov	cl,4h
2D1B:0C43 D3 E0           	shl	ax,cl
2D1B:0C45 09 46 F8        	or	[bp-8h],ax

l2D1B_0C48:
2D1B:0C48 83 7E F2 18     	cmp	word ptr [bp-0Eh],18h
2D1B:0C4C 75 0D           	jnz	0C5Bh

l2D1B_0C4E:
2D1B:0C4E 8B 46 FA        	mov	ax,[bp-6h]
2D1B:0C51 B1 04           	mov	cl,4h
2D1B:0C53 D3 E0           	shl	ax,cl
2D1B:0C55 03 46 FA        	add	ax,[bp-6h]
2D1B:0C58 09 46 F8        	or	[bp-8h],ax

l2D1B_0C5B:
2D1B:0C5B D1 66 FA        	shl	word ptr [bp-6h],1h
2D1B:0C5E 47              	inc	di

l2D1B_0C5F:
2D1B:0C5F 83 FF 04        	cmp	di,4h
2D1B:0C62 7F 03           	jg	0C67h

l2D1B_0C64:
2D1B:0C64 E9 45 FF        	jmp	0BACh

l2D1B_0C67:
2D1B:0C67 8B 5E F8        	mov	bx,[bp-8h]
2D1B:0C6A 81 E3 FF 00     	and	bx,0FFh
2D1B:0C6E 8A 87 C6 08     	mov	al,[bx+8C6h]
2D1B:0C72 88 84 D6 AE     	mov	[si+0AED6h],al
2D1B:0C76 80 BC D6 AE 03  	cmp	byte ptr [si+0AED6h],3h
2D1B:0C7B 75 5A           	jnz	0CD7h

l2D1B_0C7D:
2D1B:0C7D 8B C6           	mov	ax,si
2D1B:0C7F BA 96 00        	mov	dx,96h
2D1B:0C82 F7 E2           	mul	dx
2D1B:0C84 8B D8           	mov	bx,ax
2D1B:0C86 81 C3 81 8B     	add	bx,8B81h
2D1B:0C8A 1E              	push	ds
2D1B:0C8B 07              	pop	es
2D1B:0C8C 26 8B 47 4A     	mov	ax,es:[bx+4Ah]
2D1B:0C90 50              	push	ax
2D1B:0C91 8B C6           	mov	ax,si
2D1B:0C93 BA 96 00        	mov	dx,96h
2D1B:0C96 F7 E2           	mul	dx
2D1B:0C98 8B D8           	mov	bx,ax
2D1B:0C9A 81 C3 81 8B     	add	bx,8B81h
2D1B:0C9E 1E              	push	ds
2D1B:0C9F 07              	pop	es
2D1B:0CA0 58              	pop	ax
2D1B:0CA1 26 03 47 48     	add	ax,es:[bx+48h]
2D1B:0CA5 50              	push	ax
2D1B:0CA6 8B C6           	mov	ax,si
2D1B:0CA8 BA 96 00        	mov	dx,96h
2D1B:0CAB F7 E2           	mul	dx
2D1B:0CAD 8B D8           	mov	bx,ax
2D1B:0CAF 81 C3 81 8B     	add	bx,8B81h
2D1B:0CB3 1E              	push	ds
2D1B:0CB4 07              	pop	es
2D1B:0CB5 58              	pop	ax
2D1B:0CB6 26 03 47 46     	add	ax,es:[bx+46h]
2D1B:0CBA 74 1B           	jz	0CD7h

l2D1B_0CBC:
2D1B:0CBC 8B 5E F8        	mov	bx,[bp-8h]
2D1B:0CBF 81 E3 7F 00     	and	bx,7Fh
2D1B:0CC3 8A 87 C6 08     	mov	al,[bx+8C6h]
2D1B:0CC7 88 84 D6 AE     	mov	[si+0AED6h],al
2D1B:0CCB 80 BC D6 AE 04  	cmp	byte ptr [si+0AED6h],4h
2D1B:0CD0 75 05           	jnz	0CD7h

l2D1B_0CD2:
2D1B:0CD2 C6 84 D6 AE 03  	mov	byte ptr [si+0AED6h],3h

l2D1B_0CD7:
2D1B:0CD7 80 BC D6 AE 04  	cmp	byte ptr [si+0AED6h],4h
2D1B:0CDC 74 03           	jz	0CE1h

l2D1B_0CDE:
2D1B:0CDE E9 F2 01        	jmp	0ED3h

l2D1B_0CE1:
2D1B:0CE1 B8 0C 00        	mov	ax,0Ch
2D1B:0CE4 2B 46 E8        	sub	ax,[bp-18h]
2D1B:0CE7 89 46 FC        	mov	[bp-4h],ax
2D1B:0CEA E9 46 01        	jmp	0E33h

l2D1B_0CED:
2D1B:0CED 8B 5E FC        	mov	bx,[bp-4h]
2D1B:0CF0 8A 87 A4 88     	mov	al,[bx+88A4h]
2D1B:0CF4 98              	cbw
2D1B:0CF5 3B 46 F2        	cmp	ax,[bp-0Eh]
2D1B:0CF8 74 03           	jz	0CFDh

l2D1B_0CFA:
2D1B:0CFA E9 33 01        	jmp	0E30h

l2D1B_0CFD:
2D1B:0CFD C7 46 F8 00 00  	mov	word ptr [bp-8h],0h
2D1B:0D02 C7 46 FA 01 00  	mov	word ptr [bp-6h],1h
2D1B:0D07 BF 01 00        	mov	di,1h
2D1B:0D0A E9 CA 00        	jmp	0DD7h

l2D1B_0D0D:
2D1B:0D0D 8B C6           	mov	ax,si
2D1B:0D0F BA 0C 00        	mov	dx,0Ch
2D1B:0D12 F7 E2           	mul	dx
2D1B:0D14 8B D8           	mov	bx,ax
2D1B:0D16 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0D1A 1E              	push	ds
2D1B:0D1B 07              	pop	es
2D1B:0D1C 8B C7           	mov	ax,di
2D1B:0D1E D1 E0           	shl	ax,1h
2D1B:0D20 03 D8           	add	bx,ax
2D1B:0D22 26 8B 07        	mov	ax,es:[bx]
2D1B:0D25 89 46 FE        	mov	[bp-2h],ax
2D1B:0D28 8B 46 FC        	mov	ax,[bp-4h]
2D1B:0D2B BA 0C 00        	mov	dx,0Ch
2D1B:0D2E F7 E2           	mul	dx
2D1B:0D30 8B D8           	mov	bx,ax
2D1B:0D32 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0D36 1E              	push	ds
2D1B:0D37 07              	pop	es
2D1B:0D38 8B C7           	mov	ax,di
2D1B:0D3A D1 E0           	shl	ax,1h
2D1B:0D3C 03 D8           	add	bx,ax
2D1B:0D3E 26 8B 07        	mov	ax,es:[bx]
2D1B:0D41 03 46 FE        	add	ax,[bp-2h]
2D1B:0D44 75 03           	jnz	0D49h

l2D1B_0D46:
2D1B:0D46 E9 8A 00        	jmp	0DD3h

l2D1B_0D49:
2D1B:0D49 8B 46 FC        	mov	ax,[bp-4h]
2D1B:0D4C BA 0C 00        	mov	dx,0Ch
2D1B:0D4F F7 E2           	mul	dx
2D1B:0D51 8B D8           	mov	bx,ax
2D1B:0D53 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0D57 1E              	push	ds
2D1B:0D58 07              	pop	es
2D1B:0D59 8B C7           	mov	ax,di
2D1B:0D5B D1 E0           	shl	ax,1h
2D1B:0D5D 03 D8           	add	bx,ax
2D1B:0D5F 26 8B 07        	mov	ax,es:[bx]
2D1B:0D62 03 46 FE        	add	ax,[bp-2h]
2D1B:0D65 50              	push	ax
2D1B:0D66 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:0D69 BA 0C 00        	mov	dx,0Ch
2D1B:0D6C F7 E2           	mul	dx
2D1B:0D6E 8B D8           	mov	bx,ax
2D1B:0D70 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0D74 1E              	push	ds
2D1B:0D75 07              	pop	es
2D1B:0D76 8B C7           	mov	ax,di
2D1B:0D78 D1 E0           	shl	ax,1h
2D1B:0D7A 03 D8           	add	bx,ax
2D1B:0D7C 58              	pop	ax
2D1B:0D7D 26 3B 07        	cmp	ax,es:[bx]
2D1B:0D80 7C 06           	jl	0D88h

l2D1B_0D82:
2D1B:0D82 8B 46 FA        	mov	ax,[bp-6h]
2D1B:0D85 09 46 F8        	or	[bp-8h],ax

l2D1B_0D88:
2D1B:0D88 83 FF 01        	cmp	di,1h
2D1B:0D8B 74 1C           	jz	0DA9h

l2D1B_0D8D:
2D1B:0D8D 8B 46 FC        	mov	ax,[bp-4h]
2D1B:0D90 BA 0C 00        	mov	dx,0Ch
2D1B:0D93 F7 E2           	mul	dx
2D1B:0D95 8B D8           	mov	bx,ax
2D1B:0D97 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0D9B 1E              	push	ds
2D1B:0D9C 07              	pop	es
2D1B:0D9D 8B C7           	mov	ax,di
2D1B:0D9F D1 E0           	shl	ax,1h
2D1B:0DA1 03 D8           	add	bx,ax
2D1B:0DA3 26 8B 07        	mov	ax,es:[bx]
2D1B:0DA6 01 46 FE        	add	[bp-2h],ax

l2D1B_0DA9:
2D1B:0DA9 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:0DAC BA 0C 00        	mov	dx,0Ch
2D1B:0DAF F7 E2           	mul	dx
2D1B:0DB1 8B D8           	mov	bx,ax
2D1B:0DB3 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0DB7 1E              	push	ds
2D1B:0DB8 07              	pop	es
2D1B:0DB9 8B C7           	mov	ax,di
2D1B:0DBB D1 E0           	shl	ax,1h
2D1B:0DBD 03 D8           	add	bx,ax
2D1B:0DBF 26 8B 07        	mov	ax,es:[bx]
2D1B:0DC2 D1 E0           	shl	ax,1h
2D1B:0DC4 3B 46 FE        	cmp	ax,[bp-2h]
2D1B:0DC7 7F 0A           	jg	0DD3h

l2D1B_0DC9:
2D1B:0DC9 8B 46 FA        	mov	ax,[bp-6h]
2D1B:0DCC B1 04           	mov	cl,4h
2D1B:0DCE D3 E0           	shl	ax,cl
2D1B:0DD0 09 46 F8        	or	[bp-8h],ax

l2D1B_0DD3:
2D1B:0DD3 D1 66 FA        	shl	word ptr [bp-6h],1h
2D1B:0DD6 47              	inc	di

l2D1B_0DD7:
2D1B:0DD7 83 FF 04        	cmp	di,4h
2D1B:0DDA 7F 03           	jg	0DDFh

l2D1B_0DDC:
2D1B:0DDC E9 2E FF        	jmp	0D0Dh

l2D1B_0DDF:
2D1B:0DDF C7 46 FA 22 00  	mov	word ptr [bp-6h],22h
2D1B:0DE4 BF 02 00        	mov	di,2h
2D1B:0DE7 EB 30           	jmp	0E19h

l2D1B_0DE9:
2D1B:0DE9 8B 46 FA        	mov	ax,[bp-6h]
2D1B:0DEC 85 46 F8        	test	[bp-8h],ax
2D1B:0DEF 74 24           	jz	0E15h

l2D1B_0DF1:
2D1B:0DF1 8B C6           	mov	ax,si
2D1B:0DF3 BA 0C 00        	mov	dx,0Ch
2D1B:0DF6 F7 E2           	mul	dx
2D1B:0DF8 8B D8           	mov	bx,ax
2D1B:0DFA 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0DFE 1E              	push	ds
2D1B:0DFF 07              	pop	es
2D1B:0E00 8B C7           	mov	ax,di
2D1B:0E02 D1 E0           	shl	ax,1h
2D1B:0E04 03 D8           	add	bx,ax
2D1B:0E06 26 83 3F 00     	cmp	word ptr es:[bx],0h
2D1B:0E0A 75 09           	jnz	0E15h

l2D1B_0E0C:
2D1B:0E0C B8 FF 00        	mov	ax,0FFh
2D1B:0E0F 2B 46 FA        	sub	ax,[bp-6h]
2D1B:0E12 21 46 F8        	and	[bp-8h],ax

l2D1B_0E15:
2D1B:0E15 D1 66 FA        	shl	word ptr [bp-6h],1h
2D1B:0E18 47              	inc	di

l2D1B_0E19:
2D1B:0E19 83 FF 04        	cmp	di,4h
2D1B:0E1C 7E CB           	jle	0DE9h

l2D1B_0E1E:
2D1B:0E1E 8B 5E F8        	mov	bx,[bp-8h]
2D1B:0E21 81 E3 FF 00     	and	bx,0FFh
2D1B:0E25 8A 87 C6 08     	mov	al,[bx+8C6h]
2D1B:0E29 88 84 D6 AE     	mov	[si+0AED6h],al
2D1B:0E2D 89 76 FC        	mov	[bp-4h],si

l2D1B_0E30:
2D1B:0E30 FF 46 FC        	inc	word ptr [bp-4h]

l2D1B_0E33:
2D1B:0E33 8B 46 FC        	mov	ax,[bp-4h]
2D1B:0E36 3B C6           	cmp	ax,si
2D1B:0E38 7D 03           	jge	0E3Dh

l2D1B_0E3A:
2D1B:0E3A E9 B0 FE        	jmp	0CEDh

l2D1B_0E3D:
2D1B:0E3D 80 BC D6 AE 04  	cmp	byte ptr [si+0AED6h],4h
2D1B:0E42 75 33           	jnz	0E77h

l2D1B_0E44:
2D1B:0E44 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:0E49 75 2C           	jnz	0E77h

l2D1B_0E4B:
2D1B:0E4B 83 FE 0C        	cmp	si,0Ch
2D1B:0E4E 7D 27           	jge	0E77h

l2D1B_0E50:
2D1B:0E50 8A 84 F3 A7     	mov	al,[si+0A7F3h]
2D1B:0E54 98              	cbw
2D1B:0E55 3B 46 F2        	cmp	ax,[bp-0Eh]
2D1B:0E58 74 1D           	jz	0E77h

l2D1B_0E5A:
2D1B:0E5A C7 06 85 B5 00 00 	mov	word ptr [0B585h],0h
2D1B:0E60 C7 06 4B B0 5D 02 	mov	word ptr [0B04Bh],25Dh
2D1B:0E66 C7 06 27 89 0A 00 	mov	word ptr [8927h],0Ah
2D1B:0E6C 89 36 F2 B2     	mov	[0B2F2h],si
2D1B:0E70 8A 46 F2        	mov	al,[bp-0Eh]
2D1B:0E73 88 84 F3 A7     	mov	[si+0A7F3h],al

l2D1B_0E77:
2D1B:0E77 80 BC D6 AE 04  	cmp	byte ptr [si+0AED6h],4h
2D1B:0E7C 75 55           	jnz	0ED3h

l2D1B_0E7E:
2D1B:0E7E 8B C6           	mov	ax,si
2D1B:0E80 BA 0C 00        	mov	dx,0Ch
2D1B:0E83 F7 E2           	mul	dx
2D1B:0E85 8B D8           	mov	bx,ax
2D1B:0E87 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0E8B 1E              	push	ds
2D1B:0E8C 07              	pop	es
2D1B:0E8D 26 83 7F 04 00  	cmp	word ptr es:[bx+4h],0h
2D1B:0E92 74 07           	jz	0E9Bh

l2D1B_0E94:
2D1B:0E94 C6 84 D6 AE 01  	mov	byte ptr [si+0AED6h],1h
2D1B:0E99 EB 38           	jmp	0ED3h

l2D1B_0E9B:
2D1B:0E9B 8B C6           	mov	ax,si
2D1B:0E9D BA 0C 00        	mov	dx,0Ch
2D1B:0EA0 F7 E2           	mul	dx
2D1B:0EA2 8B D8           	mov	bx,ax
2D1B:0EA4 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0EA8 1E              	push	ds
2D1B:0EA9 07              	pop	es
2D1B:0EAA 26 83 7F 06 00  	cmp	word ptr es:[bx+6h],0h
2D1B:0EAF 74 07           	jz	0EB8h

l2D1B_0EB1:
2D1B:0EB1 C6 84 D6 AE 02  	mov	byte ptr [si+0AED6h],2h
2D1B:0EB6 EB 1B           	jmp	0ED3h

l2D1B_0EB8:
2D1B:0EB8 8B C6           	mov	ax,si
2D1B:0EBA BA 0C 00        	mov	dx,0Ch
2D1B:0EBD F7 E2           	mul	dx
2D1B:0EBF 8B D8           	mov	bx,ax
2D1B:0EC1 81 C3 F1 AE     	add	bx,0AEF1h
2D1B:0EC5 1E              	push	ds
2D1B:0EC6 07              	pop	es
2D1B:0EC7 26 83 7F 08 00  	cmp	word ptr es:[bx+8h],0h
2D1B:0ECC 74 05           	jz	0ED3h

l2D1B_0ECE:
2D1B:0ECE C6 84 D6 AE 03  	mov	byte ptr [si+0AED6h],3h

l2D1B_0ED3:
2D1B:0ED3 80 BC 68 8B 00  	cmp	byte ptr [si+8B68h],0h
2D1B:0ED8 75 0C           	jnz	0EE6h

l2D1B_0EDA:
2D1B:0EDA 80 BC F3 88 FF  	cmp	byte ptr [si+88F3h],0FFh
2D1B:0EDF 75 05           	jnz	0EE6h

l2D1B_0EE1:
2D1B:0EE1 C6 84 D6 AE 00  	mov	byte ptr [si+0AED6h],0h

l2D1B_0EE6:
2D1B:0EE6 8B C6           	mov	ax,si
2D1B:0EE8 BA 96 00        	mov	dx,96h
2D1B:0EEB F7 E2           	mul	dx
2D1B:0EED 8B D8           	mov	bx,ax
2D1B:0EEF 81 C3 81 8B     	add	bx,8B81h
2D1B:0EF3 1E              	push	ds
2D1B:0EF4 07              	pop	es
2D1B:0EF5 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2D1B:0EFB 75 13           	jnz	0F10h

l2D1B_0EFD:
2D1B:0EFD 80 BC 0C 89 00  	cmp	byte ptr [si+890Ch],0h
2D1B:0F02 74 0C           	jz	0F10h

l2D1B_0F04:
2D1B:0F04 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:0F09 75 05           	jnz	0F10h

l2D1B_0F0B:
2D1B:0F0B C6 84 D6 AE 01  	mov	byte ptr [si+0AED6h],1h

l2D1B_0F10:
2D1B:0F10 46              	inc	si

l2D1B_0F11:
2D1B:0F11 83 FE 18        	cmp	si,18h
2D1B:0F14 7D 03           	jge	0F19h

l2D1B_0F16:
2D1B:0F16 E9 F3 F9        	jmp	090Ch

l2D1B_0F19:
2D1B:0F19 5F              	pop	di
2D1B:0F1A 5E              	pop	si
2D1B:0F1B 8B E5           	mov	sp,bp
2D1B:0F1D 5D              	pop	bp
2D1B:0F1E CB              	retf

;; AdvanceUnitTacticalMovement_0F1F: 2D1B:0F1F
;;   Called from:
;;     1A1F:03A3 (in UpdateTacticalFrame_0351)
AdvanceUnitTacticalMovement_0F1F proc
2D1B:0F1F 55              	push	bp
2D1B:0F20 8B EC           	mov	bp,sp
2D1B:0F22 83 EC 16        	sub	sp,16h
2D1B:0F25 56              	push	si
2D1B:0F26 57              	push	di
2D1B:0F27 8B 76 06        	mov	si,[bp+6h]
2D1B:0F2A 8B C6           	mov	ax,si
2D1B:0F2C BA 96 00        	mov	dx,96h
2D1B:0F2F F7 E2           	mul	dx
2D1B:0F31 8B D8           	mov	bx,ax
2D1B:0F33 81 C3 81 8B     	add	bx,8B81h
2D1B:0F37 1E              	push	ds
2D1B:0F38 07              	pop	es
2D1B:0F39 26 8A 47 02     	mov	al,es:[bx+2h]
2D1B:0F3D 98              	cbw
2D1B:0F3E 89 46 F4        	mov	[bp-0Ch],ax
2D1B:0F41 80 BC C7 99 02  	cmp	byte ptr [si+99C7h],2h
2D1B:0F46 75 08           	jnz	0F50h

l2D1B_0F48:
2D1B:0F48 8B 46 F4        	mov	ax,[bp-0Ch]
2D1B:0F4B D1 F8           	sar	ax,1h
2D1B:0F4D 01 46 F4        	add	[bp-0Ch],ax

l2D1B_0F50:
2D1B:0F50 8B C6           	mov	ax,si
2D1B:0F52 BA 96 00        	mov	dx,96h
2D1B:0F55 F7 E2           	mul	dx
2D1B:0F57 8B D8           	mov	bx,ax
2D1B:0F59 81 C3 81 8B     	add	bx,8B81h
2D1B:0F5D 1E              	push	ds
2D1B:0F5E 07              	pop	es
2D1B:0F5F 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:0F64 25 FF 00        	and	ax,0FFh
2D1B:0F67 BB 05 00        	mov	bx,5h
2D1B:0F6A 33 D2           	xor	dx,dx
2D1B:0F6C F7 F3           	div	bx
2D1B:0F6E 29 46 F4        	sub	[bp-0Ch],ax
2D1B:0F71 83 7E F4 00     	cmp	word ptr [bp-0Ch],0h
2D1B:0F75 7D 05           	jge	0F7Ch

l2D1B_0F77:
2D1B:0F77 C7 46 F4 00 00  	mov	word ptr [bp-0Ch],0h

l2D1B_0F7C:
2D1B:0F7C 33 C0           	xor	ax,ax
2D1B:0F7E 89 46 F8        	mov	[bp-8h],ax
2D1B:0F81 89 46 F6        	mov	[bp-0Ah],ax
2D1B:0F84 8A 84 93 99     	mov	al,[si+9993h]
2D1B:0F88 B4 00           	mov	ah,0h
2D1B:0F8A 3B 06 5D 85     	cmp	ax,[855Dh]
2D1B:0F8E 7C 47           	jl	0FD7h

l2D1B_0F90:
2D1B:0F90 8A 84 93 99     	mov	al,[si+9993h]
2D1B:0F94 B4 00           	mov	ah,0h
2D1B:0F96 3B 06 9E 84     	cmp	ax,[849Eh]
2D1B:0F9A 7F 3B           	jg	0FD7h

l2D1B_0F9C:
2D1B:0F9C D1 7E F4        	sar	word ptr [bp-0Ch],1h
2D1B:0F9F D1 7E F4        	sar	word ptr [bp-0Ch],1h
2D1B:0FA2 80 BC 27 88 00  	cmp	byte ptr [si+8827h],0h
2D1B:0FA7 75 2E           	jnz	0FD7h

l2D1B_0FA9:
2D1B:0FA9 8B C6           	mov	ax,si
2D1B:0FAB BA 96 00        	mov	dx,96h
2D1B:0FAE F7 E2           	mul	dx
2D1B:0FB0 8B D8           	mov	bx,ax
2D1B:0FB2 81 C3 81 8B     	add	bx,8B81h
2D1B:0FB6 1E              	push	ds
2D1B:0FB7 07              	pop	es
2D1B:0FB8 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2D1B:0FBD 74 18           	jz	0FD7h

l2D1B_0FBF:
2D1B:0FBF 80 BC 3D AE 00  	cmp	byte ptr [si+0AE3Dh],0h
2D1B:0FC4 74 11           	jz	0FD7h

l2D1B_0FC6:
2D1B:0FC6 80 BC C7 99 02  	cmp	byte ptr [si+99C7h],2h
2D1B:0FCB 75 0A           	jnz	0FD7h

l2D1B_0FCD:
2D1B:0FCD B8 01 00        	mov	ax,1h
2D1B:0FD0 89 46 F6        	mov	[bp-0Ah],ax
2D1B:0FD3 88 84 27 88     	mov	[si+8827h],al

l2D1B_0FD7:
2D1B:0FD7 8A 84 93 99     	mov	al,[si+9993h]
2D1B:0FDB B4 00           	mov	ah,0h
2D1B:0FDD 3B 06 59 88     	cmp	ax,[8859h]
2D1B:0FE1 7C 48           	jl	102Bh

l2D1B_0FE3:
2D1B:0FE3 8A 84 93 99     	mov	al,[si+9993h]
2D1B:0FE7 B4 00           	mov	ah,0h
2D1B:0FE9 8B 16 59 88     	mov	dx,[8859h]
2D1B:0FED 42              	inc	dx
2D1B:0FEE 42              	inc	dx
2D1B:0FEF 3B C2           	cmp	ax,dx
2D1B:0FF1 7F 38           	jg	102Bh

l2D1B_0FF3:
2D1B:0FF3 D1 7E F4        	sar	word ptr [bp-0Ch],1h
2D1B:0FF6 80 BC 27 88 00  	cmp	byte ptr [si+8827h],0h
2D1B:0FFB 75 2E           	jnz	102Bh

l2D1B_0FFD:
2D1B:0FFD 8B C6           	mov	ax,si
2D1B:0FFF BA 96 00        	mov	dx,96h
2D1B:1002 F7 E2           	mul	dx
2D1B:1004 8B D8           	mov	bx,ax
2D1B:1006 81 C3 81 8B     	add	bx,8B81h
2D1B:100A 1E              	push	ds
2D1B:100B 07              	pop	es
2D1B:100C 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2D1B:1011 74 18           	jz	102Bh

l2D1B_1013:
2D1B:1013 80 BC 3D AE 00  	cmp	byte ptr [si+0AE3Dh],0h
2D1B:1018 74 11           	jz	102Bh

l2D1B_101A:
2D1B:101A 80 BC C7 99 02  	cmp	byte ptr [si+99C7h],2h
2D1B:101F 75 0A           	jnz	102Bh

l2D1B_1021:
2D1B:1021 B8 01 00        	mov	ax,1h
2D1B:1024 89 46 F6        	mov	[bp-0Ah],ax
2D1B:1027 88 84 27 88     	mov	[si+8827h],al

l2D1B_102B:
2D1B:102B 83 7E F4 08     	cmp	word ptr [bp-0Ch],8h
2D1B:102F 7E 05           	jle	1036h

l2D1B_1031:
2D1B:1031 C7 46 F4 08 00  	mov	word ptr [bp-0Ch],8h

l2D1B_1036:
2D1B:1036 83 7E F4 01     	cmp	word ptr [bp-0Ch],1h
2D1B:103A 7D 20           	jge	105Ch

l2D1B_103C:
2D1B:103C C7 46 F4 01 00  	mov	word ptr [bp-0Ch],1h
2D1B:1041 8B C6           	mov	ax,si
2D1B:1043 BA 96 00        	mov	dx,96h
2D1B:1046 F7 E2           	mul	dx
2D1B:1048 8B D8           	mov	bx,ax
2D1B:104A 81 C3 81 8B     	add	bx,8B81h
2D1B:104E 1E              	push	ds
2D1B:104F 07              	pop	es
2D1B:1050 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2D1B:1055 75 05           	jnz	105Ch

l2D1B_1057:
2D1B:1057 C7 46 F4 09 00  	mov	word ptr [bp-0Ch],9h

l2D1B_105C:
2D1B:105C 80 BC 27 88 00  	cmp	byte ptr [si+8827h],0h
2D1B:1061 74 2D           	jz	1090h

l2D1B_1063:
2D1B:1063 80 BC 3D AE 00  	cmp	byte ptr [si+0AE3Dh],0h
2D1B:1068 74 16           	jz	1080h

l2D1B_106A:
2D1B:106A 8B C6           	mov	ax,si
2D1B:106C BA 96 00        	mov	dx,96h
2D1B:106F F7 E2           	mul	dx
2D1B:1071 8B D8           	mov	bx,ax
2D1B:1073 81 C3 81 8B     	add	bx,8B81h
2D1B:1077 1E              	push	ds
2D1B:1078 07              	pop	es
2D1B:1079 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2D1B:107E 75 07           	jnz	1087h

l2D1B_1080:
2D1B:1080 C7 46 F4 09 00  	mov	word ptr [bp-0Ch],9h
2D1B:1085 EB 09           	jmp	1090h

l2D1B_1087:
2D1B:1087 C7 46 F4 08 00  	mov	word ptr [bp-0Ch],8h
2D1B:108C FE 8C 3D AE     	dec	byte ptr [si+0AE3Dh]

l2D1B_1090:
2D1B:1090 80 BC C7 99 00  	cmp	byte ptr [si+99C7h],0h
2D1B:1095 75 03           	jnz	109Ah

l2D1B_1097:
2D1B:1097 E9 04 04        	jmp	149Eh

l2D1B_109A:
2D1B:109A A1 2A B0        	mov	ax,[0B02Ah]
2D1B:109D 8B 5E F4        	mov	bx,[bp-0Ch]
2D1B:10A0 4B              	dec	bx
2D1B:10A1 D1 E3           	shl	bx,1h
2D1B:10A3 85 87 26 10     	test	[bx+1026h],ax
2D1B:10A7 75 03           	jnz	10ACh

l2D1B_10A9:
2D1B:10A9 E9 F2 03        	jmp	149Eh

l2D1B_10AC:
2D1B:10AC 80 BC 4A A8 00  	cmp	byte ptr [si+0A84Ah],0h
2D1B:10B1 74 03           	jz	10B6h

l2D1B_10B3:
2D1B:10B3 E9 DD 03        	jmp	1493h

l2D1B_10B6:
2D1B:10B6 33 FF           	xor	di,di
2D1B:10B8 80 BC B9 B5 00  	cmp	byte ptr [si+0B5B9h],0h
2D1B:10BD 75 03           	jnz	10C2h

l2D1B_10BF:
2D1B:10BF BF 01 00        	mov	di,1h

l2D1B_10C2:
2D1B:10C2 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:10C7 75 07           	jnz	10D0h

l2D1B_10C9:
2D1B:10C9 80 BC A4 88 FF  	cmp	byte ptr [si+88A4h],0FFh
2D1B:10CE 75 0A           	jnz	10DAh

l2D1B_10D0:
2D1B:10D0 80 BC B9 B5 00  	cmp	byte ptr [si+0B5B9h],0h
2D1B:10D5 75 03           	jnz	10DAh

l2D1B_10D7:
2D1B:10D7 E9 F5 00        	jmp	11CFh

l2D1B_10DA:
2D1B:10DA 33 FF           	xor	di,di
2D1B:10DC 8B C7           	mov	ax,di
2D1B:10DE 89 46 EE        	mov	[bp-12h],ax
2D1B:10E1 80 BC F3 88 18  	cmp	byte ptr [si+88F3h],18h
2D1B:10E6 75 1C           	jnz	1104h

l2D1B_10E8:
2D1B:10E8 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:10ED 75 15           	jnz	1104h

l2D1B_10EF:
2D1B:10EF 8A 84 59 83     	mov	al,[si+8359h]
2D1B:10F3 B4 00           	mov	ah,0h
2D1B:10F5 89 46 EA        	mov	[bp-16h],ax
2D1B:10F8 8A 84 A7 83     	mov	al,[si+83A7h]
2D1B:10FC B4 00           	mov	ah,0h
2D1B:10FE 89 46 EC        	mov	[bp-14h],ax
2D1B:1101 E9 BF 00        	jmp	11C3h

l2D1B_1104:
2D1B:1104 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:1108 98              	cbw
2D1B:1109 8B D8           	mov	bx,ax
2D1B:110B 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:110F B4 00           	mov	ah,0h
2D1B:1111 89 46 EA        	mov	[bp-16h],ax
2D1B:1114 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:1118 98              	cbw
2D1B:1119 8B D8           	mov	bx,ax
2D1B:111B 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:111F B4 00           	mov	ah,0h
2D1B:1121 89 46 EC        	mov	[bp-14h],ax
2D1B:1124 80 BC A4 88 FF  	cmp	byte ptr [si+88A4h],0FFh
2D1B:1129 75 03           	jnz	112Eh

l2D1B_112B:
2D1B:112B BF 01 00        	mov	di,1h

l2D1B_112E:
2D1B:112E 80 BC F3 88 18  	cmp	byte ptr [si+88F3h],18h
2D1B:1133 74 03           	jz	1138h

l2D1B_1135:
2D1B:1135 E9 8B 00        	jmp	11C3h

l2D1B_1138:
2D1B:1138 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:113D 75 03           	jnz	1142h

l2D1B_113F:
2D1B:113F E9 81 00        	jmp	11C3h

l2D1B_1142:
2D1B:1142 8A 84 62 85     	mov	al,[si+8562h]
2D1B:1146 3A 84 40 83     	cmp	al,[si+8340h]
2D1B:114A 74 03           	jz	114Fh

l2D1B_114C:
2D1B:114C E9 74 00        	jmp	11C3h

l2D1B_114F:
2D1B:114F 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:1153 3A 84 8E 83     	cmp	al,[si+838Eh]
2D1B:1157 75 6A           	jnz	11C3h

l2D1B_1159:
2D1B:1159 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:115D 98              	cbw
2D1B:115E 8B D8           	mov	bx,ax
2D1B:1160 8A 87 67 86     	mov	al,[bx+8667h]
2D1B:1164 50              	push	ax
2D1B:1165 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:1169 98              	cbw
2D1B:116A 8B D8           	mov	bx,ax
2D1B:116C 58              	pop	ax
2D1B:116D 0A 87 80 86     	or	al,[bx+8680h]
2D1B:1171 74 50           	jz	11C3h

l2D1B_1173:
2D1B:1173 8A 84 A7 83     	mov	al,[si+83A7h]
2D1B:1177 B4 00           	mov	ah,0h
2D1B:1179 50              	push	ax
2D1B:117A 8A 84 59 83     	mov	al,[si+8359h]
2D1B:117E B4 00           	mov	ah,0h
2D1B:1180 50              	push	ax
2D1B:1181 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:1185 B4 00           	mov	ah,0h
2D1B:1187 50              	push	ax
2D1B:1188 8A 84 62 85     	mov	al,[si+8562h]
2D1B:118C B4 00           	mov	ah,0h
2D1B:118E 50              	push	ax
2D1B:118F 9A D1 06 00 08  	call	far 0800h:06D1h
2D1B:1194 83 C4 08        	add	sp,8h
2D1B:1197 89 46 FA        	mov	[bp-6h],ax
2D1B:119A 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:119E 7C 1E           	jl	11BEh

l2D1B_11A0:
2D1B:11A0 83 7E FA 07     	cmp	word ptr [bp-6h],7h
2D1B:11A4 7F 18           	jg	11BEh

l2D1B_11A6:
2D1B:11A6 8A 46 FA        	mov	al,[bp-6h]
2D1B:11A9 88 84 9A 86     	mov	[si+869Ah],al
2D1B:11AD 8B 5E FA        	mov	bx,[bp-6h]
2D1B:11B0 8A 87 2D 04     	mov	al,[bx+42Dh]
2D1B:11B4 98              	cbw
2D1B:11B5 50              	push	ax
2D1B:11B6 56              	push	si
2D1B:11B7 9A 04 18 1B 2D  	call	far 2D1Bh:1804h
2D1B:11BC 59              	pop	cx
2D1B:11BD 59              	pop	cx

l2D1B_11BE:
2D1B:11BE C7 46 F8 01 00  	mov	word ptr [bp-8h],1h

l2D1B_11C3:
2D1B:11C3 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:11C8 74 03           	jz	11CDh

l2D1B_11CA:
2D1B:11CA BF 01 00        	mov	di,1h

l2D1B_11CD:
2D1B:11CD EB 03           	jmp	11D2h

l2D1B_11CF:
2D1B:11CF BF 01 00        	mov	di,1h

l2D1B_11D2:
2D1B:11D2 0B FF           	or	di,di
2D1B:11D4 74 17           	jz	11EDh

l2D1B_11D6:
2D1B:11D6 8A 84 40 83     	mov	al,[si+8340h]
2D1B:11DA B4 00           	mov	ah,0h
2D1B:11DC 89 46 EA        	mov	[bp-16h],ax
2D1B:11DF 8A 84 8E 83     	mov	al,[si+838Eh]
2D1B:11E3 B4 00           	mov	ah,0h
2D1B:11E5 89 46 EC        	mov	[bp-14h],ax
2D1B:11E8 C7 46 EE 01 00  	mov	word ptr [bp-12h],1h

l2D1B_11ED:
2D1B:11ED 80 BC B9 B5 00  	cmp	byte ptr [si+0B5B9h],0h
2D1B:11F2 75 05           	jnz	11F9h

l2D1B_11F4:
2D1B:11F4 C6 84 D6 AE 05  	mov	byte ptr [si+0AED6h],5h

l2D1B_11F9:
2D1B:11F9 8A 84 62 85     	mov	al,[si+8562h]
2D1B:11FD B4 00           	mov	ah,0h
2D1B:11FF 89 46 F0        	mov	[bp-10h],ax
2D1B:1202 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:1206 B4 00           	mov	ah,0h
2D1B:1208 89 46 F2        	mov	[bp-0Eh],ax
2D1B:120B FF 76 EC        	push	word ptr [bp-14h]
2D1B:120E FF 76 EA        	push	word ptr [bp-16h]
2D1B:1211 FF 76 F2        	push	word ptr [bp-0Eh]
2D1B:1214 FF 76 F0        	push	word ptr [bp-10h]
2D1B:1217 9A 90 0D 07 20  	call	far 2007h:0D90h
2D1B:121C 83 C4 08        	add	sp,8h
2D1B:121F 8B F8           	mov	di,ax
2D1B:1221 83 7E EE 00     	cmp	word ptr [bp-12h],0h
2D1B:1225 74 03           	jz	122Ah

l2D1B_1227:
2D1B:1227 E9 9C 00        	jmp	12C6h

l2D1B_122A:
2D1B:122A 8A 84 D6 AE     	mov	al,[si+0AED6h]
2D1B:122E 98              	cbw
2D1B:122F 48              	dec	ax
2D1B:1230 3D 04 00        	cmp	ax,4h
2D1B:1233 76 03           	jbe	1238h

l2D1B_1235:
2D1B:1235 E9 8C 00        	jmp	12C4h

l2D1B_1238:
2D1B:1238 8B D8           	mov	bx,ax
2D1B:123A D1 E3           	shl	bx,1h
2D1B:123C 2E FF A7 41 12  	jmp	word ptr cs:[bx+1241h]
l2D1B_1241	dw	0x124B
l2D1B_1243	dw	0x1258
l2D1B_1245	dw	0x1270
l2D1B_1247	dw	0x1288
l2D1B_1249	dw	0x12AD

l2D1B_124B:
2D1B:124B 83 FF 01        	cmp	di,1h
2D1B:124E 7E 05           	jle	1255h

l2D1B_1250:
2D1B:1250 C7 46 EE 01 00  	mov	word ptr [bp-12h],1h

l2D1B_1255:
2D1B:1255 E9 6E 00        	jmp	12C6h

l2D1B_1258:
2D1B:1258 83 FF 06        	cmp	di,6h
2D1B:125B 7E 07           	jle	1264h

l2D1B_125D:
2D1B:125D C7 46 EE 01 00  	mov	word ptr [bp-12h],1h
2D1B:1262 EB 0A           	jmp	126Eh

l2D1B_1264:
2D1B:1264 83 FF 05        	cmp	di,5h
2D1B:1267 7D 05           	jge	126Eh

l2D1B_1269:
2D1B:1269 C7 46 EE 02 00  	mov	word ptr [bp-12h],2h

l2D1B_126E:
2D1B:126E EB 56           	jmp	12C6h

l2D1B_1270:
2D1B:1270 83 FF 0C        	cmp	di,0Ch
2D1B:1273 7E 07           	jle	127Ch

l2D1B_1275:
2D1B:1275 C7 46 EE 01 00  	mov	word ptr [bp-12h],1h
2D1B:127A EB 0A           	jmp	1286h

l2D1B_127C:
2D1B:127C 83 FF 0B        	cmp	di,0Bh
2D1B:127F 7D 05           	jge	1286h

l2D1B_1281:
2D1B:1281 C7 46 EE 02 00  	mov	word ptr [bp-12h],2h

l2D1B_1286:
2D1B:1286 EB 3E           	jmp	12C6h

l2D1B_1288:
2D1B:1288 83 FF 0F        	cmp	di,0Fh
2D1B:128B 7D 07           	jge	1294h

l2D1B_128D:
2D1B:128D C7 46 EE 02 00  	mov	word ptr [bp-12h],2h
2D1B:1292 EB 17           	jmp	12ABh

l2D1B_1294:
2D1B:1294 8A 84 40 83     	mov	al,[si+8340h]
2D1B:1298 B4 00           	mov	ah,0h
2D1B:129A 89 46 EA        	mov	[bp-16h],ax
2D1B:129D 8A 84 8E 83     	mov	al,[si+838Eh]
2D1B:12A1 B4 00           	mov	ah,0h
2D1B:12A3 89 46 EC        	mov	[bp-14h],ax
2D1B:12A6 C7 46 EE 01 00  	mov	word ptr [bp-12h],1h

l2D1B_12AB:
2D1B:12AB EB 19           	jmp	12C6h

l2D1B_12AD:
2D1B:12AD 8B 46 F0        	mov	ax,[bp-10h]
2D1B:12B0 3B 46 EA        	cmp	ax,[bp-16h]
2D1B:12B3 75 08           	jnz	12BDh

l2D1B_12B5:
2D1B:12B5 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:12B8 3B 46 EC        	cmp	ax,[bp-14h]
2D1B:12BB 74 05           	jz	12C2h

l2D1B_12BD:
2D1B:12BD C7 46 EE 01 00  	mov	word ptr [bp-12h],1h

l2D1B_12C2:
2D1B:12C2 EB 02           	jmp	12C6h

l2D1B_12C4:
2D1B:12C4 EB 00           	jmp	12C6h

l2D1B_12C6:
2D1B:12C6 80 BC B9 B5 02  	cmp	byte ptr [si+0B5B9h],2h
2D1B:12CB 74 03           	jz	12D0h

l2D1B_12CD:
2D1B:12CD E9 77 00        	jmp	1347h

l2D1B_12D0:
2D1B:12D0 8B FE           	mov	di,si
2D1B:12D2 81 E7 FC 00     	and	di,0FCh
2D1B:12D6 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
2D1B:12DB EB 64           	jmp	1341h

l2D1B_12DD:
2D1B:12DD 8B C7           	mov	ax,di
2D1B:12DF 03 46 FC        	add	ax,[bp-4h]
2D1B:12E2 50              	push	ax
2D1B:12E3 9A 29 18 08 22  	call	far 2208h:1829h
2D1B:12E8 59              	pop	cx
2D1B:12E9 0B C0           	or	ax,ax
2D1B:12EB 74 51           	jz	133Eh

l2D1B_12ED:
2D1B:12ED 8B DF           	mov	bx,di
2D1B:12EF 03 5E FC        	add	bx,[bp-4h]
2D1B:12F2 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:12F6 B4 00           	mov	ah,0h
2D1B:12F8 50              	push	ax
2D1B:12F9 8B DF           	mov	bx,di
2D1B:12FB 03 5E FC        	add	bx,[bp-4h]
2D1B:12FE 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:1302 B4 00           	mov	ah,0h
2D1B:1304 50              	push	ax
2D1B:1305 FF 76 F2        	push	word ptr [bp-0Eh]
2D1B:1308 FF 76 F0        	push	word ptr [bp-10h]
2D1B:130B 9A 90 0D 07 20  	call	far 2007h:0D90h
2D1B:1310 83 C4 08        	add	sp,8h
2D1B:1313 3D 06 00        	cmp	ax,6h
2D1B:1316 7C 26           	jl	133Eh

l2D1B_1318:
2D1B:1318 8B DF           	mov	bx,di
2D1B:131A 03 5E FC        	add	bx,[bp-4h]
2D1B:131D 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:1321 B4 00           	mov	ah,0h
2D1B:1323 89 46 EA        	mov	[bp-16h],ax
2D1B:1326 8B DF           	mov	bx,di
2D1B:1328 03 5E FC        	add	bx,[bp-4h]
2D1B:132B 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:132F B4 00           	mov	ah,0h
2D1B:1331 89 46 EC        	mov	[bp-14h],ax
2D1B:1334 C7 46 EE 01 00  	mov	word ptr [bp-12h],1h
2D1B:1339 C7 46 FC 05 00  	mov	word ptr [bp-4h],5h

l2D1B_133E:
2D1B:133E FF 46 FC        	inc	word ptr [bp-4h]

l2D1B_1341:
2D1B:1341 83 7E FC 04     	cmp	word ptr [bp-4h],4h
2D1B:1345 7C 96           	jl	12DDh

l2D1B_1347:
2D1B:1347 83 7E EE 02     	cmp	word ptr [bp-12h],2h
2D1B:134B 75 36           	jnz	1383h

l2D1B_134D:
2D1B:134D 8B 46 EA        	mov	ax,[bp-16h]
2D1B:1350 3B 46 F0        	cmp	ax,[bp-10h]
2D1B:1353 7E 0B           	jle	1360h

l2D1B_1355:
2D1B:1355 8B 46 F0        	mov	ax,[bp-10h]
2D1B:1358 05 FE FF        	add	ax,0FFFEh
2D1B:135B 89 46 EA        	mov	[bp-16h],ax
2D1B:135E EB 08           	jmp	1368h

l2D1B_1360:
2D1B:1360 8B 46 F0        	mov	ax,[bp-10h]
2D1B:1363 40              	inc	ax
2D1B:1364 40              	inc	ax
2D1B:1365 89 46 EA        	mov	[bp-16h],ax

l2D1B_1368:
2D1B:1368 8B 46 EC        	mov	ax,[bp-14h]
2D1B:136B 3B 46 F2        	cmp	ax,[bp-0Eh]
2D1B:136E 7E 0B           	jle	137Bh

l2D1B_1370:
2D1B:1370 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:1373 05 FE FF        	add	ax,0FFFEh
2D1B:1376 89 46 EC        	mov	[bp-14h],ax
2D1B:1379 EB 08           	jmp	1383h

l2D1B_137B:
2D1B:137B 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:137E 40              	inc	ax
2D1B:137F 40              	inc	ax
2D1B:1380 89 46 EC        	mov	[bp-14h],ax

l2D1B_1383:
2D1B:1383 8B 46 F0        	mov	ax,[bp-10h]
2D1B:1386 3B 46 EA        	cmp	ax,[bp-16h]
2D1B:1389 74 03           	jz	138Eh

l2D1B_138B:
2D1B:138B E9 E2 00        	jmp	1470h

l2D1B_138E:
2D1B:138E 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:1391 3B 46 EC        	cmp	ax,[bp-14h]
2D1B:1394 74 03           	jz	1399h

l2D1B_1396:
2D1B:1396 E9 D7 00        	jmp	1470h

l2D1B_1399:
2D1B:1399 C7 46 EE 00 00  	mov	word ptr [bp-12h],0h
2D1B:139E 83 7E F8 00     	cmp	word ptr [bp-8h],0h
2D1B:13A2 74 03           	jz	13A7h

l2D1B_13A4:
2D1B:13A4 E9 C9 00        	jmp	1470h

l2D1B_13A7:
2D1B:13A7 80 BC A4 88 FF  	cmp	byte ptr [si+88A4h],0FFh
2D1B:13AC 75 03           	jnz	13B1h

l2D1B_13AE:
2D1B:13AE E9 BF 00        	jmp	1470h

l2D1B_13B1:
2D1B:13B1 80 BC A4 88 18  	cmp	byte ptr [si+88A4h],18h
2D1B:13B6 7C 03           	jl	13BBh

l2D1B_13B8:
2D1B:13B8 E9 B5 00        	jmp	1470h

l2D1B_13BB:
2D1B:13BB 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:13BF 98              	cbw
2D1B:13C0 8B D8           	mov	bx,ax
2D1B:13C2 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:13C6 B4 00           	mov	ah,0h
2D1B:13C8 50              	push	ax
2D1B:13C9 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:13CD 98              	cbw
2D1B:13CE 8B D8           	mov	bx,ax
2D1B:13D0 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:13D4 B4 00           	mov	ah,0h
2D1B:13D6 50              	push	ax
2D1B:13D7 FF 76 F2        	push	word ptr [bp-0Eh]
2D1B:13DA FF 76 F0        	push	word ptr [bp-10h]
2D1B:13DD 9A D1 06 00 08  	call	far 0800h:06D1h
2D1B:13E2 83 C4 08        	add	sp,8h
2D1B:13E5 89 46 FA        	mov	[bp-6h],ax
2D1B:13E8 80 BC B9 B5 00  	cmp	byte ptr [si+0B5B9h],0h
2D1B:13ED 75 3E           	jnz	142Dh

l2D1B_13EF:
2D1B:13EF 56              	push	si
2D1B:13F0 9A 30 2A 1B 2D  	call	far 2D1Bh:2A30h
2D1B:13F5 59              	pop	cx
2D1B:13F6 89 46 FE        	mov	[bp-2h],ax
2D1B:13F9 8B 5E FE        	mov	bx,[bp-2h]
2D1B:13FC 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:1400 8B 5E FE        	mov	bx,[bp-2h]
2D1B:1403 3A 87 40 83     	cmp	al,[bx+8340h]
2D1B:1407 75 1D           	jnz	1426h

l2D1B_1409:
2D1B:1409 8B 5E FE        	mov	bx,[bp-2h]
2D1B:140C 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:1410 8B 5E FE        	mov	bx,[bp-2h]
2D1B:1413 3A 87 8E 83     	cmp	al,[bx+838Eh]
2D1B:1417 75 0D           	jnz	1426h

l2D1B_1419:
2D1B:1419 8B 5E FE        	mov	bx,[bp-2h]
2D1B:141C 8A 87 9A 86     	mov	al,[bx+869Ah]
2D1B:1420 98              	cbw
2D1B:1421 89 46 FA        	mov	[bp-6h],ax
2D1B:1424 EB 05           	jmp	142Bh

l2D1B_1426:
2D1B:1426 C7 46 FA FF FF  	mov	word ptr [bp-6h],0FFFFh

l2D1B_142B:
2D1B:142B EB 1F           	jmp	144Ch

l2D1B_142D:
2D1B:142D 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:1431 98              	cbw
2D1B:1432 8B D8           	mov	bx,ax
2D1B:1434 8A 87 67 86     	mov	al,[bx+8667h]
2D1B:1438 50              	push	ax
2D1B:1439 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:143D 98              	cbw
2D1B:143E 8B D8           	mov	bx,ax
2D1B:1440 58              	pop	ax
2D1B:1441 0A 87 80 86     	or	al,[bx+8680h]
2D1B:1445 75 05           	jnz	144Ch

l2D1B_1447:
2D1B:1447 C7 46 FA FF FF  	mov	word ptr [bp-6h],0FFFFh

l2D1B_144C:
2D1B:144C 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:1450 7C 1E           	jl	1470h

l2D1B_1452:
2D1B:1452 83 7E FA 07     	cmp	word ptr [bp-6h],7h
2D1B:1456 7F 18           	jg	1470h

l2D1B_1458:
2D1B:1458 8A 46 FA        	mov	al,[bp-6h]
2D1B:145B 88 84 9A 86     	mov	[si+869Ah],al
2D1B:145F 8B 5E FA        	mov	bx,[bp-6h]
2D1B:1462 8A 87 2D 04     	mov	al,[bx+42Dh]
2D1B:1466 98              	cbw
2D1B:1467 50              	push	ax
2D1B:1468 56              	push	si
2D1B:1469 9A 04 18 1B 2D  	call	far 2D1Bh:1804h
2D1B:146E 59              	pop	cx
2D1B:146F 59              	pop	cx

l2D1B_1470:
2D1B:1470 83 7E EE 00     	cmp	word ptr [bp-12h],0h
2D1B:1474 74 10           	jz	1486h

l2D1B_1476:
2D1B:1476 FF 76 EC        	push	word ptr [bp-14h]
2D1B:1479 FF 76 EA        	push	word ptr [bp-16h]
2D1B:147C 56              	push	si
2D1B:147D 0E              	push	cs
2D1B:147E E8 69 EF        	call	03EAh
2D1B:1481 83 C4 06        	add	sp,6h
2D1B:1484 EB 0B           	jmp	1491h

l2D1B_1486:
2D1B:1486 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2D1B:148A 74 05           	jz	1491h

l2D1B_148C:
2D1B:148C C6 84 27 88 00  	mov	byte ptr [si+8827h],0h

l2D1B_1491:
2D1B:1491 EB 0B           	jmp	149Eh

l2D1B_1493:
2D1B:1493 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2D1B:1497 74 05           	jz	149Eh

l2D1B_1499:
2D1B:1499 C6 84 27 88 00  	mov	byte ptr [si+8827h],0h

l2D1B_149E:
2D1B:149E 5F              	pop	di
2D1B:149F 5E              	pop	si
2D1B:14A0 8B E5           	mov	sp,bp
2D1B:14A2 5D              	pop	bp
2D1B:14A3 CB              	retf

;; ExecuteUnitWeaponAI_14A4: 2D1B:14A4
;;   Called from:
;;     1A1F:07CA (in RunTacticalInteractionLoop_0613)
ExecuteUnitWeaponAI_14A4 proc
2D1B:14A4 55              	push	bp
2D1B:14A5 8B EC           	mov	bp,sp
2D1B:14A7 83 EC 1E        	sub	sp,1Eh
2D1B:14AA 56              	push	si
2D1B:14AB 57              	push	di
2D1B:14AC 8B 76 06        	mov	si,[bp+6h]
2D1B:14AF 33 C0           	xor	ax,ax
2D1B:14B1 89 46 EC        	mov	[bp-14h],ax
2D1B:14B4 89 46 E8        	mov	[bp-18h],ax
2D1B:14B7 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:14BC 74 0E           	jz	14CCh

l2D1B_14BE:
2D1B:14BE 80 BC F3 88 FF  	cmp	byte ptr [si+88F3h],0FFh
2D1B:14C3 75 07           	jnz	14CCh

l2D1B_14C5:
2D1B:14C5 80 BC 68 8B 01  	cmp	byte ptr [si+8B68h],1h
2D1B:14CA 75 05           	jnz	14D1h

l2D1B_14CC:
2D1B:14CC C7 46 EC 01 00  	mov	word ptr [bp-14h],1h

l2D1B_14D1:
2D1B:14D1 83 7E EC 00     	cmp	word ptr [bp-14h],0h
2D1B:14D5 74 5B           	jz	1532h

l2D1B_14D7:
2D1B:14D7 80 BC 4A A8 00  	cmp	byte ptr [si+0A84Ah],0h
2D1B:14DC 74 07           	jz	14E5h

l2D1B_14DE:
2D1B:14DE C7 46 EC 00 00  	mov	word ptr [bp-14h],0h
2D1B:14E3 EB 4D           	jmp	1532h

l2D1B_14E5:
2D1B:14E5 8B C6           	mov	ax,si
2D1B:14E7 BA 96 00        	mov	dx,96h
2D1B:14EA F7 E2           	mul	dx
2D1B:14EC 8B D8           	mov	bx,ax
2D1B:14EE 81 C3 81 8B     	add	bx,8B81h
2D1B:14F2 1E              	push	ds
2D1B:14F3 07              	pop	es
2D1B:14F4 26 8A 87 93 00  	mov	al,es:[bx+93h]
2D1B:14F9 98              	cbw
2D1B:14FA 40              	inc	ax
2D1B:14FB 89 46 FA        	mov	[bp-6h],ax
2D1B:14FE 80 BC 0C 89 00  	cmp	byte ptr [si+890Ch],0h
2D1B:1503 74 03           	jz	1508h

l2D1B_1505:
2D1B:1505 FF 4E FA        	dec	word ptr [bp-6h]

l2D1B_1508:
2D1B:1508 8B C6           	mov	ax,si
2D1B:150A BA 96 00        	mov	dx,96h
2D1B:150D F7 E2           	mul	dx
2D1B:150F 8B D8           	mov	bx,ax
2D1B:1511 81 C3 81 8B     	add	bx,8B81h
2D1B:1515 1E              	push	ds
2D1B:1516 07              	pop	es
2D1B:1517 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:151C 25 FF 00        	and	ax,0FFh
2D1B:151F 8B 5E FA        	mov	bx,[bp-6h]
2D1B:1522 50              	push	ax
2D1B:1523 8A 87 E0 03     	mov	al,[bx+3E0h]
2D1B:1527 98              	cbw
2D1B:1528 5A              	pop	dx
2D1B:1529 3B D0           	cmp	dx,ax
2D1B:152B 76 05           	jbe	1532h

l2D1B_152D:
2D1B:152D C7 46 EC 00 00  	mov	word ptr [bp-14h],0h

l2D1B_1532:
2D1B:1532 83 7E EC 00     	cmp	word ptr [bp-14h],0h
2D1B:1536 75 03           	jnz	153Bh

l2D1B_1538:
2D1B:1538 E9 BE 02        	jmp	17F9h

l2D1B_153B:
2D1B:153B 8A 84 A4 88     	mov	al,[si+88A4h]
2D1B:153F 98              	cbw
2D1B:1540 8B F8           	mov	di,ax
2D1B:1542 83 FF 18        	cmp	di,18h
2D1B:1545 74 27           	jz	156Eh

l2D1B_1547:
2D1B:1547 0B FF           	or	di,di
2D1B:1549 7D 03           	jge	154Eh

l2D1B_154B:
2D1B:154B E9 A0 02        	jmp	17EEh

l2D1B_154E:
2D1B:154E 83 FF 18        	cmp	di,18h
2D1B:1551 7C 03           	jl	1556h

l2D1B_1553:
2D1B:1553 E9 98 02        	jmp	17EEh

l2D1B_1556:
2D1B:1556 8B C7           	mov	ax,di
2D1B:1558 BA 96 00        	mov	dx,96h
2D1B:155B F7 E2           	mul	dx
2D1B:155D 8B D8           	mov	bx,ax
2D1B:155F 81 C3 81 8B     	add	bx,8B81h
2D1B:1563 1E              	push	ds
2D1B:1564 07              	pop	es
2D1B:1565 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:1569 75 03           	jnz	156Eh

l2D1B_156B:
2D1B:156B E9 80 02        	jmp	17EEh

l2D1B_156E:
2D1B:156E 83 FF 18        	cmp	di,18h
2D1B:1571 75 14           	jnz	1587h

l2D1B_1573:
2D1B:1573 8A 84 59 83     	mov	al,[si+8359h]
2D1B:1577 B4 00           	mov	ah,0h
2D1B:1579 89 46 EE        	mov	[bp-12h],ax
2D1B:157C 8A 84 A7 83     	mov	al,[si+83A7h]
2D1B:1580 B4 00           	mov	ah,0h
2D1B:1582 89 46 F0        	mov	[bp-10h],ax
2D1B:1585 EB 12           	jmp	1599h

l2D1B_1587:
2D1B:1587 8A 85 62 85     	mov	al,[di+8562h]
2D1B:158B B4 00           	mov	ah,0h
2D1B:158D 89 46 EE        	mov	[bp-12h],ax
2D1B:1590 8A 85 7B 85     	mov	al,[di+857Bh]
2D1B:1594 B4 00           	mov	ah,0h
2D1B:1596 89 46 F0        	mov	[bp-10h],ax

l2D1B_1599:
2D1B:1599 FF 76 F0        	push	word ptr [bp-10h]
2D1B:159C FF 76 EE        	push	word ptr [bp-12h]
2D1B:159F 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:15A3 B4 00           	mov	ah,0h
2D1B:15A5 50              	push	ax
2D1B:15A6 8A 84 62 85     	mov	al,[si+8562h]
2D1B:15AA B4 00           	mov	ah,0h
2D1B:15AC 50              	push	ax
2D1B:15AD 9A 90 0D 07 20  	call	far 2007h:0D90h
2D1B:15B2 83 C4 08        	add	sp,8h
2D1B:15B5 89 46 E4        	mov	[bp-1Ch],ax
2D1B:15B8 33 C0           	xor	ax,ax
2D1B:15BA 89 46 E8        	mov	[bp-18h],ax
2D1B:15BD 89 46 E6        	mov	[bp-1Ah],ax
2D1B:15C0 C7 46 F2 19 00  	mov	word ptr [bp-0Eh],19h
2D1B:15C5 8B 46 E4        	mov	ax,[bp-1Ch]
2D1B:15C8 3B 46 F2        	cmp	ax,[bp-0Eh]
2D1B:15CB 7C 03           	jl	15D0h

l2D1B_15CD:
2D1B:15CD E9 1E 02        	jmp	17EEh

l2D1B_15D0:
2D1B:15D0 83 7E E4 13     	cmp	word ptr [bp-1Ch],13h
2D1B:15D4 7D 05           	jge	15DBh

l2D1B_15D6:
2D1B:15D6 81 4E E6 40 00  	or	word ptr [bp-1Ah],40h

l2D1B_15DB:
2D1B:15DB 83 7E E4 0A     	cmp	word ptr [bp-1Ch],0Ah
2D1B:15DF 7D 05           	jge	15E6h

l2D1B_15E1:
2D1B:15E1 81 4E E6 20 00  	or	word ptr [bp-1Ah],20h

l2D1B_15E6:
2D1B:15E6 83 7E E4 04     	cmp	word ptr [bp-1Ch],4h
2D1B:15EA 7D 05           	jge	15F1h

l2D1B_15EC:
2D1B:15EC 81 4E E6 10 00  	or	word ptr [bp-1Ah],10h

l2D1B_15F1:
2D1B:15F1 8B C6           	mov	ax,si
2D1B:15F3 BA 96 00        	mov	dx,96h
2D1B:15F6 F7 E2           	mul	dx
2D1B:15F8 8B D8           	mov	bx,ax
2D1B:15FA 81 C3 81 8B     	add	bx,8B81h
2D1B:15FE 1E              	push	ds
2D1B:15FF 07              	pop	es
2D1B:1600 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:1605 25 FF 00        	and	ax,0FFh
2D1B:1608 89 46 E4        	mov	[bp-1Ch],ax
2D1B:160B 83 7E E4 00     	cmp	word ptr [bp-1Ch],0h
2D1B:160F 75 07           	jnz	1618h

l2D1B_1611:
2D1B:1611 81 4E E6 01 00  	or	word ptr [bp-1Ah],1h
2D1B:1616 EB 1F           	jmp	1637h

l2D1B_1618:
2D1B:1618 83 7E E4 06     	cmp	word ptr [bp-1Ch],6h
2D1B:161C 7D 07           	jge	1625h

l2D1B_161E:
2D1B:161E 81 4E E6 02 00  	or	word ptr [bp-1Ah],2h
2D1B:1623 EB 12           	jmp	1637h

l2D1B_1625:
2D1B:1625 83 7E E4 0C     	cmp	word ptr [bp-1Ch],0Ch
2D1B:1629 7D 07           	jge	1632h

l2D1B_162B:
2D1B:162B 81 4E E6 04 00  	or	word ptr [bp-1Ah],4h
2D1B:1630 EB 05           	jmp	1637h

l2D1B_1632:
2D1B:1632 81 4E E6 08 00  	or	word ptr [bp-1Ah],8h

l2D1B_1637:
2D1B:1637 8A 85 7B 85     	mov	al,[di+857Bh]
2D1B:163B B4 00           	mov	ah,0h
2D1B:163D 50              	push	ax
2D1B:163E 8A 85 62 85     	mov	al,[di+8562h]
2D1B:1642 B4 00           	mov	ah,0h
2D1B:1644 50              	push	ax
2D1B:1645 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:1649 B4 00           	mov	ah,0h
2D1B:164B 50              	push	ax
2D1B:164C 8A 84 62 85     	mov	al,[si+8562h]
2D1B:1650 B4 00           	mov	ah,0h
2D1B:1652 50              	push	ax
2D1B:1653 9A D1 06 00 08  	call	far 0800h:06D1h
2D1B:1658 83 C4 08        	add	sp,8h
2D1B:165B 89 46 F4        	mov	[bp-0Ch],ax
2D1B:165E 83 7E F4 08     	cmp	word ptr [bp-0Ch],8h
2D1B:1662 7D 06           	jge	166Ah

l2D1B_1664:
2D1B:1664 83 7E F4 00     	cmp	word ptr [bp-0Ch],0h
2D1B:1668 7D 05           	jge	166Fh

l2D1B_166A:
2D1B:166A C7 46 F4 00 00  	mov	word ptr [bp-0Ch],0h

l2D1B_166F:
2D1B:166F 8A 84 9A 86     	mov	al,[si+869Ah]
2D1B:1673 98              	cbw
2D1B:1674 05 03 00        	add	ax,3h
2D1B:1677 89 46 F6        	mov	[bp-0Ah],ax
2D1B:167A 33 C0           	xor	ax,ax
2D1B:167C 89 46 F8        	mov	[bp-8h],ax
2D1B:167F 89 46 EA        	mov	[bp-16h],ax
2D1B:1682 EB 16           	jmp	169Ah

l2D1B_1684:
2D1B:1684 8B 46 F6        	mov	ax,[bp-0Ah]
2D1B:1687 FF 46 F6        	inc	word ptr [bp-0Ah]
2D1B:168A 25 07 00        	and	ax,7h
2D1B:168D 3B 46 F4        	cmp	ax,[bp-0Ch]
2D1B:1690 75 05           	jnz	1697h

l2D1B_1692:
2D1B:1692 C7 46 F8 01 00  	mov	word ptr [bp-8h],1h

l2D1B_1697:
2D1B:1697 FF 46 EA        	inc	word ptr [bp-16h]

l2D1B_169A:
2D1B:169A 83 7E EA 03     	cmp	word ptr [bp-16h],3h
2D1B:169E 7D 06           	jge	16A6h

l2D1B_16A0:
2D1B:16A0 83 7E F8 00     	cmp	word ptr [bp-8h],0h
2D1B:16A4 74 DE           	jz	1684h

l2D1B_16A6:
2D1B:16A6 83 7E F8 00     	cmp	word ptr [bp-8h],0h
2D1B:16AA 74 07           	jz	16B3h

l2D1B_16AC:
2D1B:16AC 56              	push	si
2D1B:16AD 9A 04 26 1B 2D  	call	far 2D1Bh:2604h
2D1B:16B2 59              	pop	cx

l2D1B_16B3:
2D1B:16B3 8B 5E E6        	mov	bx,[bp-1Ah]
2D1B:16B6 8A 87 A6 0F     	mov	al,[bx+0FA6h]
2D1B:16BA 98              	cbw
2D1B:16BB 8B D8           	mov	bx,ax
2D1B:16BD D1 E3           	shl	bx,1h
2D1B:16BF D1 E3           	shl	bx,1h
2D1B:16C1 C4 9F 66 0F     	les	bx,[bx+0F66h]
2D1B:16C5 8C 46 FE        	mov	[bp-2h],es
2D1B:16C8 89 5E FC        	mov	[bp-4h],bx
2D1B:16CB 8B 5E E6        	mov	bx,[bp-1Ah]
2D1B:16CE 8A 87 A6 0F     	mov	al,[bx+0FA6h]
2D1B:16D2 98              	cbw
2D1B:16D3 8B D8           	mov	bx,ax
2D1B:16D5 D1 E3           	shl	bx,1h
2D1B:16D7 8B 87 46 0F     	mov	ax,[bx+0F46h]
2D1B:16DB 89 46 E2        	mov	[bp-1Eh],ax
2D1B:16DE C7 46 EA 00 00  	mov	word ptr [bp-16h],0h
2D1B:16E3 EB 43           	jmp	1728h

l2D1B_16E5:
2D1B:16E5 8B 46 EA        	mov	ax,[bp-16h]
2D1B:16E8 D1 E0           	shl	ax,1h
2D1B:16EA D1 E0           	shl	ax,1h
2D1B:16EC C4 5E FC        	les	bx,[bp-4h]
2D1B:16EF 03 D8           	add	bx,ax
2D1B:16F1 26 8B 57 02     	mov	dx,es:[bx+2h]
2D1B:16F5 26 8B 07        	mov	ax,es:[bx]
2D1B:16F8 8B DE           	mov	bx,si
2D1B:16FA D1 E3           	shl	bx,1h
2D1B:16FC D1 E3           	shl	bx,1h
2D1B:16FE 23 87 71 A9     	and	ax,[bx+0A971h]
2D1B:1702 23 97 73 A9     	and	dx,[bx+0A973h]
2D1B:1706 0B D0           	or	dx,ax
2D1B:1708 74 1B           	jz	1725h

l2D1B_170A:
2D1B:170A 8B 46 EA        	mov	ax,[bp-16h]
2D1B:170D D1 E0           	shl	ax,1h
2D1B:170F D1 E0           	shl	ax,1h
2D1B:1711 C4 5E FC        	les	bx,[bp-4h]
2D1B:1714 03 D8           	add	bx,ax
2D1B:1716 8B 46 E2        	mov	ax,[bp-1Eh]
2D1B:1719 D1 E0           	shl	ax,1h
2D1B:171B D1 E0           	shl	ax,1h
2D1B:171D 03 D8           	add	bx,ax
2D1B:171F 26 8B 07        	mov	ax,es:[bx]
2D1B:1722 89 46 E8        	mov	[bp-18h],ax

l2D1B_1725:
2D1B:1725 FF 46 EA        	inc	word ptr [bp-16h]

l2D1B_1728:
2D1B:1728 8B 46 EA        	mov	ax,[bp-16h]
2D1B:172B 3B 46 E2        	cmp	ax,[bp-1Eh]
2D1B:172E 7D 06           	jge	1736h

l2D1B_1730:
2D1B:1730 83 7E E8 00     	cmp	word ptr [bp-18h],0h
2D1B:1734 74 AF           	jz	16E5h

l2D1B_1736:
2D1B:1736 83 7E E8 00     	cmp	word ptr [bp-18h],0h
2D1B:173A 75 03           	jnz	173Fh

l2D1B_173C:
2D1B:173C E9 AF 00        	jmp	17EEh

l2D1B_173F:
2D1B:173F 8B C6           	mov	ax,si
2D1B:1741 BA 96 00        	mov	dx,96h
2D1B:1744 F7 E2           	mul	dx
2D1B:1746 8B D8           	mov	bx,ax
2D1B:1748 81 C3 81 8B     	add	bx,8B81h
2D1B:174C 1E              	push	ds
2D1B:174D 07              	pop	es
2D1B:174E 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2D1B:1754 74 03           	jz	1759h

l2D1B_1756:
2D1B:1756 E9 83 00        	jmp	17DCh

l2D1B_1759:
2D1B:1759 80 BC 0C 89 00  	cmp	byte ptr [si+890Ch],0h
2D1B:175E 75 03           	jnz	1763h

l2D1B_1760:
2D1B:1760 E9 79 00        	jmp	17DCh

l2D1B_1763:
2D1B:1763 8B C6           	mov	ax,si
2D1B:1765 BA 96 00        	mov	dx,96h
2D1B:1768 F7 E2           	mul	dx
2D1B:176A 8B D8           	mov	bx,ax
2D1B:176C 81 C3 81 8B     	add	bx,8B81h
2D1B:1770 1E              	push	ds
2D1B:1771 07              	pop	es
2D1B:1772 26 FF 47 3A     	inc	word ptr es:[bx+3Ah]
2D1B:1776 57              	push	di
2D1B:1777 B8 0A 00        	mov	ax,0Ah
2D1B:177A 50              	push	ax
2D1B:177B 56              	push	si
2D1B:177C 9A 54 18 1B 2D  	call	far 2D1Bh:1854h
2D1B:1781 83 C4 06        	add	sp,6h
2D1B:1784 89 46 E8        	mov	[bp-18h],ax
2D1B:1787 83 7E E8 00     	cmp	word ptr [bp-18h],0h
2D1B:178B 74 3A           	jz	17C7h

l2D1B_178D:
2D1B:178D 8B C7           	mov	ax,di
2D1B:178F BA 96 00        	mov	dx,96h
2D1B:1792 F7 E2           	mul	dx
2D1B:1794 8B D8           	mov	bx,ax
2D1B:1796 81 C3 81 8B     	add	bx,8B81h
2D1B:179A 1E              	push	ds
2D1B:179B 07              	pop	es
2D1B:179C 26 FF 47 3A     	inc	word ptr es:[bx+3Ah]
2D1B:17A0 56              	push	si
2D1B:17A1 B8 0A 00        	mov	ax,0Ah
2D1B:17A4 50              	push	ax
2D1B:17A5 57              	push	di
2D1B:17A6 9A 54 18 1B 2D  	call	far 2D1Bh:1854h
2D1B:17AB 83 C4 06        	add	sp,6h
2D1B:17AE 0B C0           	or	ax,ax
2D1B:17B0 75 13           	jnz	17C5h

l2D1B_17B2:
2D1B:17B2 8B C7           	mov	ax,di
2D1B:17B4 BA 96 00        	mov	dx,96h
2D1B:17B7 F7 E2           	mul	dx
2D1B:17B9 8B D8           	mov	bx,ax
2D1B:17BB 81 C3 81 8B     	add	bx,8B81h
2D1B:17BF 1E              	push	ds
2D1B:17C0 07              	pop	es
2D1B:17C1 26 FF 4F 3A     	dec	word ptr es:[bx+3Ah]

l2D1B_17C5:
2D1B:17C5 EB 13           	jmp	17DAh

l2D1B_17C7:
2D1B:17C7 8B C6           	mov	ax,si
2D1B:17C9 BA 96 00        	mov	dx,96h
2D1B:17CC F7 E2           	mul	dx
2D1B:17CE 8B D8           	mov	bx,ax
2D1B:17D0 81 C3 81 8B     	add	bx,8B81h
2D1B:17D4 1E              	push	ds
2D1B:17D5 07              	pop	es
2D1B:17D6 26 FF 4F 3A     	dec	word ptr es:[bx+3Ah]

l2D1B_17DA:
2D1B:17DA EB 12           	jmp	17EEh

l2D1B_17DC:
2D1B:17DC 57              	push	di
2D1B:17DD 8B 46 E8        	mov	ax,[bp-18h]
2D1B:17E0 48              	dec	ax
2D1B:17E1 50              	push	ax
2D1B:17E2 56              	push	si
2D1B:17E3 9A 54 18 1B 2D  	call	far 2D1Bh:1854h
2D1B:17E8 83 C4 06        	add	sp,6h
2D1B:17EB 89 46 E8        	mov	[bp-18h],ax

l2D1B_17EE:
2D1B:17EE 83 7E E8 00     	cmp	word ptr [bp-18h],0h
2D1B:17F2 74 05           	jz	17F9h

l2D1B_17F4:
2D1B:17F4 C6 85 D4 87 01  	mov	byte ptr [di+87D4h],1h

l2D1B_17F9:
2D1B:17F9 8B 46 E8        	mov	ax,[bp-18h]
2D1B:17FC EB 00           	jmp	17FEh

l2D1B_17FE:
2D1B:17FE 5F              	pop	di
2D1B:17FF 5E              	pop	si
2D1B:1800 8B E5           	mov	sp,bp
2D1B:1802 5D              	pop	bp
2D1B:1803 CB              	retf

;; UpdateUnitSpriteForFacing_1804: 2D1B:1804
;;   Called from:
;;     2208:2560 (in InitializeScenarioUnitFromTemplate_2472)
;;     2D1B:07F4 (in MoveUnitTowardMapCell_03EA)
;;     2D1B:11B7 (in AdvanceUnitTacticalMovement_0F1F)
;;     2D1B:1469 (in AdvanceUnitTacticalMovement_0F1F)
UpdateUnitSpriteForFacing_1804 proc
2D1B:1804 55              	push	bp
2D1B:1805 8B EC           	mov	bp,sp
2D1B:1807 56              	push	si
2D1B:1808 8B 76 06        	mov	si,[bp+6h]
2D1B:180B 8B C6           	mov	ax,si
2D1B:180D BA 96 00        	mov	dx,96h
2D1B:1810 F7 E2           	mul	dx
2D1B:1812 8B D8           	mov	bx,ax
2D1B:1814 81 C3 81 8B     	add	bx,8B81h
2D1B:1818 1E              	push	ds
2D1B:1819 07              	pop	es
2D1B:181A 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2D1B:1820 75 05           	jnz	1827h

l2D1B_1822:
2D1B:1822 C7 46 08 00 00  	mov	word ptr [bp+8h],0h

l2D1B_1827:
2D1B:1827 8B DE           	mov	bx,si
2D1B:1829 D1 E3           	shl	bx,1h
2D1B:182B 8B 87 18 A8     	mov	ax,[bx+0A818h]
2D1B:182F 8B 56 08        	mov	dx,[bp+8h]
2D1B:1832 81 E2 03 00     	and	dx,3h
2D1B:1836 D1 E2           	shl	dx,1h
2D1B:1838 03 C2           	add	ax,dx
2D1B:183A 8B DE           	mov	bx,si
2D1B:183C D1 E3           	shl	bx,1h
2D1B:183E 89 87 6B AE     	mov	[bx+0AE6Bh],ax
2D1B:1842 80 BC A3 84 00  	cmp	byte ptr [si+84A3h],0h
2D1B:1847 74 08           	jz	1851h

l2D1B_1849:
2D1B:1849 8B DE           	mov	bx,si
2D1B:184B D1 E3           	shl	bx,1h
2D1B:184D FF 87 6B AE     	inc	word ptr [bx+0AE6Bh]

l2D1B_1851:
2D1B:1851 5E              	pop	si
2D1B:1852 5D              	pop	bp
2D1B:1853 CB              	retf

;; ResolveWeaponAttack_1854: 2D1B:1854
;;   Called from:
;;     2D1B:177C (in ExecuteUnitWeaponAI_14A4)
;;     2D1B:17A6 (in ExecuteUnitWeaponAI_14A4)
;;     2D1B:17E3 (in ExecuteUnitWeaponAI_14A4)
ResolveWeaponAttack_1854 proc
2D1B:1854 55              	push	bp
2D1B:1855 8B EC           	mov	bp,sp
2D1B:1857 83 EC 18        	sub	sp,18h
2D1B:185A 56              	push	si
2D1B:185B 57              	push	di
2D1B:185C 8B 7E 08        	mov	di,[bp+8h]
2D1B:185F 33 F6           	xor	si,si
2D1B:1861 8B C6           	mov	ax,si
2D1B:1863 89 46 FC        	mov	[bp-4h],ax
2D1B:1866 89 46 F8        	mov	[bp-8h],ax
2D1B:1869 83 7E 0A FF     	cmp	word ptr [bp+0Ah],0FFh
2D1B:186D 75 03           	jnz	1872h

l2D1B_186F:
2D1B:186F E9 29 05        	jmp	1D9Bh

l2D1B_1872:
2D1B:1872 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2D1B:1876 75 5A           	jnz	18D2h

l2D1B_1878:
2D1B:1878 8B 5E 06        	mov	bx,[bp+6h]
2D1B:187B 8A 87 59 83     	mov	al,[bx+8359h]
2D1B:187F B4 00           	mov	ah,0h
2D1B:1881 89 46 EC        	mov	[bp-14h],ax
2D1B:1884 8B 5E 06        	mov	bx,[bp+6h]
2D1B:1887 8A 87 A7 83     	mov	al,[bx+83A7h]
2D1B:188B B4 00           	mov	ah,0h
2D1B:188D 89 46 EE        	mov	[bp-12h],ax
2D1B:1890 FF 36 C0 86     	push	word ptr [86C0h]
2D1B:1894 FF 36 BE 86     	push	word ptr [86BEh]
2D1B:1898 FF 36 9E 84     	push	word ptr [849Eh]
2D1B:189C FF 36 5D 85     	push	word ptr [855Dh]
2D1B:18A0 FF 36 EC 83     	push	word ptr [83ECh]
2D1B:18A4 FF 36 EA 83     	push	word ptr [83EAh]
2D1B:18A8 FF 76 EE        	push	word ptr [bp-12h]
2D1B:18AB FF 76 EC        	push	word ptr [bp-14h]
2D1B:18AE 8B 5E 06        	mov	bx,[bp+6h]
2D1B:18B1 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:18B5 B4 00           	mov	ah,0h
2D1B:18B7 50              	push	ax
2D1B:18B8 8B 5E 06        	mov	bx,[bp+6h]
2D1B:18BB 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:18BF B4 00           	mov	ah,0h
2D1B:18C1 50              	push	ax
2D1B:18C2 9A 8C 07 00 08  	call	far 0800h:078Ch
2D1B:18C7 83 C4 14        	add	sp,14h
2D1B:18CA 89 46 FA        	mov	[bp-6h],ax
2D1B:18CD 83 EE 04        	sub	si,4h
2D1B:18D0 EB 28           	jmp	18FAh

l2D1B_18D2:
2D1B:18D2 FF 76 0A        	push	word ptr [bp+0Ah]
2D1B:18D5 FF 76 06        	push	word ptr [bp+6h]
2D1B:18D8 9A A6 1D 1B 2D  	call	far 2D1Bh:1DA6h
2D1B:18DD 59              	pop	cx
2D1B:18DE 59              	pop	cx
2D1B:18DF 89 46 FA        	mov	[bp-6h],ax
2D1B:18E2 8B 5E 0A        	mov	bx,[bp+0Ah]
2D1B:18E5 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:18E9 B4 00           	mov	ah,0h
2D1B:18EB 89 46 EC        	mov	[bp-14h],ax
2D1B:18EE 8B 5E 0A        	mov	bx,[bp+0Ah]
2D1B:18F1 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:18F5 B4 00           	mov	ah,0h
2D1B:18F7 89 46 EE        	mov	[bp-12h],ax

l2D1B_18FA:
2D1B:18FA 83 FF 10        	cmp	di,10h
2D1B:18FD 7D 03           	jge	1902h

l2D1B_18FF:
2D1B:18FF E9 7C 00        	jmp	197Eh

l2D1B_1902:
2D1B:1902 83 FF 13        	cmp	di,13h
2D1B:1905 7E 03           	jle	190Ah

l2D1B_1907:
2D1B:1907 E9 74 00        	jmp	197Eh

l2D1B_190A:
2D1B:190A 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:190E 75 6E           	jnz	197Eh

l2D1B_1910:
2D1B:1910 33 F6           	xor	si,si
2D1B:1912 83 7E 06 0C     	cmp	word ptr [bp+6h],0Ch
2D1B:1916 7C 03           	jl	191Bh

l2D1B_1918:
2D1B:1918 BE 0C 00        	mov	si,0Ch

l2D1B_191B:
2D1B:191B C7 46 E8 00 00  	mov	word ptr [bp-18h],0h
2D1B:1920 EB 56           	jmp	1978h

l2D1B_1922:
2D1B:1922 8B 46 E8        	mov	ax,[bp-18h]
2D1B:1925 03 C6           	add	ax,si
2D1B:1927 BA 96 00        	mov	dx,96h
2D1B:192A F7 E2           	mul	dx
2D1B:192C 8B D8           	mov	bx,ax
2D1B:192E 81 C3 81 8B     	add	bx,8B81h
2D1B:1932 1E              	push	ds
2D1B:1933 07              	pop	es
2D1B:1934 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:1938 74 3B           	jz	1975h

l2D1B_193A:
2D1B:193A 8B 46 E8        	mov	ax,[bp-18h]
2D1B:193D 03 C6           	add	ax,si
2D1B:193F BA 96 00        	mov	dx,96h
2D1B:1942 F7 E2           	mul	dx
2D1B:1944 8B D8           	mov	bx,ax
2D1B:1946 81 C3 81 8B     	add	bx,8B81h
2D1B:194A 1E              	push	ds
2D1B:194B 07              	pop	es
2D1B:194C 26 80 BF 8E 00 00 	cmp	byte ptr es:[bx+8Eh],0h
2D1B:1952 74 21           	jz	1975h

l2D1B_1954:
2D1B:1954 FF 76 0A        	push	word ptr [bp+0Ah]
2D1B:1957 8B 46 E8        	mov	ax,[bp-18h]
2D1B:195A 03 C6           	add	ax,si
2D1B:195C 50              	push	ax
2D1B:195D 9A A6 1D 1B 2D  	call	far 2D1Bh:1DA6h
2D1B:1962 59              	pop	cx
2D1B:1963 59              	pop	cx
2D1B:1964 0B C0           	or	ax,ax
2D1B:1966 74 0D           	jz	1975h

l2D1B_1968:
2D1B:1968 C7 46 E8 0C 00  	mov	word ptr [bp-18h],0Ch
2D1B:196D C7 46 FA 01 00  	mov	word ptr [bp-6h],1h
2D1B:1972 BE FA FF        	mov	si,0FFFAh

l2D1B_1975:
2D1B:1975 FF 46 E8        	inc	word ptr [bp-18h]

l2D1B_1978:
2D1B:1978 83 7E E8 0C     	cmp	word ptr [bp-18h],0Ch
2D1B:197C 7C A4           	jl	1922h

l2D1B_197E:
2D1B:197E 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:1982 75 03           	jnz	1987h

l2D1B_1984:
2D1B:1984 E9 14 04        	jmp	1D9Bh

l2D1B_1987:
2D1B:1987 FF 76 EE        	push	word ptr [bp-12h]
2D1B:198A FF 76 EC        	push	word ptr [bp-14h]
2D1B:198D 8B 5E 06        	mov	bx,[bp+6h]
2D1B:1990 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:1994 B4 00           	mov	ah,0h
2D1B:1996 50              	push	ax
2D1B:1997 8B 5E 06        	mov	bx,[bp+6h]
2D1B:199A 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:199E B4 00           	mov	ah,0h
2D1B:19A0 50              	push	ax
2D1B:19A1 9A 90 0D 07 20  	call	far 2007h:0D90h
2D1B:19A6 83 C4 08        	add	sp,8h
2D1B:19A9 89 46 F0        	mov	[bp-10h],ax
2D1B:19AC 8B 46 06        	mov	ax,[bp+6h]
2D1B:19AF BA 96 00        	mov	dx,96h
2D1B:19B2 F7 E2           	mul	dx
2D1B:19B4 8B D8           	mov	bx,ax
2D1B:19B6 81 C3 81 8B     	add	bx,8B81h
2D1B:19BA 1E              	push	ds
2D1B:19BB 07              	pop	es
2D1B:19BC 26 8A 87 8A 00  	mov	al,es:[bx+8Ah]
2D1B:19C1 98              	cbw
2D1B:19C2 03 F0           	add	si,ax
2D1B:19C4 8B 46 0A        	mov	ax,[bp+0Ah]
2D1B:19C7 BA 96 00        	mov	dx,96h
2D1B:19CA F7 E2           	mul	dx
2D1B:19CC 8B D8           	mov	bx,ax
2D1B:19CE 81 C3 81 8B     	add	bx,8B81h
2D1B:19D2 1E              	push	ds
2D1B:19D3 07              	pop	es
2D1B:19D4 26 8A 87 8B 00  	mov	al,es:[bx+8Bh]
2D1B:19D9 98              	cbw
2D1B:19DA 03 F0           	add	si,ax
2D1B:19DC 8B 46 0A        	mov	ax,[bp+0Ah]
2D1B:19DF BA 96 00        	mov	dx,96h
2D1B:19E2 F7 E2           	mul	dx
2D1B:19E4 8B D8           	mov	bx,ax
2D1B:19E6 81 C3 81 8B     	add	bx,8B81h
2D1B:19EA 1E              	push	ds
2D1B:19EB 07              	pop	es
2D1B:19EC 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2D1B:19F1 75 03           	jnz	19F6h

l2D1B_19F3:
2D1B:19F3 83 EE 04        	sub	si,4h

l2D1B_19F6:
2D1B:19F6 83 FF 01        	cmp	di,1h
2D1B:19F9 74 0A           	jz	1A05h

l2D1B_19FB:
2D1B:19FB 83 FF 03        	cmp	di,3h
2D1B:19FE 74 05           	jz	1A05h

l2D1B_1A00:
2D1B:1A00 83 FF 05        	cmp	di,5h
2D1B:1A03 75 02           	jnz	1A07h

l2D1B_1A05:
2D1B:1A05 4E              	dec	si
2D1B:1A06 4E              	dec	si

l2D1B_1A07:
2D1B:1A07 8B C7           	mov	ax,di
2D1B:1A09 BA 0F 00        	mov	dx,0Fh
2D1B:1A0C F7 E2           	mul	dx
2D1B:1A0E 8B D8           	mov	bx,ax
2D1B:1A10 81 C3 35 04     	add	bx,435h
2D1B:1A14 1E              	push	ds
2D1B:1A15 07              	pop	es
2D1B:1A16 26 8A 47 07     	mov	al,es:[bx+7h]
2D1B:1A1A 98              	cbw
2D1B:1A1B 89 46 FE        	mov	[bp-2h],ax
2D1B:1A1E 83 7E FC 00     	cmp	word ptr [bp-4h],0h
2D1B:1A22 74 03           	jz	1A27h

l2D1B_1A24:
2D1B:1A24 D1 66 FE        	shl	word ptr [bp-2h],1h

l2D1B_1A27:
2D1B:1A27 8B 46 F0        	mov	ax,[bp-10h]
2D1B:1A2A 3B 46 FE        	cmp	ax,[bp-2h]
2D1B:1A2D 7E 02           	jle	1A31h

l2D1B_1A2F:
2D1B:1A2F 46              	inc	si
2D1B:1A30 46              	inc	si

l2D1B_1A31:
2D1B:1A31 8B 46 FE        	mov	ax,[bp-2h]
2D1B:1A34 D1 E0           	shl	ax,1h
2D1B:1A36 3B 46 F0        	cmp	ax,[bp-10h]
2D1B:1A39 7D 02           	jge	1A3Dh

l2D1B_1A3B:
2D1B:1A3B 46              	inc	si
2D1B:1A3C 46              	inc	si

l2D1B_1A3D:
2D1B:1A3D 8B C7           	mov	ax,di
2D1B:1A3F BA 0F 00        	mov	dx,0Fh
2D1B:1A42 F7 E2           	mul	dx
2D1B:1A44 8B D8           	mov	bx,ax
2D1B:1A46 81 C3 35 04     	add	bx,435h
2D1B:1A4A 1E              	push	ds
2D1B:1A4B 07              	pop	es
2D1B:1A4C 26 8A 47 06     	mov	al,es:[bx+6h]
2D1B:1A50 98              	cbw
2D1B:1A51 3B 46 F0        	cmp	ax,[bp-10h]
2D1B:1A54 7C 1B           	jl	1A71h

l2D1B_1A56:
2D1B:1A56 8B C7           	mov	ax,di
2D1B:1A58 BA 0F 00        	mov	dx,0Fh
2D1B:1A5B F7 E2           	mul	dx
2D1B:1A5D 8B D8           	mov	bx,ax
2D1B:1A5F 81 C3 35 04     	add	bx,435h
2D1B:1A63 1E              	push	ds
2D1B:1A64 07              	pop	es
2D1B:1A65 26 8A 47 06     	mov	al,es:[bx+6h]
2D1B:1A69 98              	cbw
2D1B:1A6A 8B 56 F0        	mov	dx,[bp-10h]
2D1B:1A6D 2B D0           	sub	dx,ax
2D1B:1A6F 03 F2           	add	si,dx

l2D1B_1A71:
2D1B:1A71 8B 46 06        	mov	ax,[bp+6h]
2D1B:1A74 BA 96 00        	mov	dx,96h
2D1B:1A77 F7 E2           	mul	dx
2D1B:1A79 8B D8           	mov	bx,ax
2D1B:1A7B 81 C3 81 8B     	add	bx,8B81h
2D1B:1A7F 1E              	push	ds
2D1B:1A80 07              	pop	es
2D1B:1A81 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:1A86 25 FF 00        	and	ax,0FFh
2D1B:1A89 BB 05 00        	mov	bx,5h
2D1B:1A8C 33 D2           	xor	dx,dx
2D1B:1A8E F7 F3           	div	bx
2D1B:1A90 03 F0           	add	si,ax
2D1B:1A92 8B 5E 06        	mov	bx,[bp+6h]
2D1B:1A95 80 BF 27 88 00  	cmp	byte ptr [bx+8827h],0h
2D1B:1A9A 74 03           	jz	1A9Fh

l2D1B_1A9C:
2D1B:1A9C 83 C6 03        	add	si,3h

l2D1B_1A9F:
2D1B:1A9F 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2D1B:1AA3 74 12           	jz	1AB7h

l2D1B_1AA5:
2D1B:1AA5 8B 5E 0A        	mov	bx,[bp+0Ah]
2D1B:1AA8 8A 87 93 99     	mov	al,[bx+9993h]
2D1B:1AAC B4 00           	mov	ah,0h
2D1B:1AAE 8B D8           	mov	bx,ax
2D1B:1AB0 8A 87 65 A8     	mov	al,[bx+0A865h]
2D1B:1AB4 98              	cbw
2D1B:1AB5 03 F0           	add	si,ax

l2D1B_1AB7:
2D1B:1AB7 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2D1B:1ABB 74 0A           	jz	1AC7h

l2D1B_1ABD:
2D1B:1ABD 8B 5E 0A        	mov	bx,[bp+0Ah]
2D1B:1AC0 8A 87 27 88     	mov	al,[bx+8827h]
2D1B:1AC4 98              	cbw
2D1B:1AC5 03 F0           	add	si,ax

l2D1B_1AC7:
2D1B:1AC7 8B C7           	mov	ax,di
2D1B:1AC9 BA 0F 00        	mov	dx,0Fh
2D1B:1ACC F7 E2           	mul	dx
2D1B:1ACE 8B D8           	mov	bx,ax
2D1B:1AD0 81 C3 35 04     	add	bx,435h
2D1B:1AD4 1E              	push	ds
2D1B:1AD5 07              	pop	es
2D1B:1AD6 26 8A 47 0B     	mov	al,es:[bx+0Bh]
2D1B:1ADA 98              	cbw
2D1B:1ADB 89 46 F2        	mov	[bp-0Eh],ax
2D1B:1ADE 83 FE 0A        	cmp	si,0Ah
2D1B:1AE1 7E 03           	jle	1AE6h

l2D1B_1AE3:
2D1B:1AE3 BE 0A 00        	mov	si,0Ah

l2D1B_1AE6:
2D1B:1AE6 83 FE 0C        	cmp	si,0Ch
2D1B:1AE9 7E 03           	jle	1AEEh

l2D1B_1AEB:
2D1B:1AEB E9 AD 02        	jmp	1D9Bh

l2D1B_1AEE:
2D1B:1AEE C7 46 F8 01 00  	mov	word ptr [bp-8h],1h
2D1B:1AF3 83 7E F2 00     	cmp	word ptr [bp-0Eh],0h
2D1B:1AF7 74 22           	jz	1B1Bh

l2D1B_1AF9:
2D1B:1AF9 8B 46 06        	mov	ax,[bp+6h]
2D1B:1AFC BA 96 00        	mov	dx,96h
2D1B:1AFF F7 E2           	mul	dx
2D1B:1B01 8B D8           	mov	bx,ax
2D1B:1B03 81 C3 81 8B     	add	bx,8B81h
2D1B:1B07 1E              	push	ds
2D1B:1B08 07              	pop	es
2D1B:1B09 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:1B0C 48              	dec	ax
2D1B:1B0D D1 E0           	shl	ax,1h
2D1B:1B0F 03 D8           	add	bx,ax
2D1B:1B11 26 83 7F 38 00  	cmp	word ptr es:[bx+38h],0h
2D1B:1B16 75 03           	jnz	1B1Bh

l2D1B_1B18:
2D1B:1B18 E9 80 02        	jmp	1D9Bh

l2D1B_1B1B:
2D1B:1B1B 8B C7           	mov	ax,di
2D1B:1B1D BA 0F 00        	mov	dx,0Fh
2D1B:1B20 F7 E2           	mul	dx
2D1B:1B22 8B D8           	mov	bx,ax
2D1B:1B24 81 C3 35 04     	add	bx,435h
2D1B:1B28 1E              	push	ds
2D1B:1B29 07              	pop	es
2D1B:1B2A 26 8A 47 0D     	mov	al,es:[bx+0Dh]
2D1B:1B2E 50              	push	ax
2D1B:1B2F 8B 46 06        	mov	ax,[bp+6h]
2D1B:1B32 BA 17 00        	mov	dx,17h
2D1B:1B35 F7 E2           	mul	dx
2D1B:1B37 8B D8           	mov	bx,ax
2D1B:1B39 81 C3 29 89     	add	bx,8929h
2D1B:1B3D 1E              	push	ds
2D1B:1B3E 07              	pop	es
2D1B:1B3F 58              	pop	ax
2D1B:1B40 26 00 01        	add	es:[bx+di],al
2D1B:1B43 8B 46 06        	mov	ax,[bp+6h]
2D1B:1B46 BA 96 00        	mov	dx,96h
2D1B:1B49 F7 E2           	mul	dx
2D1B:1B4B 8B D8           	mov	bx,ax
2D1B:1B4D 81 C3 81 8B     	add	bx,8B81h
2D1B:1B51 1E              	push	ds
2D1B:1B52 07              	pop	es
2D1B:1B53 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:1B58 25 FF 00        	and	ax,0FFh
2D1B:1B5B 50              	push	ax
2D1B:1B5C 8B C7           	mov	ax,di
2D1B:1B5E BA 0F 00        	mov	dx,0Fh
2D1B:1B61 F7 E2           	mul	dx
2D1B:1B63 8B D8           	mov	bx,ax
2D1B:1B65 81 C3 35 04     	add	bx,435h
2D1B:1B69 1E              	push	ds
2D1B:1B6A 07              	pop	es
2D1B:1B6B 26 8A 47 04     	mov	al,es:[bx+4h]
2D1B:1B6F 98              	cbw
2D1B:1B70 8B D0           	mov	dx,ax
2D1B:1B72 58              	pop	ax
2D1B:1B73 03 C2           	add	ax,dx
2D1B:1B75 50              	push	ax
2D1B:1B76 8B 46 06        	mov	ax,[bp+6h]
2D1B:1B79 BA 96 00        	mov	dx,96h
2D1B:1B7C F7 E2           	mul	dx
2D1B:1B7E 8B D8           	mov	bx,ax
2D1B:1B80 81 C3 81 8B     	add	bx,8B81h
2D1B:1B84 1E              	push	ds
2D1B:1B85 07              	pop	es
2D1B:1B86 58              	pop	ax
2D1B:1B87 26 81 A7 87 00 00 FF 	and	word ptr es:[bx+87h],0FF00h
2D1B:1B8E 25 FF 00        	and	ax,0FFh
2D1B:1B91 26 09 87 87 00  	or	es:[bx+87h],ax
2D1B:1B96 83 7E F2 00     	cmp	word ptr [bp-0Eh],0h
2D1B:1B9A 74 1C           	jz	1BB8h

l2D1B_1B9C:
2D1B:1B9C 8B 46 06        	mov	ax,[bp+6h]
2D1B:1B9F BA 96 00        	mov	dx,96h
2D1B:1BA2 F7 E2           	mul	dx
2D1B:1BA4 8B D8           	mov	bx,ax
2D1B:1BA6 81 C3 81 8B     	add	bx,8B81h
2D1B:1BAA 1E              	push	ds
2D1B:1BAB 07              	pop	es
2D1B:1BAC 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:1BAF 48              	dec	ax
2D1B:1BB0 D1 E0           	shl	ax,1h
2D1B:1BB2 03 D8           	add	bx,ax
2D1B:1BB4 26 FF 4F 38     	dec	word ptr es:[bx+38h]

l2D1B_1BB8:
2D1B:1BB8 9A F4 1D 1B 2D  	call	far 2D1Bh:1DF4h
2D1B:1BBD 3B C6           	cmp	ax,si
2D1B:1BBF 7C 05           	jl	1BC6h

l2D1B_1BC1:
2D1B:1BC1 B8 01 00        	mov	ax,1h
2D1B:1BC4 EB 02           	jmp	1BC8h

l2D1B_1BC6:
2D1B:1BC6 33 C0           	xor	ax,ax

l2D1B_1BC8:
2D1B:1BC8 89 46 F6        	mov	[bp-0Ah],ax
2D1B:1BCB 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2D1B:1BCF 74 03           	jz	1BD4h

l2D1B_1BD1:
2D1B:1BD1 E9 84 00        	jmp	1C58h

l2D1B_1BD4:
2D1B:1BD4 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2D1B:1BD8 75 03           	jnz	1BDDh

l2D1B_1BDA:
2D1B:1BDA E9 7B 00        	jmp	1C58h

l2D1B_1BDD:
2D1B:1BDD 33 C0           	xor	ax,ax
2D1B:1BDF 50              	push	ax
2D1B:1BE0 B8 01 00        	mov	ax,1h
2D1B:1BE3 50              	push	ax
2D1B:1BE4 FF 76 EE        	push	word ptr [bp-12h]
2D1B:1BE7 FF 76 EC        	push	word ptr [bp-14h]
2D1B:1BEA 9A 6F 27 1B 2D  	call	far 2D1Bh:276Fh
2D1B:1BEF 83 C4 08        	add	sp,8h
2D1B:1BF2 FF 76 EE        	push	word ptr [bp-12h]
2D1B:1BF5 FF 76 EC        	push	word ptr [bp-14h]
2D1B:1BF8 9A F9 0C 1F 1A  	call	far 1A1Fh:0CF9h
2D1B:1BFD 59              	pop	cx
2D1B:1BFE 59              	pop	cx
2D1B:1BFF 3D 03 00        	cmp	ax,3h
2D1B:1C02 75 54           	jnz	1C58h

l2D1B_1C04:
2D1B:1C04 C7 46 EA 00 00  	mov	word ptr [bp-16h],0h
2D1B:1C09 EB 47           	jmp	1C52h

l2D1B_1C0B:
2D1B:1C0B 8B 46 EA        	mov	ax,[bp-16h]
2D1B:1C0E BA 96 00        	mov	dx,96h
2D1B:1C11 F7 E2           	mul	dx
2D1B:1C13 8B D8           	mov	bx,ax
2D1B:1C15 81 C3 81 8B     	add	bx,8B81h
2D1B:1C19 1E              	push	ds
2D1B:1C1A 07              	pop	es
2D1B:1C1B 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:1C1F 74 2E           	jz	1C4Fh

l2D1B_1C21:
2D1B:1C21 8B 5E EA        	mov	bx,[bp-16h]
2D1B:1C24 80 BF F3 88 18  	cmp	byte ptr [bx+88F3h],18h
2D1B:1C29 75 24           	jnz	1C4Fh

l2D1B_1C2B:
2D1B:1C2B 8B 5E EA        	mov	bx,[bp-16h]
2D1B:1C2E 8A 87 59 83     	mov	al,[bx+8359h]
2D1B:1C32 B4 00           	mov	ah,0h
2D1B:1C34 3B 46 EC        	cmp	ax,[bp-14h]
2D1B:1C37 75 16           	jnz	1C4Fh

l2D1B_1C39:
2D1B:1C39 8B 5E EA        	mov	bx,[bp-16h]
2D1B:1C3C 8A 87 A7 83     	mov	al,[bx+83A7h]
2D1B:1C40 B4 00           	mov	ah,0h
2D1B:1C42 3B 46 EE        	cmp	ax,[bp-12h]
2D1B:1C45 75 08           	jnz	1C4Fh

l2D1B_1C47:
2D1B:1C47 8B 5E EA        	mov	bx,[bp-16h]
2D1B:1C4A C6 87 F3 88 FF  	mov	byte ptr [bx+88F3h],0FFh

l2D1B_1C4F:
2D1B:1C4F FF 46 EA        	inc	word ptr [bp-16h]

l2D1B_1C52:
2D1B:1C52 83 7E EA 18     	cmp	word ptr [bp-16h],18h
2D1B:1C56 7C B3           	jl	1C0Bh

l2D1B_1C58:
2D1B:1C58 83 FF 08        	cmp	di,8h
2D1B:1C5B 7F 1A           	jg	1C77h

l2D1B_1C5D:
2D1B:1C5D 57              	push	di
2D1B:1C5E FF 76 F6        	push	word ptr [bp-0Ah]
2D1B:1C61 33 C0           	xor	ax,ax
2D1B:1C63 50              	push	ax
2D1B:1C64 FF 76 EE        	push	word ptr [bp-12h]
2D1B:1C67 FF 76 EC        	push	word ptr [bp-14h]
2D1B:1C6A FF 76 06        	push	word ptr [bp+6h]
2D1B:1C6D 9A 55 0D 1F 1A  	call	far 1A1Fh:0D55h
2D1B:1C72 83 C4 0C        	add	sp,0Ch
2D1B:1C75 EB 27           	jmp	1C9Eh

l2D1B_1C77:
2D1B:1C77 83 FF 0F        	cmp	di,0Fh
2D1B:1C7A 74 0A           	jz	1C86h

l2D1B_1C7C:
2D1B:1C7C 83 FF 09        	cmp	di,9h
2D1B:1C7F 7C 1D           	jl	1C9Eh

l2D1B_1C81:
2D1B:1C81 83 FF 0E        	cmp	di,0Eh
2D1B:1C84 7F 18           	jg	1C9Eh

l2D1B_1C86:
2D1B:1C86 57              	push	di
2D1B:1C87 FF 76 F6        	push	word ptr [bp-0Ah]
2D1B:1C8A 33 C0           	xor	ax,ax
2D1B:1C8C 50              	push	ax
2D1B:1C8D FF 76 EE        	push	word ptr [bp-12h]
2D1B:1C90 FF 76 EC        	push	word ptr [bp-14h]
2D1B:1C93 FF 76 06        	push	word ptr [bp+6h]
2D1B:1C96 9A 55 0D 1F 1A  	call	far 1A1Fh:0D55h
2D1B:1C9B 83 C4 0C        	add	sp,0Ch

l2D1B_1C9E:
2D1B:1C9E 83 FF 10        	cmp	di,10h
2D1B:1CA1 7D 03           	jge	1CA6h

l2D1B_1CA3:
2D1B:1CA3 E9 88 00        	jmp	1D2Eh

l2D1B_1CA6:
2D1B:1CA6 8B 46 06        	mov	ax,[bp+6h]
2D1B:1CA9 BA 96 00        	mov	dx,96h
2D1B:1CAC F7 E2           	mul	dx
2D1B:1CAE 8B D8           	mov	bx,ax
2D1B:1CB0 81 C3 81 8B     	add	bx,8B81h
2D1B:1CB4 1E              	push	ds
2D1B:1CB5 07              	pop	es
2D1B:1CB6 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2D1B:1CBC 75 59           	jnz	1D17h

l2D1B_1CBE:
2D1B:1CBE 8B 46 06        	mov	ax,[bp+6h]
2D1B:1CC1 BA 96 00        	mov	dx,96h
2D1B:1CC4 F7 E2           	mul	dx
2D1B:1CC6 8B D8           	mov	bx,ax
2D1B:1CC8 81 C3 81 8B     	add	bx,8B81h
2D1B:1CCC 1E              	push	ds
2D1B:1CCD 07              	pop	es
2D1B:1CCE 26 80 BF 8C 00 00 	cmp	byte ptr es:[bx+8Ch],0h
2D1B:1CD4 74 41           	jz	1D17h

l2D1B_1CD6:
2D1B:1CD6 C7 46 F6 00 00  	mov	word ptr [bp-0Ah],0h
2D1B:1CDB 8B 46 0A        	mov	ax,[bp+0Ah]
2D1B:1CDE BA 96 00        	mov	dx,96h
2D1B:1CE1 F7 E2           	mul	dx
2D1B:1CE3 8B D8           	mov	bx,ax
2D1B:1CE5 81 C3 81 8B     	add	bx,8B81h
2D1B:1CE9 1E              	push	ds
2D1B:1CEA 07              	pop	es
2D1B:1CEB 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:1CF0 25 FF 00        	and	ax,0FFh
2D1B:1CF3 05 1E 00        	add	ax,1Eh
2D1B:1CF6 50              	push	ax
2D1B:1CF7 8B 46 0A        	mov	ax,[bp+0Ah]
2D1B:1CFA BA 96 00        	mov	dx,96h
2D1B:1CFD F7 E2           	mul	dx
2D1B:1CFF 8B D8           	mov	bx,ax
2D1B:1D01 81 C3 81 8B     	add	bx,8B81h
2D1B:1D05 1E              	push	ds
2D1B:1D06 07              	pop	es
2D1B:1D07 58              	pop	ax
2D1B:1D08 26 81 A7 87 00 00 FF 	and	word ptr es:[bx+87h],0FF00h
2D1B:1D0F 25 FF 00        	and	ax,0FFh
2D1B:1D12 26 09 87 87 00  	or	es:[bx+87h],ax

l2D1B_1D17:
2D1B:1D17 FF 76 F6        	push	word ptr [bp-0Ah]
2D1B:1D1A FF 76 0A        	push	word ptr [bp+0Ah]
2D1B:1D1D 57              	push	di
2D1B:1D1E FF 76 06        	push	word ptr [bp+6h]
2D1B:1D21 9A A4 0A 07 20  	call	far 2007h:0AA4h
2D1B:1D26 83 C4 08        	add	sp,8h
2D1B:1D29 C7 46 F6 00 00  	mov	word ptr [bp-0Ah],0h

l2D1B_1D2E:
2D1B:1D2E 8B C7           	mov	ax,di
2D1B:1D30 BA 0F 00        	mov	dx,0Fh
2D1B:1D33 F7 E2           	mul	dx
2D1B:1D35 8B D8           	mov	bx,ax
2D1B:1D37 81 C3 35 04     	add	bx,435h
2D1B:1D3B 1E              	push	ds
2D1B:1D3C 07              	pop	es
2D1B:1D3D 26 8A 47 0E     	mov	al,es:[bx+0Eh]
2D1B:1D41 98              	cbw
2D1B:1D42 50              	push	ax
2D1B:1D43 9A 67 05 FB 31  	call	far 31FBh:0567h
2D1B:1D48 59              	pop	cx
2D1B:1D49 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2D1B:1D4D 74 4C           	jz	1D9Bh

l2D1B_1D4F:
2D1B:1D4F C7 46 F4 0A 00  	mov	word ptr [bp-0Ch],0Ah
2D1B:1D54 8B C7           	mov	ax,di
2D1B:1D56 BA 0F 00        	mov	dx,0Fh
2D1B:1D59 F7 E2           	mul	dx
2D1B:1D5B 8B D8           	mov	bx,ax
2D1B:1D5D 81 C3 35 04     	add	bx,435h
2D1B:1D61 1E              	push	ds
2D1B:1D62 07              	pop	es
2D1B:1D63 26 80 7F 05 03  	cmp	byte ptr es:[bx+5h],3h
2D1B:1D68 7E 05           	jle	1D6Fh

l2D1B_1D6A:
2D1B:1D6A C7 46 F4 01 00  	mov	word ptr [bp-0Ch],1h

l2D1B_1D6F:
2D1B:1D6F FF 76 F4        	push	word ptr [bp-0Ch]
2D1B:1D72 FF 76 EE        	push	word ptr [bp-12h]
2D1B:1D75 FF 76 EC        	push	word ptr [bp-14h]
2D1B:1D78 9A 46 08 07 20  	call	far 2007h:0846h
2D1B:1D7D 83 C4 06        	add	sp,6h
2D1B:1D80 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2D1B:1D84 7C 15           	jl	1D9Bh

l2D1B_1D86:
2D1B:1D86 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2D1B:1D8A 7D 0F           	jge	1D9Bh

l2D1B_1D8C:
2D1B:1D8C FF 76 0A        	push	word ptr [bp+0Ah]
2D1B:1D8F 57              	push	di
2D1B:1D90 FF 76 06        	push	word ptr [bp+6h]
2D1B:1D93 9A 2B 1E 1B 2D  	call	far 2D1Bh:1E2Bh
2D1B:1D98 83 C4 06        	add	sp,6h

l2D1B_1D9B:
2D1B:1D9B 8B 46 F8        	mov	ax,[bp-8h]
2D1B:1D9E EB 00           	jmp	1DA0h

l2D1B_1DA0:
2D1B:1DA0 5F              	pop	di
2D1B:1DA1 5E              	pop	si
2D1B:1DA2 8B E5           	mov	sp,bp
2D1B:1DA4 5D              	pop	bp
2D1B:1DA5 CB              	retf

;; HasUnitLineOfSight_1DA6: 2D1B:1DA6
;;   Called from:
;;     2208:1D33 (in UpdateUnitEnemyVisibility_1CCC)
;;     2B34:0547 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:1062 (in PrepareDisplayedUnitCombatRatings_1014)
;;     2D1B:18D8 (in ResolveWeaponAttack_1854)
;;     2D1B:195D (in ResolveWeaponAttack_1854)
HasUnitLineOfSight_1DA6 proc
2D1B:1DA6 55              	push	bp
2D1B:1DA7 8B EC           	mov	bp,sp
2D1B:1DA9 FF 36 C0 86     	push	word ptr [86C0h]
2D1B:1DAD FF 36 BE 86     	push	word ptr [86BEh]
2D1B:1DB1 FF 36 9E 84     	push	word ptr [849Eh]
2D1B:1DB5 FF 36 5D 85     	push	word ptr [855Dh]
2D1B:1DB9 FF 36 EC 83     	push	word ptr [83ECh]
2D1B:1DBD FF 36 EA 83     	push	word ptr [83EAh]
2D1B:1DC1 8B 5E 08        	mov	bx,[bp+8h]
2D1B:1DC4 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:1DC8 B4 00           	mov	ah,0h
2D1B:1DCA 50              	push	ax
2D1B:1DCB 8B 5E 08        	mov	bx,[bp+8h]
2D1B:1DCE 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:1DD2 B4 00           	mov	ah,0h
2D1B:1DD4 50              	push	ax
2D1B:1DD5 8B 5E 06        	mov	bx,[bp+6h]
2D1B:1DD8 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:1DDC B4 00           	mov	ah,0h
2D1B:1DDE 50              	push	ax
2D1B:1DDF 8B 5E 06        	mov	bx,[bp+6h]
2D1B:1DE2 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:1DE6 B4 00           	mov	ah,0h
2D1B:1DE8 50              	push	ax
2D1B:1DE9 9A 8C 07 00 08  	call	far 0800h:078Ch
2D1B:1DEE 8B E5           	mov	sp,bp
2D1B:1DF0 EB 00           	jmp	1DF2h

l2D1B_1DF2:
2D1B:1DF2 5D              	pop	bp
2D1B:1DF3 CB              	retf

;; Roll2D6_1DF4: 2D1B:1DF4
;;   Called from:
;;     2D1B:1BB8 (in ResolveWeaponAttack_1854)
;;     2D1B:1F50 (in ApplyWeaponDamage_1E2B)
;;     2D1B:2049 (in ApplyWeaponDamage_1E2B)
;;     2D1B:209B (in ApplyWeaponDamage_1E2B)
;;     2D1B:20E4 (in ApplyWeaponDamage_1E2B)
;;     2D1B:20ED (in ApplyWeaponDamage_1E2B)
;;     2D1B:25A8 (in UpdateUnitHeatShutdown_256B)
Roll2D6_1DF4 proc
2D1B:1DF4 56              	push	si
2D1B:1DF5 57              	push	di

l2D1B_1DF6:
2D1B:1DF6 9A 46 4D 00 08  	call	far 0800h:4D46h
2D1B:1DFB B4 00           	mov	ah,0h
2D1B:1DFD 8B F8           	mov	di,ax
2D1B:1DFF 81 E7 07 00     	and	di,7h
2D1B:1E03 83 FF 06        	cmp	di,6h
2D1B:1E06 7F EE           	jg	1DF6h

l2D1B_1E08:
2D1B:1E08 0B FF           	or	di,di
2D1B:1E0A 74 EA           	jz	1DF6h

l2D1B_1E0C:
2D1B:1E0C 9A 46 4D 00 08  	call	far 0800h:4D46h
2D1B:1E11 B4 00           	mov	ah,0h
2D1B:1E13 8B F0           	mov	si,ax
2D1B:1E15 81 E6 07 00     	and	si,7h
2D1B:1E19 83 FE 06        	cmp	si,6h
2D1B:1E1C 7F EE           	jg	1E0Ch

l2D1B_1E1E:
2D1B:1E1E 0B F6           	or	si,si
2D1B:1E20 74 EA           	jz	1E0Ch

l2D1B_1E22:
2D1B:1E22 8B C7           	mov	ax,di
2D1B:1E24 03 C6           	add	ax,si
2D1B:1E26 EB 00           	jmp	1E28h

l2D1B_1E28:
2D1B:1E28 5F              	pop	di
2D1B:1E29 5E              	pop	si
2D1B:1E2A CB              	retf

;; ApplyWeaponDamage_1E2B: 2D1B:1E2B
;;   Called from:
;;     2007:0D7C (in ApplyAreaTerrainAndUnitDamage_0CFB)
;;     2007:199C (in AdvanceTacticalProjectiles_17DE)
;;     2D1B:1D93 (in ResolveWeaponAttack_1854)
ApplyWeaponDamage_1E2B proc
2D1B:1E2B 55              	push	bp
2D1B:1E2C 8B EC           	mov	bp,sp
2D1B:1E2E 83 EC 18        	sub	sp,18h
2D1B:1E31 56              	push	si
2D1B:1E32 57              	push	di
2D1B:1E33 8B 76 0A        	mov	si,[bp+0Ah]
2D1B:1E36 C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2D1B:1E3B 0B F6           	or	si,si
2D1B:1E3D 75 0C           	jnz	1E4Bh

l2D1B_1E3F:
2D1B:1E3F 83 3E D7 A9 00  	cmp	word ptr [0A9D7h],0h
2D1B:1E44 74 05           	jz	1E4Bh

l2D1B_1E46:
2D1B:1E46 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h

l2D1B_1E4B:
2D1B:1E4B 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2D1B:1E4F 75 03           	jnz	1E54h

l2D1B_1E51:
2D1B:1E51 E9 52 05        	jmp	23A6h

l2D1B_1E54:
2D1B:1E54 0B F6           	or	si,si
2D1B:1E56 7D 03           	jge	1E5Bh

l2D1B_1E58:
2D1B:1E58 E9 4B 05        	jmp	23A6h

l2D1B_1E5B:
2D1B:1E5B 83 FE 18        	cmp	si,18h
2D1B:1E5E 7C 03           	jl	1E63h

l2D1B_1E60:
2D1B:1E60 E9 43 05        	jmp	23A6h

l2D1B_1E63:
2D1B:1E63 8B C6           	mov	ax,si
2D1B:1E65 BA 96 00        	mov	dx,96h
2D1B:1E68 F7 E2           	mul	dx
2D1B:1E6A 8B D8           	mov	bx,ax
2D1B:1E6C 81 C3 81 8B     	add	bx,8B81h
2D1B:1E70 1E              	push	ds
2D1B:1E71 07              	pop	es
2D1B:1E72 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:1E76 75 03           	jnz	1E7Bh

l2D1B_1E78:
2D1B:1E78 E9 2B 05        	jmp	23A6h

l2D1B_1E7B:
2D1B:1E7B 83 FE 0C        	cmp	si,0Ch
2D1B:1E7E 7D 12           	jge	1E92h

l2D1B_1E80:
2D1B:1E80 1E              	push	ds
2D1B:1E81 8B C6           	mov	ax,si
2D1B:1E83 BA 96 00        	mov	dx,96h
2D1B:1E86 F7 E2           	mul	dx
2D1B:1E88 05 81 8B        	add	ax,8B81h
2D1B:1E8B 50              	push	ax
2D1B:1E8C 0E              	push	cs
2D1B:1E8D E8 E9 E4        	call	0379h
2D1B:1E90 59              	pop	cx
2D1B:1E91 59              	pop	cx

l2D1B_1E92:
2D1B:1E92 A1 3E 83        	mov	ax,[833Eh]
2D1B:1E95 89 46 FC        	mov	[bp-4h],ax
2D1B:1E98 8B 46 08        	mov	ax,[bp+8h]
2D1B:1E9B BA 0F 00        	mov	dx,0Fh
2D1B:1E9E F7 E2           	mul	dx
2D1B:1EA0 8B D8           	mov	bx,ax
2D1B:1EA2 81 C3 35 04     	add	bx,435h
2D1B:1EA6 1E              	push	ds
2D1B:1EA7 07              	pop	es
2D1B:1EA8 26 8A 47 05     	mov	al,es:[bx+5h]
2D1B:1EAC 98              	cbw
2D1B:1EAD 89 46 F4        	mov	[bp-0Ch],ax
2D1B:1EB0 83 7E 08 10     	cmp	word ptr [bp+8h],10h
2D1B:1EB4 7C 23           	jl	1ED9h

l2D1B_1EB6:
2D1B:1EB6 8B 46 06        	mov	ax,[bp+6h]
2D1B:1EB9 BA 96 00        	mov	dx,96h
2D1B:1EBC F7 E2           	mul	dx
2D1B:1EBE 8B D8           	mov	bx,ax
2D1B:1EC0 81 C3 81 8B     	add	bx,8B81h
2D1B:1EC4 1E              	push	ds
2D1B:1EC5 07              	pop	es
2D1B:1EC6 26 80 BF 8C 00 00 	cmp	byte ptr es:[bx+8Ch],0h
2D1B:1ECC 74 0B           	jz	1ED9h

l2D1B_1ECE:
2D1B:1ECE 8B 5E 08        	mov	bx,[bp+8h]
2D1B:1ED1 8A 87 0D 3D     	mov	al,[bx+3D0Dh]
2D1B:1ED5 98              	cbw
2D1B:1ED6 01 46 F4        	add	[bp-0Ch],ax

l2D1B_1ED9:
2D1B:1ED9 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:1EDD B4 00           	mov	ah,0h
2D1B:1EDF 50              	push	ax
2D1B:1EE0 8A 84 62 85     	mov	al,[si+8562h]
2D1B:1EE4 B4 00           	mov	ah,0h
2D1B:1EE6 50              	push	ax
2D1B:1EE7 8B 5E 06        	mov	bx,[bp+6h]
2D1B:1EEA 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:1EEE B4 00           	mov	ah,0h
2D1B:1EF0 50              	push	ax
2D1B:1EF1 8B 5E 06        	mov	bx,[bp+6h]
2D1B:1EF4 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:1EF8 B4 00           	mov	ah,0h
2D1B:1EFA 50              	push	ax
2D1B:1EFB 9A D1 06 00 08  	call	far 0800h:06D1h
2D1B:1F00 83 C4 08        	add	sp,8h
2D1B:1F03 89 46 EE        	mov	[bp-12h],ax
2D1B:1F06 83 7E EE 08     	cmp	word ptr [bp-12h],8h
2D1B:1F0A 7D 06           	jge	1F12h

l2D1B_1F0C:
2D1B:1F0C 83 7E EE 00     	cmp	word ptr [bp-12h],0h
2D1B:1F10 7D 05           	jge	1F17h

l2D1B_1F12:
2D1B:1F12 C7 46 EE 00 00  	mov	word ptr [bp-12h],0h

l2D1B_1F17:
2D1B:1F17 BB 08 00        	mov	bx,8h
2D1B:1F1A 2B 5E EE        	sub	bx,[bp-12h]
2D1B:1F1D 8A 84 9A 86     	mov	al,[si+869Ah]
2D1B:1F21 98              	cbw
2D1B:1F22 03 D8           	add	bx,ax
2D1B:1F24 D1 E3           	shl	bx,1h
2D1B:1F26 8B 87 FE 3C     	mov	ax,[bx+3CFEh]
2D1B:1F2A 89 46 F2        	mov	[bp-0Eh],ax
2D1B:1F2D 8B C6           	mov	ax,si
2D1B:1F2F BA 96 00        	mov	dx,96h
2D1B:1F32 F7 E2           	mul	dx
2D1B:1F34 8B D8           	mov	bx,ax
2D1B:1F36 81 C3 81 8B     	add	bx,8B81h
2D1B:1F3A 1E              	push	ds
2D1B:1F3B 07              	pop	es
2D1B:1F3C 26 80 BF 95 00 03 	cmp	byte ptr es:[bx+95h],3h
2D1B:1F42 75 05           	jnz	1F49h

l2D1B_1F44:
2D1B:1F44 C7 46 F2 04 00  	mov	word ptr [bp-0Eh],4h

l2D1B_1F49:
2D1B:1F49 C7 46 F0 00 00  	mov	word ptr [bp-10h],0h
2D1B:1F4E EB 59           	jmp	1FA9h

l2D1B_1F50:
2D1B:1F50 0E              	push	cs
2D1B:1F51 E8 A0 FE        	call	1DF4h
2D1B:1F54 05 FE FF        	add	ax,0FFFEh
2D1B:1F57 D1 E0           	shl	ax,1h
2D1B:1F59 50              	push	ax
2D1B:1F5A 8B 46 F2        	mov	ax,[bp-0Eh]
2D1B:1F5D BA 18 00        	mov	dx,18h
2D1B:1F60 F7 E2           	mul	dx
2D1B:1F62 8B D8           	mov	bx,ax
2D1B:1F64 81 C3 38 10     	add	bx,1038h
2D1B:1F68 1E              	push	ds
2D1B:1F69 07              	pop	es
2D1B:1F6A 58              	pop	ax
2D1B:1F6B 03 D8           	add	bx,ax
2D1B:1F6D 26 8B 3F        	mov	di,es:[bx]
2D1B:1F70 8B C6           	mov	ax,si
2D1B:1F72 BA 96 00        	mov	dx,96h
2D1B:1F75 F7 E2           	mul	dx
2D1B:1F77 8B D8           	mov	bx,ax
2D1B:1F79 81 C3 81 8B     	add	bx,8B81h
2D1B:1F7D 1E              	push	ds
2D1B:1F7E 07              	pop	es
2D1B:1F7F 03 DF           	add	bx,di
2D1B:1F81 26 8A 47 04     	mov	al,es:[bx+4h]
2D1B:1F85 98              	cbw
2D1B:1F86 89 46 F0        	mov	[bp-10h],ax
2D1B:1F89 83 FF 08        	cmp	di,8h
2D1B:1F8C 7C 1B           	jl	1FA9h

l2D1B_1F8E:
2D1B:1F8E 8B C6           	mov	ax,si
2D1B:1F90 BA 96 00        	mov	dx,96h
2D1B:1F93 F7 E2           	mul	dx
2D1B:1F95 8B D8           	mov	bx,ax
2D1B:1F97 81 C3 81 8B     	add	bx,8B81h
2D1B:1F9B 1E              	push	ds
2D1B:1F9C 07              	pop	es
2D1B:1F9D 03 DF           	add	bx,di
2D1B:1F9F 83 C3 FE        	add	bx,0FEh
2D1B:1FA2 26 8A 07        	mov	al,es:[bx]
2D1B:1FA5 98              	cbw
2D1B:1FA6 89 46 F0        	mov	[bp-10h],ax

l2D1B_1FA9:
2D1B:1FA9 83 7E F0 00     	cmp	word ptr [bp-10h],0h
2D1B:1FAD 74 A1           	jz	1F50h

l2D1B_1FAF:
2D1B:1FAF 0B F6           	or	si,si
2D1B:1FB1 75 06           	jnz	1FB9h

l2D1B_1FB3:
2D1B:1FB3 8B 46 06        	mov	ax,[bp+6h]
2D1B:1FB6 A3 65 A9        	mov	[0A965h],ax

l2D1B_1FB9:
2D1B:1FB9 C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h
2D1B:1FBE 8B C6           	mov	ax,si
2D1B:1FC0 BA 96 00        	mov	dx,96h
2D1B:1FC3 F7 E2           	mul	dx
2D1B:1FC5 8B D8           	mov	bx,ax
2D1B:1FC7 81 C3 81 8B     	add	bx,8B81h
2D1B:1FCB 1E              	push	ds
2D1B:1FCC 07              	pop	es
2D1B:1FCD 03 DF           	add	bx,di
2D1B:1FCF 26 80 7F 0C 00  	cmp	byte ptr es:[bx+0Ch],0h
2D1B:1FD4 75 03           	jnz	1FD9h

l2D1B_1FD6:
2D1B:1FD6 E9 92 00        	jmp	206Bh

l2D1B_1FD9:
2D1B:1FD9 C7 46 F6 00 00  	mov	word ptr [bp-0Ah],0h
2D1B:1FDE 8B C6           	mov	ax,si
2D1B:1FE0 BA 96 00        	mov	dx,96h
2D1B:1FE3 F7 E2           	mul	dx
2D1B:1FE5 8B D8           	mov	bx,ax
2D1B:1FE7 81 C3 81 8B     	add	bx,8B81h
2D1B:1FEB 1E              	push	ds
2D1B:1FEC 07              	pop	es
2D1B:1FED 03 DF           	add	bx,di
2D1B:1FEF 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2D1B:1FF3 98              	cbw
2D1B:1FF4 3B 46 F4        	cmp	ax,[bp-0Ch]
2D1B:1FF7 7D 36           	jge	202Fh

l2D1B_1FF9:
2D1B:1FF9 8B C6           	mov	ax,si
2D1B:1FFB BA 96 00        	mov	dx,96h
2D1B:1FFE F7 E2           	mul	dx
2D1B:2000 8B D8           	mov	bx,ax
2D1B:2002 81 C3 81 8B     	add	bx,8B81h
2D1B:2006 1E              	push	ds
2D1B:2007 07              	pop	es
2D1B:2008 03 DF           	add	bx,di
2D1B:200A 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2D1B:200E 98              	cbw
2D1B:200F 29 46 F4        	sub	[bp-0Ch],ax
2D1B:2012 8B C6           	mov	ax,si
2D1B:2014 BA 96 00        	mov	dx,96h
2D1B:2017 F7 E2           	mul	dx
2D1B:2019 8B D8           	mov	bx,ax
2D1B:201B 81 C3 81 8B     	add	bx,8B81h
2D1B:201F 1E              	push	ds
2D1B:2020 07              	pop	es
2D1B:2021 03 DF           	add	bx,di
2D1B:2023 26 C6 47 0C 00  	mov	byte ptr es:[bx+0Ch],0h
2D1B:2028 C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h
2D1B:202D EB 1A           	jmp	2049h

l2D1B_202F:
2D1B:202F 8A 46 F4        	mov	al,[bp-0Ch]
2D1B:2032 50              	push	ax
2D1B:2033 8B C6           	mov	ax,si
2D1B:2035 BA 96 00        	mov	dx,96h
2D1B:2038 F7 E2           	mul	dx
2D1B:203A 8B D8           	mov	bx,ax
2D1B:203C 81 C3 81 8B     	add	bx,8B81h
2D1B:2040 1E              	push	ds
2D1B:2041 07              	pop	es
2D1B:2042 03 DF           	add	bx,di
2D1B:2044 58              	pop	ax
2D1B:2045 26 28 47 0C     	sub	es:[bx+0Ch],al

l2D1B_2049:
2D1B:2049 0E              	push	cs
2D1B:204A E8 A7 FD        	call	1DF4h
2D1B:204D 3D 0C 00        	cmp	ax,0Ch
2D1B:2050 75 19           	jnz	206Bh

l2D1B_2052:
2D1B:2052 83 FF 08        	cmp	di,8h
2D1B:2055 7D 14           	jge	206Bh

l2D1B_2057:
2D1B:2057 83 FF 02        	cmp	di,2h
2D1B:205A 7C 05           	jl	2061h

l2D1B_205C:
2D1B:205C 83 FF 04        	cmp	di,4h
2D1B:205F 7E 0A           	jle	206Bh

l2D1B_2061:
2D1B:2061 C7 46 F4 64 00  	mov	word ptr [bp-0Ch],64h
2D1B:2066 C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h

l2D1B_206B:
2D1B:206B 83 FF 08        	cmp	di,8h
2D1B:206E 7C 03           	jl	2073h

l2D1B_2070:
2D1B:2070 83 EF 06        	sub	di,6h

l2D1B_2073:
2D1B:2073 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2D1B:2077 75 03           	jnz	207Ch

l2D1B_2079:
2D1B:2079 E9 C7 02        	jmp	2343h

l2D1B_207C:
2D1B:207C 8B C6           	mov	ax,si
2D1B:207E BA 96 00        	mov	dx,96h
2D1B:2081 F7 E2           	mul	dx
2D1B:2083 8B D8           	mov	bx,ax
2D1B:2085 81 C3 81 8B     	add	bx,8B81h
2D1B:2089 1E              	push	ds
2D1B:208A 07              	pop	es
2D1B:208B 03 DF           	add	bx,di
2D1B:208D 26 80 7F 04 00  	cmp	byte ptr es:[bx+4h],0h
2D1B:2092 75 03           	jnz	2097h

l2D1B_2094:
2D1B:2094 E9 AC 02        	jmp	2343h

l2D1B_2097:
2D1B:2097 0B FF           	or	di,di
2D1B:2099 75 44           	jnz	20DFh

l2D1B_209B:
2D1B:209B 0E              	push	cs
2D1B:209C E8 55 FD        	call	1DF4h
2D1B:209F 3D 08 00        	cmp	ax,8h
2D1B:20A2 7C 3B           	jl	20DFh

l2D1B_20A4:
2D1B:20A4 9A 46 4D 00 08  	call	far 0800h:4D46h
2D1B:20A9 A8 01           	test	al,1h
2D1B:20AB 74 2D           	jz	20DAh

l2D1B_20AD:
2D1B:20AD 8B C6           	mov	ax,si
2D1B:20AF BA 96 00        	mov	dx,96h
2D1B:20B2 F7 E2           	mul	dx
2D1B:20B4 8B D8           	mov	bx,ax
2D1B:20B6 81 C3 81 8B     	add	bx,8B81h
2D1B:20BA 1E              	push	ds
2D1B:20BB 07              	pop	es
2D1B:20BC 26 80 BF 89 00 02 	cmp	byte ptr es:[bx+89h],2h
2D1B:20C2 7D 14           	jge	20D8h

l2D1B_20C4:
2D1B:20C4 8B C6           	mov	ax,si
2D1B:20C6 BA 96 00        	mov	dx,96h
2D1B:20C9 F7 E2           	mul	dx
2D1B:20CB 8B D8           	mov	bx,ax
2D1B:20CD 81 C3 81 8B     	add	bx,8B81h
2D1B:20D1 1E              	push	ds
2D1B:20D2 07              	pop	es
2D1B:20D3 26 FE 87 89 00  	inc	byte ptr es:[bx+89h]

l2D1B_20D8:
2D1B:20D8 EB 05           	jmp	20DFh

l2D1B_20DA:
2D1B:20DA C7 46 F4 64 00  	mov	word ptr [bp-0Ch],64h

l2D1B_20DF:
2D1B:20DF 83 FF 03        	cmp	di,3h
2D1B:20E2 75 34           	jnz	2118h

l2D1B_20E4:
2D1B:20E4 0E              	push	cs
2D1B:20E5 E8 0C FD        	call	1DF4h
2D1B:20E8 3D 08 00        	cmp	ax,8h
2D1B:20EB 7C 2B           	jl	2118h

l2D1B_20ED:
2D1B:20ED 0E              	push	cs
2D1B:20EE E8 03 FD        	call	1DF4h
2D1B:20F1 3D 07 00        	cmp	ax,7h
2D1B:20F4 7D 22           	jge	2118h

l2D1B_20F6:
2D1B:20F6 8B C6           	mov	ax,si
2D1B:20F8 BA 96 00        	mov	dx,96h
2D1B:20FB F7 E2           	mul	dx
2D1B:20FD 8B D8           	mov	bx,ax
2D1B:20FF 81 C3 81 8B     	add	bx,8B81h
2D1B:2103 1E              	push	ds
2D1B:2104 07              	pop	es
2D1B:2105 26 FE 87 85 00  	inc	byte ptr es:[bx+85h]
2D1B:210A 26 8A 87 85 00  	mov	al,es:[bx+85h]
2D1B:210F 3C 03           	cmp	al,3h
2D1B:2111 7C 05           	jl	2118h

l2D1B_2113:
2D1B:2113 C7 46 F4 64 00  	mov	word ptr [bp-0Ch],64h

l2D1B_2118:
2D1B:2118 8B C6           	mov	ax,si
2D1B:211A BA 96 00        	mov	dx,96h
2D1B:211D F7 E2           	mul	dx
2D1B:211F 8B D8           	mov	bx,ax
2D1B:2121 81 C3 81 8B     	add	bx,8B81h
2D1B:2125 1E              	push	ds
2D1B:2126 07              	pop	es
2D1B:2127 03 DF           	add	bx,di
2D1B:2129 26 8A 47 04     	mov	al,es:[bx+4h]
2D1B:212D 98              	cbw
2D1B:212E 3B 46 F4        	cmp	ax,[bp-0Ch]
2D1B:2131 7E 03           	jle	2136h

l2D1B_2133:
2D1B:2133 E9 F3 01        	jmp	2329h

l2D1B_2136:
2D1B:2136 33 C0           	xor	ax,ax
2D1B:2138 89 46 FA        	mov	[bp-6h],ax
2D1B:213B 50              	push	ax
2D1B:213C 8B C6           	mov	ax,si
2D1B:213E BA 96 00        	mov	dx,96h
2D1B:2141 F7 E2           	mul	dx
2D1B:2143 8B D8           	mov	bx,ax
2D1B:2145 81 C3 81 8B     	add	bx,8B81h
2D1B:2149 1E              	push	ds
2D1B:214A 07              	pop	es
2D1B:214B 03 DF           	add	bx,di
2D1B:214D 58              	pop	ax
2D1B:214E 26 88 47 04     	mov	es:[bx+4h],al
2D1B:2152 8B C7           	mov	ax,di
2D1B:2154 3D 07 00        	cmp	ax,7h
2D1B:2157 76 03           	jbe	215Ch

l2D1B_2159:
2D1B:2159 E9 74 01        	jmp	22D0h

l2D1B_215C:
2D1B:215C 8B D8           	mov	bx,ax
2D1B:215E D1 E3           	shl	bx,1h
2D1B:2160 2E FF A7 65 21  	jmp	word ptr cs:[bx+2165h]
;; Code vector at 2D1B:2165 (16 bytes)
	2D1B:2175
	2D1B:2199
	2D1B:21B9
	2D1B:21D9
	2D1B:21FE
	2D1B:221E
	2D1B:223E
	2D1B:2287
2D1B:2165                75 21 99 21 B9 21 D9 21 FE 21 1E      u!.!.!.!.!.
2D1B:2170 22 3E 22 87 22                                  ">"."           

l2D1B_2175:
2D1B:2175 8B C6           	mov	ax,si
2D1B:2177 BA 96 00        	mov	dx,96h
2D1B:217A F7 E2           	mul	dx
2D1B:217C 8B D8           	mov	bx,ax
2D1B:217E 81 C3 81 8B     	add	bx,8B81h
2D1B:2182 1E              	push	ds
2D1B:2183 07              	pop	es
2D1B:2184 83 C3 55        	add	bx,55h
2D1B:2187 8C 46 EA        	mov	[bp-16h],es
2D1B:218A 89 5E E8        	mov	[bp-18h],bx
2D1B:218D B8 01 00        	mov	ax,1h
2D1B:2190 89 46 FA        	mov	[bp-6h],ax
2D1B:2193 89 46 F8        	mov	[bp-8h],ax
2D1B:2196 E9 37 01        	jmp	22D0h

l2D1B_2199:
2D1B:2199 8B C6           	mov	ax,si
2D1B:219B BA 96 00        	mov	dx,96h
2D1B:219E F7 E2           	mul	dx
2D1B:21A0 8B D8           	mov	bx,ax
2D1B:21A2 81 C3 81 8B     	add	bx,8B81h
2D1B:21A6 1E              	push	ds
2D1B:21A7 07              	pop	es
2D1B:21A8 83 C3 56        	add	bx,56h
2D1B:21AB 8C 46 EA        	mov	[bp-16h],es
2D1B:21AE 89 5E E8        	mov	[bp-18h],bx
2D1B:21B1 C7 46 F8 08 00  	mov	word ptr [bp-8h],8h
2D1B:21B6 E9 17 01        	jmp	22D0h

l2D1B_21B9:
2D1B:21B9 8B C6           	mov	ax,si
2D1B:21BB BA 96 00        	mov	dx,96h
2D1B:21BE F7 E2           	mul	dx
2D1B:21C0 8B D8           	mov	bx,ax
2D1B:21C2 81 C3 81 8B     	add	bx,8B81h
2D1B:21C6 1E              	push	ds
2D1B:21C7 07              	pop	es
2D1B:21C8 83 C3 5E        	add	bx,5Eh
2D1B:21CB 8C 46 EA        	mov	[bp-16h],es
2D1B:21CE 89 5E E8        	mov	[bp-18h],bx
2D1B:21D1 C7 46 F8 0C 00  	mov	word ptr [bp-8h],0Ch
2D1B:21D6 E9 F7 00        	jmp	22D0h

l2D1B_21D9:
2D1B:21D9 8B C6           	mov	ax,si
2D1B:21DB BA 96 00        	mov	dx,96h
2D1B:21DE F7 E2           	mul	dx
2D1B:21E0 8B D8           	mov	bx,ax
2D1B:21E2 81 C3 81 8B     	add	bx,8B81h
2D1B:21E6 1E              	push	ds
2D1B:21E7 07              	pop	es
2D1B:21E8 83 C3 6A        	add	bx,6Ah
2D1B:21EB 8C 46 EA        	mov	[bp-16h],es
2D1B:21EE 89 5E E8        	mov	[bp-18h],bx
2D1B:21F1 C7 46 F8 02 00  	mov	word ptr [bp-8h],2h
2D1B:21F6 C7 46 FA 01 00  	mov	word ptr [bp-6h],1h
2D1B:21FB E9 D2 00        	jmp	22D0h

l2D1B_21FE:
2D1B:21FE 8B C6           	mov	ax,si
2D1B:2200 BA 96 00        	mov	dx,96h
2D1B:2203 F7 E2           	mul	dx
2D1B:2205 8B D8           	mov	bx,ax
2D1B:2207 81 C3 81 8B     	add	bx,8B81h
2D1B:220B 1E              	push	ds
2D1B:220C 07              	pop	es
2D1B:220D 83 C3 6C        	add	bx,6Ch
2D1B:2210 8C 46 EA        	mov	[bp-16h],es
2D1B:2213 89 5E E8        	mov	[bp-18h],bx
2D1B:2216 C7 46 F8 0C 00  	mov	word ptr [bp-8h],0Ch
2D1B:221B E9 B2 00        	jmp	22D0h

l2D1B_221E:
2D1B:221E 8B C6           	mov	ax,si
2D1B:2220 BA 96 00        	mov	dx,96h
2D1B:2223 F7 E2           	mul	dx
2D1B:2225 8B D8           	mov	bx,ax
2D1B:2227 81 C3 81 8B     	add	bx,8B81h
2D1B:222B 1E              	push	ds
2D1B:222C 07              	pop	es
2D1B:222D 83 C3 78        	add	bx,78h
2D1B:2230 8C 46 EA        	mov	[bp-16h],es
2D1B:2233 89 5E E8        	mov	[bp-18h],bx
2D1B:2236 C7 46 F8 08 00  	mov	word ptr [bp-8h],8h
2D1B:223B E9 92 00        	jmp	22D0h

l2D1B_223E:
2D1B:223E 8B C6           	mov	ax,si
2D1B:2240 BA 96 00        	mov	dx,96h
2D1B:2243 F7 E2           	mul	dx
2D1B:2245 8B D8           	mov	bx,ax
2D1B:2247 81 C3 81 8B     	add	bx,8B81h
2D1B:224B 1E              	push	ds
2D1B:224C 07              	pop	es
2D1B:224D 81 C3 80 00     	add	bx,80h
2D1B:2251 8C 46 EA        	mov	[bp-16h],es
2D1B:2254 89 5E E8        	mov	[bp-18h],bx
2D1B:2257 B0 00           	mov	al,0h
2D1B:2259 88 84 27 88     	mov	[si+8827h],al
2D1B:225D 50              	push	ax
2D1B:225E 8B C6           	mov	ax,si
2D1B:2260 BA 96 00        	mov	dx,96h
2D1B:2263 F7 E2           	mul	dx
2D1B:2265 8B D8           	mov	bx,ax
2D1B:2267 81 C3 81 8B     	add	bx,8B81h
2D1B:226B 1E              	push	ds
2D1B:226C 07              	pop	es
2D1B:226D 58              	pop	ax
2D1B:226E 26 88 47 02     	mov	es:[bx+2h],al
2D1B:2272 C7 46 F8 02 00  	mov	word ptr [bp-8h],2h
2D1B:2277 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:227B 75 08           	jnz	2285h

l2D1B_227D:
2D1B:227D 9A B4 2C 1B 2D  	call	far 2D1Bh:2CB4h
2D1B:2282 89 46 FA        	mov	[bp-6h],ax

l2D1B_2285:
2D1B:2285 EB 49           	jmp	22D0h

l2D1B_2287:
2D1B:2287 8B C6           	mov	ax,si
2D1B:2289 BA 96 00        	mov	dx,96h
2D1B:228C F7 E2           	mul	dx
2D1B:228E 8B D8           	mov	bx,ax
2D1B:2290 81 C3 81 8B     	add	bx,8B81h
2D1B:2294 1E              	push	ds
2D1B:2295 07              	pop	es
2D1B:2296 81 C3 82 00     	add	bx,82h
2D1B:229A 8C 46 EA        	mov	[bp-16h],es
2D1B:229D 89 5E E8        	mov	[bp-18h],bx
2D1B:22A0 B0 00           	mov	al,0h
2D1B:22A2 88 84 27 88     	mov	[si+8827h],al
2D1B:22A6 50              	push	ax
2D1B:22A7 8B C6           	mov	ax,si
2D1B:22A9 BA 96 00        	mov	dx,96h
2D1B:22AC F7 E2           	mul	dx
2D1B:22AE 8B D8           	mov	bx,ax
2D1B:22B0 81 C3 81 8B     	add	bx,8B81h
2D1B:22B4 1E              	push	ds
2D1B:22B5 07              	pop	es
2D1B:22B6 58              	pop	ax
2D1B:22B7 26 88 47 02     	mov	es:[bx+2h],al
2D1B:22BB C7 46 F8 02 00  	mov	word ptr [bp-8h],2h
2D1B:22C0 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:22C4 75 08           	jnz	22CEh

l2D1B_22C6:
2D1B:22C6 9A B4 2C 1B 2D  	call	far 2D1Bh:2CB4h
2D1B:22CB 89 46 FA        	mov	[bp-6h],ax

l2D1B_22CE:
2D1B:22CE EB 00           	jmp	22D0h

l2D1B_22D0:
2D1B:22D0 8B 46 06        	mov	ax,[bp+6h]
2D1B:22D3 A3 F2 B2        	mov	[0B2F2h],ax
2D1B:22D6 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:22DA 74 07           	jz	22E3h

l2D1B_22DC:
2D1B:22DC 56              	push	si
2D1B:22DD 9A 53 24 1B 2D  	call	far 2D1Bh:2453h
2D1B:22E2 59              	pop	cx

l2D1B_22E3:
2D1B:22E3 C7 46 EC 00 00  	mov	word ptr [bp-14h],0h
2D1B:22E8 EB 19           	jmp	2303h

l2D1B_22EA:
2D1B:22EA C4 5E E8        	les	bx,[bp-18h]
2D1B:22ED 26 8A 07        	mov	al,es:[bx]
2D1B:22F0 98              	cbw
2D1B:22F1 03 46 EC        	add	ax,[bp-14h]
2D1B:22F4 74 0A           	jz	2300h

l2D1B_22F6:
2D1B:22F6 C4 5E E8        	les	bx,[bp-18h]
2D1B:22F9 03 5E EC        	add	bx,[bp-14h]
2D1B:22FC 26 80 0F 80     	or	byte ptr es:[bx],80h

l2D1B_2300:
2D1B:2300 FF 46 EC        	inc	word ptr [bp-14h]

l2D1B_2303:
2D1B:2303 8B 46 EC        	mov	ax,[bp-14h]
2D1B:2306 3B 46 F8        	cmp	ax,[bp-8h]
2D1B:2309 7C DF           	jl	22EAh

l2D1B_230B:
2D1B:230B B8 01 00        	mov	ax,1h
2D1B:230E 50              	push	ax
2D1B:230F B8 01 00        	mov	ax,1h
2D1B:2312 50              	push	ax
2D1B:2313 56              	push	si
2D1B:2314 1E              	push	ds
2D1B:2315 8B C6           	mov	ax,si
2D1B:2317 BA 96 00        	mov	dx,96h
2D1B:231A F7 E2           	mul	dx
2D1B:231C 05 81 8B        	add	ax,8B81h
2D1B:231F 50              	push	ax
2D1B:2320 0E              	push	cs
2D1B:2321 E8 E1 DC        	call	0005h
2D1B:2324 83 C4 0A        	add	sp,0Ah
2D1B:2327 EB 1A           	jmp	2343h

l2D1B_2329:
2D1B:2329 8A 46 F4        	mov	al,[bp-0Ch]
2D1B:232C 50              	push	ax
2D1B:232D 8B C6           	mov	ax,si
2D1B:232F BA 96 00        	mov	dx,96h
2D1B:2332 F7 E2           	mul	dx
2D1B:2334 8B D8           	mov	bx,ax
2D1B:2336 81 C3 81 8B     	add	bx,8B81h
2D1B:233A 1E              	push	ds
2D1B:233B 07              	pop	es
2D1B:233C 03 DF           	add	bx,di
2D1B:233E 58              	pop	ax
2D1B:233F 26 28 47 04     	sub	es:[bx+4h],al

l2D1B_2343:
2D1B:2343 8B C6           	mov	ax,si
2D1B:2345 BA 96 00        	mov	dx,96h
2D1B:2348 F7 E2           	mul	dx
2D1B:234A 8B D8           	mov	bx,ax
2D1B:234C 81 C3 81 8B     	add	bx,8B81h
2D1B:2350 1E              	push	ds
2D1B:2351 07              	pop	es
2D1B:2352 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:2356 74 4E           	jz	23A6h

l2D1B_2358:
2D1B:2358 83 FE 0C        	cmp	si,0Ch
2D1B:235B 7D 49           	jge	23A6h

l2D1B_235D:
2D1B:235D 56              	push	si
2D1B:235E 9A 29 18 08 22  	call	far 2208h:1829h
2D1B:2363 59              	pop	cx
2D1B:2364 0B C0           	or	ax,ax
2D1B:2366 74 3E           	jz	23A6h

l2D1B_2368:
2D1B:2368 8B 46 FC        	mov	ax,[bp-4h]
2D1B:236B D1 E0           	shl	ax,1h
2D1B:236D 3B 06 BB 86     	cmp	ax,[86BBh]
2D1B:2371 7C 33           	jl	23A6h

l2D1B_2373:
2D1B:2373 1E              	push	ds
2D1B:2374 8B C6           	mov	ax,si
2D1B:2376 BA 96 00        	mov	dx,96h
2D1B:2379 F7 E2           	mul	dx
2D1B:237B 05 81 8B        	add	ax,8B81h
2D1B:237E 50              	push	ax
2D1B:237F 0E              	push	cs
2D1B:2380 E8 F6 DF        	call	0379h
2D1B:2383 59              	pop	cx
2D1B:2384 59              	pop	cx
2D1B:2385 A1 3E 83        	mov	ax,[833Eh]
2D1B:2388 D1 E0           	shl	ax,1h
2D1B:238A 3B 06 BB 86     	cmp	ax,[86BBh]
2D1B:238E 7D 16           	jge	23A6h

l2D1B_2390:
2D1B:2390 C7 06 27 89 00 00 	mov	word ptr [8927h],0h
2D1B:2396 89 36 F2 B2     	mov	[0B2F2h],si
2D1B:239A C7 06 85 B5 01 00 	mov	word ptr [0B585h],1h
2D1B:23A0 C7 06 4B B0 5D 02 	mov	word ptr [0B04Bh],25Dh

l2D1B_23A6:
2D1B:23A6 5F              	pop	di
2D1B:23A7 5E              	pop	si
2D1B:23A8 8B E5           	mov	sp,bp
2D1B:23AA 5D              	pop	bp
2D1B:23AB CB              	retf

;; BeginTerrainDamageAtCell_23AC: 2D1B:23AC
;;   Called from:
;;     1A1F:0CB0 (in AdvanceTerrainDamageState_0C50)
;;     2D1B:082B (in MoveUnitTowardMapCell_03EA)
BeginTerrainDamageAtCell_23AC proc
2D1B:23AC 55              	push	bp
2D1B:23AD 8B EC           	mov	bp,sp
2D1B:23AF 83 EC 02        	sub	sp,2h
2D1B:23B2 56              	push	si
2D1B:23B3 57              	push	di
2D1B:23B4 8B 7E 06        	mov	di,[bp+6h]
2D1B:23B7 A1 AA 00        	mov	ax,[00AAh]
2D1B:23BA F7 66 08        	mul	word ptr [bp+8h]
2D1B:23BD 8B F0           	mov	si,ax
2D1B:23BF 8B C7           	mov	ax,di
2D1B:23C1 D1 F8           	sar	ax,1h
2D1B:23C3 D1 F8           	sar	ax,1h
2D1B:23C5 03 F0           	add	si,ax
2D1B:23C7 8B DF           	mov	bx,di
2D1B:23C9 81 E3 03 00     	and	bx,3h
2D1B:23CD 8A 87 25 3D     	mov	al,[bx+3D25h]
2D1B:23D1 88 46 FF        	mov	[bp-1h],al
2D1B:23D4 8A 46 FF        	mov	al,[bp-1h]
2D1B:23D7 C4 1E 5F AE     	les	bx,[0AE5Fh]
2D1B:23DB 26 84 00        	test	es:[bx+si],al
2D1B:23DE 75 12           	jnz	23F2h

l2D1B_23E0:
2D1B:23E0 FF 76 0A        	push	word ptr [bp+0Ah]
2D1B:23E3 8B C7           	mov	ax,di
2D1B:23E5 25 03 00        	and	ax,3h
2D1B:23E8 50              	push	ax
2D1B:23E9 56              	push	si
2D1B:23EA 9A F8 23 1B 2D  	call	far 2D1Bh:23F8h
2D1B:23EF 83 C4 06        	add	sp,6h

l2D1B_23F2:
2D1B:23F2 5F              	pop	di
2D1B:23F3 5E              	pop	si
2D1B:23F4 8B E5           	mov	sp,bp
2D1B:23F6 5D              	pop	bp
2D1B:23F7 CB              	retf

;; ApplyOrQueueTerrainDamage_23F8: 2D1B:23F8
;;   Called from:
;;     2D1B:23EA (in BeginTerrainDamageAtCell_23AC)
ApplyOrQueueTerrainDamage_23F8 proc
2D1B:23F8 55              	push	bp
2D1B:23F9 8B EC           	mov	bp,sp
2D1B:23FB 8B 46 0A        	mov	ax,[bp+0Ah]
2D1B:23FE 3B 06 59 88     	cmp	ax,[8859h]
2D1B:2402 7C 0A           	jl	240Eh

l2D1B_2404:
2D1B:2404 A1 59 88        	mov	ax,[8859h]
2D1B:2407 40              	inc	ax
2D1B:2408 40              	inc	ax
2D1B:2409 3B 46 0A        	cmp	ax,[bp+0Ah]
2D1B:240C 7D 13           	jge	2421h

l2D1B_240E:
2D1B:240E 8B 5E 08        	mov	bx,[bp+8h]
2D1B:2411 8A 87 29 3D     	mov	al,[bx+3D29h]
2D1B:2415 C4 1E 5F AE     	les	bx,[0AE5Fh]
2D1B:2419 03 5E 06        	add	bx,[bp+6h]
2D1B:241C 26 08 07        	or	es:[bx],al
2D1B:241F EB 30           	jmp	2451h

l2D1B_2421:
2D1B:2421 80 3E A2 84 06  	cmp	byte ptr [84A2h],6h
2D1B:2426 74 29           	jz	2451h

l2D1B_2428:
2D1B:2428 83 3E 06 81 32  	cmp	word ptr [8106h],32h
2D1B:242D 7D 22           	jge	2451h

l2D1B_242F:
2D1B:242F 8B 46 06        	mov	ax,[bp+6h]
2D1B:2432 8B 1E 06 81     	mov	bx,[8106h]
2D1B:2436 D1 E3           	shl	bx,1h
2D1B:2438 89 87 8E B2     	mov	[bx+0B28Eh],ax
2D1B:243C FF 06 06 81     	inc	word ptr [8106h]
2D1B:2440 8B 46 08        	mov	ax,[bp+8h]
2D1B:2443 8B 1E 06 81     	mov	bx,[8106h]
2D1B:2447 D1 E3           	shl	bx,1h
2D1B:2449 89 87 8E B2     	mov	[bx+0B28Eh],ax
2D1B:244D FF 06 06 81     	inc	word ptr [8106h]

l2D1B_2451:
2D1B:2451 5D              	pop	bp
2D1B:2452 CB              	retf

;; DestroyScenarioUnit_2453: 2D1B:2453
;;   Called from:
;;     2D1B:22DD (in ApplyWeaponDamage_1E2B)
;;     2D1B:2BF5 (in CollapseStructureAtMapCell_2AF3)
DestroyScenarioUnit_2453 proc
2D1B:2453 55              	push	bp
2D1B:2454 8B EC           	mov	bp,sp
2D1B:2456 83 EC 02        	sub	sp,2h
2D1B:2459 56              	push	si
2D1B:245A 57              	push	di
2D1B:245B 8B 76 06        	mov	si,[bp+6h]
2D1B:245E 56              	push	si
2D1B:245F 9A 29 18 08 22  	call	far 2208h:1829h
2D1B:2464 59              	pop	cx
2D1B:2465 89 46 FE        	mov	[bp-2h],ax
2D1B:2468 8B C6           	mov	ax,si
2D1B:246A BA 96 00        	mov	dx,96h
2D1B:246D F7 E2           	mul	dx
2D1B:246F 8B D8           	mov	bx,ax
2D1B:2471 81 C3 81 8B     	add	bx,8B81h
2D1B:2475 1E              	push	ds
2D1B:2476 07              	pop	es
2D1B:2477 26 C6 07 00     	mov	byte ptr es:[bx],0h
2D1B:247B 3B 36 DC 03     	cmp	si,[03DCh]
2D1B:247F 75 06           	jnz	2487h

l2D1B_2481:
2D1B:2481 C7 06 DC 03 FF FF 	mov	word ptr [03DCh],0FFFFh

l2D1B_2487:
2D1B:2487 3B 36 DE 03     	cmp	si,[03DEh]
2D1B:248B 75 06           	jnz	2493h

l2D1B_248D:
2D1B:248D C7 06 DE 03 FF FF 	mov	word ptr [03DEh],0FFFFh

l2D1B_2493:
2D1B:2493 33 FF           	xor	di,di
2D1B:2495 EB 0F           	jmp	24A6h

l2D1B_2497:
2D1B:2497 8A 85 F3 88     	mov	al,[di+88F3h]
2D1B:249B 98              	cbw
2D1B:249C 3B C6           	cmp	ax,si
2D1B:249E 75 05           	jnz	24A5h

l2D1B_24A0:
2D1B:24A0 C6 85 F3 88 FF  	mov	byte ptr [di+88F3h],0FFh

l2D1B_24A5:
2D1B:24A5 47              	inc	di

l2D1B_24A6:
2D1B:24A6 83 FF 18        	cmp	di,18h
2D1B:24A9 7C EC           	jl	2497h

l2D1B_24AB:
2D1B:24AB 8A 84 62 85     	mov	al,[si+8562h]
2D1B:24AF 50              	push	ax
2D1B:24B0 8B C6           	mov	ax,si
2D1B:24B2 BA 03 00        	mov	dx,3h
2D1B:24B5 F7 E2           	mul	dx
2D1B:24B7 8B D8           	mov	bx,ax
2D1B:24B9 81 C3 5B 88     	add	bx,885Bh
2D1B:24BD 1E              	push	ds
2D1B:24BE 07              	pop	es
2D1B:24BF 58              	pop	ax
2D1B:24C0 26 88 07        	mov	es:[bx],al
2D1B:24C3 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:24C7 50              	push	ax
2D1B:24C8 8B C6           	mov	ax,si
2D1B:24CA BA 03 00        	mov	dx,3h
2D1B:24CD F7 E2           	mul	dx
2D1B:24CF 8B D8           	mov	bx,ax
2D1B:24D1 81 C3 5B 88     	add	bx,885Bh
2D1B:24D5 1E              	push	ds
2D1B:24D6 07              	pop	es
2D1B:24D7 58              	pop	ax
2D1B:24D8 26 88 47 01     	mov	es:[bx+1h],al
2D1B:24DC 8B C6           	mov	ax,si
2D1B:24DE BA 03 00        	mov	dx,3h
2D1B:24E1 F7 E2           	mul	dx
2D1B:24E3 8B D8           	mov	bx,ax
2D1B:24E5 81 C3 5B 88     	add	bx,885Bh
2D1B:24E9 1E              	push	ds
2D1B:24EA 07              	pop	es
2D1B:24EB 26 C6 47 02 DD  	mov	byte ptr es:[bx+2h],0DDh
2D1B:24F0 C7 06 4B B0 5D 02 	mov	word ptr [0B04Bh],25Dh
2D1B:24F6 C7 06 27 89 09 00 	mov	word ptr [8927h],9h
2D1B:24FC C7 06 85 B5 00 00 	mov	word ptr [0B585h],0h
2D1B:2502 89 36 45 B0     	mov	[0B045h],si
2D1B:2506 83 FE 0C        	cmp	si,0Ch
2D1B:2509 7D 27           	jge	2532h

l2D1B_250B:
2D1B:250B B8 01 00        	mov	ax,1h
2D1B:250E A3 D2 B5        	mov	[0B5D2h],ax
2D1B:2511 A3 85 B5        	mov	[0B585h],ax
2D1B:2514 C7 06 27 89 12 00 	mov	word ptr [8927h],12h
2D1B:251A 89 36 F2 B2     	mov	[0B2F2h],si
2D1B:251E 8B C6           	mov	ax,si
2D1B:2520 BA 03 00        	mov	dx,3h
2D1B:2523 F7 E2           	mul	dx
2D1B:2525 8B D8           	mov	bx,ax
2D1B:2527 81 C3 5B 88     	add	bx,885Bh
2D1B:252B 1E              	push	ds
2D1B:252C 07              	pop	es
2D1B:252D 26 C6 47 02 DC  	mov	byte ptr es:[bx+2h],0DCh

l2D1B_2532:
2D1B:2532 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2D1B:2536 74 0D           	jz	2545h

l2D1B_2538:
2D1B:2538 8B 46 FE        	mov	ax,[bp-2h]
2D1B:253B 25 0C 00        	and	ax,0Ch
2D1B:253E 50              	push	ax
2D1B:253F 9A A1 18 08 22  	call	far 2208h:18A1h
2D1B:2544 59              	pop	cx

l2D1B_2545:
2D1B:2545 B8 04 00        	mov	ax,4h
2D1B:2548 50              	push	ax
2D1B:2549 9A 67 05 FB 31  	call	far 31FBh:0567h
2D1B:254E 59              	pop	cx
2D1B:254F 83 FE 08        	cmp	si,8h
2D1B:2552 75 11           	jnz	2565h

l2D1B_2554:
2D1B:2554 83 3E 81 B5 4C  	cmp	word ptr [0B581h],4Ch
2D1B:2559 75 0A           	jnz	2565h

l2D1B_255B:
2D1B:255B C6 06 B1 99 03  	mov	byte ptr [99B1h],3h
2D1B:2560 C6 06 79 B5 FF  	mov	byte ptr [0B579h],0FFh

l2D1B_2565:
2D1B:2565 5F              	pop	di
2D1B:2566 5E              	pop	si
2D1B:2567 8B E5           	mov	sp,bp
2D1B:2569 5D              	pop	bp
2D1B:256A CB              	retf

;; UpdateUnitHeatShutdown_256B: 2D1B:256B
;;   Called from:
;;     1A1F:083B (in RunTacticalInteractionLoop_0613)
UpdateUnitHeatShutdown_256B proc
2D1B:256B 55              	push	bp
2D1B:256C 8B EC           	mov	bp,sp
2D1B:256E 83 EC 02        	sub	sp,2h
2D1B:2571 56              	push	si
2D1B:2572 57              	push	di
2D1B:2573 8B 76 06        	mov	si,[bp+6h]
2D1B:2576 8B C6           	mov	ax,si
2D1B:2578 BA 96 00        	mov	dx,96h
2D1B:257B F7 E2           	mul	dx
2D1B:257D 8B D8           	mov	bx,ax
2D1B:257F 81 C3 81 8B     	add	bx,8B81h
2D1B:2583 1E              	push	ds
2D1B:2584 07              	pop	es
2D1B:2585 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2D1B:258A 25 FF 00        	and	ax,0FFh
2D1B:258D 89 46 FE        	mov	[bp-2h],ax
2D1B:2590 83 7E FE 1E     	cmp	word ptr [bp-2h],1Eh
2D1B:2594 7E 05           	jle	259Bh

l2D1B_2596:
2D1B:2596 C7 46 FE 1E 00  	mov	word ptr [bp-2h],1Eh

l2D1B_259B:
2D1B:259B BF 01 00        	mov	di,1h
2D1B:259E 83 7E FE 0E     	cmp	word ptr [bp-2h],0Eh
2D1B:25A2 7D 04           	jge	25A8h

l2D1B_25A4:
2D1B:25A4 33 FF           	xor	di,di
2D1B:25A6 EB 21           	jmp	25C9h

l2D1B_25A8:
2D1B:25A8 0E              	push	cs
2D1B:25A9 E8 48 F8        	call	1DF4h
2D1B:25AC 8B 56 FE        	mov	dx,[bp-2h]
2D1B:25AF 83 C2 F2        	add	dx,0F2h
2D1B:25B2 D1 FA           	sar	dx,1h
2D1B:25B4 83 C2 04        	add	dx,4h
2D1B:25B7 3B C2           	cmp	ax,dx
2D1B:25B9 7C 04           	jl	25BFh

l2D1B_25BB:
2D1B:25BB 33 FF           	xor	di,di
2D1B:25BD EB 0A           	jmp	25C9h

l2D1B_25BF:
2D1B:25BF C6 84 0C 89 00  	mov	byte ptr [si+890Ch],0h
2D1B:25C4 C6 84 4A A8 01  	mov	byte ptr [si+0A84Ah],1h

l2D1B_25C9:
2D1B:25C9 83 FE 0C        	cmp	si,0Ch
2D1B:25CC 7D 2C           	jge	25FAh

l2D1B_25CE:
2D1B:25CE 56              	push	si
2D1B:25CF 9A 29 18 08 22  	call	far 2208h:1829h
2D1B:25D4 59              	pop	cx
2D1B:25D5 0B C0           	or	ax,ax
2D1B:25D7 74 21           	jz	25FAh

l2D1B_25D9:
2D1B:25D9 0B FF           	or	di,di
2D1B:25DB 74 1D           	jz	25FAh

l2D1B_25DD:
2D1B:25DD 80 BC 4A A8 00  	cmp	byte ptr [si+0A84Ah],0h
2D1B:25E2 75 16           	jnz	25FAh

l2D1B_25E4:
2D1B:25E4 C7 06 4B B0 5D 02 	mov	word ptr [0B04Bh],25Dh
2D1B:25EA 89 36 F2 B2     	mov	[0B2F2h],si
2D1B:25EE C7 06 85 B5 01 00 	mov	word ptr [0B585h],1h
2D1B:25F4 C7 06 27 89 01 00 	mov	word ptr [8927h],1h

l2D1B_25FA:
2D1B:25FA 8B C7           	mov	ax,di
2D1B:25FC EB 00           	jmp	25FEh

l2D1B_25FE:
2D1B:25FE 5F              	pop	di
2D1B:25FF 5E              	pop	si
2D1B:2600 8B E5           	mov	sp,bp
2D1B:2602 5D              	pop	bp
2D1B:2603 CB              	retf

;; BuildArmWeaponAvailabilityMasks_2604: 2D1B:2604
;;   Called from:
;;     2D1B:16AD (in ExecuteUnitWeaponAI_14A4)
BuildArmWeaponAvailabilityMasks_2604 proc
2D1B:2604 55              	push	bp
2D1B:2605 8B EC           	mov	bp,sp
2D1B:2607 83 EC 04        	sub	sp,4h
2D1B:260A 56              	push	si
2D1B:260B 57              	push	di
2D1B:260C 33 F6           	xor	si,si
2D1B:260E EB 0B           	jmp	261Bh

l2D1B_2610:
2D1B:2610 8B DE           	mov	bx,si
2D1B:2612 D1 E3           	shl	bx,1h
2D1B:2614 C7 87 BF 88 00 00 	mov	word ptr [bx+88BFh],0h
2D1B:261A 46              	inc	si

l2D1B_261B:
2D1B:261B 83 FE 17        	cmp	si,17h
2D1B:261E 7C F0           	jl	2610h

l2D1B_2620:
2D1B:2620 33 F6           	xor	si,si
2D1B:2622 EB 63           	jmp	2687h

l2D1B_2624:
2D1B:2624 8B 46 06        	mov	ax,[bp+6h]
2D1B:2627 BA 96 00        	mov	dx,96h
2D1B:262A F7 E2           	mul	dx
2D1B:262C 8B D8           	mov	bx,ax
2D1B:262E 81 C3 81 8B     	add	bx,8B81h
2D1B:2632 1E              	push	ds
2D1B:2633 07              	pop	es
2D1B:2634 03 DE           	add	bx,si
2D1B:2636 26 8A 47 56     	mov	al,es:[bx+56h]
2D1B:263A 98              	cbw
2D1B:263B 8B F8           	mov	di,ax
2D1B:263D 0B FF           	or	di,di
2D1B:263F 74 14           	jz	2655h

l2D1B_2641:
2D1B:2641 F7 C7 80 00     	test	di,80h
2D1B:2645 75 0E           	jnz	2655h

l2D1B_2647:
2D1B:2647 83 FF 17        	cmp	di,17h
2D1B:264A 7F 09           	jg	2655h

l2D1B_264C:
2D1B:264C 8B DF           	mov	bx,di
2D1B:264E 4B              	dec	bx
2D1B:264F D1 E3           	shl	bx,1h
2D1B:2651 FF 87 BF 88     	inc	word ptr [bx+88BFh]

l2D1B_2655:
2D1B:2655 8B 46 06        	mov	ax,[bp+6h]
2D1B:2658 BA 96 00        	mov	dx,96h
2D1B:265B F7 E2           	mul	dx
2D1B:265D 8B D8           	mov	bx,ax
2D1B:265F 81 C3 81 8B     	add	bx,8B81h
2D1B:2663 1E              	push	ds
2D1B:2664 07              	pop	es
2D1B:2665 03 DE           	add	bx,si
2D1B:2667 26 8A 47 78     	mov	al,es:[bx+78h]
2D1B:266B 98              	cbw
2D1B:266C 8B F8           	mov	di,ax
2D1B:266E 0B FF           	or	di,di
2D1B:2670 74 14           	jz	2686h

l2D1B_2672:
2D1B:2672 F7 C7 80 00     	test	di,80h
2D1B:2676 75 0E           	jnz	2686h

l2D1B_2678:
2D1B:2678 83 FF 17        	cmp	di,17h
2D1B:267B 7F 09           	jg	2686h

l2D1B_267D:
2D1B:267D 8B DF           	mov	bx,di
2D1B:267F 4B              	dec	bx
2D1B:2680 D1 E3           	shl	bx,1h
2D1B:2682 FF 87 BF 88     	inc	word ptr [bx+88BFh]

l2D1B_2686:
2D1B:2686 46              	inc	si

l2D1B_2687:
2D1B:2687 83 FE 08        	cmp	si,8h
2D1B:268A 7C 98           	jl	2624h

l2D1B_268C:
2D1B:268C C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2D1B:2691 C7 46 FC 01 00  	mov	word ptr [bp-4h],1h
2D1B:2696 8B 5E 06        	mov	bx,[bp+6h]
2D1B:2699 D1 E3           	shl	bx,1h
2D1B:269B D1 E3           	shl	bx,1h
2D1B:269D C7 87 73 A9 00 00 	mov	word ptr [bx+0A973h],0h
2D1B:26A3 C7 87 71 A9 00 00 	mov	word ptr [bx+0A971h],0h
2D1B:26A9 33 F6           	xor	si,si
2D1B:26AB E9 B3 00        	jmp	2761h

l2D1B_26AE:
2D1B:26AE 8B DE           	mov	bx,si
2D1B:26B0 D1 E3           	shl	bx,1h
2D1B:26B2 83 BF BF 88 00  	cmp	word ptr [bx+88BFh],0h
2D1B:26B7 75 03           	jnz	26BCh

l2D1B_26B9:
2D1B:26B9 E9 94 00        	jmp	2750h

l2D1B_26BC:
2D1B:26BC 8B C6           	mov	ax,si
2D1B:26BE BA 0F 00        	mov	dx,0Fh
2D1B:26C1 F7 E2           	mul	dx
2D1B:26C3 8B D8           	mov	bx,ax
2D1B:26C5 81 C3 35 04     	add	bx,435h
2D1B:26C9 1E              	push	ds
2D1B:26CA 07              	pop	es
2D1B:26CB 26 80 7F 0B 00  	cmp	byte ptr es:[bx+0Bh],0h
2D1B:26D0 74 5A           	jz	272Ch

l2D1B_26D2:
2D1B:26D2 8B 46 06        	mov	ax,[bp+6h]
2D1B:26D5 BA 96 00        	mov	dx,96h
2D1B:26D8 F7 E2           	mul	dx
2D1B:26DA 8B D8           	mov	bx,ax
2D1B:26DC 81 C3 81 8B     	add	bx,8B81h
2D1B:26E0 1E              	push	ds
2D1B:26E1 07              	pop	es
2D1B:26E2 8B C6           	mov	ax,si
2D1B:26E4 BA 0F 00        	mov	dx,0Fh
2D1B:26E7 F7 E2           	mul	dx
2D1B:26E9 06              	push	es
2D1B:26EA 53              	push	bx
2D1B:26EB 8B D8           	mov	bx,ax
2D1B:26ED 81 C3 35 04     	add	bx,435h
2D1B:26F1 1E              	push	ds
2D1B:26F2 07              	pop	es
2D1B:26F3 26 8A 47 0B     	mov	al,es:[bx+0Bh]
2D1B:26F7 98              	cbw
2D1B:26F8 48              	dec	ax
2D1B:26F9 D1 E0           	shl	ax,1h
2D1B:26FB 5B              	pop	bx
2D1B:26FC 07              	pop	es
2D1B:26FD 03 D8           	add	bx,ax
2D1B:26FF 26 83 7F 38 00  	cmp	word ptr es:[bx+38h],0h
2D1B:2704 74 24           	jz	272Ah

l2D1B_2706:
2D1B:2706 8B 5E 06        	mov	bx,[bp+6h]
2D1B:2709 D1 E3           	shl	bx,1h
2D1B:270B D1 E3           	shl	bx,1h
2D1B:270D 8B 97 73 A9     	mov	dx,[bx+0A973h]
2D1B:2711 8B 87 71 A9     	mov	ax,[bx+0A971h]
2D1B:2715 0B 46 FC        	or	ax,[bp-4h]
2D1B:2718 0B 56 FE        	or	dx,[bp-2h]
2D1B:271B 8B 5E 06        	mov	bx,[bp+6h]
2D1B:271E D1 E3           	shl	bx,1h
2D1B:2720 D1 E3           	shl	bx,1h
2D1B:2722 89 97 73 A9     	mov	[bx+0A973h],dx
2D1B:2726 89 87 71 A9     	mov	[bx+0A971h],ax

l2D1B_272A:
2D1B:272A EB 24           	jmp	2750h

l2D1B_272C:
2D1B:272C 8B 5E 06        	mov	bx,[bp+6h]
2D1B:272F D1 E3           	shl	bx,1h
2D1B:2731 D1 E3           	shl	bx,1h
2D1B:2733 8B 97 73 A9     	mov	dx,[bx+0A973h]
2D1B:2737 8B 87 71 A9     	mov	ax,[bx+0A971h]
2D1B:273B 0B 46 FC        	or	ax,[bp-4h]
2D1B:273E 0B 56 FE        	or	dx,[bp-2h]
2D1B:2741 8B 5E 06        	mov	bx,[bp+6h]
2D1B:2744 D1 E3           	shl	bx,1h
2D1B:2746 D1 E3           	shl	bx,1h
2D1B:2748 89 97 73 A9     	mov	[bx+0A973h],dx
2D1B:274C 89 87 71 A9     	mov	[bx+0A971h],ax

l2D1B_2750:
2D1B:2750 8B 56 FE        	mov	dx,[bp-2h]
2D1B:2753 8B 46 FC        	mov	ax,[bp-4h]
2D1B:2756 D1 E0           	shl	ax,1h
2D1B:2758 D1 D2           	rcl	dx,1h
2D1B:275A 89 56 FE        	mov	[bp-2h],dx
2D1B:275D 89 46 FC        	mov	[bp-4h],ax
2D1B:2760 46              	inc	si

l2D1B_2761:
2D1B:2761 83 FE 17        	cmp	si,17h
2D1B:2764 7D 03           	jge	2769h

l2D1B_2766:
2D1B:2766 E9 45 FF        	jmp	26AEh

l2D1B_2769:
2D1B:2769 5F              	pop	di
2D1B:276A 5E              	pop	si
2D1B:276B 8B E5           	mov	sp,bp
2D1B:276D 5D              	pop	bp
2D1B:276E CB              	retf

;; ApplyTerrainImpact_276F: 2D1B:276F
;;   Called from:
;;     2007:0570 (in AdvanceTerrainEffects_042A)
;;     2007:05A8 (in AdvanceTerrainEffects_042A)
;;     2007:05E0 (in AdvanceTerrainEffects_042A)
;;     2007:0617 (in AdvanceTerrainEffects_042A)
;;     2D1B:1BEA (in ResolveWeaponAttack_1854)
;;     2D1B:2B79 (in CollapseStructureAtMapCell_2AF3)
ApplyTerrainImpact_276F proc
2D1B:276F 55              	push	bp
2D1B:2770 8B EC           	mov	bp,sp
2D1B:2772 83 EC 06        	sub	sp,6h
2D1B:2775 56              	push	si
2D1B:2776 57              	push	di
2D1B:2777 FF 76 08        	push	word ptr [bp+8h]
2D1B:277A FF 76 06        	push	word ptr [bp+6h]
2D1B:277D 9A F9 0C 1F 1A  	call	far 1A1Fh:0CF9h
2D1B:2782 59              	pop	cx
2D1B:2783 59              	pop	cx
2D1B:2784 89 46 FC        	mov	[bp-4h],ax
2D1B:2787 83 7E 06 00     	cmp	word ptr [bp+6h],0h
2D1B:278B 7D 03           	jge	2790h

l2D1B_278D:
2D1B:278D E9 D9 01        	jmp	2969h

l2D1B_2790:
2D1B:2790 8B 46 06        	mov	ax,[bp+6h]
2D1B:2793 3B 06 A6 00     	cmp	ax,[00A6h]
2D1B:2797 7C 03           	jl	279Ch

l2D1B_2799:
2D1B:2799 E9 CD 01        	jmp	2969h

l2D1B_279C:
2D1B:279C 83 7E 08 00     	cmp	word ptr [bp+8h],0h
2D1B:27A0 7D 03           	jge	27A5h

l2D1B_27A2:
2D1B:27A2 E9 C4 01        	jmp	2969h

l2D1B_27A5:
2D1B:27A5 8B 46 08        	mov	ax,[bp+8h]
2D1B:27A8 3B 06 A8 00     	cmp	ax,[00A8h]
2D1B:27AC 7C 03           	jl	27B1h

l2D1B_27AE:
2D1B:27AE E9 B8 01        	jmp	2969h

l2D1B_27B1:
2D1B:27B1 83 7E FC 03     	cmp	word ptr [bp-4h],3h
2D1B:27B5 7C 03           	jl	27BAh

l2D1B_27B7:
2D1B:27B7 E9 AF 01        	jmp	2969h

l2D1B_27BA:
2D1B:27BA 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2D1B:27BE 74 12           	jz	27D2h

l2D1B_27C0:
2D1B:27C0 B8 03 00        	mov	ax,3h
2D1B:27C3 50              	push	ax
2D1B:27C4 FF 76 08        	push	word ptr [bp+8h]
2D1B:27C7 FF 76 06        	push	word ptr [bp+6h]
2D1B:27CA 9A 50 0C 1F 1A  	call	far 1A1Fh:0C50h
2D1B:27CF 83 C4 06        	add	sp,6h

l2D1B_27D2:
2D1B:27D2 8B 46 08        	mov	ax,[bp+8h]
2D1B:27D5 F7 26 A6 00     	mul	word ptr [00A6h]
2D1B:27D9 03 46 06        	add	ax,[bp+6h]
2D1B:27DC C4 1E EA 83     	les	bx,[83EAh]
2D1B:27E0 03 D8           	add	bx,ax
2D1B:27E2 26 8A 07        	mov	al,es:[bx]
2D1B:27E5 B4 00           	mov	ah,0h
2D1B:27E7 8B F8           	mov	di,ax
2D1B:27E9 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2D1B:27EE 3B 3E 5D 85     	cmp	di,[855Dh]
2D1B:27F2 7C 13           	jl	2807h

l2D1B_27F4:
2D1B:27F4 3B 3E 9E 84     	cmp	di,[849Eh]
2D1B:27F8 7F 0D           	jg	2807h

l2D1B_27FA:
2D1B:27FA 9A 46 4D 00 08  	call	far 0800h:4D46h
2D1B:27FF B4 00           	mov	ah,0h
2D1B:2801 25 01 00        	and	ax,1h
2D1B:2804 89 46 FE        	mov	[bp-2h],ax

l2D1B_2807:
2D1B:2807 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2D1B:280B 75 09           	jnz	2816h

l2D1B_280D:
2D1B:280D 83 7E 0C 00     	cmp	word ptr [bp+0Ch],0h
2D1B:2811 75 03           	jnz	2816h

l2D1B_2813:
2D1B:2813 E9 D7 00        	jmp	28EDh

l2D1B_2816:
2D1B:2816 BF 01 00        	mov	di,1h
2D1B:2819 33 F6           	xor	si,si
2D1B:281B EB 35           	jmp	2852h

l2D1B_281D:
2D1B:281D 8B C6           	mov	ax,si
2D1B:281F BA 06 00        	mov	dx,6h
2D1B:2822 F7 E2           	mul	dx
2D1B:2824 8B D8           	mov	bx,ax
2D1B:2826 81 C3 0C 81     	add	bx,810Ch
2D1B:282A 1E              	push	ds
2D1B:282B 07              	pop	es
2D1B:282C 26 8B 07        	mov	ax,es:[bx]
2D1B:282F 3B 46 06        	cmp	ax,[bp+6h]
2D1B:2832 75 1D           	jnz	2851h

l2D1B_2834:
2D1B:2834 8B C6           	mov	ax,si
2D1B:2836 BA 06 00        	mov	dx,6h
2D1B:2839 F7 E2           	mul	dx
2D1B:283B 8B D8           	mov	bx,ax
2D1B:283D 81 C3 0C 81     	add	bx,810Ch
2D1B:2841 1E              	push	ds
2D1B:2842 07              	pop	es
2D1B:2843 26 8B 47 02     	mov	ax,es:[bx+2h]
2D1B:2847 3B 46 08        	cmp	ax,[bp+8h]
2D1B:284A 75 05           	jnz	2851h

l2D1B_284C:
2D1B:284C BE 5A 00        	mov	si,5Ah
2D1B:284F 33 FF           	xor	di,di

l2D1B_2851:
2D1B:2851 46              	inc	si

l2D1B_2852:
2D1B:2852 83 FE 5A        	cmp	si,5Ah
2D1B:2855 7C C6           	jl	281Dh

l2D1B_2857:
2D1B:2857 0B FF           	or	di,di
2D1B:2859 75 03           	jnz	285Eh

l2D1B_285B:
2D1B:285B E9 8F 00        	jmp	28EDh

l2D1B_285E:
2D1B:285E 33 F6           	xor	si,si
2D1B:2860 E9 82 00        	jmp	28E5h

l2D1B_2863:
2D1B:2863 8B C6           	mov	ax,si
2D1B:2865 BA 06 00        	mov	dx,6h
2D1B:2868 F7 E2           	mul	dx
2D1B:286A 8B D8           	mov	bx,ax
2D1B:286C 81 C3 0C 81     	add	bx,810Ch
2D1B:2870 1E              	push	ds
2D1B:2871 07              	pop	es
2D1B:2872 26 83 3F FF     	cmp	word ptr es:[bx],0FFh
2D1B:2876 75 6C           	jnz	28E4h

l2D1B_2878:
2D1B:2878 8B 46 06        	mov	ax,[bp+6h]
2D1B:287B 50              	push	ax
2D1B:287C 8B C6           	mov	ax,si
2D1B:287E BA 06 00        	mov	dx,6h
2D1B:2881 F7 E2           	mul	dx
2D1B:2883 8B D8           	mov	bx,ax
2D1B:2885 81 C3 0C 81     	add	bx,810Ch
2D1B:2889 1E              	push	ds
2D1B:288A 07              	pop	es
2D1B:288B 58              	pop	ax
2D1B:288C 26 89 07        	mov	es:[bx],ax
2D1B:288F 8B 46 08        	mov	ax,[bp+8h]
2D1B:2892 50              	push	ax
2D1B:2893 8B C6           	mov	ax,si
2D1B:2895 BA 06 00        	mov	dx,6h
2D1B:2898 F7 E2           	mul	dx
2D1B:289A 8B D8           	mov	bx,ax
2D1B:289C 81 C3 0C 81     	add	bx,810Ch
2D1B:28A0 1E              	push	ds
2D1B:28A1 07              	pop	es
2D1B:28A2 58              	pop	ax
2D1B:28A3 26 89 47 02     	mov	es:[bx+2h],ax
2D1B:28A7 9A 46 4D 00 08  	call	far 0800h:4D46h
2D1B:28AC B4 00           	mov	ah,0h
2D1B:28AE BB 03 00        	mov	bx,3h
2D1B:28B1 99              	cwd
2D1B:28B2 F7 FB           	idiv	bx
2D1B:28B4 8B C6           	mov	ax,si
2D1B:28B6 BB 06 00        	mov	bx,6h
2D1B:28B9 52              	push	dx
2D1B:28BA F7 E3           	mul	bx
2D1B:28BC 8B D8           	mov	bx,ax
2D1B:28BE 81 C3 0C 81     	add	bx,810Ch
2D1B:28C2 1E              	push	ds
2D1B:28C3 07              	pop	es
2D1B:28C4 58              	pop	ax
2D1B:28C5 26 89 47 04     	mov	es:[bx+4h],ax
2D1B:28C9 BE 5A 00        	mov	si,5Ah
2D1B:28CC 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2D1B:28D0 75 12           	jnz	28E4h

l2D1B_28D2:
2D1B:28D2 B8 03 00        	mov	ax,3h
2D1B:28D5 50              	push	ax
2D1B:28D6 FF 76 08        	push	word ptr [bp+8h]
2D1B:28D9 FF 76 06        	push	word ptr [bp+6h]
2D1B:28DC 9A 50 0C 1F 1A  	call	far 1A1Fh:0C50h
2D1B:28E1 83 C4 06        	add	sp,6h

l2D1B_28E4:
2D1B:28E4 46              	inc	si

l2D1B_28E5:
2D1B:28E5 83 FE 5A        	cmp	si,5Ah
2D1B:28E8 7D 03           	jge	28EDh

l2D1B_28EA:
2D1B:28EA E9 76 FF        	jmp	2863h

l2D1B_28ED:
2D1B:28ED 83 7E FC 02     	cmp	word ptr [bp-4h],2h
2D1B:28F1 74 03           	jz	28F6h

l2D1B_28F3:
2D1B:28F3 E9 73 00        	jmp	2969h

l2D1B_28F6:
2D1B:28F6 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
2D1B:28FA 75 03           	jnz	28FFh

l2D1B_28FC:
2D1B:28FC E9 6A 00        	jmp	2969h

l2D1B_28FF:
2D1B:28FF C7 46 FA 00 00  	mov	word ptr [bp-6h],0h
2D1B:2904 A0 A2 84        	mov	al,[84A2h]
2D1B:2907 98              	cbw
2D1B:2908 3D 01 00        	cmp	ax,1h
2D1B:290B 74 0C           	jz	2919h

l2D1B_290D:
2D1B:290D 3D 05 00        	cmp	ax,5h
2D1B:2910 74 1A           	jz	292Ch

l2D1B_2912:
2D1B:2912 3D 08 00        	cmp	ax,8h
2D1B:2915 74 28           	jz	293Fh

l2D1B_2917:
2D1B:2917 EB 39           	jmp	2952h

l2D1B_2919:
2D1B:2919 81 FF 8C 00     	cmp	di,8Ch
2D1B:291D 7C 0B           	jl	292Ah

l2D1B_291F:
2D1B:291F 81 FF 94 00     	cmp	di,94h
2D1B:2923 7F 05           	jg	292Ah

l2D1B_2925:
2D1B:2925 C7 46 FA 01 00  	mov	word ptr [bp-6h],1h

l2D1B_292A:
2D1B:292A EB 28           	jmp	2954h

l2D1B_292C:
2D1B:292C 81 FF E6 00     	cmp	di,0E6h
2D1B:2930 7C 0B           	jl	293Dh

l2D1B_2932:
2D1B:2932 81 FF EE 00     	cmp	di,0EEh
2D1B:2936 7F 05           	jg	293Dh

l2D1B_2938:
2D1B:2938 C7 46 FA 01 00  	mov	word ptr [bp-6h],1h

l2D1B_293D:
2D1B:293D EB 15           	jmp	2954h

l2D1B_293F:
2D1B:293F 81 FF A9 00     	cmp	di,0A9h
2D1B:2943 7C 0B           	jl	2950h

l2D1B_2945:
2D1B:2945 81 FF AC 00     	cmp	di,0ACh
2D1B:2949 7F 05           	jg	2950h

l2D1B_294B:
2D1B:294B C7 46 FA 01 00  	mov	word ptr [bp-6h],1h

l2D1B_2950:
2D1B:2950 EB 02           	jmp	2954h

l2D1B_2952:
2D1B:2952 EB 00           	jmp	2954h

l2D1B_2954:
2D1B:2954 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2D1B:2958 74 0F           	jz	2969h

l2D1B_295A:
2D1B:295A 57              	push	di
2D1B:295B FF 76 08        	push	word ptr [bp+8h]
2D1B:295E FF 76 06        	push	word ptr [bp+6h]
2D1B:2961 9A F3 2A 1B 2D  	call	far 2D1Bh:2AF3h
2D1B:2966 83 C4 06        	add	sp,6h

l2D1B_2969:
2D1B:2969 5F              	pop	di
2D1B:296A 5E              	pop	si
2D1B:296B 8B E5           	mov	sp,bp
2D1B:296D 5D              	pop	bp
2D1B:296E CB              	retf

;; QueueLanceOrderNarration_296F: 2D1B:296F
;;   Called from:
;;     2D1B:04DB (in MoveUnitTowardMapCell_03EA)
;;     2D1B:0583 (in MoveUnitTowardMapCell_03EA)
QueueLanceOrderNarration_296F proc
2D1B:296F 55              	push	bp
2D1B:2970 8B EC           	mov	bp,sp
2D1B:2972 56              	push	si
2D1B:2973 8B 76 06        	mov	si,[bp+6h]
2D1B:2976 83 FE 0C        	cmp	si,0Ch
2D1B:2979 7D 28           	jge	29A3h

l2D1B_297B:
2D1B:297B 56              	push	si
2D1B:297C 9A 29 18 08 22  	call	far 2208h:1829h
2D1B:2981 59              	pop	cx
2D1B:2982 0B C0           	or	ax,ax
2D1B:2984 74 1D           	jz	29A3h

l2D1B_2986:
2D1B:2986 80 BC 68 8B 02  	cmp	byte ptr [si+8B68h],2h
2D1B:298B 74 16           	jz	29A3h

l2D1B_298D:
2D1B:298D C7 06 85 B5 00 00 	mov	word ptr [0B585h],0h
2D1B:2993 C7 06 4B B0 5D 02 	mov	word ptr [0B04Bh],25Dh
2D1B:2999 89 36 F2 B2     	mov	[0B2F2h],si
2D1B:299D C7 06 27 89 07 00 	mov	word ptr [8927h],7h

l2D1B_29A3:
2D1B:29A3 5E              	pop	si
2D1B:29A4 5D              	pop	bp
2D1B:29A5 CB              	retf
2D1B:29A6                   55 8B EC 83 EC 04 56 57 BF FF       U.....VW..
2D1B:29B0 7F C7 46 FE FF FF 8B 76 08 EB 60 8B C6 BA 96 00 ..F....v..`.....
2D1B:29C0 F7 E2 8B D8 81 C3 81 8B 1E 07 26 80 3F 00 74 4A ..........&.?.tJ
2D1B:29D0 8B C6 25 0C 00 8B 56 06 81 E2 0C 00 3B C2 74 3A ..%...V.....;.t:
2D1B:29E0 8B 5E 06 8A 87 7B 85 B4 00 50 8B 5E 06 8A 87 62 .^...{...P.^...b
2D1B:29F0 85 B4 00 50 8A 84 7B 85 B4 00 50 8A 84 62 85 B4 ...P..{...P..b..
2D1B:2A00 00 50 9A 90 0D 07 20 83 C4 08 89 46 FC 8B 46 FC .P.... ....F..F.
2D1B:2A10 3B C7 7D 06 8B 7E FC 89 76 FE 46 8B 46 08 05 0C ;.}..~..v.F.F...
2D1B:2A20 00 3B C6 7F 96 8B 46 FE EB 00 5F 5E 8B E5 5D CB .;....F..._^..].

;; FindOperationalLanceLeader_2A30: 2D1B:2A30
;;   Called from:
;;     1A1F:4460 (in RenderPendingNarration_4447)
;;     1A1F:4B66 (in HandleTacticalInput_4A9E)
;;     1A1F:5003 (in ShowPendingNarrationPrompt_4FA6)
;;     2208:18AC (in RebuildLanceFormationAfterLeaderLoss_18A1)
;;     2208:1DC6 (in UpdateUnitEnemyVisibility_1CCC)
;;     2D1B:13F0 (in AdvanceUnitTacticalMovement_0F1F)
FindOperationalLanceLeader_2A30 proc
2D1B:2A30 55              	push	bp
2D1B:2A31 8B EC           	mov	bp,sp
2D1B:2A33 83 EC 02        	sub	sp,2h
2D1B:2A36 56              	push	si
2D1B:2A37 57              	push	di
2D1B:2A38 BF FF FF        	mov	di,0FFFFh
2D1B:2A3B 89 7E FE        	mov	[bp-2h],di
2D1B:2A3E 81 66 06 1C 00  	and	word ptr [bp+6h],1Ch
2D1B:2A43 33 F6           	xor	si,si
2D1B:2A45 EB 48           	jmp	2A8Fh

l2D1B_2A47:
2D1B:2A47 8B 46 06        	mov	ax,[bp+6h]
2D1B:2A4A 03 C6           	add	ax,si
2D1B:2A4C BA 96 00        	mov	dx,96h
2D1B:2A4F F7 E2           	mul	dx
2D1B:2A51 8B D8           	mov	bx,ax
2D1B:2A53 81 C3 81 8B     	add	bx,8B81h
2D1B:2A57 1E              	push	ds
2D1B:2A58 07              	pop	es
2D1B:2A59 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:2A5D 74 2F           	jz	2A8Eh

l2D1B_2A5F:
2D1B:2A5F 83 7E FE FF     	cmp	word ptr [bp-2h],0FFh
2D1B:2A63 75 08           	jnz	2A6Dh

l2D1B_2A65:
2D1B:2A65 8B 46 06        	mov	ax,[bp+6h]
2D1B:2A68 03 C6           	add	ax,si
2D1B:2A6A 89 46 FE        	mov	[bp-2h],ax

l2D1B_2A6D:
2D1B:2A6D 8B 46 06        	mov	ax,[bp+6h]
2D1B:2A70 03 C6           	add	ax,si
2D1B:2A72 BA 96 00        	mov	dx,96h
2D1B:2A75 F7 E2           	mul	dx
2D1B:2A77 8B D8           	mov	bx,ax
2D1B:2A79 81 C3 81 8B     	add	bx,8B81h
2D1B:2A7D 1E              	push	ds
2D1B:2A7E 07              	pop	es
2D1B:2A7F 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2D1B:2A84 74 08           	jz	2A8Eh

l2D1B_2A86:
2D1B:2A86 8B 7E 06        	mov	di,[bp+6h]
2D1B:2A89 03 FE           	add	di,si
2D1B:2A8B BE 05 00        	mov	si,5h

l2D1B_2A8E:
2D1B:2A8E 46              	inc	si

l2D1B_2A8F:
2D1B:2A8F 83 FE 04        	cmp	si,4h
2D1B:2A92 7C B3           	jl	2A47h

l2D1B_2A94:
2D1B:2A94 83 FF FF        	cmp	di,0FFh
2D1B:2A97 75 03           	jnz	2A9Ch

l2D1B_2A99:
2D1B:2A99 8B 7E FE        	mov	di,[bp-2h]

l2D1B_2A9C:
2D1B:2A9C 8B C7           	mov	ax,di
2D1B:2A9E EB 00           	jmp	2AA0h

l2D1B_2AA0:
2D1B:2AA0 5F              	pop	di
2D1B:2AA1 5E              	pop	si
2D1B:2AA2 8B E5           	mov	sp,bp
2D1B:2AA4 5D              	pop	bp
2D1B:2AA5 CB              	retf

;; HasTacticalReferencePointLineOfSightToUnit_2AA6: 2D1B:2AA6
;;   Called from:
;;     2B34:05E0 (in DrawTacticalUnitControlPanel_04C2)
HasTacticalReferencePointLineOfSightToUnit_2AA6 proc
2D1B:2AA6 55              	push	bp
2D1B:2AA7 8B EC           	mov	bp,sp
2D1B:2AA9 B0 FF           	mov	al,0FFh
2D1B:2AAB 50              	push	ax
2D1B:2AAC B8 FF 00        	mov	ax,0FFh
2D1B:2AAF 50              	push	ax
2D1B:2AB0 B8 FF 00        	mov	ax,0FFh
2D1B:2AB3 50              	push	ax
2D1B:2AB4 B8 FF 00        	mov	ax,0FFh
2D1B:2AB7 50              	push	ax
2D1B:2AB8 FF 36 EC 83     	push	word ptr [83ECh]
2D1B:2ABC FF 36 EA 83     	push	word ptr [83EAh]
2D1B:2AC0 8B 5E 08        	mov	bx,[bp+8h]
2D1B:2AC3 8A 87 7B 85     	mov	al,[bx+857Bh]
2D1B:2AC7 B4 00           	mov	ah,0h
2D1B:2AC9 50              	push	ax
2D1B:2ACA 8B 5E 08        	mov	bx,[bp+8h]
2D1B:2ACD 8A 87 62 85     	mov	al,[bx+8562h]
2D1B:2AD1 B4 00           	mov	ah,0h
2D1B:2AD3 50              	push	ax
2D1B:2AD4 8B 5E 06        	mov	bx,[bp+6h]
2D1B:2AD7 8A 87 5F 86     	mov	al,[bx+865Fh]
2D1B:2ADB B4 00           	mov	ah,0h
2D1B:2ADD 50              	push	ax
2D1B:2ADE 8B 5E 06        	mov	bx,[bp+6h]
2D1B:2AE1 8A 87 5B 86     	mov	al,[bx+865Bh]
2D1B:2AE5 B4 00           	mov	ah,0h
2D1B:2AE7 50              	push	ax
2D1B:2AE8 9A 8C 07 00 08  	call	far 0800h:078Ch
2D1B:2AED 8B E5           	mov	sp,bp
2D1B:2AEF EB 00           	jmp	2AF1h

l2D1B_2AF1:
2D1B:2AF1 5D              	pop	bp
2D1B:2AF2 CB              	retf

;; CollapseStructureAtMapCell_2AF3: 2D1B:2AF3
;;   Called from:
;;     2D1B:2961 (in ApplyTerrainImpact_276F)
CollapseStructureAtMapCell_2AF3 proc
2D1B:2AF3 55              	push	bp
2D1B:2AF4 8B EC           	mov	bp,sp
2D1B:2AF6 83 EC 0A        	sub	sp,0Ah
2D1B:2AF9 56              	push	si
2D1B:2AFA 57              	push	di
2D1B:2AFB 8B 7E 08        	mov	di,[bp+8h]
2D1B:2AFE 80 3E A2 84 08  	cmp	byte ptr [84A2h],8h
2D1B:2B03 75 1D           	jnz	2B22h

l2D1B_2B05:
2D1B:2B05 B8 02 00        	mov	ax,2h
2D1B:2B08 89 46 F8        	mov	[bp-8h],ax
2D1B:2B0B 89 46 F6        	mov	[bp-0Ah],ax
2D1B:2B0E F7 46 0A 01 00  	test	word ptr [bp+0Ah],1h
2D1B:2B13 75 03           	jnz	2B18h

l2D1B_2B15:
2D1B:2B15 FF 4E 06        	dec	word ptr [bp+6h]

l2D1B_2B18:
2D1B:2B18 81 7E 0A AB 00  	cmp	word ptr [bp+0Ah],0ABh
2D1B:2B1D 7C 01           	jl	2B20h

l2D1B_2B1F:
2D1B:2B1F 4F              	dec	di

l2D1B_2B20:
2D1B:2B20 EB 30           	jmp	2B52h

l2D1B_2B22:
2D1B:2B22 B8 03 00        	mov	ax,3h
2D1B:2B25 89 46 F8        	mov	[bp-8h],ax
2D1B:2B28 89 46 F6        	mov	[bp-0Ah],ax
2D1B:2B2B 81 6E 0A 8C 00  	sub	word ptr [bp+0Ah],8Ch
2D1B:2B30 80 3E A2 84 05  	cmp	byte ptr [84A2h],5h
2D1B:2B35 75 04           	jnz	2B3Bh

l2D1B_2B37:
2D1B:2B37 83 6E 0A 5A     	sub	word ptr [bp+0Ah],5Ah

l2D1B_2B3B:
2D1B:2B3B 8B 46 0A        	mov	ax,[bp+0Ah]
2D1B:2B3E BB 03 00        	mov	bx,3h
2D1B:2B41 99              	cwd
2D1B:2B42 F7 FB           	idiv	bx
2D1B:2B44 2B F8           	sub	di,ax
2D1B:2B46 8B 46 0A        	mov	ax,[bp+0Ah]
2D1B:2B49 BB 03 00        	mov	bx,3h
2D1B:2B4C 99              	cwd
2D1B:2B4D F7 FB           	idiv	bx
2D1B:2B4F 29 56 06        	sub	[bp+6h],dx

l2D1B_2B52:
2D1B:2B52 C7 46 FA 00 00  	mov	word ptr [bp-6h],0h
2D1B:2B57 E9 B8 00        	jmp	2C12h

l2D1B_2B5A:
2D1B:2B5A C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
2D1B:2B5F E9 A1 00        	jmp	2C03h

l2D1B_2B62:
2D1B:2B62 8B 46 06        	mov	ax,[bp+6h]
2D1B:2B65 03 46 FC        	add	ax,[bp-4h]
2D1B:2B68 89 46 FE        	mov	[bp-2h],ax
2D1B:2B6B EB 13           	jmp	2B80h

l2D1B_2B6D:
2D1B:2B6D B8 01 00        	mov	ax,1h
2D1B:2B70 50              	push	ax
2D1B:2B71 B8 01 00        	mov	ax,1h
2D1B:2B74 50              	push	ax
2D1B:2B75 57              	push	di
2D1B:2B76 FF 76 FE        	push	word ptr [bp-2h]
2D1B:2B79 0E              	push	cs
2D1B:2B7A E8 F2 FB        	call	276Fh
2D1B:2B7D 83 C4 08        	add	sp,8h

l2D1B_2B80:
2D1B:2B80 B8 03 00        	mov	ax,3h
2D1B:2B83 50              	push	ax
2D1B:2B84 57              	push	di
2D1B:2B85 FF 76 FE        	push	word ptr [bp-2h]
2D1B:2B88 9A 50 0C 1F 1A  	call	far 1A1Fh:0C50h
2D1B:2B8D 83 C4 06        	add	sp,6h
2D1B:2B90 3D 03 00        	cmp	ax,3h
2D1B:2B93 7C D8           	jl	2B6Dh

l2D1B_2B95:
2D1B:2B95 B8 01 00        	mov	ax,1h
2D1B:2B98 50              	push	ax
2D1B:2B99 57              	push	di
2D1B:2B9A FF 76 FE        	push	word ptr [bp-2h]
2D1B:2B9D 9A 46 08 07 20  	call	far 2007h:0846h
2D1B:2BA2 83 C4 06        	add	sp,6h
2D1B:2BA5 33 F6           	xor	si,si
2D1B:2BA7 EB 52           	jmp	2BFBh

l2D1B_2BA9:
2D1B:2BA9 8B C6           	mov	ax,si
2D1B:2BAB BA 96 00        	mov	dx,96h
2D1B:2BAE F7 E2           	mul	dx
2D1B:2BB0 8B D8           	mov	bx,ax
2D1B:2BB2 81 C3 81 8B     	add	bx,8B81h
2D1B:2BB6 1E              	push	ds
2D1B:2BB7 07              	pop	es
2D1B:2BB8 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2D1B:2BBC 74 3C           	jz	2BFAh

l2D1B_2BBE:
2D1B:2BBE 8A 84 62 85     	mov	al,[si+8562h]
2D1B:2BC2 B4 00           	mov	ah,0h
2D1B:2BC4 8B 56 FE        	mov	dx,[bp-2h]
2D1B:2BC7 4A              	dec	dx
2D1B:2BC8 3B C2           	cmp	ax,dx
2D1B:2BCA 7C 2E           	jl	2BFAh

l2D1B_2BCC:
2D1B:2BCC 8A 84 62 85     	mov	al,[si+8562h]
2D1B:2BD0 B4 00           	mov	ah,0h
2D1B:2BD2 8B 56 FE        	mov	dx,[bp-2h]
2D1B:2BD5 42              	inc	dx
2D1B:2BD6 3B C2           	cmp	ax,dx
2D1B:2BD8 7F 20           	jg	2BFAh

l2D1B_2BDA:
2D1B:2BDA 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:2BDE B4 00           	mov	ah,0h
2D1B:2BE0 8B D7           	mov	dx,di
2D1B:2BE2 4A              	dec	dx
2D1B:2BE3 3B C2           	cmp	ax,dx
2D1B:2BE5 7C 13           	jl	2BFAh

l2D1B_2BE7:
2D1B:2BE7 8A 84 7B 85     	mov	al,[si+857Bh]
2D1B:2BEB B4 00           	mov	ah,0h
2D1B:2BED 8B D7           	mov	dx,di
2D1B:2BEF 42              	inc	dx
2D1B:2BF0 3B C2           	cmp	ax,dx
2D1B:2BF2 7F 06           	jg	2BFAh

l2D1B_2BF4:
2D1B:2BF4 56              	push	si
2D1B:2BF5 0E              	push	cs
2D1B:2BF6 E8 5A F8        	call	2453h
2D1B:2BF9 59              	pop	cx

l2D1B_2BFA:
2D1B:2BFA 46              	inc	si

l2D1B_2BFB:
2D1B:2BFB 83 FE 18        	cmp	si,18h
2D1B:2BFE 7C A9           	jl	2BA9h

l2D1B_2C00:
2D1B:2C00 FF 46 FC        	inc	word ptr [bp-4h]

l2D1B_2C03:
2D1B:2C03 8B 46 FC        	mov	ax,[bp-4h]
2D1B:2C06 3B 46 F6        	cmp	ax,[bp-0Ah]
2D1B:2C09 7D 03           	jge	2C0Eh

l2D1B_2C0B:
2D1B:2C0B E9 54 FF        	jmp	2B62h

l2D1B_2C0E:
2D1B:2C0E FF 46 FA        	inc	word ptr [bp-6h]
2D1B:2C11 47              	inc	di

l2D1B_2C12:
2D1B:2C12 8B 46 FA        	mov	ax,[bp-6h]
2D1B:2C15 3B 46 F8        	cmp	ax,[bp-8h]
2D1B:2C18 7D 03           	jge	2C1Dh

l2D1B_2C1A:
2D1B:2C1A E9 3D FF        	jmp	2B5Ah

l2D1B_2C1D:
2D1B:2C1D 5F              	pop	di
2D1B:2C1E 5E              	pop	si
2D1B:2C1F 8B E5           	mov	sp,bp
2D1B:2C21 5D              	pop	bp
2D1B:2C22 CB              	retf

;; AdvanceUnitRouteWaypoint_2C23: 2D1B:2C23
;;   Called from:
;;     2D1B:0493 (in MoveUnitTowardMapCell_03EA)
;;     2D1B:058C (in MoveUnitTowardMapCell_03EA)
AdvanceUnitRouteWaypoint_2C23 proc
2D1B:2C23 55              	push	bp
2D1B:2C24 8B EC           	mov	bp,sp
2D1B:2C26 56              	push	si
2D1B:2C27 8B 76 06        	mov	si,[bp+6h]
2D1B:2C2A 8B C6           	mov	ax,si
2D1B:2C2C BA 0B 00        	mov	dx,0Bh
2D1B:2C2F F7 E2           	mul	dx
2D1B:2C31 8B D8           	mov	bx,ax
2D1B:2C33 81 C3 C1 86     	add	bx,86C1h
2D1B:2C37 1E              	push	ds
2D1B:2C38 07              	pop	es
2D1B:2C39 26 80 3F 03     	cmp	byte ptr es:[bx],3h
2D1B:2C3D 7D 72           	jge	2CB1h

l2D1B_2C3F:
2D1B:2C3F 8B C6           	mov	ax,si
2D1B:2C41 BA 0B 00        	mov	dx,0Bh
2D1B:2C44 F7 E2           	mul	dx
2D1B:2C46 8B D8           	mov	bx,ax
2D1B:2C48 81 C3 C1 86     	add	bx,86C1h
2D1B:2C4C 1E              	push	ds
2D1B:2C4D 07              	pop	es
2D1B:2C4E 26 FE 07        	inc	byte ptr es:[bx]
2D1B:2C51 8B C6           	mov	ax,si
2D1B:2C53 BA 0B 00        	mov	dx,0Bh
2D1B:2C56 F7 E2           	mul	dx
2D1B:2C58 8B D8           	mov	bx,ax
2D1B:2C5A 81 C3 C1 86     	add	bx,86C1h
2D1B:2C5E 1E              	push	ds
2D1B:2C5F 07              	pop	es
2D1B:2C60 8B C6           	mov	ax,si
2D1B:2C62 BA 0B 00        	mov	dx,0Bh
2D1B:2C65 F7 E2           	mul	dx
2D1B:2C67 06              	push	es
2D1B:2C68 53              	push	bx
2D1B:2C69 8B D8           	mov	bx,ax
2D1B:2C6B 81 C3 C1 86     	add	bx,86C1h
2D1B:2C6F 1E              	push	ds
2D1B:2C70 07              	pop	es
2D1B:2C71 26 8A 07        	mov	al,es:[bx]
2D1B:2C74 98              	cbw
2D1B:2C75 5B              	pop	bx
2D1B:2C76 07              	pop	es
2D1B:2C77 03 D8           	add	bx,ax
2D1B:2C79 26 8A 47 03     	mov	al,es:[bx+3h]
2D1B:2C7D 88 84 40 83     	mov	[si+8340h],al
2D1B:2C81 8B C6           	mov	ax,si
2D1B:2C83 BA 0B 00        	mov	dx,0Bh
2D1B:2C86 F7 E2           	mul	dx
2D1B:2C88 8B D8           	mov	bx,ax
2D1B:2C8A 81 C3 C1 86     	add	bx,86C1h
2D1B:2C8E 1E              	push	ds
2D1B:2C8F 07              	pop	es
2D1B:2C90 8B C6           	mov	ax,si
2D1B:2C92 BA 0B 00        	mov	dx,0Bh
2D1B:2C95 F7 E2           	mul	dx
2D1B:2C97 06              	push	es
2D1B:2C98 53              	push	bx
2D1B:2C99 8B D8           	mov	bx,ax
2D1B:2C9B 81 C3 C1 86     	add	bx,86C1h
2D1B:2C9F 1E              	push	ds
2D1B:2CA0 07              	pop	es
2D1B:2CA1 26 8A 07        	mov	al,es:[bx]
2D1B:2CA4 98              	cbw
2D1B:2CA5 5B              	pop	bx
2D1B:2CA6 07              	pop	es
2D1B:2CA7 03 D8           	add	bx,ax
2D1B:2CA9 26 8A 47 07     	mov	al,es:[bx+7h]
2D1B:2CAD 88 84 8E 83     	mov	[si+838Eh],al

l2D1B_2CB1:
2D1B:2CB1 5E              	pop	si
2D1B:2CB2 5D              	pop	bp
2D1B:2CB3 CB              	retf

;; ShouldDestroyUnitAfterLegLoss_2CB4: 2D1B:2CB4
;;   Called from:
;;     2D1B:227D (in ApplyWeaponDamage_1E2B)
;;     2D1B:22C6 (in ApplyWeaponDamage_1E2B)
ShouldDestroyUnitAfterLegLoss_2CB4 proc
2D1B:2CB4 56              	push	si
2D1B:2CB5 33 F6           	xor	si,si
2D1B:2CB7 83 3E 81 B5 36  	cmp	word ptr [0B581h],36h
2D1B:2CBC 7C 0A           	jl	2CC8h

l2D1B_2CBE:
2D1B:2CBE 83 3E 81 B5 39  	cmp	word ptr [0B581h],39h
2D1B:2CC3 7F 03           	jg	2CC8h

l2D1B_2CC5:
2D1B:2CC5 BE 01 00        	mov	si,1h

l2D1B_2CC8:
2D1B:2CC8 83 3E 81 B5 42  	cmp	word ptr [0B581h],42h
2D1B:2CCD 7C 0A           	jl	2CD9h

l2D1B_2CCF:
2D1B:2CCF 83 3E 81 B5 43  	cmp	word ptr [0B581h],43h
2D1B:2CD4 7F 03           	jg	2CD9h

l2D1B_2CD6:
2D1B:2CD6 BE 01 00        	mov	si,1h

l2D1B_2CD9:
2D1B:2CD9 83 3E 81 B5 45  	cmp	word ptr [0B581h],45h
2D1B:2CDE 75 03           	jnz	2CE3h

l2D1B_2CE0:
2D1B:2CE0 BE 01 00        	mov	si,1h

l2D1B_2CE3:
2D1B:2CE3 83 3E 81 B5 4C  	cmp	word ptr [0B581h],4Ch
2D1B:2CE8 7C 0A           	jl	2CF4h

l2D1B_2CEA:
2D1B:2CEA 83 3E 81 B5 53  	cmp	word ptr [0B581h],53h
2D1B:2CEF 7F 03           	jg	2CF4h
