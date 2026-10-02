;;; Segment 34D5 (34D5:0000)

l34C8_00D0:
34C8:00D0 BE B7 FF        	mov	si,0FFB7h
34C8:00D3 EB 00           	jmp	00D5h

l34C8_00D5:
34C8:00D5 8B C6           	mov	ax,si
34C8:00D7 EB 00           	jmp	00D9h

l34C8_00D9:
34C8:00D9 5E              	pop	si
34C8:00DA 5D              	pop	bp
34C8:00DB CB              	retf

;; CaptureVideoTileStrip_000C: 34D5:000C
;;   Called from:
;;     0D73:00AA (in RunCampaignLoop_0006)
;;     0D73:0438 (in RebuildTacticalVideoResources_0387)
CaptureVideoTileStrip_000C proc
34D5:000C 55              	push	bp
34D5:000D 8B EC           	mov	bp,sp
34D5:000F 83 EC 0E        	sub	sp,0Eh
34D5:0012 56              	push	si
34D5:0013 8B 76 0A        	mov	si,[bp+0Ah]
34D5:0016 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
34D5:001B 75 05           	jnz	0022h

l34D5_001D:
34D5:001D B8 01 00        	mov	ax,1h
34D5:0020 EB 02           	jmp	0024h

l34D5_0022:
34D5:0022 33 C0           	xor	ax,ax

l34D5_0024:
34D5:0024 05 05 00        	add	ax,5h
34D5:0027 89 46 F2        	mov	[bp-0Eh],ax
34D5:002A 8B 46 0E        	mov	ax,[bp+0Eh]
34D5:002D 8A 4E F2        	mov	cl,[bp-0Eh]
34D5:0030 D3 E0           	shl	ax,cl
34D5:0032 99              	cwd
34D5:0033 89 56 FE        	mov	[bp-2h],dx
34D5:0036 89 46 FC        	mov	[bp-4h],ax
34D5:0039 FF 76 FE        	push	word ptr [bp-2h]
34D5:003C FF 76 FC        	push	word ptr [bp-4h]
34D5:003F 9A B5 00 56 0D  	call	far 0D56h:00B5h
34D5:0044 59              	pop	cx
34D5:0045 59              	pop	cx
34D5:0046 89 56 FA        	mov	[bp-6h],dx
34D5:0049 89 46 F8        	mov	[bp-8h],ax
34D5:004C 89 56 F6        	mov	[bp-0Ah],dx
34D5:004F 89 46 F4        	mov	[bp-0Ch],ax
34D5:0052 C7 46 F2 00 00  	mov	word ptr [bp-0Eh],0h
34D5:0057 EB 35           	jmp	008Eh

l34D5_0059:
34D5:0059 FF 76 0C        	push	word ptr [bp+0Ch]
34D5:005C 56              	push	si
34D5:005D FF 76 FA        	push	word ptr [bp-6h]
34D5:0060 FF 76 F8        	push	word ptr [bp-8h]
34D5:0063 FF 76 08        	push	word ptr [bp+8h]
34D5:0066 FF 76 06        	push	word ptr [bp+6h]
34D5:0069 9A 0B 00 95 34  	call	far 3495h:000Bh
34D5:006E 83 C4 0C        	add	sp,0Ch
34D5:0071 46              	inc	si
34D5:0072 83 FE 27        	cmp	si,27h
34D5:0075 7E 05           	jle	007Ch

l34D5_0077:
34D5:0077 33 F6           	xor	si,si
34D5:0079 FF 46 0C        	inc	word ptr [bp+0Ch]

l34D5_007C:
34D5:007C 83 46 F8 20     	add	word ptr [bp-8h],20h
34D5:0080 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
34D5:0085 75 04           	jnz	008Bh

l34D5_0087:
34D5:0087 83 46 F8 20     	add	word ptr [bp-8h],20h

l34D5_008B:
34D5:008B FF 46 F2        	inc	word ptr [bp-0Eh]

l34D5_008E:
34D5:008E 8B 46 F2        	mov	ax,[bp-0Eh]
34D5:0091 3B 46 0E        	cmp	ax,[bp+0Eh]
34D5:0094 7C C3           	jl	0059h

l34D5_0096:
34D5:0096 8B 56 F6        	mov	dx,[bp-0Ah]
34D5:0099 8B 46 F4        	mov	ax,[bp-0Ch]
34D5:009C EB 00           	jmp	009Eh

l34D5_009E:
34D5:009E 5E              	pop	si
34D5:009F 8B E5           	mov	sp,bp
