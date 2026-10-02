;;; Segment 35CE (35CE:0000)
35CE:0000 F6 75 05                                        .u.             

l35CA_0043:
35CA:0043 9A 7A 3B 00 08  	call	far 0800h:3B7Ah

l35CA_0048:
35CA:0048 5E              	pop	si
35CA:0049 CB              	retf

;; RenderFormattedText_000A: 35CE:000A
;;   Called from:
;;     0D73:2466 (in ShowConfirmationDialog_2448)
;;     0D73:2EE5 (in ShowScenarioMessage_2E7C)
;;     0D73:3B4D (in ShowMissionFollowupMessage_3AE4)
;;     0D73:3E04 (in UpdateTextEntryCursorBlink_3DA9)
;;     0D73:43CF (in EditTextField_4317)
;;     0D73:4501 (in EditTextField_4317)
;;     0D73:47D2 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:48A1 (in SaveGame_4866)
;;     0D73:4A36 (in SaveGame_4866)
;;     0D73:4EFB (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F07 (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F1D (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F29 (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F3E (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F50 (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F5E (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F6A (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F76 (in ShowSaveLoadMenu_4EC7)
;;     0D73:4F86 (in ShowSaveLoadMenu_4EC7)
;;     0D73:4FA8 (in ShowSaveLoadMenu_4EC7)
;;     0D73:4FBF (in ShowSaveLoadMenu_4EC7)
;;     0D73:4FCB (in ShowSaveLoadMenu_4EC7)
;;     0D73:5027 (in ShowSaveLoadMenu_4EC7)
;;     0D73:510A (in ShowSaveLoadMenu_4EC7)
;;     0D73:5293 (in RenameSaveSlot_5233)
;;     0D73:5343 (in RenameSaveSlot_5233)
;;     0D73:53F4 (in WaitForAcknowledgement_53E1)
;;     0D73:5428 (in WaitForAcknowledgement_53E1)
;;     0D73:5483 (in PromptYesNo_546F)
;;     0D73:549B (in PromptYesNo_546F)
;;     1A1F:421E (in RunGameOptionsMenu_417F)
;;     1A1F:425C (in RunGameOptionsMenu_417F)
;;     1A1F:4273 (in RunGameOptionsMenu_417F)
;;     1A1F:428A (in RunGameOptionsMenu_417F)
;;     1A1F:42A1 (in RunGameOptionsMenu_417F)
;;     1A1F:44A6 (in RenderPendingNarration_4447)
;;     1A1F:44D6 (in RenderPendingNarration_4447)
;;     1A1F:4633 (in RenderPendingNarration_4447)
;;     1A1F:466F (in RenderPendingNarration_4447)
;;     1A1F:4680 (in RenderPendingNarration_4447)
;;     2007:0F99 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:0FA7 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:0FDF (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:0FEB (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:1091 (in DrawSelectedUnitStatusPanel_0E19)
;;     2208:012A (in RunTacticalUnitCommandMenu_000B)
;;     2208:015B (in RunTacticalUnitCommandMenu_000B)
;;     2208:0177 (in RunTacticalUnitCommandMenu_000B)
;;     2208:018B (in RunTacticalUnitCommandMenu_000B)
;;     2208:01E0 (in RunTacticalUnitCommandMenu_000B)
;;     2208:0203 (in RunTacticalUnitCommandMenu_000B)
;;     2208:0211 (in RunTacticalUnitCommandMenu_000B)
;;     2208:0230 (in RunTacticalUnitCommandMenu_000B)
;;     2208:028A (in RunTacticalUnitCommandMenu_000B)
;;     2208:02BE (in RunTacticalUnitCommandMenu_000B)
;;     2208:02DD (in RunTacticalUnitCommandMenu_000B)
;;     2208:0303 (in RunTacticalUnitCommandMenu_000B)
;;     2208:1514 (in RunTacticalGameOptionsMenu_148A)
;;     2208:152A (in RunTacticalGameOptionsMenu_148A)
;;     2208:1548 (in RunTacticalGameOptionsMenu_148A)
;;     2208:1569 (in RunTacticalGameOptionsMenu_148A)
;;     2208:1587 (in RunTacticalGameOptionsMenu_148A)
;;     2208:15A8 (in RunTacticalGameOptionsMenu_148A)
;;     2208:15C6 (in RunTacticalGameOptionsMenu_148A)
;;     2B34:04BA (in RenderFormattedLineBreak_04B5)
;;     2B34:0C6D (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0C90 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0CB3 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0CD6 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0CF9 (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0D1C (in DrawTacticalUnitControlPanel_04C2)
;;     2B34:0FAD (in DrawTacticalUnitControlPanel_04C2)
RenderFormattedText_000A proc
35CE:000A 55              	push	bp
35CE:000B 8B EC           	mov	bp,sp
35CE:000D 81 EC B0 00     	sub	sp,0B0h
35CE:0011 56              	push	si
35CE:0012 57              	push	di
35CE:0013 C7 86 58 FF 01 00 	mov	word ptr [bp+0FF58h],1h
35CE:0019 33 C0           	xor	ax,ax
35CE:001B 89 86 56 FF     	mov	[bp+0FF56h],ax
35CE:001F 89 86 54 FF     	mov	[bp+0FF54h],ax
35CE:0023 B0 00           	mov	al,0h
35CE:0025 88 46 FF        	mov	[bp-1h],al
35CE:0028 98              	cbw
35CE:0029 8B F0           	mov	si,ax
35CE:002B 8B C6           	mov	ax,si
35CE:002D 89 86 50 FF     	mov	[bp+0FF50h],ax
35CE:0031 C6 86 5C FF 00  	mov	byte ptr [bp+0FF5Ch],0h
35CE:0036 8B 3E 3C 62     	mov	di,[623Ch]
35CE:003A E9 6C 04        	jmp	04A9h

l35CE_003D:
35CE:003D 83 BE 54 FF 00  	cmp	word ptr [bp+0FF54h],0h
35CE:0042 75 14           	jnz	0058h

l35CE_0044:
35CE:0044 C4 5E 06        	les	bx,[bp+6h]
35CE:0047 03 9E 50 FF     	add	bx,[bp+0FF50h]
35CE:004B 26 8A 07        	mov	al,es:[bx]
35CE:004E 88 86 5B FF     	mov	[bp+0FF5Bh],al
35CE:0052 FF 86 50 FF     	inc	word ptr [bp+0FF50h]
35CE:0056 EB 0D           	jmp	0065h

l35CE_0058:
35CE:0058 8A 46 FF        	mov	al,[bp-1h]
35CE:005B 88 86 5B FF     	mov	[bp+0FF5Bh],al
35CE:005F C7 86 54 FF 00 00 	mov	word ptr [bp+0FF54h],0h

l35CE_0065:
35CE:0065 F6 86 5B FF 80  	test	byte ptr [bp+0FF5Bh],80h
35CE:006A 74 4F           	jz	00BBh

l35CE_006C:
35CE:006C 8A 86 5B FF     	mov	al,[bp+0FF5Bh]
35CE:0070 24 07           	and	al,7h
35CE:0072 88 46 FF        	mov	[bp-1h],al
35CE:0075 8A 86 5B FF     	mov	al,[bp+0FF5Bh]
35CE:0079 98              	cbw
35CE:007A 25 7F 00        	and	ax,7Fh
35CE:007D D1 F8           	sar	ax,1h
35CE:007F D1 F8           	sar	ax,1h
35CE:0081 D1 F8           	sar	ax,1h
35CE:0083 88 86 5B FF     	mov	[bp+0FF5Bh],al
35CE:0087 8A 86 5B FF     	mov	al,[bp+0FF5Bh]
35CE:008B 98              	cbw
35CE:008C 8B D8           	mov	bx,ax
35CE:008E D1 E3           	shl	bx,1h
35CE:0090 D1 E3           	shl	bx,1h
35CE:0092 D1 E3           	shl	bx,1h
35CE:0094 81 C3 BA 05     	add	bx,5BAh
35CE:0098 1E              	push	ds
35CE:0099 07              	pop	es
35CE:009A 8A 46 FF        	mov	al,[bp-1h]
35CE:009D 98              	cbw
35CE:009E 03 D8           	add	bx,ax
35CE:00A0 26 8A 07        	mov	al,es:[bx]
35CE:00A3 88 46 FF        	mov	[bp-1h],al
35CE:00A6 8A 86 5B FF     	mov	al,[bp+0FF5Bh]
35CE:00AA 98              	cbw
35CE:00AB 8B D8           	mov	bx,ax
35CE:00AD 8A 87 AA 05     	mov	al,[bx+5AAh]
35CE:00B1 88 86 5B FF     	mov	[bp+0FF5Bh],al
35CE:00B5 C7 86 54 FF 01 00 	mov	word ptr [bp+0FF54h],1h

l35CE_00BB:
35CE:00BB 80 BE 5B FF 00  	cmp	byte ptr [bp+0FF5Bh],0h
35CE:00C0 75 09           	jnz	00CBh

l35CE_00C2:
35CE:00C2 C7 86 56 FF 01 00 	mov	word ptr [bp+0FF56h],1h
35CE:00C8 E9 DE 03        	jmp	04A9h

l35CE_00CB:
35CE:00CB 80 BE 5B FF 0D  	cmp	byte ptr [bp+0FF5Bh],0Dh
35CE:00D0 75 78           	jnz	014Ah

l35CE_00D2:
35CE:00D2 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:00D7 8B C6           	mov	ax,si
35CE:00D9 03 C7           	add	ax,di
35CE:00DB 50              	push	ax
35CE:00DC A0 66 86        	mov	al,[8666h]
35CE:00DF 98              	cbw
35CE:00E0 8B D0           	mov	dx,ax
35CE:00E2 58              	pop	ax
35CE:00E3 F7 E2           	mul	dx
35CE:00E5 8B 16 34 62     	mov	dx,[6234h]
35CE:00E9 D1 E2           	shl	dx,1h
35CE:00EB D1 E2           	shl	dx,1h
35CE:00ED D1 E2           	shl	dx,1h
35CE:00EF 3B C2           	cmp	ax,dx
35CE:00F1 7F 27           	jg	011Ah

l35CE_00F3:
35CE:00F3 16              	push	ss
35CE:00F4 8D 46 AE        	lea	ax,[bp-52h]
35CE:00F7 50              	push	ax
35CE:00F8 16              	push	ss
35CE:00F9 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:00FD 50              	push	ax
35CE:00FE 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:0103 83 C4 08        	add	sp,8h
35CE:0106 B8 01 00        	mov	ax,1h
35CE:0109 50              	push	ax
35CE:010A 16              	push	ss
35CE:010B 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:010F 50              	push	ax
35CE:0110 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0115 83 C4 06        	add	sp,6h
35CE:0118 EB 23           	jmp	013Dh

l35CE_011A:
35CE:011A B8 01 00        	mov	ax,1h
35CE:011D 50              	push	ax
35CE:011E 16              	push	ss
35CE:011F 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0123 50              	push	ax
35CE:0124 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0129 83 C4 06        	add	sp,6h
35CE:012C B8 01 00        	mov	ax,1h
35CE:012F 50              	push	ax
35CE:0130 16              	push	ss
35CE:0131 8D 46 AE        	lea	ax,[bp-52h]
35CE:0134 50              	push	ax
35CE:0135 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:013A 83 C4 06        	add	sp,6h

l35CE_013D:
35CE:013D 33 F6           	xor	si,si
35CE:013F 8B FE           	mov	di,si
35CE:0141 C7 86 58 FF 01 00 	mov	word ptr [bp+0FF58h],1h
35CE:0147 E9 5F 03        	jmp	04A9h

l35CE_014A:
35CE:014A 80 BE 5B FF 02  	cmp	byte ptr [bp+0FF5Bh],2h
35CE:014F 74 03           	jz	0154h

l35CE_0151:
35CE:0151 E9 84 00        	jmp	01D8h

l35CE_0154:
35CE:0154 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:0159 8B C6           	mov	ax,si
35CE:015B 03 C7           	add	ax,di
35CE:015D 50              	push	ax
35CE:015E A0 66 86        	mov	al,[8666h]
35CE:0161 98              	cbw
35CE:0162 8B D0           	mov	dx,ax
35CE:0164 58              	pop	ax
35CE:0165 F7 E2           	mul	dx
35CE:0167 8B 16 34 62     	mov	dx,[6234h]
35CE:016B D1 E2           	shl	dx,1h
35CE:016D D1 E2           	shl	dx,1h
35CE:016F D1 E2           	shl	dx,1h
35CE:0171 3B C2           	cmp	ax,dx
35CE:0173 7F 26           	jg	019Bh

l35CE_0175:
35CE:0175 16              	push	ss
35CE:0176 8D 46 AE        	lea	ax,[bp-52h]
35CE:0179 50              	push	ax
35CE:017A 16              	push	ss
35CE:017B 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:017F 50              	push	ax
35CE:0180 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:0185 83 C4 08        	add	sp,8h
35CE:0188 33 C0           	xor	ax,ax
35CE:018A 50              	push	ax
35CE:018B 16              	push	ss
35CE:018C 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0190 50              	push	ax
35CE:0191 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0196 83 C4 06        	add	sp,6h
35CE:0199 EB 22           	jmp	01BDh

l35CE_019B:
35CE:019B B8 01 00        	mov	ax,1h
35CE:019E 50              	push	ax
35CE:019F 16              	push	ss
35CE:01A0 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:01A4 50              	push	ax
35CE:01A5 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:01AA 83 C4 06        	add	sp,6h
35CE:01AD 33 C0           	xor	ax,ax
35CE:01AF 50              	push	ax
35CE:01B0 16              	push	ss
35CE:01B1 8D 46 AE        	lea	ax,[bp-52h]
35CE:01B4 50              	push	ax
35CE:01B5 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:01BA 83 C4 06        	add	sp,6h

l35CE_01BD:
35CE:01BD 33 F6           	xor	si,si
35CE:01BF 8B 3E 3C 62     	mov	di,[623Ch]
35CE:01C3 C4 5E 06        	les	bx,[bp+6h]
35CE:01C6 03 9E 50 FF     	add	bx,[bp+0FF50h]
35CE:01CA 26 8A 07        	mov	al,es:[bx]
35CE:01CD 98              	cbw
35CE:01CE A3 3A 62        	mov	[623Ah],ax
35CE:01D1 FF 86 50 FF     	inc	word ptr [bp+0FF50h]
35CE:01D5 E9 D1 02        	jmp	04A9h

l35CE_01D8:
35CE:01D8 80 BE 5B FF 06  	cmp	byte ptr [bp+0FF5Bh],6h
35CE:01DD 74 03           	jz	01E2h

l35CE_01DF:
35CE:01DF E9 84 00        	jmp	0266h

l35CE_01E2:
35CE:01E2 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:01E7 8B C6           	mov	ax,si
35CE:01E9 03 C7           	add	ax,di
35CE:01EB 50              	push	ax
35CE:01EC A0 66 86        	mov	al,[8666h]
35CE:01EF 98              	cbw
35CE:01F0 8B D0           	mov	dx,ax
35CE:01F2 58              	pop	ax
35CE:01F3 F7 E2           	mul	dx
35CE:01F5 8B 16 34 62     	mov	dx,[6234h]
35CE:01F9 D1 E2           	shl	dx,1h
35CE:01FB D1 E2           	shl	dx,1h
35CE:01FD D1 E2           	shl	dx,1h
35CE:01FF 3B C2           	cmp	ax,dx
35CE:0201 7F 26           	jg	0229h

l35CE_0203:
35CE:0203 16              	push	ss
35CE:0204 8D 46 AE        	lea	ax,[bp-52h]
35CE:0207 50              	push	ax
35CE:0208 16              	push	ss
35CE:0209 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:020D 50              	push	ax
35CE:020E 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:0213 83 C4 08        	add	sp,8h
35CE:0216 33 C0           	xor	ax,ax
35CE:0218 50              	push	ax
35CE:0219 16              	push	ss
35CE:021A 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:021E 50              	push	ax
35CE:021F 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0224 83 C4 06        	add	sp,6h
35CE:0227 EB 22           	jmp	024Bh

l35CE_0229:
35CE:0229 B8 01 00        	mov	ax,1h
35CE:022C 50              	push	ax
35CE:022D 16              	push	ss
35CE:022E 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0232 50              	push	ax
35CE:0233 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0238 83 C4 06        	add	sp,6h
35CE:023B 33 C0           	xor	ax,ax
35CE:023D 50              	push	ax
35CE:023E 16              	push	ss
35CE:023F 8D 46 AE        	lea	ax,[bp-52h]
35CE:0242 50              	push	ax
35CE:0243 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0248 83 C4 06        	add	sp,6h

l35CE_024B:
35CE:024B 33 F6           	xor	si,si
35CE:024D 8B 3E 3C 62     	mov	di,[623Ch]
35CE:0251 C4 5E 06        	les	bx,[bp+6h]
35CE:0254 03 9E 50 FF     	add	bx,[bp+0FF50h]
35CE:0258 26 8A 07        	mov	al,es:[bx]
35CE:025B 98              	cbw
35CE:025C A3 38 62        	mov	[6238h],ax
35CE:025F FF 86 50 FF     	inc	word ptr [bp+0FF50h]
35CE:0263 E9 43 02        	jmp	04A9h

l35CE_0266:
35CE:0266 80 BE 5B FF 09  	cmp	byte ptr [bp+0FF5Bh],9h
35CE:026B 74 03           	jz	0270h

l35CE_026D:
35CE:026D E9 A6 00        	jmp	0316h

l35CE_0270:
35CE:0270 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:0275 8B C6           	mov	ax,si
35CE:0277 03 C7           	add	ax,di
35CE:0279 50              	push	ax
35CE:027A A0 66 86        	mov	al,[8666h]
35CE:027D 98              	cbw
35CE:027E 8B D0           	mov	dx,ax
35CE:0280 58              	pop	ax
35CE:0281 F7 E2           	mul	dx
35CE:0283 8B 16 34 62     	mov	dx,[6234h]
35CE:0287 D1 E2           	shl	dx,1h
35CE:0289 D1 E2           	shl	dx,1h
35CE:028B D1 E2           	shl	dx,1h
35CE:028D 3B C2           	cmp	ax,dx
35CE:028F 7F 26           	jg	02B7h

l35CE_0291:
35CE:0291 16              	push	ss
35CE:0292 8D 46 AE        	lea	ax,[bp-52h]
35CE:0295 50              	push	ax
35CE:0296 16              	push	ss
35CE:0297 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:029B 50              	push	ax
35CE:029C 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:02A1 83 C4 08        	add	sp,8h
35CE:02A4 33 C0           	xor	ax,ax
35CE:02A6 50              	push	ax
35CE:02A7 16              	push	ss
35CE:02A8 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:02AC 50              	push	ax
35CE:02AD 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:02B2 83 C4 06        	add	sp,6h
35CE:02B5 EB 22           	jmp	02D9h

l35CE_02B7:
35CE:02B7 B8 01 00        	mov	ax,1h
35CE:02BA 50              	push	ax
35CE:02BB 16              	push	ss
35CE:02BC 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:02C0 50              	push	ax
35CE:02C1 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:02C6 83 C4 06        	add	sp,6h
35CE:02C9 33 C0           	xor	ax,ax
35CE:02CB 50              	push	ax
35CE:02CC 16              	push	ss
35CE:02CD 8D 46 AE        	lea	ax,[bp-52h]
35CE:02D0 50              	push	ax
35CE:02D1 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:02D6 83 C4 06        	add	sp,6h

l35CE_02D9:
35CE:02D9 33 F6           	xor	si,si
35CE:02DB C4 5E 06        	les	bx,[bp+6h]
35CE:02DE 03 9E 50 FF     	add	bx,[bp+0FF50h]
35CE:02E2 26 8A 07        	mov	al,es:[bx]
35CE:02E5 98              	cbw
35CE:02E6 8B F8           	mov	di,ax
35CE:02E8 8B C7           	mov	ax,di
35CE:02EA A3 3C 62        	mov	[623Ch],ax
35CE:02ED FF 86 50 FF     	inc	word ptr [bp+0FF50h]
35CE:02F1 A1 3C 62        	mov	ax,[623Ch]
35CE:02F4 40              	inc	ax
35CE:02F5 50              	push	ax
35CE:02F6 A0 66 86        	mov	al,[8666h]
35CE:02F9 98              	cbw
35CE:02FA 8B D0           	mov	dx,ax
35CE:02FC 58              	pop	ax
35CE:02FD F7 E2           	mul	dx
35CE:02FF 8B 16 34 62     	mov	dx,[6234h]
35CE:0303 D1 E2           	shl	dx,1h
35CE:0305 D1 E2           	shl	dx,1h
35CE:0307 D1 E2           	shl	dx,1h
35CE:0309 3B C2           	cmp	ax,dx
35CE:030B 7C 06           	jl	0313h

l35CE_030D:
35CE:030D 33 FF           	xor	di,di
35CE:030F 89 3E 3C 62     	mov	[623Ch],di

l35CE_0313:
35CE:0313 E9 93 01        	jmp	04A9h

l35CE_0316:
35CE:0316 80 BE 5B FF 13  	cmp	byte ptr [bp+0FF5Bh],13h
35CE:031B 75 50           	jnz	036Dh

l35CE_031D:
35CE:031D C4 5E 06        	les	bx,[bp+6h]
35CE:0320 03 9E 50 FF     	add	bx,[bp+0FF50h]
35CE:0324 26 8A 07        	mov	al,es:[bx]
35CE:0327 98              	cbw
35CE:0328 89 86 52 FF     	mov	[bp+0FF52h],ax
35CE:032C FF 86 50 FF     	inc	word ptr [bp+0FF50h]
35CE:0330 A1 3C 62        	mov	ax,[623Ch]
35CE:0333 3B 86 52 FF     	cmp	ax,[bp+0FF52h]
35CE:0337 7D 31           	jge	036Ah

l35CE_0339:
35CE:0339 EB 0A           	jmp	0345h

l35CE_033B:
35CE:033B 36 C6 42 AE 20  	mov	byte ptr ss:[bp+si-52h],20h
35CE:0340 46              	inc	si
35CE:0341 FF 8E 52 FF     	dec	word ptr [bp+0FF52h]

l35CE_0345:
35CE:0345 A1 3C 62        	mov	ax,[623Ch]
35CE:0348 3B 86 52 FF     	cmp	ax,[bp+0FF52h]
35CE:034C 7C ED           	jl	033Bh

l35CE_034E:
35CE:034E 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:0353 16              	push	ss
35CE:0354 8D 46 AE        	lea	ax,[bp-52h]
35CE:0357 50              	push	ax
35CE:0358 16              	push	ss
35CE:0359 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:035D 50              	push	ax
35CE:035E 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:0363 83 C4 08        	add	sp,8h
35CE:0366 03 FE           	add	di,si
35CE:0368 33 F6           	xor	si,si

l35CE_036A:
35CE:036A E9 3C 01        	jmp	04A9h

l35CE_036D:
35CE:036D 80 BE 5B FF 20  	cmp	byte ptr [bp+0FF5Bh],20h
35CE:0372 74 03           	jz	0377h

l35CE_0374:
35CE:0374 E9 C3 00        	jmp	043Ah

l35CE_0377:
35CE:0377 8B C6           	mov	ax,si
35CE:0379 03 C7           	add	ax,di
35CE:037B 50              	push	ax
35CE:037C A0 66 86        	mov	al,[8666h]
35CE:037F 98              	cbw
35CE:0380 8B D0           	mov	dx,ax
35CE:0382 58              	pop	ax
35CE:0383 F7 E2           	mul	dx
35CE:0385 8B 16 34 62     	mov	dx,[6234h]
35CE:0389 D1 E2           	shl	dx,1h
35CE:038B D1 E2           	shl	dx,1h
35CE:038D D1 E2           	shl	dx,1h
35CE:038F 3B C2           	cmp	ax,dx
35CE:0391 7F 4A           	jg	03DDh

l35CE_0393:
35CE:0393 8B C6           	mov	ax,si
35CE:0395 03 C7           	add	ax,di
35CE:0397 40              	inc	ax
35CE:0398 50              	push	ax
35CE:0399 A0 66 86        	mov	al,[8666h]
35CE:039C 98              	cbw
35CE:039D 8B D0           	mov	dx,ax
35CE:039F 58              	pop	ax
35CE:03A0 F7 E2           	mul	dx
35CE:03A2 8B 16 34 62     	mov	dx,[6234h]
35CE:03A6 D1 E2           	shl	dx,1h
35CE:03A8 D1 E2           	shl	dx,1h
35CE:03AA D1 E2           	shl	dx,1h
35CE:03AC 3B C2           	cmp	ax,dx
35CE:03AE 7F 13           	jg	03C3h

l35CE_03B0:
35CE:03B0 8B C6           	mov	ax,si
35CE:03B2 03 C7           	add	ax,di
35CE:03B4 75 07           	jnz	03BDh

l35CE_03B6:
35CE:03B6 83 BE 58 FF 00  	cmp	word ptr [bp+0FF58h],0h
35CE:03BB 74 06           	jz	03C3h

l35CE_03BD:
35CE:03BD 36 C6 42 AE 20  	mov	byte ptr ss:[bp+si-52h],20h
35CE:03C2 46              	inc	si

l35CE_03C3:
35CE:03C3 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:03C8 16              	push	ss
35CE:03C9 8D 46 AE        	lea	ax,[bp-52h]
35CE:03CC 50              	push	ax
35CE:03CD 16              	push	ss
35CE:03CE 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:03D2 50              	push	ax
35CE:03D3 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:03D8 83 C4 08        	add	sp,8h
35CE:03DB EB 51           	jmp	042Eh

l35CE_03DD:
35CE:03DD 8B C6           	mov	ax,si
35CE:03DF 40              	inc	ax
35CE:03E0 50              	push	ax
35CE:03E1 A0 66 86        	mov	al,[8666h]
35CE:03E4 98              	cbw
35CE:03E5 8B D0           	mov	dx,ax
35CE:03E7 58              	pop	ax
35CE:03E8 F7 E2           	mul	dx
35CE:03EA 8B 16 34 62     	mov	dx,[6234h]
35CE:03EE D1 E2           	shl	dx,1h
35CE:03F0 D1 E2           	shl	dx,1h
35CE:03F2 D1 E2           	shl	dx,1h
35CE:03F4 3B C2           	cmp	ax,dx
35CE:03F6 7F 0A           	jg	0402h

l35CE_03F8:
35CE:03F8 0B F6           	or	si,si
35CE:03FA 74 06           	jz	0402h

l35CE_03FC:
35CE:03FC 36 C6 42 AE 20  	mov	byte ptr ss:[bp+si-52h],20h
35CE:0401 46              	inc	si

l35CE_0402:
35CE:0402 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:0407 B8 01 00        	mov	ax,1h
35CE:040A 50              	push	ax
35CE:040B 16              	push	ss
35CE:040C 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0410 50              	push	ax
35CE:0411 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0416 83 C4 06        	add	sp,6h
35CE:0419 33 FF           	xor	di,di
35CE:041B 16              	push	ss
35CE:041C 8D 46 AE        	lea	ax,[bp-52h]
35CE:041F 50              	push	ax
35CE:0420 16              	push	ss
35CE:0421 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0425 50              	push	ax
35CE:0426 9A 00 00 83 39  	call	far 3983h:0000h
35CE:042B 83 C4 08        	add	sp,8h

l35CE_042E:
35CE:042E 03 FE           	add	di,si
35CE:0430 33 F6           	xor	si,si
35CE:0432 C7 86 58 FF 00 00 	mov	word ptr [bp+0FF58h],0h
35CE:0438 EB 6F           	jmp	04A9h

l35CE_043A:
35CE:043A A0 66 86        	mov	al,[8666h]
35CE:043D 98              	cbw
35CE:043E F7 E6           	mul	si
35CE:0440 8B 16 34 62     	mov	dx,[6234h]
35CE:0444 D1 E2           	shl	dx,1h
35CE:0446 D1 E2           	shl	dx,1h
35CE:0448 D1 E2           	shl	dx,1h
35CE:044A 3B C2           	cmp	ax,dx
35CE:044C 7C 52           	jl	04A0h

l35CE_044E:
35CE:044E 80 BE 5C FF 00  	cmp	byte ptr [bp+0FF5Ch],0h
35CE:0453 74 12           	jz	0467h

l35CE_0455:
35CE:0455 B8 01 00        	mov	ax,1h
35CE:0458 50              	push	ax
35CE:0459 16              	push	ss
35CE:045A 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:045E 50              	push	ax
35CE:045F 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0464 83 C4 06        	add	sp,6h

l35CE_0467:
35CE:0467 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:046C 16              	push	ss
35CE:046D 8D 46 AE        	lea	ax,[bp-52h]
35CE:0470 50              	push	ax
35CE:0471 16              	push	ss
35CE:0472 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0476 50              	push	ax
35CE:0477 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:047C 83 C4 08        	add	sp,8h
35CE:047F B8 01 00        	mov	ax,1h
35CE:0482 50              	push	ax
35CE:0483 16              	push	ss
35CE:0484 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0488 50              	push	ax
35CE:0489 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:048E 83 C4 06        	add	sp,6h
35CE:0491 33 F6           	xor	si,si
35CE:0493 8B FE           	mov	di,si
35CE:0495 8A 86 5B FF     	mov	al,[bp+0FF5Bh]
35CE:0499 36 88 42 AE     	mov	ss:[bp+si-52h],al
35CE:049D 46              	inc	si
35CE:049E EB 09           	jmp	04A9h

l35CE_04A0:
35CE:04A0 8A 86 5B FF     	mov	al,[bp+0FF5Bh]
35CE:04A4 36 88 42 AE     	mov	ss:[bp+si-52h],al
35CE:04A8 46              	inc	si

l35CE_04A9:
35CE:04A9 83 BE 56 FF 00  	cmp	word ptr [bp+0FF56h],0h
35CE:04AE 75 03           	jnz	04B3h

l35CE_04B0:
35CE:04B0 E9 8A FB        	jmp	003Dh

l35CE_04B3:
35CE:04B3 0B F6           	or	si,si
35CE:04B5 75 07           	jnz	04BEh

l35CE_04B7:
35CE:04B7 80 BE 5C FF 00  	cmp	byte ptr [bp+0FF5Ch],0h
35CE:04BC 74 72           	jz	0530h

l35CE_04BE:
35CE:04BE 36 C6 42 AE 00  	mov	byte ptr ss:[bp+si-52h],0h
35CE:04C3 A1 34 62        	mov	ax,[6234h]
35CE:04C6 D1 E0           	shl	ax,1h
35CE:04C8 D1 E0           	shl	ax,1h
35CE:04CA D1 E0           	shl	ax,1h
35CE:04CC 50              	push	ax
35CE:04CD A0 66 86        	mov	al,[8666h]
35CE:04D0 98              	cbw
35CE:04D1 5A              	pop	dx
35CE:04D2 2B D0           	sub	dx,ax
35CE:04D4 8B C6           	mov	ax,si
35CE:04D6 03 C7           	add	ax,di
35CE:04D8 52              	push	dx
35CE:04D9 50              	push	ax
35CE:04DA A0 66 86        	mov	al,[8666h]
35CE:04DD 98              	cbw
35CE:04DE 8B D0           	mov	dx,ax
35CE:04E0 58              	pop	ax
35CE:04E1 F7 E2           	mul	dx
35CE:04E3 5A              	pop	dx
35CE:04E4 3B D0           	cmp	dx,ax
35CE:04E6 7C 26           	jl	050Eh

l35CE_04E8:
35CE:04E8 16              	push	ss
35CE:04E9 8D 46 AE        	lea	ax,[bp-52h]
35CE:04EC 50              	push	ax
35CE:04ED 16              	push	ss
35CE:04EE 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:04F2 50              	push	ax
35CE:04F3 9A 01 00 7A 39  	call	far 397Ah:0001h
35CE:04F8 83 C4 08        	add	sp,8h
35CE:04FB 33 C0           	xor	ax,ax
35CE:04FD 50              	push	ax
35CE:04FE 16              	push	ss
35CE:04FF 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0503 50              	push	ax
35CE:0504 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:0509 83 C4 06        	add	sp,6h
35CE:050C EB 22           	jmp	0530h

l35CE_050E:
35CE:050E B8 01 00        	mov	ax,1h
35CE:0511 50              	push	ax
35CE:0512 16              	push	ss
35CE:0513 8D 86 5C FF     	lea	ax,[bp+0FF5Ch]
35CE:0517 50              	push	ax
35CE:0518 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:051D 83 C4 06        	add	sp,6h
35CE:0520 33 C0           	xor	ax,ax
35CE:0522 50              	push	ax
35CE:0523 16              	push	ss
35CE:0524 8D 46 AE        	lea	ax,[bp-52h]
35CE:0527 50              	push	ax
35CE:0528 9A 0B 00 6F 35  	call	far 356Fh:000Bh
35CE:052D 83 C4 06        	add	sp,6h
