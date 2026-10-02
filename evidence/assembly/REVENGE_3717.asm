;;; Segment 3717 (3717:0000)

;; MPU401IRQHandler_0F60: 3621:0F60
MPU401IRQHandler_0F60 proc
3621:0F60 50              	push	ax
3621:0F61 52              	push	dx
3621:0F62 BA 30 03        	mov	dx,330h
3621:0F65 EC              	in	al,dx
3621:0F66 B0 20           	mov	al,20h
3621:0F68 E6 20           	out	20h,al
3621:0F6A 5A              	pop	dx
3621:0F6B 58              	pop	ax
3621:0F6C CF              	iret
3621:0F6D                                        00                    .  

;; InitializePCSpeakerSampleConversion_000E: 3717:000E
;;   Called from:
;;     31FB:00A9 (in InitializeDigitalSoundDriver_0005)
InitializePCSpeakerSampleConversion_000E proc
3717:000E 55              	push	bp
3717:000F 8B EC           	mov	bp,sp
3717:0011 B8 20 D3        	mov	ax,0D320h
3717:0014 BA D3 06        	mov	dx,6D3h
3717:0017 F7 76 06        	div	word ptr [bp+6h]
3717:001A A3 D4 B7        	mov	[0B7D4h],ax
3717:001D 50              	push	ax
3717:001E 0E              	push	cs
3717:001F E8 86 00        	call	00A8h
3717:0022 83 C4 02        	add	sp,2h
3717:0025 A3 D6 B7        	mov	[0B7D6h],ax
3717:0028 50              	push	ax
3717:0029 FF 36 D4 B7     	push	word ptr [0B7D4h]
3717:002D 0E              	push	cs
3717:002E E8 E5 00        	call	0116h
3717:0031 83 C4 04        	add	sp,4h
3717:0034 0B C0           	or	ax,ax
3717:0036 74 04           	jz	003Ch

l3717_0038:
3717:0038 2B C0           	sub	ax,ax
3717:003A 5D              	pop	bp
3717:003B CB              	retf

l3717_003C:
3717:003C 0E              	push	cs
3717:003D E8 42 01        	call	0182h
3717:0040 B8 01 00        	mov	ax,1h
3717:0043 5D              	pop	bp
3717:0044 CB              	retf
3717:0045                90                                    .          

;; TranslatePCSpeakerSampleBuffer_0046: 3717:0046
;;   Called from:
;;     31FB:0559 (in LoadScenarioDigitalSoundBank_0297)
TranslatePCSpeakerSampleBuffer_0046 proc
3717:0046 55              	push	bp
3717:0047 8B EC           	mov	bp,sp
3717:0049 83 EC 06        	sub	sp,6h
3717:004C 57              	push	di
3717:004D 8B 4E 0A        	mov	cx,[bp+0Ah]
3717:0050 8B 46 06        	mov	ax,[bp+6h]
3717:0053 8B 56 08        	mov	dx,[bp+8h]
3717:0056 89 46 FC        	mov	[bp-4h],ax
3717:0059 89 56 FE        	mov	[bp-2h],dx
3717:005C C4 7E FC        	les	di,[bp-4h]

l3717_005F:
3717:005F 26 8A 1D        	mov	bl,es:[di]
3717:0062 2A FF           	sub	bh,bh
3717:0064 8A 87 D4 B6     	mov	al,[bx+0B6D4h]
3717:0068 26 88 05        	mov	es:[di],al
3717:006B 47              	inc	di
3717:006C E2 F1           	loop	005Fh

l3717_006E:
3717:006E 89 7E FC        	mov	[bp-4h],di
3717:0071 8C 46 FE        	mov	[bp-2h],es
3717:0074 89 4E FA        	mov	[bp-6h],cx
3717:0077 5F              	pop	di
3717:0078 8B E5           	mov	sp,bp
3717:007A 5D              	pop	bp
3717:007B CB              	retf
3717:007C                                     90 90                   ..  

;; PlayPCSpeakerBitstream_007E: 3717:007E
;;   Called from:
;;     31FB:11F1 (in PlayScenarioDigitalSoundSequence_0742)
PlayPCSpeakerBitstream_007E proc
3717:007E 55              	push	bp
3717:007F 8B EC           	mov	bp,sp
3717:0081 FF 36 D6 B7     	push	word ptr [0B7D6h]
3717:0085 9A 0C 00 3D 37  	call	far 373Dh:000Ch
3717:008A 83 C4 02        	add	sp,2h
3717:008D FF 76 0A        	push	word ptr [bp+0Ah]
3717:0090 FF 76 08        	push	word ptr [bp+8h]
3717:0093 FF 76 06        	push	word ptr [bp+6h]
3717:0096 9A 4E 00 3D 37  	call	far 373Dh:004Eh
3717:009B 83 C4 06        	add	sp,6h
3717:009E 9A 0B 02 3D 37  	call	far 373Dh:020Bh
3717:00A3 5D              	pop	bp
3717:00A4 CB              	retf
3717:00A5                90 CB 90                              ...        

;; FindPCSpeakerDelayScale_00A8: 3717:00A8
;;   Called from:
;;     3717:001E (in InitializePCSpeakerSampleConversion_000E)
FindPCSpeakerDelayScale_00A8 proc
3717:00A8 55              	push	bp
3717:00A9 8B EC           	mov	bp,sp
3717:00AB 83 EC 0A        	sub	sp,0Ah
3717:00AE 57              	push	di
3717:00AF 56              	push	si
3717:00B0 C7 46 FA FF 7F  	mov	word ptr [bp-6h],7FFFh
3717:00B5 C7 46 FC 00 00  	mov	word ptr [bp-4h],0h
3717:00BA B8 4A 4A        	mov	ax,4A4Ah
3717:00BD B9 18 00        	mov	cx,18h
3717:00C0 BF D8 B7        	mov	di,0B7D8h
3717:00C3 1E              	push	ds
3717:00C4 07              	pop	es

l3717_00C5:
3717:00C5 F3 AB           	rep stosw

l3717_00C7:
3717:00C7 83 46 FC 30     	add	word ptr [bp-4h],30h
3717:00CB BF 01 00        	mov	di,1h
3717:00CE EB 04           	jmp	00D4h

l3717_00D0:
3717:00D0 89 76 FA        	mov	[bp-6h],si
3717:00D3 47              	inc	di

l3717_00D4:
3717:00D4 57              	push	di
3717:00D5 9A 0C 00 3D 37  	call	far 373Dh:000Ch
3717:00DA 83 C4 02        	add	sp,2h
3717:00DD B8 30 00        	mov	ax,30h
3717:00E0 50              	push	ax
3717:00E1 B8 D8 B7        	mov	ax,0B7D8h
3717:00E4 1E              	push	ds
3717:00E5 50              	push	ax
3717:00E6 9A 4E 00 3D 37  	call	far 373Dh:004Eh
3717:00EB 83 C4 06        	add	sp,6h
3717:00EE 9A 0B 02 3D 37  	call	far 373Dh:020Bh
3717:00F3 8B C8           	mov	cx,ax
3717:00F5 8B 46 06        	mov	ax,[bp+6h]
3717:00F8 2B C1           	sub	ax,cx
3717:00FA 99              	cwd
3717:00FB 33 C2           	xor	ax,dx
3717:00FD 2B C2           	sub	ax,dx
3717:00FF 8B F0           	mov	si,ax
3717:0101 3B 76 FA        	cmp	si,[bp-6h]
3717:0104 7E CA           	jle	00D0h

l3717_0106:
3717:0106 4F              	dec	di
3717:0107 89 7E F8        	mov	[bp-8h],di
3717:010A 89 76 FE        	mov	[bp-2h],si
3717:010D 8B C7           	mov	ax,di
3717:010F 5E              	pop	si
3717:0110 5F              	pop	di
3717:0111 8B E5           	mov	sp,bp
3717:0113 5D              	pop	bp
3717:0114 CB              	retf
3717:0115                90                                    .          

;; PCSpeakerCalibrationExceedsTolerance_0116: 3717:0116
;;   Called from:
;;     3717:002D (in InitializePCSpeakerSampleConversion_000E)
PCSpeakerCalibrationExceedsTolerance_0116 proc
3717:0116 55              	push	bp
3717:0117 8B EC           	mov	bp,sp
3717:0119 83 EC 06        	sub	sp,6h
3717:011C 57              	push	di
3717:011D 8B 46 06        	mov	ax,[bp+6h]
3717:0120 99              	cwd
3717:0121 B9 05 00        	mov	cx,5h
3717:0124 F7 F9           	idiv	cx
3717:0126 89 46 FC        	mov	[bp-4h],ax
3717:0129 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
3717:012E B8 4A 4A        	mov	ax,4A4Ah
3717:0131 B9 18 00        	mov	cx,18h
3717:0134 BF D8 B7        	mov	di,0B7D8h
3717:0137 1E              	push	ds
3717:0138 07              	pop	es

l3717_0139:
3717:0139 F3 AB           	rep stosw

l3717_013B:
3717:013B 83 46 FE 30     	add	word ptr [bp-2h],30h
3717:013F FF 76 08        	push	word ptr [bp+8h]
3717:0142 9A 0C 00 3D 37  	call	far 373Dh:000Ch
3717:0147 83 C4 02        	add	sp,2h
3717:014A B8 30 00        	mov	ax,30h
3717:014D 50              	push	ax
3717:014E B8 D8 B7        	mov	ax,0B7D8h
3717:0151 1E              	push	ds
3717:0152 50              	push	ax
3717:0153 9A 4E 00 3D 37  	call	far 373Dh:004Eh
3717:0158 83 C4 06        	add	sp,6h
3717:015B 9A 0B 02 3D 37  	call	far 373Dh:020Bh
3717:0160 8B C8           	mov	cx,ax
3717:0162 8B 46 06        	mov	ax,[bp+6h]
3717:0165 2B C1           	sub	ax,cx
3717:0167 99              	cwd
3717:0168 33 C2           	xor	ax,dx
3717:016A 2B C2           	sub	ax,dx
3717:016C 3B 46 FC        	cmp	ax,[bp-4h]
3717:016F 7E 09           	jle	017Ah

l3717_0171:
3717:0171 B8 01 00        	mov	ax,1h
3717:0174 5F              	pop	di
3717:0175 8B E5           	mov	sp,bp
3717:0177 5D              	pop	bp
3717:0178 CB              	retf
3717:0179                            90                            .      

l3717_017A:
3717:017A 2B C0           	sub	ax,ax
3717:017C 5F              	pop	di
3717:017D 8B E5           	mov	sp,bp
3717:017F 5D              	pop	bp
3717:0180 CB              	retf
3717:0181    90                                            .              

;; BuildPCSpeakerSampleLookup_0182: 3717:0182
;;   Called from:
;;     3717:003C (in InitializePCSpeakerSampleConversion_000E)
BuildPCSpeakerSampleLookup_0182 proc
3717:0182 55              	push	bp
3717:0183 8B EC           	mov	bp,sp
3717:0185 83 EC 34        	sub	sp,34h
3717:0188 57              	push	di
3717:0189 56              	push	si
3717:018A C7 46 E8 00 00  	mov	word ptr [bp-18h],0h
3717:018F C7 46 E2 07 00  	mov	word ptr [bp-1Eh],7h

l3717_0194:
3717:0194 C7 46 E4 08 00  	mov	word ptr [bp-1Ch],8h
3717:0199 8B 46 E8        	mov	ax,[bp-18h]
3717:019C B9 08 00        	mov	cx,8h
3717:019F 8D 7E EA        	lea	di,[bp-16h]
3717:01A2 16              	push	ss
3717:01A3 07              	pop	es

l3717_01A4:
3717:01A4 F3 AB           	rep stosw

l3717_01A6:
3717:01A6 C6 46 FE 00     	mov	byte ptr [bp-2h],0h
3717:01AA C7 46 E4 08 00  	mov	word ptr [bp-1Ch],8h
3717:01AF C6 46 FC 01     	mov	byte ptr [bp-4h],1h
3717:01B3 C7 46 CC 08 00  	mov	word ptr [bp-34h],8h

l3717_01B8:
3717:01B8 8B 46 EA        	mov	ax,[bp-16h]
3717:01BB 89 46 FA        	mov	[bp-6h],ax
3717:01BE 3D FF 00        	cmp	ax,0FFh
3717:01C1 7E 07           	jle	01CAh

l3717_01C3:
3717:01C3 C7 46 FA FF 00  	mov	word ptr [bp-6h],0FFh
3717:01C8 EB 0B           	jmp	01D5h

l3717_01CA:
3717:01CA 83 7E FA 00     	cmp	word ptr [bp-6h],0h
3717:01CE 7D 05           	jge	01D5h

l3717_01D0:
3717:01D0 C7 46 FA 00 00  	mov	word ptr [bp-6h],0h

l3717_01D5:
3717:01D5 81 7E FA 80 00  	cmp	word ptr [bp-6h],80h
3717:01DA 7C 06           	jl	01E2h

l3717_01DC:
3717:01DC 8A 46 FC        	mov	al,[bp-4h]
3717:01DF EB 03           	jmp	01E4h
3717:01E1    90                                            .              

l3717_01E2:
3717:01E2 2A C0           	sub	al,al

l3717_01E4:
3717:01E4 88 46 E0        	mov	[bp-20h],al
3717:01E7 0A C0           	or	al,al
3717:01E9 74 05           	jz	01F0h

l3717_01EB:
3717:01EB B8 C0 00        	mov	ax,0C0h
3717:01EE EB 03           	jmp	01F3h

l3717_01F0:
3717:01F0 B8 40 00        	mov	ax,40h

l3717_01F3:
3717:01F3 8B 4E FA        	mov	cx,[bp-6h]
3717:01F6 2B C8           	sub	cx,ax
3717:01F8 89 4E E6        	mov	[bp-1Ah],cx
3717:01FB 8D 46 EA        	lea	ax,[bp-16h]
3717:01FE 89 46 D6        	mov	[bp-2Ah],ax
3717:0201 8C 56 D8        	mov	[bp-28h],ss
3717:0204 BE 18 6D        	mov	si,6D18h
3717:0207 8D 46 EC        	lea	ax,[bp-14h]
3717:020A 89 46 D0        	mov	[bp-30h],ax
3717:020D 8C 56 D2        	mov	[bp-2Eh],ss
3717:0210 BF 07 00        	mov	di,7h

l3717_0213:
3717:0213 8B 46 E6        	mov	ax,[bp-1Ah]
3717:0216 F7 2C           	imul	word ptr [si]
3717:0218 B1 07           	mov	cl,7h
3717:021A D3 F8           	sar	ax,cl
3717:021C C4 5E D0        	les	bx,[bp-30h]
3717:021F 26 03 07        	add	ax,es:[bx]
3717:0222 C4 5E D6        	les	bx,[bp-2Ah]
3717:0225 26 89 07        	mov	es:[bx],ax
3717:0228 83 46 D6 02     	add	word ptr [bp-2Ah],2h
3717:022C 83 C6 02        	add	si,2h
3717:022F 83 46 D0 02     	add	word ptr [bp-30h],2h
3717:0233 4F              	dec	di
3717:0234 75 DD           	jnz	0213h

l3717_0236:
3717:0236 8A 46 E0        	mov	al,[bp-20h]
3717:0239 08 46 FE        	or	[bp-2h],al
3717:023C D0 66 FC        	shl	byte ptr [bp-4h],1h
3717:023F FF 4E CC        	dec	word ptr [bp-34h]
3717:0242 74 03           	jz	0247h

l3717_0244:
3717:0244 E9 71 FF        	jmp	01B8h

l3717_0247:
3717:0247 8B 5E E8        	mov	bx,[bp-18h]
3717:024A 8A 46 FE        	mov	al,[bp-2h]
3717:024D 88 87 D4 B6     	mov	[bx+0B6D4h],al
3717:0251 FF 46 E8        	inc	word ptr [bp-18h]
3717:0254 81 7E E8 00 01  	cmp	word ptr [bp-18h],100h
3717:0259 73 03           	jnc	025Eh

l3717_025B:
3717:025B E9 36 FF        	jmp	0194h

l3717_025E:
3717:025E 5E              	pop	si
3717:025F 5F              	pop	di
