;;; Segment 3568 (3568:0000)
3568:0000 00                                              .               

l34E6_0821:
34E6:0821 5F              	pop	di
34E6:0822 5E              	pop	si
34E6:0823 8B E5           	mov	sp,bp
34E6:0825 5D              	pop	bp
34E6:0826 CB              	retf

;; RunUiRegionSelectionLoop_0007: 3568:0007
;;   Called from:
;;     0D73:2727 (in RunMainMenuSelection_25F5)
;;     1A1F:50BD (in ShowPendingNarrationPrompt_4FA6)
RunUiRegionSelectionLoop_0007 proc
3568:0007 55              	push	bp
3568:0008 8B EC           	mov	bp,sp
3568:000A 56              	push	si
3568:000B 57              	push	di
3568:000C 8B 3E AE 7F     	mov	di,[7FAEh]
3568:0010 0B FF           	or	di,di
3568:0012 75 05           	jnz	0019h

l3568_0014:
3568:0014 9A 68 39 00 08  	call	far 0800h:3968h

l3568_0019:
3568:0019 FF 76 08        	push	word ptr [bp+8h]
3568:001C FF 76 06        	push	word ptr [bp+6h]
3568:001F 9A 0B 00 AB 35  	call	far 35ABh:000Bh
3568:0024 59              	pop	cx
3568:0025 59              	pop	cx
3568:0026 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
3568:002B C7 06 A4 7F 00 00 	mov	word ptr [7FA4h],0h

l3568_0031:
3568:0031 FF 76 08        	push	word ptr [bp+8h]
3568:0034 FF 76 06        	push	word ptr [bp+6h]
3568:0037 9A 03 00 E6 34  	call	far 34E6h:0003h
3568:003C 59              	pop	cx
3568:003D 59              	pop	cx
3568:003E 8B F0           	mov	si,ax
3568:0040 83 FE FF        	cmp	si,0FFh
3568:0043 74 EC           	jz	0031h

l3568_0045:
3568:0045 0B FF           	or	di,di
3568:0047 74 05           	jz	004Eh

l3568_0049:
3568:0049 9A 68 39 00 08  	call	far 0800h:3968h

l3568_004E:
3568:004E 8B C6           	mov	ax,si
