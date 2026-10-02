;;; Segment 3934 (3934:0000)
3934:0000 CB                                              .               

;; DOS_DeviceIOControl: 3934:0001
;;   Called from:
;;     3915:0118 (in CRT_OpenFile)
;;     3915:0143 (in CRT_OpenFile)
DOS_DeviceIOControl proc
3934:0001 55              	push	bp
3934:0002 8B EC           	mov	bp,sp
3934:0004 1E              	push	ds
3934:0005 B4 44           	mov	ah,44h
3934:0007 8A 46 08        	mov	al,[bp+8h]
3934:000A 8B 5E 06        	mov	bx,[bp+6h]
3934:000D 8B 4E 0E        	mov	cx,[bp+0Eh]
3934:0010 C5 56 0A        	lds	dx,[bp+0Ah]
3934:0013 CD 21           	int	21h
3934:0015 1F              	pop	ds
3934:0016 72 0C           	jc	0024h

l3934_0018:
3934:0018 83 7E 08 00     	cmp	word ptr [bp+8h],0h
3934:001C 75 04           	jnz	0022h

l3934_001E:
3934:001E 8B C2           	mov	ax,dx
