;;; Segment 35AB (35AB:0000)
35AB:0000 0A 89 36 D0 B6 5F 5E 8B E5 5D CB                ..6.._^..].     

;; BeginUiRegionSelection_000B: 35AB:000B
;;   Called from:
;;     3568:001F (in RunUiRegionSelectionLoop_0007)
BeginUiRegionSelection_000B proc
35AB:000B 55              	push	bp
35AB:000C 8B EC           	mov	bp,sp
35AB:000E 83 EC 08        	sub	sp,8h
35AB:0011 56              	push	si
35AB:0012 57              	push	di
35AB:0013 8B 76 06        	mov	si,[bp+6h]
35AB:0016 A1 30 62        	mov	ax,[6230h]
35AB:0019 D1 E0           	shl	ax,1h
35AB:001B D1 E0           	shl	ax,1h
35AB:001D D1 E0           	shl	ax,1h
35AB:001F 8B DE           	mov	bx,si
35AB:0021 B1 04           	mov	cl,4h
35AB:0023 D3 E3           	shl	bx,cl
35AB:0025 81 C3 AA 07     	add	bx,7AAh
35AB:0029 50              	push	ax
35AB:002A 1E              	push	ds
35AB:002B 07              	pop	es
35AB:002C 26 8B 07        	mov	ax,es:[bx]
35AB:002F 50              	push	ax
35AB:0030 A0 66 86        	mov	al,[8666h]
35AB:0033 98              	cbw
35AB:0034 8B D0           	mov	dx,ax
35AB:0036 58              	pop	ax
35AB:0037 F7 E2           	mul	dx
35AB:0039 5A              	pop	dx
35AB:003A 03 D0           	add	dx,ax
35AB:003C 89 56 FC        	mov	[bp-4h],dx
35AB:003F A1 32 62        	mov	ax,[6232h]
35AB:0042 D1 E0           	shl	ax,1h
35AB:0044 D1 E0           	shl	ax,1h
35AB:0046 D1 E0           	shl	ax,1h
35AB:0048 8B DE           	mov	bx,si
35AB:004A B1 04           	mov	cl,4h
35AB:004C D3 E3           	shl	bx,cl
35AB:004E 81 C3 AA 07     	add	bx,7AAh
35AB:0052 50              	push	ax
35AB:0053 1E              	push	ds
35AB:0054 07              	pop	es
35AB:0055 26 8B 47 02     	mov	ax,es:[bx+2h]
35AB:0059 50              	push	ax
35AB:005A A0 BB 99        	mov	al,[99BBh]
35AB:005D 98              	cbw
35AB:005E 8B D0           	mov	dx,ax
35AB:0060 58              	pop	ax
35AB:0061 F7 E2           	mul	dx
35AB:0063 5A              	pop	dx
35AB:0064 03 D0           	add	dx,ax
35AB:0066 89 56 FE        	mov	[bp-2h],dx
35AB:0069 33 FF           	xor	di,di
35AB:006B EB 17           	jmp	0084h

l35AB_006D:
35AB:006D 8B DE           	mov	bx,si
35AB:006F 03 DF           	add	bx,di
35AB:0071 B1 04           	mov	cl,4h
35AB:0073 D3 E3           	shl	bx,cl
35AB:0075 81 C3 AA 07     	add	bx,7AAh
35AB:0079 1E              	push	ds
35AB:007A 07              	pop	es
35AB:007B 26 8A 47 08     	mov	al,es:[bx+8h]
35AB:007F 88 85 6A B6     	mov	[di+0B66Ah],al
35AB:0083 47              	inc	di

l35AB_0084:
35AB:0084 3B 7E 08        	cmp	di,[bp+8h]
35AB:0087 7C E4           	jl	006Dh

l35AB_0089:
35AB:0089 8B DE           	mov	bx,si
35AB:008B B1 04           	mov	cl,4h
35AB:008D D3 E3           	shl	bx,cl
35AB:008F 81 C3 AA 07     	add	bx,7AAh
35AB:0093 1E              	push	ds
35AB:0094 07              	pop	es
35AB:0095 26 8B 47 08     	mov	ax,es:[bx+8h]
35AB:0099 8B DE           	mov	bx,si
35AB:009B B1 04           	mov	cl,4h
35AB:009D D3 E3           	shl	bx,cl
35AB:009F 81 C3 AA 07     	add	bx,7AAh
35AB:00A3 50              	push	ax
35AB:00A4 1E              	push	ds
35AB:00A5 07              	pop	es
35AB:00A6 58              	pop	ax
35AB:00A7 26 3B 47 06     	cmp	ax,es:[bx+6h]
35AB:00AB 7C 12           	jl	00BFh

l35AB_00AD:
35AB:00AD 8B DE           	mov	bx,si
35AB:00AF B1 04           	mov	cl,4h
35AB:00B1 D3 E3           	shl	bx,cl
35AB:00B3 81 C3 AA 07     	add	bx,7AAh
35AB:00B7 1E              	push	ds
35AB:00B8 07              	pop	es
35AB:00B9 26 C7 47 08 00 00 	mov	word ptr es:[bx+8h],0h

l35AB_00BF:
35AB:00BF 83 3E 28 62 00  	cmp	word ptr [6228h],0h
35AB:00C4 75 07           	jnz	00CDh

l35AB_00C6:
35AB:00C6 83 3E 2A 62 00  	cmp	word ptr [622Ah],0h
35AB:00CB 74 12           	jz	00DFh

l35AB_00CD:
35AB:00CD 8B DE           	mov	bx,si
35AB:00CF B1 04           	mov	cl,4h
35AB:00D1 D3 E3           	shl	bx,cl
35AB:00D3 81 C3 AA 07     	add	bx,7AAh
35AB:00D7 1E              	push	ds
35AB:00D8 07              	pop	es
35AB:00D9 26 C7 47 08 00 00 	mov	word ptr es:[bx+8h],0h

l35AB_00DF:
35AB:00DF C7 46 F8 01 00  	mov	word ptr [bp-8h],1h
35AB:00E4 8B DE           	mov	bx,si
35AB:00E6 B1 04           	mov	cl,4h
35AB:00E8 D3 E3           	shl	bx,cl
35AB:00EA 81 C3 AA 07     	add	bx,7AAh
35AB:00EE 1E              	push	ds
35AB:00EF 07              	pop	es
35AB:00F0 26 8B 47 08     	mov	ax,es:[bx+8h]
35AB:00F4 89 46 FA        	mov	[bp-6h],ax
35AB:00F7 83 7E FA 00     	cmp	word ptr [bp-6h],0h
35AB:00FB 75 1A           	jnz	0117h

l35AB_00FD:
35AB:00FD 83 3E D2 B6 00  	cmp	word ptr [0B6D2h],0h
35AB:0102 74 13           	jz	0117h

l35AB_0104:
35AB:0104 8B DE           	mov	bx,si
35AB:0106 B1 04           	mov	cl,4h
35AB:0108 D3 E3           	shl	bx,cl
35AB:010A 81 C3 AA 07     	add	bx,7AAh
35AB:010E 1E              	push	ds
35AB:010F 07              	pop	es
35AB:0110 26 8B 47 06     	mov	ax,es:[bx+6h]
35AB:0114 89 46 F8        	mov	[bp-8h],ax

l35AB_0117:
35AB:0117 8B DE           	mov	bx,si
35AB:0119 B1 04           	mov	cl,4h
35AB:011B D3 E3           	shl	bx,cl
35AB:011D 81 C3 AA 07     	add	bx,7AAh
35AB:0121 1E              	push	ds
35AB:0122 07              	pop	es
35AB:0123 26 FF 77 0C     	push	word ptr es:[bx+0Ch]
35AB:0127 8B 46 FA        	mov	ax,[bp-6h]
35AB:012A 03 46 F8        	add	ax,[bp-8h]
35AB:012D 50              	push	ax
35AB:012E A0 BB 99        	mov	al,[99BBh]
35AB:0131 98              	cbw
35AB:0132 8B D0           	mov	dx,ax
35AB:0134 58              	pop	ax
35AB:0135 F7 E2           	mul	dx
35AB:0137 03 46 FE        	add	ax,[bp-2h]
35AB:013A 48              	dec	ax
35AB:013B 50              	push	ax
35AB:013C 8B DE           	mov	bx,si
35AB:013E B1 04           	mov	cl,4h
35AB:0140 D3 E3           	shl	bx,cl
35AB:0142 81 C3 AA 07     	add	bx,7AAh
35AB:0146 1E              	push	ds
35AB:0147 07              	pop	es
35AB:0148 26 8B 47 04     	mov	ax,es:[bx+4h]
35AB:014C 50              	push	ax
35AB:014D A0 66 86        	mov	al,[8666h]
35AB:0150 98              	cbw
35AB:0151 8B D0           	mov	dx,ax
35AB:0153 58              	pop	ax
35AB:0154 F7 E2           	mul	dx
35AB:0156 03 46 FC        	add	ax,[bp-4h]
35AB:0159 48              	dec	ax
35AB:015A 50              	push	ax
35AB:015B A0 BB 99        	mov	al,[99BBh]
35AB:015E 98              	cbw
35AB:015F F7 66 FA        	mul	word ptr [bp-6h]
35AB:0162 03 46 FE        	add	ax,[bp-2h]
35AB:0165 50              	push	ax
35AB:0166 FF 76 FC        	push	word ptr [bp-4h]
35AB:0169 9A 4E 48 00 08  	call	far 0800h:484Eh
35AB:016E 83 C4 0A        	add	sp,0Ah
