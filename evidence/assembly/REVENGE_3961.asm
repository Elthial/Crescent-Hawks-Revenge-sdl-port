;;; Segment 3961 (3961:0000)

;; DOS_WriteFile: 3961:0000
;;   Called from:
;;     394A:003A (in WriteFileWithTextTranslation)
;;     394A:00E0 (in WriteFileWithTextTranslation)
;;     394A:0143 (in WriteFileWithTextTranslation)
DOS_WriteFile proc
3961:0000 55              	push	bp
3961:0001 8B EC           	mov	bp,sp
3961:0003 8B 5E 06        	mov	bx,[bp+6h]
3961:0006 D1 E3           	shl	bx,1h
3961:0008 F7 87 2A 71 00 08 	test	word ptr [bx+712Ah],800h
3961:000E 74 12           	jz	0022h

l3961_0010:
3961:0010 B8 02 00        	mov	ax,2h
3961:0013 50              	push	ax
3961:0014 33 C0           	xor	ax,ax
3961:0016 50              	push	ax
3961:0017 50              	push	ax
3961:0018 FF 76 06        	push	word ptr [bp+6h]
3961:001B 9A 0C 00 65 39  	call	far 3965h:000Ch
3961:0020 8B E5           	mov	sp,bp

l3961_0022:
3961:0022 1E              	push	ds
3961:0023 B4 40           	mov	ah,40h
3961:0025 8B 5E 06        	mov	bx,[bp+6h]
3961:0028 8B 4E 0C        	mov	cx,[bp+0Ch]
3961:002B C5 56 08        	lds	dx,[bp+8h]
3961:002E CD 21           	int	21h
3961:0030 1F              	pop	ds
3961:0031 72 0F           	jc	0042h

l3961_0033:
3961:0033 50              	push	ax
3961:0034 8B 5E 06        	mov	bx,[bp+6h]
3961:0037 D1 E3           	shl	bx,1h
3961:0039 81 8F 2A 71 00 10 	or	word ptr [bx+712Ah],1000h
3961:003F 58              	pop	ax
