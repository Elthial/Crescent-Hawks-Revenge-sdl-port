;;; Segment 34C8 (34C8:0000)
34C8:0000 00                                              .               

l34C6_0021:
34C6:0021 5D              	pop	bp
34C6:0022 CB              	retf

;; NormalizeNavigationKeyCode_0003: 34C8:0003
;;   Called from:
;;     1A1F:074E (in RunTacticalInteractionLoop_0613)
;;     34E6:03C6 (in PollUiRegionSelection_0003)
NormalizeNavigationKeyCode_0003 proc
34C8:0003 55              	push	bp
34C8:0004 8B EC           	mov	bp,sp
34C8:0006 56              	push	si
34C8:0007 8B 76 06        	mov	si,[bp+6h]
34C8:000A 8B C6           	mov	ax,si
34C8:000C B9 0E 00        	mov	cx,0Eh
34C8:000F BB 21 00        	mov	bx,21h

l34C8_0012:
34C8:0012 2E 3B 07        	cmp	ax,cs:[bx]
34C8:0015 74 06           	jz	001Dh

l34C8_0017:
34C8:0017 43              	inc	bx
34C8:0018 43              	inc	bx
34C8:0019 E2 F7           	loop	0012h

l34C8_001B:
34C8:001B EB 64           	jmp	0081h

l34C8_001D:
34C8:001D 2E FF 67 1C     	jmp	word ptr cs:[bx+1Ch]
l34C8_0021	dw	0xFF0C
dw	0xFFAF
dw	0xFFB0
dw	0xFFB1
dw	0xFFB3
dw	0xFFB5
dw	0xFFB7
dw	0xFFB8
dw	0xFFB9
dw	0x000C
dw	0x005C
dw	0x0060
dw	0x007C
dw	0x007E
l34C8_003D	dw	0x006D
dw	0x0063
dw	0x005E
dw	0x0059
dw	0x006D
dw	0x0068
dw	0x007C
dw	0x0077
dw	0x0072
dw	0x006D
dw	0x0072
dw	0x005E
dw	0x0068
dw	0x0077
34C8:0059                            BE B1 FF EB 23 BE B0          ....#..
34C8:0060 FF EB 1E BE AF FF EB 19 BE B5 FF EB 14 BE B3 FF ................
34C8:0070 EB 0F BE B9 FF EB 0A BE B8 FF EB 05 BE B7 FF EB ................
34C8:0080 00                                              .               

l34C8_0081:
34C8:0081 83 3E 24 62 00  	cmp	word ptr [6224h],0h
34C8:0086 74 4D           	jz	00D5h

l34C8_0088:
34C8:0088 8B C6           	mov	ax,si
34C8:008A 2D 31 00        	sub	ax,31h
34C8:008D 3D 08 00        	cmp	ax,8h
34C8:0090 77 43           	ja	00D5h

l34C8_0092:
34C8:0092 8B D8           	mov	bx,ax
34C8:0094 D1 E3           	shl	bx,1h
34C8:0096 2E FF A7 9B 00  	jmp	word ptr cs:[bx+9Bh]
l34C8_009B	dw	0x00AD
l34C8_009D	dw	0x00B2
l34C8_009F	dw	0x00B7
l34C8_00A1	dw	0x00BC
l34C8_00A3	dw	0x00D5
l34C8_00A5	dw	0x00C1
l34C8_00A7	dw	0x00C6
l34C8_00A9	dw	0x00CB
l34C8_00AB	dw	0x00D0

l34C8_00AD:
34C8:00AD BE B1 FF        	mov	si,0FFB1h
34C8:00B0 EB 23           	jmp	00D5h

l34C8_00B2:
34C8:00B2 BE B0 FF        	mov	si,0FFB0h
34C8:00B5 EB 1E           	jmp	00D5h

l34C8_00B7:
34C8:00B7 BE AF FF        	mov	si,0FFAFh
34C8:00BA EB 19           	jmp	00D5h

l34C8_00BC:
34C8:00BC BE B5 FF        	mov	si,0FFB5h
34C8:00BF EB 14           	jmp	00D5h

l34C8_00C1:
34C8:00C1 BE B3 FF        	mov	si,0FFB3h
34C8:00C4 EB 0F           	jmp	00D5h

l34C8_00C6:
34C8:00C6 BE B9 FF        	mov	si,0FFB9h
34C8:00C9 EB 0A           	jmp	00D5h

l34C8_00CB:
34C8:00CB BE B8 FF        	mov	si,0FFB8h
34C8:00CE EB 05           	jmp	00D5h
