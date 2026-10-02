;;; Segment 0D56 (0D56:0000)

l0800_5560:
0800:5560 1F              	pop	ds
0800:5561 5F              	pop	di
0800:5562 5E              	pop	si
0800:5563 5D              	pop	bp
0800:5564 CA 08 00        	retf	8h

;; PrintAllocationErrorAndExit: 0D56:0007
;;   Called from:
;;     0D56:00D2 (in AllocateFarMemory)
;;     0D56:00FF (in AllocateFarMemory)
;;     0D56:014D (in AllocateParagraphAlignedMemory)
PrintAllocationErrorAndExit proc
0D56:0007 55              	push	bp
0D56:0008 8B EC           	mov	bp,sp
0D56:000A 83 EC 14        	sub	sp,14h
0D56:000D B8 06 00        	mov	ax,6h
0D56:0010 50              	push	ax
0D56:0011 9A 50 03 7F 2C  	call	far 2C7Fh:0350h
0D56:0016 59              	pop	cx
0D56:0017 FF 76 08        	push	word ptr [bp+8h]
0D56:001A FF 76 06        	push	word ptr [bp+6h]
0D56:001D 9A 07 00 27 33  	call	far 3327h:0007h
0D56:0022 59              	pop	cx
0D56:0023 59              	pop	cx
0D56:0024 1E              	push	ds
0D56:0025 B8 2B 23        	mov	ax,232Bh
0D56:0028 50              	push	ax
0D56:0029 9A 07 00 27 33  	call	far 3327h:0007h
0D56:002E 59              	pop	cx
0D56:002F 59              	pop	cx
0D56:0030 B8 0A 00        	mov	ax,0Ah
0D56:0033 50              	push	ax
0D56:0034 16              	push	ss
0D56:0035 8D 46 EC        	lea	ax,[bp-14h]
0D56:0038 50              	push	ax
0D56:0039 FF 36 DE B5     	push	word ptr [0B5DEh]
0D56:003D FF 36 DC B5     	push	word ptr [0B5DCh]
0D56:0041 9A DA 00 68 39  	call	far 3968h:00DAh
0D56:0046 83 C4 0A        	add	sp,0Ah
0D56:0049 16              	push	ss
0D56:004A 8D 46 EC        	lea	ax,[bp-14h]
0D56:004D 50              	push	ax
0D56:004E 9A 07 00 27 33  	call	far 3327h:0007h
0D56:0053 59              	pop	cx
0D56:0054 59              	pop	cx
0D56:0055 1E              	push	ds
0D56:0056 B8 3F 23        	mov	ax,233Fh
0D56:0059 50              	push	ax
0D56:005A 9A 07 00 27 33  	call	far 3327h:0007h
0D56:005F 59              	pop	cx
0D56:0060 59              	pop	cx
0D56:0061 1E              	push	ds
0D56:0062 B8 49 23        	mov	ax,2349h
0D56:0065 50              	push	ax
0D56:0066 9A 07 00 27 33  	call	far 3327h:0007h
0D56:006B 59              	pop	cx
0D56:006C 59              	pop	cx
0D56:006D B8 0A 00        	mov	ax,0Ah
0D56:0070 50              	push	ax
0D56:0071 16              	push	ss
0D56:0072 8D 46 EC        	lea	ax,[bp-14h]
0D56:0075 50              	push	ax
0D56:0076 9A 0F 00 8B 39  	call	far 398Bh:000Fh
0D56:007B 52              	push	dx
0D56:007C 50              	push	ax
0D56:007D 9A DA 00 68 39  	call	far 3968h:00DAh
0D56:0082 83 C4 0A        	add	sp,0Ah
0D56:0085 16              	push	ss
0D56:0086 8D 46 EC        	lea	ax,[bp-14h]
0D56:0089 50              	push	ax
0D56:008A 9A 07 00 27 33  	call	far 3327h:0007h
0D56:008F 59              	pop	cx
0D56:0090 59              	pop	cx
0D56:0091 1E              	push	ds
0D56:0092 B8 4F 23        	mov	ax,234Fh
0D56:0095 50              	push	ax
0D56:0096 9A 07 00 27 33  	call	far 3327h:0007h
0D56:009B 59              	pop	cx
0D56:009C 59              	pop	cx
0D56:009D 9A 5C 04 7F 2C  	call	far 2C7Fh:045Ch
0D56:00A2 9A E3 02 7F 2C  	call	far 2C7Fh:02E3h
0D56:00A7 B8 01 00        	mov	ax,1h
0D56:00AA 50              	push	ax
0D56:00AB 9A 10 00 C6 38  	call	far 38C6h:0010h
0D56:00B0 59              	pop	cx
0D56:00B1 8B E5           	mov	sp,bp
0D56:00B3 5D              	pop	bp
0D56:00B4 CB              	retf

;; AllocateFarMemory: 0D56:00B5
;;   Called from:
;;     0800:36C0 (in InitializeMouseSupport_36A6)
;;     0D73:562F (in BuildVgaDisplayBackingBuffer_5508)
;;     2C7F:04F1 (in LoadMediaConfiguration_047A)
;;     2FEA:0038 (in BuildPlanarDisplayBackingBuffer_000A)
;;     2FEA:0153 (in BuildPlanarDisplayBackingBuffer_000A)
;;     3014:011E (in AllocateMusicStagingBuffer_0117)
;;     31FB:01D5 (in LoadDigitalWeaponEffectBank_00B3)
;;     31FB:049D (in LoadScenarioDigitalSoundBank_0297)
;;     34D5:003F (in CaptureVideoTileStrip_000C)
AllocateFarMemory proc
0D56:00B5 55              	push	bp
0D56:00B6 8B EC           	mov	bp,sp
0D56:00B8 83 EC 04        	sub	sp,4h
0D56:00BB 56              	push	si
0D56:00BC 8B 76 06        	mov	si,[bp+6h]
0D56:00BF 83 7E 08 00     	cmp	word ptr [bp+8h],0h
0D56:00C3 7C 15           	jl	00DAh

l0D56_00C5:
0D56:00C5 7F 06           	jg	00CDh

l0D56_00C7:
0D56:00C7 83 7E 06 FF     	cmp	word ptr [bp+6h],0FFh
0D56:00CB 76 0D           	jbe	00DAh

l0D56_00CD:
0D56:00CD 1E              	push	ds
0D56:00CE B8 5E 23        	mov	ax,235Eh
0D56:00D1 50              	push	ax
0D56:00D2 0E              	push	cs
0D56:00D3 E8 31 FF        	call	0007h
0D56:00D6 59              	pop	cx
0D56:00D7 59              	pop	cx
0D56:00D8 EB 2B           	jmp	0105h

l0D56_00DA:
0D56:00DA 56              	push	si
0D56:00DB 9A 02 00 CD 38  	call	far 38CDh:0002h
0D56:00E0 59              	pop	cx
0D56:00E1 89 56 FE        	mov	[bp-2h],dx
0D56:00E4 89 46 FC        	mov	[bp-4h],ax
0D56:00E7 8B 46 FC        	mov	ax,[bp-4h]
0D56:00EA 0B 46 FE        	or	ax,[bp-2h]
0D56:00ED 75 16           	jnz	0105h

l0D56_00EF:
0D56:00EF 8B C6           	mov	ax,si
0D56:00F1 33 D2           	xor	dx,dx
0D56:00F3 89 16 DE B5     	mov	[0B5DEh],dx
0D56:00F7 A3 DC B5        	mov	[0B5DCh],ax
0D56:00FA 1E              	push	ds
0D56:00FB B8 DC 22        	mov	ax,22DCh
0D56:00FE 50              	push	ax
0D56:00FF 0E              	push	cs
0D56:0100 E8 04 FF        	call	0007h
0D56:0103 59              	pop	cx
0D56:0104 59              	pop	cx

l0D56_0105:
0D56:0105 8B 56 FE        	mov	dx,[bp-2h]
0D56:0108 8B 46 FC        	mov	ax,[bp-4h]
0D56:010B EB 00           	jmp	010Dh

l0D56_010D:
0D56:010D 5E              	pop	si
0D56:010E 8B E5           	mov	sp,bp
0D56:0110 5D              	pop	bp
0D56:0111 CB              	retf

;; AllocateParagraphAlignedMemory: 0D56:0112
;;   Called from:
;;     0D73:466E (in ShowInvalidSaveVersionDialog_4611)
;;     21E7:0163 (in DecodeWestwoodPackedResource_00F4)
;;     21E7:01B8 (in DecodeWestwoodPackedResource_00F4)
;;     2C7F:0203 (in InitializeGame_003C)
AllocateParagraphAlignedMemory proc
0D56:0112 55              	push	bp
0D56:0113 8B EC           	mov	bp,sp
0D56:0115 83 EC 06        	sub	sp,6h
0D56:0118 83 46 06 10     	add	word ptr [bp+6h],10h
0D56:011C 83 56 08 00     	adc	word ptr [bp+8h],0h
0D56:0120 FF 76 08        	push	word ptr [bp+8h]
0D56:0123 FF 76 06        	push	word ptr [bp+6h]
0D56:0126 9A 03 02 CD 38  	call	far 38CDh:0203h
0D56:012B 59              	pop	cx
0D56:012C 59              	pop	cx
0D56:012D 89 56 FC        	mov	[bp-4h],dx
0D56:0130 89 46 FA        	mov	[bp-6h],ax
0D56:0133 8B 46 FA        	mov	ax,[bp-6h]
0D56:0136 0B 46 FC        	or	ax,[bp-4h]
0D56:0139 75 18           	jnz	0153h

l0D56_013B:
0D56:013B 8B 56 08        	mov	dx,[bp+8h]
0D56:013E 8B 46 06        	mov	ax,[bp+6h]
0D56:0141 89 16 DE B5     	mov	[0B5DEh],dx
0D56:0145 A3 DC B5        	mov	[0B5DCh],ax
0D56:0148 1E              	push	ds
0D56:0149 B8 DC 22        	mov	ax,22DCh
0D56:014C 50              	push	ax
0D56:014D 0E              	push	cs
0D56:014E E8 B6 FE        	call	0007h
0D56:0151 59              	pop	cx
0D56:0152 59              	pop	cx

l0D56_0153:
0D56:0153 B8 10 00        	mov	ax,10h
0D56:0156 2B 46 FA        	sub	ax,[bp-6h]
0D56:0159 89 46 FE        	mov	[bp-2h],ax
0D56:015C 8A 46 FE        	mov	al,[bp-2h]
0D56:015F C4 5E FA        	les	bx,[bp-6h]
0D56:0162 03 5E FE        	add	bx,[bp-2h]
0D56:0165 4B              	dec	bx
0D56:0166 26 88 07        	mov	es:[bx],al
0D56:0169 8B 56 FC        	mov	dx,[bp-4h]
0D56:016C 42              	inc	dx
0D56:016D 33 C0           	xor	ax,ax
0D56:016F 89 56 FC        	mov	[bp-4h],dx
0D56:0172 89 46 FA        	mov	[bp-6h],ax
0D56:0175 8B 56 FC        	mov	dx,[bp-4h]
0D56:0178 8B 46 FA        	mov	ax,[bp-6h]
0D56:017B EB 00           	jmp	017Dh

l0D56_017D:
0D56:017D 8B E5           	mov	sp,bp
0D56:017F 5D              	pop	bp
0D56:0180 CB              	retf

;; FreeFarMemory: 0D56:0181
;;   Called from:
;;     0D73:041F (in RebuildTacticalVideoResources_0387)
;;     0D73:412E (in RebuildMouseCursorBackingBuffer_4126)
;;     2C7F:0639 (in LoadMediaConfiguration_047A)
;;     3014:013B (in ReleaseMusicDriverBuffer_0133)
;;     31FB:12AF (in ReleaseDigitalWeaponEffectBank_12A7)
;;     31FB:12BF (in ReleaseDigitalSoundBuffer_12B7)
FreeFarMemory proc
0D56:0181 55              	push	bp
0D56:0182 8B EC           	mov	bp,sp
0D56:0184 8B 46 06        	mov	ax,[bp+6h]
0D56:0187 0B 46 08        	or	ax,[bp+8h]
0D56:018A 74 0D           	jz	0199h

l0D56_018C:
0D56:018C FF 76 08        	push	word ptr [bp+8h]
0D56:018F FF 76 06        	push	word ptr [bp+6h]
0D56:0192 9A 0C 00 8D 39  	call	far 398Dh:000Ch
0D56:0197 8B E5           	mov	sp,bp

l0D56_0199:
0D56:0199 C7 46 08 00 00  	mov	word ptr [bp+8h],0h
0D56:019E C7 46 06 00 00  	mov	word ptr [bp+6h],0h
0D56:01A3 5D              	pop	bp
0D56:01A4 CB              	retf

;; FreeParagraphAlignedMemory: 0D56:01A5
;;   Called from:
;;     0D73:4838 (in ShowInvalidSaveVersionDialog_4611)
;;     21E7:018A (in DecodeWestwoodPackedResource_00F4)
;;     21E7:01DF (in DecodeWestwoodPackedResource_00F4)
FreeParagraphAlignedMemory proc
0D56:01A5 55              	push	bp
0D56:01A6 8B EC           	mov	bp,sp
0D56:01A8 83 EC 04        	sub	sp,4h
0D56:01AB 56              	push	si
0D56:01AC 8B 56 08        	mov	dx,[bp+8h]
0D56:01AF 4A              	dec	dx
0D56:01B0 B8 0F 00        	mov	ax,0Fh
0D56:01B3 89 56 FE        	mov	[bp-2h],dx
0D56:01B6 89 46 FC        	mov	[bp-4h],ax
0D56:01B9 C4 5E FC        	les	bx,[bp-4h]
0D56:01BC 26 8A 07        	mov	al,es:[bx]
0D56:01BF B4 00           	mov	ah,0h
0D56:01C1 8B F0           	mov	si,ax
0D56:01C3 8B 56 FE        	mov	dx,[bp-2h]
0D56:01C6 8B C6           	mov	ax,si
0D56:01C8 52              	push	dx
0D56:01C9 50              	push	ax
0D56:01CA 9A E6 02 8D 39  	call	far 398Dh:02E6h
0D56:01CF 59              	pop	cx
