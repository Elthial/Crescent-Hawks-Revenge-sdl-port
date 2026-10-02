;;; Segment 34DF (34DF:0000)
34DF:0000 E5 5D CB                                        .].             

;; LoadPackedIconPageDirect_0003: 34DF:0003
;;   Called from:
;;     1A1F:04E8 (in LoadTacticalIconResource_0468)
LoadPackedIconPageDirect_0003 proc
34DF:0003 55              	push	bp
34DF:0004 8B EC           	mov	bp,sp
34DF:0006 56              	push	si
34DF:0007 FF 76 0C        	push	word ptr [bp+0Ch]
34DF:000A FF 76 0A        	push	word ptr [bp+0Ah]
34DF:000D FF 76 08        	push	word ptr [bp+8h]
34DF:0010 FF 76 06        	push	word ptr [bp+6h]
34DF:0013 9A 08 00 B3 34  	call	far 34B3h:0008h
34DF:0018 83 C4 08        	add	sp,8h
34DF:001B 33 F6           	xor	si,si
34DF:001D 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
34DF:0022 75 13           	jnz	0037h

l34DF_0024:
34DF:0024 BE 01 00        	mov	si,1h
34DF:0027 C7 06 CE B6 01 00 	mov	word ptr [0B6CEh],1h
34DF:002D B8 01 00        	mov	ax,1h
34DF:0030 50              	push	ax
34DF:0031 9A E7 4D 00 08  	call	far 0800h:4DE7h
34DF:0036 59              	pop	cx

l34DF_0037:
34DF:0037 FF 76 10        	push	word ptr [bp+10h]
34DF:003A FF 76 0E        	push	word ptr [bp+0Eh]
34DF:003D FF 76 0C        	push	word ptr [bp+0Ch]
34DF:0040 FF 76 0A        	push	word ptr [bp+0Ah]
34DF:0043 9A 0B 00 C2 35  	call	far 35C2h:000Bh
34DF:0048 83 C4 08        	add	sp,8h
34DF:004B 0B F6           	or	si,si
34DF:004D 74 21           	jz	0070h

l34DF_004F:
34DF:004F C7 06 CE B6 00 00 	mov	word ptr [0B6CEh],0h
34DF:0055 33 C0           	xor	ax,ax
34DF:0057 50              	push	ax
34DF:0058 9A E7 4D 00 08  	call	far 0800h:4DE7h
34DF:005D 59              	pop	cx
34DF:005E FF 36 26 62     	push	word ptr [6226h]
34DF:0062 FF 76 10        	push	word ptr [bp+10h]
34DF:0065 FF 76 0E        	push	word ptr [bp+0Eh]
34DF:0068 9A D8 35 00 08  	call	far 0800h:35D8h
34DF:006D 83 C4 06        	add	sp,6h
