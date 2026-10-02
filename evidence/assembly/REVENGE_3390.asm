;;; Segment 3390 (3390:0000)
3390:0000 5D CB                                           ].              

;; AbortRuntimeWithMessage: 3390:0002
;;   Called from:
;;     3390:025F (in CloseTrackedFile)
;;     3390:02AB (in ReadTrackedFile)
;;     3390:0391 (in WriteTrackedFile)
;;     3390:03AB (in WriteTrackedFile)
;;     3390:0460 (in SeekTrackedFile)
;;     3390:05A7 (in SeekTrackedFile)
;;     3390:05F5 (in SeekTrackedFile)
;;     3390:0715 (in GetResourceDriveMask)
;;     3390:0A14 (in ReleaseCachedResources)
;;     3390:0CEE (in FindResourceDescriptorIndex)
AbortRuntimeWithMessage proc
3390:0002 55              	push	bp
3390:0003 8B EC           	mov	bp,sp
3390:0005 C4 5E 06        	les	bx,[bp+6h]
3390:0008 8C 06 34 B6     	mov	[0B634h],es
3390:000C 89 1E 32 B6     	mov	[0B632h],bx
3390:0010 FF 1E BE 5F     	call	dword ptr [5FBEh]
3390:0014 FF 1E C2 5F     	call	dword ptr [5FC2h]
3390:0018 B8 01 00        	mov	ax,1h
3390:001B 50              	push	ax
3390:001C 9A 24 00 90 33  	call	far 3390h:0024h
3390:0021 59              	pop	cx
3390:0022 5D              	pop	bp
3390:0023 CB              	retf

;; ShutdownAndExit: 3390:0024
;;   Called from:
;;     3390:001C (in AbortRuntimeWithMessage)
;;     3390:0109 (in OpenTrackedFile)
;;     3390:0133 (in OpenTrackedFile)
;;     3390:01BE (in OpenTrackedFile)
ShutdownAndExit proc
3390:0024 55              	push	bp
3390:0025 8B EC           	mov	bp,sp
3390:0027 9A E3 02 7F 2C  	call	far 2C7Fh:02E3h
3390:002C FF 76 06        	push	word ptr [bp+6h]
3390:002F 9A 10 00 C6 38  	call	far 38C6h:0010h
3390:0034 59              	pop	cx
3390:0035 5D              	pop	bp
3390:0036 CB              	retf

;; OpenTrackedFile: 3390:0037
;;   Called from:
;;     0D73:45F6 (in EnsureCompatibleSaveFile_4572)
;;     0D73:4AA1 (in WriteSaveSlot_4A7E)
;;     0D73:4DB2 (in ReadSaveSlot_4D8F)
;;     1A1F:0420 (in LoadTacticalIconSetResources_03D4)
;;     1A1F:054E (in LoadTacticalMap_051B)
;;     1A1F:10E0 (in LoadUnitTemplateRecord_10CD)
;;     21E7:001A (in ReadWholeResourceFile_000C)
;;     21E7:0052 (in ReadResourceFileSpan_0044)
;;     21E7:009F (in LoadAndDecodePackedResource_008E)
;;     34B3:0019 (in LoadPackedIconResource_0008)
OpenTrackedFile proc
3390:0037 55              	push	bp
3390:0038 8B EC           	mov	bp,sp
3390:003A 83 EC 04        	sub	sp,4h
3390:003D 56              	push	si
3390:003E 57              	push	di
3390:003F 8B 46 0A        	mov	ax,[bp+0Ah]
3390:0042 3D 01 00        	cmp	ax,1h
3390:0045 74 0D           	jz	0054h

l3390_0047:
3390:0047 3D 02 00        	cmp	ax,2h
3390:004A 74 53           	jz	009Fh

l3390_004C:
3390:004C 3D 03 00        	cmp	ax,3h
3390:004F 74 60           	jz	00B1h

l3390_0051:
3390:0051 E9 C7 00        	jmp	011Bh

l3390_0054:
3390:0054 FF 76 08        	push	word ptr [bp+8h]
3390:0057 FF 76 06        	push	word ptr [bp+6h]
3390:005A 9A FF 0B 90 33  	call	far 3390h:0BFFh
3390:005F 59              	pop	cx
3390:0060 59              	pop	cx
3390:0061 0B C0           	or	ax,ax
3390:0063 75 32           	jnz	0097h

l3390_0065:
3390:0065 FF 76 08        	push	word ptr [bp+8h]
3390:0068 FF 76 06        	push	word ptr [bp+6h]
3390:006B 9A 1F 06 90 33  	call	far 3390h:061Fh
3390:0070 59              	pop	cx
3390:0071 59              	pop	cx
3390:0072 0B C0           	or	ax,ax
3390:0074 75 21           	jnz	0097h

l3390_0076:
3390:0076 FF 76 08        	push	word ptr [bp+8h]
3390:0079 FF 76 06        	push	word ptr [bp+6h]
3390:007C 9A 9C 06 90 33  	call	far 3390h:069Ch
3390:0081 59              	pop	cx
3390:0082 59              	pop	cx
3390:0083 A3 36 B6        	mov	[0B636h],ax
3390:0086 83 3E 38 B6 00  	cmp	word ptr [0B638h],0h
3390:008B 74 0A           	jz	0097h

l3390_008D:
3390:008D FF 36 36 B6     	push	word ptr [0B636h]
3390:0091 9A 08 00 93 35  	call	far 3593h:0008h
3390:0096 59              	pop	cx

l3390_0097:
3390:0097 C7 46 FC 01 80  	mov	word ptr [bp-4h],8001h
3390:009C E9 9B 00        	jmp	013Ah

l3390_009F:
3390:009F C7 46 FC 02 80  	mov	word ptr [bp-4h],8002h
3390:00A4 FF 76 08        	push	word ptr [bp+8h]
3390:00A7 FF 76 06        	push	word ptr [bp+6h]
3390:00AA 9A 4F 06 90 33  	call	far 3390h:064Fh
3390:00AF 59              	pop	cx
3390:00B0 59              	pop	cx

l3390_00B1:
3390:00B1 8B 3E C6 5F     	mov	di,[5FC6h]
3390:00B5 FF 76 08        	push	word ptr [bp+8h]
3390:00B8 FF 76 06        	push	word ptr [bp+6h]
3390:00BB 9A 1F 06 90 33  	call	far 3390h:061Fh
3390:00C0 59              	pop	cx
3390:00C1 59              	pop	cx
3390:00C2 0B C0           	or	ax,ax
3390:00C4 75 48           	jnz	010Eh

l3390_00C6:
3390:00C6 EB 10           	jmp	00D8h

l3390_00C8:
3390:00C8 C4 1E 82 5F     	les	bx,[5F82h]
3390:00CC 8C 06 34 B6     	mov	[0B634h],es
3390:00D0 89 1E 32 B6     	mov	[0B632h],bx
3390:00D4 FF 1E BE 5F     	call	dword ptr [5FBEh]

l3390_00D8:
3390:00D8 FF 76 08        	push	word ptr [bp+8h]
3390:00DB FF 76 06        	push	word ptr [bp+6h]
3390:00DE 9A 68 06 90 33  	call	far 3390h:0668h
3390:00E3 59              	pop	cx
3390:00E4 59              	pop	cx
3390:00E5 0B C0           	or	ax,ax
3390:00E7 75 07           	jnz	00F0h

l3390_00E9:
3390:00E9 8B C7           	mov	ax,di
3390:00EB 4F              	dec	di
3390:00EC 0B C0           	or	ax,ax
3390:00EE 75 D8           	jnz	00C8h

l3390_00F0:
3390:00F0 FF 76 08        	push	word ptr [bp+8h]
3390:00F3 FF 76 06        	push	word ptr [bp+6h]
3390:00F6 9A 1F 06 90 33  	call	far 3390h:061Fh
3390:00FB 59              	pop	cx
3390:00FC 59              	pop	cx
3390:00FD 0B C0           	or	ax,ax
3390:00FF 75 0D           	jnz	010Eh

l3390_0101:
3390:0101 FF 1E C2 5F     	call	dword ptr [5FC2h]
3390:0105 B8 01 00        	mov	ax,1h
3390:0108 50              	push	ax
3390:0109 0E              	push	cs
3390:010A E8 17 FF        	call	0024h
3390:010D 59              	pop	cx

l3390_010E:
3390:010E 83 7E 0A 03     	cmp	word ptr [bp+0Ah],3h
3390:0112 75 05           	jnz	0119h

l3390_0114:
3390:0114 C7 46 FC 04 80  	mov	word ptr [bp-4h],8004h

l3390_0119:
3390:0119 EB 1F           	jmp	013Ah

l3390_011B:
3390:011B C4 1E 86 5F     	les	bx,[5F86h]
3390:011F 8C 06 34 B6     	mov	[0B634h],es
3390:0123 89 1E 32 B6     	mov	[0B632h],bx
3390:0127 FF 1E BE 5F     	call	dword ptr [5FBEh]
3390:012B FF 1E C2 5F     	call	dword ptr [5FC2h]
3390:012F B8 01 00        	mov	ax,1h
3390:0132 50              	push	ax
3390:0133 0E              	push	cs
3390:0134 E8 ED FE        	call	0024h
3390:0137 59              	pop	cx
3390:0138 EB 00           	jmp	013Ah

l3390_013A:
3390:013A FF 76 08        	push	word ptr [bp+8h]
3390:013D FF 76 06        	push	word ptr [bp+6h]
3390:0140 9A FF 0B 90 33  	call	far 3390h:0BFFh
3390:0145 59              	pop	cx
3390:0146 59              	pop	cx
3390:0147 0B C0           	or	ax,ax
3390:0149 74 03           	jz	014Eh

l3390_014B:
3390:014B E9 77 00        	jmp	01C5h

l3390_014E:
3390:014E 8B 3E C6 5F     	mov	di,[5FC6h]
3390:0152 B8 80 01        	mov	ax,180h
3390:0155 50              	push	ax
3390:0156 FF 76 FC        	push	word ptr [bp-4h]
3390:0159 FF 76 08        	push	word ptr [bp+8h]
3390:015C FF 76 06        	push	word ptr [bp+6h]
3390:015F 9A 37 00 15 39  	call	far 3915h:0037h
3390:0164 83 C4 08        	add	sp,8h
3390:0167 8B F0           	mov	si,ax
3390:0169 EB 3D           	jmp	01A8h

l3390_016B:
3390:016B B8 80 01        	mov	ax,180h
3390:016E 50              	push	ax
3390:016F FF 76 FC        	push	word ptr [bp-4h]
3390:0172 FF 76 08        	push	word ptr [bp+8h]
3390:0175 FF 76 06        	push	word ptr [bp+6h]
3390:0178 9A 37 00 15 39  	call	far 3915h:0037h
3390:017D 83 C4 08        	add	sp,8h
3390:0180 8B F0           	mov	si,ax
3390:0182 83 FE FF        	cmp	si,0FFh
3390:0185 75 21           	jnz	01A8h

l3390_0187:
3390:0187 4F              	dec	di
3390:0188 FF 76 08        	push	word ptr [bp+8h]
3390:018B FF 76 06        	push	word ptr [bp+6h]
3390:018E 9A 9C 06 90 33  	call	far 3390h:069Ch
3390:0193 59              	pop	cx
3390:0194 59              	pop	cx
3390:0195 A3 36 B6        	mov	[0B636h],ax
3390:0198 C4 1E 8A 5F     	les	bx,[5F8Ah]
3390:019C 8C 06 34 B6     	mov	[0B634h],es
3390:01A0 89 1E 32 B6     	mov	[0B632h],bx
3390:01A4 FF 1E BE 5F     	call	dword ptr [5FBEh]

l3390_01A8:
3390:01A8 83 FE FF        	cmp	si,0FFh
3390:01AB 75 04           	jnz	01B1h

l3390_01AD:
3390:01AD 0B FF           	or	di,di
3390:01AF 75 BA           	jnz	016Bh

l3390_01B1:
3390:01B1 83 FE FF        	cmp	si,0FFh
3390:01B4 75 0D           	jnz	01C3h

l3390_01B6:
3390:01B6 FF 1E C2 5F     	call	dword ptr [5FC2h]
3390:01BA B8 01 00        	mov	ax,1h
3390:01BD 50              	push	ax
3390:01BE 0E              	push	cs
3390:01BF E8 62 FE        	call	0024h
3390:01C2 59              	pop	cx

l3390_01C3:
3390:01C3 EB 31           	jmp	01F6h

l3390_01C5:
3390:01C5 FF 76 08        	push	word ptr [bp+8h]
3390:01C8 FF 76 06        	push	word ptr [bp+6h]
3390:01CB 9A 86 0C 90 33  	call	far 3390h:0C86h
3390:01D0 59              	pop	cx
3390:01D1 59              	pop	cx
3390:01D2 8B F0           	mov	si,ax
3390:01D4 8B C6           	mov	ax,si
3390:01D6 BA 12 00        	mov	dx,12h
3390:01D9 F7 E2           	mul	dx
3390:01DB 8B D8           	mov	bx,ax
3390:01DD 81 C3 B0 10     	add	bx,10B0h
3390:01E1 1E              	push	ds
3390:01E2 07              	pop	es
3390:01E3 26 C7 47 10 00 00 	mov	word ptr es:[bx+10h],0h
3390:01E9 26 C7 47 0E 00 00 	mov	word ptr es:[bx+0Eh],0h
3390:01EF 8B C6           	mov	ax,si
3390:01F1 0D 00 80        	or	ax,8000h
3390:01F4 8B F0           	mov	si,ax

l3390_01F6:
3390:01F6 C7 46 FE 0A 00  	mov	word ptr [bp-2h],0Ah
3390:01FB 33 FF           	xor	di,di
3390:01FD EB 12           	jmp	0211h

l3390_01FF:
3390:01FF 8B DF           	mov	bx,di
3390:0201 D1 E3           	shl	bx,1h
3390:0203 81 BF 3A B6 FF 7F 	cmp	word ptr [bx+0B63Ah],7FFFh
3390:0209 75 05           	jnz	0210h

l3390_020B:
3390:020B 89 7E FE        	mov	[bp-2h],di
3390:020E EB 06           	jmp	0216h

l3390_0210:
3390:0210 47              	inc	di

l3390_0211:
3390:0211 83 FF 0A        	cmp	di,0Ah
3390:0214 7C E9           	jl	01FFh

l3390_0216:
3390:0216 83 7E FE 0A     	cmp	word ptr [bp-2h],0Ah
3390:021A 75 14           	jnz	0230h

l3390_021C:
3390:021C C4 1E 8E 5F     	les	bx,[5F8Eh]
3390:0220 8C 06 34 B6     	mov	[0B634h],es
3390:0224 89 1E 32 B6     	mov	[0B632h],bx
3390:0228 FF 1E BE 5F     	call	dword ptr [5FBEh]
3390:022C FF 1E C2 5F     	call	dword ptr [5FC2h]

l3390_0230:
3390:0230 8B 5E FE        	mov	bx,[bp-2h]
3390:0233 D1 E3           	shl	bx,1h
3390:0235 89 B7 3A B6     	mov	[bx+0B63Ah],si
3390:0239 8B 46 FE        	mov	ax,[bp-2h]
3390:023C EB 00           	jmp	023Eh

l3390_023E:
3390:023E 5F              	pop	di
3390:023F 5E              	pop	si
3390:0240 8B E5           	mov	sp,bp
3390:0242 5D              	pop	bp
3390:0243 CB              	retf

;; CloseTrackedFile: 3390:0244
;;   Called from:
;;     0D73:45E2 (in EnsureCompatibleSaveFile_4572)
;;     0D73:4B75 (in WriteSaveSlot_4A7E)
;;     0D73:4E8C (in ReadSaveSlot_4D8F)
;;     1A1F:045F (in LoadTacticalIconSetResources_03D4)
;;     1A1F:0609 (in LoadTacticalMap_051B)
;;     1A1F:1127 (in LoadUnitTemplateRecord_10CD)
;;     21E7:003B (in ReadWholeResourceFile_000C)
;;     21E7:0085 (in ReadResourceFileSpan_0044)
;;     21E7:00D5 (in LoadAndDecodePackedResource_008E)
;;     34B3:004F (in LoadPackedIconResource_0008)
CloseTrackedFile proc
3390:0244 55              	push	bp
3390:0245 8B EC           	mov	bp,sp
3390:0247 56              	push	si
3390:0248 8B 76 06        	mov	si,[bp+6h]
3390:024B 8B DE           	mov	bx,si
3390:024D D1 E3           	shl	bx,1h
3390:024F 81 BF 3A B6 FF 7F 	cmp	word ptr [bx+0B63Ah],7FFFh
3390:0255 75 0E           	jnz	0265h

l3390_0257:
3390:0257 FF 36 94 5F     	push	word ptr [5F94h]
3390:025B FF 36 92 5F     	push	word ptr [5F92h]
3390:025F 0E              	push	cs
3390:0260 E8 9F FD        	call	0002h
3390:0263 59              	pop	cx
3390:0264 59              	pop	cx

l3390_0265:
3390:0265 8B DE           	mov	bx,si
3390:0267 D1 E3           	shl	bx,1h
3390:0269 F7 87 3A B6 00 80 	test	word ptr [bx+0B63Ah],8000h
3390:026F 75 0E           	jnz	027Fh

l3390_0271:
3390:0271 8B DE           	mov	bx,si
3390:0273 D1 E3           	shl	bx,1h
3390:0275 FF B7 3A B6     	push	word ptr [bx+0B63Ah]
3390:0279 9A 0E 00 36 39  	call	far 3936h:000Eh
3390:027E 59              	pop	cx

l3390_027F:
3390:027F 8B DE           	mov	bx,si
3390:0281 D1 E3           	shl	bx,1h
3390:0283 C7 87 3A B6 FF 7F 	mov	word ptr [bx+0B63Ah],7FFFh
3390:0289 5E              	pop	si
3390:028A 5D              	pop	bp
3390:028B CB              	retf

;; ReadTrackedFile: 3390:028C
;;   Called from:
;;     0D73:45A7 (in EnsureCompatibleSaveFile_4572)
;;     0D73:45CE (in EnsureCompatibleSaveFile_4572)
;;     0D73:4AF2 (in WriteSaveSlot_4A7E)
;;     0D73:4B07 (in WriteSaveSlot_4A7E)
;;     0D73:4E03 (in ReadSaveSlot_4D8F)
;;     0D73:4E18 (in ReadSaveSlot_4D8F)
;;     0D73:4E49 (in ReadSaveSlot_4D8F)
;;     0D73:4E6F (in ReadSaveSlot_4D8F)
;;     0D73:4E83 (in ReadSaveSlot_4D8F)
;;     1A1F:0456 (in LoadTacticalIconSetResources_03D4)
;;     1A1F:0568 (in LoadTacticalMap_051B)
;;     1A1F:0600 (in LoadTacticalMap_051B)
;;     1A1F:111E (in LoadUnitTemplateRecord_10CD)
;;     21E7:0032 (in ReadWholeResourceFile_000C)
;;     21E7:007C (in ReadResourceFileSpan_0044)
;;     21E7:00B6 (in LoadAndDecodePackedResource_008E)
;;     21E7:00CC (in LoadAndDecodePackedResource_008E)
;;     34B3:0030 (in LoadPackedIconResource_0008)
;;     34B3:0046 (in LoadPackedIconResource_0008)
ReadTrackedFile proc
3390:028C 55              	push	bp
3390:028D 8B EC           	mov	bp,sp
3390:028F 83 EC 04        	sub	sp,4h
3390:0292 56              	push	si
3390:0293 57              	push	di
3390:0294 8B 7E 06        	mov	di,[bp+6h]
3390:0297 8B DF           	mov	bx,di
3390:0299 D1 E3           	shl	bx,1h
3390:029B 81 BF 3A B6 FF 7F 	cmp	word ptr [bx+0B63Ah],7FFFh
3390:02A1 75 0E           	jnz	02B1h

l3390_02A3:
3390:02A3 FF 36 98 5F     	push	word ptr [5F98h]
3390:02A7 FF 36 96 5F     	push	word ptr [5F96h]
3390:02AB 0E              	push	cs
3390:02AC E8 53 FD        	call	0002h
3390:02AF 59              	pop	cx
3390:02B0 59              	pop	cx

l3390_02B1:
3390:02B1 8B DF           	mov	bx,di
3390:02B3 D1 E3           	shl	bx,1h
3390:02B5 F7 87 3A B6 00 80 	test	word ptr [bx+0B63Ah],8000h
3390:02BB 74 23           	jz	02E0h

l3390_02BD:
3390:02BD FF 76 0E        	push	word ptr [bp+0Eh]
3390:02C0 FF 76 0C        	push	word ptr [bp+0Ch]
3390:02C3 FF 76 0A        	push	word ptr [bp+0Ah]
3390:02C6 FF 76 08        	push	word ptr [bp+8h]
3390:02C9 8B DF           	mov	bx,di
3390:02CB D1 E3           	shl	bx,1h
3390:02CD 8B 87 3A B6     	mov	ax,[bx+0B63Ah]
3390:02D1 25 FF 7F        	and	ax,7FFFh
3390:02D4 50              	push	ax
3390:02D5 9A F7 0C 90 33  	call	far 3390h:0CF7h
3390:02DA 83 C4 0A        	add	sp,0Ah
3390:02DD E9 8C 00        	jmp	036Ch

l3390_02E0:
3390:02E0 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
3390:02E5 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
3390:02EA EB 3C           	jmp	0328h

l3390_02EC:
3390:02EC B8 00 FA        	mov	ax,0FA00h
3390:02EF 50              	push	ax
3390:02F0 FF 76 0A        	push	word ptr [bp+0Ah]
3390:02F3 FF 76 08        	push	word ptr [bp+8h]
3390:02F6 8B DF           	mov	bx,di
3390:02F8 D1 E3           	shl	bx,1h
3390:02FA FF B7 3A B6     	push	word ptr [bx+0B63Ah]
3390:02FE 9A 05 00 3C 39  	call	far 393Ch:0005h
3390:0303 83 C4 08        	add	sp,8h
3390:0306 8B F0           	mov	si,ax
3390:0308 81 6E 0C 00 FA  	sub	word ptr [bp+0Ch],0FA00h
3390:030D 83 5E 0E 00     	sbb	word ptr [bp+0Eh],0h
3390:0311 83 FE FF        	cmp	si,0FFh
3390:0314 75 08           	jnz	031Eh

l3390_0316:
3390:0316 33 D2           	xor	dx,dx
3390:0318 33 C0           	xor	ax,ax
3390:031A EB 50           	jmp	036Ch
3390:031C                                     EB 0A                   ..  

l3390_031E:
3390:031E 8B C6           	mov	ax,si
3390:0320 33 D2           	xor	dx,dx
3390:0322 01 46 FC        	add	[bp-4h],ax
3390:0325 11 56 FE        	adc	[bp-2h],dx

l3390_0328:
3390:0328 83 7E 0E 00     	cmp	word ptr [bp+0Eh],0h
3390:032C 7F BE           	jg	02ECh

l3390_032E:
3390:032E 75 07           	jnz	0337h

l3390_0330:
3390:0330 81 7E 0C 00 FA  	cmp	word ptr [bp+0Ch],0FA00h
3390:0335 77 B5           	ja	02ECh

l3390_0337:
3390:0337 FF 76 0E        	push	word ptr [bp+0Eh]
3390:033A FF 76 0C        	push	word ptr [bp+0Ch]
3390:033D FF 76 0A        	push	word ptr [bp+0Ah]
3390:0340 FF 76 08        	push	word ptr [bp+8h]
3390:0343 8B DF           	mov	bx,di
3390:0345 D1 E3           	shl	bx,1h
3390:0347 FF B7 3A B6     	push	word ptr [bx+0B63Ah]
3390:034B 9A 05 00 3C 39  	call	far 393Ch:0005h
3390:0350 83 C4 0A        	add	sp,0Ah
3390:0353 8B F0           	mov	si,ax
3390:0355 83 FE FF        	cmp	si,0FFh
3390:0358 75 06           	jnz	0360h

l3390_035A:
3390:035A 33 D2           	xor	dx,dx
3390:035C 33 C0           	xor	ax,ax
3390:035E EB 0C           	jmp	036Ch

l3390_0360:
3390:0360 8B C6           	mov	ax,si
3390:0362 33 D2           	xor	dx,dx
3390:0364 03 46 FC        	add	ax,[bp-4h]
3390:0367 13 56 FE        	adc	dx,[bp-2h]
3390:036A EB 00           	jmp	036Ch

l3390_036C:
3390:036C 5F              	pop	di
3390:036D 5E              	pop	si
3390:036E 8B E5           	mov	sp,bp
3390:0370 5D              	pop	bp
3390:0371 CB              	retf

;; WriteTrackedFile: 3390:0372
;;   Called from:
;;     0D73:4B38 (in WriteSaveSlot_4A7E)
;;     0D73:4B58 (in WriteSaveSlot_4A7E)
;;     0D73:4B6C (in WriteSaveSlot_4A7E)
WriteTrackedFile proc
3390:0372 55              	push	bp
3390:0373 8B EC           	mov	bp,sp
3390:0375 83 EC 04        	sub	sp,4h
3390:0378 56              	push	si
3390:0379 57              	push	di
3390:037A 8B 7E 06        	mov	di,[bp+6h]
3390:037D 8B DF           	mov	bx,di
3390:037F D1 E3           	shl	bx,1h
3390:0381 81 BF 3A B6 FF 7F 	cmp	word ptr [bx+0B63Ah],7FFFh
3390:0387 75 0E           	jnz	0397h

l3390_0389:
3390:0389 FF 36 9C 5F     	push	word ptr [5F9Ch]
3390:038D FF 36 9A 5F     	push	word ptr [5F9Ah]
3390:0391 0E              	push	cs
3390:0392 E8 6D FC        	call	0002h
3390:0395 59              	pop	cx
3390:0396 59              	pop	cx

l3390_0397:
3390:0397 8B DF           	mov	bx,di
3390:0399 D1 E3           	shl	bx,1h
3390:039B F7 87 3A B6 00 80 	test	word ptr [bx+0B63Ah],8000h
3390:03A1 74 0E           	jz	03B1h

l3390_03A3:
3390:03A3 FF 36 A8 5F     	push	word ptr [5FA8h]
3390:03A7 FF 36 A6 5F     	push	word ptr [5FA6h]
3390:03AB 0E              	push	cs
3390:03AC E8 53 FC        	call	0002h
3390:03AF 59              	pop	cx
3390:03B0 59              	pop	cx

l3390_03B1:
3390:03B1 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
3390:03B6 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
3390:03BB EB 3A           	jmp	03F7h

l3390_03BD:
3390:03BD B8 00 FA        	mov	ax,0FA00h
3390:03C0 50              	push	ax
3390:03C1 FF 76 0A        	push	word ptr [bp+0Ah]
3390:03C4 FF 76 08        	push	word ptr [bp+8h]
3390:03C7 8B DF           	mov	bx,di
3390:03C9 D1 E3           	shl	bx,1h
3390:03CB FF B7 3A B6     	push	word ptr [bx+0B63Ah]
3390:03CF 9A 0A 00 4A 39  	call	far 394Ah:000Ah
3390:03D4 83 C4 08        	add	sp,8h
3390:03D7 8B F0           	mov	si,ax
3390:03D9 83 FE FF        	cmp	si,0FFh
3390:03DC 75 06           	jnz	03E4h

l3390_03DE:
3390:03DE 33 D2           	xor	dx,dx
3390:03E0 33 C0           	xor	ax,ax
3390:03E2 EB 57           	jmp	043Bh

l3390_03E4:
3390:03E4 81 6E 0C 00 FA  	sub	word ptr [bp+0Ch],0FA00h
3390:03E9 83 5E 0E 00     	sbb	word ptr [bp+0Eh],0h
3390:03ED 8B C6           	mov	ax,si
3390:03EF 33 D2           	xor	dx,dx
3390:03F1 01 46 FC        	add	[bp-4h],ax
3390:03F4 11 56 FE        	adc	[bp-2h],dx

l3390_03F7:
3390:03F7 83 7E 0E 00     	cmp	word ptr [bp+0Eh],0h
3390:03FB 7F C0           	jg	03BDh

l3390_03FD:
3390:03FD 75 07           	jnz	0406h

l3390_03FF:
3390:03FF 81 7E 0C 00 FA  	cmp	word ptr [bp+0Ch],0FA00h
3390:0404 77 B7           	ja	03BDh

l3390_0406:
3390:0406 FF 76 0E        	push	word ptr [bp+0Eh]
3390:0409 FF 76 0C        	push	word ptr [bp+0Ch]
3390:040C FF 76 0A        	push	word ptr [bp+0Ah]
3390:040F FF 76 08        	push	word ptr [bp+8h]
3390:0412 8B DF           	mov	bx,di
3390:0414 D1 E3           	shl	bx,1h
3390:0416 FF B7 3A B6     	push	word ptr [bx+0B63Ah]
3390:041A 9A 0A 00 4A 39  	call	far 394Ah:000Ah
3390:041F 83 C4 0A        	add	sp,0Ah
3390:0422 8B F0           	mov	si,ax
3390:0424 83 FE FF        	cmp	si,0FFh
3390:0427 75 06           	jnz	042Fh

l3390_0429:
3390:0429 33 D2           	xor	dx,dx
3390:042B 33 C0           	xor	ax,ax
3390:042D EB 0C           	jmp	043Bh

l3390_042F:
3390:042F 8B C6           	mov	ax,si
3390:0431 33 D2           	xor	dx,dx
3390:0433 03 46 FC        	add	ax,[bp-4h]
3390:0436 13 56 FE        	adc	dx,[bp-2h]
3390:0439 EB 00           	jmp	043Bh

l3390_043B:
3390:043B 5F              	pop	di
3390:043C 5E              	pop	si
3390:043D 8B E5           	mov	sp,bp
3390:043F 5D              	pop	bp
3390:0440 CB              	retf

;; SeekTrackedFile: 3390:0441
;;   Called from:
;;     0D73:4592 (in EnsureCompatibleSaveFile_4572)
;;     0D73:45B9 (in EnsureCompatibleSaveFile_4572)
;;     0D73:4ADD (in WriteSaveSlot_4A7E)
;;     0D73:4B1F (in WriteSaveSlot_4A7E)
;;     0D73:4DEE (in ReadSaveSlot_4D8F)
;;     0D73:4E30 (in ReadSaveSlot_4D8F)
;;     1A1F:043E (in LoadTacticalIconSetResources_03D4)
;;     1A1F:1109 (in LoadUnitTemplateRecord_10CD)
;;     21E7:0066 (in ReadResourceFileSpan_0044)
SeekTrackedFile proc
3390:0441 55              	push	bp
3390:0442 8B EC           	mov	bp,sp
3390:0444 83 EC 04        	sub	sp,4h
3390:0447 56              	push	si
3390:0448 57              	push	di
3390:0449 8B 7E 06        	mov	di,[bp+6h]
3390:044C 8B DF           	mov	bx,di
3390:044E D1 E3           	shl	bx,1h
3390:0450 81 BF 3A B6 FF 7F 	cmp	word ptr [bx+0B63Ah],7FFFh
3390:0456 75 0E           	jnz	0466h

l3390_0458:
3390:0458 FF 36 A0 5F     	push	word ptr [5FA0h]
3390:045C FF 36 9E 5F     	push	word ptr [5F9Eh]
3390:0460 0E              	push	cs
3390:0461 E8 9E FB        	call	0002h
3390:0464 59              	pop	cx
3390:0465 59              	pop	cx

l3390_0466:
3390:0466 8B DF           	mov	bx,di
3390:0468 D1 E3           	shl	bx,1h
3390:046A F7 87 3A B6 00 80 	test	word ptr [bx+0B63Ah],8000h
3390:0470 75 03           	jnz	0475h

l3390_0472:
3390:0472 E9 63 01        	jmp	05D8h

l3390_0475:
3390:0475 8B DF           	mov	bx,di
3390:0477 D1 E3           	shl	bx,1h
3390:0479 8B B7 3A B6     	mov	si,[bx+0B63Ah]
3390:047D 81 E6 FF 7F     	and	si,7FFFh
3390:0481 8B C6           	mov	ax,si
3390:0483 BA 12 00        	mov	dx,12h
3390:0486 F7 E2           	mul	dx
3390:0488 8B D8           	mov	bx,ax
3390:048A 81 C3 B0 10     	add	bx,10B0h
3390:048E 1E              	push	ds
3390:048F 07              	pop	es
3390:0490 26 8B 57 10     	mov	dx,es:[bx+10h]
3390:0494 26 8B 47 0E     	mov	ax,es:[bx+0Eh]
3390:0498 89 56 FE        	mov	[bp-2h],dx
3390:049B 89 46 FC        	mov	[bp-4h],ax
3390:049E 8B 46 0C        	mov	ax,[bp+0Ch]
3390:04A1 0B C0           	or	ax,ax
3390:04A3 74 10           	jz	04B5h

l3390_04A5:
3390:04A5 3D 01 00        	cmp	ax,1h
3390:04A8 75 03           	jnz	04ADh

l3390_04AA:
3390:04AA E9 76 00        	jmp	0523h

l3390_04AD:
3390:04AD 3D 02 00        	cmp	ax,2h
3390:04B0 74 54           	jz	0506h

l3390_04B2:
3390:04B2 E9 EA 00        	jmp	059Fh

l3390_04B5:
3390:04B5 8B C6           	mov	ax,si
3390:04B7 BA 12 00        	mov	dx,12h
3390:04BA F7 E2           	mul	dx
3390:04BC 8B D8           	mov	bx,ax
3390:04BE 81 C3 B0 10     	add	bx,10B0h
3390:04C2 1E              	push	ds
3390:04C3 07              	pop	es
3390:04C4 26 8B 57 06     	mov	dx,es:[bx+6h]
3390:04C8 26 8B 47 04     	mov	ax,es:[bx+4h]
3390:04CC 3B 56 0A        	cmp	dx,[bp+0Ah]
3390:04CF 7F 26           	jg	04F7h

l3390_04D1:
3390:04D1 7C 05           	jl	04D8h

l3390_04D3:
3390:04D3 3B 46 08        	cmp	ax,[bp+8h]
3390:04D6 73 1F           	jnc	04F7h

l3390_04D8:
3390:04D8 8B C6           	mov	ax,si
3390:04DA BA 12 00        	mov	dx,12h
3390:04DD F7 E2           	mul	dx
3390:04DF 8B D8           	mov	bx,ax
3390:04E1 81 C3 B0 10     	add	bx,10B0h
3390:04E5 1E              	push	ds
3390:04E6 07              	pop	es
3390:04E7 26 8B 57 06     	mov	dx,es:[bx+6h]
3390:04EB 26 8B 47 04     	mov	ax,es:[bx+4h]
3390:04EF 89 56 FE        	mov	[bp-2h],dx
3390:04F2 89 46 FC        	mov	[bp-4h],ax
3390:04F5 EB 0C           	jmp	0503h

l3390_04F7:
3390:04F7 8B 56 0A        	mov	dx,[bp+0Ah]
3390:04FA 8B 46 08        	mov	ax,[bp+8h]
3390:04FD 89 56 FE        	mov	[bp-2h],dx
3390:0500 89 46 FC        	mov	[bp-4h],ax

l3390_0503:
3390:0503 E9 A9 00        	jmp	05AFh

l3390_0506:
3390:0506 8B C6           	mov	ax,si
3390:0508 BA 12 00        	mov	dx,12h
3390:050B F7 E2           	mul	dx
3390:050D 8B D8           	mov	bx,ax
3390:050F 81 C3 B0 10     	add	bx,10B0h
3390:0513 1E              	push	ds
3390:0514 07              	pop	es
3390:0515 26 8B 57 06     	mov	dx,es:[bx+6h]
3390:0519 26 8B 47 04     	mov	ax,es:[bx+4h]
3390:051D 89 56 FE        	mov	[bp-2h],dx
3390:0520 89 46 FC        	mov	[bp-4h],ax

l3390_0523:
3390:0523 8B 56 FE        	mov	dx,[bp-2h]
3390:0526 8B 46 FC        	mov	ax,[bp-4h]
3390:0529 03 46 08        	add	ax,[bp+8h]
3390:052C 13 56 0A        	adc	dx,[bp+0Ah]
3390:052F 52              	push	dx
3390:0530 50              	push	ax
3390:0531 8B C6           	mov	ax,si
3390:0533 BA 12 00        	mov	dx,12h
3390:0536 F7 E2           	mul	dx
3390:0538 8B D8           	mov	bx,ax
3390:053A 81 C3 B0 10     	add	bx,10B0h
3390:053E 1E              	push	ds
3390:053F 07              	pop	es
3390:0540 58              	pop	ax
3390:0541 5A              	pop	dx
3390:0542 26 3B 57 06     	cmp	dx,es:[bx+6h]
3390:0546 7C 27           	jl	056Fh

l3390_0548:
3390:0548 7F 06           	jg	0550h

l3390_054A:
3390:054A 26 3B 47 04     	cmp	ax,es:[bx+4h]
3390:054E 76 1F           	jbe	056Fh

l3390_0550:
3390:0550 8B C6           	mov	ax,si
3390:0552 BA 12 00        	mov	dx,12h
3390:0555 F7 E2           	mul	dx
3390:0557 8B D8           	mov	bx,ax
3390:0559 81 C3 B0 10     	add	bx,10B0h
3390:055D 1E              	push	ds
3390:055E 07              	pop	es
3390:055F 26 8B 57 06     	mov	dx,es:[bx+6h]
3390:0563 26 8B 47 04     	mov	ax,es:[bx+4h]
3390:0567 89 56 FE        	mov	[bp-2h],dx
3390:056A 89 46 FC        	mov	[bp-4h],ax
3390:056D EB 2E           	jmp	059Dh

l3390_056F:
3390:056F 8B 56 FE        	mov	dx,[bp-2h]
3390:0572 8B 46 FC        	mov	ax,[bp-4h]
3390:0575 03 46 08        	add	ax,[bp+8h]
3390:0578 13 56 0A        	adc	dx,[bp+0Ah]
3390:057B 0B D2           	or	dx,dx
3390:057D 7F 12           	jg	0591h

l3390_057F:
3390:057F 7C 04           	jl	0585h

l3390_0581:
3390:0581 0B C0           	or	ax,ax
3390:0583 73 0C           	jnc	0591h

l3390_0585:
3390:0585 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
3390:058A C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
3390:058F EB 0C           	jmp	059Dh

l3390_0591:
3390:0591 8B 56 0A        	mov	dx,[bp+0Ah]
3390:0594 8B 46 08        	mov	ax,[bp+8h]
3390:0597 01 46 FC        	add	[bp-4h],ax
3390:059A 11 56 FE        	adc	[bp-2h],dx

l3390_059D:
3390:059D EB 10           	jmp	05AFh

l3390_059F:
3390:059F FF 36 A4 5F     	push	word ptr [5FA4h]
3390:05A3 FF 36 A2 5F     	push	word ptr [5FA2h]
3390:05A7 0E              	push	cs
3390:05A8 E8 57 FA        	call	0002h
3390:05AB 59              	pop	cx
3390:05AC 59              	pop	cx
3390:05AD EB 00           	jmp	05AFh

l3390_05AF:
3390:05AF 8B 56 FE        	mov	dx,[bp-2h]
3390:05B2 8B 46 FC        	mov	ax,[bp-4h]
3390:05B5 52              	push	dx
3390:05B6 50              	push	ax
3390:05B7 8B C6           	mov	ax,si
3390:05B9 BA 12 00        	mov	dx,12h
3390:05BC F7 E2           	mul	dx
3390:05BE 8B D8           	mov	bx,ax
3390:05C0 81 C3 B0 10     	add	bx,10B0h
3390:05C4 1E              	push	ds
3390:05C5 07              	pop	es
3390:05C6 58              	pop	ax
3390:05C7 5A              	pop	dx
3390:05C8 26 89 57 10     	mov	es:[bx+10h],dx
3390:05CC 26 89 47 0E     	mov	es:[bx+0Eh],ax
3390:05D0 8B 56 FE        	mov	dx,[bp-2h]
3390:05D3 8B 46 FC        	mov	ax,[bp-4h]
3390:05D6 EB 41           	jmp	0619h

l3390_05D8:
3390:05D8 8B 46 0C        	mov	ax,[bp+0Ch]
3390:05DB 0B C0           	or	ax,ax
3390:05DD 74 0C           	jz	05EBh

l3390_05DF:
3390:05DF 3D 01 00        	cmp	ax,1h
3390:05E2 74 07           	jz	05EBh

l3390_05E4:
3390:05E4 3D 02 00        	cmp	ax,2h
3390:05E7 74 02           	jz	05EBh

l3390_05E9:
3390:05E9 EB 02           	jmp	05EDh

l3390_05EB:
3390:05EB EB 10           	jmp	05FDh

l3390_05ED:
3390:05ED FF 36 A4 5F     	push	word ptr [5FA4h]
3390:05F1 FF 36 A2 5F     	push	word ptr [5FA2h]
3390:05F5 0E              	push	cs
3390:05F6 E8 09 FA        	call	0002h
3390:05F9 59              	pop	cx
3390:05FA 59              	pop	cx
3390:05FB EB 00           	jmp	05FDh

l3390_05FD:
3390:05FD FF 76 0C        	push	word ptr [bp+0Ch]
3390:0600 FF 76 0A        	push	word ptr [bp+0Ah]
3390:0603 FF 76 08        	push	word ptr [bp+8h]
3390:0606 8B DF           	mov	bx,di
3390:0608 D1 E3           	shl	bx,1h
3390:060A FF B7 3A B6     	push	word ptr [bx+0B63Ah]
3390:060E 9A 0C 00 65 39  	call	far 3965h:000Ch
3390:0613 83 C4 08        	add	sp,8h
3390:0616 99              	cwd
3390:0617 EB 00           	jmp	0619h

l3390_0619:
3390:0619 5F              	pop	di
3390:061A 5E              	pop	si
3390:061B 8B E5           	mov	sp,bp
3390:061D 5D              	pop	bp
3390:061E CB              	retf

;; CanOpenFileForRead: 3390:061F
;;   Called from:
;;     3390:006B (in OpenTrackedFile)
;;     3390:00BB (in OpenTrackedFile)
;;     3390:00F6 (in OpenTrackedFile)
CanOpenFileForRead proc
3390:061F 55              	push	bp
3390:0620 8B EC           	mov	bp,sp
3390:0622 56              	push	si
3390:0623 B8 01 80        	mov	ax,8001h
3390:0626 50              	push	ax
3390:0627 FF 76 08        	push	word ptr [bp+8h]
3390:062A FF 76 06        	push	word ptr [bp+6h]
3390:062D 9A 37 00 15 39  	call	far 3915h:0037h
3390:0632 83 C4 06        	add	sp,6h
3390:0635 8B F0           	mov	si,ax
3390:0637 83 FE FF        	cmp	si,0FFh
3390:063A 75 04           	jnz	0640h

l3390_063C:
3390:063C 33 C0           	xor	ax,ax
3390:063E EB 0C           	jmp	064Ch

l3390_0640:
3390:0640 56              	push	si
3390:0641 9A 0E 00 36 39  	call	far 3936h:000Eh
3390:0646 59              	pop	cx
3390:0647 B8 01 00        	mov	ax,1h
3390:064A EB 00           	jmp	064Ch

l3390_064C:
3390:064C 5E              	pop	si
3390:064D 5D              	pop	bp
3390:064E CB              	retf

;; DeleteFileIgnoringErrors: 3390:064F
;;   Called from:
;;     3390:00AA (in OpenTrackedFile)
DeleteFileIgnoringErrors proc
3390:064F 55              	push	bp
3390:0650 8B EC           	mov	bp,sp
3390:0652 FF 76 08        	push	word ptr [bp+8h]
3390:0655 FF 76 06        	push	word ptr [bp+6h]
3390:0658 9A 05 00 78 39  	call	far 3978h:0005h
3390:065D 8B E5           	mov	sp,bp
3390:065F F7 D8           	neg	ax
3390:0661 1B C0           	sbb	ax,ax
3390:0663 40              	inc	ax
3390:0664 EB 00           	jmp	0666h

l3390_0666:
3390:0666 5D              	pop	bp
3390:0667 CB              	retf

;; CanOpenFileForWrite: 3390:0668
;;   Called from:
;;     3390:00DE (in OpenTrackedFile)
CanOpenFileForWrite proc
3390:0668 55              	push	bp
3390:0669 8B EC           	mov	bp,sp
3390:066B 56              	push	si
3390:066C B8 80 01        	mov	ax,180h
3390:066F 50              	push	ax
3390:0670 B8 02 81        	mov	ax,8102h
3390:0673 50              	push	ax
3390:0674 FF 76 08        	push	word ptr [bp+8h]
3390:0677 FF 76 06        	push	word ptr [bp+6h]
3390:067A 9A 37 00 15 39  	call	far 3915h:0037h
3390:067F 83 C4 08        	add	sp,8h
3390:0682 8B F0           	mov	si,ax
3390:0684 83 FE FF        	cmp	si,0FFh
3390:0687 75 04           	jnz	068Dh

l3390_0689:
3390:0689 33 C0           	xor	ax,ax
3390:068B EB 0C           	jmp	0699h

l3390_068D:
3390:068D 56              	push	si
3390:068E 9A 0E 00 36 39  	call	far 3936h:000Eh
3390:0693 59              	pop	cx
3390:0694 B8 01 00        	mov	ax,1h
3390:0697 EB 00           	jmp	0699h

l3390_0699:
3390:0699 5E              	pop	si
3390:069A 5D              	pop	bp
3390:069B CB              	retf

;; GetResourceDriveMask: 3390:069C
;;   Called from:
;;     3390:007C (in OpenTrackedFile)
;;     3390:018E (in OpenTrackedFile)
GetResourceDriveMask proc
3390:069C 55              	push	bp
3390:069D 8B EC           	mov	bp,sp
3390:069F 56              	push	si
3390:06A0 33 F6           	xor	si,si
3390:06A2 FF 76 08        	push	word ptr [bp+8h]
3390:06A5 FF 76 06        	push	word ptr [bp+6h]
3390:06A8 9A 0C 00 04 3A  	call	far 3A04h:000Ch
3390:06AD 59              	pop	cx
3390:06AE 59              	pop	cx
3390:06AF 89 56 08        	mov	[bp+8h],dx
3390:06B2 89 46 06        	mov	[bp+6h],ax
3390:06B5 EB 3E           	jmp	06F5h

l3390_06B7:
3390:06B7 FF 76 08        	push	word ptr [bp+8h]
3390:06BA FF 76 06        	push	word ptr [bp+6h]
3390:06BD 8B C6           	mov	ax,si
3390:06BF BA 12 00        	mov	dx,12h
3390:06C2 F7 E2           	mul	dx
3390:06C4 8B D8           	mov	bx,ax
3390:06C6 81 C3 B0 10     	add	bx,10B0h
3390:06CA 1E              	push	ds
3390:06CB 07              	pop	es
3390:06CC 26 FF 77 02     	push	word ptr es:[bx+2h]
3390:06D0 26 FF 37        	push	word ptr es:[bx]
3390:06D3 9A 0E 00 7F 39  	call	far 397Fh:000Eh
3390:06D8 83 C4 08        	add	sp,8h
3390:06DB 0B C0           	or	ax,ax
3390:06DD 75 15           	jnz	06F4h

l3390_06DF:
3390:06DF 8B C6           	mov	ax,si
3390:06E1 BA 12 00        	mov	dx,12h
3390:06E4 F7 E2           	mul	dx
3390:06E6 8B D8           	mov	bx,ax
3390:06E8 81 C3 B0 10     	add	bx,10B0h
3390:06EC 1E              	push	ds
3390:06ED 07              	pop	es
3390:06EE 26 8B 47 0C     	mov	ax,es:[bx+0Ch]
3390:06F2 EB 27           	jmp	071Bh

l3390_06F4:
3390:06F4 46              	inc	si

l3390_06F5:
3390:06F5 8B C6           	mov	ax,si
3390:06F7 BA 12 00        	mov	dx,12h
3390:06FA F7 E2           	mul	dx
3390:06FC 8B D8           	mov	bx,ax
3390:06FE 81 C3 B0 10     	add	bx,10B0h
3390:0702 1E              	push	ds
3390:0703 07              	pop	es
3390:0704 26 C4 1F        	les	bx,es:[bx]
3390:0707 26 80 3F 00     	cmp	byte ptr es:[bx],0h
3390:070B 75 AA           	jnz	06B7h

l3390_070D:
3390:070D FF 36 AC 5F     	push	word ptr [5FACh]
3390:0711 FF 36 AA 5F     	push	word ptr [5FAAh]
3390:0715 0E              	push	cs
3390:0716 E8 E9 F8        	call	0002h
3390:0719 59              	pop	cx
3390:071A 59              	pop	cx

l3390_071B:
3390:071B 5E              	pop	si
3390:071C 5D              	pop	bp
3390:071D CB              	retf
3390:071E                                           55 8B               U.
3390:0720 EC 83 EC 0A 56 57 C6 46 FB 41 8B 36 2E 62 FF 36 ....VW.F.A.6.b.6
3390:0730 CE 5F 9A 09 00 38 33 59 C7 46 F6 00 00 A1 CA 5F ._...83Y.F....._
3390:0740 0B 06 CC 5F 75 4C A1 34 62 F7 26 36 62 99 89 56 ..._uL.4b.&6b..V
3390:0750 FE 89 46 FC C7 46 F6 05 00 83 3E CE B6 03 75 05 ..F..F....>...u.
3390:0760 C7 46 F6 06 00 8B 56 FE 8B 46 FC 8A 4E F6 9A E8 .F....V..F..N...
3390:0770 54 00 08 89 56 FE 89 46 FC FF 76 FE FF 76 FC 9A T...V..F..v..v..
3390:0780 03 02 CD 38 59 59 89 16 CC 5F A3 CA 5F C7 46 F6 ...8YY..._.._.F.
3390:0790 01 00 FF 36 CC 5F FF 36 CA 5F FF 36 36 62 FF 36 ...6._.6._.66b.6
3390:07A0 34 62 FF 36 32 62 FF 36 30 62 9A 35 28 00 08 83 4b.62b.60b.5(...
3390:07B0 C4 0C 9A 06 00 6D 35 B8 0F 00 50 A1 32 62 D1 E0 .....m5...P.2b..
3390:07C0 D1 E0 D1 E0 50 A1 30 62 03 06 34 62 D1 E0 D1 E0 ....P.0b..4b....
3390:07D0 D1 E0 48 50 A1 32 62 D1 E0 D1 E0 D1 E0 50 A1 30 ..HP.2b......P.0
3390:07E0 62 D1 E0 D1 E0 D1 E0 50 9A A6 00 65 33 83 C4 0A b......P...e3...
3390:07F0 B8 0F 00 50 A1 32 62 03 06 36 62 D1 E0 D1 E0 D1 ...P.2b..6b.....
3390:0800 E0 48 50 A1 30 62 03 06 34 62 D1 E0 D1 E0 D1 E0 .HP.0b..4b......
3390:0810 48 50 A1 32 62 03 06 36 62 D1 E0 D1 E0 D1 E0 48 HP.2b..6b......H
3390:0820 50 A1 30 62 D1 E0 D1 E0 D1 E0 50 9A A6 00 65 33 P.0b......P...e3
3390:0830 83 C4 0A B8 0F 00 50 A1 32 62 03 06 36 62 D1 E0 ......P.2b..6b..
3390:0840 D1 E0 D1 E0 48 50 A1 30 62 D1 E0 D1 E0 D1 E0 50 ....HP.0b......P
3390:0850 A1 32 62 D1 E0 D1 E0 D1 E0 50 A1 30 62 D1 E0 D1 .2b......P.0b...
3390:0860 E0 D1 E0 50 9A A6 00 65 33 83 C4 0A B8 0F 00 50 ...P...e3......P
3390:0870 A1 32 62 03 06 36 62 D1 E0 D1 E0 D1 E0 48 50 A1 .2b..6b......HP.
3390:0880 30 62 03 06 34 62 D1 E0 D1 E0 D1 E0 48 50 A1 32 0b..4b......HP.2
3390:0890 62 D1 E0 D1 E0 D1 E0 50 A1 30 62 03 06 34 62 D1 b......P.0b..4b.
3390:08A0 E0 D1 E0 D1 E0 48 50 9A A6 00 65 33 83 C4 0A B8 .....HP...e3....
3390:08B0 FF FF 50 9A FC 0D 90 33 59 8B 16 34 B6 A1 32 B6 ..P....3Y..4..2.
3390:08C0 3B 16 8C 5F 75 29 3B 06 8A 5F 75 23 8A 46 FB 02 ;.._u);.._u#.F..
3390:08D0 06 36 B6 C4 1E 32 B6 26 88 47 0C 83 3E 68 B6 00 .6...2.&.G..>h..
3390:08E0 75 0D A0 62 B6 04 41 C4 1E 32 B6 26 88 47 17 8B u..b..A..2.&.G..
3390:08F0 3E 38 62 A1 3A 62 89 46 F8 C7 06 38 62 0F 00 C7 >8b.:b.F...8b...
3390:0900 06 3A 62 0C 00 FF 36 34 B6 FF 36 32 B6 9A 0A 00 .:b...64..62....
3390:0910 CE 35 59 59 89 3E 38 62 8B 46 F8 A3 3A 62 9A 5C .5YY.>8b.F..:b.\
3390:0920 04 7F 2C B8 01 00 50 9A FC 0D 90 33 59 FF 36 CC ..,...P....3Y.6.
3390:0930 5F FF 36 CA 5F FF 36 36 62 FF 36 34 62 FF 36 32 _.6._.66b.64b.62
3390:0940 62 FF 36 30 62 9A 83 26 00 08 83 C4 0C 56 9A 09 b.60b..&.....V..
3390:0950 00 38 33 59 83 7E F6 00 74 1B FF 36 CC 5F FF 36 .83Y.~..t..6._.6
3390:0960 CA 5F 9A E6 02 8D 39 59 59 C7 06 CC 5F 00 00 C7 ._....9YY..._...
3390:0970 06 CA 5F 00 00 5F 5E 8B E5 5D CB C4 1E BA 5F 8C .._.._^..]...._.
3390:0980 06 34 B6 89 1E 32 B6 0E E8 93 FD CB             .4...2......    

;; ReleaseCachedResources: 3390:098C
;;   Called from:
;;     2C7F:0311 (in ShutdownGame_02E3)
ReleaseCachedResources proc
3390:098C 56              	push	si
3390:098D 33 F6           	xor	si,si
3390:098F EB 53           	jmp	09E4h

l3390_0991:
3390:0991 8B C6           	mov	ax,si
3390:0993 BA 12 00        	mov	dx,12h
3390:0996 F7 E2           	mul	dx
3390:0998 8B D8           	mov	bx,ax
3390:099A 81 C3 B0 10     	add	bx,10B0h
3390:099E 1E              	push	ds
3390:099F 07              	pop	es
3390:09A0 26 8B 47 08     	mov	ax,es:[bx+8h]
3390:09A4 26 0B 47 0A     	or	ax,es:[bx+0Ah]
3390:09A8 74 39           	jz	09E3h

l3390_09AA:
3390:09AA 8B C6           	mov	ax,si
3390:09AC BA 12 00        	mov	dx,12h
3390:09AF F7 E2           	mul	dx
3390:09B1 8B D8           	mov	bx,ax
3390:09B3 81 C3 B0 10     	add	bx,10B0h
3390:09B7 1E              	push	ds
3390:09B8 07              	pop	es
3390:09B9 26 FF 77 0A     	push	word ptr es:[bx+0Ah]
3390:09BD 26 FF 77 08     	push	word ptr es:[bx+8h]
3390:09C1 9A E6 02 8D 39  	call	far 398Dh:02E6h
3390:09C6 59              	pop	cx
3390:09C7 59              	pop	cx
3390:09C8 8B C6           	mov	ax,si
3390:09CA BA 12 00        	mov	dx,12h
3390:09CD F7 E2           	mul	dx
3390:09CF 8B D8           	mov	bx,ax
3390:09D1 81 C3 B0 10     	add	bx,10B0h
3390:09D5 1E              	push	ds
3390:09D6 07              	pop	es
3390:09D7 26 C7 47 0A 00 00 	mov	word ptr es:[bx+0Ah],0h
3390:09DD 26 C7 47 08 00 00 	mov	word ptr es:[bx+8h],0h

l3390_09E3:
3390:09E3 46              	inc	si

l3390_09E4:
3390:09E4 8B C6           	mov	ax,si
3390:09E6 BA 12 00        	mov	dx,12h
3390:09E9 F7 E2           	mul	dx
3390:09EB 8B D8           	mov	bx,ax
3390:09ED 81 C3 B0 10     	add	bx,10B0h
3390:09F1 1E              	push	ds
3390:09F2 07              	pop	es
3390:09F3 26 C4 1F        	les	bx,es:[bx]
3390:09F6 26 80 3F 00     	cmp	byte ptr es:[bx],0h
3390:09FA 75 95           	jnz	0991h

l3390_09FC:
3390:09FC 33 F6           	xor	si,si
3390:09FE EB 1B           	jmp	0A1Bh

l3390_0A00:
3390:0A00 8B DE           	mov	bx,si
3390:0A02 D1 E3           	shl	bx,1h
3390:0A04 81 BF 3A B6 FF 7F 	cmp	word ptr [bx+0B63Ah],7FFFh
3390:0A0A 74 0E           	jz	0A1Ah

l3390_0A0C:
3390:0A0C FF 36 B4 5F     	push	word ptr [5FB4h]
3390:0A10 FF 36 B2 5F     	push	word ptr [5FB2h]
3390:0A14 0E              	push	cs
3390:0A15 E8 EA F5        	call	0002h
3390:0A18 59              	pop	cx
3390:0A19 59              	pop	cx

l3390_0A1A:
3390:0A1A 46              	inc	si

l3390_0A1B:
3390:0A1B 83 FE 0A        	cmp	si,0Ah
3390:0A1E 7C E0           	jl	0A00h

l3390_0A20:
3390:0A20 5E              	pop	si
3390:0A21 CB              	retf

;; InitializeResourceCache: 3390:0A22
;;   Called from:
;;     2C7F:02A6 (in InitializeGame_003C)
InitializeResourceCache proc
3390:0A22 55              	push	bp
3390:0A23 8B EC           	mov	bp,sp
3390:0A25 83 EC 08        	sub	sp,8h
3390:0A28 56              	push	si
3390:0A29 57              	push	di
3390:0A2A 33 F6           	xor	si,si
3390:0A2C EB 0B           	jmp	0A39h

l3390_0A2E:
3390:0A2E 8B DE           	mov	bx,si
3390:0A30 D1 E3           	shl	bx,1h
3390:0A32 C7 87 3A B6 FF 7F 	mov	word ptr [bx+0B63Ah],7FFFh
3390:0A38 46              	inc	si

l3390_0A39:
3390:0A39 83 FE 0A        	cmp	si,0Ah
3390:0A3C 7C F0           	jl	0A2Eh

l3390_0A3E:
3390:0A3E 9A A8 33 00 08  	call	far 0800h:33A8h
3390:0A43 2B 06 C8 5F     	sub	ax,[5FC8h]
3390:0A47 89 46 FC        	mov	[bp-4h],ax
3390:0A4A 33 F6           	xor	si,si
3390:0A4C 89 36 38 B6     	mov	[0B638h],si
3390:0A50 E9 8B 01        	jmp	0BDEh

l3390_0A53:
3390:0A53 8B C6           	mov	ax,si
3390:0A55 BA 12 00        	mov	dx,12h
3390:0A58 F7 E2           	mul	dx
3390:0A5A 8B D8           	mov	bx,ax
3390:0A5C 81 C3 B0 10     	add	bx,10B0h
3390:0A60 1E              	push	ds
3390:0A61 07              	pop	es
3390:0A62 26 8B 47 0C     	mov	ax,es:[bx+0Ch]
3390:0A66 09 06 38 B6     	or	[0B638h],ax
3390:0A6A 83 3E 4E B6 00  	cmp	word ptr [0B64Eh],0h
3390:0A6F 75 03           	jnz	0A74h

l3390_0A71:
3390:0A71 E9 69 01        	jmp	0BDDh

l3390_0A74:
3390:0A74 8B C6           	mov	ax,si
3390:0A76 BA 12 00        	mov	dx,12h
3390:0A79 F7 E2           	mul	dx
3390:0A7B 8B D8           	mov	bx,ax
3390:0A7D 81 C3 B0 10     	add	bx,10B0h
3390:0A81 1E              	push	ds
3390:0A82 07              	pop	es
3390:0A83 26 FF 77 02     	push	word ptr es:[bx+2h]
3390:0A87 26 FF 37        	push	word ptr es:[bx]
3390:0A8A 9A 0C 00 04 3A  	call	far 3A04h:000Ch
3390:0A8F 59              	pop	cx
3390:0A90 59              	pop	cx
3390:0A91 52              	push	dx
3390:0A92 50              	push	ax
3390:0A93 8B C6           	mov	ax,si
3390:0A95 BA 12 00        	mov	dx,12h
3390:0A98 F7 E2           	mul	dx
3390:0A9A 8B D8           	mov	bx,ax
3390:0A9C 81 C3 B0 10     	add	bx,10B0h
3390:0AA0 1E              	push	ds
3390:0AA1 07              	pop	es
3390:0AA2 58              	pop	ax
3390:0AA3 5A              	pop	dx
3390:0AA4 26 89 57 02     	mov	es:[bx+2h],dx
3390:0AA8 26 89 07        	mov	es:[bx],ax
3390:0AAB 33 D2           	xor	dx,dx
3390:0AAD B8 00 04        	mov	ax,400h
3390:0AB0 52              	push	dx
3390:0AB1 50              	push	ax
3390:0AB2 8B C6           	mov	ax,si
3390:0AB4 BA 12 00        	mov	dx,12h
3390:0AB7 F7 E2           	mul	dx
3390:0AB9 8B D8           	mov	bx,ax
3390:0ABB 81 C3 B0 10     	add	bx,10B0h
3390:0ABF 1E              	push	ds
3390:0AC0 07              	pop	es
3390:0AC1 26 FF 77 06     	push	word ptr es:[bx+6h]
3390:0AC5 26 FF 77 04     	push	word ptr es:[bx+4h]
3390:0AC9 9A 45 54 00 08  	call	far 0800h:5445h
3390:0ACE 40              	inc	ax
3390:0ACF 89 46 FE        	mov	[bp-2h],ax
3390:0AD2 8B 46 FC        	mov	ax,[bp-4h]
3390:0AD5 3B 46 FE        	cmp	ax,[bp-2h]
3390:0AD8 7C 26           	jl	0B00h

l3390_0ADA:
3390:0ADA 8B C6           	mov	ax,si
3390:0ADC BA 12 00        	mov	dx,12h
3390:0ADF F7 E2           	mul	dx
3390:0AE1 8B D8           	mov	bx,ax
3390:0AE3 81 C3 B0 10     	add	bx,10B0h
3390:0AE7 1E              	push	ds
3390:0AE8 07              	pop	es
3390:0AE9 26 FF 77 06     	push	word ptr es:[bx+6h]
3390:0AED 26 FF 77 04     	push	word ptr es:[bx+4h]
3390:0AF1 9A 03 02 CD 38  	call	far 38CDh:0203h
3390:0AF6 59              	pop	cx
3390:0AF7 59              	pop	cx
3390:0AF8 89 56 FA        	mov	[bp-6h],dx
3390:0AFB 89 46 F8        	mov	[bp-8h],ax
3390:0AFE EB 0A           	jmp	0B0Ah

l3390_0B00:
3390:0B00 C7 46 FA 00 00  	mov	word ptr [bp-6h],0h
3390:0B05 C7 46 F8 00 00  	mov	word ptr [bp-8h],0h

l3390_0B0A:
3390:0B0A 8B 46 F8        	mov	ax,[bp-8h]
3390:0B0D 0B 46 FA        	or	ax,[bp-6h]
3390:0B10 75 04           	jnz	0B16h

l3390_0B12:
3390:0B12 46              	inc	si
3390:0B13 E9 C8 00        	jmp	0BDEh

l3390_0B16:
3390:0B16 B8 80 01        	mov	ax,180h
3390:0B19 50              	push	ax
3390:0B1A B8 01 80        	mov	ax,8001h
3390:0B1D 50              	push	ax
3390:0B1E 8B C6           	mov	ax,si
3390:0B20 BA 12 00        	mov	dx,12h
3390:0B23 F7 E2           	mul	dx
3390:0B25 8B D8           	mov	bx,ax
3390:0B27 81 C3 B0 10     	add	bx,10B0h
3390:0B2B 1E              	push	ds
3390:0B2C 07              	pop	es
3390:0B2D 26 FF 77 02     	push	word ptr es:[bx+2h]
3390:0B31 26 FF 37        	push	word ptr es:[bx]
3390:0B34 9A 37 00 15 39  	call	far 3915h:0037h
3390:0B39 83 C4 08        	add	sp,8h
3390:0B3C 8B F8           	mov	di,ax
3390:0B3E 83 FF FF        	cmp	di,0FFh
3390:0B41 75 11           	jnz	0B54h

l3390_0B43:
3390:0B43 FF 76 FA        	push	word ptr [bp-6h]
3390:0B46 FF 76 F8        	push	word ptr [bp-8h]
3390:0B49 9A E6 02 8D 39  	call	far 398Dh:02E6h
3390:0B4E 59              	pop	cx
3390:0B4F 59              	pop	cx
3390:0B50 46              	inc	si
3390:0B51 E9 8A 00        	jmp	0BDEh

l3390_0B54:
3390:0B54 8B C6           	mov	ax,si
3390:0B56 BA 12 00        	mov	dx,12h
3390:0B59 F7 E2           	mul	dx
3390:0B5B 8B D8           	mov	bx,ax
3390:0B5D 81 C3 B0 10     	add	bx,10B0h
3390:0B61 1E              	push	ds
3390:0B62 07              	pop	es
3390:0B63 26 FF 77 06     	push	word ptr es:[bx+6h]
3390:0B67 26 FF 77 04     	push	word ptr es:[bx+4h]
3390:0B6B FF 76 FA        	push	word ptr [bp-6h]
3390:0B6E FF 76 F8        	push	word ptr [bp-8h]
3390:0B71 57              	push	di
3390:0B72 9A 05 00 3C 39  	call	far 393Ch:0005h
3390:0B77 83 C4 0A        	add	sp,0Ah
3390:0B7A 99              	cwd
3390:0B7B 52              	push	dx
3390:0B7C 50              	push	ax
3390:0B7D 8B C6           	mov	ax,si
3390:0B7F BA 12 00        	mov	dx,12h
3390:0B82 F7 E2           	mul	dx
3390:0B84 8B D8           	mov	bx,ax
3390:0B86 81 C3 B0 10     	add	bx,10B0h
3390:0B8A 1E              	push	ds
3390:0B8B 07              	pop	es
3390:0B8C 58              	pop	ax
3390:0B8D 5A              	pop	dx
3390:0B8E 26 3B 57 06     	cmp	dx,es:[bx+6h]
3390:0B92 75 37           	jnz	0BCBh

l3390_0B94:
3390:0B94 26 3B 47 04     	cmp	ax,es:[bx+4h]
3390:0B98 75 31           	jnz	0BCBh

l3390_0B9A:
3390:0B9A 8B 56 FA        	mov	dx,[bp-6h]
3390:0B9D 8B 46 F8        	mov	ax,[bp-8h]
3390:0BA0 52              	push	dx
3390:0BA1 50              	push	ax
3390:0BA2 8B C6           	mov	ax,si
3390:0BA4 BA 12 00        	mov	dx,12h
3390:0BA7 F7 E2           	mul	dx
3390:0BA9 8B D8           	mov	bx,ax
3390:0BAB 81 C3 B0 10     	add	bx,10B0h
3390:0BAF 1E              	push	ds
3390:0BB0 07              	pop	es
3390:0BB1 58              	pop	ax
3390:0BB2 5A              	pop	dx
3390:0BB3 26 89 57 0A     	mov	es:[bx+0Ah],dx
3390:0BB7 26 89 47 08     	mov	es:[bx+8h],ax
3390:0BBB 57              	push	di
3390:0BBC 9A 0E 00 36 39  	call	far 3936h:000Eh
3390:0BC1 59              	pop	cx
3390:0BC2 46              	inc	si
3390:0BC3 8B 46 FE        	mov	ax,[bp-2h]
3390:0BC6 29 46 FC        	sub	[bp-4h],ax
3390:0BC9 EB 10           	jmp	0BDBh

l3390_0BCB:
3390:0BCB FF 76 FA        	push	word ptr [bp-6h]
3390:0BCE FF 76 F8        	push	word ptr [bp-8h]
3390:0BD1 9A E6 02 8D 39  	call	far 398Dh:02E6h
3390:0BD6 59              	pop	cx
3390:0BD7 59              	pop	cx
3390:0BD8 46              	inc	si
3390:0BD9 EB 03           	jmp	0BDEh

l3390_0BDB:
3390:0BDB EB 01           	jmp	0BDEh

l3390_0BDD:
3390:0BDD 46              	inc	si

l3390_0BDE:
3390:0BDE 8B C6           	mov	ax,si
3390:0BE0 BA 12 00        	mov	dx,12h
3390:0BE3 F7 E2           	mul	dx
3390:0BE5 8B D8           	mov	bx,ax
3390:0BE7 81 C3 B0 10     	add	bx,10B0h
3390:0BEB 1E              	push	ds
3390:0BEC 07              	pop	es
3390:0BED 26 C4 1F        	les	bx,es:[bx]
3390:0BF0 26 80 3F 00     	cmp	byte ptr es:[bx],0h
3390:0BF4 74 03           	jz	0BF9h

l3390_0BF6:
3390:0BF6 E9 5A FE        	jmp	0A53h

l3390_0BF9:
3390:0BF9 5F              	pop	di
3390:0BFA 5E              	pop	si
3390:0BFB 8B E5           	mov	sp,bp
3390:0BFD 5D              	pop	bp
3390:0BFE CB              	retf

;; IsResourceCached: 3390:0BFF
;;   Called from:
;;     3390:005A (in OpenTrackedFile)
;;     3390:0140 (in OpenTrackedFile)
IsResourceCached proc
3390:0BFF 55              	push	bp
3390:0C00 8B EC           	mov	bp,sp
3390:0C02 56              	push	si
3390:0C03 33 F6           	xor	si,si
3390:0C05 FF 76 08        	push	word ptr [bp+8h]
3390:0C08 FF 76 06        	push	word ptr [bp+6h]
3390:0C0B 9A 0C 00 04 3A  	call	far 3A04h:000Ch
3390:0C10 59              	pop	cx
3390:0C11 59              	pop	cx
3390:0C12 89 56 08        	mov	[bp+8h],dx
3390:0C15 89 46 06        	mov	[bp+6h],ax
3390:0C18 EB 4D           	jmp	0C67h

l3390_0C1A:
3390:0C1A FF 76 08        	push	word ptr [bp+8h]
3390:0C1D FF 76 06        	push	word ptr [bp+6h]
3390:0C20 8B C6           	mov	ax,si
3390:0C22 BA 12 00        	mov	dx,12h
3390:0C25 F7 E2           	mul	dx
3390:0C27 8B D8           	mov	bx,ax
3390:0C29 81 C3 B0 10     	add	bx,10B0h
3390:0C2D 1E              	push	ds
3390:0C2E 07              	pop	es
3390:0C2F 26 FF 77 02     	push	word ptr es:[bx+2h]
3390:0C33 26 FF 37        	push	word ptr es:[bx]
3390:0C36 9A 0E 00 7F 39  	call	far 397Fh:000Eh
3390:0C3B 83 C4 08        	add	sp,8h
3390:0C3E 0B C0           	or	ax,ax
3390:0C40 75 24           	jnz	0C66h

l3390_0C42:
3390:0C42 8B C6           	mov	ax,si
3390:0C44 BA 12 00        	mov	dx,12h
3390:0C47 F7 E2           	mul	dx
3390:0C49 8B D8           	mov	bx,ax
3390:0C4B 81 C3 B0 10     	add	bx,10B0h
3390:0C4F 1E              	push	ds
3390:0C50 07              	pop	es
3390:0C51 26 8B 47 08     	mov	ax,es:[bx+8h]
3390:0C55 26 0B 47 0A     	or	ax,es:[bx+0Ah]
3390:0C59 74 07           	jz	0C62h

l3390_0C5B:
3390:0C5B B8 01 00        	mov	ax,1h
3390:0C5E EB 23           	jmp	0C83h
3390:0C60 EB 04                                           ..              

l3390_0C62:
3390:0C62 33 C0           	xor	ax,ax
3390:0C64 EB 1D           	jmp	0C83h

l3390_0C66:
3390:0C66 46              	inc	si

l3390_0C67:
3390:0C67 8B C6           	mov	ax,si
3390:0C69 BA 12 00        	mov	dx,12h
3390:0C6C F7 E2           	mul	dx
3390:0C6E 8B D8           	mov	bx,ax
3390:0C70 81 C3 B0 10     	add	bx,10B0h
3390:0C74 1E              	push	ds
3390:0C75 07              	pop	es
3390:0C76 26 C4 1F        	les	bx,es:[bx]
3390:0C79 26 80 3F 00     	cmp	byte ptr es:[bx],0h
3390:0C7D 75 9B           	jnz	0C1Ah

l3390_0C7F:
3390:0C7F 33 C0           	xor	ax,ax
3390:0C81 EB 00           	jmp	0C83h

l3390_0C83:
3390:0C83 5E              	pop	si
3390:0C84 5D              	pop	bp
3390:0C85 CB              	retf

;; FindResourceDescriptorIndex: 3390:0C86
;;   Called from:
;;     3390:01CB (in OpenTrackedFile)
FindResourceDescriptorIndex proc
3390:0C86 55              	push	bp
3390:0C87 8B EC           	mov	bp,sp
3390:0C89 56              	push	si
3390:0C8A 33 F6           	xor	si,si
3390:0C8C FF 76 08        	push	word ptr [bp+8h]
3390:0C8F FF 76 06        	push	word ptr [bp+6h]
3390:0C92 9A 0C 00 04 3A  	call	far 3A04h:000Ch
3390:0C97 59              	pop	cx
3390:0C98 59              	pop	cx
3390:0C99 89 56 08        	mov	[bp+8h],dx
3390:0C9C 89 46 06        	mov	[bp+6h],ax
3390:0C9F EB 2D           	jmp	0CCEh

l3390_0CA1:
3390:0CA1 FF 76 08        	push	word ptr [bp+8h]
3390:0CA4 FF 76 06        	push	word ptr [bp+6h]
3390:0CA7 8B C6           	mov	ax,si
3390:0CA9 BA 12 00        	mov	dx,12h
3390:0CAC F7 E2           	mul	dx
3390:0CAE 8B D8           	mov	bx,ax
3390:0CB0 81 C3 B0 10     	add	bx,10B0h
3390:0CB4 1E              	push	ds
3390:0CB5 07              	pop	es
3390:0CB6 26 FF 77 02     	push	word ptr es:[bx+2h]
3390:0CBA 26 FF 37        	push	word ptr es:[bx]
3390:0CBD 9A 0E 00 7F 39  	call	far 397Fh:000Eh
3390:0CC2 83 C4 08        	add	sp,8h
3390:0CC5 0B C0           	or	ax,ax
3390:0CC7 75 04           	jnz	0CCDh

l3390_0CC9:
3390:0CC9 8B C6           	mov	ax,si
3390:0CCB EB 27           	jmp	0CF4h

l3390_0CCD:
3390:0CCD 46              	inc	si

l3390_0CCE:
3390:0CCE 8B C6           	mov	ax,si
3390:0CD0 BA 12 00        	mov	dx,12h
3390:0CD3 F7 E2           	mul	dx
3390:0CD5 8B D8           	mov	bx,ax
3390:0CD7 81 C3 B0 10     	add	bx,10B0h
3390:0CDB 1E              	push	ds
3390:0CDC 07              	pop	es
3390:0CDD 26 C4 1F        	les	bx,es:[bx]
3390:0CE0 26 80 3F 00     	cmp	byte ptr es:[bx],0h
3390:0CE4 75 BB           	jnz	0CA1h

l3390_0CE6:
3390:0CE6 FF 36 B0 5F     	push	word ptr [5FB0h]
3390:0CEA FF 36 AE 5F     	push	word ptr [5FAEh]
3390:0CEE 0E              	push	cs
3390:0CEF E8 10 F3        	call	0002h
3390:0CF2 59              	pop	cx
3390:0CF3 59              	pop	cx

l3390_0CF4:
3390:0CF4 5E              	pop	si
3390:0CF5 5D              	pop	bp
3390:0CF6 CB              	retf

;; ReadCachedResource: 3390:0CF7
;;   Called from:
;;     3390:02D5 (in ReadTrackedFile)
ReadCachedResource proc
3390:0CF7 55              	push	bp
3390:0CF8 8B EC           	mov	bp,sp
3390:0CFA 83 EC 04        	sub	sp,4h
3390:0CFD 56              	push	si
3390:0CFE 8B 76 06        	mov	si,[bp+6h]
3390:0D01 8B C6           	mov	ax,si
3390:0D03 BA 12 00        	mov	dx,12h
3390:0D06 F7 E2           	mul	dx
3390:0D08 8B D8           	mov	bx,ax
3390:0D0A 81 C3 B0 10     	add	bx,10B0h
3390:0D0E 1E              	push	ds
3390:0D0F 07              	pop	es
3390:0D10 26 8B 57 10     	mov	dx,es:[bx+10h]
3390:0D14 26 8B 47 0E     	mov	ax,es:[bx+0Eh]
3390:0D18 03 46 0C        	add	ax,[bp+0Ch]
3390:0D1B 13 56 0E        	adc	dx,[bp+0Eh]
3390:0D1E 52              	push	dx
3390:0D1F 50              	push	ax
3390:0D20 8B C6           	mov	ax,si
3390:0D22 BA 12 00        	mov	dx,12h
3390:0D25 F7 E2           	mul	dx
3390:0D27 8B D8           	mov	bx,ax
3390:0D29 81 C3 B0 10     	add	bx,10B0h
3390:0D2D 1E              	push	ds
3390:0D2E 07              	pop	es
3390:0D2F 58              	pop	ax
3390:0D30 5A              	pop	dx
3390:0D31 26 3B 57 06     	cmp	dx,es:[bx+6h]
3390:0D35 7C 40           	jl	0D77h

l3390_0D37:
3390:0D37 7F 06           	jg	0D3Fh

l3390_0D39:
3390:0D39 26 3B 47 04     	cmp	ax,es:[bx+4h]
3390:0D3D 76 38           	jbe	0D77h

l3390_0D3F:
3390:0D3F 8B C6           	mov	ax,si
3390:0D41 BA 12 00        	mov	dx,12h
3390:0D44 F7 E2           	mul	dx
3390:0D46 8B D8           	mov	bx,ax
3390:0D48 81 C3 B0 10     	add	bx,10B0h
3390:0D4C 1E              	push	ds
3390:0D4D 07              	pop	es
3390:0D4E 26 8B 57 06     	mov	dx,es:[bx+6h]
3390:0D52 26 8B 47 04     	mov	ax,es:[bx+4h]
3390:0D56 52              	push	dx
3390:0D57 50              	push	ax
3390:0D58 8B C6           	mov	ax,si
3390:0D5A BA 12 00        	mov	dx,12h
3390:0D5D F7 E2           	mul	dx
3390:0D5F 8B D8           	mov	bx,ax
3390:0D61 81 C3 B0 10     	add	bx,10B0h
3390:0D65 1E              	push	ds
3390:0D66 07              	pop	es
3390:0D67 58              	pop	ax
3390:0D68 5A              	pop	dx
3390:0D69 26 2B 47 0E     	sub	ax,es:[bx+0Eh]
3390:0D6D 26 1B 57 10     	sbb	dx,es:[bx+10h]
3390:0D71 89 56 0E        	mov	[bp+0Eh],dx
3390:0D74 89 46 0C        	mov	[bp+0Ch],ax

l3390_0D77:
3390:0D77 8B C6           	mov	ax,si
3390:0D79 BA 12 00        	mov	dx,12h
3390:0D7C F7 E2           	mul	dx
3390:0D7E 8B D8           	mov	bx,ax
3390:0D80 81 C3 B0 10     	add	bx,10B0h
3390:0D84 1E              	push	ds
3390:0D85 07              	pop	es
3390:0D86 26 8B 57 0A     	mov	dx,es:[bx+0Ah]
3390:0D8A 26 8B 47 08     	mov	ax,es:[bx+8h]
3390:0D8E 52              	push	dx
3390:0D8F 50              	push	ax
3390:0D90 8B C6           	mov	ax,si
3390:0D92 BA 12 00        	mov	dx,12h
3390:0D95 F7 E2           	mul	dx
3390:0D97 8B D8           	mov	bx,ax
3390:0D99 81 C3 B0 10     	add	bx,10B0h
3390:0D9D 1E              	push	ds
3390:0D9E 07              	pop	es
3390:0D9F 58              	pop	ax
3390:0DA0 5A              	pop	dx
3390:0DA1 26 03 47 0E     	add	ax,es:[bx+0Eh]
3390:0DA5 52              	push	dx
3390:0DA6 50              	push	ax
3390:0DA7 9A 9E 3B 00 08  	call	far 0800h:3B9Eh
3390:0DAC 59              	pop	cx
3390:0DAD 59              	pop	cx
3390:0DAE 89 56 FE        	mov	[bp-2h],dx
3390:0DB1 89 46 FC        	mov	[bp-4h],ax
3390:0DB4 FF 76 0E        	push	word ptr [bp+0Eh]
3390:0DB7 FF 76 0C        	push	word ptr [bp+0Ch]
3390:0DBA FF 76 0A        	push	word ptr [bp+0Ah]
3390:0DBD FF 76 08        	push	word ptr [bp+8h]
3390:0DC0 FF 76 FE        	push	word ptr [bp-2h]
3390:0DC3 FF 76 FC        	push	word ptr [bp-4h]
3390:0DC6 9A C8 2E 00 08  	call	far 0800h:2EC8h
3390:0DCB 83 C4 0C        	add	sp,0Ch
3390:0DCE 8B 56 0E        	mov	dx,[bp+0Eh]
3390:0DD1 8B 46 0C        	mov	ax,[bp+0Ch]
3390:0DD4 52              	push	dx
3390:0DD5 50              	push	ax
3390:0DD6 8B C6           	mov	ax,si
3390:0DD8 BA 12 00        	mov	dx,12h
3390:0DDB F7 E2           	mul	dx
3390:0DDD 8B D8           	mov	bx,ax
3390:0DDF 81 C3 B0 10     	add	bx,10B0h
3390:0DE3 1E              	push	ds
3390:0DE4 07              	pop	es
3390:0DE5 58              	pop	ax
3390:0DE6 5A              	pop	dx
3390:0DE7 26 01 47 0E     	add	es:[bx+0Eh],ax
3390:0DEB 26 11 57 10     	adc	es:[bx+10h],dx
3390:0DEF 8B 56 0E        	mov	dx,[bp+0Eh]
3390:0DF2 8B 46 0C        	mov	ax,[bp+0Ch]
3390:0DF5 EB 00           	jmp	0DF7h

l3390_0DF7:
3390:0DF7 5E              	pop	si
3390:0DF8 8B E5           	mov	sp,bp
3390:0DFA 5D              	pop	bp
3390:0DFB CB              	retf

;; AdjustActiveTextWindowMargin_0DFC: 3390:0DFC
;;   Called from:
;;     0D73:47AC (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:47F3 (in ShowInvalidSaveVersionDialog_4611)
AdjustActiveTextWindowMargin_0DFC proc
3390:0DFC 55              	push	bp
3390:0DFD 8B EC           	mov	bp,sp
3390:0DFF 56              	push	si
3390:0E00 8B 76 06        	mov	si,[bp+6h]
3390:0E03 29 36 30 62     	sub	[6230h],si
3390:0E07 29 36 32 62     	sub	[6232h],si
3390:0E0B 8B C6           	mov	ax,si
3390:0E0D D1 E0           	shl	ax,1h
3390:0E0F 01 06 34 62     	add	[6234h],ax
