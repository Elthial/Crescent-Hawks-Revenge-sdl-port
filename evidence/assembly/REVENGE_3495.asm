;;; Segment 3495 (3495:0000)
3495:0000 8B F0 8B C6 EB 00                               ......          

l3477_01E6:
3477:01E6 5E              	pop	si
3477:01E7 8B E5           	mov	sp,bp
3477:01E9 5D              	pop	bp
3477:01EA CB              	retf

;; Capture8x8VideoTile_000B: 3495:000B
;;   Called from:
;;     34D5:0069 (in CaptureVideoTileStrip_000C)
Capture8x8VideoTile_000B proc
3495:000B 55              	push	bp
3495:000C 8B EC           	mov	bp,sp
3495:000E 56              	push	si
3495:000F 57              	push	di
3495:0010 83 3E CE B6 02  	cmp	word ptr [0B6CEh],2h
3495:0015 75 03           	jnz	001Ah

l3495_0017:
3495:0017 E9 F4 00        	jmp	010Eh

l3495_001A:
3495:001A 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
3495:001F 74 03           	jz	0024h

l3495_0021:
3495:0021 E9 7C 00        	jmp	00A0h

l3495_0024:
3495:0024 BF 9C 00        	mov	di,9Ch
3495:0027 8B 46 10        	mov	ax,[bp+10h]
3495:002A BA 00 05        	mov	dx,500h
3495:002D F7 E2           	mul	dx
3495:002F 8B 56 0E        	mov	dx,[bp+0Eh]
3495:0032 D1 E2           	shl	dx,1h
3495:0034 D1 E2           	shl	dx,1h
3495:0036 03 C2           	add	ax,dx
3495:0038 D1 E0           	shl	ax,1h
3495:003A 01 46 06        	add	[bp+6h],ax
3495:003D 33 F6           	xor	si,si
3495:003F EB 58           	jmp	0099h

l3495_0041:
3495:0041 C4 5E 06        	les	bx,[bp+6h]
3495:0044 26 8B 07        	mov	ax,es:[bx]
3495:0047 C4 5E 0A        	les	bx,[bp+0Ah]
3495:004A 26 89 07        	mov	es:[bx],ax
3495:004D 83 46 06 02     	add	word ptr [bp+6h],2h
3495:0051 83 46 0A 02     	add	word ptr [bp+0Ah],2h
3495:0055 C4 5E 06        	les	bx,[bp+6h]
3495:0058 26 8B 07        	mov	ax,es:[bx]
3495:005B C4 5E 0A        	les	bx,[bp+0Ah]
3495:005E 26 89 07        	mov	es:[bx],ax
3495:0061 83 46 06 02     	add	word ptr [bp+6h],2h
3495:0065 83 46 0A 02     	add	word ptr [bp+0Ah],2h
3495:0069 C4 5E 06        	les	bx,[bp+6h]
3495:006C 26 8B 07        	mov	ax,es:[bx]
3495:006F C4 5E 0A        	les	bx,[bp+0Ah]
3495:0072 26 89 07        	mov	es:[bx],ax
3495:0075 83 46 06 02     	add	word ptr [bp+6h],2h
3495:0079 83 46 0A 02     	add	word ptr [bp+0Ah],2h
3495:007D C4 5E 06        	les	bx,[bp+6h]
3495:0080 26 8B 07        	mov	ax,es:[bx]
3495:0083 C4 5E 0A        	les	bx,[bp+0Ah]
3495:0086 26 89 07        	mov	es:[bx],ax
3495:0089 83 46 06 02     	add	word ptr [bp+6h],2h
3495:008D 83 46 0A 02     	add	word ptr [bp+0Ah],2h
3495:0091 8B C7           	mov	ax,di
3495:0093 D1 E0           	shl	ax,1h
3495:0095 01 46 06        	add	[bp+6h],ax
3495:0098 46              	inc	si

l3495_0099:
3495:0099 83 FE 08        	cmp	si,8h
3495:009C 7C A3           	jl	0041h

l3495_009E:
3495:009E EB 6C           	jmp	010Ch

l3495_00A0:
3495:00A0 BF 50 00        	mov	di,50h
3495:00A3 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
3495:00A8 74 16           	jz	00C0h

l3495_00AA:
3495:00AA 8B 46 10        	mov	ax,[bp+10h]
3495:00AD BA 80 02        	mov	dx,280h
3495:00B0 F7 E2           	mul	dx
3495:00B2 8B 56 0E        	mov	dx,[bp+0Eh]
3495:00B5 D1 E2           	shl	dx,1h
3495:00B7 03 C2           	add	ax,dx
3495:00B9 D1 E0           	shl	ax,1h
3495:00BB 01 46 06        	add	[bp+6h],ax
3495:00BE EB 13           	jmp	00D3h

l3495_00C0:
3495:00C0 8B 46 10        	mov	ax,[bp+10h]
3495:00C3 BA 40 01        	mov	dx,140h
3495:00C6 F7 E2           	mul	dx
3495:00C8 03 46 0E        	add	ax,[bp+0Eh]
3495:00CB D1 E0           	shl	ax,1h
3495:00CD 01 46 06        	add	[bp+6h],ax
3495:00D0 BF 28 00        	mov	di,28h

l3495_00D3:
3495:00D3 33 F6           	xor	si,si
3495:00D5 EB 30           	jmp	0107h

l3495_00D7:
3495:00D7 C4 5E 06        	les	bx,[bp+6h]
3495:00DA 26 8B 07        	mov	ax,es:[bx]
3495:00DD C4 5E 0A        	les	bx,[bp+0Ah]
3495:00E0 26 89 07        	mov	es:[bx],ax
3495:00E3 83 46 0A 02     	add	word ptr [bp+0Ah],2h
3495:00E7 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
3495:00EC 74 11           	jz	00FFh

l3495_00EE:
3495:00EE C4 5E 06        	les	bx,[bp+6h]
3495:00F1 26 8B 47 02     	mov	ax,es:[bx+2h]
3495:00F5 C4 5E 0A        	les	bx,[bp+0Ah]
3495:00F8 26 89 07        	mov	es:[bx],ax
3495:00FB 83 46 0A 02     	add	word ptr [bp+0Ah],2h

l3495_00FF:
3495:00FF 8B C7           	mov	ax,di
3495:0101 D1 E0           	shl	ax,1h
3495:0103 01 46 06        	add	[bp+6h],ax
3495:0106 46              	inc	si

l3495_0107:
3495:0107 83 FE 08        	cmp	si,8h
3495:010A 7C CB           	jl	00D7h

l3495_010C:
3495:010C EB 14           	jmp	0122h

l3495_010E:
3495:010E FF 76 10        	push	word ptr [bp+10h]
3495:0111 FF 76 0E        	push	word ptr [bp+0Eh]
3495:0114 FF 76 0C        	push	word ptr [bp+0Ch]
3495:0117 FF 76 0A        	push	word ptr [bp+0Ah]
3495:011A 9A FD 4D 00 08  	call	far 0800h:4DFDh
3495:011F 83 C4 08        	add	sp,8h
