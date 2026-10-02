;;; Segment 38CD (38CD:0000)
38CD:0000 5D CB                                           ].              

;; AllocateFarHeapBytes16: 38CD:0002
;;   Called from:
;;     0D56:00DB (in AllocateFarMemory)
;;     3477:00FF (in LoadFontResource_000B)
AllocateFarHeapBytes16 proc
38CD:0002 55              	push	bp
38CD:0003 8B EC           	mov	bp,sp
38CD:0005 8B 46 06        	mov	ax,[bp+6h]
38CD:0008 33 D2           	xor	dx,dx
38CD:000A 52              	push	dx
38CD:000B 50              	push	ax
38CD:000C 9A 03 02 CD 38  	call	far 38CDh:0203h
38CD:0011 8B E5           	mov	sp,bp
38CD:0013 EB 00           	jmp	0015h

l38CD_0015:
38CD:0015 5D              	pop	bp
38CD:0016 CB              	retf

;; UnlinkFarHeapFreeBlock_0017: 38CD:0017
;;   Called from:
;;     38CD:02BE (in AllocateFarHeapBytes)
;;     398D:012A (in CoalesceFarHeapSuccessor_00BD)
;;     398D:01A6 (in ReleaseFarHeapTail_0135)
UnlinkFarHeapFreeBlock_0017 proc
38CD:0017 55              	push	bp
38CD:0018 8B EC           	mov	bp,sp
38CD:001A 83 EC 04        	sub	sp,4h
38CD:001D C4 5E 06        	les	bx,[bp+6h]
38CD:0020 26 8B 57 0E     	mov	dx,es:[bx+0Eh]
38CD:0024 26 8B 47 0C     	mov	ax,es:[bx+0Ch]
38CD:0028 89 16 24 70     	mov	[7024h],dx
38CD:002C A3 22 70        	mov	[7022h],ax
38CD:002F 8B 4E 08        	mov	cx,[bp+8h]
38CD:0032 8B 5E 06        	mov	bx,[bp+6h]
38CD:0035 9A 0B 54 00 08  	call	far 0800h:540Bh
38CD:003A 75 0E           	jnz	004Ah

l38CD_003C:
38CD:003C C7 06 24 70 00 00 	mov	word ptr [7024h],0h
38CD:0042 C7 06 22 70 00 00 	mov	word ptr [7022h],0h
38CD:0048 EB 31           	jmp	007Bh

l38CD_004A:
38CD:004A C4 5E 06        	les	bx,[bp+6h]
38CD:004D 26 C4 5F 08     	les	bx,es:[bx+8h]
38CD:0051 8C 46 FE        	mov	[bp-2h],es
38CD:0054 89 5E FC        	mov	[bp-4h],bx
38CD:0057 8B 56 FE        	mov	dx,[bp-2h]
38CD:005A 8B 46 FC        	mov	ax,[bp-4h]
38CD:005D C4 1E 22 70     	les	bx,[7022h]
38CD:0061 26 89 57 0A     	mov	es:[bx+0Ah],dx
38CD:0065 26 89 47 08     	mov	es:[bx+8h],ax
38CD:0069 8B 16 24 70     	mov	dx,[7024h]
38CD:006D A1 22 70        	mov	ax,[7022h]
38CD:0070 C4 5E FC        	les	bx,[bp-4h]
38CD:0073 26 89 57 0E     	mov	es:[bx+0Eh],dx
38CD:0077 26 89 47 0C     	mov	es:[bx+0Ch],ax

l38CD_007B:
38CD:007B 8B E5           	mov	sp,bp
38CD:007D 5D              	pop	bp
38CD:007E CB              	retf

;; SplitFarHeapFreeBlock_007F: 38CD:007F
;;   Called from:
;;     38CD:0299 (in AllocateFarHeapBytes)
SplitFarHeapFreeBlock_007F proc
38CD:007F 55              	push	bp
38CD:0080 8B EC           	mov	bp,sp
38CD:0082 83 EC 04        	sub	sp,4h
38CD:0085 8B 56 0C        	mov	dx,[bp+0Ch]
38CD:0088 8B 46 0A        	mov	ax,[bp+0Ah]
38CD:008B C4 5E 06        	les	bx,[bp+6h]
38CD:008E 26 29 07        	sub	es:[bx],ax
38CD:0091 26 19 57 02     	sbb	es:[bx+2h],dx
38CD:0095 C4 5E 06        	les	bx,[bp+6h]
38CD:0098 26 8B 4F 02     	mov	cx,es:[bx+2h]
38CD:009C 26 8B 1F        	mov	bx,es:[bx]
38CD:009F 8B 56 08        	mov	dx,[bp+8h]
38CD:00A2 8B 46 06        	mov	ax,[bp+6h]
38CD:00A5 9A B0 53 00 08  	call	far 0800h:53B0h
38CD:00AA 89 56 FE        	mov	[bp-2h],dx
38CD:00AD 89 46 FC        	mov	[bp-4h],ax
38CD:00B0 8B 56 0C        	mov	dx,[bp+0Ch]
38CD:00B3 8B 46 0A        	mov	ax,[bp+0Ah]
38CD:00B6 05 01 00        	add	ax,1h
38CD:00B9 83 D2 00        	adc	dx,0h
38CD:00BC C4 5E FC        	les	bx,[bp-4h]
38CD:00BF 26 89 57 02     	mov	es:[bx+2h],dx
38CD:00C3 26 89 07        	mov	es:[bx],ax
38CD:00C6 8B 56 08        	mov	dx,[bp+8h]
38CD:00C9 8B 46 06        	mov	ax,[bp+6h]
38CD:00CC C4 5E FC        	les	bx,[bp-4h]
38CD:00CF 26 89 57 06     	mov	es:[bx+6h],dx
38CD:00D3 26 89 47 04     	mov	es:[bx+4h],ax
38CD:00D7 8B 4E 08        	mov	cx,[bp+8h]
38CD:00DA 8B 5E 06        	mov	bx,[bp+6h]
38CD:00DD 8B 16 20 70     	mov	dx,[7020h]
38CD:00E1 A1 1E 70        	mov	ax,[701Eh]
38CD:00E4 9A 0B 54 00 08  	call	far 0800h:540Bh
38CD:00E9 75 0D           	jnz	00F8h

l38CD_00EB:
38CD:00EB C4 5E FC        	les	bx,[bp-4h]
38CD:00EE 8C 06 20 70     	mov	[7020h],es
38CD:00F2 89 1E 1E 70     	mov	[701Eh],bx
38CD:00F6 EB 28           	jmp	0120h

l38CD_00F8:
38CD:00F8 8B 56 FE        	mov	dx,[bp-2h]
38CD:00FB 8B 46 FC        	mov	ax,[bp-4h]
38CD:00FE 8B 4E 0C        	mov	cx,[bp+0Ch]
38CD:0101 8B 5E 0A        	mov	bx,[bp+0Ah]
38CD:0104 9A B0 53 00 08  	call	far 0800h:53B0h
38CD:0109 89 56 08        	mov	[bp+8h],dx
38CD:010C 89 46 06        	mov	[bp+6h],ax
38CD:010F 8B 56 FE        	mov	dx,[bp-2h]
38CD:0112 8B 46 FC        	mov	ax,[bp-4h]
38CD:0115 C4 5E 06        	les	bx,[bp+6h]
38CD:0118 26 89 57 06     	mov	es:[bx+6h],dx
38CD:011C 26 89 47 04     	mov	es:[bx+4h],ax

l38CD_0120:
38CD:0120 8B 56 FE        	mov	dx,[bp-2h]
38CD:0123 8B 46 FC        	mov	ax,[bp-4h]
38CD:0126 05 08 00        	add	ax,8h
38CD:0129 EB 00           	jmp	012Bh

l38CD_012B:
38CD:012B 8B E5           	mov	sp,bp
38CD:012D 5D              	pop	bp
38CD:012E CB              	retf

;; ExtendFarHeap_012F: 38CD:012F
;;   Called from:
;;     38CD:0306 (in AllocateFarHeapBytes)
ExtendFarHeap_012F proc
38CD:012F 55              	push	bp
38CD:0130 8B EC           	mov	bp,sp
38CD:0132 83 EC 04        	sub	sp,4h
38CD:0135 FF 76 08        	push	word ptr [bp+8h]
38CD:0138 FF 76 06        	push	word ptr [bp+6h]
38CD:013B 9A D9 00 FE 38  	call	far 38FEh:00D9h
38CD:0140 59              	pop	cx
38CD:0141 59              	pop	cx
38CD:0142 89 56 FE        	mov	[bp-2h],dx
38CD:0145 89 46 FC        	mov	[bp-4h],ax
38CD:0148 83 7E FE FF     	cmp	word ptr [bp-2h],0FFh
38CD:014C 75 0C           	jnz	015Ah

l38CD_014E:
38CD:014E 83 7E FC FF     	cmp	word ptr [bp-4h],0FFh
38CD:0152 75 06           	jnz	015Ah

l38CD_0154:
38CD:0154 33 D2           	xor	dx,dx
38CD:0156 33 C0           	xor	ax,ax
38CD:0158 EB 3F           	jmp	0199h

l38CD_015A:
38CD:015A 8B 16 20 70     	mov	dx,[7020h]
38CD:015E A1 1E 70        	mov	ax,[701Eh]
38CD:0161 C4 5E FC        	les	bx,[bp-4h]
38CD:0164 26 89 57 06     	mov	es:[bx+6h],dx
38CD:0168 26 89 47 04     	mov	es:[bx+4h],ax
38CD:016C 8B 56 08        	mov	dx,[bp+8h]
38CD:016F 8B 46 06        	mov	ax,[bp+6h]
38CD:0172 05 01 00        	add	ax,1h
38CD:0175 83 D2 00        	adc	dx,0h
38CD:0178 C4 5E FC        	les	bx,[bp-4h]
38CD:017B 26 89 57 02     	mov	es:[bx+2h],dx
38CD:017F 26 89 07        	mov	es:[bx],ax
38CD:0182 C4 5E FC        	les	bx,[bp-4h]
38CD:0185 8C 06 20 70     	mov	[7020h],es
38CD:0189 89 1E 1E 70     	mov	[701Eh],bx
38CD:018D 8B 16 20 70     	mov	dx,[7020h]
38CD:0191 A1 1E 70        	mov	ax,[701Eh]
38CD:0194 05 08 00        	add	ax,8h
38CD:0197 EB 00           	jmp	0199h

l38CD_0199:
38CD:0199 8B E5           	mov	sp,bp
38CD:019B 5D              	pop	bp
38CD:019C CB              	retf

;; InitializeFarHeap_019D: 38CD:019D
;;   Called from:
;;     38CD:0249 (in AllocateFarHeapBytes)
InitializeFarHeap_019D proc
38CD:019D 55              	push	bp
38CD:019E 8B EC           	mov	bp,sp
38CD:01A0 83 EC 04        	sub	sp,4h
38CD:01A3 FF 76 08        	push	word ptr [bp+8h]
38CD:01A6 FF 76 06        	push	word ptr [bp+6h]
38CD:01A9 9A D9 00 FE 38  	call	far 38FEh:00D9h
38CD:01AE 59              	pop	cx
38CD:01AF 59              	pop	cx
38CD:01B0 89 56 FE        	mov	[bp-2h],dx
38CD:01B3 89 46 FC        	mov	[bp-4h],ax
38CD:01B6 83 7E FE FF     	cmp	word ptr [bp-2h],0FFh
38CD:01BA 75 0C           	jnz	01C8h

l38CD_01BC:
38CD:01BC 83 7E FC FF     	cmp	word ptr [bp-4h],0FFh
38CD:01C0 75 06           	jnz	01C8h

l38CD_01C2:
38CD:01C2 33 D2           	xor	dx,dx
38CD:01C4 33 C0           	xor	ax,ax
38CD:01C6 EB 37           	jmp	01FFh

l38CD_01C8:
38CD:01C8 C4 5E FC        	les	bx,[bp-4h]
38CD:01CB 8C 06 1C 70     	mov	[701Ch],es
38CD:01CF 89 1E 1A 70     	mov	[701Ah],bx
38CD:01D3 C4 5E FC        	les	bx,[bp-4h]
38CD:01D6 8C 06 20 70     	mov	[7020h],es
38CD:01DA 89 1E 1E 70     	mov	[701Eh],bx
38CD:01DE 8B 56 08        	mov	dx,[bp+8h]
38CD:01E1 8B 46 06        	mov	ax,[bp+6h]
38CD:01E4 05 01 00        	add	ax,1h
38CD:01E7 83 D2 00        	adc	dx,0h
38CD:01EA C4 5E FC        	les	bx,[bp-4h]
38CD:01ED 26 89 57 02     	mov	es:[bx+2h],dx
38CD:01F1 26 89 07        	mov	es:[bx],ax
38CD:01F4 8B 56 FE        	mov	dx,[bp-2h]
38CD:01F7 8B 46 FC        	mov	ax,[bp-4h]
38CD:01FA 05 08 00        	add	ax,8h
38CD:01FD EB 00           	jmp	01FFh

l38CD_01FF:
38CD:01FF 8B E5           	mov	sp,bp
38CD:0201 5D              	pop	bp
38CD:0202 CB              	retf

;; AllocateFarHeapBytes: 38CD:0203
;;   Called from:
;;     0D56:0126 (in AllocateParagraphAlignedMemory)
;;     3390:0AF1 (in InitializeResourceCache)
;;     38CD:000C (in AllocateFarHeapBytes16)
AllocateFarHeapBytes proc
38CD:0203 55              	push	bp
38CD:0204 8B EC           	mov	bp,sp
38CD:0206 83 EC 04        	sub	sp,4h
38CD:0209 8B 46 06        	mov	ax,[bp+6h]
38CD:020C 0B 46 08        	or	ax,[bp+8h]
38CD:020F 75 07           	jnz	0218h

l38CD_0211:
38CD:0211 33 D2           	xor	dx,dx
38CD:0213 33 C0           	xor	ax,ax
38CD:0215 E9 F6 00        	jmp	030Eh

l38CD_0218:
38CD:0218 8B 56 08        	mov	dx,[bp+8h]
38CD:021B 8B 46 06        	mov	ax,[bp+6h]
38CD:021E 05 17 00        	add	ax,17h
38CD:0221 83 D2 00        	adc	dx,0h
38CD:0224 25 F0 FF        	and	ax,0FFF0h
38CD:0227 81 E2 FF FF     	and	dx,0FFFFh
38CD:022B 89 56 08        	mov	[bp+8h],dx
38CD:022E 89 46 06        	mov	[bp+6h],ax
38CD:0231 33 C9           	xor	cx,cx
38CD:0233 33 DB           	xor	bx,bx
38CD:0235 8B 16 1C 70     	mov	dx,[701Ch]
38CD:0239 A1 1A 70        	mov	ax,[701Ah]
38CD:023C 9A 0B 54 00 08  	call	far 0800h:540Bh
38CD:0241 75 0F           	jnz	0252h

l38CD_0243:
38CD:0243 FF 76 08        	push	word ptr [bp+8h]
38CD:0246 FF 76 06        	push	word ptr [bp+6h]
38CD:0249 0E              	push	cs
38CD:024A E8 50 FF        	call	019Dh
38CD:024D 59              	pop	cx
38CD:024E 59              	pop	cx
38CD:024F E9 BC 00        	jmp	030Eh

l38CD_0252:
38CD:0252 8B 16 24 70     	mov	dx,[7024h]
38CD:0256 A1 22 70        	mov	ax,[7022h]
38CD:0259 89 56 FE        	mov	[bp-2h],dx
38CD:025C 89 46 FC        	mov	[bp-4h],ax
38CD:025F 33 C9           	xor	cx,cx
38CD:0261 33 DB           	xor	bx,bx
38CD:0263 9A 0B 54 00 08  	call	far 0800h:540Bh
38CD:0268 75 03           	jnz	026Dh

l38CD_026A:
38CD:026A E9 93 00        	jmp	0300h

l38CD_026D:
38CD:026D C4 5E FC        	les	bx,[bp-4h]
38CD:0270 26 8B 57 02     	mov	dx,es:[bx+2h]
38CD:0274 26 8B 07        	mov	ax,es:[bx]
38CD:0277 8B 4E 08        	mov	cx,[bp+8h]
38CD:027A 8B 5E 06        	mov	bx,[bp+6h]
38CD:027D 83 C3 30        	add	bx,30h
38CD:0280 83 D1 00        	adc	cx,0h
38CD:0283 3B D1           	cmp	dx,cx
38CD:0285 72 1B           	jc	02A2h

l38CD_0287:
38CD:0287 75 04           	jnz	028Dh

l38CD_0289:
38CD:0289 3B C3           	cmp	ax,bx
38CD:028B 72 15           	jc	02A2h

l38CD_028D:
38CD:028D FF 76 08        	push	word ptr [bp+8h]
38CD:0290 FF 76 06        	push	word ptr [bp+6h]
38CD:0293 FF 76 FE        	push	word ptr [bp-2h]
38CD:0296 FF 76 FC        	push	word ptr [bp-4h]
38CD:0299 0E              	push	cs
38CD:029A E8 E2 FD        	call	007Fh
38CD:029D 83 C4 08        	add	sp,8h
38CD:02A0 EB 6C           	jmp	030Eh

l38CD_02A2:
38CD:02A2 C4 5E FC        	les	bx,[bp-4h]
38CD:02A5 26 8B 57 02     	mov	dx,es:[bx+2h]
38CD:02A9 26 8B 07        	mov	ax,es:[bx]
38CD:02AC 3B 56 08        	cmp	dx,[bp+8h]
38CD:02AF 72 2A           	jc	02DBh

l38CD_02B1:
38CD:02B1 75 05           	jnz	02B8h

l38CD_02B3:
38CD:02B3 3B 46 06        	cmp	ax,[bp+6h]
38CD:02B6 72 23           	jc	02DBh

l38CD_02B8:
38CD:02B8 FF 76 FE        	push	word ptr [bp-2h]
38CD:02BB FF 76 FC        	push	word ptr [bp-4h]
38CD:02BE 0E              	push	cs
38CD:02BF E8 55 FD        	call	0017h
38CD:02C2 59              	pop	cx
38CD:02C3 59              	pop	cx
38CD:02C4 C4 5E FC        	les	bx,[bp-4h]
38CD:02C7 26 83 07 01     	add	word ptr es:[bx],1h
38CD:02CB 26 83 57 02 00  	adc	word ptr es:[bx+2h],0h
38CD:02D0 8B 56 FE        	mov	dx,[bp-2h]
38CD:02D3 8B 46 FC        	mov	ax,[bp-4h]
38CD:02D6 05 08 00        	add	ax,8h
38CD:02D9 EB 33           	jmp	030Eh

l38CD_02DB:
38CD:02DB C4 5E FC        	les	bx,[bp-4h]
38CD:02DE 26 C4 5F 0C     	les	bx,es:[bx+0Ch]
38CD:02E2 8C 46 FE        	mov	[bp-2h],es
38CD:02E5 89 5E FC        	mov	[bp-4h],bx
38CD:02E8 8B 0E 24 70     	mov	cx,[7024h]
38CD:02EC 8B 1E 22 70     	mov	bx,[7022h]
38CD:02F0 8B 56 FE        	mov	dx,[bp-2h]
38CD:02F3 8B 46 FC        	mov	ax,[bp-4h]
38CD:02F6 9A 0B 54 00 08  	call	far 0800h:540Bh
38CD:02FB 74 03           	jz	0300h

l38CD_02FD:
38CD:02FD E9 6D FF        	jmp	026Dh

l38CD_0300:
38CD:0300 FF 76 08        	push	word ptr [bp+8h]
38CD:0303 FF 76 06        	push	word ptr [bp+6h]
38CD:0306 0E              	push	cs
38CD:0307 E8 25 FE        	call	012Fh
38CD:030A 59              	pop	cx
38CD:030B 59              	pop	cx
38CD:030C EB 00           	jmp	030Eh

l38CD_030E:
38CD:030E 8B E5           	mov	sp,bp
