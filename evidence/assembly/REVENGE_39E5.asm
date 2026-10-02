;;; Segment 39E5 (39E5:0000)
39E5:0000 EC B4 25 8A 46 06 1E C5 56 08 CD 21 1F 5D CB    ..%.F...V..!.]. 

;; InvokeInterruptWithRegisterBlocks: 39E5:000F
;;   Called from:
;;     2C7F:033F (in GetCurrentBIOSVideoMode_032B)
;;     2C7F:0392 (in SetVideoModeForAdapter_0350)
InvokeInterruptWithRegisterBlocks proc
39E5:000F 55              	push	bp
39E5:0010 8B EC           	mov	bp,sp
39E5:0012 83 EC 08        	sub	sp,8h
39E5:0015 16              	push	ss
39E5:0016 8D 46 F8        	lea	ax,[bp-8h]
39E5:0019 50              	push	ax
39E5:001A 9A 00 00 F3 39  	call	far 39F3h:0000h
39E5:001F 59              	pop	cx
39E5:0020 59              	pop	cx
39E5:0021 16              	push	ss
39E5:0022 8D 46 F8        	lea	ax,[bp-8h]
39E5:0025 50              	push	ax
39E5:0026 FF 76 0E        	push	word ptr [bp+0Eh]
39E5:0029 FF 76 0C        	push	word ptr [bp+0Ch]
39E5:002C FF 76 0A        	push	word ptr [bp+0Ah]
39E5:002F FF 76 08        	push	word ptr [bp+8h]
39E5:0032 FF 76 06        	push	word ptr [bp+6h]
39E5:0035 9A 43 00 E5 39  	call	far 39E5h:0043h
39E5:003A 83 C4 0E        	add	sp,0Eh
39E5:003D EB 00           	jmp	003Fh

l39E5_003F:
39E5:003F 8B E5           	mov	sp,bp
39E5:0041 5D              	pop	bp
39E5:0042 CB              	retf

;; InvokeInterruptThunk_0043: 39E5:0043
;;   Called from:
;;     39E5:0035 (in InvokeInterruptWithRegisterBlocks)
InvokeInterruptThunk_0043 proc
39E5:0043 55              	push	bp
39E5:0044 8B EC           	mov	bp,sp
39E5:0046 83 EC 0E        	sub	sp,0Eh
39E5:0049 56              	push	si
39E5:004A 57              	push	di
39E5:004B 1E              	push	ds
39E5:004C 8D 4E F6        	lea	cx,[bp-0Ah]
39E5:004F 89 4E F2        	mov	[bp-0Eh],cx
39E5:0052 8C 56 F4        	mov	[bp-0Ch],ss
39E5:0055 C6 46 F6 55     	mov	byte ptr [bp-0Ah],55h
39E5:0059 C6 46 F7 CD     	mov	byte ptr [bp-9h],0CDh
39E5:005D 8B 46 06        	mov	ax,[bp+6h]
39E5:0060 88 46 F8        	mov	[bp-8h],al
39E5:0063 C7 46 F9 5D CB  	mov	word ptr [bp-7h],0CB5Dh
39E5:0068 3C 25           	cmp	al,25h
39E5:006A 72 15           	jc	0081h

l39E5_006C:
39E5:006C 3C 26           	cmp	al,26h
39E5:006E 77 11           	ja	0081h

l39E5_0070:
39E5:0070 C6 46 F9 36     	mov	byte ptr [bp-7h],36h
39E5:0074 C7 46 FA 8F 06  	mov	word ptr [bp-6h],68Fh
39E5:0079 89 4E FC        	mov	[bp-4h],cx
39E5:007C C7 46 FE 5D CB  	mov	word ptr [bp-2h],0CB5Dh

l39E5_0081:
39E5:0081 C5 76 10        	lds	si,[bp+10h]
39E5:0084 FF 34           	push	word ptr [si]
39E5:0086 FF 74 06        	push	word ptr [si+6h]
39E5:0089 C5 76 08        	lds	si,[bp+8h]
39E5:008C 8B 04           	mov	ax,[si]
39E5:008E 8B 5C 02        	mov	bx,[si+2h]
39E5:0091 8B 4C 04        	mov	cx,[si+4h]
39E5:0094 8B 54 06        	mov	dx,[si+6h]
39E5:0097 8B 7C 0A        	mov	di,[si+0Ah]
39E5:009A 8B 74 08        	mov	si,[si+8h]
39E5:009D 1F              	pop	ds
39E5:009E 07              	pop	es
39E5:009F FF 5E F2        	call	dword ptr [bp-0Eh]
39E5:00A2 9C              	pushf
39E5:00A3 9C              	pushf
39E5:00A4 56              	push	si
39E5:00A5 1E              	push	ds
39E5:00A6 06              	push	es
39E5:00A7 C5 76 10        	lds	si,[bp+10h]
39E5:00AA 8F 04           	pop	word ptr [si]
39E5:00AC 8F 44 06        	pop	word ptr [si+6h]
39E5:00AF C5 76 0C        	lds	si,[bp+0Ch]
39E5:00B2 8F 44 08        	pop	word ptr [si+8h]
39E5:00B5 8F 44 0E        	pop	word ptr [si+0Eh]
39E5:00B8 8F 44 0C        	pop	word ptr [si+0Ch]
39E5:00BB 83 64 0C 01     	and	word ptr [si+0Ch],1h
39E5:00BF 89 7C 0A        	mov	[si+0Ah],di
39E5:00C2 89 54 06        	mov	[si+6h],dx
39E5:00C5 89 4C 04        	mov	[si+4h],cx
39E5:00C8 89 5C 02        	mov	[si+2h],bx
39E5:00CB 89 04           	mov	[si],ax
39E5:00CD 1F              	pop	ds
39E5:00CE 74 08           	jz	00D8h

l39E5_00D0:
39E5:00D0 50              	push	ax
39E5:00D1 50              	push	ax
39E5:00D2 9A 04 00 C3 38  	call	far 38C3h:0004h
39E5:00D7 58              	pop	ax

l39E5_00D8:
39E5:00D8 EB 00           	jmp	00DAh

l39E5_00DA:
39E5:00DA 5F              	pop	di
39E5:00DB 5E              	pop	si
39E5:00DC 8B E5           	mov	sp,bp
39E5:00DE 5D              	pop	bp
39E5:00DF CB              	retf
