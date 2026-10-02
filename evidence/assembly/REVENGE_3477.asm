;;; Segment 3477 (3477:0000)
3477:0000 27 33 00 08 83 C4 0A                            '3.....         

l3471_0067:
3471:0067 5F              	pop	di
3471:0068 5E              	pop	si
3471:0069 5D              	pop	bp
3471:006A CB              	retf

;; LoadFontResource_000B: 3477:000B
;;   Called from:
;;     2C7F:01A9 (in InitializeGame_003C)
;;     2C7F:01BC (in InitializeGame_003C)
LoadFontResource_000B proc
3477:000B 55              	push	bp
3477:000C 8B EC           	mov	bp,sp
3477:000E 83 EC 12        	sub	sp,12h
3477:0011 56              	push	si
3477:0012 57              	push	di
3477:0013 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
3477:0018 C7 46 FA 00 00  	mov	word ptr [bp-6h],0h
3477:001D B8 01 80        	mov	ax,8001h
3477:0020 50              	push	ax
3477:0021 FF 76 08        	push	word ptr [bp+8h]
3477:0024 FF 76 06        	push	word ptr [bp+6h]
3477:0027 9A 37 00 15 39  	call	far 3915h:0037h
3477:002C 83 C4 06        	add	sp,6h
3477:002F 8B F0           	mov	si,ax
3477:0031 83 FE FF        	cmp	si,0FFh
3477:0034 75 03           	jnz	0039h

l3477_0036:
3477:0036 E9 48 01        	jmp	0181h

l3477_0039:
3477:0039 B8 02 00        	mov	ax,2h
3477:003C 50              	push	ax
3477:003D 16              	push	ss
3477:003E 8D 46 F2        	lea	ax,[bp-0Eh]
3477:0041 50              	push	ax
3477:0042 56              	push	si
3477:0043 9A 05 00 3C 39  	call	far 393Ch:0005h
3477:0048 83 C4 08        	add	sp,8h
3477:004B 8B F8           	mov	di,ax
3477:004D 83 46 F2 02     	add	word ptr [bp-0Eh],2h
3477:0051 83 FF 02        	cmp	di,2h
3477:0054 74 03           	jz	0059h

l3477_0056:
3477:0056 E9 21 01        	jmp	017Ah

l3477_0059:
3477:0059 81 7E F2 04 01  	cmp	word ptr [bp-0Eh],104h
3477:005E 77 03           	ja	0063h

l3477_0060:
3477:0060 E9 17 01        	jmp	017Ah

l3477_0063:
3477:0063 56              	push	si
3477:0064 9A 00 00 C0 39  	call	far 39C0h:0000h
3477:0069 59              	pop	cx
3477:006A 8B 5E F2        	mov	bx,[bp-0Eh]
3477:006D 33 C9           	xor	cx,cx
3477:006F 3B D1           	cmp	dx,cx
3477:0071 74 03           	jz	0076h

l3477_0073:
3477:0073 E9 04 01        	jmp	017Ah

l3477_0076:
3477:0076 3B C3           	cmp	ax,bx
3477:0078 74 03           	jz	007Dh

l3477_007A:
3477:007A E9 FD 00        	jmp	017Ah

l3477_007D:
3477:007D 33 C0           	xor	ax,ax
3477:007F 50              	push	ax
3477:0080 33 D2           	xor	dx,dx
3477:0082 B8 02 01        	mov	ax,102h
3477:0085 52              	push	dx
3477:0086 50              	push	ax
3477:0087 56              	push	si
3477:0088 9A 0C 00 65 39  	call	far 3965h:000Ch
3477:008D 83 C4 08        	add	sp,8h
3477:0090 89 56 F8        	mov	[bp-8h],dx
3477:0093 89 46 F6        	mov	[bp-0Ah],ax
3477:0096 83 7E F8 00     	cmp	word ptr [bp-8h],0h
3477:009A 74 03           	jz	009Fh

l3477_009C:
3477:009C E9 DB 00        	jmp	017Ah

l3477_009F:
3477:009F 81 7E F6 02 01  	cmp	word ptr [bp-0Ah],102h
3477:00A4 74 03           	jz	00A9h

l3477_00A6:
3477:00A6 E9 D1 00        	jmp	017Ah

l3477_00A9:
3477:00A9 B8 02 00        	mov	ax,2h
3477:00AC 50              	push	ax
3477:00AD 16              	push	ss
3477:00AE 8D 46 FE        	lea	ax,[bp-2h]
3477:00B1 50              	push	ax
3477:00B2 56              	push	si
3477:00B3 9A 05 00 3C 39  	call	far 393Ch:0005h
3477:00B8 83 C4 08        	add	sp,8h
3477:00BB 8B F8           	mov	di,ax
3477:00BD 83 FF 02        	cmp	di,2h
3477:00C0 74 03           	jz	00C5h

l3477_00C2:
3477:00C2 E9 B5 00        	jmp	017Ah

l3477_00C5:
3477:00C5 8A 46 FE        	mov	al,[bp-2h]
3477:00C8 98              	cbw
3477:00C9 89 46 EE        	mov	[bp-12h],ax
3477:00CC 8A 46 FF        	mov	al,[bp-1h]
3477:00CF 98              	cbw
3477:00D0 05 07 00        	add	ax,7h
3477:00D3 BB 08 00        	mov	bx,8h
3477:00D6 99              	cwd
3477:00D7 F7 FB           	idiv	bx
3477:00D9 89 46 F0        	mov	[bp-10h],ax
3477:00DC 8B 46 EE        	mov	ax,[bp-12h]
3477:00DF F7 66 F0        	mul	word ptr [bp-10h]
3477:00E2 B1 07           	mov	cl,7h
3477:00E4 D3 E0           	shl	ax,cl
3477:00E6 89 46 F4        	mov	[bp-0Ch],ax
3477:00E9 8B 46 F4        	mov	ax,[bp-0Ch]
3477:00EC 05 04 01        	add	ax,104h
3477:00EF 3B 46 F2        	cmp	ax,[bp-0Eh]
3477:00F2 74 03           	jz	00F7h

l3477_00F4:
3477:00F4 E9 83 00        	jmp	017Ah

l3477_00F7:
3477:00F7 81 46 F4 04 01  	add	word ptr [bp-0Ch],104h
3477:00FC FF 76 F4        	push	word ptr [bp-0Ch]
3477:00FF 9A 02 00 CD 38  	call	far 38CDh:0002h
3477:0104 59              	pop	cx
3477:0105 89 56 FC        	mov	[bp-4h],dx
3477:0108 89 46 FA        	mov	[bp-6h],ax
3477:010B 8B 46 FA        	mov	ax,[bp-6h]
3477:010E 0B 46 FC        	or	ax,[bp-4h]
3477:0111 74 67           	jz	017Ah

l3477_0113:
3477:0113 33 C0           	xor	ax,ax
3477:0115 50              	push	ax
3477:0116 33 C0           	xor	ax,ax
3477:0118 50              	push	ax
3477:0119 50              	push	ax
3477:011A 56              	push	si
3477:011B 9A 0C 00 65 39  	call	far 3965h:000Ch
3477:0120 83 C4 08        	add	sp,8h
3477:0123 89 56 F8        	mov	[bp-8h],dx
3477:0126 89 46 F6        	mov	[bp-0Ah],ax
3477:0129 8B 46 F6        	mov	ax,[bp-0Ah]
3477:012C 0B 46 F8        	or	ax,[bp-8h]
3477:012F 75 32           	jnz	0163h

l3477_0131:
3477:0131 FF 76 F2        	push	word ptr [bp-0Eh]
3477:0134 FF 76 FC        	push	word ptr [bp-4h]
3477:0137 FF 76 FA        	push	word ptr [bp-6h]
3477:013A 56              	push	si
3477:013B 9A 05 00 3C 39  	call	far 393Ch:0005h
3477:0140 83 C4 08        	add	sp,8h
3477:0143 8B F8           	mov	di,ax
3477:0145 3B 7E F2        	cmp	di,[bp-0Eh]
3477:0148 74 17           	jz	0161h

l3477_014A:
3477:014A FF 76 FC        	push	word ptr [bp-4h]
3477:014D FF 76 FA        	push	word ptr [bp-6h]
3477:0150 9A 0C 00 8D 39  	call	far 398Dh:000Ch
3477:0155 59              	pop	cx
3477:0156 59              	pop	cx
3477:0157 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
3477:015C C7 46 FA 00 00  	mov	word ptr [bp-6h],0h

l3477_0161:
3477:0161 EB 17           	jmp	017Ah

l3477_0163:
3477:0163 FF 76 FC        	push	word ptr [bp-4h]
3477:0166 FF 76 FA        	push	word ptr [bp-6h]
3477:0169 9A 0C 00 8D 39  	call	far 398Dh:000Ch
3477:016E 59              	pop	cx
3477:016F 59              	pop	cx
3477:0170 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
3477:0175 C7 46 FA 00 00  	mov	word ptr [bp-6h],0h

l3477_017A:
3477:017A 56              	push	si
3477:017B 9A 0E 00 36 39  	call	far 3936h:000Eh
3477:0180 59              	pop	cx

l3477_0181:
3477:0181 8B 56 FC        	mov	dx,[bp-4h]
3477:0184 8B 46 FA        	mov	ax,[bp-6h]
3477:0187 EB 00           	jmp	0189h

l3477_0189:
3477:0189 5F              	pop	di
3477:018A 5E              	pop	si
3477:018B 8B E5           	mov	sp,bp
3477:018D 5D              	pop	bp
3477:018E CB              	retf

;; SetActiveFontResource_018F: 3477:018F
;;   Called from:
;;     0D73:0068 (in RunCampaignLoop_0006)
;;     0D73:0222 (in InitializeTacticalScenario_0214)
;;     0D73:0373 (in InitializeTacticalScenario_0214)
;;     0D73:372D (in DrawMissionHeaderFrame_365C)
;;     0D73:375F (in DrawMissionHeaderFrame_365C)
;;     2C7F:01F4 (in InitializeGame_003C)
SetActiveFontResource_018F proc
3477:018F 55              	push	bp
3477:0190 8B EC           	mov	bp,sp
3477:0192 C4 5E 06        	les	bx,[bp+6h]
3477:0195 8C 06 C3 84     	mov	[84C3h],es
3477:0199 89 1E C1 84     	mov	[84C1h],bx
3477:019D C4 5E 06        	les	bx,[bp+6h]
3477:01A0 26 8A 87 03 01  	mov	al,es:[bx+103h]
3477:01A5 A2 66 86        	mov	[8666h],al
3477:01A8 C4 5E 06        	les	bx,[bp+6h]
3477:01AB 26 8A 87 02 01  	mov	al,es:[bx+102h]
3477:01B0 A2 BB 99        	mov	[99BBh],al
3477:01B3 5D              	pop	bp
3477:01B4 CB              	retf

;; MeasureTextWidth_01B5: 3477:01B5
;;   Called from:
;;     0D73:3E7A (in DrawCenteredClippedText_3E35)
;;     0D73:3EA0 (in DrawCenteredClippedText_3E35)
;;     0D73:3EF4 (in DrawCenteredClippedText_3E35)
;;     0D73:3F20 (in DrawCenteredClippedText_3E35)
;;     0D73:3F9C (in DrawLeftAlignedClippedText_3F57)
;;     0D73:3FC5 (in DrawLeftAlignedClippedText_3F57)
;;     0D73:4037 (in DrawRightAlignedClippedText_3FF2)
;;     0D73:4060 (in DrawRightAlignedClippedText_3FF2)
;;     2507:4D8E (in DrawUnitStatusScreen_483A)
;;     2507:4E05 (in DrawUnitStatusScreen_483A)
MeasureTextWidth_01B5 proc
3477:01B5 55              	push	bp
3477:01B6 8B EC           	mov	bp,sp
3477:01B8 83 EC 04        	sub	sp,4h
3477:01BB 56              	push	si
3477:01BC C4 1E C1 84     	les	bx,[84C1h]
3477:01C0 8C 46 FE        	mov	[bp-2h],es
3477:01C3 89 5E FC        	mov	[bp-4h],bx
3477:01C6 C4 5E FC        	les	bx,[bp-4h]
3477:01C9 26 8A 87 03 01  	mov	al,es:[bx+103h]
3477:01CE 98              	cbw
3477:01CF 8B F0           	mov	si,ax
3477:01D1 FF 76 08        	push	word ptr [bp+8h]
3477:01D4 FF 76 06        	push	word ptr [bp+6h]
3477:01D7 9A 03 00 7E 39  	call	far 397Eh:0003h
3477:01DC 59              	pop	cx
3477:01DD 59              	pop	cx
3477:01DE F7 E6           	mul	si
