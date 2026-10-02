;;; Segment 39C0 (39C0:0000)

;; GetFileLength: 39C0:0000
;;   Called from:
;;     2C7F:04B6 (in LoadMediaConfiguration_047A)
;;     3477:0064 (in LoadFontResource_000B)
GetFileLength proc
39C0:0000 55              	push	bp
39C0:0001 8B EC           	mov	bp,sp
39C0:0003 83 EC 04        	sub	sp,4h
39C0:0006 B8 01 42        	mov	ax,4201h
39C0:0009 8B 5E 06        	mov	bx,[bp+6h]
39C0:000C 33 C9           	xor	cx,cx
39C0:000E 33 D2           	xor	dx,dx
39C0:0010 CD 21           	int	21h
39C0:0012 72 24           	jc	0038h

l39C0_0014:
39C0:0014 52              	push	dx
39C0:0015 50              	push	ax
39C0:0016 B8 02 42        	mov	ax,4202h
39C0:0019 33 C9           	xor	cx,cx
39C0:001B 33 D2           	xor	dx,dx
39C0:001D CD 21           	int	21h
39C0:001F 89 46 FC        	mov	[bp-4h],ax
39C0:0022 89 56 FE        	mov	[bp-2h],dx
39C0:0025 5A              	pop	dx
39C0:0026 59              	pop	cx
39C0:0027 72 0F           	jc	0038h

l39C0_0029:
39C0:0029 B8 00 42        	mov	ax,4200h
39C0:002C CD 21           	int	21h
39C0:002E 72 08           	jc	0038h

l39C0_0030:
39C0:0030 8B 56 FE        	mov	dx,[bp-2h]
39C0:0033 8B 46 FC        	mov	ax,[bp-4h]
39C0:0036 EB 09           	jmp	0041h

l39C0_0038:
39C0:0038 50              	push	ax
39C0:0039 9A 04 00 C3 38  	call	far 38C3h:0004h
39C0:003E 99              	cwd
39C0:003F EB 00           	jmp	0041h
