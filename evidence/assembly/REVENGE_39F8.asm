;;; Segment 39F8 (39F8:0000)

;; FarStringTokenize: 39F8:0000
;;   Called from:
;;     2C7F:05A6 (in LoadMediaConfiguration_047A)
;;     2C7F:067D (in ApplyVideoConfigOption_0669)
;;     2C7F:0741 (in ApplyMusicConfigOption_072D)
;;     2C7F:07E2 (in ApplySoundConfigOption_07CE)
;;     2C7F:085F (in ApplySoundConfigOption_07CE)
;;     2C7F:08DE (in ApplyInputDeviceConfigOption_08CA)
FarStringTokenize proc
39F8:0000 55              	push	bp
39F8:0001 8B EC           	mov	bp,sp
39F8:0003 83 EC 08        	sub	sp,8h
39F8:0006 8B 46 06        	mov	ax,[bp+6h]
39F8:0009 0B 46 08        	or	ax,[bp+8h]
39F8:000C 74 0B           	jz	0019h

l39F8_000E:
39F8:000E C4 5E 06        	les	bx,[bp+6h]
39F8:0011 8C 06 90 B8     	mov	[0B890h],es
39F8:0015 89 1E 8E B8     	mov	[0B88Eh],bx

l39F8_0019:
39F8:0019 EB 37           	jmp	0052h

l39F8_001B:
39F8:001B C4 5E 0A        	les	bx,[bp+0Ah]
39F8:001E 8C 46 FA        	mov	[bp-6h],es
39F8:0021 89 5E F8        	mov	[bp-8h],bx
39F8:0024 EB 14           	jmp	003Ah

l39F8_0026:
39F8:0026 C4 5E F8        	les	bx,[bp-8h]
39F8:0029 26 8A 07        	mov	al,es:[bx]
39F8:002C C4 1E 8E B8     	les	bx,[0B88Eh]
39F8:0030 26 3A 07        	cmp	al,es:[bx]
39F8:0033 75 02           	jnz	0037h

l39F8_0035:
39F8:0035 EB 0C           	jmp	0043h

l39F8_0037:
39F8:0037 FF 46 F8        	inc	word ptr [bp-8h]

l39F8_003A:
39F8:003A C4 5E F8        	les	bx,[bp-8h]
39F8:003D 26 80 3F 00     	cmp	byte ptr es:[bx],0h
39F8:0041 75 E3           	jnz	0026h

l39F8_0043:
39F8:0043 C4 5E F8        	les	bx,[bp-8h]
39F8:0046 26 80 3F 00     	cmp	byte ptr es:[bx],0h
39F8:004A 75 02           	jnz	004Eh

l39F8_004C:
39F8:004C EB 0E           	jmp	005Ch

l39F8_004E:
39F8:004E FF 06 8E B8     	inc	word ptr [0B88Eh]

l39F8_0052:
39F8:0052 C4 1E 8E B8     	les	bx,[0B88Eh]
39F8:0056 26 80 3F 00     	cmp	byte ptr es:[bx],0h
39F8:005A 75 BF           	jnz	001Bh

l39F8_005C:
39F8:005C C4 1E 8E B8     	les	bx,[0B88Eh]
39F8:0060 26 80 3F 00     	cmp	byte ptr es:[bx],0h
39F8:0064 75 06           	jnz	006Ch

l39F8_0066:
39F8:0066 33 D2           	xor	dx,dx
39F8:0068 33 C0           	xor	ax,ax
39F8:006A EB 5C           	jmp	00C8h

l39F8_006C:
39F8:006C C4 1E 8E B8     	les	bx,[0B88Eh]
39F8:0070 8C 46 FE        	mov	[bp-2h],es
39F8:0073 89 5E FC        	mov	[bp-4h],bx
39F8:0076 EB 3E           	jmp	00B6h

l39F8_0078:
39F8:0078 C4 5E 0A        	les	bx,[bp+0Ah]
39F8:007B 8C 46 FA        	mov	[bp-6h],es
39F8:007E 89 5E F8        	mov	[bp-8h],bx
39F8:0081 EB 26           	jmp	00A9h

l39F8_0083:
39F8:0083 C4 5E F8        	les	bx,[bp-8h]
39F8:0086 26 8A 07        	mov	al,es:[bx]
39F8:0089 C4 1E 8E B8     	les	bx,[0B88Eh]
39F8:008D 26 3A 07        	cmp	al,es:[bx]
39F8:0090 75 14           	jnz	00A6h

l39F8_0092:
39F8:0092 C4 1E 8E B8     	les	bx,[0B88Eh]
39F8:0096 26 C6 07 00     	mov	byte ptr es:[bx],0h
39F8:009A FF 06 8E B8     	inc	word ptr [0B88Eh]
39F8:009E 8B 56 FE        	mov	dx,[bp-2h]
39F8:00A1 8B 46 FC        	mov	ax,[bp-4h]
39F8:00A4 EB 22           	jmp	00C8h

l39F8_00A6:
39F8:00A6 FF 46 F8        	inc	word ptr [bp-8h]

l39F8_00A9:
39F8:00A9 C4 5E F8        	les	bx,[bp-8h]
39F8:00AC 26 80 3F 00     	cmp	byte ptr es:[bx],0h
39F8:00B0 75 D1           	jnz	0083h

l39F8_00B2:
39F8:00B2 FF 06 8E B8     	inc	word ptr [0B88Eh]

l39F8_00B6:
39F8:00B6 C4 1E 8E B8     	les	bx,[0B88Eh]
39F8:00BA 26 80 3F 00     	cmp	byte ptr es:[bx],0h
39F8:00BE 75 B8           	jnz	0078h
