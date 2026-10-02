;;; Segment 3939 (3939:0000)
3939:0000 71 FF FF 56 9A 0F 00 39 39 59 EB 00             q..V...99Y..    

l3936_003C:
3936:003C 5E              	pop	si
3936:003D 5D              	pop	bp
3936:003E CB              	retf

;; DOS_CloseFile: 3939:000F
;;   Called from:
;;     3915:00D2 (in CRT_OpenFile)
;;     3936:0034 (in CRT_CloseFile)
DOS_CloseFile proc
3939:000F 55              	push	bp
3939:0010 8B EC           	mov	bp,sp
3939:0012 56              	push	si
3939:0013 8B 76 06        	mov	si,[bp+6h]
3939:0016 B4 3E           	mov	ah,3Eh
3939:0018 8B DE           	mov	bx,si
3939:001A CD 21           	int	21h
3939:001C 72 0C           	jc	002Ah

l3939_001E:
3939:001E D1 E3           	shl	bx,1h
3939:0020 C7 87 2A 71 FF FF 	mov	word ptr [bx+712Ah],0FFFFh
3939:0026 33 C0           	xor	ax,ax
3939:0028 EB 08           	jmp	0032h

l3939_002A:
3939:002A 50              	push	ax
3939:002B 9A 04 00 C3 38  	call	far 38C3h:0004h
