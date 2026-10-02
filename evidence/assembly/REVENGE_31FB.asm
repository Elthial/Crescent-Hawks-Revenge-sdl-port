;;; Segment 31FB (31FB:0000)

l30F1_10A0:
30F1:10A0 E9 65 FF        	jmp	1008h

l30F1_10A3:
30F1:10A3 5E              	pop	si
30F1:10A4 CB              	retf

;; InitializeDigitalSoundDriver_0005: 31FB:0005
;;   Called from:
;;     2C7F:02B0 (in InitializeGame_003C)
InitializeDigitalSoundDriver_0005 proc
31FB:0005 55              	push	bp
31FB:0006 8B EC           	mov	bp,sp
31FB:0008 83 EC 04        	sub	sp,4h
31FB:000B 80 3E 65 86 00  	cmp	byte ptr [8665h],0h
31FB:0010 7F 03           	jg	0015h

l31FB_0012:
31FB:0012 E9 89 00        	jmp	009Eh

l31FB_0015:
31FB:0015 A0 65 86        	mov	al,[8665h]
31FB:0018 98              	cbw
31FB:0019 8B D8           	mov	bx,ax
31FB:001B D1 E3           	shl	bx,1h
31FB:001D 8B 9F 3E 59     	mov	bx,[bx+593Eh]
31FB:0021 8B 07           	mov	ax,[bx]
31FB:0023 A3 12 B6        	mov	[0B612h],ax
31FB:0026 80 3E 65 86 04  	cmp	byte ptr [8665h],4h
31FB:002B 75 0A           	jnz	0037h

l31FB_002D:
31FB:002D FF 36 12 B6     	push	word ptr [0B612h]
31FB:0031 9A 06 00 5F 37  	call	far 375Fh:0006h
31FB:0036 59              	pop	cx

l31FB_0037:
31FB:0037 FF 36 72 83     	push	word ptr [8372h]
31FB:003B FF 36 12 B6     	push	word ptr [0B612h]
31FB:003F 9A 44 00 5F 37  	call	far 375Fh:0044h
31FB:0044 59              	pop	cx
31FB:0045 59              	pop	cx
31FB:0046 33 C0           	xor	ax,ax
31FB:0048 50              	push	ax
31FB:0049 9A C6 09 5F 37  	call	far 375Fh:09C6h
31FB:004E 59              	pop	cx
31FB:004F A0 65 86        	mov	al,[8665h]
31FB:0052 98              	cbw
31FB:0053 8B D8           	mov	bx,ax
31FB:0055 D1 E3           	shl	bx,1h
31FB:0057 FF B7 3E 59     	push	word ptr [bx+593Eh]
31FB:005B 9A D6 05 5F 37  	call	far 375Fh:05D6h
31FB:0060 59              	pop	cx
31FB:0061 D1 EA           	shr	dx,1h
31FB:0063 D1 D8           	rcr	ax,1h
31FB:0065 89 56 FE        	mov	[bp-2h],dx
31FB:0068 89 46 FC        	mov	[bp-4h],ax
31FB:006B 83 7E FE 00     	cmp	word ptr [bp-2h],0h
31FB:006F 7C 0E           	jl	007Fh

l31FB_0071:
31FB:0071 7F 07           	jg	007Ah

l31FB_0073:
31FB:0073 81 7E FC 40 1F  	cmp	word ptr [bp-4h],1F40h
31FB:0078 76 05           	jbe	007Fh

l31FB_007A:
31FB:007A B8 40 1F        	mov	ax,1F40h
31FB:007D EB 03           	jmp	0082h

l31FB_007F:
31FB:007F 8B 46 FC        	mov	ax,[bp-4h]

l31FB_0082:
31FB:0082 A3 26 B6        	mov	[0B626h],ax
31FB:0085 1E              	push	ds
31FB:0086 B8 14 B6        	mov	ax,0B614h
31FB:0089 50              	push	ax
31FB:008A 9A C7 06 5F 37  	call	far 375Fh:06C7h
31FB:008F 59              	pop	cx
31FB:0090 59              	pop	cx
31FB:0091 81 3E 26 B6 B8 0B 	cmp	word ptr [0B626h],0BB8h
31FB:0097 73 05           	jnc	009Eh

l31FB_0099:
31FB:0099 C6 06 65 86 00  	mov	byte ptr [8665h],0h

l31FB_009E:
31FB:009E 80 3E 65 86 00  	cmp	byte ptr [8665h],0h
31FB:00A3 75 0A           	jnz	00AFh

l31FB_00A5:
31FB:00A5 B8 40 1F        	mov	ax,1F40h
31FB:00A8 50              	push	ax
31FB:00A9 9A 0E 00 17 37  	call	far 3717h:000Eh
31FB:00AE 59              	pop	cx

l31FB_00AF:
31FB:00AF 8B E5           	mov	sp,bp
31FB:00B1 5D              	pop	bp
31FB:00B2 CB              	retf

;; LoadDigitalWeaponEffectBank_00B3: 31FB:00B3
;;   Called from:
;;     0D73:0281 (in InitializeTacticalScenario_0214)
LoadDigitalWeaponEffectBank_00B3 proc
31FB:00B3 55              	push	bp
31FB:00B4 8B EC           	mov	bp,sp
31FB:00B6 83 EC 0C        	sub	sp,0Ch
31FB:00B9 56              	push	si
31FB:00BA 57              	push	di
31FB:00BB 80 3E 65 86 01  	cmp	byte ptr [8665h],1h
31FB:00C0 7D 03           	jge	00C5h

l31FB_00C2:
31FB:00C2 E9 8B 01        	jmp	0250h

l31FB_00C5:
31FB:00C5 BF 10 00        	mov	di,10h
31FB:00C8 33 C0           	xor	ax,ax
31FB:00CA 89 46 F8        	mov	[bp-8h],ax
31FB:00CD 89 46 FA        	mov	[bp-6h],ax
31FB:00D0 33 F6           	xor	si,si
31FB:00D2 EB 28           	jmp	00FCh

l31FB_00D4:
31FB:00D4 8B C6           	mov	ax,si
31FB:00D6 BA 0A 00        	mov	dx,0Ah
31FB:00D9 F7 E2           	mul	dx
31FB:00DB 8B D8           	mov	bx,ax
31FB:00DD 81 C3 5C 5C     	add	bx,5C5Ch
31FB:00E1 1E              	push	ds
31FB:00E2 07              	pop	es
31FB:00E3 8C 46 FE        	mov	[bp-2h],es
31FB:00E6 89 5E FC        	mov	[bp-4h],bx
31FB:00E9 C4 5E FC        	les	bx,[bp-4h]
31FB:00EC 26 83 3F 00     	cmp	word ptr es:[bx],0h
31FB:00F0 7C 09           	jl	00FBh

l31FB_00F2:
31FB:00F2 C4 5E FC        	les	bx,[bp-4h]
31FB:00F5 26 C7 47 08 00 00 	mov	word ptr es:[bx+8h],0h

l31FB_00FB:
31FB:00FB 46              	inc	si

l31FB_00FC:
31FB:00FC 3B F7           	cmp	si,di
31FB:00FE 7C D4           	jl	00D4h

l31FB_0100:
31FB:0100 33 F6           	xor	si,si
31FB:0102 E9 C2 00        	jmp	01C7h

l31FB_0105:
31FB:0105 8B C6           	mov	ax,si
31FB:0107 BA 0A 00        	mov	dx,0Ah
31FB:010A F7 E2           	mul	dx
31FB:010C 8B D8           	mov	bx,ax
31FB:010E 81 C3 5C 5C     	add	bx,5C5Ch
31FB:0112 1E              	push	ds
31FB:0113 07              	pop	es
31FB:0114 8C 46 FE        	mov	[bp-2h],es
31FB:0117 89 5E FC        	mov	[bp-4h],bx
31FB:011A C4 5E FC        	les	bx,[bp-4h]
31FB:011D 26 8B 07        	mov	ax,es:[bx]
31FB:0120 89 46 F6        	mov	[bp-0Ah],ax
31FB:0123 83 7E F6 00     	cmp	word ptr [bp-0Ah],0h
31FB:0127 7D 03           	jge	012Ch

l31FB_0129:
31FB:0129 E9 9A 00        	jmp	01C6h

l31FB_012C:
31FB:012C C4 5E FC        	les	bx,[bp-4h]
31FB:012F 26 83 7F 08 00  	cmp	word ptr es:[bx+8h],0h
31FB:0134 74 03           	jz	0139h

l31FB_0136:
31FB:0136 E9 8D 00        	jmp	01C6h

l31FB_0139:
31FB:0139 C4 5E FC        	les	bx,[bp-4h]
31FB:013C 26 8B 07        	mov	ax,es:[bx]
31FB:013F BA 12 00        	mov	dx,12h
31FB:0142 F7 E2           	mul	dx
31FB:0144 8B D8           	mov	bx,ax
31FB:0146 81 C3 B0 10     	add	bx,10B0h
31FB:014A 1E              	push	ds
31FB:014B 07              	pop	es
31FB:014C 26 8B 47 04     	mov	ax,es:[bx+4h]
31FB:0150 89 46 F8        	mov	[bp-8h],ax
31FB:0153 8B 46 FA        	mov	ax,[bp-6h]
31FB:0156 C4 5E FC        	les	bx,[bp-4h]
31FB:0159 26 89 47 04     	mov	es:[bx+4h],ax
31FB:015D 8B 46 F8        	mov	ax,[bp-8h]
31FB:0160 C4 5E FC        	les	bx,[bp-4h]
31FB:0163 26 89 47 06     	mov	es:[bx+6h],ax
31FB:0167 C4 5E FC        	les	bx,[bp-4h]
31FB:016A 26 C7 47 08 01 00 	mov	word ptr es:[bx+8h],1h
31FB:0170 8B C6           	mov	ax,si
31FB:0172 40              	inc	ax
31FB:0173 89 46 F4        	mov	[bp-0Ch],ax
31FB:0176 EB 41           	jmp	01B9h

l31FB_0178:
31FB:0178 8B 46 F4        	mov	ax,[bp-0Ch]
31FB:017B BA 0A 00        	mov	dx,0Ah
31FB:017E F7 E2           	mul	dx
31FB:0180 8B D8           	mov	bx,ax
31FB:0182 81 C3 5C 5C     	add	bx,5C5Ch
31FB:0186 1E              	push	ds
31FB:0187 07              	pop	es
31FB:0188 8C 46 FE        	mov	[bp-2h],es
31FB:018B 89 5E FC        	mov	[bp-4h],bx
31FB:018E C4 5E FC        	les	bx,[bp-4h]
31FB:0191 26 8B 07        	mov	ax,es:[bx]
31FB:0194 3B 46 F6        	cmp	ax,[bp-0Ah]
31FB:0197 75 1D           	jnz	01B6h

l31FB_0199:
31FB:0199 8B 46 FA        	mov	ax,[bp-6h]
31FB:019C C4 5E FC        	les	bx,[bp-4h]
31FB:019F 26 89 47 04     	mov	es:[bx+4h],ax
31FB:01A3 8B 46 F8        	mov	ax,[bp-8h]
31FB:01A6 C4 5E FC        	les	bx,[bp-4h]
31FB:01A9 26 89 47 06     	mov	es:[bx+6h],ax
31FB:01AD C4 5E FC        	les	bx,[bp-4h]
31FB:01B0 26 C7 47 08 02 00 	mov	word ptr es:[bx+8h],2h

l31FB_01B6:
31FB:01B6 FF 46 F4        	inc	word ptr [bp-0Ch]

l31FB_01B9:
31FB:01B9 8B 46 F4        	mov	ax,[bp-0Ch]
31FB:01BC 3B C7           	cmp	ax,di
31FB:01BE 7C B8           	jl	0178h

l31FB_01C0:
31FB:01C0 8B 46 F8        	mov	ax,[bp-8h]
31FB:01C3 01 46 FA        	add	[bp-6h],ax

l31FB_01C6:
31FB:01C6 46              	inc	si

l31FB_01C7:
31FB:01C7 3B F7           	cmp	si,di
31FB:01C9 7D 03           	jge	01CEh

l31FB_01CB:
31FB:01CB E9 37 FF        	jmp	0105h

l31FB_01CE:
31FB:01CE 8B 46 FA        	mov	ax,[bp-6h]
31FB:01D1 33 D2           	xor	dx,dx
31FB:01D3 52              	push	dx
31FB:01D4 50              	push	ax
31FB:01D5 9A B5 00 56 0D  	call	far 0D56h:00B5h
31FB:01DA 59              	pop	cx
31FB:01DB 59              	pop	cx
31FB:01DC 89 16 2B B6     	mov	[0B62Bh],dx
31FB:01E0 A3 29 B6        	mov	[0B629h],ax
31FB:01E3 33 F6           	xor	si,si
31FB:01E5 EB 65           	jmp	024Ch

l31FB_01E7:
31FB:01E7 8B C6           	mov	ax,si
31FB:01E9 BA 0A 00        	mov	dx,0Ah
31FB:01EC F7 E2           	mul	dx
31FB:01EE 8B D8           	mov	bx,ax
31FB:01F0 81 C3 5C 5C     	add	bx,5C5Ch
31FB:01F4 1E              	push	ds
31FB:01F5 07              	pop	es
31FB:01F6 8C 46 FE        	mov	[bp-2h],es
31FB:01F9 89 5E FC        	mov	[bp-4h],bx
31FB:01FC C4 5E FC        	les	bx,[bp-4h]
31FB:01FF 26 83 3F 00     	cmp	word ptr es:[bx],0h
31FB:0203 7C 46           	jl	024Bh

l31FB_0205:
31FB:0205 C4 5E FC        	les	bx,[bp-4h]
31FB:0208 26 83 7F 08 01  	cmp	word ptr es:[bx+8h],1h
31FB:020D 75 3C           	jnz	024Bh

l31FB_020F:
31FB:020F C4 5E FC        	les	bx,[bp-4h]
31FB:0212 26 FF 77 06     	push	word ptr es:[bx+6h]
31FB:0216 C4 5E FC        	les	bx,[bp-4h]
31FB:0219 26 8B 47 04     	mov	ax,es:[bx+4h]
31FB:021D 8B 0E 2B B6     	mov	cx,[0B62Bh]
31FB:0221 8B 1E 29 B6     	mov	bx,[0B629h]
31FB:0225 03 D8           	add	bx,ax
31FB:0227 51              	push	cx
31FB:0228 53              	push	bx
31FB:0229 C4 5E FC        	les	bx,[bp-4h]
31FB:022C 26 8B 07        	mov	ax,es:[bx]
31FB:022F BA 12 00        	mov	dx,12h
31FB:0232 F7 E2           	mul	dx
31FB:0234 8B D8           	mov	bx,ax
31FB:0236 81 C3 B0 10     	add	bx,10B0h
31FB:023A 1E              	push	ds
31FB:023B 07              	pop	es
31FB:023C 26 FF 77 02     	push	word ptr es:[bx+2h]
31FB:0240 26 FF 37        	push	word ptr es:[bx]
31FB:0243 9A 0C 00 E7 21  	call	far 21E7h:000Ch
31FB:0248 83 C4 0A        	add	sp,0Ah

l31FB_024B:
31FB:024B 46              	inc	si

l31FB_024C:
31FB:024C 3B F7           	cmp	si,di
31FB:024E 7C 97           	jl	01E7h

l31FB_0250:
31FB:0250 5F              	pop	di
31FB:0251 5E              	pop	si
31FB:0252 8B E5           	mov	sp,bp
31FB:0254 5D              	pop	bp
31FB:0255 CB              	retf

;; FindDigitalSoundEntryByCode_0256: 31FB:0256
;;   Called from:
;;     31FB:044A (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:04B4 (in LoadScenarioDigitalSoundBank_0297)
;;     31FB:1145 (in PlayScenarioDigitalSoundSequence_0742)
FindDigitalSoundEntryByCode_0256 proc
31FB:0256 55              	push	bp
31FB:0257 8B EC           	mov	bp,sp
31FB:0259 83 EC 02        	sub	sp,2h
31FB:025C 56              	push	si
31FB:025D 57              	push	di
31FB:025E BF FF FF        	mov	di,0FFFFh
31FB:0261 C7 46 FE 16 00  	mov	word ptr [bp-2h],16h
31FB:0266 33 F6           	xor	si,si
31FB:0268 EB 1A           	jmp	0284h

l31FB_026A:
31FB:026A 8B C6           	mov	ax,si
31FB:026C BA 0B 00        	mov	dx,0Bh
31FB:026F F7 E2           	mul	dx
31FB:0271 8B D8           	mov	bx,ax
31FB:0273 81 C3 FC 5C     	add	bx,5CFCh
31FB:0277 1E              	push	ds
31FB:0278 07              	pop	es
31FB:0279 26 8A 07        	mov	al,es:[bx]
31FB:027C 3A 46 06        	cmp	al,[bp+6h]
31FB:027F 75 02           	jnz	0283h

l31FB_0281:
31FB:0281 8B FE           	mov	di,si

l31FB_0283:
31FB:0283 46              	inc	si

l31FB_0284:
31FB:0284 3B 76 FE        	cmp	si,[bp-2h]
31FB:0287 7D 04           	jge	028Dh

l31FB_0289:
31FB:0289 0B FF           	or	di,di
31FB:028B 7C DD           	jl	026Ah

l31FB_028D:
31FB:028D 8B C7           	mov	ax,di
31FB:028F EB 00           	jmp	0291h

l31FB_0291:
31FB:0291 5F              	pop	di
31FB:0292 5E              	pop	si
31FB:0293 8B E5           	mov	sp,bp
31FB:0295 5D              	pop	bp
31FB:0296 CB              	retf

;; LoadScenarioDigitalSoundBank_0297: 31FB:0297
;;   Called from:
;;     0D73:028B (in InitializeTacticalScenario_0214)
;;     0D73:30B1 (in RunTitleAndMainMenu_309C)
;;     0D73:30E1 (in RunTitleAndMainMenu_309C)
LoadScenarioDigitalSoundBank_0297 proc
31FB:0297 55              	push	bp
31FB:0298 8B EC           	mov	bp,sp
31FB:029A 83 EC 16        	sub	sp,16h
31FB:029D 56              	push	si
31FB:029E 57              	push	di
31FB:029F 8A 46 06        	mov	al,[bp+6h]
31FB:02A2 88 46 EF        	mov	[bp-11h],al
31FB:02A5 C6 46 F0 00     	mov	byte ptr [bp-10h],0h
31FB:02A9 80 7E EF FF     	cmp	byte ptr [bp-11h],0FFh
31FB:02AD 75 15           	jnz	02C4h

l31FB_02AF:
31FB:02AF 1E              	push	ds
31FB:02B0 B8 EE 5D        	mov	ax,5DEEh
31FB:02B3 50              	push	ax
31FB:02B4 16              	push	ss
31FB:02B5 8D 46 F0        	lea	ax,[bp-10h]
31FB:02B8 50              	push	ax
31FB:02B9 9A 00 00 83 39  	call	far 3983h:0000h
31FB:02BE 83 C4 08        	add	sp,8h
31FB:02C1 E9 76 01        	jmp	043Ah

l31FB_02C4:
31FB:02C4 80 7E EF FE     	cmp	byte ptr [bp-11h],0FEh
31FB:02C8 75 15           	jnz	02DFh

l31FB_02CA:
31FB:02CA 1E              	push	ds
31FB:02CB B8 F0 5D        	mov	ax,5DF0h
31FB:02CE 50              	push	ax
31FB:02CF 16              	push	ss
31FB:02D0 8D 46 F0        	lea	ax,[bp-10h]
31FB:02D3 50              	push	ax
31FB:02D4 9A 00 00 83 39  	call	far 3983h:0000h
31FB:02D9 83 C4 08        	add	sp,8h
31FB:02DC E9 5B 01        	jmp	043Ah

l31FB_02DF:
31FB:02DF 80 7E EF 31     	cmp	byte ptr [bp-11h],31h
31FB:02E3 7C 1B           	jl	0300h

l31FB_02E5:
31FB:02E5 80 7E EF 35     	cmp	byte ptr [bp-11h],35h
31FB:02E9 7F 15           	jg	0300h

l31FB_02EB:
31FB:02EB 1E              	push	ds
31FB:02EC B8 F2 5D        	mov	ax,5DF2h
31FB:02EF 50              	push	ax
31FB:02F0 16              	push	ss
31FB:02F1 8D 46 F0        	lea	ax,[bp-10h]
31FB:02F4 50              	push	ax
31FB:02F5 9A 00 00 83 39  	call	far 3983h:0000h
31FB:02FA 83 C4 08        	add	sp,8h
31FB:02FD E9 3A 01        	jmp	043Ah

l31FB_0300:
31FB:0300 80 7E EF 36     	cmp	byte ptr [bp-11h],36h
31FB:0304 75 15           	jnz	031Bh

l31FB_0306:
31FB:0306 1E              	push	ds
31FB:0307 B8 F9 5D        	mov	ax,5DF9h
31FB:030A 50              	push	ax
31FB:030B 16              	push	ss
31FB:030C 8D 46 F0        	lea	ax,[bp-10h]
31FB:030F 50              	push	ax
31FB:0310 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0315 83 C4 08        	add	sp,8h
31FB:0318 E9 1F 01        	jmp	043Ah

l31FB_031B:
31FB:031B 80 7E EF 37     	cmp	byte ptr [bp-11h],37h
31FB:031F 75 15           	jnz	0336h

l31FB_0321:
31FB:0321 1E              	push	ds
31FB:0322 B8 03 5E        	mov	ax,5E03h
31FB:0325 50              	push	ax
31FB:0326 16              	push	ss
31FB:0327 8D 46 F0        	lea	ax,[bp-10h]
31FB:032A 50              	push	ax
31FB:032B 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0330 83 C4 08        	add	sp,8h
31FB:0333 E9 04 01        	jmp	043Ah

l31FB_0336:
31FB:0336 80 7E EF 38     	cmp	byte ptr [bp-11h],38h
31FB:033A 75 15           	jnz	0351h

l31FB_033C:
31FB:033C 1E              	push	ds
31FB:033D B8 0A 5E        	mov	ax,5E0Ah
31FB:0340 50              	push	ax
31FB:0341 16              	push	ss
31FB:0342 8D 46 F0        	lea	ax,[bp-10h]
31FB:0345 50              	push	ax
31FB:0346 9A 00 00 83 39  	call	far 3983h:0000h
31FB:034B 83 C4 08        	add	sp,8h
31FB:034E E9 E9 00        	jmp	043Ah

l31FB_0351:
31FB:0351 80 7E EF 39     	cmp	byte ptr [bp-11h],39h
31FB:0355 75 15           	jnz	036Ch

l31FB_0357:
31FB:0357 1E              	push	ds
31FB:0358 B8 14 5E        	mov	ax,5E14h
31FB:035B 50              	push	ax
31FB:035C 16              	push	ss
31FB:035D 8D 46 F0        	lea	ax,[bp-10h]
31FB:0360 50              	push	ax
31FB:0361 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0366 83 C4 08        	add	sp,8h
31FB:0369 E9 CE 00        	jmp	043Ah

l31FB_036C:
31FB:036C 80 7E EF 41     	cmp	byte ptr [bp-11h],41h
31FB:0370 75 15           	jnz	0387h

l31FB_0372:
31FB:0372 1E              	push	ds
31FB:0373 B8 1D 5E        	mov	ax,5E1Dh
31FB:0376 50              	push	ax
31FB:0377 16              	push	ss
31FB:0378 8D 46 F0        	lea	ax,[bp-10h]
31FB:037B 50              	push	ax
31FB:037C 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0381 83 C4 08        	add	sp,8h
31FB:0384 E9 B3 00        	jmp	043Ah

l31FB_0387:
31FB:0387 80 7E EF 42     	cmp	byte ptr [bp-11h],42h
31FB:038B 7C 06           	jl	0393h

l31FB_038D:
31FB:038D 80 7E EF 45     	cmp	byte ptr [bp-11h],45h
31FB:0391 7E 06           	jle	0399h

l31FB_0393:
31FB:0393 80 7E EF 54     	cmp	byte ptr [bp-11h],54h
31FB:0397 75 15           	jnz	03AEh

l31FB_0399:
31FB:0399 1E              	push	ds
31FB:039A B8 26 5E        	mov	ax,5E26h
31FB:039D 50              	push	ax
31FB:039E 16              	push	ss
31FB:039F 8D 46 F0        	lea	ax,[bp-10h]
31FB:03A2 50              	push	ax
31FB:03A3 9A 00 00 83 39  	call	far 3983h:0000h
31FB:03A8 83 C4 08        	add	sp,8h
31FB:03AB E9 8C 00        	jmp	043Ah

l31FB_03AE:
31FB:03AE 80 7E EF 46     	cmp	byte ptr [bp-11h],46h
31FB:03B2 7C 1A           	jl	03CEh

l31FB_03B4:
31FB:03B4 80 7E EF 4E     	cmp	byte ptr [bp-11h],4Eh
31FB:03B8 7F 14           	jg	03CEh

l31FB_03BA:
31FB:03BA 1E              	push	ds
31FB:03BB B8 32 5E        	mov	ax,5E32h
31FB:03BE 50              	push	ax
31FB:03BF 16              	push	ss
31FB:03C0 8D 46 F0        	lea	ax,[bp-10h]
31FB:03C3 50              	push	ax
31FB:03C4 9A 00 00 83 39  	call	far 3983h:0000h
31FB:03C9 83 C4 08        	add	sp,8h
31FB:03CC EB 6C           	jmp	043Ah

l31FB_03CE:
31FB:03CE 80 7E EF 4F     	cmp	byte ptr [bp-11h],4Fh
31FB:03D2 75 14           	jnz	03E8h

l31FB_03D4:
31FB:03D4 1E              	push	ds
31FB:03D5 B8 3E 5E        	mov	ax,5E3Eh
31FB:03D8 50              	push	ax
31FB:03D9 16              	push	ss
31FB:03DA 8D 46 F0        	lea	ax,[bp-10h]
31FB:03DD 50              	push	ax
31FB:03DE 9A 00 00 83 39  	call	far 3983h:0000h
31FB:03E3 83 C4 08        	add	sp,8h
31FB:03E6 EB 52           	jmp	043Ah

l31FB_03E8:
31FB:03E8 80 7E EF 50     	cmp	byte ptr [bp-11h],50h
31FB:03EC 7C 1A           	jl	0408h

l31FB_03EE:
31FB:03EE 80 7E EF 52     	cmp	byte ptr [bp-11h],52h
31FB:03F2 7F 14           	jg	0408h

l31FB_03F4:
31FB:03F4 1E              	push	ds
31FB:03F5 B8 4A 5E        	mov	ax,5E4Ah
31FB:03F8 50              	push	ax
31FB:03F9 16              	push	ss
31FB:03FA 8D 46 F0        	lea	ax,[bp-10h]
31FB:03FD 50              	push	ax
31FB:03FE 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0403 83 C4 08        	add	sp,8h
31FB:0406 EB 32           	jmp	043Ah

l31FB_0408:
31FB:0408 80 7E EF 53     	cmp	byte ptr [bp-11h],53h
31FB:040C 75 14           	jnz	0422h

l31FB_040E:
31FB:040E 1E              	push	ds
31FB:040F B8 56 5E        	mov	ax,5E56h
31FB:0412 50              	push	ax
31FB:0413 16              	push	ss
31FB:0414 8D 46 F0        	lea	ax,[bp-10h]
31FB:0417 50              	push	ax
31FB:0418 9A 00 00 83 39  	call	far 3983h:0000h
31FB:041D 83 C4 08        	add	sp,8h
31FB:0420 EB 18           	jmp	043Ah

l31FB_0422:
31FB:0422 80 7E EF 55     	cmp	byte ptr [bp-11h],55h
31FB:0426 75 12           	jnz	043Ah

l31FB_0428:
31FB:0428 1E              	push	ds
31FB:0429 B8 62 5E        	mov	ax,5E62h
31FB:042C 50              	push	ax
31FB:042D 16              	push	ss
31FB:042E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0431 50              	push	ax
31FB:0432 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0437 83 C4 08        	add	sp,8h

l31FB_043A:
31FB:043A 33 C0           	xor	ax,ax
31FB:043C 89 46 EA        	mov	[bp-16h],ax
31FB:043F 89 46 EC        	mov	[bp-14h],ax
31FB:0442 33 F6           	xor	si,si
31FB:0444 EB 44           	jmp	048Ah

l31FB_0446:
31FB:0446 36 FF 72 F0     	push	word ptr ss:[bp+si-10h]
31FB:044A 0E              	push	cs
31FB:044B E8 08 FE        	call	0256h
31FB:044E 59              	pop	cx
31FB:044F 8B F8           	mov	di,ax
31FB:0451 0B FF           	or	di,di
31FB:0453 7C 34           	jl	0489h

l31FB_0455:
31FB:0455 8B C7           	mov	ax,di
31FB:0457 BA 0B 00        	mov	dx,0Bh
31FB:045A F7 E2           	mul	dx
31FB:045C 8B D8           	mov	bx,ax
31FB:045E 81 C3 FC 5C     	add	bx,5CFCh
31FB:0462 1E              	push	ds
31FB:0463 07              	pop	es
31FB:0464 26 8B 47 07     	mov	ax,es:[bx+7h]
31FB:0468 89 46 EA        	mov	[bp-16h],ax
31FB:046B 8B 46 EC        	mov	ax,[bp-14h]
31FB:046E 50              	push	ax
31FB:046F 8B C7           	mov	ax,di
31FB:0471 BA 0B 00        	mov	dx,0Bh
31FB:0474 F7 E2           	mul	dx
31FB:0476 8B D8           	mov	bx,ax
31FB:0478 81 C3 FC 5C     	add	bx,5CFCh
31FB:047C 1E              	push	ds
31FB:047D 07              	pop	es
31FB:047E 58              	pop	ax
31FB:047F 26 89 47 09     	mov	es:[bx+9h],ax
31FB:0483 8B 46 EA        	mov	ax,[bp-16h]
31FB:0486 01 46 EC        	add	[bp-14h],ax

l31FB_0489:
31FB:0489 46              	inc	si

l31FB_048A:
31FB:048A 83 FE 0F        	cmp	si,0Fh
31FB:048D 7D 07           	jge	0496h

l31FB_048F:
31FB:048F 36 80 7A F0 00  	cmp	byte ptr ss:[bp+si-10h],0h
31FB:0494 75 B0           	jnz	0446h

l31FB_0496:
31FB:0496 8B 46 EC        	mov	ax,[bp-14h]
31FB:0499 33 D2           	xor	dx,dx
31FB:049B 52              	push	dx
31FB:049C 50              	push	ax
31FB:049D 9A B5 00 56 0D  	call	far 0D56h:00B5h
31FB:04A2 59              	pop	cx
31FB:04A3 59              	pop	cx
31FB:04A4 89 16 2F B6     	mov	[0B62Fh],dx
31FB:04A8 A3 2D B6        	mov	[0B62Dh],ax
31FB:04AB 33 F6           	xor	si,si
31FB:04AD E9 88 00        	jmp	0538h

l31FB_04B0:
31FB:04B0 36 FF 72 F0     	push	word ptr ss:[bp+si-10h]
31FB:04B4 0E              	push	cs
31FB:04B5 E8 9E FD        	call	0256h
31FB:04B8 59              	pop	cx
31FB:04B9 8B F8           	mov	di,ax
31FB:04BB 0B FF           	or	di,di
31FB:04BD 7C 78           	jl	0537h

l31FB_04BF:
31FB:04BF 8B C7           	mov	ax,di
31FB:04C1 BA 0B 00        	mov	dx,0Bh
31FB:04C4 F7 E2           	mul	dx
31FB:04C6 8B D8           	mov	bx,ax
31FB:04C8 81 C3 FC 5C     	add	bx,5CFCh
31FB:04CC 1E              	push	ds
31FB:04CD 07              	pop	es
31FB:04CE 26 FF 77 07     	push	word ptr es:[bx+7h]
31FB:04D2 8B C7           	mov	ax,di
31FB:04D4 BA 0B 00        	mov	dx,0Bh
31FB:04D7 F7 E2           	mul	dx
31FB:04D9 8B D8           	mov	bx,ax
31FB:04DB 81 C3 FC 5C     	add	bx,5CFCh
31FB:04DF 1E              	push	ds
31FB:04E0 07              	pop	es
31FB:04E1 26 8B 47 09     	mov	ax,es:[bx+9h]
31FB:04E5 8B 0E 2F B6     	mov	cx,[0B62Fh]
31FB:04E9 8B 1E 2D B6     	mov	bx,[0B62Dh]
31FB:04ED 03 D8           	add	bx,ax
31FB:04EF 51              	push	cx
31FB:04F0 53              	push	bx
31FB:04F1 8B C7           	mov	ax,di
31FB:04F3 BA 0B 00        	mov	dx,0Bh
31FB:04F6 F7 E2           	mul	dx
31FB:04F8 8B D8           	mov	bx,ax
31FB:04FA 81 C3 FC 5C     	add	bx,5CFCh
31FB:04FE 1E              	push	ds
31FB:04FF 07              	pop	es
31FB:0500 26 FF 77 05     	push	word ptr es:[bx+5h]
31FB:0504 26 FF 77 03     	push	word ptr es:[bx+3h]
31FB:0508 8B C7           	mov	ax,di
31FB:050A BA 0B 00        	mov	dx,0Bh
31FB:050D F7 E2           	mul	dx
31FB:050F 8B D8           	mov	bx,ax
31FB:0511 81 C3 FC 5C     	add	bx,5CFCh
31FB:0515 1E              	push	ds
31FB:0516 07              	pop	es
31FB:0517 26 8B 47 01     	mov	ax,es:[bx+1h]
31FB:051B BA 12 00        	mov	dx,12h
31FB:051E F7 E2           	mul	dx
31FB:0520 8B D8           	mov	bx,ax
31FB:0522 81 C3 B0 10     	add	bx,10B0h
31FB:0526 1E              	push	ds
31FB:0527 07              	pop	es
31FB:0528 26 FF 77 02     	push	word ptr es:[bx+2h]
31FB:052C 26 FF 37        	push	word ptr es:[bx]
31FB:052F 9A 44 00 E7 21  	call	far 21E7h:0044h
31FB:0534 83 C4 0E        	add	sp,0Eh

l31FB_0537:
31FB:0537 46              	inc	si

l31FB_0538:
31FB:0538 83 FE 0F        	cmp	si,0Fh
31FB:053B 7D 0A           	jge	0547h

l31FB_053D:
31FB:053D 36 80 7A F0 00  	cmp	byte ptr ss:[bp+si-10h],0h
31FB:0542 74 03           	jz	0547h

l31FB_0544:
31FB:0544 E9 69 FF        	jmp	04B0h

l31FB_0547:
31FB:0547 80 3E 65 86 00  	cmp	byte ptr [8665h],0h
31FB:054C 75 13           	jnz	0561h

l31FB_054E:
31FB:054E FF 76 EC        	push	word ptr [bp-14h]
31FB:0551 FF 36 2F B6     	push	word ptr [0B62Fh]
31FB:0555 FF 36 2D B6     	push	word ptr [0B62Dh]
31FB:0559 9A 46 00 17 37  	call	far 3717h:0046h
31FB:055E 83 C4 06        	add	sp,6h

l31FB_0561:
31FB:0561 5F              	pop	di
31FB:0562 5E              	pop	si
31FB:0563 8B E5           	mov	sp,bp
31FB:0565 5D              	pop	bp
31FB:0566 CB              	retf

;; DispatchWeaponEffect_0567: 31FB:0567
;;   Called from:
;;     2007:089C (in QueueTacticalImpactVisual_0846)
;;     2007:08AB (in QueueTacticalImpactVisual_0846)
;;     2007:08BA (in QueueTacticalImpactVisual_0846)
;;     2007:1115 (in DrawSelectedUnitStatusPanel_0E19)
;;     2D1B:1D43 (in ResolveWeaponAttack_1854)
;;     2D1B:2549 (in DestroyScenarioUnit_2453)
DispatchWeaponEffect_0567 proc
31FB:0567 55              	push	bp
31FB:0568 8B EC           	mov	bp,sp
31FB:056A 56              	push	si
31FB:056B 8B 76 06        	mov	si,[bp+6h]
31FB:056E 80 3E 65 86 00  	cmp	byte ptr [8665h],0h
31FB:0573 74 05           	jz	057Ah

l31FB_0575:
31FB:0575 83 FE 03        	cmp	si,3h
31FB:0578 75 09           	jnz	0583h

l31FB_057A:
31FB:057A 56              	push	si
31FB:057B 9A 0C 00 AF 30  	call	far 30AFh:000Ch
31FB:0580 59              	pop	cx
31FB:0581 EB 07           	jmp	058Ah

l31FB_0583:
31FB:0583 56              	push	si
31FB:0584 9A 8D 05 FB 31  	call	far 31FBh:058Dh
31FB:0589 59              	pop	cx

l31FB_058A:
31FB:058A 5E              	pop	si
31FB:058B 5D              	pop	bp
31FB:058C CB              	retf

;; PlayDigitalWeaponEffect_058D: 31FB:058D
;;   Called from:
;;     31FB:0584 (in DispatchWeaponEffect_0567)
PlayDigitalWeaponEffect_058D proc
31FB:058D 55              	push	bp
31FB:058E 8B EC           	mov	bp,sp
31FB:0590 56              	push	si
31FB:0591 8B 76 06        	mov	si,[bp+6h]
31FB:0594 83 3E 0A 80 00  	cmp	word ptr [800Ah],0h
31FB:0599 75 03           	jnz	059Eh

l31FB_059B:
31FB:059B E9 48 01        	jmp	06E6h

l31FB_059E:
31FB:059E C6 06 F0 A7 01  	mov	byte ptr [0A7F0h],1h
31FB:05A3 80 3E 15 80 00  	cmp	byte ptr [8015h],0h
31FB:05A8 75 37           	jnz	05E1h

l31FB_05AA:
31FB:05AA C6 06 15 80 01  	mov	byte ptr [8015h],1h
31FB:05AF 9A 82 03 B2 30  	call	far 30B2h:0382h
31FB:05B4 FF 36 26 B6     	push	word ptr [0B626h]
31FB:05B8 9A 3B 06 5F 37  	call	far 375Fh:063Bh
31FB:05BD 59              	pop	cx
31FB:05BE FF 36 26 B6     	push	word ptr [0B626h]
31FB:05C2 A0 65 86        	mov	al,[8665h]
31FB:05C5 98              	cbw
31FB:05C6 8B D8           	mov	bx,ax
31FB:05C8 D1 E3           	shl	bx,1h
31FB:05CA FF B7 3E 59     	push	word ptr [bx+593Eh]
31FB:05CE 9A C2 02 5F 37  	call	far 375Fh:02C2h
31FB:05D3 59              	pop	cx
31FB:05D4 59              	pop	cx
31FB:05D5 B8 00 01        	mov	ax,100h
31FB:05D8 50              	push	ax
31FB:05D9 9A C6 09 5F 37  	call	far 375Fh:09C6h
31FB:05DE 59              	pop	cx
31FB:05DF EB 0F           	jmp	05F0h

l31FB_05E1:
31FB:05E1 FF 36 10 B6     	push	word ptr [0B610h]
31FB:05E5 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:05E9 9A B9 08 5F 37  	call	far 375Fh:08B9h
31FB:05EE 59              	pop	cx
31FB:05EF 59              	pop	cx

l31FB_05F0:
31FB:05F0 C6 06 F0 A7 00  	mov	byte ptr [0A7F0h],0h
31FB:05F5 83 FE 06        	cmp	si,6h
31FB:05F8 75 07           	jnz	0601h

l31FB_05FA:
31FB:05FA C6 06 28 B6 03  	mov	byte ptr [0B628h],3h
31FB:05FF EB 11           	jmp	0612h

l31FB_0601:
31FB:0601 83 FE 0F        	cmp	si,0Fh
31FB:0604 75 07           	jnz	060Dh

l31FB_0606:
31FB:0606 C6 06 28 B6 06  	mov	byte ptr [0B628h],6h
31FB:060B EB 05           	jmp	0612h

l31FB_060D:
31FB:060D C6 06 28 B6 00  	mov	byte ptr [0B628h],0h

l31FB_0612:
31FB:0612 8C 1E 10 B6     	mov	[0B610h],ds
31FB:0616 C7 06 0E B6 50 59 	mov	word ptr [0B60Eh],5950h
31FB:061C B8 33 66        	mov	ax,6633h
31FB:061F 50              	push	ax
31FB:0620 B8 40 1F        	mov	ax,1F40h
31FB:0623 50              	push	ax
31FB:0624 8B C6           	mov	ax,si
31FB:0626 BA 0A 00        	mov	dx,0Ah
31FB:0629 F7 E2           	mul	dx
31FB:062B 8B D8           	mov	bx,ax
31FB:062D 81 C3 5C 5C     	add	bx,5C5Ch
31FB:0631 1E              	push	ds
31FB:0632 07              	pop	es
31FB:0633 26 FF 77 06     	push	word ptr es:[bx+6h]
31FB:0637 8B C6           	mov	ax,si
31FB:0639 BA 0A 00        	mov	dx,0Ah
31FB:063C F7 E2           	mul	dx
31FB:063E 8B D8           	mov	bx,ax
31FB:0640 81 C3 5C 5C     	add	bx,5C5Ch
31FB:0644 1E              	push	ds
31FB:0645 07              	pop	es
31FB:0646 26 8B 47 04     	mov	ax,es:[bx+4h]
31FB:064A 8B 0E 2B B6     	mov	cx,[0B62Bh]
31FB:064E 8B 1E 29 B6     	mov	bx,[0B629h]
31FB:0652 03 D8           	add	bx,ax
31FB:0654 51              	push	cx
31FB:0655 53              	push	bx
31FB:0656 FF 36 10 B6     	push	word ptr [0B610h]
31FB:065A FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:065E 9A 35 07 5F 37  	call	far 375Fh:0735h
31FB:0663 83 C4 0E        	add	sp,0Eh
31FB:0666 8B C6           	mov	ax,si
31FB:0668 BA 0A 00        	mov	dx,0Ah
31FB:066B F7 E2           	mul	dx
31FB:066D 8B D8           	mov	bx,ax
31FB:066F 81 C3 5C 5C     	add	bx,5C5Ch
31FB:0673 1E              	push	ds
31FB:0674 07              	pop	es
31FB:0675 26 FF 77 02     	push	word ptr es:[bx+2h]
31FB:0679 FF 36 10 B6     	push	word ptr [0B610h]
31FB:067D FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:0681 9A 8E 07 5F 37  	call	far 375Fh:078Eh
31FB:0686 83 C4 06        	add	sp,6h
31FB:0689 FF 36 10 B6     	push	word ptr [0B610h]
31FB:068D FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:0691 B8 FB 31        	mov	ax,31FBh
31FB:0694 50              	push	ax
31FB:0695 B8 E9 06        	mov	ax,6E9h
31FB:0698 50              	push	ax
31FB:0699 FF 36 10 B6     	push	word ptr [0B610h]
31FB:069D FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:06A1 9A 14 08 5F 37  	call	far 375Fh:0814h
31FB:06A6 83 C4 0C        	add	sp,0Ch
31FB:06A9 FF 36 10 B6     	push	word ptr [0B610h]
31FB:06AD FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:06B1 9A 17 09 5F 37  	call	far 375Fh:0917h
31FB:06B6 59              	pop	cx
31FB:06B7 59              	pop	cx
31FB:06B8 1E              	push	ds
31FB:06B9 B8 14 B6        	mov	ax,0B614h
31FB:06BC 50              	push	ax
31FB:06BD FF 36 10 B6     	push	word ptr [0B610h]
31FB:06C1 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:06C5 9A 52 08 5F 37  	call	far 375Fh:0852h
31FB:06CA 83 C4 08        	add	sp,8h
31FB:06CD 1E              	push	ds
31FB:06CE B8 14 B6        	mov	ax,0B614h
31FB:06D1 50              	push	ax
31FB:06D2 A0 65 86        	mov	al,[8665h]
31FB:06D5 98              	cbw
31FB:06D6 8B D8           	mov	bx,ax
31FB:06D8 D1 E3           	shl	bx,1h
31FB:06DA FF B7 3E 59     	push	word ptr [bx+593Eh]
31FB:06DE 9A FA 06 5F 37  	call	far 375Fh:06FAh
31FB:06E3 83 C4 06        	add	sp,6h

l31FB_06E6:
31FB:06E6 5E              	pop	si
31FB:06E7 5D              	pop	bp
31FB:06E8 CB              	retf

;; HandleDigitalWeaponEffectCompletion_06E9: 31FB:06E9
HandleDigitalWeaponEffectCompletion_06E9 proc
31FB:06E9 55              	push	bp
31FB:06EA 8B EC           	mov	bp,sp
31FB:06EC 80 3E F0 A7 00  	cmp	byte ptr [0A7F0h],0h
31FB:06F1 75 4D           	jnz	0740h

l31FB_06F3:
31FB:06F3 80 3E 28 B6 00  	cmp	byte ptr [0B628h],0h
31FB:06F8 74 13           	jz	070Dh

l31FB_06FA:
31FB:06FA FE 0E 28 B6     	dec	byte ptr [0B628h]
31FB:06FE FF 76 08        	push	word ptr [bp+8h]
31FB:0701 FF 76 06        	push	word ptr [bp+6h]
31FB:0704 9A 17 09 5F 37  	call	far 375Fh:0917h
31FB:0709 8B E5           	mov	sp,bp
31FB:070B EB 33           	jmp	0740h

l31FB_070D:
31FB:070D C6 06 F0 A7 01  	mov	byte ptr [0A7F0h],1h
31FB:0712 FF 76 08        	push	word ptr [bp+8h]
31FB:0715 FF 76 06        	push	word ptr [bp+6h]
31FB:0718 9A B9 08 5F 37  	call	far 375Fh:08B9h
31FB:071D 8B E5           	mov	sp,bp
31FB:071F A0 65 86        	mov	al,[8665h]
31FB:0722 98              	cbw
31FB:0723 8B D8           	mov	bx,ax
31FB:0725 D1 E3           	shl	bx,1h
31FB:0727 FF B7 3E 59     	push	word ptr [bx+593Eh]
31FB:072B 9A D9 02 5F 37  	call	far 375Fh:02D9h
31FB:0730 59              	pop	cx
31FB:0731 9A A9 06 5F 37  	call	far 375Fh:06A9h
31FB:0736 9A D9 02 B2 30  	call	far 30B2h:02D9h
31FB:073B C6 06 15 80 00  	mov	byte ptr [8015h],0h

l31FB_0740:
31FB:0740 5D              	pop	bp
31FB:0741 CB              	retf

;; PlayScenarioDigitalSoundSequence_0742: 31FB:0742
;;   Called from:
;;     0D73:30BB (in RunTitleAndMainMenu_309C)
;;     0D73:30EB (in RunTitleAndMainMenu_309C)
;;     2007:113F (in DrawSelectedUnitStatusPanel_0E19)
PlayScenarioDigitalSoundSequence_0742 proc
31FB:0742 55              	push	bp
31FB:0743 8B EC           	mov	bp,sp
31FB:0745 83 EC 18        	sub	sp,18h
31FB:0748 56              	push	si
31FB:0749 57              	push	di
31FB:074A 8B 36 0E 80     	mov	si,[800Eh]
31FB:074E 8A 46 06        	mov	al,[bp+6h]
31FB:0751 88 46 EF        	mov	[bp-11h],al
31FB:0754 C6 46 F0 00     	mov	byte ptr [bp-10h],0h
31FB:0758 80 7E EF FF     	cmp	byte ptr [bp-11h],0FFh
31FB:075C 75 15           	jnz	0773h

l31FB_075E:
31FB:075E 1E              	push	ds
31FB:075F B8 6E 5E        	mov	ax,5E6Eh
31FB:0762 50              	push	ax
31FB:0763 16              	push	ss
31FB:0764 8D 46 F0        	lea	ax,[bp-10h]
31FB:0767 50              	push	ax
31FB:0768 9A 00 00 83 39  	call	far 3983h:0000h
31FB:076D 83 C4 08        	add	sp,8h
31FB:0770 E9 60 09        	jmp	10D3h

l31FB_0773:
31FB:0773 80 7E EF FE     	cmp	byte ptr [bp-11h],0FEh
31FB:0777 75 15           	jnz	078Eh

l31FB_0779:
31FB:0779 1E              	push	ds
31FB:077A B8 70 5E        	mov	ax,5E70h
31FB:077D 50              	push	ax
31FB:077E 16              	push	ss
31FB:077F 8D 46 F0        	lea	ax,[bp-10h]
31FB:0782 50              	push	ax
31FB:0783 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0788 83 C4 08        	add	sp,8h
31FB:078B E9 45 09        	jmp	10D3h

l31FB_078E:
31FB:078E 80 7E EF 31     	cmp	byte ptr [bp-11h],31h
31FB:0792 7D 03           	jge	0797h

l31FB_0794:
31FB:0794 E9 96 00        	jmp	082Dh

l31FB_0797:
31FB:0797 80 7E EF 35     	cmp	byte ptr [bp-11h],35h
31FB:079B 7E 03           	jle	07A0h

l31FB_079D:
31FB:079D E9 8D 00        	jmp	082Dh

l31FB_07A0:
31FB:07A0 83 FE 02        	cmp	si,2h
31FB:07A3 75 14           	jnz	07B9h

l31FB_07A5:
31FB:07A5 1E              	push	ds
31FB:07A6 B8 72 5E        	mov	ax,5E72h
31FB:07A9 50              	push	ax
31FB:07AA 16              	push	ss
31FB:07AB 8D 46 F0        	lea	ax,[bp-10h]
31FB:07AE 50              	push	ax
31FB:07AF 9A 00 00 83 39  	call	far 3983h:0000h
31FB:07B4 83 C4 08        	add	sp,8h
31FB:07B7 EB 12           	jmp	07CBh

l31FB_07B9:
31FB:07B9 1E              	push	ds
31FB:07BA B8 75 5E        	mov	ax,5E75h
31FB:07BD 50              	push	ax
31FB:07BE 16              	push	ss
31FB:07BF 8D 46 F0        	lea	ax,[bp-10h]
31FB:07C2 50              	push	ax
31FB:07C3 9A 00 00 83 39  	call	far 3983h:0000h
31FB:07C8 83 C4 08        	add	sp,8h

l31FB_07CB:
31FB:07CB 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:07D0 75 14           	jnz	07E6h

l31FB_07D2:
31FB:07D2 1E              	push	ds
31FB:07D3 B8 77 5E        	mov	ax,5E77h
31FB:07D6 50              	push	ax
31FB:07D7 16              	push	ss
31FB:07D8 8D 46 F0        	lea	ax,[bp-10h]
31FB:07DB 50              	push	ax
31FB:07DC 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:07E1 83 C4 08        	add	sp,8h
31FB:07E4 EB 12           	jmp	07F8h

l31FB_07E6:
31FB:07E6 1E              	push	ds
31FB:07E7 B8 79 5E        	mov	ax,5E79h
31FB:07EA 50              	push	ax
31FB:07EB 16              	push	ss
31FB:07EC 8D 46 F0        	lea	ax,[bp-10h]
31FB:07EF 50              	push	ax
31FB:07F0 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:07F5 83 C4 08        	add	sp,8h

l31FB_07F8:
31FB:07F8 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:07FD 74 14           	jz	0813h

l31FB_07FF:
31FB:07FF 1E              	push	ds
31FB:0800 B8 7B 5E        	mov	ax,5E7Bh
31FB:0803 50              	push	ax
31FB:0804 16              	push	ss
31FB:0805 8D 46 F0        	lea	ax,[bp-10h]
31FB:0808 50              	push	ax
31FB:0809 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:080E 83 C4 08        	add	sp,8h
31FB:0811 EB 17           	jmp	082Ah

l31FB_0813:
31FB:0813 83 FE 02        	cmp	si,2h
31FB:0816 75 12           	jnz	082Ah

l31FB_0818:
31FB:0818 1E              	push	ds
31FB:0819 B8 7D 5E        	mov	ax,5E7Dh
31FB:081C 50              	push	ax
31FB:081D 16              	push	ss
31FB:081E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0821 50              	push	ax
31FB:0822 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0827 83 C4 08        	add	sp,8h

l31FB_082A:
31FB:082A E9 A6 08        	jmp	10D3h

l31FB_082D:
31FB:082D 80 7E EF 36     	cmp	byte ptr [bp-11h],36h
31FB:0831 74 03           	jz	0836h

l31FB_0833:
31FB:0833 E9 A8 00        	jmp	08DEh

l31FB_0836:
31FB:0836 83 FE 02        	cmp	si,2h
31FB:0839 75 14           	jnz	084Fh

l31FB_083B:
31FB:083B 1E              	push	ds
31FB:083C B8 7F 5E        	mov	ax,5E7Fh
31FB:083F 50              	push	ax
31FB:0840 16              	push	ss
31FB:0841 8D 46 F0        	lea	ax,[bp-10h]
31FB:0844 50              	push	ax
31FB:0845 9A 00 00 83 39  	call	far 3983h:0000h
31FB:084A 83 C4 08        	add	sp,8h
31FB:084D EB 12           	jmp	0861h

l31FB_084F:
31FB:084F 1E              	push	ds
31FB:0850 B8 83 5E        	mov	ax,5E83h
31FB:0853 50              	push	ax
31FB:0854 16              	push	ss
31FB:0855 8D 46 F0        	lea	ax,[bp-10h]
31FB:0858 50              	push	ax
31FB:0859 9A 00 00 83 39  	call	far 3983h:0000h
31FB:085E 83 C4 08        	add	sp,8h

l31FB_0861:
31FB:0861 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0866 75 14           	jnz	087Ch

l31FB_0868:
31FB:0868 1E              	push	ds
31FB:0869 B8 85 5E        	mov	ax,5E85h
31FB:086C 50              	push	ax
31FB:086D 16              	push	ss
31FB:086E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0871 50              	push	ax
31FB:0872 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0877 83 C4 08        	add	sp,8h
31FB:087A EB 2D           	jmp	08A9h

l31FB_087C:
31FB:087C 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:0881 75 14           	jnz	0897h

l31FB_0883:
31FB:0883 1E              	push	ds
31FB:0884 B8 88 5E        	mov	ax,5E88h
31FB:0887 50              	push	ax
31FB:0888 16              	push	ss
31FB:0889 8D 46 F0        	lea	ax,[bp-10h]
31FB:088C 50              	push	ax
31FB:088D 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0892 83 C4 08        	add	sp,8h
31FB:0895 EB 12           	jmp	08A9h

l31FB_0897:
31FB:0897 1E              	push	ds
31FB:0898 B8 8B 5E        	mov	ax,5E8Bh
31FB:089B 50              	push	ax
31FB:089C 16              	push	ss
31FB:089D 8D 46 F0        	lea	ax,[bp-10h]
31FB:08A0 50              	push	ax
31FB:08A1 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:08A6 83 C4 08        	add	sp,8h

l31FB_08A9:
31FB:08A9 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:08AE 74 14           	jz	08C4h

l31FB_08B0:
31FB:08B0 1E              	push	ds
31FB:08B1 B8 8E 5E        	mov	ax,5E8Eh
31FB:08B4 50              	push	ax
31FB:08B5 16              	push	ss
31FB:08B6 8D 46 F0        	lea	ax,[bp-10h]
31FB:08B9 50              	push	ax
31FB:08BA 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:08BF 83 C4 08        	add	sp,8h
31FB:08C2 EB 17           	jmp	08DBh

l31FB_08C4:
31FB:08C4 83 FE 02        	cmp	si,2h
31FB:08C7 75 12           	jnz	08DBh

l31FB_08C9:
31FB:08C9 1E              	push	ds
31FB:08CA B8 90 5E        	mov	ax,5E90h
31FB:08CD 50              	push	ax
31FB:08CE 16              	push	ss
31FB:08CF 8D 46 F0        	lea	ax,[bp-10h]
31FB:08D2 50              	push	ax
31FB:08D3 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:08D8 83 C4 08        	add	sp,8h

l31FB_08DB:
31FB:08DB E9 F5 07        	jmp	10D3h

l31FB_08DE:
31FB:08DE 80 7E EF 37     	cmp	byte ptr [bp-11h],37h
31FB:08E2 75 72           	jnz	0956h

l31FB_08E4:
31FB:08E4 83 FE 02        	cmp	si,2h
31FB:08E7 75 14           	jnz	08FDh

l31FB_08E9:
31FB:08E9 1E              	push	ds
31FB:08EA B8 92 5E        	mov	ax,5E92h
31FB:08ED 50              	push	ax
31FB:08EE 16              	push	ss
31FB:08EF 8D 46 F0        	lea	ax,[bp-10h]
31FB:08F2 50              	push	ax
31FB:08F3 9A 00 00 83 39  	call	far 3983h:0000h
31FB:08F8 83 C4 08        	add	sp,8h
31FB:08FB EB 12           	jmp	090Fh

l31FB_08FD:
31FB:08FD 1E              	push	ds
31FB:08FE B8 96 5E        	mov	ax,5E96h
31FB:0901 50              	push	ax
31FB:0902 16              	push	ss
31FB:0903 8D 46 F0        	lea	ax,[bp-10h]
31FB:0906 50              	push	ax
31FB:0907 9A 00 00 83 39  	call	far 3983h:0000h
31FB:090C 83 C4 08        	add	sp,8h

l31FB_090F:
31FB:090F 1E              	push	ds
31FB:0910 B8 98 5E        	mov	ax,5E98h
31FB:0913 50              	push	ax
31FB:0914 16              	push	ss
31FB:0915 8D 46 F0        	lea	ax,[bp-10h]
31FB:0918 50              	push	ax
31FB:0919 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:091E 83 C4 08        	add	sp,8h
31FB:0921 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0926 74 14           	jz	093Ch

l31FB_0928:
31FB:0928 1E              	push	ds
31FB:0929 B8 9B 5E        	mov	ax,5E9Bh
31FB:092C 50              	push	ax
31FB:092D 16              	push	ss
31FB:092E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0931 50              	push	ax
31FB:0932 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0937 83 C4 08        	add	sp,8h
31FB:093A EB 17           	jmp	0953h

l31FB_093C:
31FB:093C 83 FE 02        	cmp	si,2h
31FB:093F 75 12           	jnz	0953h

l31FB_0941:
31FB:0941 1E              	push	ds
31FB:0942 B8 9D 5E        	mov	ax,5E9Dh
31FB:0945 50              	push	ax
31FB:0946 16              	push	ss
31FB:0947 8D 46 F0        	lea	ax,[bp-10h]
31FB:094A 50              	push	ax
31FB:094B 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0950 83 C4 08        	add	sp,8h

l31FB_0953:
31FB:0953 E9 7D 07        	jmp	10D3h

l31FB_0956:
31FB:0956 80 7E EF 38     	cmp	byte ptr [bp-11h],38h
31FB:095A 74 03           	jz	095Fh

l31FB_095C:
31FB:095C E9 A8 00        	jmp	0A07h

l31FB_095F:
31FB:095F 83 FE 02        	cmp	si,2h
31FB:0962 75 14           	jnz	0978h

l31FB_0964:
31FB:0964 1E              	push	ds
31FB:0965 B8 9F 5E        	mov	ax,5E9Fh
31FB:0968 50              	push	ax
31FB:0969 16              	push	ss
31FB:096A 8D 46 F0        	lea	ax,[bp-10h]
31FB:096D 50              	push	ax
31FB:096E 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0973 83 C4 08        	add	sp,8h
31FB:0976 EB 12           	jmp	098Ah

l31FB_0978:
31FB:0978 1E              	push	ds
31FB:0979 B8 A3 5E        	mov	ax,5EA3h
31FB:097C 50              	push	ax
31FB:097D 16              	push	ss
31FB:097E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0981 50              	push	ax
31FB:0982 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0987 83 C4 08        	add	sp,8h

l31FB_098A:
31FB:098A 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:098F 75 14           	jnz	09A5h

l31FB_0991:
31FB:0991 1E              	push	ds
31FB:0992 B8 A5 5E        	mov	ax,5EA5h
31FB:0995 50              	push	ax
31FB:0996 16              	push	ss
31FB:0997 8D 46 F0        	lea	ax,[bp-10h]
31FB:099A 50              	push	ax
31FB:099B 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:09A0 83 C4 08        	add	sp,8h
31FB:09A3 EB 2D           	jmp	09D2h

l31FB_09A5:
31FB:09A5 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:09AA 75 14           	jnz	09C0h

l31FB_09AC:
31FB:09AC 1E              	push	ds
31FB:09AD B8 A8 5E        	mov	ax,5EA8h
31FB:09B0 50              	push	ax
31FB:09B1 16              	push	ss
31FB:09B2 8D 46 F0        	lea	ax,[bp-10h]
31FB:09B5 50              	push	ax
31FB:09B6 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:09BB 83 C4 08        	add	sp,8h
31FB:09BE EB 12           	jmp	09D2h

l31FB_09C0:
31FB:09C0 1E              	push	ds
31FB:09C1 B8 AB 5E        	mov	ax,5EABh
31FB:09C4 50              	push	ax
31FB:09C5 16              	push	ss
31FB:09C6 8D 46 F0        	lea	ax,[bp-10h]
31FB:09C9 50              	push	ax
31FB:09CA 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:09CF 83 C4 08        	add	sp,8h

l31FB_09D2:
31FB:09D2 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:09D7 74 14           	jz	09EDh

l31FB_09D9:
31FB:09D9 1E              	push	ds
31FB:09DA B8 AE 5E        	mov	ax,5EAEh
31FB:09DD 50              	push	ax
31FB:09DE 16              	push	ss
31FB:09DF 8D 46 F0        	lea	ax,[bp-10h]
31FB:09E2 50              	push	ax
31FB:09E3 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:09E8 83 C4 08        	add	sp,8h
31FB:09EB EB 17           	jmp	0A04h

l31FB_09ED:
31FB:09ED 83 FE 02        	cmp	si,2h
31FB:09F0 75 12           	jnz	0A04h

l31FB_09F2:
31FB:09F2 1E              	push	ds
31FB:09F3 B8 B0 5E        	mov	ax,5EB0h
31FB:09F6 50              	push	ax
31FB:09F7 16              	push	ss
31FB:09F8 8D 46 F0        	lea	ax,[bp-10h]
31FB:09FB 50              	push	ax
31FB:09FC 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0A01 83 C4 08        	add	sp,8h

l31FB_0A04:
31FB:0A04 E9 CC 06        	jmp	10D3h

l31FB_0A07:
31FB:0A07 80 7E EF 39     	cmp	byte ptr [bp-11h],39h
31FB:0A0B 74 03           	jz	0A10h

l31FB_0A0D:
31FB:0A0D E9 8D 00        	jmp	0A9Dh

l31FB_0A10:
31FB:0A10 83 FE 02        	cmp	si,2h
31FB:0A13 75 14           	jnz	0A29h

l31FB_0A15:
31FB:0A15 1E              	push	ds
31FB:0A16 B8 B2 5E        	mov	ax,5EB2h
31FB:0A19 50              	push	ax
31FB:0A1A 16              	push	ss
31FB:0A1B 8D 46 F0        	lea	ax,[bp-10h]
31FB:0A1E 50              	push	ax
31FB:0A1F 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0A24 83 C4 08        	add	sp,8h
31FB:0A27 EB 12           	jmp	0A3Bh

l31FB_0A29:
31FB:0A29 1E              	push	ds
31FB:0A2A B8 B6 5E        	mov	ax,5EB6h
31FB:0A2D 50              	push	ax
31FB:0A2E 16              	push	ss
31FB:0A2F 8D 46 F0        	lea	ax,[bp-10h]
31FB:0A32 50              	push	ax
31FB:0A33 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0A38 83 C4 08        	add	sp,8h

l31FB_0A3B:
31FB:0A3B 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0A40 75 14           	jnz	0A56h

l31FB_0A42:
31FB:0A42 1E              	push	ds
31FB:0A43 B8 B8 5E        	mov	ax,5EB8h
31FB:0A46 50              	push	ax
31FB:0A47 16              	push	ss
31FB:0A48 8D 46 F0        	lea	ax,[bp-10h]
31FB:0A4B 50              	push	ax
31FB:0A4C 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0A51 83 C4 08        	add	sp,8h
31FB:0A54 EB 12           	jmp	0A68h

l31FB_0A56:
31FB:0A56 1E              	push	ds
31FB:0A57 B8 BB 5E        	mov	ax,5EBBh
31FB:0A5A 50              	push	ax
31FB:0A5B 16              	push	ss
31FB:0A5C 8D 46 F0        	lea	ax,[bp-10h]
31FB:0A5F 50              	push	ax
31FB:0A60 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0A65 83 C4 08        	add	sp,8h

l31FB_0A68:
31FB:0A68 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0A6D 74 14           	jz	0A83h

l31FB_0A6F:
31FB:0A6F 1E              	push	ds
31FB:0A70 B8 BE 5E        	mov	ax,5EBEh
31FB:0A73 50              	push	ax
31FB:0A74 16              	push	ss
31FB:0A75 8D 46 F0        	lea	ax,[bp-10h]
31FB:0A78 50              	push	ax
31FB:0A79 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0A7E 83 C4 08        	add	sp,8h
31FB:0A81 EB 17           	jmp	0A9Ah

l31FB_0A83:
31FB:0A83 83 FE 02        	cmp	si,2h
31FB:0A86 75 12           	jnz	0A9Ah

l31FB_0A88:
31FB:0A88 1E              	push	ds
31FB:0A89 B8 C0 5E        	mov	ax,5EC0h
31FB:0A8C 50              	push	ax
31FB:0A8D 16              	push	ss
31FB:0A8E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0A91 50              	push	ax
31FB:0A92 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0A97 83 C4 08        	add	sp,8h

l31FB_0A9A:
31FB:0A9A E9 36 06        	jmp	10D3h

l31FB_0A9D:
31FB:0A9D 80 7E EF 41     	cmp	byte ptr [bp-11h],41h
31FB:0AA1 74 03           	jz	0AA6h

l31FB_0AA3:
31FB:0AA3 E9 A8 00        	jmp	0B4Eh

l31FB_0AA6:
31FB:0AA6 83 FE 02        	cmp	si,2h
31FB:0AA9 75 14           	jnz	0ABFh

l31FB_0AAB:
31FB:0AAB 1E              	push	ds
31FB:0AAC B8 C2 5E        	mov	ax,5EC2h
31FB:0AAF 50              	push	ax
31FB:0AB0 16              	push	ss
31FB:0AB1 8D 46 F0        	lea	ax,[bp-10h]
31FB:0AB4 50              	push	ax
31FB:0AB5 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0ABA 83 C4 08        	add	sp,8h
31FB:0ABD EB 12           	jmp	0AD1h

l31FB_0ABF:
31FB:0ABF 1E              	push	ds
31FB:0AC0 B8 C6 5E        	mov	ax,5EC6h
31FB:0AC3 50              	push	ax
31FB:0AC4 16              	push	ss
31FB:0AC5 8D 46 F0        	lea	ax,[bp-10h]
31FB:0AC8 50              	push	ax
31FB:0AC9 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0ACE 83 C4 08        	add	sp,8h

l31FB_0AD1:
31FB:0AD1 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0AD6 75 14           	jnz	0AECh

l31FB_0AD8:
31FB:0AD8 1E              	push	ds
31FB:0AD9 B8 C8 5E        	mov	ax,5EC8h
31FB:0ADC 50              	push	ax
31FB:0ADD 16              	push	ss
31FB:0ADE 8D 46 F0        	lea	ax,[bp-10h]
31FB:0AE1 50              	push	ax
31FB:0AE2 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0AE7 83 C4 08        	add	sp,8h
31FB:0AEA EB 2D           	jmp	0B19h

l31FB_0AEC:
31FB:0AEC 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:0AF1 75 14           	jnz	0B07h

l31FB_0AF3:
31FB:0AF3 1E              	push	ds
31FB:0AF4 B8 CB 5E        	mov	ax,5ECBh
31FB:0AF7 50              	push	ax
31FB:0AF8 16              	push	ss
31FB:0AF9 8D 46 F0        	lea	ax,[bp-10h]
31FB:0AFC 50              	push	ax
31FB:0AFD 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0B02 83 C4 08        	add	sp,8h
31FB:0B05 EB 12           	jmp	0B19h

l31FB_0B07:
31FB:0B07 1E              	push	ds
31FB:0B08 B8 CE 5E        	mov	ax,5ECEh
31FB:0B0B 50              	push	ax
31FB:0B0C 16              	push	ss
31FB:0B0D 8D 46 F0        	lea	ax,[bp-10h]
31FB:0B10 50              	push	ax
31FB:0B11 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0B16 83 C4 08        	add	sp,8h

l31FB_0B19:
31FB:0B19 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0B1E 74 14           	jz	0B34h

l31FB_0B20:
31FB:0B20 1E              	push	ds
31FB:0B21 B8 D1 5E        	mov	ax,5ED1h
31FB:0B24 50              	push	ax
31FB:0B25 16              	push	ss
31FB:0B26 8D 46 F0        	lea	ax,[bp-10h]
31FB:0B29 50              	push	ax
31FB:0B2A 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0B2F 83 C4 08        	add	sp,8h
31FB:0B32 EB 17           	jmp	0B4Bh

l31FB_0B34:
31FB:0B34 83 FE 02        	cmp	si,2h
31FB:0B37 75 12           	jnz	0B4Bh

l31FB_0B39:
31FB:0B39 1E              	push	ds
31FB:0B3A B8 D3 5E        	mov	ax,5ED3h
31FB:0B3D 50              	push	ax
31FB:0B3E 16              	push	ss
31FB:0B3F 8D 46 F0        	lea	ax,[bp-10h]
31FB:0B42 50              	push	ax
31FB:0B43 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0B48 83 C4 08        	add	sp,8h

l31FB_0B4B:
31FB:0B4B E9 85 05        	jmp	10D3h

l31FB_0B4E:
31FB:0B4E 80 7E EF 42     	cmp	byte ptr [bp-11h],42h
31FB:0B52 7C 06           	jl	0B5Ah

l31FB_0B54:
31FB:0B54 80 7E EF 45     	cmp	byte ptr [bp-11h],45h
31FB:0B58 7E 09           	jle	0B63h

l31FB_0B5A:
31FB:0B5A 80 7E EF 54     	cmp	byte ptr [bp-11h],54h
31FB:0B5E 74 03           	jz	0B63h

l31FB_0B60:
31FB:0B60 E9 DE 00        	jmp	0C41h

l31FB_0B63:
31FB:0B63 83 FE 02        	cmp	si,2h
31FB:0B66 75 14           	jnz	0B7Ch

l31FB_0B68:
31FB:0B68 1E              	push	ds
31FB:0B69 B8 D5 5E        	mov	ax,5ED5h
31FB:0B6C 50              	push	ax
31FB:0B6D 16              	push	ss
31FB:0B6E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0B71 50              	push	ax
31FB:0B72 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0B77 83 C4 08        	add	sp,8h
31FB:0B7A EB 12           	jmp	0B8Eh

l31FB_0B7C:
31FB:0B7C 1E              	push	ds
31FB:0B7D B8 D9 5E        	mov	ax,5ED9h
31FB:0B80 50              	push	ax
31FB:0B81 16              	push	ss
31FB:0B82 8D 46 F0        	lea	ax,[bp-10h]
31FB:0B85 50              	push	ax
31FB:0B86 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0B8B 83 C4 08        	add	sp,8h

l31FB_0B8E:
31FB:0B8E 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0B93 75 14           	jnz	0BA9h

l31FB_0B95:
31FB:0B95 1E              	push	ds
31FB:0B96 B8 DB 5E        	mov	ax,5EDBh
31FB:0B99 50              	push	ax
31FB:0B9A 16              	push	ss
31FB:0B9B 8D 46 F0        	lea	ax,[bp-10h]
31FB:0B9E 50              	push	ax
31FB:0B9F 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0BA4 83 C4 08        	add	sp,8h
31FB:0BA7 EB 63           	jmp	0C0Ch

l31FB_0BA9:
31FB:0BA9 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:0BAE 75 14           	jnz	0BC4h

l31FB_0BB0:
31FB:0BB0 1E              	push	ds
l2A6A_84C1		dw	0xDEB8
	dw	0x505E
2A6A:84C5                16 8D 46 F0 50 9A 01 00 7A 39 83      ..F.P...z9.
2A6A:84D0 C4 08 EB 48                                     ...H            

l31FB_0BC4:
31FB:0BC4 83 3E F2 B2 03  	cmp	word ptr [0B2F2h],3h
31FB:0BC9 75 14           	jnz	0BDFh

l31FB_0BCB:
31FB:0BCB 1E              	push	ds
31FB:0BCC B8 E1 5E        	mov	ax,5EE1h
31FB:0BCF 50              	push	ax
31FB:0BD0 16              	push	ss
31FB:0BD1 8D 46 F0        	lea	ax,[bp-10h]
31FB:0BD4 50              	push	ax
31FB:0BD5 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0BDA 83 C4 08        	add	sp,8h
31FB:0BDD EB 2D           	jmp	0C0Ch

l31FB_0BDF:
31FB:0BDF 83 3E F2 B2 04  	cmp	word ptr [0B2F2h],4h
31FB:0BE4 75 14           	jnz	0BFAh

l31FB_0BE6:
31FB:0BE6 1E              	push	ds
31FB:0BE7 B8 E4 5E        	mov	ax,5EE4h
31FB:0BEA 50              	push	ax
31FB:0BEB 16              	push	ss
31FB:0BEC 8D 46 F0        	lea	ax,[bp-10h]
31FB:0BEF 50              	push	ax
31FB:0BF0 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0BF5 83 C4 08        	add	sp,8h
31FB:0BF8 EB 12           	jmp	0C0Ch

l31FB_0BFA:
31FB:0BFA 1E              	push	ds
31FB:0BFB B8 E7 5E        	mov	ax,5EE7h
31FB:0BFE 50              	push	ax
31FB:0BFF 16              	push	ss
31FB:0C00 8D 46 F0        	lea	ax,[bp-10h]
31FB:0C03 50              	push	ax
31FB:0C04 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0C09 83 C4 08        	add	sp,8h

l31FB_0C0C:
31FB:0C0C 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0C11 74 14           	jz	0C27h

l31FB_0C13:
31FB:0C13 1E              	push	ds
31FB:0C14 B8 EA 5E        	mov	ax,5EEAh
31FB:0C17 50              	push	ax
31FB:0C18 16              	push	ss
31FB:0C19 8D 46 F0        	lea	ax,[bp-10h]
31FB:0C1C 50              	push	ax
31FB:0C1D 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0C22 83 C4 08        	add	sp,8h
31FB:0C25 EB 17           	jmp	0C3Eh

l31FB_0C27:
31FB:0C27 83 FE 02        	cmp	si,2h
31FB:0C2A 75 12           	jnz	0C3Eh

l31FB_0C2C:
31FB:0C2C 1E              	push	ds
31FB:0C2D B8 EC 5E        	mov	ax,5EECh
31FB:0C30 50              	push	ax
31FB:0C31 16              	push	ss
31FB:0C32 8D 46 F0        	lea	ax,[bp-10h]
31FB:0C35 50              	push	ax
31FB:0C36 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0C3B 83 C4 08        	add	sp,8h

l31FB_0C3E:
31FB:0C3E E9 92 04        	jmp	10D3h

l31FB_0C41:
31FB:0C41 80 7E EF 46     	cmp	byte ptr [bp-11h],46h
31FB:0C45 7D 03           	jge	0C4Ah

l31FB_0C47:
31FB:0C47 E9 E7 00        	jmp	0D31h

l31FB_0C4A:
31FB:0C4A 80 7E EF 4E     	cmp	byte ptr [bp-11h],4Eh
31FB:0C4E 7E 03           	jle	0C53h

l31FB_0C50:
31FB:0C50 E9 DE 00        	jmp	0D31h

l31FB_0C53:
31FB:0C53 83 FE 02        	cmp	si,2h
31FB:0C56 75 14           	jnz	0C6Ch

l31FB_0C58:
31FB:0C58 1E              	push	ds
31FB:0C59 B8 EE 5E        	mov	ax,5EEEh
31FB:0C5C 50              	push	ax
31FB:0C5D 16              	push	ss
31FB:0C5E 8D 46 F0        	lea	ax,[bp-10h]
31FB:0C61 50              	push	ax
31FB:0C62 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0C67 83 C4 08        	add	sp,8h
31FB:0C6A EB 12           	jmp	0C7Eh

l31FB_0C6C:
31FB:0C6C 1E              	push	ds
31FB:0C6D B8 F2 5E        	mov	ax,5EF2h
31FB:0C70 50              	push	ax
31FB:0C71 16              	push	ss
31FB:0C72 8D 46 F0        	lea	ax,[bp-10h]
31FB:0C75 50              	push	ax
31FB:0C76 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0C7B 83 C4 08        	add	sp,8h

l31FB_0C7E:
31FB:0C7E 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0C83 75 14           	jnz	0C99h

l31FB_0C85:
31FB:0C85 1E              	push	ds
31FB:0C86 B8 F4 5E        	mov	ax,5EF4h
31FB:0C89 50              	push	ax
31FB:0C8A 16              	push	ss
31FB:0C8B 8D 46 F0        	lea	ax,[bp-10h]
31FB:0C8E 50              	push	ax
31FB:0C8F 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0C94 83 C4 08        	add	sp,8h
31FB:0C97 EB 63           	jmp	0CFCh

l31FB_0C99:
31FB:0C99 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:0C9E 75 14           	jnz	0CB4h
l2A6A_85AF	db	0x14

l31FB_0CA0:
31FB:0CA0 1E              	push	ds
31FB:0CA1 B8 F7 5E        	mov	ax,5EF7h
31FB:0CA4 50              	push	ax
31FB:0CA5 16              	push	ss
31FB:0CA6 8D 46 F0        	lea	ax,[bp-10h]
31FB:0CA9 50              	push	ax
31FB:0CAA 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0CAF 83 C4 08        	add	sp,8h
31FB:0CB2 EB 48           	jmp	0CFCh

l31FB_0CB4:
31FB:0CB4 83 3E F2 B2 03  	cmp	word ptr [0B2F2h],3h
31FB:0CB9 75 14           	jnz	0CCFh

l31FB_0CBB:
31FB:0CBB 1E              	push	ds
31FB:0CBC B8 FA 5E        	mov	ax,5EFAh
31FB:0CBF 50              	push	ax
31FB:0CC0 16              	push	ss
31FB:0CC1 8D 46 F0        	lea	ax,[bp-10h]
31FB:0CC4 50              	push	ax
31FB:0CC5 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0CCA 83 C4 08        	add	sp,8h
31FB:0CCD EB 2D           	jmp	0CFCh

l31FB_0CCF:
31FB:0CCF 83 3E F2 B2 04  	cmp	word ptr [0B2F2h],4h
31FB:0CD4 75 14           	jnz	0CEAh

l31FB_0CD6:
31FB:0CD6 1E              	push	ds
31FB:0CD7 B8 FD 5E        	mov	ax,5EFDh
31FB:0CDA 50              	push	ax
31FB:0CDB 16              	push	ss
31FB:0CDC 8D 46 F0        	lea	ax,[bp-10h]
31FB:0CDF 50              	push	ax
31FB:0CE0 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0CE5 83 C4 08        	add	sp,8h
31FB:0CE8 EB 12           	jmp	0CFCh

l31FB_0CEA:
31FB:0CEA 1E              	push	ds
31FB:0CEB B8 00 5F        	mov	ax,5F00h
31FB:0CEE 50              	push	ax
31FB:0CEF 16              	push	ss
31FB:0CF0 8D 46 F0        	lea	ax,[bp-10h]
31FB:0CF3 50              	push	ax
31FB:0CF4 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0CF9 83 C4 08        	add	sp,8h

l31FB_0CFC:
31FB:0CFC 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0D01 74 14           	jz	0D17h

l31FB_0D03:
31FB:0D03 1E              	push	ds
31FB:0D04 B8 03 5F        	mov	ax,5F03h
31FB:0D07 50              	push	ax
31FB:0D08 16              	push	ss
31FB:0D09 8D 46 F0        	lea	ax,[bp-10h]
31FB:0D0C 50              	push	ax
31FB:0D0D 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0D12 83 C4 08        	add	sp,8h
31FB:0D15 EB 17           	jmp	0D2Eh

l31FB_0D17:
31FB:0D17 83 FE 02        	cmp	si,2h
31FB:0D1A 75 12           	jnz	0D2Eh

l31FB_0D1C:
31FB:0D1C 1E              	push	ds
31FB:0D1D B8 05 5F        	mov	ax,5F05h
31FB:0D20 50              	push	ax
31FB:0D21 16              	push	ss
31FB:0D22 8D 46 F0        	lea	ax,[bp-10h]
31FB:0D25 50              	push	ax
31FB:0D26 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0D2B 83 C4 08        	add	sp,8h

l31FB_0D2E:
31FB:0D2E E9 A2 03        	jmp	10D3h

l31FB_0D31:
31FB:0D31 80 7E EF 4F     	cmp	byte ptr [bp-11h],4Fh
31FB:0D35 74 03           	jz	0D3Ah

l31FB_0D37:
31FB:0D37 E9 DE 00        	jmp	0E18h

l31FB_0D3A:
31FB:0D3A 83 FE 02        	cmp	si,2h
31FB:0D3D 75 14           	jnz	0D53h

l31FB_0D3F:
31FB:0D3F 1E              	push	ds
31FB:0D40 B8 07 5F        	mov	ax,5F07h
31FB:0D43 50              	push	ax
31FB:0D44 16              	push	ss
31FB:0D45 8D 46 F0        	lea	ax,[bp-10h]
31FB:0D48 50              	push	ax
31FB:0D49 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0D4E 83 C4 08        	add	sp,8h
31FB:0D51 EB 12           	jmp	0D65h

l31FB_0D53:
31FB:0D53 1E              	push	ds
31FB:0D54 B8 0B 5F        	mov	ax,5F0Bh
31FB:0D57 50              	push	ax
31FB:0D58 16              	push	ss
31FB:0D59 8D 46 F0        	lea	ax,[bp-10h]
31FB:0D5C 50              	push	ax
31FB:0D5D 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0D62 83 C4 08        	add	sp,8h

l31FB_0D65:
31FB:0D65 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0D6A 75 14           	jnz	0D80h

l31FB_0D6C:
31FB:0D6C 1E              	push	ds
31FB:0D6D B8 0D 5F        	mov	ax,5F0Dh
31FB:0D70 50              	push	ax
31FB:0D71 16              	push	ss
31FB:0D72 8D 46 F0        	lea	ax,[bp-10h]
31FB:0D75 50              	push	ax
31FB:0D76 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0D7B 83 C4 08        	add	sp,8h
31FB:0D7E EB 63           	jmp	0DE3h

l31FB_0D80:
31FB:0D80 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:0D85 75 14           	jnz	0D9Bh

l31FB_0D87:
31FB:0D87 1E              	push	ds
31FB:0D88 B8 10 5F        	mov	ax,5F10h
31FB:0D8B 50              	push	ax
31FB:0D8C 16              	push	ss
31FB:0D8D 8D 46 F0        	lea	ax,[bp-10h]
31FB:0D90 50              	push	ax
31FB:0D91 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0D96 83 C4 08        	add	sp,8h
31FB:0D99 EB 48           	jmp	0DE3h

l31FB_0D9B:
31FB:0D9B 83 3E F2 B2 03  	cmp	word ptr [0B2F2h],3h
31FB:0DA0 75 14           	jnz	0DB6h

l31FB_0DA2:
31FB:0DA2 1E              	push	ds
31FB:0DA3 B8 13 5F        	mov	ax,5F13h
31FB:0DA6 50              	push	ax
31FB:0DA7 16              	push	ss
31FB:0DA8 8D 46 F0        	lea	ax,[bp-10h]
31FB:0DAB 50              	push	ax
31FB:0DAC 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0DB1 83 C4 08        	add	sp,8h
31FB:0DB4 EB 2D           	jmp	0DE3h

l31FB_0DB6:
31FB:0DB6 83 3E F2 B2 04  	cmp	word ptr [0B2F2h],4h
31FB:0DBB 75 14           	jnz	0DD1h

l31FB_0DBD:
31FB:0DBD 1E              	push	ds
31FB:0DBE B8 16 5F        	mov	ax,5F16h
31FB:0DC1 50              	push	ax
31FB:0DC2 16              	push	ss
31FB:0DC3 8D 46 F0        	lea	ax,[bp-10h]
31FB:0DC6 50              	push	ax
31FB:0DC7 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0DCC 83 C4 08        	add	sp,8h
31FB:0DCF EB 12           	jmp	0DE3h

l31FB_0DD1:
31FB:0DD1 1E              	push	ds
31FB:0DD2 B8 19 5F        	mov	ax,5F19h
31FB:0DD5 50              	push	ax
31FB:0DD6 16              	push	ss
31FB:0DD7 8D 46 F0        	lea	ax,[bp-10h]
31FB:0DDA 50              	push	ax
31FB:0DDB 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0DE0 83 C4 08        	add	sp,8h

l31FB_0DE3:
31FB:0DE3 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0DE8 74 14           	jz	0DFEh

l31FB_0DEA:
31FB:0DEA 1E              	push	ds
31FB:0DEB B8 1C 5F        	mov	ax,5F1Ch
31FB:0DEE 50              	push	ax
31FB:0DEF 16              	push	ss
31FB:0DF0 8D 46 F0        	lea	ax,[bp-10h]
31FB:0DF3 50              	push	ax
31FB:0DF4 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0DF9 83 C4 08        	add	sp,8h
31FB:0DFC EB 17           	jmp	0E15h

l31FB_0DFE:
31FB:0DFE 83 FE 02        	cmp	si,2h
31FB:0E01 75 12           	jnz	0E15h

l31FB_0E03:
31FB:0E03 1E              	push	ds
31FB:0E04 B8 1E 5F        	mov	ax,5F1Eh
31FB:0E07 50              	push	ax
31FB:0E08 16              	push	ss
31FB:0E09 8D 46 F0        	lea	ax,[bp-10h]
31FB:0E0C 50              	push	ax
31FB:0E0D 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0E12 83 C4 08        	add	sp,8h

l31FB_0E15:
31FB:0E15 E9 BB 02        	jmp	10D3h

l31FB_0E18:
31FB:0E18 80 7E EF 50     	cmp	byte ptr [bp-11h],50h
31FB:0E1C 7D 03           	jge	0E21h

l31FB_0E1E:
31FB:0E1E E9 E7 00        	jmp	0F08h

l31FB_0E21:
31FB:0E21 80 7E EF 52     	cmp	byte ptr [bp-11h],52h
31FB:0E25 7E 03           	jle	0E2Ah

l31FB_0E27:
31FB:0E27 E9 DE 00        	jmp	0F08h

l31FB_0E2A:
31FB:0E2A 83 FE 02        	cmp	si,2h
31FB:0E2D 75 14           	jnz	0E43h

l31FB_0E2F:
31FB:0E2F 1E              	push	ds
31FB:0E30 B8 20 5F        	mov	ax,5F20h
31FB:0E33 50              	push	ax
31FB:0E34 16              	push	ss
31FB:0E35 8D 46 F0        	lea	ax,[bp-10h]
31FB:0E38 50              	push	ax
31FB:0E39 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0E3E 83 C4 08        	add	sp,8h
31FB:0E41 EB 12           	jmp	0E55h

l31FB_0E43:
31FB:0E43 1E              	push	ds
31FB:0E44 B8 24 5F        	mov	ax,5F24h
31FB:0E47 50              	push	ax
31FB:0E48 16              	push	ss
31FB:0E49 8D 46 F0        	lea	ax,[bp-10h]
31FB:0E4C 50              	push	ax
31FB:0E4D 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0E52 83 C4 08        	add	sp,8h

l31FB_0E55:
31FB:0E55 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0E5A 75 14           	jnz	0E70h

l31FB_0E5C:
31FB:0E5C 1E              	push	ds
31FB:0E5D B8 26 5F        	mov	ax,5F26h
31FB:0E60 50              	push	ax
31FB:0E61 16              	push	ss
31FB:0E62 8D 46 F0        	lea	ax,[bp-10h]
31FB:0E65 50              	push	ax
31FB:0E66 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0E6B 83 C4 08        	add	sp,8h
31FB:0E6E EB 63           	jmp	0ED3h

l31FB_0E70:
31FB:0E70 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:0E75 75 14           	jnz	0E8Bh

l31FB_0E77:
31FB:0E77 1E              	push	ds
31FB:0E78 B8 29 5F        	mov	ax,5F29h
31FB:0E7B 50              	push	ax
31FB:0E7C 16              	push	ss
31FB:0E7D 8D 46 F0        	lea	ax,[bp-10h]
31FB:0E80 50              	push	ax
31FB:0E81 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0E86 83 C4 08        	add	sp,8h
31FB:0E89 EB 48           	jmp	0ED3h

l31FB_0E8B:
31FB:0E8B 83 3E F2 B2 03  	cmp	word ptr [0B2F2h],3h
31FB:0E90 75 14           	jnz	0EA6h

l31FB_0E92:
31FB:0E92 1E              	push	ds
31FB:0E93 B8 2C 5F        	mov	ax,5F2Ch
31FB:0E96 50              	push	ax
31FB:0E97 16              	push	ss
31FB:0E98 8D 46 F0        	lea	ax,[bp-10h]
31FB:0E9B 50              	push	ax
31FB:0E9C 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0EA1 83 C4 08        	add	sp,8h
31FB:0EA4 EB 2D           	jmp	0ED3h

l31FB_0EA6:
31FB:0EA6 83 3E F2 B2 04  	cmp	word ptr [0B2F2h],4h
31FB:0EAB 75 14           	jnz	0EC1h

l31FB_0EAD:
31FB:0EAD 1E              	push	ds
31FB:0EAE B8 2F 5F        	mov	ax,5F2Fh
31FB:0EB1 50              	push	ax
31FB:0EB2 16              	push	ss
31FB:0EB3 8D 46 F0        	lea	ax,[bp-10h]
31FB:0EB6 50              	push	ax
31FB:0EB7 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0EBC 83 C4 08        	add	sp,8h
31FB:0EBF EB 12           	jmp	0ED3h

l31FB_0EC1:
31FB:0EC1 1E              	push	ds
31FB:0EC2 B8 32 5F        	mov	ax,5F32h
31FB:0EC5 50              	push	ax
31FB:0EC6 16              	push	ss
31FB:0EC7 8D 46 F0        	lea	ax,[bp-10h]
31FB:0ECA 50              	push	ax
31FB:0ECB 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0ED0 83 C4 08        	add	sp,8h

l31FB_0ED3:
31FB:0ED3 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0ED8 74 14           	jz	0EEEh

l31FB_0EDA:
31FB:0EDA 1E              	push	ds
31FB:0EDB B8 35 5F        	mov	ax,5F35h
31FB:0EDE 50              	push	ax
31FB:0EDF 16              	push	ss
31FB:0EE0 8D 46 F0        	lea	ax,[bp-10h]
31FB:0EE3 50              	push	ax
31FB:0EE4 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0EE9 83 C4 08        	add	sp,8h
31FB:0EEC EB 17           	jmp	0F05h

l31FB_0EEE:
31FB:0EEE 83 FE 02        	cmp	si,2h
31FB:0EF1 75 12           	jnz	0F05h

l31FB_0EF3:
31FB:0EF3 1E              	push	ds
31FB:0EF4 B8 37 5F        	mov	ax,5F37h
31FB:0EF7 50              	push	ax
31FB:0EF8 16              	push	ss
31FB:0EF9 8D 46 F0        	lea	ax,[bp-10h]
31FB:0EFC 50              	push	ax
31FB:0EFD 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0F02 83 C4 08        	add	sp,8h

l31FB_0F05:
31FB:0F05 E9 CB 01        	jmp	10D3h

l31FB_0F08:
31FB:0F08 80 7E EF 53     	cmp	byte ptr [bp-11h],53h
31FB:0F0C 74 03           	jz	0F11h

l31FB_0F0E:
31FB:0F0E E9 DE 00        	jmp	0FEFh

l31FB_0F11:
31FB:0F11 83 FE 02        	cmp	si,2h
31FB:0F14 75 14           	jnz	0F2Ah

l31FB_0F16:
31FB:0F16 1E              	push	ds
31FB:0F17 B8 39 5F        	mov	ax,5F39h
31FB:0F1A 50              	push	ax
31FB:0F1B 16              	push	ss
31FB:0F1C 8D 46 F0        	lea	ax,[bp-10h]
31FB:0F1F 50              	push	ax
31FB:0F20 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0F25 83 C4 08        	add	sp,8h
31FB:0F28 EB 12           	jmp	0F3Ch

l31FB_0F2A:
31FB:0F2A 1E              	push	ds
31FB:0F2B B8 3D 5F        	mov	ax,5F3Dh
31FB:0F2E 50              	push	ax
31FB:0F2F 16              	push	ss
31FB:0F30 8D 46 F0        	lea	ax,[bp-10h]
31FB:0F33 50              	push	ax
31FB:0F34 9A 00 00 83 39  	call	far 3983h:0000h
31FB:0F39 83 C4 08        	add	sp,8h

l31FB_0F3C:
31FB:0F3C 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:0F41 75 14           	jnz	0F57h

l31FB_0F43:
31FB:0F43 1E              	push	ds
31FB:0F44 B8 3F 5F        	mov	ax,5F3Fh
31FB:0F47 50              	push	ax
31FB:0F48 16              	push	ss
31FB:0F49 8D 46 F0        	lea	ax,[bp-10h]
31FB:0F4C 50              	push	ax
31FB:0F4D 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0F52 83 C4 08        	add	sp,8h
31FB:0F55 EB 63           	jmp	0FBAh

l31FB_0F57:
31FB:0F57 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:0F5C 75 14           	jnz	0F72h

l31FB_0F5E:
31FB:0F5E 1E              	push	ds
31FB:0F5F B8 42 5F        	mov	ax,5F42h
31FB:0F62 50              	push	ax
31FB:0F63 16              	push	ss
31FB:0F64 8D 46 F0        	lea	ax,[bp-10h]
31FB:0F67 50              	push	ax
31FB:0F68 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0F6D 83 C4 08        	add	sp,8h
31FB:0F70 EB 48           	jmp	0FBAh

l31FB_0F72:
31FB:0F72 83 3E F2 B2 03  	cmp	word ptr [0B2F2h],3h
31FB:0F77 75 14           	jnz	0F8Dh

l31FB_0F79:
31FB:0F79 1E              	push	ds
31FB:0F7A B8 45 5F        	mov	ax,5F45h
31FB:0F7D 50              	push	ax
31FB:0F7E 16              	push	ss
31FB:0F7F 8D 46 F0        	lea	ax,[bp-10h]
31FB:0F82 50              	push	ax
31FB:0F83 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0F88 83 C4 08        	add	sp,8h
31FB:0F8B EB 2D           	jmp	0FBAh

l31FB_0F8D:
31FB:0F8D 83 3E F2 B2 04  	cmp	word ptr [0B2F2h],4h
31FB:0F92 75 14           	jnz	0FA8h

l31FB_0F94:
31FB:0F94 1E              	push	ds
31FB:0F95 B8 48 5F        	mov	ax,5F48h
31FB:0F98 50              	push	ax
31FB:0F99 16              	push	ss
31FB:0F9A 8D 46 F0        	lea	ax,[bp-10h]
31FB:0F9D 50              	push	ax
31FB:0F9E 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0FA3 83 C4 08        	add	sp,8h
31FB:0FA6 EB 12           	jmp	0FBAh

l31FB_0FA8:
31FB:0FA8 1E              	push	ds
31FB:0FA9 B8 4B 5F        	mov	ax,5F4Bh
31FB:0FAC 50              	push	ax
31FB:0FAD 16              	push	ss
31FB:0FAE 8D 46 F0        	lea	ax,[bp-10h]
31FB:0FB1 50              	push	ax
31FB:0FB2 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0FB7 83 C4 08        	add	sp,8h

l31FB_0FBA:
31FB:0FBA 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:0FBF 74 14           	jz	0FD5h

l31FB_0FC1:
31FB:0FC1 1E              	push	ds
31FB:0FC2 B8 4E 5F        	mov	ax,5F4Eh
31FB:0FC5 50              	push	ax
31FB:0FC6 16              	push	ss
31FB:0FC7 8D 46 F0        	lea	ax,[bp-10h]
31FB:0FCA 50              	push	ax
31FB:0FCB 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0FD0 83 C4 08        	add	sp,8h
31FB:0FD3 EB 17           	jmp	0FECh

l31FB_0FD5:
31FB:0FD5 83 FE 02        	cmp	si,2h
31FB:0FD8 75 12           	jnz	0FECh

l31FB_0FDA:
31FB:0FDA 1E              	push	ds
31FB:0FDB B8 50 5F        	mov	ax,5F50h
31FB:0FDE 50              	push	ax
31FB:0FDF 16              	push	ss
31FB:0FE0 8D 46 F0        	lea	ax,[bp-10h]
31FB:0FE3 50              	push	ax
31FB:0FE4 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:0FE9 83 C4 08        	add	sp,8h

l31FB_0FEC:
31FB:0FEC E9 E4 00        	jmp	10D3h

l31FB_0FEF:
31FB:0FEF 80 7E EF 55     	cmp	byte ptr [bp-11h],55h
31FB:0FF3 74 03           	jz	0FF8h

l31FB_0FF5:
31FB:0FF5 E9 DB 00        	jmp	10D3h

l31FB_0FF8:
31FB:0FF8 83 FE 02        	cmp	si,2h
31FB:0FFB 75 14           	jnz	1011h

l31FB_0FFD:
31FB:0FFD 1E              	push	ds
31FB:0FFE B8 52 5F        	mov	ax,5F52h
31FB:1001 50              	push	ax
31FB:1002 16              	push	ss
31FB:1003 8D 46 F0        	lea	ax,[bp-10h]
31FB:1006 50              	push	ax
31FB:1007 9A 00 00 83 39  	call	far 3983h:0000h
31FB:100C 83 C4 08        	add	sp,8h
31FB:100F EB 12           	jmp	1023h

l31FB_1011:
31FB:1011 1E              	push	ds
31FB:1012 B8 56 5F        	mov	ax,5F56h
31FB:1015 50              	push	ax
31FB:1016 16              	push	ss
31FB:1017 8D 46 F0        	lea	ax,[bp-10h]
31FB:101A 50              	push	ax
31FB:101B 9A 00 00 83 39  	call	far 3983h:0000h
31FB:1020 83 C4 08        	add	sp,8h

l31FB_1023:
31FB:1023 83 3E F2 B2 01  	cmp	word ptr [0B2F2h],1h
31FB:1028 75 14           	jnz	103Eh

l31FB_102A:
31FB:102A 1E              	push	ds
31FB:102B B8 58 5F        	mov	ax,5F58h
31FB:102E 50              	push	ax
31FB:102F 16              	push	ss
31FB:1030 8D 46 F0        	lea	ax,[bp-10h]
31FB:1033 50              	push	ax
31FB:1034 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:1039 83 C4 08        	add	sp,8h
31FB:103C EB 63           	jmp	10A1h

l31FB_103E:
31FB:103E 83 3E F2 B2 02  	cmp	word ptr [0B2F2h],2h
31FB:1043 75 14           	jnz	1059h

l31FB_1045:
31FB:1045 1E              	push	ds
31FB:1046 B8 5B 5F        	mov	ax,5F5Bh
31FB:1049 50              	push	ax
31FB:104A 16              	push	ss
31FB:104B 8D 46 F0        	lea	ax,[bp-10h]
31FB:104E 50              	push	ax
31FB:104F 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:1054 83 C4 08        	add	sp,8h
31FB:1057 EB 48           	jmp	10A1h

l31FB_1059:
31FB:1059 83 3E F2 B2 03  	cmp	word ptr [0B2F2h],3h
31FB:105E 75 14           	jnz	1074h

l31FB_1060:
31FB:1060 1E              	push	ds
31FB:1061 B8 5E 5F        	mov	ax,5F5Eh
31FB:1064 50              	push	ax
31FB:1065 16              	push	ss
31FB:1066 8D 46 F0        	lea	ax,[bp-10h]
31FB:1069 50              	push	ax
31FB:106A 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:106F 83 C4 08        	add	sp,8h
31FB:1072 EB 2D           	jmp	10A1h

l31FB_1074:
31FB:1074 83 3E F2 B2 04  	cmp	word ptr [0B2F2h],4h
31FB:1079 75 14           	jnz	108Fh

l31FB_107B:
31FB:107B 1E              	push	ds
31FB:107C B8 61 5F        	mov	ax,5F61h
31FB:107F 50              	push	ax
31FB:1080 16              	push	ss
31FB:1081 8D 46 F0        	lea	ax,[bp-10h]
31FB:1084 50              	push	ax
31FB:1085 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:108A 83 C4 08        	add	sp,8h
31FB:108D EB 12           	jmp	10A1h

l31FB_108F:
31FB:108F 1E              	push	ds
31FB:1090 B8 64 5F        	mov	ax,5F64h
31FB:1093 50              	push	ax
31FB:1094 16              	push	ss
31FB:1095 8D 46 F0        	lea	ax,[bp-10h]
31FB:1098 50              	push	ax
31FB:1099 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:109E 83 C4 08        	add	sp,8h

l31FB_10A1:
31FB:10A1 83 3E 85 B5 00  	cmp	word ptr [0B585h],0h
31FB:10A6 74 14           	jz	10BCh

l31FB_10A8:
31FB:10A8 1E              	push	ds
31FB:10A9 B8 67 5F        	mov	ax,5F67h
31FB:10AC 50              	push	ax
31FB:10AD 16              	push	ss
31FB:10AE 8D 46 F0        	lea	ax,[bp-10h]
31FB:10B1 50              	push	ax
31FB:10B2 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:10B7 83 C4 08        	add	sp,8h
31FB:10BA EB 17           	jmp	10D3h

l31FB_10BC:
31FB:10BC 83 FE 02        	cmp	si,2h
31FB:10BF 75 12           	jnz	10D3h

l31FB_10C1:
31FB:10C1 1E              	push	ds
31FB:10C2 B8 69 5F        	mov	ax,5F69h
31FB:10C5 50              	push	ax
31FB:10C6 16              	push	ss
31FB:10C7 8D 46 F0        	lea	ax,[bp-10h]
31FB:10CA 50              	push	ax
31FB:10CB 9A 01 00 7A 39  	call	far 397Ah:0001h
31FB:10D0 83 C4 08        	add	sp,8h

l31FB_10D3:
31FB:10D3 0B F6           	or	si,si
31FB:10D5 75 03           	jnz	10DAh

l31FB_10D7:
31FB:10D7 E9 C7 01        	jmp	12A1h

l31FB_10DA:
31FB:10DA 80 3E 65 86 01  	cmp	byte ptr [8665h],1h
31FB:10DF 7C 57           	jl	1138h

l31FB_10E1:
31FB:10E1 C6 06 F0 A7 01  	mov	byte ptr [0A7F0h],1h
31FB:10E6 80 3E 15 80 00  	cmp	byte ptr [8015h],0h
31FB:10EB 75 37           	jnz	1124h

l31FB_10ED:
31FB:10ED C6 06 15 80 01  	mov	byte ptr [8015h],1h
31FB:10F2 9A 82 03 B2 30  	call	far 30B2h:0382h
31FB:10F7 FF 36 26 B6     	push	word ptr [0B626h]
31FB:10FB 9A 3B 06 5F 37  	call	far 375Fh:063Bh
31FB:1100 59              	pop	cx
31FB:1101 FF 36 26 B6     	push	word ptr [0B626h]
31FB:1105 A0 65 86        	mov	al,[8665h]
31FB:1108 98              	cbw
31FB:1109 8B D8           	mov	bx,ax
31FB:110B D1 E3           	shl	bx,1h
31FB:110D FF B7 3E 59     	push	word ptr [bx+593Eh]
31FB:1111 9A C2 02 5F 37  	call	far 375Fh:02C2h
31FB:1116 59              	pop	cx
31FB:1117 59              	pop	cx
31FB:1118 B8 00 01        	mov	ax,100h
31FB:111B 50              	push	ax
31FB:111C 9A C6 09 5F 37  	call	far 375Fh:09C6h
31FB:1121 59              	pop	cx
31FB:1122 EB 0F           	jmp	1133h

l31FB_1124:
31FB:1124 FF 36 10 B6     	push	word ptr [0B610h]
31FB:1128 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:112C 9A B9 08 5F 37  	call	far 375Fh:08B9h
31FB:1131 59              	pop	cx
31FB:1132 59              	pop	cx

l31FB_1133:
31FB:1133 C6 06 F0 A7 00  	mov	byte ptr [0A7F0h],0h

l31FB_1138:
31FB:1138 C7 46 E8 00 00  	mov	word ptr [bp-18h],0h
31FB:113D 33 FF           	xor	di,di
31FB:113F EB 67           	jmp	11A8h

l31FB_1141:
31FB:1141 36 FF 73 F0     	push	word ptr ss:[bp+di-10h]
31FB:1145 0E              	push	cs
31FB:1146 E8 0D F1        	call	0256h
31FB:1149 59              	pop	cx
31FB:114A 89 46 EC        	mov	[bp-14h],ax
31FB:114D 83 7E EC 00     	cmp	word ptr [bp-14h],0h
31FB:1151 7C 54           	jl	11A7h

l31FB_1153:
31FB:1153 B8 33 66        	mov	ax,6633h
31FB:1156 50              	push	ax
31FB:1157 B8 40 1F        	mov	ax,1F40h
31FB:115A 50              	push	ax
31FB:115B 8B 46 EC        	mov	ax,[bp-14h]
31FB:115E BA 0B 00        	mov	dx,0Bh
31FB:1161 F7 E2           	mul	dx
31FB:1163 8B D8           	mov	bx,ax
31FB:1165 81 C3 FC 5C     	add	bx,5CFCh
31FB:1169 1E              	push	ds
31FB:116A 07              	pop	es
31FB:116B 26 FF 77 07     	push	word ptr es:[bx+7h]
31FB:116F 8B 46 EC        	mov	ax,[bp-14h]
31FB:1172 BA 0B 00        	mov	dx,0Bh
31FB:1175 F7 E2           	mul	dx
31FB:1177 8B D8           	mov	bx,ax
31FB:1179 81 C3 FC 5C     	add	bx,5CFCh
31FB:117D 1E              	push	ds
31FB:117E 07              	pop	es
31FB:117F 26 8B 47 09     	mov	ax,es:[bx+9h]
31FB:1183 8B 0E 2F B6     	mov	cx,[0B62Fh]
31FB:1187 8B 1E 2D B6     	mov	bx,[0B62Dh]
31FB:118B 03 D8           	add	bx,ax
31FB:118D 51              	push	cx
31FB:118E 53              	push	bx
31FB:118F 1E              	push	ds
31FB:1190 8B 46 E8        	mov	ax,[bp-18h]
31FB:1193 FF 46 E8        	inc	word ptr [bp-18h]
31FB:1196 BA 34 00        	mov	dx,34h
31FB:1199 F7 E2           	mul	dx
31FB:119B 05 50 59        	add	ax,5950h
31FB:119E 50              	push	ax
31FB:119F 9A 35 07 5F 37  	call	far 375Fh:0735h
31FB:11A4 83 C4 0E        	add	sp,0Eh

l31FB_11A7:
31FB:11A7 47              	inc	di

l31FB_11A8:
31FB:11A8 83 FF 0F        	cmp	di,0Fh
31FB:11AB 7D 07           	jge	11B4h

l31FB_11AD:
31FB:11AD 36 80 7B F0 00  	cmp	byte ptr ss:[bp+di-10h],0h
31FB:11B2 75 8D           	jnz	1141h

l31FB_11B4:
31FB:11B4 8B 46 E8        	mov	ax,[bp-18h]
31FB:11B7 89 46 EA        	mov	[bp-16h],ax
31FB:11BA 33 FF           	xor	di,di
31FB:11BC E9 B2 00        	jmp	1271h

l31FB_11BF:
31FB:11BF 8B C7           	mov	ax,di
31FB:11C1 BA 34 00        	mov	dx,34h
31FB:11C4 F7 E2           	mul	dx
31FB:11C6 8B D8           	mov	bx,ax
31FB:11C8 81 C3 50 59     	add	bx,5950h
31FB:11CC 1E              	push	ds
31FB:11CD 07              	pop	es
31FB:11CE 8C 06 10 B6     	mov	[0B610h],es
31FB:11D2 89 1E 0E B6     	mov	[0B60Eh],bx
31FB:11D6 80 3E 65 86 00  	cmp	byte ptr [8665h],0h
31FB:11DB 75 1E           	jnz	11FBh

l31FB_11DD:
31FB:11DD C4 1E 0E B6     	les	bx,[0B60Eh]
31FB:11E1 26 FF 77 10     	push	word ptr es:[bx+10h]
31FB:11E5 C4 1E 0E B6     	les	bx,[0B60Eh]
31FB:11E9 26 FF 77 0E     	push	word ptr es:[bx+0Eh]
31FB:11ED 26 FF 77 0C     	push	word ptr es:[bx+0Ch]
31FB:11F1 9A 7E 00 17 37  	call	far 3717h:007Eh
31FB:11F6 83 C4 06        	add	sp,6h
31FB:11F9 EB 75           	jmp	1270h

l31FB_11FB:
31FB:11FB B8 33 66        	mov	ax,6633h
31FB:11FE 50              	push	ax
31FB:11FF FF 36 10 B6     	push	word ptr [0B610h]
31FB:1203 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:1207 9A 8E 07 5F 37  	call	far 375Fh:078Eh
31FB:120C 83 C4 06        	add	sp,6h
31FB:120F FF 36 10 B6     	push	word ptr [0B610h]
31FB:1213 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:1217 9A 17 09 5F 37  	call	far 375Fh:0917h
31FB:121C 59              	pop	cx
31FB:121D 59              	pop	cx
31FB:121E 1E              	push	ds
31FB:121F B8 14 B6        	mov	ax,0B614h
31FB:1222 50              	push	ax
31FB:1223 FF 36 10 B6     	push	word ptr [0B610h]
31FB:1227 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:122B 9A 52 08 5F 37  	call	far 375Fh:0852h
31FB:1230 83 C4 08        	add	sp,8h
31FB:1233 1E              	push	ds
31FB:1234 B8 14 B6        	mov	ax,0B614h
31FB:1237 50              	push	ax
31FB:1238 A0 65 86        	mov	al,[8665h]
31FB:123B 98              	cbw
31FB:123C 8B D8           	mov	bx,ax
31FB:123E D1 E3           	shl	bx,1h
31FB:1240 FF B7 3E 59     	push	word ptr [bx+593Eh]
31FB:1244 9A FA 06 5F 37  	call	far 375Fh:06FAh
31FB:1249 83 C4 06        	add	sp,6h
31FB:124C EB 00           	jmp	124Eh

l31FB_124E:
31FB:124E FF 36 10 B6     	push	word ptr [0B610h]
31FB:1252 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:1256 9A 99 09 5F 37  	call	far 375Fh:0999h
31FB:125B 59              	pop	cx
31FB:125C 59              	pop	cx
31FB:125D 0B C0           	or	ax,ax
31FB:125F 7F ED           	jg	124Eh

l31FB_1261:
31FB:1261 FF 36 10 B6     	push	word ptr [0B610h]
31FB:1265 FF 36 0E B6     	push	word ptr [0B60Eh]
31FB:1269 9A B9 08 5F 37  	call	far 375Fh:08B9h
31FB:126E 59              	pop	cx
31FB:126F 59              	pop	cx

l31FB_1270:
31FB:1270 47              	inc	di

l31FB_1271:
31FB:1271 3B 7E EA        	cmp	di,[bp-16h]
31FB:1274 7D 03           	jge	1279h

l31FB_1276:
31FB:1276 E9 46 FF        	jmp	11BFh

l31FB_1279:
31FB:1279 80 3E 65 86 01  	cmp	byte ptr [8665h],1h
31FB:127E 7C 1C           	jl	129Ch

l31FB_1280:
31FB:1280 A0 65 86        	mov	al,[8665h]
31FB:1283 98              	cbw
31FB:1284 8B D8           	mov	bx,ax
31FB:1286 D1 E3           	shl	bx,1h
31FB:1288 FF B7 3E 59     	push	word ptr [bx+593Eh]
31FB:128C 9A D9 02 5F 37  	call	far 375Fh:02D9h
31FB:1291 59              	pop	cx
31FB:1292 9A A9 06 5F 37  	call	far 375Fh:06A9h
31FB:1297 9A D9 02 B2 30  	call	far 30B2h:02D9h

l31FB_129C:
31FB:129C C6 06 15 80 00  	mov	byte ptr [8015h],0h

l31FB_12A1:
31FB:12A1 5F              	pop	di
31FB:12A2 5E              	pop	si
31FB:12A3 8B E5           	mov	sp,bp
31FB:12A5 5D              	pop	bp
31FB:12A6 CB              	retf

;; ReleaseDigitalWeaponEffectBank_12A7: 31FB:12A7
;;   Called from:
;;     0D73:0304 (in InitializeTacticalScenario_0214)
ReleaseDigitalWeaponEffectBank_12A7 proc
31FB:12A7 FF 36 2B B6     	push	word ptr [0B62Bh]
31FB:12AB FF 36 29 B6     	push	word ptr [0B629h]
31FB:12AF 9A 81 01 56 0D  	call	far 0D56h:0181h
31FB:12B4 59              	pop	cx
31FB:12B5 59              	pop	cx
31FB:12B6 CB              	retf

;; ReleaseDigitalSoundBuffer_12B7: 31FB:12B7
;;   Called from:
;;     0D73:02FF (in InitializeTacticalScenario_0214)
;;     0D73:30C1 (in RunTitleAndMainMenu_309C)
;;     0D73:30F1 (in RunTitleAndMainMenu_309C)
ReleaseDigitalSoundBuffer_12B7 proc
31FB:12B7 FF 36 2F B6     	push	word ptr [0B62Fh]
31FB:12BB FF 36 2D B6     	push	word ptr [0B62Dh]
31FB:12BF 9A 81 01 56 0D  	call	far 0D56h:0181h
