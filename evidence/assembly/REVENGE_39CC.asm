;;; Segment 39CC (39CC:0000)
39CC:0000 76 08 FF 76 06 0E E8 7C FF 8B E5 EB 00 5D CB    v..v...|.....]. 

;; CaptureLocalClockSnapshot_000F: 39CC:000F
;;   Called from:
;;     0D73:3DB6 (in UpdateTextEntryCursorBlink_3DA9)
CaptureLocalClockSnapshot_000F proc
39CC:000F 55              	push	bp
39CC:0010 8B EC           	mov	bp,sp
39CC:0012 83 EC 0C        	sub	sp,0Ch
39CC:0015 9A 08 00 3C 3A  	call	far 3A3Ch:0008h

l39CC_001A:
39CC:001A 16              	push	ss
39CC:001B 8D 46 F4        	lea	ax,[bp-0Ch]
39CC:001E 50              	push	ax
39CC:001F 9A 0D 00 D9 39  	call	far 39D9h:000Dh
39CC:0024 59              	pop	cx
39CC:0025 59              	pop	cx
39CC:0026 16              	push	ss
39CC:0027 8D 46 FC        	lea	ax,[bp-4h]
39CC:002A 50              	push	ax
39CC:002B 9A 23 00 D9 39  	call	far 39D9h:0023h
39CC:0030 59              	pop	cx
39CC:0031 59              	pop	cx
39CC:0032 16              	push	ss
39CC:0033 8D 46 F8        	lea	ax,[bp-8h]
39CC:0036 50              	push	ax
39CC:0037 9A 0D 00 D9 39  	call	far 39D9h:000Dh
39CC:003C 59              	pop	cx
39CC:003D 59              	pop	cx
39CC:003E 8B 46 F4        	mov	ax,[bp-0Ch]
39CC:0041 3B 46 F8        	cmp	ax,[bp-8h]
39CC:0044 75 D4           	jnz	001Ah

l39CC_0046:
39CC:0046 8A 46 F6        	mov	al,[bp-0Ah]
39CC:0049 3A 46 FA        	cmp	al,[bp-6h]
39CC:004C 75 CC           	jnz	001Ah

l39CC_004E:
39CC:004E 8A 46 F7        	mov	al,[bp-9h]
39CC:0051 3A 46 FB        	cmp	al,[bp-5h]
39CC:0054 75 C4           	jnz	001Ah

l39CC_0056:
39CC:0056 33 D2           	xor	dx,dx
39CC:0058 B8 3C 00        	mov	ax,3Ch
39CC:005B 52              	push	dx
39CC:005C 50              	push	ax
39CC:005D FF 36 92 71     	push	word ptr [7192h]
39CC:0061 FF 36 90 71     	push	word ptr [7190h]
39CC:0065 9A 45 54 00 08  	call	far 0800h:5445h
39CC:006A C4 5E 06        	les	bx,[bp+6h]
39CC:006D 26 89 47 06     	mov	es:[bx+6h],ax
39CC:0071 83 3E 94 71 00  	cmp	word ptr [7194h],0h
39CC:0076 74 2B           	jz	00A3h

l39CC_0078:
39CC:0078 8A 46 FD        	mov	al,[bp-3h]
39CC:007B B4 00           	mov	ah,0h
39CC:007D 50              	push	ax
39CC:007E 8A 46 F6        	mov	al,[bp-0Ah]
39CC:0081 98              	cbw
39CC:0082 50              	push	ax
39CC:0083 8A 46 F7        	mov	al,[bp-9h]
39CC:0086 98              	cbw
39CC:0087 50              	push	ax
39CC:0088 8B 46 F4        	mov	ax,[bp-0Ch]
39CC:008B 05 4E F8        	add	ax,0F84Eh
39CC:008E 50              	push	ax
39CC:008F 9A ED 01 3C 3A  	call	far 3A3Ch:01EDh
39CC:0094 0B C0           	or	ax,ax
39CC:0096 74 0B           	jz	00A3h

l39CC_0098:
39CC:0098 C4 5E 06        	les	bx,[bp+6h]
39CC:009B 26 C7 47 08 01 00 	mov	word ptr es:[bx+8h],1h
39CC:00A1 EB 09           	jmp	00ACh

l39CC_00A3:
39CC:00A3 C4 5E 06        	les	bx,[bp+6h]
39CC:00A6 26 C7 47 08 00 00 	mov	word ptr es:[bx+8h],0h

l39CC_00AC:
39CC:00AC 16              	push	ss
39CC:00AD 8D 46 FC        	lea	ax,[bp-4h]
39CC:00B0 50              	push	ax
39CC:00B1 16              	push	ss
39CC:00B2 8D 46 F4        	lea	ax,[bp-0Ch]
39CC:00B5 50              	push	ax
39CC:00B6 9A 01 00 07 3A  	call	far 3A07h:0001h
39CC:00BB 83 C4 08        	add	sp,8h
39CC:00BE C4 5E 06        	les	bx,[bp+6h]
39CC:00C1 26 89 57 02     	mov	es:[bx+2h],dx
39CC:00C5 26 89 07        	mov	es:[bx],ax
39CC:00C8 8A 46 FE        	mov	al,[bp-2h]
39CC:00CB B4 00           	mov	ah,0h
39CC:00CD BA 0A 00        	mov	dx,0Ah
