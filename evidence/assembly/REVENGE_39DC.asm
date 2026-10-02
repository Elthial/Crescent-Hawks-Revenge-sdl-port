;;; Segment 39DC (39DC:0000)
39DC:0000 C4 5E 06 26 89 57 02 5D CB                      .^.&.W.].       

;; GetEnvironmentVariable: 39DC:0009
;;   Called from:
;;     3A3C:0014 (in InitializeTimezoneFromEnvironment)
GetEnvironmentVariable proc
39DC:0009 55              	push	bp
39DC:000A 8B EC           	mov	bp,sp
39DC:000C 83 EC 04        	sub	sp,4h
39DC:000F 56              	push	si
39DC:0010 57              	push	di
39DC:0011 C4 7E 06        	les	di,[bp+6h]
39DC:0014 8C C0           	mov	ax,es
39DC:0016 0B C7           	or	ax,di
39DC:0018 74 20           	jz	003Ah

l39DC_001A:
39DC:001A B0 00           	mov	al,0h
39DC:001C 26 8A 25        	mov	ah,es:[di]
39DC:001F B9 FF FF        	mov	cx,0FFFFh
39DC:0022 FC              	cld

l39DC_0023:
39DC:0023 F2 AE           	repne scasb

l39DC_0025:
39DC:0025 F7 D1           	not	cx
39DC:0027 49              	dec	cx
39DC:0028 74 10           	jz	003Ah

l39DC_002A:
39DC:002A C4 3E 71 00     	les	di,[0071h]
39DC:002E 8C 46 FE        	mov	[bp-2h],es
39DC:0031 8C C3           	mov	bx,es
39DC:0033 0B DF           	or	bx,di
39DC:0035 89 7E FC        	mov	[bp-4h],di
39DC:0038 75 0E           	jnz	0048h

l39DC_003A:
39DC:003A 33 D2           	xor	dx,dx
39DC:003C 33 C0           	xor	ax,ax
39DC:003E EB 36           	jmp	0076h
39DC:0040 90                                              .               

l39DC_0041:
39DC:0041 83 46 FC 04     	add	word ptr [bp-4h],4h
39DC:0045 C4 7E FC        	les	di,[bp-4h]

l39DC_0048:
39DC:0048 26 C4 3D        	les	di,es:[di]
39DC:004B 8C C3           	mov	bx,es
39DC:004D 0B DF           	or	bx,di
39DC:004F 74 E9           	jz	003Ah

l39DC_0051:
39DC:0051 26 8A 05        	mov	al,es:[di]
39DC:0054 0A C0           	or	al,al
39DC:0056 74 E2           	jz	003Ah

l39DC_0058:
39DC:0058 3A E0           	cmp	ah,al
39DC:005A 75 E5           	jnz	0041h

l39DC_005C:
39DC:005C 8B D9           	mov	bx,cx
39DC:005E 26 80 39 3D     	cmp	byte ptr es:[bx+di],3Dh
39DC:0062 75 DD           	jnz	0041h

l39DC_0064:
39DC:0064 1E              	push	ds
39DC:0065 C5 76 06        	lds	si,[bp+6h]

l39DC_0068:
39DC:0068 F3 A6           	rep cmpsb

l39DC_006A:
39DC:006A 1F              	pop	ds
39DC:006B 87 CB           	xchg	bx,cx
39DC:006D 75 D2           	jnz	0041h

l39DC_006F:
39DC:006F 47              	inc	di
