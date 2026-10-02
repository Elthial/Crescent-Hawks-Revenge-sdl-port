;;; Segment 3471 (3471:0000)
3471:0000 06 34 62 8B C6 D1 E0 01 06 36 62 5E 5D CB       .4b......6b^].  

;; FillVideoRectangle_000E: 3471:000E
;;   Called from:
;;     0D73:3675 (in DrawMissionHeaderFrame_365C)
;;     2007:1384 (in DrawBeveledMenuButton_132C)
;;     2007:15E9 (in RedrawTacticalViewport_159F)
;;     2507:48A3 (in DrawUnitStatusScreen_483A)
;;     2507:48D3 (in DrawUnitStatusScreen_483A)
;;     356F:00D1 (in RenderTextToActiveWindow_000B)
FillVideoRectangle_000E proc
3471:000E 55              	push	bp
3471:000F 8B EC           	mov	bp,sp
3471:0011 56              	push	si
3471:0012 57              	push	di
3471:0013 8B 7E 08        	mov	di,[bp+8h]
3471:0016 8B 76 06        	mov	si,[bp+6h]
3471:0019 F7 C6 01 00     	test	si,1h
3471:001D 75 0E           	jnz	002Dh

l3471_001F:
3471:001F F7 46 0A 01 00  	test	word ptr [bp+0Ah],1h
3471:0024 74 07           	jz	002Dh

l3471_0026:
3471:0026 83 3E CE B6 01  	cmp	word ptr [0B6CEh],1h
3471:002B 74 1E           	jz	004Bh

l3471_002D:
3471:002D EB 13           	jmp	0042h

l3471_002F:
3471:002F FF 76 0E        	push	word ptr [bp+0Eh]
3471:0032 FF 76 0A        	push	word ptr [bp+0Ah]
3471:0035 56              	push	si
3471:0036 8B C7           	mov	ax,di
3471:0038 47              	inc	di
3471:0039 50              	push	ax
3471:003A 9A 07 00 65 33  	call	far 3365h:0007h
3471:003F 83 C4 08        	add	sp,8h

l3471_0042:
3471:0042 8B 46 0C        	mov	ax,[bp+0Ch]
3471:0045 3B C7           	cmp	ax,di
3471:0047 7D E6           	jge	002Fh

l3471_0049:
3471:0049 EB 1C           	jmp	0067h

l3471_004B:
3471:004B FF 76 0E        	push	word ptr [bp+0Eh]
3471:004E 8B 46 0C        	mov	ax,[bp+0Ch]
3471:0051 2B C7           	sub	ax,di
3471:0053 50              	push	ax
3471:0054 8B 46 0A        	mov	ax,[bp+0Ah]
3471:0057 2B C6           	sub	ax,si
3471:0059 D1 F8           	sar	ax,1h
3471:005B 40              	inc	ax
3471:005C 50              	push	ax
3471:005D 57              	push	di
3471:005E 56              	push	si
3471:005F 9A 27 33 00 08  	call	far 0800h:3327h
