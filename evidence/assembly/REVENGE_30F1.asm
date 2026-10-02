;;; Segment 30F1 (30F1:0000)
30F1:0000 01 1F 5E 5F 5D CB                               ..^_].          

;; PrepareScenarioUnitRosters_0006: 30F1:0006
;;   Called from:
;;     0D73:286A (in RunInGameMenu_274D)
;;     0D73:2895 (in RunInGameMenu_274D)
;;     0D73:48B4 (in SaveGame_4866)
PrepareScenarioUnitRosters_0006 proc
30F1:0006 56              	push	si
30F1:0007 33 F6           	xor	si,si
30F1:0009 EB 11           	jmp	001Ch

l30F1_000B:
30F1:000B 8A 84 62 85     	mov	al,[si+8562h]
30F1:000F 88 84 7B 19     	mov	[si+197Bh],al
30F1:0013 8A 84 7B 85     	mov	al,[si+857Bh]
30F1:0017 88 84 93 19     	mov	[si+1993h],al
30F1:001B 46              	inc	si

l30F1_001C:
30F1:001C 83 FE 18        	cmp	si,18h
30F1:001F 7C EA           	jl	000Bh

l30F1_0021:
30F1:0021 BB 5F 85        	mov	bx,855Fh
30F1:0024 1E              	push	ds
30F1:0025 53              	push	bx
30F1:0026 BB 37 83        	mov	bx,8337h
30F1:0029 1E              	push	ds
30F1:002A 53              	push	bx
30F1:002B B9 03 00        	mov	cx,3h
30F1:002E 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0033 A1 81 B5        	mov	ax,[0B581h]
30F1:0036 2D 31 00        	sub	ax,31h
30F1:0039 3D 23 00        	cmp	ax,23h
30F1:003C 76 03           	jbe	0041h

l30F1_003E:
30F1:003E E9 33 08        	jmp	0874h

l30F1_0041:
30F1:0041 8B D8           	mov	bx,ax
30F1:0043 D1 E3           	shl	bx,1h
30F1:0045 2E FF A7 4A 00  	jmp	word ptr cs:[bx+4Ah]
l30F1_004A	dw	0x0092
l30F1_004C	dw	0x0111
l30F1_004E	dw	0x018C
l30F1_0050	dw	0x022A
l30F1_0052	dw	0x0275
l30F1_0054	dw	0x02FF
l30F1_0056	dw	0x0375
l30F1_0058	dw	0x03D7
l30F1_005A	dw	0x044D
l30F1_005C	dw	0x0874
l30F1_005E	dw	0x0874
l30F1_0060	dw	0x0874
l30F1_0062	dw	0x0874
l30F1_0064	dw	0x0874
l30F1_0066	dw	0x0874
l30F1_0068	dw	0x0874
l30F1_006A	dw	0x0874
l30F1_006C	dw	0x04D3
l30F1_006E	dw	0x053C
l30F1_0070	dw	0x0574
l30F1_0072	dw	0x05A7
l30F1_0074	dw	0x0874
l30F1_0076	dw	0x0874
l30F1_0078	dw	0x0874
l30F1_007A	dw	0x0874
l30F1_007C	dw	0x0874
l30F1_007E	dw	0x0874
l30F1_0080	dw	0x05D5
l30F1_0082	dw	0x0634
l30F1_0084	dw	0x066C
l30F1_0086	dw	0x06B3
l30F1_0088	dw	0x0724
l30F1_008A	dw	0x07A4
l30F1_008C	dw	0x082C
l30F1_008E	dw	0x082C
l30F1_0090	dw	0x0541

l30F1_0092:
30F1:0092 BB CE 9C        	mov	bx,9CCEh
30F1:0095 1E              	push	ds
30F1:0096 53              	push	bx
30F1:0097 BB B0 85        	mov	bx,85B0h
30F1:009A 1E              	push	ds
30F1:009B 53              	push	bx
30F1:009C B9 96 00        	mov	cx,96h
30F1:009F 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:00A4 C7 06 67 A9 00 00 	mov	word ptr [0A967h],0h
30F1:00AA 80 3E 81 8B 00  	cmp	byte ptr [8B81h],0h
30F1:00AF 74 24           	jz	00D5h

l30F1_00B1:
30F1:00B1 80 3E 83 8B 00  	cmp	byte ptr [8B83h],0h
30F1:00B6 74 1D           	jz	00D5h

l30F1_00B8:
30F1:00B8 BB CE 9C        	mov	bx,9CCEh
30F1:00BB 1E              	push	ds
30F1:00BC 53              	push	bx
30F1:00BD BB 81 8B        	mov	bx,8B81h
30F1:00C0 1E              	push	ds
30F1:00C1 53              	push	bx
30F1:00C2 B9 96 00        	mov	cx,96h
30F1:00C5 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:00CA C6 06 CE 9C 00  	mov	byte ptr [9CCEh],0h
30F1:00CF C7 06 67 A9 01 00 	mov	word ptr [0A967h],1h

l30F1_00D5:
30F1:00D5 A0 4B 94        	mov	al,[944Bh]
30F1:00D8 98              	cbw
30F1:00D9 A3 F1 88        	mov	[88F1h],ax
30F1:00DC F6 06 4E 88 80  	test	byte ptr [884Eh],80h
30F1:00E1 74 06           	jz	00E9h

l30F1_00E3:
30F1:00E3 C7 06 F1 88 01 00 	mov	word ptr [88F1h],1h

l30F1_00E9:
30F1:00E9 C6 06 4B 94 00  	mov	byte ptr [944Bh],0h
30F1:00EE BB AA A2        	mov	bx,0A2AAh
30F1:00F1 1E              	push	ds
30F1:00F2 53              	push	bx
30F1:00F3 BB 4B 94        	mov	bx,944Bh
30F1:00F6 1E              	push	ds
30F1:00F7 53              	push	bx
30F1:00F8 B9 96 00        	mov	cx,96h
30F1:00FB 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0100 B8 14 00        	mov	ax,14h
30F1:0103 50              	push	ax
30F1:0104 33 C0           	xor	ax,ax
30F1:0106 50              	push	ax
30F1:0107 9A 30 5D 1F 1A  	call	far 1A1Fh:5D30h
30F1:010C 59              	pop	cx
30F1:010D 59              	pop	cx
30F1:010E E9 65 07        	jmp	0876h

l30F1_0111:
30F1:0111 BB E0 99        	mov	bx,99E0h
30F1:0114 1E              	push	ds
30F1:0115 53              	push	bx
30F1:0116 BB 81 8B        	mov	bx,8B81h
30F1:0119 1E              	push	ds
30F1:011A 53              	push	bx
30F1:011B B9 96 00        	mov	cx,96h
30F1:011E 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0123 BB 76 9A        	mov	bx,9A76h
30F1:0126 1E              	push	ds
30F1:0127 53              	push	bx
30F1:0128 BB 17 8C        	mov	bx,8C17h
30F1:012B 1E              	push	ds
30F1:012C 53              	push	bx
30F1:012D B9 96 00        	mov	cx,96h
30F1:0130 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0135 BB 7E A1        	mov	bx,0A17Eh
30F1:0138 1E              	push	ds
30F1:0139 53              	push	bx
30F1:013A BB 89 92        	mov	bx,9289h
30F1:013D 1E              	push	ds
30F1:013E 53              	push	bx
30F1:013F B9 96 00        	mov	cx,96h
30F1:0142 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0147 BB 14 A2        	mov	bx,0A214h
30F1:014A 1E              	push	ds
30F1:014B 53              	push	bx
30F1:014C BB 39 97        	mov	bx,9739h
30F1:014F 1E              	push	ds
30F1:0150 53              	push	bx
30F1:0151 B9 96 00        	mov	cx,96h
30F1:0154 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0159 33 C0           	xor	ax,ax
30F1:015B A3 25 89        	mov	[8925h],ax
30F1:015E A3 C5 99        	mov	[99C5h],ax
30F1:0161 F6 06 4B 88 80  	test	byte ptr [884Bh],80h
30F1:0166 74 06           	jz	016Eh

l30F1_0168:
30F1:0168 C7 06 C5 99 01 00 	mov	word ptr [99C5h],1h

l30F1_016E:
30F1:016E F6 06 53 88 80  	test	byte ptr [8853h],80h
30F1:0173 74 06           	jz	017Bh

l30F1_0175:
30F1:0175 C7 06 25 89 01 00 	mov	word ptr [8925h],1h

l30F1_017B:
30F1:017B B8 03 00        	mov	ax,3h
30F1:017E 50              	push	ax
30F1:017F 33 C0           	xor	ax,ax
30F1:0181 50              	push	ax
30F1:0182 9A 30 5D 1F 1A  	call	far 1A1Fh:5D30h
30F1:0187 59              	pop	cx
30F1:0188 59              	pop	cx
30F1:0189 E9 EA 06        	jmp	0876h

l30F1_018C:
30F1:018C BB E0 99        	mov	bx,99E0h
30F1:018F 1E              	push	ds
30F1:0190 53              	push	bx
30F1:0191 BB 81 8B        	mov	bx,8B81h
30F1:0194 1E              	push	ds
30F1:0195 53              	push	bx
30F1:0196 B9 96 00        	mov	cx,96h
30F1:0199 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:019E BB 76 9A        	mov	bx,9A76h
30F1:01A1 1E              	push	ds
30F1:01A2 53              	push	bx
30F1:01A3 BB 17 8C        	mov	bx,8C17h
30F1:01A6 1E              	push	ds
30F1:01A7 53              	push	bx
30F1:01A8 B9 96 00        	mov	cx,96h
30F1:01AB 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:01B0 BB 38 9C        	mov	bx,9C38h
30F1:01B3 1E              	push	ds
30F1:01B4 53              	push	bx
30F1:01B5 BB 0C 9B        	mov	bx,9B0Ch
30F1:01B8 1E              	push	ds
30F1:01B9 53              	push	bx
30F1:01BA B9 96 00        	mov	cx,96h
30F1:01BD 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:01C2 83 3E 91 99 00  	cmp	word ptr [9991h],0h
30F1:01C7 74 19           	jz	01E2h

l30F1_01C9:
30F1:01C9 BB 0C 9B        	mov	bx,9B0Ch
30F1:01CC 1E              	push	ds
30F1:01CD 53              	push	bx
30F1:01CE BB 89 92        	mov	bx,9289h
30F1:01D1 1E              	push	ds
30F1:01D2 53              	push	bx
30F1:01D3 B9 96 00        	mov	cx,96h
30F1:01D6 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:01DB C6 06 0C 9B 01  	mov	byte ptr [9B0Ch],1h
30F1:01E0 EB 25           	jmp	0207h

l30F1_01E2:
30F1:01E2 BB 0C 9B        	mov	bx,9B0Ch
30F1:01E5 1E              	push	ds
30F1:01E6 53              	push	bx
30F1:01E7 BB AD 8C        	mov	bx,8CADh
30F1:01EA 1E              	push	ds
30F1:01EB 53              	push	bx
30F1:01EC B9 96 00        	mov	cx,96h
30F1:01EF 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:01F4 80 3E 29 B0 00  	cmp	byte ptr [0B029h],0h
30F1:01F9 75 0C           	jnz	0207h

l30F1_01FB:
30F1:01FB 83 3E 67 A9 00  	cmp	word ptr [0A967h],0h
30F1:0200 74 05           	jz	0207h

l30F1_0202:
30F1:0202 C6 06 0C 9B 01  	mov	byte ptr [9B0Ch],1h

l30F1_0207:
30F1:0207 BB CE 9C        	mov	bx,9CCEh
30F1:020A 1E              	push	ds
30F1:020B 53              	push	bx
30F1:020C BB B0 85        	mov	bx,85B0h
30F1:020F 1E              	push	ds
30F1:0210 53              	push	bx
30F1:0211 B9 96 00        	mov	cx,96h
30F1:0214 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0219 B8 02 00        	mov	ax,2h
30F1:021C 50              	push	ax
30F1:021D 33 C0           	xor	ax,ax
30F1:021F 50              	push	ax
30F1:0220 9A 30 5D 1F 1A  	call	far 1A1Fh:5D30h
30F1:0225 59              	pop	cx
30F1:0226 59              	pop	cx
30F1:0227 E9 4C 06        	jmp	0876h

l30F1_022A:
30F1:022A BB E0 99        	mov	bx,99E0h
30F1:022D 1E              	push	ds
30F1:022E 53              	push	bx
30F1:022F BB 81 8B        	mov	bx,8B81h
30F1:0232 1E              	push	ds
30F1:0233 53              	push	bx
30F1:0234 B9 96 00        	mov	cx,96h
30F1:0237 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:023C BB 76 9A        	mov	bx,9A76h
30F1:023F 1E              	push	ds
30F1:0240 53              	push	bx
30F1:0241 BB 17 8C        	mov	bx,8C17h
30F1:0244 1E              	push	ds
30F1:0245 53              	push	bx
30F1:0246 B9 96 00        	mov	cx,96h
30F1:0249 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:024E BB 0C 9B        	mov	bx,9B0Ch
30F1:0251 1E              	push	ds
30F1:0252 53              	push	bx
30F1:0253 BB 38 9C        	mov	bx,9C38h
30F1:0256 1E              	push	ds
30F1:0257 53              	push	bx
30F1:0258 B9 96 00        	mov	cx,96h
30F1:025B 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0260 BB 38 9C        	mov	bx,9C38h
30F1:0263 1E              	push	ds
30F1:0264 53              	push	bx
30F1:0265 BB AD 8C        	mov	bx,8CADh
30F1:0268 1E              	push	ds
30F1:0269 53              	push	bx
30F1:026A B9 96 00        	mov	cx,96h
30F1:026D 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0272 E9 01 06        	jmp	0876h

l30F1_0275:
30F1:0275 33 C0           	xor	ax,ax
30F1:0277 50              	push	ax
30F1:0278 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:027D 59              	pop	cx
30F1:027E B8 01 00        	mov	ax,1h
30F1:0281 50              	push	ax
30F1:0282 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:0287 59              	pop	cx
30F1:0288 B8 02 00        	mov	ax,2h
30F1:028B 50              	push	ax
30F1:028C 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:0291 59              	pop	cx
30F1:0292 B8 03 00        	mov	ax,3h
30F1:0295 50              	push	ax
30F1:0296 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:029B 59              	pop	cx
30F1:029C B8 04 00        	mov	ax,4h
30F1:029F 50              	push	ax
30F1:02A0 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:02A5 59              	pop	cx
30F1:02A6 80 3E 76 9A 00  	cmp	byte ptr [9A76h],0h
30F1:02AB 75 12           	jnz	02BFh

l30F1_02AD:
30F1:02AD BB 76 9A        	mov	bx,9A76h
30F1:02B0 1E              	push	ds
30F1:02B1 53              	push	bx
30F1:02B2 BB 38 9C        	mov	bx,9C38h
30F1:02B5 1E              	push	ds
30F1:02B6 53              	push	bx
30F1:02B7 B9 96 00        	mov	cx,96h
30F1:02BA 9A 4B 55 00 08  	call	far 0800h:554Bh

l30F1_02BF:
30F1:02BF 80 3E 76 9A 00  	cmp	byte ptr [9A76h],0h
30F1:02C4 75 24           	jnz	02EAh

l30F1_02C6:
30F1:02C6 BB 76 9A        	mov	bx,9A76h
30F1:02C9 1E              	push	ds
30F1:02CA 53              	push	bx
30F1:02CB BB A2 9B        	mov	bx,9BA2h
30F1:02CE 1E              	push	ds
30F1:02CF 53              	push	bx
30F1:02D0 B9 96 00        	mov	cx,96h
30F1:02D3 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:02D8 BB A2 9B        	mov	bx,9BA2h
30F1:02DB 1E              	push	ds
30F1:02DC 53              	push	bx
30F1:02DD BB B0 85        	mov	bx,85B0h
30F1:02E0 1E              	push	ds
30F1:02E1 53              	push	bx
30F1:02E2 B9 96 00        	mov	cx,96h
30F1:02E5 9A 4B 55 00 08  	call	far 0800h:554Bh

l30F1_02EA:
30F1:02EA BB 38 9C        	mov	bx,9C38h
30F1:02ED 1E              	push	ds
30F1:02EE 53              	push	bx
30F1:02EF BB B0 85        	mov	bx,85B0h
30F1:02F2 1E              	push	ds
30F1:02F3 53              	push	bx
30F1:02F4 B9 96 00        	mov	cx,96h
30F1:02F7 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:02FC E9 77 05        	jmp	0876h

l30F1_02FF:
30F1:02FF 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:0304 33 F6           	xor	si,si
30F1:0306 EB 53           	jmp	035Bh

l30F1_0308:
30F1:0308 8B C6           	mov	ax,si
30F1:030A BA 96 00        	mov	dx,96h
30F1:030D F7 E2           	mul	dx
30F1:030F 8B D8           	mov	bx,ax
30F1:0311 81 C3 E0 99     	add	bx,99E0h
30F1:0315 1E              	push	ds
30F1:0316 53              	push	bx
30F1:0317 8B C6           	mov	ax,si
30F1:0319 BA 96 00        	mov	dx,96h
30F1:031C F7 E2           	mul	dx
30F1:031E 8B D8           	mov	bx,ax
30F1:0320 81 C3 81 8B     	add	bx,8B81h
30F1:0324 1E              	push	ds
30F1:0325 53              	push	bx
30F1:0326 B9 96 00        	mov	cx,96h
30F1:0329 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:032E 8B C6           	mov	ax,si
30F1:0330 05 15 00        	add	ax,15h
30F1:0333 BA 96 00        	mov	dx,96h
30F1:0336 F7 E2           	mul	dx
30F1:0338 8B D8           	mov	bx,ax
30F1:033A 81 C3 E0 99     	add	bx,99E0h
30F1:033E 1E              	push	ds
30F1:033F 53              	push	bx
30F1:0340 8B C6           	mov	ax,si
30F1:0342 05 15 00        	add	ax,15h
30F1:0345 BA 96 00        	mov	dx,96h
30F1:0348 F7 E2           	mul	dx
30F1:034A 8B D8           	mov	bx,ax
30F1:034C 81 C3 81 8B     	add	bx,8B81h
30F1:0350 1E              	push	ds
30F1:0351 53              	push	bx
30F1:0352 B9 96 00        	mov	cx,96h
30F1:0355 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:035A 46              	inc	si

l30F1_035B:
30F1:035B 83 FE 03        	cmp	si,3h
30F1:035E 7C A8           	jl	0308h

l30F1_0360:
30F1:0360 BB 98 A5        	mov	bx,0A598h
30F1:0363 1E              	push	ds
30F1:0364 53              	push	bx
30F1:0365 BB B0 85        	mov	bx,85B0h
30F1:0368 1E              	push	ds
30F1:0369 53              	push	bx
30F1:036A B9 96 00        	mov	cx,96h
30F1:036D 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0372 E9 01 05        	jmp	0876h

l30F1_0375:
30F1:0375 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:037A BB A2 9B        	mov	bx,9BA2h
30F1:037D 1E              	push	ds
30F1:037E 53              	push	bx
30F1:037F BB 81 8B        	mov	bx,8B81h
30F1:0382 1E              	push	ds
30F1:0383 53              	push	bx
30F1:0384 B9 96 00        	mov	cx,96h
30F1:0387 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:038C BB 38 9C        	mov	bx,9C38h
30F1:038F 1E              	push	ds
30F1:0390 53              	push	bx
30F1:0391 BB 17 8C        	mov	bx,8C17h
30F1:0394 1E              	push	ds
30F1:0395 53              	push	bx
30F1:0396 B9 96 00        	mov	cx,96h
30F1:0399 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:039E 33 F6           	xor	si,si
30F1:03A0 EB 2D           	jmp	03CFh

l30F1_03A2:
30F1:03A2 8B C6           	mov	ax,si
30F1:03A4 05 15 00        	add	ax,15h
30F1:03A7 BA 96 00        	mov	dx,96h
30F1:03AA F7 E2           	mul	dx
30F1:03AC 8B D8           	mov	bx,ax
30F1:03AE 81 C3 E0 99     	add	bx,99E0h
30F1:03B2 1E              	push	ds
30F1:03B3 53              	push	bx
30F1:03B4 8B C6           	mov	ax,si
30F1:03B6 05 15 00        	add	ax,15h
30F1:03B9 BA 96 00        	mov	dx,96h
30F1:03BC F7 E2           	mul	dx
30F1:03BE 8B D8           	mov	bx,ax
30F1:03C0 81 C3 81 8B     	add	bx,8B81h
30F1:03C4 1E              	push	ds
30F1:03C5 53              	push	bx
30F1:03C6 B9 96 00        	mov	cx,96h
30F1:03C9 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:03CE 46              	inc	si

l30F1_03CF:
30F1:03CF 83 FE 03        	cmp	si,3h
30F1:03D2 7C CE           	jl	03A2h

l30F1_03D4:
30F1:03D4 E9 9F 04        	jmp	0876h

l30F1_03D7:
30F1:03D7 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:03DC 33 F6           	xor	si,si
30F1:03DE EB 53           	jmp	0433h

l30F1_03E0:
30F1:03E0 8B C6           	mov	ax,si
30F1:03E2 BA 96 00        	mov	dx,96h
30F1:03E5 F7 E2           	mul	dx
30F1:03E7 8B D8           	mov	bx,ax
30F1:03E9 81 C3 E0 99     	add	bx,99E0h
30F1:03ED 1E              	push	ds
30F1:03EE 53              	push	bx
30F1:03EF 8B C6           	mov	ax,si
30F1:03F1 BA 96 00        	mov	dx,96h
30F1:03F4 F7 E2           	mul	dx
30F1:03F6 8B D8           	mov	bx,ax
30F1:03F8 81 C3 81 8B     	add	bx,8B81h
30F1:03FC 1E              	push	ds
30F1:03FD 53              	push	bx
30F1:03FE B9 96 00        	mov	cx,96h
30F1:0401 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0406 8B C6           	mov	ax,si
30F1:0408 05 15 00        	add	ax,15h
30F1:040B BA 96 00        	mov	dx,96h
30F1:040E F7 E2           	mul	dx
30F1:0410 8B D8           	mov	bx,ax
30F1:0412 81 C3 E0 99     	add	bx,99E0h
30F1:0416 1E              	push	ds
30F1:0417 53              	push	bx
30F1:0418 8B C6           	mov	ax,si
30F1:041A 05 15 00        	add	ax,15h
30F1:041D BA 96 00        	mov	dx,96h
30F1:0420 F7 E2           	mul	dx
30F1:0422 8B D8           	mov	bx,ax
30F1:0424 81 C3 81 8B     	add	bx,8B81h
30F1:0428 1E              	push	ds
30F1:0429 53              	push	bx
30F1:042A B9 96 00        	mov	cx,96h
30F1:042D 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0432 46              	inc	si

l30F1_0433:
30F1:0433 83 FE 03        	cmp	si,3h
30F1:0436 7C A8           	jl	03E0h

l30F1_0438:
30F1:0438 BB A2 9B        	mov	bx,9BA2h
30F1:043B 1E              	push	ds
30F1:043C 53              	push	bx
30F1:043D BB D9 8D        	mov	bx,8DD9h
30F1:0440 1E              	push	ds
30F1:0441 53              	push	bx
30F1:0442 B9 96 00        	mov	cx,96h
30F1:0445 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:044A E9 29 04        	jmp	0876h

l30F1_044D:
30F1:044D 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:0452 BB E0 99        	mov	bx,99E0h
30F1:0455 1E              	push	ds
30F1:0456 53              	push	bx
30F1:0457 BB 81 8B        	mov	bx,8B81h
30F1:045A 1E              	push	ds
30F1:045B 53              	push	bx
30F1:045C B9 96 00        	mov	cx,96h
30F1:045F 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0464 BB A2 9B        	mov	bx,9BA2h
30F1:0467 1E              	push	ds
30F1:0468 53              	push	bx
30F1:0469 BB 17 8C        	mov	bx,8C17h
30F1:046C 1E              	push	ds
30F1:046D 53              	push	bx
30F1:046E B9 96 00        	mov	cx,96h
30F1:0471 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0476 BB 76 9A        	mov	bx,9A76h
30F1:0479 1E              	push	ds
30F1:047A 53              	push	bx
30F1:047B BB D9 8D        	mov	bx,8DD9h
30F1:047E 1E              	push	ds
30F1:047F 53              	push	bx
30F1:0480 B9 96 00        	mov	cx,96h
30F1:0483 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0488 BB 0C 9B        	mov	bx,9B0Ch
30F1:048B 1E              	push	ds
30F1:048C 53              	push	bx
30F1:048D BB 6F 8E        	mov	bx,8E6Fh
30F1:0490 1E              	push	ds
30F1:0491 53              	push	bx
30F1:0492 B9 96 00        	mov	cx,96h
30F1:0495 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:049A 33 F6           	xor	si,si
30F1:049C EB 2D           	jmp	04CBh

l30F1_049E:
30F1:049E 8B C6           	mov	ax,si
30F1:04A0 05 15 00        	add	ax,15h
30F1:04A3 BA 96 00        	mov	dx,96h
30F1:04A6 F7 E2           	mul	dx
30F1:04A8 8B D8           	mov	bx,ax
30F1:04AA 81 C3 E0 99     	add	bx,99E0h
30F1:04AE 1E              	push	ds
30F1:04AF 53              	push	bx
30F1:04B0 8B C6           	mov	ax,si
30F1:04B2 05 15 00        	add	ax,15h
30F1:04B5 BA 96 00        	mov	dx,96h
30F1:04B8 F7 E2           	mul	dx
30F1:04BA 8B D8           	mov	bx,ax
30F1:04BC 81 C3 81 8B     	add	bx,8B81h
30F1:04C0 1E              	push	ds
30F1:04C1 53              	push	bx
30F1:04C2 B9 96 00        	mov	cx,96h
30F1:04C5 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:04CA 46              	inc	si

l30F1_04CB:
30F1:04CB 83 FE 03        	cmp	si,3h
30F1:04CE 7C CE           	jl	049Eh

l30F1_04D0:
30F1:04D0 E9 A3 03        	jmp	0876h

l30F1_04D3:
30F1:04D3 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:04D8 33 F6           	xor	si,si
30F1:04DA EB 27           	jmp	0503h

l30F1_04DC:
30F1:04DC 8B C6           	mov	ax,si
30F1:04DE BA 96 00        	mov	dx,96h
30F1:04E1 F7 E2           	mul	dx
30F1:04E3 8B D8           	mov	bx,ax
30F1:04E5 81 C3 E0 99     	add	bx,99E0h
30F1:04E9 1E              	push	ds
30F1:04EA 53              	push	bx
30F1:04EB 8B C6           	mov	ax,si
30F1:04ED BA 96 00        	mov	dx,96h
30F1:04F0 F7 E2           	mul	dx
30F1:04F2 8B D8           	mov	bx,ax
30F1:04F4 81 C3 81 8B     	add	bx,8B81h
30F1:04F8 1E              	push	ds
30F1:04F9 53              	push	bx
30F1:04FA B9 96 00        	mov	cx,96h
30F1:04FD 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0502 46              	inc	si

l30F1_0503:
30F1:0503 83 FE 0C        	cmp	si,0Ch
30F1:0506 7C D4           	jl	04DCh

l30F1_0508:
30F1:0508 BE 10 00        	mov	si,10h
30F1:050B EB 27           	jmp	0534h

l30F1_050D:
30F1:050D 8B C6           	mov	ax,si
30F1:050F BA 96 00        	mov	dx,96h
30F1:0512 F7 E2           	mul	dx
30F1:0514 8B D8           	mov	bx,ax
30F1:0516 81 C3 E0 99     	add	bx,99E0h
30F1:051A 1E              	push	ds
30F1:051B 53              	push	bx
30F1:051C 8B C6           	mov	ax,si
30F1:051E BA 96 00        	mov	dx,96h
30F1:0521 F7 E2           	mul	dx
30F1:0523 8B D8           	mov	bx,ax
30F1:0525 81 C3 81 8B     	add	bx,8B81h
30F1:0529 1E              	push	ds
30F1:052A 53              	push	bx
30F1:052B B9 96 00        	mov	cx,96h
30F1:052E 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0533 46              	inc	si

l30F1_0534:
30F1:0534 83 FE 18        	cmp	si,18h
30F1:0537 7C D4           	jl	050Dh

l30F1_0539:
30F1:0539 E9 3A 03        	jmp	0876h

l30F1_053C:
30F1:053C 9A 59 0B F1 30  	call	far 30F1h:0B59h

l30F1_0541:
30F1:0541 33 F6           	xor	si,si
30F1:0543 EB 27           	jmp	056Ch

l30F1_0545:
30F1:0545 8B C6           	mov	ax,si
30F1:0547 BA 96 00        	mov	dx,96h
30F1:054A F7 E2           	mul	dx
30F1:054C 8B D8           	mov	bx,ax
30F1:054E 81 C3 E0 99     	add	bx,99E0h
30F1:0552 1E              	push	ds
30F1:0553 53              	push	bx
30F1:0554 8B C6           	mov	ax,si
30F1:0556 BA 96 00        	mov	dx,96h
30F1:0559 F7 E2           	mul	dx
30F1:055B 8B D8           	mov	bx,ax
30F1:055D 81 C3 81 8B     	add	bx,8B81h
30F1:0561 1E              	push	ds
30F1:0562 53              	push	bx
30F1:0563 B9 96 00        	mov	cx,96h
30F1:0566 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:056B 46              	inc	si

l30F1_056C:
30F1:056C 83 FE 0C        	cmp	si,0Ch
30F1:056F 7C D4           	jl	0545h

l30F1_0571:
30F1:0571 E9 02 03        	jmp	0876h

l30F1_0574:
30F1:0574 33 F6           	xor	si,si
30F1:0576 EB 27           	jmp	059Fh

l30F1_0578:
30F1:0578 8B C6           	mov	ax,si
30F1:057A BA 96 00        	mov	dx,96h
30F1:057D F7 E2           	mul	dx
30F1:057F 8B D8           	mov	bx,ax
30F1:0581 81 C3 E0 99     	add	bx,99E0h
30F1:0585 1E              	push	ds
30F1:0586 53              	push	bx
30F1:0587 8B C6           	mov	ax,si
30F1:0589 BA 96 00        	mov	dx,96h
30F1:058C F7 E2           	mul	dx
30F1:058E 8B D8           	mov	bx,ax
30F1:0590 81 C3 81 8B     	add	bx,8B81h
30F1:0594 1E              	push	ds
30F1:0595 53              	push	bx
30F1:0596 B9 96 00        	mov	cx,96h
30F1:0599 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:059E 46              	inc	si

l30F1_059F:
30F1:059F 83 FE 18        	cmp	si,18h
30F1:05A2 7C D4           	jl	0578h

l30F1_05A4:
30F1:05A4 E9 CF 02        	jmp	0876h

l30F1_05A7:
30F1:05A7 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:05AC 33 F6           	xor	si,si
30F1:05AE EB 1D           	jmp	05CDh

l30F1_05B0:
30F1:05B0 8B C6           	mov	ax,si
30F1:05B2 BA 96 00        	mov	dx,96h
30F1:05B5 F7 E2           	mul	dx
30F1:05B7 8B D8           	mov	bx,ax
30F1:05B9 81 C3 E0 99     	add	bx,99E0h
30F1:05BD 1E              	push	ds
30F1:05BE 53              	push	bx
30F1:05BF BB B0 85        	mov	bx,85B0h
30F1:05C2 1E              	push	ds
30F1:05C3 53              	push	bx
30F1:05C4 B9 96 00        	mov	cx,96h
30F1:05C7 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:05CC 46              	inc	si

l30F1_05CD:
30F1:05CD 83 FE 18        	cmp	si,18h
30F1:05D0 7C DE           	jl	05B0h

l30F1_05D2:
30F1:05D2 E9 A1 02        	jmp	0876h

l30F1_05D5:
30F1:05D5 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:05DA 33 F6           	xor	si,si
30F1:05DC EB 27           	jmp	0605h

l30F1_05DE:
30F1:05DE 8B C6           	mov	ax,si
30F1:05E0 BA 96 00        	mov	dx,96h
30F1:05E3 F7 E2           	mul	dx
30F1:05E5 8B D8           	mov	bx,ax
30F1:05E7 81 C3 E0 99     	add	bx,99E0h
30F1:05EB 1E              	push	ds
30F1:05EC 53              	push	bx
30F1:05ED 8B C6           	mov	ax,si
30F1:05EF BA 96 00        	mov	dx,96h
30F1:05F2 F7 E2           	mul	dx
30F1:05F4 8B D8           	mov	bx,ax
30F1:05F6 81 C3 81 8B     	add	bx,8B81h
30F1:05FA 1E              	push	ds
30F1:05FB 53              	push	bx
30F1:05FC B9 96 00        	mov	cx,96h
30F1:05FF 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0604 46              	inc	si

l30F1_0605:
30F1:0605 83 FE 04        	cmp	si,4h
30F1:0608 7C D4           	jl	05DEh

l30F1_060A:
30F1:060A BE 0C 00        	mov	si,0Ch
30F1:060D EB 1D           	jmp	062Ch

l30F1_060F:
30F1:060F 8B C6           	mov	ax,si
30F1:0611 BA 96 00        	mov	dx,96h
30F1:0614 F7 E2           	mul	dx
30F1:0616 8B D8           	mov	bx,ax
30F1:0618 81 C3 E0 99     	add	bx,99E0h
30F1:061C 1E              	push	ds
30F1:061D 53              	push	bx
30F1:061E BB B0 85        	mov	bx,85B0h
30F1:0621 1E              	push	ds
30F1:0622 53              	push	bx
30F1:0623 B9 96 00        	mov	cx,96h
30F1:0626 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:062B 46              	inc	si

l30F1_062C:
30F1:062C 83 FE 18        	cmp	si,18h
30F1:062F 7C DE           	jl	060Fh

l30F1_0631:
30F1:0631 E9 42 02        	jmp	0876h

l30F1_0634:
30F1:0634 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:0639 33 F6           	xor	si,si
30F1:063B EB 27           	jmp	0664h

l30F1_063D:
30F1:063D 8B C6           	mov	ax,si
30F1:063F BA 96 00        	mov	dx,96h
30F1:0642 F7 E2           	mul	dx
30F1:0644 8B D8           	mov	bx,ax
30F1:0646 81 C3 E0 99     	add	bx,99E0h
30F1:064A 1E              	push	ds
30F1:064B 53              	push	bx
30F1:064C 8B C6           	mov	ax,si
30F1:064E BA 96 00        	mov	dx,96h
30F1:0651 F7 E2           	mul	dx
30F1:0653 8B D8           	mov	bx,ax
30F1:0655 81 C3 81 8B     	add	bx,8B81h
30F1:0659 1E              	push	ds
30F1:065A 53              	push	bx
30F1:065B B9 96 00        	mov	cx,96h
30F1:065E 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0663 46              	inc	si

l30F1_0664:
30F1:0664 83 FE 0C        	cmp	si,0Ch
30F1:0667 7C D4           	jl	063Dh

l30F1_0669:
30F1:0669 E9 0A 02        	jmp	0876h

l30F1_066C:
30F1:066C 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:0671 33 F6           	xor	si,si
30F1:0673 EB 36           	jmp	06ABh

l30F1_0675:
30F1:0675 8B C6           	mov	ax,si
30F1:0677 BA 96 00        	mov	dx,96h
30F1:067A F7 E2           	mul	dx
30F1:067C 8B D8           	mov	bx,ax
30F1:067E 81 C3 E0 99     	add	bx,99E0h
30F1:0682 1E              	push	ds
30F1:0683 53              	push	bx
30F1:0684 8B C6           	mov	ax,si
30F1:0686 BA 96 00        	mov	dx,96h
30F1:0689 F7 E2           	mul	dx
30F1:068B 8B D8           	mov	bx,ax
30F1:068D 81 C3 81 8B     	add	bx,8B81h
30F1:0691 1E              	push	ds
30F1:0692 53              	push	bx
30F1:0693 B9 96 00        	mov	cx,96h
30F1:0696 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:069B F7 06 DF 24 01 00 	test	word ptr [24DFh],1h
30F1:06A1 74 07           	jz	06AAh

l30F1_06A3:
30F1:06A3 56              	push	si
30F1:06A4 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:06A9 59              	pop	cx

l30F1_06AA:
30F1:06AA 46              	inc	si

l30F1_06AB:
30F1:06AB 83 FE 0C        	cmp	si,0Ch
30F1:06AE 7C C5           	jl	0675h

l30F1_06B0:
30F1:06B0 E9 C3 01        	jmp	0876h

l30F1_06B3:
30F1:06B3 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:06B8 9A 81 0A F1 30  	call	far 30F1h:0A81h
30F1:06BD 9A 8F 0B F1 30  	call	far 30F1h:0B8Fh
30F1:06C2 33 F6           	xor	si,si
30F1:06C4 EB 56           	jmp	071Ch

l30F1_06C6:
30F1:06C6 8B C6           	mov	ax,si
30F1:06C8 05 08 00        	add	ax,8h
30F1:06CB BA 96 00        	mov	dx,96h
30F1:06CE F7 E2           	mul	dx
30F1:06D0 8B D8           	mov	bx,ax
30F1:06D2 81 C3 E0 99     	add	bx,99E0h
30F1:06D6 1E              	push	ds
30F1:06D7 53              	push	bx
30F1:06D8 8B C6           	mov	ax,si
30F1:06DA 05 04 00        	add	ax,4h
30F1:06DD BA 96 00        	mov	dx,96h
30F1:06E0 F7 E2           	mul	dx
30F1:06E2 8B D8           	mov	bx,ax
30F1:06E4 81 C3 81 8B     	add	bx,8B81h
30F1:06E8 1E              	push	ds
30F1:06E9 53              	push	bx
30F1:06EA B9 96 00        	mov	cx,96h
30F1:06ED 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:06F2 8B C6           	mov	ax,si
30F1:06F4 05 0C 00        	add	ax,0Ch
30F1:06F7 BA 96 00        	mov	dx,96h
30F1:06FA F7 E2           	mul	dx
30F1:06FC 8B D8           	mov	bx,ax
30F1:06FE 81 C3 E0 99     	add	bx,99E0h
30F1:0702 1E              	push	ds
30F1:0703 53              	push	bx
30F1:0704 8B C6           	mov	ax,si
30F1:0706 BA 96 00        	mov	dx,96h
30F1:0709 F7 E2           	mul	dx
30F1:070B 8B D8           	mov	bx,ax
30F1:070D 81 C3 81 8B     	add	bx,8B81h
30F1:0711 1E              	push	ds
30F1:0712 53              	push	bx
30F1:0713 B9 96 00        	mov	cx,96h
30F1:0716 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:071B 46              	inc	si

l30F1_071C:
30F1:071C 83 FE 04        	cmp	si,4h
30F1:071F 7C A5           	jl	06C6h

l30F1_0721:
30F1:0721 E9 52 01        	jmp	0876h

l30F1_0724:
30F1:0724 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:0729 9A 81 0A F1 30  	call	far 30F1h:0A81h
30F1:072E 9A 8F 0B F1 30  	call	far 30F1h:0B8Fh
30F1:0733 33 F6           	xor	si,si
30F1:0735 EB 65           	jmp	079Ch

l30F1_0737:
30F1:0737 8B C6           	mov	ax,si
30F1:0739 05 08 00        	add	ax,8h
30F1:073C BA 96 00        	mov	dx,96h
30F1:073F F7 E2           	mul	dx
30F1:0741 8B D8           	mov	bx,ax
30F1:0743 81 C3 E0 99     	add	bx,99E0h
30F1:0747 1E              	push	ds
30F1:0748 53              	push	bx
30F1:0749 8B C6           	mov	ax,si
30F1:074B 05 04 00        	add	ax,4h
30F1:074E BA 96 00        	mov	dx,96h
30F1:0751 F7 E2           	mul	dx
30F1:0753 8B D8           	mov	bx,ax
30F1:0755 81 C3 81 8B     	add	bx,8B81h
30F1:0759 1E              	push	ds
30F1:075A 53              	push	bx
30F1:075B B9 96 00        	mov	cx,96h
30F1:075E 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0763 8B C6           	mov	ax,si
30F1:0765 05 0C 00        	add	ax,0Ch
30F1:0768 BA 96 00        	mov	dx,96h
30F1:076B F7 E2           	mul	dx
30F1:076D 8B D8           	mov	bx,ax
30F1:076F 81 C3 E0 99     	add	bx,99E0h
30F1:0773 1E              	push	ds
30F1:0774 53              	push	bx
30F1:0775 8B C6           	mov	ax,si
30F1:0777 05 08 00        	add	ax,8h
30F1:077A BA 96 00        	mov	dx,96h
30F1:077D F7 E2           	mul	dx
30F1:077F 8B D8           	mov	bx,ax
30F1:0781 81 C3 81 8B     	add	bx,8B81h
30F1:0785 1E              	push	ds
30F1:0786 53              	push	bx
30F1:0787 B9 96 00        	mov	cx,96h
30F1:078A 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:078F 8B C6           	mov	ax,si
30F1:0791 05 0C 00        	add	ax,0Ch
30F1:0794 50              	push	ax
30F1:0795 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:079A 59              	pop	cx
30F1:079B 46              	inc	si

l30F1_079C:
30F1:079C 83 FE 04        	cmp	si,4h
30F1:079F 7C 96           	jl	0737h

l30F1_07A1:
30F1:07A1 E9 D2 00        	jmp	0876h

l30F1_07A4:
30F1:07A4 9A 81 0A F1 30  	call	far 30F1h:0A81h
30F1:07A9 9A 8F 0B F1 30  	call	far 30F1h:0B8Fh
30F1:07AE 33 F6           	xor	si,si
30F1:07B0 EB 2E           	jmp	07E0h

l30F1_07B2:
30F1:07B2 8B C6           	mov	ax,si
30F1:07B4 BA 96 00        	mov	dx,96h
30F1:07B7 F7 E2           	mul	dx
30F1:07B9 8B D8           	mov	bx,ax
30F1:07BB 81 C3 E0 99     	add	bx,99E0h
30F1:07BF 1E              	push	ds
30F1:07C0 53              	push	bx
30F1:07C1 8B C6           	mov	ax,si
30F1:07C3 BA 96 00        	mov	dx,96h
30F1:07C6 F7 E2           	mul	dx
30F1:07C8 8B D8           	mov	bx,ax
30F1:07CA 81 C3 81 8B     	add	bx,8B81h
30F1:07CE 1E              	push	ds
30F1:07CF 53              	push	bx
30F1:07D0 B9 96 00        	mov	cx,96h
30F1:07D3 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:07D8 56              	push	si
30F1:07D9 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:07DE 59              	pop	cx
30F1:07DF 46              	inc	si

l30F1_07E0:
30F1:07E0 83 FE 08        	cmp	si,8h
30F1:07E3 7C CD           	jl	07B2h

l30F1_07E5:
30F1:07E5 BE 08 00        	mov	si,8h
30F1:07E8 EB 36           	jmp	0820h

l30F1_07EA:
30F1:07EA 8B C6           	mov	ax,si
30F1:07EC 05 04 00        	add	ax,4h
30F1:07EF BA 96 00        	mov	dx,96h
30F1:07F2 F7 E2           	mul	dx
30F1:07F4 8B D8           	mov	bx,ax
30F1:07F6 81 C3 E0 99     	add	bx,99E0h
30F1:07FA 1E              	push	ds
30F1:07FB 53              	push	bx
30F1:07FC 8B C6           	mov	ax,si
30F1:07FE BA 96 00        	mov	dx,96h
30F1:0801 F7 E2           	mul	dx
30F1:0803 8B D8           	mov	bx,ax
30F1:0805 81 C3 81 8B     	add	bx,8B81h
30F1:0809 1E              	push	ds
30F1:080A 53              	push	bx
30F1:080B B9 96 00        	mov	cx,96h
30F1:080E 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0813 8B C6           	mov	ax,si
30F1:0815 05 04 00        	add	ax,4h
30F1:0818 50              	push	ax
30F1:0819 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:081E 59              	pop	cx
30F1:081F 46              	inc	si

l30F1_0820:
30F1:0820 83 FE 0C        	cmp	si,0Ch
30F1:0823 7C C5           	jl	07EAh

l30F1_0825:
30F1:0825 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:082A EB 4A           	jmp	0876h

l30F1_082C:
30F1:082C 9A 81 0A F1 30  	call	far 30F1h:0A81h
30F1:0831 9A 8F 0B F1 30  	call	far 30F1h:0B8Fh
30F1:0836 33 F6           	xor	si,si
30F1:0838 EB 2E           	jmp	0868h

l30F1_083A:
30F1:083A 8B C6           	mov	ax,si
30F1:083C BA 96 00        	mov	dx,96h
30F1:083F F7 E2           	mul	dx
30F1:0841 8B D8           	mov	bx,ax
30F1:0843 81 C3 E0 99     	add	bx,99E0h
30F1:0847 1E              	push	ds
30F1:0848 53              	push	bx
30F1:0849 8B C6           	mov	ax,si
30F1:084B BA 96 00        	mov	dx,96h
30F1:084E F7 E2           	mul	dx
30F1:0850 8B D8           	mov	bx,ax
30F1:0852 81 C3 81 8B     	add	bx,8B81h
30F1:0856 1E              	push	ds
30F1:0857 53              	push	bx
30F1:0858 B9 96 00        	mov	cx,96h
30F1:085B 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0860 56              	push	si
30F1:0861 9A 78 08 F1 30  	call	far 30F1h:0878h
30F1:0866 59              	pop	cx
30F1:0867 46              	inc	si

l30F1_0868:
30F1:0868 83 FE 08        	cmp	si,8h
30F1:086B 7C CD           	jl	083Ah

l30F1_086D:
30F1:086D 9A 59 0B F1 30  	call	far 30F1h:0B59h
30F1:0872 EB 02           	jmp	0876h

l30F1_0874:
30F1:0874 EB 00           	jmp	0876h

l30F1_0876:
30F1:0876 5E              	pop	si
30F1:0877 CB              	retf

;; ResetLiveUnitState_0878: 30F1:0878
;;   Called from:
;;     30F1:0278 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0282 (in PrepareScenarioUnitRosters_0006)
;;     30F1:028C (in PrepareScenarioUnitRosters_0006)
;;     30F1:0296 (in PrepareScenarioUnitRosters_0006)
;;     30F1:02A0 (in PrepareScenarioUnitRosters_0006)
;;     30F1:06A4 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0795 (in PrepareScenarioUnitRosters_0006)
;;     30F1:07D9 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0819 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0861 (in PrepareScenarioUnitRosters_0006)
ResetLiveUnitState_0878 proc
30F1:0878 55              	push	bp
30F1:0879 8B EC           	mov	bp,sp
30F1:087B 56              	push	si
30F1:087C 57              	push	di
30F1:087D 8B 7E 06        	mov	di,[bp+6h]
30F1:0880 33 F6           	xor	si,si
30F1:0882 E9 42 01        	jmp	09C7h

l30F1_0885:
30F1:0885 83 FE 08        	cmp	si,8h
30F1:0888 7D 58           	jge	08E2h

l30F1_088A:
30F1:088A 8B C7           	mov	ax,di
30F1:088C BA 96 00        	mov	dx,96h
30F1:088F F7 E2           	mul	dx
30F1:0891 8B D8           	mov	bx,ax
30F1:0893 81 C3 E0 99     	add	bx,99E0h
30F1:0897 1E              	push	ds
30F1:0898 07              	pop	es
30F1:0899 03 DE           	add	bx,si
30F1:089B 26 8A 47 17     	mov	al,es:[bx+17h]
30F1:089F 50              	push	ax
30F1:08A0 8B C7           	mov	ax,di
30F1:08A2 BA 96 00        	mov	dx,96h
30F1:08A5 F7 E2           	mul	dx
30F1:08A7 8B D8           	mov	bx,ax
30F1:08A9 81 C3 E0 99     	add	bx,99E0h
30F1:08AD 1E              	push	ds
30F1:08AE 07              	pop	es
30F1:08AF 03 DE           	add	bx,si
30F1:08B1 58              	pop	ax
30F1:08B2 26 88 47 04     	mov	es:[bx+4h],al
30F1:08B6 8B C7           	mov	ax,di
30F1:08B8 BA 96 00        	mov	dx,96h
30F1:08BB F7 E2           	mul	dx
30F1:08BD 8B D8           	mov	bx,ax
30F1:08BF 81 C3 E0 99     	add	bx,99E0h
30F1:08C3 1E              	push	ds
30F1:08C4 07              	pop	es
30F1:08C5 03 DE           	add	bx,si
30F1:08C7 26 80 67 56 7F  	and	byte ptr es:[bx+56h],7Fh
30F1:08CC 8B C7           	mov	ax,di
30F1:08CE BA 96 00        	mov	dx,96h
30F1:08D1 F7 E2           	mul	dx
30F1:08D3 8B D8           	mov	bx,ax
30F1:08D5 81 C3 E0 99     	add	bx,99E0h
30F1:08D9 1E              	push	ds
30F1:08DA 07              	pop	es
30F1:08DB 03 DE           	add	bx,si
30F1:08DD 26 80 67 78 7F  	and	byte ptr es:[bx+78h],7Fh

l30F1_08E2:
30F1:08E2 83 FE 0B        	cmp	si,0Bh
30F1:08E5 7D 2C           	jge	0913h

l30F1_08E7:
30F1:08E7 8B C7           	mov	ax,di
30F1:08E9 BA 96 00        	mov	dx,96h
30F1:08EC F7 E2           	mul	dx
30F1:08EE 8B D8           	mov	bx,ax
30F1:08F0 81 C3 E0 99     	add	bx,99E0h
30F1:08F4 1E              	push	ds
30F1:08F5 07              	pop	es
30F1:08F6 03 DE           	add	bx,si
30F1:08F8 26 8A 47 1F     	mov	al,es:[bx+1Fh]
30F1:08FC 50              	push	ax
30F1:08FD 8B C7           	mov	ax,di
30F1:08FF BA 96 00        	mov	dx,96h
30F1:0902 F7 E2           	mul	dx
30F1:0904 8B D8           	mov	bx,ax
30F1:0906 81 C3 E0 99     	add	bx,99E0h
30F1:090A 1E              	push	ds
30F1:090B 07              	pop	es
30F1:090C 03 DE           	add	bx,si
30F1:090E 58              	pop	ax
30F1:090F 26 88 47 0C     	mov	es:[bx+0Ch],al

l30F1_0913:
30F1:0913 8B C7           	mov	ax,di
30F1:0915 BA 96 00        	mov	dx,96h
30F1:0918 F7 E2           	mul	dx
30F1:091A 8B D8           	mov	bx,ax
30F1:091C 81 C3 E0 99     	add	bx,99E0h
30F1:0920 1E              	push	ds
30F1:0921 07              	pop	es
30F1:0922 03 DE           	add	bx,si
30F1:0924 26 8A 47 2A     	mov	al,es:[bx+2Ah]
30F1:0928 98              	cbw
30F1:0929 8B DE           	mov	bx,si
30F1:092B D1 E3           	shl	bx,1h
30F1:092D F7 A7 8E 05     	mul	word ptr [bx+58Eh]
30F1:0931 50              	push	ax
30F1:0932 8B C7           	mov	ax,di
30F1:0934 BA 96 00        	mov	dx,96h
30F1:0937 F7 E2           	mul	dx
30F1:0939 8B D8           	mov	bx,ax
30F1:093B 81 C3 E0 99     	add	bx,99E0h
30F1:093F 1E              	push	ds
30F1:0940 07              	pop	es
30F1:0941 8B C6           	mov	ax,si
30F1:0943 D1 E0           	shl	ax,1h
30F1:0945 03 D8           	add	bx,ax
30F1:0947 58              	pop	ax
30F1:0948 26 89 47 38     	mov	es:[bx+38h],ax
30F1:094C 83 FE 0C        	cmp	si,0Ch
30F1:094F 7D 2C           	jge	097Dh

l30F1_0951:
30F1:0951 8B C7           	mov	ax,di
30F1:0953 BA 96 00        	mov	dx,96h
30F1:0956 F7 E2           	mul	dx
30F1:0958 8B D8           	mov	bx,ax
30F1:095A 81 C3 E0 99     	add	bx,99E0h
30F1:095E 1E              	push	ds
30F1:095F 07              	pop	es
30F1:0960 03 DE           	add	bx,si
30F1:0962 26 80 67 5E 7F  	and	byte ptr es:[bx+5Eh],7Fh
30F1:0967 8B C7           	mov	ax,di
30F1:0969 BA 96 00        	mov	dx,96h
30F1:096C F7 E2           	mul	dx
30F1:096E 8B D8           	mov	bx,ax
30F1:0970 81 C3 E0 99     	add	bx,99E0h
30F1:0974 1E              	push	ds
30F1:0975 07              	pop	es
30F1:0976 03 DE           	add	bx,si
30F1:0978 26 80 67 6C 7F  	and	byte ptr es:[bx+6Ch],7Fh

l30F1_097D:
30F1:097D 83 FE 02        	cmp	si,2h
30F1:0980 7D 44           	jge	09C6h

l30F1_0982:
30F1:0982 8B C7           	mov	ax,di
30F1:0984 BA 96 00        	mov	dx,96h
30F1:0987 F7 E2           	mul	dx
30F1:0989 8B D8           	mov	bx,ax
30F1:098B 81 C3 E0 99     	add	bx,99E0h
30F1:098F 1E              	push	ds
30F1:0990 07              	pop	es
30F1:0991 03 DE           	add	bx,si
30F1:0993 26 80 A7 80 00 7F 	and	byte ptr es:[bx+80h],7Fh
30F1:0999 8B C7           	mov	ax,di
30F1:099B BA 96 00        	mov	dx,96h
30F1:099E F7 E2           	mul	dx
30F1:09A0 8B D8           	mov	bx,ax
30F1:09A2 81 C3 E0 99     	add	bx,99E0h
30F1:09A6 1E              	push	ds
30F1:09A7 07              	pop	es
30F1:09A8 03 DE           	add	bx,si
30F1:09AA 26 80 A7 82 00 7F 	and	byte ptr es:[bx+82h],7Fh
30F1:09B0 8B C7           	mov	ax,di
30F1:09B2 BA 96 00        	mov	dx,96h
30F1:09B5 F7 E2           	mul	dx
30F1:09B7 8B D8           	mov	bx,ax
30F1:09B9 81 C3 E0 99     	add	bx,99E0h
30F1:09BD 1E              	push	ds
30F1:09BE 07              	pop	es
30F1:09BF 03 DE           	add	bx,si
30F1:09C1 26 80 67 6A 7F  	and	byte ptr es:[bx+6Ah],7Fh

l30F1_09C6:
30F1:09C6 46              	inc	si

l30F1_09C7:
30F1:09C7 83 FE 0E        	cmp	si,0Eh
30F1:09CA 7D 03           	jge	09CFh

l30F1_09CC:
30F1:09CC E9 B6 FE        	jmp	0885h

l30F1_09CF:
30F1:09CF 8B C7           	mov	ax,di
30F1:09D1 BA 96 00        	mov	dx,96h
30F1:09D4 F7 E2           	mul	dx
30F1:09D6 8B D8           	mov	bx,ax
30F1:09D8 81 C3 E0 99     	add	bx,99E0h
30F1:09DC 1E              	push	ds
30F1:09DD 07              	pop	es
30F1:09DE 26 80 67 55 7F  	and	byte ptr es:[bx+55h],7Fh
30F1:09E3 33 C0           	xor	ax,ax
30F1:09E5 50              	push	ax
30F1:09E6 8B C7           	mov	ax,di
30F1:09E8 BA 96 00        	mov	dx,96h
30F1:09EB F7 E2           	mul	dx
30F1:09ED 8B D8           	mov	bx,ax
30F1:09EF 81 C3 E0 99     	add	bx,99E0h
30F1:09F3 1E              	push	ds
30F1:09F4 07              	pop	es
30F1:09F5 58              	pop	ax
30F1:09F6 26 89 87 86 00  	mov	es:[bx+86h],ax
30F1:09FB 50              	push	ax
30F1:09FC 8B C7           	mov	ax,di
30F1:09FE BA 96 00        	mov	dx,96h
30F1:0A01 F7 E2           	mul	dx
30F1:0A03 8B D8           	mov	bx,ax
30F1:0A05 81 C3 E0 99     	add	bx,99E0h
30F1:0A09 1E              	push	ds
30F1:0A0A 07              	pop	es
30F1:0A0B 58              	pop	ax
30F1:0A0C 26 88 87 85 00  	mov	es:[bx+85h],al
30F1:0A11 8B C7           	mov	ax,di
30F1:0A13 BA 96 00        	mov	dx,96h
30F1:0A16 F7 E2           	mul	dx
30F1:0A18 8B D8           	mov	bx,ax
30F1:0A1A 81 C3 E0 99     	add	bx,99E0h
30F1:0A1E 1E              	push	ds
30F1:0A1F 07              	pop	es
30F1:0A20 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
30F1:0A25 75 14           	jnz	0A3Bh

l30F1_0A27:
30F1:0A27 8B C7           	mov	ax,di
30F1:0A29 BA 96 00        	mov	dx,96h
30F1:0A2C F7 E2           	mul	dx
30F1:0A2E 8B D8           	mov	bx,ax
30F1:0A30 81 C3 E0 99     	add	bx,99E0h
30F1:0A34 1E              	push	ds
30F1:0A35 07              	pop	es
30F1:0A36 26 C6 47 02 04  	mov	byte ptr es:[bx+2h],4h

l30F1_0A3B:
30F1:0A3B 5F              	pop	di
30F1:0A3C 5E              	pop	si
30F1:0A3D 5D              	pop	bp
30F1:0A3E CB              	retf

;; AssignScenarioLanceAllegiances_0A3F: 30F1:0A3F
AssignScenarioLanceAllegiances_0A3F proc
30F1:0A3F 55              	push	bp
30F1:0A40 8B EC           	mov	bp,sp
30F1:0A42 56              	push	si
30F1:0A43 33 F6           	xor	si,si
30F1:0A45 EB 32           	jmp	0A79h

l30F1_0A47:
30F1:0A47 8B 46 06        	mov	ax,[bp+6h]
30F1:0A4A BA 03 00        	mov	dx,3h
30F1:0A4D F7 E2           	mul	dx
30F1:0A4F 8B D8           	mov	bx,ax
30F1:0A51 81 C3 28 59     	add	bx,5928h
30F1:0A55 1E              	push	ds
30F1:0A56 07              	pop	es
30F1:0A57 8B C6           	mov	ax,si
30F1:0A59 D1 F8           	sar	ax,1h
30F1:0A5B D1 F8           	sar	ax,1h
30F1:0A5D 03 D8           	add	bx,ax
30F1:0A5F 26 8A 07        	mov	al,es:[bx]
30F1:0A62 50              	push	ax
30F1:0A63 8B C6           	mov	ax,si
30F1:0A65 BA 96 00        	mov	dx,96h
30F1:0A68 F7 E2           	mul	dx
30F1:0A6A 8B D8           	mov	bx,ax
30F1:0A6C 81 C3 81 8B     	add	bx,8B81h
30F1:0A70 1E              	push	ds
30F1:0A71 07              	pop	es
30F1:0A72 58              	pop	ax
30F1:0A73 26 88 87 94 00  	mov	es:[bx+94h],al
30F1:0A78 46              	inc	si

l30F1_0A79:
30F1:0A79 83 FE 0C        	cmp	si,0Ch
30F1:0A7C 7C C9           	jl	0A47h

l30F1_0A7E:
30F1:0A7E 5E              	pop	si
30F1:0A7F 5D              	pop	bp
30F1:0A80 CB              	retf

;; UpdatePilotAvailability_0A81: 30F1:0A81
;;   Called from:
;;     30F1:06B8 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0729 (in PrepareScenarioUnitRosters_0006)
;;     30F1:07A4 (in PrepareScenarioUnitRosters_0006)
;;     30F1:082C (in PrepareScenarioUnitRosters_0006)
UpdatePilotAvailability_0A81 proc
30F1:0A81 56              	push	si
30F1:0A82 57              	push	di
30F1:0A83 33 F6           	xor	si,si
30F1:0A85 EB 6D           	jmp	0AF4h

l30F1_0A87:
30F1:0A87 8B C6           	mov	ax,si
30F1:0A89 BA 96 00        	mov	dx,96h
30F1:0A8C F7 E2           	mul	dx
30F1:0A8E 8B D8           	mov	bx,ax
30F1:0A90 81 C3 81 8B     	add	bx,8B81h
30F1:0A94 1E              	push	ds
30F1:0A95 07              	pop	es
30F1:0A96 26 80 BF 84 00 00 	cmp	byte ptr es:[bx+84h],0h
30F1:0A9C 74 55           	jz	0AF3h

l30F1_0A9E:
30F1:0A9E 8B C6           	mov	ax,si
30F1:0AA0 BA 96 00        	mov	dx,96h
30F1:0AA3 F7 E2           	mul	dx
30F1:0AA5 8B D8           	mov	bx,ax
30F1:0AA7 81 C3 81 8B     	add	bx,8B81h
30F1:0AAB 1E              	push	ds
30F1:0AAC 07              	pop	es
30F1:0AAD 26 8A 87 92 00  	mov	al,es:[bx+92h]
30F1:0AB2 98              	cbw
30F1:0AB3 8B F8           	mov	di,ax
30F1:0AB5 83 FF 25        	cmp	di,25h
30F1:0AB8 7D 39           	jge	0AF3h

l30F1_0ABA:
30F1:0ABA 8B C6           	mov	ax,si
30F1:0ABC BA 96 00        	mov	dx,96h
30F1:0ABF F7 E2           	mul	dx
30F1:0AC1 8B D8           	mov	bx,ax
30F1:0AC3 81 C3 81 8B     	add	bx,8B81h
30F1:0AC7 1E              	push	ds
30F1:0AC8 07              	pop	es
30F1:0AC9 26 80 3F 00     	cmp	byte ptr es:[bx],0h
30F1:0ACD 74 13           	jz	0AE2h

l30F1_0ACF:
30F1:0ACF 8B DF           	mov	bx,di
30F1:0AD1 D1 E3           	shl	bx,1h
30F1:0AD3 D1 E3           	shl	bx,1h
30F1:0AD5 81 C3 4C 1D     	add	bx,1D4Ch
30F1:0AD9 1E              	push	ds
30F1:0ADA 07              	pop	es
30F1:0ADB 26 C6 47 03 01  	mov	byte ptr es:[bx+3h],1h
30F1:0AE0 EB 11           	jmp	0AF3h

l30F1_0AE2:
30F1:0AE2 8B DF           	mov	bx,di
30F1:0AE4 D1 E3           	shl	bx,1h
30F1:0AE6 D1 E3           	shl	bx,1h
30F1:0AE8 81 C3 4C 1D     	add	bx,1D4Ch
30F1:0AEC 1E              	push	ds
30F1:0AED 07              	pop	es
30F1:0AEE 26 C6 47 03 FF  	mov	byte ptr es:[bx+3h],0FFh

l30F1_0AF3:
30F1:0AF3 46              	inc	si

l30F1_0AF4:
30F1:0AF4 83 FE 0C        	cmp	si,0Ch
30F1:0AF7 7C 8E           	jl	0A87h

l30F1_0AF9:
30F1:0AF9 5F              	pop	di
30F1:0AFA 5E              	pop	si
30F1:0AFB CB              	retf

;; AssignPilotRosterEntryToUnit_0AFC: 30F1:0AFC
;;   Called from:
;;     1A1F:339F (in ExecuteSceneInstructions_2A4E)
;;     1A1F:3962 (in ExecuteSceneInstructions_2A4E)
AssignPilotRosterEntryToUnit_0AFC proc
30F1:0AFC 55              	push	bp
30F1:0AFD 8B EC           	mov	bp,sp
30F1:0AFF 83 EC 04        	sub	sp,4h
30F1:0B02 8B 46 06        	mov	ax,[bp+6h]
30F1:0B05 BA 96 00        	mov	dx,96h
30F1:0B08 F7 E2           	mul	dx
30F1:0B0A 8B D8           	mov	bx,ax
30F1:0B0C 81 C3 81 8B     	add	bx,8B81h
30F1:0B10 1E              	push	ds
30F1:0B11 07              	pop	es
30F1:0B12 8C 46 FE        	mov	[bp-2h],es
30F1:0B15 89 5E FC        	mov	[bp-4h],bx
30F1:0B18 8A 46 08        	mov	al,[bp+8h]
30F1:0B1B C4 5E FC        	les	bx,[bp-4h]
30F1:0B1E 26 88 87 92 00  	mov	es:[bx+92h],al
30F1:0B23 8B 5E 08        	mov	bx,[bp+8h]
30F1:0B26 D1 E3           	shl	bx,1h
30F1:0B28 D1 E3           	shl	bx,1h
30F1:0B2A 81 C3 4C 1D     	add	bx,1D4Ch
30F1:0B2E 1E              	push	ds
30F1:0B2F 07              	pop	es
30F1:0B30 26 8A 47 01     	mov	al,es:[bx+1h]
30F1:0B34 C4 5E FC        	les	bx,[bp-4h]
30F1:0B37 26 88 87 93 00  	mov	es:[bx+93h],al
30F1:0B3C 8B 5E 08        	mov	bx,[bp+8h]
30F1:0B3F D1 E3           	shl	bx,1h
30F1:0B41 D1 E3           	shl	bx,1h
30F1:0B43 81 C3 4C 1D     	add	bx,1D4Ch
30F1:0B47 1E              	push	ds
30F1:0B48 07              	pop	es
30F1:0B49 26 8A 47 02     	mov	al,es:[bx+2h]
30F1:0B4D C4 5E FC        	les	bx,[bp-4h]
30F1:0B50 26 88 87 8A 00  	mov	es:[bx+8Ah],al
30F1:0B55 8B E5           	mov	sp,bp
30F1:0B57 5D              	pop	bp
30F1:0B58 CB              	retf

;; InvalidateEmptyRosterSlots_0B59: 30F1:0B59
;;   Called from:
;;     30F1:02FF (in PrepareScenarioUnitRosters_0006)
;;     30F1:0375 (in PrepareScenarioUnitRosters_0006)
;;     30F1:03D7 (in PrepareScenarioUnitRosters_0006)
;;     30F1:044D (in PrepareScenarioUnitRosters_0006)
;;     30F1:04D3 (in PrepareScenarioUnitRosters_0006)
;;     30F1:053C (in PrepareScenarioUnitRosters_0006)
;;     30F1:05A7 (in PrepareScenarioUnitRosters_0006)
;;     30F1:05D5 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0634 (in PrepareScenarioUnitRosters_0006)
;;     30F1:066C (in PrepareScenarioUnitRosters_0006)
;;     30F1:06B3 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0724 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0825 (in PrepareScenarioUnitRosters_0006)
;;     30F1:086D (in PrepareScenarioUnitRosters_0006)
InvalidateEmptyRosterSlots_0B59 proc
30F1:0B59 56              	push	si
30F1:0B5A 33 F6           	xor	si,si
30F1:0B5C EB 2A           	jmp	0B88h

l30F1_0B5E:
30F1:0B5E 8B C6           	mov	ax,si
30F1:0B60 BA 96 00        	mov	dx,96h
30F1:0B63 F7 E2           	mul	dx
30F1:0B65 8B D8           	mov	bx,ax
30F1:0B67 81 C3 81 8B     	add	bx,8B81h
30F1:0B6B 1E              	push	ds
30F1:0B6C 07              	pop	es
30F1:0B6D 26 80 7F 02 00  	cmp	byte ptr es:[bx+2h],0h
30F1:0B72 75 13           	jnz	0B87h

l30F1_0B74:
30F1:0B74 8B C6           	mov	ax,si
30F1:0B76 BA 96 00        	mov	dx,96h
30F1:0B79 F7 E2           	mul	dx
30F1:0B7B 8B D8           	mov	bx,ax
30F1:0B7D 81 C3 81 8B     	add	bx,8B81h
30F1:0B81 1E              	push	ds
30F1:0B82 07              	pop	es
30F1:0B83 26 C6 07 00     	mov	byte ptr es:[bx],0h

l30F1_0B87:
30F1:0B87 46              	inc	si

l30F1_0B88:
30F1:0B88 83 FE 18        	cmp	si,18h
30F1:0B8B 7C D1           	jl	0B5Eh

l30F1_0B8D:
30F1:0B8D 5E              	pop	si
30F1:0B8E CB              	retf

;; CompactScenarioLances_0B8F: 30F1:0B8F
;;   Called from:
;;     30F1:06BD (in PrepareScenarioUnitRosters_0006)
;;     30F1:072E (in PrepareScenarioUnitRosters_0006)
;;     30F1:07A9 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0831 (in PrepareScenarioUnitRosters_0006)
CompactScenarioLances_0B8F proc
30F1:0B8F 55              	push	bp
30F1:0B90 8B EC           	mov	bp,sp
30F1:0B92 83 EC 10        	sub	sp,10h
30F1:0B95 56              	push	si
30F1:0B96 57              	push	di
30F1:0B97 C7 46 F0 00 00  	mov	word ptr [bp-10h],0h
30F1:0B9C E9 35 02        	jmp	0DD4h

l30F1_0B9F:
30F1:0B9F 8B 7E F0        	mov	di,[bp-10h]
30F1:0BA2 D1 E7           	shl	di,1h
30F1:0BA4 D1 E7           	shl	di,1h
30F1:0BA6 8B F7           	mov	si,di
30F1:0BA8 C7 46 F4 00 00  	mov	word ptr [bp-0Ch],0h
30F1:0BAD C7 46 F6 00 00  	mov	word ptr [bp-0Ah],0h
30F1:0BB2 83 3E 81 B5 4F  	cmp	word ptr [0B581h],4Fh
30F1:0BB7 7C 1F           	jl	0BD8h

l30F1_0BB9:
30F1:0BB9 83 3E 81 B5 50  	cmp	word ptr [0B581h],50h
30F1:0BBE 7F 18           	jg	0BD8h

l30F1_0BC0:
30F1:0BC0 83 7E F0 00     	cmp	word ptr [bp-10h],0h
30F1:0BC4 75 07           	jnz	0BCDh

l30F1_0BC6:
30F1:0BC6 C7 46 F6 01 00  	mov	word ptr [bp-0Ah],1h
30F1:0BCB EB 0B           	jmp	0BD8h

l30F1_0BCD:
30F1:0BCD 83 7E F0 01     	cmp	word ptr [bp-10h],1h
30F1:0BD1 75 05           	jnz	0BD8h

l30F1_0BD3:
30F1:0BD3 C7 46 F4 04 00  	mov	word ptr [bp-0Ch],4h

l30F1_0BD8:
30F1:0BD8 C7 46 F2 00 00  	mov	word ptr [bp-0Eh],0h
30F1:0BDD E9 9E 01        	jmp	0D7Eh

l30F1_0BE0:
30F1:0BE0 8B C6           	mov	ax,si
30F1:0BE2 BA 96 00        	mov	dx,96h
30F1:0BE5 F7 E2           	mul	dx
30F1:0BE7 8B D8           	mov	bx,ax
30F1:0BE9 81 C3 81 8B     	add	bx,8B81h
30F1:0BED 1E              	push	ds
30F1:0BEE 07              	pop	es
30F1:0BEF 26 80 3F 00     	cmp	byte ptr es:[bx],0h
30F1:0BF3 75 03           	jnz	0BF8h

l30F1_0BF5:
30F1:0BF5 E9 1C 01        	jmp	0D14h

l30F1_0BF8:
30F1:0BF8 3B FE           	cmp	di,si
30F1:0BFA 75 03           	jnz	0BFFh

l30F1_0BFC:
30F1:0BFC E9 12 01        	jmp	0D11h

l30F1_0BFF:
30F1:0BFF 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
30F1:0C03 74 26           	jz	0C2Bh

l30F1_0C05:
30F1:0C05 8B C7           	mov	ax,di
30F1:0C07 BA 96 00        	mov	dx,96h
30F1:0C0A F7 E2           	mul	dx
30F1:0C0C 8B D8           	mov	bx,ax
30F1:0C0E 81 C3 E0 99     	add	bx,99E0h
30F1:0C12 1E              	push	ds
30F1:0C13 53              	push	bx
30F1:0C14 8B C6           	mov	ax,si
30F1:0C16 BA 96 00        	mov	dx,96h
30F1:0C19 F7 E2           	mul	dx
30F1:0C1B 8B D8           	mov	bx,ax
30F1:0C1D 81 C3 E0 99     	add	bx,99E0h
30F1:0C21 1E              	push	ds
30F1:0C22 53              	push	bx
30F1:0C23 B9 96 00        	mov	cx,96h
30F1:0C26 9A 4B 55 00 08  	call	far 0800h:554Bh

l30F1_0C2B:
30F1:0C2B 8B C7           	mov	ax,di
30F1:0C2D BA 96 00        	mov	dx,96h
30F1:0C30 F7 E2           	mul	dx
30F1:0C32 8B D8           	mov	bx,ax
30F1:0C34 81 C3 81 8B     	add	bx,8B81h
30F1:0C38 1E              	push	ds
30F1:0C39 53              	push	bx
30F1:0C3A 8B C6           	mov	ax,si
30F1:0C3C BA 96 00        	mov	dx,96h
30F1:0C3F F7 E2           	mul	dx
30F1:0C41 8B D8           	mov	bx,ax
30F1:0C43 81 C3 81 8B     	add	bx,8B81h
30F1:0C47 1E              	push	ds
30F1:0C48 53              	push	bx
30F1:0C49 B9 96 00        	mov	cx,96h
30F1:0C4C 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0C51 8B C7           	mov	ax,di
30F1:0C53 03 46 F4        	add	ax,[bp-0Ch]
30F1:0C56 BA 0A 00        	mov	dx,0Ah
30F1:0C59 F7 E2           	mul	dx
30F1:0C5B 8B D8           	mov	bx,ax
30F1:0C5D 81 C3 CA 1C     	add	bx,1CCAh
30F1:0C61 1E              	push	ds
30F1:0C62 07              	pop	es
30F1:0C63 8C 46 FA        	mov	[bp-6h],es
30F1:0C66 89 5E F8        	mov	[bp-8h],bx
30F1:0C69 8B C6           	mov	ax,si
30F1:0C6B 03 46 F4        	add	ax,[bp-0Ch]
30F1:0C6E BA 0A 00        	mov	dx,0Ah
30F1:0C71 F7 E2           	mul	dx
30F1:0C73 8B D8           	mov	bx,ax
30F1:0C75 81 C3 CA 1C     	add	bx,1CCAh
30F1:0C79 1E              	push	ds
30F1:0C7A 07              	pop	es
30F1:0C7B 8C 46 FE        	mov	[bp-2h],es
30F1:0C7E 89 5E FC        	mov	[bp-4h],bx
30F1:0C81 C4 5E FC        	les	bx,[bp-4h]
30F1:0C84 26 8A 47 06     	mov	al,es:[bx+6h]
30F1:0C88 C4 5E F8        	les	bx,[bp-8h]
30F1:0C8B 26 88 47 06     	mov	es:[bx+6h],al
30F1:0C8F C4 5E FC        	les	bx,[bp-4h]
30F1:0C92 26 8A 47 07     	mov	al,es:[bx+7h]
30F1:0C96 C4 5E F8        	les	bx,[bp-8h]
30F1:0C99 26 88 47 07     	mov	es:[bx+7h],al
30F1:0C9D C4 5E FC        	les	bx,[bp-4h]
30F1:0CA0 26 8A 47 09     	mov	al,es:[bx+9h]
30F1:0CA4 C4 5E F8        	les	bx,[bp-8h]
30F1:0CA7 26 88 47 09     	mov	es:[bx+9h],al
30F1:0CAB 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
30F1:0CAF 74 1C           	jz	0CCDh

l30F1_0CB1:
30F1:0CB1 8B C6           	mov	ax,si
30F1:0CB3 BA 96 00        	mov	dx,96h
30F1:0CB6 F7 E2           	mul	dx
30F1:0CB8 8B D8           	mov	bx,ax
30F1:0CBA 81 C3 E0 99     	add	bx,99E0h
30F1:0CBE 1E              	push	ds
30F1:0CBF 53              	push	bx
30F1:0CC0 BB B0 85        	mov	bx,85B0h
30F1:0CC3 1E              	push	ds
30F1:0CC4 53              	push	bx
30F1:0CC5 B9 96 00        	mov	cx,96h
30F1:0CC8 9A 4B 55 00 08  	call	far 0800h:554Bh

l30F1_0CCD:
30F1:0CCD 8B C6           	mov	ax,si
30F1:0CCF BA 96 00        	mov	dx,96h
30F1:0CD2 F7 E2           	mul	dx
30F1:0CD4 8B D8           	mov	bx,ax
30F1:0CD6 81 C3 81 8B     	add	bx,8B81h
30F1:0CDA 1E              	push	ds
30F1:0CDB 53              	push	bx
30F1:0CDC BB B0 85        	mov	bx,85B0h
30F1:0CDF 1E              	push	ds
30F1:0CE0 53              	push	bx
30F1:0CE1 B9 96 00        	mov	cx,96h
30F1:0CE4 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0CE9 8B C6           	mov	ax,si
30F1:0CEB 03 46 F4        	add	ax,[bp-0Ch]
30F1:0CEE BA 0A 00        	mov	dx,0Ah
30F1:0CF1 F7 E2           	mul	dx
30F1:0CF3 8B D8           	mov	bx,ax
30F1:0CF5 81 C3 CA 1C     	add	bx,1CCAh
30F1:0CF9 1E              	push	ds
30F1:0CFA 07              	pop	es
30F1:0CFB 8C 46 FA        	mov	[bp-6h],es
30F1:0CFE 89 5E F8        	mov	[bp-8h],bx
30F1:0D01 C4 5E F8        	les	bx,[bp-8h]
30F1:0D04 26 C6 47 07 FF  	mov	byte ptr es:[bx+7h],0FFh
30F1:0D09 C4 5E F8        	les	bx,[bp-8h]
30F1:0D0C 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_0D11:
30F1:0D11 47              	inc	di
30F1:0D12 EB 66           	jmp	0D7Ah

l30F1_0D14:
30F1:0D14 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
30F1:0D18 74 1C           	jz	0D36h

l30F1_0D1A:
30F1:0D1A 8B C6           	mov	ax,si
30F1:0D1C BA 96 00        	mov	dx,96h
30F1:0D1F F7 E2           	mul	dx
30F1:0D21 8B D8           	mov	bx,ax
30F1:0D23 81 C3 E0 99     	add	bx,99E0h
30F1:0D27 1E              	push	ds
30F1:0D28 53              	push	bx
30F1:0D29 BB B0 85        	mov	bx,85B0h
30F1:0D2C 1E              	push	ds
30F1:0D2D 53              	push	bx
30F1:0D2E B9 96 00        	mov	cx,96h
30F1:0D31 9A 4B 55 00 08  	call	far 0800h:554Bh

l30F1_0D36:
30F1:0D36 8B C6           	mov	ax,si
30F1:0D38 BA 96 00        	mov	dx,96h
30F1:0D3B F7 E2           	mul	dx
30F1:0D3D 8B D8           	mov	bx,ax
30F1:0D3F 81 C3 81 8B     	add	bx,8B81h
30F1:0D43 1E              	push	ds
30F1:0D44 53              	push	bx
30F1:0D45 BB B0 85        	mov	bx,85B0h
30F1:0D48 1E              	push	ds
30F1:0D49 53              	push	bx
30F1:0D4A B9 96 00        	mov	cx,96h
30F1:0D4D 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0D52 8B C6           	mov	ax,si
30F1:0D54 03 46 F4        	add	ax,[bp-0Ch]
30F1:0D57 BA 0A 00        	mov	dx,0Ah
30F1:0D5A F7 E2           	mul	dx
30F1:0D5C 8B D8           	mov	bx,ax
30F1:0D5E 81 C3 CA 1C     	add	bx,1CCAh
30F1:0D62 1E              	push	ds
30F1:0D63 07              	pop	es
30F1:0D64 8C 46 FA        	mov	[bp-6h],es
30F1:0D67 89 5E F8        	mov	[bp-8h],bx
30F1:0D6A C4 5E F8        	les	bx,[bp-8h]
30F1:0D6D 26 C6 47 07 FF  	mov	byte ptr es:[bx+7h],0FFh
30F1:0D72 C4 5E F8        	les	bx,[bp-8h]
30F1:0D75 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_0D7A:
30F1:0D7A 46              	inc	si
30F1:0D7B FF 46 F2        	inc	word ptr [bp-0Eh]

l30F1_0D7E:
30F1:0D7E 83 7E F2 04     	cmp	word ptr [bp-0Eh],4h
30F1:0D82 7D 03           	jge	0D87h

l30F1_0D84:
30F1:0D84 E9 59 FE        	jmp	0BE0h

l30F1_0D87:
30F1:0D87 8B 7E F0        	mov	di,[bp-10h]
30F1:0D8A D1 E7           	shl	di,1h
30F1:0D8C D1 E7           	shl	di,1h
30F1:0D8E C7 46 F2 00 00  	mov	word ptr [bp-0Eh],0h
30F1:0D93 EB 36           	jmp	0DCBh

l30F1_0D95:
30F1:0D95 8B C7           	mov	ax,di
30F1:0D97 03 46 F4        	add	ax,[bp-0Ch]
30F1:0D9A BA 0A 00        	mov	dx,0Ah
30F1:0D9D F7 E2           	mul	dx
30F1:0D9F 8B D8           	mov	bx,ax
30F1:0DA1 81 C3 CA 1C     	add	bx,1CCAh
30F1:0DA5 1E              	push	ds
30F1:0DA6 07              	pop	es
30F1:0DA7 8C 46 FA        	mov	[bp-6h],es
30F1:0DAA 89 5E F8        	mov	[bp-8h],bx
30F1:0DAD C4 5E F8        	les	bx,[bp-8h]
30F1:0DB0 26 80 7F 09 FF  	cmp	byte ptr es:[bx+9h],0FFh
30F1:0DB5 75 10           	jnz	0DC7h

l30F1_0DB7:
30F1:0DB7 C4 5E F8        	les	bx,[bp-8h]
30F1:0DBA 26 C6 47 06 00  	mov	byte ptr es:[bx+6h],0h
30F1:0DBF C4 5E F8        	les	bx,[bp-8h]
30F1:0DC2 26 C6 47 08 FF  	mov	byte ptr es:[bx+8h],0FFh

l30F1_0DC7:
30F1:0DC7 47              	inc	di
30F1:0DC8 FF 46 F2        	inc	word ptr [bp-0Eh]

l30F1_0DCB:
30F1:0DCB 83 7E F2 04     	cmp	word ptr [bp-0Eh],4h
30F1:0DCF 7C C4           	jl	0D95h

l30F1_0DD1:
30F1:0DD1 FF 46 F0        	inc	word ptr [bp-10h]

l30F1_0DD4:
30F1:0DD4 83 7E F0 02     	cmp	word ptr [bp-10h],2h
30F1:0DD8 7D 03           	jge	0DDDh

l30F1_0DDA:
30F1:0DDA E9 C2 FD        	jmp	0B9Fh

l30F1_0DDD:
30F1:0DDD 5F              	pop	di
30F1:0DDE 5E              	pop	si
30F1:0DDF 8B E5           	mov	sp,bp
30F1:0DE1 5D              	pop	bp
30F1:0DE2 CB              	retf
30F1:0DE3          56 83 3E D6 24 10 7C 68 83 3E D6 24 11    V.>.$.|h.>.$.
30F1:0DF0 7F 61 33 F6 EB 56 8B C6 05 10 00 BA 96 00 F7 E2 .a3..V..........
30F1:0E00 8B D8 81 C3 E0 99 1E 53 8B C6 BA 96 00 F7 E2 8B .......S........
30F1:0E10 D8 81 C3 E0 99 1E 53 B9 96 00 9A 4B 55 00 08 8B ......S....KU...
30F1:0E20 C6 05 14 00 BA 96 00 F7 E2 8B D8 81 C3 E0 99 1E ................
30F1:0E30 53 8B C6 05 08 00 BA 96 00 F7 E2 8B D8 81 C3 E0 S...............
30F1:0E40 99 1E 53 B9 96 00 9A 4B 55 00 08 46 83 FE 04 7C ..S....KU..F...|
30F1:0E50 A5 EB 41 83 3E D6 24 12 7C 3A 83 3E D6 24 14 7F ..A.>.$.|:.>.$..
30F1:0E60 33 33 F6 EB 2A 8B C6 05 10 00 BA 96 00 F7 E2 8B 33..*...........
30F1:0E70 D8 81 C3 E0 99 1E 53 8B C6 BA 96 00 F7 E2 8B D8 ......S.........
30F1:0E80 81 C3 E0 99 1E 53 B9 96 00 9A 4B 55 00 08 46 83 .....S....KU..F.
30F1:0E90 FE 08 7C D1 5E CB                               ..|.^.          

;; PromoteReserveUnitsForCampaignStage_0E96: 30F1:0E96
;;   Called from:
;;     0D73:296B (in RunInGameMenu_274D)
PromoteReserveUnitsForCampaignStage_0E96 proc
30F1:0E96 56              	push	si
30F1:0E97 83 3E D6 24 10  	cmp	word ptr [24D6h],10h
30F1:0E9C 7D 03           	jge	0EA1h

l30F1_0E9E:
30F1:0E9E E9 4E 01        	jmp	0FEFh

l30F1_0EA1:
30F1:0EA1 83 3E D6 24 11  	cmp	word ptr [24D6h],11h
30F1:0EA6 7E 03           	jle	0EABh

l30F1_0EA8:
30F1:0EA8 E9 44 01        	jmp	0FEFh

l30F1_0EAB:
30F1:0EAB 33 F6           	xor	si,si
30F1:0EAD E9 34 01        	jmp	0FE4h

l30F1_0EB0:
30F1:0EB0 8B C6           	mov	ax,si
30F1:0EB2 BA 96 00        	mov	dx,96h
30F1:0EB5 F7 E2           	mul	dx
30F1:0EB7 8B D8           	mov	bx,ax
30F1:0EB9 81 C3 E0 99     	add	bx,99E0h
30F1:0EBD 1E              	push	ds
30F1:0EBE 53              	push	bx
30F1:0EBF 8B C6           	mov	ax,si
30F1:0EC1 05 10 00        	add	ax,10h
30F1:0EC4 BA 96 00        	mov	dx,96h
30F1:0EC7 F7 E2           	mul	dx
30F1:0EC9 8B D8           	mov	bx,ax
30F1:0ECB 81 C3 E0 99     	add	bx,99E0h
30F1:0ECF 1E              	push	ds
30F1:0ED0 53              	push	bx
30F1:0ED1 B9 96 00        	mov	cx,96h
30F1:0ED4 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0ED9 8B C6           	mov	ax,si
30F1:0EDB BA 96 00        	mov	dx,96h
30F1:0EDE F7 E2           	mul	dx
30F1:0EE0 8B D8           	mov	bx,ax
30F1:0EE2 81 C3 E0 99     	add	bx,99E0h
30F1:0EE6 1E              	push	ds
30F1:0EE7 07              	pop	es
30F1:0EE8 26 80 BF 84 00 00 	cmp	byte ptr es:[bx+84h],0h
30F1:0EEE 74 3E           	jz	0F2Eh

l30F1_0EF0:
30F1:0EF0 8B C6           	mov	ax,si
30F1:0EF2 BA 96 00        	mov	dx,96h
30F1:0EF5 F7 E2           	mul	dx
30F1:0EF7 8B D8           	mov	bx,ax
30F1:0EF9 81 C3 E0 99     	add	bx,99E0h
30F1:0EFD 1E              	push	ds
30F1:0EFE 07              	pop	es
30F1:0EFF 26 8A 87 92 00  	mov	al,es:[bx+92h]
30F1:0F04 98              	cbw
30F1:0F05 8B D8           	mov	bx,ax
30F1:0F07 D1 E3           	shl	bx,1h
30F1:0F09 D1 E3           	shl	bx,1h
30F1:0F0B 81 C3 4C 1D     	add	bx,1D4Ch
30F1:0F0F 1E              	push	ds
30F1:0F10 07              	pop	es
30F1:0F11 26 80 7F 03 00  	cmp	byte ptr es:[bx+3h],0h
30F1:0F16 75 14           	jnz	0F2Ch

l30F1_0F18:
30F1:0F18 8B C6           	mov	ax,si
30F1:0F1A BA 0A 00        	mov	dx,0Ah
30F1:0F1D F7 E2           	mul	dx
30F1:0F1F 8B D8           	mov	bx,ax
30F1:0F21 81 C3 CA 1C     	add	bx,1CCAh
30F1:0F25 1E              	push	ds
30F1:0F26 07              	pop	es
30F1:0F27 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_0F2C:
30F1:0F2C EB 14           	jmp	0F42h

l30F1_0F2E:
30F1:0F2E 8B C6           	mov	ax,si
30F1:0F30 BA 0A 00        	mov	dx,0Ah
30F1:0F33 F7 E2           	mul	dx
30F1:0F35 8B D8           	mov	bx,ax
30F1:0F37 81 C3 CA 1C     	add	bx,1CCAh
30F1:0F3B 1E              	push	ds
30F1:0F3C 07              	pop	es
30F1:0F3D 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_0F42:
30F1:0F42 8B C6           	mov	ax,si
30F1:0F44 05 08 00        	add	ax,8h
30F1:0F47 BA 96 00        	mov	dx,96h
30F1:0F4A F7 E2           	mul	dx
30F1:0F4C 8B D8           	mov	bx,ax
30F1:0F4E 81 C3 E0 99     	add	bx,99E0h
30F1:0F52 1E              	push	ds
30F1:0F53 53              	push	bx
30F1:0F54 8B C6           	mov	ax,si
30F1:0F56 05 14 00        	add	ax,14h
30F1:0F59 BA 96 00        	mov	dx,96h
30F1:0F5C F7 E2           	mul	dx
30F1:0F5E 8B D8           	mov	bx,ax
30F1:0F60 81 C3 E0 99     	add	bx,99E0h
30F1:0F64 1E              	push	ds
30F1:0F65 53              	push	bx
30F1:0F66 B9 96 00        	mov	cx,96h
30F1:0F69 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:0F6E 8B C6           	mov	ax,si
30F1:0F70 05 08 00        	add	ax,8h
30F1:0F73 BA 96 00        	mov	dx,96h
30F1:0F76 F7 E2           	mul	dx
30F1:0F78 8B D8           	mov	bx,ax
30F1:0F7A 81 C3 E0 99     	add	bx,99E0h
30F1:0F7E 1E              	push	ds
30F1:0F7F 07              	pop	es
30F1:0F80 26 80 BF 84 00 00 	cmp	byte ptr es:[bx+84h],0h
30F1:0F86 74 44           	jz	0FCCh

l30F1_0F88:
30F1:0F88 8B C6           	mov	ax,si
30F1:0F8A 05 08 00        	add	ax,8h
30F1:0F8D BA 96 00        	mov	dx,96h
30F1:0F90 F7 E2           	mul	dx
30F1:0F92 8B D8           	mov	bx,ax
30F1:0F94 81 C3 E0 99     	add	bx,99E0h
30F1:0F98 1E              	push	ds
30F1:0F99 07              	pop	es
30F1:0F9A 26 8A 87 92 00  	mov	al,es:[bx+92h]
30F1:0F9F 98              	cbw
30F1:0FA0 8B D8           	mov	bx,ax
30F1:0FA2 D1 E3           	shl	bx,1h
30F1:0FA4 D1 E3           	shl	bx,1h
30F1:0FA6 81 C3 4C 1D     	add	bx,1D4Ch
30F1:0FAA 1E              	push	ds
30F1:0FAB 07              	pop	es
30F1:0FAC 26 80 7F 03 00  	cmp	byte ptr es:[bx+3h],0h
30F1:0FB1 75 17           	jnz	0FCAh

l30F1_0FB3:
30F1:0FB3 8B C6           	mov	ax,si
30F1:0FB5 05 08 00        	add	ax,8h
30F1:0FB8 BA 0A 00        	mov	dx,0Ah
30F1:0FBB F7 E2           	mul	dx
30F1:0FBD 8B D8           	mov	bx,ax
30F1:0FBF 81 C3 CA 1C     	add	bx,1CCAh
30F1:0FC3 1E              	push	ds
30F1:0FC4 07              	pop	es
30F1:0FC5 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_0FCA:
30F1:0FCA EB 17           	jmp	0FE3h

l30F1_0FCC:
30F1:0FCC 8B C6           	mov	ax,si
30F1:0FCE 05 08 00        	add	ax,8h
30F1:0FD1 BA 0A 00        	mov	dx,0Ah
30F1:0FD4 F7 E2           	mul	dx
30F1:0FD6 8B D8           	mov	bx,ax
30F1:0FD8 81 C3 CA 1C     	add	bx,1CCAh
30F1:0FDC 1E              	push	ds
30F1:0FDD 07              	pop	es
30F1:0FDE 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_0FE3:
30F1:0FE3 46              	inc	si

l30F1_0FE4:
30F1:0FE4 83 FE 04        	cmp	si,4h
30F1:0FE7 7D 03           	jge	0FECh

l30F1_0FE9:
30F1:0FE9 E9 C4 FE        	jmp	0EB0h

l30F1_0FEC:
30F1:0FEC E9 B4 00        	jmp	10A3h

l30F1_0FEF:
30F1:0FEF 83 3E D6 24 12  	cmp	word ptr [24D6h],12h
30F1:0FF4 7D 03           	jge	0FF9h

l30F1_0FF6:
30F1:0FF6 E9 AA 00        	jmp	10A3h

l30F1_0FF9:
30F1:0FF9 83 3E D6 24 14  	cmp	word ptr [24D6h],14h
30F1:0FFE 7E 03           	jle	1003h

l30F1_1000:
30F1:1000 E9 A0 00        	jmp	10A3h

l30F1_1003:
30F1:1003 33 F6           	xor	si,si
30F1:1005 E9 93 00        	jmp	109Bh

l30F1_1008:
30F1:1008 8B C6           	mov	ax,si
30F1:100A BA 96 00        	mov	dx,96h
30F1:100D F7 E2           	mul	dx
30F1:100F 8B D8           	mov	bx,ax
30F1:1011 81 C3 E0 99     	add	bx,99E0h
30F1:1015 1E              	push	ds
30F1:1016 53              	push	bx
30F1:1017 8B C6           	mov	ax,si
30F1:1019 05 10 00        	add	ax,10h
30F1:101C BA 96 00        	mov	dx,96h
30F1:101F F7 E2           	mul	dx
30F1:1021 8B D8           	mov	bx,ax
30F1:1023 81 C3 E0 99     	add	bx,99E0h
30F1:1027 1E              	push	ds
30F1:1028 53              	push	bx
30F1:1029 B9 96 00        	mov	cx,96h
30F1:102C 9A 4B 55 00 08  	call	far 0800h:554Bh
30F1:1031 8B C6           	mov	ax,si
30F1:1033 BA 96 00        	mov	dx,96h
30F1:1036 F7 E2           	mul	dx
30F1:1038 8B D8           	mov	bx,ax
30F1:103A 81 C3 E0 99     	add	bx,99E0h
30F1:103E 1E              	push	ds
30F1:103F 07              	pop	es
30F1:1040 26 80 BF 84 00 00 	cmp	byte ptr es:[bx+84h],0h
30F1:1046 74 3E           	jz	1086h

l30F1_1048:
30F1:1048 8B C6           	mov	ax,si
30F1:104A BA 96 00        	mov	dx,96h
30F1:104D F7 E2           	mul	dx
30F1:104F 8B D8           	mov	bx,ax
30F1:1051 81 C3 E0 99     	add	bx,99E0h
30F1:1055 1E              	push	ds
30F1:1056 07              	pop	es
30F1:1057 26 8A 87 92 00  	mov	al,es:[bx+92h]
30F1:105C 98              	cbw
30F1:105D 8B D8           	mov	bx,ax
30F1:105F D1 E3           	shl	bx,1h
30F1:1061 D1 E3           	shl	bx,1h
30F1:1063 81 C3 4C 1D     	add	bx,1D4Ch
30F1:1067 1E              	push	ds
30F1:1068 07              	pop	es
30F1:1069 26 80 7F 03 00  	cmp	byte ptr es:[bx+3h],0h
30F1:106E 75 14           	jnz	1084h

l30F1_1070:
30F1:1070 8B C6           	mov	ax,si
30F1:1072 BA 0A 00        	mov	dx,0Ah
30F1:1075 F7 E2           	mul	dx
30F1:1077 8B D8           	mov	bx,ax
30F1:1079 81 C3 CA 1C     	add	bx,1CCAh
30F1:107D 1E              	push	ds
30F1:107E 07              	pop	es
30F1:107F 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_1084:
30F1:1084 EB 14           	jmp	109Ah

l30F1_1086:
30F1:1086 8B C6           	mov	ax,si
30F1:1088 BA 0A 00        	mov	dx,0Ah
30F1:108B F7 E2           	mul	dx
30F1:108D 8B D8           	mov	bx,ax
30F1:108F 81 C3 CA 1C     	add	bx,1CCAh
30F1:1093 1E              	push	ds
30F1:1094 07              	pop	es
30F1:1095 26 C6 47 09 FF  	mov	byte ptr es:[bx+9h],0FFh

l30F1_109A:
30F1:109A 46              	inc	si

l30F1_109B:
30F1:109B 83 FE 08        	cmp	si,8h
30F1:109E 7D 03           	jge	10A3h
