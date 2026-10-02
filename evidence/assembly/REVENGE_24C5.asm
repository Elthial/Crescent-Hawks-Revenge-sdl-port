;;; Segment 24C5 (24C5:0000)
24C5:0000 5D CB                                           ].              
2208:2BD2       56 33 F6 89 36 35 83 83 3E 3A 83 00 74 0D   V3..65..>:..t.
2208:2BE0 A0 38 83 98 3B 06 B6 AE 75 03 BE 01 00 0B F6 75 .8..;...u......u
2208:2BF0 2A C7 06 3A 83 00 00 A0 38 83 98 3B 06 B6 AE 74 *..:....8..;...t
2208:2C00 1A 9A 46 4D 00 08 3A 06 99 86 72 0F BE 01 00 8B ..FM..:...r.....
2208:2C10 C6 A3 3A 83 A0 38 83 98 A3 B6 AE 80 3E 56 86 00 ..:..8......>V..
2208:2C20 75 03 E9 CB 00 0B F6 75 45 C7 06 04 81 01 00 C7 u......uE.......
2208:2C30 06 DC 03 FF FF B8 A0 00 2B 06 A6 00 D1 F8 A3 F1 ........+.......
2208:2C40 A7 FF 36 A8 00 FF 36 A6 00 FF 36 E8 83 FF 36 E6 ..6...6...6...6.
2208:2C50 83 FF 36 EC 83 FF 36 EA 83 9A 89 0A 00 08 83 C4 ..6...6.........
2208:2C60 0C 9A 68 39 00 08 9A 7F 03 C5 24 E9 80 00 9A 68 ..h9......$....h
2208:2C70 39 00 08 FF 36 60 B6 FF 36 5E B6 B8 0B 00 50 B8 9...6`..6^....P.
2208:2C80 03 00 50 33 C0 50 B8 01 00 50 9A 35 28 00 08 83 ..P3.P...P.5(...
2208:2C90 C4 0C B8 0D 00 50 9A 09 00 49 33 59 B8 0E 00 50 .....P...I3Y...P
2208:2CA0 9A 6F 0C 07 20 59 1E B8 53 45 50 9A 0A 00 CE 35 .o.. Y..SEP....5
2208:2CB0 59 59 9A 7A 3B 00 08 9A 19 3D 73 0D 9A 68 39 00 YY.z;....=s..h9.
2208:2CC0 08 FF 36 60 B6 FF 36 5E B6 B8 0B 00 50 B8 03 00 ..6`..6^....P...
2208:2CD0 50 33 C0 50 B8 01 00 50 9A 83 26 00 08 83 C4 0C P3.P...P..&.....
2208:2CE0 33 C0 50 9A 06 1D 07 20 59 9A 7A 3B 00 08 EB 0C 3.P.... Y.z;....
2208:2CF0 1E B8 34 45 50 9A F7 3B 1F 1A 59 59 5E CB       ..4EP..;..YY^.  

;; RefreshTacticalOverview_012E: 24C5:012E
;;   Called from:
;;     2007:1D2E (in RefreshTacticalDisplay_1D06)
RefreshTacticalOverview_012E proc
24C5:012E 55              	push	bp
24C5:012F 8B EC           	mov	bp,sp
24C5:0131 83 EC 0E        	sub	sp,0Eh
24C5:0134 56              	push	si
24C5:0135 57              	push	di
24C5:0136 A1 A6 00        	mov	ax,[00A6h]
24C5:0139 05 07 00        	add	ax,7h
24C5:013C 25 F8 00        	and	ax,0F8h
24C5:013F 89 46 FC        	mov	[bp-4h],ax
24C5:0142 33 F6           	xor	si,si
24C5:0144 EB 5E           	jmp	01A4h

l24C5_0146:
24C5:0146 80 BC 74 83 FF  	cmp	byte ptr [si+8374h],0FFh
24C5:014B 75 07           	jnz	0154h

l24C5_014D:
24C5:014D 80 BC C0 83 FF  	cmp	byte ptr [si+83C0h],0FFh
24C5:0152 74 4F           	jz	01A3h

l24C5_0154:
24C5:0154 8A 84 C0 83     	mov	al,[si+83C0h]
24C5:0158 B4 00           	mov	ah,0h
24C5:015A F7 66 FC        	mul	word ptr [bp-4h]
24C5:015D C4 1E E6 83     	les	bx,[83E6h]
24C5:0161 03 D8           	add	bx,ax
24C5:0163 8C 46 F4        	mov	[bp-0Ch],es
24C5:0166 89 5E F2        	mov	[bp-0Eh],bx
24C5:0169 8A 84 74 83     	mov	al,[si+8374h]
24C5:016D B4 00           	mov	ah,0h
24C5:016F C4 5E F2        	les	bx,[bp-0Eh]
24C5:0172 03 D8           	add	bx,ax
24C5:0174 26 8A 07        	mov	al,es:[bx]
24C5:0177 B4 00           	mov	ah,0h
24C5:0179 89 46 F8        	mov	[bp-8h],ax
24C5:017C FF 76 F8        	push	word ptr [bp-8h]
24C5:017F 8A 84 C0 83     	mov	al,[si+83C0h]
24C5:0183 B4 00           	mov	ah,0h
24C5:0185 50              	push	ax
24C5:0186 8A 84 74 83     	mov	al,[si+8374h]
24C5:018A B4 00           	mov	ah,0h
24C5:018C 03 06 F1 A7     	add	ax,[0A7F1h]
24C5:0190 50              	push	ax
24C5:0191 9A 07 0B 00 08  	call	far 0800h:0B07h
24C5:0196 83 C4 06        	add	sp,6h
24C5:0199 B0 FF           	mov	al,0FFh
24C5:019B 88 84 C0 83     	mov	[si+83C0h],al
24C5:019F 88 84 74 83     	mov	[si+8374h],al

l24C5_01A3:
24C5:01A3 46              	inc	si

l24C5_01A4:
24C5:01A4 83 FE 18        	cmp	si,18h
24C5:01A7 7C 9D           	jl	0146h

l24C5_01A9:
24C5:01A9 A1 D8 83        	mov	ax,[83D8h]
24C5:01AC F7 66 FC        	mul	word ptr [bp-4h]
24C5:01AF C4 1E E6 83     	les	bx,[83E6h]
24C5:01B3 03 D8           	add	bx,ax
24C5:01B5 03 1E 8C 83     	add	bx,[838Ch]
24C5:01B9 8C 46 F4        	mov	[bp-0Ch],es
24C5:01BC 89 5E F2        	mov	[bp-0Eh],bx
24C5:01BF 8B 46 FC        	mov	ax,[bp-4h]
24C5:01C2 BA 0B 00        	mov	dx,0Bh
24C5:01C5 F7 E2           	mul	dx
24C5:01C7 89 46 FE        	mov	[bp-2h],ax
24C5:01CA 33 FF           	xor	di,di
24C5:01CC EB 45           	jmp	0213h

l24C5_01CE:
24C5:01CE C4 5E F2        	les	bx,[bp-0Eh]
24C5:01D1 26 8A 01        	mov	al,es:[bx+di]
24C5:01D4 B4 00           	mov	ah,0h
24C5:01D6 50              	push	ax
24C5:01D7 FF 36 D8 83     	push	word ptr [83D8h]
24C5:01DB A1 8C 83        	mov	ax,[838Ch]
24C5:01DE 03 C7           	add	ax,di
24C5:01E0 03 06 F1 A7     	add	ax,[0A7F1h]
24C5:01E4 50              	push	ax
24C5:01E5 9A 07 0B 00 08  	call	far 0800h:0B07h
24C5:01EA 83 C4 06        	add	sp,6h
24C5:01ED C4 5E F2        	les	bx,[bp-0Eh]
24C5:01F0 03 5E FE        	add	bx,[bp-2h]
24C5:01F3 26 8A 01        	mov	al,es:[bx+di]
24C5:01F6 B4 00           	mov	ah,0h
24C5:01F8 50              	push	ax
24C5:01F9 A1 D8 83        	mov	ax,[83D8h]
24C5:01FC 05 0B 00        	add	ax,0Bh
24C5:01FF 50              	push	ax
24C5:0200 A1 8C 83        	mov	ax,[838Ch]
24C5:0203 03 C7           	add	ax,di
24C5:0205 03 06 F1 A7     	add	ax,[0A7F1h]
24C5:0209 50              	push	ax
24C5:020A 9A 07 0B 00 08  	call	far 0800h:0B07h
24C5:020F 83 C4 06        	add	sp,6h
24C5:0212 47              	inc	di

l24C5_0213:
24C5:0213 83 FF 13        	cmp	di,13h
24C5:0216 7C B6           	jl	01CEh

l24C5_0218:
24C5:0218 C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h
24C5:021D EB 4D           	jmp	026Ch

l24C5_021F:
24C5:021F 8B 46 FC        	mov	ax,[bp-4h]
24C5:0222 01 46 F2        	add	[bp-0Eh],ax
24C5:0225 C4 5E F2        	les	bx,[bp-0Eh]
24C5:0228 26 8A 07        	mov	al,es:[bx]
24C5:022B B4 00           	mov	ah,0h
24C5:022D 50              	push	ax
24C5:022E A1 D8 83        	mov	ax,[83D8h]
24C5:0231 03 46 F6        	add	ax,[bp-0Ah]
24C5:0234 50              	push	ax
24C5:0235 A1 8C 83        	mov	ax,[838Ch]
24C5:0238 03 06 F1 A7     	add	ax,[0A7F1h]
24C5:023C 50              	push	ax
24C5:023D 9A 07 0B 00 08  	call	far 0800h:0B07h
24C5:0242 83 C4 06        	add	sp,6h
24C5:0245 C4 5E F2        	les	bx,[bp-0Eh]
24C5:0248 26 8A 47 12     	mov	al,es:[bx+12h]
24C5:024C B4 00           	mov	ah,0h
24C5:024E 50              	push	ax
24C5:024F A1 D8 83        	mov	ax,[83D8h]
24C5:0252 03 46 F6        	add	ax,[bp-0Ah]
24C5:0255 50              	push	ax
24C5:0256 A1 8C 83        	mov	ax,[838Ch]
24C5:0259 03 06 F1 A7     	add	ax,[0A7F1h]
24C5:025D 05 12 00        	add	ax,12h
24C5:0260 50              	push	ax
24C5:0261 9A 07 0B 00 08  	call	far 0800h:0B07h
24C5:0266 83 C4 06        	add	sp,6h
24C5:0269 FF 46 F6        	inc	word ptr [bp-0Ah]

l24C5_026C:
24C5:026C 83 7E F6 0B     	cmp	word ptr [bp-0Ah],0Bh
24C5:0270 7C AD           	jl	021Fh

l24C5_0272:
24C5:0272 9A F1 02 C5 24  	call	far 24C5h:02F1h
24C5:0277 C7 46 FA 66 00  	mov	word ptr [bp-6h],66h
24C5:027C 83 3E 81 B5 46  	cmp	word ptr [0B581h],46h
24C5:0281 7C 0C           	jl	028Fh

l24C5_0283:
24C5:0283 83 3E 81 B5 54  	cmp	word ptr [0B581h],54h
24C5:0288 74 05           	jz	028Fh

l24C5_028A:
24C5:028A C7 46 FA AA 00  	mov	word ptr [bp-6h],0AAh

l24C5_028F:
24C5:028F 33 F6           	xor	si,si
24C5:0291 EB 53           	jmp	02E6h

l24C5_0293:
24C5:0293 8B C6           	mov	ax,si
24C5:0295 BA 96 00        	mov	dx,96h
24C5:0298 F7 E2           	mul	dx
24C5:029A 8B D8           	mov	bx,ax
24C5:029C 81 C3 81 8B     	add	bx,8B81h
24C5:02A0 1E              	push	ds
24C5:02A1 07              	pop	es
24C5:02A2 26 80 3F 00     	cmp	byte ptr es:[bx],0h
24C5:02A6 74 3D           	jz	02E5h

l24C5_02A8:
24C5:02A8 C7 46 F8 DD 00  	mov	word ptr [bp-8h],0DDh
24C5:02AD 83 FE 0C        	cmp	si,0Ch
24C5:02B0 7C 06           	jl	02B8h

l24C5_02B2:
24C5:02B2 8B 46 FA        	mov	ax,[bp-6h]
24C5:02B5 89 46 F8        	mov	[bp-8h],ax

l24C5_02B8:
24C5:02B8 8A 84 62 85     	mov	al,[si+8562h]
24C5:02BC 88 84 74 83     	mov	[si+8374h],al
24C5:02C0 8A 84 7B 85     	mov	al,[si+857Bh]
24C5:02C4 88 84 C0 83     	mov	[si+83C0h],al
24C5:02C8 FF 76 F8        	push	word ptr [bp-8h]
24C5:02CB 8A 84 C0 83     	mov	al,[si+83C0h]
24C5:02CF B4 00           	mov	ah,0h
24C5:02D1 50              	push	ax
24C5:02D2 8A 84 74 83     	mov	al,[si+8374h]
24C5:02D6 B4 00           	mov	ah,0h
24C5:02D8 03 06 F1 A7     	add	ax,[0A7F1h]
24C5:02DC 50              	push	ax
24C5:02DD 9A 07 0B 00 08  	call	far 0800h:0B07h
24C5:02E2 83 C4 06        	add	sp,6h

l24C5_02E5:
24C5:02E5 46              	inc	si

l24C5_02E6:
24C5:02E6 83 FE 18        	cmp	si,18h
24C5:02E9 7C A8           	jl	0293h

l24C5_02EB:
24C5:02EB 5F              	pop	di
24C5:02EC 5E              	pop	si
24C5:02ED 8B E5           	mov	sp,bp
24C5:02EF 5D              	pop	bp
24C5:02F0 CB              	retf

;; DrawTacticalOverviewViewportFrame_02F1: 24C5:02F1
;;   Called from:
;;     24C5:0272 (in RefreshTacticalOverview_012E)
;;     24C5:03F7 (in DrawTacticalOverviewMap_037F)
DrawTacticalOverviewViewportFrame_02F1 proc
24C5:02F1 56              	push	si
24C5:02F2 57              	push	di
24C5:02F3 9A 2E 18 1F 1A  	call	far 1A1Fh:182Eh
24C5:02F8 A1 A0 84        	mov	ax,[84A0h]
24C5:02FB A3 8C 83        	mov	[838Ch],ax
24C5:02FE A1 DA 83        	mov	ax,[83DAh]
24C5:0301 A3 D8 83        	mov	[83D8h],ax
24C5:0304 8B 36 F1 A7     	mov	si,[0A7F1h]
24C5:0308 03 36 A0 84     	add	si,[84A0h]
24C5:030C D1 E6           	shl	si,1h
24C5:030E 8B 3E DA 83     	mov	di,[83DAh]
24C5:0312 D1 E7           	shl	di,1h
24C5:0314 B8 0F 00        	mov	ax,0Fh
24C5:0317 50              	push	ax
24C5:0318 57              	push	di
24C5:0319 8B C6           	mov	ax,si
24C5:031B 05 25 00        	add	ax,25h
24C5:031E 50              	push	ax
24C5:031F 57              	push	di
24C5:0320 56              	push	si
24C5:0321 9A A6 00 65 33  	call	far 3365h:00A6h
24C5:0326 83 C4 0A        	add	sp,0Ah
24C5:0329 B8 0F 00        	mov	ax,0Fh
24C5:032C 50              	push	ax
24C5:032D 8B C7           	mov	ax,di
24C5:032F 05 17 00        	add	ax,17h
24C5:0332 50              	push	ax
24C5:0333 56              	push	si
24C5:0334 57              	push	di
24C5:0335 56              	push	si
24C5:0336 9A A6 00 65 33  	call	far 3365h:00A6h
24C5:033B 83 C4 0A        	add	sp,0Ah
24C5:033E B8 0F 00        	mov	ax,0Fh
24C5:0341 50              	push	ax
24C5:0342 8B C7           	mov	ax,di
24C5:0344 05 17 00        	add	ax,17h
24C5:0347 50              	push	ax
24C5:0348 8B C6           	mov	ax,si
24C5:034A 05 25 00        	add	ax,25h
24C5:034D 50              	push	ax
24C5:034E 57              	push	di
24C5:034F 8B C6           	mov	ax,si
24C5:0351 05 25 00        	add	ax,25h
24C5:0354 50              	push	ax
24C5:0355 9A A6 00 65 33  	call	far 3365h:00A6h
24C5:035A 83 C4 0A        	add	sp,0Ah
24C5:035D B8 0F 00        	mov	ax,0Fh
24C5:0360 50              	push	ax
24C5:0361 8B C7           	mov	ax,di
24C5:0363 05 17 00        	add	ax,17h
24C5:0366 50              	push	ax
24C5:0367 8B C6           	mov	ax,si
24C5:0369 05 25 00        	add	ax,25h
24C5:036C 50              	push	ax
24C5:036D 8B C7           	mov	ax,di
24C5:036F 05 17 00        	add	ax,17h
24C5:0372 50              	push	ax
24C5:0373 56              	push	si
24C5:0374 9A A6 00 65 33  	call	far 3365h:00A6h
24C5:0379 83 C4 0A        	add	sp,0Ah
24C5:037C 5F              	pop	di
24C5:037D 5E              	pop	si
24C5:037E CB              	retf

;; DrawTacticalOverviewMap_037F: 24C5:037F
;;   Called from:
;;     1A1F:06F2 (in RunTacticalInteractionLoop_0613)
DrawTacticalOverviewMap_037F proc
24C5:037F 55              	push	bp
24C5:0380 8B EC           	mov	bp,sp
24C5:0382 83 EC 0A        	sub	sp,0Ah
24C5:0385 56              	push	si
24C5:0386 57              	push	di
24C5:0387 9A 59 2D 00 08  	call	far 0800h:2D59h
24C5:038C A1 A6 00        	mov	ax,[00A6h]
24C5:038F 05 07 00        	add	ax,7h
24C5:0392 25 F8 00        	and	ax,0F8h
24C5:0395 89 46 F8        	mov	[bp-8h],ax
24C5:0398 89 46 F6        	mov	[bp-0Ah],ax
24C5:039B 33 FF           	xor	di,di
24C5:039D EB 3E           	jmp	03DDh

l24C5_039F:
24C5:039F 8B C7           	mov	ax,di
24C5:03A1 F7 66 F8        	mul	word ptr [bp-8h]
24C5:03A4 C4 1E E6 83     	les	bx,[83E6h]
24C5:03A8 03 D8           	add	bx,ax
24C5:03AA 8C 46 FC        	mov	[bp-4h],es
24C5:03AD 89 5E FA        	mov	[bp-6h],bx
24C5:03B0 33 F6           	xor	si,si
24C5:03B2 EB 23           	jmp	03D7h

l24C5_03B4:
24C5:03B4 C4 5E FA        	les	bx,[bp-6h]
24C5:03B7 26 8A 07        	mov	al,es:[bx]
24C5:03BA 88 46 FF        	mov	[bp-1h],al
24C5:03BD FF 46 FA        	inc	word ptr [bp-6h]
24C5:03C0 8A 46 FF        	mov	al,[bp-1h]
24C5:03C3 B4 00           	mov	ah,0h
24C5:03C5 50              	push	ax
24C5:03C6 57              	push	di
24C5:03C7 8B C6           	mov	ax,si
24C5:03C9 03 06 F1 A7     	add	ax,[0A7F1h]
24C5:03CD 50              	push	ax
24C5:03CE 9A 07 0B 00 08  	call	far 0800h:0B07h
24C5:03D3 83 C4 06        	add	sp,6h
24C5:03D6 46              	inc	si

l24C5_03D7:
24C5:03D7 3B 76 F6        	cmp	si,[bp-0Ah]
24C5:03DA 7C D8           	jl	03B4h

l24C5_03DC:
24C5:03DC 47              	inc	di

l24C5_03DD:
24C5:03DD 3B 3E A8 00     	cmp	di,[00A8h]
24C5:03E1 7C BC           	jl	039Fh

l24C5_03E3:
24C5:03E3 33 F6           	xor	si,si
24C5:03E5 EB 0B           	jmp	03F2h

l24C5_03E7:
24C5:03E7 B0 FF           	mov	al,0FFh
24C5:03E9 88 84 C0 83     	mov	[si+83C0h],al
24C5:03ED 88 84 74 83     	mov	[si+8374h],al
24C5:03F1 46              	inc	si

l24C5_03F2:
24C5:03F2 83 FE 18        	cmp	si,18h
24C5:03F5 7C F0           	jl	03E7h

l24C5_03F7:
24C5:03F7 0E              	push	cs
24C5:03F8 E8 F6 FE        	call	02F1h
24C5:03FB 5F              	pop	di
24C5:03FC 5E              	pop	si
24C5:03FD 8B E5           	mov	sp,bp
24C5:03FF 5D              	pop	bp
24C5:0400 CB              	retf

;; ExitTacticalOverview_0401: 24C5:0401
;;   Called from:
;;     1A1F:06F9 (in RunTacticalInteractionLoop_0613)
;;     1A1F:5117 (in ShowPendingNarrationPrompt_4FA6)
ExitTacticalOverview_0401 proc
24C5:0401 56              	push	si
24C5:0402 C7 06 04 81 00 00 	mov	word ptr [8104h],0h
24C5:0408 9A 59 2D 00 08  	call	far 0800h:2D59h
24C5:040D 33 F6           	xor	si,si
24C5:040F EB 06           	jmp	0417h

l24C5_0411:
24C5:0411 C6 84 74 B5 FF  	mov	byte ptr [si+0B574h],0FFh
24C5:0416 46              	inc	si

l24C5_0417:
24C5:0417 83 FE 09        	cmp	si,9h
24C5:041A 7C F5           	jl	0411h

l24C5_041C:
24C5:041C 9A BA 16 07 20  	call	far 2007h:16BAh
