;;; Segment 2FEA (2FEA:0000)
2FEA:0000 03                                              .               

l2D1B_2CF1:
2D1B:2CF1 BE 01 00        	mov	si,1h

l2D1B_2CF4:
2D1B:2CF4 8B C6           	mov	ax,si
2D1B:2CF6 EB 00           	jmp	2CF8h

l2D1B_2CF8:
2D1B:2CF8 5E              	pop	si
2D1B:2CF9 CB              	retf

;; BuildPlanarDisplayBackingBuffer_000A: 2FEA:000A
;;   Called from:
;;     0D73:54EE (in BuildDisplayBackingBuffer_54B9)
BuildPlanarDisplayBackingBuffer_000A proc
2FEA:000A 55              	push	bp
2FEA:000B 8B EC           	mov	bp,sp
2FEA:000D 83 EC 0A        	sub	sp,0Ah
2FEA:0010 56              	push	si
2FEA:0011 57              	push	di
2FEA:0012 8B 7E 0C        	mov	di,[bp+0Ch]
2FEA:0015 8B 76 08        	mov	si,[bp+8h]
2FEA:0018 8B 46 0A        	mov	ax,[bp+0Ah]
2FEA:001B F7 E7           	mul	di
2FEA:001D D1 E0           	shl	ax,1h
2FEA:001F D1 E0           	shl	ax,1h
2FEA:0021 89 46 FA        	mov	[bp-6h],ax
2FEA:0024 83 3E CE B6 02  	cmp	word ptr [0B6CEh],2h
2FEA:0029 75 03           	jnz	002Eh

l2FEA_002B:
2FEA:002B E9 DB 00        	jmp	0109h

l2FEA_002E:
2FEA:002E 8B 46 FA        	mov	ax,[bp-6h]
2FEA:0031 05 04 00        	add	ax,4h
2FEA:0034 33 D2           	xor	dx,dx
2FEA:0036 52              	push	dx
2FEA:0037 50              	push	ax
2FEA:0038 9A B5 00 56 0D  	call	far 0D56h:00B5h
2FEA:003D 59              	pop	cx
2FEA:003E 59              	pop	cx
2FEA:003F 89 56 FE        	mov	[bp-2h],dx
2FEA:0042 89 46 FC        	mov	[bp-4h],ax
2FEA:0045 8B 46 FC        	mov	ax,[bp-4h]
2FEA:0048 0B 46 FE        	or	ax,[bp-2h]
2FEA:004B 75 03           	jnz	0050h

l2FEA_004D:
2FEA:004D E9 B6 00        	jmp	0106h

l2FEA_0050:
2FEA:0050 8B C7           	mov	ax,di
2FEA:0052 FE C8           	dec	al
2FEA:0054 C4 5E FC        	les	bx,[bp-4h]
2FEA:0057 26 88 47 03     	mov	es:[bx+3h],al
2FEA:005B C4 5E FC        	les	bx,[bp-4h]
2FEA:005E 26 88 47 01     	mov	es:[bx+1h],al
2FEA:0062 8A 46 0A        	mov	al,[bp+0Ah]
2FEA:0065 C4 5E FC        	les	bx,[bp-4h]
2FEA:0068 26 88 47 02     	mov	es:[bx+2h],al
2FEA:006C D1 66 06        	shl	word ptr [bp+6h],1h
2FEA:006F D1 66 06        	shl	word ptr [bp+6h],1h
2FEA:0072 8B C6           	mov	ax,si
2FEA:0074 BA A0 00        	mov	dx,0A0h
2FEA:0077 F7 E2           	mul	dx
2FEA:0079 8B F0           	mov	si,ax
2FEA:007B D1 66 0A        	shl	word ptr [bp+0Ah],1h
2FEA:007E C7 46 F6 A0 00  	mov	word ptr [bp-0Ah],0A0h
2FEA:0083 8B 46 0A        	mov	ax,[bp+0Ah]
2FEA:0086 D1 E0           	shl	ax,1h
2FEA:0088 8B 56 F6        	mov	dx,[bp-0Ah]
2FEA:008B 2B D0           	sub	dx,ax
2FEA:008D 52              	push	dx
2FEA:008E 57              	push	di
2FEA:008F FF 76 0A        	push	word ptr [bp+0Ah]
2FEA:0092 8B 56 FE        	mov	dx,[bp-2h]
2FEA:0095 8B 46 FC        	mov	ax,[bp-4h]
2FEA:0098 05 04 00        	add	ax,4h
2FEA:009B 52              	push	dx
2FEA:009C 50              	push	ax
2FEA:009D 8B 16 60 B6     	mov	dx,[0B660h]
2FEA:00A1 A1 5E B6        	mov	ax,[0B65Eh]
2FEA:00A4 03 C6           	add	ax,si
2FEA:00A6 03 46 06        	add	ax,[bp+6h]
2FEA:00A9 52              	push	dx
2FEA:00AA 50              	push	ax
2FEA:00AB 9A 85 11 00 08  	call	far 0800h:1185h
2FEA:00B0 83 C4 0E        	add	sp,0Eh
2FEA:00B3 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
2FEA:00B8 75 38           	jnz	00F2h

l2FEA_00BA:
2FEA:00BA 8B 46 0A        	mov	ax,[bp+0Ah]
2FEA:00BD D1 E0           	shl	ax,1h
2FEA:00BF 8B 56 F6        	mov	dx,[bp-0Ah]
2FEA:00C2 2B D0           	sub	dx,ax
2FEA:00C4 52              	push	dx
2FEA:00C5 57              	push	di
2FEA:00C6 FF 76 0A        	push	word ptr [bp+0Ah]
2FEA:00C9 8B 46 FA        	mov	ax,[bp-6h]
2FEA:00CC D1 E8           	shr	ax,1h
2FEA:00CE 8B 4E FE        	mov	cx,[bp-2h]
2FEA:00D1 8B 5E FC        	mov	bx,[bp-4h]
2FEA:00D4 03 D8           	add	bx,ax
2FEA:00D6 83 C3 04        	add	bx,4h
2FEA:00D9 51              	push	cx
2FEA:00DA 53              	push	bx
2FEA:00DB 8B 16 60 B6     	mov	dx,[0B660h]
2FEA:00DF A1 5E B6        	mov	ax,[0B65Eh]
2FEA:00E2 03 C6           	add	ax,si
2FEA:00E4 03 46 06        	add	ax,[bp+6h]
2FEA:00E7 40              	inc	ax
2FEA:00E8 52              	push	dx
2FEA:00E9 50              	push	ax
2FEA:00EA 9A 85 11 00 08  	call	far 0800h:1185h
2FEA:00EF 83 C4 0E        	add	sp,0Eh

l2FEA_00F2:
2FEA:00F2 8B 46 0A        	mov	ax,[bp+0Ah]
2FEA:00F5 F7 E7           	mul	di
2FEA:00F7 99              	cwd
2FEA:00F8 B1 02           	mov	cl,2h
2FEA:00FA 9A E8 54 00 08  	call	far 0800h:54E8h
2FEA:00FF 89 16 06 B6     	mov	[0B606h],dx
2FEA:0103 A3 04 B6        	mov	[0B604h],ax

l2FEA_0106:
2FEA:0106 E9 A1 00        	jmp	01AAh

l2FEA_0109:
2FEA:0109 D1 66 06        	shl	word ptr [bp+6h],1h
2FEA:010C D1 66 06        	shl	word ptr [bp+6h],1h
2FEA:010F 8B C6           	mov	ax,si
2FEA:0111 BA A0 00        	mov	dx,0A0h
2FEA:0114 F7 E2           	mul	dx
2FEA:0116 8B F0           	mov	si,ax
2FEA:0118 8B 46 0A        	mov	ax,[bp+0Ah]
2FEA:011B D1 E0           	shl	ax,1h
2FEA:011D D1 E0           	shl	ax,1h
2FEA:011F BA A0 00        	mov	dx,0A0h
2FEA:0122 2B D0           	sub	dx,ax
2FEA:0124 52              	push	dx
2FEA:0125 57              	push	di
2FEA:0126 FF 76 0A        	push	word ptr [bp+0Ah]
2FEA:0129 FF 36 E4 83     	push	word ptr [83E4h]
2FEA:012D FF 36 E2 83     	push	word ptr [83E2h]
2FEA:0131 8B 16 60 B6     	mov	dx,[0B660h]
2FEA:0135 A1 5E B6        	mov	ax,[0B65Eh]
2FEA:0138 03 C6           	add	ax,si
2FEA:013A 03 46 06        	add	ax,[bp+6h]
2FEA:013D 52              	push	dx
2FEA:013E 50              	push	ax
2FEA:013F 9A 85 11 00 08  	call	far 0800h:1185h
2FEA:0144 83 C4 0E        	add	sp,0Eh
2FEA:0147 89 46 F8        	mov	[bp-8h],ax
2FEA:014A 8B 46 F8        	mov	ax,[bp-8h]
2FEA:014D 05 04 00        	add	ax,4h
2FEA:0150 99              	cwd
2FEA:0151 52              	push	dx
2FEA:0152 50              	push	ax
2FEA:0153 9A B5 00 56 0D  	call	far 0D56h:00B5h
2FEA:0158 59              	pop	cx
2FEA:0159 59              	pop	cx
2FEA:015A 89 56 FE        	mov	[bp-2h],dx
2FEA:015D 89 46 FC        	mov	[bp-4h],ax
2FEA:0160 8B C7           	mov	ax,di
2FEA:0162 FE C8           	dec	al
2FEA:0164 C4 5E FC        	les	bx,[bp-4h]
2FEA:0167 26 88 47 03     	mov	es:[bx+3h],al
2FEA:016B C4 5E FC        	les	bx,[bp-4h]
2FEA:016E 26 88 47 01     	mov	es:[bx+1h],al
2FEA:0172 8A 46 0A        	mov	al,[bp+0Ah]
2FEA:0175 C4 5E FC        	les	bx,[bp-4h]
2FEA:0178 26 88 47 02     	mov	es:[bx+2h],al
2FEA:017C 8B 46 F8        	mov	ax,[bp-8h]
2FEA:017F 99              	cwd
2FEA:0180 89 16 06 B6     	mov	[0B606h],dx
2FEA:0184 A3 04 B6        	mov	[0B604h],ax
2FEA:0187 FF 36 06 B6     	push	word ptr [0B606h]
2FEA:018B FF 36 04 B6     	push	word ptr [0B604h]
2FEA:018F 8B 56 FE        	mov	dx,[bp-2h]
2FEA:0192 8B 46 FC        	mov	ax,[bp-4h]
2FEA:0195 05 04 00        	add	ax,4h
2FEA:0198 52              	push	dx
2FEA:0199 50              	push	ax
2FEA:019A FF 36 E4 83     	push	word ptr [83E4h]
2FEA:019E FF 36 E2 83     	push	word ptr [83E2h]
2FEA:01A2 9A C8 2E 00 08  	call	far 0800h:2EC8h
2FEA:01A7 83 C4 0C        	add	sp,0Ch

l2FEA_01AA:
2FEA:01AA 8B 56 FE        	mov	dx,[bp-2h]
2FEA:01AD 8B 46 FC        	mov	ax,[bp-4h]
