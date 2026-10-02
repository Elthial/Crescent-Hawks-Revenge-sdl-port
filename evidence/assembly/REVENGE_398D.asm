;;; Segment 398D (398D:0000)
398D:0000 55 00 08 05 F8 FF 83 D2 FF EB 00                U..........     

l398B_002B:
398B:002B CB              	retf

;; FreeHeapBlock: 398D:000C
;;   Called from:
;;     0D56:0192 (in FreeFarMemory)
;;     2507:6254 (in FreeGraphicsBufferRange_623D)
;;     3477:0150 (in LoadFontResource_000B)
;;     3477:0169 (in LoadFontResource_000B)
FreeHeapBlock proc
398D:000C 55              	push	bp
398D:000D 8B EC           	mov	bp,sp
398D:000F FF 76 08        	push	word ptr [bp+8h]
398D:0012 FF 76 06        	push	word ptr [bp+6h]
398D:0015 9A E6 02 8D 39  	call	far 398Dh:02E6h
398D:001A 8B E5           	mov	sp,bp
398D:001C 5D              	pop	bp
398D:001D CB              	retf

;; InsertFarHeapFreeBlock_001E: 398D:001E
;;   Called from:
;;     398D:02B4 (in FreeAndCoalesceFarHeapBlock_021A)
InsertFarHeapFreeBlock_001E proc
398D:001E 55              	push	bp
398D:001F 8B EC           	mov	bp,sp
398D:0021 83 EC 04        	sub	sp,4h
398D:0024 33 C9           	xor	cx,cx
398D:0026 33 DB           	xor	bx,bx
398D:0028 8B 16 24 70     	mov	dx,[7024h]
398D:002C A1 22 70        	mov	ax,[7022h]
398D:002F 9A 0B 54 00 08  	call	far 0800h:540Bh
398D:0034 74 56           	jz	008Ch

l398D_0036:
398D:0036 C4 1E 22 70     	les	bx,[7022h]
398D:003A 26 C4 5F 0C     	les	bx,es:[bx+0Ch]
398D:003E 8C 46 FE        	mov	[bp-2h],es
398D:0041 89 5E FC        	mov	[bp-4h],bx
398D:0044 8B 56 08        	mov	dx,[bp+8h]
398D:0047 8B 46 06        	mov	ax,[bp+6h]
398D:004A C4 1E 22 70     	les	bx,[7022h]
398D:004E 26 89 57 0E     	mov	es:[bx+0Eh],dx
398D:0052 26 89 47 0C     	mov	es:[bx+0Ch],ax
398D:0056 8B 56 08        	mov	dx,[bp+8h]
398D:0059 8B 46 06        	mov	ax,[bp+6h]
398D:005C C4 5E FC        	les	bx,[bp-4h]
398D:005F 26 89 57 0A     	mov	es:[bx+0Ah],dx
398D:0063 26 89 47 08     	mov	es:[bx+8h],ax
398D:0067 8B 56 FE        	mov	dx,[bp-2h]
398D:006A 8B 46 FC        	mov	ax,[bp-4h]
398D:006D C4 5E 06        	les	bx,[bp+6h]
398D:0070 26 89 57 0E     	mov	es:[bx+0Eh],dx
398D:0074 26 89 47 0C     	mov	es:[bx+0Ch],ax
398D:0078 8B 16 24 70     	mov	dx,[7024h]
398D:007C A1 22 70        	mov	ax,[7022h]
398D:007F C4 5E 06        	les	bx,[bp+6h]
398D:0082 26 89 57 0A     	mov	es:[bx+0Ah],dx
398D:0086 26 89 47 08     	mov	es:[bx+8h],ax
398D:008A EB 2D           	jmp	00B9h

l398D_008C:
398D:008C C4 5E 06        	les	bx,[bp+6h]
398D:008F 8C 06 24 70     	mov	[7024h],es
398D:0093 89 1E 22 70     	mov	[7022h],bx
398D:0097 8B 56 08        	mov	dx,[bp+8h]
398D:009A 8B 46 06        	mov	ax,[bp+6h]
398D:009D C4 5E 06        	les	bx,[bp+6h]
398D:00A0 26 89 57 0A     	mov	es:[bx+0Ah],dx
398D:00A4 26 89 47 08     	mov	es:[bx+8h],ax
398D:00A8 8B 56 08        	mov	dx,[bp+8h]
398D:00AB 8B 46 06        	mov	ax,[bp+6h]
398D:00AE C4 5E 06        	les	bx,[bp+6h]
398D:00B1 26 89 57 0E     	mov	es:[bx+0Eh],dx
398D:00B5 26 89 47 0C     	mov	es:[bx+0Ch],ax

l398D_00B9:
398D:00B9 8B E5           	mov	sp,bp
398D:00BB 5D              	pop	bp
398D:00BC CB              	retf

;; CoalesceFarHeapSuccessor_00BD: 398D:00BD
;;   Called from:
;;     398D:02DB (in FreeAndCoalesceFarHeapBlock_021A)
CoalesceFarHeapSuccessor_00BD proc
398D:00BD 55              	push	bp
398D:00BE 8B EC           	mov	bp,sp
398D:00C0 83 EC 04        	sub	sp,4h
398D:00C3 C4 5E 0A        	les	bx,[bp+0Ah]
398D:00C6 26 8B 57 02     	mov	dx,es:[bx+2h]
398D:00CA 26 8B 07        	mov	ax,es:[bx]
398D:00CD C4 5E 06        	les	bx,[bp+6h]
398D:00D0 26 01 07        	add	es:[bx],ax
398D:00D3 26 11 57 02     	adc	es:[bx+2h],dx
398D:00D7 8B 4E 0C        	mov	cx,[bp+0Ch]
398D:00DA 8B 5E 0A        	mov	bx,[bp+0Ah]
398D:00DD 8B 16 20 70     	mov	dx,[7020h]
398D:00E1 A1 1E 70        	mov	ax,[701Eh]
398D:00E4 9A 0B 54 00 08  	call	far 0800h:540Bh
398D:00E9 75 0D           	jnz	00F8h

l398D_00EB:
398D:00EB C4 5E 06        	les	bx,[bp+6h]
398D:00EE 8C 06 20 70     	mov	[7020h],es
398D:00F2 89 1E 1E 70     	mov	[701Eh],bx
398D:00F6 EB 2C           	jmp	0124h

l398D_00F8:
398D:00F8 C4 5E 0A        	les	bx,[bp+0Ah]
398D:00FB 26 8B 4F 02     	mov	cx,es:[bx+2h]
398D:00FF 26 8B 1F        	mov	bx,es:[bx]
398D:0102 8B 56 0C        	mov	dx,[bp+0Ch]
398D:0105 8B 46 0A        	mov	ax,[bp+0Ah]
398D:0108 9A B0 53 00 08  	call	far 0800h:53B0h
398D:010D 89 56 FE        	mov	[bp-2h],dx
398D:0110 89 46 FC        	mov	[bp-4h],ax
398D:0113 8B 56 08        	mov	dx,[bp+8h]
398D:0116 8B 46 06        	mov	ax,[bp+6h]
398D:0119 C4 5E FC        	les	bx,[bp-4h]
398D:011C 26 89 57 06     	mov	es:[bx+6h],dx
398D:0120 26 89 47 04     	mov	es:[bx+4h],ax

l398D_0124:
398D:0124 FF 76 0C        	push	word ptr [bp+0Ch]
398D:0127 FF 76 0A        	push	word ptr [bp+0Ah]
398D:012A 9A 17 00 CD 38  	call	far 38CDh:0017h
398D:012F 59              	pop	cx
398D:0130 59              	pop	cx
398D:0131 8B E5           	mov	sp,bp
398D:0133 5D              	pop	bp
398D:0134 CB              	retf

;; ReleaseFarHeapTail_0135: 398D:0135
;;   Called from:
;;     398D:031C (in FreeFarHeapAllocation)
ReleaseFarHeapTail_0135 proc
398D:0135 55              	push	bp
398D:0136 8B EC           	mov	bp,sp
398D:0138 83 EC 04        	sub	sp,4h
398D:013B 8B 0E 20 70     	mov	cx,[7020h]
398D:013F 8B 1E 1E 70     	mov	bx,[701Eh]
398D:0143 8B 16 1C 70     	mov	dx,[701Ch]
398D:0147 A1 1A 70        	mov	ax,[701Ah]
398D:014A 9A 0B 54 00 08  	call	far 0800h:540Bh
398D:014F 75 2C           	jnz	017Dh

l398D_0151:
398D:0151 FF 36 1C 70     	push	word ptr [701Ch]
398D:0155 FF 36 1A 70     	push	word ptr [701Ah]
398D:0159 9A 92 00 FE 38  	call	far 38FEh:0092h
398D:015E 59              	pop	cx
398D:015F 59              	pop	cx
398D:0160 C7 06 20 70 00 00 	mov	word ptr [7020h],0h
398D:0166 C7 06 1E 70 00 00 	mov	word ptr [701Eh],0h
398D:016C 33 DB           	xor	bx,bx
398D:016E 8E C3           	mov	es,bx
398D:0170 33 DB           	xor	bx,bx
398D:0172 8C 06 1C 70     	mov	[701Ch],es
398D:0176 89 1E 1A 70     	mov	[701Ah],bx
398D:017A E9 99 00        	jmp	0216h

l398D_017D:
398D:017D C4 1E 1E 70     	les	bx,[701Eh]
398D:0181 26 C4 5F 04     	les	bx,es:[bx+4h]
398D:0185 8C 46 FE        	mov	[bp-2h],es
398D:0188 89 5E FC        	mov	[bp-4h],bx
398D:018B C4 5E FC        	les	bx,[bp-4h]
398D:018E 26 8B 57 02     	mov	dx,es:[bx+2h]
398D:0192 26 8B 07        	mov	ax,es:[bx]
398D:0195 25 01 00        	and	ax,1h
398D:0198 81 E2 00 00     	and	dx,0h
398D:019C 0B D0           	or	dx,ax
398D:019E 75 5C           	jnz	01FCh

l398D_01A0:
398D:01A0 FF 76 FE        	push	word ptr [bp-2h]
398D:01A3 FF 76 FC        	push	word ptr [bp-4h]
398D:01A6 9A 17 00 CD 38  	call	far 38CDh:0017h
398D:01AB 59              	pop	cx
398D:01AC 59              	pop	cx
398D:01AD 8B 0E 1C 70     	mov	cx,[701Ch]
398D:01B1 8B 1E 1A 70     	mov	bx,[701Ah]
398D:01B5 8B 56 FE        	mov	dx,[bp-2h]
398D:01B8 8B 46 FC        	mov	ax,[bp-4h]
398D:01BB 9A 0B 54 00 08  	call	far 0800h:540Bh
398D:01C0 75 1C           	jnz	01DEh

l398D_01C2:
398D:01C2 C7 06 20 70 00 00 	mov	word ptr [7020h],0h
398D:01C8 C7 06 1E 70 00 00 	mov	word ptr [701Eh],0h
398D:01CE 33 DB           	xor	bx,bx
398D:01D0 8E C3           	mov	es,bx
398D:01D2 33 DB           	xor	bx,bx
398D:01D4 8C 06 1C 70     	mov	[701Ch],es
398D:01D8 89 1E 1A 70     	mov	[701Ah],bx
398D:01DC EB 0F           	jmp	01EDh

l398D_01DE:
398D:01DE C4 5E FC        	les	bx,[bp-4h]
398D:01E1 26 C4 5F 04     	les	bx,es:[bx+4h]
398D:01E5 8C 06 20 70     	mov	[7020h],es
398D:01E9 89 1E 1E 70     	mov	[701Eh],bx

l398D_01ED:
398D:01ED FF 76 FE        	push	word ptr [bp-2h]
398D:01F0 FF 76 FC        	push	word ptr [bp-4h]
398D:01F3 9A 92 00 FE 38  	call	far 38FEh:0092h
398D:01F8 59              	pop	cx
398D:01F9 59              	pop	cx
398D:01FA EB 1A           	jmp	0216h

l398D_01FC:
398D:01FC FF 36 20 70     	push	word ptr [7020h]
398D:0200 FF 36 1E 70     	push	word ptr [701Eh]
398D:0204 9A 92 00 FE 38  	call	far 38FEh:0092h
398D:0209 59              	pop	cx
398D:020A 59              	pop	cx
398D:020B C4 5E FC        	les	bx,[bp-4h]
398D:020E 8C 06 20 70     	mov	[7020h],es
398D:0212 89 1E 1E 70     	mov	[701Eh],bx

l398D_0216:
398D:0216 8B E5           	mov	sp,bp
398D:0218 5D              	pop	bp
398D:0219 CB              	retf

;; FreeAndCoalesceFarHeapBlock_021A: 398D:021A
;;   Called from:
;;     398D:0328 (in FreeFarHeapAllocation)
FreeAndCoalesceFarHeapBlock_021A proc
398D:021A 55              	push	bp
398D:021B 8B EC           	mov	bp,sp
398D:021D 83 EC 08        	sub	sp,8h
398D:0220 C4 5E 06        	les	bx,[bp+6h]
398D:0223 26 83 2F 01     	sub	word ptr es:[bx],1h
398D:0227 26 83 5F 02 00  	sbb	word ptr es:[bx+2h],0h
398D:022C C4 5E 06        	les	bx,[bp+6h]
398D:022F 26 8B 4F 02     	mov	cx,es:[bx+2h]
398D:0233 26 8B 1F        	mov	bx,es:[bx]
398D:0236 8B 56 08        	mov	dx,[bp+8h]
398D:0239 8B 46 06        	mov	ax,[bp+6h]
398D:023C 9A B0 53 00 08  	call	far 0800h:53B0h
398D:0241 89 56 FA        	mov	[bp-6h],dx
398D:0244 89 46 F8        	mov	[bp-8h],ax
398D:0247 C4 5E 06        	les	bx,[bp+6h]
398D:024A 26 C4 5F 04     	les	bx,es:[bx+4h]
398D:024E 8C 46 FE        	mov	[bp-2h],es
398D:0251 89 5E FC        	mov	[bp-4h],bx
398D:0254 C4 5E FC        	les	bx,[bp-4h]
398D:0257 26 8B 57 02     	mov	dx,es:[bx+2h]
398D:025B 26 8B 07        	mov	ax,es:[bx]
398D:025E 25 01 00        	and	ax,1h
398D:0261 81 E2 00 00     	and	dx,0h
398D:0265 0B D0           	or	dx,ax
398D:0267 75 45           	jnz	02AEh

l398D_0269:
398D:0269 8B 0E 1C 70     	mov	cx,[701Ch]
398D:026D 8B 1E 1A 70     	mov	bx,[701Ah]
398D:0271 8B 56 08        	mov	dx,[bp+8h]
398D:0274 8B 46 06        	mov	ax,[bp+6h]
398D:0277 9A 0B 54 00 08  	call	far 0800h:540Bh
398D:027C 74 30           	jz	02AEh

l398D_027E:
398D:027E C4 5E 06        	les	bx,[bp+6h]
398D:0281 26 8B 57 02     	mov	dx,es:[bx+2h]
398D:0285 26 8B 07        	mov	ax,es:[bx]
398D:0288 C4 5E FC        	les	bx,[bp-4h]
398D:028B 26 01 07        	add	es:[bx],ax
398D:028E 26 11 57 02     	adc	es:[bx+2h],dx
398D:0292 8B 56 FE        	mov	dx,[bp-2h]
398D:0295 8B 46 FC        	mov	ax,[bp-4h]
398D:0298 C4 5E F8        	les	bx,[bp-8h]
398D:029B 26 89 57 06     	mov	es:[bx+6h],dx
398D:029F 26 89 47 04     	mov	es:[bx+4h],ax
398D:02A3 C4 5E FC        	les	bx,[bp-4h]
398D:02A6 8C 46 08        	mov	[bp+8h],es
398D:02A9 89 5E 06        	mov	[bp+6h],bx
398D:02AC EB 0C           	jmp	02BAh

l398D_02AE:
398D:02AE FF 76 08        	push	word ptr [bp+8h]
398D:02B1 FF 76 06        	push	word ptr [bp+6h]
398D:02B4 0E              	push	cs
398D:02B5 E8 66 FD        	call	001Eh
398D:02B8 59              	pop	cx
398D:02B9 59              	pop	cx

l398D_02BA:
398D:02BA C4 5E F8        	les	bx,[bp-8h]
398D:02BD 26 8B 57 02     	mov	dx,es:[bx+2h]
398D:02C1 26 8B 07        	mov	ax,es:[bx]
398D:02C4 25 01 00        	and	ax,1h
398D:02C7 81 E2 00 00     	and	dx,0h
398D:02CB 0B D0           	or	dx,ax
398D:02CD 75 13           	jnz	02E2h

l398D_02CF:
398D:02CF FF 76 FA        	push	word ptr [bp-6h]
398D:02D2 FF 76 F8        	push	word ptr [bp-8h]
398D:02D5 FF 76 08        	push	word ptr [bp+8h]
398D:02D8 FF 76 06        	push	word ptr [bp+6h]
398D:02DB 0E              	push	cs
398D:02DC E8 DE FD        	call	00BDh
398D:02DF 83 C4 08        	add	sp,8h

l398D_02E2:
398D:02E2 8B E5           	mov	sp,bp
398D:02E4 5D              	pop	bp
398D:02E5 CB              	retf

;; FreeFarHeapAllocation: 398D:02E6
;;   Called from:
;;     0D56:01CA (in FreeParagraphAlignedMemory)
;;     3390:09C1 (in ReleaseCachedResources)
;;     3390:0B49 (in InitializeResourceCache)
;;     3390:0BD1 (in InitializeResourceCache)
;;     398D:0015 (in FreeHeapBlock)
FreeFarHeapAllocation proc
398D:02E6 55              	push	bp
398D:02E7 8B EC           	mov	bp,sp
398D:02E9 8B 46 06        	mov	ax,[bp+6h]
398D:02EC 0B 46 08        	or	ax,[bp+8h]
398D:02EF 75 02           	jnz	02F3h

l398D_02F1:
398D:02F1 EB 3B           	jmp	032Eh

l398D_02F3:
398D:02F3 8B 56 08        	mov	dx,[bp+8h]
398D:02F6 8B 46 06        	mov	ax,[bp+6h]
398D:02F9 B9 FF FF        	mov	cx,0FFFFh
398D:02FC BB F8 FF        	mov	bx,0FFF8h
398D:02FF 9A B0 53 00 08  	call	far 0800h:53B0h
398D:0304 89 56 08        	mov	[bp+8h],dx
398D:0307 89 46 06        	mov	[bp+6h],ax
398D:030A 8B 56 08        	mov	dx,[bp+8h]
398D:030D 8B 46 06        	mov	ax,[bp+6h]
398D:0310 3B 16 20 70     	cmp	dx,[7020h]
398D:0314 75 0C           	jnz	0322h

l398D_0316:
398D:0316 3B 06 1E 70     	cmp	ax,[701Eh]
398D:031A 75 06           	jnz	0322h

l398D_031C:
398D:031C 0E              	push	cs
398D:031D E8 15 FE        	call	0135h
398D:0320 EB 0C           	jmp	032Eh

l398D_0322:
398D:0322 FF 76 08        	push	word ptr [bp+8h]
398D:0325 FF 76 06        	push	word ptr [bp+6h]
398D:0328 0E              	push	cs
398D:0329 E8 EE FE        	call	021Ah
398D:032C 8B E5           	mov	sp,bp

l398D_032E:
398D:032E 5D              	pop	bp
398D:032F CB              	retf
