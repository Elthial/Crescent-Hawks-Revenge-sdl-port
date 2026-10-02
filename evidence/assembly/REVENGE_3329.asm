;;; Segment 3329 (3329:0000)
3329:0000 08 59                                           .Y              

l3327_0022:
3327:0022 C4 5E 06        	les	bx,[bp+6h]
3327:0025 26 80 38 00     	cmp	byte ptr es:[bx+si],0h
3327:0029 75 E4           	jnz	000Fh

l3327_002B:
3327:002B 5E              	pop	si
3327:002C 5D              	pop	bp
3327:002D CB              	retf

;; CopyClippedVideoRegion_000E: 3329:000E
;;   Called from:
;;     0D73:2ACC (in OpenModalTextWindow_2A5D)
;;     0D73:2B1B (in RestoreModalTextWindow_2AEE)
;;     0D73:2FB7 (in AnimateTitleTextLine_2F5F)
;;     0D73:3084 (in AnimateTitleTextLine_2F5F)
;;     0D73:3174 (in RunTitleAndMainMenu_309C)
;;     0D73:3219 (in RunTitleAndMainMenu_309C)
;;     2507:49F2 (in DrawUnitStatusScreen_483A)
;;     356F:008B (in RenderTextToActiveWindow_000B)
CopyClippedVideoRegion_000E proc
3329:000E 55              	push	bp
3329:000F 8B EC           	mov	bp,sp
3329:0011 56              	push	si
3329:0012 57              	push	di
3329:0013 8B 7E 08        	mov	di,[bp+8h]
3329:0016 8B 76 06        	mov	si,[bp+6h]
3329:0019 83 7E 0E 28     	cmp	word ptr [bp+0Eh],28h
3329:001D 7E 05           	jle	0024h

l3329_001F:
3329:001F C7 46 0E 28 00  	mov	word ptr [bp+0Eh],28h

l3329_0024:
3329:0024 81 7E 10 C8 00  	cmp	word ptr [bp+10h],0C8h
3329:0029 7E 05           	jle	0030h

l3329_002B:
3329:002B C7 46 10 C8 00  	mov	word ptr [bp+10h],0C8h

l3329_0030:
3329:0030 0B F6           	or	si,si
3329:0032 7D 08           	jge	003Ch

l3329_0034:
3329:0034 29 76 0A        	sub	[bp+0Ah],si
3329:0037 01 76 0E        	add	[bp+0Eh],si
3329:003A 33 F6           	xor	si,si

l3329_003C:
3329:003C 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
3329:0040 7D 0E           	jge	0050h

l3329_0042:
3329:0042 2B 76 0A        	sub	si,[bp+0Ah]
3329:0045 8B 46 0A        	mov	ax,[bp+0Ah]
3329:0048 01 46 0E        	add	[bp+0Eh],ax
3329:004B C7 46 0A 00 00  	mov	word ptr [bp+0Ah],0h

l3329_0050:
3329:0050 0B FF           	or	di,di
3329:0052 7D 08           	jge	005Ch

l3329_0054:
3329:0054 29 7E 0C        	sub	[bp+0Ch],di
3329:0057 01 7E 10        	add	[bp+10h],di
3329:005A 33 FF           	xor	di,di

l3329_005C:
3329:005C 83 7E 0C 00     	cmp	word ptr [bp+0Ch],0h
3329:0060 7D 0E           	jge	0070h

l3329_0062:
3329:0062 2B 7E 0C        	sub	di,[bp+0Ch]
3329:0065 8B 46 0C        	mov	ax,[bp+0Ch]
3329:0068 01 46 10        	add	[bp+10h],ax
3329:006B C7 46 0C 00 00  	mov	word ptr [bp+0Ch],0h

l3329_0070:
3329:0070 83 3E CE B6 02  	cmp	word ptr [0B6CEh],2h
3329:0075 74 24           	jz	009Bh

l3329_0077:
3329:0077 FF 76 18        	push	word ptr [bp+18h]
3329:007A FF 76 16        	push	word ptr [bp+16h]
3329:007D FF 76 14        	push	word ptr [bp+14h]
3329:0080 FF 76 12        	push	word ptr [bp+12h]
3329:0083 FF 76 10        	push	word ptr [bp+10h]
3329:0086 FF 76 0E        	push	word ptr [bp+0Eh]
3329:0089 FF 76 0C        	push	word ptr [bp+0Ch]
3329:008C FF 76 0A        	push	word ptr [bp+0Ah]
3329:008F 57              	push	di
3329:0090 56              	push	si
3329:0091 9A 00 2B 00 08  	call	far 0800h:2B00h
3329:0096 83 C4 14        	add	sp,14h
3329:0099 EB 5A           	jmp	00F5h

l3329_009B:
3329:009B 8B 56 14        	mov	dx,[bp+14h]
3329:009E 8B 46 12        	mov	ax,[bp+12h]
3329:00A1 3B 16 60 B6     	cmp	dx,[0B660h]
3329:00A5 75 10           	jnz	00B7h

l3329_00A7:
3329:00A7 3B 06 5E B6     	cmp	ax,[0B65Eh]
3329:00AB 75 0A           	jnz	00B7h

l3329_00AD:
3329:00AD C7 46 14 00 A2  	mov	word ptr [bp+14h],0A200h
3329:00B2 C7 46 12 00 00  	mov	word ptr [bp+12h],0h

l3329_00B7:
3329:00B7 8B 56 18        	mov	dx,[bp+18h]
3329:00BA 8B 46 16        	mov	ax,[bp+16h]
3329:00BD 3B 16 60 B6     	cmp	dx,[0B660h]
3329:00C1 75 10           	jnz	00D3h

l3329_00C3:
3329:00C3 3B 06 5E B6     	cmp	ax,[0B65Eh]
3329:00C7 75 0A           	jnz	00D3h

l3329_00C9:
3329:00C9 C7 46 18 00 A2  	mov	word ptr [bp+18h],0A200h
3329:00CE C7 46 16 00 00  	mov	word ptr [bp+16h],0h

l3329_00D3:
3329:00D3 FF 76 18        	push	word ptr [bp+18h]
3329:00D6 FF 76 16        	push	word ptr [bp+16h]
3329:00D9 FF 76 14        	push	word ptr [bp+14h]
3329:00DC FF 76 12        	push	word ptr [bp+12h]
3329:00DF FF 76 10        	push	word ptr [bp+10h]
3329:00E2 FF 76 0E        	push	word ptr [bp+0Eh]
3329:00E5 FF 76 0C        	push	word ptr [bp+0Ch]
3329:00E8 FF 76 0A        	push	word ptr [bp+0Ah]
3329:00EB 57              	push	di
3329:00EC 56              	push	si
3329:00ED 9A 00 2B 00 08  	call	far 0800h:2B00h
