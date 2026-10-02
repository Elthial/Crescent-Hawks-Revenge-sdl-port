;;; Segment 2C7F (2C7F:0000)
2C7F:0000 99 01                                           ..              

l2B34_14B2:
2B34:14B2 47              	inc	di

l2B34_14B3:
2B34:14B3 3B 7E 0A        	cmp	di,[bp+0Ah]
2B34:14B6 7D 03           	jge	14BBh

l2B34_14B8:
2B34:14B8 E9 5E FF        	jmp	1419h

l2B34_14BB:
2B34:14BB 5F              	pop	di
2B34:14BC 5E              	pop	si
2B34:14BD 5D              	pop	bp
2B34:14BE CB              	retf

;; main: 2C7F:000F
main proc
2C7F:000F C7 06 4E B6 00 00 	mov	word ptr [0B64Eh],0h
2C7F:0015 C7 06 CE 5F 01 00 	mov	word ptr [5FCEh],1h
2C7F:001B C7 06 24 62 00 00 	mov	word ptr [6224h],0h
2C7F:0021 9A 3C 00 7F 2C  	call	far 2C7Fh:003Ch
2C7F:0026 83 3E C8 38 00  	cmp	word ptr [38C8h],0h
2C7F:002B 74 05           	jz	0032h

l2C7F_002D:
2C7F:002D 9A 06 00 73 0D  	call	far 0D73h:0006h

l2C7F_0032:
2C7F:0032 9A E3 02 7F 2C  	call	far 2C7Fh:02E3h
2C7F:0037 33 C0           	xor	ax,ax
2C7F:0039 EB 00           	jmp	003Bh

l2C7F_003B:
2C7F:003B CB              	retf

;; InitializeGame_003C: 2C7F:003C
;;   Called from:
;;     2C7F:0021 (in main)
InitializeGame_003C proc
2C7F:003C 55              	push	bp
2C7F:003D 8B EC           	mov	bp,sp
2C7F:003F 83 EC 0A        	sub	sp,0Ah
2C7F:0042 56              	push	si
2C7F:0043 57              	push	di
2C7F:0044 9A 2B 03 7F 2C  	call	far 2C7Fh:032Bh
2C7F:0049 A3 C6 38        	mov	[38C6h],ax
2C7F:004C B8 05 00        	mov	ax,5h
2C7F:004F 50              	push	ax
2C7F:0050 9A 50 03 7F 2C  	call	far 2C7Fh:0350h
2C7F:0055 59              	pop	cx
2C7F:0056 C7 06 10 80 01 02 	mov	word ptr [8010h],201h
2C7F:005C 9A 68 04 37 30  	call	far 3037h:0468h
2C7F:0061 1E              	push	ds
2C7F:0062 B8 E4 38        	mov	ax,38E4h
2C7F:0065 50              	push	ax
2C7F:0066 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:006B 59              	pop	cx
2C7F:006C 59              	pop	cx
2C7F:006D 1E              	push	ds
2C7F:006E B8 25 39        	mov	ax,3925h
2C7F:0071 50              	push	ax
2C7F:0072 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0077 59              	pop	cx
2C7F:0078 59              	pop	cx
2C7F:0079 B8 10 00        	mov	ax,10h
2C7F:007C 50              	push	ax
2C7F:007D 16              	push	ss
2C7F:007E 8D 46 F6        	lea	ax,[bp-0Ah]
2C7F:0081 50              	push	ax
2C7F:0082 B8 01 00        	mov	ax,1h
2C7F:0085 50              	push	ax
2C7F:0086 9A 8D 00 68 39  	call	far 3968h:008Dh
2C7F:008B 83 C4 08        	add	sp,8h
2C7F:008E 16              	push	ss
2C7F:008F 8D 46 F6        	lea	ax,[bp-0Ah]
2C7F:0092 50              	push	ax
2C7F:0093 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0098 59              	pop	cx
2C7F:0099 59              	pop	cx
2C7F:009A 1E              	push	ds
2C7F:009B B8 8F 3A        	mov	ax,3A8Fh
2C7F:009E 50              	push	ax
2C7F:009F 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:00A4 59              	pop	cx
2C7F:00A5 59              	pop	cx
2C7F:00A6 B8 10 00        	mov	ax,10h
2C7F:00A9 50              	push	ax
2C7F:00AA 16              	push	ss
2C7F:00AB 8D 46 F6        	lea	ax,[bp-0Ah]
2C7F:00AE 50              	push	ax
2C7F:00AF 33 C0           	xor	ax,ax
2C7F:00B1 50              	push	ax
2C7F:00B2 9A 8D 00 68 39  	call	far 3968h:008Dh
2C7F:00B7 83 C4 08        	add	sp,8h
2C7F:00BA B8 02 00        	mov	ax,2h
2C7F:00BD 50              	push	ax
2C7F:00BE 16              	push	ss
2C7F:00BF 8D 46 F6        	lea	ax,[bp-0Ah]
2C7F:00C2 50              	push	ax
2C7F:00C3 9A 8E 41 73 0D  	call	far 0D73h:418Eh
2C7F:00C8 83 C4 06        	add	sp,6h
2C7F:00CB 1E              	push	ds
2C7F:00CC B8 BA 3C        	mov	ax,3CBAh
2C7F:00CF 50              	push	ax
2C7F:00D0 1E              	push	ds
2C7F:00D1 B8 B8 3C        	mov	ax,3CB8h
2C7F:00D4 50              	push	ax
2C7F:00D5 16              	push	ss
2C7F:00D6 8D 46 F6        	lea	ax,[bp-0Ah]
2C7F:00D9 50              	push	ax
2C7F:00DA 9A 88 42 73 0D  	call	far 0D73h:4288h
2C7F:00DF 83 C4 0C        	add	sp,0Ch
2C7F:00E2 16              	push	ss
2C7F:00E3 8D 46 F6        	lea	ax,[bp-0Ah]
2C7F:00E6 50              	push	ax
2C7F:00E7 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:00EC 59              	pop	cx
2C7F:00ED 59              	pop	cx
2C7F:00EE 1E              	push	ds
2C7F:00EF B8 8F 3A        	mov	ax,3A8Fh
2C7F:00F2 50              	push	ax
2C7F:00F3 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:00F8 59              	pop	cx
2C7F:00F9 59              	pop	cx
2C7F:00FA 1E              	push	ds
2C7F:00FB B8 8C 3A        	mov	ax,3A8Ch
2C7F:00FE 50              	push	ax
2C7F:00FF 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0104 59              	pop	cx
2C7F:0105 59              	pop	cx
2C7F:0106 1E              	push	ds
2C7F:0107 B8 2F 39        	mov	ax,392Fh
2C7F:010A 50              	push	ax
2C7F:010B 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0110 59              	pop	cx
2C7F:0111 59              	pop	cx
2C7F:0112 1E              	push	ds
2C7F:0113 B8 8C 3A        	mov	ax,3A8Ch
2C7F:0116 50              	push	ax
2C7F:0117 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:011C 59              	pop	cx
2C7F:011D 59              	pop	cx
2C7F:011E 1E              	push	ds
2C7F:011F B8 8C 3A        	mov	ax,3A8Ch
2C7F:0122 50              	push	ax
2C7F:0123 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0128 59              	pop	cx
2C7F:0129 59              	pop	cx
2C7F:012A 9A 0F 00 8B 39  	call	far 398Bh:000Fh
2C7F:012F B1 0A           	mov	cl,0Ah
2C7F:0131 9A 07 55 00 08  	call	far 0800h:5507h
2C7F:0136 8B F8           	mov	di,ax
2C7F:0138 9A 7A 04 7F 2C  	call	far 2C7Fh:047Ah
2C7F:013D 8B F0           	mov	si,ax
2C7F:013F 0B F6           	or	si,si
2C7F:0141 74 4B           	jz	018Eh

l2C7F_0143:
2C7F:0143 81 FF 10 01     	cmp	di,110h
2C7F:0147 73 10           	jnc	0159h

l2C7F_0149:
2C7F:0149 1E              	push	ds
2C7F:014A B8 53 3A        	mov	ax,3A53h
2C7F:014D 50              	push	ax
2C7F:014E 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0153 59              	pop	cx
2C7F:0154 59              	pop	cx
2C7F:0155 33 F6           	xor	si,si
2C7F:0157 EB 1B           	jmp	0174h

l2C7F_0159:
2C7F:0159 83 3E CE B6 01  	cmp	word ptr [0B6CEh],1h
2C7F:015E 75 14           	jnz	0174h

l2C7F_0160:
2C7F:0160 81 FF 20 01     	cmp	di,120h
2C7F:0164 73 0E           	jnc	0174h

l2C7F_0166:
2C7F:0166 1E              	push	ds
2C7F:0167 B8 12 3A        	mov	ax,3A12h
2C7F:016A 50              	push	ax
2C7F:016B 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0170 59              	pop	cx
2C7F:0171 59              	pop	cx
2C7F:0172 33 F6           	xor	si,si

l2C7F_0174:
2C7F:0174 0B F6           	or	si,si
2C7F:0176 75 16           	jnz	018Eh

l2C7F_0178:
2C7F:0178 1E              	push	ds
2C7F:0179 B8 70 3C        	mov	ax,3C70h
2C7F:017C 50              	push	ax
2C7F:017D 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0182 59              	pop	cx
2C7F:0183 59              	pop	cx
2C7F:0184 9A 1E 3E 73 0D  	call	far 0D73h:3E1Eh
2C7F:0189 9A 5C 04 7F 2C  	call	far 2C7Fh:045Ch

l2C7F_018E:
2C7F:018E 0B F6           	or	si,si
2C7F:0190 75 03           	jnz	0195h

l2C7F_0192:
2C7F:0192 E9 48 01        	jmp	02DDh

l2C7F_0195:
2C7F:0195 9A 0A 00 B8 34  	call	far 34B8h:000Ah
2C7F:019A B8 2C 01        	mov	ax,12Ch
2C7F:019D 50              	push	ax
2C7F:019E 9A 97 3C 73 0D  	call	far 0D73h:3C97h
2C7F:01A3 59              	pop	cx
2C7F:01A4 1E              	push	ds
2C7F:01A5 B8 CA 38        	mov	ax,38CAh
2C7F:01A8 50              	push	ax
2C7F:01A9 9A 0B 00 77 34  	call	far 3477h:000Bh
2C7F:01AE 59              	pop	cx
2C7F:01AF 59              	pop	cx
2C7F:01B0 89 16 B5 86     	mov	[86B5h],dx
2C7F:01B4 A3 B3 86        	mov	[86B3h],ax
2C7F:01B7 1E              	push	ds
2C7F:01B8 B8 D7 38        	mov	ax,38D7h
2C7F:01BB 50              	push	ax
2C7F:01BC 9A 0B 00 77 34  	call	far 3477h:000Bh
2C7F:01C1 59              	pop	cx
2C7F:01C2 59              	pop	cx
2C7F:01C3 89 16 B9 86     	mov	[86B9h],dx
2C7F:01C7 A3 B7 86        	mov	[86B7h],ax
2C7F:01CA A1 B3 86        	mov	ax,[86B3h]
2C7F:01CD 0B 06 B5 86     	or	ax,[86B5h]
2C7F:01D1 75 03           	jnz	01D6h

l2C7F_01D3:
2C7F:01D3 E9 F1 00        	jmp	02C7h

l2C7F_01D6:
2C7F:01D6 A1 B7 86        	mov	ax,[86B7h]
2C7F:01D9 0B 06 B9 86     	or	ax,[86B9h]
2C7F:01DD 75 03           	jnz	01E2h

l2C7F_01DF:
2C7F:01DF E9 E5 00        	jmp	02C7h

l2C7F_01E2:
2C7F:01E2 FF 36 CE B6     	push	word ptr [0B6CEh]
2C7F:01E6 9A 50 03 7F 2C  	call	far 2C7Fh:0350h
2C7F:01EB 59              	pop	cx
2C7F:01EC FF 36 B9 86     	push	word ptr [86B9h]
2C7F:01F0 FF 36 B7 86     	push	word ptr [86B7h]
2C7F:01F4 9A 8F 01 77 34  	call	far 3477h:018Fh
2C7F:01F9 59              	pop	cx
2C7F:01FA 59              	pop	cx
2C7F:01FB BA 01 00        	mov	dx,1h
2C7F:01FE B8 00 FD        	mov	ax,0FD00h
2C7F:0201 52              	push	dx
2C7F:0202 50              	push	ax
2C7F:0203 9A 12 01 56 0D  	call	far 0D56h:0112h
2C7F:0208 59              	pop	cx
2C7F:0209 59              	pop	cx
2C7F:020A 89 16 60 B6     	mov	[0B660h],dx
2C7F:020E A3 5E B6        	mov	[0B65Eh],ax
2C7F:0211 BA 01 00        	mov	dx,1h
2C7F:0214 33 C0           	xor	ax,ax
2C7F:0216 52              	push	dx
2C7F:0217 50              	push	ax
2C7F:0218 FF 36 60 B6     	push	word ptr [0B660h]
2C7F:021C FF 36 5E B6     	push	word ptr [0B65Eh]
2C7F:0220 9A 9D 03 7F 2C  	call	far 2C7Fh:039Dh
2C7F:0225 83 C4 08        	add	sp,8h
2C7F:0228 89 16 E0 83     	mov	[83E0h],dx
2C7F:022C A3 DE 83        	mov	[83DEh],ax
2C7F:022F C4 1E DE 83     	les	bx,[83DEh]
2C7F:0233 8C 06 E4 83     	mov	[83E4h],es
2C7F:0237 89 1E E2 83     	mov	[83E2h],bx
2C7F:023B C7 06 66 B6 00 B8 	mov	word ptr [0B666h],0B800h
2C7F:0241 C7 06 64 B6 00 00 	mov	word ptr [0B664h],0h
2C7F:0247 83 3E CE B6 02  	cmp	word ptr [0B6CEh],2h
2C7F:024C 74 07           	jz	0255h

l2C7F_024E:
2C7F:024E 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
2C7F:0253 75 0C           	jnz	0261h

l2C7F_0255:
2C7F:0255 C7 06 66 B6 00 A0 	mov	word ptr [0B666h],0A000h
2C7F:025B C7 06 64 B6 00 00 	mov	word ptr [0B664h],0h

l2C7F_0261:
2C7F:0261 C4 1E 64 B6     	les	bx,[0B664h]
2C7F:0265 8C 06 3D 7D     	mov	[7D3Dh],es
2C7F:0269 89 1E 3B 7D     	mov	[7D3Bh],bx
2C7F:026D 1E              	push	ds
2C7F:026E B8 AC 00        	mov	ax,0ACh
2C7F:0271 50              	push	ax
2C7F:0272 9A 04 00 2D 2B  	call	far 2B2Dh:0004h
2C7F:0277 59              	pop	cx
2C7F:0278 59              	pop	cx
2C7F:0279 83 3E CE B6 00  	cmp	word ptr [0B6CEh],0h
2C7F:027E 75 16           	jnz	0296h

l2C7F_0280:
2C7F:0280 B8 01 00        	mov	ax,1h
2C7F:0283 50              	push	ax
2C7F:0284 9A 98 4D 00 08  	call	far 0800h:4D98h
2C7F:0289 59              	pop	cx
2C7F:028A 1E              	push	ds
2C7F:028B B8 BC 03        	mov	ax,3BCh
2C7F:028E 50              	push	ax
2C7F:028F 9A F8 34 00 08  	call	far 0800h:34F8h
2C7F:0294 59              	pop	cx
2C7F:0295 59              	pop	cx

l2C7F_0296:
2C7F:0296 9A 14 00 A7 34  	call	far 34A7h:0014h
2C7F:029B C7 06 C8 38 01 00 	mov	word ptr [38C8h],1h
2C7F:02A1 9A A6 36 00 08  	call	far 0800h:36A6h
2C7F:02A6 9A 22 0A 90 33  	call	far 3390h:0A22h
2C7F:02AB 9A F0 23 00 08  	call	far 0800h:23F0h
2C7F:02B0 9A 05 00 FB 31  	call	far 31FBh:0005h
2C7F:02B5 9A 38 00 14 30  	call	far 3014h:0038h
2C7F:02BA C7 06 0A 80 01 00 	mov	word ptr [800Ah],1h
2C7F:02C0 9A D9 02 B2 30  	call	far 30B2h:02D9h
2C7F:02C5 EB 16           	jmp	02DDh

l2C7F_02C7:
2C7F:02C7 1E              	push	ds
2C7F:02C8 B8 41 3C        	mov	ax,3C41h
2C7F:02CB 50              	push	ax
2C7F:02CC 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:02D1 59              	pop	cx
2C7F:02D2 59              	pop	cx
2C7F:02D3 9A 1E 3E 73 0D  	call	far 0D73h:3E1Eh
2C7F:02D8 9A 5C 04 7F 2C  	call	far 2C7Fh:045Ch

l2C7F_02DD:
2C7F:02DD 5F              	pop	di
2C7F:02DE 5E              	pop	si
2C7F:02DF 8B E5           	mov	sp,bp
2C7F:02E1 5D              	pop	bp
2C7F:02E2 CB              	retf

;; ShutdownGame_02E3: 2C7F:02E3
;;   Called from:
;;     0D56:00A2 (in PrintAllocationErrorAndExit)
;;     0D73:4851 (in ShowInvalidSaveVersionDialog_4611)
;;     2C7F:0032 (in main)
;;     3390:0027 (in ShutdownAndExit)
ShutdownGame_02E3 proc
2C7F:02E3 83 3E C8 38 00  	cmp	word ptr [38C8h],0h
2C7F:02E8 74 31           	jz	031Bh

l2C7F_02EA:
2C7F:02EA EB 00           	jmp	02ECh

l2C7F_02EC:
2C7F:02EC 80 3E 15 80 00  	cmp	byte ptr [8015h],0h
2C7F:02F1 75 F9           	jnz	02ECh

l2C7F_02F3:
2C7F:02F3 9A 85 01 14 30  	call	far 3014h:0185h
2C7F:02F8 B8 3C 00        	mov	ax,3Ch
2C7F:02FB 50              	push	ax
2C7F:02FC 9A 0C 00 4A 33  	call	far 334Ah:000Ch
2C7F:0301 59              	pop	cx
2C7F:0302 9A 82 03 B2 30  	call	far 30B2h:0382h
2C7F:0307 9A 43 01 14 30  	call	far 3014h:0143h
2C7F:030C 9A 1E 24 00 08  	call	far 0800h:241Eh
2C7F:0311 9A 8C 09 90 33  	call	far 3390h:098Ch
2C7F:0316 9A FE 37 00 08  	call	far 0800h:37FEh

l2C7F_031B:
2C7F:031B 9A 63 07 37 30  	call	far 3037h:0763h
2C7F:0320 B8 06 00        	mov	ax,6h
2C7F:0323 50              	push	ax
2C7F:0324 9A 50 03 7F 2C  	call	far 2C7Fh:0350h
2C7F:0329 59              	pop	cx
2C7F:032A CB              	retf

;; GetCurrentBIOSVideoMode_032B: 2C7F:032B
;;   Called from:
;;     2C7F:0044 (in InitializeGame_003C)
GetCurrentBIOSVideoMode_032B proc
2C7F:032B C7 06 E4 B5 00 0F 	mov	word ptr [0B5E4h],0F00h
2C7F:0331 1E              	push	ds
2C7F:0332 B8 F4 B5        	mov	ax,0B5F4h
2C7F:0335 50              	push	ax
2C7F:0336 1E              	push	ds
2C7F:0337 B8 E4 B5        	mov	ax,0B5E4h
2C7F:033A 50              	push	ax
2C7F:033B B8 10 00        	mov	ax,10h
2C7F:033E 50              	push	ax
2C7F:033F 9A 0F 00 E5 39  	call	far 39E5h:000Fh
2C7F:0344 83 C4 0A        	add	sp,0Ah
2C7F:0347 A1 F4 B5        	mov	ax,[0B5F4h]
2C7F:034A 25 FF 00        	and	ax,0FFh
2C7F:034D EB 00           	jmp	034Fh

l2C7F_034F:
2C7F:034F CB              	retf

;; SetVideoModeForAdapter_0350: 2C7F:0350
;;   Called from:
;;     0D56:0011 (in PrintAllocationErrorAndExit)
;;     0D73:038D (in RebuildTacticalVideoResources_0387)
;;     2C7F:0050 (in InitializeGame_003C)
;;     2C7F:01E6 (in InitializeGame_003C)
;;     2C7F:0324 (in ShutdownGame_02E3)
SetVideoModeForAdapter_0350 proc
2C7F:0350 55              	push	bp
2C7F:0351 8B EC           	mov	bp,sp
2C7F:0353 56              	push	si
2C7F:0354 8B 76 06        	mov	si,[bp+6h]
2C7F:0357 83 FE 06        	cmp	si,6h
2C7F:035A 7D 14           	jge	0370h

l2C7F_035C:
2C7F:035C 56              	push	si
2C7F:035D 9A E7 4D 00 08  	call	far 0800h:4DE7h
2C7F:0362 59              	pop	cx
2C7F:0363 8B DE           	mov	bx,si
2C7F:0365 D1 E3           	shl	bx,1h
2C7F:0367 8B 87 AA 3C     	mov	ax,[bx+3CAAh]
2C7F:036B A3 E4 B5        	mov	[0B5E4h],ax
2C7F:036E EB 06           	jmp	0376h

l2C7F_0370:
2C7F:0370 A1 C6 38        	mov	ax,[38C6h]
2C7F:0373 A3 E4 B5        	mov	[0B5E4h],ax

l2C7F_0376:
2C7F:0376 8B DE           	mov	bx,si
2C7F:0378 D1 E3           	shl	bx,1h
2C7F:037A 8B 87 AA 3C     	mov	ax,[bx+3CAAh]
2C7F:037E 3B 06 C6 38     	cmp	ax,[38C6h]
2C7F:0382 74 16           	jz	039Ah

l2C7F_0384:
2C7F:0384 1E              	push	ds
2C7F:0385 B8 F4 B5        	mov	ax,0B5F4h
2C7F:0388 50              	push	ax
2C7F:0389 1E              	push	ds
2C7F:038A B8 E4 B5        	mov	ax,0B5E4h
2C7F:038D 50              	push	ax
2C7F:038E B8 10 00        	mov	ax,10h
2C7F:0391 50              	push	ax
2C7F:0392 9A 0F 00 E5 39  	call	far 39E5h:000Fh
2C7F:0397 83 C4 0A        	add	sp,0Ah

l2C7F_039A:
2C7F:039A 5E              	pop	si
2C7F:039B 5D              	pop	bp
2C7F:039C CB              	retf

;; AddBytesToFarPointer: 2C7F:039D
;;   Called from:
;;     0D73:0272 (in InitializeTacticalScenario_0214)
;;     2C7F:0220 (in InitializeGame_003C)
AddBytesToFarPointer proc
2C7F:039D 55              	push	bp
2C7F:039E 8B EC           	mov	bp,sp
2C7F:03A0 83 EC 08        	sub	sp,8h
2C7F:03A3 56              	push	si
2C7F:03A4 57              	push	di
2C7F:03A5 8B 56 08        	mov	dx,[bp+8h]
2C7F:03A8 8B 46 06        	mov	ax,[bp+6h]
2C7F:03AB 89 56 FA        	mov	[bp-6h],dx
2C7F:03AE 89 46 F8        	mov	[bp-8h],ax
2C7F:03B1 8B 76 FA        	mov	si,[bp-6h]
2C7F:03B4 8B 7E F8        	mov	di,[bp-8h]
2C7F:03B7 81 E7 FF FF     	and	di,0FFFFh
2C7F:03BB 8B C6           	mov	ax,si
2C7F:03BD 33 D2           	xor	dx,dx
2C7F:03BF B1 04           	mov	cl,4h
2C7F:03C1 9A E8 54 00 08  	call	far 0800h:54E8h
2C7F:03C6 89 56 FA        	mov	[bp-6h],dx
2C7F:03C9 89 46 F8        	mov	[bp-8h],ax
2C7F:03CC 8B C7           	mov	ax,di
2C7F:03CE 33 D2           	xor	dx,dx
2C7F:03D0 01 46 F8        	add	[bp-8h],ax
2C7F:03D3 11 56 FA        	adc	[bp-6h],dx
2C7F:03D6 8B 56 0C        	mov	dx,[bp+0Ch]
2C7F:03D9 8B 46 0A        	mov	ax,[bp+0Ah]
2C7F:03DC 01 46 F8        	add	[bp-8h],ax
2C7F:03DF 11 56 FA        	adc	[bp-6h],dx
2C7F:03E2 8B 56 FA        	mov	dx,[bp-6h]
2C7F:03E5 8B 46 F8        	mov	ax,[bp-8h]
2C7F:03E8 B1 04           	mov	cl,4h
2C7F:03EA 9A 07 55 00 08  	call	far 0800h:5507h
2C7F:03EF 8B F0           	mov	si,ax
2C7F:03F1 8B 7E F8        	mov	di,[bp-8h]
2C7F:03F4 81 E7 0F 00     	and	di,0Fh
2C7F:03F8 8B C6           	mov	ax,si
2C7F:03FA 33 D2           	xor	dx,dx
2C7F:03FC 8B D0           	mov	dx,ax
2C7F:03FE 33 C0           	xor	ax,ax
2C7F:0400 89 56 FA        	mov	[bp-6h],dx
2C7F:0403 89 46 F8        	mov	[bp-8h],ax
2C7F:0406 8B C7           	mov	ax,di
2C7F:0408 33 D2           	xor	dx,dx
2C7F:040A 01 46 F8        	add	[bp-8h],ax
2C7F:040D 11 56 FA        	adc	[bp-6h],dx
2C7F:0410 C4 5E F8        	les	bx,[bp-8h]
2C7F:0413 8C 46 FE        	mov	[bp-2h],es
2C7F:0416 89 5E FC        	mov	[bp-4h],bx
2C7F:0419 8B 56 FE        	mov	dx,[bp-2h]
2C7F:041C 8B 46 FC        	mov	ax,[bp-4h]
2C7F:041F EB 00           	jmp	0421h

l2C7F_0421:
2C7F:0421 5F              	pop	di
2C7F:0422 5E              	pop	si
2C7F:0423 8B E5           	mov	sp,bp
2C7F:0425 5D              	pop	bp
2C7F:0426 CB              	retf

;; ServiceMusicAndCheckKeyboardInput_0427: 2C7F:0427
;;   Called from:
;;     0D73:3CAA (in WaitForDismissInputOrTimeout_3C97)
;;     0D73:3D46 (in WaitForKeyboardOrMouseInput_3D40)
;;     0D73:3E2B (in FlushPendingInput_3E1E)
;;     1A1F:0674 (in RunTacticalInteractionLoop_0613)
;;     1A1F:06AE (in RunTacticalInteractionLoop_0613)
;;     34E6:03A5 (in PollUiRegionSelection_0003)
;;     34E6:03B7 (in PollUiRegionSelection_0003)
ServiceMusicAndCheckKeyboardInput_0427 proc
2C7F:0427 56              	push	si
2C7F:0428 83 3E 0A 80 00  	cmp	word ptr [800Ah],0h
2C7F:042D 75 05           	jnz	0434h

l2C7F_042F:
2C7F:042F 9A 2E 00 AF 30  	call	far 30AFh:002Eh

l2C7F_0434:
2C7F:0434 8B 36 0C 80     	mov	si,[800Ch]
2C7F:0438 A1 69 AE        	mov	ax,[0AE69h]
2C7F:043B 3B C6           	cmp	ax,si
2C7F:043D 74 14           	jz	0453h

l2C7F_043F:
2C7F:043F 0B F6           	or	si,si
2C7F:0441 75 07           	jnz	044Ah

l2C7F_0443:
2C7F:0443 9A 0E 00 14 30  	call	far 3014h:000Eh
2C7F:0448 EB 05           	jmp	044Fh

l2C7F_044A:
2C7F:044A 9A 1A 00 14 30  	call	far 3014h:001Ah

l2C7F_044F:
2C7F:044F 89 36 69 AE     	mov	[0AE69h],si

l2C7F_0453:
2C7F:0453 9A A0 01 37 30  	call	far 3037h:01A0h
2C7F:0458 EB 00           	jmp	045Ah

l2C7F_045A:
2C7F:045A 5E              	pop	si
2C7F:045B CB              	retf

;; ReadTranslatedKeypress_045C: 2C7F:045C
;;   Called from:
;;     0D56:009D (in PrintAllocationErrorAndExit)
;;     0D73:3CB3 (in WaitForDismissInputOrTimeout_3C97)
;;     0D73:3D4F (in WaitForKeyboardOrMouseInput_3D40)
;;     0D73:3E26 (in FlushPendingInput_3E1E)
;;     1A1F:067D (in RunTacticalInteractionLoop_0613)
;;     1A1F:06A9 (in RunTacticalInteractionLoop_0613)
;;     2C7F:0189 (in InitializeGame_003C)
;;     2C7F:02D8 (in InitializeGame_003C)
;;     2C7F:065B (in LoadMediaConfiguration_047A)
;;     34E6:03C0 (in PollUiRegionSelection_0003)
ReadTranslatedKeypress_045C proc
2C7F:045C 55              	push	bp
2C7F:045D 8B EC           	mov	bp,sp
2C7F:045F 83 EC 02        	sub	sp,2h
2C7F:0462 56              	push	si
2C7F:0463 9A D7 01 37 30  	call	far 3037h:01D7h
2C7F:0468 88 46 FF        	mov	[bp-1h],al
2C7F:046B 8A 46 FF        	mov	al,[bp-1h]
2C7F:046E 98              	cbw
2C7F:046F 8B F0           	mov	si,ax
2C7F:0471 8B C6           	mov	ax,si
2C7F:0473 EB 00           	jmp	0475h

l2C7F_0475:
2C7F:0475 5E              	pop	si
2C7F:0476 8B E5           	mov	sp,bp
2C7F:0478 5D              	pop	bp
2C7F:0479 CB              	retf

;; LoadMediaConfiguration_047A: 2C7F:047A
;;   Called from:
;;     2C7F:0138 (in InitializeGame_003C)
LoadMediaConfiguration_047A proc
2C7F:047A 55              	push	bp
2C7F:047B 8B EC           	mov	bp,sp
2C7F:047D 83 EC 3E        	sub	sp,3Eh
2C7F:0480 56              	push	si
2C7F:0481 57              	push	di
2C7F:0482 BF 01 00        	mov	di,1h
2C7F:0485 B8 01 80        	mov	ax,8001h
2C7F:0488 50              	push	ax
2C7F:0489 FF 36 8C 15     	push	word ptr [158Ch]
2C7F:048D FF 36 8A 15     	push	word ptr [158Ah]
2C7F:0491 9A 37 00 15 39  	call	far 3915h:0037h
2C7F:0496 83 C4 06        	add	sp,6h
2C7F:0499 89 46 C2        	mov	[bp-3Eh],ax
2C7F:049C 83 7E C2 FF     	cmp	word ptr [bp-3Eh],0FFh
2C7F:04A0 75 11           	jnz	04B3h

l2C7F_04A2:
2C7F:04A2 1E              	push	ds
2C7F:04A3 B8 05 3C        	mov	ax,3C05h
2C7F:04A6 50              	push	ax
2C7F:04A7 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:04AC 59              	pop	cx
2C7F:04AD 59              	pop	cx
2C7F:04AE 33 FF           	xor	di,di
2C7F:04B0 E9 8D 01        	jmp	0640h

l2C7F_04B3:
2C7F:04B3 FF 76 C2        	push	word ptr [bp-3Eh]
2C7F:04B6 9A 00 00 C0 39  	call	far 39C0h:0000h
2C7F:04BB 59              	pop	cx
2C7F:04BC 89 56 CE        	mov	[bp-32h],dx
2C7F:04BF 89 46 CC        	mov	[bp-34h],ax
2C7F:04C2 83 7E CE 00     	cmp	word ptr [bp-32h],0h
2C7F:04C6 7C 23           	jl	04EBh

l2C7F_04C8:
2C7F:04C8 7F 07           	jg	04D1h

l2C7F_04CA:
2C7F:04CA 81 7E CC C8 00  	cmp	word ptr [bp-34h],0C8h
2C7F:04CF 76 1A           	jbe	04EBh

l2C7F_04D1:
2C7F:04D1 FF 76 C2        	push	word ptr [bp-3Eh]
2C7F:04D4 9A 0E 00 36 39  	call	far 3936h:000Eh
2C7F:04D9 59              	pop	cx
2C7F:04DA 1E              	push	ds
2C7F:04DB B8 05 3C        	mov	ax,3C05h
2C7F:04DE 50              	push	ax
2C7F:04DF 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:04E4 59              	pop	cx
2C7F:04E5 59              	pop	cx
2C7F:04E6 33 FF           	xor	di,di
2C7F:04E8 E9 55 01        	jmp	0640h

l2C7F_04EB:
2C7F:04EB FF 76 CE        	push	word ptr [bp-32h]
2C7F:04EE FF 76 CC        	push	word ptr [bp-34h]
2C7F:04F1 9A B5 00 56 0D  	call	far 0D56h:00B5h
2C7F:04F6 59              	pop	cx
2C7F:04F7 59              	pop	cx
2C7F:04F8 89 56 FE        	mov	[bp-2h],dx
2C7F:04FB 89 46 FC        	mov	[bp-4h],ax
2C7F:04FE 89 56 FA        	mov	[bp-6h],dx
2C7F:0501 89 46 F8        	mov	[bp-8h],ax
2C7F:0504 8B 46 CC        	mov	ax,[bp-34h]
2C7F:0507 89 46 CA        	mov	[bp-36h],ax
2C7F:050A FF 76 CA        	push	word ptr [bp-36h]
2C7F:050D FF 76 FE        	push	word ptr [bp-2h]
2C7F:0510 FF 76 FC        	push	word ptr [bp-4h]
2C7F:0513 FF 76 C2        	push	word ptr [bp-3Eh]
2C7F:0516 9A 05 00 3C 39  	call	far 393Ch:0005h
2C7F:051B 83 C4 08        	add	sp,8h
2C7F:051E 3B 46 CA        	cmp	ax,[bp-36h]
2C7F:0521 74 1A           	jz	053Dh

l2C7F_0523:
2C7F:0523 FF 76 C2        	push	word ptr [bp-3Eh]
2C7F:0526 9A 0E 00 36 39  	call	far 3936h:000Eh
2C7F:052B 59              	pop	cx
2C7F:052C 1E              	push	ds
2C7F:052D B8 05 3C        	mov	ax,3C05h
2C7F:0530 50              	push	ax
2C7F:0531 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0536 59              	pop	cx
2C7F:0537 59              	pop	cx
2C7F:0538 33 FF           	xor	di,di
2C7F:053A E9 F6 00        	jmp	0633h

l2C7F_053D:
2C7F:053D FF 76 C2        	push	word ptr [bp-3Eh]
2C7F:0540 9A 0E 00 36 39  	call	far 3936h:000Eh
2C7F:0545 59              	pop	cx
2C7F:0546 C7 46 C6 01 00  	mov	word ptr [bp-3Ah],1h
2C7F:054B E9 DC 00        	jmp	062Ah

l2C7F_054E:
2C7F:054E 33 F6           	xor	si,si
2C7F:0550 EB 36           	jmp	0588h

l2C7F_0552:
2C7F:0552 C4 5E FC        	les	bx,[bp-4h]
2C7F:0555 26 8A 07        	mov	al,es:[bx]
2C7F:0558 98              	cbw
2C7F:0559 89 46 C4        	mov	[bp-3Ch],ax
2C7F:055C FF 46 FC        	inc	word ptr [bp-4h]
2C7F:055F 8B 46 CA        	mov	ax,[bp-36h]
2C7F:0562 FF 4E CA        	dec	word ptr [bp-36h]
2C7F:0565 0B C0           	or	ax,ax
2C7F:0567 75 07           	jnz	0570h

l2C7F_0569:
2C7F:0569 C7 46 C6 00 00  	mov	word ptr [bp-3Ah],0h
2C7F:056E EB 17           	jmp	0587h

l2C7F_0570:
2C7F:0570 83 7E C4 0A     	cmp	word ptr [bp-3Ch],0Ah
2C7F:0574 75 0A           	jnz	0580h

l2C7F_0576:
2C7F:0576 36 C6 42 D0 00  	mov	byte ptr ss:[bp+si-30h],0h
2C7F:057B BE 28 00        	mov	si,28h
2C7F:057E EB 07           	jmp	0587h

l2C7F_0580:
2C7F:0580 8A 46 C4        	mov	al,[bp-3Ch]
2C7F:0583 36 88 42 D0     	mov	ss:[bp+si-30h],al

l2C7F_0587:
2C7F:0587 46              	inc	si

l2C7F_0588:
2C7F:0588 83 FE 28        	cmp	si,28h
2C7F:058B 7D 06           	jge	0593h

l2C7F_058D:
2C7F:058D 83 7E C6 00     	cmp	word ptr [bp-3Ah],0h
2C7F:0591 75 BF           	jnz	0552h

l2C7F_0593:
2C7F:0593 83 7E C6 00     	cmp	word ptr [bp-3Ah],0h
2C7F:0597 75 03           	jnz	059Ch

l2C7F_0599:
2C7F:0599 E9 8E 00        	jmp	062Ah

l2C7F_059C:
2C7F:059C 1E              	push	ds
2C7F:059D B8 BC 3C        	mov	ax,3CBCh
2C7F:05A0 50              	push	ax
2C7F:05A1 16              	push	ss
2C7F:05A2 8D 46 D0        	lea	ax,[bp-30h]
2C7F:05A5 50              	push	ax
2C7F:05A6 9A 00 00 F8 39  	call	far 39F8h:0000h
2C7F:05AB 83 C4 08        	add	sp,8h
2C7F:05AE 89 16 E2 B5     	mov	[0B5E2h],dx
2C7F:05B2 A3 E0 B5        	mov	[0B5E0h],ax
2C7F:05B5 FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:05B9 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:05BD 9A 0C 00 04 3A  	call	far 3A04h:000Ch
2C7F:05C2 59              	pop	cx
2C7F:05C3 59              	pop	cx
2C7F:05C4 33 F6           	xor	si,si
2C7F:05C6 C7 46 C8 01 00  	mov	word ptr [bp-38h],1h
2C7F:05CB EB 3C           	jmp	0609h

l2C7F_05CD:
2C7F:05CD FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:05D1 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:05D5 1E              	push	ds
2C7F:05D6 8B C6           	mov	ax,si
2C7F:05D8 B1 04           	mov	cl,4h
2C7F:05DA D3 E0           	shl	ax,cl
2C7F:05DC 05 91 3A        	add	ax,3A91h
2C7F:05DF 50              	push	ax
2C7F:05E0 9A 0E 00 7F 39  	call	far 397Fh:000Eh
2C7F:05E5 83 C4 08        	add	sp,8h
2C7F:05E8 0B C0           	or	ax,ax
2C7F:05EA 75 1C           	jnz	0608h

l2C7F_05EC:
2C7F:05EC 8B DE           	mov	bx,si
2C7F:05EE B1 04           	mov	cl,4h
2C7F:05F0 D3 E3           	shl	bx,cl
2C7F:05F2 81 C3 91 3A     	add	bx,3A91h
2C7F:05F6 1E              	push	ds
2C7F:05F7 07              	pop	es
2C7F:05F8 26 FF 5F 0C     	call	dword ptr es:[bx+0Ch]
2C7F:05FC 8B F8           	mov	di,ax
2C7F:05FE 89 7E C6        	mov	[bp-3Ah],di
2C7F:0601 C7 46 C8 00 00  	mov	word ptr [bp-38h],0h
2C7F:0606 EB 01           	jmp	0609h

l2C7F_0608:
2C7F:0608 46              	inc	si

l2C7F_0609:
2C7F:0609 83 7E C8 00     	cmp	word ptr [bp-38h],0h
2C7F:060D 74 05           	jz	0614h

l2C7F_060F:
2C7F:060F 83 FE 04        	cmp	si,4h
2C7F:0612 7C B9           	jl	05CDh

l2C7F_0614:
2C7F:0614 83 FE 04        	cmp	si,4h
2C7F:0617 75 11           	jnz	062Ah

l2C7F_0619:
2C7F:0619 1E              	push	ds
2C7F:061A B8 05 3C        	mov	ax,3C05h
2C7F:061D 50              	push	ax
2C7F:061E 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:0623 59              	pop	cx
2C7F:0624 59              	pop	cx
2C7F:0625 33 FF           	xor	di,di
2C7F:0627 89 7E C6        	mov	[bp-3Ah],di

l2C7F_062A:
2C7F:062A 83 7E C6 00     	cmp	word ptr [bp-3Ah],0h
2C7F:062E 74 03           	jz	0633h

l2C7F_0630:
2C7F:0630 E9 1B FF        	jmp	054Eh

l2C7F_0633:
2C7F:0633 FF 76 FA        	push	word ptr [bp-6h]
2C7F:0636 FF 76 F8        	push	word ptr [bp-8h]
2C7F:0639 9A 81 01 56 0D  	call	far 0D56h:0181h
2C7F:063E 59              	pop	cx
2C7F:063F 59              	pop	cx

l2C7F_0640:
2C7F:0640 C7 06 5C B6 01 00 	mov	word ptr [0B65Ch],1h
2C7F:0646 C7 06 62 B6 00 00 	mov	word ptr [0B662h],0h
2C7F:064C C7 06 68 B6 01 00 	mov	word ptr [0B668h],1h
2C7F:0652 0B FF           	or	di,di
2C7F:0654 75 09           	jnz	065Fh

l2C7F_0656:
2C7F:0656 9A 1E 3E 73 0D  	call	far 0D73h:3E1Eh
2C7F:065B 0E              	push	cs
2C7F:065C E8 FD FD        	call	045Ch

l2C7F_065F:
2C7F:065F 8B C7           	mov	ax,di
2C7F:0661 EB 00           	jmp	0663h

l2C7F_0663:
2C7F:0663 5F              	pop	di
2C7F:0664 5E              	pop	si
2C7F:0665 8B E5           	mov	sp,bp
2C7F:0667 5D              	pop	bp
2C7F:0668 CB              	retf

;; ApplyVideoConfigOption_0669: 2C7F:0669
;;   Called from:
;;     2C7F:05F7 (in LoadMediaConfiguration_047A)
ApplyVideoConfigOption_0669 proc
2C7F:0669 55              	push	bp
2C7F:066A 8B EC           	mov	bp,sp
2C7F:066C 83 EC 02        	sub	sp,2h
2C7F:066F 56              	push	si
2C7F:0670 57              	push	di
2C7F:0671 BF 01 00        	mov	di,1h
2C7F:0674 1E              	push	ds
2C7F:0675 B8 BE 3C        	mov	ax,3CBEh
2C7F:0678 50              	push	ax
2C7F:0679 33 C0           	xor	ax,ax
2C7F:067B 50              	push	ax
2C7F:067C 50              	push	ax
2C7F:067D 9A 00 00 F8 39  	call	far 39F8h:0000h
2C7F:0682 83 C4 08        	add	sp,8h
2C7F:0685 89 16 E2 B5     	mov	[0B5E2h],dx
2C7F:0689 A3 E0 B5        	mov	[0B5E0h],ax
2C7F:068C FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:0690 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:0694 9A 0C 00 04 3A  	call	far 3A04h:000Ch
2C7F:0699 59              	pop	cx
2C7F:069A 59              	pop	cx
2C7F:069B 33 F6           	xor	si,si
2C7F:069D C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2C7F:06A2 EB 61           	jmp	0705h

l2C7F_06A4:
2C7F:06A4 FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:06A8 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:06AC 1E              	push	ds
2C7F:06AD 8B C6           	mov	ax,si
2C7F:06AF BA 0D 00        	mov	dx,0Dh
2C7F:06B2 F7 E2           	mul	dx
2C7F:06B4 05 D1 3A        	add	ax,3AD1h
2C7F:06B7 50              	push	ax
2C7F:06B8 9A 0E 00 7F 39  	call	far 397Fh:000Eh
2C7F:06BD 83 C4 08        	add	sp,8h
2C7F:06C0 0B C0           	or	ax,ax
2C7F:06C2 75 40           	jnz	0704h

l2C7F_06C4:
2C7F:06C4 8B C6           	mov	ax,si
2C7F:06C6 BA 0D 00        	mov	dx,0Dh
2C7F:06C9 F7 E2           	mul	dx
2C7F:06CB 8B D8           	mov	bx,ax
2C7F:06CD 81 C3 D1 3A     	add	bx,3AD1h
2C7F:06D1 1E              	push	ds
2C7F:06D2 07              	pop	es
2C7F:06D3 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2C7F:06D7 98              	cbw
2C7F:06D8 A3 CE B6        	mov	[0B6CEh],ax
2C7F:06DB C7 06 DC 83 00 00 	mov	word ptr [83DCh],0h
2C7F:06E1 83 3E CE B6 07  	cmp	word ptr [0B6CEh],7h
2C7F:06E6 75 08           	jnz	06F0h

l2C7F_06E8:
2C7F:06E8 C7 06 CE B6 03 00 	mov	word ptr [0B6CEh],3h
2C7F:06EE EB 0D           	jmp	06FDh

l2C7F_06F0:
2C7F:06F0 83 3E CE B6 03  	cmp	word ptr [0B6CEh],3h
2C7F:06F5 75 06           	jnz	06FDh

l2C7F_06F7:
2C7F:06F7 C7 06 DC 83 01 00 	mov	word ptr [83DCh],1h

l2C7F_06FD:
2C7F:06FD C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2C7F:0702 EB 01           	jmp	0705h

l2C7F_0704:
2C7F:0704 46              	inc	si

l2C7F_0705:
2C7F:0705 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2C7F:0709 74 05           	jz	0710h

l2C7F_070B:
2C7F:070B 83 FE 05        	cmp	si,5h
2C7F:070E 7C 94           	jl	06A4h

l2C7F_0710:
2C7F:0710 83 FE 05        	cmp	si,5h
2C7F:0713 75 0E           	jnz	0723h

l2C7F_0715:
2C7F:0715 1E              	push	ds
2C7F:0716 B8 05 3C        	mov	ax,3C05h
2C7F:0719 50              	push	ax
2C7F:071A 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:071F 59              	pop	cx
2C7F:0720 59              	pop	cx
2C7F:0721 33 FF           	xor	di,di

l2C7F_0723:
2C7F:0723 8B C7           	mov	ax,di
2C7F:0725 EB 00           	jmp	0727h

l2C7F_0727:
2C7F:0727 5F              	pop	di
2C7F:0728 5E              	pop	si
2C7F:0729 8B E5           	mov	sp,bp
2C7F:072B 5D              	pop	bp
2C7F:072C CB              	retf

;; ApplyMusicConfigOption_072D: 2C7F:072D
;;   Called from:
;;     2C7F:05F7 (in LoadMediaConfiguration_047A)
ApplyMusicConfigOption_072D proc
2C7F:072D 55              	push	bp
2C7F:072E 8B EC           	mov	bp,sp
2C7F:0730 83 EC 02        	sub	sp,2h
2C7F:0733 56              	push	si
2C7F:0734 57              	push	di
2C7F:0735 BF 01 00        	mov	di,1h
2C7F:0738 1E              	push	ds
2C7F:0739 B8 C2 3C        	mov	ax,3CC2h
2C7F:073C 50              	push	ax
2C7F:073D 33 C0           	xor	ax,ax
2C7F:073F 50              	push	ax
2C7F:0740 50              	push	ax
2C7F:0741 9A 00 00 F8 39  	call	far 39F8h:0000h
2C7F:0746 83 C4 08        	add	sp,8h
2C7F:0749 89 16 E2 B5     	mov	[0B5E2h],dx
2C7F:074D A3 E0 B5        	mov	[0B5E0h],ax
2C7F:0750 FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:0754 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:0758 9A 0C 00 04 3A  	call	far 3A04h:000Ch
2C7F:075D 59              	pop	cx
2C7F:075E 59              	pop	cx
2C7F:075F 33 F6           	xor	si,si
2C7F:0761 C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2C7F:0766 EB 3E           	jmp	07A6h

l2C7F_0768:
2C7F:0768 FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:076C FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:0770 1E              	push	ds
2C7F:0771 8B C6           	mov	ax,si
2C7F:0773 BA 0D 00        	mov	dx,0Dh
2C7F:0776 F7 E2           	mul	dx
2C7F:0778 05 12 3B        	add	ax,3B12h
2C7F:077B 50              	push	ax
2C7F:077C 9A 0E 00 7F 39  	call	far 397Fh:000Eh
2C7F:0781 83 C4 08        	add	sp,8h
2C7F:0784 0B C0           	or	ax,ax
2C7F:0786 75 1D           	jnz	07A5h

l2C7F_0788:
2C7F:0788 8B C6           	mov	ax,si
2C7F:078A BA 0D 00        	mov	dx,0Dh
2C7F:078D F7 E2           	mul	dx
2C7F:078F 8B D8           	mov	bx,ax
2C7F:0791 81 C3 12 3B     	add	bx,3B12h
2C7F:0795 1E              	push	ds
2C7F:0796 07              	pop	es
2C7F:0797 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2C7F:079B A2 AF 85        	mov	[85AFh],al
2C7F:079E C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2C7F:07A3 EB 01           	jmp	07A6h

l2C7F_07A5:
2C7F:07A5 46              	inc	si

l2C7F_07A6:
2C7F:07A6 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2C7F:07AA 74 05           	jz	07B1h

l2C7F_07AC:
2C7F:07AC 83 FE 07        	cmp	si,7h
2C7F:07AF 7C B7           	jl	0768h

l2C7F_07B1:
2C7F:07B1 83 FE 07        	cmp	si,7h
2C7F:07B4 75 0E           	jnz	07C4h

l2C7F_07B6:
2C7F:07B6 1E              	push	ds
2C7F:07B7 B8 05 3C        	mov	ax,3C05h
2C7F:07BA 50              	push	ax
2C7F:07BB 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:07C0 59              	pop	cx
2C7F:07C1 59              	pop	cx
2C7F:07C2 33 FF           	xor	di,di

l2C7F_07C4:
2C7F:07C4 8B C7           	mov	ax,di
2C7F:07C6 EB 00           	jmp	07C8h

l2C7F_07C8:
2C7F:07C8 5F              	pop	di
2C7F:07C9 5E              	pop	si
2C7F:07CA 8B E5           	mov	sp,bp
2C7F:07CC 5D              	pop	bp
2C7F:07CD CB              	retf

;; ApplySoundConfigOption_07CE: 2C7F:07CE
;;   Called from:
;;     2C7F:05F7 (in LoadMediaConfiguration_047A)
ApplySoundConfigOption_07CE proc
2C7F:07CE 55              	push	bp
2C7F:07CF 8B EC           	mov	bp,sp
2C7F:07D1 83 EC 02        	sub	sp,2h
2C7F:07D4 56              	push	si
2C7F:07D5 57              	push	di
2C7F:07D6 BF 01 00        	mov	di,1h
2C7F:07D9 1E              	push	ds
2C7F:07DA B8 C6 3C        	mov	ax,3CC6h
2C7F:07DD 50              	push	ax
2C7F:07DE 33 C0           	xor	ax,ax
2C7F:07E0 50              	push	ax
2C7F:07E1 50              	push	ax
2C7F:07E2 9A 00 00 F8 39  	call	far 39F8h:0000h
2C7F:07E7 83 C4 08        	add	sp,8h
2C7F:07EA 89 16 E2 B5     	mov	[0B5E2h],dx
2C7F:07EE A3 E0 B5        	mov	[0B5E0h],ax
2C7F:07F1 FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:07F5 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:07F9 9A 0C 00 04 3A  	call	far 3A04h:000Ch
2C7F:07FE 59              	pop	cx
2C7F:07FF 59              	pop	cx
2C7F:0800 33 F6           	xor	si,si
2C7F:0802 C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2C7F:0807 E9 95 00        	jmp	089Fh

l2C7F_080A:
2C7F:080A FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:080E FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:0812 1E              	push	ds
2C7F:0813 8B C6           	mov	ax,si
2C7F:0815 BA 0E 00        	mov	dx,0Eh
2C7F:0818 F7 E2           	mul	dx
2C7F:081A 05 87 3B        	add	ax,3B87h
2C7F:081D 50              	push	ax
2C7F:081E 9A 0E 00 7F 39  	call	far 397Fh:000Eh
2C7F:0823 83 C4 08        	add	sp,8h
2C7F:0826 0B C0           	or	ax,ax
2C7F:0828 75 74           	jnz	089Eh

l2C7F_082A:
2C7F:082A 8B C6           	mov	ax,si
2C7F:082C BA 0E 00        	mov	dx,0Eh
2C7F:082F F7 E2           	mul	dx
2C7F:0831 8B D8           	mov	bx,ax
2C7F:0833 81 C3 87 3B     	add	bx,3B87h
2C7F:0837 1E              	push	ds
2C7F:0838 07              	pop	es
2C7F:0839 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2C7F:083D A2 65 86        	mov	[8665h],al
2C7F:0840 8B C6           	mov	ax,si
2C7F:0842 BA 0E 00        	mov	dx,0Eh
2C7F:0845 F7 E2           	mul	dx
2C7F:0847 8B D8           	mov	bx,ax
2C7F:0849 81 C3 87 3B     	add	bx,3B87h
2C7F:084D 1E              	push	ds
2C7F:084E 07              	pop	es
2C7F:084F 26 80 7F 0D 00  	cmp	byte ptr es:[bx+0Dh],0h
2C7F:0854 74 3B           	jz	0891h

l2C7F_0856:
2C7F:0856 1E              	push	ds
2C7F:0857 B8 CA 3C        	mov	ax,3CCAh
2C7F:085A 50              	push	ax
2C7F:085B 33 C0           	xor	ax,ax
2C7F:085D 50              	push	ax
2C7F:085E 50              	push	ax
2C7F:085F 9A 00 00 F8 39  	call	far 39F8h:0000h
2C7F:0864 83 C4 08        	add	sp,8h
2C7F:0867 89 16 E2 B5     	mov	[0B5E2h],dx
2C7F:086B A3 E0 B5        	mov	[0B5E0h],ax
2C7F:086E FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:0872 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:0876 9A 0C 00 04 3A  	call	far 3A04h:000Ch
2C7F:087B 59              	pop	cx
2C7F:087C 59              	pop	cx
2C7F:087D FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:0881 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:0885 9A 6C 09 7F 2C  	call	far 2C7Fh:096Ch
2C7F:088A 59              	pop	cx
2C7F:088B 59              	pop	cx
2C7F:088C A3 72 83        	mov	[8372h],ax
2C7F:088F EB 06           	jmp	0897h

l2C7F_0891:
2C7F:0891 C7 06 72 83 01 00 	mov	word ptr [8372h],1h

l2C7F_0897:
2C7F:0897 C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2C7F:089C EB 01           	jmp	089Fh

l2C7F_089E:
2C7F:089E 46              	inc	si

l2C7F_089F:
2C7F:089F 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2C7F:08A3 74 08           	jz	08ADh

l2C7F_08A5:
2C7F:08A5 83 FE 09        	cmp	si,9h
2C7F:08A8 7D 03           	jge	08ADh

l2C7F_08AA:
2C7F:08AA E9 5D FF        	jmp	080Ah

l2C7F_08AD:
2C7F:08AD 83 FE 09        	cmp	si,9h
2C7F:08B0 75 0E           	jnz	08C0h

l2C7F_08B2:
2C7F:08B2 1E              	push	ds
2C7F:08B3 B8 05 3C        	mov	ax,3C05h
2C7F:08B6 50              	push	ax
2C7F:08B7 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:08BC 59              	pop	cx
2C7F:08BD 59              	pop	cx
2C7F:08BE 33 FF           	xor	di,di

l2C7F_08C0:
2C7F:08C0 8B C7           	mov	ax,di
2C7F:08C2 EB 00           	jmp	08C4h

l2C7F_08C4:
2C7F:08C4 5F              	pop	di
2C7F:08C5 5E              	pop	si
2C7F:08C6 8B E5           	mov	sp,bp
2C7F:08C8 5D              	pop	bp
2C7F:08C9 CB              	retf

;; ApplyInputDeviceConfigOption_08CA: 2C7F:08CA
;;   Called from:
;;     2C7F:05F7 (in LoadMediaConfiguration_047A)
ApplyInputDeviceConfigOption_08CA proc
2C7F:08CA 55              	push	bp
2C7F:08CB 8B EC           	mov	bp,sp
2C7F:08CD 83 EC 02        	sub	sp,2h
2C7F:08D0 56              	push	si
2C7F:08D1 57              	push	di
2C7F:08D2 BF 01 00        	mov	di,1h
2C7F:08D5 1E              	push	ds
2C7F:08D6 B8 CE 3C        	mov	ax,3CCEh
2C7F:08D9 50              	push	ax
2C7F:08DA 33 C0           	xor	ax,ax
2C7F:08DC 50              	push	ax
2C7F:08DD 50              	push	ax
2C7F:08DE 9A 00 00 F8 39  	call	far 39F8h:0000h
2C7F:08E3 83 C4 08        	add	sp,8h
2C7F:08E6 89 16 E2 B5     	mov	[0B5E2h],dx
2C7F:08EA A3 E0 B5        	mov	[0B5E0h],ax
2C7F:08ED FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:08F1 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:08F5 9A 0C 00 04 3A  	call	far 3A04h:000Ch
2C7F:08FA 59              	pop	cx
2C7F:08FB 59              	pop	cx
2C7F:08FC 33 F6           	xor	si,si
2C7F:08FE C7 46 FE 01 00  	mov	word ptr [bp-2h],1h
2C7F:0903 EB 3F           	jmp	0944h

l2C7F_0905:
2C7F:0905 FF 36 E2 B5     	push	word ptr [0B5E2h]
2C7F:0909 FF 36 E0 B5     	push	word ptr [0B5E0h]
2C7F:090D 1E              	push	ds
2C7F:090E 8B C6           	mov	ax,si
2C7F:0910 BA 0D 00        	mov	dx,0Dh
2C7F:0913 F7 E2           	mul	dx
2C7F:0915 05 6D 3B        	add	ax,3B6Dh
2C7F:0918 50              	push	ax
2C7F:0919 9A 0E 00 7F 39  	call	far 397Fh:000Eh
2C7F:091E 83 C4 08        	add	sp,8h
2C7F:0921 0B C0           	or	ax,ax
2C7F:0923 75 1E           	jnz	0943h

l2C7F_0925:
2C7F:0925 8B C6           	mov	ax,si
2C7F:0927 BA 0D 00        	mov	dx,0Dh
2C7F:092A F7 E2           	mul	dx
2C7F:092C 8B D8           	mov	bx,ax
2C7F:092E 81 C3 6D 3B     	add	bx,3B6Dh
2C7F:0932 1E              	push	ds
2C7F:0933 07              	pop	es
2C7F:0934 26 8A 47 0C     	mov	al,es:[bx+0Ch]
2C7F:0938 98              	cbw
2C7F:0939 A3 BD 88        	mov	[88BDh],ax
2C7F:093C C7 46 FE 00 00  	mov	word ptr [bp-2h],0h
2C7F:0941 EB 01           	jmp	0944h

l2C7F_0943:
2C7F:0943 46              	inc	si

l2C7F_0944:
2C7F:0944 83 7E FE 00     	cmp	word ptr [bp-2h],0h
2C7F:0948 74 05           	jz	094Fh

l2C7F_094A:
2C7F:094A 83 FE 02        	cmp	si,2h
2C7F:094D 7C B6           	jl	0905h

l2C7F_094F:
2C7F:094F 83 FE 02        	cmp	si,2h
2C7F:0952 75 0E           	jnz	0962h

l2C7F_0954:
2C7F:0954 1E              	push	ds
2C7F:0955 B8 05 3C        	mov	ax,3C05h
2C7F:0958 50              	push	ax
2C7F:0959 9A 07 00 27 33  	call	far 3327h:0007h
2C7F:095E 59              	pop	cx
2C7F:095F 59              	pop	cx
2C7F:0960 33 FF           	xor	di,di

l2C7F_0962:
2C7F:0962 8B C7           	mov	ax,di
2C7F:0964 EB 00           	jmp	0966h

l2C7F_0966:
2C7F:0966 5F              	pop	di
2C7F:0967 5E              	pop	si
2C7F:0968 8B E5           	mov	sp,bp
2C7F:096A 5D              	pop	bp
2C7F:096B CB              	retf

;; ParseHexValue: 2C7F:096C
;;   Called from:
;;     2C7F:0885 (in ApplySoundConfigOption_07CE)
ParseHexValue proc
2C7F:096C 55              	push	bp
2C7F:096D 8B EC           	mov	bp,sp
2C7F:096F 56              	push	si
2C7F:0970 57              	push	di
2C7F:0971 33 FF           	xor	di,di
2C7F:0973 C4 5E 06        	les	bx,[bp+6h]
2C7F:0976 26 8A 07        	mov	al,es:[bx]
2C7F:0979 98              	cbw
2C7F:097A 8B F0           	mov	si,ax
2C7F:097C FF 46 06        	inc	word ptr [bp+6h]
2C7F:097F EB 38           	jmp	09B9h

l2C7F_0981:
2C7F:0981 83 FE 30        	cmp	si,30h
2C7F:0984 7C 12           	jl	0998h

l2C7F_0986:
2C7F:0986 83 FE 39        	cmp	si,39h
2C7F:0989 7F 0D           	jg	0998h

l2C7F_098B:
2C7F:098B B1 04           	mov	cl,4h
2C7F:098D D3 E7           	shl	di,cl
2C7F:098F 8B C6           	mov	ax,si
2C7F:0991 05 D0 FF        	add	ax,0FFD0h
2C7F:0994 03 F8           	add	di,ax
2C7F:0996 EB 15           	jmp	09ADh

l2C7F_0998:
2C7F:0998 83 FE 41        	cmp	si,41h
2C7F:099B 7C 10           	jl	09ADh

l2C7F_099D:
2C7F:099D 83 FE 46        	cmp	si,46h
2C7F:09A0 7F 0B           	jg	09ADh

l2C7F_09A2:
2C7F:09A2 B1 04           	mov	cl,4h
2C7F:09A4 D3 E7           	shl	di,cl
2C7F:09A6 8B C6           	mov	ax,si
2C7F:09A8 05 C9 FF        	add	ax,0FFC9h
2C7F:09AB 03 F8           	add	di,ax

l2C7F_09AD:
2C7F:09AD C4 5E 06        	les	bx,[bp+6h]
2C7F:09B0 26 8A 07        	mov	al,es:[bx]
2C7F:09B3 98              	cbw
2C7F:09B4 8B F0           	mov	si,ax
2C7F:09B6 FF 46 06        	inc	word ptr [bp+6h]

l2C7F_09B9:
2C7F:09B9 0B F6           	or	si,si
2C7F:09BB 75 C4           	jnz	0981h

l2C7F_09BD:
2C7F:09BD 8B C7           	mov	ax,di
2C7F:09BF EB 00           	jmp	09C1h
