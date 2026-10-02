;;; Segment 3A07 (3A07:0000)
3A07:0000 CB                                              .               

;; ConvertLocalDateTimeToEpochSeconds_0001: 3A07:0001
;;   Called from:
;;     39CC:00B6 (in CaptureLocalClockSnapshot_000F)
ConvertLocalDateTimeToEpochSeconds_0001 proc
3A07:0001 55              	push	bp
3A07:0002 8B EC           	mov	bp,sp
3A07:0004 83 EC 06        	sub	sp,6h
3A07:0007 56              	push	si
3A07:0008 57              	push	di
3A07:0009 9A 08 00 3C 3A  	call	far 3A3Ch:0008h
3A07:000E 8B 16 92 71     	mov	dx,[7192h]
3A07:0012 A1 90 71        	mov	ax,[7190h]
3A07:0015 05 00 A6        	add	ax,0A600h
3A07:0018 81 D2 CE 12     	adc	dx,12CEh
3A07:001C 89 56 FC        	mov	[bp-4h],dx
3A07:001F 89 46 FA        	mov	[bp-6h],ax
3A07:0022 C4 5E 06        	les	bx,[bp+6h]
3A07:0025 26 8B 37        	mov	si,es:[bx]
3A07:0028 81 C6 44 F8     	add	si,0F844h
3A07:002C 8B C6           	mov	ax,si
3A07:002E D1 F8           	sar	ax,1h
3A07:0030 D1 F8           	sar	ax,1h
3A07:0032 99              	cwd
3A07:0033 B9 86 07        	mov	cx,786h
3A07:0036 BB 80 1F        	mov	bx,1F80h
3A07:0039 9A 2C 54 00 08  	call	far 0800h:542Ch
3A07:003E 01 46 FA        	add	[bp-6h],ax
3A07:0041 11 56 FC        	adc	[bp-4h],dx
3A07:0044 8B C6           	mov	ax,si
3A07:0046 25 03 00        	and	ax,3h
3A07:0049 99              	cwd
3A07:004A B9 E1 01        	mov	cx,1E1h
3A07:004D BB 80 33        	mov	bx,3380h
3A07:0050 9A 2C 54 00 08  	call	far 0800h:542Ch
3A07:0055 01 46 FA        	add	[bp-6h],ax
3A07:0058 11 56 FC        	adc	[bp-4h],dx
3A07:005B F7 C6 03 00     	test	si,3h
3A07:005F 74 09           	jz	006Ah

l3A07_0061:
3A07:0061 81 46 FA 80 51  	add	word ptr [bp-6h],5180h
3A07:0066 83 56 FC 01     	adc	word ptr [bp-4h],1h

l3A07_006A:
3A07:006A 33 FF           	xor	di,di
3A07:006C C4 5E 06        	les	bx,[bp+6h]
3A07:006F 26 8A 47 03     	mov	al,es:[bx+3h]
3A07:0073 98              	cbw
3A07:0074 8B F0           	mov	si,ax
3A07:0076 4E              	dec	si
3A07:0077 EB 08           	jmp	0081h

l3A07_0079:
3A07:0079 4E              	dec	si
3A07:007A 8A 84 56 71     	mov	al,[si+7156h]
3A07:007E 98              	cbw
3A07:007F 03 F8           	add	di,ax

l3A07_0081:
3A07:0081 0B F6           	or	si,si
3A07:0083 7F F4           	jg	0079h

l3A07_0085:
3A07:0085 C4 5E 06        	les	bx,[bp+6h]
3A07:0088 26 8A 47 02     	mov	al,es:[bx+2h]
3A07:008C 98              	cbw
3A07:008D 48              	dec	ax
3A07:008E 03 F8           	add	di,ax
3A07:0090 C4 5E 06        	les	bx,[bp+6h]
3A07:0093 26 80 7F 03 02  	cmp	byte ptr es:[bx+3h],2h
3A07:0098 7E 0B           	jle	00A5h

l3A07_009A:
3A07:009A C4 5E 06        	les	bx,[bp+6h]
3A07:009D 26 F7 07 03 00  	test	word ptr es:[bx],3h
3A07:00A2 75 01           	jnz	00A5h

l3A07_00A4:
3A07:00A4 47              	inc	di

l3A07_00A5:
3A07:00A5 8B C7           	mov	ax,di
3A07:00A7 BA 18 00        	mov	dx,18h
3A07:00AA F7 E2           	mul	dx
3A07:00AC C4 5E 0A        	les	bx,[bp+0Ah]
3A07:00AF 26 8A 57 01     	mov	dl,es:[bx+1h]
3A07:00B3 B6 00           	mov	dh,0h
3A07:00B5 03 C2           	add	ax,dx
3A07:00B7 89 46 FE        	mov	[bp-2h],ax
3A07:00BA 83 3E 94 71 00  	cmp	word ptr [7194h],0h
3A07:00BF 74 24           	jz	00E5h

l3A07_00C1:
3A07:00C1 C4 5E 0A        	les	bx,[bp+0Ah]
3A07:00C4 26 8A 47 01     	mov	al,es:[bx+1h]
3A07:00C8 B4 00           	mov	ah,0h
3A07:00CA 50              	push	ax
3A07:00CB 57              	push	di
3A07:00CC 33 C0           	xor	ax,ax
3A07:00CE 50              	push	ax
3A07:00CF C4 5E 06        	les	bx,[bp+6h]
3A07:00D2 26 8B 07        	mov	ax,es:[bx]
3A07:00D5 05 4E F8        	add	ax,0F84Eh
3A07:00D8 50              	push	ax
3A07:00D9 9A ED 01 3C 3A  	call	far 3A3Ch:01EDh
3A07:00DE 0B C0           	or	ax,ax
3A07:00E0 74 03           	jz	00E5h

l3A07_00E2:
3A07:00E2 FF 4E FE        	dec	word ptr [bp-2h]

l3A07_00E5:
3A07:00E5 8B 46 FE        	mov	ax,[bp-2h]
3A07:00E8 99              	cwd
3A07:00E9 33 C9           	xor	cx,cx
3A07:00EB BB 10 0E        	mov	bx,0E10h
3A07:00EE 9A 2C 54 00 08  	call	far 0800h:542Ch
3A07:00F3 01 46 FA        	add	[bp-6h],ax
3A07:00F6 11 56 FC        	adc	[bp-4h],dx
3A07:00F9 C4 5E 0A        	les	bx,[bp+0Ah]
3A07:00FC 26 8A 07        	mov	al,es:[bx]
3A07:00FF B4 00           	mov	ah,0h
3A07:0101 99              	cwd
3A07:0102 33 C9           	xor	cx,cx
3A07:0104 BB 3C 00        	mov	bx,3Ch
3A07:0107 9A 2C 54 00 08  	call	far 0800h:542Ch
3A07:010C C4 5E 0A        	les	bx,[bp+0Ah]
3A07:010F 26 8A 5F 03     	mov	bl,es:[bx+3h]
3A07:0113 B7 00           	mov	bh,0h
3A07:0115 52              	push	dx
3A07:0116 50              	push	ax
3A07:0117 8B C3           	mov	ax,bx
3A07:0119 99              	cwd
3A07:011A 5B              	pop	bx
3A07:011B 59              	pop	cx
3A07:011C 03 D8           	add	bx,ax
3A07:011E 13 CA           	adc	cx,dx
3A07:0120 01 5E FA        	add	[bp-6h],bx
3A07:0123 11 4E FC        	adc	[bp-4h],cx
3A07:0126 8B 56 FC        	mov	dx,[bp-4h]
3A07:0129 8B 46 FA        	mov	ax,[bp-6h]
3A07:012C EB 00           	jmp	012Eh

l3A07_012E:
3A07:012E 5F              	pop	di
3A07:012F 5E              	pop	si
3A07:0130 8B E5           	mov	sp,bp
3A07:0132 5D              	pop	bp
3A07:0133 CB              	retf
3A07:0134             55 8B EC 9A 08 00 3C 3A 8B 16 92 71     U.....<:...q
3A07:0140 A1 90 71 05 00 A6 81 D2 CE 12 29 46 06 19 56 08 ..q.......)F..V.
3A07:0150 C4 5E 0E 26 C6 47 02 00 33 D2 B8 3C 00 52 50 FF .^.&.G..3..<.RP.
3A07:0160 76 08 FF 76 06 9A 4E 54 00 08 C4 5E 0E 26 88 47 v..v..NT...^.&.G
3A07:0170 03 33 D2 B8 3C 00 52 50 FF 76 08 FF 76 06 9A 45 .3..<.RP.v..v..E
3A07:0180 54 00 08 89 56 08 89 46 06 33 D2 B8 3C 00 52 50 T...V..F.3..<.RP
3A07:0190 FF 76 08 FF 76 06 9A 4E 54 00 08 C4 5E 0E 26 88 .v..v..NT...^.&.
3A07:01A0 07 33 D2 B8 3C 00 52 50 FF 76 08 FF 76 06 9A 45 .3..<.RP.v..v..E
3A07:01B0 54 00 08 89 56 08 89 46 06 33 D2 B8 F8 88 52 50 T...V..F.3....RP
3A07:01C0 FF 76 08 FF 76 06 9A 45 54 00 08 D1 E0 D1 E0 05 .v..v..ET.......
3A07:01D0 BC 07 C4 5E 0A 26 89 07 33 D2 B8 F8 88 52 50 FF ...^.&..3....RP.
3A07:01E0 76 08 FF 76 06 9A 4E 54 00 08 89 56 08 89 46 06 v..v..NT...V..F.
3A07:01F0 83 7E 08 00 7C 48 7F 07 81 7E 06 50 22 76 3F 81 .~..|H...~.P"v?.
3A07:0200 6E 06 50 22 83 5E 08 00 C4 5E 0A 26 FF 07 33 D2 n.P".^...^.&..3.
3A07:0210 B8 38 22 52 50 FF 76 08 FF 76 06 9A 45 54 00 08 .8"RP.v..v..ET..
3A07:0220 C4 5E 0A 26 01 07 33 D2 B8 38 22 52 50 FF 76 08 .^.&..3..8"RP.v.
3A07:0230 FF 76 06 9A 4E 54 00 08 89 56 08 89 46 06 83 3E .v..NT...V..F..>
3A07:0240 94 71 00 74 44 33 D2 B8 18 00 52 50 FF 76 08 FF .q.tD3....RP.v..
3A07:0250 76 06 9A 4E 54 00 08 50 33 D2 B8 18 00 52 50 FF v..NT..P3....RP.
3A07:0260 76 08 FF 76 06 9A 45 54 00 08 50 33 C0 50 C4 5E v..v..ET..P3.P.^
3A07:0270 0A 26 8B 07 05 4E F8 50 9A ED 01 3C 3A 0B C0 74 .&...N.P...<:..t
3A07:0280 08 83 46 06 01 83 56 08 00 33 D2 B8 18 00 52 50 ..F...V..3....RP
3A07:0290 FF 76 08 FF 76 06 9A 4E 54 00 08 C4 5E 0E 26 88 .v..v..NT...^.&.
3A07:02A0 47 01 33 D2 B8 18 00 52 50 FF 76 08 FF 76 06 9A G.3....RP.v..v..
3A07:02B0 45 54 00 08 89 56 08 89 46 06 83 46 06 01 83 56 ET...V..F..F...V
3A07:02C0 08 00 C4 5E 0A 26 F7 07 03 00 75 36 83 7E 08 00 ...^.&....u6.~..
3A07:02D0 7C 12 7F 06 83 7E 06 3C 76 0A 83 6E 06 01 83 5E |....~.<v..n...^
3A07:02E0 08 00 EB 1E 83 7E 08 00 75 18 83 7E 06 3C 75 12 .....~..u..~.<u.
3A07:02F0 C4 5E 0A 26 C6 47 03 02 C4 5E 0A 26 C6 47 02 1D .^.&.G...^.&.G..
3A07:0300 EB 54 C4 5E 0A 26 C6 47 03 00 EB 1D C4 5E 0A 26 .T.^.&.G.....^.&
3A07:0310 8A 47 03 98 8B D8 8A 87 56 71 98 99 29 46 06 19 .G......Vq..)F..
3A07:0320 56 08 C4 5E 0A 26 FE 47 03 C4 5E 0A 26 8A 47 03 V..^.&.G..^.&.G.
3A07:0330 98 8B D8 8A 87 56 71 98 99 3B 56 08 7C CE 75 05 .....Vq..;V.|.u.
3A07:0340 3B 46 06 72 C7 C4 5E 0A 26 FE 47 03 8A 46 06 C4 ;F.r..^.&.G..F..
