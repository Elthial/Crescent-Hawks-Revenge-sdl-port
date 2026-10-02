;;; Segment 3A3C (3A3C:0000)
3A3C:0000 5E 0A 26 88 47 02 5D CB                         ^.&.G.].        

;; InitializeTimezoneFromEnvironment: 3A3C:0008
;;   Called from:
;;     39CC:0015 (in CaptureLocalClockSnapshot_000F)
;;     3A07:0009 (in ConvertLocalDateTimeToEpochSeconds_0001)
InitializeTimezoneFromEnvironment proc
3A3C:0008 55              	push	bp
3A3C:0009 8B EC           	mov	bp,sp
3A3C:000B 83 EC 04        	sub	sp,4h
3A3C:000E 56              	push	si
3A3C:000F 1E              	push	ds
3A3C:0010 B8 96 71        	mov	ax,7196h
3A3C:0013 50              	push	ax
3A3C:0014 9A 09 00 DC 39  	call	far 39DCh:0009h
3A3C:0019 59              	pop	cx
3A3C:001A 59              	pop	cx
3A3C:001B 89 56 FE        	mov	[bp-2h],dx
3A3C:001E 89 46 FC        	mov	[bp-4h],ax
3A3C:0021 0B D0           	or	dx,ax
3A3C:0023 75 03           	jnz	0028h

l3A3C_0025:
3A3C:0025 E9 8E 00        	jmp	00B6h

l3A3C_0028:
3A3C:0028 FF 76 FE        	push	word ptr [bp-2h]
3A3C:002B FF 76 FC        	push	word ptr [bp-4h]
3A3C:002E 9A 03 00 7E 39  	call	far 397Eh:0003h
3A3C:0033 59              	pop	cx
3A3C:0034 59              	pop	cx
3A3C:0035 3D 04 00        	cmp	ax,4h
3A3C:0038 73 03           	jnc	003Dh

l3A3C_003A:
3A3C:003A EB 7A           	jmp	00B6h
3A3C:003C                                     90                      .   

l3A3C_003D:
3A3C:003D C4 5E FC        	les	bx,[bp-4h]
3A3C:0040 26 8A 07        	mov	al,es:[bx]
3A3C:0043 98              	cbw
3A3C:0044 8B D8           	mov	bx,ax
3A3C:0046 F6 87 29 70 0C  	test	byte ptr [bx+7029h],0Ch
3A3C:004B 74 69           	jz	00B6h

l3A3C_004D:
3A3C:004D C4 5E FC        	les	bx,[bp-4h]
3A3C:0050 26 8A 47 01     	mov	al,es:[bx+1h]
3A3C:0054 98              	cbw
3A3C:0055 8B D8           	mov	bx,ax
3A3C:0057 F6 87 29 70 0C  	test	byte ptr [bx+7029h],0Ch
3A3C:005C 74 58           	jz	00B6h

l3A3C_005E:
3A3C:005E C4 5E FC        	les	bx,[bp-4h]
3A3C:0061 26 8A 47 02     	mov	al,es:[bx+2h]
3A3C:0065 98              	cbw
3A3C:0066 8B D8           	mov	bx,ax
3A3C:0068 F6 87 29 70 0C  	test	byte ptr [bx+7029h],0Ch
3A3C:006D 74 47           	jz	00B6h

l3A3C_006F:
3A3C:006F C4 5E FC        	les	bx,[bp-4h]
3A3C:0072 26 80 7F 03 2D  	cmp	byte ptr es:[bx+3h],2Dh
3A3C:0077 74 1B           	jz	0094h

l3A3C_0079:
3A3C:0079 C4 5E FC        	les	bx,[bp-4h]
3A3C:007C 26 80 7F 03 2B  	cmp	byte ptr es:[bx+3h],2Bh
3A3C:0081 74 11           	jz	0094h

l3A3C_0083:
3A3C:0083 C4 5E FC        	les	bx,[bp-4h]
3A3C:0086 26 8A 47 03     	mov	al,es:[bx+3h]
3A3C:008A 98              	cbw
3A3C:008B 8B D8           	mov	bx,ax
3A3C:008D F6 87 29 70 02  	test	byte ptr [bx+7029h],2h
3A3C:0092 74 22           	jz	00B6h

l3A3C_0094:
3A3C:0094 C4 5E FC        	les	bx,[bp-4h]
3A3C:0097 26 8A 47 03     	mov	al,es:[bx+3h]
3A3C:009B 98              	cbw
3A3C:009C 8B D8           	mov	bx,ax
3A3C:009E F6 87 29 70 02  	test	byte ptr [bx+7029h],2h
3A3C:00A3 75 50           	jnz	00F5h

l3A3C_00A5:
3A3C:00A5 C4 5E FC        	les	bx,[bp-4h]
3A3C:00A8 26 8A 47 04     	mov	al,es:[bx+4h]
3A3C:00AC 98              	cbw
3A3C:00AD 8B D8           	mov	bx,ax
3A3C:00AF F6 87 29 70 02  	test	byte ptr [bx+7029h],2h
3A3C:00B4 75 3F           	jnz	00F5h

l3A3C_00B6:
3A3C:00B6 C7 06 94 71 01 00 	mov	word ptr [7194h],1h
3A3C:00BC C7 06 92 71 00 00 	mov	word ptr [7192h],0h
3A3C:00C2 C7 06 90 71 50 46 	mov	word ptr [7190h],4650h
3A3C:00C8 1E              	push	ds
3A3C:00C9 B8 99 71        	mov	ax,7199h
3A3C:00CC 50              	push	ax
3A3C:00CD FF 36 8A 71     	push	word ptr [718Ah]
3A3C:00D1 FF 36 88 71     	push	word ptr [7188h]
3A3C:00D5 9A 00 00 83 39  	call	far 3983h:0000h
3A3C:00DA 83 C4 08        	add	sp,8h
3A3C:00DD 1E              	push	ds
3A3C:00DE B8 9D 71        	mov	ax,719Dh
3A3C:00E1 50              	push	ax
3A3C:00E2 FF 36 8E 71     	push	word ptr [718Eh]
3A3C:00E6 FF 36 8C 71     	push	word ptr [718Ch]
3A3C:00EA 9A 00 00 83 39  	call	far 3983h:0000h
3A3C:00EF 83 C4 08        	add	sp,8h
3A3C:00F2 E9 F3 00        	jmp	01E8h

l3A3C_00F5:
3A3C:00F5 B8 04 00        	mov	ax,4h
3A3C:00F8 50              	push	ax
3A3C:00F9 33 C0           	xor	ax,ax
3A3C:00FB 50              	push	ax
3A3C:00FC FF 36 8E 71     	push	word ptr [718Eh]
3A3C:0100 FF 36 8C 71     	push	word ptr [718Ch]
3A3C:0104 9A 2F 00 85 39  	call	far 3985h:002Fh
3A3C:0109 83 C4 08        	add	sp,8h
3A3C:010C B8 03 00        	mov	ax,3h
3A3C:010F 50              	push	ax
3A3C:0110 FF 76 FE        	push	word ptr [bp-2h]
3A3C:0113 FF 76 FC        	push	word ptr [bp-4h]
3A3C:0116 FF 36 8A 71     	push	word ptr [718Ah]
3A3C:011A FF 36 88 71     	push	word ptr [7188h]
3A3C:011E 9A 0D 00 F4 39  	call	far 39F4h:000Dh
3A3C:0123 83 C4 0A        	add	sp,0Ah
3A3C:0126 C4 1E 88 71     	les	bx,[7188h]
3A3C:012A 26 C6 47 03 00  	mov	byte ptr es:[bx+3h],0h
3A3C:012F 8B 56 FE        	mov	dx,[bp-2h]
3A3C:0132 8B 46 FC        	mov	ax,[bp-4h]
3A3C:0135 05 03 00        	add	ax,3h
3A3C:0138 52              	push	dx
3A3C:0139 50              	push	ax
3A3C:013A 9A 05 00 C4 39  	call	far 39C4h:0005h
3A3C:013F 59              	pop	cx
3A3C:0140 59              	pop	cx
3A3C:0141 33 C9           	xor	cx,cx
3A3C:0143 BB 10 0E        	mov	bx,0E10h
3A3C:0146 9A 2C 54 00 08  	call	far 0800h:542Ch
3A3C:014B 89 16 92 71     	mov	[7192h],dx
3A3C:014F A3 90 71        	mov	[7190h],ax
3A3C:0152 C7 06 94 71 00 00 	mov	word ptr [7194h],0h
3A3C:0158 BE 03 00        	mov	si,3h
3A3C:015B EB 7F           	jmp	01DCh
3A3C:015D                                        90                    .  

l3A3C_015E:
3A3C:015E C4 5E FC        	les	bx,[bp-4h]
3A3C:0161 26 8A 00        	mov	al,es:[bx+si]
3A3C:0164 98              	cbw
3A3C:0165 8B D8           	mov	bx,ax
3A3C:0167 F6 87 29 70 0C  	test	byte ptr [bx+7029h],0Ch
3A3C:016C 74 6D           	jz	01DBh

l3A3C_016E:
3A3C:016E 8B 56 FE        	mov	dx,[bp-2h]
3A3C:0171 8B 46 FC        	mov	ax,[bp-4h]
3A3C:0174 03 C6           	add	ax,si
3A3C:0176 52              	push	dx
3A3C:0177 50              	push	ax
3A3C:0178 9A 03 00 7E 39  	call	far 397Eh:0003h
3A3C:017D 59              	pop	cx
3A3C:017E 59              	pop	cx
3A3C:017F 3D 03 00        	cmp	ax,3h
3A3C:0182 72 26           	jc	01AAh

l3A3C_0184:
3A3C:0184 C4 5E FC        	les	bx,[bp-4h]
3A3C:0187 03 DE           	add	bx,si
3A3C:0189 26 8A 47 01     	mov	al,es:[bx+1h]
3A3C:018D 98              	cbw
3A3C:018E 8B D8           	mov	bx,ax
3A3C:0190 F6 87 29 70 0C  	test	byte ptr [bx+7029h],0Ch
3A3C:0195 74 13           	jz	01AAh

l3A3C_0197:
3A3C:0197 C4 5E FC        	les	bx,[bp-4h]
3A3C:019A 03 DE           	add	bx,si
3A3C:019C 26 8A 47 02     	mov	al,es:[bx+2h]
3A3C:01A0 98              	cbw
3A3C:01A1 8B D8           	mov	bx,ax
3A3C:01A3 F6 87 29 70 0C  	test	byte ptr [bx+7029h],0Ch
3A3C:01A8 75 02           	jnz	01ACh

l3A3C_01AA:
3A3C:01AA EB 3C           	jmp	01E8h

l3A3C_01AC:
3A3C:01AC B8 03 00        	mov	ax,3h
3A3C:01AF 50              	push	ax
3A3C:01B0 8B 56 FE        	mov	dx,[bp-2h]
3A3C:01B3 8B 46 FC        	mov	ax,[bp-4h]
3A3C:01B6 03 C6           	add	ax,si
3A3C:01B8 52              	push	dx
3A3C:01B9 50              	push	ax
3A3C:01BA FF 36 8E 71     	push	word ptr [718Eh]
3A3C:01BE FF 36 8C 71     	push	word ptr [718Ch]
3A3C:01C2 9A 0D 00 F4 39  	call	far 39F4h:000Dh
3A3C:01C7 83 C4 0A        	add	sp,0Ah
3A3C:01CA C4 1E 8C 71     	les	bx,[718Ch]
3A3C:01CE 26 C6 47 03 00  	mov	byte ptr es:[bx+3h],0h
3A3C:01D3 C7 06 94 71 01 00 	mov	word ptr [7194h],1h
3A3C:01D9 EB 0D           	jmp	01E8h

l3A3C_01DB:
3A3C:01DB 46              	inc	si

l3A3C_01DC:
3A3C:01DC C4 5E FC        	les	bx,[bp-4h]
3A3C:01DF 26 80 38 00     	cmp	byte ptr es:[bx+si],0h
3A3C:01E3 74 03           	jz	01E8h

l3A3C_01E5:
3A3C:01E5 E9 76 FF        	jmp	015Eh

l3A3C_01E8:
3A3C:01E8 5E              	pop	si
3A3C:01E9 8B E5           	mov	sp,bp
3A3C:01EB 5D              	pop	bp
3A3C:01EC CB              	retf

;; IsDaylightSavingTime_01ED: 3A3C:01ED
;;   Called from:
;;     39CC:008F (in CaptureLocalClockSnapshot_000F)
;;     3A07:00D9 (in ConvertLocalDateTimeToEpochSeconds_0001)
IsDaylightSavingTime_01ED proc
3A3C:01ED 55              	push	bp
3A3C:01EE 8B EC           	mov	bp,sp
3A3C:01F0 56              	push	si
3A3C:01F1 57              	push	di
3A3C:01F2 8B 76 08        	mov	si,[bp+8h]
3A3C:01F5 0B F6           	or	si,si
3A3C:01F7 75 28           	jnz	0221h

l3A3C_01F9:
3A3C:01F9 8B 7E 0A        	mov	di,[bp+0Ah]
3A3C:01FC 83 7E 0A 3B     	cmp	word ptr [bp+0Ah],3Bh
3A3C:0200 72 0C           	jc	020Eh

l3A3C_0202:
3A3C:0202 8B 46 06        	mov	ax,[bp+6h]
3A3C:0205 05 46 00        	add	ax,46h
3A3C:0208 A9 03 00        	test	ax,3h
3A3C:020B 75 01           	jnz	020Eh

l3A3C_020D:
3A3C:020D 4F              	dec	di

l3A3C_020E:
3A3C:020E 33 F6           	xor	si,si
3A3C:0210 EB 01           	jmp	0213h

l3A3C_0212:
3A3C:0212 46              	inc	si

l3A3C_0213:
3A3C:0213 8B DE           	mov	bx,si
3A3C:0215 D1 E3           	shl	bx,1h
3A3C:0217 8B 87 6E 71     	mov	ax,[bx+716Eh]
3A3C:021B 3B C7           	cmp	ax,di
3A3C:021D 76 F3           	jbe	0212h

l3A3C_021F:
3A3C:021F EB 1F           	jmp	0240h

l3A3C_0221:
3A3C:0221 83 FE 03        	cmp	si,3h
3A3C:0224 72 0B           	jc	0231h

l3A3C_0226:
3A3C:0226 8B 46 06        	mov	ax,[bp+6h]
3A3C:0229 05 46 00        	add	ax,46h
3A3C:022C A9 03 00        	test	ax,3h
3A3C:022F 74 03           	jz	0234h

l3A3C_0231:
3A3C:0231 FF 4E 0A        	dec	word ptr [bp+0Ah]

l3A3C_0234:
3A3C:0234 8B DE           	mov	bx,si
3A3C:0236 4B              	dec	bx
3A3C:0237 D1 E3           	shl	bx,1h
3A3C:0239 8B 87 6E 71     	mov	ax,[bx+716Eh]
3A3C:023D 01 46 0A        	add	[bp+0Ah],ax

l3A3C_0240:
3A3C:0240 83 FE 04        	cmp	si,4h
3A3C:0243 72 78           	jc	02BDh

l3A3C_0245:
3A3C:0245 74 07           	jz	024Eh

l3A3C_0247:
3A3C:0247 83 FE 0A        	cmp	si,0Ah
3A3C:024A 77 71           	ja	02BDh

l3A3C_024C:
3A3C:024C 75 6A           	jnz	02B8h

l3A3C_024E:
3A3C:024E 8B DE           	mov	bx,si
3A3C:0250 D1 E3           	shl	bx,1h
3A3C:0252 83 7E 06 10     	cmp	word ptr [bp+6h],10h
3A3C:0256 7E 0F           	jle	0267h

l3A3C_0258:
3A3C:0258 83 FE 04        	cmp	si,4h
3A3C:025B 75 0A           	jnz	0267h

l3A3C_025D:
3A3C:025D 8B 8F 6C 71     	mov	cx,[bx+716Ch]
3A3C:0261 83 C1 07        	add	cx,7h
3A3C:0264 EB 05           	jmp	026Bh
3A3C:0266                   90                                  .         

l3A3C_0267:
3A3C:0267 8B 8F 6E 71     	mov	cx,[bx+716Eh]

l3A3C_026B:
3A3C:026B 8B 5E 06        	mov	bx,[bp+6h]
3A3C:026E 81 C3 B2 07     	add	bx,7B2h
3A3C:0272 F6 C3 03        	test	bl,3h
3A3C:0275 74 01           	jz	0278h

l3A3C_0277:
3A3C:0277 49              	dec	cx

l3A3C_0278:
3A3C:0278 8B 5E 06        	mov	bx,[bp+6h]
3A3C:027B 43              	inc	bx
3A3C:027C D1 FB           	sar	bx,1h
3A3C:027E D1 FB           	sar	bx,1h
3A3C:0280 03 D9           	add	bx,cx
3A3C:0282 B8 6D 01        	mov	ax,16Dh
3A3C:0285 F7 66 06        	mul	word ptr [bp+6h]
3A3C:0288 03 C3           	add	ax,bx
3A3C:028A 05 04 00        	add	ax,4h
3A3C:028D 33 D2           	xor	dx,dx
3A3C:028F BB 07 00        	mov	bx,7h
3A3C:0292 F7 F3           	div	bx
3A3C:0294 2B CA           	sub	cx,dx
3A3C:0296 8B 46 0A        	mov	ax,[bp+0Ah]
3A3C:0299 83 FE 04        	cmp	si,4h
3A3C:029C 75 0E           	jnz	02ACh

l3A3C_029E:
3A3C:029E 3B C1           	cmp	ax,cx
3A3C:02A0 77 16           	ja	02B8h

l3A3C_02A2:
3A3C:02A2 75 19           	jnz	02BDh

l3A3C_02A4:
3A3C:02A4 80 7E 0C 02     	cmp	byte ptr [bp+0Ch],2h
3A3C:02A8 72 13           	jc	02BDh

l3A3C_02AA:
3A3C:02AA EB 0C           	jmp	02B8h

l3A3C_02AC:
3A3C:02AC 3B C1           	cmp	ax,cx
3A3C:02AE 72 08           	jc	02B8h

l3A3C_02B0:
3A3C:02B0 75 0B           	jnz	02BDh

l3A3C_02B2:
3A3C:02B2 80 7E 0C 01     	cmp	byte ptr [bp+0Ch],1h
3A3C:02B6 77 05           	ja	02BDh

l3A3C_02B8:
3A3C:02B8 B8 01 00        	mov	ax,1h
3A3C:02BB EB 04           	jmp	02C1h

l3A3C_02BD:
3A3C:02BD 33 C0           	xor	ax,ax
3A3C:02BF EB 00           	jmp	02C1h
