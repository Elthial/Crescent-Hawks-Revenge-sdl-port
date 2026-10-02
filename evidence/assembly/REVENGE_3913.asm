;;; Segment 3913 (3913:0000)

l38FE_0150:
38FE:0150 8B E5           	mov	sp,bp
38FE:0152 5D              	pop	bp
38FE:0153 CB              	retf

;; DOS_ResizeMemoryBlock: 3913:0004
;;   Called from:
;;     38FE:004D (in ResizeProgramBreak_0002)
DOS_ResizeMemoryBlock proc
3913:0004 55              	push	bp
3913:0005 8B EC           	mov	bp,sp
3913:0007 B4 4A           	mov	ah,4Ah
3913:0009 8B 5E 08        	mov	bx,[bp+8h]
3913:000C 8E 46 06        	mov	es,[bp+6h]
3913:000F CD 21           	int	21h
3913:0011 72 05           	jc	0018h

l3913_0013:
3913:0013 B8 FF FF        	mov	ax,0FFFFh
3913:0016 EB 0A           	jmp	0022h

l3913_0018:
3913:0018 53              	push	bx
3913:0019 50              	push	ax
3913:001A 9A 04 00 C3 38  	call	far 38C3h:0004h
3913:001F 58              	pop	ax
