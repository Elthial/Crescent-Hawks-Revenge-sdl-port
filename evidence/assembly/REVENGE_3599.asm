;;; Segment 3599 (3599:0000)
3599:0000 A2 C7 06 3B 7D 00 00                            ...;}..         

l3596_0037:
3596:0037 5D              	pop	bp
3596:0038 CB              	retf

;; HighlightUiRegionSelection_0009: 3599:0009
;;   Called from:
;;     358E:0021 (in RunSingleUiRegionSelection_000C)
HighlightUiRegionSelection_0009 proc
3599:0009 55              	push	bp
3599:000A 8B EC           	mov	bp,sp
3599:000C 83 EC 02        	sub	sp,2h
3599:000F 56              	push	si
3599:0010 57              	push	di
3599:0011 8B 76 06        	mov	si,[bp+6h]
3599:0014 8B DE           	mov	bx,si
3599:0016 B1 04           	mov	cl,4h
3599:0018 D3 E3           	shl	bx,cl
3599:001A 81 C3 AA 07     	add	bx,7AAh
3599:001E 1E              	push	ds
3599:001F 07              	pop	es
3599:0020 26 8B 47 08     	mov	ax,es:[bx+8h]
3599:0024 8B DE           	mov	bx,si
3599:0026 B1 04           	mov	cl,4h
3599:0028 D3 E3           	shl	bx,cl
3599:002A 81 C3 AA 07     	add	bx,7AAh
3599:002E 50              	push	ax
3599:002F 1E              	push	ds
3599:0030 07              	pop	es
3599:0031 58              	pop	ax
3599:0032 26 3B 47 06     	cmp	ax,es:[bx+6h]
3599:0036 7C 12           	jl	004Ah

l3599_0038:
3599:0038 8B DE           	mov	bx,si
3599:003A B1 04           	mov	cl,4h
3599:003C D3 E3           	shl	bx,cl
3599:003E 81 C3 AA 07     	add	bx,7AAh
3599:0042 1E              	push	ds
3599:0043 07              	pop	es
3599:0044 26 C7 47 08 00 00 	mov	word ptr es:[bx+8h],0h

l3599_004A:
3599:004A 83 3E 28 62 00  	cmp	word ptr [6228h],0h
3599:004F 75 07           	jnz	0058h

l3599_0051:
3599:0051 83 3E 2A 62 00  	cmp	word ptr [622Ah],0h
3599:0056 74 12           	jz	006Ah

l3599_0058:
3599:0058 8B DE           	mov	bx,si
3599:005A B1 04           	mov	cl,4h
3599:005C D3 E3           	shl	bx,cl
3599:005E 81 C3 AA 07     	add	bx,7AAh
3599:0062 1E              	push	ds
3599:0063 07              	pop	es
3599:0064 26 C7 47 08 00 00 	mov	word ptr es:[bx+8h],0h

l3599_006A:
3599:006A 8B DE           	mov	bx,si
3599:006C B1 04           	mov	cl,4h
3599:006E D3 E3           	shl	bx,cl
3599:0070 81 C3 AA 07     	add	bx,7AAh
3599:0074 1E              	push	ds
3599:0075 07              	pop	es
3599:0076 26 8A 47 08     	mov	al,es:[bx+8h]
3599:007A A2 6A B6        	mov	[0B66Ah],al
3599:007D A1 30 62        	mov	ax,[6230h]
3599:0080 D1 E0           	shl	ax,1h
3599:0082 D1 E0           	shl	ax,1h
3599:0084 D1 E0           	shl	ax,1h
3599:0086 8B DE           	mov	bx,si
3599:0088 B1 04           	mov	cl,4h
3599:008A D3 E3           	shl	bx,cl
3599:008C 81 C3 AA 07     	add	bx,7AAh
3599:0090 50              	push	ax
3599:0091 1E              	push	ds
3599:0092 07              	pop	es
3599:0093 26 8B 07        	mov	ax,es:[bx]
3599:0096 50              	push	ax
3599:0097 A0 66 86        	mov	al,[8666h]
3599:009A 98              	cbw
3599:009B 8B D0           	mov	dx,ax
3599:009D 58              	pop	ax
3599:009E F7 E2           	mul	dx
3599:00A0 5A              	pop	dx
3599:00A1 03 D0           	add	dx,ax
3599:00A3 89 56 FE        	mov	[bp-2h],dx
3599:00A6 8B 3E 32 62     	mov	di,[6232h]
3599:00AA D1 E7           	shl	di,1h
3599:00AC D1 E7           	shl	di,1h
3599:00AE D1 E7           	shl	di,1h
3599:00B0 8B DE           	mov	bx,si
3599:00B2 B1 04           	mov	cl,4h
3599:00B4 D3 E3           	shl	bx,cl
3599:00B6 81 C3 AA 07     	add	bx,7AAh
3599:00BA 1E              	push	ds
3599:00BB 07              	pop	es
3599:00BC 26 8B 47 02     	mov	ax,es:[bx+2h]
3599:00C0 8B DE           	mov	bx,si
3599:00C2 B1 04           	mov	cl,4h
3599:00C4 D3 E3           	shl	bx,cl
3599:00C6 81 C3 AA 07     	add	bx,7AAh
3599:00CA 50              	push	ax
3599:00CB 1E              	push	ds
3599:00CC 07              	pop	es
3599:00CD 58              	pop	ax
3599:00CE 26 03 47 08     	add	ax,es:[bx+8h]
3599:00D2 50              	push	ax
3599:00D3 A0 BB 99        	mov	al,[99BBh]
3599:00D6 98              	cbw
3599:00D7 8B D0           	mov	dx,ax
3599:00D9 58              	pop	ax
3599:00DA F7 E2           	mul	dx
3599:00DC 03 F8           	add	di,ax
3599:00DE 8B DE           	mov	bx,si
3599:00E0 B1 04           	mov	cl,4h
3599:00E2 D3 E3           	shl	bx,cl
3599:00E4 81 C3 AA 07     	add	bx,7AAh
3599:00E8 1E              	push	ds
3599:00E9 07              	pop	es
3599:00EA 26 FF 77 0C     	push	word ptr es:[bx+0Ch]
3599:00EE A0 BB 99        	mov	al,[99BBh]
3599:00F1 98              	cbw
3599:00F2 03 C7           	add	ax,di
3599:00F4 48              	dec	ax
3599:00F5 50              	push	ax
3599:00F6 8B DE           	mov	bx,si
3599:00F8 B1 04           	mov	cl,4h
3599:00FA D3 E3           	shl	bx,cl
3599:00FC 81 C3 AA 07     	add	bx,7AAh
3599:0100 1E              	push	ds
3599:0101 07              	pop	es
3599:0102 26 8B 47 04     	mov	ax,es:[bx+4h]
3599:0106 50              	push	ax
3599:0107 A0 66 86        	mov	al,[8666h]
3599:010A 98              	cbw
3599:010B 8B D0           	mov	dx,ax
3599:010D 58              	pop	ax
3599:010E F7 E2           	mul	dx
3599:0110 03 46 FE        	add	ax,[bp-2h]
3599:0113 48              	dec	ax
3599:0114 50              	push	ax
3599:0115 57              	push	di
3599:0116 FF 76 FE        	push	word ptr [bp-2h]
3599:0119 9A 4E 48 00 08  	call	far 0800h:484Eh
3599:011E 83 C4 0A        	add	sp,0Ah
