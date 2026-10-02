;;; Segment 3005 (3005:0000)
3005:0000 EB 00                                           ..              

l2FEA_01B2:
2FEA:01B2 5F              	pop	di
2FEA:01B3 5E              	pop	si
2FEA:01B4 8B E5           	mov	sp,bp
2FEA:01B6 5D              	pop	bp
2FEA:01B7 CB              	retf

;; DrawTacticalClippedSprite_0008: 3005:0008
;;   Called from:
;;     2007:0E0B (in DrawTacticalEffectSprite_0DDB)
DrawTacticalClippedSprite_0008 proc
3005:0008 55              	push	bp
3005:0009 8B EC           	mov	bp,sp
3005:000B 56              	push	si
3005:000C 57              	push	di
3005:000D 8B 76 12        	mov	si,[bp+12h]
3005:0010 8B 7E 0E        	mov	di,[bp+0Eh]
3005:0013 83 3E 3C 56 00  	cmp	word ptr [563Ch],0h
3005:0018 74 03           	jz	001Dh

l3005_001A:
3005:001A E9 DD 00        	jmp	00FAh

l3005_001D:
3005:001D C7 06 3C 56 01 00 	mov	word ptr [563Ch],1h
3005:0023 8B DE           	mov	bx,si
3005:0025 B1 04           	mov	cl,4h
3005:0027 D3 E3           	shl	bx,cl
3005:0029 81 C3 3A 06     	add	bx,63Ah
3005:002D 1E              	push	ds
3005:002E 07              	pop	es
3005:002F 26 8B 07        	mov	ax,es:[bx]
3005:0032 A3 67 7D        	mov	[7D67h],ax
3005:0035 A3 1C 7B        	mov	[7B1Ch],ax
3005:0038 A1 1C 7B        	mov	ax,[7B1Ch]
3005:003B D1 E0           	shl	ax,1h
3005:003D D1 E0           	shl	ax,1h
3005:003F D1 E0           	shl	ax,1h
3005:0041 03 F8           	add	di,ax
3005:0043 8B DE           	mov	bx,si
3005:0045 B1 04           	mov	cl,4h
3005:0047 D3 E3           	shl	bx,cl
3005:0049 81 C3 3A 06     	add	bx,63Ah
3005:004D 1E              	push	ds
3005:004E 07              	pop	es
3005:004F 26 8B 47 04     	mov	ax,es:[bx+4h]
3005:0053 03 06 1C 7B     	add	ax,[7B1Ch]
3005:0057 A3 69 7D        	mov	[7D69h],ax
3005:005A A3 1E 7B        	mov	[7B1Eh],ax
3005:005D 8B DE           	mov	bx,si
3005:005F B1 04           	mov	cl,4h
3005:0061 D3 E3           	shl	bx,cl
3005:0063 81 C3 3A 06     	add	bx,63Ah
3005:0067 1E              	push	ds
3005:0068 07              	pop	es
3005:0069 26 8B 47 02     	mov	ax,es:[bx+2h]
3005:006D D1 E0           	shl	ax,1h
3005:006F D1 E0           	shl	ax,1h
3005:0071 D1 E0           	shl	ax,1h
3005:0073 A3 6B 7D        	mov	[7D6Bh],ax
3005:0076 A3 20 7B        	mov	[7B20h],ax
3005:0079 A1 20 7B        	mov	ax,[7B20h]
3005:007C 01 46 10        	add	[bp+10h],ax
3005:007F 8B DE           	mov	bx,si
3005:0081 B1 04           	mov	cl,4h
3005:0083 D3 E3           	shl	bx,cl
3005:0085 81 C3 3A 06     	add	bx,63Ah
3005:0089 1E              	push	ds
3005:008A 07              	pop	es
3005:008B 26 8B 47 06     	mov	ax,es:[bx+6h]
3005:008F D1 E0           	shl	ax,1h
3005:0091 D1 E0           	shl	ax,1h
3005:0093 D1 E0           	shl	ax,1h
3005:0095 03 06 20 7B     	add	ax,[7B20h]
3005:0099 A3 6D 7D        	mov	[7D6Dh],ax
3005:009C A3 22 7B        	mov	[7B22h],ax
3005:009F 83 3E CE B6 02  	cmp	word ptr [0B6CEh],2h
3005:00A4 74 1A           	jz	00C0h

l3005_00A6:
3005:00A6 FF 76 10        	push	word ptr [bp+10h]
3005:00A9 57              	push	di
3005:00AA FF 76 0C        	push	word ptr [bp+0Ch]
3005:00AD FF 76 0A        	push	word ptr [bp+0Ah]
3005:00B0 FF 76 08        	push	word ptr [bp+8h]
3005:00B3 FF 76 06        	push	word ptr [bp+6h]
3005:00B6 9A B7 14 00 08  	call	far 0800h:14B7h
3005:00BB 83 C4 0C        	add	sp,0Ch
3005:00BE EB 34           	jmp	00F4h

l3005_00C0:
3005:00C0 8B 56 08        	mov	dx,[bp+8h]
3005:00C3 8B 46 06        	mov	ax,[bp+6h]
3005:00C6 3B 16 60 B6     	cmp	dx,[0B660h]
3005:00CA 75 10           	jnz	00DCh

l3005_00CC:
3005:00CC 3B 06 5E B6     	cmp	ax,[0B65Eh]
3005:00D0 75 0A           	jnz	00DCh

l3005_00D2:
3005:00D2 C7 46 08 00 A2  	mov	word ptr [bp+8h],0A200h
3005:00D7 C7 46 06 00 00  	mov	word ptr [bp+6h],0h

l3005_00DC:
3005:00DC FF 76 10        	push	word ptr [bp+10h]
3005:00DF 57              	push	di
3005:00E0 FF 76 0C        	push	word ptr [bp+0Ch]
3005:00E3 FF 76 0A        	push	word ptr [bp+0Ah]
3005:00E6 FF 76 08        	push	word ptr [bp+8h]
3005:00E9 FF 76 06        	push	word ptr [bp+6h]
3005:00EC 9A FD 30 00 08  	call	far 0800h:30FDh
