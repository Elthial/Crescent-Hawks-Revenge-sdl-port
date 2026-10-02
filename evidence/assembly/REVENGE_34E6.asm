;;; Segment 34E6 (34E6:0000)

l34DF_0070:
34DF:0070 5E              	pop	si
34DF:0071 5D              	pop	bp
34DF:0072 CB              	retf

;; PollUiRegionSelection_0003: 34E6:0003
;;   Called from:
;;     3568:0037 (in RunUiRegionSelectionLoop_0007)
;;     358E:0039 (in RunSingleUiRegionSelection_000C)
PollUiRegionSelection_0003 proc
34E6:0003 55              	push	bp
34E6:0004 8B EC           	mov	bp,sp
34E6:0006 83 EC 22        	sub	sp,22h
34E6:0009 56              	push	si
34E6:000A 57              	push	di
34E6:000B 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:000F B1 04           	mov	cl,4h
34E6:0011 D3 E3           	shl	bx,cl
34E6:0013 81 C3 AA 07     	add	bx,7AAh
34E6:0017 1E              	push	ds
34E6:0018 07              	pop	es
34E6:0019 26 8B 77 08     	mov	si,es:[bx+8h]
34E6:001D A1 D0 B6        	mov	ax,[0B6D0h]
34E6:0020 89 46 F0        	mov	[bp-10h],ax
34E6:0023 33 FF           	xor	di,di
34E6:0025 89 7E F2        	mov	[bp-0Eh],di
34E6:0028 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
34E6:002D C7 46 EA 01 00  	mov	word ptr [bp-16h],1h
34E6:0032 0B F6           	or	si,si
34E6:0034 75 1C           	jnz	0052h

l34E6_0036:
34E6:0036 83 3E D2 B6 00  	cmp	word ptr [0B6D2h],0h
34E6:003B 74 15           	jz	0052h

l34E6_003D:
34E6:003D 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0041 B1 04           	mov	cl,4h
34E6:0043 D3 E3           	shl	bx,cl
34E6:0045 81 C3 AA 07     	add	bx,7AAh
34E6:0049 1E              	push	ds
34E6:004A 07              	pop	es
34E6:004B 26 8B 47 06     	mov	ax,es:[bx+6h]
34E6:004F 89 46 EA        	mov	[bp-16h],ax

l34E6_0052:
34E6:0052 83 3E B2 7F 00  	cmp	word ptr [7FB2h],0h
34E6:0057 74 03           	jz	005Ch

l34E6_0059:
34E6:0059 E9 49 03        	jmp	03A5h

l34E6_005C:
34E6:005C 9A F6 34 00 08  	call	far 0800h:34F6h
34E6:0061 A1 A0 7F        	mov	ax,[7FA0h]
34E6:0064 89 46 DE        	mov	[bp-22h],ax
34E6:0067 A1 A4 7F        	mov	ax,[7FA4h]
34E6:006A 89 46 E0        	mov	[bp-20h],ax
34E6:006D C7 06 A4 7F 00 00 	mov	word ptr [7FA4h],0h
34E6:0073 9A F4 34 00 08  	call	far 0800h:34F4h
34E6:0078 83 7E E0 00     	cmp	word ptr [bp-20h],0h
34E6:007C 74 1B           	jz	0099h

l34E6_007E:
34E6:007E 83 7E DE 00     	cmp	word ptr [bp-22h],0h
34E6:0082 74 15           	jz	0099h

l34E6_0084:
34E6:0084 8B 46 DE        	mov	ax,[bp-22h]
34E6:0087 25 02 00        	and	ax,2h
34E6:008A 3D 02 00        	cmp	ax,2h
34E6:008D 75 0A           	jnz	0099h

l34E6_008F:
34E6:008F C7 46 E0 00 00  	mov	word ptr [bp-20h],0h
34E6:0094 C7 46 F2 1B 00  	mov	word ptr [bp-0Eh],1Bh

l34E6_0099:
34E6:0099 C7 46 F4 00 00  	mov	word ptr [bp-0Ch],0h
34E6:009E E9 F9 02        	jmp	039Ah

l34E6_00A1:
34E6:00A1 8B 46 06        	mov	ax,[bp+6h]
34E6:00A4 03 46 F4        	add	ax,[bp-0Ch]
34E6:00A7 89 46 FE        	mov	[bp-2h],ax
34E6:00AA A1 30 62        	mov	ax,[6230h]
34E6:00AD D1 E0           	shl	ax,1h
34E6:00AF D1 E0           	shl	ax,1h
34E6:00B1 D1 E0           	shl	ax,1h
34E6:00B3 8B 5E FE        	mov	bx,[bp-2h]
34E6:00B6 B1 04           	mov	cl,4h
34E6:00B8 D3 E3           	shl	bx,cl
34E6:00BA 81 C3 AA 07     	add	bx,7AAh
34E6:00BE 50              	push	ax
34E6:00BF 1E              	push	ds
34E6:00C0 07              	pop	es
34E6:00C1 26 8B 07        	mov	ax,es:[bx]
34E6:00C4 50              	push	ax
34E6:00C5 A0 66 86        	mov	al,[8666h]
34E6:00C8 98              	cbw
34E6:00C9 8B D0           	mov	dx,ax
34E6:00CB 58              	pop	ax
34E6:00CC F7 E2           	mul	dx
34E6:00CE 5A              	pop	dx
34E6:00CF 03 D0           	add	dx,ax
34E6:00D1 89 56 F6        	mov	[bp-0Ah],dx
34E6:00D4 A1 32 62        	mov	ax,[6232h]
34E6:00D7 D1 E0           	shl	ax,1h
34E6:00D9 D1 E0           	shl	ax,1h
34E6:00DB D1 E0           	shl	ax,1h
34E6:00DD 8B 5E FE        	mov	bx,[bp-2h]
34E6:00E0 B1 04           	mov	cl,4h
34E6:00E2 D3 E3           	shl	bx,cl
34E6:00E4 81 C3 AA 07     	add	bx,7AAh
34E6:00E8 50              	push	ax
34E6:00E9 1E              	push	ds
34E6:00EA 07              	pop	es
34E6:00EB 26 8B 47 02     	mov	ax,es:[bx+2h]
34E6:00EF 50              	push	ax
34E6:00F0 A0 BB 99        	mov	al,[99BBh]
34E6:00F3 98              	cbw
34E6:00F4 8B D0           	mov	dx,ax
34E6:00F6 58              	pop	ax
34E6:00F7 F7 E2           	mul	dx
34E6:00F9 5A              	pop	dx
34E6:00FA 03 D0           	add	dx,ax
34E6:00FC 89 56 F8        	mov	[bp-8h],dx
34E6:00FF 8B 5E FE        	mov	bx,[bp-2h]
34E6:0102 B1 04           	mov	cl,4h
34E6:0104 D3 E3           	shl	bx,cl
34E6:0106 81 C3 AA 07     	add	bx,7AAh
34E6:010A 1E              	push	ds
34E6:010B 07              	pop	es
34E6:010C 26 8B 47 04     	mov	ax,es:[bx+4h]
34E6:0110 50              	push	ax
34E6:0111 A0 66 86        	mov	al,[8666h]
34E6:0114 98              	cbw
34E6:0115 8B D0           	mov	dx,ax
34E6:0117 58              	pop	ax
34E6:0118 F7 E2           	mul	dx
34E6:011A 03 46 F6        	add	ax,[bp-0Ah]
34E6:011D 48              	dec	ax
34E6:011E 89 46 FA        	mov	[bp-6h],ax
34E6:0121 8B 5E FE        	mov	bx,[bp-2h]
34E6:0124 B1 04           	mov	cl,4h
34E6:0126 D3 E3           	shl	bx,cl
34E6:0128 81 C3 AA 07     	add	bx,7AAh
34E6:012C 1E              	push	ds
34E6:012D 07              	pop	es
34E6:012E 26 8B 47 06     	mov	ax,es:[bx+6h]
34E6:0132 50              	push	ax
34E6:0133 A0 BB 99        	mov	al,[99BBh]
34E6:0136 98              	cbw
34E6:0137 8B D0           	mov	dx,ax
34E6:0139 58              	pop	ax
34E6:013A F7 E2           	mul	dx
34E6:013C 03 46 F8        	add	ax,[bp-8h]
34E6:013F 48              	dec	ax
34E6:0140 89 46 FC        	mov	[bp-4h],ax
34E6:0143 9A F6 34 00 08  	call	far 0800h:34F6h
34E6:0148 A1 AA 7F        	mov	ax,[7FAAh]
34E6:014B 89 46 E2        	mov	[bp-1Eh],ax
34E6:014E FF 76 FC        	push	word ptr [bp-4h]
34E6:0151 FF 76 FA        	push	word ptr [bp-6h]
34E6:0154 FF 76 F8        	push	word ptr [bp-8h]
34E6:0157 FF 76 F6        	push	word ptr [bp-0Ah]
34E6:015A 9A 25 38 00 08  	call	far 0800h:3825h
34E6:015F 83 C4 08        	add	sp,8h
34E6:0162 0B C0           	or	ax,ax
34E6:0164 75 03           	jnz	0169h

l34E6_0166:
34E6:0166 E9 29 02        	jmp	0392h

l34E6_0169:
34E6:0169 9A F4 34 00 08  	call	far 0800h:34F4h
34E6:016E 8B 46 E2        	mov	ax,[bp-1Eh]
34E6:0171 2B 46 F8        	sub	ax,[bp-8h]
34E6:0174 50              	push	ax
34E6:0175 A0 BB 99        	mov	al,[99BBh]
34E6:0178 98              	cbw
34E6:0179 8B D8           	mov	bx,ax
34E6:017B 58              	pop	ax
34E6:017C 99              	cwd
34E6:017D F7 FB           	idiv	bx
34E6:017F 89 46 E4        	mov	[bp-1Ch],ax
34E6:0182 3B 76 E4        	cmp	si,[bp-1Ch]
34E6:0185 75 0B           	jnz	0192h

l34E6_0187:
34E6:0187 A1 D0 B6        	mov	ax,[0B6D0h]
34E6:018A 3B 46 FE        	cmp	ax,[bp-2h]
34E6:018D 75 03           	jnz	0192h

l34E6_018F:
34E6:018F E9 DF 01        	jmp	0371h

l34E6_0192:
34E6:0192 A1 30 62        	mov	ax,[6230h]
34E6:0195 D1 E0           	shl	ax,1h
34E6:0197 D1 E0           	shl	ax,1h
34E6:0199 D1 E0           	shl	ax,1h
34E6:019B 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:019F B1 04           	mov	cl,4h
34E6:01A1 D3 E3           	shl	bx,cl
34E6:01A3 81 C3 AA 07     	add	bx,7AAh
34E6:01A7 50              	push	ax
34E6:01A8 1E              	push	ds
34E6:01A9 07              	pop	es
34E6:01AA 26 8B 07        	mov	ax,es:[bx]
34E6:01AD 50              	push	ax
34E6:01AE A0 66 86        	mov	al,[8666h]
34E6:01B1 98              	cbw
34E6:01B2 8B D0           	mov	dx,ax
34E6:01B4 58              	pop	ax
34E6:01B5 F7 E2           	mul	dx
34E6:01B7 5A              	pop	dx
34E6:01B8 03 D0           	add	dx,ax
34E6:01BA 89 56 EE        	mov	[bp-12h],dx
34E6:01BD A1 32 62        	mov	ax,[6232h]
34E6:01C0 D1 E0           	shl	ax,1h
34E6:01C2 D1 E0           	shl	ax,1h
34E6:01C4 D1 E0           	shl	ax,1h
34E6:01C6 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:01CA B1 04           	mov	cl,4h
34E6:01CC D3 E3           	shl	bx,cl
34E6:01CE 81 C3 AA 07     	add	bx,7AAh
34E6:01D2 50              	push	ax
34E6:01D3 1E              	push	ds
34E6:01D4 07              	pop	es
34E6:01D5 26 8B 47 02     	mov	ax,es:[bx+2h]
34E6:01D9 50              	push	ax
34E6:01DA A0 BB 99        	mov	al,[99BBh]
34E6:01DD 98              	cbw
34E6:01DE 8B D0           	mov	dx,ax
34E6:01E0 58              	pop	ax
34E6:01E1 F7 E2           	mul	dx
34E6:01E3 5A              	pop	dx
34E6:01E4 03 D0           	add	dx,ax
34E6:01E6 89 56 E8        	mov	[bp-18h],dx
34E6:01E9 C7 46 EA 01 00  	mov	word ptr [bp-16h],1h
34E6:01EE 0B F6           	or	si,si
34E6:01F0 75 1C           	jnz	020Eh

l34E6_01F2:
34E6:01F2 83 3E D2 B6 00  	cmp	word ptr [0B6D2h],0h
34E6:01F7 74 15           	jz	020Eh

l34E6_01F9:
34E6:01F9 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:01FD B1 04           	mov	cl,4h
34E6:01FF D3 E3           	shl	bx,cl
34E6:0201 81 C3 AA 07     	add	bx,7AAh
34E6:0205 1E              	push	ds
34E6:0206 07              	pop	es
34E6:0207 26 8B 47 06     	mov	ax,es:[bx+6h]
34E6:020B 89 46 EA        	mov	[bp-16h],ax

l34E6_020E:
34E6:020E 9A 68 39 00 08  	call	far 0800h:3968h
34E6:0213 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0217 B1 04           	mov	cl,4h
34E6:0219 D3 E3           	shl	bx,cl
34E6:021B 81 C3 AA 07     	add	bx,7AAh
34E6:021F 1E              	push	ds
34E6:0220 07              	pop	es
34E6:0221 26 FF 77 0C     	push	word ptr es:[bx+0Ch]
34E6:0225 8B C6           	mov	ax,si
34E6:0227 03 46 EA        	add	ax,[bp-16h]
34E6:022A 50              	push	ax
34E6:022B A0 BB 99        	mov	al,[99BBh]
34E6:022E 98              	cbw
34E6:022F 8B D0           	mov	dx,ax
34E6:0231 58              	pop	ax
34E6:0232 F7 E2           	mul	dx
34E6:0234 03 46 E8        	add	ax,[bp-18h]
34E6:0237 48              	dec	ax
34E6:0238 50              	push	ax
34E6:0239 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:023D B1 04           	mov	cl,4h
34E6:023F D3 E3           	shl	bx,cl
34E6:0241 81 C3 AA 07     	add	bx,7AAh
34E6:0245 1E              	push	ds
34E6:0246 07              	pop	es
34E6:0247 26 8B 47 04     	mov	ax,es:[bx+4h]
34E6:024B 50              	push	ax
34E6:024C A0 66 86        	mov	al,[8666h]
34E6:024F 98              	cbw
34E6:0250 8B D0           	mov	dx,ax
34E6:0252 58              	pop	ax
34E6:0253 F7 E2           	mul	dx
34E6:0255 03 46 EE        	add	ax,[bp-12h]
34E6:0258 48              	dec	ax
34E6:0259 50              	push	ax
34E6:025A A0 BB 99        	mov	al,[99BBh]
34E6:025D 98              	cbw
34E6:025E F7 E6           	mul	si
34E6:0260 03 46 E8        	add	ax,[bp-18h]
34E6:0263 50              	push	ax
34E6:0264 FF 76 EE        	push	word ptr [bp-12h]
34E6:0267 9A 4E 48 00 08  	call	far 0800h:484Eh
34E6:026C 83 C4 0A        	add	sp,0Ah
34E6:026F 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
34E6:0274 8B 76 E4        	mov	si,[bp-1Ch]
34E6:0277 8B 46 FE        	mov	ax,[bp-2h]
34E6:027A A3 D0 B6        	mov	[0B6D0h],ax
34E6:027D 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0281 B1 04           	mov	cl,4h
34E6:0283 D3 E3           	shl	bx,cl
34E6:0285 81 C3 AA 07     	add	bx,7AAh
34E6:0289 1E              	push	ds
34E6:028A 07              	pop	es
34E6:028B 26 89 77 08     	mov	es:[bx+8h],si
34E6:028F A1 30 62        	mov	ax,[6230h]
34E6:0292 D1 E0           	shl	ax,1h
34E6:0294 D1 E0           	shl	ax,1h
34E6:0296 D1 E0           	shl	ax,1h
34E6:0298 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:029C B1 04           	mov	cl,4h
34E6:029E D3 E3           	shl	bx,cl
34E6:02A0 81 C3 AA 07     	add	bx,7AAh
34E6:02A4 50              	push	ax
34E6:02A5 1E              	push	ds
34E6:02A6 07              	pop	es
34E6:02A7 26 8B 07        	mov	ax,es:[bx]
34E6:02AA 50              	push	ax
34E6:02AB A0 66 86        	mov	al,[8666h]
34E6:02AE 98              	cbw
34E6:02AF 8B D0           	mov	dx,ax
34E6:02B1 58              	pop	ax
34E6:02B2 F7 E2           	mul	dx
34E6:02B4 5A              	pop	dx
34E6:02B5 03 D0           	add	dx,ax
34E6:02B7 89 56 EE        	mov	[bp-12h],dx
34E6:02BA A1 32 62        	mov	ax,[6232h]
34E6:02BD D1 E0           	shl	ax,1h
34E6:02BF D1 E0           	shl	ax,1h
34E6:02C1 D1 E0           	shl	ax,1h
34E6:02C3 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:02C7 B1 04           	mov	cl,4h
34E6:02C9 D3 E3           	shl	bx,cl
34E6:02CB 81 C3 AA 07     	add	bx,7AAh
34E6:02CF 50              	push	ax
34E6:02D0 1E              	push	ds
34E6:02D1 07              	pop	es
34E6:02D2 26 8B 47 02     	mov	ax,es:[bx+2h]
34E6:02D6 50              	push	ax
34E6:02D7 A0 BB 99        	mov	al,[99BBh]
34E6:02DA 98              	cbw
34E6:02DB 8B D0           	mov	dx,ax
34E6:02DD 58              	pop	ax
34E6:02DE F7 E2           	mul	dx
34E6:02E0 5A              	pop	dx
34E6:02E1 03 D0           	add	dx,ax
34E6:02E3 89 56 E8        	mov	[bp-18h],dx
34E6:02E6 C7 46 EA 01 00  	mov	word ptr [bp-16h],1h
34E6:02EB 0B F6           	or	si,si
34E6:02ED 75 1C           	jnz	030Bh

l34E6_02EF:
34E6:02EF 83 3E D2 B6 00  	cmp	word ptr [0B6D2h],0h
34E6:02F4 74 15           	jz	030Bh

l34E6_02F6:
34E6:02F6 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:02FA B1 04           	mov	cl,4h
34E6:02FC D3 E3           	shl	bx,cl
34E6:02FE 81 C3 AA 07     	add	bx,7AAh
34E6:0302 1E              	push	ds
34E6:0303 07              	pop	es
34E6:0304 26 8B 47 06     	mov	ax,es:[bx+6h]
34E6:0308 89 46 EA        	mov	[bp-16h],ax

l34E6_030B:
34E6:030B 9A 68 39 00 08  	call	far 0800h:3968h
34E6:0310 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0314 B1 04           	mov	cl,4h
34E6:0316 D3 E3           	shl	bx,cl
34E6:0318 81 C3 AA 07     	add	bx,7AAh
34E6:031C 1E              	push	ds
34E6:031D 07              	pop	es
34E6:031E 26 FF 77 0C     	push	word ptr es:[bx+0Ch]
34E6:0322 8B C6           	mov	ax,si
34E6:0324 03 46 EA        	add	ax,[bp-16h]
34E6:0327 50              	push	ax
34E6:0328 A0 BB 99        	mov	al,[99BBh]
34E6:032B 98              	cbw
34E6:032C 8B D0           	mov	dx,ax
34E6:032E 58              	pop	ax
34E6:032F F7 E2           	mul	dx
34E6:0331 03 46 E8        	add	ax,[bp-18h]
34E6:0334 48              	dec	ax
34E6:0335 50              	push	ax
34E6:0336 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:033A B1 04           	mov	cl,4h
34E6:033C D3 E3           	shl	bx,cl
34E6:033E 81 C3 AA 07     	add	bx,7AAh
34E6:0342 1E              	push	ds
34E6:0343 07              	pop	es
34E6:0344 26 8B 47 04     	mov	ax,es:[bx+4h]
34E6:0348 50              	push	ax
34E6:0349 A0 66 86        	mov	al,[8666h]
34E6:034C 98              	cbw
34E6:034D 8B D0           	mov	dx,ax
34E6:034F 58              	pop	ax
34E6:0350 F7 E2           	mul	dx
34E6:0352 03 46 EE        	add	ax,[bp-12h]
34E6:0355 48              	dec	ax
34E6:0356 50              	push	ax
34E6:0357 A0 BB 99        	mov	al,[99BBh]
34E6:035A 98              	cbw
34E6:035B F7 E6           	mul	si
34E6:035D 03 46 E8        	add	ax,[bp-18h]
34E6:0360 50              	push	ax
34E6:0361 FF 76 EE        	push	word ptr [bp-12h]
34E6:0364 9A 4E 48 00 08  	call	far 0800h:484Eh
34E6:0369 83 C4 0A        	add	sp,0Ah
34E6:036C 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l34E6_0371:
34E6:0371 83 7E E0 00     	cmp	word ptr [bp-20h],0h
34E6:0375 74 1B           	jz	0392h

l34E6_0377:
34E6:0377 83 7E DE 00     	cmp	word ptr [bp-22h],0h
34E6:037B 74 15           	jz	0392h

l34E6_037D:
34E6:037D C7 46 E0 00 00  	mov	word ptr [bp-20h],0h
34E6:0382 8B 46 DE        	mov	ax,[bp-22h]
34E6:0385 25 01 00        	and	ax,1h
34E6:0388 3D 01 00        	cmp	ax,1h
34E6:038B 75 05           	jnz	0392h

l34E6_038D:
34E6:038D C7 46 F2 0D 00  	mov	word ptr [bp-0Eh],0Dh

l34E6_0392:
34E6:0392 9A F4 34 00 08  	call	far 0800h:34F4h
34E6:0397 FF 46 F4        	inc	word ptr [bp-0Ch]

l34E6_039A:
34E6:039A 8B 46 F4        	mov	ax,[bp-0Ch]
34E6:039D 3B 46 08        	cmp	ax,[bp+8h]
34E6:03A0 7D 03           	jge	03A5h

l34E6_03A2:
34E6:03A2 E9 FC FC        	jmp	00A1h

l34E6_03A5:
34E6:03A5 9A 27 04 7F 2C  	call	far 2C7Fh:0427h
34E6:03AA 0B C0           	or	ax,ax
34E6:03AC 75 09           	jnz	03B7h

l34E6_03AE:
34E6:03AE 83 7E F2 00     	cmp	word ptr [bp-0Eh],0h
34E6:03B2 75 03           	jnz	03B7h

l34E6_03B4:
34E6:03B4 E9 AD 03        	jmp	0764h

l34E6_03B7:
34E6:03B7 9A 27 04 7F 2C  	call	far 2C7Fh:0427h
34E6:03BC 0B C0           	or	ax,ax
34E6:03BE 74 10           	jz	03D0h

l34E6_03C0:
34E6:03C0 9A 5C 04 7F 2C  	call	far 2C7Fh:045Ch
34E6:03C5 50              	push	ax
34E6:03C6 9A 03 00 C8 34  	call	far 34C8h:0003h
34E6:03CB 59              	pop	cx
34E6:03CC 8B F8           	mov	di,ax
34E6:03CE EB 03           	jmp	03D3h

l34E6_03D0:
34E6:03D0 8B 7E F2        	mov	di,[bp-0Eh]

l34E6_03D3:
34E6:03D3 3B 3E 42 62     	cmp	di,[6242h]
34E6:03D7 74 33           	jz	040Ch

l34E6_03D9:
34E6:03D9 3B 3E 44 62     	cmp	di,[6244h]
34E6:03DD 74 2D           	jz	040Ch

l34E6_03DF:
34E6:03DF 3B 3E 46 62     	cmp	di,[6246h]
34E6:03E3 74 27           	jz	040Ch

l34E6_03E5:
34E6:03E5 3B 3E 48 62     	cmp	di,[6248h]
34E6:03E9 74 21           	jz	040Ch

l34E6_03EB:
34E6:03EB 83 FF 1B        	cmp	di,1Bh
34E6:03EE 74 1C           	jz	040Ch

l34E6_03F0:
34E6:03F0 83 FF B9        	cmp	di,0B9h
34E6:03F3 74 17           	jz	040Ch

l34E6_03F5:
34E6:03F5 83 FF B7        	cmp	di,0B7h
34E6:03F8 74 12           	jz	040Ch

l34E6_03FA:
34E6:03FA 83 FF B1        	cmp	di,0B1h
34E6:03FD 74 0D           	jz	040Ch

l34E6_03FF:
34E6:03FF 83 FF AF        	cmp	di,0AFh
34E6:0402 74 08           	jz	040Ch

l34E6_0404:
34E6:0404 83 FF 09        	cmp	di,9h
34E6:0407 74 03           	jz	040Ch

l34E6_0409:
34E6:0409 E9 58 03        	jmp	0764h

l34E6_040C:
34E6:040C C7 46 EA 01 00  	mov	word ptr [bp-16h],1h
34E6:0411 0B F6           	or	si,si
34E6:0413 75 1C           	jnz	0431h

l34E6_0415:
34E6:0415 83 3E D2 B6 00  	cmp	word ptr [0B6D2h],0h
34E6:041A 74 15           	jz	0431h

l34E6_041C:
34E6:041C 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0420 B1 04           	mov	cl,4h
34E6:0422 D3 E3           	shl	bx,cl
34E6:0424 81 C3 AA 07     	add	bx,7AAh
34E6:0428 1E              	push	ds
34E6:0429 07              	pop	es
34E6:042A 26 8B 47 06     	mov	ax,es:[bx+6h]
34E6:042E 89 46 EA        	mov	[bp-16h],ax

l34E6_0431:
34E6:0431 A1 30 62        	mov	ax,[6230h]
34E6:0434 D1 E0           	shl	ax,1h
34E6:0436 D1 E0           	shl	ax,1h
34E6:0438 D1 E0           	shl	ax,1h
34E6:043A 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:043E B1 04           	mov	cl,4h
34E6:0440 D3 E3           	shl	bx,cl
34E6:0442 81 C3 AA 07     	add	bx,7AAh
34E6:0446 50              	push	ax
34E6:0447 1E              	push	ds
34E6:0448 07              	pop	es
34E6:0449 26 8B 07        	mov	ax,es:[bx]
34E6:044C 50              	push	ax
34E6:044D A0 66 86        	mov	al,[8666h]
34E6:0450 98              	cbw
34E6:0451 8B D0           	mov	dx,ax
34E6:0453 58              	pop	ax
34E6:0454 F7 E2           	mul	dx
34E6:0456 5A              	pop	dx
34E6:0457 03 D0           	add	dx,ax
34E6:0459 89 56 EE        	mov	[bp-12h],dx
34E6:045C A1 32 62        	mov	ax,[6232h]
34E6:045F D1 E0           	shl	ax,1h
34E6:0461 D1 E0           	shl	ax,1h
34E6:0463 D1 E0           	shl	ax,1h
34E6:0465 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0469 B1 04           	mov	cl,4h
34E6:046B D3 E3           	shl	bx,cl
34E6:046D 81 C3 AA 07     	add	bx,7AAh
34E6:0471 50              	push	ax
34E6:0472 1E              	push	ds
34E6:0473 07              	pop	es
34E6:0474 26 8B 47 02     	mov	ax,es:[bx+2h]
34E6:0478 50              	push	ax
34E6:0479 A0 BB 99        	mov	al,[99BBh]
34E6:047C 98              	cbw
34E6:047D 8B D0           	mov	dx,ax
34E6:047F 58              	pop	ax
34E6:0480 F7 E2           	mul	dx
34E6:0482 5A              	pop	dx
34E6:0483 03 D0           	add	dx,ax
34E6:0485 89 56 E8        	mov	[bp-18h],dx
34E6:0488 9A 68 39 00 08  	call	far 0800h:3968h
34E6:048D 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0491 B1 04           	mov	cl,4h
34E6:0493 D3 E3           	shl	bx,cl
34E6:0495 81 C3 AA 07     	add	bx,7AAh
34E6:0499 1E              	push	ds
34E6:049A 07              	pop	es
34E6:049B 26 FF 77 0C     	push	word ptr es:[bx+0Ch]
34E6:049F 8B C6           	mov	ax,si
34E6:04A1 03 46 EA        	add	ax,[bp-16h]
34E6:04A4 50              	push	ax
34E6:04A5 A0 BB 99        	mov	al,[99BBh]
34E6:04A8 98              	cbw
34E6:04A9 8B D0           	mov	dx,ax
34E6:04AB 58              	pop	ax
34E6:04AC F7 E2           	mul	dx
34E6:04AE 03 46 E8        	add	ax,[bp-18h]
34E6:04B1 48              	dec	ax
34E6:04B2 50              	push	ax
34E6:04B3 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:04B7 B1 04           	mov	cl,4h
34E6:04B9 D3 E3           	shl	bx,cl
34E6:04BB 81 C3 AA 07     	add	bx,7AAh
34E6:04BF 1E              	push	ds
34E6:04C0 07              	pop	es
34E6:04C1 26 8B 47 04     	mov	ax,es:[bx+4h]
34E6:04C5 50              	push	ax
34E6:04C6 A0 66 86        	mov	al,[8666h]
34E6:04C9 98              	cbw
34E6:04CA 8B D0           	mov	dx,ax
34E6:04CC 58              	pop	ax
34E6:04CD F7 E2           	mul	dx
34E6:04CF 03 46 EE        	add	ax,[bp-12h]
34E6:04D2 48              	dec	ax
34E6:04D3 50              	push	ax
34E6:04D4 A0 BB 99        	mov	al,[99BBh]
34E6:04D7 98              	cbw
34E6:04D8 F7 E6           	mul	si
34E6:04DA 03 46 E8        	add	ax,[bp-18h]
34E6:04DD 50              	push	ax
34E6:04DE FF 76 EE        	push	word ptr [bp-12h]
34E6:04E1 9A 4E 48 00 08  	call	far 0800h:484Eh
34E6:04E6 83 C4 0A        	add	sp,0Ah
34E6:04E9 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
34E6:04EE 83 FF 1B        	cmp	di,1Bh
34E6:04F1 75 36           	jnz	0529h

l34E6_04F3:
34E6:04F3 8B 46 F0        	mov	ax,[bp-10h]
34E6:04F6 A3 D0 B6        	mov	[0B6D0h],ax
34E6:04F9 C7 46 E6 00 00  	mov	word ptr [bp-1Ah],0h
34E6:04FE EB 21           	jmp	0521h

l34E6_0500:
34E6:0500 8B 5E E6        	mov	bx,[bp-1Ah]
34E6:0503 8A 87 6A B6     	mov	al,[bx+0B66Ah]
34E6:0507 98              	cbw
34E6:0508 8B 5E 06        	mov	bx,[bp+6h]
34E6:050B 03 5E E6        	add	bx,[bp-1Ah]
34E6:050E B1 04           	mov	cl,4h
34E6:0510 D3 E3           	shl	bx,cl
34E6:0512 81 C3 AA 07     	add	bx,7AAh
34E6:0516 50              	push	ax
34E6:0517 1E              	push	ds
34E6:0518 07              	pop	es
34E6:0519 58              	pop	ax
34E6:051A 26 89 47 08     	mov	es:[bx+8h],ax
34E6:051E FF 46 E6        	inc	word ptr [bp-1Ah]

l34E6_0521:
34E6:0521 8B 46 E6        	mov	ax,[bp-1Ah]
34E6:0524 3B 46 08        	cmp	ax,[bp+8h]
34E6:0527 7C D7           	jl	0500h

l34E6_0529:
34E6:0529 3B 3E 42 62     	cmp	di,[6242h]
34E6:052D 75 01           	jnz	0530h

l34E6_052F:
34E6:052F 4E              	dec	si

l34E6_0530:
34E6:0530 3B 3E 44 62     	cmp	di,[6244h]
34E6:0534 75 01           	jnz	0537h

l34E6_0536:
34E6:0536 46              	inc	si

l34E6_0537:
34E6:0537 3B 3E 48 62     	cmp	di,[6248h]
34E6:053B 74 05           	jz	0542h

l34E6_053D:
34E6:053D 83 FF 09        	cmp	di,9h
34E6:0540 75 70           	jnz	05B2h

l34E6_0542:
34E6:0542 A1 D0 B6        	mov	ax,[0B6D0h]
34E6:0545 89 46 EC        	mov	[bp-14h],ax
34E6:0548 FF 06 D0 B6     	inc	word ptr [0B6D0h]
34E6:054C 8B 46 06        	mov	ax,[bp+6h]
34E6:054F 03 46 08        	add	ax,[bp+8h]
34E6:0552 3B 06 D0 B6     	cmp	ax,[0B6D0h]
34E6:0556 7F 06           	jg	055Eh

l34E6_0558:
34E6:0558 8B 46 06        	mov	ax,[bp+6h]
34E6:055B A3 D0 B6        	mov	[0B6D0h],ax

l34E6_055E:
34E6:055E 8B C6           	mov	ax,si
34E6:0560 8B 5E EC        	mov	bx,[bp-14h]
34E6:0563 B1 04           	mov	cl,4h
34E6:0565 D3 E3           	shl	bx,cl
34E6:0567 81 C3 AA 07     	add	bx,7AAh
34E6:056B 50              	push	ax
34E6:056C 1E              	push	ds
34E6:056D 07              	pop	es
34E6:056E 58              	pop	ax
34E6:056F 26 89 47 08     	mov	es:[bx+8h],ax
34E6:0573 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0577 B1 04           	mov	cl,4h
34E6:0579 D3 E3           	shl	bx,cl
34E6:057B 81 C3 AA 07     	add	bx,7AAh
34E6:057F 50              	push	ax
34E6:0580 1E              	push	ds
34E6:0581 07              	pop	es
34E6:0582 58              	pop	ax
34E6:0583 26 89 47 08     	mov	es:[bx+8h],ax
34E6:0587 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:058B B1 04           	mov	cl,4h
34E6:058D D3 E3           	shl	bx,cl
34E6:058F 81 C3 AA 07     	add	bx,7AAh
34E6:0593 1E              	push	ds
34E6:0594 07              	pop	es
34E6:0595 26 8B 47 08     	mov	ax,es:[bx+8h]
34E6:0599 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:059D B1 04           	mov	cl,4h
34E6:059F D3 E3           	shl	bx,cl
34E6:05A1 81 C3 AA 07     	add	bx,7AAh
34E6:05A5 50              	push	ax
34E6:05A6 1E              	push	ds
34E6:05A7 07              	pop	es
34E6:05A8 58              	pop	ax
34E6:05A9 26 3B 47 06     	cmp	ax,es:[bx+6h]
34E6:05AD 7C 03           	jl	05B2h

l34E6_05AF:
34E6:05AF BE FF FF        	mov	si,0FFFFh

l34E6_05B2:
34E6:05B2 3B 3E 46 62     	cmp	di,[6246h]
34E6:05B6 75 70           	jnz	0628h

l34E6_05B8:
34E6:05B8 A1 D0 B6        	mov	ax,[0B6D0h]
34E6:05BB 89 46 EC        	mov	[bp-14h],ax
34E6:05BE FF 0E D0 B6     	dec	word ptr [0B6D0h]
34E6:05C2 A1 D0 B6        	mov	ax,[0B6D0h]
34E6:05C5 3B 46 06        	cmp	ax,[bp+6h]
34E6:05C8 7D 0A           	jge	05D4h

l34E6_05CA:
34E6:05CA 8B 46 08        	mov	ax,[bp+8h]
34E6:05CD 03 46 06        	add	ax,[bp+6h]
34E6:05D0 48              	dec	ax
34E6:05D1 A3 D0 B6        	mov	[0B6D0h],ax

l34E6_05D4:
34E6:05D4 8B C6           	mov	ax,si
34E6:05D6 8B 5E EC        	mov	bx,[bp-14h]
34E6:05D9 B1 04           	mov	cl,4h
34E6:05DB D3 E3           	shl	bx,cl
34E6:05DD 81 C3 AA 07     	add	bx,7AAh
34E6:05E1 50              	push	ax
34E6:05E2 1E              	push	ds
34E6:05E3 07              	pop	es
34E6:05E4 58              	pop	ax
34E6:05E5 26 89 47 08     	mov	es:[bx+8h],ax
34E6:05E9 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:05ED B1 04           	mov	cl,4h
34E6:05EF D3 E3           	shl	bx,cl
34E6:05F1 81 C3 AA 07     	add	bx,7AAh
34E6:05F5 50              	push	ax
34E6:05F6 1E              	push	ds
34E6:05F7 07              	pop	es
34E6:05F8 58              	pop	ax
34E6:05F9 26 89 47 08     	mov	es:[bx+8h],ax
34E6:05FD 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0601 B1 04           	mov	cl,4h
34E6:0603 D3 E3           	shl	bx,cl
34E6:0605 81 C3 AA 07     	add	bx,7AAh
34E6:0609 1E              	push	ds
34E6:060A 07              	pop	es
34E6:060B 26 8B 47 08     	mov	ax,es:[bx+8h]
34E6:060F 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0613 B1 04           	mov	cl,4h
34E6:0615 D3 E3           	shl	bx,cl
34E6:0617 81 C3 AA 07     	add	bx,7AAh
34E6:061B 50              	push	ax
34E6:061C 1E              	push	ds
34E6:061D 07              	pop	es
34E6:061E 58              	pop	ax
34E6:061F 26 3B 47 06     	cmp	ax,es:[bx+6h]
34E6:0623 7C 03           	jl	0628h

l34E6_0625:
34E6:0625 BE FF FF        	mov	si,0FFFFh

l34E6_0628:
34E6:0628 83 FF B1        	cmp	di,0B1h
34E6:062B 74 05           	jz	0632h

l34E6_062D:
34E6:062D 83 FF AF        	cmp	di,0AFh
34E6:0630 75 03           	jnz	0635h

l34E6_0632:
34E6:0632 BE FF FF        	mov	si,0FFFFh

l34E6_0635:
34E6:0635 83 FF B9        	cmp	di,0B9h
34E6:0638 74 05           	jz	063Fh

l34E6_063A:
34E6:063A 83 FF B7        	cmp	di,0B7h
34E6:063D 75 02           	jnz	0641h

l34E6_063F:
34E6:063F 33 F6           	xor	si,si

l34E6_0641:
34E6:0641 0B F6           	or	si,si
34E6:0643 7D 13           	jge	0658h

l34E6_0645:
34E6:0645 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0649 B1 04           	mov	cl,4h
34E6:064B D3 E3           	shl	bx,cl
34E6:064D 81 C3 AA 07     	add	bx,7AAh
34E6:0651 1E              	push	ds
34E6:0652 07              	pop	es
34E6:0653 26 8B 77 06     	mov	si,es:[bx+6h]
34E6:0657 4E              	dec	si

l34E6_0658:
34E6:0658 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:065C B1 04           	mov	cl,4h
34E6:065E D3 E3           	shl	bx,cl
34E6:0660 81 C3 AA 07     	add	bx,7AAh
34E6:0664 1E              	push	ds
34E6:0665 07              	pop	es
34E6:0666 26 8B 47 06     	mov	ax,es:[bx+6h]
34E6:066A 3B C6           	cmp	ax,si
34E6:066C 7F 02           	jg	0670h

l34E6_066E:
34E6:066E 33 F6           	xor	si,si

l34E6_0670:
34E6:0670 C7 46 EA 01 00  	mov	word ptr [bp-16h],1h
34E6:0675 0B F6           	or	si,si
34E6:0677 75 1C           	jnz	0695h

l34E6_0679:
34E6:0679 83 3E D2 B6 00  	cmp	word ptr [0B6D2h],0h
34E6:067E 74 15           	jz	0695h

l34E6_0680:
34E6:0680 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0684 B1 04           	mov	cl,4h
34E6:0686 D3 E3           	shl	bx,cl
34E6:0688 81 C3 AA 07     	add	bx,7AAh
34E6:068C 1E              	push	ds
34E6:068D 07              	pop	es
34E6:068E 26 8B 47 06     	mov	ax,es:[bx+6h]
34E6:0692 89 46 EA        	mov	[bp-16h],ax

l34E6_0695:
34E6:0695 A1 30 62        	mov	ax,[6230h]
34E6:0698 D1 E0           	shl	ax,1h
34E6:069A D1 E0           	shl	ax,1h
34E6:069C D1 E0           	shl	ax,1h
34E6:069E 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:06A2 B1 04           	mov	cl,4h
34E6:06A4 D3 E3           	shl	bx,cl
34E6:06A6 81 C3 AA 07     	add	bx,7AAh
34E6:06AA 50              	push	ax
34E6:06AB 1E              	push	ds
34E6:06AC 07              	pop	es
34E6:06AD 26 8B 07        	mov	ax,es:[bx]
34E6:06B0 50              	push	ax
34E6:06B1 A0 66 86        	mov	al,[8666h]
34E6:06B4 98              	cbw
34E6:06B5 8B D0           	mov	dx,ax
34E6:06B7 58              	pop	ax
34E6:06B8 F7 E2           	mul	dx
34E6:06BA 5A              	pop	dx
34E6:06BB 03 D0           	add	dx,ax
34E6:06BD 89 56 EE        	mov	[bp-12h],dx
34E6:06C0 A1 32 62        	mov	ax,[6232h]
34E6:06C3 D1 E0           	shl	ax,1h
34E6:06C5 D1 E0           	shl	ax,1h
34E6:06C7 D1 E0           	shl	ax,1h
34E6:06C9 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:06CD B1 04           	mov	cl,4h
34E6:06CF D3 E3           	shl	bx,cl
34E6:06D1 81 C3 AA 07     	add	bx,7AAh
34E6:06D5 50              	push	ax
34E6:06D6 1E              	push	ds
34E6:06D7 07              	pop	es
34E6:06D8 26 8B 47 02     	mov	ax,es:[bx+2h]
34E6:06DC 50              	push	ax
34E6:06DD A0 BB 99        	mov	al,[99BBh]
34E6:06E0 98              	cbw
34E6:06E1 8B D0           	mov	dx,ax
34E6:06E3 58              	pop	ax
34E6:06E4 F7 E2           	mul	dx
34E6:06E6 5A              	pop	dx
34E6:06E7 03 D0           	add	dx,ax
34E6:06E9 89 56 E8        	mov	[bp-18h],dx
34E6:06EC 9A 68 39 00 08  	call	far 0800h:3968h
34E6:06F1 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:06F5 B1 04           	mov	cl,4h
34E6:06F7 D3 E3           	shl	bx,cl
34E6:06F9 81 C3 AA 07     	add	bx,7AAh
34E6:06FD 1E              	push	ds
34E6:06FE 07              	pop	es
34E6:06FF 26 FF 77 0C     	push	word ptr es:[bx+0Ch]
34E6:0703 8B C6           	mov	ax,si
34E6:0705 03 46 EA        	add	ax,[bp-16h]
34E6:0708 50              	push	ax
34E6:0709 A0 BB 99        	mov	al,[99BBh]
34E6:070C 98              	cbw
34E6:070D 8B D0           	mov	dx,ax
34E6:070F 58              	pop	ax
34E6:0710 F7 E2           	mul	dx
34E6:0712 03 46 E8        	add	ax,[bp-18h]
34E6:0715 48              	dec	ax
34E6:0716 50              	push	ax
34E6:0717 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:071B B1 04           	mov	cl,4h
34E6:071D D3 E3           	shl	bx,cl
34E6:071F 81 C3 AA 07     	add	bx,7AAh
34E6:0723 1E              	push	ds
34E6:0724 07              	pop	es
34E6:0725 26 8B 47 04     	mov	ax,es:[bx+4h]
34E6:0729 50              	push	ax
34E6:072A A0 66 86        	mov	al,[8666h]
34E6:072D 98              	cbw
34E6:072E 8B D0           	mov	dx,ax
34E6:0730 58              	pop	ax
34E6:0731 F7 E2           	mul	dx
34E6:0733 03 46 EE        	add	ax,[bp-12h]
34E6:0736 48              	dec	ax
34E6:0737 50              	push	ax
34E6:0738 A0 BB 99        	mov	al,[99BBh]
34E6:073B 98              	cbw
34E6:073C F7 E6           	mul	si
34E6:073E 03 46 E8        	add	ax,[bp-18h]
34E6:0741 50              	push	ax
34E6:0742 FF 76 EE        	push	word ptr [bp-12h]
34E6:0745 9A 4E 48 00 08  	call	far 0800h:484Eh
34E6:074A 83 C4 0A        	add	sp,0Ah
34E6:074D 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
34E6:0752 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0756 B1 04           	mov	cl,4h
34E6:0758 D3 E3           	shl	bx,cl
34E6:075A 81 C3 AA 07     	add	bx,7AAh
34E6:075E 1E              	push	ds
34E6:075F 07              	pop	es
34E6:0760 26 89 77 08     	mov	es:[bx+8h],si

l34E6_0764:
34E6:0764 A1 30 62        	mov	ax,[6230h]
34E6:0767 D1 E0           	shl	ax,1h
34E6:0769 D1 E0           	shl	ax,1h
34E6:076B D1 E0           	shl	ax,1h
34E6:076D 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:0771 B1 04           	mov	cl,4h
34E6:0773 D3 E3           	shl	bx,cl
34E6:0775 81 C3 AA 07     	add	bx,7AAh
34E6:0779 50              	push	ax
34E6:077A 1E              	push	ds
34E6:077B 07              	pop	es
34E6:077C 26 8B 07        	mov	ax,es:[bx]
34E6:077F 50              	push	ax
34E6:0780 A0 66 86        	mov	al,[8666h]
34E6:0783 98              	cbw
34E6:0784 8B D0           	mov	dx,ax
34E6:0786 58              	pop	ax
34E6:0787 F7 E2           	mul	dx
34E6:0789 5A              	pop	dx
34E6:078A 03 D0           	add	dx,ax
34E6:078C 89 16 58 B6     	mov	[0B658h],dx
34E6:0790 A1 32 62        	mov	ax,[6232h]
34E6:0793 D1 E0           	shl	ax,1h
34E6:0795 D1 E0           	shl	ax,1h
34E6:0797 D1 E0           	shl	ax,1h
34E6:0799 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:079D B1 04           	mov	cl,4h
34E6:079F D3 E3           	shl	bx,cl
34E6:07A1 81 C3 AA 07     	add	bx,7AAh
34E6:07A5 50              	push	ax
34E6:07A6 1E              	push	ds
34E6:07A7 07              	pop	es
34E6:07A8 26 8B 47 02     	mov	ax,es:[bx+2h]
34E6:07AC 03 C6           	add	ax,si
34E6:07AE 50              	push	ax
34E6:07AF A0 BB 99        	mov	al,[99BBh]
34E6:07B2 98              	cbw
34E6:07B3 8B D0           	mov	dx,ax
34E6:07B5 58              	pop	ax
34E6:07B6 F7 E2           	mul	dx
34E6:07B8 5A              	pop	dx
34E6:07B9 03 D0           	add	dx,ax
34E6:07BB 89 16 5A B6     	mov	[0B65Ah],dx
34E6:07BF 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:07C3 B1 04           	mov	cl,4h
34E6:07C5 D3 E3           	shl	bx,cl
34E6:07C7 81 C3 AA 07     	add	bx,7AAh
34E6:07CB 1E              	push	ds
34E6:07CC 07              	pop	es
34E6:07CD 26 8B 47 04     	mov	ax,es:[bx+4h]
34E6:07D1 50              	push	ax
34E6:07D2 A0 66 86        	mov	al,[8666h]
34E6:07D5 98              	cbw
34E6:07D6 8B D0           	mov	dx,ax
34E6:07D8 58              	pop	ax
34E6:07D9 F7 E2           	mul	dx
34E6:07DB A3 56 B6        	mov	[0B656h],ax
34E6:07DE A0 BB 99        	mov	al,[99BBh]
34E6:07E1 98              	cbw
34E6:07E2 F7 66 EA        	mul	word ptr [bp-16h]
34E6:07E5 A3 54 B6        	mov	[0B654h],ax
34E6:07E8 8B 1E D0 B6     	mov	bx,[0B6D0h]
34E6:07EC B1 04           	mov	cl,4h
34E6:07EE D3 E3           	shl	bx,cl
34E6:07F0 81 C3 AA 07     	add	bx,7AAh
34E6:07F4 1E              	push	ds
34E6:07F5 07              	pop	es
34E6:07F6 26 8B 47 0C     	mov	ax,es:[bx+0Ch]
34E6:07FA A3 52 B6        	mov	[0B652h],ax
34E6:07FD 83 FF 0D        	cmp	di,0Dh
34E6:0800 74 0A           	jz	080Ch

l34E6_0802:
34E6:0802 83 FF 20        	cmp	di,20h
34E6:0805 74 05           	jz	080Ch

l34E6_0807:
34E6:0807 83 FF 1B        	cmp	di,1Bh
34E6:080A 75 10           	jnz	081Ch

l34E6_080C:
34E6:080C 83 FF 1B        	cmp	di,1Bh
34E6:080F 75 05           	jnz	0816h

l34E6_0811:
34E6:0811 B8 1B 00        	mov	ax,1Bh
34E6:0814 EB 0B           	jmp	0821h

l34E6_0816:
34E6:0816 8B C6           	mov	ax,si
34E6:0818 EB 07           	jmp	0821h
34E6:081A                               EB 05                       ..    

l34E6_081C:
34E6:081C B8 FF FF        	mov	ax,0FFFFh
34E6:081F EB 00           	jmp	0821h
