;;; Segment 373D (373D:0000)
373D:0000 8B E5 5D CB                                     ..].            
3717:0264             00 00 00 00 00 00 00 00                 ........    

;; BeginPCSpeakerTimedOutput_000C: 373D:000C
;;   Called from:
;;     3717:0085 (in PlayPCSpeakerBitstream_007E)
;;     3717:00D5 (in FindPCSpeakerDelayScale_00A8)
;;     3717:0142 (in PCSpeakerCalibrationExceedsTolerance_0116)
BeginPCSpeakerTimedOutput_000C proc
373D:000C 8B DC           	mov	bx,sp
373D:000E 36 8B 57 04     	mov	dx,ss:[bx+4h]
373D:0012 8A F2           	mov	dh,dl
373D:0014 FE CE           	dec	dh
373D:0016 75 02           	jnz	001Ah

l373D_0018:
373D:0018 FE C6           	inc	dh

l373D_001A:
373D:001A 8A E6           	mov	ah,dh
373D:001C FE CC           	dec	ah
373D:001E 75 02           	jnz	0022h

l373D_0020:
373D:0020 FE C4           	inc	ah

l373D_0022:
373D:0022 FA              	cli
373D:0023 E4 61           	in	al,61h
373D:0025 2E A3 08 00     	mov	cs:[0008h],ax
373D:0029 2E 89 16 06 00  	mov	cs:[0006h],dx
373D:002E 24 FC           	and	al,0FCh
373D:0030 E6 61           	out	61h,al
373D:0032 8A D8           	mov	bl,al
373D:0034 34 02           	xor	al,2h
373D:0036 8A F8           	mov	bh,al
373D:0038 2E 89 1E 0A 00  	mov	cs:[000Ah],bx
373D:003D B0 00           	mov	al,0h
373D:003F E6 43           	out	43h,al
373D:0041 E4 40           	in	al,40h
373D:0043 8A E0           	mov	ah,al
373D:0045 E4 40           	in	al,40h
373D:0047 86 E0           	xchg	al,ah
373D:0049 2E A3 04 00     	mov	cs:[0004h],ax
373D:004D CB              	retf

;; WritePCSpeakerBitstream_004E: 373D:004E
;;   Called from:
;;     3717:0096 (in PlayPCSpeakerBitstream_007E)
;;     3717:00E6 (in FindPCSpeakerDelayScale_00A8)
;;     3717:0153 (in PCSpeakerCalibrationExceedsTolerance_0116)
WritePCSpeakerBitstream_004E proc
373D:004E 55              	push	bp
373D:004F 8B EC           	mov	bp,sp
373D:0051 1E              	push	ds
373D:0052 57              	push	di
373D:0053 56              	push	si
373D:0054 C5 76 06        	lds	si,[bp+6h]
373D:0057 8B 7E 0A        	mov	di,[bp+0Ah]
373D:005A D1 EF           	shr	di,1h
373D:005C 2E A1 08 00     	mov	ax,cs:[0008h]
373D:0060 2E 8B 1E 0A 00  	mov	bx,cs:[000Ah]
373D:0065 33 C9           	xor	cx,cx
373D:0067 2E 8B 16 06 00  	mov	dx,cs:[0006h]

l373D_006C:
373D:006C 8B 2C           	mov	bp,[si]
373D:006E 46              	inc	si
373D:006F 46              	inc	si
373D:0070 8A CC           	mov	cl,ah

l373D_0072:
373D:0072 E2 FE           	loop	0072h

l373D_0074:
373D:0074 D1 DD           	rcr	bp,1h
373D:0076 73 6B           	jnc	00E3h

l373D_0078:
373D:0078 8A C7           	mov	al,bh
373D:007A E6 61           	out	61h,al

l373D_007C:
373D:007C 8A CA           	mov	cl,dl

l373D_007E:
373D:007E E2 FE           	loop	007Eh

l373D_0080:
373D:0080 D1 DD           	rcr	bp,1h
373D:0082 72 6B           	jc	00EFh

l373D_0084:
373D:0084 8A C3           	mov	al,bl
373D:0086 E6 61           	out	61h,al

l373D_0088:
373D:0088 8A CA           	mov	cl,dl

l373D_008A:
373D:008A E2 FE           	loop	008Ah

l373D_008C:
373D:008C D1 DD           	rcr	bp,1h
373D:008E 73 6B           	jnc	00FBh

l373D_0090:
373D:0090 8A C7           	mov	al,bh
373D:0092 E6 61           	out	61h,al

l373D_0094:
373D:0094 8A CA           	mov	cl,dl

l373D_0096:
373D:0096 E2 FE           	loop	0096h

l373D_0098:
373D:0098 D1 DD           	rcr	bp,1h
373D:009A 72 6B           	jc	0107h

l373D_009C:
373D:009C 8A C3           	mov	al,bl
373D:009E E6 61           	out	61h,al

l373D_00A0:
373D:00A0 8A CA           	mov	cl,dl

l373D_00A2:
373D:00A2 E2 FE           	loop	00A2h

l373D_00A4:
373D:00A4 D1 DD           	rcr	bp,1h
373D:00A6 73 6B           	jnc	0113h

l373D_00A8:
373D:00A8 8A C7           	mov	al,bh
373D:00AA E6 61           	out	61h,al

l373D_00AC:
373D:00AC 8A CA           	mov	cl,dl

l373D_00AE:
373D:00AE E2 FE           	loop	00AEh

l373D_00B0:
373D:00B0 D1 DD           	rcr	bp,1h
373D:00B2 72 6B           	jc	011Fh

l373D_00B4:
373D:00B4 8A C3           	mov	al,bl
373D:00B6 E6 61           	out	61h,al

l373D_00B8:
373D:00B8 8A CA           	mov	cl,dl

l373D_00BA:
373D:00BA E2 FE           	loop	00BAh

l373D_00BC:
373D:00BC D1 DD           	rcr	bp,1h
373D:00BE 73 6B           	jnc	012Bh

l373D_00C0:
373D:00C0 8A C7           	mov	al,bh
373D:00C2 E6 61           	out	61h,al

l373D_00C4:
373D:00C4 8A CA           	mov	cl,dl

l373D_00C6:
373D:00C6 E2 FE           	loop	00C6h

l373D_00C8:
373D:00C8 D1 DD           	rcr	bp,1h
373D:00CA 72 6B           	jc	0137h

l373D_00CC:
373D:00CC 8A C3           	mov	al,bl
373D:00CE E6 61           	out	61h,al
373D:00D0 E9 CD 00        	jmp	01A0h

l373D_00D3:
373D:00D3 8B 2C           	mov	bp,[si]
373D:00D5 46              	inc	si
373D:00D6 46              	inc	si
373D:00D7 8A CC           	mov	cl,ah

l373D_00D9:
373D:00D9 E2 FE           	loop	00D9h

l373D_00DB:
373D:00DB D1 DD           	rcr	bp,1h
373D:00DD 72 9D           	jc	007Ch

l373D_00DF:
373D:00DF 8A C3           	mov	al,bl
373D:00E1 E6 61           	out	61h,al

l373D_00E3:
373D:00E3 8A CA           	mov	cl,dl

l373D_00E5:
373D:00E5 E2 FE           	loop	00E5h

l373D_00E7:
373D:00E7 D1 DD           	rcr	bp,1h
373D:00E9 73 9D           	jnc	0088h

l373D_00EB:
373D:00EB 8A C7           	mov	al,bh
373D:00ED E6 61           	out	61h,al

l373D_00EF:
373D:00EF 8A CA           	mov	cl,dl

l373D_00F1:
373D:00F1 E2 FE           	loop	00F1h

l373D_00F3:
373D:00F3 D1 DD           	rcr	bp,1h
373D:00F5 72 9D           	jc	0094h

l373D_00F7:
373D:00F7 8A C3           	mov	al,bl
373D:00F9 E6 61           	out	61h,al

l373D_00FB:
373D:00FB 8A CA           	mov	cl,dl

l373D_00FD:
373D:00FD E2 FE           	loop	00FDh

l373D_00FF:
373D:00FF D1 DD           	rcr	bp,1h
373D:0101 73 9D           	jnc	00A0h

l373D_0103:
373D:0103 8A C7           	mov	al,bh
373D:0105 E6 61           	out	61h,al

l373D_0107:
373D:0107 8A CA           	mov	cl,dl

l373D_0109:
373D:0109 E2 FE           	loop	0109h

l373D_010B:
373D:010B D1 DD           	rcr	bp,1h
373D:010D 72 9D           	jc	00ACh

l373D_010F:
373D:010F 8A C3           	mov	al,bl
373D:0111 E6 61           	out	61h,al

l373D_0113:
373D:0113 8A CA           	mov	cl,dl

l373D_0115:
373D:0115 E2 FE           	loop	0115h

l373D_0117:
373D:0117 D1 DD           	rcr	bp,1h
373D:0119 73 9D           	jnc	00B8h

l373D_011B:
373D:011B 8A C7           	mov	al,bh
373D:011D E6 61           	out	61h,al

l373D_011F:
373D:011F 8A CA           	mov	cl,dl

l373D_0121:
373D:0121 E2 FE           	loop	0121h

l373D_0123:
373D:0123 D1 DD           	rcr	bp,1h
373D:0125 72 9D           	jc	00C4h

l373D_0127:
373D:0127 8A C3           	mov	al,bl
373D:0129 E6 61           	out	61h,al

l373D_012B:
373D:012B 8A CA           	mov	cl,dl

l373D_012D:
373D:012D E2 FE           	loop	012Dh

l373D_012F:
373D:012F D1 DD           	rcr	bp,1h
373D:0131 73 6D           	jnc	01A0h

l373D_0133:
373D:0133 8A C7           	mov	al,bh
373D:0135 E6 61           	out	61h,al

l373D_0137:
373D:0137 4F              	dec	di
373D:0138 75 03           	jnz	013Dh

l373D_013A:
373D:013A E9 C9 00        	jmp	0206h

l373D_013D:
373D:013D 8A CE           	mov	cl,dh

l373D_013F:
373D:013F E2 FE           	loop	013Fh

l373D_0141:
373D:0141 D1 DD           	rcr	bp,1h
373D:0143 72 6A           	jc	01AFh

l373D_0145:
373D:0145 8A C3           	mov	al,bl
373D:0147 E6 61           	out	61h,al

l373D_0149:
373D:0149 8A CA           	mov	cl,dl

l373D_014B:
373D:014B E2 FE           	loop	014Bh

l373D_014D:
373D:014D D1 DD           	rcr	bp,1h
373D:014F 73 6A           	jnc	01BBh

l373D_0151:
373D:0151 8A C7           	mov	al,bh
373D:0153 E6 61           	out	61h,al

l373D_0155:
373D:0155 8A CA           	mov	cl,dl

l373D_0157:
373D:0157 E2 FE           	loop	0157h

l373D_0159:
373D:0159 D1 DD           	rcr	bp,1h
373D:015B 72 6A           	jc	01C7h

l373D_015D:
373D:015D 8A C3           	mov	al,bl
373D:015F E6 61           	out	61h,al

l373D_0161:
373D:0161 8A CA           	mov	cl,dl

l373D_0163:
373D:0163 E2 FE           	loop	0163h

l373D_0165:
373D:0165 D1 DD           	rcr	bp,1h
373D:0167 73 6A           	jnc	01D3h

l373D_0169:
373D:0169 8A C7           	mov	al,bh
373D:016B E6 61           	out	61h,al

l373D_016D:
373D:016D 8A CA           	mov	cl,dl

l373D_016F:
373D:016F E2 FE           	loop	016Fh

l373D_0171:
373D:0171 D1 DD           	rcr	bp,1h
373D:0173 72 6A           	jc	01DFh

l373D_0175:
373D:0175 8A C3           	mov	al,bl
373D:0177 E6 61           	out	61h,al

l373D_0179:
373D:0179 8A CA           	mov	cl,dl

l373D_017B:
373D:017B E2 FE           	loop	017Bh

l373D_017D:
373D:017D D1 DD           	rcr	bp,1h
373D:017F 73 6A           	jnc	01EBh

l373D_0181:
373D:0181 8A C7           	mov	al,bh
373D:0183 E6 61           	out	61h,al

l373D_0185:
373D:0185 8A CA           	mov	cl,dl

l373D_0187:
373D:0187 E2 FE           	loop	0187h

l373D_0189:
373D:0189 D1 DD           	rcr	bp,1h
373D:018B 72 6A           	jc	01F7h

l373D_018D:
373D:018D 8A C3           	mov	al,bl
373D:018F E6 61           	out	61h,al

l373D_0191:
373D:0191 8A CA           	mov	cl,dl

l373D_0193:
373D:0193 E2 FE           	loop	0193h

l373D_0195:
373D:0195 D1 DD           	rcr	bp,1h
373D:0197 73 6A           	jnc	0203h

l373D_0199:
373D:0199 8A C7           	mov	al,bh
373D:019B E6 61           	out	61h,al

l373D_019D:
373D:019D E9 33 FF        	jmp	00D3h

l373D_01A0:
373D:01A0 4F              	dec	di
373D:01A1 74 63           	jz	0206h

l373D_01A3:
373D:01A3 8A CE           	mov	cl,dh

l373D_01A5:
373D:01A5 E2 FE           	loop	01A5h

l373D_01A7:
373D:01A7 D1 DD           	rcr	bp,1h
373D:01A9 73 9E           	jnc	0149h

l373D_01AB:
373D:01AB 8A C7           	mov	al,bh
373D:01AD E6 61           	out	61h,al

l373D_01AF:
373D:01AF 8A CA           	mov	cl,dl

l373D_01B1:
373D:01B1 E2 FE           	loop	01B1h

l373D_01B3:
373D:01B3 D1 DD           	rcr	bp,1h
373D:01B5 72 9E           	jc	0155h

l373D_01B7:
373D:01B7 8A C3           	mov	al,bl
373D:01B9 E6 61           	out	61h,al

l373D_01BB:
373D:01BB 8A CA           	mov	cl,dl

l373D_01BD:
373D:01BD E2 FE           	loop	01BDh

l373D_01BF:
373D:01BF D1 DD           	rcr	bp,1h
373D:01C1 73 9E           	jnc	0161h

l373D_01C3:
373D:01C3 8A C7           	mov	al,bh
373D:01C5 E6 61           	out	61h,al

l373D_01C7:
373D:01C7 8A CA           	mov	cl,dl

l373D_01C9:
373D:01C9 E2 FE           	loop	01C9h

l373D_01CB:
373D:01CB D1 DD           	rcr	bp,1h
373D:01CD 72 9E           	jc	016Dh

l373D_01CF:
373D:01CF 8A C3           	mov	al,bl
373D:01D1 E6 61           	out	61h,al

l373D_01D3:
373D:01D3 8A CA           	mov	cl,dl

l373D_01D5:
373D:01D5 E2 FE           	loop	01D5h

l373D_01D7:
373D:01D7 D1 DD           	rcr	bp,1h
373D:01D9 73 9E           	jnc	0179h

l373D_01DB:
373D:01DB 8A C7           	mov	al,bh
373D:01DD E6 61           	out	61h,al

l373D_01DF:
373D:01DF 8A CA           	mov	cl,dl

l373D_01E1:
373D:01E1 E2 FE           	loop	01E1h

l373D_01E3:
373D:01E3 D1 DD           	rcr	bp,1h
373D:01E5 72 9E           	jc	0185h

l373D_01E7:
373D:01E7 8A C3           	mov	al,bl
373D:01E9 E6 61           	out	61h,al

l373D_01EB:
373D:01EB 8A CA           	mov	cl,dl

l373D_01ED:
373D:01ED E2 FE           	loop	01EDh

l373D_01EF:
373D:01EF D1 DD           	rcr	bp,1h
373D:01F1 73 9E           	jnc	0191h

l373D_01F3:
373D:01F3 8A C7           	mov	al,bh
373D:01F5 E6 61           	out	61h,al

l373D_01F7:
373D:01F7 8A CA           	mov	cl,dl

l373D_01F9:
373D:01F9 E2 FE           	loop	01F9h

l373D_01FB:
373D:01FB D1 DD           	rcr	bp,1h
373D:01FD 72 9E           	jc	019Dh

l373D_01FF:
373D:01FF 8A C3           	mov	al,bl
373D:0201 E6 61           	out	61h,al

l373D_0203:
373D:0203 E9 66 FE        	jmp	006Ch

l373D_0206:
373D:0206 5E              	pop	si
373D:0207 5F              	pop	di
373D:0208 1F              	pop	ds
373D:0209 5D              	pop	bp
373D:020A CB              	retf

;; EndPCSpeakerTimedOutput_020B: 373D:020B
;;   Called from:
;;     3717:009E (in PlayPCSpeakerBitstream_007E)
;;     3717:00EE (in FindPCSpeakerDelayScale_00A8)
;;     3717:015B (in PCSpeakerCalibrationExceedsTolerance_0116)
EndPCSpeakerTimedOutput_020B proc
373D:020B 2E A1 08 00     	mov	ax,cs:[0008h]
373D:020F E6 61           	out	61h,al
373D:0211 B0 00           	mov	al,0h
373D:0213 E6 43           	out	43h,al
373D:0215 E4 40           	in	al,40h
373D:0217 8A E0           	mov	ah,al
373D:0219 E4 40           	in	al,40h
373D:021B 86 E0           	xchg	al,ah
373D:021D 2E 2B 06 04 00  	sub	ax,cs:[0004h]
