;;; Segment 356F (356F:0000)
356F:0000 C4 0A 33 C0 A3 3E 62 A3 3C 62 CB                ..3..>b.<b.     

;; RenderTextToActiveWindow_000B: 356F:000B
;;   Called from:
;;     35CE:0110 (in RenderFormattedText_000A)
;;     35CE:0124 (in RenderFormattedText_000A)
;;     35CE:0135 (in RenderFormattedText_000A)
;;     35CE:0191 (in RenderFormattedText_000A)
;;     35CE:01A5 (in RenderFormattedText_000A)
;;     35CE:01B5 (in RenderFormattedText_000A)
;;     35CE:021F (in RenderFormattedText_000A)
;;     35CE:0233 (in RenderFormattedText_000A)
;;     35CE:0243 (in RenderFormattedText_000A)
;;     35CE:02AD (in RenderFormattedText_000A)
;;     35CE:02C1 (in RenderFormattedText_000A)
;;     35CE:02D1 (in RenderFormattedText_000A)
;;     35CE:0411 (in RenderFormattedText_000A)
;;     35CE:045F (in RenderFormattedText_000A)
;;     35CE:0489 (in RenderFormattedText_000A)
;;     35CE:0504 (in RenderFormattedText_000A)
;;     35CE:0518 (in RenderFormattedText_000A)
;;     35CE:0528 (in RenderFormattedText_000A)
RenderTextToActiveWindow_000B proc
356F:000B 55              	push	bp
356F:000C 8B EC           	mov	bp,sp
356F:000E 56              	push	si
356F:000F A1 36 62        	mov	ax,[6236h]
356F:0012 D1 E0           	shl	ax,1h
356F:0014 D1 E0           	shl	ax,1h
356F:0016 D1 E0           	shl	ax,1h
356F:0018 50              	push	ax
356F:0019 A0 BB 99        	mov	al,[99BBh]
356F:001C 98              	cbw
356F:001D 5A              	pop	dx
356F:001E 2B D0           	sub	dx,ax
356F:0020 A0 BB 99        	mov	al,[99BBh]
356F:0023 98              	cbw
356F:0024 52              	push	dx
356F:0025 F7 26 3E 62     	mul	word ptr [623Eh]
356F:0029 5A              	pop	dx
356F:002A 3B D0           	cmp	dx,ax
356F:002C 7C 03           	jl	0031h

l356F_002E:
356F:002E E9 33 01        	jmp	0164h

l356F_0031:
356F:0031 A1 36 62        	mov	ax,[6236h]
356F:0034 D1 E0           	shl	ax,1h
356F:0036 D1 E0           	shl	ax,1h
356F:0038 D1 E0           	shl	ax,1h
356F:003A 50              	push	ax
356F:003B A0 BB 99        	mov	al,[99BBh]
356F:003E 98              	cbw
356F:003F 8B D8           	mov	bx,ax
356F:0041 58              	pop	ax
356F:0042 99              	cwd
356F:0043 F7 FB           	idiv	bx
356F:0045 48              	dec	ax
356F:0046 50              	push	ax
356F:0047 A0 BB 99        	mov	al,[99BBh]
356F:004A 98              	cbw
356F:004B 8B D0           	mov	dx,ax
356F:004D 58              	pop	ax
356F:004E F7 E2           	mul	dx
356F:0050 8B F0           	mov	si,ax
356F:0052 FF 36 3D 7D     	push	word ptr [7D3Dh]
356F:0056 FF 36 3B 7D     	push	word ptr [7D3Bh]
356F:005A FF 36 3D 7D     	push	word ptr [7D3Dh]
356F:005E FF 36 3B 7D     	push	word ptr [7D3Bh]
356F:0062 56              	push	si
356F:0063 FF 36 34 62     	push	word ptr [6234h]
356F:0067 A1 32 62        	mov	ax,[6232h]
356F:006A D1 E0           	shl	ax,1h
356F:006C D1 E0           	shl	ax,1h
356F:006E D1 E0           	shl	ax,1h
356F:0070 50              	push	ax
356F:0071 FF 36 30 62     	push	word ptr [6230h]
356F:0075 A1 32 62        	mov	ax,[6232h]
356F:0078 D1 E0           	shl	ax,1h
356F:007A D1 E0           	shl	ax,1h
356F:007C D1 E0           	shl	ax,1h
356F:007E 50              	push	ax
356F:007F A0 BB 99        	mov	al,[99BBh]
356F:0082 98              	cbw
356F:0083 5A              	pop	dx
356F:0084 03 D0           	add	dx,ax
356F:0086 52              	push	dx
356F:0087 FF 36 30 62     	push	word ptr [6230h]
356F:008B 9A 0E 00 29 33  	call	far 3329h:000Eh
356F:0090 83 C4 14        	add	sp,14h
356F:0093 FF 36 3A 62     	push	word ptr [623Ah]
356F:0097 A1 32 62        	mov	ax,[6232h]
356F:009A D1 E0           	shl	ax,1h
356F:009C D1 E0           	shl	ax,1h
356F:009E D1 E0           	shl	ax,1h
356F:00A0 03 C6           	add	ax,si
356F:00A2 50              	push	ax
356F:00A3 A0 BB 99        	mov	al,[99BBh]
356F:00A6 98              	cbw
356F:00A7 5A              	pop	dx
356F:00A8 03 D0           	add	dx,ax
356F:00AA 4A              	dec	dx
356F:00AB 52              	push	dx
356F:00AC A1 30 62        	mov	ax,[6230h]
356F:00AF 03 06 34 62     	add	ax,[6234h]
356F:00B3 D1 E0           	shl	ax,1h
356F:00B5 D1 E0           	shl	ax,1h
356F:00B7 D1 E0           	shl	ax,1h
356F:00B9 48              	dec	ax
356F:00BA 50              	push	ax
356F:00BB A1 32 62        	mov	ax,[6232h]
356F:00BE D1 E0           	shl	ax,1h
356F:00C0 D1 E0           	shl	ax,1h
356F:00C2 D1 E0           	shl	ax,1h
356F:00C4 03 C6           	add	ax,si
356F:00C6 50              	push	ax
356F:00C7 A1 30 62        	mov	ax,[6230h]
356F:00CA D1 E0           	shl	ax,1h
356F:00CC D1 E0           	shl	ax,1h
356F:00CE D1 E0           	shl	ax,1h
356F:00D0 50              	push	ax
356F:00D1 9A 0E 00 71 34  	call	far 3471h:000Eh
356F:00D6 83 C4 0A        	add	sp,0Ah
356F:00D9 FF 36 3A 62     	push	word ptr [623Ah]
356F:00DD FF 36 38 62     	push	word ptr [6238h]
356F:00E1 A1 32 62        	mov	ax,[6232h]
356F:00E4 D1 E0           	shl	ax,1h
356F:00E6 D1 E0           	shl	ax,1h
356F:00E8 D1 E0           	shl	ax,1h
356F:00EA 03 C6           	add	ax,si
356F:00EC 50              	push	ax
356F:00ED A1 30 62        	mov	ax,[6230h]
356F:00F0 D1 E0           	shl	ax,1h
356F:00F2 D1 E0           	shl	ax,1h
356F:00F4 D1 E0           	shl	ax,1h
356F:00F6 50              	push	ax
356F:00F7 FF 76 08        	push	word ptr [bp+8h]
356F:00FA FF 76 06        	push	word ptr [bp+6h]
356F:00FD 9A 0B 47 00 08  	call	far 0800h:470Bh
356F:0102 83 C4 0C        	add	sp,0Ch
356F:0105 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
356F:0109 74 0C           	jz	0117h

l356F_010B:
356F:010B C7 06 3C 62 00 00 	mov	word ptr [623Ch],0h
356F:0111 FF 06 3E 62     	inc	word ptr [623Eh]
356F:0115 EB 4A           	jmp	0161h

l356F_0117:
356F:0117 8B C6           	mov	ax,si
356F:0119 50              	push	ax
356F:011A A0 BB 99        	mov	al,[99BBh]
356F:011D 98              	cbw
356F:011E 8B D8           	mov	bx,ax
356F:0120 58              	pop	ax
356F:0121 99              	cwd
356F:0122 F7 FB           	idiv	bx
356F:0124 A3 3E 62        	mov	[623Eh],ax
356F:0127 FF 76 08        	push	word ptr [bp+8h]
356F:012A FF 76 06        	push	word ptr [bp+6h]
356F:012D 9A 03 00 7E 39  	call	far 397Eh:0003h
356F:0132 59              	pop	cx
356F:0133 59              	pop	cx
356F:0134 01 06 3C 62     	add	[623Ch],ax
356F:0138 A1 34 62        	mov	ax,[6234h]
356F:013B D1 E0           	shl	ax,1h
356F:013D D1 E0           	shl	ax,1h
356F:013F D1 E0           	shl	ax,1h
356F:0141 50              	push	ax
356F:0142 A0 66 86        	mov	al,[8666h]
356F:0145 98              	cbw
356F:0146 5A              	pop	dx
356F:0147 2B D0           	sub	dx,ax
356F:0149 A0 66 86        	mov	al,[8666h]
356F:014C 98              	cbw
356F:014D 52              	push	dx
356F:014E F7 26 3C 62     	mul	word ptr [623Ch]
356F:0152 5A              	pop	dx
356F:0153 3B D0           	cmp	dx,ax
356F:0155 7D 0A           	jge	0161h

l356F_0157:
356F:0157 C7 06 3C 62 00 00 	mov	word ptr [623Ch],0h
356F:015D FF 06 3E 62     	inc	word ptr [623Eh]

l356F_0161:
356F:0161 E9 8E 00        	jmp	01F2h

l356F_0164:
356F:0164 FF 36 3A 62     	push	word ptr [623Ah]
356F:0168 FF 36 38 62     	push	word ptr [6238h]
356F:016C A1 32 62        	mov	ax,[6232h]
356F:016F D1 E0           	shl	ax,1h
356F:0171 D1 E0           	shl	ax,1h
356F:0173 D1 E0           	shl	ax,1h
356F:0175 50              	push	ax
356F:0176 A0 BB 99        	mov	al,[99BBh]
356F:0179 98              	cbw
356F:017A F7 26 3E 62     	mul	word ptr [623Eh]
356F:017E 5A              	pop	dx
356F:017F 03 D0           	add	dx,ax
356F:0181 52              	push	dx
356F:0182 A1 30 62        	mov	ax,[6230h]
356F:0185 D1 E0           	shl	ax,1h
356F:0187 D1 E0           	shl	ax,1h
356F:0189 D1 E0           	shl	ax,1h
356F:018B 50              	push	ax
356F:018C A0 66 86        	mov	al,[8666h]
356F:018F 98              	cbw
356F:0190 F7 26 3C 62     	mul	word ptr [623Ch]
356F:0194 5A              	pop	dx
356F:0195 03 D0           	add	dx,ax
356F:0197 52              	push	dx
356F:0198 FF 76 08        	push	word ptr [bp+8h]
356F:019B FF 76 06        	push	word ptr [bp+6h]
356F:019E 9A 0B 47 00 08  	call	far 0800h:470Bh
356F:01A3 83 C4 0C        	add	sp,0Ch
356F:01A6 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
356F:01AA 74 0C           	jz	01B8h

l356F_01AC:
356F:01AC C7 06 3C 62 00 00 	mov	word ptr [623Ch],0h
356F:01B2 FF 06 3E 62     	inc	word ptr [623Eh]
356F:01B6 EB 3A           	jmp	01F2h

l356F_01B8:
356F:01B8 FF 76 08        	push	word ptr [bp+8h]
356F:01BB FF 76 06        	push	word ptr [bp+6h]
356F:01BE 9A 03 00 7E 39  	call	far 397Eh:0003h
356F:01C3 59              	pop	cx
356F:01C4 59              	pop	cx
356F:01C5 01 06 3C 62     	add	[623Ch],ax
356F:01C9 A1 34 62        	mov	ax,[6234h]
356F:01CC D1 E0           	shl	ax,1h
356F:01CE D1 E0           	shl	ax,1h
356F:01D0 D1 E0           	shl	ax,1h
356F:01D2 50              	push	ax
356F:01D3 A0 66 86        	mov	al,[8666h]
356F:01D6 98              	cbw
356F:01D7 5A              	pop	dx
356F:01D8 2B D0           	sub	dx,ax
356F:01DA A0 66 86        	mov	al,[8666h]
356F:01DD 98              	cbw
356F:01DE 52              	push	dx
356F:01DF F7 26 3C 62     	mul	word ptr [623Ch]
356F:01E3 5A              	pop	dx
356F:01E4 3B D0           	cmp	dx,ax
356F:01E6 7D 0A           	jge	01F2h

l356F_01E8:
356F:01E8 C7 06 3C 62 00 00 	mov	word ptr [623Ch],0h
356F:01EE FF 06 3E 62     	inc	word ptr [623Eh]
