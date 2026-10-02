;;; Segment 34B8 (34B8:0000)
34B8:0000 44 02 90 33 59 5E 8B E5 5D CB                   D..3Y^..].      

;; CalibrateVideoTiming_000A: 34B8:000A
;;   Called from:
;;     2C7F:0195 (in InitializeGame_003C)
CalibrateVideoTiming_000A proc
34B8:000A 55              	push	bp
34B8:000B 8B EC           	mov	bp,sp
34B8:000D 83 EC 0E        	sub	sp,0Eh
34B8:0010 56              	push	si
34B8:0011 57              	push	di
34B8:0012 C7 46 F4 00 00  	mov	word ptr [bp-0Ch],0h
34B8:0017 C7 46 F2 6C 04  	mov	word ptr [bp-0Eh],46Ch
34B8:001C 33 F6           	xor	si,si
34B8:001E 89 36 EE 7F     	mov	[7FEEh],si
34B8:0022 9A F6 34 00 08  	call	far 0800h:34F6h
34B8:0027 C4 5E F2        	les	bx,[bp-0Eh]
34B8:002A 26 8B 57 02     	mov	dx,es:[bx+2h]
34B8:002E 26 8B 07        	mov	ax,es:[bx]
34B8:0031 89 56 F8        	mov	[bp-8h],dx
34B8:0034 89 46 F6        	mov	[bp-0Ah],ax
34B8:0037 9A F4 34 00 08  	call	far 0800h:34F4h
34B8:003C EB 00           	jmp	003Eh

l34B8_003E:
34B8:003E C4 5E F2        	les	bx,[bp-0Eh]
34B8:0041 26 8B 57 02     	mov	dx,es:[bx+2h]
34B8:0045 26 8B 07        	mov	ax,es:[bx]
34B8:0048 3B 56 F8        	cmp	dx,[bp-8h]
34B8:004B 75 05           	jnz	0052h

l34B8_004D:
34B8:004D 3B 46 F6        	cmp	ax,[bp-0Ah]
34B8:0050 74 EC           	jz	003Eh

l34B8_0052:
34B8:0052 9A F6 34 00 08  	call	far 0800h:34F6h
34B8:0057 C4 5E F2        	les	bx,[bp-0Eh]
34B8:005A 26 8B 57 02     	mov	dx,es:[bx+2h]
34B8:005E 26 8B 07        	mov	ax,es:[bx]
34B8:0061 05 04 00        	add	ax,4h
34B8:0064 83 D2 00        	adc	dx,0h
34B8:0067 89 56 F8        	mov	[bp-8h],dx
34B8:006A 89 46 F6        	mov	[bp-0Ah],ax
34B8:006D 9A F4 34 00 08  	call	far 0800h:34F4h
34B8:0072 EB 0B           	jmp	007Fh

l34B8_0074:
34B8:0074 46              	inc	si
34B8:0075 BF C8 00        	mov	di,0C8h
34B8:0078 EB 01           	jmp	007Bh

l34B8_007A:
34B8:007A 4F              	dec	di

l34B8_007B:
34B8:007B 0B FF           	or	di,di
34B8:007D 75 FB           	jnz	007Ah

l34B8_007F:
34B8:007F C4 5E F2        	les	bx,[bp-0Eh]
34B8:0082 26 8B 57 02     	mov	dx,es:[bx+2h]
34B8:0086 26 8B 07        	mov	ax,es:[bx]
34B8:0089 3B 56 F8        	cmp	dx,[bp-8h]
34B8:008C 72 E6           	jc	0074h

l34B8_008E:
34B8:008E 75 05           	jnz	0095h

l34B8_0090:
34B8:0090 3B 46 F6        	cmp	ax,[bp-0Ah]
34B8:0093 72 DF           	jc	0074h

l34B8_0095:
34B8:0095 8B C6           	mov	ax,si
34B8:0097 05 70 FE        	add	ax,0FE70h
34B8:009A A3 50 B6        	mov	[0B650h],ax
34B8:009D 83 3E 50 B6 00  	cmp	word ptr [0B650h],0h
34B8:00A2 7D 06           	jge	00AAh

l34B8_00A4:
34B8:00A4 C7 06 50 B6 00 00 	mov	word ptr [0B650h],0h

l34B8_00AA:
34B8:00AA 33 C0           	xor	ax,ax
34B8:00AC 89 46 FC        	mov	[bp-4h],ax
34B8:00AF 89 46 FA        	mov	[bp-6h],ax
34B8:00B2 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
34B8:00B7 EB 14           	jmp	00CDh

l34B8_00B9:
34B8:00B9 9A AA 4E 00 08  	call	far 0800h:4EAAh
34B8:00BE 0B C0           	or	ax,ax
34B8:00C0 74 05           	jz	00C7h

l34B8_00C2:
34B8:00C2 FF 46 FC        	inc	word ptr [bp-4h]
34B8:00C5 EB 03           	jmp	00CAh

l34B8_00C7:
34B8:00C7 FF 46 FA        	inc	word ptr [bp-6h]

l34B8_00CA:
34B8:00CA FF 46 FE        	inc	word ptr [bp-2h]

l34B8_00CD:
34B8:00CD 81 7E FE 10 27  	cmp	word ptr [bp-2h],2710h
34B8:00D2 7C E5           	jl	00B9h

l34B8_00D4:
34B8:00D4 8B 46 FC        	mov	ax,[bp-4h]
34B8:00D7 3B 46 FA        	cmp	ax,[bp-6h]
34B8:00DA 7E 06           	jle	00E2h

l34B8_00DC:
34B8:00DC C7 06 EE 7F 01 00 	mov	word ptr [7FEEh],1h
