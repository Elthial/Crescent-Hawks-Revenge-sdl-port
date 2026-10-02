;;; Segment 3948 (3948:0000)
3948:0000 2B C3 EB 00                                     +...            

l393C_00C4:
393C:00C4 5F              	pop	di
393C:00C5 5E              	pop	si
393C:00C6 8B E5           	mov	sp,bp
393C:00C8 5D              	pop	bp
393C:00C9 CB              	retf

;; DOS_ReadFile: 3948:000A
;;   Called from:
;;     393C:0034 (in ReadFileWithTextTranslation)
;;     393C:0085 (in ReadFileWithTextTranslation)
DOS_ReadFile proc
3948:000A 55              	push	bp
3948:000B 8B EC           	mov	bp,sp
3948:000D 1E              	push	ds
3948:000E B4 3F           	mov	ah,3Fh
3948:0010 8B 5E 06        	mov	bx,[bp+6h]
3948:0013 8B 4E 0C        	mov	cx,[bp+0Ch]
3948:0016 C5 56 08        	lds	dx,[bp+8h]
3948:0019 CD 21           	int	21h
3948:001B 1F              	pop	ds
3948:001C 72 02           	jc	0020h

l3948_001E:
3948:001E EB 08           	jmp	0028h
