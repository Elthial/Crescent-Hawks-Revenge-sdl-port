;;; Segment 39F4 (39F4:0000)
39F4:0000 26 8C 54 04 26 8C 5C 06 8E C0 5E 5D CB          &.T.&.\...^].   

;; FarStringNCopy: 39F4:000D
;;   Called from:
;;     0D73:3E50 (in DrawCenteredClippedText_3E35)
;;     0D73:3EE7 (in DrawCenteredClippedText_3E35)
;;     0D73:3F72 (in DrawLeftAlignedClippedText_3F57)
;;     0D73:400D (in DrawRightAlignedClippedText_3FF2)
;;     2208:01CE (in RunTacticalUnitCommandMenu_000B)
;;     3A3C:011E (in InitializeTimezoneFromEnvironment)
;;     3A3C:01C2 (in InitializeTimezoneFromEnvironment)
FarStringNCopy proc
39F4:000D 55              	push	bp
39F4:000E 8B EC           	mov	bp,sp
39F4:0010 56              	push	si
39F4:0011 57              	push	di
39F4:0012 FC              	cld
39F4:0013 C4 7E 0A        	les	di,[bp+0Ah]
39F4:0016 8B F7           	mov	si,di
39F4:0018 32 C0           	xor	al,al
39F4:001A 8B 5E 0E        	mov	bx,[bp+0Eh]
39F4:001D 8B CB           	mov	cx,bx

l39F4_001F:
39F4:001F F2 AE           	repne scasb

l39F4_0021:
39F4:0021 2B D9           	sub	bx,cx
39F4:0023 1E              	push	ds
39F4:0024 8C C7           	mov	di,es
39F4:0026 8E DF           	mov	ds,di
39F4:0028 C4 7E 06        	les	di,[bp+6h]
39F4:002B 87 CB           	xchg	bx,cx

l39F4_002D:
39F4:002D F3 A4           	rep movsb

l39F4_002F:
39F4:002F 8B CB           	mov	cx,bx

l39F4_0031:
39F4:0031 F3 AA           	rep stosb

l39F4_0033:
39F4:0033 1F              	pop	ds
39F4:0034 8B 56 08        	mov	dx,[bp+8h]
39F4:0037 8B 46 06        	mov	ax,[bp+6h]
39F4:003A EB 00           	jmp	003Ch

l39F4_003C:
39F4:003C 5F              	pop	di
39F4:003D 5E              	pop	si
39F4:003E 5D              	pop	bp
39F4:003F CB              	retf
