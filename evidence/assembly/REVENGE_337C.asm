;;; Segment 337C (337C:0000)
337C:0000 CB                                              .               

;; DrawClippedRectangleOutline_0001: 337C:0001
;;   Called from:
;;     2507:4935 (in DrawUnitStatusScreen_483A)
DrawClippedRectangleOutline_0001 proc
337C:0001 55              	push	bp
337C:0002 8B EC           	mov	bp,sp
337C:0004 56              	push	si
337C:0005 57              	push	di
337C:0006 8B 7E 08        	mov	di,[bp+8h]
337C:0009 8B 76 06        	mov	si,[bp+6h]
337C:000C 0B F6           	or	si,si
337C:000E 7D 02           	jge	0012h

l337C_0010:
337C:0010 33 F6           	xor	si,si

l337C_0012:
337C:0012 83 7E 0A 00     	cmp	word ptr [bp+0Ah],0h
337C:0016 7D 05           	jge	001Dh

l337C_0018:
337C:0018 C7 46 0A 00 00  	mov	word ptr [bp+0Ah],0h

l337C_001D:
337C:001D 81 FE 3F 01     	cmp	si,13Fh
337C:0021 7E 03           	jle	0026h

l337C_0023:
337C:0023 BE 3F 01        	mov	si,13Fh

l337C_0026:
337C:0026 81 7E 0A 3F 01  	cmp	word ptr [bp+0Ah],13Fh
337C:002B 7E 05           	jle	0032h

l337C_002D:
337C:002D C7 46 0A 3F 01  	mov	word ptr [bp+0Ah],13Fh

l337C_0032:
337C:0032 0B FF           	or	di,di
337C:0034 7D 02           	jge	0038h

l337C_0036:
337C:0036 33 FF           	xor	di,di

l337C_0038:
337C:0038 83 7E 0C 00     	cmp	word ptr [bp+0Ch],0h
337C:003C 7D 05           	jge	0043h

l337C_003E:
337C:003E C7 46 0C 00 00  	mov	word ptr [bp+0Ch],0h

l337C_0043:
337C:0043 81 FF C7 00     	cmp	di,0C7h
337C:0047 7E 03           	jle	004Ch

l337C_0049:
337C:0049 BF C7 00        	mov	di,0C7h

l337C_004C:
337C:004C 81 7E 0C C7 00  	cmp	word ptr [bp+0Ch],0C7h
337C:0051 7E 05           	jle	0058h

l337C_0053:
337C:0053 C7 46 0C C7 00  	mov	word ptr [bp+0Ch],0C7h

l337C_0058:
337C:0058 FF 76 0E        	push	word ptr [bp+0Eh]
337C:005B 57              	push	di
337C:005C FF 76 0A        	push	word ptr [bp+0Ah]
337C:005F 57              	push	di
337C:0060 56              	push	si
337C:0061 9A A6 00 65 33  	call	far 3365h:00A6h
337C:0066 83 C4 0A        	add	sp,0Ah
337C:0069 FF 76 0E        	push	word ptr [bp+0Eh]
337C:006C FF 76 0C        	push	word ptr [bp+0Ch]
337C:006F FF 76 0A        	push	word ptr [bp+0Ah]
337C:0072 FF 76 0C        	push	word ptr [bp+0Ch]
337C:0075 56              	push	si
337C:0076 9A A6 00 65 33  	call	far 3365h:00A6h
337C:007B 83 C4 0A        	add	sp,0Ah
337C:007E FF 76 0E        	push	word ptr [bp+0Eh]
337C:0081 FF 76 0C        	push	word ptr [bp+0Ch]
337C:0084 56              	push	si
337C:0085 57              	push	di
337C:0086 56              	push	si
337C:0087 9A A6 00 65 33  	call	far 3365h:00A6h
337C:008C 83 C4 0A        	add	sp,0Ah
337C:008F FF 76 0E        	push	word ptr [bp+0Eh]
337C:0092 FF 76 0C        	push	word ptr [bp+0Ch]
337C:0095 FF 76 0A        	push	word ptr [bp+0Ah]
337C:0098 57              	push	di
337C:0099 FF 76 0A        	push	word ptr [bp+0Ah]
337C:009C 9A A6 00 65 33  	call	far 3365h:00A6h
