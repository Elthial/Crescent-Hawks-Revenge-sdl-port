;;; Segment 3621 (3621:0000)

l35CE_0530:
35CE:0530 5F              	pop	di
35CE:0531 5E              	pop	si
35CE:0532 8B E5           	mov	sp,bp
35CE:0534 5D              	pop	bp
35CE:0535 CB              	retf
35CE:0536                   A1 5A 62 CB C6 06 64 62 01 CB       .Zb...db..
35CE:0540 C6 06 64 62 00 CB 55 8B EC 56 57 BE 5E 62 C4 7E ..db..U..VW.^b.~
35CE:0550 06 B9 03 00 FC C6 06 64 62 01 F3 A5 C6 06 64 62 .......db.....db
35CE:0560 00 5F 5E 5D CB                                  ._^].           

;; SetMIDITimingDivisor_0035: 3621:0035
;;   Called from:
;;     3014:006A (in InitializeMusicDriver_0038)
;;     3014:0090 (in InitializeMusicDriver_0038)
;;     3014:00B5 (in InitializeMusicDriver_0038)
;;     3014:00DA (in InitializeMusicDriver_0038)
;;     3014:00FF (in InitializeMusicDriver_0038)
SetMIDITimingDivisor_0035 proc
3621:0035 55              	push	bp
3621:0036 8B EC           	mov	bp,sp
3621:0038 8B 46 06        	mov	ax,[bp+6h]
3621:003B 0B C0           	or	ax,ax
3621:003D 74 0A           	jz	0049h

l3621_003F:
3621:003F FA              	cli
3621:0040 A3 4C 62        	mov	[624Ch],ax
3621:0043 33 C0           	xor	ax,ax
3621:0045 A3 50 62        	mov	[6250h],ax
3621:0048 FB              	sti

l3621_0049:
3621:0049 5D              	pop	bp
3621:004A CB              	retf

;; ConfigureMIDITempo_004B: 3621:004B
;;   Called from:
;;     3621:030D (in ServiceMIDISequenceTick_01E8)
ConfigureMIDITempo_004B proc
3621:004B 55              	push	bp
3621:004C 8B EC           	mov	bp,sp
3621:004E 8B 46 08        	mov	ax,[bp+8h]
3621:0051 A3 4A 62        	mov	[624Ah],ax
3621:0054 F7 66 06        	mul	word ptr [bp+6h]
3621:0057 FA              	cli
3621:0058 A3 4E 62        	mov	[624Eh],ax
3621:005B 33 C0           	xor	ax,ax
3621:005D A3 50 62        	mov	[6250h],ax
3621:0060 FB              	sti
3621:0061 5D              	pop	bp
3621:0062 CB              	retf

;; ConfigureMIDITimeSignature_0063: 3621:0063
;;   Called from:
;;     3621:0337 (in ServiceMIDISequenceTick_01E8)
ConfigureMIDITimeSignature_0063 proc
3621:0063 55              	push	bp
3621:0064 8B EC           	mov	bp,sp
3621:0066 8B 46 0A        	mov	ax,[bp+0Ah]
3621:0069 A3 54 62        	mov	[6254h],ax
3621:006C F7 66 08        	mul	word ptr [bp+8h]
3621:006F 8B D8           	mov	bx,ax
3621:0071 B8 80 01        	mov	ax,180h
3621:0074 F7 66 06        	mul	word ptr [bp+6h]
3621:0077 F7 F3           	div	bx
3621:0079 A3 52 62        	mov	[6252h],ax
3621:007C 5D              	pop	bp
3621:007D CB              	retf

;; SendMIDIAllNotesOff_007E: 3621:007E
;;   Called from:
;;     3621:011F (in StartMIDISequence_00C1)
;;     3621:01A8 (in PauseMIDISequence_0193)
;;     3621:01DF (in StopMIDISequence_01CC)
SendMIDIAllNotesOff_007E proc
3621:007E B9 10 00        	mov	cx,10h

l3621_0081:
3621:0081 51              	push	cx
3621:0082 8B C1           	mov	ax,cx
3621:0084 04 AF           	add	al,0AFh
3621:0086 50              	push	ax
3621:0087 9A EE 03 21 36  	call	far 3621h:03EEh
3621:008C 83 C4 02        	add	sp,2h
3621:008F B8 7B 00        	mov	ax,7Bh
3621:0092 50              	push	ax
3621:0093 9A EE 03 21 36  	call	far 3621h:03EEh
3621:0098 83 C4 02        	add	sp,2h
3621:009B 33 C0           	xor	ax,ax
3621:009D 50              	push	ax
3621:009E 9A EE 03 21 36  	call	far 3621h:03EEh
3621:00A3 83 C4 02        	add	sp,2h
3621:00A6 59              	pop	cx
3621:00A7 E2 D8           	loop	0081h

l3621_00A9:
3621:00A9 C3              	ret

;; ReadMIDIVariableLengthQuantity_00AA: 3621:00AA
;;   Called from:
;;     3621:0129 (in StartMIDISequence_00C1)
;;     3621:0290 (in ServiceMIDISequenceTick_01E8)
;;     3621:02B1 (in ServiceMIDISequenceTick_01E8)
;;     3621:0341 (in ServiceMIDISequenceTick_01E8)
ReadMIDIVariableLengthQuantity_00AA proc
3621:00AA 33 C0           	xor	ax,ax
3621:00AC 8B D0           	mov	dx,ax

l3621_00AE:
3621:00AE 8A F2           	mov	dh,dl
3621:00B0 8A D4           	mov	dl,ah
3621:00B2 8A E0           	mov	ah,al
3621:00B4 26 8A 04        	mov	al,es:[si]
3621:00B7 46              	inc	si
3621:00B8 D0 C0           	rol	al,1h
3621:00BA D1 EA           	shr	dx,1h
3621:00BC D1 D8           	rcr	ax,1h
3621:00BE 72 EE           	jc	00AEh

l3621_00C0:
3621:00C0 C3              	ret

;; StartMIDISequence_00C1: 3621:00C1
;;   Called from:
;;     3014:016B (in StartLoadedMusicTrack_0153)
StartMIDISequence_00C1 proc
3621:00C1 55              	push	bp
3621:00C2 8B EC           	mov	bp,sp
3621:00C4 F7 46 0A 01 00  	test	word ptr [bp+0Ah],1h
3621:00C9 75 03           	jnz	00CEh

l3621_00CB:
3621:00CB E9 87 00        	jmp	0155h

l3621_00CE:
3621:00CE 56              	push	si
3621:00CF 1E              	push	ds
3621:00D0 C5 76 06        	lds	si,[bp+6h]
3621:00D3 FC              	cld
3621:00D4 AD              	lodsw
3621:00D5 3D 4D 54        	cmp	ax,544Dh
3621:00D8 75 79           	jnz	0153h

l3621_00DA:
3621:00DA AD              	lodsw
3621:00DB 3D 68 64        	cmp	ax,6468h
3621:00DE 75 73           	jnz	0153h

l3621_00E0:
3621:00E0 83 C6 02        	add	si,2h
3621:00E3 AD              	lodsw
3621:00E4 86 E0           	xchg	al,ah
3621:00E6 8B C8           	mov	cx,ax
3621:00E8 83 3C 00        	cmp	word ptr [si],0h
3621:00EB 75 66           	jnz	0153h

l3621_00ED:
3621:00ED 81 7C 02 00 01  	cmp	word ptr [si+2h],100h
3621:00F2 75 5F           	jnz	0153h

l3621_00F4:
3621:00F4 81 7C 04 00 60  	cmp	word ptr [si+4h],6000h
3621:00F9 75 58           	jnz	0153h

l3621_00FB:
3621:00FB 03 F1           	add	si,cx
3621:00FD AD              	lodsw
3621:00FE 3D 4D 54        	cmp	ax,544Dh
3621:0101 75 50           	jnz	0153h

l3621_0103:
3621:0103 AD              	lodsw
3621:0104 3D 72 6B        	cmp	ax,6B72h
3621:0107 75 4A           	jnz	0153h

l3621_0109:
3621:0109 83 C6 04        	add	si,4h
3621:010C 8C D8           	mov	ax,ds
3621:010E 8E C0           	mov	es,ax
3621:0110 1F              	pop	ds
3621:0111 C6 06 64 62 01  	mov	byte ptr [6264h],1h
3621:0116 F7 06 5A 62 01 00 	test	word ptr [625Ah],1h
3621:011C 74 05           	jz	0123h

l3621_011E:
3621:011E 06              	push	es
3621:011F E8 5C FF        	call	007Eh
3621:0122 07              	pop	es

l3621_0123:
3621:0123 C7 06 5A 62 00 00 	mov	word ptr [625Ah],0h
3621:0129 E8 7E FF        	call	00AAh
3621:012C A3 5C 62        	mov	[625Ch],ax
3621:012F 89 36 56 62     	mov	[6256h],si
3621:0133 8C 06 58 62     	mov	[6258h],es
3621:0137 8B 46 0A        	mov	ax,[bp+0Ah]
3621:013A A3 5A 62        	mov	[625Ah],ax
3621:013D 33 D2           	xor	dx,dx
3621:013F 89 16 5E 62     	mov	[625Eh],dx
3621:0143 89 16 60 62     	mov	[6260h],dx
3621:0147 89 16 62 62     	mov	[6262h],dx
3621:014B C6 06 64 62 00  	mov	byte ptr [6264h],0h
3621:0150 5E              	pop	si
3621:0151 5D              	pop	bp
3621:0152 CB              	retf

l3621_0153:
3621:0153 1F              	pop	ds
3621:0154 5E              	pop	si

l3621_0155:
3621:0155 B8 00 00        	mov	ax,0h
3621:0158 5D              	pop	bp
3621:0159 CB              	retf
3621:015A                               A1 5A 62 25 03 00           .Zb%..
3621:0160 3D 01 00 75 12 C6 06 64 62 01 83 0E 5A 62 02 E8 =..u...db...Zb..
3621:0170 0C FF C6 06 64 62 00 CB A1 5A 62 25 03 00 3D 03 ....db...Zb%..=.
3621:0180 00 75 0F C6 06 64 62 01 83 26 5A 62 FD C6 06 64 .u...db..&Zb...d
3621:0190 62 00 CB                                        b..             

;; PauseMIDISequence_0193: 3621:0193
;;   Called from:
;;     3014:000E (in DisableMusicPlayback_000E)
PauseMIDISequence_0193 proc
3621:0193 A1 5A 62        	mov	ax,[625Ah]
3621:0196 25 05 00        	and	ax,5h
3621:0199 3D 01 00        	cmp	ax,1h
3621:019C 75 12           	jnz	01B0h

l3621_019E:
3621:019E C6 06 64 62 01  	mov	byte ptr [6264h],1h
3621:01A3 83 0E 5A 62 04  	or	word ptr [625Ah],4h
3621:01A8 E8 D3 FE        	call	007Eh
3621:01AB C6 06 64 62 00  	mov	byte ptr [6264h],0h

l3621_01B0:
3621:01B0 CB              	retf

;; ResumeMIDISequence_01B1: 3621:01B1
;;   Called from:
;;     3014:001A (in EnableMusicPlayback_001A)
ResumeMIDISequence_01B1 proc
3621:01B1 A1 5A 62        	mov	ax,[625Ah]
3621:01B4 25 05 00        	and	ax,5h
3621:01B7 3D 05 00        	cmp	ax,5h
3621:01BA 75 0F           	jnz	01CBh

l3621_01BC:
3621:01BC C6 06 64 62 01  	mov	byte ptr [6264h],1h
3621:01C1 83 26 5A 62 FB  	and	word ptr [625Ah],0FBh
3621:01C6 C6 06 64 62 00  	mov	byte ptr [6264h],0h

l3621_01CB:
3621:01CB CB              	retf

;; StopMIDISequence_01CC: 3621:01CC
;;   Called from:
;;     3014:0143 (in ShutdownMusicDriver_0143)
;;     3014:0185 (in StopLoadedMusicTrack_0185)
;;     3621:02E4 (in ServiceMIDISequenceTick_01E8)
StopMIDISequence_01CC proc
3621:01CC F7 06 5A 62 01 00 	test	word ptr [625Ah],1h
3621:01D2 74 13           	jz	01E7h

l3621_01D4:
3621:01D4 C6 06 64 62 01  	mov	byte ptr [6264h],1h
3621:01D9 C7 06 5A 62 00 00 	mov	word ptr [625Ah],0h
3621:01DF E8 9C FE        	call	007Eh
3621:01E2 C6 06 64 62 00  	mov	byte ptr [6264h],0h

l3621_01E7:
3621:01E7 CB              	retf

;; ServiceMIDISequenceTick_01E8: 3621:01E8
;;   Called from:
;;     30B2:00CC (in MusicTimerIRQ0Handler_0010)
ServiceMIDISequenceTick_01E8 proc
3621:01E8 FB              	sti
3621:01E9 A1 5A 62        	mov	ax,[625Ah]
3621:01EC 25 03 00        	and	ax,3h
3621:01EF 3D 01 00        	cmp	ax,1h
3621:01F2 74 01           	jz	01F5h

l3621_01F4:
3621:01F4 CB              	retf

l3621_01F5:
3621:01F5 A1 50 62        	mov	ax,[6250h]
3621:01F8 03 06 4E 62     	add	ax,[624Eh]
3621:01FC 33 D2           	xor	dx,dx
3621:01FE F7 36 4C 62     	div	word ptr [624Ch]
3621:0202 89 16 50 62     	mov	[6250h],dx
3621:0206 01 06 5C 62     	add	[625Ch],ax
3621:020A F7 06 5A 62 08 00 	test	word ptr [625Ah],8h
3621:0210 74 20           	jz	0232h

l3621_0212:
3621:0212 03 06 5E 62     	add	ax,[625Eh]
3621:0216 33 D2           	xor	dx,dx
3621:0218 F7 36 52 62     	div	word ptr [6252h]
3621:021C 89 16 5E 62     	mov	[625Eh],dx
3621:0220 03 06 60 62     	add	ax,[6260h]
3621:0224 33 D2           	xor	dx,dx
3621:0226 F7 36 54 62     	div	word ptr [6254h]
3621:022A 89 16 60 62     	mov	[6260h],dx
3621:022E 01 06 62 62     	add	[6262h],ax

l3621_0232:
3621:0232 80 3E 64 62 01  	cmp	byte ptr [6264h],1h
3621:0237 74 3D           	jz	0276h

l3621_0239:
3621:0239 56              	push	si
3621:023A C4 36 56 62     	les	si,[6256h]

l3621_023E:
3621:023E 83 3E 5C 62 00  	cmp	word ptr [625Ch],0h
3621:0243 78 2C           	js	0271h

l3621_0245:
3621:0245 33 C0           	xor	ax,ax
3621:0247 26 8A 04        	mov	al,es:[si]
3621:024A 46              	inc	si
3621:024B 3C 80           	cmp	al,80h
3621:024D 73 04           	jnc	0253h

l3621_024F:
3621:024F A0 65 62        	mov	al,[6265h]
3621:0252 4E              	dec	si

l3621_0253:
3621:0253 8B D8           	mov	bx,ax
3621:0255 3C FF           	cmp	al,0FFh
3621:0257 74 1E           	jz	0277h

l3621_0259:
3621:0259 3C F8           	cmp	al,0F8h
3621:025B 73 1F           	jnc	027Ch

l3621_025D:
3621:025D 3C F0           	cmp	al,0F0h
3621:025F 73 16           	jnc	0277h

l3621_0261:
3621:0261 A2 65 62        	mov	[6265h],al
3621:0264 80 E3 70        	and	bl,70h
3621:0267 D0 EB           	shr	bl,1h
3621:0269 D0 EB           	shr	bl,1h
3621:026B D0 EB           	shr	bl,1h
3621:026D FF A7 66 62     	jmp	word ptr [bx+6266h]

l3621_0271:
3621:0271 89 36 56 62     	mov	[6256h],si
3621:0275 5E              	pop	si

l3621_0276:
3621:0276 CB              	retf

l3621_0277:
3621:0277 C6 06 65 62 00  	mov	byte ptr [6265h],0h

l3621_027C:
3621:027C 80 E3 0F        	and	bl,0Fh
3621:027F D0 E3           	shl	bl,1h
3621:0281 FF A7 74 62     	jmp	word ptr [bx+6274h]

l3621_0285:
3621:0285 06              	push	es
3621:0286 50              	push	ax
3621:0287 9A EE 03 21 36  	call	far 3621h:03EEh
3621:028C 83 C4 02        	add	sp,2h
3621:028F 07              	pop	es

l3621_0290:
3621:0290 E8 17 FE        	call	00AAh
3621:0293 8B C8           	mov	cx,ax

l3621_0295:
3621:0295 33 C0           	xor	ax,ax
3621:0297 26 8A 04        	mov	al,es:[si]
3621:029A 46              	inc	si
3621:029B 51              	push	cx
3621:029C 06              	push	es
3621:029D 50              	push	ax
3621:029E 9A EE 03 21 36  	call	far 3621h:03EEh
3621:02A3 83 C4 02        	add	sp,2h
3621:02A6 07              	pop	es
3621:02A7 59              	pop	cx
3621:02A8 E2 EB           	loop	0295h

l3621_02AA:
3621:02AA E9 94 00        	jmp	0341h

l3621_02AD:
3621:02AD 26 8A 1C        	mov	bl,es:[si]
3621:02B0 46              	inc	si
3621:02B1 E8 F6 FD        	call	00AAh
3621:02B4 03 C6           	add	ax,si
3621:02B6 50              	push	ax
3621:02B7 06              	push	es
3621:02B8 80 FB 01        	cmp	bl,1h
3621:02BB 74 11           	jz	02CEh

l3621_02BD:
3621:02BD 80 FB 2F        	cmp	bl,2Fh
3621:02C0 74 1F           	jz	02E1h

l3621_02C2:
3621:02C2 80 FB 51        	cmp	bl,51h
3621:02C5 74 24           	jz	02EBh

l3621_02C7:
3621:02C7 80 FB 58        	cmp	bl,58h
3621:02CA 74 4B           	jz	0317h

l3621_02CC:
3621:02CC EB 71           	jmp	033Fh

l3621_02CE:
3621:02CE BB 28 67        	mov	bx,6728h
3621:02D1 B9 10 00        	mov	cx,10h

l3621_02D4:
3621:02D4 26 8A 04        	mov	al,es:[si]
3621:02D7 46              	inc	si
3621:02D8 24 0F           	and	al,0Fh
3621:02DA 88 07           	mov	[bx],al
3621:02DC 43              	inc	bx
3621:02DD E2 F5           	loop	02D4h

l3621_02DF:
3621:02DF EB 5E           	jmp	033Fh

l3621_02E1:
3621:02E1 83 C4 04        	add	sp,4h
3621:02E4 9A CC 01 21 36  	call	far 3621h:01CCh
3621:02E9 EB 86           	jmp	0271h

l3621_02EB:
3621:02EB 33 C0           	xor	ax,ax
3621:02ED 26 8A 04        	mov	al,es:[si]
3621:02F0 50              	push	ax
3621:02F1 26 8B 44 01     	mov	ax,es:[si+1h]
3621:02F5 86 E0           	xchg	al,ah
3621:02F7 50              	push	ax
3621:02F8 B8 93 03        	mov	ax,393h
3621:02FB 50              	push	ax
3621:02FC B8 00 87        	mov	ax,8700h
3621:02FF 50              	push	ax
3621:0300 9A 88 03 21 36  	call	far 3621h:0388h
3621:0305 83 C4 08        	add	sp,8h
3621:0308 50              	push	ax
3621:0309 B8 60 00        	mov	ax,60h
3621:030C 50              	push	ax
3621:030D 9A 4B 00 21 36  	call	far 3621h:004Bh
3621:0312 83 C4 04        	add	sp,4h
3621:0315 EB 28           	jmp	033Fh

l3621_0317:
3621:0317 26 8A 1C        	mov	bl,es:[si]
3621:031A 26 8B 4C 01     	mov	cx,es:[si+1h]
3621:031E B7 01           	mov	bh,1h
3621:0320 D2 E7           	shl	bh,cl
3621:0322 8A C7           	mov	al,bh
3621:0324 F6 E5           	mul	ch
3621:0326 8B C8           	mov	cx,ax
3621:0328 B0 60           	mov	al,60h
3621:032A F6 E3           	mul	bl
3621:032C 33 D2           	xor	dx,dx
3621:032E F7 F1           	div	cx
3621:0330 50              	push	ax
3621:0331 8A D7           	mov	dl,bh
3621:0333 52              	push	dx
3621:0334 8A D3           	mov	dl,bl
3621:0336 52              	push	dx
3621:0337 9A 63 00 21 36  	call	far 3621h:0063h
3621:033C 83 C4 06        	add	sp,6h

l3621_033F:
3621:033F 07              	pop	es
3621:0340 5E              	pop	si

l3621_0341:
3621:0341 E8 66 FD        	call	00AAh
3621:0344 29 06 5C 62     	sub	[625Ch],ax
3621:0348 E9 F3 FE        	jmp	023Eh
3621:034B                                  F7 06 5A 62 04            ..Zb.
3621:0350 00 74 05 83 C6 02 EB E9                         .t......        

l3621_0358:
3621:0358 06              	push	es
3621:0359 50              	push	ax
3621:035A 9A EE 03 21 36  	call	far 3621h:03EEh
3621:035F 83 C4 02        	add	sp,2h
3621:0362 07              	pop	es
3621:0363 33 C0           	xor	ax,ax
3621:0365 26 8A 04        	mov	al,es:[si]
3621:0368 46              	inc	si

l3621_0369:
3621:0369 06              	push	es
3621:036A 50              	push	ax
3621:036B 9A EE 03 21 36  	call	far 3621h:03EEh
3621:0370 83 C4 02        	add	sp,2h
3621:0373 07              	pop	es
3621:0374 33 C0           	xor	ax,ax
3621:0376 26 8A 04        	mov	al,es:[si]
3621:0379 46              	inc	si

l3621_037A:
3621:037A 06              	push	es
3621:037B 50              	push	ax
3621:037C 9A EE 03 21 36  	call	far 3621h:03EEh
3621:0381 83 C4 02        	add	sp,2h
3621:0384 07              	pop	es
3621:0385 EB BA           	jmp	0341h
3621:0387                      00                                .        

;; DivideUnsigned32_0388: 3621:0388
;;   Called from:
;;     3621:0300 (in ServiceMIDISequenceTick_01E8)
DivideUnsigned32_0388 proc
3621:0388 55              	push	bp
3621:0389 8B EC           	mov	bp,sp
3621:038B 56              	push	si
3621:038C 57              	push	di
3621:038D 33 D2           	xor	dx,dx
3621:038F 8B 7E 08        	mov	di,[bp+8h]
3621:0392 8B 76 06        	mov	si,[bp+6h]
3621:0395 8B C6           	mov	ax,si
3621:0397 0B C7           	or	ax,di
3621:0399 74 4F           	jz	03EAh

l3621_039B:
3621:039B 8B 5E 0C        	mov	bx,[bp+0Ch]
3621:039E 8B 6E 0A        	mov	bp,[bp+0Ah]
3621:03A1 8B C5           	mov	ax,bp
3621:03A3 0B C3           	or	ax,bx
3621:03A5 74 43           	jz	03EAh

l3621_03A7:
3621:03A7 33 C0           	xor	ax,ax
3621:03A9 3B DF           	cmp	bx,di
3621:03AB 75 02           	jnz	03AFh

l3621_03AD:
3621:03AD 3B EE           	cmp	bp,si

l3621_03AF:
3621:03AF 77 39           	ja	03EAh

l3621_03B1:
3621:03B1 EB 08           	jmp	03BBh

l3621_03B3:
3621:03B3 D1 E6           	shl	si,1h
3621:03B5 D1 D7           	rcl	di,1h
3621:03B7 D1 E5           	shl	bp,1h
3621:03B9 D1 D3           	rcl	bx,1h

l3621_03BB:
3621:03BB 0B FF           	or	di,di
3621:03BD 79 F4           	jns	03B3h

l3621_03BF:
3621:03BF 33 C9           	xor	cx,cx
3621:03C1 EB 04           	jmp	03C7h

l3621_03C3:
3621:03C3 D1 E5           	shl	bp,1h
3621:03C5 D1 D3           	rcl	bx,1h

l3621_03C7:
3621:03C7 41              	inc	cx
3621:03C8 0B DB           	or	bx,bx
3621:03CA 79 F7           	jns	03C3h

l3621_03CC:
3621:03CC EB 08           	jmp	03D6h

l3621_03CE:
3621:03CE D1 E0           	shl	ax,1h
3621:03D0 D1 D2           	rcl	dx,1h
3621:03D2 D1 EB           	shr	bx,1h
3621:03D4 D1 DD           	rcr	bp,1h

l3621_03D6:
3621:03D6 3B DF           	cmp	bx,di
3621:03D8 75 02           	jnz	03DCh

l3621_03DA:
3621:03DA 3B EE           	cmp	bp,si

l3621_03DC:
3621:03DC 77 0A           	ja	03E8h

l3621_03DE:
3621:03DE 2B F5           	sub	si,bp
3621:03E0 1B FB           	sbb	di,bx
3621:03E2 05 01 00        	add	ax,1h
3621:03E5 83 D2 00        	adc	dx,0h

l3621_03E8:
3621:03E8 E2 E4           	loop	03CEh

l3621_03EA:
3621:03EA 5F              	pop	di
3621:03EB 5E              	pop	si
3621:03EC 5D              	pop	bp
3621:03ED CB              	retf

;; DispatchMIDIByte_03EE: 3621:03EE
;;   Called from:
;;     3621:0087 (in SendMIDIAllNotesOff_007E)
;;     3621:0093 (in SendMIDIAllNotesOff_007E)
;;     3621:009E (in SendMIDIAllNotesOff_007E)
;;     3621:0287 (in ServiceMIDISequenceTick_01E8)
;;     3621:029E (in ServiceMIDISequenceTick_01E8)
;;     3621:035A (in ServiceMIDISequenceTick_01E8)
;;     3621:036B (in ServiceMIDISequenceTick_01E8)
;;     3621:037C (in ServiceMIDISequenceTick_01E8)
DispatchMIDIByte_03EE proc
3621:03EE 55              	push	bp
3621:03EF 8B EC           	mov	bp,sp
3621:03F1 FF 76 06        	push	word ptr [bp+6h]
3621:03F4 9A 50 05 21 36  	call	far 3621h:0550h
3621:03F9 0B C0           	or	ax,ax
3621:03FB 58              	pop	ax
3621:03FC 74 02           	jz	0400h

l3621_03FE:
3621:03FE 5D              	pop	bp
3621:03FF CB              	retf

l3621_0400:
3621:0400 56              	push	si
3621:0401 57              	push	di
3621:0402 3C 80           	cmp	al,80h
3621:0404 73 7C           	jnc	0482h

l3621_0406:
3621:0406 8B 1E B0 62     	mov	bx,[62B0h]
3621:040A FF A7 94 62     	jmp	word ptr [bx+6294h]

l3621_040E:
3621:040E 50              	push	ax
3621:040F 9A F1 06 21 36  	call	far 3621h:06F1h
3621:0414 83 C4 02        	add	sp,2h
3621:0417 BB 16 00        	mov	bx,16h
3621:041A EB 7B           	jmp	0497h

l3621_041C:
3621:041C 50              	push	ax
3621:041D 9A F1 06 21 36  	call	far 3621h:06F1h
3621:0422 83 C4 02        	add	sp,2h
3621:0425 EB 6D           	jmp	0494h

l3621_0427:
3621:0427 9A 32 08 21 36  	call	far 3621h:0832h
3621:042C EB 66           	jmp	0494h

l3621_042E:
3621:042E 8B D8           	mov	bx,ax
3621:0430 24 0F           	and	al,0Fh
3621:0432 A3 B2 62        	mov	[62B2h],ax
3621:0435 80 E3 70        	and	bl,70h
3621:0438 D1 EB           	shr	bx,1h
3621:043A D1 EB           	shr	bx,1h
3621:043C EB 59           	jmp	0497h
3621:043E                                           A3 B4               ..
3621:0440 62 83 C3 02 EB 51 FF 36 B4 62 FF 36 B2 62 9A 5E b....Q.6.b.6.b.^
3621:0450 05 21 36 83 C4 04 EB 43 0A C0 74 EA 50 FF 36 B4 .!6....C..t.P.6.
3621:0460 62 FF 36 B2 62 9A E7 05 21 36 83 C4 06 EB 2C 50 b.6.b...!6....,P
3621:0470 FF 36 B4 62 FF 36 B2 62 9A 9D 06 21 36 83 C4 06 .6.b.6.b...!6...
3621:0480 EB 19                                           ..              

l3621_0482:
3621:0482 3C F0           	cmp	al,0F0h
3621:0484 72 A8           	jc	042Eh

l3621_0486:
3621:0486 74 86           	jz	040Eh

l3621_0488:
3621:0488 3C F7           	cmp	al,0F7h
3621:048A 74 90           	jz	041Ch

l3621_048C:
3621:048C 3C FF           	cmp	al,0FFh
3621:048E 74 97           	jz	0427h

l3621_0490:
3621:0490 3C F8           	cmp	al,0F8h
3621:0492 73 07           	jnc	049Bh

l3621_0494:
3621:0494 BB 12 00        	mov	bx,12h

l3621_0497:
3621:0497 89 1E B0 62     	mov	[62B0h],bx

l3621_049B:
3621:049B 5F              	pop	di
3621:049C 5E              	pop	si
3621:049D 5D              	pop	bp
3621:049E CB              	retf
3621:049F                                              83                .
3621:04A0 3E B4 62 01 74 15 83 3E B4 62 21 74 14 83 3E B4 >.b.t..>.b!t..>.
3621:04B0 62 7B 72 E7 9A 9F 06 21 36 EB E0 86 E0 D1 E8 EB b{r....!6.......
3621:04C0 0B 33 06 B6 62 25 7F 00 33 06 B6 62 A3 B6 62 50 .3..b%..3..b..bP
3621:04D0 FF 36 B2 62 9A 9E 06 21 36 83 C4 04 EB BD 50 FF .6.b...!6.....P.
3621:04E0 36 B2 62 9A C7 06 21 36 83 C4 04 EB AE 50 FF 36 6.b...!6.....P.6
3621:04F0 B2 62 9A EF 06 21 36 83 C4 04 EB 9F 86 E0 D1 E8 .b...!6.........
3621:0500 0B 06 B4 62 50 FF 36 B2 62 9A F0 06 21 36 83 C4 ...bP.6.b...!6..
3621:0510 04 EB 88 00                                     ....            

;; PrepareMIDIDriver_0514: 3621:0514
;;   Called from:
;;     3014:0060 (in InitializeMusicDriver_0038)
;;     3014:0086 (in InitializeMusicDriver_0038)
;;     3014:00AB (in InitializeMusicDriver_0038)
;;     3014:00D0 (in InitializeMusicDriver_0038)
;;     3014:00F5 (in InitializeMusicDriver_0038)
PrepareMIDIDriver_0514 proc
3621:0514 8B DC           	mov	bx,sp
3621:0516 36 8B 5F 04     	mov	bx,ss:[bx+4h]
3621:051A FF 57 04        	call	word ptr [bx+4h]
3621:051D CB              	retf

;; ActivateMIDIDriver_051E: 3621:051E
;;   Called from:
;;     3014:0074 (in InitializeMusicDriver_0038)
;;     3014:009A (in InitializeMusicDriver_0038)
;;     3014:00BF (in InitializeMusicDriver_0038)
;;     3014:00E4 (in InitializeMusicDriver_0038)
;;     3014:0109 (in InitializeMusicDriver_0038)
ActivateMIDIDriver_051E proc
3621:051E 8B 1E B8 62     	mov	bx,[62B8h]
3621:0522 FF 57 08        	call	word ptr [bx+8h]
3621:0525 8B DC           	mov	bx,sp
3621:0527 36 8B 5F 04     	mov	bx,ss:[bx+4h]
3621:052B 89 1E B8 62     	mov	[62B8h],bx
3621:052F FF 77 16        	push	word ptr [bx+16h]
3621:0532 FF 57 06        	call	word ptr [bx+6h]
3621:0535 8A 47 03        	mov	al,[bx+3h]
3621:0538 88 47 1A        	mov	[bx+1Ah],al
3621:053B 9A 32 08 21 36  	call	far 3621h:0832h
3621:0540 58              	pop	ax
3621:0541 CB              	retf

;; DeactivateMIDIDriver_0542: 3621:0542
;;   Called from:
;;     3014:0148 (in ShutdownMusicDriver_0143)
DeactivateMIDIDriver_0542 proc
3621:0542 8B 1E B8 62     	mov	bx,[62B8h]
3621:0546 FF 57 08        	call	word ptr [bx+8h]
3621:0549 C7 06 B8 62 66 67 	mov	word ptr [62B8h],6766h
3621:054F CB              	retf

;; MIDIDriverHandlesByte_0550: 3621:0550
;;   Called from:
;;     3621:03F4 (in DispatchMIDIByte_03EE)
MIDIDriverHandlesByte_0550 proc
3621:0550 8B DC           	mov	bx,sp
3621:0552 36 8B 47 04     	mov	ax,ss:[bx+4h]
3621:0556 8B 1E B8 62     	mov	bx,[62B8h]
3621:055A FF 57 0A        	call	word ptr [bx+0Ah]
3621:055D CB              	retf
3621:055E                                           55 8B               U.
3621:0560 EC 56 57 8B 5E 06 D1 E3 D1 E3 D1 E3 81 C3 20 64 .VW.^......... d
3621:0570 8A 27 0A E4 74 42 F6 C4 40 74 1E 8B 4E 08 2A 4F .'..tB..@t..N.*O
3621:0580 04 80 F9 20 73 32 80 C1 10 D1 E1 D1 E1 D1 E1 81 ... s2..........
3621:0590 C1 20 64 C6 46 08 00 8B D9 8B 46 08 BE BA 62 EB . d.F.....F...b.
3621:05A0 10 39 5C 06 75 0B 80 7C 05 00 74 05 38 44 08 74 .9\.u..|..t.8D.t
3621:05B0 0B 8B 34 83 3C 00 75 E9 33 C0 EB 27 C6 44 05 00 ..4.<.u.3..'.D..
3621:05C0 8B 3C 8B 5C 02 89 3F 89 5D 02 BB BA 62 8B 3F 89 .<.\..?.]...b.?.
3621:05D0 3C 89 5C 02 89 37 89 75 02 8B 1E B8 62 FF 57 0E <.\..7.u....b.W.
3621:05E0 B8 01 00 5F 5E 5D CB 55 8B EC 56 57 8B 5E 06 D1 ..._^].U..VW.^..
3621:05F0 E3 D1 E3 D1 E3 81 C3 20 64 8A 27 0A E4 74 4B F6 ....... d.'..tK.
3621:0600 C4 40 74 1E 8B 4E 08 2A 4F 04 80 F9 20 73 3B 80 .@t..N.*O... s;.
3621:0610 C1 10 D1 E1 D1 E1 D1 E1 81 C1 20 64 C6 46 08 00 .......... d.F..
3621:0620 8B D9 8A 47 01 8A 27 BE BA 62 EB 17 38 44 05 77 ...G..'..b..8D.w
3621:0630 19 3A 64 04 75 0D 8B 7C 06 3B FB 74 1A 80 7D 05 .:d.u..|.;.t..}.
3621:0640 00 75 0B 8B 34 83 3C 00 75 E2 33 C0 EB 4B FE 4D .u..4.<.u.3..K.M
3621:0650 05 FE 47 05 89 5C 06 53 88 44 05 8B 3C 8B 5C 02 ..G..\.S.D..<.\.
3621:0660 89 3F 89 5D 02 EB 09 38 45 05 73 09 8B DF 8B 3D .?.]...8E.s....=
3621:0670 83 3D 00 75 F2 89 3C 89 5C 02 89 37 89 75 02 5F .=.u..<.\..7.u._
3621:0680 8B 5E 08 88 5C 08 02 5D 04 88 5C 09 8B 46 0A 8B .^..\..]..\..F..
3621:0690 1E B8 62 FF 57 0C B8 01 00 5F 5E 5D CB CB CB 55 ..b.W...._^]...U
3621:06A0 8B EC 56 57 BE BA 62 EB 13 80 7C 05 00 74 0D C6 ..VW..b...|..t..
3621:06B0 44 05 00 56 8B 1E B8 62 FF 57 0E 5E 8B 34 83 3C D..V...b.W.^.4.<
3621:06C0 00 75 E6 5F 5E 5D CB 55 8B EC 8B 5E 06 D1 E3 D1 .u._^].U...^....
3621:06D0 E3 D1 E3 81 C3 20 64 8B 46 08 88 47 03 D1 E0 D1 ..... d.F..G....
3621:06E0 E0 8B C8 D1 E0 03 C1 05 A8 65 89 47 06 5D CB CB .........e.G.]..
3621:06F0 CB                                              .               

;; DispatchMIDISystemByte_06F1: 3621:06F1
;;   Called from:
;;     3621:040F (in DispatchMIDIByte_03EE)
;;     3621:041D (in DispatchMIDIByte_03EE)
DispatchMIDISystemByte_06F1 proc
3621:06F1 55              	push	bp
3621:06F2 8B EC           	mov	bp,sp
3621:06F4 8B 46 06        	mov	ax,[bp+6h]
3621:06F7 3C F0           	cmp	al,0F0h
3621:06F9 74 08           	jz	0703h

l3621_06FB:
3621:06FB 3C F7           	cmp	al,0F7h
3621:06FD 74 2A           	jz	0729h

l3621_06FF:
3621:06FF FF 26 58 67     	jmp	word ptr [6758h]

l3621_0703:
3621:0703 B8 08 07        	mov	ax,708h
3621:0706 EB 55           	jmp	075Dh
3621:0708                         8B 1E B8 62 3A 47 02 75         ...b:G.u
3621:0710 18 B8 16 07 EB 47 3C 03 73 0F D1 E0 A3 5A 67 B8 .....G<.s....Zg.
3621:0720 24 07 EB 39 A2 5C 67 EB 25                      $..9.\g.%       

l3621_0729:
3621:0729 B8 60 07        	mov	ax,760h
3621:072C EB 2F           	jmp	075Dh
3621:072E                                           8B 1E               ..
3621:0730 5E 67 88 07 43 89 1E 5E 67 FE 0E 5D 67 75 21 56 ^g..C..^g..]gu!V
3621:0740 57 BE 38 67 8B 1E 5A 67 FF 97 60 67 5F 5E A0 5C W.8g..Zg..`g_^.\
3621:0750 67 A2 5D 67 B8 38 67 A3 5E 67 B8 2E 07          g.]g.8g.^g...   

l3621_075D:
3621:075D A3 58 67        	mov	[6758h],ax
3621:0760 5D              	pop	bp
3621:0761 CB              	retf
3621:0762       FC AC 32 E4 8B D8 D1 E3 D1 E3 D1 E3 81 C3   ..2...........
3621:0770 20 64 AC 88 07 AC 88 47 01 AC 2A 47 02 74 67 78  d.....G..*G.tgx
3621:0780 5F 56 8B C8 80 7F 05 00 74 0A FE 47 02 FE 4F 05 _V......t..G..O.
3621:0790 E0 F8 E3 49 8A 17 BE BA 62 8B C6 EB 39 3A 54 04 ...I....b...9:T.
3621:07A0 75 34 8B 7C 06 80 7D 05 00 74 2B FE 4D 05 FE 47 u4.|..}..t+.M..G
3621:07B0 02 89 5C 06 C6 44 05 00 8B 3C 8B 5C 02 89 3F 89 ..\..D...<.\..?.
3621:07C0 5D 02 93 8B 3F 89 3C 89 5C 02 89 37 89 75 02 8B ]...?.<.\..7.u..
3621:07D0 F0 8B C3 8B 5C 06 8B 34 83 3C 00 E0 C0 5E EB 06 ....\..4.<...^..
3621:07E0 00 47 02 28 47 05 AC 88 47 03 32 E4 D1 E0 D1 E0 .G.(G...G.2.....
3621:07F0 8B C8 D1 E0 03 C1 05 A8 65 89 47 06 AC A8 40 74 ........e.G...@t
3621:0800 02 0C 80 88 47 04 C3 FC AC 32 E4 8B F8 D1 E7 D1 ....G....2......
3621:0810 E7 8B C7 D1 E7 03 F8 81 C7 A8 65 8B 1E B8 62 FF ..........e...b.
3621:0820 57 12 C3 FC AC 8B 1E B8 62 88 47 1A 9A 58 08 21 W.......b.G..X.!
3621:0830 36 C3                                           6.              

;; ResetMIDIPlaybackState_0832: 3621:0832
;;   Called from:
;;     3621:0427 (in DispatchMIDIByte_03EE)
;;     3621:053B (in ActivateMIDIDriver_051E)
ResetMIDIPlaybackState_0832 proc
3621:0832 56              	push	si
3621:0833 57              	push	di
3621:0834 C7 06 58 67 60 07 	mov	word ptr [6758h],760h
3621:083A 33 C0           	xor	ax,ax
3621:083C 8C DF           	mov	di,ds
3621:083E 8E C7           	mov	es,di
3621:0840 BF 20 64        	mov	di,6420h
3621:0843 FC              	cld
3621:0844 B9 C0 00        	mov	cx,0C0h

l3621_0847:
3621:0847 F3 AB           	rep stosw

l3621_0849:
3621:0849 BB 28 67        	mov	bx,6728h
3621:084C B9 10 00        	mov	cx,10h

l3621_084F:
3621:084F 88 07           	mov	[bx],al
3621:0851 43              	inc	bx
3621:0852 FE C0           	inc	al
3621:0854 E2 F9           	loop	084Fh

l3621_0856:
3621:0856 EB 02           	jmp	085Ah
3621:0858                         56 57                           VW      

l3621_085A:
3621:085A BE BA 62        	mov	si,62BAh
3621:085D 8D 7C 02        	lea	di,[si+2h]
3621:0860 89 3C           	mov	[si],di
3621:0862 89 75 02        	mov	[di+2h],si
3621:0865 8B 1E B8 62     	mov	bx,[62B8h]
3621:0869 8A 4F 1A        	mov	cl,[bx+1Ah]
3621:086C 32 ED           	xor	ch,ch
3621:086E 88 0E A5 65     	mov	[65A5h],cl
3621:0872 E3 1E           	jcxz	0892h

l3621_0874:
3621:0874 33 C0           	xor	ax,ax
3621:0876 BB C0 62        	mov	bx,62C0h

l3621_0879:
3621:0879 C7 47 06 A0 65  	mov	word ptr [bx+6h],65A0h
3621:087E 88 47 05        	mov	[bx+5h],al
3621:0881 89 3F           	mov	[bx],di
3621:0883 89 77 02        	mov	[bx+2h],si
3621:0886 89 1C           	mov	[si],bx
3621:0888 89 5D 02        	mov	[di+2h],bx
3621:088B 8B FB           	mov	di,bx
3621:088D 83 C3 20        	add	bx,20h
3621:0890 E2 E7           	loop	0879h

l3621_0892:
3621:0892 8B 1E B8 62     	mov	bx,[62B8h]
3621:0896 C7 47 18 C0 62  	mov	word ptr [bx+18h],62C0h
3621:089B FF 57 10        	call	word ptr [bx+10h]
3621:089E 5F              	pop	di
3621:089F 5E              	pop	si
3621:08A0 CB              	retf

;; ServiceActiveMIDIDriver_08A1: 3621:08A1
;;   Called from:
;;     30B2:0067 (in MusicTimerIRQ0Handler_0010)
ServiceActiveMIDIDriver_08A1 proc
3621:08A1 8B 1E B8 62     	mov	bx,[62B8h]
3621:08A5 FF 67 14        	jmp	word ptr [bx+14h]

;; NullMIDIDriverProbe_08A8: 3621:08A8
NullMIDIDriverProbe_08A8 proc
3621:08A8 B8 01 00        	mov	ax,1h
3621:08AB C3              	ret

;; ActivateNullMIDIDriver_08AC: 3621:08AC
ActivateNullMIDIDriver_08AC proc
3621:08AC C3              	ret

;; DeactivateNullMIDIDriver_08AD: 3621:08AD
DeactivateNullMIDIDriver_08AD proc
3621:08AD C3              	ret

;; FilterNullMIDIByte_08AE: 3621:08AE
FilterNullMIDIByte_08AE proc
3621:08AE 33 C0           	xor	ax,ax
3621:08B0 C3              	ret

;; NullMIDIVoiceOn_08B1: 3621:08B1
NullMIDIVoiceOn_08B1 proc
3621:08B1 C3              	ret

;; NullMIDIVoiceOff_08B2: 3621:08B2
NullMIDIVoiceOff_08B2 proc
3621:08B2 C3              	ret

;; ResetNullMIDIDriver_08B3: 3621:08B3
ResetNullMIDIDriver_08B3 proc
3621:08B3 C3              	ret

;; LoadNullMIDIInstrument_08B4: 3621:08B4
LoadNullMIDIInstrument_08B4 proc
3621:08B4 C3              	ret

;; ServiceNullMIDIDriver_08B5: 3621:08B5
ServiceNullMIDIDriver_08B5 proc
3621:08B5 CB              	retf

;; SpeakerMIDIDriverProbe_08B6: 3621:08B6
SpeakerMIDIDriverProbe_08B6 proc
3621:08B6 B8 01 00        	mov	ax,1h
3621:08B9 C3              	ret

;; ActivateSpeakerMIDIDriver_08BA: 3621:08BA
ActivateSpeakerMIDIDriver_08BA proc
3621:08BA FA              	cli
3621:08BB B0 B6           	mov	al,0B6h
3621:08BD E6 43           	out	43h,al
3621:08BF B8 14 00        	mov	ax,14h
3621:08C2 A3 BC 67        	mov	[67BCh],ax
3621:08C5 E6 42           	out	42h,al
3621:08C7 8A C4           	mov	al,ah
3621:08C9 E6 42           	out	42h,al
3621:08CB E4 61           	in	al,61h
3621:08CD 0C 03           	or	al,3h
3621:08CF E6 61           	out	61h,al
3621:08D1 FB              	sti
3621:08D2 C3              	ret

;; DeactivateSpeakerMIDIDriver_08D3: 3621:08D3
DeactivateSpeakerMIDIDriver_08D3 proc
3621:08D3 FA              	cli
3621:08D4 E4 61           	in	al,61h
3621:08D6 24 FC           	and	al,0FCh
3621:08D8 E6 61           	out	61h,al
3621:08DA FB              	sti
3621:08DB C3              	ret

;; FilterSpeakerMIDIByte_08DC: 3621:08DC
FilterSpeakerMIDIByte_08DC proc
3621:08DC 33 C0           	xor	ax,ax
3621:08DE C3              	ret

;; SpeakerMIDIVoiceOn_08DF: 3621:08DF
SpeakerMIDIVoiceOn_08DF proc
3621:08DF 32 FF           	xor	bh,bh
3621:08E1 8A 5C 09        	mov	bl,[si+9h]
3621:08E4 83 EB 0E        	sub	bx,0Eh
3621:08E7 78 08           	js	08F1h

l3621_08E9:
3621:08E9 D1 E3           	shl	bx,1h
3621:08EB 8B 87 C2 67     	mov	ax,[bx+67C2h]
3621:08EF EB 03           	jmp	08F4h

l3621_08F1:
3621:08F1 B8 14 00        	mov	ax,14h

l3621_08F4:
3621:08F4 89 44 0A        	mov	[si+0Ah],ax
3621:08F7 C3              	ret

;; SpeakerMIDIVoiceOff_08F8: 3621:08F8
SpeakerMIDIVoiceOff_08F8 proc
3621:08F8 B8 14 00        	mov	ax,14h
3621:08FB 89 44 0A        	mov	[si+0Ah],ax
3621:08FE C3              	ret

;; ResetSpeakerMIDIDriver_08FF: 3621:08FF
ResetSpeakerMIDIDriver_08FF proc
3621:08FF 8B 36 A6 67     	mov	si,[67A6h]
3621:0903 89 36 BE 67     	mov	[67BEh],si
3621:0907 33 C9           	xor	cx,cx
3621:0909 8A 0E A8 67     	mov	cl,[67A8h]
3621:090D 88 0E C0 67     	mov	[67C0h],cl
3621:0911 E3 0E           	jcxz	0921h

l3621_0913:
3621:0913 C6 44 04 01     	mov	byte ptr [si+4h],1h
3621:0917 C7 44 0A 14 00  	mov	word ptr [si+0Ah],14h
3621:091C 83 C6 20        	add	si,20h
3621:091F E2 F2           	loop	0913h

l3621_0921:
3621:0921 C3              	ret

;; LoadSpeakerMIDIInstrument_0922: 3621:0922
LoadSpeakerMIDIInstrument_0922 proc
3621:0922 C3              	ret

;; ServiceSpeakerMIDIDriver_0923: 3621:0923
ServiceSpeakerMIDIDriver_0923 proc
3621:0923 80 3E A8 67 00  	cmp	byte ptr [67A8h],0h
3621:0928 75 01           	jnz	092Bh

l3621_092A:
3621:092A CB              	retf

l3621_092B:
3621:092B 8B 1E BE 67     	mov	bx,[67BEh]
3621:092F 8B 47 0A        	mov	ax,[bx+0Ah]
3621:0932 39 06 BC 67     	cmp	[67BCh],ax
3621:0936 74 10           	jz	0948h

l3621_0938:
3621:0938 A3 BC 67        	mov	[67BCh],ax
3621:093B B0 B6           	mov	al,0B6h
3621:093D E6 43           	out	43h,al
3621:093F A1 BC 67        	mov	ax,[67BCh]
3621:0942 E6 42           	out	42h,al
3621:0944 8A C4           	mov	al,ah
3621:0946 E6 42           	out	42h,al

l3621_0948:
3621:0948 83 C3 20        	add	bx,20h
3621:094B FE 0E C0 67     	dec	byte ptr [67C0h]
3621:094F 75 0A           	jnz	095Bh

l3621_0951:
3621:0951 A0 A8 67        	mov	al,[67A8h]
3621:0954 A2 C0 67        	mov	[67C0h],al
3621:0957 8B 1E A6 67     	mov	bx,[67A6h]

l3621_095B:
3621:095B 89 1E BE 67     	mov	[67BEh],bx
3621:095F CB              	retf
3621:0960 FA B0 B6 E6 43 A1 BC 67 E6 42 8A C4 E6 42 FB CB ....C..g.B...B..
3621:0970 B8 00 F0 8E C0 BB FE FF 26 80 3F FF 75 0D       ........&.?.u.  

;; TandyMIDIDriverProbe_097E: 3621:097E
TandyMIDIDriverProbe_097E proc
3621:097E BB 00 C0        	mov	bx,0C000h
3621:0981 26 80 3F 21     	cmp	byte ptr es:[bx],21h
3621:0985 75 04           	jnz	098Bh

l3621_0987:
3621:0987 B8 01 00        	mov	ax,1h
3621:098A C3              	ret

l3621_098B:
3621:098B 33 C0           	xor	ax,ax
3621:098D C3              	ret
3621:098E                                           FF 26               .&
3621:0990 94 67 8B 1E BE 68 33 C9 8A 0E DB 68             .g...h3....h    

;; ActivateTandyMIDIDriver_099C: 3621:099C
ActivateTandyMIDIDriver_099C proc
3621:099C E3 0F           	jcxz	09ADh

;; SilenceTandyMIDIVoices_099E: 3621:099E
;;   Called from:
;;     3621:099C (in ActivateTandyMIDIDriver_099C)
;;     3621:09A0 (in DeactivateTandyMIDIDriver_09A0)
SilenceTandyMIDIVoices_099E proc
3621:099E 8A 47 0D        	mov	al,[bx+0Dh]

;; DeactivateTandyMIDIDriver_09A0: 3621:09A0
DeactivateTandyMIDIDriver_09A0 proc
3621:09A0 0D 0C 9F        	or	ax,9F0Ch

l3621_09A1:
3621:09A1 0C 9F           	or	al,9Fh
3621:09A3 88 47 0C        	mov	[bx+0Ch],al
3621:09A6 E6 C0           	out	0C0h,al
3621:09A8 83 C3 20        	add	bx,20h
3621:09AB E2 F1           	loop	099Eh

l3621_09AD:
3621:09AD FF 26 96 67     	jmp	word ptr [6796h]
3621:09B1    33 C0 C3 80 7C 04 02 75 2B 32 FF 8A 5C 09     3...|..u+2..\. 

;; FilterTandyMIDIByte_09BF: 3621:09BF
FilterTandyMIDIByte_09BF proc
3621:09BF 83 EB 2D        	sub	bx,2Dh

;; TandyMIDIVoiceOn_09C2: 3621:09C2
;;   Called from:
;;     3621:09BF (in FilterTandyMIDIByte_09BF)
TandyMIDIVoiceOn_09C2 proc
3621:09C2 78 0D           	js	09D1h

l3621_09C4:
3621:09C4 83 FB 4B        	cmp	bx,4Bh
3621:09C7 77 08           	ja	09D1h

l3621_09C9:
3621:09C9 D1 E3           	shl	bx,1h
3621:09CB 8B 9F DC 68     	mov	bx,[bx+68DCh]
3621:09CF EB 05           	jmp	09D6h

l3621_09D1:
3621:09D1 BB 81 00        	mov	bx,81h
3621:09D4 33 C0           	xor	ax,ax

l3621_09D6:
3621:09D6 0A 5C 0D        	or	bl,[si+0Dh]
3621:09D9 89 5C 0A        	mov	[si+0Ah],bx
3621:09DC B4 92           	mov	ah,92h
3621:09DE 0A 64 0D        	or	ah,[si+0Dh]
3621:09E1 88 64 0C        	mov	[si+0Ch],ah
3621:09E4 C3              	ret
3621:09E5                FF 26 9A 67 80 7C 04 02 75 12 B8      .&.g.|..u..
3621:09F0 81 00 0A 44 0D 89 44                            ...D..D         

;; TandyMIDIVoiceOff_09F7: 3621:09F7
TandyMIDIVoiceOff_09F7 proc
3621:09F7 0A B0 9F 0A     	or	dh,[bx+si+0A9Fh]
3621:09FB 44              	inc	sp
3621:09FC 0D 88 44        	or	ax,4488h
3621:09FF 0C C3           	or	al,0C3h
3621:0A01 FF 26 9C 67     	jmp	word ptr [679Ch]
3621:0A05                8B 36 BE 68 89 36 D8 68 33 C0 A0      .6.h.6.h3..
3621:0A10 C0 68 2D                                        .h-             

;; ResetTandyMIDIDriver_0A13: 3621:0A13
ResetTandyMIDIDriver_0A13 proc
3621:0A13 03 00           	add	ax,[bx+si]
3621:0A15 79 02           	jns	0A19h

l3621_0A17:
3621:0A17 33 C0           	xor	ax,ax

l3621_0A19:
3621:0A19 A2 A8 67        	mov	[67A8h],al
3621:0A1C 33 C9           	xor	cx,cx
3621:0A1E 8A 0E C0 68     	mov	cl,[68C0h]
3621:0A22 2B C8           	sub	cx,ax
3621:0A24 88 0E DB 68     	mov	[68DBh],cl
3621:0A28 88 0E DA 68     	mov	[68DAh],cl
3621:0A2C E3 2C           	jcxz	0A5Ah

l3621_0A2E:
3621:0A2E C6 44 04 02     	mov	byte ptr [si+4h],2h
3621:0A32 8B C1           	mov	ax,cx
3621:0A34 48              	dec	ax
3621:0A35 D1 E0           	shl	ax,1h
3621:0A37 D1 E0           	shl	ax,1h
3621:0A39 D1 E0           	shl	ax,1h
3621:0A3B D1 E0           	shl	ax,1h
3621:0A3D D1 E0           	shl	ax,1h
3621:0A3F 88 44 0D        	mov	[si+0Dh],al
3621:0A42 0D 81 00        	or	ax,81h
3621:0A45 89 44 0A        	mov	[si+0Ah],ax
3621:0A48 0C 9F           	or	al,9Fh
3621:0A4A 88 44 0C        	mov	[si+0Ch],al
3621:0A4D 83 C6 20        	add	si,20h
3621:0A50 E2 DC           	loop	0A2Eh

l3621_0A52:
3621:0A52 89 36 A6 67     	mov	[67A6h],si
3621:0A56 FF 26 9E 67     	jmp	word ptr [679Eh]

l3621_0A5A:
3621:0A5A C3              	ret
3621:0A5B                                  C3 80 3E DB 68            ..>.h
3621:0A60 00 74 29 8B 1E D8 68 8B 47                      .t)...h.G       

;; LoadTandyMIDIInstrument_0A69: 3621:0A69
LoadTandyMIDIInstrument_0A69 proc
3621:0A69 0A E6           	or	ah,dh

;; ServiceTandyMIDIDriver_0A6A: 3621:0A6A
ServiceTandyMIDIDriver_0A6A proc
3621:0A6A E6 C0           	out	0C0h,al

;; fn3621_0A6B: 3621:0A6B
;;   Called from:
;;     3621:0A69 (in LoadTandyMIDIInstrument_0A69)
;;     3621:0A6A (in ServiceTandyMIDIDriver_0A6A)
fn3621_0A6B proc
3621:0A6B C0 8A C4 E6 C1  	ror	byte ptr [bp+si+0E6C4h],0C1h
3621:0A70 8A 47 0C        	mov	al,[bx+0Ch]
3621:0A73 E6 C0           	out	0C0h,al
3621:0A75 83 C3 20        	add	bx,20h
3621:0A78 FE 0E DA 68     	dec	byte ptr [68DAh]
3621:0A7C 75 0A           	jnz	0A88h

;; RestartTandyMIDIVoiceScan_0A7E: 3621:0A7E
;;   Called from:
;;     3621:0A7C (in fn3621_0A6B)
RestartTandyMIDIVoiceScan_0A7E proc
3621:0A7E A0 DB 68        	mov	al,[68DBh]
3621:0A81 A2 DA 68        	mov	[68DAh],al
3621:0A84 8B 1E BE 68     	mov	bx,[68BEh]

l3621_0A88:
3621:0A88 89 1E D8 68     	mov	[68D8h],bx
3621:0A8C FF 26 A2 67     	jmp	word ptr [67A2h]
3621:0A90 06 53 B4 C0 CD 15 26 8B 47 02 5B 07 3D FC       .S....&.G.[.=.  

;; IBMPS1MIDIDriverProbe_0A9E: 3621:0A9E
IBMPS1MIDIDriverProbe_0A9E proc
3621:0A9E 0B 75 12        	or	si,[di+12h]
3621:0AA1 B0 2F           	mov	al,2Fh
3621:0AA3 FA              	cli
3621:0AA4 E6 70           	out	70h,al
3621:0AA6 EB 00           	jmp	0AA8h

l3621_0AA8:
3621:0AA8 E4 71           	in	al,71h
3621:0AAA FB              	sti
3621:0AAB A8 10           	test	al,10h
3621:0AAD 74 04           	jz	0AB3h

l3621_0AAF:
3621:0AAF B8 01 00        	mov	ax,1h
3621:0AB2 C3              	ret

l3621_0AB3:
3621:0AB3 33 C0           	xor	ax,ax
3621:0AB5 C3              	ret
3621:0AB6                   FF 26 94 67 52 BA 05 02 8B 1E       .&.gR.....
3621:0AC0 8C 69 33 C9                                     .i3.            

;; ActivateIBMPS1MIDIDriver_0AC4: 3621:0AC4
ActivateIBMPS1MIDIDriver_0AC4 proc
3621:0AC4 8A 0E A7 69     	mov	cl,[69A7h]

;; DeactivateIBMPS1MIDIDriver_0AC8: 3621:0AC8
;;   Called from:
;;     3621:0AC4 (in ActivateIBMPS1MIDIDriver_0AC4)
DeactivateIBMPS1MIDIDriver_0AC8 proc
3621:0AC8 E3 0E           	jcxz	0AD8h

l3621_0ACA:
3621:0ACA 8A 47 0D        	mov	al,[bx+0Dh]
3621:0ACD 0C 9F           	or	al,9Fh
3621:0ACF 88 47 0C        	mov	[bx+0Ch],al
3621:0AD2 EE              	out	dx,al
3621:0AD3 83 C3 20        	add	bx,20h
3621:0AD6 E2 F2           	loop	0ACAh

l3621_0AD8:
3621:0AD8 5A              	pop	dx
3621:0AD9 FF 26 96 67     	jmp	word ptr [6796h]
3621:0ADD                                        33 C0 C3              3..
3621:0AE0 80 7C 04 02 75 2B 32 FF 8A 5C 09                .|..u+2..\.     

;; FilterIBMPS1MIDIByte_0AEB: 3621:0AEB
FilterIBMPS1MIDIByte_0AEB proc
3621:0AEB 83 EB 2F        	sub	bx,2Fh

;; IBMPS1MIDIVoiceOn_0AEE: 3621:0AEE
;;   Called from:
;;     3621:0AEB (in FilterIBMPS1MIDIByte_0AEB)
IBMPS1MIDIVoiceOn_0AEE proc
3621:0AEE 78 0D           	js	0AFDh

l3621_0AF0:
3621:0AF0 83 FB 49        	cmp	bx,49h
3621:0AF3 77 08           	ja	0AFDh

l3621_0AF5:
3621:0AF5 D1 E3           	shl	bx,1h
3621:0AF7 8B 9F A8 69     	mov	bx,[bx+69A8h]
3621:0AFB EB 05           	jmp	0B02h

l3621_0AFD:
3621:0AFD BB 81 00        	mov	bx,81h
3621:0B00 33 C0           	xor	ax,ax

l3621_0B02:
3621:0B02 0A 5C 0D        	or	bl,[si+0Dh]
3621:0B05 89 5C 0A        	mov	[si+0Ah],bx
3621:0B08 B4 92           	mov	ah,92h
3621:0B0A 0A 64 0D        	or	ah,[si+0Dh]
3621:0B0D 88 64 0C        	mov	[si+0Ch],ah
3621:0B10 C3              	ret
3621:0B11    FF 26 9A 67 80 7C 04 02 75 12 B8 81 00 0A 44  .&.g.|..u.....D
3621:0B20 0D 89 44                                        ..D             

;; IBMPS1MIDIVoiceOff_0B23: 3621:0B23
IBMPS1MIDIVoiceOff_0B23 proc
3621:0B23 0A B0 9F 0A     	or	dh,[bx+si+0A9Fh]
3621:0B27 44              	inc	sp
3621:0B28 0D 88 44        	or	ax,4488h
3621:0B2B 0C C3           	or	al,0C3h
3621:0B2D FF 26 9C 67     	jmp	word ptr [679Ch]
3621:0B31    8B 36 8C 69 89 36 A4 69 33 C0 A0 8E 69 2D     .6.i.6.i3...i- 

;; ResetIBMPS1MIDIDriver_0B3F: 3621:0B3F
ResetIBMPS1MIDIDriver_0B3F proc
3621:0B3F 03 00           	add	ax,[bx+si]
3621:0B41 79 02           	jns	0B45h

l3621_0B43:
3621:0B43 33 C0           	xor	ax,ax

l3621_0B45:
3621:0B45 A2 A8 67        	mov	[67A8h],al
3621:0B48 33 C9           	xor	cx,cx
3621:0B4A 8A 0E 8E 69     	mov	cl,[698Eh]
3621:0B4E 2B C8           	sub	cx,ax
3621:0B50 88 0E A7 69     	mov	[69A7h],cl
3621:0B54 88 0E A6 69     	mov	[69A6h],cl
3621:0B58 E3 2C           	jcxz	0B86h

l3621_0B5A:
3621:0B5A C6 44 04 02     	mov	byte ptr [si+4h],2h
3621:0B5E 8B C1           	mov	ax,cx
3621:0B60 48              	dec	ax
3621:0B61 D1 E0           	shl	ax,1h
3621:0B63 D1 E0           	shl	ax,1h
3621:0B65 D1 E0           	shl	ax,1h
3621:0B67 D1 E0           	shl	ax,1h
3621:0B69 D1 E0           	shl	ax,1h
3621:0B6B 88 44 0D        	mov	[si+0Dh],al
3621:0B6E 0D 81 00        	or	ax,81h
3621:0B71 89 44 0A        	mov	[si+0Ah],ax
3621:0B74 0C 9F           	or	al,9Fh
3621:0B76 88 44 0C        	mov	[si+0Ch],al
3621:0B79 83 C6 20        	add	si,20h
3621:0B7C E2 DC           	loop	0B5Ah

l3621_0B7E:
3621:0B7E 89 36 A6 67     	mov	[67A6h],si
3621:0B82 FF 26 9E 67     	jmp	word ptr [679Eh]

l3621_0B86:
3621:0B86 C3              	ret
3621:0B87                      C3 80 3E A7 69 00 74 2B 52        ..>.i.t+R
3621:0B90 BA 05 02 8B 1E                                  .....           

;; LoadIBMPS1MIDIInstrument_0B95: 3621:0B95
LoadIBMPS1MIDIInstrument_0B95 proc
3621:0B95 A4              	movsb

;; ServiceIBMPS1MIDIDriver_0B96: 3621:0B96
;;   Called from:
;;     3621:0B95 (in LoadIBMPS1MIDIInstrument_0B95)
ServiceIBMPS1MIDIDriver_0B96 proc
3621:0B96 69 8B 47 0A EE 8A 	imul	cx,[bp+di+0A47h],8AEEh
3621:0B9C C4 EE 8A        	illegal
3621:0B9F 47              	inc	di
3621:0BA0 0C EE           	or	al,0EEh
3621:0BA2 83 C3 20        	add	bx,20h
3621:0BA5 FE 0E A6 69     	dec	byte ptr [69A6h]
3621:0BA9 75 0A           	jnz	0BB5h
3621:0BAB A0 A7 69        	mov	al,[69A7h]
3621:0BAE A2 A6 69        	mov	[69A6h],al
3621:0BB1 8B 1E 8C 69     	mov	bx,[698Ch]
3621:0BB5 89 1E A4 69     	mov	[69A4h],bx
3621:0BB9 5A              	pop	dx
3621:0BBA FF 26 A2 67     	jmp	word ptr [67A2h]

;; WriteAdLibMIDIRegister_0BBE: 3621:0BBE
;;   Called from:
;;     3621:0BE1 (in WriteAdLibMIDIRegisterList_0BDF)
;;     3621:0BF2 (in ProgramAdLibPatchOperator_0BEE)
;;     3621:0BFF (in ProgramAdLibPatchOperator_0BEE)
;;     3621:0C07 (in ProgramAdLibPatchOperator_0BEE)
;;     3621:0C0F (in ProgramAdLibPatchOperator_0BEE)
;;     3621:0C17 (in ProgramAdLibPatchOperator_0BEE)
;;     3621:0CDB (in fn3621_0CB5)
;;     3621:0CFB (in fn3621_0CDE)
;;     3621:0D13 (in fn3621_0CDE)
;;     3621:0D1A (in fn3621_0CDE)
;;     3621:0D30 (in fn3621_0CDE)
;;     3621:0D37 (in fn3621_0CDE)
;;     3621:0D42 (in fn3621_0CDE)
;;     3621:0D51 (in fn3621_0CDE)
;;     3621:0D56 (in fn3621_0CDE)
;;     3621:0D6F (in AdLibMIDIVoiceOff_0D6C)
WriteAdLibMIDIRegister_0BBE proc
3621:0BBE 50              	push	ax
3621:0BBF 51              	push	cx
3621:0BC0 EE              	out	dx,al
3621:0BC1 8B 0E 6E 6A     	mov	cx,[6A6Eh]

l3621_0BC5:
3621:0BC5 EC              	in	al,dx
3621:0BC6 24 00           	and	al,0h
3621:0BC8 3C FF           	cmp	al,0FFh
3621:0BCA E0 F9           	loopne	0BC5h

l3621_0BCC:
3621:0BCC 8A C4           	mov	al,ah
3621:0BCE 42              	inc	dx
3621:0BCF EE              	out	dx,al
3621:0BD0 4A              	dec	dx
3621:0BD1 8B 0E 70 6A     	mov	cx,[6A70h]

l3621_0BD5:
3621:0BD5 EC              	in	al,dx
3621:0BD6 24 00           	and	al,0h
3621:0BD8 3C FF           	cmp	al,0FFh
3621:0BDA E0 F9           	loopne	0BD5h

l3621_0BDC:
3621:0BDC 59              	pop	cx
3621:0BDD 58              	pop	ax
3621:0BDE C3              	ret

;; WriteAdLibMIDIRegisterList_0BDF: 3621:0BDF
;;   Called from:
;;     3621:0C8E (in ActivateAdLibMIDIDriver_0C84)
;;     3621:0DBA (in ResetAdLibMIDIDriver_0D94)
WriteAdLibMIDIRegisterList_0BDF proc
3621:0BDF EB 06           	jmp	0BE7h

l3621_0BE1:
3621:0BE1 E8 DA FF        	call	0BBEh
3621:0BE4 83 C3 02        	add	bx,2h

l3621_0BE7:
3621:0BE7 8B 07           	mov	ax,[bx]
3621:0BE9 0B C0           	or	ax,ax
3621:0BEB 75 F4           	jnz	0BE1h

l3621_0BED:
3621:0BED C3              	ret

;; ProgramAdLibPatchOperator_0BEE: 3621:0BEE
;;   Called from:
;;     3621:0CBB (in fn3621_0CB5)
;;     3621:0CCA (in fn3621_0CB5)
ProgramAdLibPatchOperator_0BEE proc
3621:0BEE 8A 25           	mov	ah,[di]
3621:0BF0 04 20           	add	al,20h
3621:0BF2 E8 C9 FF        	call	0BBEh
3621:0BF5 8A 65 01        	mov	ah,[di+1h]
3621:0BF8 04 20           	add	al,20h
3621:0BFA F6 C1 30        	test	cl,30h
3621:0BFD 74 03           	jz	0C02h

l3621_0BFF:
3621:0BFF E8 BC FF        	call	0BBEh

l3621_0C02:
3621:0C02 8A 65 03        	mov	ah,[di+3h]
3621:0C05 04 20           	add	al,20h
3621:0C07 E8 B4 FF        	call	0BBEh
3621:0C0A 8A 65 02        	mov	ah,[di+2h]
3621:0C0D 04 20           	add	al,20h
3621:0C0F E8 AC FF        	call	0BBEh
3621:0C12 8A 65 04        	mov	ah,[di+4h]
3621:0C15 04 60           	add	al,60h
3621:0C17 E8 A4 FF        	call	0BBEh
3621:0C1A 2C E0           	sub	al,0E0h
3621:0C1C C3              	ret
3621:0C1D                                        BA 88 03              ...
3621:0C20 B8 04 60 E8 98 FF B8 04 80 E8 92                ..`........     

;; AdLibMIDIDriverProbe_0C2B: 3621:0C2B
AdLibMIDIDriverProbe_0C2B proc
3621:0C2B FF EC           	jmp	esp
3621:0C2D                                        24 E0 75              $.u
3621:0C30 42 B8 02 C0 E8 87 FF B8 04 21 EE B9 14 00 EC E2 B........!......
3621:0C40 FD 8A C4 42 FA EE 4A 33 C9 EC 24 E0 3C C0 E0 F9 ...B..J3..$.<...
3621:0C50 FB 75 20 F7 D9 8B C1 33 D2 BB E4 00 F7 F3 40 A3 .u ....3......@.
3621:0C60 70 6A 8B C1 33 D2 BB 0F 06 F7 F3 40 A3 6E 6A B8 pj..3......@.nj.
3621:0C70 01 00 C3 33 C0 C3 53 BA 88 03 BB 96 6B E8 5F FF ...3..S.....k._.
3621:0C80 C6 06 72 6A                                     ..rj            

;; ActivateAdLibMIDIDriver_0C84: 3621:0C84
ActivateAdLibMIDIDriver_0C84 proc
3621:0C84 00 5B C3        	add	[bp+di-3Dh],bl
3621:0C87 53              	push	bx
3621:0C88 BA 88 03        	mov	dx,388h
3621:0C8B BB B2 6B        	mov	bx,6BB2h
3621:0C8E E8 4E FF        	call	0BDFh
3621:0C91 5B              	pop	bx
3621:0C92 C3              	ret
3621:0C93          33 C0                                     3.           

;; DeactivateAdLibMIDIDriver_0C95: 3621:0C95
DeactivateAdLibMIDIDriver_0C95 proc
3621:0C95 C3              	ret
3621:0C96                   32 FF 8A 5C 09 83 FB 72 77 02       2..\...rw.
3621:0CA0 EB                                              .               

;; FilterAdLibMIDIByte_0CA1: 3621:0CA1
FilterAdLibMIDIByte_0CA1 proc
3621:0CA1 03 E9           	add	bp,cx
3621:0CA3 B9 00 53        	mov	cx,5300h

;; AdLibMIDIVoiceOn_0CA4: 3621:0CA4
AdLibMIDIVoiceOn_0CA4 proc
3621:0CA4 00 53 50        	add	[bp+di+50h],dl

;; fn3621_0CA6: 3621:0CA6
;;   Called from:
;;     3621:0CA3 (in FilterAdLibMIDIByte_0CA1)
;;     3621:0CA4 (in AdLibMIDIVoiceOn_0CA4)
fn3621_0CA6 proc
3621:0CA6 50              	push	ax
3621:0CA7 BA 88 03        	mov	dx,388h
3621:0CAA 8A 4C 04        	mov	cl,[si+4h]
3621:0CAD 8B 7D 06        	mov	di,[di+6h]
3621:0CB0 39 7C 0C        	cmp	[si+0Ch],di
3621:0CB3 74 29           	jz	0CDEh

;; fn3621_0CB5: 3621:0CB5
;;   Called from:
;;     3621:0CB2 (in fn3621_0CA6)
;;     3621:0CB3 (in fn3621_0CA6)
fn3621_0CB5 proc
3621:0CB5 89 7C 0C        	mov	[si+0Ch],di
3621:0CB8 8A 44 0B        	mov	al,[si+0Bh]
3621:0CBB E8 30 FF        	call	0BEEh
3621:0CBE F6 C1 30        	test	cl,30h
3621:0CC1 74 1B           	jz	0CDEh

l3621_0CC3:
3621:0CC3 04 03           	add	al,3h
3621:0CC5 83 C7 06        	add	di,6h
3621:0CC8 32 C9           	xor	cl,cl
3621:0CCA E8 21 FF        	call	0BEEh
3621:0CCD 8A 4C 04        	mov	cl,[si+4h]
3621:0CD0 83 EF 06        	sub	di,6h
3621:0CD3 8A 44 0A        	mov	al,[si+0Ah]
3621:0CD6 04 C0           	add	al,0C0h
3621:0CD8 8A 65 05        	mov	ah,[di+5h]
3621:0CDB E8 E0 FE        	call	0BBEh

;; fn3621_0CDE: 3621:0CDE
;;   Called from:
;;     3621:0CB2 (in fn3621_0CA6)
;;     3621:0CB3 (in fn3621_0CA6)
;;     3621:0CC1 (in fn3621_0CB5)
;;     3621:0CDB (in fn3621_0CB5)
fn3621_0CDE proc
3621:0CDE 8A 44 0B        	mov	al,[si+0Bh]
3621:0CE1 F6 C1 30        	test	cl,30h
3621:0CE4 74 05           	jz	0CEBh

l3621_0CE6:
3621:0CE6 04 03           	add	al,3h
3621:0CE8 83 C7 06        	add	di,6h

l3621_0CEB:
3621:0CEB 04 40           	add	al,40h
3621:0CED 8A 65 01        	mov	ah,[di+1h]
3621:0CF0 80 E4 C0        	and	ah,0C0h
3621:0CF3 5B              	pop	bx
3621:0CF4 D0 EB           	shr	bl,1h
3621:0CF6 80 F3 3F        	xor	bl,3Fh
3621:0CF9 0A E3           	or	ah,bl
3621:0CFB E8 C0 FE        	call	0BBEh
3621:0CFE 5B              	pop	bx
3621:0CFF D1 E3           	shl	bx,1h
3621:0D01 F6 C1 04        	test	cl,4h
3621:0D04 74 17           	jz	0D1Dh

l3621_0D06:
3621:0D06 F6 C1 20        	test	cl,20h
3621:0D09 75 12           	jnz	0D1Dh

l3621_0D0B:
3621:0D0B 8B 87 82 6A     	mov	ax,[bx+6A82h]
3621:0D0F 8A E8           	mov	ch,al
3621:0D11 B0 B7           	mov	al,0B7h
3621:0D13 E8 A8 FE        	call	0BBEh
3621:0D16 8A E5           	mov	ah,ch
3621:0D18 B0 A7           	mov	al,0A7h
3621:0D1A E8 A1 FE        	call	0BBEh

l3621_0D1D:
3621:0D1D F6 C1 34        	test	cl,34h
3621:0D20 74 25           	jz	0D47h

l3621_0D22:
3621:0D22 8B 9F 74 6A     	mov	bx,[bx+6A74h]
3621:0D26 89 5C 0E        	mov	[si+0Eh],bx
3621:0D29 8A 44 0A        	mov	al,[si+0Ah]
3621:0D2C 04 A0           	add	al,0A0h
3621:0D2E 8A E3           	mov	ah,bl
3621:0D30 E8 8B FE        	call	0BBEh
3621:0D33 04 10           	add	al,10h
3621:0D35 8A E7           	mov	ah,bh
3621:0D37 E8 84 FE        	call	0BBEh
3621:0D3A F6 C1 20        	test	cl,20h
3621:0D3D 74 08           	jz	0D47h

l3621_0D3F:
3621:0D3F 0D 00 20        	or	ax,2000h
3621:0D42 E8 79 FE        	call	0BBEh
3621:0D45 EB 16           	jmp	0D5Dh

l3621_0D47:
3621:0D47 B0 BD           	mov	al,0BDh
3621:0D49 8A E1           	mov	ah,cl
3621:0D4B F6 D4           	not	ah
3621:0D4D 22 26 72 6A     	and	ah,[6A72h]
3621:0D51 E8 6A FE        	call	0BBEh
3621:0D54 0A E1           	or	ah,cl
3621:0D56 E8 65 FE        	call	0BBEh
3621:0D59 88 26 72 6A     	mov	[6A72h],ah

l3621_0D5D:
3621:0D5D C3              	ret
3621:0D5E                                           BA 88               ..
3621:0D60 03 F6 44 04 20 74 0C 8B 44 0E B0 B0             ..D. t..D...    

;; AdLibMIDIVoiceOff_0D6C: 3621:0D6C
AdLibMIDIVoiceOff_0D6C proc
3621:0D6C 02 44 0A        	add	al,[si+0Ah]
3621:0D6F E8 4C FE        	call	0BBEh
3621:0D72 C3              	ret
3621:0D73          B0 BD 8A 64 04 F6 D4 22 26 72 6A E8 3D    ...d..."&rj.=
3621:0D80 FE 88 26 72 6A C3 BA 88 03 BB B2 6B E8 50 FE 8B ..&rj......k.P..
3621:0D90 36 54 6A 33                                     6Tj3            

;; ResetAdLibMIDIDriver_0D94: 3621:0D94
ResetAdLibMIDIDriver_0D94 proc
3621:0D94 C9              	leave
3621:0D95 8A 0E 56 6A     	mov	cl,[6A56h]
3621:0D99 E3 41           	jcxz	0DDCh

l3621_0D9B:
3621:0D9B BB 9E 6B        	mov	bx,6B9Eh
3621:0D9E B8 5A 6B        	mov	ax,6B5Ah
3621:0DA1 C6 06 72 6A 20  	mov	byte ptr [6A72h],20h
3621:0DA6 83 F9 0B        	cmp	cx,0Bh
3621:0DA9 74 0B           	jz	0DB6h

l3621_0DAB:
3621:0DAB BB 9A 6B        	mov	bx,6B9Ah
3621:0DAE B8 7B 6B        	mov	ax,6B7Bh
3621:0DB1 C6 06 72 6A 00  	mov	byte ptr [6A72h],0h

l3621_0DB6:
3621:0DB6 50              	push	ax
3621:0DB7 BA 88 03        	mov	dx,388h
3621:0DBA E8 22 FE        	call	0BDFh
3621:0DBD 5B              	pop	bx

l3621_0DBE:
3621:0DBE 8A 07           	mov	al,[bx]
3621:0DC0 88 44 0A        	mov	[si+0Ah],al
3621:0DC3 8A 47 01        	mov	al,[bx+1h]
3621:0DC6 88 44 0B        	mov	[si+0Bh],al
3621:0DC9 8A 47 02        	mov	al,[bx+2h]
3621:0DCC 88 44 04        	mov	[si+4h],al
3621:0DCF C7 44 0C 00 00  	mov	word ptr [si+0Ch],0h
3621:0DD4 83 C3 03        	add	bx,3h
3621:0DD7 83 C6 20        	add	si,20h
3621:0DDA E2 E2           	loop	0DBEh

l3621_0DDC:
3621:0DDC C3              	ret
3621:0DDD                                        FC AC 88              ...
3621:0DE0 05 AC 8A E8 80 E5 78 D0 E5 24 03                ......x..$.     

;; LoadAdLibMIDIInstrument_0DEB: 3621:0DEB
LoadAdLibMIDIInstrument_0DEB proc
3621:0DEB 88 45 04        	mov	[di+4h],al
3621:0DEE AC              	lodsb
3621:0DEF 8A E0           	mov	ah,al
3621:0DF1 80 E4 0F        	and	ah,0Fh
3621:0DF4 0A EC           	or	ch,ah
3621:0DF6 24 60           	and	al,60h
3621:0DF8 D0 E0           	shl	al,1h
3621:0DFA 88 45 01        	mov	[di+1h],al
3621:0DFD AC              	lodsb
3621:0DFE 8A C8           	mov	cl,al
3621:0E00 80 E1 78        	and	cl,78h
3621:0E03 D0 E1           	shl	cl,1h
3621:0E05 24 07           	and	al,7h
3621:0E07 D0 E0           	shl	al,1h
3621:0E09 88 45 05        	mov	[di+5h],al
3621:0E0C AC              	lodsb
3621:0E0D 8A E0           	mov	ah,al
3621:0E0F 80 E4 0F        	and	ah,0Fh
3621:0E12 0A CC           	or	cl,ah
3621:0E14 24 40           	and	al,40h
3621:0E16 D0 E0           	shl	al,1h
3621:0E18 08 05           	or	[di],al
3621:0E1A 89 4D 02        	mov	[di+2h],cx
3621:0E1D AC              	lodsb
3621:0E1E 24 3F           	and	al,3Fh
3621:0E20 08 45 01        	or	[di+1h],al
3621:0E23 AC              	lodsb
3621:0E24 88 45 06        	mov	[di+6h],al
3621:0E27 AC              	lodsb
3621:0E28 8A E8           	mov	ch,al
3621:0E2A 80 E5 78        	and	ch,78h
3621:0E2D D0 E5           	shl	ch,1h
3621:0E2F 24 03           	and	al,3h
3621:0E31 88 45 0A        	mov	[di+0Ah],al
3621:0E34 AC              	lodsb
3621:0E35 8A E0           	mov	ah,al
3621:0E37 80 E4 0F        	and	ah,0Fh
3621:0E3A 0A EC           	or	ch,ah
3621:0E3C 24 60           	and	al,60h
3621:0E3E D0 E0           	shl	al,1h
3621:0E40 88 45 07        	mov	[di+7h],al
3621:0E43 AC              	lodsb
3621:0E44 8A C8           	mov	cl,al
3621:0E46 80 E1 78        	and	cl,78h
3621:0E49 D0 E1           	shl	cl,1h
3621:0E4B AC              	lodsb
3621:0E4C 8A E0           	mov	ah,al
3621:0E4E 80 E4 0F        	and	ah,0Fh
3621:0E51 0A CC           	or	cl,ah
3621:0E53 24 40           	and	al,40h
3621:0E55 D0 E0           	shl	al,1h
3621:0E57 08 45 06        	or	[di+6h],al
3621:0E5A 89 4D 08        	mov	[di+8h],cx
3621:0E5D C3              	ret
3621:0E5E                                           CB 00               ..
3621:0E60 FA BA 31 03 33 C9 EC A8 40 E0 FB E3             ..1.3...@...    

;; ServiceAdLibMIDIDriver_0E6C: 3621:0E6C
ServiceAdLibMIDIDriver_0E6C proc
3621:0E6C 23 B0 FF EE     	and	si,[bx+si+0EEFFh]

;; RolandMIDIDriverProbe_0E6E: 3621:0E6E
RolandMIDIDriverProbe_0E6E proc
3621:0E6E FF EE           	jmp	esi
3621:0E70 33 C9 EC A8 40 E0 FB E3 17 B0 00 EE 33 C9 EC A8 3...@.......3...
3621:0E80 80 E0 FB E3 0B 4A EC 3C FE 75 05 FB B8 01 00 C3 .....J.<.u......
3621:0E90 FB 33 C0 C3 FA BA 31 03 B0 3F EE 33 C0 A3 12 6D .3....1..?.3...m
3621:0EA0 A3 14                                           ..              

;; ActivateRolandMIDIDriver_0EA2: 3621:0EA2
ActivateRolandMIDIDriver_0EA2 proc
3621:0EA2 6D              	insw
3621:0EA3 A3 16 6D        	mov	[6D16h],ax
3621:0EA6 53              	push	bx
3621:0EA7 B8 0A 35        	mov	ax,350Ah
3621:0EAA CD 21           	int	21h
3621:0EAC 89 1E 0E 6C     	mov	[6C0Eh],bx
3621:0EB0 8C 06 10 6C     	mov	[6C10h],es
3621:0EB4 5B              	pop	bx
3621:0EB5 BA 60 0F        	mov	dx,0F60h
3621:0EB8 8C C8           	mov	ax,cs
3621:0EBA 1E              	push	ds
3621:0EBB 8E D8           	mov	ds,ax
3621:0EBD B8 0A 25        	mov	ax,250Ah
3621:0EC0 CD 21           	int	21h
3621:0EC2 1F              	pop	ds
3621:0EC3 BA 30 03        	mov	dx,330h
3621:0EC6 EC              	in	al,dx
3621:0EC7 EC              	in	al,dx
3621:0EC8 EC              	in	al,dx
3621:0EC9 EC              	in	al,dx
3621:0ECA EC              	in	al,dx
3621:0ECB EC              	in	al,dx
3621:0ECC EC              	in	al,dx
3621:0ECD EC              	in	al,dx
3621:0ECE EC              	in	al,dx
3621:0ECF EC              	in	al,dx
3621:0ED0 B0 20           	mov	al,20h
3621:0ED2 E6 20           	out	20h,al
3621:0ED4 B0 00           	mov	al,0h
3621:0ED6 E6 21           	out	21h,al
3621:0ED8 FB              	sti
3621:0ED9 C3              	ret
3621:0EDA                               83 3E 16 6D 00 75           .>.m.u
3621:0EE0 F9 FA 8B 16 0E 6C A1 10                         .....l..        

;; DeactivateRolandMIDIDriver_0EE8: 3621:0EE8
DeactivateRolandMIDIDriver_0EE8 proc
3621:0EE8 6C              	insb
3621:0EE9 1E              	push	ds
3621:0EEA 8E D8           	mov	ds,ax
3621:0EEC B8 0A 25        	mov	ax,250Ah
3621:0EEF CD 21           	int	21h
3621:0EF1 1F              	pop	ds
3621:0EF2 FB              	sti
3621:0EF3 C3              	ret
3621:0EF4             0A C0 79 0F 3C F0 73 0B 8A D8 83 E3     ..y.<.s.....
3621:0F00 0F 24                                           .$              

;; FilterRolandMIDIByte_0F02: 3621:0F02
FilterRolandMIDIByte_0F02 proc
3621:0F02 F0              	lock
3621:0F03 0A 87 28 67     	or	al,[bx+6728h]

l3621_0F07:
3621:0F07 81 3E 16 6D 00 01 	cmp	word ptr [6D16h],100h
3621:0F0D 73 F8           	jnc	0F07h

l3621_0F0F:
3621:0F0F FA              	cli
3621:0F10 8B 1E 12 6D     	mov	bx,[6D12h]
3621:0F14 88 87 12 6C     	mov	[bx+6C12h],al
3621:0F18 43              	inc	bx
3621:0F19 81 FB 00 01     	cmp	bx,100h
3621:0F1D 72 02           	jc	0F21h

l3621_0F1F:
3621:0F1F 33 DB           	xor	bx,bx

l3621_0F21:
3621:0F21 89 1E 12 6D     	mov	[6D12h],bx
3621:0F25 FF 06 16 6D     	inc	word ptr [6D16h]
3621:0F29 FB              	sti
3621:0F2A B8 01 00        	mov	ax,1h
3621:0F2D C3              	ret
3621:0F2E                                           B0 FF               ..
3621:0F30 EB C2 C3 83 3E 16 6D 00 74 25 BA 31             ....>.m.t%.1    

;; ResetRolandMIDIDriver_0F3C: 3621:0F3C
ResetRolandMIDIDriver_0F3C proc
3621:0F3C 03 EC           	add	bp,sp
3621:0F3E A8 40           	test	al,40h

;; RolandMIDIDriverNoOp_0F40: 3621:0F40
;;   Called from:
;;     3621:0F3E (in ResetRolandMIDIDriver_0F3C)
RolandMIDIDriverNoOp_0F40 proc
3621:0F40 75 1D           	jnz	0F5Fh

;; ServiceRolandMIDIDriver_0F41: 3621:0F41
ServiceRolandMIDIDriver_0F41 proc
3621:0F41 1D 8B 1E        	sbb	ax,1E8Bh

l3621_0F42:
3621:0F42 8B 1E 14 6D     	mov	bx,[6D14h]
3621:0F46 8A 87 12 6C     	mov	al,[bx+6C12h]
3621:0F4A BA 30 03        	mov	dx,330h
3621:0F4D EE              	out	dx,al
3621:0F4E 43              	inc	bx
3621:0F4F 81 FB 00 01     	cmp	bx,100h
3621:0F53 72 02           	jc	0F57h

;; WrapRolandMIDIQueueReadIndex_0F55: 3621:0F55
;;   Called from:
;;     3621:0F53 (in ServiceRolandMIDIDriver_0F41)
;;     3621:0F53 (in RolandMIDIDriverNoOp_0F40)
WrapRolandMIDIQueueReadIndex_0F55 proc
3621:0F55 33 DB           	xor	bx,bx

;; CommitRolandMIDIQueueRead_0F57: 3621:0F57
;;   Called from:
;;     3621:0F53 (in ServiceRolandMIDIDriver_0F41)
;;     3621:0F53 (in RolandMIDIDriverNoOp_0F40)
;;     3621:0F55 (in WrapRolandMIDIQueueReadIndex_0F55)
CommitRolandMIDIQueueRead_0F57 proc
3621:0F57 89 1E 14 6D     	mov	[6D14h],bx
3621:0F5B FF 0E 16 6D     	dec	word ptr [6D16h]

l3621_0F5F:
3621:0F5F CB              	retf
