;;; Segment 3596 (3596:0000)
3596:0000 08 59                                           .Y              

l3593_0032:
3593:0032 5D              	pop	bp
3593:0033 CB              	retf

;; SetActiveRenderTarget_0004: 3596:0004
;;   Called from:
;;     2507:4859 (in DrawUnitStatusScreen_483A)
;;     2507:4A00 (in DrawUnitStatusScreen_483A)
SetActiveRenderTarget_0004 proc
3596:0004 55              	push	bp
3596:0005 8B EC           	mov	bp,sp
3596:0007 C4 5E 06        	les	bx,[bp+6h]
3596:000A 8C 06 3D 7D     	mov	[7D3Dh],es
3596:000E 89 1E 3B 7D     	mov	[7D3Bh],bx
3596:0012 83 3E CE B6 02  	cmp	word ptr [0B6CEh],2h
3596:0017 75 1E           	jnz	0037h

l3596_0019:
3596:0019 8B 56 08        	mov	dx,[bp+8h]
3596:001C 8B 46 06        	mov	ax,[bp+6h]
3596:001F 3B 16 60 B6     	cmp	dx,[0B660h]
3596:0023 75 12           	jnz	0037h

l3596_0025:
3596:0025 3B 06 5E B6     	cmp	ax,[0B65Eh]
3596:0029 75 0C           	jnz	0037h

l3596_002B:
3596:002B C7 06 3D 7D 00 A2 	mov	word ptr [7D3Dh],0A200h
