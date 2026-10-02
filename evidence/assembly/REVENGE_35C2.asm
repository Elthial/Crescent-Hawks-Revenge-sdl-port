;;; Segment 35C2 (35C2:0000)
35C2:0000 0A 89 36 D0 B6 5F 5E 8B E5 5D CB                ..6.._^..].     

;; CopyDecodedIconPage_000B: 35C2:000B
;;   Called from:
;;     1A1F:04CA (in LoadTacticalIconResource_0468)
;;     34DF:0043 (in LoadPackedIconPageDirect_0003)
CopyDecodedIconPage_000B proc
35C2:000B 55              	push	bp
35C2:000C 8B EC           	mov	bp,sp
35C2:000E 56              	push	si
35C2:000F C4 5E 06        	les	bx,[bp+6h]
35C2:0012 FF 46 06        	inc	word ptr [bp+6h]
35C2:0015 26 80 3F 01     	cmp	byte ptr es:[bx],1h
35C2:0019 75 16           	jnz	0031h

l35C2_001B:
35C2:001B FF 76 0C        	push	word ptr [bp+0Ch]
35C2:001E FF 76 0A        	push	word ptr [bp+0Ah]
35C2:0021 FF 76 08        	push	word ptr [bp+8h]
35C2:0024 FF 76 06        	push	word ptr [bp+6h]
35C2:0027 9A D6 33 00 08  	call	far 0800h:33D6h
35C2:002C 83 C4 08        	add	sp,8h
35C2:002F EB 14           	jmp	0045h

l35C2_0031:
35C2:0031 FF 76 0C        	push	word ptr [bp+0Ch]
35C2:0034 FF 76 0A        	push	word ptr [bp+0Ah]
35C2:0037 FF 76 08        	push	word ptr [bp+8h]
35C2:003A FF 76 06        	push	word ptr [bp+6h]
35C2:003D 9A 2D 34 00 08  	call	far 0800h:342Dh
35C2:0042 83 C4 08        	add	sp,8h

l35C2_0045:
35C2:0045 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
35C2:004A 75 3A           	jnz	0086h

l35C2_004C:
35C2:004C BE 50 00        	mov	si,50h
35C2:004F 83 3E 26 62 00  	cmp	word ptr [6226h],0h
35C2:0054 74 03           	jz	0059h

l35C2_0056:
35C2:0056 BE 04 00        	mov	si,4h

l35C2_0059:
35C2:0059 B8 80 3E        	mov	ax,3E80h
35C2:005C 50              	push	ax
35C2:005D 56              	push	si
35C2:005E FF 76 0C        	push	word ptr [bp+0Ch]
35C2:0061 FF 76 0A        	push	word ptr [bp+0Ah]
35C2:0064 FF 76 0C        	push	word ptr [bp+0Ch]
35C2:0067 FF 76 0A        	push	word ptr [bp+0Ah]
35C2:006A 9A 71 35 00 08  	call	far 0800h:3571h
35C2:006F 83 C4 0C        	add	sp,0Ch
35C2:0072 83 3E 26 62 00  	cmp	word ptr [6226h],0h
35C2:0077 74 0D           	jz	0086h

l35C2_0079:
35C2:0079 FF 76 0C        	push	word ptr [bp+0Ch]
35C2:007C FF 76 0A        	push	word ptr [bp+0Ah]
35C2:007F 9A ED 32 00 08  	call	far 0800h:32EDh
