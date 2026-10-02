;;; Segment 3978 (3978:0000)
3978:0000 FF EB 00                                        ...             

l3968_0103:
3968:0103 5D              	pop	bp
3968:0104 CB              	retf

;; DOS_DeleteFile: 3978:0005
;;   Called from:
;;     3390:0658 (in DeleteFileIgnoringErrors)
DOS_DeleteFile proc
3978:0005 55              	push	bp
3978:0006 8B EC           	mov	bp,sp
3978:0008 1E              	push	ds
3978:0009 B4 41           	mov	ah,41h
3978:000B C5 56 06        	lds	dx,[bp+6h]
3978:000E CD 21           	int	21h
3978:0010 1F              	pop	ds
3978:0011 72 04           	jc	0017h

l3978_0013:
3978:0013 33 C0           	xor	ax,ax
3978:0015 EB 08           	jmp	001Fh

l3978_0017:
3978:0017 50              	push	ax
3978:0018 9A 04 00 C3 38  	call	far 38C3h:0004h
3978:001D EB 00           	jmp	001Fh

l3978_001F:
3978:001F 5D              	pop	bp
