;;; Segment 3014 (3014:0000)
3014:0000 08 83 C4 0C                                     ....            

l3005_00F4:
3005:00F4 C7 06 3C 56 00 00 	mov	word ptr [563Ch],0h

l3005_00FA:
3005:00FA 5F              	pop	di
3005:00FB 5E              	pop	si
3005:00FC 5D              	pop	bp
3005:00FD CB              	retf

;; DisableMusicPlayback_000E: 3014:000E
;;   Called from:
;;     2C7F:0443 (in ServiceMusicAndCheckKeyboardInput_0427)
;;     3014:0180 (in StartLoadedMusicTrack_0153)
DisableMusicPlayback_000E proc
3014:000E 9A 93 01 21 36  	call	far 3621h:0193h
3014:0013 C7 06 0C 80 00 00 	mov	word ptr [800Ch],0h
3014:0019 CB              	retf

;; EnableMusicPlayback_001A: 3014:001A
;;   Called from:
;;     2C7F:044A (in ServiceMusicAndCheckKeyboardInput_0427)
;;     3014:017A (in StartLoadedMusicTrack_0153)
EnableMusicPlayback_001A proc
3014:001A 9A B1 01 21 36  	call	far 3621h:01B1h
3014:001F C7 06 0C 80 01 00 	mov	word ptr [800Ch],1h
3014:0025 CB              	retf
3014:0026                   83 3E 0C 80 00 74 06 0E E8 DD       .>...t....
3014:0030 FF EB 04 0E E8 E3 FF CB                         ........        

;; InitializeMusicDriver_0038: 3014:0038
;;   Called from:
;;     2C7F:02B5 (in InitializeGame_003C)
InitializeMusicDriver_0038 proc
3014:0038 9A 17 01 14 30  	call	far 3014h:0117h
3014:003D A0 AF 85        	mov	al,[85AFh]
3014:0040 98              	cbw
3014:0041 3D 04 00        	cmp	ax,4h
3014:0044 76 03           	jbe	0049h

l3014_0046:
3014:0046 E9 CD 00        	jmp	0116h

l3014_0049:
3014:0049 8B D8           	mov	bx,ax
3014:004B D1 E3           	shl	bx,1h
3014:004D 2E FF A7 52 00  	jmp	word ptr cs:[bx+52h]
;; Code vector at 3014:0052 (10 bytes)
	3014:005C
	3014:0082
	3014:00A7
	3014:00CC
	3014:00F1
3014:0052       5C 00 82 00 A7 00 CC 00 F1 00               \.........    

l3014_005C:
3014:005C B8 8E 67        	mov	ax,678Eh
3014:005F 50              	push	ax
3014:0060 9A 14 05 21 36  	call	far 3621h:0514h
3014:0065 59              	pop	cx
3014:0066 B8 10 11        	mov	ax,1110h
3014:0069 50              	push	ax
3014:006A 9A 35 00 21 36  	call	far 3621h:0035h
3014:006F 59              	pop	cx
3014:0070 B8 8E 67        	mov	ax,678Eh
3014:0073 50              	push	ax
3014:0074 9A 1E 05 21 36  	call	far 3621h:051Eh
3014:0079 59              	pop	cx
3014:007A C6 06 14 80 01  	mov	byte ptr [8014h],1h
3014:007F E9 94 00        	jmp	0116h

l3014_0082:
3014:0082 B8 A6 68        	mov	ax,68A6h
3014:0085 50              	push	ax
3014:0086 9A 14 05 21 36  	call	far 3621h:0514h
3014:008B 59              	pop	cx
3014:008C B8 10 11        	mov	ax,1110h
3014:008F 50              	push	ax
3014:0090 9A 35 00 21 36  	call	far 3621h:0035h
3014:0095 59              	pop	cx
3014:0096 B8 A6 68        	mov	ax,68A6h
3014:0099 50              	push	ax
3014:009A 9A 1E 05 21 36  	call	far 3621h:051Eh
3014:009F 59              	pop	cx
3014:00A0 C6 06 14 80 01  	mov	byte ptr [8014h],1h
3014:00A5 EB 6F           	jmp	0116h

l3014_00A7:
3014:00A7 B8 74 69        	mov	ax,6974h
3014:00AA 50              	push	ax
3014:00AB 9A 14 05 21 36  	call	far 3621h:0514h
3014:00B0 59              	pop	cx
3014:00B1 B8 10 11        	mov	ax,1110h
3014:00B4 50              	push	ax
3014:00B5 9A 35 00 21 36  	call	far 3621h:0035h
3014:00BA 59              	pop	cx
3014:00BB B8 74 69        	mov	ax,6974h
3014:00BE 50              	push	ax
3014:00BF 9A 1E 05 21 36  	call	far 3621h:051Eh
3014:00C4 59              	pop	cx
3014:00C5 C6 06 14 80 01  	mov	byte ptr [8014h],1h
3014:00CA EB 4A           	jmp	0116h

l3014_00CC:
3014:00CC B8 3C 6A        	mov	ax,6A3Ch
3014:00CF 50              	push	ax
3014:00D0 9A 14 05 21 36  	call	far 3621h:0514h
3014:00D5 59              	pop	cx
3014:00D6 B8 10 11        	mov	ax,1110h
3014:00D9 50              	push	ax
3014:00DA 9A 35 00 21 36  	call	far 3621h:0035h
3014:00DF 59              	pop	cx
3014:00E0 B8 3C 6A        	mov	ax,6A3Ch
3014:00E3 50              	push	ax
3014:00E4 9A 1E 05 21 36  	call	far 3621h:051Eh
3014:00E9 59              	pop	cx
3014:00EA C6 06 14 80 01  	mov	byte ptr [8014h],1h
3014:00EF EB 25           	jmp	0116h

l3014_00F1:
3014:00F1 B8 D8 6B        	mov	ax,6BD8h
3014:00F4 50              	push	ax
3014:00F5 9A 14 05 21 36  	call	far 3621h:0514h
3014:00FA 59              	pop	cx
3014:00FB B8 10 11        	mov	ax,1110h
3014:00FE 50              	push	ax
3014:00FF 9A 35 00 21 36  	call	far 3621h:0035h
3014:0104 59              	pop	cx
3014:0105 B8 D8 6B        	mov	ax,6BD8h
3014:0108 50              	push	ax
3014:0109 9A 1E 05 21 36  	call	far 3621h:051Eh
3014:010E 59              	pop	cx
3014:010F C6 06 14 80 02  	mov	byte ptr [8014h],2h
3014:0114 EB 00           	jmp	0116h

l3014_0116:
3014:0116 CB              	retf

;; AllocateMusicStagingBuffer_0117: 3014:0117
;;   Called from:
;;     0D73:033D (in InitializeTacticalScenario_0214)
;;     3014:0038 (in InitializeMusicDriver_0038)
AllocateMusicStagingBuffer_0117 proc
3014:0117 33 D2           	xor	dx,dx
3014:0119 B8 D4 30        	mov	ax,30D4h
3014:011C 52              	push	dx
3014:011D 50              	push	ax
3014:011E 9A B5 00 56 0D  	call	far 0D56h:00B5h
3014:0123 59              	pop	cx
3014:0124 59              	pop	cx
3014:0125 89 16 0C B6     	mov	[0B60Ch],dx
3014:0129 A3 0A B6        	mov	[0B60Ah],ax
3014:012C C7 06 3E 56 FF FF 	mov	word ptr [563Eh],0FFFFh
3014:0132 CB              	retf

;; ReleaseMusicDriverBuffer_0133: 3014:0133
;;   Called from:
;;     0D73:025E (in InitializeTacticalScenario_0214)
;;     3014:014D (in ShutdownMusicDriver_0143)
ReleaseMusicDriverBuffer_0133 proc
3014:0133 FF 36 0C B6     	push	word ptr [0B60Ch]
3014:0137 FF 36 0A B6     	push	word ptr [0B60Ah]
3014:013B 9A 81 01 56 0D  	call	far 0D56h:0181h
3014:0140 59              	pop	cx
3014:0141 59              	pop	cx
3014:0142 CB              	retf

;; ShutdownMusicDriver_0143: 3014:0143
;;   Called from:
;;     2C7F:0307 (in ShutdownGame_02E3)
ShutdownMusicDriver_0143 proc
3014:0143 9A CC 01 21 36  	call	far 3621h:01CCh
3014:0148 9A 42 05 21 36  	call	far 3621h:0542h
3014:014D 0E              	push	cs
3014:014E E8 E2 FF        	call	0133h
3014:0151 CB              	retf
3014:0152       CB                                          .             

;; StartLoadedMusicTrack_0153: 3014:0153
;;   Called from:
;;     3014:0234 (in PlayMusicResource_01F5)
StartLoadedMusicTrack_0153 proc
3014:0153 80 3E AF 85 00  	cmp	byte ptr [85AFh],0h
3014:0158 75 05           	jnz	015Fh

l3014_015A:
3014:015A 9A A6 02 B2 30  	call	far 30B2h:02A6h

l3014_015F:
3014:015F B8 09 00        	mov	ax,9h
3014:0162 50              	push	ax
3014:0163 FF 36 0C B6     	push	word ptr [0B60Ch]
3014:0167 FF 36 0A B6     	push	word ptr [0B60Ah]
3014:016B 9A C1 00 21 36  	call	far 3621h:00C1h
3014:0170 83 C4 06        	add	sp,6h
3014:0173 83 3E 0C 80 00  	cmp	word ptr [800Ch],0h
3014:0178 74 06           	jz	0180h

l3014_017A:
3014:017A 0E              	push	cs
3014:017B E8 9C FE        	call	001Ah
3014:017E EB 04           	jmp	0184h

l3014_0180:
3014:0180 0E              	push	cs
3014:0181 E8 8A FE        	call	000Eh

l3014_0184:
3014:0184 CB              	retf

;; StopLoadedMusicTrack_0185: 3014:0185
;;   Called from:
;;     0D73:0259 (in InitializeTacticalScenario_0214)
;;     2C7F:02F3 (in ShutdownGame_02E3)
;;     3014:0203 (in PlayMusicResource_01F5)
StopLoadedMusicTrack_0185 proc
3014:0185 9A CC 01 21 36  	call	far 3621h:01CCh
3014:018A 80 3E AF 85 00  	cmp	byte ptr [85AFh],0h
3014:018F 75 05           	jnz	0196h

l3014_0191:
3014:0191 9A C1 02 B2 30  	call	far 30B2h:02C1h

l3014_0196:
3014:0196 CB              	retf

;; LoadMusicResource_0197: 3014:0197
;;   Called from:
;;     3014:022F (in PlayMusicResource_01F5)
LoadMusicResource_0197 proc
3014:0197 55              	push	bp
3014:0198 8B EC           	mov	bp,sp
3014:019A 56              	push	si
3014:019B 57              	push	di
3014:019C 8B 76 06        	mov	si,[bp+6h]
3014:019F 83 3E 0C 80 00  	cmp	word ptr [800Ch],0h
3014:01A4 74 4B           	jz	01F1h

l3014_01A6:
3014:01A6 8B C6           	mov	ax,si
3014:01A8 BA 12 00        	mov	dx,12h
3014:01AB F7 E2           	mul	dx
3014:01AD 8B D8           	mov	bx,ax
3014:01AF 81 C3 B0 10     	add	bx,10B0h
3014:01B3 1E              	push	ds
3014:01B4 07              	pop	es
3014:01B5 26 8B 7F 04     	mov	di,es:[bx+4h]
3014:01B9 81 FF D4 30     	cmp	di,30D4h
3014:01BD 7F 32           	jg	01F1h

l3014_01BF:
3014:01BF A1 3E 56        	mov	ax,[563Eh]
3014:01C2 3B C6           	cmp	ax,si
3014:01C4 74 2B           	jz	01F1h

l3014_01C6:
3014:01C6 57              	push	di
3014:01C7 FF 36 0C B6     	push	word ptr [0B60Ch]
3014:01CB FF 36 0A B6     	push	word ptr [0B60Ah]
3014:01CF 8B C6           	mov	ax,si
3014:01D1 BA 12 00        	mov	dx,12h
3014:01D4 F7 E2           	mul	dx
3014:01D6 8B D8           	mov	bx,ax
3014:01D8 81 C3 B0 10     	add	bx,10B0h
3014:01DC 1E              	push	ds
3014:01DD 07              	pop	es
3014:01DE 26 FF 77 02     	push	word ptr es:[bx+2h]
3014:01E2 26 FF 37        	push	word ptr es:[bx]
3014:01E5 9A 0C 00 E7 21  	call	far 21E7h:000Ch
3014:01EA 83 C4 0A        	add	sp,0Ah
3014:01ED 89 36 3E 56     	mov	[563Eh],si

l3014_01F1:
3014:01F1 5F              	pop	di
3014:01F2 5E              	pop	si
3014:01F3 5D              	pop	bp
3014:01F4 CB              	retf

;; PlayMusicResource_01F5: 3014:01F5
;;   Called from:
;;     0D73:30FA (in RunTitleAndMainMenu_309C)
PlayMusicResource_01F5 proc
3014:01F5 55              	push	bp
3014:01F6 8B EC           	mov	bp,sp
3014:01F8 56              	push	si
3014:01F9 8B 76 06        	mov	si,[bp+6h]
3014:01FC 80 3E 64 A8 00  	cmp	byte ptr [0A864h],0h
3014:0201 75 35           	jnz	0238h

l3014_0203:
3014:0203 0E              	push	cs
3014:0204 E8 7E FF        	call	0185h
3014:0207 80 3E AF 85 00  	cmp	byte ptr [85AFh],0h
3014:020C 74 0E           	jz	021Ch

l3014_020E:
3014:020E 80 3E AF 85 01  	cmp	byte ptr [85AFh],1h
3014:0213 74 07           	jz	021Ch

l3014_0215:
3014:0215 80 3E AF 85 02  	cmp	byte ptr [85AFh],2h
3014:021A 75 12           	jnz	022Eh

l3014_021C:
3014:021C 83 FE 49        	cmp	si,49h
3014:021F 75 05           	jnz	0226h

l3014_0221:
3014:0221 BE 48 00        	mov	si,48h
3014:0224 EB 08           	jmp	022Eh

l3014_0226:
3014:0226 83 FE 4B        	cmp	si,4Bh
3014:0229 75 03           	jnz	022Eh

l3014_022B:
3014:022B BE 4C 00        	mov	si,4Ch

l3014_022E:
3014:022E 56              	push	si
3014:022F 0E              	push	cs
