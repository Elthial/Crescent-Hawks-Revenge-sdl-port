;;; Segment 34B3 (34B3:0000)
34B3:0000 5D 1F 07 CF 5F 5E 5D CB                         ]..._^].        

;; LoadPackedIconResource_0008: 34B3:0008
;;   Called from:
;;     1A1F:04B4 (in LoadTacticalIconResource_0468)
;;     34DF:0013 (in LoadPackedIconPageDirect_0003)
LoadPackedIconResource_0008 proc
34B3:0008 55              	push	bp
34B3:0009 8B EC           	mov	bp,sp
34B3:000B 83 EC 02        	sub	sp,2h
34B3:000E 56              	push	si
34B3:000F B8 01 00        	mov	ax,1h
34B3:0012 50              	push	ax
34B3:0013 FF 76 08        	push	word ptr [bp+8h]
34B3:0016 FF 76 06        	push	word ptr [bp+6h]
34B3:0019 9A 37 00 90 33  	call	far 3390h:0037h
34B3:001E 83 C4 06        	add	sp,6h
34B3:0021 8B F0           	mov	si,ax
34B3:0023 33 D2           	xor	dx,dx
34B3:0025 B8 02 00        	mov	ax,2h
34B3:0028 52              	push	dx
34B3:0029 50              	push	ax
34B3:002A 16              	push	ss
34B3:002B 8D 46 FE        	lea	ax,[bp-2h]
34B3:002E 50              	push	ax
34B3:002F 56              	push	si
34B3:0030 9A 8C 02 90 33  	call	far 3390h:028Ch
34B3:0035 83 C4 0A        	add	sp,0Ah
34B3:0038 8B 46 FE        	mov	ax,[bp-2h]
34B3:003B 33 D2           	xor	dx,dx
34B3:003D 52              	push	dx
34B3:003E 50              	push	ax
34B3:003F FF 76 0C        	push	word ptr [bp+0Ch]
34B3:0042 FF 76 0A        	push	word ptr [bp+0Ah]
34B3:0045 56              	push	si
34B3:0046 9A 8C 02 90 33  	call	far 3390h:028Ch
34B3:004B 83 C4 0A        	add	sp,0Ah
34B3:004E 56              	push	si
34B3:004F 9A 44 02 90 33  	call	far 3390h:0244h
