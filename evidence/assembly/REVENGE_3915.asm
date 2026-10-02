;;; Segment 3915 (3915:0000)
3915:0000 EB 00                                           ..              

l3913_0022:
3913:0022 5D              	pop	bp
3913:0023 CB              	retf

;; DOS_CreateFile: 3915:0004
;;   Called from:
;;     3915:00C1 (in CRT_OpenFile)
;;     3915:00E5 (in CRT_OpenFile)
DOS_CreateFile proc
3915:0004 55              	push	bp
3915:0005 8B EC           	mov	bp,sp
3915:0007 1E              	push	ds
3915:0008 8B 4E 04        	mov	cx,[bp+4h]
3915:000B B4 3C           	mov	ah,3Ch
3915:000D C5 56 06        	lds	dx,[bp+6h]
3915:0010 CD 21           	int	21h
3915:0012 1F              	pop	ds
3915:0013 72 02           	jc	0017h

l3915_0015:
3915:0015 EB 08           	jmp	001Fh

l3915_0017:
3915:0017 50              	push	ax
3915:0018 9A 04 00 C3 38  	call	far 38C3h:0004h
3915:001D EB 00           	jmp	001Fh

l3915_001F:
3915:001F 5D              	pop	bp
3915:0020 C2 06 00        	ret	6h

;; SetFileEndAtCurrentPosition: 3915:0023
;;   Called from:
;;     3915:0154 (in CRT_OpenFile)
SetFileEndAtCurrentPosition proc
3915:0023 55              	push	bp
3915:0024 8B EC           	mov	bp,sp
3915:0026 8B 5E 04        	mov	bx,[bp+4h]
3915:0029 2B C9           	sub	cx,cx
3915:002B 2B D2           	sub	dx,dx
3915:002D B4 40           	mov	ah,40h
3915:002F CD 21           	int	21h
3915:0031 EB 00           	jmp	0033h

l3915_0033:
3915:0033 5D              	pop	bp
3915:0034 C2 02 00        	ret	2h

;; CRT_OpenFile: 3915:0037
;;   Called from:
;;     2C7F:0491 (in LoadMediaConfiguration_047A)
;;     3390:015F (in OpenTrackedFile)
;;     3390:0178 (in OpenTrackedFile)
;;     3390:062D (in CanOpenFileForRead)
;;     3390:067A (in CanOpenFileForWrite)
;;     3390:0B34 (in InitializeResourceCache)
;;     3477:0027 (in LoadFontResource_000B)
CRT_OpenFile proc
3915:0037 55              	push	bp
3915:0038 8B EC           	mov	bp,sp
3915:003A 83 EC 04        	sub	sp,4h
3915:003D 56              	push	si
3915:003E 57              	push	di
3915:003F 8B 7E 0A        	mov	di,[bp+0Ah]
3915:0042 F7 C7 00 C0     	test	di,0C000h
3915:0046 75 08           	jnz	0050h

l3915_0048:
3915:0048 A1 52 71        	mov	ax,[7152h]
3915:004B 25 00 C0        	and	ax,0C000h
3915:004E 0B F8           	or	di,ax

l3915_0050:
3915:0050 F7 C7 00 01     	test	di,100h
3915:0054 75 03           	jnz	0059h

l3915_0056:
3915:0056 E9 9F 00        	jmp	00F8h

l3915_0059:
3915:0059 A1 54 71        	mov	ax,[7154h]
3915:005C 21 46 0C        	and	[bp+0Ch],ax
3915:005F 8B 46 0C        	mov	ax,[bp+0Ch]
3915:0062 A9 80 01        	test	ax,180h
3915:0065 75 09           	jnz	0070h

l3915_0067:
3915:0067 B8 01 00        	mov	ax,1h
3915:006A 50              	push	ax
3915:006B 9A 04 00 C3 38  	call	far 38C3h:0004h

l3915_0070:
3915:0070 33 C0           	xor	ax,ax
3915:0072 50              	push	ax
3915:0073 FF 76 08        	push	word ptr [bp+8h]
3915:0076 FF 76 06        	push	word ptr [bp+6h]
3915:0079 9A 0E 00 89 39  	call	far 3989h:000Eh
3915:007E 83 C4 06        	add	sp,6h
3915:0081 89 46 FC        	mov	[bp-4h],ax
3915:0084 3D FF FF        	cmp	ax,0FFFFh
3915:0087 75 13           	jnz	009Ch

l3915_0089:
3915:0089 F7 46 0C 80 00  	test	word ptr [bp+0Ch],80h
3915:008E 74 04           	jz	0094h

l3915_0090:
3915:0090 33 C0           	xor	ax,ax
3915:0092 EB 03           	jmp	0097h

l3915_0094:
3915:0094 B8 01 00        	mov	ax,1h

l3915_0097:
3915:0097 89 46 FC        	mov	[bp-4h],ax
3915:009A EB 16           	jmp	00B2h

l3915_009C:
3915:009C F7 C7 00 04     	test	di,400h
3915:00A0 74 0E           	jz	00B0h

l3915_00A2:
3915:00A2 B8 50 00        	mov	ax,50h
3915:00A5 50              	push	ax
3915:00A6 9A 04 00 C3 38  	call	far 38C3h:0004h
3915:00AB E9 F0 00        	jmp	019Eh
3915:00AE                                           EB 02               ..

l3915_00B0:
3915:00B0 EB 46           	jmp	00F8h

l3915_00B2:
3915:00B2 F7 C7 F0 00     	test	di,0F0h
3915:00B6 74 24           	jz	00DCh

l3915_00B8:
3915:00B8 FF 76 08        	push	word ptr [bp+8h]
3915:00BB FF 76 06        	push	word ptr [bp+6h]
3915:00BE 33 C0           	xor	ax,ax
3915:00C0 50              	push	ax
3915:00C1 E8 40 FF        	call	0004h
3915:00C4 8B F0           	mov	si,ax
3915:00C6 8B C6           	mov	ax,si
3915:00C8 0B C0           	or	ax,ax
3915:00CA 7D 05           	jge	00D1h

l3915_00CC:
3915:00CC 8B C6           	mov	ax,si
3915:00CE E9 CD 00        	jmp	019Eh

l3915_00D1:
3915:00D1 56              	push	si
3915:00D2 9A 0F 00 39 39  	call	far 3939h:000Fh
3915:00D7 59              	pop	cx
3915:00D8 EB 23           	jmp	00FDh
3915:00DA                               EB 19                       ..    

l3915_00DC:
3915:00DC FF 76 08        	push	word ptr [bp+8h]
3915:00DF FF 76 06        	push	word ptr [bp+6h]
3915:00E2 FF 76 FC        	push	word ptr [bp-4h]
3915:00E5 E8 1C FF        	call	0004h
3915:00E8 8B F0           	mov	si,ax
3915:00EA 8B C6           	mov	ax,si
3915:00EC 0B C0           	or	ax,ax
3915:00EE 7D 05           	jge	00F5h

l3915_00F0:
3915:00F0 8B C6           	mov	ax,si
3915:00F2 E9 A9 00        	jmp	019Eh

l3915_00F5:
3915:00F5 E9 81 00        	jmp	0179h

l3915_00F8:
3915:00F8 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h

l3915_00FD:
3915:00FD 57              	push	di
3915:00FE FF 76 08        	push	word ptr [bp+8h]
3915:0101 FF 76 06        	push	word ptr [bp+6h]
3915:0104 9A 04 00 2F 39  	call	far 392Fh:0004h
3915:0109 83 C4 06        	add	sp,6h
3915:010C 8B F0           	mov	si,ax
3915:010E 8B C6           	mov	ax,si
3915:0110 0B C0           	or	ax,ax
3915:0112 7C 65           	jl	0179h

l3915_0114:
3915:0114 33 C0           	xor	ax,ax
3915:0116 50              	push	ax
3915:0117 56              	push	si
3915:0118 9A 01 00 34 39  	call	far 3934h:0001h
3915:011D 59              	pop	cx
3915:011E 59              	pop	cx
3915:011F 89 46 FE        	mov	[bp-2h],ax
3915:0122 A9 80 00        	test	ax,80h
3915:0125 74 26           	jz	014Dh

l3915_0127:
3915:0127 81 CF 00 20     	or	di,2000h
3915:012B F7 C7 00 80     	test	di,8000h
3915:012F 74 1A           	jz	014Bh

l3915_0131:
3915:0131 8B 46 FE        	mov	ax,[bp-2h]
3915:0134 25 FF 00        	and	ax,0FFh
3915:0137 0D 20 00        	or	ax,20h
3915:013A 33 D2           	xor	dx,dx
3915:013C 52              	push	dx
3915:013D 50              	push	ax
3915:013E B8 01 00        	mov	ax,1h
3915:0141 50              	push	ax
3915:0142 56              	push	si
3915:0143 9A 01 00 34 39  	call	far 3934h:0001h
3915:0148 83 C4 08        	add	sp,8h

l3915_014B:
3915:014B EB 0A           	jmp	0157h

l3915_014D:
3915:014D F7 C7 00 02     	test	di,200h
3915:0151 74 04           	jz	0157h

l3915_0153:
3915:0153 56              	push	si
3915:0154 E8 CC FE        	call	0023h

l3915_0157:
3915:0157 83 7E FC 00     	cmp	word ptr [bp-4h],0h
3915:015B 74 1C           	jz	0179h

l3915_015D:
3915:015D F7 C7 F0 00     	test	di,0F0h
3915:0161 74 16           	jz	0179h

l3915_0163:
3915:0163 B8 01 00        	mov	ax,1h
3915:0166 50              	push	ax
3915:0167 B8 01 00        	mov	ax,1h
3915:016A 50              	push	ax
3915:016B FF 76 08        	push	word ptr [bp+8h]
3915:016E FF 76 06        	push	word ptr [bp+6h]
3915:0171 9A 0E 00 89 39  	call	far 3989h:000Eh
3915:0176 83 C4 08        	add	sp,8h

l3915_0179:
3915:0179 0B F6           	or	si,si
3915:017B 7C 1D           	jl	019Ah

l3915_017D:
3915:017D F7 C7 00 03     	test	di,300h
3915:0181 74 05           	jz	0188h

l3915_0183:
3915:0183 B8 00 10        	mov	ax,1000h
3915:0186 EB 02           	jmp	018Ah

l3915_0188:
3915:0188 33 C0           	xor	ax,ax

l3915_018A:
3915:018A 8B D7           	mov	dx,di
3915:018C 81 E2 FF F8     	and	dx,0F8FFh
3915:0190 0B C2           	or	ax,dx
3915:0192 8B DE           	mov	bx,si
3915:0194 D1 E3           	shl	bx,1h
3915:0196 89 87 2A 71     	mov	[bx+712Ah],ax

l3915_019A:
3915:019A 8B C6           	mov	ax,si
3915:019C EB 00           	jmp	019Eh

l3915_019E:
3915:019E 5F              	pop	di
3915:019F 5E              	pop	si
