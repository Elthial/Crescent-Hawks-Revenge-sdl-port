;;; Segment 30B2 (30B2:0000)
30B2:0000 03 B2 30 CB                                     ..0.            
30AF:0034             00 00 00 00 00 00 00 00 00 00 00 00     ............

;; MusicTimerIRQ0Handler_0010: 30B2:0010
MusicTimerIRQ0Handler_0010 proc
30B2:0010 50              	push	ax
30B2:0011 1E              	push	ds
30B2:0012 B8 6B 42        	mov	ax,426Bh
30B2:0015 8E D8           	mov	ds,ax
30B2:0017 A1 0C 00        	mov	ax,[000Ch]
30B2:001A 0A C0           	or	al,al
30B2:001C 75 39           	jnz	0057h

l30B2_001E:
30B2:001E A1 E7 00        	mov	ax,[00E7h]
30B2:0021 40              	inc	ax
30B2:0022 3D 23 01        	cmp	ax,123h
30B2:0025 7E 10           	jle	0037h

l30B2_0027:
30B2:0027 A0 E9 00        	mov	al,[00E9h]
30B2:002A FE C0           	inc	al
30B2:002C 3C 3B           	cmp	al,3Bh
30B2:002E 7E 02           	jle	0032h

l30B2_0030:
30B2:0030 32 C0           	xor	al,al

l30B2_0032:
30B2:0032 A2 E9 00        	mov	[00E9h],al
30B2:0035 33 C0           	xor	ax,ax

l30B2_0037:
30B2:0037 A3 E7 00        	mov	[00E7h],ax
30B2:003A E8 A2 00        	call	00DFh
30B2:003D A1 0A 00        	mov	ax,[000Ah]
30B2:0040 0A C0           	or	al,al
30B2:0042 75 0E           	jnz	0052h

l30B2_0044:
30B2:0044 A1 08 00        	mov	ax,[0008h]
30B2:0047 A3 0A 00        	mov	[000Ah],ax
30B2:004A C6 06 07 00 01  	mov	byte ptr [0007h],1h
30B2:004F EB 06           	jmp	0057h
30B2:0051    90                                            .              

l30B2_0052:
30B2:0052 FE C8           	dec	al
30B2:0054 A3 0A 00        	mov	[000Ah],ax

l30B2_0057:
30B2:0057 80 3E 04 00 00  	cmp	byte ptr [0004h],0h
30B2:005C 74 13           	jz	0071h

l30B2_005E:
30B2:005E 53              	push	bx
30B2:005F 51              	push	cx
30B2:0060 52              	push	dx
30B2:0061 06              	push	es
30B2:0062 1E              	push	ds
30B2:0063 8E 1E 02 00     	mov	ds,[0002h]
30B2:0067 9A A1 08 21 36  	call	far 3621h:08A1h
30B2:006C 1F              	pop	ds
30B2:006D 07              	pop	es
30B2:006E 5A              	pop	dx
30B2:006F 59              	pop	cx
30B2:0070 5B              	pop	bx

l30B2_0071:
30B2:0071 A1 0C 00        	mov	ax,[000Ch]
30B2:0074 0A C0           	or	al,al
30B2:0076 74 08           	jz	0080h

l30B2_0078:
30B2:0078 FE C8           	dec	al
30B2:007A A3 0C 00        	mov	[000Ch],ax
30B2:007D EB 07           	jmp	0086h
30B2:007F                                              90                .

l30B2_0080:
30B2:0080 A1 0E 00        	mov	ax,[000Eh]
30B2:0083 A3 0C 00        	mov	[000Ch],ax

l30B2_0086:
30B2:0086 80 3E 07 00 00  	cmp	byte ptr [0007h],0h
30B2:008B 74 0C           	jz	0099h

l30B2_008D:
30B2:008D C6 06 07 00 00  	mov	byte ptr [0007h],0h
30B2:0092 1F              	pop	ds
30B2:0093 58              	pop	ax
30B2:0094 2E FF 2E 04 00  	jmp	dword ptr cs:[0004h]

l30B2_0099:
30B2:0099 B0 20           	mov	al,20h
30B2:009B E6 20           	out	20h,al
30B2:009D 80 3E 04 00 00  	cmp	byte ptr [0004h],0h
30B2:00A2 74 38           	jz	00DCh

l30B2_00A4:
30B2:00A4 83 3E 0C 00 01  	cmp	word ptr [000Ch],1h
30B2:00A9 75 31           	jnz	00DCh

l30B2_00AB:
30B2:00AB A1 0A 00        	mov	ax,[000Ah]
30B2:00AE 25 03 00        	and	ax,3h
30B2:00B1 3C 01           	cmp	al,1h
30B2:00B3 75 27           	jnz	00DCh

l30B2_00B5:
30B2:00B5 FB              	sti
30B2:00B6 83 3E 10 00 00  	cmp	word ptr [0010h],0h
30B2:00BB 75 1F           	jnz	00DCh

l30B2_00BD:
30B2:00BD C7 06 10 00 01 00 	mov	word ptr [0010h],1h
30B2:00C3 53              	push	bx
30B2:00C4 51              	push	cx
30B2:00C5 52              	push	dx
30B2:00C6 06              	push	es
30B2:00C7 1E              	push	ds
30B2:00C8 8E 1E 02 00     	mov	ds,[0002h]
30B2:00CC 9A E8 01 21 36  	call	far 3621h:01E8h
30B2:00D1 1F              	pop	ds
30B2:00D2 07              	pop	es
30B2:00D3 5A              	pop	dx
30B2:00D4 59              	pop	cx
30B2:00D5 5B              	pop	bx
30B2:00D6 C7 06 10 00 00 00 	mov	word ptr [0010h],0h

l30B2_00DC:
30B2:00DC 1F              	pop	ds
30B2:00DD 58              	pop	ax
30B2:00DE CF              	iret

;; DecodePCSpeakerEffectTick_00DF: 30B2:00DF
;;   Called from:
;;     30B2:003A (in MusicTimerIRQ0Handler_0010)
DecodePCSpeakerEffectTick_00DF proc
30B2:00DF 80 3E E1 00 00  	cmp	byte ptr [00E1h],0h
30B2:00E4 74 2B           	jz	0111h

l30B2_00E6:
30B2:00E6 C6 06 05 00 01  	mov	byte ptr [0005h],1h
30B2:00EB C6 06 E0 00 01  	mov	byte ptr [00E0h],1h
30B2:00F0 C6 06 E3 00 01  	mov	byte ptr [00E3h],1h
30B2:00F5 C6 06 E1 00 00  	mov	byte ptr [00E1h],0h
30B2:00FA C6 06 E2 00 00  	mov	byte ptr [00E2h],0h
30B2:00FF A1 18 00        	mov	ax,[0018h]
30B2:0102 A3 12 00        	mov	[0012h],ax
30B2:0105 A1 1A 00        	mov	ax,[001Ah]
30B2:0108 A3 14 00        	mov	[0014h],ax
30B2:010B C7 06 16 00 00 00 	mov	word ptr [0016h],0h

l30B2_0111:
30B2:0111 80 3E E0 00 00  	cmp	byte ptr [00E0h],0h
30B2:0116 75 03           	jnz	011Bh

l30B2_0118:
30B2:0118 E9 75 01        	jmp	0290h

l30B2_011B:
30B2:011B 06              	push	es
30B2:011C 56              	push	si
30B2:011D 53              	push	bx
30B2:011E 52              	push	dx
30B2:011F 8B 1E 16 00     	mov	bx,[0016h]
30B2:0123 80 3E E3 00 00  	cmp	byte ptr [00E3h],0h
30B2:0128 75 03           	jnz	012Dh

l30B2_012A:
30B2:012A E9 30 01        	jmp	025Dh

l30B2_012D:
30B2:012D 8E 06 14 00     	mov	es,[0014h]
30B2:0131 8B 36 12 00     	mov	si,[0012h]
30B2:0135 03 F3           	add	si,bx

l30B2_0137:
30B2:0137 26 8A 04        	mov	al,es:[si]
30B2:013A 0A C0           	or	al,al
30B2:013C 78 3F           	js	017Dh

l30B2_013E:
30B2:013E 3C 5F           	cmp	al,5Fh
30B2:0140 7E 03           	jle	0145h

l30B2_0142:
30B2:0142 E9 31 01        	jmp	0276h

l30B2_0145:
30B2:0145 57              	push	di
30B2:0146 32 E4           	xor	ah,ah
30B2:0148 D1 E0           	shl	ax,1h
30B2:014A 8B F8           	mov	di,ax
30B2:014C 8B 85 20 00     	mov	ax,[di+20h]
30B2:0150 5F              	pop	di

l30B2_0151:
30B2:0151 0B C0           	or	ax,ax
30B2:0153 74 09           	jz	015Eh

l30B2_0155:
30B2:0155 E8 47 01        	call	029Fh
30B2:0158 E8 36 01        	call	0291h
30B2:015B EB 04           	jmp	0161h
30B2:015D                                        90                    .  

l30B2_015E:
30B2:015E E8 37 01        	call	0298h

l30B2_0161:
30B2:0161 46              	inc	si
30B2:0162 32 E4           	xor	ah,ah
30B2:0164 26 8A 04        	mov	al,es:[si]
30B2:0167 FE C0           	inc	al
30B2:0169 F6 26 E4 00     	mul	byte ptr [00E4h]
30B2:016D 48              	dec	ax
30B2:016E A3 1E 00        	mov	[001Eh],ax
30B2:0171 46              	inc	si
30B2:0172 83 C3 02        	add	bx,2h
30B2:0175 C6 06 E3 00 00  	mov	byte ptr [00E3h],0h
30B2:017A E9 0B 01        	jmp	0288h

l30B2_017D:
30B2:017D 3C CE           	cmp	al,0CEh
30B2:017F 75 1E           	jnz	019Fh

l30B2_0181:
30B2:0181 FE 0E E5 00     	dec	byte ptr [00E5h]
30B2:0185 75 08           	jnz	018Fh

l30B2_0187:
30B2:0187 83 C6 03        	add	si,3h
30B2:018A 83 C3 03        	add	bx,3h
30B2:018D EB A8           	jmp	0137h

l30B2_018F:
30B2:018F 46              	inc	si
30B2:0190 26 8B 04        	mov	ax,es:[si]
30B2:0193 43              	inc	bx
30B2:0194 2B F0           	sub	si,ax
30B2:0196 2B D8           	sub	bx,ax
30B2:0198 71 03           	jno	019Dh

l30B2_019A:
30B2:019A E9 D9 00        	jmp	0276h

l30B2_019D:
30B2:019D EB 98           	jmp	0137h

l30B2_019F:
30B2:019F 3C CD           	cmp	al,0CDh
30B2:01A1 75 13           	jnz	01B6h

l30B2_01A3:
30B2:01A3 46              	inc	si
30B2:01A4 26 8A 04        	mov	al,es:[si]
30B2:01A7 0A C0           	or	al,al
30B2:01A9 75 02           	jnz	01ADh

l30B2_01AB:
30B2:01AB B0 01           	mov	al,1h

l30B2_01AD:
30B2:01AD A2 E5 00        	mov	[00E5h],al
30B2:01B0 46              	inc	si
30B2:01B1 83 C3 02        	add	bx,2h
30B2:01B4 EB 81           	jmp	0137h

l30B2_01B6:
30B2:01B6 3C D2           	cmp	al,0D2h
30B2:01B8 75 20           	jnz	01DAh

l30B2_01BA:
30B2:01BA FE 0E E6 00     	dec	byte ptr [00E6h]
30B2:01BE 75 09           	jnz	01C9h

l30B2_01C0:
30B2:01C0 83 C6 03        	add	si,3h
30B2:01C3 83 C3 03        	add	bx,3h
30B2:01C6 E9 6E FF        	jmp	0137h

l30B2_01C9:
30B2:01C9 46              	inc	si
30B2:01CA 26 8B 04        	mov	ax,es:[si]
30B2:01CD 43              	inc	bx
30B2:01CE 2B F0           	sub	si,ax
30B2:01D0 2B D8           	sub	bx,ax
30B2:01D2 71 03           	jno	01D7h

l30B2_01D4:
30B2:01D4 E9 9F 00        	jmp	0276h

l30B2_01D7:
30B2:01D7 E9 5D FF        	jmp	0137h

l30B2_01DA:
30B2:01DA 3C D1           	cmp	al,0D1h
30B2:01DC 75 14           	jnz	01F2h

l30B2_01DE:
30B2:01DE 46              	inc	si
30B2:01DF 26 8A 04        	mov	al,es:[si]
30B2:01E2 0A C0           	or	al,al
30B2:01E4 75 02           	jnz	01E8h

l30B2_01E6:
30B2:01E6 B0 01           	mov	al,1h

l30B2_01E8:
30B2:01E8 A2 E6 00        	mov	[00E6h],al
30B2:01EB 46              	inc	si
30B2:01EC 83 C3 02        	add	bx,2h
30B2:01EF E9 45 FF        	jmp	0137h

l30B2_01F2:
30B2:01F2 3C E6           	cmp	al,0E6h
30B2:01F4 75 11           	jnz	0207h

l30B2_01F6:
30B2:01F6 46              	inc	si
30B2:01F7 BA 12 00        	mov	dx,12h
30B2:01FA B8 DC 34        	mov	ax,34DCh
30B2:01FD 26 F7 34        	div	word ptr es:[si]
30B2:0200 46              	inc	si
30B2:0201 83 C3 02        	add	bx,2h
30B2:0204 E9 4A FF        	jmp	0151h

l30B2_0207:
30B2:0207 3C E2           	cmp	al,0E2h
30B2:0209 75 14           	jnz	021Fh

l30B2_020B:
30B2:020B 46              	inc	si
30B2:020C 26 8A 04        	mov	al,es:[si]
30B2:020F 0A C0           	or	al,al
30B2:0211 75 02           	jnz	0215h

l30B2_0213:
30B2:0213 B0 01           	mov	al,1h

l30B2_0215:
30B2:0215 A2 E4 00        	mov	[00E4h],al
30B2:0218 46              	inc	si
30B2:0219 83 C3 02        	add	bx,2h
30B2:021C E9 18 FF        	jmp	0137h

l30B2_021F:
30B2:021F 3C E8           	cmp	al,0E8h
30B2:0221 75 18           	jnz	023Bh

l30B2_0223:
30B2:0223 46              	inc	si
30B2:0224 26 8A 04        	mov	al,es:[si]
30B2:0227 28 06 E4 00     	sub	[00E4h],al
30B2:022B 71 07           	jno	0234h

l30B2_022D:
30B2:022D 75 05           	jnz	0234h

l30B2_022F:
30B2:022F C6 06 E4 00 01  	mov	byte ptr [00E4h],1h

l30B2_0234:
30B2:0234 46              	inc	si
30B2:0235 83 C3 02        	add	bx,2h
30B2:0238 E9 FC FE        	jmp	0137h

l30B2_023B:
30B2:023B 3C E9           	cmp	al,0E9h
30B2:023D 75 16           	jnz	0255h

l30B2_023F:
30B2:023F 46              	inc	si
30B2:0240 26 8A 04        	mov	al,es:[si]
30B2:0243 00 06 E4 00     	add	[00E4h],al
30B2:0247 71 05           	jno	024Eh

l30B2_0249:
30B2:0249 C6 06 E4 00 FF  	mov	byte ptr [00E4h],0FFh

l30B2_024E:
30B2:024E 46              	inc	si
30B2:024F 83 C3 02        	add	bx,2h
30B2:0252 E9 E2 FE        	jmp	0137h

l30B2_0255:
30B2:0255 3C FF           	cmp	al,0FFh
30B2:0257 75 1D           	jnz	0276h

l30B2_0259:
30B2:0259 43              	inc	bx
30B2:025A EB 1A           	jmp	0276h
30B2:025C                                     90                      .   

l30B2_025D:
30B2:025D FF 0E 1E 00     	dec	word ptr [001Eh]
30B2:0261 79 0C           	jns	026Fh

l30B2_0263:
30B2:0263 83 3E 1E 00 FF  	cmp	word ptr [001Eh],0FFh
30B2:0268 74 05           	jz	026Fh

l30B2_026A:
30B2:026A C6 06 E3 00 01  	mov	byte ptr [00E3h],1h

l30B2_026F:
30B2:026F 80 3E E2 00 00  	cmp	byte ptr [00E2h],0h
30B2:0274 74 12           	jz	0288h

l30B2_0276:
30B2:0276 E8 1F 00        	call	0298h
30B2:0279 C6 06 E2 00 00  	mov	byte ptr [00E2h],0h
30B2:027E C6 06 E0 00 00  	mov	byte ptr [00E0h],0h
30B2:0283 C6 06 05 00 00  	mov	byte ptr [0005h],0h

l30B2_0288:
30B2:0288 89 1E 16 00     	mov	[0016h],bx
30B2:028C 5A              	pop	dx
30B2:028D 5B              	pop	bx
30B2:028E 5E              	pop	si
30B2:028F 07              	pop	es

l30B2_0290:
30B2:0290 C3              	ret

;; EnablePCSpeaker_0291: 30B2:0291
;;   Called from:
;;     30B2:0158 (in DecodePCSpeakerEffectTick_00DF)
;;     30B2:02B8 (in StartPCSpeakerFixedTone_02A6)
EnablePCSpeaker_0291 proc
30B2:0291 E4 61           	in	al,61h
30B2:0293 0C 03           	or	al,3h
30B2:0295 E6 61           	out	61h,al
30B2:0297 C3              	ret

;; SilencePCSpeaker_0298: 30B2:0298
;;   Called from:
;;     30B2:015E (in DecodePCSpeakerEffectTick_00DF)
;;     30B2:0276 (in DecodePCSpeakerEffectTick_00DF)
SilencePCSpeaker_0298 proc
30B2:0298 E4 61           	in	al,61h
30B2:029A 24 FC           	and	al,0FCh
30B2:029C E6 61           	out	61h,al
30B2:029E C3              	ret

;; WritePCSpeakerPITDivisor_029F: 30B2:029F
;;   Called from:
;;     30B2:0155 (in DecodePCSpeakerEffectTick_00DF)
;;     30B2:02B5 (in StartPCSpeakerFixedTone_02A6)
WritePCSpeakerPITDivisor_029F proc
30B2:029F E6 42           	out	42h,al
30B2:02A1 8A C4           	mov	al,ah
30B2:02A3 E6 42           	out	42h,al
30B2:02A5 C3              	ret

;; StartPCSpeakerFixedTone_02A6: 30B2:02A6
;;   Called from:
;;     3014:015A (in StartLoadedMusicTrack_0153)
StartPCSpeakerFixedTone_02A6 proc
30B2:02A6 55              	push	bp
30B2:02A7 8B EC           	mov	bp,sp
30B2:02A9 57              	push	di
30B2:02AA 56              	push	si
30B2:02AB 1E              	push	ds
30B2:02AC B8 6B 42        	mov	ax,426Bh
30B2:02AF 8E D8           	mov	ds,ax
30B2:02B1 FA              	cli
30B2:02B2 B8 0E 00        	mov	ax,0Eh
30B2:02B5 E8 E7 FF        	call	029Fh
30B2:02B8 E8 D6 FF        	call	0291h
30B2:02BB FB              	sti
30B2:02BC 1F              	pop	ds
30B2:02BD 5E              	pop	si
30B2:02BE 5F              	pop	di
30B2:02BF 5D              	pop	bp
30B2:02C0 CB              	retf

;; DisablePCSpeaker_02C1: 30B2:02C1
;;   Called from:
;;     3014:0191 (in StopLoadedMusicTrack_0185)
;;     30B2:0378 (in InstallMusicTimer_02D9)
;;     30B2:03AC (in RestoreSystemTimer_0382)
DisablePCSpeaker_02C1 proc
30B2:02C1 55              	push	bp
30B2:02C2 8B EC           	mov	bp,sp
30B2:02C4 57              	push	di
30B2:02C5 56              	push	si
30B2:02C6 1E              	push	ds
30B2:02C7 B8 6B 42        	mov	ax,426Bh
30B2:02CA 8E D8           	mov	ds,ax
30B2:02CC FA              	cli
30B2:02CD E4 61           	in	al,61h
30B2:02CF 24 FC           	and	al,0FCh
30B2:02D1 E6 61           	out	61h,al
30B2:02D3 FB              	sti
30B2:02D4 1F              	pop	ds
30B2:02D5 5E              	pop	si
30B2:02D6 5F              	pop	di
30B2:02D7 5D              	pop	bp
30B2:02D8 CB              	retf

;; InstallMusicTimer_02D9: 30B2:02D9
;;   Called from:
;;     2C7F:02C0 (in InitializeGame_003C)
;;     31FB:0736 (in HandleDigitalWeaponEffectCompletion_06E9)
;;     31FB:1297 (in PlayScenarioDigitalSoundSequence_0742)
InstallMusicTimer_02D9 proc
30B2:02D9 55              	push	bp
30B2:02DA 8B EC           	mov	bp,sp
30B2:02DC 57              	push	di
30B2:02DD 56              	push	si
30B2:02DE 1E              	push	ds
30B2:02DF B8 6B 42        	mov	ax,426Bh
30B2:02E2 8E D8           	mov	ds,ax
30B2:02E4 58              	pop	ax
30B2:02E5 A3 02 00        	mov	[0002h],ax
30B2:02E8 50              	push	ax
30B2:02E9 1E              	push	ds
30B2:02EA B0 08           	mov	al,8h
30B2:02EC B4 35           	mov	ah,35h
30B2:02EE CD 21           	int	21h
30B2:02F0 2E 89 1E 04 00  	mov	cs:[0004h],bx
30B2:02F5 2E 8C 06 06 00  	mov	cs:[0006h],es
30B2:02FA C7 06 08 00 0F 00 	mov	word ptr [0008h],0Fh
30B2:0300 C7 06 0A 00 00 00 	mov	word ptr [000Ah],0h
30B2:0306 80 3E 04 00 02  	cmp	byte ptr [0004h],2h
30B2:030B 74 31           	jz	033Eh

l30B2_030D:
30B2:030D 80 3E 04 00 01  	cmp	byte ptr [0004h],1h
30B2:0312 74 15           	jz	0329h

l30B2_0314:
30B2:0314 C7 06 0E 00 00 00 	mov	word ptr [000Eh],0h
30B2:031A C7 06 0C 00 00 00 	mov	word ptr [000Ch],0h
30B2:0320 C7 06 10 00 00 00 	mov	word ptr [0010h],0h
30B2:0326 EB 28           	jmp	0350h
30B2:0328                         90                              .       

l30B2_0329:
30B2:0329 C7 06 0E 00 03 00 	mov	word ptr [000Eh],3h
30B2:032F C7 06 0C 00 00 00 	mov	word ptr [000Ch],0h
30B2:0335 C7 06 10 00 00 00 	mov	word ptr [0010h],0h
30B2:033B EB 13           	jmp	0350h
30B2:033D                                        90                    .  

l30B2_033E:
30B2:033E C7 06 0E 00 03 00 	mov	word ptr [000Eh],3h
30B2:0344 C7 06 0C 00 00 00 	mov	word ptr [000Ch],0h
30B2:034A C7 06 10 00 00 00 	mov	word ptr [0010h],0h

l30B2_0350:
30B2:0350 8C C8           	mov	ax,cs
30B2:0352 8E D8           	mov	ds,ax
30B2:0354 BA 10 00        	mov	dx,10h
30B2:0357 B0 08           	mov	al,8h
30B2:0359 B4 25           	mov	ah,25h
30B2:035B CD 21           	int	21h
30B2:035D B0 36           	mov	al,36h
30B2:035F E6 43           	out	43h,al
30B2:0361 1F              	pop	ds
30B2:0362 80 3E 04 00 00  	cmp	byte ptr [0004h],0h
30B2:0367 75 06           	jnz	036Fh

l30B2_0369:
30B2:0369 B8 00 10        	mov	ax,1000h
30B2:036C EB 04           	jmp	0372h
30B2:036E                                           90                  . 

l30B2_036F:
30B2:036F B8 00 04        	mov	ax,400h

l30B2_0372:
30B2:0372 E6 40           	out	40h,al
30B2:0374 8A C4           	mov	al,ah
30B2:0376 E6 40           	out	40h,al
30B2:0378 9A C1 02 B2 30  	call	far 30B2h:02C1h
30B2:037D 1F              	pop	ds
30B2:037E 5E              	pop	si
30B2:037F 5F              	pop	di
30B2:0380 5D              	pop	bp
30B2:0381 CB              	retf

;; RestoreSystemTimer_0382: 30B2:0382
;;   Called from:
;;     2C7F:0302 (in ShutdownGame_02E3)
;;     31FB:05AF (in PlayDigitalWeaponEffect_058D)
;;     31FB:10F2 (in PlayScenarioDigitalSoundSequence_0742)
RestoreSystemTimer_0382 proc
30B2:0382 55              	push	bp
30B2:0383 8B EC           	mov	bp,sp
30B2:0385 57              	push	di
30B2:0386 56              	push	si
30B2:0387 1E              	push	ds
30B2:0388 B8 6B 42        	mov	ax,426Bh
30B2:038B 8E D8           	mov	ds,ax
30B2:038D 2E 8B 16 04 00  	mov	dx,cs:[0004h]
30B2:0392 2E 8B 1E 06 00  	mov	bx,cs:[0006h]
30B2:0397 8E DB           	mov	ds,bx
30B2:0399 B0 08           	mov	al,8h
30B2:039B B4 25           	mov	ah,25h
30B2:039D CD 21           	int	21h
30B2:039F B0 36           	mov	al,36h
30B2:03A1 E6 43           	out	43h,al
30B2:03A3 B8 00 00        	mov	ax,0h
30B2:03A6 E6 40           	out	40h,al
30B2:03A8 8A C4           	mov	al,ah
30B2:03AA E6 40           	out	40h,al
30B2:03AC 9A C1 02 B2 30  	call	far 30B2h:02C1h
30B2:03B1 1F              	pop	ds
30B2:03B2 5E              	pop	si
30B2:03B3 5F              	pop	di
30B2:03B4 5D              	pop	bp
30B2:03B5 CB              	retf

;; StartPCSpeakerEffectStream_03B6: 30B2:03B6
;;   Called from:
;;     30AF:0025 (in PlayPCSpeakerEffectByIndex_078C)
StartPCSpeakerEffectStream_03B6 proc
30B2:03B6 55              	push	bp
30B2:03B7 8B EC           	mov	bp,sp
30B2:03B9 57              	push	di
30B2:03BA 56              	push	si
30B2:03BB 1E              	push	ds
30B2:03BC B8 6B 42        	mov	ax,426Bh
30B2:03BF 8E D8           	mov	ds,ax
30B2:03C1 8B 46 06        	mov	ax,[bp+6h]
30B2:03C4 A3 18 00        	mov	[0018h],ax
30B2:03C7 8B 46 08        	mov	ax,[bp+8h]
30B2:03CA A3 1A 00        	mov	[001Ah],ax
30B2:03CD C6 06 E1 00 01  	mov	byte ptr [00E1h],1h
30B2:03D2 C6 06 E0 00 01  	mov	byte ptr [00E0h],1h
30B2:03D7 C6 06 05 00 01  	mov	byte ptr [0005h],1h
30B2:03DC 1F              	pop	ds
30B2:03DD 5E              	pop	si
30B2:03DE 5F              	pop	di
30B2:03DF 5D              	pop	bp
30B2:03E0 CB              	retf

;; RequestPCSpeakerEffectStop_03E1: 30B2:03E1
;;   Called from:
;;     30AF:002E (in RequestPCSpeakerEffectStop_002E)
RequestPCSpeakerEffectStop_03E1 proc
30B2:03E1 55              	push	bp
30B2:03E2 8B EC           	mov	bp,sp
30B2:03E4 57              	push	di
30B2:03E5 56              	push	si
30B2:03E6 1E              	push	ds
30B2:03E7 B8 6B 42        	mov	ax,426Bh
30B2:03EA 8E D8           	mov	ds,ax
30B2:03EC C6 06 E2 00 01  	mov	byte ptr [00E2h],1h
