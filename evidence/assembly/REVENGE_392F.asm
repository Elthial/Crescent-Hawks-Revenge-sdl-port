;;; Segment 392F (392F:0000)
392F:0000 8B E5 5D CB                                     ..].            

;; DOS_OpenFile: 392F:0004
;;   Called from:
;;     3915:0104 (in CRT_OpenFile)
DOS_OpenFile proc
392F:0004 55              	push	bp
392F:0005 8B EC           	mov	bp,sp
392F:0007 56              	push	si
392F:0008 B0 01           	mov	al,1h
392F:000A 8B 4E 0A        	mov	cx,[bp+0Ah]
392F:000D F7 C1 02 00     	test	cx,2h
392F:0011 75 0A           	jnz	001Dh

l392F_0013:
392F:0013 B0 02           	mov	al,2h
392F:0015 F7 C1 04 00     	test	cx,4h
392F:0019 75 02           	jnz	001Dh

l392F_001B:
392F:001B B0 00           	mov	al,0h

l392F_001D:
392F:001D 1E              	push	ds
392F:001E C5 56 06        	lds	dx,[bp+6h]
392F:0021 B1 F0           	mov	cl,0F0h
392F:0023 22 4E 0A        	and	cl,[bp+0Ah]
392F:0026 0A C1           	or	al,cl
392F:0028 B4 3D           	mov	ah,3Dh
392F:002A CD 21           	int	21h
392F:002C 1F              	pop	ds
392F:002D 72 17           	jc	0046h

l392F_002F:
392F:002F 8B F0           	mov	si,ax
392F:0031 8B 46 0A        	mov	ax,[bp+0Ah]
392F:0034 25 FF F8        	and	ax,0F8FFh
392F:0037 0D 00 80        	or	ax,8000h
392F:003A 8B DE           	mov	bx,si
392F:003C D1 E3           	shl	bx,1h
392F:003E 89 87 2A 71     	mov	[bx+712Ah],ax
392F:0042 8B C6           	mov	ax,si
392F:0044 EB 08           	jmp	004Eh

l392F_0046:
392F:0046 50              	push	ax
392F:0047 9A 04 00 C3 38  	call	far 38C3h:0004h
392F:004C EB 00           	jmp	004Eh

l392F_004E:
392F:004E 5E              	pop	si
392F:004F 5D              	pop	bp
