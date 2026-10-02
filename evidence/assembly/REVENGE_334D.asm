;;; Segment 334D (334D:0000)
334D:0000 CB                                              .               

;; DrawActiveTextWindowFrame_0001: 334D:0001
;;   Called from:
;;     0D73:2AE1 (in OpenModalTextWindow_2A5D)
;;     1A1F:41D7 (in RunGameOptionsMenu_417F)
DrawActiveTextWindowFrame_0001 proc
334D:0001 55              	push	bp
334D:0002 8B EC           	mov	bp,sp
334D:0004 83 EC 0C        	sub	sp,0Ch
334D:0007 56              	push	si
334D:0008 57              	push	di
334D:0009 C7 46 F6 05 00  	mov	word ptr [bp-0Ah],5h
334D:000E 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
334D:0013 75 05           	jnz	001Ah

l334D_0015:
334D:0015 C7 46 F6 06 00  	mov	word ptr [bp-0Ah],6h

l334D_001A:
334D:001A A1 30 62        	mov	ax,[6230h]
334D:001D 89 46 F4        	mov	[bp-0Ch],ax
334D:0020 8B 36 32 62     	mov	si,[6232h]
334D:0024 8B 5E 06        	mov	bx,[bp+6h]
334D:0027 D1 E3           	shl	bx,1h
334D:0029 D1 E3           	shl	bx,1h
334D:002B C4 9F C2 08     	les	bx,[bx+8C2h]
334D:002F 8C 46 FE        	mov	[bp-2h],es
334D:0032 89 5E FC        	mov	[bp-4h],bx
334D:0035 C4 5E FC        	les	bx,[bp-4h]
334D:0038 26 8B 07        	mov	ax,es:[bx]
334D:003B 8A 4E F6        	mov	cl,[bp-0Ah]
334D:003E D3 E0           	shl	ax,cl
334D:0040 C4 1E B5 99     	les	bx,[99B5h]
334D:0044 03 D8           	add	bx,ax
334D:0046 8C 46 FA        	mov	[bp-6h],es
334D:0049 89 5E F8        	mov	[bp-8h],bx
334D:004C 8B C6           	mov	ax,si
334D:004E 48              	dec	ax
334D:004F 50              	push	ax
334D:0050 8B 46 F4        	mov	ax,[bp-0Ch]
334D:0053 48              	dec	ax
334D:0054 50              	push	ax
334D:0055 FF 76 FA        	push	word ptr [bp-6h]
334D:0058 FF 76 F8        	push	word ptr [bp-8h]
334D:005B 9A 05 2F 00 08  	call	far 0800h:2F05h
334D:0060 83 C4 08        	add	sp,8h
334D:0063 C4 5E FC        	les	bx,[bp-4h]
334D:0066 26 8B 47 02     	mov	ax,es:[bx+2h]
334D:006A 8A 4E F6        	mov	cl,[bp-0Ah]
334D:006D D3 E0           	shl	ax,cl
334D:006F C4 1E B5 99     	les	bx,[99B5h]
334D:0073 03 D8           	add	bx,ax
334D:0075 8C 46 FA        	mov	[bp-6h],es
334D:0078 89 5E F8        	mov	[bp-8h],bx
334D:007B 8B C6           	mov	ax,si
334D:007D 48              	dec	ax
334D:007E 50              	push	ax
334D:007F 8B 46 F4        	mov	ax,[bp-0Ch]
334D:0082 03 06 34 62     	add	ax,[6234h]
334D:0086 50              	push	ax
334D:0087 FF 76 FA        	push	word ptr [bp-6h]
334D:008A FF 76 F8        	push	word ptr [bp-8h]
334D:008D 9A 05 2F 00 08  	call	far 0800h:2F05h
334D:0092 83 C4 08        	add	sp,8h
334D:0095 C4 5E FC        	les	bx,[bp-4h]
334D:0098 26 8B 47 04     	mov	ax,es:[bx+4h]
334D:009C 8A 4E F6        	mov	cl,[bp-0Ah]
334D:009F D3 E0           	shl	ax,cl
334D:00A1 C4 1E B5 99     	les	bx,[99B5h]
334D:00A5 03 D8           	add	bx,ax
334D:00A7 8C 46 FA        	mov	[bp-6h],es
334D:00AA 89 5E F8        	mov	[bp-8h],bx
334D:00AD 8B C6           	mov	ax,si
334D:00AF 03 06 36 62     	add	ax,[6236h]
334D:00B3 50              	push	ax
334D:00B4 8B 46 F4        	mov	ax,[bp-0Ch]
334D:00B7 48              	dec	ax
334D:00B8 50              	push	ax
334D:00B9 FF 76 FA        	push	word ptr [bp-6h]
334D:00BC FF 76 F8        	push	word ptr [bp-8h]
334D:00BF 9A 05 2F 00 08  	call	far 0800h:2F05h
334D:00C4 83 C4 08        	add	sp,8h
334D:00C7 C4 5E FC        	les	bx,[bp-4h]
334D:00CA 26 8B 47 06     	mov	ax,es:[bx+6h]
334D:00CE 8A 4E F6        	mov	cl,[bp-0Ah]
334D:00D1 D3 E0           	shl	ax,cl
334D:00D3 C4 1E B5 99     	les	bx,[99B5h]
334D:00D7 03 D8           	add	bx,ax
334D:00D9 8C 46 FA        	mov	[bp-6h],es
334D:00DC 89 5E F8        	mov	[bp-8h],bx
334D:00DF 8B C6           	mov	ax,si
334D:00E1 03 06 36 62     	add	ax,[6236h]
334D:00E5 50              	push	ax
334D:00E6 8B 46 F4        	mov	ax,[bp-0Ch]
334D:00E9 03 06 34 62     	add	ax,[6234h]
334D:00ED 50              	push	ax
334D:00EE FF 76 FA        	push	word ptr [bp-6h]
334D:00F1 FF 76 F8        	push	word ptr [bp-8h]
334D:00F4 9A 05 2F 00 08  	call	far 0800h:2F05h
334D:00F9 83 C4 08        	add	sp,8h
334D:00FC BF 04 00        	mov	di,4h
334D:00FF B8 01 00        	mov	ax,1h
334D:0102 50              	push	ax
334D:0103 FF 36 34 62     	push	word ptr [6234h]
334D:0107 8B C6           	mov	ax,si
334D:0109 48              	dec	ax
334D:010A 50              	push	ax
334D:010B FF 76 F4        	push	word ptr [bp-0Ch]
334D:010E 57              	push	di
334D:010F FF 76 FE        	push	word ptr [bp-2h]
334D:0112 FF 76 FC        	push	word ptr [bp-4h]
334D:0115 9A 08 00 86 33  	call	far 3386h:0008h
334D:011A 83 C4 0E        	add	sp,0Eh
334D:011D 8B F8           	mov	di,ax
334D:011F 33 C0           	xor	ax,ax
334D:0121 50              	push	ax
334D:0122 FF 36 36 62     	push	word ptr [6236h]
334D:0126 56              	push	si
334D:0127 A1 30 62        	mov	ax,[6230h]
334D:012A 48              	dec	ax
334D:012B 50              	push	ax
334D:012C 57              	push	di
334D:012D FF 76 FE        	push	word ptr [bp-2h]
334D:0130 FF 76 FC        	push	word ptr [bp-4h]
334D:0133 9A 08 00 86 33  	call	far 3386h:0008h
334D:0138 83 C4 0E        	add	sp,0Eh
334D:013B 8B F8           	mov	di,ax
334D:013D 33 C0           	xor	ax,ax
334D:013F 50              	push	ax
334D:0140 FF 36 36 62     	push	word ptr [6236h]
334D:0144 56              	push	si
334D:0145 A1 30 62        	mov	ax,[6230h]
334D:0148 03 06 34 62     	add	ax,[6234h]
334D:014C 50              	push	ax
334D:014D 57              	push	di
334D:014E FF 76 FE        	push	word ptr [bp-2h]
334D:0151 FF 76 FC        	push	word ptr [bp-4h]
334D:0154 9A 08 00 86 33  	call	far 3386h:0008h
334D:0159 83 C4 0E        	add	sp,0Eh
334D:015C 8B F8           	mov	di,ax
334D:015E B8 01 00        	mov	ax,1h
334D:0161 50              	push	ax
334D:0162 FF 36 34 62     	push	word ptr [6234h]
334D:0166 8B C6           	mov	ax,si
334D:0168 03 06 36 62     	add	ax,[6236h]
334D:016C 50              	push	ax
334D:016D FF 76 F4        	push	word ptr [bp-0Ch]
334D:0170 57              	push	di
334D:0171 FF 76 FE        	push	word ptr [bp-2h]
334D:0174 FF 76 FC        	push	word ptr [bp-4h]
334D:0177 9A 08 00 86 33  	call	far 3386h:0008h
334D:017C 83 C4 0E        	add	sp,0Eh
334D:017F 8B F8           	mov	di,ax
