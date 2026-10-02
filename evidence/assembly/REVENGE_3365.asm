;;; Segment 3365 (3365:0000)
3365:0000 F8 5F 5E 8B E5 5D CB                            ._^..].         

;; DrawHorizontalSpan_0007: 3365:0007
;;   Called from:
;;     3365:014A (in DrawClippedAxisAlignedLine_00A6)
;;     3471:003A (in FillVideoRectangle_000E)
DrawHorizontalSpan_0007 proc
3365:0007 55              	push	bp
3365:0008 8B EC           	mov	bp,sp
3365:000A 83 EC 04        	sub	sp,4h
3365:000D 56              	push	si
3365:000E 57              	push	di
3365:000F 8B 76 08        	mov	si,[bp+8h]
3365:0012 8B 7E 06        	mov	di,[bp+6h]
3365:0015 8B 1E CE B6     	mov	bx,[0B6CEh]
3365:0019 D1 E3           	shl	bx,1h
3365:001B 8B 87 6C 5F     	mov	ax,[bx+5F6Ch]
3365:001F 89 46 FE        	mov	[bp-2h],ax
3365:0022 EB 11           	jmp	0035h

l3365_0024:
3365:0024 FF 76 0C        	push	word ptr [bp+0Ch]
3365:0027 57              	push	di
3365:0028 57              	push	di
3365:0029 8B C6           	mov	ax,si
3365:002B 46              	inc	si
3365:002C 50              	push	ax
3365:002D 9A F3 4E 00 08  	call	far 0800h:4EF3h
3365:0032 83 C4 08        	add	sp,8h

l3365_0035:
3365:0035 8B 46 FE        	mov	ax,[bp-2h]
3365:0038 85 F0           	test	ax,si
3365:003A 74 05           	jz	0041h

l3365_003C:
3365:003C 3B 76 0A        	cmp	si,[bp+0Ah]
3365:003F 7E E3           	jle	0024h

l3365_0041:
3365:0041 3B 76 0A        	cmp	si,[bp+0Ah]
3365:0044 7D 42           	jge	0088h

l3365_0046:
3365:0046 8B 46 0A        	mov	ax,[bp+0Ah]
3365:0049 2B C6           	sub	ax,si
3365:004B 89 46 FC        	mov	[bp-4h],ax
3365:004E 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
3365:0053 74 0D           	jz	0062h

l3365_0055:
3365:0055 8B 1E CE B6     	mov	bx,[0B6CEh]
3365:0059 D1 E3           	shl	bx,1h
3365:005B 8A 8F 7C 5F     	mov	cl,[bx+5F7Ch]
3365:005F D3 7E FC        	sar	word ptr [bp-4h],cl

l3365_0062:
3365:0062 83 7E FC 00     	cmp	word ptr [bp-4h],0h
3365:0066 74 10           	jz	0078h

l3365_0068:
3365:0068 FF 76 0C        	push	word ptr [bp+0Ch]
3365:006B FF 76 FC        	push	word ptr [bp-4h]
3365:006E 57              	push	di
3365:006F 56              	push	si
3365:0070 9A D5 29 00 08  	call	far 0800h:29D5h
3365:0075 83 C4 08        	add	sp,8h

l3365_0078:
3365:0078 8B 1E CE B6     	mov	bx,[0B6CEh]
3365:007C 83 C3 04        	add	bx,4h
3365:007F D1 E3           	shl	bx,1h
3365:0081 8B B7 6C 5F     	mov	si,[bx+5F6Ch]
3365:0085 23 76 0A        	and	si,[bp+0Ah]

l3365_0088:
3365:0088 EB 11           	jmp	009Bh

l3365_008A:
3365:008A FF 76 0C        	push	word ptr [bp+0Ch]
3365:008D 57              	push	di
3365:008E 57              	push	di
3365:008F 8B C6           	mov	ax,si
3365:0091 46              	inc	si
3365:0092 50              	push	ax
3365:0093 9A F3 4E 00 08  	call	far 0800h:4EF3h
3365:0098 83 C4 08        	add	sp,8h

l3365_009B:
3365:009B 3B 76 0A        	cmp	si,[bp+0Ah]
3365:009E 7E EA           	jle	008Ah

l3365_00A0:
3365:00A0 5F              	pop	di
3365:00A1 5E              	pop	si
3365:00A2 8B E5           	mov	sp,bp
3365:00A4 5D              	pop	bp
3365:00A5 CB              	retf

;; DrawClippedAxisAlignedLine_00A6: 3365:00A6
;;   Called from:
;;     0D73:3691 (in DrawMissionHeaderFrame_365C)
;;     0D73:36AD (in DrawMissionHeaderFrame_365C)
;;     0D73:36C9 (in DrawMissionHeaderFrame_365C)
;;     0D73:36E5 (in DrawMissionHeaderFrame_365C)
;;     0D73:3701 (in DrawMissionHeaderFrame_365C)
;;     0D73:371D (in DrawMissionHeaderFrame_365C)
;;     0D73:46DC (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:471F (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:4758 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:479B (in ShowInvalidSaveVersionDialog_4611)
;;     2007:07E5 (in DrawTacticalCellOutline_07C9)
;;     2007:07F9 (in DrawTacticalCellOutline_07C9)
;;     2007:0817 (in DrawTacticalCellOutline_07C9)
;;     2007:0835 (in DrawTacticalCellOutline_07C9)
;;     2007:0CB2 (in DrawActiveTextWindowBorder_0C6F)
;;     2007:0CC3 (in DrawActiveTextWindowBorder_0C6F)
;;     2007:0CD8 (in DrawActiveTextWindowBorder_0C6F)
;;     2007:0CED (in DrawActiveTextWindowBorder_0C6F)
;;     2007:13C7 (in DrawBeveledMenuButton_132C)
;;     2007:13EC (in DrawBeveledMenuButton_132C)
;;     2007:1411 (in DrawBeveledMenuButton_132C)
;;     2007:1433 (in DrawBeveledMenuButton_132C)
;;     2007:145C (in DrawBeveledMenuButton_132C)
;;     2007:1480 (in DrawBeveledMenuButton_132C)
;;     2007:14A5 (in DrawBeveledMenuButton_132C)
;;     2007:14CC (in DrawBeveledMenuButton_132C)
;;     24C5:0321 (in DrawTacticalOverviewViewportFrame_02F1)
;;     24C5:0336 (in DrawTacticalOverviewViewportFrame_02F1)
;;     24C5:0355 (in DrawTacticalOverviewViewportFrame_02F1)
;;     24C5:0374 (in DrawTacticalOverviewViewportFrame_02F1)
;;     2507:4908 (in DrawUnitStatusScreen_483A)
;;     2507:4956 (in DrawUnitStatusScreen_483A)
;;     2507:4974 (in DrawUnitStatusScreen_483A)
;;     2507:4996 (in DrawUnitStatusScreen_483A)
;;     2507:49B8 (in DrawUnitStatusScreen_483A)
;;     3365:0169 (in DrawClippedPixel_0157)
;;     337C:0061 (in DrawClippedRectangleOutline_0001)
;;     337C:0076 (in DrawClippedRectangleOutline_0001)
;;     337C:0087 (in DrawClippedRectangleOutline_0001)
;;     337C:009C (in DrawClippedRectangleOutline_0001)
DrawClippedAxisAlignedLine_00A6 proc
3365:00A6 55              	push	bp
3365:00A7 8B EC           	mov	bp,sp
3365:00A9 83 EC 02        	sub	sp,2h
3365:00AC 56              	push	si
3365:00AD 57              	push	di
3365:00AE 8B 7E 08        	mov	di,[bp+8h]
3365:00B1 8B 76 06        	mov	si,[bp+6h]
3365:00B4 8B 46 0A        	mov	ax,[bp+0Ah]
3365:00B7 3B C6           	cmp	ax,si
3365:00B9 7D 0C           	jge	00C7h

l3365_00BB:
3365:00BB 89 76 FE        	mov	[bp-2h],si
3365:00BE 8B 76 0A        	mov	si,[bp+0Ah]
3365:00C1 8B 46 FE        	mov	ax,[bp-2h]
3365:00C4 89 46 0A        	mov	[bp+0Ah],ax

l3365_00C7:
3365:00C7 8B 46 0C        	mov	ax,[bp+0Ch]
3365:00CA 3B C7           	cmp	ax,di
3365:00CC 7D 0C           	jge	00DAh

l3365_00CE:
3365:00CE 89 7E FE        	mov	[bp-2h],di
3365:00D1 8B 7E 0C        	mov	di,[bp+0Ch]
3365:00D4 8B 46 FE        	mov	ax,[bp-2h]
3365:00D7 89 46 0C        	mov	[bp+0Ch],ax

l3365_00DA:
3365:00DA 0B F6           	or	si,si
3365:00DC 7D 02           	jge	00E0h

l3365_00DE:
3365:00DE 33 F6           	xor	si,si

l3365_00E0:
3365:00E0 0B FF           	or	di,di
3365:00E2 7D 02           	jge	00E6h

l3365_00E4:
3365:00E4 33 FF           	xor	di,di

l3365_00E6:
3365:00E6 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
3365:00EA 7D 05           	jge	00F1h

l3365_00EC:
3365:00EC C7 46 0A 00 00  	mov	word ptr [bp+0Ah],0h

l3365_00F1:
3365:00F1 83 7E 0C 00     	cmp	word ptr [bp+0Ch],0h
3365:00F5 7D 05           	jge	00FCh

l3365_00F7:
3365:00F7 C7 46 0C 00 00  	mov	word ptr [bp+0Ch],0h

l3365_00FC:
3365:00FC 81 FE 3F 01     	cmp	si,13Fh
3365:0100 7E 03           	jle	0105h

l3365_0102:
3365:0102 BE 3F 01        	mov	si,13Fh

l3365_0105:
3365:0105 81 7E 0A 3F 01  	cmp	word ptr [bp+0Ah],13Fh
3365:010A 7E 05           	jle	0111h

l3365_010C:
3365:010C C7 46 0A 3F 01  	mov	word ptr [bp+0Ah],13Fh

l3365_0111:
3365:0111 81 FF C7 00     	cmp	di,0C7h
3365:0115 7E 03           	jle	011Ah

l3365_0117:
3365:0117 BF C7 00        	mov	di,0C7h

l3365_011A:
3365:011A 81 7E 0C C7 00  	cmp	word ptr [bp+0Ch],0C7h
3365:011F 7E 05           	jle	0126h

l3365_0121:
3365:0121 C7 46 0C C7 00  	mov	word ptr [bp+0Ch],0C7h

l3365_0126:
3365:0126 3B 76 0A        	cmp	si,[bp+0Ah]
3365:0129 75 12           	jnz	013Dh

l3365_012B:
3365:012B FF 76 0E        	push	word ptr [bp+0Eh]
3365:012E FF 76 0C        	push	word ptr [bp+0Ch]
3365:0131 57              	push	di
3365:0132 56              	push	si
3365:0133 9A F3 4E 00 08  	call	far 0800h:4EF3h
3365:0138 83 C4 08        	add	sp,8h
3365:013B EB 14           	jmp	0151h

l3365_013D:
3365:013D 3B 7E 0C        	cmp	di,[bp+0Ch]
3365:0140 75 0F           	jnz	0151h

l3365_0142:
3365:0142 FF 76 0E        	push	word ptr [bp+0Eh]
3365:0145 FF 76 0A        	push	word ptr [bp+0Ah]
3365:0148 56              	push	si
3365:0149 57              	push	di
3365:014A 0E              	push	cs
3365:014B E8 B9 FE        	call	0007h
3365:014E 83 C4 08        	add	sp,8h

l3365_0151:
3365:0151 5F              	pop	di
3365:0152 5E              	pop	si
3365:0153 8B E5           	mov	sp,bp
3365:0155 5D              	pop	bp
3365:0156 CB              	retf

;; DrawClippedPixel_0157: 3365:0157
;;   Called from:
;;     2007:09EB (in DrawClippedWeaponTraceLine_0926)
;;     2007:0A3A (in DrawClippedWeaponTraceLine_0926)
;;     2208:226C (in DrawLanceFormationMarker_2224)
;;     2208:2280 (in DrawLanceFormationMarker_2224)
;;     2208:22C8 (in DrawLanceFormationMarker_2224)
;;     2208:230C (in DrawLanceFormationMarker_2224)
DrawClippedPixel_0157 proc
3365:0157 55              	push	bp
3365:0158 8B EC           	mov	bp,sp
3365:015A FF 76 0A        	push	word ptr [bp+0Ah]
3365:015D FF 76 08        	push	word ptr [bp+8h]
3365:0160 FF 76 06        	push	word ptr [bp+6h]
3365:0163 FF 76 08        	push	word ptr [bp+8h]
3365:0166 FF 76 06        	push	word ptr [bp+6h]
3365:0169 0E              	push	cs
3365:016A E8 39 FF        	call	00A6h
3365:016D 8B E5           	mov	sp,bp
3365:016F 5D              	pop	bp
