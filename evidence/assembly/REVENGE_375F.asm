;;; Segment 375F (375F:0000)
375F:0000 04 00 F7 D8 FB CB                               ......          

;; InvokeDigitalHardwareProbe_0006: 375F:0006
;;   Called from:
;;     31FB:0031 (in InitializeDigitalSoundDriver_0005)
InvokeDigitalHardwareProbe_0006 proc
375F:0006 8B DC           	mov	bx,sp
375F:0008 36 8B 5F 04     	mov	bx,ss:[bx+4h]

l375F_000C:
375F:000C 8B 57 02        	mov	dx,[bx+2h]
375F:000F FF 57 08        	call	word ptr [bx+8h]
375F:0012 CB              	retf

;; ProbeDigitalHardwareCandidateList_0013: 375F:0013
ProbeDigitalHardwareCandidateList_0013 proc
375F:0013 8B DC           	mov	bx,sp
375F:0015 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:0019 8B 4F 04        	mov	cx,[bx+4h]
375F:001C E3 EE           	jcxz	000Ch

l375F_001E:
375F:001E 56              	push	si
375F:001F 8B 77 06        	mov	si,[bx+6h]

l375F_0022:
375F:0022 51              	push	cx
375F:0023 8B 14           	mov	dx,[si]
375F:0025 FF 57 08        	call	word ptr [bx+8h]
375F:0028 59              	pop	cx
375F:0029 0B C0           	or	ax,ax
375F:002B 74 07           	jz	0034h

l375F_002D:
375F:002D 79 05           	jns	0034h

l375F_002F:
375F:002F 83 C6 02        	add	si,2h
375F:0032 E2 EE           	loop	0022h

l375F_0034:
375F:0034 5E              	pop	si
375F:0035 CB              	retf

;; ProbeDigitalHardwareWithParameter_0036: 375F:0036
ProbeDigitalHardwareWithParameter_0036 proc
375F:0036 8B DC           	mov	bx,sp
375F:0038 36 8B 57 06     	mov	dx,ss:[bx+6h]
375F:003C 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:0040 FF 57 08        	call	word ptr [bx+8h]
375F:0043 CB              	retf

;; AcquireDigitalHardware_0044: 375F:0044
;;   Called from:
;;     31FB:003F (in InitializeDigitalSoundDriver_0005)
AcquireDigitalHardware_0044 proc
375F:0044 8B DC           	mov	bx,sp
375F:0046 36 8B 57 06     	mov	dx,ss:[bx+6h]
375F:004A 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:004E FF 47 0E        	inc	word ptr [bx+0Eh]
375F:0051 83 7F 0E 01     	cmp	word ptr [bx+0Eh],1h
375F:0055 75 03           	jnz	005Ah

l375F_0057:
375F:0057 FF 57 0A        	call	word ptr [bx+0Ah]

l375F_005A:
375F:005A CB              	retf

;; ReleaseDigitalHardware_005B: 375F:005B
ReleaseDigitalHardware_005B proc
375F:005B 8B DC           	mov	bx,sp
375F:005D 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:0061 83 7F 0E 00     	cmp	word ptr [bx+0Eh],0h
375F:0065 74 08           	jz	006Fh

l375F_0067:
375F:0067 FF 4F 0E        	dec	word ptr [bx+0Eh]
375F:006A 75 03           	jnz	006Fh

l375F_006C:
375F:006C FF 57 0C        	call	word ptr [bx+0Ch]

l375F_006F:
375F:006F CB              	retf

;; ProbeNullSoundHardware_0070: 375F:0070
ProbeNullSoundHardware_0070 proc
375F:0070 B8 01 00        	mov	ax,1h
375F:0073 C3              	ret

;; AcquireNullSoundHardware_0074: 375F:0074
AcquireNullSoundHardware_0074 proc
375F:0074 C3              	ret

;; ReleaseNullSoundHardware_0075: 375F:0075
ReleaseNullSoundHardware_0075 proc
375F:0075 C3              	ret

;; ProbeTandy3VoiceHardware_0076: 375F:0076
ProbeTandy3VoiceHardware_0076 proc
375F:0076 B8 00 F0        	mov	ax,0F000h
375F:0079 8E C0           	mov	es,ax
375F:007B BB FE FF        	mov	bx,0FFFEh
375F:007E 26 80 3F FF     	cmp	byte ptr es:[bx],0FFh
375F:0082 75 0D           	jnz	0091h

l375F_0084:
375F:0084 BB 00 C0        	mov	bx,0C000h
375F:0087 26 80 3F 21     	cmp	byte ptr es:[bx],21h
375F:008B 75 04           	jnz	0091h

l375F_008D:
375F:008D B8 01 00        	mov	ax,1h
375F:0090 C3              	ret

l375F_0091:
375F:0091 B8 FF FF        	mov	ax,0FFFFh
375F:0094 C3              	ret

;; AcquireTandy3VoiceHardware_0095: 375F:0095
AcquireTandy3VoiceHardware_0095 proc
375F:0095 C3              	ret

;; ReleaseTandy3VoiceHardware_0096: 375F:0096
ReleaseTandy3VoiceHardware_0096 proc
375F:0096 C3              	ret
375F:0097                      00                                .        

;; ProbeTandyDACHardware_0098: 375F:0098
ProbeTandyDACHardware_0098 proc
375F:0098 B8 00 F0        	mov	ax,0F000h
375F:009B 8E C0           	mov	es,ax
375F:009D BB FE FF        	mov	bx,0FFFEh
375F:00A0 26 80 3F FF     	cmp	byte ptr es:[bx],0FFh
375F:00A4 75 20           	jnz	00C6h

l375F_00A6:
375F:00A6 BB 00 C0        	mov	bx,0C000h
375F:00A9 26 80 3F 21     	cmp	byte ptr es:[bx],21h
375F:00AD 75 17           	jnz	00C6h

l375F_00AF:
375F:00AF B4 C0           	mov	ah,0C0h
375F:00B1 CD 15           	int	15h
375F:00B3 72 11           	jc	00C6h

l375F_00B5:
375F:00B5 26 83 3F 03     	cmp	word ptr es:[bx],3h
375F:00B9 75 0B           	jnz	00C6h

l375F_00BB:
375F:00BB 26 80 7F 02 FF  	cmp	byte ptr es:[bx+2h],0FFh
375F:00C0 75 04           	jnz	00C6h

l375F_00C2:
375F:00C2 B8 01 00        	mov	ax,1h
375F:00C5 C3              	ret

l375F_00C6:
375F:00C6 B8 FF FF        	mov	ax,0FFFFh
375F:00C9 C3              	ret

;; AcquireTandyDACHardware_00CA: 375F:00CA
AcquireTandyDACHardware_00CA proc
375F:00CA C3              	ret

;; ReleaseTandyDACHardware_00CB: 375F:00CB
ReleaseTandyDACHardware_00CB proc
375F:00CB C3              	ret

;; ProbeIBMPS1AudioHardware_00CC: 375F:00CC
ProbeIBMPS1AudioHardware_00CC proc
375F:00CC 06              	push	es
375F:00CD 53              	push	bx
375F:00CE B4 C0           	mov	ah,0C0h
375F:00D0 CD 15           	int	15h
375F:00D2 26 8B 47 02     	mov	ax,es:[bx+2h]
375F:00D6 5B              	pop	bx
375F:00D7 07              	pop	es
375F:00D8 3D FC 0B        	cmp	ax,0BFCh
375F:00DB 75 12           	jnz	00EFh

l375F_00DD:
375F:00DD B0 2F           	mov	al,2Fh
375F:00DF FA              	cli
375F:00E0 E6 70           	out	70h,al
375F:00E2 EB 00           	jmp	00E4h

l375F_00E4:
375F:00E4 E4 71           	in	al,71h
375F:00E6 FB              	sti
375F:00E7 A8 10           	test	al,10h
375F:00E9 74 04           	jz	00EFh

l375F_00EB:
375F:00EB B8 01 00        	mov	ax,1h
375F:00EE C3              	ret

l375F_00EF:
375F:00EF B8 FF FF        	mov	ax,0FFFFh
375F:00F2 C3              	ret

;; AcquireIBMPS1AudioHardware_00F3: 375F:00F3
AcquireIBMPS1AudioHardware_00F3 proc
375F:00F3 C3              	ret

;; ReleaseIBMPS1AudioHardware_00F4: 375F:00F4
ReleaseIBMPS1AudioHardware_00F4 proc
375F:00F4 C3              	ret
375F:00F5                00                                    .          
l375F_00F6	dw	0x0000

;; WriteSoundBlasterDSP_00F8: 375F:00F8
;;   Called from:
;;     375F:0151 (in ReleaseSoundBlasterHardware_014F)
;;     375F:0332 (in WriteSoundBlasterDigitalSample_032E)
WriteSoundBlasterDSP_00F8 proc
375F:00F8 2E 8B 16 F6 00  	mov	dx,cs:[00F6h]
375F:00FD 83 C2 0C        	add	dx,0Ch

;; WriteSoundBlasterDSPPort_0100: 375F:0100
;;   Called from:
;;     375F:00FD (in WriteSoundBlasterDSPPort_0100)
;;     375F:014D (in AcquireSoundBlasterHardware_0143)
;;     375F:0337 (in WriteSoundBlasterDigitalSample_032E)
WriteSoundBlasterDSPPort_0100 proc
375F:0100 EC              	in	al,dx
375F:0101 D0 E0           	shl	al,1h
375F:0103 72 FB           	jc	0100h

l375F_0105:
375F:0105 8A C4           	mov	al,ah
375F:0107 EE              	out	dx,al
375F:0108 C3              	ret

;; ReadSoundBlasterDSP_0109: 375F:0109
ReadSoundBlasterDSP_0109 proc
375F:0109 2E 8B 16 F6 00  	mov	dx,cs:[00F6h]
375F:010E 83 C2 0E        	add	dx,0Eh

l375F_0111:
375F:0111 EC              	in	al,dx
375F:0112 D0 E0           	shl	al,1h
375F:0114 73 FB           	jnc	0111h

l375F_0116:
375F:0116 83 EA 04        	sub	dx,4h
375F:0119 EC              	in	al,dx
375F:011A C3              	ret

;; ProbeSoundBlasterHardware_011B: 375F:011B
ProbeSoundBlasterHardware_011B proc
375F:011B 83 C2 06        	add	dx,6h
375F:011E B8 01 00        	mov	ax,1h
375F:0121 EE              	out	dx,al
375F:0122 86 C4           	xchg	ah,al
375F:0124 8B C8           	mov	cx,ax

l375F_0126:
375F:0126 E2 FE           	loop	0126h

l375F_0128:
375F:0128 EE              	out	dx,al
375F:0129 83 C2 08        	add	dx,8h

l375F_012C:
375F:012C EC              	in	al,dx
375F:012D D0 E0           	shl	al,1h
375F:012F 73 FB           	jnc	012Ch

l375F_0131:
375F:0131 83 EA 04        	sub	dx,4h
375F:0134 EC              	in	al,dx
375F:0135 83 EA 0A        	sub	dx,0Ah
375F:0138 3C AA           	cmp	al,0AAh
375F:013A 74 04           	jz	0140h

l375F_013C:
375F:013C B8 FF FF        	mov	ax,0FFFFh
375F:013F C3              	ret

l375F_0140:
375F:0140 8B C2           	mov	ax,dx
375F:0142 C3              	ret

;; AcquireSoundBlasterHardware_0143: 375F:0143
AcquireSoundBlasterHardware_0143 proc
375F:0143 2E 89 16 F6 00  	mov	cs:[00F6h],dx
375F:0148 83 C2 0C        	add	dx,0Ch
375F:014B B4 D1           	mov	ah,0D1h
375F:014D EB B1           	jmp	0100h

;; ReleaseSoundBlasterHardware_014F: 375F:014F
ReleaseSoundBlasterHardware_014F proc
375F:014F B4 D3           	mov	ah,0D3h
375F:0151 EB A5           	jmp	00F8h
375F:0153          00                                        .            
l375F_0154	dw	0x000A
l375F_0156	dw	0x0050

;; WriteAdLibRegister_0158: 375F:0158
;;   Called from:
;;     375F:0193 (in ProbeAdLibSoundHardware_0190)
;;     375F:01EC (in AcquireAdLibSoundHardware_01E9)
;;     375F:0369 (in ReleaseAdLibDigitalOutput_0366)
WriteAdLibRegister_0158 proc
375F:0158 BA 88 03        	mov	dx,388h

;; WriteAdLibRegisterAtPort_015B: 375F:015B
;;   Called from:
;;     375F:0158 (in WriteAdLibRegister_0158)
;;     375F:0183 (in LoadAdLibRegisterList_017E)
;;     375F:0199 (in ProbeAdLibSoundHardware_0190)
;;     375F:01A4 (in ProbeAdLibSoundHardware_0190)
;;     375F:01F2 (in AcquireAdLibSoundHardware_01E9)
;;     375F:0345 (in InitializeAdLibDigitalOutput_033A)
;;     375F:034B (in InitializeAdLibDigitalOutput_033A)
;;     375F:0358 (in InitializeAdLibDigitalOutput_033A)
;;     375F:035E (in InitializeAdLibDigitalOutput_033A)
WriteAdLibRegisterAtPort_015B proc
375F:015B 50              	push	ax
375F:015C 51              	push	cx
375F:015D EE              	out	dx,al
375F:015E 2E 8B 0E 54 01  	mov	cx,cs:[0154h]

;; WriteAdLibDataAtPort_0163: 375F:0163
;;   Called from:
;;     375F:015E (in WriteAdLibRegisterAtPort_015B)
WriteAdLibDataAtPort_0163 proc
375F:0163 EC              	in	al,dx
375F:0164 24 00           	and	al,0h
375F:0166 3C FF           	cmp	al,0FFh
375F:0168 E0 F9           	loopne	0163h

l375F_016A:
375F:016A 8A C4           	mov	al,ah
375F:016C 42              	inc	dx
375F:016D EE              	out	dx,al
375F:016E 4A              	dec	dx
375F:016F 2E 8B 0E 56 01  	mov	cx,cs:[0156h]

l375F_0174:
375F:0174 EC              	in	al,dx
375F:0175 24 00           	and	al,0h
375F:0177 3C FF           	cmp	al,0FFh
375F:0179 E0 F9           	loopne	0174h

l375F_017B:
375F:017B 59              	pop	cx
375F:017C 58              	pop	ax
375F:017D C3              	ret

;; LoadAdLibRegisterList_017E: 375F:017E
;;   Called from:
;;     375F:033F (in InitializeAdLibDigitalOutput_033A)
LoadAdLibRegisterList_017E proc
375F:017E BA 88 03        	mov	dx,388h
375F:0181 EB 06           	jmp	0189h

l375F_0183:
375F:0183 E8 D5 FF        	call	015Bh
375F:0186 83 C3 02        	add	bx,2h

l375F_0189:
375F:0189 8B 07           	mov	ax,[bx]
375F:018B 0B C0           	or	ax,ax
375F:018D 75 F4           	jnz	0183h

l375F_018F:
375F:018F C3              	ret

;; ProbeAdLibSoundHardware_0190: 375F:0190
ProbeAdLibSoundHardware_0190 proc
375F:0190 B8 04 60        	mov	ax,6004h
375F:0193 E8 C2 FF        	call	0158h
375F:0196 B8 04 80        	mov	ax,8004h
375F:0199 E8 BF FF        	call	015Bh
375F:019C EC              	in	al,dx
375F:019D 24 E0           	and	al,0E0h
375F:019F 75 44           	jnz	01E5h

l375F_01A1:
375F:01A1 B8 02 C0        	mov	ax,0C002h
375F:01A4 E8 B4 FF        	call	015Bh
375F:01A7 B8 04 21        	mov	ax,2104h
375F:01AA EE              	out	dx,al
375F:01AB B9 14 00        	mov	cx,14h

l375F_01AE:
375F:01AE EC              	in	al,dx
375F:01AF E2 FD           	loop	01AEh

l375F_01B1:
375F:01B1 8A C4           	mov	al,ah
375F:01B3 42              	inc	dx
375F:01B4 FA              	cli
375F:01B5 EE              	out	dx,al
375F:01B6 4A              	dec	dx
375F:01B7 33 C9           	xor	cx,cx

l375F_01B9:
375F:01B9 EC              	in	al,dx
375F:01BA 24 E0           	and	al,0E0h
375F:01BC 3C C0           	cmp	al,0C0h
375F:01BE E0 F9           	loopne	01B9h

l375F_01C0:
375F:01C0 FB              	sti
375F:01C1 75 22           	jnz	01E5h

l375F_01C3:
375F:01C3 F7 D9           	neg	cx
375F:01C5 8B C1           	mov	ax,cx
375F:01C7 33 D2           	xor	dx,dx
375F:01C9 BB E4 00        	mov	bx,0E4h
375F:01CC F7 F3           	div	bx
375F:01CE 40              	inc	ax
375F:01CF 2E A3 56 01     	mov	cs:[0156h],ax
375F:01D3 8B C1           	mov	ax,cx
375F:01D5 33 D2           	xor	dx,dx
375F:01D7 BB 0F 06        	mov	bx,60Fh
375F:01DA F7 F3           	div	bx
375F:01DC 40              	inc	ax
375F:01DD 2E A3 54 01     	mov	cs:[0154h],ax
375F:01E1 B8 01 00        	mov	ax,1h
375F:01E4 C3              	ret

l375F_01E5:
375F:01E5 B8 FF FF        	mov	ax,0FFFFh
375F:01E8 C3              	ret

;; AcquireAdLibSoundHardware_01E9: 375F:01E9
AcquireAdLibSoundHardware_01E9 proc
375F:01E9 B8 01 20        	mov	ax,2001h
375F:01EC E8 69 FF        	call	0158h
375F:01EF B8 08 00        	mov	ax,8h
375F:01F2 E9 66 FF        	jmp	015Bh

;; ReleaseAdLibSoundHardware_01F5: 375F:01F5
ReleaseAdLibSoundHardware_01F5 proc
375F:01F5 C3              	ret
l375F_01F6	dw	0x0000
l375F_01F8	dw	0x0000
l375F_01FA	dw	0x0000
l375F_01FC	dw	0x0000
375F:01FE                                           2E 8B               ..
375F:0200 16 F8 01 EB 05 2E 8B 16 FC 01 EE 86 C4 4A EE 86 .............J..
375F:0210 C4 C3                                           ..              

;; WriteCMSBothChips_0212: 375F:0212
;;   Called from:
;;     375F:0244 (in AcquireCMSHardware_0228)
;;     375F:024D (in AcquireCMSHardware_0228)
;;     375F:0253 (in AcquireCMSHardware_0228)
;;     375F:0259 (in AcquireCMSHardware_0228)
;;     375F:025E (in AcquireCMSHardware_0228)
;;     375F:0263 (in ReleaseCMSHardware_0260)
;;     375F:0379 (in InitializeCMSDigitalOutput_0376)
;;     375F:037F (in InitializeCMSDigitalOutput_0376)
;;     375F:0384 (in InitializeCMSDigitalOutput_0376)
;;     375F:0389 (in ReleaseCMSDigitalOutput_0387)
WriteCMSBothChips_0212 proc
375F:0212 2E 8B 16 FC 01  	mov	dx,cs:[01FCh]
375F:0217 EE              	out	dx,al
375F:0218 4A              	dec	dx
375F:0219 4A              	dec	dx
375F:021A EE              	out	dx,al
375F:021B 86 C4           	xchg	ah,al
375F:021D 42              	inc	dx
375F:021E EE              	out	dx,al
375F:021F 4A              	dec	dx
375F:0220 4A              	dec	dx
375F:0221 EE              	out	dx,al
375F:0222 86 C4           	xchg	ah,al
375F:0224 C3              	ret

;; ProbeCMSHardware_0225: 375F:0225
ProbeCMSHardware_0225 proc
375F:0225 33 C0           	xor	ax,ax
375F:0227 C3              	ret

;; AcquireCMSHardware_0228: 375F:0228
AcquireCMSHardware_0228 proc
375F:0228 2E 89 16 F6 01  	mov	cs:[01F6h],dx
375F:022D 42              	inc	dx
375F:022E 2E 89 16 F8 01  	mov	cs:[01F8h],dx
375F:0233 42              	inc	dx
375F:0234 2E 89 16 FA 01  	mov	cs:[01FAh],dx
375F:0239 42              	inc	dx
375F:023A 2E 89 16 FC 01  	mov	cs:[01FCh],dx
375F:023F 33 C0           	xor	ax,ax
375F:0241 B9 20 00        	mov	cx,20h

l375F_0244:
375F:0244 E8 CB FF        	call	0212h
375F:0247 40              	inc	ax
375F:0248 E2 FA           	loop	0244h

l375F_024A:
375F:024A B8 1C 02        	mov	ax,21Ch
375F:024D E8 C2 FF        	call	0212h
375F:0250 B8 1C 01        	mov	ax,11Ch
375F:0253 E8 BC FF        	call	0212h
375F:0256 B8 14 3F        	mov	ax,3F14h
375F:0259 E8 B6 FF        	call	0212h
375F:025C 33 C0           	xor	ax,ax
375F:025E EB B2           	jmp	0212h

;; ReleaseCMSHardware_0260: 375F:0260
ReleaseCMSHardware_0260 proc
375F:0260 B8 1C 00        	mov	ax,1Ch
375F:0263 EB AD           	jmp	0212h
375F:0265                00 00 00                              ...        
l375F_0268	dw	0x0000

;; ProbeInnovationHardware_026A: 375F:026A
ProbeInnovationHardware_026A proc
375F:026A 33 C0           	xor	ax,ax
375F:026C C3              	ret

;; AcquireInnovationHardware_026D: 375F:026D
AcquireInnovationHardware_026D proc
375F:026D 2E 89 16 66 02  	mov	cs:[0266h],dx
375F:0272 32 C0           	xor	al,al
375F:0274 B9 19 00        	mov	cx,19h

l375F_0277:
375F:0277 EE              	out	dx,al
375F:0278 42              	inc	dx
375F:0279 E2 FC           	loop	0277h

l375F_027B:
375F:027B 4A              	dec	dx
375F:027C 2E 89 16 68 02  	mov	cs:[0268h],dx
375F:0281 C3              	ret

;; ReleaseInnovationHardware_0282: 375F:0282
ReleaseInnovationHardware_0282 proc
375F:0282 2E 8B 16 68 02  	mov	dx,cs:[0268h]
375F:0287 32 C0           	xor	al,al
375F:0289 EE              	out	dx,al
375F:028A C3              	ret
375F:028B                                  00                        .    
l375F_028C	dw	0x0000
l375F_028E	dw	0x0000

;; WriteCovoxControl_0290: 375F:0290
;;   Called from:
;;     375F:02BE (in AcquireCovoxHardware_02AE)
;;     375F:04B1 (in InitializeCovoxDigitalOutput_04AE)
WriteCovoxControl_0290 proc
375F:0290 2E 8B 16 8C 02  	mov	dx,cs:[028Ch]
375F:0295 EE              	out	dx,al
375F:0296 42              	inc	dx

l375F_0297:
375F:0297 8A C4           	mov	al,ah
375F:0299 EE              	out	dx,al
375F:029A EC              	in	al,dx
375F:029B 3A C4           	cmp	al,ah
375F:029D 75 F8           	jnz	0297h

l375F_029F:
375F:029F C3              	ret
375F:02A0 2E 8B 16 8C 02 EE 42 8A C4 EC C3                ......B....     

;; ProbeCovoxHardware_02AB: 375F:02AB
ProbeCovoxHardware_02AB proc
375F:02AB 33 C0           	xor	ax,ax
375F:02AD C3              	ret

;; AcquireCovoxHardware_02AE: 375F:02AE
AcquireCovoxHardware_02AE proc
375F:02AE 2E 89 16 8C 02  	mov	cs:[028Ch],dx
375F:02B3 83 C2 02        	add	dx,2h
375F:02B6 2E 89 16 8E 02  	mov	cs:[028Eh],dx
375F:02BB B8 0E FF        	mov	ax,0FF0Eh
375F:02BE EB D0           	jmp	0290h

;; ReleaseCovoxHardware_02C0: 375F:02C0
ReleaseCovoxHardware_02C0 proc
375F:02C0 C3              	ret
375F:02C1    00                                            .              

;; AcquireDigitalPlaybackDriver_02C2: 375F:02C2
;;   Called from:
;;     31FB:05CE (in PlayDigitalWeaponEffect_058D)
;;     31FB:1111 (in PlayScenarioDigitalSoundSequence_0742)
AcquireDigitalPlaybackDriver_02C2 proc
375F:02C2 8B DC           	mov	bx,sp
375F:02C4 36 8B 47 06     	mov	ax,ss:[bx+6h]
375F:02C8 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:02CC FF 47 0A        	inc	word ptr [bx+0Ah]
375F:02CF 83 7F 0A 01     	cmp	word ptr [bx+0Ah],1h
375F:02D3 75 03           	jnz	02D8h

l375F_02D5:
375F:02D5 FF 57 02        	call	word ptr [bx+2h]

l375F_02D8:
375F:02D8 CB              	retf

;; ReleaseDigitalPlaybackDriver_02D9: 375F:02D9
;;   Called from:
;;     31FB:072B (in HandleDigitalWeaponEffectCompletion_06E9)
;;     31FB:128C (in PlayScenarioDigitalSoundSequence_0742)
ReleaseDigitalPlaybackDriver_02D9 proc
375F:02D9 8B DC           	mov	bx,sp
375F:02DB 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:02DF 83 7F 0A 00     	cmp	word ptr [bx+0Ah],0h
375F:02E3 74 08           	jz	02EDh

l375F_02E5:
375F:02E5 FF 4F 0A        	dec	word ptr [bx+0Ah]
375F:02E8 75 03           	jnz	02EDh

l375F_02EA:
375F:02EA FF 57 04        	call	word ptr [bx+4h]

l375F_02ED:
375F:02ED CB              	retf

;; InitializeNullDigitalOutput_02EE: 375F:02EE
InitializeNullDigitalOutput_02EE proc
375F:02EE C3              	ret

;; ReleaseNullDigitalOutput_02EF: 375F:02EF
ReleaseNullDigitalOutput_02EF proc
375F:02EF C3              	ret

;; WriteNullDigitalSample_02F0: 375F:02F0
WriteNullDigitalSample_02F0 proc
375F:02F0 C3              	ret
375F:02F1    00                                            .              

;; InitializeTandy3VoiceDigitalOutput_02F2: 375F:02F2
InitializeTandy3VoiceDigitalOutput_02F2 proc
375F:02F2 B0 87           	mov	al,87h
375F:02F4 E6 C0           	out	0C0h,al
375F:02F6 32 C0           	xor	al,al
375F:02F8 E6 C1           	out	0C1h,al
375F:02FA C3              	ret

;; ReleaseTandy3VoiceDigitalOutput_02FB: 375F:02FB
ReleaseTandy3VoiceDigitalOutput_02FB proc
375F:02FB C3              	ret

;; WriteTandy3VoiceDigitalSample_02FC: 375F:02FC
WriteTandy3VoiceDigitalSample_02FC proc
375F:02FC D0 E8           	shr	al,1h
375F:02FE D0 E8           	shr	al,1h
375F:0300 D0 E8           	shr	al,1h
375F:0302 D0 E8           	shr	al,1h
375F:0304 3C 0F           	cmp	al,0Fh
375F:0306 14 8F           	adc	al,8Fh
375F:0308 E6 C0           	out	0C0h,al
375F:030A C3              	ret
375F:030B                                  00                        .    

;; InitializeTandyDACDigitalOutput_030C: 375F:030C
InitializeTandyDACDigitalOutput_030C proc
375F:030C E4 C4           	in	al,0C4h
375F:030E 24 E0           	and	al,0E0h
375F:0310 0C 03           	or	al,3h
375F:0312 E6 C4           	out	0C4h,al
375F:0314 B0 E0           	mov	al,0E0h
375F:0316 E6 C7           	out	0C7h,al
375F:0318 C3              	ret

;; ReleaseTandyDACDigitalOutput_0319: 375F:0319
ReleaseTandyDACDigitalOutput_0319 proc
375F:0319 C3              	ret

;; WriteTandyDACDigitalSample_031A: 375F:031A
WriteTandyDACDigitalSample_031A proc
375F:031A E6 C5           	out	0C5h,al
375F:031C C3              	ret
375F:031D                                        00                    .  

;; InitializeIBMPS1DigitalOutput_031E: 375F:031E
InitializeIBMPS1DigitalOutput_031E proc
375F:031E BA 03 02        	mov	dx,203h
375F:0321 B0 01           	mov	al,1h
375F:0323 EE              	out	dx,al
375F:0324 C3              	ret

;; ReleaseIBMPS1DigitalOutput_0325: 375F:0325
ReleaseIBMPS1DigitalOutput_0325 proc
375F:0325 C3              	ret

;; WriteIBMPS1DigitalSample_0326: 375F:0326
WriteIBMPS1DigitalSample_0326 proc
375F:0326 BA 00 02        	mov	dx,200h
375F:0329 EE              	out	dx,al
375F:032A C3              	ret
375F:032B                                  00                        .    

;; InitializeSoundBlasterDigitalOutput_032C: 375F:032C
InitializeSoundBlasterDigitalOutput_032C proc
375F:032C C3              	ret

;; ReleaseSoundBlasterDigitalOutput_032D: 375F:032D
ReleaseSoundBlasterDigitalOutput_032D proc
375F:032D C3              	ret

;; WriteSoundBlasterDigitalSample_032E: 375F:032E
WriteSoundBlasterDigitalSample_032E proc
375F:032E 8A D8           	mov	bl,al
375F:0330 B4 10           	mov	ah,10h
375F:0332 E8 C3 FD        	call	00F8h
375F:0335 8A E3           	mov	ah,bl
375F:0337 E9 C6 FD        	jmp	0100h

;; InitializeAdLibDigitalOutput_033A: 375F:033A
InitializeAdLibDigitalOutput_033A proc
375F:033A 9C              	pushf
375F:033B FA              	cli
375F:033C BB FA 6E        	mov	bx,6EFAh
375F:033F E8 3C FE        	call	017Eh
375F:0342 B8 04 21        	mov	ax,2104h
375F:0345 E8 13 FE        	call	015Bh
375F:0348 B8 B0 23        	mov	ax,23B0h
375F:034B E8 0D FE        	call	015Bh

l375F_034E:
375F:034E EC              	in	al,dx
375F:034F 24 E0           	and	al,0E0h
375F:0351 3C C0           	cmp	al,0C0h
375F:0353 75 F9           	jnz	034Eh

l375F_0355:
375F:0355 B8 B0 20        	mov	ax,20B0h
375F:0358 E8 00 FE        	call	015Bh
375F:035B B8 A0 00        	mov	ax,0A0h
375F:035E E8 FA FD        	call	015Bh
375F:0361 9D              	popf
375F:0362 B0 40           	mov	al,40h
375F:0364 EE              	out	dx,al
375F:0365 C3              	ret

;; ReleaseAdLibDigitalOutput_0366: 375F:0366
ReleaseAdLibDigitalOutput_0366 proc
375F:0366 B8 B0 00        	mov	ax,0B0h
375F:0369 E9 EC FD        	jmp	0158h

;; WriteAdLibDigitalSample_036C: 375F:036C
WriteAdLibDigitalSample_036C proc
375F:036C D0 E8           	shr	al,1h
375F:036E D0 E8           	shr	al,1h
375F:0370 BA 89 03        	mov	dx,389h
375F:0373 EE              	out	dx,al
375F:0374 C3              	ret
375F:0375                00                                    .          

;; InitializeCMSDigitalOutput_0376: 375F:0376
InitializeCMSDigitalOutput_0376 proc
375F:0376 B8 08 FF        	mov	ax,0FF08h
375F:0379 E8 96 FE        	call	0212h
375F:037C B8 10 07        	mov	ax,710h
375F:037F E8 90 FE        	call	0212h
375F:0382 33 C0           	xor	ax,ax
375F:0384 E9 8B FE        	jmp	0212h

;; ReleaseCMSDigitalOutput_0387: 375F:0387
ReleaseCMSDigitalOutput_0387 proc
375F:0387 33 C0           	xor	ax,ax
375F:0389 E9 86 FE        	jmp	0212h

;; WriteCMSDigitalSample_038C: 375F:038C
WriteCMSDigitalSample_038C proc
375F:038C BB 9B 03        	mov	bx,39Bh
375F:038F 2E D7           	xlat
375F:0391 2E 8B 16 F6 01  	mov	dx,cs:[01F6h]
375F:0396 EE              	out	dx,al
375F:0397 42              	inc	dx
375F:0398 42              	inc	dx
375F:0399 EE              	out	dx,al
375F:039A C3              	ret
l375F_039B	db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x00
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x11
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x22
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x33
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x44
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x55
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x66
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x77
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x88
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0x99
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xAA
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xBB
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xCC
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xDD
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xEE
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
db	0xFF
375F:049B                                  00                        .    

;; InitializeInnovationDigitalOutput_049C: 375F:049C
InitializeInnovationDigitalOutput_049C proc
375F:049C C3              	ret

;; ReleaseInnovationDigitalOutput_049D: 375F:049D
ReleaseInnovationDigitalOutput_049D proc
375F:049D C3              	ret

;; WriteInnovationDigitalSample_049E: 375F:049E
WriteInnovationDigitalSample_049E proc
375F:049E 2E 8B 16 68 02  	mov	dx,cs:[0268h]
375F:04A3 D0 E8           	shr	al,1h
375F:04A5 D0 E8           	shr	al,1h
375F:04A7 D0 E8           	shr	al,1h
375F:04A9 D0 E8           	shr	al,1h
375F:04AB EE              	out	dx,al
375F:04AC C3              	ret
375F:04AD                                        00                    .  

;; InitializeCovoxDigitalOutput_04AE: 375F:04AE
InitializeCovoxDigitalOutput_04AE proc
375F:04AE B8 0F FF        	mov	ax,0FF0Fh
375F:04B1 E9 DC FD        	jmp	0290h

;; ReleaseCovoxDigitalOutput_04B4: 375F:04B4
ReleaseCovoxDigitalOutput_04B4 proc
375F:04B4 C3              	ret

;; WriteCovoxDigitalSample_04B5: 375F:04B5
WriteCovoxDigitalSample_04B5 proc
375F:04B5 2E 8B 16 8E 02  	mov	dx,cs:[028Eh]
375F:04BA EE              	out	dx,al
375F:04BB C3              	ret
375F:04BC                                     00 00 00 00             ....
375F:04C0 00 00 00 00 FF FF 00 00 00 00                   ..........      
l375F_04CA	dw	0x0000
375F:04CC                                     00 00 00 00             ....
375F:04D0 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
375F:04E0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...
375F:05D0 00 00 00 00 00 00                               ......          

;; CalibrateDigitalPlaybackRate_05D6: 375F:05D6
;;   Called from:
;;     31FB:005B (in InitializeDigitalSoundDriver_0005)
CalibrateDigitalPlaybackRate_05D6 proc
375F:05D6 8B DC           	mov	bx,sp
375F:05D8 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:05DC 9C              	pushf
375F:05DD FA              	cli
375F:05DE 1E              	push	ds
375F:05DF 57              	push	di
375F:05E0 56              	push	si
375F:05E1 55              	push	bp
375F:05E2 53              	push	bx
375F:05E3 8C CF           	mov	di,cs
375F:05E5 8E C7           	mov	es,di
375F:05E7 33 FF           	xor	di,di
375F:05E9 BE 70 6F        	mov	si,6F70h
375F:05EC B8 0D 0E        	mov	ax,0E0Dh
375F:05EF 9A 57 07 5F 37  	call	far 375Fh:0757h
375F:05F4 9A 27 09 5F 37  	call	far 375Fh:0927h
375F:05F9 8C DF           	mov	di,ds
375F:05FB 8E C7           	mov	es,di
375F:05FD BF 5E 6F        	mov	di,6F5Eh
375F:0600 9A D5 06 5F 37  	call	far 375Fh:06D5h
375F:0605 9A 68 08 5F 37  	call	far 375Fh:0868h
375F:060A 5B              	pop	bx
375F:060B 9A 0C 07 5F 37  	call	far 375Fh:070Ch
375F:0610 9A 5C 00 AE 38  	call	far 38AEh:005Ch
375F:0615 B9 0D 0E        	mov	cx,0E0Dh

l375F_0618:
375F:0618 51              	push	cx
375F:0619 9A 62 0A 5F 37  	call	far 375Fh:0A62h
375F:061E 59              	pop	cx
375F:061F E2 F7           	loop	0618h

l375F_0621:
375F:0621 9A 9B 00 AE 38  	call	far 38AEh:009Bh
375F:0626 8B CA           	mov	cx,dx
375F:0628 8B D8           	mov	bx,ax
375F:062A BA D0 FF        	mov	dx,0FFD0h
375F:062D B8 97 CE        	mov	ax,0CE97h
375F:0630 9A F6 00 AE 38  	call	far 38AEh:00F6h
375F:0635 5D              	pop	bp
375F:0636 5E              	pop	si
375F:0637 5F              	pop	di
375F:0638 1F              	pop	ds
375F:0639 9D              	popf
375F:063A CB              	retf

;; InstallDigitalPlaybackTimer_063B: 375F:063B
;;   Called from:
;;     31FB:05B8 (in PlayDigitalWeaponEffect_058D)
;;     31FB:10FB (in PlayScenarioDigitalSoundSequence_0742)
InstallDigitalPlaybackTimer_063B proc
375F:063B 8B DC           	mov	bx,sp
375F:063D 36 8B 47 04     	mov	ax,ss:[bx+4h]
375F:0641 9C              	pushf
375F:0642 50              	push	ax
375F:0643 57              	push	di
375F:0644 8C DF           	mov	di,ds
375F:0646 8E C7           	mov	es,di
375F:0648 BF 4C 6F        	mov	di,6F4Ch
375F:064B 9A D5 06 5F 37  	call	far 375Fh:06D5h
375F:0650 BB B2 6E        	mov	bx,6EB2h
375F:0653 9A 0C 07 5F 37  	call	far 375Fh:070Ch
375F:0658 5F              	pop	di
375F:0659 FA              	cli
375F:065A B8 1D 0A        	mov	ax,0A1Dh
375F:065D 8C CA           	mov	dx,cs
375F:065F BB 08 00        	mov	bx,8h
375F:0662 9A 10 00 AE 38  	call	far 38AEh:0010h
375F:0667 2E A3 BC 04     	mov	cs:[04BCh],ax
375F:066B 2E 89 16 BE 04  	mov	cs:[04BEh],dx
375F:0670 58              	pop	ax
375F:0671 9A 89 06 5F 37  	call	far 375Fh:0689h
375F:0676 2E 89 0E C0 04  	mov	cs:[04C0h],cx
375F:067B 49              	dec	cx
375F:067C 2E 89 0E C2 04  	mov	cs:[04C2h],cx
375F:0681 9D              	popf
375F:0682 CB              	retf
375F:0683          8B DC 36 8B 47 04                         ..6.G.       

;; ProgramDigitalPlaybackTimerRate_0689: 375F:0689
;;   Called from:
;;     375F:0671 (in InstallDigitalPlaybackTimer_063B)
ProgramDigitalPlaybackTimerRate_0689 proc
375F:0689 9A 46 00 AE 38  	call	far 38AEh:0046h
375F:068E 9A 46 00 AE 38  	call	far 38AEh:0046h
375F:0693 2E A3 C8 04     	mov	cs:[04C8h],ax
375F:0697 2E 89 0E C6 04  	mov	cs:[04C6h],cx
375F:069C 2E FF 0E C6 04  	dec	word ptr cs:[04C6h]
375F:06A1 91              	xchg	cx,ax
375F:06A2 9A 2A 00 AE 38  	call	far 38AEh:002Ah
375F:06A7 91              	xchg	cx,ax
375F:06A8 CB              	retf

;; RestoreDigitalPlaybackTimer_06A9: 375F:06A9
;;   Called from:
;;     31FB:0731 (in HandleDigitalWeaponEffectCompletion_06E9)
;;     31FB:1292 (in PlayScenarioDigitalSoundSequence_0742)
RestoreDigitalPlaybackTimer_06A9 proc
375F:06A9 9C              	pushf
375F:06AA FA              	cli
375F:06AB 2E A1 BC 04     	mov	ax,cs:[04BCh]
375F:06AF 2E 8B 16 BE 04  	mov	dx,cs:[04BEh]
375F:06B4 BB 08 00        	mov	bx,8h
375F:06B7 9A 10 00 AE 38  	call	far 38AEh:0010h
375F:06BC 2E A1 C0 04     	mov	ax,cs:[04C0h]
375F:06C0 9A 2A 00 AE 38  	call	far 38AEh:002Ah
375F:06C5 9D              	popf
375F:06C6 CB              	retf

;; InitializeDigitalDriverQueue_06C7: 375F:06C7
;;   Called from:
;;     31FB:008A (in InitializeDigitalSoundDriver_0005)
InitializeDigitalDriverQueue_06C7 proc
375F:06C7 8B DC           	mov	bx,sp
375F:06C9 57              	push	di
375F:06CA 36 C4 7F 04     	les	di,ss:[bx+4h]
375F:06CE 9A D5 06 5F 37  	call	far 375Fh:06D5h
375F:06D3 5F              	pop	di
375F:06D4 CB              	retf

;; InitializeDigitalDriverQueueCore_06D5: 375F:06D5
;;   Called from:
;;     375F:0600 (in CalibrateDigitalPlaybackRate_05D6)
;;     375F:064B (in InstallDigitalPlaybackTimer_063B)
;;     375F:06CE (in InitializeDigitalDriverQueue_06C7)
InitializeDigitalDriverQueueCore_06D5 proc
375F:06D5 8B C7           	mov	ax,di
375F:06D7 05 04 00        	add	ax,4h
375F:06DA 26 89 05        	mov	es:[di],ax
375F:06DD 26 8C 45 02     	mov	es:[di+2h],es
375F:06E1 33 C0           	xor	ax,ax
375F:06E3 26 89 45 04     	mov	es:[di+4h],ax
375F:06E7 26 89 45 06     	mov	es:[di+6h],ax
375F:06EB 26 89 7D 08     	mov	es:[di+8h],di
375F:06EF 26 8C 45 0A     	mov	es:[di+0Ah],es
375F:06F3 26 C7 45 0C 00 00 	mov	word ptr es:[di+0Ch],0h
375F:06F9 CB              	retf

;; AttachDigitalDriverQueue_06FA: 375F:06FA
;;   Called from:
;;     31FB:06DE (in PlayDigitalWeaponEffect_058D)
;;     31FB:1244 (in PlayScenarioDigitalSoundSequence_0742)
AttachDigitalDriverQueue_06FA proc
375F:06FA 8B DC           	mov	bx,sp
375F:06FC 57              	push	di
375F:06FD 36 C4 7F 06     	les	di,ss:[bx+6h]
375F:0701 36 8B 5F 04     	mov	bx,ss:[bx+4h]
375F:0705 9A 0C 07 5F 37  	call	far 375Fh:070Ch
375F:070A 5F              	pop	di
375F:070B CB              	retf

;; InstallDigitalDriverQueueCallback_070C: 375F:070C
;;   Called from:
;;     375F:060B (in CalibrateDigitalPlaybackRate_05D6)
;;     375F:0653 (in InstallDigitalPlaybackTimer_063B)
;;     375F:0705 (in AttachDigitalDriverQueue_06FA)
InstallDigitalDriverQueueCallback_070C proc
375F:070C 53              	push	bx
375F:070D 06              	push	es
375F:070E 9C              	pushf
375F:070F FA              	cli
375F:0710 8B 47 06        	mov	ax,[bx+6h]
375F:0713 2E A3 CA 04     	mov	cs:[04CAh],ax
375F:0717 2E 89 3E CC 04  	mov	cs:[04CCh],di
375F:071C 2E 8C 06 CE 04  	mov	cs:[04CEh],es
375F:0721 9D              	popf
375F:0722 8B 47 08        	mov	ax,[bx+8h]
375F:0725 2E A3 D2 04     	mov	cs:[04D2h],ax
375F:0729 2E A1 D0 04     	mov	ax,cs:[04D0h]
375F:072D 9A CC 09 5F 37  	call	far 375Fh:09CCh
375F:0732 07              	pop	es
375F:0733 5B              	pop	bx
375F:0734 CB              	retf

;; InitializeDigitalSampleDescriptor_0735: 375F:0735
;;   Called from:
;;     31FB:065E (in PlayDigitalWeaponEffect_058D)
;;     31FB:119F (in PlayScenarioDigitalSoundSequence_0742)
InitializeDigitalSampleDescriptor_0735 proc
375F:0735 8B DC           	mov	bx,sp
375F:0737 57              	push	di
375F:0738 56              	push	si
375F:0739 1E              	push	ds
375F:073A 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:073E 36 C4 7F 08     	les	di,ss:[bx+8h]
375F:0742 36 8B 47 0C     	mov	ax,ss:[bx+0Ch]
375F:0746 36 8B 57 0E     	mov	dx,ss:[bx+0Eh]
375F:074A 36 8B 4F 10     	mov	cx,ss:[bx+10h]
375F:074E 9A 57 07 5F 37  	call	far 375Fh:0757h
375F:0753 1F              	pop	ds
375F:0754 5E              	pop	si
375F:0755 5F              	pop	di
375F:0756 CB              	retf

;; InitializeDigitalSampleDescriptorCore_0757: 375F:0757
;;   Called from:
;;     375F:05EF (in CalibrateDigitalPlaybackRate_05D6)
;;     375F:074E (in InitializeDigitalSampleDescriptor_0735)
InitializeDigitalSampleDescriptorCore_0757 proc
375F:0757 89 7C 0C        	mov	[si+0Ch],di
375F:075A 8C 44 0E        	mov	[si+0Eh],es
375F:075D 89 44 10        	mov	[si+10h],ax
375F:0760 89 54 18        	mov	[si+18h],dx
375F:0763 89 4C 1A        	mov	[si+1Ah],cx
375F:0766 57              	push	di
375F:0767 33 C0           	xor	ax,ax
375F:0769 89 44 08        	mov	[si+8h],ax
375F:076C 89 44 0A        	mov	[si+0Ah],ax
375F:076F C7 44 1E 01 00  	mov	word ptr [si+1Eh],1h
375F:0774 89 44 1C        	mov	[si+1Ch],ax
375F:0777 8B D0           	mov	dx,ax
375F:0779 9A 05 08 5F 37  	call	far 375Fh:0805h
375F:077E 8B F8           	mov	di,ax
375F:0780 8E C0           	mov	es,ax
375F:0782 9A 32 08 5F 37  	call	far 375Fh:0832h
375F:0787 5F              	pop	di
375F:0788 C7 44 20 7C 0A  	mov	word ptr [si+20h],0A7Ch
375F:078D CB              	retf

;; ConfigureDigitalSampleTiming_078E: 375F:078E
;;   Called from:
;;     31FB:0681 (in PlayDigitalWeaponEffect_058D)
;;     31FB:1207 (in PlayScenarioDigitalSoundSequence_0742)
ConfigureDigitalSampleTiming_078E proc
375F:078E 8B DC           	mov	bx,sp
375F:0790 1E              	push	ds
375F:0791 56              	push	si
375F:0792 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:0796 36 8B 47 08     	mov	ax,ss:[bx+8h]
375F:079A 9A A2 07 5F 37  	call	far 375Fh:07A2h
375F:079F 5E              	pop	si
375F:07A0 1F              	pop	ds
375F:07A1 CB              	retf

;; CalculateDigitalSampleStep_07A2: 375F:07A2
;;   Called from:
;;     375F:079A (in ConfigureDigitalSampleTiming_078E)
CalculateDigitalSampleStep_07A2 proc
375F:07A2 55              	push	bp
375F:07A3 57              	push	di
375F:07A4 56              	push	si
375F:07A5 8B C8           	mov	cx,ax
375F:07A7 8B 5C 1A        	mov	bx,[si+1Ah]
375F:07AA 8B 44 18        	mov	ax,[si+18h]
375F:07AD 2E 8B 2E C8 04  	mov	bp,cs:[04C8h]
375F:07B2 33 D2           	xor	dx,dx
375F:07B4 F7 F5           	div	bp
375F:07B6 8B F8           	mov	di,ax
375F:07B8 33 C0           	xor	ax,ax
375F:07BA F7 F5           	div	bp
375F:07BC 91              	xchg	cx,ax
375F:07BD 33 D2           	xor	dx,dx
375F:07BF F7 F3           	div	bx
375F:07C1 8B F0           	mov	si,ax
375F:07C3 33 C0           	xor	ax,ax
375F:07C5 F7 F3           	div	bx
375F:07C7 8B E8           	mov	bp,ax
375F:07C9 F7 E1           	mul	cx
375F:07CB 8B DA           	mov	bx,dx
375F:07CD 8B C7           	mov	ax,di
375F:07CF F7 E6           	mul	si
375F:07D1 91              	xchg	cx,ax
375F:07D2 F7 E6           	mul	si
375F:07D4 03 D8           	add	bx,ax
375F:07D6 13 CA           	adc	cx,dx
375F:07D8 8B C7           	mov	ax,di
375F:07DA F7 E5           	mul	bp
375F:07DC 03 C3           	add	ax,bx
375F:07DE 13 D1           	adc	dx,cx
375F:07E0 5E              	pop	si
375F:07E1 5F              	pop	di
375F:07E2 5D              	pop	bp
375F:07E3 9C              	pushf
375F:07E4 FA              	cli
375F:07E5 89 54 1E        	mov	[si+1Eh],dx
375F:07E8 89 44 1C        	mov	[si+1Ch],ax
375F:07EB 9D              	popf
375F:07EC CB              	retf

;; ConfigureDigitalSampleLoop_07ED: 375F:07ED
ConfigureDigitalSampleLoop_07ED proc
375F:07ED 8B DC           	mov	bx,sp
375F:07EF 56              	push	si
375F:07F0 1E              	push	ds
375F:07F1 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:07F5 36 8B 47 08     	mov	ax,ss:[bx+8h]
375F:07F9 36 8B 57 0A     	mov	dx,ss:[bx+0Ah]
375F:07FD 9A 05 08 5F 37  	call	far 375Fh:0805h
375F:0802 1F              	pop	ds
375F:0803 5E              	pop	si
375F:0804 CB              	retf

;; SetDigitalSampleLoopRange_0805: 375F:0805
;;   Called from:
;;     375F:0779 (in InitializeDigitalSampleDescriptorCore_0757)
;;     375F:07FD (in ConfigureDigitalSampleLoop_07ED)
SetDigitalSampleLoopRange_0805 proc
375F:0805 9C              	pushf
375F:0806 FA              	cli
375F:0807 89 44 12        	mov	[si+12h],ax
375F:080A 89 54 14        	mov	[si+14h],dx
375F:080D 2B D0           	sub	dx,ax
375F:080F 89 54 16        	mov	[si+16h],dx
375F:0812 9D              	popf
375F:0813 CB              	retf

;; ConfigureDigitalSampleCompletion_0814: 375F:0814
;;   Called from:
;;     31FB:06A1 (in PlayDigitalWeaponEffect_058D)
ConfigureDigitalSampleCompletion_0814 proc
375F:0814 8B DC           	mov	bx,sp
375F:0816 57              	push	di
375F:0817 56              	push	si
375F:0818 1E              	push	ds
375F:0819 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:081D 36 C4 7F 08     	les	di,ss:[bx+8h]
375F:0821 36 8B 47 0C     	mov	ax,ss:[bx+0Ch]
375F:0825 36 8B 57 0E     	mov	dx,ss:[bx+0Eh]
375F:0829 9A 32 08 5F 37  	call	far 375Fh:0832h
375F:082E 1F              	pop	ds
375F:082F 5E              	pop	si
375F:0830 5F              	pop	di
375F:0831 CB              	retf

;; SetDigitalSampleCompletionCallback_0832: 375F:0832
;;   Called from:
;;     375F:0782 (in InitializeDigitalSampleDescriptorCore_0757)
;;     375F:0829 (in ConfigureDigitalSampleCompletion_0814)
SetDigitalSampleCompletionCallback_0832 proc
375F:0832 9C              	pushf
375F:0833 FA              	cli
375F:0834 89 44 30        	mov	[si+30h],ax
375F:0837 89 54 32        	mov	[si+32h],dx
375F:083A 8C C0           	mov	ax,es
375F:083C 0B C7           	or	ax,di
375F:083E 75 0A           	jnz	084Ah

l375F_0840:
375F:0840 8C 4C 2E        	mov	[si+2Eh],cs
375F:0843 C7 44 2C E5 0A  	mov	word ptr [si+2Ch],0AE5h
375F:0848 EB 06           	jmp	0850h

l375F_084A:
375F:084A 8C 44 2E        	mov	[si+2Eh],es
375F:084D 89 7C 2C        	mov	[si+2Ch],di

l375F_0850:
375F:0850 9D              	popf
375F:0851 CB              	retf

;; EnqueueDigitalSampleDescriptor_0852: 375F:0852
;;   Called from:
;;     31FB:06C5 (in PlayDigitalWeaponEffect_058D)
;;     31FB:122B (in PlayScenarioDigitalSoundSequence_0742)
EnqueueDigitalSampleDescriptor_0852 proc
375F:0852 8B DC           	mov	bx,sp
375F:0854 1E              	push	ds
375F:0855 56              	push	si
375F:0856 57              	push	di
375F:0857 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:085B 36 C4 7F 08     	les	di,ss:[bx+8h]
375F:085F 9A 68 08 5F 37  	call	far 375Fh:0868h
375F:0864 5F              	pop	di
375F:0865 5E              	pop	si
375F:0866 1F              	pop	ds
375F:0867 CB              	retf

;; LinkDigitalSampleDescriptor_0868: 375F:0868
;;   Called from:
;;     375F:0605 (in CalibrateDigitalPlaybackRate_05D6)
;;     375F:085F (in EnqueueDigitalSampleDescriptor_0852)
LinkDigitalSampleDescriptor_0868 proc
375F:0868 8B 44 08        	mov	ax,[si+8h]
375F:086B 0B 44 0A        	or	ax,[si+0Ah]
375F:086E 75 48           	jnz	08B8h

l375F_0870:
375F:0870 89 7C 08        	mov	[si+8h],di
375F:0873 8C 44 0A        	mov	[si+0Ah],es
375F:0876 9C              	pushf
375F:0877 FA              	cli
375F:0878 26 8B 45 0C     	mov	ax,es:[di+0Ch]
375F:087C 40              	inc	ax
375F:087D 26 89 45 0C     	mov	es:[di+0Ch],ax
375F:0881 8B D8           	mov	bx,ax
375F:0883 D1 E3           	shl	bx,1h
375F:0885 2E 8B 87 E8 0A  	mov	ax,cs:[bx+0AE8h]
375F:088A 26 89 45 0E     	mov	es:[di+0Eh],ax
375F:088E 06              	push	es
375F:088F 57              	push	di
375F:0890 8B DF           	mov	bx,di
375F:0892 8C C2           	mov	dx,es
375F:0894 26 C4 3D        	les	di,es:[di]
375F:0897 89 3C           	mov	[si],di
375F:0899 8C 44 02        	mov	[si+2h],es
375F:089C 89 5C 04        	mov	[si+4h],bx
375F:089F 89 54 06        	mov	[si+6h],dx
375F:08A2 26 89 75 04     	mov	es:[di+4h],si
375F:08A6 26 8C 5D 06     	mov	es:[di+6h],ds
375F:08AA 8C D8           	mov	ax,ds
375F:08AC 8E DA           	mov	ds,dx
375F:08AE 89 37           	mov	[bx],si
375F:08B0 89 47 02        	mov	[bx+2h],ax
375F:08B3 8E D8           	mov	ds,ax
375F:08B5 5F              	pop	di
375F:08B6 07              	pop	es
375F:08B7 9D              	popf

l375F_08B8:
375F:08B8 CB              	retf

;; RemoveDigitalSampleDescriptor_08B9: 375F:08B9
;;   Called from:
;;     31FB:05E9 (in PlayDigitalWeaponEffect_058D)
;;     31FB:0718 (in HandleDigitalWeaponEffectCompletion_06E9)
;;     31FB:112C (in PlayScenarioDigitalSoundSequence_0742)
;;     31FB:1269 (in PlayScenarioDigitalSoundSequence_0742)
RemoveDigitalSampleDescriptor_08B9 proc
375F:08B9 8B DC           	mov	bx,sp
375F:08BB 1E              	push	ds
375F:08BC 56              	push	si
375F:08BD 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:08C1 9A C9 08 5F 37  	call	far 375Fh:08C9h
375F:08C6 5E              	pop	si
375F:08C7 1F              	pop	ds
375F:08C8 CB              	retf

;; UnlinkDigitalSampleDescriptor_08C9: 375F:08C9
;;   Called from:
;;     375F:08C1 (in RemoveDigitalSampleDescriptor_08B9)
UnlinkDigitalSampleDescriptor_08C9 proc
375F:08C9 8B 44 08        	mov	ax,[si+8h]
375F:08CC 0B 44 0A        	or	ax,[si+0Ah]
375F:08CF 74 45           	jz	0916h

l375F_08D1:
375F:08D1 57              	push	di
375F:08D2 9C              	pushf
375F:08D3 FA              	cli
375F:08D4 06              	push	es
375F:08D5 57              	push	di
375F:08D6 8B 5C 04        	mov	bx,[si+4h]
375F:08D9 8B 54 06        	mov	dx,[si+6h]
375F:08DC C4 3C           	les	di,[si]
375F:08DE 26 89 5D 04     	mov	es:[di+4h],bx
375F:08E2 26 89 55 06     	mov	es:[di+6h],dx
375F:08E6 8C D8           	mov	ax,ds
375F:08E8 8E DA           	mov	ds,dx
375F:08EA 89 3F           	mov	[bx],di
375F:08EC 8C 47 02        	mov	[bx+2h],es
375F:08EF 8E D8           	mov	ds,ax
375F:08F1 5F              	pop	di
375F:08F2 07              	pop	es
375F:08F3 C4 7C 08        	les	di,[si+8h]
375F:08F6 26 8B 45 0C     	mov	ax,es:[di+0Ch]
375F:08FA 48              	dec	ax
375F:08FB 26 89 45 0C     	mov	es:[di+0Ch],ax
375F:08FF 8B D8           	mov	bx,ax
375F:0901 D1 E3           	shl	bx,1h
375F:0903 2E 8B 87 E8 0A  	mov	ax,cs:[bx+0AE8h]
375F:0908 26 89 45 0E     	mov	es:[di+0Eh],ax
375F:090C 9D              	popf
375F:090D 33 C0           	xor	ax,ax
375F:090F 89 44 08        	mov	[si+8h],ax
375F:0912 89 44 0A        	mov	[si+0Ah],ax
375F:0915 5F              	pop	di

l375F_0916:
375F:0916 CB              	retf

;; PrepareDigitalSamplePlayback_0917: 375F:0917
;;   Called from:
;;     31FB:06B1 (in PlayDigitalWeaponEffect_058D)
;;     31FB:0704 (in HandleDigitalWeaponEffectCompletion_06E9)
;;     31FB:1217 (in PlayScenarioDigitalSoundSequence_0742)
PrepareDigitalSamplePlayback_0917 proc
375F:0917 8B DC           	mov	bx,sp
375F:0919 1E              	push	ds
375F:091A 56              	push	si
375F:091B 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:091F 9A 27 09 5F 37  	call	far 375Fh:0927h
375F:0924 5E              	pop	si
375F:0925 1F              	pop	ds
375F:0926 CB              	retf

;; ResetDigitalSamplePlayback_0927: 375F:0927
;;   Called from:
;;     375F:05F4 (in CalibrateDigitalPlaybackRate_05D6)
;;     375F:091F (in PrepareDigitalSamplePlayback_0917)
ResetDigitalSamplePlayback_0927 proc
375F:0927 C7 44 20 7C 0A  	mov	word ptr [si+20h],0A7Ch
375F:092C 8B 44 0C        	mov	ax,[si+0Ch]
375F:092F 89 44 24        	mov	[si+24h],ax
375F:0932 8B 44 0E        	mov	ax,[si+0Eh]
375F:0935 89 44 26        	mov	[si+26h],ax
375F:0938 33 C0           	xor	ax,ax
375F:093A 89 44 22        	mov	[si+22h],ax
375F:093D 89 44 28        	mov	[si+28h],ax
375F:0940 39 44 16        	cmp	[si+16h],ax
375F:0943 74 08           	jz	094Dh

l375F_0945:
375F:0945 8B 44 14        	mov	ax,[si+14h]
375F:0948 BA AB 0A        	mov	dx,0AABh
375F:094B EB 06           	jmp	0953h

l375F_094D:
375F:094D 8B 44 10        	mov	ax,[si+10h]
375F:0950 BA 82 0A        	mov	dx,0A82h

l375F_0953:
375F:0953 89 44 2A        	mov	[si+2Ah],ax
375F:0956 89 54 20        	mov	[si+20h],dx
375F:0959 CB              	retf

;; FinishDigitalSampleLoop_095A: 375F:095A
FinishDigitalSampleLoop_095A proc
375F:095A 8B DC           	mov	bx,sp
375F:095C 1E              	push	ds
375F:095D 56              	push	si
375F:095E 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:0962 9A 6A 09 5F 37  	call	far 375Fh:096Ah
375F:0967 5E              	pop	si
375F:0968 1F              	pop	ds
375F:0969 CB              	retf

;; FinishDigitalSampleLoopCore_096A: 375F:096A
;;   Called from:
;;     375F:0962 (in FinishDigitalSampleLoop_095A)
FinishDigitalSampleLoopCore_096A proc
375F:096A 81 7C 20 AB 0A  	cmp	word ptr [si+20h],0AABh
375F:096F 75 14           	jnz	0985h

l375F_0971:
375F:0971 9C              	pushf
375F:0972 FA              	cli
375F:0973 8B 44 0C        	mov	ax,[si+0Ch]
375F:0976 03 44 10        	add	ax,[si+10h]
375F:0979 2B 44 24        	sub	ax,[si+24h]
375F:097C 89 44 2A        	mov	[si+2Ah],ax
375F:097F C7 44 20 82 0A  	mov	word ptr [si+20h],0A82h
375F:0984 9D              	popf

l375F_0985:
375F:0985 CB              	retf

;; StopDigitalSamplePlayback_0986: 375F:0986
StopDigitalSamplePlayback_0986 proc
375F:0986 8B DC           	mov	bx,sp
375F:0988 36 C4 5F 04     	les	bx,ss:[bx+4h]
375F:098C 26 C7 47 20 7C 0A 	mov	word ptr es:[bx+20h],0A7Ch
375F:0992 CB              	retf

;; StopDigitalSamplePlaybackCore_0993: 375F:0993
StopDigitalSamplePlaybackCore_0993 proc
375F:0993 C7 44 20 7C 0A  	mov	word ptr [si+20h],0A7Ch
375F:0998 CB              	retf

;; GetDigitalSamplePlaybackState_0999: 375F:0999
;;   Called from:
;;     31FB:1256 (in PlayScenarioDigitalSoundSequence_0742)
GetDigitalSamplePlaybackState_0999 proc
375F:0999 8B DC           	mov	bx,sp
375F:099B 1E              	push	ds
375F:099C 56              	push	si
375F:099D 36 C5 77 04     	lds	si,ss:[bx+4h]
375F:09A1 9A A9 09 5F 37  	call	far 375Fh:09A9h
375F:09A6 5E              	pop	si
375F:09A7 1F              	pop	ds
375F:09A8 CB              	retf

;; ReadDigitalSamplePlaybackState_09A9: 375F:09A9
;;   Called from:
;;     375F:09A1 (in GetDigitalSamplePlaybackState_0999)
ReadDigitalSamplePlaybackState_09A9 proc
375F:09A9 33 C0           	xor	ax,ax
375F:09AB 8B 54 20        	mov	dx,[si+20h]
375F:09AE 81 FA 7C 0A     	cmp	dx,0A7Ch
375F:09B2 74 11           	jz	09C5h

l375F_09B4:
375F:09B4 40              	inc	ax
375F:09B5 81 FA AB 0A     	cmp	dx,0AABh
375F:09B9 74 0A           	jz	09C5h

l375F_09BB:
375F:09BB 40              	inc	ax
375F:09BC 81 FA 82 0A     	cmp	dx,0A82h
375F:09C0 74 03           	jz	09C5h

l375F_09C2:
375F:09C2 B8 FF FF        	mov	ax,0FFFFh

l375F_09C5:
375F:09C5 CB              	retf

;; SetDigitalPlaybackTimingScale_09C6: 375F:09C6
;;   Called from:
;;     31FB:0049 (in InitializeDigitalSoundDriver_0005)
;;     31FB:05D9 (in PlayDigitalWeaponEffect_058D)
;;     31FB:111C (in PlayScenarioDigitalSoundSequence_0742)
SetDigitalPlaybackTimingScale_09C6 proc
375F:09C6 8B DC           	mov	bx,sp
375F:09C8 36 8B 47 04     	mov	ax,ss:[bx+4h]

;; ApplyDigitalMixScale_09CC: 375F:09CC
;;   Called from:
;;     375F:072D (in InstallDigitalDriverQueueCallback_070C)
;;     375F:09C8 (in SetDigitalPlaybackTimingScale_09C6)
ApplyDigitalMixScale_09CC proc
375F:09CC 2E A3 D0 04     	mov	cs:[04D0h],ax
375F:09D0 2E F7 26 D2 04  	mul	word ptr cs:[04D2h]
375F:09D5 8A C4           	mov	al,ah
375F:09D7 8A E2           	mov	ah,dl
375F:09D9 2E 3B 06 D4 04  	cmp	ax,cs:[04D4h]
375F:09DE 74 3C           	jz	0A1Ch

l375F_09E0:
375F:09E0 2E A3 D4 04     	mov	cs:[04D4h],ax
375F:09E4 57              	push	di
375F:09E5 8C CF           	mov	di,cs
375F:09E7 8E C7           	mov	es,di
375F:09E9 BF D6 04        	mov	di,4D6h
375F:09EC B9 00 01        	mov	cx,100h
375F:09EF 8B D8           	mov	bx,ax
375F:09F1 8B C1           	mov	ax,cx
375F:09F3 2B C3           	sub	ax,bx
375F:09F5 8A F0           	mov	dh,al
375F:09F7 32 D2           	xor	dl,dl
375F:09F9 D0 FC           	sar	ah,1h
375F:09FB D1 DA           	rcr	dx,1h
375F:09FD 79 0C           	jns	0A0Bh

l375F_09FF:
375F:09FF 32 C0           	xor	al,al

l375F_0A01:
375F:0A01 AA              	stosb
375F:0A02 03 D3           	add	dx,bx
375F:0A04 80 D4 00        	adc	ah,0h
375F:0A07 E0 F8           	loopne	0A01h

l375F_0A09:
375F:0A09 E3 10           	jcxz	0A1Bh

l375F_0A0B:
375F:0A0B 8A C6           	mov	al,dh
375F:0A0D AA              	stosb
375F:0A0E 03 D3           	add	dx,bx
375F:0A10 80 D4 00        	adc	ah,0h
375F:0A13 E1 F6           	loope	0A0Bh

l375F_0A15:
375F:0A15 E3 04           	jcxz	0A1Bh

l375F_0A17:
375F:0A17 B0 FF           	mov	al,0FFh

l375F_0A19:
375F:0A19 F3 AA           	rep stosb

l375F_0A1B:
375F:0A1B 5F              	pop	di

l375F_0A1C:
375F:0A1C CB              	retf
375F:0A1D                                        50 53 51              PSQ
375F:0A20 52 06 55 56 57 1E B0 20 E6 20 9A 62 0A 5F 37 2E R.UVW.. . .b._7.
375F:0A30 A1 C2 04 2E FF 06 C4 04 75 15 F9 2E 1B 06 C6 04 ........u.......
375F:0A40 73 0D 2E 03 06 C0 04 50 9C 2E FF 1E BC 04 58 2E s......P......X.
375F:0A50 FF 0E C4 04 2E A3 C2 04 1F 5F 5E 5D 07 5A 59 5B ........._^].ZY[
375F:0A60 58 CF                                           X.              

;; ServiceDigitalAudioTick_0A62: 375F:0A62
;;   Called from:
;;     375F:0619 (in CalibrateDigitalPlaybackRate_05D6)
ServiceDigitalAudioTick_0A62 proc
375F:0A62 2E C5 36 CC 04  	lds	si,cs:[04CCh]
375F:0A67 8B 4C 0C        	mov	cx,[si+0Ch]
375F:0A6A E3 78           	jcxz	0AE4h

l375F_0A6C:
375F:0A6C 8A 44 10        	mov	al,[si+10h]
375F:0A6F 2E FF 16 CA 04  	call	word ptr cs:[04CAh]
375F:0A74 8B 5C 0E        	mov	bx,[si+0Eh]
375F:0A77 C5 34           	lds	si,[si]
375F:0A79 FF 64 20        	jmp	word ptr [si+20h]
375F:0A7C                                     81 C3 80 00             ....
375F:0A80 EB 50 C4 7C 24 8B 6C 1C 8B 54 1E 29 6C 28 19 54 .P.|$.l..T.)l(.T
375F:0A90 2A 73 31 C7 44 20 7C 0A FF 74 32 FF 74 30 0E B8 *s1.D |..t2.t0..
375F:0AA0 E6 0A 50 FF 74 2E FF 74 2C EB 19 C4 7C 24 8B 6C ..P.t..t,...|$.l
375F:0AB0 1C 8B 54 1E 29 6C 28 19 54 2A 73 08 8B 44 16 2B ..T.)l(.T*s..D.+
375F:0AC0 F8 01 44 2A 26 02 1D 80 D7 00 01 6C 22 13 FA 89 ..D*&......l"...
375F:0AD0 7C 24 E2 A3 2E 8A 07 BB D6 04 2E D7 2E C5 36 CC |$............6.
375F:0AE0 04 88 44 10                                     ..D.            

l375F_0AE4:
375F:0AE4 FB              	sti
375F:0AE5 CB              	retf
375F:0AE6                   83 C4 04 CB F2 0A F2 0B F2 0D       ..........
375F:0AF0 F2 10 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D ................
375F:0B00 0E 0F 10 11 12 13 14 15 16 17 18 19 1A 1B 1C 1D ................
375F:0B10 1E 1F 20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D .. !"#$%&'()*+,-
375F:0B20 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D ./0123456789:;<=
375F:0B30 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D >?@ABCDEFGHIJKLM
375F:0B40 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D NOPQRSTUVWXYZ[\]
375F:0B50 5E 5F 60 61 62 63 64 65 66 67 68 69 6A 6B 6C 6D ^_`abcdefghijklm
375F:0B60 6E 6F 70 71 72 73 74 75 76 77 78 79 7A 7B 7C 7D nopqrstuvwxyz{|}
375F:0B70 7E 7F 80 81 82 83 84 85 86 87 88 89 8A 8B 8C 8D ~...............
375F:0B80 8E 8F 90 91 92 93 94 95 96 97 98 99 9A 9B 9C 9D ................
375F:0B90 9E 9F A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 AA AB AC AD ................
375F:0BA0 AE AF B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 BA BB BC BD ................
375F:0BB0 BE BF C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 CA CB CC CD ................
375F:0BC0 CE CF D0 D1 D2 D3 D4 D5 D6 D7 D8 D9 DA DB DC DD ................
375F:0BD0 DE DF E0 E1 E2 E3 E4 E5 E6 E7 E8 E9 EA EB EC ED ................
375F:0BE0 EE EF F0 F1 F2 F3 F4 F5 F6 F7 F8 F9 FA FB FC FD ................
375F:0BF0 FE FF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
375F:0C00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...
375F:0C30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 ................
375F:0C40 02 03 04 04 05 06 06 07 08 08 09 0A 0B 0B 0C 0D ................
375F:0C50 0D 0E 0F 10 10 11 12 12 13 14 15 15 16 17 17 18 ................
375F:0C60 19 19 1A 1B 1C 1C 1D 1E 1E 1F 20 21 21 22 23 23 .......... !!"##
375F:0C70 24 25 25 26 27 28 28 29 2A 2A 2B 2C 2D 2D 2E 2F $%%&'(()**+,--./
375F:0C80 2F 30 31 32 32 33 34 34 35 36 36 37 38 39 39 3A /01223445667899:
375F:0C90 3B 3B 3C 3D 3E 3E 3F 40 40 41 42 42 43 44 45 45 ;;<=>>?@@ABBCDEE
375F:0CA0 46 47 47 48 49 4A 4A 4B 4C 4C 4D 4E 4F 4F 50 51 FGGHIJJKLLMNOOPQ
375F:0CB0 51 52 53 53 54 55 56 56 57 58 58 59 5A 5B 5B 5C QRSSTUVVWXXYZ[[\
375F:0CC0 5D 5D 5E 5F 5F 60 61 62 62 63 64 64 65 66 67 67 ]]^__`abbcddefgg
375F:0CD0 68 69 69 6A 6B 6B 6C 6D 6E 6E 6F 70 70 71 72 73 hiijkklmnnoppqrs
375F:0CE0 73 74 75 75 76 77 78 78 79 7A 7A 7B 7C 7C 7D 7E stuuvwxxyzz{||}~
375F:0CF0 7F 7F 80 81 81 82 83 84 84 85 86 86 87 88 88 89 ................
375F:0D00 8A 8B 8B 8C 8D 8D 8E 8F 90 90 91 92 92 93 94 95 ................
375F:0D10 95 96 97 97 98 99 99 9A 9B 9C 9C 9D 9E 9E 9F A0 ................
375F:0D20 A1 A1 A2 A3 A3 A4 A5 A5 A6 A7 A8 A8 A9 AA AA AB ................
375F:0D30 AC AD AD AE AF AF B0 B1 B1 B2 B3 B4 B4 B5 B6 B6 ................
375F:0D40 B7 B8 B9 B9 BA BB BB BC BD BE BE BF C0 C0 C1 C2 ................
375F:0D50 C2 C3 C4 C5 C5 C6 C7 C7 C8 C9 CA CA CB CC CC CD ................
375F:0D60 CE CE CF D0 D1 D1 D2 D3 D3 D4 D5 D6 D6 D7 D8 D8 ................
375F:0D70 D9 DA DB DB DC DD DD DE DF DF E0 E1 E2 E2 E3 E4 ................
375F:0D80 E4 E5 E6 E7 E7 E8 E9 E9 EA EB EB EC ED EE EE EF ................
375F:0D90 F0 F0 F1 F2 F3 F3 F4 F5 F5 F6 F7 F8 F8 F9 FA FA ................
375F:0DA0 FB FC FC FD FE FF FF FF FF FF FF FF FF FF FF FF ................
375F:0DB0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:0DC0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:0DD0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:0DE0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:0DF0 FF FF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
375F:0E00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...
375F:0E90 00 00 00 00 00 00 01 02 02 03 03 04 04 05 06 06 ................
375F:0EA0 07 07 08 08 09 0A 0A 0B 0B 0C 0D 0D 0E 0E 0F 0F ................
375F:0EB0 10 11 11 12 12 13 13 14 15 15 16 16 17 17 18 19 ................
375F:0EC0 19 1A 1A 1B 1C 1C 1D 1D 1E 1E 1F 20 20 21 21 22 ...........  !!"
375F:0ED0 22 23 24 24 25 25 26 27 27 28 28 29 29 2A 2B 2B "#$$%%&''(())*++
375F:0EE0 2C 2C 2D 2D 2E 2F 2F 30 30 31 31 32 33 33 34 34 ,,--.//001123344
375F:0EF0 35 36 36 37 37 38 38 39 3A 3A 3B 3B 3C 3C 3D 3E 56677889::;;<<=>
375F:0F00 3E 3F 3F 40 40 41 42 42 43 43 44 45 45 46 46 47 >??@@ABBCCDEEFFG
375F:0F10 47 48 49 49 4A 4A 4B 4B 4C 4D 4D 4E 4E 4F 50 50 GHIIJJKKLMMNNOPP
375F:0F20 51 51 52 52 53 54 54 55 55 56 56 57 58 58 59 59 QQRRSTTUUVVWXXYY
375F:0F30 5A 5A 5B 5C 5C 5D 5D 5E 5F 5F 60 60 61 61 62 63 ZZ[\\]]^__``aabc
375F:0F40 63 64 64 65 65 66 67 67 68 68 69 69 6A 6B 6B 6C cddeefgghhiijkkl
375F:0F50 6C 6D 6E 6E 6F 6F 70 70 71 72 72 73 73 74 74 75 lmnnooppqrrssttu
375F:0F60 76 76 77 77 78 78 79 7A 7A 7B 7B 7C 7D 7D 7E 7E vvwwxxyzz{{|}}~~
375F:0F70 7F 7F 80 81 81 82 82 83 83 84 85 85 86 86 87 88 ................
375F:0F80 88 89 89 8A 8A 8B 8C 8C 8D 8D 8E 8E 8F 90 90 91 ................
375F:0F90 91 92 92 93 94 94 95 95 96 97 97 98 98 99 99 9A ................
375F:0FA0 9B 9B 9C 9C 9D 9D 9E 9F 9F A0 A0 A1 A1 A2 A3 A3 ................
375F:0FB0 A4 A4 A5 A6 A6 A7 A7 A8 A8 A9 AA AA AB AB AC AC ................
375F:0FC0 AD AE AE AF AF B0 B0 B1 B2 B2 B3 B3 B4 B5 B5 B6 ................
375F:0FD0 B6 B7 B7 B8 B9 B9 BA BA BB BB BC BD BD BE BE BF ................
375F:0FE0 C0 C0 C1 C1 C2 C2 C3 C4 C4 C5 C5 C6 C6 C7 C8 C8 ................
375F:0FF0 C9 C9 CA CA CB CC CC CD CD CE CF CF D0 D0 D1 D1 ................
375F:1000 D2 D3 D3 D4 D4 D5 D5 D6 D7 D7 D8 D8 D9 D9 DA DB ................
375F:1010 DB DC DC DD DE DE DF DF E0 E0 E1 E2 E2 E3 E3 E4 ................
375F:1020 E4 E5 E6 E6 E7 E7 E8 E9 E9 EA EA EB EB EC ED ED ................
375F:1030 EE EE EF EF F0 F1 F1 F2 F2 F3 F3 F4 F5 F5 F6 F6 ................
375F:1040 F7 F8 F8 F9 F9 FA FA FB FC FC FD FD FE FE FF FF ................
375F:1050 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1060 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1070 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1080 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1090 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:10A0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:10B0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:10C0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:10D0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:10E0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:10F0 FF FF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
375F:1100 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...
375F:11F0 00 00 00 01 01 02 02 03 03 04 04 05 05 06 06 07 ................
375F:1200 07 08 08 09 09 0A 0A 0B 0B 0C 0C 0D 0D 0E 0E 0F ................
375F:1210 0F 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 ................
375F:1220 17 18 18 19 19 1A 1A 1B 1B 1C 1C 1D 1D 1E 1E 1F ................
375F:1230 1F 20 20 21 21 22 22 23 23 24 24 25 25 26 26 27 .  !!""##$$%%&&'
375F:1240 27 28 28 29 29 2A 2A 2B 2B 2C 2C 2D 2D 2E 2E 2F '(())**++,,--../
375F:1250 2F 30 30 31 31 32 32 33 33 34 34 35 35 36 36 37 /001122334455667
375F:1260 37 38 38 39 39 3A 3A 3B 3B 3C 3C 3D 3D 3E 3E 3F 78899::;;<<==>>?
375F:1270 3F 40 40 41 41 42 42 43 43 44 44 45 45 46 46 47 ?@@AABBCCDDEEFFG
375F:1280 47 48 48 49 49 4A 4A 4B 4B 4C 4C 4D 4D 4E 4E 4F GHHIIJJKKLLMMNNO
375F:1290 4F 50 50 51 51 52 52 53 53 54 54 55 55 56 56 57 OPPQQRRSSTTUUVVW
375F:12A0 57 58 58 59 59 5A 5A 5B 5B 5C 5C 5D 5D 5E 5E 5F WXXYYZZ[[\\]]^^_
375F:12B0 5F 60 60 61 61 62 62 63 63 64 64 65 65 66 66 67 _``aabbccddeeffg
375F:12C0 67 68 68 69 69 6A 6A 6B 6B 6C 6C 6D 6D 6E 6E 6F ghhiijjkkllmmnno
375F:12D0 6F 70 70 71 71 72 72 73 73 74 74 75 75 76 76 77 oppqqrrssttuuvvw
375F:12E0 77 78 78 79 79 7A 7A 7B 7B 7C 7C 7D 7D 7E 7E 7F wxxyyzz{{||}}~~.
375F:12F0 7F 80 80 81 81 82 82 83 83 84 84 85 85 86 86 87 ................
375F:1300 87 88 88 89 89 8A 8A 8B 8B 8C 8C 8D 8D 8E 8E 8F ................
375F:1310 8F 90 90 91 91 92 92 93 93 94 94 95 95 96 96 97 ................
375F:1320 97 98 98 99 99 9A 9A 9B 9B 9C 9C 9D 9D 9E 9E 9F ................
375F:1330 9F A0 A0 A1 A1 A2 A2 A3 A3 A4 A4 A5 A5 A6 A6 A7 ................
375F:1340 A7 A8 A8 A9 A9 AA AA AB AB AC AC AD AD AE AE AF ................
375F:1350 AF B0 B0 B1 B1 B2 B2 B3 B3 B4 B4 B5 B5 B6 B6 B7 ................
375F:1360 B7 B8 B8 B9 B9 BA BA BB BB BC BC BD BD BE BE BF ................
375F:1370 BF C0 C0 C1 C1 C2 C2 C3 C3 C4 C4 C5 C5 C6 C6 C7 ................
375F:1380 C7 C8 C8 C9 C9 CA CA CB CB CC CC CD CD CE CE CF ................
375F:1390 CF D0 D0 D1 D1 D2 D2 D3 D3 D4 D4 D5 D5 D6 D6 D7 ................
375F:13A0 D7 D8 D8 D9 D9 DA DA DB DB DC DC DD DD DE DE DF ................
375F:13B0 DF E0 E0 E1 E1 E2 E2 E3 E3 E4 E4 E5 E5 E6 E6 E7 ................
375F:13C0 E7 E8 E8 E9 E9 EA EA EB EB EC EC ED ED EE EE EF ................
375F:13D0 EF F0 F0 F1 F1 F2 F2 F3 F3 F4 F4 F5 F5 F6 F6 F7 ................
375F:13E0 F7 F8 F8 F9 F9 FA FA FB FB FC FC FD FD FE FE FF ................
375F:13F0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1400 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1410 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1420 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1430 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1440 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1450 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1460 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1470 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1480 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:1490 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:14A0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:14B0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:14C0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:14D0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
375F:14E0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
