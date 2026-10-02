;;; Segment 2007 (2007:0000)
2007:0000 06 88 87 AC 99 5D CB                            .....].         

;; ComposeTacticalSpriteMaps_0007: 2007:0007
;;   Called from:
;;     2007:067D (in RebuildTacticalViewport_0650)
ComposeTacticalSpriteMaps_0007 proc
2007:0007 55              	push	bp
2007:0008 8B EC           	mov	bp,sp
2007:000A 83 EC 0A        	sub	sp,0Ah
2007:000D 56              	push	si
2007:000E 57              	push	di
2007:000F 33 F6           	xor	si,si
2007:0011 EB 6B           	jmp	007Eh

l2007_0013:
2007:0013 8B C6           	mov	ax,si
2007:0015 BA 03 00        	mov	dx,3h
2007:0018 F7 E2           	mul	dx
2007:001A 8B D8           	mov	bx,ax
2007:001C 81 C3 5B 88     	add	bx,885Bh
2007:0020 1E              	push	ds
2007:0021 07              	pop	es
2007:0022 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2007:0027 74 54           	jz	007Dh

l2007_0029:
2007:0029 8B C6           	mov	ax,si
2007:002B BA 03 00        	mov	dx,3h
2007:002E F7 E2           	mul	dx
2007:0030 8B D8           	mov	bx,ax
2007:0032 81 C3 5B 88     	add	bx,885Bh
2007:0036 1E              	push	ds
2007:0037 07              	pop	es
2007:0038 26 8A 47 02     	mov	al,es:[bx+2h]
2007:003C B4 00           	mov	ah,0h
2007:003E 05 00 01        	add	ax,100h
2007:0041 50              	push	ax
2007:0042 B8 01 00        	mov	ax,1h
2007:0045 50              	push	ax
2007:0046 B8 01 00        	mov	ax,1h
2007:0049 50              	push	ax
2007:004A 8B C6           	mov	ax,si
2007:004C BA 03 00        	mov	dx,3h
2007:004F F7 E2           	mul	dx
2007:0051 8B D8           	mov	bx,ax
2007:0053 81 C3 5B 88     	add	bx,885Bh
2007:0057 1E              	push	ds
2007:0058 07              	pop	es
2007:0059 26 8A 47 01     	mov	al,es:[bx+1h]
2007:005D B4 00           	mov	ah,0h
2007:005F 50              	push	ax
2007:0060 8B C6           	mov	ax,si
2007:0062 BA 03 00        	mov	dx,3h
2007:0065 F7 E2           	mul	dx
2007:0067 8B D8           	mov	bx,ax
2007:0069 81 C3 5B 88     	add	bx,885Bh
2007:006D 1E              	push	ds
2007:006E 07              	pop	es
2007:006F 26 8A 07        	mov	al,es:[bx]
2007:0072 B4 00           	mov	ah,0h
2007:0074 50              	push	ax
2007:0075 9A 1A 02 07 20  	call	far 2007h:021Ah
2007:007A 83 C4 0A        	add	sp,0Ah

l2007_007D:
2007:007D 46              	inc	si

l2007_007E:
2007:007E 83 FE 18        	cmp	si,18h
2007:0081 7C 90           	jl	0013h

l2007_0083:
2007:0083 33 F6           	xor	si,si
2007:0085 EB 2A           	jmp	00B1h

l2007_0087:
2007:0087 80 BC 57 86 00  	cmp	byte ptr [si+8657h],0h
2007:008C 74 22           	jz	00B0h

l2007_008E:
2007:008E B8 DA 01        	mov	ax,1DAh
2007:0091 50              	push	ax
2007:0092 B8 01 00        	mov	ax,1h
2007:0095 50              	push	ax
2007:0096 B8 01 00        	mov	ax,1h
2007:0099 50              	push	ax
2007:009A 8A 84 5F 86     	mov	al,[si+865Fh]
2007:009E B4 00           	mov	ah,0h
2007:00A0 50              	push	ax
2007:00A1 8A 84 5B 86     	mov	al,[si+865Bh]
2007:00A5 B4 00           	mov	ah,0h
2007:00A7 50              	push	ax
2007:00A8 9A 1A 02 07 20  	call	far 2007h:021Ah
2007:00AD 83 C4 0A        	add	sp,0Ah

l2007_00B0:
2007:00B0 46              	inc	si

l2007_00B1:
2007:00B1 83 FE 04        	cmp	si,4h
2007:00B4 7C D1           	jl	0087h

l2007_00B6:
2007:00B6 33 F6           	xor	si,si
2007:00B8 E9 DA 00        	jmp	0195h

l2007_00BB:
2007:00BB 8B C6           	mov	ax,si
2007:00BD BA 96 00        	mov	dx,96h
2007:00C0 F7 E2           	mul	dx
2007:00C2 8B D8           	mov	bx,ax
2007:00C4 81 C3 81 8B     	add	bx,8B81h
2007:00C8 1E              	push	ds
2007:00C9 07              	pop	es
2007:00CA 26 80 3F 01     	cmp	byte ptr es:[bx],1h
2007:00CE 74 03           	jz	00D3h

l2007_00D0:
2007:00D0 E9 C1 00        	jmp	0194h

l2007_00D3:
2007:00D3 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2007:00D8 83 FE 0C        	cmp	si,0Ch
2007:00DB 7D 07           	jge	00E4h

l2007_00DD:
2007:00DD C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h
2007:00E2 EB 4A           	jmp	012Eh

l2007_00E4:
2007:00E4 83 3E E5 03 00  	cmp	word ptr [03E5h],0h
2007:00E9 74 3E           	jz	0129h

l2007_00EB:
2007:00EB 8A 84 67 86     	mov	al,[si+8667h]
2007:00EF 98              	cbw
2007:00F0 89 46 F6        	mov	[bp-0Ah],ax
2007:00F3 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2007:00F7 75 2E           	jnz	0127h

l2007_00F9:
2007:00F9 80 BC 80 86 00  	cmp	byte ptr [si+8680h],0h
2007:00FE 74 27           	jz	0127h

l2007_0100:
2007:0100 B8 EF 01        	mov	ax,1EFh
2007:0103 50              	push	ax
2007:0104 B8 01 00        	mov	ax,1h
2007:0107 50              	push	ax
2007:0108 B8 01 00        	mov	ax,1h
2007:010B 50              	push	ax
2007:010C 8A 84 7B 85     	mov	al,[si+857Bh]
2007:0110 B4 00           	mov	ah,0h
2007:0112 50              	push	ax
2007:0113 8A 84 62 85     	mov	al,[si+8562h]
2007:0117 B4 00           	mov	ah,0h
2007:0119 50              	push	ax
2007:011A 9A 1A 02 07 20  	call	far 2007h:021Ah
2007:011F 83 C4 0A        	add	sp,0Ah
2007:0122 C7 46 FE 01 00  	mov	word ptr [bp-2h],1h

l2007_0127:
2007:0127 EB 05           	jmp	012Eh

l2007_0129:
2007:0129 C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h

l2007_012E:
2007:012E 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
2007:0132 74 49           	jz	017Dh

l2007_0134:
2007:0134 80 BC 27 88 00  	cmp	byte ptr [si+8827h],0h
2007:0139 74 1A           	jz	0155h

l2007_013B:
2007:013B 80 BC 3D AE 00  	cmp	byte ptr [si+0AE3Dh],0h
2007:0140 74 13           	jz	0155h

l2007_0142:
2007:0142 8A 84 62 85     	mov	al,[si+8562h]
2007:0146 32 84 7B 85     	xor	al,[si+857Bh]
2007:014A B4 00           	mov	ah,0h
2007:014C 25 01 00        	and	ax,1h
2007:014F 05 F1 01        	add	ax,1F1h
2007:0152 A3 BC 84        	mov	[84BCh],ax

l2007_0155:
2007:0155 8B DE           	mov	bx,si
2007:0157 D1 E3           	shl	bx,1h
2007:0159 FF B7 6B AE     	push	word ptr [bx+0AE6Bh]
2007:015D B8 01 00        	mov	ax,1h
2007:0160 50              	push	ax
2007:0161 B8 01 00        	mov	ax,1h
2007:0164 50              	push	ax
2007:0165 8A 84 7B 85     	mov	al,[si+857Bh]
2007:0169 B4 00           	mov	ah,0h
2007:016B 50              	push	ax
2007:016C 8A 84 62 85     	mov	al,[si+8562h]
2007:0170 B4 00           	mov	ah,0h
2007:0172 50              	push	ax
2007:0173 9A 1A 02 07 20  	call	far 2007h:021Ah
2007:0178 83 C4 0A        	add	sp,0Ah
2007:017B EB 17           	jmp	0194h

l2007_017D:
2007:017D 83 FE 0C        	cmp	si,0Ch
2007:0180 7C 12           	jl	0194h

l2007_0182:
2007:0182 3B 36 DC 03     	cmp	si,[03DCh]
2007:0186 75 0C           	jnz	0194h

l2007_0188:
2007:0188 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2007:018C 75 06           	jnz	0194h

l2007_018E:
2007:018E C7 06 DC 03 FF FF 	mov	word ptr [03DCh],0FFFFh

l2007_0194:
2007:0194 46              	inc	si

l2007_0195:
2007:0195 83 FE 18        	cmp	si,18h
2007:0198 7D 03           	jge	019Dh

l2007_019A:
2007:019A E9 1E FF        	jmp	00BBh

l2007_019D:
2007:019D 33 FF           	xor	di,di
2007:019F 33 F6           	xor	si,si
2007:01A1 EB 3F           	jmp	01E2h

l2007_01A3:
2007:01A3 8B DF           	mov	bx,di
2007:01A5 D1 E3           	shl	bx,1h
2007:01A7 8B 87 00 A8     	mov	ax,[bx+0A800h]
2007:01AB 89 46 F8        	mov	[bp-8h],ax
2007:01AE 47              	inc	di
2007:01AF 8B DF           	mov	bx,di
2007:01B1 D1 E3           	shl	bx,1h
2007:01B3 8B 87 00 A8     	mov	ax,[bx+0A800h]
2007:01B7 89 46 FA        	mov	[bp-6h],ax
2007:01BA 47              	inc	di
2007:01BB 8B DF           	mov	bx,di
2007:01BD D1 E3           	shl	bx,1h
2007:01BF 8B 87 00 A8     	mov	ax,[bx+0A800h]
2007:01C3 89 46 FC        	mov	[bp-4h],ax
2007:01C6 47              	inc	di
2007:01C7 47              	inc	di
2007:01C8 FF 76 FC        	push	word ptr [bp-4h]
2007:01CB B8 02 00        	mov	ax,2h
2007:01CE 50              	push	ax
2007:01CF B8 02 00        	mov	ax,2h
2007:01D2 50              	push	ax
2007:01D3 FF 76 FA        	push	word ptr [bp-6h]
2007:01D6 FF 76 F8        	push	word ptr [bp-8h]
2007:01D9 9A 1A 02 07 20  	call	far 2007h:021Ah
2007:01DE 83 C4 0A        	add	sp,0Ah
2007:01E1 46              	inc	si

l2007_01E2:
2007:01E2 3B 36 7F B5     	cmp	si,[0B57Fh]
2007:01E6 7C BB           	jl	01A3h

l2007_01E8:
2007:01E8 5F              	pop	di
2007:01E9 5E              	pop	si
2007:01EA 8B E5           	mov	sp,bp
2007:01EC 5D              	pop	bp
2007:01ED CB              	retf

;; DrawTileAlignedText_01EE: 2007:01EE
;;   Called from:
;;     0D73:57AB (in ShowScenarioCompletionStatus_5789)
;;     0D73:57CA (in ShowScenarioCompletionStatus_5789)
;;     1A1F:4C21 (in HandleTacticalInput_4A9E)
;;     2007:0ED8 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:1176 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:11A9 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:1202 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:165A (in DrawCampaignClock_15FF)
;;     2007:16AC (in DrawCampaignClock_15FF)
;;     2007:1DFE (in DrawCampaignClockSeparator_1DCC)
;;     2208:15EA (in RunTacticalGameOptionsMenu_148A)
;;     2208:1609 (in RunTacticalGameOptionsMenu_148A)
;;     2B34:0755 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:077D (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:07E1 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:080D (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0A0D (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0AB2 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0AF7 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0B63 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0BB6 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0BE1 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:100B (in DrawCenteredTextInActiveWindow_0FDB)
DrawTileAlignedText_01EE proc
2007:01EE 55              	push	bp
2007:01EF 8B EC           	mov	bp,sp
2007:01F1 FF 76 10        	push	word ptr [bp+10h]
2007:01F4 FF 76 0E        	push	word ptr [bp+0Eh]
2007:01F7 8B 46 0C        	mov	ax,[bp+0Ch]
2007:01FA D1 E0           	shl	ax,1h
2007:01FC D1 E0           	shl	ax,1h
2007:01FE D1 E0           	shl	ax,1h
2007:0200 50              	push	ax
2007:0201 8B 46 0A        	mov	ax,[bp+0Ah]
2007:0204 D1 E0           	shl	ax,1h
2007:0206 D1 E0           	shl	ax,1h
2007:0208 D1 E0           	shl	ax,1h
2007:020A 50              	push	ax
2007:020B FF 76 08        	push	word ptr [bp+8h]
2007:020E FF 76 06        	push	word ptr [bp+6h]
2007:0211 9A 0B 47 00 08  	call	far 0800h:470Bh
2007:0216 8B E5           	mov	sp,bp
2007:0218 5D              	pop	bp
2007:0219 CB              	retf

;; StampTacticalSpriteRectangle_021A: 2007:021A
;;   Called from:
;;     2007:0075 (in ComposeTacticalSpriteMaps_0007)
;;     2007:00A8 (in ComposeTacticalSpriteMaps_0007)
;;     2007:011A (in ComposeTacticalSpriteMaps_0007)
;;     2007:0173 (in ComposeTacticalSpriteMaps_0007)
;;     2007:01D9 (in ComposeTacticalSpriteMaps_0007)
StampTacticalSpriteRectangle_021A proc
2007:021A 55              	push	bp
2007:021B 8B EC           	mov	bp,sp
2007:021D 83 EC 08        	sub	sp,8h
2007:0220 56              	push	si
2007:0221 57              	push	di
2007:0222 8B 7E 08        	mov	di,[bp+8h]
2007:0225 8B 76 06        	mov	si,[bp+6h]
2007:0228 A1 A0 84        	mov	ax,[84A0h]
2007:022B 05 13 00        	add	ax,13h
2007:022E 3B C6           	cmp	ax,si
2007:0230 7F 03           	jg	0235h

l2007_0232:
2007:0232 E9 E7 00        	jmp	031Ch

l2007_0235:
2007:0235 A1 DA 83        	mov	ax,[83DAh]
2007:0238 05 0C 00        	add	ax,0Ch
2007:023B 3B C7           	cmp	ax,di
2007:023D 7F 03           	jg	0242h

l2007_023F:
2007:023F E9 DA 00        	jmp	031Ch

l2007_0242:
2007:0242 8B C6           	mov	ax,si
2007:0244 03 46 0A        	add	ax,[bp+0Ah]
2007:0247 3B 06 A0 84     	cmp	ax,[84A0h]
2007:024B 7F 03           	jg	0250h

l2007_024D:
2007:024D E9 CC 00        	jmp	031Ch

l2007_0250:
2007:0250 8B C7           	mov	ax,di
2007:0252 03 46 0C        	add	ax,[bp+0Ch]
2007:0255 3B 06 DA 83     	cmp	ax,[83DAh]
2007:0259 7F 03           	jg	025Eh

l2007_025B:
2007:025B E9 BE 00        	jmp	031Ch

l2007_025E:
2007:025E 8B 46 0A        	mov	ax,[bp+0Ah]
2007:0261 89 46 F8        	mov	[bp-8h],ax
2007:0264 2B 36 A0 84     	sub	si,[84A0h]
2007:0268 2B 3E DA 83     	sub	di,[83DAh]
2007:026C 0B FF           	or	di,di
2007:026E 7D 0F           	jge	027Fh

l2007_0270:
2007:0270 01 7E 0C        	add	[bp+0Ch],di
2007:0273 8B C7           	mov	ax,di
2007:0275 F7 D8           	neg	ax
2007:0277 F7 66 F8        	mul	word ptr [bp-8h]
2007:027A 01 46 0E        	add	[bp+0Eh],ax
2007:027D 33 FF           	xor	di,di

l2007_027F:
2007:027F 0B F6           	or	si,si
2007:0281 7D 08           	jge	028Bh

l2007_0283:
2007:0283 01 76 0A        	add	[bp+0Ah],si
2007:0286 29 76 0E        	sub	[bp+0Eh],si
2007:0289 33 F6           	xor	si,si

l2007_028B:
2007:028B 8B C6           	mov	ax,si
2007:028D 03 46 0A        	add	ax,[bp+0Ah]
2007:0290 3D 13 00        	cmp	ax,13h
2007:0293 7E 08           	jle	029Dh

l2007_0295:
2007:0295 B8 13 00        	mov	ax,13h
2007:0298 2B C6           	sub	ax,si
2007:029A 89 46 0A        	mov	[bp+0Ah],ax

l2007_029D:
2007:029D 8B C7           	mov	ax,di
2007:029F 03 46 0C        	add	ax,[bp+0Ch]
2007:02A2 3D 0C 00        	cmp	ax,0Ch
2007:02A5 7E 08           	jle	02AFh

l2007_02A7:
2007:02A7 B8 0C 00        	mov	ax,0Ch
2007:02AA 2B C7           	sub	ax,di
2007:02AC 89 46 0C        	mov	[bp+0Ch],ax

l2007_02AF:
2007:02AF 8B C7           	mov	ax,di
2007:02B1 BA 13 00        	mov	dx,13h
2007:02B4 F7 E2           	mul	dx
2007:02B6 03 C6           	add	ax,si
2007:02B8 89 46 FA        	mov	[bp-6h],ax
2007:02BB EB 55           	jmp	0312h

l2007_02BD:
2007:02BD 8B 46 0E        	mov	ax,[bp+0Eh]
2007:02C0 89 46 FC        	mov	[bp-4h],ax
2007:02C3 83 3E BC 84 00  	cmp	word ptr [84BCh],0h
2007:02C8 74 11           	jz	02DBh

l2007_02CA:
2007:02CA A1 BC 84        	mov	ax,[84BCh]
2007:02CD 8B 56 FA        	mov	dx,[bp-6h]
2007:02D0 D1 E2           	shl	dx,1h
2007:02D2 C4 1E 23 88     	les	bx,[8823h]
2007:02D6 03 DA           	add	bx,dx
2007:02D8 26 89 07        	mov	es:[bx],ax

l2007_02DB:
2007:02DB C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2007:02E0 EB 1E           	jmp	0300h

l2007_02E2:
2007:02E2 8B 46 FC        	mov	ax,[bp-4h]
2007:02E5 8B 56 FA        	mov	dx,[bp-6h]
2007:02E8 D1 E2           	shl	dx,1h
2007:02EA C4 1E BC 99     	les	bx,[99BCh]
2007:02EE 03 DA           	add	bx,dx
2007:02F0 8B 56 FE        	mov	dx,[bp-2h]
2007:02F3 D1 E2           	shl	dx,1h
2007:02F5 03 DA           	add	bx,dx
2007:02F7 26 89 07        	mov	es:[bx],ax
2007:02FA FF 46 FC        	inc	word ptr [bp-4h]
2007:02FD FF 46 FE        	inc	word ptr [bp-2h]

l2007_0300:
2007:0300 8B 46 FE        	mov	ax,[bp-2h]
2007:0303 3B 46 0A        	cmp	ax,[bp+0Ah]
2007:0306 7C DA           	jl	02E2h

l2007_0308:
2007:0308 8B 46 F8        	mov	ax,[bp-8h]
2007:030B 01 46 0E        	add	[bp+0Eh],ax
2007:030E 83 46 FA 13     	add	word ptr [bp-6h],13h

l2007_0312:
2007:0312 8B 46 0C        	mov	ax,[bp+0Ch]
2007:0315 FF 4E 0C        	dec	word ptr [bp+0Ch]
2007:0318 0B C0           	or	ax,ax
2007:031A 75 A1           	jnz	02BDh

l2007_031C:
2007:031C C7 06 BC 84 00 00 	mov	word ptr [84BCh],0h
2007:0322 5F              	pop	di
2007:0323 5E              	pop	si
2007:0324 8B E5           	mov	sp,bp
2007:0326 5D              	pop	bp
2007:0327 CB              	retf

;; DrawTacticalViewportCell_0328: 2007:0328
;;   Called from:
;;     2007:069C (in RebuildTacticalViewport_0650)
DrawTacticalViewportCell_0328 proc
2007:0328 55              	push	bp
2007:0329 8B EC           	mov	bp,sp
2007:032B 56              	push	si
2007:032C 57              	push	di
2007:032D 8B 76 0A        	mov	si,[bp+0Ah]
2007:0330 8B 7E 06        	mov	di,[bp+6h]
2007:0333 8B C6           	mov	ax,si
2007:0335 D1 E0           	shl	ax,1h
2007:0337 C4 1E BC 99     	les	bx,[99BCh]
2007:033B 03 D8           	add	bx,ax
2007:033D 26 83 3F 00     	cmp	word ptr es:[bx],0h
2007:0341 74 79           	jz	03BCh

l2007_0343:
2007:0343 80 BC 78 79 00  	cmp	byte ptr [si+7978h],0h
2007:0348 74 37           	jz	0381h

l2007_034A:
2007:034A 8B 46 08        	mov	ax,[bp+8h]
2007:034D B1 04           	mov	cl,4h
2007:034F D3 E0           	shl	ax,cl
2007:0351 50              	push	ax
2007:0352 8B C7           	mov	ax,di
2007:0354 D1 E0           	shl	ax,1h
2007:0356 40              	inc	ax
2007:0357 40              	inc	ax
2007:0358 50              	push	ax
2007:0359 FF 36 E4 83     	push	word ptr [83E4h]
2007:035D FF 36 E2 83     	push	word ptr [83E2h]
2007:0361 8A 84 78 79     	mov	al,[si+7978h]
2007:0365 98              	cbw
2007:0366 05 F2 01        	add	ax,1F2h
2007:0369 50              	push	ax
2007:036A 8B C6           	mov	ax,si
2007:036C D1 E0           	shl	ax,1h
2007:036E C4 1E BC 99     	les	bx,[99BCh]
2007:0372 03 D8           	add	bx,ax
2007:0374 26 FF 37        	push	word ptr es:[bx]
2007:0377 9A 83 24 00 08  	call	far 0800h:2483h
2007:037C 83 C4 0C        	add	sp,0Ch
2007:037F EB 39           	jmp	03BAh

l2007_0381:
2007:0381 8B 46 08        	mov	ax,[bp+8h]
2007:0384 B1 04           	mov	cl,4h
2007:0386 D3 E0           	shl	ax,cl
2007:0388 50              	push	ax
2007:0389 8B C7           	mov	ax,di
2007:038B D1 E0           	shl	ax,1h
2007:038D 40              	inc	ax
2007:038E 40              	inc	ax
2007:038F 50              	push	ax
2007:0390 FF 36 E4 83     	push	word ptr [83E4h]
2007:0394 FF 36 E2 83     	push	word ptr [83E2h]
2007:0398 8B C6           	mov	ax,si
2007:039A D1 E0           	shl	ax,1h
2007:039C C4 1E 23 88     	les	bx,[8823h]
2007:03A0 03 D8           	add	bx,ax
2007:03A2 26 FF 37        	push	word ptr es:[bx]
2007:03A5 8B C6           	mov	ax,si
2007:03A7 D1 E0           	shl	ax,1h
2007:03A9 C4 1E BC 99     	les	bx,[99BCh]
2007:03AD 03 D8           	add	bx,ax
2007:03AF 26 FF 37        	push	word ptr es:[bx]
2007:03B2 9A 83 24 00 08  	call	far 0800h:2483h
2007:03B7 83 C4 0C        	add	sp,0Ch

l2007_03BA:
2007:03BA EB 6A           	jmp	0426h

l2007_03BC:
2007:03BC 80 BC 78 79 00  	cmp	byte ptr [si+7978h],0h
2007:03C1 74 37           	jz	03FAh

l2007_03C3:
2007:03C3 8B 46 08        	mov	ax,[bp+8h]
2007:03C6 B1 04           	mov	cl,4h
2007:03C8 D3 E0           	shl	ax,cl
2007:03CA 50              	push	ax
2007:03CB 8B C7           	mov	ax,di
2007:03CD D1 E0           	shl	ax,1h
2007:03CF 40              	inc	ax
2007:03D0 40              	inc	ax
2007:03D1 50              	push	ax
2007:03D2 FF 36 E4 83     	push	word ptr [83E4h]
2007:03D6 FF 36 E2 83     	push	word ptr [83E2h]
2007:03DA 8B C6           	mov	ax,si
2007:03DC D1 E0           	shl	ax,1h
2007:03DE C4 1E 23 88     	les	bx,[8823h]
2007:03E2 03 D8           	add	bx,ax
2007:03E4 26 FF 37        	push	word ptr es:[bx]
2007:03E7 8A 84 78 79     	mov	al,[si+7978h]
2007:03EB 98              	cbw
2007:03EC 05 F2 01        	add	ax,1F2h
2007:03EF 50              	push	ax
2007:03F0 9A 83 24 00 08  	call	far 0800h:2483h
2007:03F5 83 C4 0C        	add	sp,0Ch
2007:03F8 EB 2C           	jmp	0426h

l2007_03FA:
2007:03FA 8B 46 08        	mov	ax,[bp+8h]
2007:03FD B1 04           	mov	cl,4h
2007:03FF D3 E0           	shl	ax,cl
2007:0401 50              	push	ax
2007:0402 8B C7           	mov	ax,di
2007:0404 D1 E0           	shl	ax,1h
2007:0406 40              	inc	ax
2007:0407 40              	inc	ax
2007:0408 50              	push	ax
2007:0409 8B C6           	mov	ax,si
2007:040B D1 E0           	shl	ax,1h
2007:040D C4 1E 23 88     	les	bx,[8823h]
2007:0411 03 D8           	add	bx,ax
2007:0413 26 FF 37        	push	word ptr es:[bx]
2007:0416 FF 36 E4 83     	push	word ptr [83E4h]
2007:041A FF 36 E2 83     	push	word ptr [83E2h]
2007:041E 9A 6F 11 00 08  	call	far 0800h:116Fh
2007:0423 83 C4 0A        	add	sp,0Ah

l2007_0426:
2007:0426 5F              	pop	di
2007:0427 5E              	pop	si
2007:0428 5D              	pop	bp
2007:0429 CB              	retf

;; AdvanceTerrainEffects_042A: 2007:042A
;;   Called from:
;;     2007:1D13 (in RefreshTacticalDisplay_1D06)
;;     2007:1D38 (in RefreshTacticalDisplay_1D06)
AdvanceTerrainEffects_042A proc
2007:042A 55              	push	bp
2007:042B 8B EC           	mov	bp,sp
2007:042D 83 EC 06        	sub	sp,6h
2007:0430 56              	push	si
2007:0431 57              	push	di
2007:0432 83 7E 06 00     	cmp	word ptr [bp+6h],0h
2007:0436 75 03           	jnz	043Bh

l2007_0438:
2007:0438 E9 A7 00        	jmp	04E2h

l2007_043B:
2007:043B 33 F6           	xor	si,si
2007:043D E9 99 00        	jmp	04D9h

l2007_0440:
2007:0440 8B DE           	mov	bx,si
2007:0442 D1 E3           	shl	bx,1h
2007:0444 8B 87 8E B2     	mov	ax,[bx+0B28Eh]
2007:0448 89 46 FA        	mov	[bp-6h],ax
2007:044B 8B DE           	mov	bx,si
2007:044D 43              	inc	bx
2007:044E D1 E3           	shl	bx,1h
2007:0450 8B 87 8E B2     	mov	ax,[bx+0B28Eh]
2007:0454 89 46 FC        	mov	[bp-4h],ax
2007:0457 C4 1E 5F AE     	les	bx,[0AE5Fh]
2007:045B 03 5E FA        	add	bx,[bp-6h]
2007:045E 26 8A 07        	mov	al,es:[bx]
2007:0461 B4 00           	mov	ah,0h
2007:0463 89 46 FE        	mov	[bp-2h],ax
2007:0466 8B 5E FC        	mov	bx,[bp-4h]
2007:0469 8A 87 2E 2F     	mov	al,[bx+2F2Eh]
2007:046D 22 46 FE        	and	al,[bp-2h]
2007:0470 8B 5E FC        	mov	bx,[bp-4h]
2007:0473 3A 87 2E 2F     	cmp	al,[bx+2F2Eh]
2007:0477 74 13           	jz	048Ch

l2007_0479:
2007:0479 8B 5E FC        	mov	bx,[bp-4h]
2007:047C 8A 87 32 2F     	mov	al,[bx+2F32h]
2007:0480 C4 1E 5F AE     	les	bx,[0AE5Fh]
2007:0484 03 5E FA        	add	bx,[bp-6h]
2007:0487 26 00 07        	add	es:[bx],al
2007:048A EB 4B           	jmp	04D7h

l2007_048C:
2007:048C 8B 5E FC        	mov	bx,[bp-4h]
2007:048F 8A 87 2E 2F     	mov	al,[bx+2F2Eh]
2007:0493 C4 1E 5F AE     	les	bx,[0AE5Fh]
2007:0497 03 5E FA        	add	bx,[bp-6h]
2007:049A 26 30 07        	xor	es:[bx],al
2007:049D 8B FE           	mov	di,si
2007:049F 47              	inc	di
2007:04A0 47              	inc	di
2007:04A1 EB 27           	jmp	04CAh

l2007_04A3:
2007:04A3 8B DF           	mov	bx,di
2007:04A5 D1 E3           	shl	bx,1h
2007:04A7 8B 87 8E B2     	mov	ax,[bx+0B28Eh]
2007:04AB 8B DF           	mov	bx,di
2007:04AD 83 C3 FE        	add	bx,0FEh
2007:04B0 D1 E3           	shl	bx,1h
2007:04B2 89 87 8E B2     	mov	[bx+0B28Eh],ax
2007:04B6 8B DF           	mov	bx,di
2007:04B8 43              	inc	bx
2007:04B9 D1 E3           	shl	bx,1h
2007:04BB 8B 87 8E B2     	mov	ax,[bx+0B28Eh]
2007:04BF 8B DF           	mov	bx,di
2007:04C1 4B              	dec	bx
2007:04C2 D1 E3           	shl	bx,1h
2007:04C4 89 87 8E B2     	mov	[bx+0B28Eh],ax
2007:04C8 47              	inc	di
2007:04C9 47              	inc	di

l2007_04CA:
2007:04CA 3B 3E 06 81     	cmp	di,[8106h]
2007:04CE 7C D3           	jl	04A3h

l2007_04D0:
2007:04D0 83 2E 06 81 02  	sub	word ptr [8106h],2h
2007:04D5 4E              	dec	si
2007:04D6 4E              	dec	si

l2007_04D7:
2007:04D7 46              	inc	si
2007:04D8 46              	inc	si

l2007_04D9:
2007:04D9 3B 36 06 81     	cmp	si,[8106h]
2007:04DD 7D 03           	jge	04E2h

l2007_04DF:
2007:04DF E9 5E FF        	jmp	0440h

l2007_04E2:
2007:04E2 83 3E 35 83 00  	cmp	word ptr [8335h],0h
2007:04E7 75 05           	jnz	04EEh

l2007_04E9:
2007:04E9 9A E3 1A 07 20  	call	far 2007h:1AE3h

l2007_04EE:
2007:04EE 83 7E 06 00     	cmp	word ptr [bp+6h],0h
2007:04F2 75 03           	jnz	04F7h

l2007_04F4:
2007:04F4 E9 49 01        	jmp	0640h

l2007_04F7:
2007:04F7 33 F6           	xor	si,si
2007:04F9 E9 3C 01        	jmp	0638h

l2007_04FC:
2007:04FC 8B C6           	mov	ax,si
2007:04FE BA 06 00        	mov	dx,6h
2007:0501 F7 E2           	mul	dx
2007:0503 8B D8           	mov	bx,ax
2007:0505 81 C3 0C 81     	add	bx,810Ch
2007:0509 1E              	push	ds
2007:050A 07              	pop	es
2007:050B 26 83 3F FF     	cmp	word ptr es:[bx],0FFh
2007:050F 75 03           	jnz	0514h

l2007_0511:
2007:0511 E9 23 01        	jmp	0637h

l2007_0514:
2007:0514 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:0519 B4 00           	mov	ah,0h
2007:051B 25 7F 00        	and	ax,7Fh
2007:051E 3D 09 00        	cmp	ax,9h
2007:0521 76 03           	jbe	0526h

l2007_0523:
2007:0523 E9 11 01        	jmp	0637h

l2007_0526:
2007:0526 8B D8           	mov	bx,ax
2007:0528 D1 E3           	shl	bx,1h
2007:052A 2E FF A7 2F 05  	jmp	word ptr cs:[bx+52Fh]
l2007_052F	dw	0x0543
l2007_0531	dw	0x0543
l2007_0533	dw	0x057B
l2007_0535	dw	0x057B
l2007_0537	dw	0x05B3
l2007_0539	dw	0x05B3
l2007_053B	dw	0x05EA
l2007_053D	dw	0x05EA
l2007_053F	dw	0x0637
l2007_0541	dw	0x0621

l2007_0543:
2007:0543 33 C0           	xor	ax,ax
2007:0545 50              	push	ax
2007:0546 33 C0           	xor	ax,ax
2007:0548 50              	push	ax
2007:0549 8B C6           	mov	ax,si
2007:054B BA 06 00        	mov	dx,6h
2007:054E F7 E2           	mul	dx
2007:0550 8B D8           	mov	bx,ax
2007:0552 81 C3 0C 81     	add	bx,810Ch
2007:0556 1E              	push	ds
2007:0557 07              	pop	es
2007:0558 26 FF 77 02     	push	word ptr es:[bx+2h]
2007:055C 8B C6           	mov	ax,si
2007:055E BA 06 00        	mov	dx,6h
2007:0561 F7 E2           	mul	dx
2007:0563 8B D8           	mov	bx,ax
2007:0565 81 C3 0C 81     	add	bx,810Ch
2007:0569 1E              	push	ds
2007:056A 07              	pop	es
2007:056B 26 8B 07        	mov	ax,es:[bx]
2007:056E 48              	dec	ax
2007:056F 50              	push	ax
2007:0570 9A 6F 27 1B 2D  	call	far 2D1Bh:276Fh
2007:0575 83 C4 08        	add	sp,8h
2007:0578 E9 BC 00        	jmp	0637h

l2007_057B:
2007:057B 33 C0           	xor	ax,ax
2007:057D 50              	push	ax
2007:057E 33 C0           	xor	ax,ax
2007:0580 50              	push	ax
2007:0581 8B C6           	mov	ax,si
2007:0583 BA 06 00        	mov	dx,6h
2007:0586 F7 E2           	mul	dx
2007:0588 8B D8           	mov	bx,ax
2007:058A 81 C3 0C 81     	add	bx,810Ch
2007:058E 1E              	push	ds
2007:058F 07              	pop	es
2007:0590 26 FF 77 02     	push	word ptr es:[bx+2h]
2007:0594 8B C6           	mov	ax,si
2007:0596 BA 06 00        	mov	dx,6h
2007:0599 F7 E2           	mul	dx
2007:059B 8B D8           	mov	bx,ax
2007:059D 81 C3 0C 81     	add	bx,810Ch
2007:05A1 1E              	push	ds
2007:05A2 07              	pop	es
2007:05A3 26 8B 07        	mov	ax,es:[bx]
2007:05A6 40              	inc	ax
2007:05A7 50              	push	ax
2007:05A8 9A 6F 27 1B 2D  	call	far 2D1Bh:276Fh
2007:05AD 83 C4 08        	add	sp,8h
2007:05B0 E9 84 00        	jmp	0637h

l2007_05B3:
2007:05B3 33 C0           	xor	ax,ax
2007:05B5 50              	push	ax
2007:05B6 33 C0           	xor	ax,ax
2007:05B8 50              	push	ax
2007:05B9 8B C6           	mov	ax,si
2007:05BB BA 06 00        	mov	dx,6h
2007:05BE F7 E2           	mul	dx
2007:05C0 8B D8           	mov	bx,ax
2007:05C2 81 C3 0C 81     	add	bx,810Ch
2007:05C6 1E              	push	ds
2007:05C7 07              	pop	es
2007:05C8 26 8B 47 02     	mov	ax,es:[bx+2h]
2007:05CC 48              	dec	ax
2007:05CD 50              	push	ax
2007:05CE 8B C6           	mov	ax,si
2007:05D0 BA 06 00        	mov	dx,6h
2007:05D3 F7 E2           	mul	dx
2007:05D5 8B D8           	mov	bx,ax
2007:05D7 81 C3 0C 81     	add	bx,810Ch
2007:05DB 1E              	push	ds
2007:05DC 07              	pop	es
2007:05DD 26 FF 37        	push	word ptr es:[bx]
2007:05E0 9A 6F 27 1B 2D  	call	far 2D1Bh:276Fh
2007:05E5 83 C4 08        	add	sp,8h
2007:05E8 EB 4D           	jmp	0637h

l2007_05EA:
2007:05EA 33 C0           	xor	ax,ax
2007:05EC 50              	push	ax
2007:05ED 33 C0           	xor	ax,ax
2007:05EF 50              	push	ax
2007:05F0 8B C6           	mov	ax,si
2007:05F2 BA 06 00        	mov	dx,6h
2007:05F5 F7 E2           	mul	dx
2007:05F7 8B D8           	mov	bx,ax
2007:05F9 81 C3 0C 81     	add	bx,810Ch
2007:05FD 1E              	push	ds
2007:05FE 07              	pop	es
2007:05FF 26 8B 47 02     	mov	ax,es:[bx+2h]
2007:0603 40              	inc	ax
2007:0604 50              	push	ax
2007:0605 8B C6           	mov	ax,si
2007:0607 BA 06 00        	mov	dx,6h
2007:060A F7 E2           	mul	dx
2007:060C 8B D8           	mov	bx,ax
2007:060E 81 C3 0C 81     	add	bx,810Ch
2007:0612 1E              	push	ds
2007:0613 07              	pop	es
2007:0614 26 FF 37        	push	word ptr es:[bx]
2007:0617 9A 6F 27 1B 2D  	call	far 2D1Bh:276Fh
2007:061C 83 C4 08        	add	sp,8h
2007:061F EB 16           	jmp	0637h

l2007_0621:
2007:0621 8B C6           	mov	ax,si
2007:0623 BA 06 00        	mov	dx,6h
2007:0626 F7 E2           	mul	dx
2007:0628 8B D8           	mov	bx,ax
2007:062A 81 C3 0C 81     	add	bx,810Ch
2007:062E 1E              	push	ds
2007:062F 07              	pop	es
2007:0630 26 C7 07 FF FF  	mov	word ptr es:[bx],0FFFFh
2007:0635 EB 00           	jmp	0637h

l2007_0637:
2007:0637 46              	inc	si

l2007_0638:
2007:0638 83 FE 5A        	cmp	si,5Ah
2007:063B 7D 03           	jge	0640h

l2007_063D:
2007:063D E9 BC FE        	jmp	04FCh

l2007_0640:
2007:0640 9A E8 16 07 20  	call	far 2007h:16E8h
2007:0645 9A DE 17 07 20  	call	far 2007h:17DEh
2007:064A 5F              	pop	di
2007:064B 5E              	pop	si
2007:064C 8B E5           	mov	sp,bp
2007:064E 5D              	pop	bp
2007:064F CB              	retf

;; RebuildTacticalViewport_0650: 2007:0650
;;   Called from:
;;     1A1F:1363 (in FocusTacticalViewOnUnit_11F7)
;;     1A1F:1557 (in FindUnitAtTacticalCursor_1504)
;;     1A1F:4F8B (in HandleTacticalFunctionKey_4CC6)
;;     2007:1D1F (in RefreshTacticalDisplay_1D06)
;;     2007:1D42 (in RefreshTacticalDisplay_1D06)
RebuildTacticalViewport_0650 proc
2007:0650 55              	push	bp
2007:0651 8B EC           	mov	bp,sp
2007:0653 83 EC 06        	sub	sp,6h
2007:0656 56              	push	si
2007:0657 57              	push	di
2007:0658 FF 36 DA 83     	push	word ptr [83DAh]
2007:065C FF 36 A0 84     	push	word ptr [84A0h]
2007:0660 FF 36 BE 99     	push	word ptr [99BEh]
2007:0664 FF 36 BC 99     	push	word ptr [99BCh]
2007:0668 FF 36 EC 83     	push	word ptr [83ECh]
2007:066C FF 36 EA 83     	push	word ptr [83EAh]
2007:0670 9A D3 05 00 08  	call	far 0800h:05D3h
2007:0675 83 C4 0C        	add	sp,0Ch
2007:0678 9A 19 12 07 20  	call	far 2007h:1219h
2007:067D 0E              	push	cs
2007:067E E8 86 F9        	call	0007h
2007:0681 C7 46 FA 00 00  	mov	word ptr [bp-6h],0h
2007:0686 33 F6           	xor	si,si
2007:0688 EB 23           	jmp	06ADh

l2007_068A:
2007:068A C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
2007:068F EB 15           	jmp	06A6h

l2007_0691:
2007:0691 8B 46 FA        	mov	ax,[bp-6h]
2007:0694 FF 46 FA        	inc	word ptr [bp-6h]
2007:0697 50              	push	ax
2007:0698 56              	push	si
2007:0699 FF 76 FC        	push	word ptr [bp-4h]
2007:069C 0E              	push	cs
2007:069D E8 88 FC        	call	0328h
2007:06A0 83 C4 06        	add	sp,6h
2007:06A3 FF 46 FC        	inc	word ptr [bp-4h]

l2007_06A6:
2007:06A6 83 7E FC 13     	cmp	word ptr [bp-4h],13h
2007:06AA 7C E5           	jl	0691h

l2007_06AC:
2007:06AC 46              	inc	si

l2007_06AD:
2007:06AD 83 FE 0C        	cmp	si,0Ch
2007:06B0 7C D8           	jl	068Ah

l2007_06B2:
2007:06B2 83 3E 04 81 00  	cmp	word ptr [8104h],0h
2007:06B7 74 03           	jz	06BCh

l2007_06B9:
2007:06B9 E9 D8 00        	jmp	0794h

l2007_06BC:
2007:06BC 33 FF           	xor	di,di
2007:06BE 33 F6           	xor	si,si
2007:06C0 E9 7B 00        	jmp	073Eh

l2007_06C3:
2007:06C3 80 BC 28 83 00  	cmp	byte ptr [si+8328h],0h
2007:06C8 74 68           	jz	0732h

l2007_06CA:
2007:06CA 8A 84 AC 99     	mov	al,[si+99ACh]
2007:06CE 3A 84 74 B5     	cmp	al,[si+0B574h]
2007:06D2 74 5E           	jz	0732h

l2007_06D4:
2007:06D4 8A 84 AC 99     	mov	al,[si+99ACh]
2007:06D8 98              	cbw
2007:06D9 05 F6 01        	add	ax,1F6h
2007:06DC 89 46 FE        	mov	[bp-2h],ax
2007:06DF 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
2007:06E4 74 23           	jz	0709h

l2007_06E6:
2007:06E6 57              	push	di
2007:06E7 33 C0           	xor	ax,ax
2007:06E9 50              	push	ax
2007:06EA FF 36 E4 83     	push	word ptr [83E4h]
2007:06EE FF 36 E2 83     	push	word ptr [83E2h]
2007:06F2 FF 76 FE        	push	word ptr [bp-2h]
2007:06F5 8A 84 28 83     	mov	al,[si+8328h]
2007:06F9 B4 00           	mov	ah,0h
2007:06FB 05 00 01        	add	ax,100h
2007:06FE 50              	push	ax
2007:06FF 9A 83 24 00 08  	call	far 0800h:2483h
2007:0704 83 C4 0C        	add	sp,0Ch
2007:0707 EB 21           	jmp	072Ah

l2007_0709:
2007:0709 57              	push	di
2007:070A 33 C0           	xor	ax,ax
2007:070C 50              	push	ax
2007:070D FF 36 E4 83     	push	word ptr [83E4h]
2007:0711 FF 36 E2 83     	push	word ptr [83E2h]
2007:0715 FF 76 FE        	push	word ptr [bp-2h]
2007:0718 8A 84 28 83     	mov	al,[si+8328h]
2007:071C B4 00           	mov	ah,0h
2007:071E 05 00 01        	add	ax,100h
2007:0721 50              	push	ax
2007:0722 9A BB 09 00 08  	call	far 0800h:09BBh
2007:0727 83 C4 0C        	add	sp,0Ch

l2007_072A:
2007:072A 8A 84 AC 99     	mov	al,[si+99ACh]
2007:072E 88 84 74 B5     	mov	[si+0B574h],al

l2007_0732:
2007:0732 83 C7 14        	add	di,14h
2007:0735 83 FE 04        	cmp	si,4h
2007:0738 75 03           	jnz	073Dh

l2007_073A:
2007:073A 83 C7 04        	add	di,4h

l2007_073D:
2007:073D 46              	inc	si

l2007_073E:
2007:073E 83 FE 07        	cmp	si,7h
2007:0741 7D 03           	jge	0746h

l2007_0743:
2007:0743 E9 7D FF        	jmp	06C3h

l2007_0746:
2007:0746 80 3E 7B B5 FF  	cmp	byte ptr [0B57Bh],0FFh
2007:074B 75 20           	jnz	076Dh

l2007_074D:
2007:074D B8 98 00        	mov	ax,98h
2007:0750 50              	push	ax
2007:0751 33 C0           	xor	ax,ax
2007:0753 50              	push	ax
2007:0754 B8 EF 01        	mov	ax,1EFh
2007:0757 50              	push	ax
2007:0758 FF 36 E4 83     	push	word ptr [83E4h]
2007:075C FF 36 E2 83     	push	word ptr [83E2h]
2007:0760 9A BD 1C 07 20  	call	far 2007h:1CBDh
2007:0765 83 C4 0A        	add	sp,0Ah
2007:0768 C6 06 7B B5 00  	mov	byte ptr [0B57Bh],0h

l2007_076D:
2007:076D 80 3E 2F 83 00  	cmp	byte ptr [832Fh],0h
2007:0772 74 20           	jz	0794h

l2007_0774:
2007:0774 B8 B0 00        	mov	ax,0B0h
2007:0777 50              	push	ax
2007:0778 33 C0           	xor	ax,ax
2007:077A 50              	push	ax
2007:077B A0 2F 83        	mov	al,[832Fh]
2007:077E B4 00           	mov	ah,0h
2007:0780 05 00 01        	add	ax,100h
2007:0783 50              	push	ax
2007:0784 FF 36 E4 83     	push	word ptr [83E4h]
2007:0788 FF 36 E2 83     	push	word ptr [83E2h]
2007:078C 9A BD 1C 07 20  	call	far 2007h:1CBDh
2007:0791 83 C4 0A        	add	sp,0Ah

l2007_0794:
2007:0794 5F              	pop	di
2007:0795 5E              	pop	si
2007:0796 8B E5           	mov	sp,bp
2007:0798 5D              	pop	bp
2007:0799 CB              	retf

;; DrawTacticalCursorOutline_079A: 2007:079A
;;   Called from:
;;     1A1F:1560 (in FindUnitAtTacticalCursor_1504)
;;     1A1F:4F94 (in HandleTacticalFunctionKey_4CC6)
;;     2007:1D27 (in RefreshTacticalDisplay_1D06)
;;     2007:1D51 (in RefreshTacticalDisplay_1D06)
;;     2208:2AF1 (in HighlightLanceFollowers_2A8A)
DrawTacticalCursorOutline_079A proc
2007:079A 55              	push	bp
2007:079B 8B EC           	mov	bp,sp
2007:079D 56              	push	si
2007:079E 57              	push	di
2007:079F 8B 36 31 83     	mov	si,[8331h]
2007:07A3 B1 04           	mov	cl,4h
2007:07A5 D3 E6           	shl	si,cl
2007:07A7 83 C6 10        	add	si,10h
2007:07AA 8B 3E 33 83     	mov	di,[8333h]
2007:07AE B1 04           	mov	cl,4h
2007:07B0 D3 E7           	shl	di,cl
2007:07B2 FF 76 06        	push	word ptr [bp+6h]
2007:07B5 57              	push	di
2007:07B6 56              	push	si
2007:07B7 9A C9 07 07 20  	call	far 2007h:07C9h
2007:07BC 83 C4 06        	add	sp,6h
2007:07BF 81 36 7D B5 0F 00 	xor	word ptr [0B57Dh],0Fh
2007:07C5 5F              	pop	di
2007:07C6 5E              	pop	si
2007:07C7 5D              	pop	bp
2007:07C8 CB              	retf

;; DrawTacticalCellOutline_07C9: 2007:07C9
;;   Called from:
;;     2007:07B7 (in DrawTacticalCursorOutline_079A)
;;     2007:151F (in UpdatePrimaryUnitStatusRowHighlight_14DF)
;;     2007:157A (in UpdateSecondaryUnitStatusRowHighlight_1544)
;;     2208:14E8 (in RunTacticalGameOptionsMenu_148A)
DrawTacticalCellOutline_07C9 proc
2007:07C9 55              	push	bp
2007:07CA 8B EC           	mov	bp,sp
2007:07CC 56              	push	si
2007:07CD 57              	push	di
2007:07CE 8B 7E 08        	mov	di,[bp+8h]
2007:07D1 8B 76 06        	mov	si,[bp+6h]
2007:07D4 9A 68 39 00 08  	call	far 0800h:3968h
2007:07D9 FF 76 0A        	push	word ptr [bp+0Ah]
2007:07DC 57              	push	di
2007:07DD 8B C6           	mov	ax,si
2007:07DF 05 0F 00        	add	ax,0Fh
2007:07E2 50              	push	ax
2007:07E3 57              	push	di
2007:07E4 56              	push	si
2007:07E5 9A A6 00 65 33  	call	far 3365h:00A6h
2007:07EA 83 C4 0A        	add	sp,0Ah
2007:07ED FF 76 0A        	push	word ptr [bp+0Ah]
2007:07F0 8B C7           	mov	ax,di
2007:07F2 05 0F 00        	add	ax,0Fh
2007:07F5 50              	push	ax
2007:07F6 56              	push	si
2007:07F7 57              	push	di
2007:07F8 56              	push	si
2007:07F9 9A A6 00 65 33  	call	far 3365h:00A6h
2007:07FE 83 C4 0A        	add	sp,0Ah
2007:0801 FF 76 0A        	push	word ptr [bp+0Ah]
2007:0804 8B C7           	mov	ax,di
2007:0806 05 0F 00        	add	ax,0Fh
2007:0809 50              	push	ax
2007:080A 8B C6           	mov	ax,si
2007:080C 05 0F 00        	add	ax,0Fh
2007:080F 50              	push	ax
2007:0810 57              	push	di
2007:0811 8B C6           	mov	ax,si
2007:0813 05 0F 00        	add	ax,0Fh
2007:0816 50              	push	ax
2007:0817 9A A6 00 65 33  	call	far 3365h:00A6h
2007:081C 83 C4 0A        	add	sp,0Ah
2007:081F FF 76 0A        	push	word ptr [bp+0Ah]
2007:0822 8B C7           	mov	ax,di
2007:0824 05 0F 00        	add	ax,0Fh
2007:0827 50              	push	ax
2007:0828 8B C6           	mov	ax,si
2007:082A 05 0F 00        	add	ax,0Fh
2007:082D 50              	push	ax
2007:082E 8B C7           	mov	ax,di
2007:0830 05 0F 00        	add	ax,0Fh
2007:0833 50              	push	ax
2007:0834 56              	push	si
2007:0835 9A A6 00 65 33  	call	far 3365h:00A6h
2007:083A 83 C4 0A        	add	sp,0Ah
2007:083D 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:0842 5F              	pop	di
2007:0843 5E              	pop	si
2007:0844 5D              	pop	bp
2007:0845 CB              	retf

;; QueueTacticalImpactVisual_0846: 2007:0846
;;   Called from:
;;     2007:0D0D (in ApplyAreaTerrainAndUnitDamage_0CFB)
;;     2007:19D9 (in AdvanceTacticalProjectiles_17DE)
;;     2D1B:1D78 (in ResolveWeaponAttack_1854)
;;     2D1B:2B9D (in CollapseStructureAtMapCell_2AF3)
QueueTacticalImpactVisual_0846 proc
2007:0846 55              	push	bp
2007:0847 8B EC           	mov	bp,sp
2007:0849 56              	push	si
2007:084A 57              	push	di
2007:084B 83 3E FC 80 50  	cmp	word ptr [80FCh],50h
2007:0850 7C 03           	jl	0855h

l2007_0852:
2007:0852 E9 7C 00        	jmp	08D1h

l2007_0855:
2007:0855 8B 36 FC 80     	mov	si,[80FCh]
2007:0859 D1 E6           	shl	si,1h
2007:085B D1 E6           	shl	si,1h
2007:085D 8B 46 06        	mov	ax,[bp+6h]
2007:0860 8B DE           	mov	bx,si
2007:0862 D1 E3           	shl	bx,1h
2007:0864 89 87 F4 B2     	mov	[bx+0B2F4h],ax
2007:0868 46              	inc	si
2007:0869 8B 46 08        	mov	ax,[bp+8h]
2007:086C 8B DE           	mov	bx,si
2007:086E D1 E3           	shl	bx,1h
2007:0870 89 87 F4 B2     	mov	[bx+0B2F4h],ax
2007:0874 46              	inc	si
2007:0875 8B 46 0A        	mov	ax,[bp+0Ah]
2007:0878 8B DE           	mov	bx,si
2007:087A D1 E3           	shl	bx,1h
2007:087C 89 87 F4 B2     	mov	[bx+0B2F4h],ax
2007:0880 46              	inc	si
2007:0881 8B 46 0A        	mov	ax,[bp+0Ah]
2007:0884 3D 01 00        	cmp	ax,1h
2007:0887 74 0C           	jz	0895h

l2007_0889:
2007:0889 3D 06 00        	cmp	ax,6h
2007:088C 74 16           	jz	08A4h

l2007_088E:
2007:088E 3D 0A 00        	cmp	ax,0Ah
2007:0891 74 20           	jz	08B3h

l2007_0893:
2007:0893 EB 2D           	jmp	08C2h

l2007_0895:
2007:0895 BF 06 00        	mov	di,6h
2007:0898 B8 04 00        	mov	ax,4h
2007:089B 50              	push	ax
2007:089C 9A 67 05 FB 31  	call	far 31FBh:0567h
2007:08A1 59              	pop	cx
2007:08A2 EB 20           	jmp	08C4h

l2007_08A4:
2007:08A4 BF 0A 00        	mov	di,0Ah
2007:08A7 B8 02 00        	mov	ax,2h
2007:08AA 50              	push	ax
2007:08AB 9A 67 05 FB 31  	call	far 31FBh:0567h
2007:08B0 59              	pop	cx
2007:08B1 EB 11           	jmp	08C4h

l2007_08B3:
2007:08B3 BF 0E 00        	mov	di,0Eh
2007:08B6 B8 0E 00        	mov	ax,0Eh
2007:08B9 50              	push	ax
2007:08BA 9A 67 05 FB 31  	call	far 31FBh:0567h
2007:08BF 59              	pop	cx
2007:08C0 EB 02           	jmp	08C4h

l2007_08C2:
2007:08C2 EB 00           	jmp	08C4h

l2007_08C4:
2007:08C4 8B DE           	mov	bx,si
2007:08C6 D1 E3           	shl	bx,1h
2007:08C8 89 BF F4 B2     	mov	[bx+0B2F4h],di
2007:08CC 46              	inc	si
2007:08CD FF 06 FC 80     	inc	word ptr [80FCh]

l2007_08D1:
2007:08D1 5F              	pop	di
2007:08D2 5E              	pop	si
2007:08D3 5D              	pop	bp
2007:08D4 CB              	retf

;; QueueMapEdgeEffect_08D5: 2007:08D5
;;   Called from:
;;     1A1F:1C19 (in AdvanceScenarioAreaEffects_1A83)
;;     1A1F:49BE (in QueueRandomMapEdgeEffect_4923)
QueueMapEdgeEffect_08D5 proc
2007:08D5 55              	push	bp
2007:08D6 8B EC           	mov	bp,sp
2007:08D8 56              	push	si
2007:08D9 83 3E 7F B5 03  	cmp	word ptr [0B57Fh],3h
2007:08DE 7D 43           	jge	0923h

l2007_08E0:
2007:08E0 8B 36 7F B5     	mov	si,[0B57Fh]
2007:08E4 D1 E6           	shl	si,1h
2007:08E6 D1 E6           	shl	si,1h
2007:08E8 8B 46 06        	mov	ax,[bp+6h]
2007:08EB 8B DE           	mov	bx,si
2007:08ED D1 E3           	shl	bx,1h
2007:08EF 89 87 00 A8     	mov	[bx+0A800h],ax
2007:08F3 46              	inc	si
2007:08F4 8B 46 08        	mov	ax,[bp+8h]
2007:08F7 8B DE           	mov	bx,si
2007:08F9 D1 E3           	shl	bx,1h
2007:08FB 89 87 00 A8     	mov	[bx+0A800h],ax
2007:08FF 46              	inc	si
2007:0900 8B 46 0C        	mov	ax,[bp+0Ch]
2007:0903 D1 E0           	shl	ax,1h
2007:0905 D1 E0           	shl	ax,1h
2007:0907 03 46 0A        	add	ax,[bp+0Ah]
2007:090A 8B DE           	mov	bx,si
2007:090C D1 E3           	shl	bx,1h
2007:090E 89 87 00 A8     	mov	[bx+0A800h],ax
2007:0912 46              	inc	si
2007:0913 8B 46 0C        	mov	ax,[bp+0Ch]
2007:0916 8B DE           	mov	bx,si
2007:0918 D1 E3           	shl	bx,1h
2007:091A 89 87 00 A8     	mov	[bx+0A800h],ax
2007:091E 46              	inc	si
2007:091F FF 06 7F B5     	inc	word ptr [0B57Fh]

l2007_0923:
2007:0923 5E              	pop	si
2007:0924 5D              	pop	bp
2007:0925 CB              	retf

;; DrawClippedWeaponTraceLine_0926: 2007:0926
;;   Called from:
;;     1A1F:106A (in DrawWeaponAttackTrace_0D55)
;;     1A1F:108C (in DrawWeaponAttackTrace_0D55)
;;     1A1F:10A4 (in DrawWeaponAttackTrace_0D55)
;;     1A1F:10BF (in DrawWeaponAttackTrace_0D55)
DrawClippedWeaponTraceLine_0926 proc
2007:0926 55              	push	bp
2007:0927 8B EC           	mov	bp,sp
2007:0929 83 EC 18        	sub	sp,18h
2007:092C 56              	push	si
2007:092D 57              	push	di
2007:092E 8B 7E 08        	mov	di,[bp+8h]
2007:0931 8B 76 06        	mov	si,[bp+6h]
2007:0934 B8 01 00        	mov	ax,1h
2007:0937 89 46 FE        	mov	[bp-2h],ax
2007:093A 89 46 FC        	mov	[bp-4h],ax
2007:093D 83 7E 10 00     	cmp	word ptr [bp+10h],0h
2007:0941 74 13           	jz	0956h

l2007_0943:
2007:0943 C7 46 FE 06 00  	mov	word ptr [bp-2h],6h
2007:0948 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:094D B4 00           	mov	ah,0h
2007:094F 25 03 00        	and	ax,3h
2007:0952 40              	inc	ax
2007:0953 89 46 FC        	mov	[bp-4h],ax

l2007_0956:
2007:0956 8B C7           	mov	ax,di
2007:0958 2B 46 0C        	sub	ax,[bp+0Ch]
2007:095B 89 46 E8        	mov	[bp-18h],ax
2007:095E 8B 46 0A        	mov	ax,[bp+0Ah]
2007:0961 2B C6           	sub	ax,si
2007:0963 89 46 EA        	mov	[bp-16h],ax
2007:0966 8B 46 E8        	mov	ax,[bp-18h]
2007:0969 99              	cwd
2007:096A 33 C2           	xor	ax,dx
2007:096C 2B C2           	sub	ax,dx
2007:096E 89 46 EC        	mov	[bp-14h],ax
2007:0971 8B 46 EA        	mov	ax,[bp-16h]
2007:0974 99              	cwd
2007:0975 33 C2           	xor	ax,dx
2007:0977 2B C2           	sub	ax,dx
2007:0979 89 46 EE        	mov	[bp-12h],ax
2007:097C 8B 46 EE        	mov	ax,[bp-12h]
2007:097F 3B 46 EC        	cmp	ax,[bp-14h]
2007:0982 7E 12           	jle	0996h

l2007_0984:
2007:0984 8B 46 EE        	mov	ax,[bp-12h]
2007:0987 89 46 F0        	mov	[bp-10h],ax
2007:098A 8B 46 EC        	mov	ax,[bp-14h]
2007:098D 89 46 EE        	mov	[bp-12h],ax
2007:0990 8B 46 F0        	mov	ax,[bp-10h]
2007:0993 89 46 EC        	mov	[bp-14h],ax

l2007_0996:
2007:0996 FF 76 EA        	push	word ptr [bp-16h]
2007:0999 FF 76 E8        	push	word ptr [bp-18h]
2007:099C 9A 4D 0A 07 20  	call	far 2007h:0A4Dh
2007:09A1 59              	pop	cx
2007:09A2 59              	pop	cx
2007:09A3 89 46 F2        	mov	[bp-0Eh],ax
2007:09A6 8B 46 EC        	mov	ax,[bp-14h]
2007:09A9 D1 F8           	sar	ax,1h
2007:09AB 89 46 F0        	mov	[bp-10h],ax
2007:09AE 8B 5E F2        	mov	bx,[bp-0Eh]
2007:09B1 8A 87 2A 17     	mov	al,[bx+172Ah]
2007:09B5 98              	cbw
2007:09B6 89 46 F8        	mov	[bp-8h],ax
2007:09B9 8B 5E F2        	mov	bx,[bp-0Eh]
2007:09BC 8A 87 32 17     	mov	al,[bx+1732h]
2007:09C0 98              	cbw
2007:09C1 89 46 FA        	mov	[bp-6h],ax
2007:09C4 8B 5E F2        	mov	bx,[bp-0Eh]
2007:09C7 8A 87 3A 17     	mov	al,[bx+173Ah]
2007:09CB 98              	cbw
2007:09CC 89 46 F4        	mov	[bp-0Ch],ax
2007:09CF 8B 5E F2        	mov	bx,[bp-0Eh]
2007:09D2 8A 87 42 17     	mov	al,[bx+1742h]
2007:09D6 98              	cbw
2007:09D7 89 46 F6        	mov	[bp-0Ah],ax
2007:09DA 9A 68 39 00 08  	call	far 0800h:3968h
2007:09DF EB 4A           	jmp	0A2Bh

l2007_09E1:
2007:09E1 FF 4E FC        	dec	word ptr [bp-4h]
2007:09E4 7F 13           	jg	09F9h

l2007_09E6:
2007:09E6 FF 76 0E        	push	word ptr [bp+0Eh]
2007:09E9 57              	push	di
2007:09EA 56              	push	si
2007:09EB 9A 57 01 65 33  	call	far 3365h:0157h
2007:09F0 83 C4 06        	add	sp,6h
2007:09F3 8B 46 FE        	mov	ax,[bp-2h]
2007:09F6 89 46 FC        	mov	[bp-4h],ax

l2007_09F9:
2007:09F9 3B 76 0A        	cmp	si,[bp+0Ah]
2007:09FC 74 03           	jz	0A01h

l2007_09FE:
2007:09FE 03 76 F8        	add	si,[bp-8h]

l2007_0A01:
2007:0A01 3B 7E 0C        	cmp	di,[bp+0Ch]
2007:0A04 74 03           	jz	0A09h

l2007_0A06:
2007:0A06 03 7E FA        	add	di,[bp-6h]

l2007_0A09:
2007:0A09 8B 46 EE        	mov	ax,[bp-12h]
2007:0A0C 29 46 F0        	sub	[bp-10h],ax
2007:0A0F 83 7E F0 00     	cmp	word ptr [bp-10h],0h
2007:0A13 7D 16           	jge	0A2Bh

l2007_0A15:
2007:0A15 3B 76 0A        	cmp	si,[bp+0Ah]
2007:0A18 74 03           	jz	0A1Dh

l2007_0A1A:
2007:0A1A 03 76 F4        	add	si,[bp-0Ch]

l2007_0A1D:
2007:0A1D 3B 7E 0C        	cmp	di,[bp+0Ch]
2007:0A20 74 03           	jz	0A25h

l2007_0A22:
2007:0A22 03 7E F6        	add	di,[bp-0Ah]

l2007_0A25:
2007:0A25 8B 46 EC        	mov	ax,[bp-14h]
2007:0A28 01 46 F0        	add	[bp-10h],ax

l2007_0A2B:
2007:0A2B 3B 76 0A        	cmp	si,[bp+0Ah]
2007:0A2E 75 B1           	jnz	09E1h

l2007_0A30:
2007:0A30 3B 7E 0C        	cmp	di,[bp+0Ch]
2007:0A33 75 AC           	jnz	09E1h

l2007_0A35:
2007:0A35 FF 76 0E        	push	word ptr [bp+0Eh]
2007:0A38 57              	push	di
2007:0A39 56              	push	si
2007:0A3A 9A 57 01 65 33  	call	far 3365h:0157h
2007:0A3F 83 C4 06        	add	sp,6h
2007:0A42 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:0A47 5F              	pop	di
2007:0A48 5E              	pop	si
2007:0A49 8B E5           	mov	sp,bp
2007:0A4B 5D              	pop	bp
2007:0A4C CB              	retf

;; DetermineOctant_0A4D: 2007:0A4D
;;   Called from:
;;     1A1F:0DCB (in DrawWeaponAttackTrace_0D55)
;;     1A1F:18E7 (in OffsetWeaponTraceEndpoint_18C9)
;;     2007:099C (in DrawClippedWeaponTraceLine_0926)
;;     2007:0B30 (in QueueTacticalProjectile_0AA4)
;;     2007:0B64 (in QueueTacticalProjectile_0AA4)
DetermineOctant_0A4D proc
2007:0A4D 55              	push	bp
2007:0A4E 8B EC           	mov	bp,sp
2007:0A50 56              	push	si
2007:0A51 57              	push	di
2007:0A52 8B 7E 08        	mov	di,[bp+8h]
2007:0A55 83 7E 06 00     	cmp	word ptr [bp+6h],0h
2007:0A59 7D 26           	jge	0A81h

l2007_0A5B:
2007:0A5B 0B FF           	or	di,di
2007:0A5D 7E 0F           	jle	0A6Eh

l2007_0A5F:
2007:0A5F BE 02 00        	mov	si,2h
2007:0A62 8B 46 06        	mov	ax,[bp+6h]
2007:0A65 F7 D8           	neg	ax
2007:0A67 3B C7           	cmp	ax,di
2007:0A69 7E 01           	jle	0A6Ch

l2007_0A6B:
2007:0A6B 46              	inc	si

l2007_0A6C:
2007:0A6C EB 11           	jmp	0A7Fh

l2007_0A6E:
2007:0A6E BE 04 00        	mov	si,4h
2007:0A71 8B C7           	mov	ax,di
2007:0A73 F7 D8           	neg	ax
2007:0A75 8B 56 06        	mov	dx,[bp+6h]
2007:0A78 F7 DA           	neg	dx
2007:0A7A 3B C2           	cmp	ax,dx
2007:0A7C 7E 01           	jle	0A7Fh

l2007_0A7E:
2007:0A7E 46              	inc	si

l2007_0A7F:
2007:0A7F EB 1B           	jmp	0A9Ch

l2007_0A81:
2007:0A81 0B FF           	or	di,di
2007:0A83 7E 0A           	jle	0A8Fh

l2007_0A85:
2007:0A85 33 F6           	xor	si,si
2007:0A87 3B 7E 06        	cmp	di,[bp+6h]
2007:0A8A 7E 01           	jle	0A8Dh

l2007_0A8C:
2007:0A8C 46              	inc	si

l2007_0A8D:
2007:0A8D EB 0D           	jmp	0A9Ch

l2007_0A8F:
2007:0A8F BE 06 00        	mov	si,6h
2007:0A92 8B C7           	mov	ax,di
2007:0A94 F7 D8           	neg	ax
2007:0A96 3B 46 06        	cmp	ax,[bp+6h]
2007:0A99 7D 01           	jge	0A9Ch

l2007_0A9B:
2007:0A9B 46              	inc	si

l2007_0A9C:
2007:0A9C 8B C6           	mov	ax,si
2007:0A9E EB 00           	jmp	0AA0h

l2007_0AA0:
2007:0AA0 5F              	pop	di
2007:0AA1 5E              	pop	si
2007:0AA2 5D              	pop	bp
2007:0AA3 CB              	retf

;; QueueTacticalProjectile_0AA4: 2007:0AA4
;;   Called from:
;;     2D1B:1D21 (in ResolveWeaponAttack_1854)
QueueTacticalProjectile_0AA4 proc
2007:0AA4 55              	push	bp
2007:0AA5 8B EC           	mov	bp,sp
2007:0AA7 83 EC 02        	sub	sp,2h
2007:0AAA 56              	push	si
2007:0AAB 57              	push	di
2007:0AAC 83 3E 83 B5 50  	cmp	word ptr [0B583h],50h
2007:0AB1 7C 03           	jl	0AB6h

l2007_0AB3:
2007:0AB3 E9 B3 01        	jmp	0C69h

l2007_0AB6:
2007:0AB6 8A 46 08        	mov	al,[bp+8h]
2007:0AB9 50              	push	ax
2007:0ABA A1 83 B5        	mov	ax,[0B583h]
2007:0ABD BA 0E 00        	mov	dx,0Eh
2007:0AC0 F7 E2           	mul	dx
2007:0AC2 8B D8           	mov	bx,ax
2007:0AC4 81 C3 DD A9     	add	bx,0A9DDh
2007:0AC8 1E              	push	ds
2007:0AC9 07              	pop	es
2007:0ACA 58              	pop	ax
2007:0ACB 26 88 07        	mov	es:[bx],al
2007:0ACE 8A 46 0A        	mov	al,[bp+0Ah]
2007:0AD1 50              	push	ax
2007:0AD2 A1 83 B5        	mov	ax,[0B583h]
2007:0AD5 BA 0E 00        	mov	dx,0Eh
2007:0AD8 F7 E2           	mul	dx
2007:0ADA 8B D8           	mov	bx,ax
2007:0ADC 81 C3 DD A9     	add	bx,0A9DDh
2007:0AE0 1E              	push	ds
2007:0AE1 07              	pop	es
2007:0AE2 58              	pop	ax
2007:0AE3 26 88 47 01     	mov	es:[bx+1h],al
2007:0AE7 8A 46 06        	mov	al,[bp+6h]
2007:0AEA 50              	push	ax
2007:0AEB A1 83 B5        	mov	ax,[0B583h]
2007:0AEE BA 0E 00        	mov	dx,0Eh
2007:0AF1 F7 E2           	mul	dx
2007:0AF3 8B D8           	mov	bx,ax
2007:0AF5 81 C3 DD A9     	add	bx,0A9DDh
2007:0AF9 1E              	push	ds
2007:0AFA 07              	pop	es
2007:0AFB 58              	pop	ax
2007:0AFC 26 88 47 03     	mov	es:[bx+3h],al
2007:0B00 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2007:0B04 7D 34           	jge	0B3Ah

l2007_0B06:
2007:0B06 8B 5E 0A        	mov	bx,[bp+0Ah]
2007:0B09 8A 87 62 85     	mov	al,[bx+8562h]
2007:0B0D B4 00           	mov	ah,0h
2007:0B0F 8B 5E 06        	mov	bx,[bp+6h]
2007:0B12 8A 97 62 85     	mov	dl,[bx+8562h]
2007:0B16 B6 00           	mov	dh,0h
2007:0B18 2B C2           	sub	ax,dx
2007:0B1A 50              	push	ax
2007:0B1B 8B 5E 06        	mov	bx,[bp+6h]
2007:0B1E 8A 87 7B 85     	mov	al,[bx+857Bh]
2007:0B22 B4 00           	mov	ah,0h
2007:0B24 8B 5E 0A        	mov	bx,[bp+0Ah]
2007:0B27 8A 97 7B 85     	mov	dl,[bx+857Bh]
2007:0B2B B6 00           	mov	dh,0h
2007:0B2D 2B C2           	sub	ax,dx
2007:0B2F 50              	push	ax
2007:0B30 0E              	push	cs
2007:0B31 E8 19 FF        	call	0A4Dh
2007:0B34 59              	pop	cx
2007:0B35 59              	pop	cx
2007:0B36 8B F0           	mov	si,ax
2007:0B38 EB 32           	jmp	0B6Ch

l2007_0B3A:
2007:0B3A 8B 5E 06        	mov	bx,[bp+6h]
2007:0B3D 8A 87 59 83     	mov	al,[bx+8359h]
2007:0B41 B4 00           	mov	ah,0h
2007:0B43 8B 5E 06        	mov	bx,[bp+6h]
2007:0B46 8A 97 62 85     	mov	dl,[bx+8562h]
2007:0B4A B6 00           	mov	dh,0h
2007:0B4C 2B C2           	sub	ax,dx
2007:0B4E 50              	push	ax
2007:0B4F 8B 5E 06        	mov	bx,[bp+6h]
2007:0B52 8A 87 7B 85     	mov	al,[bx+857Bh]
2007:0B56 B4 00           	mov	ah,0h
2007:0B58 8B 5E 06        	mov	bx,[bp+6h]
2007:0B5B 8A 97 A7 83     	mov	dl,[bx+83A7h]
2007:0B5F B6 00           	mov	dh,0h
2007:0B61 2B C2           	sub	ax,dx
2007:0B63 50              	push	ax
2007:0B64 0E              	push	cs
2007:0B65 E8 E5 FE        	call	0A4Dh
2007:0B68 59              	pop	cx
2007:0B69 59              	pop	cx
2007:0B6A 8B F0           	mov	si,ax

l2007_0B6C:
2007:0B6C 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2007:0B70 74 06           	jz	0B78h

l2007_0B72:
2007:0B72 83 7E 0C 00     	cmp	word ptr [bp+0Ch],0h
2007:0B76 75 4C           	jnz	0BC4h

l2007_0B78:
2007:0B78 83 7E 0A 18     	cmp	word ptr [bp+0Ah],18h
2007:0B7C 75 19           	jnz	0B97h

l2007_0B7E:
2007:0B7E 8B 5E 06        	mov	bx,[bp+6h]
2007:0B81 8A 87 59 83     	mov	al,[bx+8359h]
2007:0B85 B4 00           	mov	ah,0h
2007:0B87 8B F8           	mov	di,ax
2007:0B89 8B 5E 06        	mov	bx,[bp+6h]
2007:0B8C 8A 87 A7 83     	mov	al,[bx+83A7h]
2007:0B90 B4 00           	mov	ah,0h
2007:0B92 89 46 FE        	mov	[bp-2h],ax
2007:0B95 EB 2D           	jmp	0BC4h

l2007_0B97:
2007:0B97 8B DE           	mov	bx,si
2007:0B99 D1 E3           	shl	bx,1h
2007:0B9B 8B BF 4A 17     	mov	di,[bx+174Ah]
2007:0B9F D1 E7           	shl	di,1h
2007:0BA1 8B 5E 0A        	mov	bx,[bp+0Ah]
2007:0BA4 8A 87 62 85     	mov	al,[bx+8562h]
2007:0BA8 B4 00           	mov	ah,0h
2007:0BAA 03 F8           	add	di,ax
2007:0BAC 8B DE           	mov	bx,si
2007:0BAE D1 E3           	shl	bx,1h
2007:0BB0 8B 87 5A 17     	mov	ax,[bx+175Ah]
2007:0BB4 D1 E0           	shl	ax,1h
2007:0BB6 8B 5E 0A        	mov	bx,[bp+0Ah]
2007:0BB9 8A 97 7B 85     	mov	dl,[bx+857Bh]
2007:0BBD B6 00           	mov	dh,0h
2007:0BBF 03 C2           	add	ax,dx
2007:0BC1 89 46 FE        	mov	[bp-2h],ax

l2007_0BC4:
2007:0BC4 A1 83 B5        	mov	ax,[0B583h]
2007:0BC7 BA 0E 00        	mov	dx,0Eh
2007:0BCA F7 E2           	mul	dx
2007:0BCC 8B D8           	mov	bx,ax
2007:0BCE 81 C3 DD A9     	add	bx,0A9DDh
2007:0BD2 1E              	push	ds
2007:0BD3 07              	pop	es
2007:0BD4 26 89 7F 0A     	mov	es:[bx+0Ah],di
2007:0BD8 8B 46 FE        	mov	ax,[bp-2h]
2007:0BDB 50              	push	ax
2007:0BDC A1 83 B5        	mov	ax,[0B583h]
2007:0BDF BA 0E 00        	mov	dx,0Eh
2007:0BE2 F7 E2           	mul	dx
2007:0BE4 8B D8           	mov	bx,ax
2007:0BE6 81 C3 DD A9     	add	bx,0A9DDh
2007:0BEA 1E              	push	ds
2007:0BEB 07              	pop	es
2007:0BEC 58              	pop	ax
2007:0BED 26 89 47 0C     	mov	es:[bx+0Ch],ax
2007:0BF1 8A 46 0C        	mov	al,[bp+0Ch]
2007:0BF4 50              	push	ax
2007:0BF5 A1 83 B5        	mov	ax,[0B583h]
2007:0BF8 BA 0E 00        	mov	dx,0Eh
2007:0BFB F7 E2           	mul	dx
2007:0BFD 8B D8           	mov	bx,ax
2007:0BFF 81 C3 DD A9     	add	bx,0A9DDh
2007:0C03 1E              	push	ds
2007:0C04 07              	pop	es
2007:0C05 58              	pop	ax
2007:0C06 26 88 47 02     	mov	es:[bx+2h],al
2007:0C0A 8B C6           	mov	ax,si
2007:0C0C D1 E0           	shl	ax,1h
2007:0C0E 05 0E 00        	add	ax,0Eh
2007:0C11 50              	push	ax
2007:0C12 A1 83 B5        	mov	ax,[0B583h]
2007:0C15 BA 0E 00        	mov	dx,0Eh
2007:0C18 F7 E2           	mul	dx
2007:0C1A 8B D8           	mov	bx,ax
2007:0C1C 81 C3 DD A9     	add	bx,0A9DDh
2007:0C20 1E              	push	ds
2007:0C21 07              	pop	es
2007:0C22 58              	pop	ax
2007:0C23 26 89 47 04     	mov	es:[bx+4h],ax
2007:0C27 8B 5E 06        	mov	bx,[bp+6h]
2007:0C2A 8A 87 62 85     	mov	al,[bx+8562h]
2007:0C2E B4 00           	mov	ah,0h
2007:0C30 50              	push	ax
2007:0C31 A1 83 B5        	mov	ax,[0B583h]
2007:0C34 BA 0E 00        	mov	dx,0Eh
2007:0C37 F7 E2           	mul	dx
2007:0C39 8B D8           	mov	bx,ax
2007:0C3B 81 C3 DD A9     	add	bx,0A9DDh
2007:0C3F 1E              	push	ds
2007:0C40 07              	pop	es
2007:0C41 58              	pop	ax
2007:0C42 26 89 47 06     	mov	es:[bx+6h],ax
2007:0C46 8B 5E 06        	mov	bx,[bp+6h]
2007:0C49 8A 87 7B 85     	mov	al,[bx+857Bh]
2007:0C4D B4 00           	mov	ah,0h
2007:0C4F 50              	push	ax
2007:0C50 A1 83 B5        	mov	ax,[0B583h]
2007:0C53 BA 0E 00        	mov	dx,0Eh
2007:0C56 F7 E2           	mul	dx
2007:0C58 8B D8           	mov	bx,ax
2007:0C5A 81 C3 DD A9     	add	bx,0A9DDh
2007:0C5E 1E              	push	ds
2007:0C5F 07              	pop	es
2007:0C60 58              	pop	ax
2007:0C61 26 89 47 08     	mov	es:[bx+8h],ax
2007:0C65 FF 06 83 B5     	inc	word ptr [0B583h]

l2007_0C69:
2007:0C69 5F              	pop	di
2007:0C6A 5E              	pop	si
2007:0C6B 8B E5           	mov	sp,bp
2007:0C6D 5D              	pop	bp
2007:0C6E CB              	retf

;; DrawActiveTextWindowBorder_0C6F: 2007:0C6F
;;   Called from:
;;     1A1F:4FEF (in ShowPendingNarrationPrompt_4FA6)
;;     2208:00DB (in RunTacticalUnitCommandMenu_000B)
;;     2208:14D7 (in RunTacticalGameOptionsMenu_148A)
;;     2B34:059C (in DrawTacticalUnitControlPanel_04C2)
DrawActiveTextWindowBorder_0C6F proc
2007:0C6F 55              	push	bp
2007:0C70 8B EC           	mov	bp,sp
2007:0C72 83 EC 04        	sub	sp,4h
2007:0C75 56              	push	si
2007:0C76 57              	push	di
2007:0C77 8B 36 30 62     	mov	si,[6230h]
2007:0C7B D1 E6           	shl	si,1h
2007:0C7D D1 E6           	shl	si,1h
2007:0C7F D1 E6           	shl	si,1h
2007:0C81 4E              	dec	si
2007:0C82 8B 3E 32 62     	mov	di,[6232h]
2007:0C86 D1 E7           	shl	di,1h
2007:0C88 D1 E7           	shl	di,1h
2007:0C8A D1 E7           	shl	di,1h
2007:0C8C 4F              	dec	di
2007:0C8D A1 34 62        	mov	ax,[6234h]
2007:0C90 D1 E0           	shl	ax,1h
2007:0C92 D1 E0           	shl	ax,1h
2007:0C94 D1 E0           	shl	ax,1h
2007:0C96 03 C6           	add	ax,si
2007:0C98 89 46 FC        	mov	[bp-4h],ax
2007:0C9B A1 36 62        	mov	ax,[6236h]
2007:0C9E D1 E0           	shl	ax,1h
2007:0CA0 D1 E0           	shl	ax,1h
2007:0CA2 D1 E0           	shl	ax,1h
2007:0CA4 03 C7           	add	ax,di
2007:0CA6 89 46 FE        	mov	[bp-2h],ax
2007:0CA9 FF 76 06        	push	word ptr [bp+6h]
2007:0CAC 57              	push	di
2007:0CAD FF 76 FC        	push	word ptr [bp-4h]
2007:0CB0 57              	push	di
2007:0CB1 56              	push	si
2007:0CB2 9A A6 00 65 33  	call	far 3365h:00A6h
2007:0CB7 83 C4 0A        	add	sp,0Ah
2007:0CBA FF 76 06        	push	word ptr [bp+6h]
2007:0CBD FF 76 FE        	push	word ptr [bp-2h]
2007:0CC0 56              	push	si
2007:0CC1 57              	push	di
2007:0CC2 56              	push	si
2007:0CC3 9A A6 00 65 33  	call	far 3365h:00A6h
2007:0CC8 83 C4 0A        	add	sp,0Ah
2007:0CCB FF 76 06        	push	word ptr [bp+6h]
2007:0CCE FF 76 FE        	push	word ptr [bp-2h]
2007:0CD1 FF 76 FC        	push	word ptr [bp-4h]
2007:0CD4 57              	push	di
2007:0CD5 FF 76 FC        	push	word ptr [bp-4h]
2007:0CD8 9A A6 00 65 33  	call	far 3365h:00A6h
2007:0CDD 83 C4 0A        	add	sp,0Ah
2007:0CE0 FF 76 06        	push	word ptr [bp+6h]
2007:0CE3 FF 76 FE        	push	word ptr [bp-2h]
2007:0CE6 FF 76 FC        	push	word ptr [bp-4h]
2007:0CE9 FF 76 FE        	push	word ptr [bp-2h]
2007:0CEC 56              	push	si
2007:0CED 9A A6 00 65 33  	call	far 3365h:00A6h
2007:0CF2 83 C4 0A        	add	sp,0Ah
2007:0CF5 5F              	pop	di
2007:0CF6 5E              	pop	si
2007:0CF7 8B E5           	mov	sp,bp
2007:0CF9 5D              	pop	bp
2007:0CFA CB              	retf

;; ApplyAreaTerrainAndUnitDamage_0CFB: 2007:0CFB
;;   Called from:
;;     1A1F:1A77 (in CreateRandomAreaImpact_19FD)
;;     2007:1C36 (in AdvanceMapEdgeEffects_1AE3)
ApplyAreaTerrainAndUnitDamage_0CFB proc
2007:0CFB 55              	push	bp
2007:0CFC 8B EC           	mov	bp,sp
2007:0CFE 83 EC 04        	sub	sp,4h
2007:0D01 56              	push	si
2007:0D02 57              	push	di
2007:0D03 8B 7E 06        	mov	di,[bp+6h]
2007:0D06 FF 76 0A        	push	word ptr [bp+0Ah]
2007:0D09 FF 76 08        	push	word ptr [bp+8h]
2007:0D0C 57              	push	di
2007:0D0D 0E              	push	cs
2007:0D0E E8 35 FB        	call	0846h
2007:0D11 83 C4 06        	add	sp,6h
2007:0D14 B8 03 00        	mov	ax,3h
2007:0D17 50              	push	ax
2007:0D18 FF 76 08        	push	word ptr [bp+8h]
2007:0D1B 57              	push	di
2007:0D1C 9A 50 0C 1F 1A  	call	far 1A1Fh:0C50h
2007:0D21 83 C4 06        	add	sp,6h
2007:0D24 8B C7           	mov	ax,di
2007:0D26 40              	inc	ax
2007:0D27 89 46 FC        	mov	[bp-4h],ax
2007:0D2A 8B 46 08        	mov	ax,[bp+8h]
2007:0D2D 40              	inc	ax
2007:0D2E 89 46 FE        	mov	[bp-2h],ax
2007:0D31 33 F6           	xor	si,si
2007:0D33 EB 50           	jmp	0D85h

l2007_0D35:
2007:0D35 8B C6           	mov	ax,si
2007:0D37 BA 96 00        	mov	dx,96h
2007:0D3A F7 E2           	mul	dx
2007:0D3C 8B D8           	mov	bx,ax
2007:0D3E 81 C3 81 8B     	add	bx,8B81h
2007:0D42 1E              	push	ds
2007:0D43 07              	pop	es
2007:0D44 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2007:0D48 74 3A           	jz	0D84h

l2007_0D4A:
2007:0D4A 8A 84 62 85     	mov	al,[si+8562h]
2007:0D4E B4 00           	mov	ah,0h
2007:0D50 3B C7           	cmp	ax,di
2007:0D52 74 0B           	jz	0D5Fh

l2007_0D54:
2007:0D54 8A 84 62 85     	mov	al,[si+8562h]
2007:0D58 B4 00           	mov	ah,0h
2007:0D5A 3B 46 FC        	cmp	ax,[bp-4h]
2007:0D5D 75 25           	jnz	0D84h

l2007_0D5F:
2007:0D5F 8A 84 7B 85     	mov	al,[si+857Bh]
2007:0D63 B4 00           	mov	ah,0h
2007:0D65 3B 46 08        	cmp	ax,[bp+8h]
2007:0D68 74 0B           	jz	0D75h

l2007_0D6A:
2007:0D6A 8A 84 7B 85     	mov	al,[si+857Bh]
2007:0D6E B4 00           	mov	ah,0h
2007:0D70 3B 46 FE        	cmp	ax,[bp-2h]
2007:0D73 75 0F           	jnz	0D84h

l2007_0D75:
2007:0D75 56              	push	si
2007:0D76 FF 76 0C        	push	word ptr [bp+0Ch]
2007:0D79 33 C0           	xor	ax,ax
2007:0D7B 50              	push	ax
2007:0D7C 9A 2B 1E 1B 2D  	call	far 2D1Bh:1E2Bh
2007:0D81 83 C4 06        	add	sp,6h

l2007_0D84:
2007:0D84 46              	inc	si

l2007_0D85:
2007:0D85 83 FE 18        	cmp	si,18h
2007:0D88 7C AB           	jl	0D35h

l2007_0D8A:
2007:0D8A 5F              	pop	di
2007:0D8B 5E              	pop	si
2007:0D8C 8B E5           	mov	sp,bp
2007:0D8E 5D              	pop	bp
2007:0D8F CB              	retf

;; CalculateApproximateMapDistance_0D90: 2007:0D90
;;   Called from:
;;     2208:1925 (in RebuildLanceFormationAfterLeaderLoss_18A1)
;;     2208:1EB2 (in UpdateUnitEnemyProximityState_1E43)
;;     2D1B:0A19 (in SelectUnitTacticalTargets_08FA)
;;     2D1B:0A6F (in SelectUnitTacticalTargets_08FA)
;;     2D1B:1217 (in AdvanceUnitTacticalMovement_0F1F)
;;     2D1B:130B (in AdvanceUnitTacticalMovement_0F1F)
;;     2D1B:15AD (in ExecuteUnitWeaponAI_14A4)
;;     2D1B:19A1 (in ResolveWeaponAttack_1854)
CalculateApproximateMapDistance_0D90 proc
2007:0D90 55              	push	bp
2007:0D91 8B EC           	mov	bp,sp
2007:0D93 83 EC 02        	sub	sp,2h
2007:0D96 56              	push	si
2007:0D97 57              	push	di
2007:0D98 8B 76 06        	mov	si,[bp+6h]
2007:0D9B 2B 76 0A        	sub	si,[bp+0Ah]
2007:0D9E 8B 7E 08        	mov	di,[bp+8h]
2007:0DA1 2B 7E 0C        	sub	di,[bp+0Ch]
2007:0DA4 0B F6           	or	si,si
2007:0DA6 7D 06           	jge	0DAEh

l2007_0DA8:
2007:0DA8 8B C6           	mov	ax,si
2007:0DAA F7 D8           	neg	ax
2007:0DAC 8B F0           	mov	si,ax

l2007_0DAE:
2007:0DAE 0B FF           	or	di,di
2007:0DB0 7D 06           	jge	0DB8h

l2007_0DB2:
2007:0DB2 8B C7           	mov	ax,di
2007:0DB4 F7 D8           	neg	ax
2007:0DB6 8B F8           	mov	di,ax

l2007_0DB8:
2007:0DB8 3B F7           	cmp	si,di
2007:0DBA 7E 0B           	jle	0DC7h

l2007_0DBC:
2007:0DBC 8B C7           	mov	ax,di
2007:0DBE D1 F8           	sar	ax,1h
2007:0DC0 03 C6           	add	ax,si
2007:0DC2 89 46 FE        	mov	[bp-2h],ax
2007:0DC5 EB 09           	jmp	0DD0h

l2007_0DC7:
2007:0DC7 8B C6           	mov	ax,si
2007:0DC9 D1 F8           	sar	ax,1h
2007:0DCB 03 C7           	add	ax,di
2007:0DCD 89 46 FE        	mov	[bp-2h],ax

l2007_0DD0:
2007:0DD0 8B 46 FE        	mov	ax,[bp-2h]
2007:0DD3 EB 00           	jmp	0DD5h

l2007_0DD5:
2007:0DD5 5F              	pop	di
2007:0DD6 5E              	pop	si
2007:0DD7 8B E5           	mov	sp,bp
2007:0DD9 5D              	pop	bp
2007:0DDA CB              	retf

;; DrawTacticalEffectSprite_0DDB: 2007:0DDB
;;   Called from:
;;     2007:175A (in AdvanceImpactSpriteAnimations_16E8)
;;     2007:1853 (in AdvanceTacticalProjectiles_17DE)
DrawTacticalEffectSprite_0DDB proc
2007:0DDB 55              	push	bp
2007:0DDC 8B EC           	mov	bp,sp
2007:0DDE 83 3E 04 81 00  	cmp	word ptr [8104h],0h
2007:0DE3 75 32           	jnz	0E17h

l2007_0DE5:
2007:0DE5 9A 68 39 00 08  	call	far 0800h:3968h
2007:0DEA B8 02 00        	mov	ax,2h
2007:0DED 50              	push	ax
2007:0DEE FF 76 0A        	push	word ptr [bp+0Ah]
2007:0DF1 FF 76 08        	push	word ptr [bp+8h]
2007:0DF4 8B 5E 06        	mov	bx,[bp+6h]
2007:0DF7 D1 E3           	shl	bx,1h
2007:0DF9 D1 E3           	shl	bx,1h
2007:0DFB FF B7 F0 83     	push	word ptr [bx+83F0h]
2007:0DFF FF B7 EE 83     	push	word ptr [bx+83EEh]
2007:0E03 FF 36 66 B6     	push	word ptr [0B666h]
2007:0E07 FF 36 64 B6     	push	word ptr [0B664h]
2007:0E0B 9A 08 00 05 30  	call	far 3005h:0008h
2007:0E10 8B E5           	mov	sp,bp
2007:0E12 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l2007_0E17:
2007:0E17 5D              	pop	bp
2007:0E18 CB              	retf

;; DrawSelectedUnitStatusPanel_0E19: 2007:0E19
;;   Called from:
;;     1A1F:1566 (in FindUnitAtTacticalCursor_1504)
;;     2007:16CE (in RedrawTacticalStatusPanel_16BA)
;;     2007:1D56 (in RefreshTacticalDisplay_1D06)
DrawSelectedUnitStatusPanel_0E19 proc
2007:0E19 55              	push	bp
2007:0E1A 8B EC           	mov	bp,sp
2007:0E1C 83 EC 14        	sub	sp,14h
2007:0E1F 56              	push	si
2007:0E20 57              	push	di
2007:0E21 B8 FF FF        	mov	ax,0FFFFh
2007:0E24 89 46 F4        	mov	[bp-0Ch],ax
2007:0E27 89 46 F8        	mov	[bp-8h],ax
2007:0E2A 83 3E 4B B0 00  	cmp	word ptr [0B04Bh],0h
2007:0E2F 74 0D           	jz	0E3Eh

l2007_0E31:
2007:0E31 FF 36 F2 B2     	push	word ptr [0B2F2h]
2007:0E35 9A 0C 41 1F 1A  	call	far 1A1Fh:410Ch
2007:0E3A 59              	pop	cx
2007:0E3B 89 46 F4        	mov	[bp-0Ch],ax

l2007_0E3E:
2007:0E3E 8B 36 DC 03     	mov	si,[03DCh]
2007:0E42 83 FE FF        	cmp	si,0FFh
2007:0E45 74 03           	jz	0E4Ah

l2007_0E47:
2007:0E47 E9 70 00        	jmp	0EBAh

l2007_0E4A:
2007:0E4A A1 33 83        	mov	ax,[8333h]
2007:0E4D BA 13 00        	mov	dx,13h
2007:0E50 F7 E2           	mul	dx
2007:0E52 03 06 31 83     	add	ax,[8331h]
2007:0E56 D1 E0           	shl	ax,1h
2007:0E58 C4 1E BC 99     	les	bx,[99BCh]
2007:0E5C 03 D8           	add	bx,ax
2007:0E5E 26 8B 07        	mov	ax,es:[bx]
2007:0E61 89 46 FA        	mov	[bp-6h],ax
2007:0E64 83 7E FA 00     	cmp	word ptr [bp-6h],0h
2007:0E68 74 50           	jz	0EBAh

l2007_0E6A:
2007:0E6A A1 A0 84        	mov	ax,[84A0h]
2007:0E6D 03 06 31 83     	add	ax,[8331h]
2007:0E71 89 46 EC        	mov	[bp-14h],ax
2007:0E74 A1 DA 83        	mov	ax,[83DAh]
2007:0E77 03 06 33 83     	add	ax,[8333h]
2007:0E7B 89 46 EE        	mov	[bp-12h],ax
2007:0E7E 33 FF           	xor	di,di
2007:0E80 EB 2E           	jmp	0EB0h

l2007_0E82:
2007:0E82 8B C7           	mov	ax,di
2007:0E84 BA 96 00        	mov	dx,96h
2007:0E87 F7 E2           	mul	dx
2007:0E89 8B D8           	mov	bx,ax
2007:0E8B 81 C3 81 8B     	add	bx,8B81h
2007:0E8F 1E              	push	ds
2007:0E90 07              	pop	es
2007:0E91 26 80 3F 00     	cmp	byte ptr es:[bx],0h
2007:0E95 74 18           	jz	0EAFh

l2007_0E97:
2007:0E97 8A 85 62 85     	mov	al,[di+8562h]
2007:0E9B B4 00           	mov	ah,0h
2007:0E9D 3B 46 EC        	cmp	ax,[bp-14h]
2007:0EA0 75 0D           	jnz	0EAFh

l2007_0EA2:
2007:0EA2 8A 85 7B 85     	mov	al,[di+857Bh]
2007:0EA6 B4 00           	mov	ah,0h
2007:0EA8 3B 46 EE        	cmp	ax,[bp-12h]
2007:0EAB 75 02           	jnz	0EAFh

l2007_0EAD:
2007:0EAD 8B F7           	mov	si,di

l2007_0EAF:
2007:0EAF 47              	inc	di

l2007_0EB0:
2007:0EB0 83 FF 18        	cmp	di,18h
2007:0EB3 7D 05           	jge	0EBAh

l2007_0EB5:
2007:0EB5 83 FE FF        	cmp	si,0FFh
2007:0EB8 74 C8           	jz	0E82h

l2007_0EBA:
2007:0EBA 83 FE FF        	cmp	si,0FFh
2007:0EBD 75 3E           	jnz	0EFDh

l2007_0EBF:
2007:0EBF 9A 68 39 00 08  	call	far 0800h:3968h
2007:0EC4 B8 0C 00        	mov	ax,0Ch
2007:0EC7 50              	push	ax
2007:0EC8 B8 0C 00        	mov	ax,0Ch
2007:0ECB 50              	push	ax
2007:0ECC B8 18 00        	mov	ax,18h
2007:0ECF 50              	push	ax
2007:0ED0 33 C0           	xor	ax,ax
2007:0ED2 50              	push	ax
2007:0ED3 1E              	push	ds
2007:0ED4 B8 3E 2F        	mov	ax,2F3Eh
2007:0ED7 50              	push	ax
2007:0ED8 0E              	push	cs
2007:0ED9 E8 12 F3        	call	01EEh
2007:0EDC 83 C4 0C        	add	sp,0Ch
2007:0EDF 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:0EE4 83 3E 38 2F FF  	cmp	word ptr [2F38h],0FFh
2007:0EE9 74 0F           	jz	0EFAh

l2007_0EEB:
2007:0EEB 8B 1E 38 2F     	mov	bx,[2F38h]
2007:0EEF C6 87 74 B5 FF  	mov	byte ptr [bx+0B574h],0FFh
2007:0EF4 C7 06 38 2F FF FF 	mov	word ptr [2F38h],0FFFFh

l2007_0EFA:
2007:0EFA E9 E2 01        	jmp	10DFh

l2007_0EFD:
2007:0EFD B8 06 00        	mov	ax,6h
2007:0F00 50              	push	ax
2007:0F01 9A 09 00 38 33  	call	far 3338h:0009h
2007:0F06 59              	pop	cx
2007:0F07 33 C0           	xor	ax,ax
2007:0F09 A3 3E 62        	mov	[623Eh],ax
2007:0F0C A3 3C 62        	mov	[623Ch],ax
2007:0F0F C7 06 38 62 0F 00 	mov	word ptr [6238h],0Fh
2007:0F15 C7 06 3A 62 0C 00 	mov	word ptr [623Ah],0Ch
2007:0F1B C7 46 FC 01 00  	mov	word ptr [bp-4h],1h
2007:0F20 83 FE 0C        	cmp	si,0Ch
2007:0F23 7C 4C           	jl	0F71h

l2007_0F25:
2007:0F25 9A 68 39 00 08  	call	far 0800h:3968h
2007:0F2A 83 3E DC 03 FF  	cmp	word ptr [03DCh],0FFh
2007:0F2F 75 21           	jnz	0F52h

l2007_0F31:
2007:0F31 8B 46 FA        	mov	ax,[bp-6h]
2007:0F34 25 FF 00        	and	ax,0FFh
2007:0F37 3D EF 00        	cmp	ax,0EFh
2007:0F3A 75 16           	jnz	0F52h

l2007_0F3C:
2007:0F3C 9A 06 00 6D 35  	call	far 356Dh:0006h
2007:0F41 9A FF 15 07 20  	call	far 2007h:15FFh
2007:0F46 9A 9F 15 07 20  	call	far 2007h:159Fh
2007:0F4B C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
2007:0F50 EB 1A           	jmp	0F6Ch

l2007_0F52:
2007:0F52 80 BC 67 86 00  	cmp	byte ptr [si+8667h],0h
2007:0F57 75 13           	jnz	0F6Ch

l2007_0F59:
2007:0F59 80 BC 80 86 00  	cmp	byte ptr [si+8680h],0h
2007:0F5E 75 0C           	jnz	0F6Ch

l2007_0F60:
2007:0F60 83 3E E5 03 00  	cmp	word ptr [03E5h],0h
2007:0F65 74 05           	jz	0F6Ch

l2007_0F67:
2007:0F67 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h

l2007_0F6C:
2007:0F6C 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l2007_0F71:
2007:0F71 83 7E FC 00     	cmp	word ptr [bp-4h],0h
2007:0F75 75 03           	jnz	0F7Ah

l2007_0F77:
2007:0F77 E9 65 01        	jmp	10DFh

l2007_0F7A:
2007:0F7A 9A 68 39 00 08  	call	far 0800h:3968h
2007:0F7F 83 FE 04        	cmp	si,4h
2007:0F82 7C 0B           	jl	0F8Fh

l2007_0F84:
2007:0F84 56              	push	si
2007:0F85 9A 29 18 08 22  	call	far 2208h:1829h
2007:0F8A 59              	pop	cx
2007:0F8B 0B C0           	or	ax,ax
2007:0F8D 74 1F           	jz	0FAEh

l2007_0F8F:
2007:0F8F 83 FE 0C        	cmp	si,0Ch
2007:0F92 7D 0E           	jge	0FA2h

l2007_0F94:
2007:0F94 1E              	push	ds
2007:0F95 B8 20 46        	mov	ax,4620h
2007:0F98 50              	push	ax
2007:0F99 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2007:0F9E 59              	pop	cx
2007:0F9F 59              	pop	cx
2007:0FA0 EB 0C           	jmp	0FAEh

l2007_0FA2:
2007:0FA2 1E              	push	ds
2007:0FA3 B8 5A 2F        	mov	ax,2F5Ah
2007:0FA6 50              	push	ax
2007:0FA7 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2007:0FAC 59              	pop	cx
2007:0FAD 59              	pop	cx

l2007_0FAE:
2007:0FAE 83 FE 0C        	cmp	si,0Ch
2007:0FB1 7C 0A           	jl	0FBDh

l2007_0FB3:
2007:0FB3 C7 06 38 62 06 00 	mov	word ptr [6238h],6h
2007:0FB9 89 36 DE 03     	mov	[03DEh],si

l2007_0FBD:
2007:0FBD 8B C6           	mov	ax,si
2007:0FBF BA 96 00        	mov	dx,96h
2007:0FC2 F7 E2           	mul	dx
2007:0FC4 8B D8           	mov	bx,ax
2007:0FC6 81 C3 81 8B     	add	bx,8B81h
2007:0FCA 1E              	push	ds
2007:0FCB 07              	pop	es
2007:0FCC 26 8A 47 01     	mov	al,es:[bx+1h]
2007:0FD0 98              	cbw
2007:0FD1 8B D8           	mov	bx,ax
2007:0FD3 D1 E3           	shl	bx,1h
2007:0FD5 D1 E3           	shl	bx,1h
2007:0FD7 FF B7 30 3D     	push	word ptr [bx+3D30h]
2007:0FDB FF B7 2E 3D     	push	word ptr [bx+3D2Eh]
2007:0FDF 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2007:0FE4 59              	pop	cx
2007:0FE5 59              	pop	cx
2007:0FE6 1E              	push	ds
2007:0FE7 B8 5E 2F        	mov	ax,2F5Eh
2007:0FEA 50              	push	ax
2007:0FEB 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2007:0FF0 59              	pop	cx
2007:0FF1 59              	pop	cx
2007:0FF2 56              	push	si
2007:0FF3 9A 61 1D 07 20  	call	far 2007h:1D61h
2007:0FF8 59              	pop	cx
2007:0FF9 1E              	push	ds
2007:0FFA B8 60 2F        	mov	ax,2F60h
2007:0FFD 50              	push	ax
2007:0FFE 1E              	push	ds
2007:0FFF B8 7E B6        	mov	ax,0B67Eh
2007:1002 50              	push	ax
2007:1003 9A 01 00 7A 39  	call	far 397Ah:0001h
2007:1008 83 C4 08        	add	sp,8h
2007:100B 8B C6           	mov	ax,si
2007:100D BA 96 00        	mov	dx,96h
2007:1010 F7 E2           	mul	dx
2007:1012 8B D8           	mov	bx,ax
2007:1014 81 C3 81 8B     	add	bx,8B81h
2007:1018 1E              	push	ds
2007:1019 07              	pop	es
2007:101A 26 8B 87 87 00  	mov	ax,es:[bx+87h]
2007:101F 25 FF 00        	and	ax,0FFh
2007:1022 BB 05 00        	mov	bx,5h
2007:1025 33 D2           	xor	dx,dx
2007:1027 F7 F3           	div	bx
2007:1029 89 46 F6        	mov	[bp-0Ah],ax
2007:102C 83 7E F6 05     	cmp	word ptr [bp-0Ah],5h
2007:1030 7E 05           	jle	1037h

l2007_1032:
2007:1032 C7 46 F6 05 00  	mov	word ptr [bp-0Ah],5h

l2007_1037:
2007:1037 80 BC 4A A8 00  	cmp	byte ptr [si+0A84Ah],0h
2007:103C 74 05           	jz	1043h

l2007_103E:
2007:103E C7 46 F6 06 00  	mov	word ptr [bp-0Ah],6h

l2007_1043:
2007:1043 8B 5E F6        	mov	bx,[bp-0Ah]
2007:1046 D1 E3           	shl	bx,1h
2007:1048 D1 E3           	shl	bx,1h
2007:104A FF B7 13 41     	push	word ptr [bx+4113h]
2007:104E FF B7 11 41     	push	word ptr [bx+4111h]
2007:1052 1E              	push	ds
2007:1053 B8 7E B6        	mov	ax,0B67Eh
2007:1056 50              	push	ax
2007:1057 9A 01 00 7A 39  	call	far 397Ah:0001h
2007:105C 83 C4 08        	add	sp,8h
2007:105F 1E              	push	ds
2007:1060 B8 7E B6        	mov	ax,0B67Eh
2007:1063 50              	push	ax
2007:1064 9A 03 00 7E 39  	call	far 397Eh:0003h
2007:1069 59              	pop	cx
2007:106A 59              	pop	cx
2007:106B 8B F8           	mov	di,ax
2007:106D EB 06           	jmp	1075h

l2007_106F:
2007:106F C6 85 7E B6 20  	mov	byte ptr [di+0B67Eh],20h
2007:1074 47              	inc	di

l2007_1075:
2007:1075 8B C7           	mov	ax,di
2007:1077 03 06 3C 62     	add	ax,[623Ch]
2007:107B 3D 1B 00        	cmp	ax,1Bh
2007:107E 7C EF           	jl	106Fh

l2007_1080:
2007:1080 BB 1B 00        	mov	bx,1Bh
2007:1083 2B 1E 3C 62     	sub	bx,[623Ch]
2007:1087 C6 87 7E B6 00  	mov	byte ptr [bx+0B67Eh],0h
2007:108C 1E              	push	ds
2007:108D B8 7E B6        	mov	ax,0B67Eh
2007:1090 50              	push	ax
2007:1091 9A 0A 00 CE 35  	call	far 35CEh:000Ah
2007:1096 59              	pop	cx
2007:1097 59              	pop	cx
2007:1098 56              	push	si
2007:1099 9A 0C 41 1F 1A  	call	far 1A1Fh:410Ch
2007:109E 59              	pop	cx
2007:109F 89 46 F8        	mov	[bp-8h],ax
2007:10A2 89 46 F2        	mov	[bp-0Eh],ax
2007:10A5 83 7E F2 FF     	cmp	word ptr [bp-0Eh],0FFh
2007:10A9 74 2F           	jz	10DAh

l2007_10AB:
2007:10AB 83 7E F4 FF     	cmp	word ptr [bp-0Ch],0FFh
2007:10AF 74 08           	jz	10B9h

l2007_10B1:
2007:10B1 8B 46 F2        	mov	ax,[bp-0Eh]
2007:10B4 3B 46 F4        	cmp	ax,[bp-0Ch]
2007:10B7 74 0B           	jz	10C4h

l2007_10B9:
2007:10B9 FF 76 F2        	push	word ptr [bp-0Eh]
2007:10BC 9A DF 14 07 20  	call	far 2007h:14DFh
2007:10C1 59              	pop	cx
2007:10C2 EB 10           	jmp	10D4h

l2007_10C4:
2007:10C4 80 3E BD 86 00  	cmp	byte ptr [86BDh],0h
2007:10C9 75 09           	jnz	10D4h

l2007_10CB:
2007:10CB FF 76 F2        	push	word ptr [bp-0Eh]
2007:10CE 9A DF 14 07 20  	call	far 2007h:14DFh
2007:10D3 59              	pop	cx

l2007_10D4:
2007:10D4 8B 46 F2        	mov	ax,[bp-0Eh]
2007:10D7 A3 38 2F        	mov	[2F38h],ax

l2007_10DA:
2007:10DA 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l2007_10DF:
2007:10DF FF 0E 36 2F     	dec	word ptr [2F36h]
2007:10E3 7F 14           	jg	10F9h

l2007_10E5:
2007:10E5 C7 06 36 2F 0A 00 	mov	word ptr [2F36h],0Ah
2007:10EB 80 36 BD 86 01  	xor	byte ptr [86BDh],1h
2007:10F0 B8 FF FF        	mov	ax,0FFFFh
2007:10F3 A3 DA B5        	mov	[0B5DAh],ax
2007:10F6 A3 6B A9        	mov	[0A96Bh],ax

l2007_10F9:
2007:10F9 83 3E 4B B0 00  	cmp	word ptr [0B04Bh],0h
2007:10FE 75 03           	jnz	1103h

l2007_1100:
2007:1100 E9 E5 00        	jmp	11E8h

l2007_1103:
2007:1103 81 3E 4B B0 58 02 	cmp	word ptr [0B04Bh],258h
2007:1109 75 3A           	jnz	1145h

l2007_110B:
2007:110B 83 3E 27 89 01  	cmp	word ptr [8927h],1h
2007:1110 75 0B           	jnz	111Dh

l2007_1112:
2007:1112 33 C0           	xor	ax,ax
2007:1114 50              	push	ax
2007:1115 9A 67 05 FB 31  	call	far 31FBh:0567h
2007:111A 59              	pop	cx
2007:111B EB 28           	jmp	1145h

l2007_111D:
2007:111D C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2007:1122 83 3E D2 B5 00  	cmp	word ptr [0B5D2h],0h
2007:1127 75 07           	jnz	1130h

l2007_1129:
2007:1129 83 3E F2 B2 00  	cmp	word ptr [0B2F2h],0h
2007:112E 75 05           	jnz	1135h

l2007_1130:
2007:1130 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h

l2007_1135:
2007:1135 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2007:1139 74 0A           	jz	1145h

l2007_113B:
2007:113B FF 36 81 B5     	push	word ptr [0B581h]
2007:113F 9A 42 07 FB 31  	call	far 31FBh:0742h
2007:1144 59              	pop	cx

l2007_1145:
2007:1145 9A 68 39 00 08  	call	far 0800h:3968h
2007:114A 80 3E BD 86 00  	cmp	byte ptr [86BDh],0h
2007:114F 74 43           	jz	1194h

l2007_1151:
2007:1151 C7 46 F0 0A 00  	mov	word ptr [bp-10h],0Ah
2007:1156 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
2007:115B 74 05           	jz	1162h

l2007_115D:
2007:115D C7 46 F0 08 00  	mov	word ptr [bp-10h],8h

l2007_1162:
2007:1162 B8 0C 00        	mov	ax,0Ch
2007:1165 50              	push	ax
2007:1166 FF 76 F0        	push	word ptr [bp-10h]
2007:1169 B8 18 00        	mov	ax,18h
2007:116C 50              	push	ax
2007:116D B8 1B 00        	mov	ax,1Bh
2007:1170 50              	push	ax
2007:1171 1E              	push	ds
2007:1172 B8 24 46        	mov	ax,4624h
2007:1175 50              	push	ax
2007:1176 0E              	push	cs
2007:1177 E8 74 F0        	call	01EEh
2007:117A 83 C4 0C        	add	sp,0Ch
2007:117D 8B 46 F0        	mov	ax,[bp-10h]
2007:1180 A3 D6 B5        	mov	[0B5D6h],ax
2007:1183 83 7E F4 FF     	cmp	word ptr [bp-0Ch],0FFh
2007:1187 74 09           	jz	1192h

l2007_1189:
2007:1189 FF 76 F4        	push	word ptr [bp-0Ch]
2007:118C 9A 44 15 07 20  	call	far 2007h:1544h
2007:1191 59              	pop	cx

l2007_1192:
2007:1192 EB 39           	jmp	11CDh

l2007_1194:
2007:1194 B8 0C 00        	mov	ax,0Ch
2007:1197 50              	push	ax
2007:1198 B8 0C 00        	mov	ax,0Ch
2007:119B 50              	push	ax
2007:119C B8 18 00        	mov	ax,18h
2007:119F 50              	push	ax
2007:11A0 B8 1B 00        	mov	ax,1Bh
2007:11A3 50              	push	ax
2007:11A4 1E              	push	ds
2007:11A5 B8 62 2F        	mov	ax,2F62h
2007:11A8 50              	push	ax
2007:11A9 0E              	push	cs
2007:11AA E8 41 F0        	call	01EEh
2007:11AD 83 C4 0C        	add	sp,0Ch
2007:11B0 C7 06 D6 B5 00 00 	mov	word ptr [0B5D6h],0h
2007:11B6 83 7E F4 FF     	cmp	word ptr [bp-0Ch],0FFh
2007:11BA 74 11           	jz	11CDh

l2007_11BC:
2007:11BC 8B 46 F4        	mov	ax,[bp-0Ch]
2007:11BF 3B 46 F8        	cmp	ax,[bp-8h]
2007:11C2 74 09           	jz	11CDh

l2007_11C4:
2007:11C4 FF 76 F4        	push	word ptr [bp-0Ch]
2007:11C7 9A 44 15 07 20  	call	far 2007h:1544h
2007:11CC 59              	pop	cx

l2007_11CD:
2007:11CD 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:11D2 FF 0E 4B B0     	dec	word ptr [0B04Bh]
2007:11D6 75 0E           	jnz	11E6h

l2007_11D8:
2007:11D8 C7 06 85 B5 00 00 	mov	word ptr [0B585h],0h
2007:11DE 8B 5E F4        	mov	bx,[bp-0Ch]
2007:11E1 C6 87 74 B5 FF  	mov	byte ptr [bx+0B574h],0FFh

l2007_11E6:
2007:11E6 EB 26           	jmp	120Eh

l2007_11E8:
2007:11E8 9A 68 39 00 08  	call	far 0800h:3968h
2007:11ED B8 0C 00        	mov	ax,0Ch
2007:11F0 50              	push	ax
2007:11F1 B8 0C 00        	mov	ax,0Ch
2007:11F4 50              	push	ax
2007:11F5 B8 18 00        	mov	ax,18h
2007:11F8 50              	push	ax
2007:11F9 B8 1B 00        	mov	ax,1Bh
2007:11FC 50              	push	ax
2007:11FD 1E              	push	ds
2007:11FE B8 66 2F        	mov	ax,2F66h
2007:1201 50              	push	ax
2007:1202 0E              	push	cs
2007:1203 E8 E8 EF        	call	01EEh
2007:1206 83 C4 0C        	add	sp,0Ch
2007:1209 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l2007_120E:
2007:120E 9A CC 1D 07 20  	call	far 2007h:1DCCh
2007:1213 5F              	pop	di
2007:1214 5E              	pop	si
2007:1215 8B E5           	mov	sp,bp
2007:1217 5D              	pop	bp
2007:1218 CB              	retf

;; BuildTacticalTerrainEffectOverlay_1219: 2007:1219
;;   Called from:
;;     2007:0678 (in RebuildTacticalViewport_0650)
BuildTacticalTerrainEffectOverlay_1219 proc
2007:1219 56              	push	si
2007:121A 9A 99 09 00 08  	call	far 0800h:0999h
2007:121F 33 F6           	xor	si,si
2007:1221 E9 FE 00        	jmp	1322h

l2007_1224:
2007:1224 80 3E BE 84 00  	cmp	byte ptr [84BEh],0h
2007:1229 75 31           	jnz	125Ch

l2007_122B:
2007:122B 8B C6           	mov	ax,si
2007:122D BA 06 00        	mov	dx,6h
2007:1230 F7 E2           	mul	dx
2007:1232 8B D8           	mov	bx,ax
2007:1234 81 C3 0C 81     	add	bx,810Ch
2007:1238 1E              	push	ds
2007:1239 07              	pop	es
2007:123A 26 FF 47 04     	inc	word ptr es:[bx+4h]
2007:123E 26 8B 47 04     	mov	ax,es:[bx+4h]
2007:1242 3D 02 00        	cmp	ax,2h
2007:1245 7E 15           	jle	125Ch

l2007_1247:
2007:1247 8B C6           	mov	ax,si
2007:1249 BA 06 00        	mov	dx,6h
2007:124C F7 E2           	mul	dx
2007:124E 8B D8           	mov	bx,ax
2007:1250 81 C3 0C 81     	add	bx,810Ch
2007:1254 1E              	push	ds
2007:1255 07              	pop	es
2007:1256 26 C7 47 04 00 00 	mov	word ptr es:[bx+4h],0h

l2007_125C:
2007:125C 8B C6           	mov	ax,si
2007:125E BA 06 00        	mov	dx,6h
2007:1261 F7 E2           	mul	dx
2007:1263 8B D8           	mov	bx,ax
2007:1265 81 C3 0C 81     	add	bx,810Ch
2007:1269 1E              	push	ds
2007:126A 07              	pop	es
2007:126B 26 8B 07        	mov	ax,es:[bx]
2007:126E 3B 06 A0 84     	cmp	ax,[84A0h]
2007:1272 7D 03           	jge	1277h

l2007_1274:
2007:1274 E9 AA 00        	jmp	1321h

l2007_1277:
2007:1277 8B C6           	mov	ax,si
2007:1279 BA 06 00        	mov	dx,6h
2007:127C F7 E2           	mul	dx
2007:127E 8B D8           	mov	bx,ax
2007:1280 81 C3 0C 81     	add	bx,810Ch
2007:1284 1E              	push	ds
2007:1285 07              	pop	es
2007:1286 26 8B 07        	mov	ax,es:[bx]
2007:1289 8B 16 A0 84     	mov	dx,[84A0h]
2007:128D 83 C2 13        	add	dx,13h
2007:1290 3B C2           	cmp	ax,dx
2007:1292 7C 03           	jl	1297h

l2007_1294:
2007:1294 E9 8A 00        	jmp	1321h

l2007_1297:
2007:1297 8B C6           	mov	ax,si
2007:1299 BA 06 00        	mov	dx,6h
2007:129C F7 E2           	mul	dx
2007:129E 8B D8           	mov	bx,ax
2007:12A0 81 C3 0C 81     	add	bx,810Ch
2007:12A4 1E              	push	ds
2007:12A5 07              	pop	es
2007:12A6 26 8B 47 02     	mov	ax,es:[bx+2h]
2007:12AA 3B 06 DA 83     	cmp	ax,[83DAh]
2007:12AE 7C 71           	jl	1321h

l2007_12B0:
2007:12B0 8B C6           	mov	ax,si
2007:12B2 BA 06 00        	mov	dx,6h
2007:12B5 F7 E2           	mul	dx
2007:12B7 8B D8           	mov	bx,ax
2007:12B9 81 C3 0C 81     	add	bx,810Ch
2007:12BD 1E              	push	ds
2007:12BE 07              	pop	es
2007:12BF 26 8B 47 02     	mov	ax,es:[bx+2h]
2007:12C3 8B 16 DA 83     	mov	dx,[83DAh]
2007:12C7 83 C2 0C        	add	dx,0Ch
2007:12CA 3B C2           	cmp	ax,dx
2007:12CC 7D 53           	jge	1321h

l2007_12CE:
2007:12CE 8B C6           	mov	ax,si
2007:12D0 BA 06 00        	mov	dx,6h
2007:12D3 F7 E2           	mul	dx
2007:12D5 8B D8           	mov	bx,ax
2007:12D7 81 C3 0C 81     	add	bx,810Ch
2007:12DB 1E              	push	ds
2007:12DC 07              	pop	es
2007:12DD 26 8A 47 04     	mov	al,es:[bx+4h]
2007:12E1 FE C0           	inc	al
2007:12E3 50              	push	ax
2007:12E4 8B C6           	mov	ax,si
2007:12E6 BA 06 00        	mov	dx,6h
2007:12E9 F7 E2           	mul	dx
2007:12EB 8B D8           	mov	bx,ax
2007:12ED 81 C3 0C 81     	add	bx,810Ch
2007:12F1 1E              	push	ds
2007:12F2 07              	pop	es
2007:12F3 26 8B 47 02     	mov	ax,es:[bx+2h]
2007:12F7 2B 06 DA 83     	sub	ax,[83DAh]
2007:12FB BA 13 00        	mov	dx,13h
2007:12FE F7 E2           	mul	dx
2007:1300 8B D8           	mov	bx,ax
2007:1302 8B C6           	mov	ax,si
2007:1304 BA 06 00        	mov	dx,6h
2007:1307 F7 E2           	mul	dx
2007:1309 53              	push	bx
2007:130A 8B D8           	mov	bx,ax
2007:130C 81 C3 0C 81     	add	bx,810Ch
2007:1310 1E              	push	ds
2007:1311 07              	pop	es
2007:1312 26 8B 07        	mov	ax,es:[bx]
2007:1315 2B 06 A0 84     	sub	ax,[84A0h]
2007:1319 5B              	pop	bx
2007:131A 03 D8           	add	bx,ax
2007:131C 58              	pop	ax
2007:131D 88 87 78 79     	mov	[bx+7978h],al

l2007_1321:
2007:1321 46              	inc	si

l2007_1322:
2007:1322 83 FE 5A        	cmp	si,5Ah
2007:1325 7D 03           	jge	132Ah

l2007_1327:
2007:1327 E9 FA FE        	jmp	1224h

l2007_132A:
2007:132A 5E              	pop	si
2007:132B CB              	retf

;; DrawBeveledMenuButton_132C: 2007:132C
;;   Called from:
;;     0D73:2649 (in RunMainMenuSelection_25F5)
;;     0D73:26AD (in RunMainMenuSelection_25F5)
;;     0D73:26FF (in RunMainMenuSelection_25F5)
;;     1A1F:5040 (in ShowPendingNarrationPrompt_4FA6)
;;     1A1F:5074 (in ShowPendingNarrationPrompt_4FA6)
;;     1A1F:50A0 (in ShowPendingNarrationPrompt_4FA6)
DrawBeveledMenuButton_132C proc
2007:132C 55              	push	bp
2007:132D 8B EC           	mov	bp,sp
2007:132F 83 EC 02        	sub	sp,2h
2007:1332 56              	push	si
2007:1333 57              	push	di
2007:1334 8B 36 30 62     	mov	si,[6230h]
2007:1338 D1 E6           	shl	si,1h
2007:133A D1 E6           	shl	si,1h
2007:133C D1 E6           	shl	si,1h
2007:133E A0 66 86        	mov	al,[8666h]
2007:1341 98              	cbw
2007:1342 F7 66 06        	mul	word ptr [bp+6h]
2007:1345 03 F0           	add	si,ax
2007:1347 A0 BB 99        	mov	al,[99BBh]
2007:134A 98              	cbw
2007:134B 89 46 FE        	mov	[bp-2h],ax
2007:134E 8B 3E 32 62     	mov	di,[6232h]
2007:1352 D1 E7           	shl	di,1h
2007:1354 D1 E7           	shl	di,1h
2007:1356 D1 E7           	shl	di,1h
2007:1358 8B 46 08        	mov	ax,[bp+8h]
2007:135B F7 66 FE        	mul	word ptr [bp-2h]
2007:135E 03 F8           	add	di,ax
2007:1360 9A 68 39 00 08  	call	far 0800h:3968h
2007:1365 B8 0E 00        	mov	ax,0Eh
2007:1368 50              	push	ax
2007:1369 8B C7           	mov	ax,di
2007:136B 03 46 FE        	add	ax,[bp-2h]
2007:136E 40              	inc	ax
2007:136F 50              	push	ax
2007:1370 8B C6           	mov	ax,si
2007:1372 03 46 0E        	add	ax,[bp+0Eh]
2007:1375 40              	inc	ax
2007:1376 40              	inc	ax
2007:1377 50              	push	ax
2007:1378 8B C7           	mov	ax,di
2007:137A 05 FE FF        	add	ax,0FFFEh
2007:137D 50              	push	ax
2007:137E 8B C6           	mov	ax,si
2007:1380 05 FE FF        	add	ax,0FFFEh
2007:1383 50              	push	ax
2007:1384 9A 0E 00 71 34  	call	far 3471h:000Eh
2007:1389 83 C4 0A        	add	sp,0Ah
2007:138C 33 C0           	xor	ax,ax
2007:138E 50              	push	ax
2007:138F B8 0F 00        	mov	ax,0Fh
2007:1392 50              	push	ax
2007:1393 FF 76 0E        	push	word ptr [bp+0Eh]
2007:1396 57              	push	di
2007:1397 56              	push	si
2007:1398 33 C0           	xor	ax,ax
2007:139A 50              	push	ax
2007:139B FF 76 0C        	push	word ptr [bp+0Ch]
2007:139E FF 76 0A        	push	word ptr [bp+0Ah]
2007:13A1 9A 35 3E 73 0D  	call	far 0D73h:3E35h
2007:13A6 83 C4 10        	add	sp,10h
2007:13A9 B8 0F 00        	mov	ax,0Fh
2007:13AC 50              	push	ax
2007:13AD 8B C7           	mov	ax,di
2007:13AF 05 FD FF        	add	ax,0FFFDh
2007:13B2 50              	push	ax
2007:13B3 8B C6           	mov	ax,si
2007:13B5 03 46 0E        	add	ax,[bp+0Eh]
2007:13B8 40              	inc	ax
2007:13B9 40              	inc	ax
2007:13BA 50              	push	ax
2007:13BB 8B C7           	mov	ax,di
2007:13BD 05 FD FF        	add	ax,0FFFDh
2007:13C0 50              	push	ax
2007:13C1 8B C6           	mov	ax,si
2007:13C3 05 FC FF        	add	ax,0FFFCh
2007:13C6 50              	push	ax
2007:13C7 9A A6 00 65 33  	call	far 3365h:00A6h
2007:13CC 83 C4 0A        	add	sp,0Ah
2007:13CF B8 0F 00        	mov	ax,0Fh
2007:13D2 50              	push	ax
2007:13D3 8B C7           	mov	ax,di
2007:13D5 05 FE FF        	add	ax,0FFFEh
2007:13D8 50              	push	ax
2007:13D9 8B C6           	mov	ax,si
2007:13DB 03 46 0E        	add	ax,[bp+0Eh]
2007:13DE 40              	inc	ax
2007:13DF 50              	push	ax
2007:13E0 8B C7           	mov	ax,di
2007:13E2 05 FE FF        	add	ax,0FFFEh
2007:13E5 50              	push	ax
2007:13E6 8B C6           	mov	ax,si
2007:13E8 05 FD FF        	add	ax,0FFFDh
2007:13EB 50              	push	ax
2007:13EC 9A A6 00 65 33  	call	far 3365h:00A6h
2007:13F1 83 C4 0A        	add	sp,0Ah
2007:13F4 B8 0F 00        	mov	ax,0Fh
2007:13F7 50              	push	ax
2007:13F8 8B C7           	mov	ax,di
2007:13FA 03 46 FE        	add	ax,[bp-2h]
2007:13FD 40              	inc	ax
2007:13FE 50              	push	ax
2007:13FF 8B C6           	mov	ax,si
2007:1401 05 FC FF        	add	ax,0FFFCh
2007:1404 50              	push	ax
2007:1405 8B C7           	mov	ax,di
2007:1407 05 FE FF        	add	ax,0FFFEh
2007:140A 50              	push	ax
2007:140B 8B C6           	mov	ax,si
2007:140D 05 FC FF        	add	ax,0FFFCh
2007:1410 50              	push	ax
2007:1411 9A A6 00 65 33  	call	far 3365h:00A6h
2007:1416 83 C4 0A        	add	sp,0Ah
2007:1419 B8 0F 00        	mov	ax,0Fh
2007:141C 50              	push	ax
2007:141D 8B C7           	mov	ax,di
2007:141F 03 46 FE        	add	ax,[bp-2h]
2007:1422 50              	push	ax
2007:1423 8B C6           	mov	ax,si
2007:1425 05 FD FF        	add	ax,0FFFDh
2007:1428 50              	push	ax
2007:1429 8B C7           	mov	ax,di
2007:142B 48              	dec	ax
2007:142C 50              	push	ax
2007:142D 8B C6           	mov	ax,si
2007:142F 05 FD FF        	add	ax,0FFFDh
2007:1432 50              	push	ax
2007:1433 9A A6 00 65 33  	call	far 3365h:00A6h
2007:1438 83 C4 0A        	add	sp,0Ah
2007:143B B8 0D 00        	mov	ax,0Dh
2007:143E 50              	push	ax
2007:143F 8B C7           	mov	ax,di
2007:1441 03 46 FE        	add	ax,[bp-2h]
2007:1444 40              	inc	ax
2007:1445 50              	push	ax
2007:1446 8B C6           	mov	ax,si
2007:1448 03 46 0E        	add	ax,[bp+0Eh]
2007:144B 40              	inc	ax
2007:144C 40              	inc	ax
2007:144D 50              	push	ax
2007:144E 8B C7           	mov	ax,di
2007:1450 05 FE FF        	add	ax,0FFFEh
2007:1453 50              	push	ax
2007:1454 8B C6           	mov	ax,si
2007:1456 03 46 0E        	add	ax,[bp+0Eh]
2007:1459 40              	inc	ax
2007:145A 40              	inc	ax
2007:145B 50              	push	ax
2007:145C 9A A6 00 65 33  	call	far 3365h:00A6h
2007:1461 83 C4 0A        	add	sp,0Ah
2007:1464 B8 0D 00        	mov	ax,0Dh
2007:1467 50              	push	ax
2007:1468 8B C7           	mov	ax,di
2007:146A 03 46 FE        	add	ax,[bp-2h]
2007:146D 50              	push	ax
2007:146E 8B C6           	mov	ax,si
2007:1470 03 46 0E        	add	ax,[bp+0Eh]
2007:1473 40              	inc	ax
2007:1474 50              	push	ax
2007:1475 8B C7           	mov	ax,di
2007:1477 48              	dec	ax
2007:1478 50              	push	ax
2007:1479 8B C6           	mov	ax,si
2007:147B 03 46 0E        	add	ax,[bp+0Eh]
2007:147E 40              	inc	ax
2007:147F 50              	push	ax
2007:1480 9A A6 00 65 33  	call	far 3365h:00A6h
2007:1485 83 C4 0A        	add	sp,0Ah
2007:1488 B8 0D 00        	mov	ax,0Dh
2007:148B 50              	push	ax
2007:148C 8B C7           	mov	ax,di
2007:148E 03 46 FE        	add	ax,[bp-2h]
2007:1491 50              	push	ax
2007:1492 8B C6           	mov	ax,si
2007:1494 03 46 0E        	add	ax,[bp+0Eh]
2007:1497 40              	inc	ax
2007:1498 50              	push	ax
2007:1499 8B C7           	mov	ax,di
2007:149B 03 46 FE        	add	ax,[bp-2h]
2007:149E 50              	push	ax
2007:149F 8B C6           	mov	ax,si
2007:14A1 05 FE FF        	add	ax,0FFFEh
2007:14A4 50              	push	ax
2007:14A5 9A A6 00 65 33  	call	far 3365h:00A6h
2007:14AA 83 C4 0A        	add	sp,0Ah
2007:14AD B8 0D 00        	mov	ax,0Dh
2007:14B0 50              	push	ax
2007:14B1 8B C7           	mov	ax,di
2007:14B3 03 46 FE        	add	ax,[bp-2h]
2007:14B6 40              	inc	ax
2007:14B7 50              	push	ax
2007:14B8 8B C6           	mov	ax,si
2007:14BA 03 46 0E        	add	ax,[bp+0Eh]
2007:14BD 40              	inc	ax
2007:14BE 50              	push	ax
2007:14BF 8B C7           	mov	ax,di
2007:14C1 03 46 FE        	add	ax,[bp-2h]
2007:14C4 40              	inc	ax
2007:14C5 50              	push	ax
2007:14C6 8B C6           	mov	ax,si
2007:14C8 05 FD FF        	add	ax,0FFFDh
2007:14CB 50              	push	ax
2007:14CC 9A A6 00 65 33  	call	far 3365h:00A6h
2007:14D1 83 C4 0A        	add	sp,0Ah
2007:14D4 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:14D9 5F              	pop	di
2007:14DA 5E              	pop	si
2007:14DB 8B E5           	mov	sp,bp
2007:14DD 5D              	pop	bp
2007:14DE CB              	retf

;; UpdatePrimaryUnitStatusRowHighlight_14DF: 2007:14DF
;;   Called from:
;;     2007:10BC (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:10CE (in DrawSelectedUnitStatusPanel_0E19)
UpdatePrimaryUnitStatusRowHighlight_14DF proc
2007:14DF 55              	push	bp
2007:14E0 8B EC           	mov	bp,sp
2007:14E2 56              	push	si
2007:14E3 57              	push	di
2007:14E4 8B 76 06        	mov	si,[bp+6h]
2007:14E7 83 3E FE 80 00  	cmp	word ptr [80FEh],0h
2007:14EC 75 52           	jnz	1540h

l2007_14EE:
2007:14EE A1 3A 2F        	mov	ax,[2F3Ah]
2007:14F1 3B C6           	cmp	ax,si
2007:14F3 75 09           	jnz	14FEh

l2007_14F5:
2007:14F5 A1 DA B5        	mov	ax,[0B5DAh]
2007:14F8 3B 06 00 81     	cmp	ax,[8100h]
2007:14FC 74 42           	jz	1540h

l2007_14FE:
2007:14FE 8B C6           	mov	ax,si
2007:1500 BA 14 00        	mov	dx,14h
2007:1503 F7 E2           	mul	dx
2007:1505 8B F8           	mov	di,ax
2007:1507 83 FE 05        	cmp	si,5h
2007:150A 7C 03           	jl	150Fh

l2007_150C:
2007:150C 83 C7 04        	add	di,4h

l2007_150F:
2007:150F 83 FE 07        	cmp	si,7h
2007:1512 75 03           	jnz	1517h

l2007_1514:
2007:1514 83 C7 08        	add	di,8h

l2007_1517:
2007:1517 FF 36 00 81     	push	word ptr [8100h]
2007:151B 57              	push	di
2007:151C 33 C0           	xor	ax,ax
2007:151E 50              	push	ax
2007:151F 0E              	push	cs
2007:1520 E8 A6 F2        	call	07C9h
2007:1523 83 C4 06        	add	sp,6h
2007:1526 A1 3A 2F        	mov	ax,[2F3Ah]
2007:1529 3B C6           	cmp	ax,si
2007:152B 74 09           	jz	1536h

l2007_152D:
2007:152D 8B 1E 3A 2F     	mov	bx,[2F3Ah]
2007:1531 C6 87 74 B5 FF  	mov	byte ptr [bx+0B574h],0FFh

l2007_1536:
2007:1536 89 36 3A 2F     	mov	[2F3Ah],si
2007:153A A1 00 81        	mov	ax,[8100h]
2007:153D A3 DA B5        	mov	[0B5DAh],ax

l2007_1540:
2007:1540 5F              	pop	di
2007:1541 5E              	pop	si
2007:1542 5D              	pop	bp
2007:1543 CB              	retf

;; UpdateSecondaryUnitStatusRowHighlight_1544: 2007:1544
;;   Called from:
;;     2007:118C (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:11C7 (in DrawSelectedUnitStatusPanel_0E19)
UpdateSecondaryUnitStatusRowHighlight_1544 proc
2007:1544 55              	push	bp
2007:1545 8B EC           	mov	bp,sp
2007:1547 56              	push	si
2007:1548 57              	push	di
2007:1549 8B 76 06        	mov	si,[bp+6h]
2007:154C A1 3C 2F        	mov	ax,[2F3Ch]
2007:154F 3B C6           	cmp	ax,si
2007:1551 75 09           	jnz	155Ch

l2007_1553:
2007:1553 A1 6B A9        	mov	ax,[0A96Bh]
2007:1556 3B 06 D6 B5     	cmp	ax,[0B5D6h]
2007:155A 74 3F           	jz	159Bh

l2007_155C:
2007:155C 8B C6           	mov	ax,si
2007:155E BA 14 00        	mov	dx,14h
2007:1561 F7 E2           	mul	dx
2007:1563 8B F8           	mov	di,ax
2007:1565 83 FE 05        	cmp	si,5h
2007:1568 7C 03           	jl	156Dh

l2007_156A:
2007:156A 83 C7 04        	add	di,4h

l2007_156D:
2007:156D 83 FE 07        	cmp	si,7h
2007:1570 7D 29           	jge	159Bh

l2007_1572:
2007:1572 FF 36 D6 B5     	push	word ptr [0B5D6h]
2007:1576 57              	push	di
2007:1577 33 C0           	xor	ax,ax
2007:1579 50              	push	ax
2007:157A 0E              	push	cs
2007:157B E8 4B F2        	call	07C9h
2007:157E 83 C4 06        	add	sp,6h
2007:1581 A1 3C 2F        	mov	ax,[2F3Ch]
2007:1584 3B C6           	cmp	ax,si
2007:1586 74 09           	jz	1591h

l2007_1588:
2007:1588 8B 1E 3C 2F     	mov	bx,[2F3Ch]
2007:158C C6 87 74 B5 FF  	mov	byte ptr [bx+0B574h],0FFh

l2007_1591:
2007:1591 89 36 3C 2F     	mov	[2F3Ch],si
2007:1595 A1 D6 B5        	mov	ax,[0B5D6h]
2007:1598 A3 6B A9        	mov	[0A96Bh],ax

l2007_159B:
2007:159B 5F              	pop	di
2007:159C 5E              	pop	si
2007:159D 5D              	pop	bp
2007:159E CB              	retf

;; RedrawTacticalViewport_159F: 2007:159F
;;   Called from:
;;     1A1F:4CBE (in SetTacticalGameSpeed_4C3D)
;;     2007:0F46 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:16D2 (in RedrawTacticalStatusPanel_16BA)
RedrawTacticalViewport_159F proc
2007:159F 56              	push	si
2007:15A0 57              	push	di
2007:15A1 83 3E 04 81 00  	cmp	word ptr [8104h],0h
2007:15A6 75 54           	jnz	15FCh

l2007_15A8:
2007:15A8 9A 68 39 00 08  	call	far 0800h:3968h
2007:15AD 33 F6           	xor	si,si
2007:15AF EB 41           	jmp	15F2h

l2007_15B1:
2007:15B1 BF 03 00        	mov	di,3h
2007:15B4 3B 36 DC 17     	cmp	si,[17DCh]
2007:15B8 75 0B           	jnz	15C5h

l2007_15BA:
2007:15BA BF 04 00        	mov	di,4h
2007:15BD 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
2007:15C2 75 01           	jnz	15C5h

l2007_15C4:
2007:15C4 47              	inc	di

l2007_15C5:
2007:15C5 57              	push	di
2007:15C6 B8 C7 00        	mov	ax,0C7h
2007:15C9 50              	push	ax
2007:15CA 8B C6           	mov	ax,si
2007:15CC BA 03 00        	mov	dx,3h
2007:15CF F7 E2           	mul	dx
2007:15D1 05 F9 00        	add	ax,0F9h
2007:15D4 50              	push	ax
2007:15D5 B8 07 00        	mov	ax,7h
2007:15D8 2B C6           	sub	ax,si
2007:15DA 05 C0 00        	add	ax,0C0h
2007:15DD 50              	push	ax
2007:15DE 8B C6           	mov	ax,si
2007:15E0 BA 03 00        	mov	dx,3h
2007:15E3 F7 E2           	mul	dx
2007:15E5 05 F8 00        	add	ax,0F8h
2007:15E8 50              	push	ax
2007:15E9 9A 0E 00 71 34  	call	far 3471h:000Eh
2007:15EE 83 C4 0A        	add	sp,0Ah
2007:15F1 46              	inc	si

l2007_15F2:
2007:15F2 83 FE 08        	cmp	si,8h
2007:15F5 7C BA           	jl	15B1h

l2007_15F7:
2007:15F7 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l2007_15FC:
2007:15FC 5F              	pop	di
2007:15FD 5E              	pop	si
2007:15FE CB              	retf

;; DrawCampaignClock_15FF: 2007:15FF
;;   Called from:
;;     1A1F:0648 (in RunTacticalInteractionLoop_0613)
;;     1A1F:30F2 (in ExecuteSceneInstructions_2A4E)
;;     1A1F:5333 (in AdvanceTacticalCampaignClock_52F2)
;;     2007:0F41 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:16D6 (in RedrawTacticalStatusPanel_16BA)
DrawCampaignClock_15FF proc
2007:15FF 56              	push	si
2007:1600 83 3E 4D B0 00  	cmp	word ptr [0B04Dh],0h
2007:1605 74 03           	jz	160Ah

l2007_1607:
2007:1607 E9 AE 00        	jmp	16B8h

l2007_160A:
2007:160A 83 3E 04 81 00  	cmp	word ptr [8104h],0h
2007:160F 74 03           	jz	1614h

l2007_1611:
2007:1611 E9 A4 00        	jmp	16B8h

l2007_1614:
2007:1614 33 F6           	xor	si,si
2007:1616 8B C6           	mov	ax,si
2007:1618 A2 7E B6        	mov	[0B67Eh],al
2007:161B 80 3E 37 83 0A  	cmp	byte ptr [8337h],0Ah
2007:1620 7D 06           	jge	1628h

l2007_1622:
2007:1622 C6 06 7E B6 30  	mov	byte ptr [0B67Eh],30h
2007:1627 46              	inc	si

l2007_1628:
2007:1628 B8 0A 00        	mov	ax,0Ah
2007:162B 50              	push	ax
2007:162C 1E              	push	ds
2007:162D 8B C6           	mov	ax,si
2007:162F 05 7E B6        	add	ax,0B67Eh
2007:1632 50              	push	ax
2007:1633 A0 37 83        	mov	al,[8337h]
2007:1636 98              	cbw
2007:1637 50              	push	ax
2007:1638 9A 8D 00 68 39  	call	far 3968h:008Dh
2007:163D 83 C4 08        	add	sp,8h
2007:1640 9A 68 39 00 08  	call	far 0800h:3968h
2007:1645 B8 0C 00        	mov	ax,0Ch
2007:1648 50              	push	ax
2007:1649 B8 0F 00        	mov	ax,0Fh
2007:164C 50              	push	ax
2007:164D B8 18 00        	mov	ax,18h
2007:1650 50              	push	ax
2007:1651 B8 23 00        	mov	ax,23h
2007:1654 50              	push	ax
2007:1655 1E              	push	ds
2007:1656 B8 7E B6        	mov	ax,0B67Eh
2007:1659 50              	push	ax
2007:165A 0E              	push	cs
2007:165B E8 90 EB        	call	01EEh
2007:165E 83 C4 0C        	add	sp,0Ch
2007:1661 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:1666 9A CC 1D 07 20  	call	far 2007h:1DCCh
2007:166B 33 F6           	xor	si,si
2007:166D 80 3E 38 83 0A  	cmp	byte ptr [8338h],0Ah
2007:1672 7D 06           	jge	167Ah

l2007_1674:
2007:1674 C6 06 7E B6 30  	mov	byte ptr [0B67Eh],30h
2007:1679 46              	inc	si

l2007_167A:
2007:167A B8 0A 00        	mov	ax,0Ah
2007:167D 50              	push	ax
2007:167E 1E              	push	ds
2007:167F 8B C6           	mov	ax,si
2007:1681 05 7E B6        	add	ax,0B67Eh
2007:1684 50              	push	ax
2007:1685 A0 38 83        	mov	al,[8338h]
2007:1688 98              	cbw
2007:1689 50              	push	ax
2007:168A 9A 8D 00 68 39  	call	far 3968h:008Dh
2007:168F 83 C4 08        	add	sp,8h
2007:1692 9A 68 39 00 08  	call	far 0800h:3968h
2007:1697 B8 0C 00        	mov	ax,0Ch
2007:169A 50              	push	ax
2007:169B B8 0F 00        	mov	ax,0Fh
2007:169E 50              	push	ax
2007:169F B8 18 00        	mov	ax,18h
2007:16A2 50              	push	ax
2007:16A3 B8 26 00        	mov	ax,26h
2007:16A6 50              	push	ax
2007:16A7 1E              	push	ds
2007:16A8 B8 7E B6        	mov	ax,0B67Eh
2007:16AB 50              	push	ax
2007:16AC 0E              	push	cs
2007:16AD E8 3E EB        	call	01EEh
2007:16B0 83 C4 0C        	add	sp,0Ch
2007:16B3 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l2007_16B8:
2007:16B8 5E              	pop	si
2007:16B9 CB              	retf

;; RedrawTacticalStatusPanel_16BA: 2007:16BA
;;   Called from:
;;     1A1F:0B2F (in RunTacticalInteractionLoop_0613)
;;     2208:00C3 (in RunTacticalUnitCommandMenu_000B)
;;     2208:0602 (in RunTacticalUnitCommandMenu_000B)
;;     2208:14BF (in RunTacticalGameOptionsMenu_148A)
;;     2208:17C5 (in RunTacticalGameOptionsMenu_148A)
;;     24C5:041C (in ExitTacticalOverview_0401)
RedrawTacticalStatusPanel_16BA proc
2007:16BA 56              	push	si
2007:16BB 8B 36 2E 62     	mov	si,[622Eh]
2007:16BF 9A 68 39 00 08  	call	far 0800h:3968h
2007:16C4 B8 06 00        	mov	ax,6h
2007:16C7 50              	push	ax
2007:16C8 9A 09 00 49 33  	call	far 3349h:0009h
2007:16CD 59              	pop	cx
2007:16CE 0E              	push	cs
2007:16CF E8 47 F7        	call	0E19h
2007:16D2 0E              	push	cs
2007:16D3 E8 C9 FE        	call	159Fh
2007:16D6 0E              	push	cs
2007:16D7 E8 25 FF        	call	15FFh
2007:16DA 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:16DF 56              	push	si
2007:16E0 9A 09 00 38 33  	call	far 3338h:0009h
2007:16E5 59              	pop	cx
2007:16E6 5E              	pop	si
2007:16E7 CB              	retf

;; AdvanceImpactSpriteAnimations_16E8: 2007:16E8
;;   Called from:
;;     2007:0640 (in AdvanceTerrainEffects_042A)
AdvanceImpactSpriteAnimations_16E8 proc
2007:16E8 55              	push	bp
2007:16E9 8B EC           	mov	bp,sp
2007:16EB 83 EC 0C        	sub	sp,0Ch
2007:16EE 56              	push	si
2007:16EF 57              	push	di
2007:16F0 9A 68 39 00 08  	call	far 0800h:3968h
2007:16F5 33 F6           	xor	si,si
2007:16F7 C7 46 F4 00 00  	mov	word ptr [bp-0Ch],0h
2007:16FC E9 C8 00        	jmp	17C7h

l2007_16FF:
2007:16FF 8B DE           	mov	bx,si
2007:1701 D1 E3           	shl	bx,1h
2007:1703 8B 87 F4 B2     	mov	ax,[bx+0B2F4h]
2007:1707 2B 06 A0 84     	sub	ax,[84A0h]
2007:170B B1 04           	mov	cl,4h
2007:170D D3 E0           	shl	ax,cl
2007:170F 89 46 F8        	mov	[bp-8h],ax
2007:1712 46              	inc	si
2007:1713 8B DE           	mov	bx,si
2007:1715 D1 E3           	shl	bx,1h
2007:1717 8B 87 F4 B2     	mov	ax,[bx+0B2F4h]
2007:171B 2B 06 DA 83     	sub	ax,[83DAh]
2007:171F B1 04           	mov	cl,4h
2007:1721 D3 E0           	shl	ax,cl
2007:1723 89 46 FA        	mov	[bp-6h],ax
2007:1726 46              	inc	si
2007:1727 8B DE           	mov	bx,si
2007:1729 D1 E3           	shl	bx,1h
2007:172B 8B BF F4 B2     	mov	di,[bx+0B2F4h]
2007:172F 83 FF 01        	cmp	di,1h
2007:1732 7C 0D           	jl	1741h

l2007_1734:
2007:1734 83 FF 06        	cmp	di,6h
2007:1737 7D 08           	jge	1741h

l2007_1739:
2007:1739 83 6E F8 0C     	sub	word ptr [bp-8h],0Ch
2007:173D 83 6E FA 12     	sub	word ptr [bp-6h],12h

l2007_1741:
2007:1741 83 FF 06        	cmp	di,6h
2007:1744 7C 0D           	jl	1753h

l2007_1746:
2007:1746 83 FF 0E        	cmp	di,0Eh
2007:1749 7D 08           	jge	1753h

l2007_174B:
2007:174B 83 6E F8 04     	sub	word ptr [bp-8h],4h
2007:174F 83 6E FA 06     	sub	word ptr [bp-6h],6h

l2007_1753:
2007:1753 FF 76 FA        	push	word ptr [bp-6h]
2007:1756 FF 76 F8        	push	word ptr [bp-8h]
2007:1759 57              	push	di
2007:175A 0E              	push	cs
2007:175B E8 7D F6        	call	0DDBh
2007:175E 83 C4 06        	add	sp,6h
2007:1761 47              	inc	di
2007:1762 8B DE           	mov	bx,si
2007:1764 D1 E3           	shl	bx,1h
2007:1766 89 BF F4 B2     	mov	[bx+0B2F4h],di
2007:176A 46              	inc	si
2007:176B 8B C6           	mov	ax,si
2007:176D 46              	inc	si
2007:176E 8B D8           	mov	bx,ax
2007:1770 D1 E3           	shl	bx,1h
2007:1772 8B 87 F4 B2     	mov	ax,[bx+0B2F4h]
2007:1776 3B C7           	cmp	ax,di
2007:1778 75 4A           	jnz	17C4h

l2007_177A:
2007:177A 83 EE 04        	sub	si,4h
2007:177D FF 4E F4        	dec	word ptr [bp-0Ch]
2007:1780 89 76 FC        	mov	[bp-4h],si
2007:1783 8B 46 F4        	mov	ax,[bp-0Ch]
2007:1786 40              	inc	ax
2007:1787 89 46 F6        	mov	[bp-0Ah],ax
2007:178A EB 2B           	jmp	17B7h

l2007_178C:
2007:178C C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2007:1791 EB 1B           	jmp	17AEh

l2007_1793:
2007:1793 8B 5E FC        	mov	bx,[bp-4h]
2007:1796 83 C3 04        	add	bx,4h
2007:1799 D1 E3           	shl	bx,1h
2007:179B 8B 87 F4 B2     	mov	ax,[bx+0B2F4h]
2007:179F 8B 5E FC        	mov	bx,[bp-4h]
2007:17A2 D1 E3           	shl	bx,1h
2007:17A4 89 87 F4 B2     	mov	[bx+0B2F4h],ax
2007:17A8 FF 46 FC        	inc	word ptr [bp-4h]
2007:17AB FF 46 FE        	inc	word ptr [bp-2h]

l2007_17AE:
2007:17AE 83 7E FE 04     	cmp	word ptr [bp-2h],4h
2007:17B2 7C DF           	jl	1793h

l2007_17B4:
2007:17B4 FF 46 F6        	inc	word ptr [bp-0Ah]

l2007_17B7:
2007:17B7 8B 46 F6        	mov	ax,[bp-0Ah]
2007:17BA 3B 06 FC 80     	cmp	ax,[80FCh]
2007:17BE 7C CC           	jl	178Ch

l2007_17C0:
2007:17C0 FF 0E FC 80     	dec	word ptr [80FCh]

l2007_17C4:
2007:17C4 FF 46 F4        	inc	word ptr [bp-0Ch]

l2007_17C7:
2007:17C7 8B 46 F4        	mov	ax,[bp-0Ch]
2007:17CA 3B 06 FC 80     	cmp	ax,[80FCh]
2007:17CE 7D 03           	jge	17D3h

l2007_17D0:
2007:17D0 E9 2C FF        	jmp	16FFh

l2007_17D3:
2007:17D3 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:17D8 5F              	pop	di
2007:17D9 5E              	pop	si
2007:17DA 8B E5           	mov	sp,bp
2007:17DC 5D              	pop	bp
2007:17DD CB              	retf

;; AdvanceTacticalProjectiles_17DE: 2007:17DE
;;   Called from:
;;     2007:0645 (in AdvanceTerrainEffects_042A)
AdvanceTacticalProjectiles_17DE proc
2007:17DE 55              	push	bp
2007:17DF 8B EC           	mov	bp,sp
2007:17E1 83 EC 0C        	sub	sp,0Ch
2007:17E4 56              	push	si
2007:17E5 57              	push	di
2007:17E6 9A 68 39 00 08  	call	far 0800h:3968h
2007:17EB 33 F6           	xor	si,si
2007:17ED E9 DF 02        	jmp	1ACFh

l2007_17F0:
2007:17F0 8B C6           	mov	ax,si
2007:17F2 BA 0E 00        	mov	dx,0Eh
2007:17F5 F7 E2           	mul	dx
2007:17F7 8B D8           	mov	bx,ax
2007:17F9 81 C3 DD A9     	add	bx,0A9DDh
2007:17FD 1E              	push	ds
2007:17FE 07              	pop	es
2007:17FF 26 8B 7F 06     	mov	di,es:[bx+6h]
2007:1803 8B C6           	mov	ax,si
2007:1805 BA 0E 00        	mov	dx,0Eh
2007:1808 F7 E2           	mul	dx
2007:180A 8B D8           	mov	bx,ax
2007:180C 81 C3 DD A9     	add	bx,0A9DDh
2007:1810 1E              	push	ds
2007:1811 07              	pop	es
2007:1812 26 8B 47 08     	mov	ax,es:[bx+8h]
2007:1816 89 46 F6        	mov	[bp-0Ah],ax
2007:1819 8B C7           	mov	ax,di
2007:181B 2B 06 A0 84     	sub	ax,[84A0h]
2007:181F B1 04           	mov	cl,4h
2007:1821 D3 E0           	shl	ax,cl
2007:1823 89 46 F8        	mov	[bp-8h],ax
2007:1826 8B 46 F6        	mov	ax,[bp-0Ah]
2007:1829 2B 06 DA 83     	sub	ax,[83DAh]
2007:182D B1 04           	mov	cl,4h
2007:182F D3 E0           	shl	ax,cl
2007:1831 89 46 FA        	mov	[bp-6h],ax
2007:1834 8B C6           	mov	ax,si
2007:1836 BA 0E 00        	mov	dx,0Eh
2007:1839 F7 E2           	mul	dx
2007:183B 8B D8           	mov	bx,ax
2007:183D 81 C3 DD A9     	add	bx,0A9DDh
2007:1841 1E              	push	ds
2007:1842 07              	pop	es
2007:1843 26 8B 47 04     	mov	ax,es:[bx+4h]
2007:1847 89 46 FC        	mov	[bp-4h],ax
2007:184A FF 76 FA        	push	word ptr [bp-6h]
2007:184D FF 76 F8        	push	word ptr [bp-8h]
2007:1850 FF 76 FC        	push	word ptr [bp-4h]
2007:1853 0E              	push	cs
2007:1854 E8 84 F5        	call	0DDBh
2007:1857 83 C4 06        	add	sp,6h
2007:185A 8B C6           	mov	ax,si
2007:185C BA 0E 00        	mov	dx,0Eh
2007:185F F7 E2           	mul	dx
2007:1861 8B D8           	mov	bx,ax
2007:1863 81 C3 DD A9     	add	bx,0A9DDh
2007:1867 1E              	push	ds
2007:1868 07              	pop	es
2007:1869 26 80 7F 01 18  	cmp	byte ptr es:[bx+1h],18h
2007:186E 7D 56           	jge	18C6h

l2007_1870:
2007:1870 8B C6           	mov	ax,si
2007:1872 BA 0E 00        	mov	dx,0Eh
2007:1875 F7 E2           	mul	dx
2007:1877 8B D8           	mov	bx,ax
2007:1879 81 C3 DD A9     	add	bx,0A9DDh
2007:187D 1E              	push	ds
2007:187E 07              	pop	es
2007:187F 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2007:1884 74 40           	jz	18C6h

l2007_1886:
2007:1886 8B C6           	mov	ax,si
2007:1888 BA 0E 00        	mov	dx,0Eh
2007:188B F7 E2           	mul	dx
2007:188D 8B D8           	mov	bx,ax
2007:188F 81 C3 DD A9     	add	bx,0A9DDh
2007:1893 1E              	push	ds
2007:1894 07              	pop	es
2007:1895 26 8A 47 01     	mov	al,es:[bx+1h]
2007:1899 98              	cbw
2007:189A 8B D8           	mov	bx,ax
2007:189C 8A 87 62 85     	mov	al,[bx+8562h]
2007:18A0 B4 00           	mov	ah,0h
2007:18A2 89 46 F8        	mov	[bp-8h],ax
2007:18A5 8B C6           	mov	ax,si
2007:18A7 BA 0E 00        	mov	dx,0Eh
2007:18AA F7 E2           	mul	dx
2007:18AC 8B D8           	mov	bx,ax
2007:18AE 81 C3 DD A9     	add	bx,0A9DDh
2007:18B2 1E              	push	ds
2007:18B3 07              	pop	es
2007:18B4 26 8A 47 01     	mov	al,es:[bx+1h]
2007:18B8 98              	cbw
2007:18B9 8B D8           	mov	bx,ax
2007:18BB 8A 87 7B 85     	mov	al,[bx+857Bh]
2007:18BF B4 00           	mov	ah,0h
2007:18C1 89 46 FA        	mov	[bp-6h],ax
2007:18C4 EB 2C           	jmp	18F2h

l2007_18C6:
2007:18C6 8B C6           	mov	ax,si
2007:18C8 BA 0E 00        	mov	dx,0Eh
2007:18CB F7 E2           	mul	dx
2007:18CD 8B D8           	mov	bx,ax
2007:18CF 81 C3 DD A9     	add	bx,0A9DDh
2007:18D3 1E              	push	ds
2007:18D4 07              	pop	es
2007:18D5 26 8B 47 0A     	mov	ax,es:[bx+0Ah]
2007:18D9 89 46 F8        	mov	[bp-8h],ax
2007:18DC 8B C6           	mov	ax,si
2007:18DE BA 0E 00        	mov	dx,0Eh
2007:18E1 F7 E2           	mul	dx
2007:18E3 8B D8           	mov	bx,ax
2007:18E5 81 C3 DD A9     	add	bx,0A9DDh
2007:18E9 1E              	push	ds
2007:18EA 07              	pop	es
2007:18EB 26 8B 47 0C     	mov	ax,es:[bx+0Ch]
2007:18EF 89 46 FA        	mov	[bp-6h],ax

l2007_18F2:
2007:18F2 3B 7E F8        	cmp	di,[bp-8h]
2007:18F5 74 03           	jz	18FAh

l2007_18F7:
2007:18F7 E9 2B 01        	jmp	1A25h

l2007_18FA:
2007:18FA 8B 46 F6        	mov	ax,[bp-0Ah]
2007:18FD 3B 46 FA        	cmp	ax,[bp-6h]
2007:1900 74 03           	jz	1905h

l2007_1902:
2007:1902 E9 20 01        	jmp	1A25h

l2007_1905:
2007:1905 8B C6           	mov	ax,si
2007:1907 BA 0E 00        	mov	dx,0Eh
2007:190A F7 E2           	mul	dx
2007:190C 8B D8           	mov	bx,ax
2007:190E 81 C3 DD A9     	add	bx,0A9DDh
2007:1912 1E              	push	ds
2007:1913 07              	pop	es
2007:1914 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2007:1919 74 16           	jz	1931h

l2007_191B:
2007:191B 8B C6           	mov	ax,si
2007:191D BA 0E 00        	mov	dx,0Eh
2007:1920 F7 E2           	mul	dx
2007:1922 8B D8           	mov	bx,ax
2007:1924 81 C3 DD A9     	add	bx,0A9DDh
2007:1928 1E              	push	ds
2007:1929 07              	pop	es
2007:192A 26 80 7F 01 18  	cmp	byte ptr es:[bx+1h],18h
2007:192F 75 12           	jnz	1943h

l2007_1931:
2007:1931 B8 03 00        	mov	ax,3h
2007:1934 50              	push	ax
2007:1935 FF 76 FA        	push	word ptr [bp-6h]
2007:1938 FF 76 F8        	push	word ptr [bp-8h]
2007:193B 9A 50 0C 1F 1A  	call	far 1A1Fh:0C50h
2007:1940 83 C4 06        	add	sp,6h

l2007_1943:
2007:1943 C7 46 FC 0A 00  	mov	word ptr [bp-4h],0Ah
2007:1948 8B C6           	mov	ax,si
2007:194A BA 0E 00        	mov	dx,0Eh
2007:194D F7 E2           	mul	dx
2007:194F 8B D8           	mov	bx,ax
2007:1951 81 C3 DD A9     	add	bx,0A9DDh
2007:1955 1E              	push	ds
2007:1956 07              	pop	es
2007:1957 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
2007:195C 74 72           	jz	19D0h

l2007_195E:
2007:195E 8B C6           	mov	ax,si
2007:1960 BA 0E 00        	mov	dx,0Eh
2007:1963 F7 E2           	mul	dx
2007:1965 8B D8           	mov	bx,ax
2007:1967 81 C3 DD A9     	add	bx,0A9DDh
2007:196B 1E              	push	ds
2007:196C 07              	pop	es
2007:196D 26 8A 47 01     	mov	al,es:[bx+1h]
2007:1971 98              	cbw
2007:1972 50              	push	ax
2007:1973 8B C6           	mov	ax,si
2007:1975 BA 0E 00        	mov	dx,0Eh
2007:1978 F7 E2           	mul	dx
2007:197A 8B D8           	mov	bx,ax
2007:197C 81 C3 DD A9     	add	bx,0A9DDh
2007:1980 1E              	push	ds
2007:1981 07              	pop	es
2007:1982 26 8A 07        	mov	al,es:[bx]
2007:1985 98              	cbw
2007:1986 50              	push	ax
2007:1987 8B C6           	mov	ax,si
2007:1989 BA 0E 00        	mov	dx,0Eh
2007:198C F7 E2           	mul	dx
2007:198E 8B D8           	mov	bx,ax
2007:1990 81 C3 DD A9     	add	bx,0A9DDh
2007:1994 1E              	push	ds
2007:1995 07              	pop	es
2007:1996 26 8A 47 03     	mov	al,es:[bx+3h]
2007:199A 98              	cbw
2007:199B 50              	push	ax
2007:199C 9A 2B 1E 1B 2D  	call	far 2D1Bh:1E2Bh
2007:19A1 83 C4 06        	add	sp,6h
2007:19A4 8B C6           	mov	ax,si
2007:19A6 BA 0E 00        	mov	dx,0Eh
2007:19A9 F7 E2           	mul	dx
2007:19AB 8B D8           	mov	bx,ax
2007:19AD 81 C3 DD A9     	add	bx,0A9DDh
2007:19B1 1E              	push	ds
2007:19B2 07              	pop	es
2007:19B3 26 8A 07        	mov	al,es:[bx]
2007:19B6 98              	cbw
2007:19B7 BA 0F 00        	mov	dx,0Fh
2007:19BA F7 E2           	mul	dx
2007:19BC 8B D8           	mov	bx,ax
2007:19BE 81 C3 35 04     	add	bx,435h
2007:19C2 1E              	push	ds
2007:19C3 07              	pop	es
2007:19C4 26 80 7F 05 03  	cmp	byte ptr es:[bx+5h],3h
2007:19C9 7E 05           	jle	19D0h

l2007_19CB:
2007:19CB C7 46 FC 06 00  	mov	word ptr [bp-4h],6h

l2007_19D0:
2007:19D0 FF 76 FC        	push	word ptr [bp-4h]
2007:19D3 FF 76 FA        	push	word ptr [bp-6h]
2007:19D6 FF 76 F8        	push	word ptr [bp-8h]
2007:19D9 0E              	push	cs
2007:19DA E8 69 EE        	call	0846h
2007:19DD 83 C4 06        	add	sp,6h
2007:19E0 4E              	dec	si
2007:19E1 8B C6           	mov	ax,si
2007:19E3 40              	inc	ax
2007:19E4 89 46 F4        	mov	[bp-0Ch],ax
2007:19E7 EB 2C           	jmp	1A15h

l2007_19E9:
2007:19E9 8B 46 F4        	mov	ax,[bp-0Ch]
2007:19EC BA 0E 00        	mov	dx,0Eh
2007:19EF F7 E2           	mul	dx
2007:19F1 8B D8           	mov	bx,ax
2007:19F3 81 C3 DD A9     	add	bx,0A9DDh
2007:19F7 1E              	push	ds
2007:19F8 53              	push	bx
2007:19F9 8B 46 F4        	mov	ax,[bp-0Ch]
2007:19FC 40              	inc	ax
2007:19FD BA 0E 00        	mov	dx,0Eh
2007:1A00 F7 E2           	mul	dx
2007:1A02 8B D8           	mov	bx,ax
2007:1A04 81 C3 DD A9     	add	bx,0A9DDh
2007:1A08 1E              	push	ds
2007:1A09 53              	push	bx
2007:1A0A B9 0E 00        	mov	cx,0Eh
2007:1A0D 9A 4B 55 00 08  	call	far 0800h:554Bh
2007:1A12 FF 46 F4        	inc	word ptr [bp-0Ch]

l2007_1A15:
2007:1A15 8B 46 F4        	mov	ax,[bp-0Ch]
2007:1A18 3B 06 83 B5     	cmp	ax,[0B583h]
2007:1A1C 7C CB           	jl	19E9h

l2007_1A1E:
2007:1A1E FF 0E 83 B5     	dec	word ptr [0B583h]
2007:1A22 E9 A9 00        	jmp	1ACEh

l2007_1A25:
2007:1A25 FF 76 FA        	push	word ptr [bp-6h]
2007:1A28 FF 76 F8        	push	word ptr [bp-8h]
2007:1A2B FF 76 F6        	push	word ptr [bp-0Ah]
2007:1A2E 57              	push	di
2007:1A2F 9A D1 06 00 08  	call	far 0800h:06D1h
2007:1A34 83 C4 08        	add	sp,8h
2007:1A37 89 46 FE        	mov	[bp-2h],ax
2007:1A3A 3B 7E F8        	cmp	di,[bp-8h]
2007:1A3D 74 0B           	jz	1A4Ah

l2007_1A3F:
2007:1A3F 8B 5E FE        	mov	bx,[bp-2h]
2007:1A42 D1 E3           	shl	bx,1h
2007:1A44 8B 87 4A 17     	mov	ax,[bx+174Ah]
2007:1A48 03 F8           	add	di,ax

l2007_1A4A:
2007:1A4A 8B 46 F6        	mov	ax,[bp-0Ah]
2007:1A4D 3B 46 FA        	cmp	ax,[bp-6h]
2007:1A50 74 0C           	jz	1A5Eh

l2007_1A52:
2007:1A52 8B 5E FE        	mov	bx,[bp-2h]
2007:1A55 D1 E3           	shl	bx,1h
2007:1A57 8B 87 5A 17     	mov	ax,[bx+175Ah]
2007:1A5B 01 46 F6        	add	[bp-0Ah],ax

l2007_1A5E:
2007:1A5E 8B C6           	mov	ax,si
2007:1A60 BA 0E 00        	mov	dx,0Eh
2007:1A63 F7 E2           	mul	dx
2007:1A65 8B D8           	mov	bx,ax
2007:1A67 81 C3 DD A9     	add	bx,0A9DDh
2007:1A6B 1E              	push	ds
2007:1A6C 07              	pop	es
2007:1A6D 26 89 7F 06     	mov	es:[bx+6h],di
2007:1A71 8B 46 F6        	mov	ax,[bp-0Ah]
2007:1A74 50              	push	ax
2007:1A75 8B C6           	mov	ax,si
2007:1A77 BA 0E 00        	mov	dx,0Eh
2007:1A7A F7 E2           	mul	dx
2007:1A7C 8B D8           	mov	bx,ax
2007:1A7E 81 C3 DD A9     	add	bx,0A9DDh
2007:1A82 1E              	push	ds
2007:1A83 07              	pop	es
2007:1A84 58              	pop	ax
2007:1A85 26 89 47 08     	mov	es:[bx+8h],ax
2007:1A89 8B C6           	mov	ax,si
2007:1A8B BA 0E 00        	mov	dx,0Eh
2007:1A8E F7 E2           	mul	dx
2007:1A90 8B D8           	mov	bx,ax
2007:1A92 81 C3 DD A9     	add	bx,0A9DDh
2007:1A96 1E              	push	ds
2007:1A97 07              	pop	es
2007:1A98 26 8B 7F 04     	mov	di,es:[bx+4h]
2007:1A9C 47              	inc	di
2007:1A9D 81 E7 01 00     	and	di,1h
2007:1AA1 8B C6           	mov	ax,si
2007:1AA3 BA 0E 00        	mov	dx,0Eh
2007:1AA6 F7 E2           	mul	dx
2007:1AA8 8B D8           	mov	bx,ax
2007:1AAA 81 C3 DD A9     	add	bx,0A9DDh
2007:1AAE 1E              	push	ds
2007:1AAF 07              	pop	es
2007:1AB0 26 8B 47 04     	mov	ax,es:[bx+4h]
2007:1AB4 25 FE 00        	and	ax,0FEh
2007:1AB7 0B C7           	or	ax,di
2007:1AB9 50              	push	ax
2007:1ABA 8B C6           	mov	ax,si
2007:1ABC BA 0E 00        	mov	dx,0Eh
2007:1ABF F7 E2           	mul	dx
2007:1AC1 8B D8           	mov	bx,ax
2007:1AC3 81 C3 DD A9     	add	bx,0A9DDh
2007:1AC7 1E              	push	ds
2007:1AC8 07              	pop	es
2007:1AC9 58              	pop	ax
2007:1ACA 26 89 47 04     	mov	es:[bx+4h],ax

l2007_1ACE:
2007:1ACE 46              	inc	si

l2007_1ACF:
2007:1ACF 3B 36 83 B5     	cmp	si,[0B583h]
2007:1AD3 7D 03           	jge	1AD8h

l2007_1AD5:
2007:1AD5 E9 18 FD        	jmp	17F0h

l2007_1AD8:
2007:1AD8 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
2007:1ADD 5F              	pop	di
2007:1ADE 5E              	pop	si
2007:1ADF 8B E5           	mov	sp,bp
2007:1AE1 5D              	pop	bp
2007:1AE2 CB              	retf

;; AdvanceMapEdgeEffects_1AE3: 2007:1AE3
;;   Called from:
;;     2007:04E9 (in AdvanceTerrainEffects_042A)
AdvanceMapEdgeEffects_1AE3 proc
2007:1AE3 55              	push	bp
2007:1AE4 8B EC           	mov	bp,sp
2007:1AE6 83 EC 10        	sub	sp,10h
2007:1AE9 56              	push	si
2007:1AEA 57              	push	di
2007:1AEB C7 46 F0 00 00  	mov	word ptr [bp-10h],0h
2007:1AF0 C7 46 F2 00 00  	mov	word ptr [bp-0Eh],0h
2007:1AF5 E9 B3 01        	jmp	1CABh

l2007_1AF8:
2007:1AF8 8B 5E F0        	mov	bx,[bp-10h]
2007:1AFB D1 E3           	shl	bx,1h
2007:1AFD 8B B7 00 A8     	mov	si,[bx+0A800h]
2007:1B01 8B 5E F0        	mov	bx,[bp-10h]
2007:1B04 43              	inc	bx
2007:1B05 D1 E3           	shl	bx,1h
2007:1B07 8B BF 00 A8     	mov	di,[bx+0A800h]
2007:1B0B C7 46 F8 00 00  	mov	word ptr [bp-8h],0h
2007:1B10 8B 5E F0        	mov	bx,[bp-10h]
2007:1B13 83 C3 03        	add	bx,3h
2007:1B16 D1 E3           	shl	bx,1h
2007:1B18 8B 87 00 A8     	mov	ax,[bx+0A800h]
2007:1B1C 3D 03 00        	cmp	ax,3h
2007:1B1F 76 03           	jbe	1B24h

l2007_1B21:
2007:1B21 E9 D2 00        	jmp	1BF6h

l2007_1B24:
2007:1B24 8B D8           	mov	bx,ax
2007:1B26 D1 E3           	shl	bx,1h
2007:1B28 2E FF A7 2D 1B  	jmp	word ptr cs:[bx+1B2Dh]
l2007_1B2D	dw	0x1B35
l2007_1B2F	dw	0x1B64
l2007_1B31	dw	0x1B95
l2007_1B33	dw	0x1BC4

l2007_1B35:
2007:1B35 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1B3A B4 00           	mov	ah,0h
2007:1B3C 25 01 00        	and	ax,1h
2007:1B3F 03 C6           	add	ax,si
2007:1B41 89 46 F4        	mov	[bp-0Ch],ax
2007:1B44 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1B49 B4 00           	mov	ah,0h
2007:1B4B 25 03 00        	and	ax,3h
2007:1B4E 03 C7           	add	ax,di
2007:1B50 05 FA FF        	add	ax,0FFFAh
2007:1B53 89 46 F6        	mov	[bp-0Ah],ax
2007:1B56 4F              	dec	di
2007:1B57 83 FF FF        	cmp	di,0FFh
2007:1B5A 7D 05           	jge	1B61h

l2007_1B5C:
2007:1B5C C7 46 F8 01 00  	mov	word ptr [bp-8h],1h

l2007_1B61:
2007:1B61 E9 94 00        	jmp	1BF8h

l2007_1B64:
2007:1B64 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1B69 B4 00           	mov	ah,0h
2007:1B6B 25 01 00        	and	ax,1h
2007:1B6E 8B D7           	mov	dx,di
2007:1B70 2B D0           	sub	dx,ax
2007:1B72 89 56 F6        	mov	[bp-0Ah],dx
2007:1B75 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1B7A B4 00           	mov	ah,0h
2007:1B7C 25 03 00        	and	ax,3h
2007:1B7F 03 C6           	add	ax,si
2007:1B81 05 04 00        	add	ax,4h
2007:1B84 89 46 F4        	mov	[bp-0Ch],ax
2007:1B87 46              	inc	si
2007:1B88 3B 36 A6 00     	cmp	si,[00A6h]
2007:1B8C 7C 05           	jl	1B93h

l2007_1B8E:
2007:1B8E C7 46 F8 01 00  	mov	word ptr [bp-8h],1h

l2007_1B93:
2007:1B93 EB 63           	jmp	1BF8h

l2007_1B95:
2007:1B95 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1B9A B4 00           	mov	ah,0h
2007:1B9C 25 01 00        	and	ax,1h
2007:1B9F 03 C6           	add	ax,si
2007:1BA1 89 46 F4        	mov	[bp-0Ch],ax
2007:1BA4 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1BA9 B4 00           	mov	ah,0h
2007:1BAB 25 03 00        	and	ax,3h
2007:1BAE 03 C7           	add	ax,di
2007:1BB0 05 06 00        	add	ax,6h
2007:1BB3 89 46 F6        	mov	[bp-0Ah],ax
2007:1BB6 47              	inc	di
2007:1BB7 3B 3E A8 00     	cmp	di,[00A8h]
2007:1BBB 7C 05           	jl	1BC2h

l2007_1BBD:
2007:1BBD C7 46 F8 01 00  	mov	word ptr [bp-8h],1h

l2007_1BC2:
2007:1BC2 EB 34           	jmp	1BF8h

l2007_1BC4:
2007:1BC4 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1BC9 B4 00           	mov	ah,0h
2007:1BCB 25 01 00        	and	ax,1h
2007:1BCE 8B D7           	mov	dx,di
2007:1BD0 2B D0           	sub	dx,ax
2007:1BD2 89 56 F6        	mov	[bp-0Ah],dx
2007:1BD5 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1BDA B4 00           	mov	ah,0h
2007:1BDC 25 03 00        	and	ax,3h
2007:1BDF 05 04 00        	add	ax,4h
2007:1BE2 8B D6           	mov	dx,si
2007:1BE4 2B D0           	sub	dx,ax
2007:1BE6 89 56 F4        	mov	[bp-0Ch],dx
2007:1BE9 4E              	dec	si
2007:1BEA 83 FE FF        	cmp	si,0FFh
2007:1BED 7D 05           	jge	1BF4h

l2007_1BEF:
2007:1BEF C7 46 F8 01 00  	mov	word ptr [bp-8h],1h

l2007_1BF4:
2007:1BF4 EB 02           	jmp	1BF8h

l2007_1BF6:
2007:1BF6 EB 00           	jmp	1BF8h

l2007_1BF8:
2007:1BF8 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1BFD A8 01           	test	al,1h
2007:1BFF 74 3C           	jz	1C3Dh

l2007_1C01:
2007:1C01 C7 46 FC 0A 00  	mov	word ptr [bp-4h],0Ah
2007:1C06 9A 46 4D 00 08  	call	far 0800h:4D46h
2007:1C0B B4 00           	mov	ah,0h
2007:1C0D 25 07 00        	and	ax,7h
2007:1C10 40              	inc	ax
2007:1C11 89 46 FA        	mov	[bp-6h],ax
2007:1C14 83 7E FA 01     	cmp	word ptr [bp-6h],1h
2007:1C18 7E 05           	jle	1C1Fh

l2007_1C1A:
2007:1C1A C7 46 FC 06 00  	mov	word ptr [bp-4h],6h

l2007_1C1F:
2007:1C1F 83 7E FA 03     	cmp	word ptr [bp-6h],3h
2007:1C23 7E 05           	jle	1C2Ah

l2007_1C25:
2007:1C25 C7 46 FC 01 00  	mov	word ptr [bp-4h],1h

l2007_1C2A:
2007:1C2A FF 76 FA        	push	word ptr [bp-6h]
2007:1C2D FF 76 FC        	push	word ptr [bp-4h]
2007:1C30 FF 76 F6        	push	word ptr [bp-0Ah]
2007:1C33 FF 76 F4        	push	word ptr [bp-0Ch]
2007:1C36 0E              	push	cs
2007:1C37 E8 C1 F0        	call	0CFBh
2007:1C3A 83 C4 08        	add	sp,8h

l2007_1C3D:
2007:1C3D 8B 5E F0        	mov	bx,[bp-10h]
2007:1C40 D1 E3           	shl	bx,1h
2007:1C42 89 B7 00 A8     	mov	[bx+0A800h],si
2007:1C46 8B 5E F0        	mov	bx,[bp-10h]
2007:1C49 43              	inc	bx
2007:1C4A D1 E3           	shl	bx,1h
2007:1C4C 89 BF 00 A8     	mov	[bx+0A800h],di
2007:1C50 83 46 F0 04     	add	word ptr [bp-10h],4h
2007:1C54 83 7E F8 00     	cmp	word ptr [bp-8h],0h
2007:1C58 74 4E           	jz	1CA8h

l2007_1C5A:
2007:1C5A 83 6E F0 04     	sub	word ptr [bp-10h],4h
2007:1C5E FF 4E F2        	dec	word ptr [bp-0Eh]
2007:1C61 8B 46 F0        	mov	ax,[bp-10h]
2007:1C64 89 46 FE        	mov	[bp-2h],ax
2007:1C67 8B 46 F2        	mov	ax,[bp-0Eh]
2007:1C6A 40              	inc	ax
2007:1C6B 89 46 FA        	mov	[bp-6h],ax
2007:1C6E EB 2B           	jmp	1C9Bh

l2007_1C70:
2007:1C70 C7 46 F8 00 00  	mov	word ptr [bp-8h],0h
2007:1C75 EB 1B           	jmp	1C92h

l2007_1C77:
2007:1C77 8B 5E FE        	mov	bx,[bp-2h]
2007:1C7A 83 C3 04        	add	bx,4h
2007:1C7D D1 E3           	shl	bx,1h
2007:1C7F 8B 87 00 A8     	mov	ax,[bx+0A800h]
2007:1C83 8B 5E FE        	mov	bx,[bp-2h]
2007:1C86 D1 E3           	shl	bx,1h
2007:1C88 89 87 00 A8     	mov	[bx+0A800h],ax
2007:1C8C FF 46 FE        	inc	word ptr [bp-2h]
2007:1C8F FF 46 F8        	inc	word ptr [bp-8h]

l2007_1C92:
2007:1C92 83 7E F8 04     	cmp	word ptr [bp-8h],4h
2007:1C96 7C DF           	jl	1C77h

l2007_1C98:
2007:1C98 FF 46 FA        	inc	word ptr [bp-6h]

l2007_1C9B:
2007:1C9B 8B 46 FA        	mov	ax,[bp-6h]
2007:1C9E 3B 06 7F B5     	cmp	ax,[0B57Fh]
2007:1CA2 7C CC           	jl	1C70h

l2007_1CA4:
2007:1CA4 FF 0E 7F B5     	dec	word ptr [0B57Fh]

l2007_1CA8:
2007:1CA8 FF 46 F2        	inc	word ptr [bp-0Eh]

l2007_1CAB:
2007:1CAB 8B 46 F2        	mov	ax,[bp-0Eh]
2007:1CAE 3B 06 7F B5     	cmp	ax,[0B57Fh]
2007:1CB2 7D 03           	jge	1CB7h

l2007_1CB4:
2007:1CB4 E9 41 FE        	jmp	1AF8h

l2007_1CB7:
2007:1CB7 5F              	pop	di
2007:1CB8 5E              	pop	si
2007:1CB9 8B E5           	mov	sp,bp
2007:1CBB 5D              	pop	bp
2007:1CBC CB              	retf

;; DrawTacticalTileSpriteForAdapter_1CBD: 2007:1CBD
;;   Called from:
;;     2007:0760 (in RebuildTacticalViewport_0650)
;;     2007:078C (in RebuildTacticalViewport_0650)
DrawTacticalTileSpriteForAdapter_1CBD proc
2007:1CBD 55              	push	bp
2007:1CBE 8B EC           	mov	bp,sp
2007:1CC0 56              	push	si
2007:1CC1 8B 76 0A        	mov	si,[bp+0Ah]
2007:1CC4 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
2007:1CC9 75 0C           	jnz	1CD7h

l2007_1CCB:
2007:1CCB 81 FE 00 01     	cmp	si,100h
2007:1CCF 7C 06           	jl	1CD7h

l2007_1CD1:
2007:1CD1 81 FE 00 02     	cmp	si,200h
2007:1CD5 7C 17           	jl	1CEEh

l2007_1CD7:
2007:1CD7 FF 76 0E        	push	word ptr [bp+0Eh]
2007:1CDA FF 76 0C        	push	word ptr [bp+0Ch]
2007:1CDD 56              	push	si
2007:1CDE FF 76 08        	push	word ptr [bp+8h]
2007:1CE1 FF 76 06        	push	word ptr [bp+6h]
2007:1CE4 9A 6F 11 00 08  	call	far 0800h:116Fh
2007:1CE9 83 C4 0A        	add	sp,0Ah
2007:1CEC EB 15           	jmp	1D03h

l2007_1CEE:
2007:1CEE FF 76 0E        	push	word ptr [bp+0Eh]
2007:1CF1 FF 76 0C        	push	word ptr [bp+0Ch]
2007:1CF4 56              	push	si
2007:1CF5 FF 76 08        	push	word ptr [bp+8h]
2007:1CF8 FF 76 06        	push	word ptr [bp+6h]
2007:1CFB 9A 2E 0A 00 08  	call	far 0800h:0A2Eh
2007:1D00 83 C4 0A        	add	sp,0Ah

l2007_1D03:
2007:1D03 5E              	pop	si
2007:1D04 5D              	pop	bp
2007:1D05 CB              	retf

;; RefreshTacticalDisplay_1D06: 2007:1D06
;;   Called from:
;;     1A1F:03CA (in UpdateTacticalFrame_0351)
;;     1A1F:0709 (in RunTacticalInteractionLoop_0613)
;;     1A1F:0A16 (in RunTacticalInteractionLoop_0613)
;;     1A1F:16A2 (in OpenTacticalUnitControlPanel_1697)
;;     2208:14AD (in RunTacticalGameOptionsMenu_148A)
RefreshTacticalDisplay_1D06 proc
2007:1D06 55              	push	bp
2007:1D07 8B EC           	mov	bp,sp
2007:1D09 83 3E 04 81 00  	cmp	word ptr [8104h],0h
2007:1D0E 74 25           	jz	1D35h

l2007_1D10:
2007:1D10 FF 76 06        	push	word ptr [bp+6h]
2007:1D13 0E              	push	cs
2007:1D14 E8 13 E7        	call	042Ah
2007:1D17 59              	pop	cx
2007:1D18 83 3E 35 83 00  	cmp	word ptr [8335h],0h
2007:1D1D 74 0F           	jz	1D2Eh

l2007_1D1F:
2007:1D1F 0E              	push	cs
2007:1D20 E8 2D E9        	call	0650h
2007:1D23 FF 36 7D B5     	push	word ptr [0B57Dh]
2007:1D27 0E              	push	cs
2007:1D28 E8 6F EA        	call	079Ah
2007:1D2B 59              	pop	cx
2007:1D2C EB 05           	jmp	1D33h

l2007_1D2E:
2007:1D2E 9A 2E 01 C5 24  	call	far 24C5h:012Eh

l2007_1D33:
2007:1D33 EB 2A           	jmp	1D5Fh

l2007_1D35:
2007:1D35 FF 76 06        	push	word ptr [bp+6h]
2007:1D38 0E              	push	cs
2007:1D39 E8 EE E6        	call	042Ah
2007:1D3C 59              	pop	cx
2007:1D3D 9A 68 39 00 08  	call	far 0800h:3968h
2007:1D42 0E              	push	cs
2007:1D43 E8 0A E9        	call	0650h
2007:1D46 83 3E C0 99 00  	cmp	word ptr [99C0h],0h
2007:1D4B 74 09           	jz	1D56h

l2007_1D4D:
2007:1D4D FF 36 7D B5     	push	word ptr [0B57Dh]
2007:1D51 0E              	push	cs
2007:1D52 E8 45 EA        	call	079Ah
2007:1D55 59              	pop	cx

l2007_1D56:
2007:1D56 0E              	push	cs
2007:1D57 E8 BF F0        	call	0E19h
2007:1D5A 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l2007_1D5F:
2007:1D5F 5D              	pop	bp
2007:1D60 CB              	retf

;; FormatUnitDurabilityPercentage_1D61: 2007:1D61
;;   Called from:
;;     2007:0FF3 (in DrawSelectedUnitStatusPanel_0E19)
FormatUnitDurabilityPercentage_1D61 proc
2007:1D61 55              	push	bp
2007:1D62 8B EC           	mov	bp,sp
2007:1D64 1E              	push	ds
2007:1D65 8B 46 06        	mov	ax,[bp+6h]
2007:1D68 BA 96 00        	mov	dx,96h
2007:1D6B F7 E2           	mul	dx
2007:1D6D 05 81 8B        	add	ax,8B81h
2007:1D70 50              	push	ax
2007:1D71 9A 79 03 1B 2D  	call	far 2D1Bh:0379h
2007:1D76 8B E5           	mov	sp,bp
2007:1D78 83 7E 06 0C     	cmp	word ptr [bp+6h],0Ch
2007:1D7C 7C 17           	jl	1D95h

l2007_1D7E:
2007:1D7E A1 3E 83        	mov	ax,[833Eh]
2007:1D81 BA 0A 00        	mov	dx,0Ah
2007:1D84 F7 E2           	mul	dx
2007:1D86 99              	cwd
2007:1D87 F7 3E BB 86     	idiv	word ptr [86BBh]
2007:1D8B BA 0A 00        	mov	dx,0Ah
2007:1D8E F7 E2           	mul	dx
2007:1D90 A3 3E 83        	mov	[833Eh],ax
2007:1D93 EB 10           	jmp	1DA5h

l2007_1D95:
2007:1D95 A1 3E 83        	mov	ax,[833Eh]
2007:1D98 BA 64 00        	mov	dx,64h
2007:1D9B F7 E2           	mul	dx
2007:1D9D 99              	cwd
2007:1D9E F7 3E BB 86     	idiv	word ptr [86BBh]
2007:1DA2 A3 3E 83        	mov	[833Eh],ax

l2007_1DA5:
2007:1DA5 B8 0A 00        	mov	ax,0Ah
2007:1DA8 50              	push	ax
2007:1DA9 1E              	push	ds
2007:1DAA B8 7E B6        	mov	ax,0B67Eh
2007:1DAD 50              	push	ax
2007:1DAE FF 36 3E 83     	push	word ptr [833Eh]
2007:1DB2 9A 8D 00 68 39  	call	far 3968h:008Dh
2007:1DB7 8B E5           	mov	sp,bp
2007:1DB9 1E              	push	ds
2007:1DBA B8 6A 2F        	mov	ax,2F6Ah
2007:1DBD 50              	push	ax
2007:1DBE 1E              	push	ds
2007:1DBF B8 7E B6        	mov	ax,0B67Eh
2007:1DC2 50              	push	ax
2007:1DC3 9A 01 00 7A 39  	call	far 397Ah:0001h
2007:1DC8 8B E5           	mov	sp,bp
2007:1DCA 5D              	pop	bp
2007:1DCB CB              	retf

;; DrawCampaignClockSeparator_1DCC: 2007:1DCC
;;   Called from:
;;     2007:120E (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:1666 (in DrawCampaignClock_15FF)
DrawCampaignClockSeparator_1DCC proc
2007:1DCC 56              	push	si
2007:1DCD 8B 16 21 59     	mov	dx,[5921h]
2007:1DD1 A1 1F 59        	mov	ax,[591Fh]
2007:1DD4 25 10 00        	and	ax,10h
2007:1DD7 81 E2 00 00     	and	dx,0h
2007:1DDB 0B D0           	or	dx,ax
2007:1DDD 74 05           	jz	1DE4h

l2007_1DDF:
2007:1DDF BE 0F 00        	mov	si,0Fh
2007:1DE2 EB 03           	jmp	1DE7h

l2007_1DE4:
2007:1DE4 BE 0C 00        	mov	si,0Ch

l2007_1DE7:
2007:1DE7 9A 68 39 00 08  	call	far 0800h:3968h
2007:1DEC B8 0C 00        	mov	ax,0Ch
2007:1DEF 50              	push	ax
2007:1DF0 56              	push	si
2007:1DF1 B8 18 00        	mov	ax,18h
2007:1DF4 50              	push	ax
2007:1DF5 B8 25 00        	mov	ax,25h
2007:1DF8 50              	push	ax
2007:1DF9 1E              	push	ds
2007:1DFA B8 6C 2F        	mov	ax,2F6Ch
2007:1DFD 50              	push	ax
2007:1DFE 0E              	push	cs
2007:1DFF E8 EC E3        	call	01EEh
