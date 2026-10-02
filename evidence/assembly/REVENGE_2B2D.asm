;;; Segment 2B2D (2B2D:0000)
2B2D:0000 E5                                              .               

l2507_6261:
2507:6261 5E              	pop	si
2507:6262 5D              	pop	bp
2507:6263 CB              	retf

;; LoadVideoPalette_0004: 2B2D:0004
;;   Called from:
;;     0D73:0398 (in RebuildTacticalVideoResources_0387)
;;     0D73:328E (in LoadScreenPalette_324E)
;;     0D73:32E7 (in InstallVgaPaletteBankAnchors_329E)
;;     2C7F:0272 (in InitializeGame_003C)
LoadVideoPalette_0004 proc
2B2D:0004 55              	push	bp
2B2D:0005 8B EC           	mov	bp,sp
2B2D:0007 56              	push	si
2B2D:0008 57              	push	di
2B2D:0009 FF 36 EE 7F     	push	word ptr [7FEEh]
2B2D:000D 9A C2 4E 00 08  	call	far 0800h:4EC2h
2B2D:0012 59              	pop	cx
2B2D:0013 83 3E CE B6 01  	cmp	word ptr [0B6CEh],1h
2B2D:0018 75 14           	jnz	002Eh

l2B2D_001A:
2B2D:001A 8B 56 08        	mov	dx,[bp+8h]
2B2D:001D 8B 46 06        	mov	ax,[bp+6h]
2B2D:0020 05 00 03        	add	ax,300h
2B2D:0023 52              	push	dx
2B2D:0024 50              	push	ax
2B2D:0025 9A 6A 4E 00 08  	call	far 0800h:4E6Ah
2B2D:002A 59              	pop	cx
2B2D:002B 59              	pop	cx
2B2D:002C EB 45           	jmp	0073h

l2B2D_002E:
2B2D:002E 83 3E CE B6 02  	cmp	word ptr [0B6CEh],2h
2B2D:0033 75 2A           	jnz	005Fh

l2B2D_0035:
2B2D:0035 33 F6           	xor	si,si
2B2D:0037 EB 1F           	jmp	0058h

l2B2D_0039:
2B2D:0039 C4 5E 06        	les	bx,[bp+6h]
2B2D:003C 03 DE           	add	bx,si
2B2D:003E 26 8A 87 00 03  	mov	al,es:[bx+300h]
2B2D:0043 98              	cbw
2B2D:0044 8B F8           	mov	di,ax
2B2D:0046 83 FF 07        	cmp	di,7h
2B2D:0049 7E 03           	jle	004Eh

l2B2D_004B:
2B2D:004B 83 C7 08        	add	di,8h

l2B2D_004E:
2B2D:004E 57              	push	di
2B2D:004F 56              	push	si
2B2D:0050 9A B1 4D 00 08  	call	far 0800h:4DB1h
2B2D:0055 59              	pop	cx
2B2D:0056 59              	pop	cx
2B2D:0057 46              	inc	si

l2B2D_0058:
2B2D:0058 83 FE 10        	cmp	si,10h
2B2D:005B 7C DC           	jl	0039h

l2B2D_005D:
2B2D:005D EB 14           	jmp	0073h

l2B2D_005F:
2B2D:005F 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
2B2D:0064 75 0D           	jnz	0073h

l2B2D_0066:
2B2D:0066 FF 76 08        	push	word ptr [bp+8h]
2B2D:0069 FF 76 06        	push	word ptr [bp+6h]
2B2D:006C 9A 74 09 00 08  	call	far 0800h:0974h
