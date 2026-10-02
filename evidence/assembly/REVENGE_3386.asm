;;; Segment 3386 (3386:0000)
3386:0000 33 83 C4 0A 5F 5E 5D CB                         3..._^].        

;; DrawRepeatingFrameTileSequence_0008: 3386:0008
;;   Called from:
;;     334D:0115 (in DrawActiveTextWindowFrame_0001)
;;     334D:0133 (in DrawActiveTextWindowFrame_0001)
;;     334D:0154 (in DrawActiveTextWindowFrame_0001)
;;     334D:0177 (in DrawActiveTextWindowFrame_0001)
DrawRepeatingFrameTileSequence_0008 proc
3386:0008 55              	push	bp
3386:0009 8B EC           	mov	bp,sp
3386:000B 83 EC 06        	sub	sp,6h
3386:000E 56              	push	si
3386:000F 57              	push	di
3386:0010 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
3386:0015 75 05           	jnz	001Ch

l3386_0017:
3386:0017 B8 01 00        	mov	ax,1h
3386:001A EB 02           	jmp	001Eh

l3386_001C:
3386:001C 33 C0           	xor	ax,ax

l3386_001E:
3386:001E 05 05 00        	add	ax,5h
3386:0021 89 46 FA        	mov	[bp-6h],ax
3386:0024 8B 76 0A        	mov	si,[bp+0Ah]
3386:0027 33 FF           	xor	di,di
3386:0029 EB 54           	jmp	007Fh

l3386_002B:
3386:002B 8B C6           	mov	ax,si
3386:002D D1 E0           	shl	ax,1h
3386:002F C4 5E 06        	les	bx,[bp+6h]
3386:0032 03 D8           	add	bx,ax
3386:0034 26 8B 07        	mov	ax,es:[bx]
3386:0037 8A 4E FA        	mov	cl,[bp-6h]
3386:003A D3 E0           	shl	ax,cl
3386:003C C4 1E B5 99     	les	bx,[99B5h]
3386:0040 03 D8           	add	bx,ax
3386:0042 8C 46 FE        	mov	[bp-2h],es
3386:0045 89 5E FC        	mov	[bp-4h],bx
3386:0048 FF 76 0E        	push	word ptr [bp+0Eh]
3386:004B FF 76 0C        	push	word ptr [bp+0Ch]
3386:004E FF 76 FE        	push	word ptr [bp-2h]
3386:0051 FF 76 FC        	push	word ptr [bp-4h]
3386:0054 9A 05 2F 00 08  	call	far 0800h:2F05h
3386:0059 83 C4 08        	add	sp,8h
3386:005C 83 7E 12 00     	cmp	word ptr [bp+12h],0h
3386:0060 74 05           	jz	0067h

l3386_0062:
3386:0062 FF 46 0C        	inc	word ptr [bp+0Ch]
3386:0065 EB 03           	jmp	006Ah

l3386_0067:
3386:0067 FF 46 0E        	inc	word ptr [bp+0Eh]

l3386_006A:
3386:006A 46              	inc	si
3386:006B 8B C6           	mov	ax,si
3386:006D D1 E0           	shl	ax,1h
3386:006F C4 5E 06        	les	bx,[bp+6h]
3386:0072 03 D8           	add	bx,ax
3386:0074 26 81 3F FF 00  	cmp	word ptr es:[bx],0FFh
3386:0079 75 03           	jnz	007Eh

l3386_007B:
3386:007B 8B 76 0A        	mov	si,[bp+0Ah]

l3386_007E:
3386:007E 47              	inc	di

l3386_007F:
3386:007F 3B 7E 10        	cmp	di,[bp+10h]
3386:0082 7C A7           	jl	002Bh

l3386_0084:
3386:0084 EB 01           	jmp	0087h

l3386_0086:
3386:0086 46              	inc	si

l3386_0087:
3386:0087 8B C6           	mov	ax,si
3386:0089 D1 E0           	shl	ax,1h
3386:008B C4 5E 06        	les	bx,[bp+6h]
3386:008E 03 D8           	add	bx,ax
3386:0090 26 81 3F FF 00  	cmp	word ptr es:[bx],0FFh
3386:0095 75 EF           	jnz	0086h

l3386_0097:
3386:0097 46              	inc	si
3386:0098 8B C6           	mov	ax,si
3386:009A EB 00           	jmp	009Ch

l3386_009C:
3386:009C 5F              	pop	di
3386:009D 5E              	pop	si
3386:009E 8B E5           	mov	sp,bp
