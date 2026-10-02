;;; Segment 3968 (3968:0000)
3968:0000 04 00 C3 38 99 EB 00                            ...8...         

l3965_0037:
3965:0037 5D              	pop	bp
3965:0038 CB              	retf

;; FormatLongInteger: 3968:0009
;;   Called from:
;;     3968:00B2 (in IntegerToString)
;;     3968:00FD (in LongToString)
FormatLongInteger proc
3968:0009 55              	push	bp
3968:000A 8B EC           	mov	bp,sp
3968:000C 83 EC 22        	sub	sp,22h
3968:000F 56              	push	si
3968:0010 57              	push	di
3968:0011 06              	push	es
3968:0012 C4 7E 0C        	les	di,[bp+0Ch]
3968:0015 8B 5E 0A        	mov	bx,[bp+0Ah]
3968:0018 83 FB 24        	cmp	bx,24h
3968:001B 77 5C           	ja	0079h

l3968_001D:
3968:001D 80 FB 02        	cmp	bl,2h
3968:0020 72 57           	jc	0079h

l3968_0022:
3968:0022 8B 46 10        	mov	ax,[bp+10h]
3968:0025 8B 4E 12        	mov	cx,[bp+12h]
3968:0028 0B C9           	or	cx,cx
3968:002A 7D 12           	jge	003Eh

l3968_002C:
3968:002C 80 7E 08 00     	cmp	byte ptr [bp+8h],0h
3968:0030 74 0C           	jz	003Eh

l3968_0032:
3968:0032 26 C6 05 2D     	mov	byte ptr es:[di],2Dh
3968:0036 47              	inc	di
3968:0037 F7 D9           	neg	cx
3968:0039 F7 D8           	neg	ax
3968:003B 83 D9 00        	sbb	cx,0h

l3968_003E:
3968:003E 8D 76 DE        	lea	si,[bp-22h]
3968:0041 E3 10           	jcxz	0053h

l3968_0043:
3968:0043 91              	xchg	cx,ax
3968:0044 2B D2           	sub	dx,dx
3968:0046 F7 F3           	div	bx
3968:0048 91              	xchg	cx,ax
3968:0049 F7 F3           	div	bx
3968:004B 36 88 14        	mov	ss:[si],dl
3968:004E 46              	inc	si
3968:004F E3 0A           	jcxz	005Bh

l3968_0051:
3968:0051 EB F0           	jmp	0043h

l3968_0053:
3968:0053 2B D2           	sub	dx,dx
3968:0055 F7 F3           	div	bx
3968:0057 36 88 14        	mov	ss:[si],dl
3968:005A 46              	inc	si

l3968_005B:
3968:005B 0B C0           	or	ax,ax
3968:005D 75 F4           	jnz	0053h

l3968_005F:
3968:005F 8D 4E DE        	lea	cx,[bp-22h]
3968:0062 F7 D9           	neg	cx
3968:0064 03 CE           	add	cx,si
3968:0066 FC              	cld

l3968_0067:
3968:0067 4E              	dec	si
3968:0068 36 8A 04        	mov	al,ss:[si]
3968:006B 2C 0A           	sub	al,0Ah
3968:006D 73 04           	jnc	0073h

l3968_006F:
3968:006F 04 3A           	add	al,3Ah
3968:0071 EB 03           	jmp	0076h

l3968_0073:
3968:0073 02 46 06        	add	al,[bp+6h]

l3968_0076:
3968:0076 AA              	stosb
3968:0077 E2 EE           	loop	0067h

l3968_0079:
3968:0079 B0 00           	mov	al,0h
3968:007B AA              	stosb
3968:007C 07              	pop	es
3968:007D 8B 56 0E        	mov	dx,[bp+0Eh]
3968:0080 8B 46 0C        	mov	ax,[bp+0Ch]
3968:0083 EB 00           	jmp	0085h

l3968_0085:
3968:0085 5F              	pop	di
3968:0086 5E              	pop	si
3968:0087 8B E5           	mov	sp,bp
3968:0089 5D              	pop	bp
3968:008A CA 0E 00        	retf	0Eh

;; IntegerToString: 3968:008D
;;   Called from:
;;     0D73:3825 (in DisplayMissionDate_376C)
;;     0D73:3974 (in DisplayMissionDate_376C)
;;     2007:1638 (in DrawCampaignClock_15FF)
;;     2007:168A (in DrawCampaignClock_15FF)
;;     2007:1DB2 (in FormatUnitDurabilityPercentage_1D61)
;;     2507:4C4A (in DrawUnitStatusScreen_483A)
;;     2B34:0A51 (in DrawTacticalUnitControlPanel_04C2)
;;     2C7F:0086 (in InitializeGame_003C)
;;     2C7F:00B2 (in InitializeGame_003C)
IntegerToString proc
3968:008D 55              	push	bp
3968:008E 8B EC           	mov	bp,sp
3968:0090 83 7E 0C 0A     	cmp	word ptr [bp+0Ch],0Ah
3968:0094 75 06           	jnz	009Ch

l3968_0096:
3968:0096 8B 46 06        	mov	ax,[bp+6h]
3968:0099 99              	cwd
3968:009A EB 05           	jmp	00A1h

l3968_009C:
3968:009C 8B 46 06        	mov	ax,[bp+6h]
3968:009F 33 D2           	xor	dx,dx

l3968_00A1:
3968:00A1 52              	push	dx
3968:00A2 50              	push	ax
3968:00A3 FF 76 0A        	push	word ptr [bp+0Ah]
3968:00A6 FF 76 08        	push	word ptr [bp+8h]
3968:00A9 FF 76 0C        	push	word ptr [bp+0Ch]
3968:00AC B0 01           	mov	al,1h
3968:00AE 50              	push	ax
3968:00AF B0 61           	mov	al,61h
3968:00B1 50              	push	ax
3968:00B2 0E              	push	cs
3968:00B3 E8 53 FF        	call	0009h
3968:00B6 EB 00           	jmp	00B8h

l3968_00B8:
3968:00B8 5D              	pop	bp
3968:00B9 CB              	retf
3968:00BA                               55 8B EC FF 76 08           U...v.
3968:00C0 FF 76 06 FF 76 0C FF 76 0A FF 76 0E B0 00 50 B0 .v..v..v..v...P.
3968:00D0 61 50 0E E8 33 FF EB 00 5D CB                   aP..3...].      

;; LongToString: 3968:00DA
;;   Called from:
;;     0D56:0041 (in PrintAllocationErrorAndExit)
;;     0D56:007D (in PrintAllocationErrorAndExit)
LongToString proc
3968:00DA 55              	push	bp
3968:00DB 8B EC           	mov	bp,sp
3968:00DD FF 76 08        	push	word ptr [bp+8h]
3968:00E0 FF 76 06        	push	word ptr [bp+6h]
3968:00E3 FF 76 0C        	push	word ptr [bp+0Ch]
3968:00E6 FF 76 0A        	push	word ptr [bp+0Ah]
3968:00E9 FF 76 0E        	push	word ptr [bp+0Eh]
3968:00EC 83 7E 0E 0A     	cmp	word ptr [bp+0Eh],0Ah
3968:00F0 75 05           	jnz	00F7h

l3968_00F2:
3968:00F2 B8 01 00        	mov	ax,1h
3968:00F5 EB 02           	jmp	00F9h

l3968_00F7:
3968:00F7 33 C0           	xor	ax,ax

l3968_00F9:
3968:00F9 50              	push	ax
3968:00FA B0 61           	mov	al,61h
3968:00FC 50              	push	ax
3968:00FD 0E              	push	cs
3968:00FE E8 08 FF        	call	0009h
