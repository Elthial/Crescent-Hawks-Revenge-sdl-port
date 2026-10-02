;;; Segment 0800 (0800:0000)
0800:0000 BA 6A 3A 2E 89 16 C7 01 B4 30 CD 21 8B 2E 02 00 .j:......0.!....
0800:0010 8B 1E 2C 00 8E DA A3 7D 00 8C 06 7B 00 89 1E 77 ..,....}...{...w
0800:0020 00 89 2E 91 00 C7 06 81 00 FF FF E8 01 01 C4 3E ...............>
0800:0030 75 00 8B C7 8B D8 B9 FF 7F 26 81 3D 38 37 75 19 u........&.=87u.
0800:0040 26 8B 55 02 80 FA 3D 75 10 80 E6 DF FF 06 81 00 &.U...=u........
0800:0050 80 FE 59 75 04 FF 06 81 00 F2 AE E3 3C 43 26 38 ..Yu........<C&8
0800:0060 05 75 D6 80 CD 80 F7 D9 89 0E 75 00 B9 02 00 D3 .u........u.....
0800:0070 E3 83 C3 10 83 E3 F0 89 1E 79 00 8C D2 2B EA 8B .........y...+..
0800:0080 3E 16 70 81 FF 00 02 73 07 BF 00 02 89 3E 16 70 >.p....s.....>.p
0800:0090 B1 04 D3 EF 47 3B EF 73 03 E9 13 01 8B DF 03 DA ....G;.s........
0800:00A0 89 1E 89 00 89 1E 8D 00 A1 7B 00 2B D8 8E C0 B4 .........{.+....
0800:00B0 4A 57 CD 21 5F D3 E7 FA 8E D2 8B E7 FB 33 C0 2E JW.!_........3..
0800:00C0 8E 06 C7 01 BF FC 80 B9 9A B8 2B CF F3 AA 0E FF ..........+.....
0800:00D0 16 A2 71 9A 6E 52 00 08 9A 6C 53 00 08 B4 00 CD ..q.nR...lS.....
0800:00E0 1A 89 16 83 00 89 0E 85 00 0E FF 16 A6 71 FF 36 .............q.6
0800:00F0 73 00 FF 36 71 00 FF 36 6F 00 FF 36 6D 00 FF 36 s..6q..6o..6m..6
0800:0100 6B 00 9A 0F 00 7F 2C 50 9A 10 00 C6 38          k.....,P....8   

;; TerminateProcess: 0800:010D
;;   Called from:
;;     38C6:003B (in RunExitHandlersAndTerminate_0010)
TerminateProcess proc
0800:010D 2E 8E 1E C7 01  	mov	ds,cs:[01C7h]
0800:0112 9A 72 01 00 08  	call	far 0800h:0172h
0800:0117 0E              	push	cs
0800:0118 FF 16 A4 71     	call	word ptr [71A4h]
0800:011C 8B EC           	mov	bp,sp
0800:011E B4 4C           	mov	ah,4Ch
0800:0120 8A 46 04        	mov	al,[bp+4h]
0800:0123 CD 21           	int	21h
0800:0125                B9 0E 00 90 BA 2F 00 E9 87 00 1E      ...../.....
0800:0130 B8 00 35 CD 21 89 1E 5B 00 8C 06 5D 00 B8 04 35 ..5.!..[...]...5
0800:0140 CD 21 89 1E 5F 00 8C 06 61 00 B8 05 35 CD 21 89 .!.._...a...5.!.
0800:0150 1E 63 00 8C 06 65 00 B8 06 35 CD 21 89 1E 67 00 .c...e...5.!..g.
0800:0160 8C 06 69 00 B8 00 25 8C CA 8E DA BA 25 01 CD 21 ..i...%.....%..!
0800:0170 1F C3                                           ..              

;; InstallExceptionHandlers_0172: 0800:0172
;;   Called from:
;;     0800:0112 (in TerminateProcess)
InstallExceptionHandlers_0172 proc
0800:0172 1E              	push	ds
0800:0173 B8 00 25        	mov	ax,2500h
0800:0176 C5 16 5B 00     	lds	dx,[005Bh]
0800:017A CD 21           	int	21h
0800:017C 1F              	pop	ds
0800:017D 1E              	push	ds
0800:017E B8 04 25        	mov	ax,2504h
0800:0181 C5 16 5F 00     	lds	dx,[005Fh]
0800:0185 CD 21           	int	21h
0800:0187 1F              	pop	ds
0800:0188 1E              	push	ds
0800:0189 B8 05 25        	mov	ax,2505h
0800:018C C5 16 63 00     	lds	dx,[0063h]
0800:0190 CD 21           	int	21h
0800:0192 1F              	pop	ds
0800:0193 1E              	push	ds
0800:0194 B8 06 25        	mov	ax,2506h
0800:0197 C5 16 67 00     	lds	dx,[0067h]
0800:019B CD 21           	int	21h
0800:019D 1F              	pop	ds
0800:019E CB              	retf
0800:019F                                              C7                .
0800:01A0 06 81 00 00 00 CB CB B4 40 BB 02 00 CD 21 C3 B9 ........@....!..
0800:01B0 1E 00 90 BA 3D 00 2E 8E 1E C7 01 E8 E9 FF B8 03 ....=...........
0800:01C0 00 50 9A 0D 01 00 08 00 00                      .P.......       
l0800_01C9	db	0x00
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
db	0x00
db	0x00
0800:04C9                            77 77 77 77 77 77 77          wwwwwww
0800:04D0 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 wwwwwwwwwwwwwwww
0800:04E0 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 wwwwwwwwwwwwwwww
0800:04F0 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 wwwwwwwwwwwwwwww
0800:0500 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 wwwwwwwwwwwwwwww
0800:0510 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 wwwwwwwwwwwwwwww
0800:0520 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 wwwwwwwwwwwwwwww
0800:0530 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 wwwwwwwwwwwwwwww
0800:0540 77 77 77 77 77 77 77 77 77 EE EE EE EE EE EE EE wwwwwwwww.......
0800:0550 EE EE EE EE EE EE EE EE EE EE EE EE EE EE EE EE ................
0800:0560 EE EE EE EE EE EE EE EE EE 33 33 33 33 33 33 33 .........3333333
0800:0570 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 3333333333333333
0800:0580 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 3333333333333333
0800:0590 AA AA AA AA AA AA 00 00 00 00 00 00 00 00 00 00 ................
0800:05A0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...
0800:05C0 00 00 00 00 00 00 00 00 00                      .........       
l0800_05C9	dw	0x0000
l0800_05CB	dw	0x0000
l0800_05CD	dw	0x0000
l0800_05CF	dw	0x0000
l0800_05D1	dw	0x0000

;; BuildTacticalTerrainCellMaps_05D3: 0800:05D3
;;   Called from:
;;     2007:0670 (in RebuildTacticalViewport_0650)
BuildTacticalTerrainCellMaps_05D3 proc
0800:05D3 55              	push	bp
0800:05D4 8B EC           	mov	bp,sp
0800:05D6 57              	push	di
0800:05D7 56              	push	si
0800:05D8 1E              	push	ds
0800:05D9 B8 84 41        	mov	ax,4184h
0800:05DC 8E D8           	mov	ds,ax
0800:05DE 8B 76 06        	mov	si,[bp+6h]
0800:05E1 8B DE           	mov	bx,si
0800:05E3 81 C3 00 A0     	add	bx,0A000h
0800:05E7 8B 4E 08        	mov	cx,[bp+8h]
0800:05EA 8B 7E 0A        	mov	di,[bp+0Ah]
0800:05ED 8B 56 0C        	mov	dx,[bp+0Ch]
0800:05F0 06              	push	es
0800:05F1 52              	push	dx
0800:05F2 07              	pop	es
0800:05F3 8B 46 0E        	mov	ax,[bp+0Eh]
0800:05F6 03 F0           	add	si,ax
0800:05F8 8B D0           	mov	dx,ax
0800:05FA D1 E8           	shr	ax,1h
0800:05FC D1 E8           	shr	ax,1h
0800:05FE 03 D8           	add	bx,ax
0800:0600 B0 C0           	mov	al,0C0h
0800:0602 83 E2 03        	and	dx,3h
0800:0605 74 07           	jz	060Eh

l0800_0607:
0800:0607 D0 E8           	shr	al,1h
0800:0609 D0 E8           	shr	al,1h
0800:060B 4A              	dec	dx
0800:060C 75 F9           	jnz	0607h

l0800_060E:
0800:060E 2E A3 C9 05     	mov	cs:[05C9h],ax
0800:0612 8B 46 10        	mov	ax,[bp+10h]
0800:0615 8B 16 01 09     	mov	dx,[0901h]
0800:0619 F6 E2           	mul	dl
0800:061B 03 F0           	add	si,ax
0800:061D 8B 16 01 09     	mov	dx,[0901h]
0800:0621 83 C2 03        	add	dx,3h
0800:0624 81 E2 FC 01     	and	dx,1FCh
0800:0628 D1 EA           	shr	dx,1h
0800:062A D1 EA           	shr	dx,1h
0800:062C 2E 89 16 CF 05  	mov	cs:[05CFh],dx
0800:0631 8B 46 10        	mov	ax,[bp+10h]
0800:0634 F6 E2           	mul	dl
0800:0636 03 D8           	add	bx,ax
0800:0638 51              	push	cx
0800:0639 B2 0C           	mov	dl,0Ch
0800:063B B8 13 00        	mov	ax,13h
0800:063E F6 E2           	mul	dl
0800:0640 8B C8           	mov	cx,ax
0800:0642 33 C0           	xor	ax,ax
0800:0644 FC              	cld

l0800_0645:
0800:0645 F3 AB           	rep stosw

l0800_0647:
0800:0647 BA 0C 00        	mov	dx,0Ch
0800:064A 2E 89 16 CB 05  	mov	cs:[05CBh],dx
0800:064F 2E 89 1E CD 05  	mov	cs:[05CDh],bx
0800:0654 8B 2E 01 09     	mov	bp,[0901h]
0800:0658 83 ED 13        	sub	bp,13h
0800:065B 2E 89 2E D1 05  	mov	cs:[05D1h],bp
0800:0660 1F              	pop	ds

l0800_0661:
0800:0661 B9 13 00        	mov	cx,13h
0800:0664 2E 8B 16 C9 05  	mov	dx,cs:[05C9h]

l0800_0669:
0800:0669 AC              	lodsb
0800:066A AB              	stosw
0800:066B 84 17           	test	[bx],dl
0800:066D 74 32           	jz	06A1h

l0800_066F:
0800:066F 8A 37           	mov	dh,[bx]
0800:0671 22 F2           	and	dh,dl
0800:0673 F6 C2 03        	test	dl,3h
0800:0676 75 16           	jnz	068Eh

l0800_0678:
0800:0678 D0 EE           	shr	dh,1h
0800:067A D0 EE           	shr	dh,1h
0800:067C F6 C2 0C        	test	dl,0Ch
0800:067F 75 0D           	jnz	068Eh

l0800_0681:
0800:0681 D0 EE           	shr	dh,1h
0800:0683 D0 EE           	shr	dh,1h
0800:0685 F6 C2 30        	test	dl,30h
0800:0688 75 04           	jnz	068Eh

l0800_068A:
0800:068A D0 EE           	shr	dh,1h
0800:068C D0 EE           	shr	dh,1h

l0800_068E:
0800:068E FE CE           	dec	dh
0800:0690 8A E6           	mov	ah,dh
0800:0692 8B E8           	mov	bp,ax
0800:0694 2E 8A 86 C9 01  	mov	al,cs:[bp+1C9h]
0800:0699 B4 02           	mov	ah,2h
0800:069B 26 89 45 FE     	mov	es:[di-2h],ax
0800:069F 32 E4           	xor	ah,ah

l0800_06A1:
0800:06A1 D0 EA           	shr	dl,1h
0800:06A3 D0 EA           	shr	dl,1h
0800:06A5 74 23           	jz	06CAh

l0800_06A7:
0800:06A7 E2 C0           	loop	0669h

l0800_06A9:
0800:06A9 2E 03 36 D1 05  	add	si,cs:[05D1h]
0800:06AE 2E 8B 1E CD 05  	mov	bx,cs:[05CDh]
0800:06B3 2E 03 1E CF 05  	add	bx,cs:[05CFh]
0800:06B8 2E 89 1E CD 05  	mov	cs:[05CDh],bx
0800:06BD 2E FF 0E CB 05  	dec	word ptr cs:[05CBh]
0800:06C2 75 9D           	jnz	0661h

l0800_06C4:
0800:06C4 07              	pop	es
0800:06C5 1F              	pop	ds
0800:06C6 5E              	pop	si
0800:06C7 5F              	pop	di
0800:06C8 5D              	pop	bp
0800:06C9 CB              	retf

l0800_06CA:
0800:06CA B2 C0           	mov	dl,0C0h
0800:06CC 43              	inc	bx
0800:06CD E2 9A           	loop	0669h

l0800_06CF:
0800:06CF EB D8           	jmp	06A9h

;; DetermineRelativeAttackDirection_06D1: 0800:06D1
;;   Called from:
;;     1A1F:1B06 (in AdvanceScenarioAreaEffects_1A83)
;;     2007:1A2F (in AdvanceTacticalProjectiles_17DE)
;;     2D1B:042D (in MoveUnitTowardMapCell_03EA)
;;     2D1B:079B (in MoveUnitTowardMapCell_03EA)
;;     2D1B:118F (in AdvanceUnitTacticalMovement_0F1F)
;;     2D1B:13DD (in AdvanceUnitTacticalMovement_0F1F)
;;     2D1B:1653 (in ExecuteUnitWeaponAI_14A4)
;;     2D1B:1EFB (in ApplyWeaponDamage_1E2B)
DetermineRelativeAttackDirection_06D1 proc
0800:06D1 55              	push	bp
0800:06D2 8B EC           	mov	bp,sp
0800:06D4 57              	push	di
0800:06D5 56              	push	si
0800:06D6 1E              	push	ds
0800:06D7 B8 84 41        	mov	ax,4184h
0800:06DA 8E D8           	mov	ds,ax
0800:06DC 8B 46 06        	mov	ax,[bp+6h]
0800:06DF 8B 5E 08        	mov	bx,[bp+8h]
0800:06E2 8B 4E 0A        	mov	cx,[bp+0Ah]
0800:06E5 8B 56 0C        	mov	dx,[bp+0Ch]
0800:06E8 BE 00 00        	mov	si,0h
0800:06EB 2B DA           	sub	bx,dx
0800:06ED 8B FB           	mov	di,bx
0800:06EF 79 02           	jns	06F3h

l0800_06F1:
0800:06F1 F7 DF           	neg	di

l0800_06F3:
0800:06F3 2B C8           	sub	cx,ax
0800:06F5 8B C1           	mov	ax,cx
0800:06F7 79 02           	jns	06FBh

l0800_06F9:
0800:06F9 F7 D8           	neg	ax

l0800_06FB:
0800:06FB 8B D3           	mov	dx,bx
0800:06FD D1 E2           	shl	dx,1h
0800:06FF 3B D0           	cmp	dx,ax
0800:0701 7C 03           	jl	0706h

l0800_0703:
0800:0703 83 CE 08        	or	si,8h

l0800_0706:
0800:0706 F7 DA           	neg	dx
0800:0708 3B D0           	cmp	dx,ax
0800:070A 7C 03           	jl	070Fh

l0800_070C:
0800:070C 83 CE 04        	or	si,4h

l0800_070F:
0800:070F 8B D1           	mov	dx,cx
0800:0711 D1 E2           	shl	dx,1h
0800:0713 3B D7           	cmp	dx,di
0800:0715 7C 03           	jl	071Ah

l0800_0717:
0800:0717 83 CE 02        	or	si,2h

l0800_071A:
0800:071A F7 DA           	neg	dx
0800:071C 3B D7           	cmp	dx,di
0800:071E 7C 01           	jl	0721h

l0800_0720:
0800:0720 46              	inc	si

l0800_0721:
0800:0721 33 C0           	xor	ax,ax
0800:0723 8A 84 D7 08     	mov	al,[si+8D7h]
0800:0727 1F              	pop	ds
0800:0728 5E              	pop	si
0800:0729 5F              	pop	di
0800:072A 5D              	pop	bp
0800:072B CB              	retf

;; CalculateSelectedWeaponRating_072C: 0800:072C
;;   Called from:
;;     2D1B:0259 (in RecalculateUnitCombatRatings_0005)
;;     2D1B:028A (in RecalculateUnitCombatRatings_0005)
;;     2D1B:02BB (in RecalculateUnitCombatRatings_0005)
;;     2D1B:02F0 (in RecalculateUnitCombatRatings_0005)
;;     2D1B:0321 (in RecalculateUnitCombatRatings_0005)
;;     2D1B:0356 (in RecalculateUnitCombatRatings_0005)
CalculateSelectedWeaponRating_072C proc
0800:072C 55              	push	bp
0800:072D 8B EC           	mov	bp,sp
0800:072F 57              	push	di
0800:0730 56              	push	si
0800:0731 1E              	push	ds
0800:0732 B8 84 41        	mov	ax,4184h
0800:0735 8E D8           	mov	ds,ax
0800:0737 8B 5E 06        	mov	bx,[bp+6h]
0800:073A 8B 56 08        	mov	dx,[bp+8h]
0800:073D 8B 7E 0A        	mov	di,[bp+0Ah]
0800:0740 8B 46 0C        	mov	ax,[bp+0Ch]
0800:0743 06              	push	es
0800:0744 8E C0           	mov	es,ax
0800:0746 8B EA           	mov	bp,dx
0800:0748 BE BC 08        	mov	si,8BCh
0800:074B C7 06 50 09 00 00 	mov	word ptr [0950h],0h
0800:0751 C7 06 52 09 00 00 	mov	word ptr [0952h],0h
0800:0757 B9 17 00        	mov	cx,17h

l0800_075A:
0800:075A 0B DD           	or	bx,bp
0800:075C 74 1F           	jz	077Dh

l0800_075E:
0800:075E D1 ED           	shr	bp,1h
0800:0760 D1 DB           	rcr	bx,1h
0800:0762 73 13           	jnc	0777h

l0800_0764:
0800:0764 8A 04           	mov	al,[si]
0800:0766 32 E4           	xor	ah,ah
0800:0768 26 8A 15        	mov	dl,es:[di]
0800:076B F6 E2           	mul	dl
0800:076D 01 06 50 09     	add	[0950h],ax
0800:0771 73 04           	jnc	0777h

l0800_0773:
0800:0773 FF 06 52 09     	inc	word ptr [0952h]

l0800_0777:
0800:0777 46              	inc	si
0800:0778 83 C7 02        	add	di,2h
0800:077B E2 DD           	loop	075Ah

l0800_077D:
0800:077D 07              	pop	es
0800:077E A1 50 09        	mov	ax,[0950h]
0800:0781 8B 16 52 09     	mov	dx,[0952h]
0800:0785 1F              	pop	ds
0800:0786 5E              	pop	si
0800:0787 5F              	pop	di
0800:0788 5D              	pop	bp
0800:0789 CB              	retf
0800:078A                               00 00                       ..    

;; TraceMapLineOfSight_078C: 0800:078C
;;   Called from:
;;     2D1B:18C2 (in ResolveWeaponAttack_1854)
;;     2D1B:1DE9 (in HasUnitLineOfSight_1DA6)
;;     2D1B:2AE8 (in HasTacticalReferencePointLineOfSightToUnit_2AA6)
TraceMapLineOfSight_078C proc
0800:078C 55              	push	bp
0800:078D 8B EC           	mov	bp,sp
0800:078F 57              	push	di
0800:0790 56              	push	si
0800:0791 1E              	push	ds
0800:0792 B8 84 41        	mov	ax,4184h
0800:0795 8E D8           	mov	ds,ax
0800:0797 8B 5E 06        	mov	bx,[bp+6h]
0800:079A 89 1E 2F 09     	mov	[092Fh],bx
0800:079E 8B 46 08        	mov	ax,[bp+8h]
0800:07A1 A3 31 09        	mov	[0931h],ax
0800:07A4 8B 7E 0A        	mov	di,[bp+0Ah]
0800:07A7 89 3E 33 09     	mov	[0933h],di
0800:07AB 8B 4E 0C        	mov	cx,[bp+0Ch]
0800:07AE 89 0E 35 09     	mov	[0935h],cx
0800:07B2 8B 16 01 09     	mov	dx,[0901h]
0800:07B6 F6 E2           	mul	dl
0800:07B8 03 C3           	add	ax,bx
0800:07BA 8B 76 0E        	mov	si,[bp+0Eh]
0800:07BD 03 F0           	add	si,ax
0800:07BF A1 31 09        	mov	ax,[0931h]
0800:07C2 2B 06 35 09     	sub	ax,[0935h]
0800:07C6 A3 37 09        	mov	[0937h],ax
0800:07C9 8B 1E 33 09     	mov	bx,[0933h]
0800:07CD 2B 1E 2F 09     	sub	bx,[092Fh]
0800:07D1 89 1E 39 09     	mov	[0939h],bx
0800:07D5 A3 3D 09        	mov	[093Dh],ax
0800:07D8 0B C0           	or	ax,ax
0800:07DA 79 04           	jns	07E0h

l0800_07DC:
0800:07DC F7 1E 3D 09     	neg	word ptr [093Dh]

l0800_07E0:
0800:07E0 89 1E 3F 09     	mov	[093Fh],bx
0800:07E4 0B DB           	or	bx,bx
0800:07E6 79 04           	jns	07ECh

l0800_07E8:
0800:07E8 F7 1E 3F 09     	neg	word ptr [093Fh]

l0800_07EC:
0800:07EC 8B 16 3F 09     	mov	dx,[093Fh]
0800:07F0 3B 16 3D 09     	cmp	dx,[093Dh]
0800:07F4 7E 0C           	jle	0802h

l0800_07F6:
0800:07F6 8B 0E 3D 09     	mov	cx,[093Dh]
0800:07FA 89 16 3D 09     	mov	[093Dh],dx
0800:07FE 89 0E 3F 09     	mov	[093Fh],cx

l0800_0802:
0800:0802 0B C0           	or	ax,ax
0800:0804 79 23           	jns	0829h

l0800_0806:
0800:0806 83 3E 39 09 01  	cmp	word ptr [0939h],1h
0800:080B 7C 0D           	jl	081Ah

l0800_080D:
0800:080D BA 02 00        	mov	dx,2h
0800:0810 F7 D8           	neg	ax
0800:0812 3B C3           	cmp	ax,bx
0800:0814 7E 2C           	jle	0842h

l0800_0816:
0800:0816 42              	inc	dx
0800:0817 EB 29           	jmp	0842h
0800:0819                            90                            .      

l0800_081A:
0800:081A BA 04 00        	mov	dx,4h
0800:081D F7 D8           	neg	ax
0800:081F F7 DB           	neg	bx
0800:0821 3B D8           	cmp	bx,ax
0800:0823 7E 1D           	jle	0842h

l0800_0825:
0800:0825 42              	inc	dx
0800:0826 EB 1A           	jmp	0842h
0800:0828                         90                              .       

l0800_0829:
0800:0829 83 FB 01        	cmp	bx,1h
0800:082C 7C 0A           	jl	0838h

l0800_082E:
0800:082E 33 D2           	xor	dx,dx
0800:0830 3B D8           	cmp	bx,ax
0800:0832 7E 0E           	jle	0842h

l0800_0834:
0800:0834 42              	inc	dx
0800:0835 EB 0B           	jmp	0842h
0800:0837                      90                                .        

l0800_0838:
0800:0838 BA 06 00        	mov	dx,6h
0800:083B F7 DB           	neg	bx
0800:083D 3B C3           	cmp	ax,bx
0800:083F 7E 01           	jle	0842h

l0800_0841:
0800:0841 42              	inc	dx

l0800_0842:
0800:0842 8B 0E 3D 09     	mov	cx,[093Dh]
0800:0846 D1 E9           	shr	cx,1h
0800:0848 89 0E 3B 09     	mov	[093Bh],cx
0800:084C 8B DA           	mov	bx,dx
0800:084E D1 E3           	shl	bx,1h
0800:0850 8B 87 EB 08     	mov	ax,[bx+8EBh]
0800:0854 A3 41 09        	mov	[0941h],ax
0800:0857 8B 87 E7 08     	mov	ax,[bx+8E7h]
0800:085B A3 43 09        	mov	[0943h],ax
0800:085E 8B 87 FB 08     	mov	ax,[bx+8FBh]
0800:0862 A3 45 09        	mov	[0945h],ax
0800:0865 8B 87 0F 09     	mov	ax,[bx+90Fh]
0800:0869 A3 47 09        	mov	[0947h],ax
0800:086C 8B 87 0B 09     	mov	ax,[bx+90Bh]
0800:0870 A3 49 09        	mov	[0949h],ax
0800:0873 8B 87 1F 09     	mov	ax,[bx+91Fh]
0800:0877 A3 4B 09        	mov	[094Bh],ax
0800:087A A1 2F 09        	mov	ax,[092Fh]
0800:087D 8B 1E 31 09     	mov	bx,[0931h]
0800:0881 8B 56 12        	mov	dx,[bp+12h]
0800:0884 88 16 4D 09     	mov	[094Dh],dl
0800:0888 8B 56 14        	mov	dx,[bp+14h]
0800:088B 88 16 4E 09     	mov	[094Eh],dl
0800:088F C6 06 4F 09 03  	mov	byte ptr [094Fh],3h
0800:0894 8B 56 10        	mov	dx,[bp+10h]
0800:0897 06              	push	es
0800:0898 8E C2           	mov	es,dx
0800:089A 8A 56 16        	mov	dl,[bp+16h]
0800:089D 2E 88 16 8A 07  	mov	cs:[078Ah],dl
0800:08A2 8A 56 18        	mov	dl,[bp+18h]
0800:08A5 2E 88 16 8B 07  	mov	cs:[078Bh],dl
0800:08AA 33 D2           	xor	dx,dx

l0800_08AC:
0800:08AC 2E FE 0E 8B 07  	dec	byte ptr cs:[078Bh]
0800:08B1 74 6D           	jz	0920h

l0800_08B3:
0800:08B3 3B 06 33 09     	cmp	ax,[0933h]
0800:08B7 75 06           	jnz	08BFh

l0800_08B9:
0800:08B9 3B 1E 35 09     	cmp	bx,[0935h]
0800:08BD 74 60           	jz	091Fh

l0800_08BF:
0800:08BF 26 8A 34        	mov	dh,es:[si]
0800:08C2 2E 3A 36 8A 07  	cmp	dh,cs:[078Ah]
0800:08C7 73 57           	jnc	0920h

l0800_08C9:
0800:08C9 3A 36 4D 09     	cmp	dh,[094Dh]
0800:08CD 72 0C           	jc	08DBh

l0800_08CF:
0800:08CF 3A 36 4E 09     	cmp	dh,[094Eh]
0800:08D3 77 06           	ja	08DBh

l0800_08D5:
0800:08D5 FE 0E 4F 09     	dec	byte ptr [094Fh]
0800:08D9 74 45           	jz	0920h

l0800_08DB:
0800:08DB 3B 06 33 09     	cmp	ax,[0933h]
0800:08DF 74 08           	jz	08E9h

l0800_08E1:
0800:08E1 03 06 41 09     	add	ax,[0941h]
0800:08E5 03 36 41 09     	add	si,[0941h]

l0800_08E9:
0800:08E9 3B 1E 35 09     	cmp	bx,[0935h]
0800:08ED 74 08           	jz	08F7h

l0800_08EF:
0800:08EF 03 1E 43 09     	add	bx,[0943h]
0800:08F3 03 36 45 09     	add	si,[0945h]

l0800_08F7:
0800:08F7 2B 0E 3F 09     	sub	cx,[093Fh]
0800:08FB 79 AF           	jns	08ACh

l0800_08FD:
0800:08FD 03 0E 3D 09     	add	cx,[093Dh]
0800:0901 3B 06 33 09     	cmp	ax,[0933h]
0800:0905 74 08           	jz	090Fh

l0800_0907:
0800:0907 03 06 47 09     	add	ax,[0947h]
0800:090B 03 36 47 09     	add	si,[0947h]

l0800_090F:
0800:090F 3B 1E 35 09     	cmp	bx,[0935h]
0800:0913 74 97           	jz	08ACh

l0800_0915:
0800:0915 03 1E 49 09     	add	bx,[0949h]
0800:0919 03 36 4B 09     	add	si,[094Bh]
0800:091D EB 8D           	jmp	08ACh

l0800_091F:
0800:091F 42              	inc	dx

l0800_0920:
0800:0920 8A C2           	mov	al,dl
0800:0922 32 E4           	xor	ah,ah
0800:0924 07              	pop	es
0800:0925 1F              	pop	ds
0800:0926 5E              	pop	si
0800:0927 5F              	pop	di
0800:0928 5D              	pop	bp
0800:0929 CB              	retf

;; InterpolateLineCoordinate_092A: 0800:092A
;;   Called from:
;;     1A1F:0EE7 (in DrawWeaponAttackTrace_0D55)
;;     1A1F:0F10 (in DrawWeaponAttackTrace_0D55)
;;     1A1F:0F36 (in DrawWeaponAttackTrace_0D55)
;;     1A1F:0F5F (in DrawWeaponAttackTrace_0D55)
;;     1A1F:0F84 (in DrawWeaponAttackTrace_0D55)
;;     1A1F:0FAD (in DrawWeaponAttackTrace_0D55)
;;     1A1F:0FD2 (in DrawWeaponAttackTrace_0D55)
;;     1A1F:0FFB (in DrawWeaponAttackTrace_0D55)
;;     1A1F:1935 (in OffsetWeaponTraceEndpoint_18C9)
;;     1A1F:196F (in OffsetWeaponTraceEndpoint_18C9)
;;     1A1F:19A8 (in OffsetWeaponTraceEndpoint_18C9)
;;     1A1F:19E1 (in OffsetWeaponTraceEndpoint_18C9)
InterpolateLineCoordinate_092A proc
0800:092A 55              	push	bp
0800:092B 8B EC           	mov	bp,sp
0800:092D 57              	push	di
0800:092E 56              	push	si
0800:092F 1E              	push	ds
0800:0930 B8 84 41        	mov	ax,4184h
0800:0933 8E D8           	mov	ds,ax
0800:0935 8B 46 06        	mov	ax,[bp+6h]
0800:0938 8B 5E 08        	mov	bx,[bp+8h]
0800:093B 8B 4E 0A        	mov	cx,[bp+0Ah]
0800:093E 8B 76 0C        	mov	si,[bp+0Ch]
0800:0941 8B 7E 0E        	mov	di,[bp+0Eh]
0800:0944 3B FB           	cmp	di,bx
0800:0946 74 0C           	jz	0954h

l0800_0948:
0800:0948 2B C3           	sub	ax,bx
0800:094A 2B CE           	sub	cx,si
0800:094C F7 E9           	imul	cx
0800:094E 2B FB           	sub	di,bx
0800:0950 F7 FF           	idiv	di
0800:0952 03 C6           	add	ax,si

l0800_0954:
0800:0954 1F              	pop	ds
0800:0955 5E              	pop	si
0800:0956 5F              	pop	di
0800:0957 5D              	pop	bp
0800:0958 CB              	retf

;; InstallDamagedTerrainSpriteLookup_0959: 0800:0959
InstallDamagedTerrainSpriteLookup_0959 proc
0800:0959 55              	push	bp
0800:095A 8B EC           	mov	bp,sp
0800:095C 57              	push	di
0800:095D 56              	push	si
0800:095E 1E              	push	ds
0800:095F B8 84 41        	mov	ax,4184h
0800:0962 8E D8           	mov	ds,ax
0800:0964 B8 C9 01        	mov	ax,1C9h
0800:0967 A3 D3 08        	mov	[08D3h],ax
0800:096A 8C C8           	mov	ax,cs
0800:096C A3 D5 08        	mov	[08D5h],ax
0800:096F 1F              	pop	ds
0800:0970 5E              	pop	si
0800:0971 5F              	pop	di
0800:0972 5D              	pop	bp
0800:0973 CB              	retf

;; VGA_LoadPalette_0974: 0800:0974
;;   Called from:
;;     2B2D:006C (in LoadVideoPalette_0004)
VGA_LoadPalette_0974 proc
0800:0974 55              	push	bp
0800:0975 8B EC           	mov	bp,sp
0800:0977 57              	push	di
0800:0978 56              	push	si
0800:0979 1E              	push	ds
0800:097A B8 84 41        	mov	ax,4184h
0800:097D 8E D8           	mov	ds,ax
0800:097F 8B 56 06        	mov	dx,[bp+6h]
0800:0982 8B 46 08        	mov	ax,[bp+8h]
0800:0985 06              	push	es
0800:0986 8E C0           	mov	es,ax
0800:0988 B8 12 10        	mov	ax,1012h
0800:098B BB 00 00        	mov	bx,0h
0800:098E B9 00 01        	mov	cx,100h
0800:0991 CD 10           	int	10h
0800:0993 07              	pop	es
0800:0994 1F              	pop	ds
0800:0995 5E              	pop	si
0800:0996 5F              	pop	di
0800:0997 5D              	pop	bp
0800:0998 CB              	retf

;; ClearTacticalEffectOverlayMap_0999: 0800:0999
;;   Called from:
;;     2007:121A (in BuildTacticalTerrainEffectOverlay_1219)
ClearTacticalEffectOverlayMap_0999 proc
0800:0999 55              	push	bp
0800:099A 8B EC           	mov	bp,sp
0800:099C 57              	push	di
0800:099D 56              	push	si
0800:099E 1E              	push	ds
0800:099F B8 84 41        	mov	ax,4184h
0800:09A2 8E D8           	mov	ds,ax
0800:09A4 8C D8           	mov	ax,ds
0800:09A6 06              	push	es
0800:09A7 8E C0           	mov	es,ax
0800:09A9 BF D8 07        	mov	di,7D8h
0800:09AC 33 C0           	xor	ax,ax
0800:09AE B9 E4 00        	mov	cx,0E4h

l0800_09B1:
0800:09B1 F3 AA           	rep stosb

l0800_09B3:
0800:09B3 07              	pop	es
0800:09B4 1F              	pop	ds
0800:09B5 5E              	pop	si
0800:09B6 5F              	pop	di
0800:09B7 5D              	pop	bp
0800:09B8 CB              	retf
0800:09B9                            00 00                         ..     

;; DrawCgaCompositeTacticalTile_09BB: 0800:09BB
;;   Called from:
;;     2007:0722 (in RebuildTacticalViewport_0650)
DrawCgaCompositeTacticalTile_09BB proc
0800:09BB 55              	push	bp
0800:09BC 8B EC           	mov	bp,sp
0800:09BE 57              	push	di
0800:09BF 56              	push	si
0800:09C0 1E              	push	ds
0800:09C1 B8 84 41        	mov	ax,4184h
0800:09C4 8E D8           	mov	ds,ax
0800:09C6 8B 76 0A        	mov	si,[bp+0Ah]
0800:09C9 8B 56 0C        	mov	dx,[bp+0Ch]
0800:09CC 8B 46 10        	mov	ax,[bp+10h]
0800:09CF 25 FC 00        	and	ax,0FCh
0800:09D2 D1 E0           	shl	ax,1h
0800:09D4 D1 E0           	shl	ax,1h
0800:09D6 D1 E0           	shl	ax,1h
0800:09D8 8B D8           	mov	bx,ax
0800:09DA D1 E0           	shl	ax,1h
0800:09DC D1 E0           	shl	ax,1h
0800:09DE 03 C3           	add	ax,bx
0800:09E0 8B F8           	mov	di,ax
0800:09E2 8B 46 0E        	mov	ax,[bp+0Eh]
0800:09E5 D1 E0           	shl	ax,1h
0800:09E7 03 F8           	add	di,ax
0800:09E9 8B 5E 06        	mov	bx,[bp+6h]
0800:09EC 8B 46 08        	mov	ax,[bp+8h]
0800:09EF B9 07 00        	mov	cx,7h
0800:09F2 D3 E0           	shl	ax,cl
0800:09F4 D3 E3           	shl	bx,cl
0800:09F6 03 DE           	add	bx,si
0800:09F8 03 F0           	add	si,ax
0800:09FA 06              	push	es
0800:09FB B8 00 B8        	mov	ax,0B800h
0800:09FE 8E C0           	mov	es,ax
0800:0A00 8E DA           	mov	ds,dx
0800:0A02 BA 10 00        	mov	dx,10h

l0800_0A05:
0800:0A05 B9 04 00        	mov	cx,4h

l0800_0A08:
0800:0A08 8B 07           	mov	ax,[bx]
0800:0A0A 22 24           	and	ah,[si]
0800:0A0C 0A C4           	or	al,ah
0800:0A0E AA              	stosb
0800:0A0F 83 C6 02        	add	si,2h
0800:0A12 83 C3 02        	add	bx,2h
0800:0A15 E2 F1           	loop	0A08h

l0800_0A17:
0800:0A17 81 C7 FC 1F     	add	di,1FFCh
0800:0A1B 80 F6 01        	xor	dh,1h
0800:0A1E 75 04           	jnz	0A24h

l0800_0A20:
0800:0A20 81 EF B0 3F     	sub	di,3FB0h

l0800_0A24:
0800:0A24 FE CA           	dec	dl
0800:0A26 75 DD           	jnz	0A05h

l0800_0A28:
0800:0A28 07              	pop	es
0800:0A29 1F              	pop	ds
0800:0A2A 5E              	pop	si
0800:0A2B 5F              	pop	di
0800:0A2C 5D              	pop	bp
0800:0A2D CB              	retf

;; DrawCgaHighSpriteTile_0A2E: 0800:0A2E
;;   Called from:
;;     2007:1CFB (in DrawTacticalTileSpriteForAdapter_1CBD)
DrawCgaHighSpriteTile_0A2E proc
0800:0A2E 55              	push	bp
0800:0A2F 8B EC           	mov	bp,sp
0800:0A31 57              	push	di
0800:0A32 56              	push	si
0800:0A33 1E              	push	ds
0800:0A34 B8 84 41        	mov	ax,4184h
0800:0A37 8E D8           	mov	ds,ax
0800:0A39 06              	push	es
0800:0A3A B8 00 B8        	mov	ax,0B800h
0800:0A3D 8E C0           	mov	es,ax
0800:0A3F 8B 76 06        	mov	si,[bp+6h]
0800:0A42 8B 4E 08        	mov	cx,[bp+8h]
0800:0A45 8B 5E 0A        	mov	bx,[bp+0Ah]
0800:0A48 D1 E3           	shl	bx,1h
0800:0A4A D1 E3           	shl	bx,1h
0800:0A4C D1 E3           	shl	bx,1h
0800:0A4E 03 CB           	add	cx,bx
0800:0A50 8B 46 0E        	mov	ax,[bp+0Eh]
0800:0A53 24 FE           	and	al,0FEh
0800:0A55 BA 28 00        	mov	dx,28h
0800:0A58 F6 E2           	mul	dl
0800:0A5A 8B 56 0C        	mov	dx,[bp+0Ch]
0800:0A5D D1 E2           	shl	dx,1h
0800:0A5F 03 C2           	add	ax,dx
0800:0A61 8B F8           	mov	di,ax
0800:0A63 8E D9           	mov	ds,cx
0800:0A65 B9 08 00        	mov	cx,8h
0800:0A68 FC              	cld

l0800_0A69:
0800:0A69 A4              	movsb
0800:0A6A 46              	inc	si
0800:0A6B A4              	movsb
0800:0A6C 46              	inc	si
0800:0A6D A4              	movsb
0800:0A6E 46              	inc	si
0800:0A6F A4              	movsb
0800:0A70 46              	inc	si
0800:0A71 81 C7 FC 1F     	add	di,1FFCh
0800:0A75 A4              	movsb
0800:0A76 46              	inc	si
0800:0A77 A4              	movsb
0800:0A78 46              	inc	si
0800:0A79 A4              	movsb
0800:0A7A 46              	inc	si
0800:0A7B A4              	movsb
0800:0A7C 46              	inc	si
0800:0A7D 81 EF B4 1F     	sub	di,1FB4h
0800:0A81 E2 E6           	loop	0A69h

l0800_0A83:
0800:0A83 07              	pop	es
0800:0A84 1F              	pop	ds
0800:0A85 5E              	pop	si
0800:0A86 5F              	pop	di
0800:0A87 5D              	pop	bp
0800:0A88 CB              	retf
0800:0A89                            55 8B EC 57 56 1E B8          U..WV..
0800:0A90 84 41 8E D8 8B 76 06 8B 46 08 8B 7E 0A 8B 56 0C .A...v..F..~..V.
0800:0AA0 06 8E C2 8E D8 8B 4E 0E 8A E9 8B 56 10 33 DB 8A ......N....V.3..
0800:0AB0 D9 80 C3 07 80 E3 F8 8B EB BB C9 04 AC 2E D7 AA ................
0800:0AC0 FE C9 75 F8 8A C5 B1 07 22 C1 FE C1 2A C8 80 E1 ..u....."...*...
0800:0AD0 07 74 09 32 C0 2E D7 AA FE C9 75 FB 8A CD 4A 75 .t.2......u...Ju
0800:0AE0 DB 07 1F 5E 5F 5D CB 00 00 00 11 00 00 AA 22 00 ...^_]........".
0800:0AF0 00 DD FF 00 55 33 00 00 00 00 44 00 00 AA 88 00 ....U3....D.....
0800:0B00 00 77 FF 00 55 CC 00                            .w..U..         

;; PlotPixel_0B07: 0800:0B07
;;   Called from:
;;     24C5:0191 (in RefreshTacticalOverview_012E)
;;     24C5:01E5 (in RefreshTacticalOverview_012E)
;;     24C5:020A (in RefreshTacticalOverview_012E)
;;     24C5:023D (in RefreshTacticalOverview_012E)
;;     24C5:0261 (in RefreshTacticalOverview_012E)
;;     24C5:02DD (in RefreshTacticalOverview_012E)
;;     24C5:03CE (in DrawTacticalOverviewMap_037F)
PlotPixel_0B07 proc
0800:0B07 55              	push	bp
0800:0B08 8B EC           	mov	bp,sp
0800:0B0A 57              	push	di
0800:0B0B 56              	push	si
0800:0B0C 1E              	push	ds
0800:0B0D B8 84 41        	mov	ax,4184h
0800:0B10 8E D8           	mov	ds,ax
0800:0B12 06              	push	es
0800:0B13 B8 84 41        	mov	ax,4184h
0800:0B16 8E D8           	mov	ds,ax
0800:0B18 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:0B1D 75 03           	jnz	0B22h

l0800_0B1F:
0800:0B1F E9 97 00        	jmp	0BB9h

l0800_0B22:
0800:0B22 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:0B27 74 27           	jz	0B50h

l0800_0B29:
0800:0B29 72 4B           	jc	0B76h

l0800_0B2B:
0800:0B2B 8B 7E 06        	mov	di,[bp+6h]
0800:0B2E D1 E7           	shl	di,1h
0800:0B30 8B 46 08        	mov	ax,[bp+8h]
0800:0B33 BA 80 02        	mov	dx,280h
0800:0B36 F7 E2           	mul	dx
0800:0B38 03 F8           	add	di,ax
0800:0B3A B8 00 A0        	mov	ax,0A000h
0800:0B3D 8E D8           	mov	ds,ax
0800:0B3F 8B 46 0A        	mov	ax,[bp+0Ah]
0800:0B42 8A E0           	mov	ah,al
0800:0B44 25 F0 0F        	and	ax,0FF0h
0800:0B47 89 05           	mov	[di],ax
0800:0B49 89 85 40 01     	mov	[di+140h],ax
0800:0B4D E9 B0 00        	jmp	0C00h

l0800_0B50:
0800:0B50 8B 7E 06        	mov	di,[bp+6h]
0800:0B53 8B 46 08        	mov	ax,[bp+8h]
0800:0B56 D1 E8           	shr	ax,1h
0800:0B58 73 04           	jnc	0B5Eh

l0800_0B5A:
0800:0B5A 81 C7 00 40     	add	di,4000h

l0800_0B5E:
0800:0B5E BA A0 00        	mov	dx,0A0h
0800:0B61 F6 E2           	mul	dl
0800:0B63 03 F8           	add	di,ax
0800:0B65 B8 00 B8        	mov	ax,0B800h
0800:0B68 8E D8           	mov	ds,ax
0800:0B6A 8B 46 0A        	mov	ax,[bp+0Ah]
0800:0B6D 88 05           	mov	[di],al
0800:0B6F 88 85 00 20     	mov	[di+2000h],al
0800:0B73 E9 8A 00        	jmp	0C00h

l0800_0B76:
0800:0B76 8B 7E 06        	mov	di,[bp+6h]
0800:0B79 B9 F0 0F        	mov	cx,0FF0h
0800:0B7C D1 EF           	shr	di,1h
0800:0B7E 73 02           	jnc	0B82h

l0800_0B80:
0800:0B80 F7 D1           	not	cx

l0800_0B82:
0800:0B82 8B 46 08        	mov	ax,[bp+8h]
0800:0B85 BA 50 00        	mov	dx,50h
0800:0B88 F6 E2           	mul	dl
0800:0B8A 03 F8           	add	di,ax
0800:0B8C B8 00 B8        	mov	ax,0B800h
0800:0B8F 8E D8           	mov	ds,ax
0800:0B91 8B 5E 0A        	mov	bx,[bp+0Ah]
0800:0B94 83 E3 0F        	and	bx,0Fh
0800:0B97 81 C3 E7 0A     	add	bx,0AE7h
0800:0B9B 2E 8A 07        	mov	al,cs:[bx]
0800:0B9E 8A 25           	mov	ah,[di]
0800:0BA0 23 C1           	and	ax,cx
0800:0BA2 0A C4           	or	al,ah
0800:0BA4 88 05           	mov	[di],al
0800:0BA6 2E 8A 47 10     	mov	al,cs:[bx+10h]
0800:0BAA 8A A5 00 20     	mov	ah,[di+2000h]
0800:0BAE 23 C1           	and	ax,cx
0800:0BB0 0A C4           	or	al,ah
0800:0BB2 88 85 00 20     	mov	[di+2000h],al
0800:0BB6 EB 48           	jmp	0C00h
0800:0BB8                         90                              .       

l0800_0BB9:
0800:0BB9 8B 46 08        	mov	ax,[bp+8h]
0800:0BBC B2 50           	mov	dl,50h
0800:0BBE F6 E2           	mul	dl
0800:0BC0 8B F8           	mov	di,ax
0800:0BC2 8B 46 06        	mov	ax,[bp+6h]
0800:0BC5 8B C8           	mov	cx,ax
0800:0BC7 D1 E8           	shr	ax,1h
0800:0BC9 D1 E8           	shr	ax,1h
0800:0BCB 03 F8           	add	di,ax
0800:0BCD BB C0 00        	mov	bx,0C0h
0800:0BD0 83 E1 03        	and	cx,3h
0800:0BD3 74 06           	jz	0BDBh

l0800_0BD5:
0800:0BD5 D1 EB           	shr	bx,1h
0800:0BD7 D1 EB           	shr	bx,1h
0800:0BD9 E2 FA           	loop	0BD5h

l0800_0BDB:
0800:0BDB BA CE 03        	mov	dx,3CEh
0800:0BDE B8 05 02        	mov	ax,205h
0800:0BE1 EE              	out	dx,al
0800:0BE2 42              	inc	dx
0800:0BE3 8A C4           	mov	al,ah
0800:0BE5 EE              	out	dx,al
0800:0BE6 4A              	dec	dx
0800:0BE7 B0 08           	mov	al,8h
0800:0BE9 EE              	out	dx,al
0800:0BEA 42              	inc	dx
0800:0BEB 8A C3           	mov	al,bl
0800:0BED EE              	out	dx,al
0800:0BEE 8B 4E 0A        	mov	cx,[bp+0Ah]
0800:0BF1 B8 00 A0        	mov	ax,0A000h
0800:0BF4 8E D8           	mov	ds,ax
0800:0BF6 8A 05           	mov	al,[di]
0800:0BF8 88 0D           	mov	[di],cl
0800:0BFA 8A 45 28        	mov	al,[di+28h]
0800:0BFD 88 4D 28        	mov	[di+28h],cl

l0800_0C00:
0800:0C00 07              	pop	es
0800:0C01 1F              	pop	ds
0800:0C02 5E              	pop	si
0800:0C03 5F              	pop	di
0800:0C04 5D              	pop	bp
0800:0C05 CB              	retf
0800:0C06                   55 8B EC 57 56 1E B8 84 41 8E       U..WV...A.
0800:0C10 D8 06 8B 76 06 8B 56 08 8B 7E 0A 8B 46 0C 8E C0 ...v..V..~..F...
0800:0C20 8A 66 0E 8E DA B9 00 FA AC 22 C4 AA E2 FA 07 1F .f......."......
0800:0C30 5E 5F 5D CB                                     ^_].            

;; CopyUncompressedFarBlock_0C34: 0800:0C34
;;   Called from:
;;     21E7:0137 (in DecodeWestwoodPackedResource_00F4)
CopyUncompressedFarBlock_0C34 proc
0800:0C34 55              	push	bp
0800:0C35 8B EC           	mov	bp,sp
0800:0C37 57              	push	di
0800:0C38 56              	push	si
0800:0C39 1E              	push	ds
0800:0C3A B8 84 41        	mov	ax,4184h
0800:0C3D 8E D8           	mov	ds,ax
0800:0C3F 8B 76 06        	mov	si,[bp+6h]
0800:0C42 8B 56 08        	mov	dx,[bp+8h]
0800:0C45 8B 7E 0A        	mov	di,[bp+0Ah]
0800:0C48 8B 46 0C        	mov	ax,[bp+0Ch]
0800:0C4B 06              	push	es
0800:0C4C 8E C0           	mov	es,ax
0800:0C4E 8B 4E 0E        	mov	cx,[bp+0Eh]
0800:0C51 8B 5E 10        	mov	bx,[bp+10h]
0800:0C54 8E DA           	mov	ds,dx
0800:0C56 D1 E9           	shr	cx,1h
0800:0C58 74 02           	jz	0C5Ch

l0800_0C5A:
0800:0C5A F3 A5           	rep movsw

l0800_0C5C:
0800:0C5C 73 01           	jnc	0C5Fh

l0800_0C5E:
0800:0C5E A4              	movsb

l0800_0C5F:
0800:0C5F 0B DB           	or	bx,bx
0800:0C61 74 1E           	jz	0C81h

l0800_0C63:
0800:0C63 8B C7           	mov	ax,di
0800:0C65 8C C2           	mov	dx,es
0800:0C67 E8 1D 00        	call	0C87h
0800:0C6A 8B F8           	mov	di,ax
0800:0C6C 8E C2           	mov	es,dx
0800:0C6E 8B C6           	mov	ax,si
0800:0C70 8C DA           	mov	dx,ds
0800:0C72 E8 12 00        	call	0C87h
0800:0C75 8B F0           	mov	si,ax
0800:0C77 8E DA           	mov	ds,dx
0800:0C79 B9 00 80        	mov	cx,8000h

l0800_0C7C:
0800:0C7C F3 A5           	rep movsw

l0800_0C7E:
0800:0C7E 4B              	dec	bx
0800:0C7F 75 E2           	jnz	0C63h

l0800_0C81:
0800:0C81 07              	pop	es
0800:0C82 1F              	pop	ds
0800:0C83 5E              	pop	si
0800:0C84 5F              	pop	di
0800:0C85 5D              	pop	bp
0800:0C86 CB              	retf

;; NormalizeSegmentOffset_0C87: 0800:0C87
;;   Called from:
;;     0800:0C67 (in CopyUncompressedFarBlock_0C34)
;;     0800:0C72 (in CopyUncompressedFarBlock_0C34)
NormalizeSegmentOffset_0C87 proc
0800:0C87 3D 10 00        	cmp	ax,10h
0800:0C8A 72 06           	jc	0C92h

l0800_0C8C:
0800:0C8C 42              	inc	dx
0800:0C8D 2D 10 00        	sub	ax,10h
0800:0C90 75 F5           	jnz	0C87h

l0800_0C92:
0800:0C92 C3              	ret
0800:0C93          00 00 00 00 00 00 00                      .......      

;; DecodeRLEBlock_0C9A: 0800:0C9A
;;   Called from:
;;     21E7:014A (in DecodeWestwoodPackedResource_00F4)
DecodeRLEBlock_0C9A proc
0800:0C9A 55              	push	bp
0800:0C9B 8B EC           	mov	bp,sp
0800:0C9D 57              	push	di
0800:0C9E 56              	push	si
0800:0C9F 1E              	push	ds
0800:0CA0 B8 84 41        	mov	ax,4184h
0800:0CA3 8E D8           	mov	ds,ax
0800:0CA5 50              	push	ax
0800:0CA6 53              	push	bx
0800:0CA7 51              	push	cx
0800:0CA8 52              	push	dx
0800:0CA9 06              	push	es
0800:0CAA FC              	cld
0800:0CAB 8E 46 08        	mov	es,[bp+8h]
0800:0CAE 8E 5E 06        	mov	ds,[bp+6h]
0800:0CB1 33 C9           	xor	cx,cx
0800:0CB3 33 FF           	xor	di,di
0800:0CB5 33 F6           	xor	si,si
0800:0CB7 83 C6 02        	add	si,2h
0800:0CBA 8B 1C           	mov	bx,[si]
0800:0CBC 8B 54 02        	mov	dx,[si+2h]
0800:0CBF 83 C6 04        	add	si,4h
0800:0CC2 8B 04           	mov	ax,[si]
0800:0CC4 83 C6 02        	add	si,2h
0800:0CC7 03 F0           	add	si,ax

l0800_0CC9:
0800:0CC9 8A 0C           	mov	cl,[si]
0800:0CCB 46              	inc	si
0800:0CCC 80 F9 00        	cmp	cl,0h
0800:0CCF 74 0D           	jz	0CDEh

l0800_0CD1:
0800:0CD1 80 F9 7F        	cmp	cl,7Fh
0800:0CD4 77 12           	ja	0CE8h

l0800_0CD6:
0800:0CD6 E8 20 00        	call	0CF9h

l0800_0CD9:
0800:0CD9 F3 A4           	rep movsb

l0800_0CDB:
0800:0CDB EB 13           	jmp	0CF0h
0800:0CDD                                        90                    .  

l0800_0CDE:
0800:0CDE 8B 0C           	mov	cx,[si]
0800:0CE0 86 CD           	xchg	ch,cl
0800:0CE2 83 C6 02        	add	si,2h
0800:0CE5 EB 03           	jmp	0CEAh
0800:0CE7                      90                                .        

l0800_0CE8:
0800:0CE8 F6 D9           	neg	cl

l0800_0CEA:
0800:0CEA E8 0C 00        	call	0CF9h
0800:0CED AC              	lodsb

l0800_0CEE:
0800:0CEE F3 AA           	rep stosb

l0800_0CF0:
0800:0CF0 8B C3           	mov	ax,bx
0800:0CF2 0B C2           	or	ax,dx
0800:0CF4 75 D3           	jnz	0CC9h

l0800_0CF6:
0800:0CF6 EB 18           	jmp	0D10h
0800:0CF8                         90                              .       
0800:0CF9                            2B D9 83 DA 00 50 8C          +....P.
0800:0D00 C0 83 FF 10 7C 06 83 EF 10 40 EB F5 8E C0 58 C3 ....|....@....X.

l0800_0D10:
0800:0D10 07              	pop	es
0800:0D11 5A              	pop	dx
0800:0D12 59              	pop	cx
0800:0D13 5B              	pop	bx
0800:0D14 58              	pop	ax
0800:0D15 1F              	pop	ds
0800:0D16 5E              	pop	si
0800:0D17 5F              	pop	di
0800:0D18 5D              	pop	bp
0800:0D19 CB              	retf

;; DecodeWestwoodLzw12_0D1A: 0800:0D1A
;;   Called from:
;;     21E7:017C (in DecodeWestwoodPackedResource_00F4)
;;     21E7:019F (in DecodeWestwoodPackedResource_00F4)
DecodeWestwoodLzw12_0D1A proc
0800:0D1A 55              	push	bp
0800:0D1B 8B EC           	mov	bp,sp
0800:0D1D 57              	push	di
0800:0D1E 56              	push	si
0800:0D1F 1E              	push	ds
0800:0D20 B8 84 41        	mov	ax,4184h
0800:0D23 8E D8           	mov	ds,ax
0800:0D25 50              	push	ax
0800:0D26 53              	push	bx
0800:0D27 51              	push	cx
0800:0D28 52              	push	dx
0800:0D29 06              	push	es
0800:0D2A FC              	cld
0800:0D2B 8E 46 08        	mov	es,[bp+8h]
0800:0D2E 8E 5E 06        	mov	ds,[bp+6h]
0800:0D31 8B 6E 0A        	mov	bp,[bp+0Ah]
0800:0D34 33 FF           	xor	di,di
0800:0D36 BE 02 00        	mov	si,2h
0800:0D39 AD              	lodsw
0800:0D3A 2E A3 93 0C     	mov	cs:[0C93h],ax
0800:0D3E AD              	lodsw
0800:0D3F AD              	lodsw
0800:0D40 03 F0           	add	si,ax
0800:0D42 2E 8C 1E 97 0C  	mov	cs:[0C97h],ds
0800:0D47 8E DD           	mov	ds,bp
0800:0D49 33 C9           	xor	cx,cx
0800:0D4B 2E 88 2E 99 0C  	mov	cs:[0C99h],ch
0800:0D50 B1 04           	mov	cl,4h
0800:0D52 33 ED           	xor	bp,bp
0800:0D54 E8 91 00        	call	0DE8h
0800:0D57 8B D0           	mov	dx,ax
0800:0D59 8A E8           	mov	ch,al
0800:0D5B AA              	stosb

l0800_0D5C:
0800:0D5C 2E 3B 3E 93 0C  	cmp	di,cs:[0C93h]
0800:0D61 73 49           	jnc	0DACh

l0800_0D63:
0800:0D63 E8 82 00        	call	0DE8h
0800:0D66 0A E4           	or	ah,ah
0800:0D68 74 65           	jz	0DCFh

l0800_0D6A:
0800:0D6A 50              	push	ax
0800:0D6B 57              	push	di
0800:0D6C FE CC           	dec	ah
0800:0D6E 8B D8           	mov	bx,ax
0800:0D70 D1 E3           	shl	bx,1h
0800:0D72 D1 E3           	shl	bx,1h
0800:0D74 3B DD           	cmp	bx,bp
0800:0D76 72 06           	jc	0D7Eh

l0800_0D78:
0800:0D78 73 35           	jnc	0DAFh

l0800_0D7A:
0800:0D7A 81 EB 00 04     	sub	bx,400h

l0800_0D7E:
0800:0D7E 8A 47 02        	mov	al,[bx+2h]
0800:0D81 AA              	stosb
0800:0D82 8B 07           	mov	ax,[bx]
0800:0D84 8B D8           	mov	bx,ax
0800:0D86 D1 E3           	shl	bx,1h
0800:0D88 D1 E3           	shl	bx,1h

l0800_0D8A:
0800:0D8A 81 FB 00 04     	cmp	bx,400h
0800:0D8E 73 EA           	jnc	0D7Ah

l0800_0D90:
0800:0D90 8B C3           	mov	ax,bx
0800:0D92 D1 E8           	shr	ax,1h
0800:0D94 D1 E8           	shr	ax,1h
0800:0D96 AA              	stosb
0800:0D97 8A E8           	mov	ch,al
0800:0D99 5B              	pop	bx
0800:0D9A 57              	push	di
0800:0D9B 4F              	dec	di
0800:0D9C 87 DF           	xchg	di,bx

l0800_0D9E:
0800:0D9E 3B FB           	cmp	di,bx
0800:0DA0 73 18           	jnc	0DBAh

l0800_0DA2:
0800:0DA2 26 8A 05        	mov	al,es:[di]
0800:0DA5 26 86 07        	xchg	es:[bx],al
0800:0DA8 AA              	stosb
0800:0DA9 4B              	dec	bx
0800:0DAA EB F2           	jmp	0D9Eh

l0800_0DAC:
0800:0DAC EB 5E           	jmp	0E0Ch
0800:0DAE                                           90                  . 

l0800_0DAF:
0800:0DAF 8A C5           	mov	al,ch
0800:0DB1 AA              	stosb
0800:0DB2 8B DA           	mov	bx,dx
0800:0DB4 D1 E3           	shl	bx,1h
0800:0DB6 D1 E3           	shl	bx,1h
0800:0DB8 EB D0           	jmp	0D8Ah

l0800_0DBA:
0800:0DBA 5F              	pop	di
0800:0DBB 81 FD 00 3C     	cmp	bp,3C00h
0800:0DBF 73 0B           	jnc	0DCCh

l0800_0DC1:
0800:0DC1 3E 89 56 00     	mov	ds:[bp+0h],dx
0800:0DC5 3E 88 6E 02     	mov	ds:[bp+2h],ch
0800:0DC9 83 C5 04        	add	bp,4h

l0800_0DCC:
0800:0DCC 5A              	pop	dx
0800:0DCD EB 8D           	jmp	0D5Ch

l0800_0DCF:
0800:0DCF AA              	stosb
0800:0DD0 8A E8           	mov	ch,al
0800:0DD2 81 FD 00 3C     	cmp	bp,3C00h
0800:0DD6 73 0B           	jnc	0DE3h

l0800_0DD8:
0800:0DD8 3E 89 56 00     	mov	ds:[bp+0h],dx
0800:0DDC 3E 88 6E 02     	mov	ds:[bp+2h],ch
0800:0DE0 83 C5 04        	add	bp,4h

l0800_0DE3:
0800:0DE3 8B D0           	mov	dx,ax
0800:0DE5 E9 74 FF        	jmp	0D5Ch

;; ReadWestwoodLzw12Code_0DE8: 0800:0DE8
;;   Called from:
;;     0800:0D54 (in DecodeWestwoodLzw12_0D1A)
;;     0800:0D63 (in DecodeWestwoodLzw12_0D1A)
ReadWestwoodLzw12Code_0DE8 proc
0800:0DE8 1E              	push	ds
0800:0DE9 2E 8E 1E 97 0C  	mov	ds,cs:[0C97h]
0800:0DEE 2E FE 06 99 0C  	inc	byte ptr cs:[0C99h]
0800:0DF3 2E F6 06 99 0C 01 	test	byte ptr cs:[0C99h],1h
0800:0DF9 75 08           	jnz	0E03h

l0800_0DFB:
0800:0DFB AD              	lodsw
0800:0DFC 86 E0           	xchg	al,ah
0800:0DFE 80 E4 0F        	and	ah,0Fh
0800:0E01 1F              	pop	ds
0800:0E02 C3              	ret

l0800_0E03:
0800:0E03 8B 04           	mov	ax,[si]
0800:0E05 86 E0           	xchg	al,ah
0800:0E07 D3 E8           	shr	ax,cl
0800:0E09 46              	inc	si
0800:0E0A 1F              	pop	ds
0800:0E0B C3              	ret

l0800_0E0C:
0800:0E0C 07              	pop	es
0800:0E0D 5A              	pop	dx
0800:0E0E 59              	pop	cx
0800:0E0F 5B              	pop	bx
0800:0E10 58              	pop	ax
0800:0E11 1F              	pop	ds
0800:0E12 5E              	pop	si
0800:0E13 5F              	pop	di
0800:0E14 5D              	pop	bp
0800:0E15 CB              	retf

;; DecodeWestwoodLzw14_0E16: 0800:0E16
;;   Called from:
;;     21E7:01D1 (in DecodeWestwoodPackedResource_00F4)
;;     21E7:01F4 (in DecodeWestwoodPackedResource_00F4)
DecodeWestwoodLzw14_0E16 proc
0800:0E16 55              	push	bp
0800:0E17 8B EC           	mov	bp,sp
0800:0E19 57              	push	di
0800:0E1A 56              	push	si
0800:0E1B 1E              	push	ds
0800:0E1C B8 84 41        	mov	ax,4184h
0800:0E1F 8E D8           	mov	ds,ax
0800:0E21 50              	push	ax
0800:0E22 53              	push	bx
0800:0E23 51              	push	cx
0800:0E24 52              	push	dx
0800:0E25 06              	push	es
0800:0E26 FC              	cld
0800:0E27 8E 46 08        	mov	es,[bp+8h]
0800:0E2A 8E 5E 06        	mov	ds,[bp+6h]
0800:0E2D 8B 6E 0A        	mov	bp,[bp+0Ah]
0800:0E30 33 FF           	xor	di,di
0800:0E32 BE 02 00        	mov	si,2h
0800:0E35 AD              	lodsw
0800:0E36 2E A3 93 0C     	mov	cs:[0C93h],ax
0800:0E3A AD              	lodsw
0800:0E3B AD              	lodsw
0800:0E3C 03 F0           	add	si,ax
0800:0E3E 2E 8C 1E 97 0C  	mov	cs:[0C97h],ds
0800:0E43 8E DD           	mov	ds,bp
0800:0E45 33 C9           	xor	cx,cx
0800:0E47 2E 88 2E 99 0C  	mov	cs:[0C99h],ch
0800:0E4C 33 ED           	xor	bp,bp
0800:0E4E E8 88 00        	call	0ED9h
0800:0E51 8B D0           	mov	dx,ax
0800:0E53 8A E8           	mov	ch,al
0800:0E55 AA              	stosb

l0800_0E56:
0800:0E56 2E 3B 3E 93 0C  	cmp	di,cs:[0C93h]
0800:0E5B 73 55           	jnc	0EB2h

l0800_0E5D:
0800:0E5D E8 79 00        	call	0ED9h
0800:0E60 0A E4           	or	ah,ah
0800:0E62 74 58           	jz	0EBCh

l0800_0E64:
0800:0E64 50              	push	ax
0800:0E65 57              	push	di
0800:0E66 FE CC           	dec	ah
0800:0E68 8B D8           	mov	bx,ax
0800:0E6A D1 E0           	shl	ax,1h
0800:0E6C 3B C5           	cmp	ax,bp
0800:0E6E 72 04           	jc	0E74h

l0800_0E70:
0800:0E70 73 43           	jnc	0EB5h

l0800_0E72:
0800:0E72 FE CF           	dec	bh

l0800_0E74:
0800:0E74 8A 87 00 7E     	mov	al,[bx+7E00h]
0800:0E78 AA              	stosb
0800:0E79 D1 E3           	shl	bx,1h
0800:0E7B 8B 1F           	mov	bx,[bx]

l0800_0E7D:
0800:0E7D 0A FF           	or	bh,bh
0800:0E7F 75 F1           	jnz	0E72h

l0800_0E81:
0800:0E81 8A C3           	mov	al,bl
0800:0E83 AA              	stosb
0800:0E84 8A E8           	mov	ch,al
0800:0E86 5B              	pop	bx
0800:0E87 57              	push	di
0800:0E88 4F              	dec	di
0800:0E89 87 DF           	xchg	di,bx

l0800_0E8B:
0800:0E8B 3B FB           	cmp	di,bx
0800:0E8D 73 0A           	jnc	0E99h

l0800_0E8F:
0800:0E8F 26 8A 05        	mov	al,es:[di]
0800:0E92 26 86 07        	xchg	es:[bx],al
0800:0E95 AA              	stosb
0800:0E96 4B              	dec	bx
0800:0E97 EB F2           	jmp	0E8Bh

l0800_0E99:
0800:0E99 5F              	pop	di
0800:0E9A 81 FD 00 7E     	cmp	bp,7E00h
0800:0E9E 73 0F           	jnc	0EAFh

l0800_0EA0:
0800:0EA0 3E 89 56 00     	mov	ds:[bp+0h],dx
0800:0EA4 8B DD           	mov	bx,bp
0800:0EA6 D1 EB           	shr	bx,1h
0800:0EA8 88 AF 00 7E     	mov	[bx+7E00h],ch
0800:0EAC 83 C5 02        	add	bp,2h

l0800_0EAF:
0800:0EAF 5A              	pop	dx
0800:0EB0 EB A4           	jmp	0E56h

l0800_0EB2:
0800:0EB2 EB 7F           	jmp	0F33h
0800:0EB4             90                                      .           

l0800_0EB5:
0800:0EB5 8A C5           	mov	al,ch
0800:0EB7 AA              	stosb
0800:0EB8 8B DA           	mov	bx,dx
0800:0EBA EB C1           	jmp	0E7Dh

l0800_0EBC:
0800:0EBC AA              	stosb
0800:0EBD 8A E8           	mov	ch,al
0800:0EBF 81 FD 00 7E     	cmp	bp,7E00h
0800:0EC3 73 0F           	jnc	0ED4h

l0800_0EC5:
0800:0EC5 3E 89 56 00     	mov	ds:[bp+0h],dx
0800:0EC9 8B DD           	mov	bx,bp
0800:0ECB D1 EB           	shr	bx,1h
0800:0ECD 88 AF 00 7E     	mov	[bx+7E00h],ch
0800:0ED1 83 C5 02        	add	bp,2h

l0800_0ED4:
0800:0ED4 8B D0           	mov	dx,ax
0800:0ED6 E9 7D FF        	jmp	0E56h

;; ReadWestwoodLzw14Code_0ED9: 0800:0ED9
;;   Called from:
;;     0800:0E4E (in DecodeWestwoodLzw14_0E16)
;;     0800:0E5D (in DecodeWestwoodLzw14_0E16)
ReadWestwoodLzw14Code_0ED9 proc
0800:0ED9 1E              	push	ds
0800:0EDA 2E 8E 1E 97 0C  	mov	ds,cs:[0C97h]
0800:0EDF 2E FE 06 99 0C  	inc	byte ptr cs:[0C99h]
0800:0EE4 2E 80 26 99 0C 03 	and	byte ptr cs:[0C99h],3h
0800:0EEA 74 21           	jz	0F0Dh

l0800_0EEC:
0800:0EEC 2E 8A 0E 99 0C  	mov	cl,cs:[0C99h]
0800:0EF1 80 F9 01        	cmp	cl,1h
0800:0EF4 74 1F           	jz	0F15h

l0800_0EF6:
0800:0EF6 80 F9 02        	cmp	cl,2h
0800:0EF9 74 25           	jz	0F20h

l0800_0EFB:
0800:0EFB AD              	lodsw
0800:0EFC 86 E0           	xchg	al,ah
0800:0EFE 8A 0C           	mov	cl,[si]
0800:0F00 D0 E1           	shl	cl,1h
0800:0F02 D1 D0           	rcl	ax,1h
0800:0F04 D0 E1           	shl	cl,1h
0800:0F06 D1 D0           	rcl	ax,1h
0800:0F08 80 E4 3F        	and	ah,3Fh
0800:0F0B 1F              	pop	ds
0800:0F0C C3              	ret

l0800_0F0D:
0800:0F0D AD              	lodsw
0800:0F0E 86 E0           	xchg	al,ah
0800:0F10 80 E4 3F        	and	ah,3Fh
0800:0F13 1F              	pop	ds
0800:0F14 C3              	ret

l0800_0F15:
0800:0F15 AC              	lodsb
0800:0F16 8A 24           	mov	ah,[si]
0800:0F18 86 E0           	xchg	al,ah
0800:0F1A D1 E8           	shr	ax,1h
0800:0F1C D1 E8           	shr	ax,1h
0800:0F1E 1F              	pop	ds
0800:0F1F C3              	ret

l0800_0F20:
0800:0F20 AD              	lodsw
0800:0F21 8A C8           	mov	cl,al
0800:0F23 8A 04           	mov	al,[si]
0800:0F25 D0 E9           	shr	cl,1h
0800:0F27 D1 D8           	rcr	ax,1h
0800:0F29 D0 E9           	shr	cl,1h
0800:0F2B D1 D8           	rcr	ax,1h
0800:0F2D D1 E8           	shr	ax,1h
0800:0F2F D1 E8           	shr	ax,1h
0800:0F31 1F              	pop	ds
0800:0F32 C3              	ret

l0800_0F33:
0800:0F33 07              	pop	es
0800:0F34 5A              	pop	dx
0800:0F35 59              	pop	cx
0800:0F36 5B              	pop	bx
0800:0F37 58              	pop	ax
0800:0F38 1F              	pop	ds
0800:0F39 5E              	pop	si
0800:0F3A 5F              	pop	di
0800:0F3B 5D              	pop	bp
0800:0F3C CB              	retf
0800:0F3D                                        55 8B EC              U..
0800:0F40 57 56 1E B8 84 41 8E D8 8B 76 06 8B 56 08 8B 7E WV...A...v..V..~
0800:0F50 0A 8B 46 0C FC 06 8E C0 8E DA B9 00 7D AC 8A E0 ..F.........}...
0800:0F60 D0 E8 D0 E8 D0 E8 D0 E8 25 0F 0F AB E2 EF 07 1F ........%.......
0800:0F70 5E 5F 5D CB                                     ^_].            

;; PackLowNibblesTo4Bpp_0F74: 0800:0F74
;;   Called from:
;;     0D73:336F (in LoadScreenAssetToWorkBuffer_32F4)
;;     0D73:4105 (in LoadGraphicsResourceToBuffers_4099)
PackLowNibblesTo4Bpp_0F74 proc
0800:0F74 55              	push	bp
0800:0F75 8B EC           	mov	bp,sp
0800:0F77 57              	push	di
0800:0F78 56              	push	si
0800:0F79 1E              	push	ds
0800:0F7A B8 84 41        	mov	ax,4184h
0800:0F7D 8E D8           	mov	ds,ax
0800:0F7F 8B 76 06        	mov	si,[bp+6h]
0800:0F82 8B 56 08        	mov	dx,[bp+8h]
0800:0F85 8B 7E 0A        	mov	di,[bp+0Ah]
0800:0F88 8B 46 0C        	mov	ax,[bp+0Ch]
0800:0F8B 06              	push	es
0800:0F8C 8E C0           	mov	es,ax
0800:0F8E 8E DA           	mov	ds,dx
0800:0F90 B9 00 7D        	mov	cx,7D00h

l0800_0F93:
0800:0F93 AD              	lodsw
0800:0F94 25 0F 0F        	and	ax,0F0Fh
0800:0F97 D0 E0           	shl	al,1h
0800:0F99 D0 E0           	shl	al,1h
0800:0F9B D0 E0           	shl	al,1h
0800:0F9D D0 E0           	shl	al,1h
0800:0F9F 0A C4           	or	al,ah
0800:0FA1 AA              	stosb
0800:0FA2 E2 EF           	loop	0F93h

l0800_0FA4:
0800:0FA4 07              	pop	es
0800:0FA5 1F              	pop	ds
0800:0FA6 5E              	pop	si
0800:0FA7 5F              	pop	di
0800:0FA8 5D              	pop	bp
0800:0FA9 CB              	retf
0800:0FAA                               55 8B EC 57 56 1E           U..WV.
0800:0FB0 B8 84 41 8E D8 06 8B 46 06 D1 E0 D1 E0 D1 E0 A3 ..A....F........
0800:0FC0 56 09 8B 46 08 A3 5A 09 8B 46 0A D1 E0 D1 E0 D1 V..F..Z..F......
0800:0FD0 E0 A3 58 09 8B 46 0C A3 5C 09 8B 46 0E D1 E0 D1 ..X..F..\..F....
0800:0FE0 E0 A3 5E 09 8B 46 10 A3 60 09 8B 76 12 8B 46 14 ..^..F..`..v..F.
0800:0FF0 A3 54 09 8B 7E 16 8B 46 18 8E C0 A1 5A 09 BA 40 .T..~..F....Z..@
0800:1000 01 F7 E2 03 06 56 09 03 F0 A1 5C 09 BA 40 01 F7 .....V....\..@..
0800:1010 E2 03 06 58 09 03 F8 BD 40 01 8B 16 60 09 8B 1E ...X....@...`...
0800:1020 5E 09 A1 54 09 8E D8 8B CB F3 A5 8B C3 D1 E0 2B ^..T...........+
0800:1030 F0 2B F8 03 F5 03 FD 4A 75 ED 07 1F 5E 5F 5D CB .+.....Ju...^_].

l0800_1040:
0800:1040 55              	push	bp
0800:1041 8B EC           	mov	bp,sp
0800:1043 57              	push	di
0800:1044 56              	push	si
0800:1045 1E              	push	ds
0800:1046 B8 84 41        	mov	ax,4184h
0800:1049 8E D8           	mov	ds,ax
0800:104B 06              	push	es
0800:104C 8B 3E 9B 0B     	mov	di,[0B9Bh]
0800:1050 A1 9D 0B        	mov	ax,[0B9Dh]
0800:1053 8E C0           	mov	es,ax
0800:1055 8B 76 06        	mov	si,[bp+6h]
0800:1058 8B 46 08        	mov	ax,[bp+8h]
0800:105B 8B 5E 0A        	mov	bx,[bp+0Ah]
0800:105E D1 E3           	shl	bx,1h
0800:1060 D1 E3           	shl	bx,1h
0800:1062 D1 E3           	shl	bx,1h
0800:1064 03 C3           	add	ax,bx
0800:1066 A3 62 09        	mov	[0962h],ax
0800:1069 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:106E 74 05           	jz	1075h

l0800_1070:
0800:1070 72 48           	jc	10BAh

l0800_1072:
0800:1072 EB 71           	jmp	10E5h
0800:1074             90                                      .           

l0800_1075:
0800:1075 8B 46 0E        	mov	ax,[bp+0Eh]
0800:1078 24 FC           	and	al,0FCh
0800:107A BA 28 00        	mov	dx,28h
0800:107D F6 E2           	mul	dl
0800:107F 8B 56 0C        	mov	dx,[bp+0Ch]
0800:1082 D1 E2           	shl	dx,1h
0800:1084 D1 E2           	shl	dx,1h
0800:1086 03 C2           	add	ax,dx
0800:1088 03 F8           	add	di,ax
0800:108A BA 04 00        	mov	dx,4h
0800:108D 8B DA           	mov	bx,dx
0800:108F BD F8 1F        	mov	bp,1FF8h
0800:1092 8E 1E 62 09     	mov	ds,[0962h]
0800:1096 FC              	cld

l0800_1097:
0800:1097 8B CB           	mov	cx,bx

l0800_1099:
0800:1099 F3 A5           	rep movsw

l0800_109B:
0800:109B 03 FD           	add	di,bp
0800:109D 8B CB           	mov	cx,bx

l0800_109F:
0800:109F F3 A5           	rep movsw

l0800_10A1:
0800:10A1 03 FD           	add	di,bp
0800:10A3 8B CB           	mov	cx,bx

l0800_10A5:
0800:10A5 F3 A5           	rep movsw

l0800_10A7:
0800:10A7 03 FD           	add	di,bp
0800:10A9 8B CB           	mov	cx,bx

l0800_10AB:
0800:10AB F3 A5           	rep movsw

l0800_10AD:
0800:10AD 81 EF 68 5F     	sub	di,5F68h
0800:10B1 4A              	dec	dx
0800:10B2 75 E3           	jnz	1097h

l0800_10B4:
0800:10B4 07              	pop	es
0800:10B5 1F              	pop	ds
0800:10B6 5E              	pop	si
0800:10B7 5F              	pop	di
0800:10B8 5D              	pop	bp
0800:10B9 CB              	retf

l0800_10BA:
0800:10BA 8B 46 0E        	mov	ax,[bp+0Eh]
0800:10BD 24 FE           	and	al,0FEh
0800:10BF BA 28 00        	mov	dx,28h
0800:10C2 F6 E2           	mul	dl
0800:10C4 8B 56 0C        	mov	dx,[bp+0Ch]
0800:10C7 D1 E2           	shl	dx,1h
0800:10C9 03 C2           	add	ax,dx
0800:10CB 03 F8           	add	di,ax
0800:10CD B9 08 00        	mov	cx,8h
0800:10D0 8E 1E 62 09     	mov	ds,[0962h]
0800:10D4 FC              	cld

l0800_10D5:
0800:10D5 A5              	movsw
0800:10D6 A5              	movsw
0800:10D7 81 C7 FC 1F     	add	di,1FFCh
0800:10DB A5              	movsw
0800:10DC A5              	movsw
0800:10DD 81 EF B4 1F     	sub	di,1FB4h
0800:10E1 E2 F2           	loop	10D5h

l0800_10E3:
0800:10E3 EB CF           	jmp	10B4h

l0800_10E5:
0800:10E5 8B 46 0E        	mov	ax,[bp+0Eh]
0800:10E8 BA 40 01        	mov	dx,140h
0800:10EB F7 E2           	mul	dx
0800:10ED 8B 56 0C        	mov	dx,[bp+0Ch]
0800:10F0 D1 E2           	shl	dx,1h
0800:10F2 D1 E2           	shl	dx,1h
0800:10F4 D1 E2           	shl	dx,1h
0800:10F6 03 C2           	add	ax,dx
0800:10F8 03 F8           	add	di,ax
0800:10FA 8E 1E 62 09     	mov	ds,[0962h]
0800:10FE FC              	cld
0800:10FF BA 10 00        	mov	dx,10h

l0800_1102:
0800:1102 B9 08 00        	mov	cx,8h

l0800_1105:
0800:1105 AC              	lodsb
0800:1106 8A E0           	mov	ah,al
0800:1108 25 F0 0F        	and	ax,0FF0h
0800:110B AB              	stosw
0800:110C E2 F7           	loop	1105h

l0800_110E:
0800:110E 81 C7 30 01     	add	di,130h
0800:1112 4A              	dec	dx
0800:1113 75 ED           	jnz	1102h

l0800_1115:
0800:1115 EB 9D           	jmp	10B4h

l0800_1117:
0800:1117 55              	push	bp
0800:1118 8B EC           	mov	bp,sp
0800:111A 57              	push	di
0800:111B 56              	push	si
0800:111C 1E              	push	ds
0800:111D B8 84 41        	mov	ax,4184h
0800:1120 8E D8           	mov	ds,ax
0800:1122 06              	push	es
0800:1123 BA CE 03        	mov	dx,3CEh
0800:1126 B8 05 02        	mov	ax,205h
0800:1129 EE              	out	dx,al
0800:112A 42              	inc	dx
0800:112B 8A C4           	mov	al,ah
0800:112D EE              	out	dx,al
0800:112E 4A              	dec	dx
0800:112F B8 08 00        	mov	ax,8h
0800:1132 EE              	out	dx,al
0800:1133 42              	inc	dx
0800:1134 8A C4           	mov	al,ah
0800:1136 EE              	out	dx,al
0800:1137 8B 46 0A        	mov	ax,[bp+0Ah]
0800:113A B9 05 00        	mov	cx,5h
0800:113D D3 E0           	shl	ax,cl
0800:113F 8B F0           	mov	si,ax
0800:1141 8B 4E 0C        	mov	cx,[bp+0Ch]
0800:1144 8B 46 0E        	mov	ax,[bp+0Eh]
0800:1147 BA 28 00        	mov	dx,28h
0800:114A F6 E2           	mul	dl
0800:114C 03 C1           	add	ax,cx
0800:114E 8B F8           	mov	di,ax
0800:1150 03 3E 9B 0B     	add	di,[0B9Bh]
0800:1154 A1 9D 0B        	mov	ax,[0B9Dh]
0800:1157 8E C0           	mov	es,ax
0800:1159 B9 10 00        	mov	cx,10h
0800:115C B8 00 A4        	mov	ax,0A400h
0800:115F 8E D8           	mov	ds,ax
0800:1161 FC              	cld

l0800_1162:
0800:1162 A4              	movsb
0800:1163 A4              	movsb
0800:1164 83 C7 26        	add	di,26h
0800:1167 E2 F9           	loop	1162h

l0800_1169:
0800:1169 07              	pop	es
0800:116A 1F              	pop	ds
0800:116B 5E              	pop	si
0800:116C 5F              	pop	di
0800:116D 5D              	pop	bp
0800:116E CB              	retf

;; DrawTacticalTileSprite_116F: 0800:116F
;;   Called from:
;;     2007:041E (in DrawTacticalViewportCell_0328)
;;     2007:1CE4 (in DrawTacticalTileSpriteForAdapter_1CBD)
DrawTacticalTileSprite_116F proc
0800:116F 8C DB           	mov	bx,ds
0800:1171 B8 84 41        	mov	ax,4184h
0800:1174 8E D8           	mov	ds,ax
0800:1176 A1 4C 0E        	mov	ax,[0E4Ch]
0800:1179 8E DB           	mov	ds,bx
0800:117B 3D 02 00        	cmp	ax,2h
0800:117E 74 97           	jz	1117h

l0800_1180:
0800:1180 EA 40 10 00 08  	jmp	far 0800h:1040h

;; EncodeDisplayBackingRows_1185: 0800:1185
;;   Called from:
;;     2FEA:00AB (in BuildPlanarDisplayBackingBuffer_000A)
;;     2FEA:00EA (in BuildPlanarDisplayBackingBuffer_000A)
;;     2FEA:013F (in BuildPlanarDisplayBackingBuffer_000A)
EncodeDisplayBackingRows_1185 proc
0800:1185 55              	push	bp
0800:1186 8B EC           	mov	bp,sp
0800:1188 57              	push	di
0800:1189 56              	push	si
0800:118A 1E              	push	ds
0800:118B B8 84 41        	mov	ax,4184h
0800:118E 8E D8           	mov	ds,ax
0800:1190 06              	push	es
0800:1191 8B 76 06        	mov	si,[bp+6h]
0800:1194 8B 46 08        	mov	ax,[bp+8h]
0800:1197 A3 64 09        	mov	[0964h],ax
0800:119A 8B 7E 0A        	mov	di,[bp+0Ah]
0800:119D 89 3E 66 09     	mov	[0966h],di
0800:11A1 8B 46 0C        	mov	ax,[bp+0Ch]
0800:11A4 8E C0           	mov	es,ax
0800:11A6 8B 56 0E        	mov	dx,[bp+0Eh]
0800:11A9 8B 46 10        	mov	ax,[bp+10h]
0800:11AC A2 68 09        	mov	[0968h],al
0800:11AF 8B 5E 12        	mov	bx,[bp+12h]
0800:11B2 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:11B7 74 35           	jz	11EEh

l0800_11B9:
0800:11B9 8A 36 68 09     	mov	dh,[0968h]
0800:11BD 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:11C2 74 16           	jz	11DAh

l0800_11C4:
0800:11C4 8E 1E 64 09     	mov	ds,[0964h]

l0800_11C8:
0800:11C8 8A CA           	mov	cl,dl
0800:11CA 32 ED           	xor	ch,ch

l0800_11CC:
0800:11CC F3 A5           	rep movsw

l0800_11CE:
0800:11CE 03 F3           	add	si,bx
0800:11D0 FE CE           	dec	dh
0800:11D2 75 F4           	jnz	11C8h

l0800_11D4:
0800:11D4 07              	pop	es
0800:11D5 1F              	pop	ds
0800:11D6 5E              	pop	si
0800:11D7 5F              	pop	di
0800:11D8 5D              	pop	bp
0800:11D9 CB              	retf

l0800_11DA:
0800:11DA 8E 1E 64 09     	mov	ds,[0964h]

l0800_11DE:
0800:11DE 8A CA           	mov	cl,dl
0800:11E0 32 ED           	xor	ch,ch

l0800_11E2:
0800:11E2 AD              	lodsw
0800:11E3 AA              	stosb
0800:11E4 E2 FC           	loop	11E2h

l0800_11E6:
0800:11E6 03 F3           	add	si,bx
0800:11E8 FE CE           	dec	dh
0800:11EA 75 F2           	jnz	11DEh

l0800_11EC:
0800:11EC 74 E6           	jz	11D4h

l0800_11EE:
0800:11EE 1E              	push	ds
0800:11EF 8B EE           	mov	bp,si
0800:11F1 89 16 69 09     	mov	[0969h],dx

l0800_11F5:
0800:11F5 8B 16 69 09     	mov	dx,[0969h]
0800:11F9 88 16 6B 09     	mov	[096Bh],dl

l0800_11FD:
0800:11FD 8B F5           	mov	si,bp
0800:11FF 1E              	push	ds
0800:1200 A1 64 09        	mov	ax,[0964h]
0800:1203 8E D8           	mov	ds,ax
0800:1205 AD              	lodsw
0800:1206 86 E0           	xchg	al,ah
0800:1208 8B D8           	mov	bx,ax
0800:120A AD              	lodsw
0800:120B 86 E0           	xchg	al,ah
0800:120D 8B EE           	mov	bp,si
0800:120F 1F              	pop	ds
0800:1210 BE 6C 09        	mov	si,96Ch
0800:1213 B9 10 00        	mov	cx,10h

l0800_1216:
0800:1216 88 2C           	mov	[si],ch
0800:1218 46              	inc	si
0800:1219 E2 FB           	loop	1216h

l0800_121B:
0800:121B B5 80           	mov	ch,80h

l0800_121D:
0800:121D E8 7E 00        	call	129Eh
0800:1220 BE 6C 09        	mov	si,96Ch
0800:1223 03 F2           	add	si,dx
0800:1225 08 2C           	or	[si],ch
0800:1227 D0 ED           	shr	ch,1h
0800:1229 74 09           	jz	1234h

l0800_122B:
0800:122B 80 FD 08        	cmp	ch,8h
0800:122E 75 ED           	jnz	121Dh

l0800_1230:
0800:1230 8B D8           	mov	bx,ax
0800:1232 EB E9           	jmp	121Dh

l0800_1234:
0800:1234 BE 6C 09        	mov	si,96Ch
0800:1237 BB 0F 00        	mov	bx,0Fh
0800:123A 32 C0           	xor	al,al

l0800_123C:
0800:123C 0A 00           	or	al,[bx+si]
0800:123E 4B              	dec	bx
0800:123F 75 FB           	jnz	123Ch

l0800_1241:
0800:1241 0A C0           	or	al,al
0800:1243 74 15           	jz	125Ah

l0800_1245:
0800:1245 B9 01 00        	mov	cx,1h
0800:1248 46              	inc	si

l0800_1249:
0800:1249 AC              	lodsb
0800:124A 0A C0           	or	al,al
0800:124C 74 04           	jz	1252h

l0800_124E:
0800:124E AA              	stosb
0800:124F 8A C1           	mov	al,cl
0800:1251 AA              	stosb

l0800_1252:
0800:1252 41              	inc	cx
0800:1253 83 F9 10        	cmp	cx,10h
0800:1256 72 F1           	jc	1249h

l0800_1258:
0800:1258 73 02           	jnc	125Ch

l0800_125A:
0800:125A AA              	stosb
0800:125B AA              	stosb

l0800_125C:
0800:125C 4F              	dec	di
0800:125D B0 80           	mov	al,80h
0800:125F 26 08 05        	or	es:[di],al
0800:1262 47              	inc	di
0800:1263 FE 0E 6B 09     	dec	byte ptr [096Bh]
0800:1267 75 94           	jnz	11FDh

l0800_1269:
0800:1269 4F              	dec	di
0800:126A B0 40           	mov	al,40h
0800:126C 26 08 05        	or	es:[di],al
0800:126F 47              	inc	di
0800:1270 81 C5 A0 00     	add	bp,0A0h
0800:1274 2B 2E 69 09     	sub	bp,[0969h]
0800:1278 2B 2E 69 09     	sub	bp,[0969h]
0800:127C 2B 2E 69 09     	sub	bp,[0969h]
0800:1280 2B 2E 69 09     	sub	bp,[0969h]
0800:1284 FE 0E 68 09     	dec	byte ptr [0968h]
0800:1288 74 03           	jz	128Dh

l0800_128A:
0800:128A E9 68 FF        	jmp	11F5h

l0800_128D:
0800:128D 4F              	dec	di
0800:128E B0 20           	mov	al,20h
0800:1290 26 08 05        	or	es:[di],al
0800:1293 1F              	pop	ds
0800:1294 47              	inc	di
0800:1295 8B C7           	mov	ax,di
0800:1297 2B 06 66 09     	sub	ax,[0966h]
0800:129B E9 36 FF        	jmp	11D4h

;; ExtractHighNibbleAndShiftLeft_129E: 0800:129E
;;   Called from:
;;     0800:121D (in EncodeDisplayBackingRows_1185)
ExtractHighNibbleAndShiftLeft_129E proc
0800:129E 33 D2           	xor	dx,dx
0800:12A0 D1 E3           	shl	bx,1h
0800:12A2 D0 D2           	rcl	dl,1h
0800:12A4 D1 E3           	shl	bx,1h
0800:12A6 D0 D2           	rcl	dl,1h
0800:12A8 D1 E3           	shl	bx,1h
0800:12AA D0 D2           	rcl	dl,1h
0800:12AC D1 E3           	shl	bx,1h
0800:12AE D0 D2           	rcl	dl,1h
0800:12B0 C3              	ret
l0800_12B1	db	0xFF
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0xF0
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
db	0x0F
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
l0800_13B1	db	0xFF
db	0xFC
db	0xFC
db	0xFC
db	0xF3
db	0xF0
db	0xF0
db	0xF0
db	0xF3
db	0xF0
db	0xF0
db	0xF0
db	0xF3
db	0xF0
db	0xF0
db	0xF0
db	0xCF
db	0xCC
db	0xCC
db	0xCC
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xCF
db	0xCC
db	0xCC
db	0xCC
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xCF
db	0xCC
db	0xCC
db	0xCC
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0xC3
db	0xC0
db	0xC0
db	0xC0
db	0x3F
db	0x3C
db	0x3C
db	0x3C
db	0x33
db	0x30
db	0x30
db	0x30
db	0x33
db	0x30
db	0x30
db	0x30
db	0x33
db	0x30
db	0x30
db	0x30
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x3F
db	0x3C
db	0x3C
db	0x3C
db	0x33
db	0x30
db	0x30
db	0x30
db	0x33
db	0x30
db	0x30
db	0x30
db	0x33
db	0x30
db	0x30
db	0x30
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x3F
db	0x3C
db	0x3C
db	0x3C
db	0x33
db	0x30
db	0x30
db	0x30
db	0x33
db	0x30
db	0x30
db	0x30
db	0x33
db	0x30
db	0x30
db	0x30
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x0F
db	0x0C
db	0x0C
db	0x0C
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
db	0x03
db	0x00
db	0x00
db	0x00
0800:14B1    00 00 00 00 00 00                             ......         

;; DrawCgaTandyEncodedSprite_14B7: 0800:14B7
;;   Called from:
;;     0D73:5743 (in DrawClippedSprite_566E)
;;     3005:00B6 (in DrawTacticalClippedSprite_0008)
DrawCgaTandyEncodedSprite_14B7 proc
0800:14B7 55              	push	bp
0800:14B8 8B EC           	mov	bp,sp
0800:14BA 57              	push	di
0800:14BB 56              	push	si
0800:14BC 1E              	push	ds
0800:14BD B8 84 41        	mov	ax,4184h
0800:14C0 8E D8           	mov	ds,ax
0800:14C2 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:14C7 75 03           	jnz	14CCh

l0800_14C9:
0800:14C9 E9 8E 02        	jmp	175Ah

l0800_14CC:
0800:14CC 06              	push	es
0800:14CD 8B 7E 06        	mov	di,[bp+6h]
0800:14D0 8B 46 08        	mov	ax,[bp+8h]
0800:14D3 8E C0           	mov	es,ax
0800:14D5 8B 76 0A        	mov	si,[bp+0Ah]
0800:14D8 8B 46 0C        	mov	ax,[bp+0Ch]
0800:14DB A3 84 09        	mov	[0984h],ax
0800:14DE 8B 5E 0E        	mov	bx,[bp+0Eh]
0800:14E1 8B 46 10        	mov	ax,[bp+10h]
0800:14E4 A3 8A 09        	mov	[098Ah],ax
0800:14E7 A1 7C 09        	mov	ax,[097Ch]
0800:14EA 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:14EF 74 02           	jz	14F3h

l0800_14F1:
0800:14F1 D1 E0           	shl	ax,1h

l0800_14F3:
0800:14F3 D1 E0           	shl	ax,1h
0800:14F5 D1 E0           	shl	ax,1h
0800:14F7 03 F8           	add	di,ax
0800:14F9 C6 06 94 09 00  	mov	byte ptr [0994h],0h
0800:14FE 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:1503 74 06           	jz	150Bh

l0800_1505:
0800:1505 D1 FB           	sar	bx,1h
0800:1507 D0 16 94 09     	rcl	byte ptr [0994h],1h

l0800_150B:
0800:150B 2B D8           	sub	bx,ax
0800:150D 89 1E 88 09     	mov	[0988h],bx
0800:1511 A1 7E 09        	mov	ax,[097Eh]
0800:1514 2B 06 7C 09     	sub	ax,[097Ch]
0800:1518 A3 95 09        	mov	[0995h],ax
0800:151B 1E              	push	ds
0800:151C 46              	inc	si
0800:151D A1 84 09        	mov	ax,[0984h]
0800:1520 8E D8           	mov	ds,ax
0800:1522 AD              	lodsw
0800:1523 46              	inc	si
0800:1524 1F              	pop	ds
0800:1525 FE C0           	inc	al
0800:1527 50              	push	ax
0800:1528 25 FF 00        	and	ax,0FFh
0800:152B A3 8C 09        	mov	[098Ch],ax
0800:152E 58              	pop	ax
0800:152F 86 C4           	xchg	ah,al
0800:1531 25 FF 00        	and	ax,0FFh
0800:1534 D1 E0           	shl	ax,1h
0800:1536 D1 E0           	shl	ax,1h
0800:1538 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:153D 74 03           	jz	1542h

l0800_153F:
0800:153F E9 BB 04        	jmp	19FDh

l0800_1542:
0800:1542 A3 8E 09        	mov	[098Eh],ax
0800:1545 A3 90 09        	mov	[0990h],ax
0800:1548 A1 8A 09        	mov	ax,[098Ah]
0800:154B 2B 06 80 09     	sub	ax,[0980h]
0800:154F 79 26           	jns	1577h

l0800_1551:
0800:1551 F7 D8           	neg	ax
0800:1553 3B 06 8C 09     	cmp	ax,[098Ch]
0800:1557 73 4C           	jnc	15A5h

l0800_1559:
0800:1559 8B 16 8E 09     	mov	dx,[098Eh]
0800:155D F6 E2           	mul	dl
0800:155F 03 F0           	add	si,ax
0800:1561 A1 8C 09        	mov	ax,[098Ch]
0800:1564 03 06 8A 09     	add	ax,[098Ah]
0800:1568 2B 06 80 09     	sub	ax,[0980h]
0800:156C 78 6E           	js	15DCh

l0800_156E:
0800:156E A3 8C 09        	mov	[098Ch],ax
0800:1571 A1 80 09        	mov	ax,[0980h]
0800:1574 A3 8A 09        	mov	[098Ah],ax

l0800_1577:
0800:1577 A1 82 09        	mov	ax,[0982h]
0800:157A 2B 06 8A 09     	sub	ax,[098Ah]
0800:157E 78 5C           	js	15DCh

l0800_1580:
0800:1580 74 5A           	jz	15DCh

l0800_1582:
0800:1582 3B 06 8C 09     	cmp	ax,[098Ch]
0800:1586 73 03           	jnc	158Bh

l0800_1588:
0800:1588 A3 8C 09        	mov	[098Ch],ax

l0800_158B:
0800:158B 2E C7 06 B3 14 00 00 	mov	word ptr cs:[14B3h],0h
0800:1592 A1 88 09        	mov	ax,[0988h]
0800:1595 0B C0           	or	ax,ax
0800:1597 79 1A           	jns	15B3h

l0800_1599:
0800:1599 01 06 8E 09     	add	[098Eh],ax
0800:159D F7 D8           	neg	ax
0800:159F 03 F0           	add	si,ax
0800:15A1 3B 06 90 09     	cmp	ax,[0990h]

l0800_15A5:
0800:15A5 73 35           	jnc	15DCh

l0800_15A7:
0800:15A7 33 C0           	xor	ax,ax
0800:15A9 A3 88 09        	mov	[0988h],ax
0800:15AC 2E C7 06 B3 14 01 00 	mov	word ptr cs:[14B3h],1h

l0800_15B3:
0800:15B3 A1 95 09        	mov	ax,[0995h]
0800:15B6 D1 E0           	shl	ax,1h
0800:15B8 D1 E0           	shl	ax,1h
0800:15BA 2B 06 88 09     	sub	ax,[0988h]
0800:15BE 78 1C           	js	15DCh

l0800_15C0:
0800:15C0 74 1A           	jz	15DCh

l0800_15C2:
0800:15C2 2E C7 06 B1 14 00 00 	mov	word ptr cs:[14B1h],0h
0800:15C9 3B 06 8E 09     	cmp	ax,[098Eh]
0800:15CD 73 10           	jnc	15DFh

l0800_15CF:
0800:15CF A3 8E 09        	mov	[098Eh],ax
0800:15D2 2E C7 06 B1 14 01 00 	mov	word ptr cs:[14B1h],1h
0800:15D9 EB 04           	jmp	15DFh
0800:15DB                                  90                        .    

l0800_15DC:
0800:15DC E9 86 00        	jmp	1665h

l0800_15DF:
0800:15DF A1 8A 09        	mov	ax,[098Ah]
0800:15E2 8B D8           	mov	bx,ax
0800:15E4 25 FC 00        	and	ax,0FCh
0800:15E7 D1 E0           	shl	ax,1h
0800:15E9 D1 E0           	shl	ax,1h
0800:15EB D1 E0           	shl	ax,1h
0800:15ED 8B D0           	mov	dx,ax
0800:15EF D1 E0           	shl	ax,1h
0800:15F1 D1 E0           	shl	ax,1h
0800:15F3 03 C2           	add	ax,dx
0800:15F5 03 06 88 09     	add	ax,[0988h]
0800:15F9 83 E3 03        	and	bx,3h
0800:15FC 74 07           	jz	1605h

l0800_15FE:
0800:15FE 8B CB           	mov	cx,bx

l0800_1600:
0800:1600 80 C4 20        	add	ah,20h
0800:1603 E2 FB           	loop	1600h

l0800_1605:
0800:1605 03 F8           	add	di,ax
0800:1607 B8 00 20        	mov	ax,2000h
0800:160A 2B 06 8E 09     	sub	ax,[098Eh]
0800:160E A3 8A 09        	mov	[098Ah],ax
0800:1611 8B 16 84 09     	mov	dx,[0984h]
0800:1615 8A E3           	mov	ah,bl
0800:1617 33 DB           	xor	bx,bx
0800:1619 80 3E 94 09 01  	cmp	byte ptr [0994h],1h
0800:161E 74 55           	jz	1675h

l0800_1620:
0800:1620 83 3E 97 09 01  	cmp	word ptr [0997h],1h
0800:1625 75 03           	jnz	162Ah

l0800_1627:
0800:1627 E9 F4 00        	jmp	171Eh

l0800_162A:
0800:162A 8B 0E 8E 09     	mov	cx,[098Eh]
0800:162E 8C DD           	mov	bp,ds
0800:1630 8E DA           	mov	ds,dx

l0800_1632:
0800:1632 AC              	lodsb
0800:1633 0A C0           	or	al,al
0800:1635 74 39           	jz	1670h

l0800_1637:
0800:1637 8A D8           	mov	bl,al
0800:1639 2E 8A 9F B1 12  	mov	bl,cs:[bx+12B1h]
0800:163E 26 22 1D        	and	bl,es:[di]
0800:1641 0A C3           	or	al,bl
0800:1643 AA              	stosb
0800:1644 E2 EC           	loop	1632h

l0800_1646:
0800:1646 8E DD           	mov	ds,bp
0800:1648 03 36 90 09     	add	si,[0990h]
0800:164C 2B 36 8E 09     	sub	si,[098Eh]
0800:1650 03 3E 8A 09     	add	di,[098Ah]
0800:1654 FE C4           	inc	ah
0800:1656 80 E4 03        	and	ah,3h
0800:1659 75 04           	jnz	165Fh

l0800_165B:
0800:165B 81 EF 60 7F     	sub	di,7F60h

l0800_165F:
0800:165F FF 0E 8C 09     	dec	word ptr [098Ch]
0800:1663 75 C5           	jnz	162Ah

l0800_1665:
0800:1665 07              	pop	es
0800:1666 1F              	pop	ds
0800:1667 5E              	pop	si
0800:1668 5F              	pop	di
0800:1669 5D              	pop	bp
0800:166A CB              	retf

l0800_166B:
0800:166B AC              	lodsb
0800:166C 0A C0           	or	al,al
0800:166E 75 C7           	jnz	1637h

l0800_1670:
0800:1670 47              	inc	di
0800:1671 E2 F8           	loop	166Bh

l0800_1673:
0800:1673 EB D1           	jmp	1646h

l0800_1675:
0800:1675 86 E0           	xchg	al,ah
0800:1677 A3 92 09        	mov	[0992h],ax

l0800_167A:
0800:167A 8B 0E 8E 09     	mov	cx,[098Eh]
0800:167E 8C DD           	mov	bp,ds
0800:1680 8E DA           	mov	ds,dx
0800:1682 2E 83 3E B3 14 00 	cmp	word ptr cs:[14B3h],0h
0800:1688 74 2B           	jz	16B5h

l0800_168A:
0800:168A 8A 44 FF        	mov	al,[si-1h]
0800:168D 32 E4           	xor	ah,ah
0800:168F 8B D8           	mov	bx,ax
0800:1691 2E 8A 9F B1 12  	mov	bl,cs:[bx+12B1h]
0800:1696 86 E0           	xchg	al,ah
0800:1698 86 FB           	xchg	bl,bh
0800:169A D1 E8           	shr	ax,1h
0800:169C D1 E8           	shr	ax,1h
0800:169E D1 E8           	shr	ax,1h
0800:16A0 D1 E8           	shr	ax,1h
0800:16A2 D1 EB           	shr	bx,1h
0800:16A4 D1 EB           	shr	bx,1h
0800:16A6 D1 EB           	shr	bx,1h
0800:16A8 D1 EB           	shr	bx,1h
0800:16AA 80 CB 0F        	or	bl,0Fh
0800:16AD 26 22 1D        	and	bl,es:[di]
0800:16B0 0A C3           	or	al,bl
0800:16B2 26 88 25        	mov	es:[di],ah

l0800_16B5:
0800:16B5 AC              	lodsb
0800:16B6 32 E4           	xor	ah,ah
0800:16B8 8B D8           	mov	bx,ax
0800:16BA 2E 8A 9F B1 12  	mov	bl,cs:[bx+12B1h]
0800:16BF 86 E0           	xchg	al,ah
0800:16C1 86 FB           	xchg	bl,bh
0800:16C3 D1 E8           	shr	ax,1h
0800:16C5 D1 E8           	shr	ax,1h
0800:16C7 D1 E8           	shr	ax,1h
0800:16C9 D1 E8           	shr	ax,1h
0800:16CB D1 EB           	shr	bx,1h
0800:16CD D1 EB           	shr	bx,1h
0800:16CF D1 EB           	shr	bx,1h
0800:16D1 D1 EB           	shr	bx,1h
0800:16D3 81 CB 0F F0     	or	bx,0F00Fh
0800:16D7 26 22 3D        	and	bh,es:[di]
0800:16DA 0A E7           	or	ah,bh
0800:16DC 86 E0           	xchg	al,ah
0800:16DE AA              	stosb
0800:16DF 83 F9 01        	cmp	cx,1h
0800:16E2 74 30           	jz	1714h

l0800_16E4:
0800:16E4 26 22 1D        	and	bl,es:[di]
0800:16E7 0A E3           	or	ah,bl
0800:16E9 26 88 25        	mov	es:[di],ah
0800:16EC E2 C7           	loop	16B5h

l0800_16EE:
0800:16EE 8E DD           	mov	ds,bp
0800:16F0 03 36 90 09     	add	si,[0990h]
0800:16F4 2B 36 8E 09     	sub	si,[098Eh]
0800:16F8 03 3E 8A 09     	add	di,[098Ah]
0800:16FC FF 06 92 09     	inc	word ptr [0992h]
0800:1700 83 26 92 09 03  	and	word ptr [0992h],3h
0800:1705 75 04           	jnz	170Bh

l0800_1707:
0800:1707 81 EF 60 7F     	sub	di,7F60h

l0800_170B:
0800:170B FF 0E 8C 09     	dec	word ptr [098Ch]
0800:170F 74 46           	jz	1757h

l0800_1711:
0800:1711 E9 66 FF        	jmp	167Ah

l0800_1714:
0800:1714 2E 83 3E B1 14 00 	cmp	word ptr cs:[14B1h],0h
0800:171A 74 C8           	jz	16E4h

l0800_171C:
0800:171C EB D0           	jmp	16EEh

l0800_171E:
0800:171E 8B 0E 8E 09     	mov	cx,[098Eh]
0800:1722 8C DD           	mov	bp,ds
0800:1724 8E DA           	mov	ds,dx

l0800_1726:
0800:1726 AC              	lodsb
0800:1727 32 FF           	xor	bh,bh
0800:1729 26 8A 1D        	mov	bl,es:[di]
0800:172C 2E 8A BF B1 12  	mov	bh,cs:[bx+12B1h]
0800:1731 22 C7           	and	al,bh
0800:1733 0A C3           	or	al,bl
0800:1735 AA              	stosb
0800:1736 E2 EE           	loop	1726h

l0800_1738:
0800:1738 8E DD           	mov	ds,bp
0800:173A 03 36 90 09     	add	si,[0990h]
0800:173E 2B 36 8E 09     	sub	si,[098Eh]
0800:1742 03 3E 8A 09     	add	di,[098Ah]
0800:1746 FE C4           	inc	ah
0800:1748 80 E4 03        	and	ah,3h
0800:174B 75 04           	jnz	1751h

l0800_174D:
0800:174D 81 EF 60 7F     	sub	di,7F60h

l0800_1751:
0800:1751 FF 0E 8C 09     	dec	word ptr [098Ch]
0800:1755 75 C7           	jnz	171Eh

l0800_1757:
0800:1757 E9 0B FF        	jmp	1665h

l0800_175A:
0800:175A 06              	push	es
0800:175B 8B 7E 06        	mov	di,[bp+6h]
0800:175E 8B 46 08        	mov	ax,[bp+8h]
0800:1761 8E C0           	mov	es,ax
0800:1763 8B 76 0A        	mov	si,[bp+0Ah]
0800:1766 8B 46 0C        	mov	ax,[bp+0Ch]
0800:1769 A3 84 09        	mov	[0984h],ax
0800:176C 8B 5E 0E        	mov	bx,[bp+0Eh]
0800:176F 8B 46 10        	mov	ax,[bp+10h]
0800:1772 A3 8A 09        	mov	[098Ah],ax
0800:1775 A1 7C 09        	mov	ax,[097Ch]
0800:1778 D1 E0           	shl	ax,1h
0800:177A 03 F8           	add	di,ax
0800:177C 88 1E 94 09     	mov	[0994h],bl
0800:1780 80 26 94 09 03  	and	byte ptr [0994h],3h
0800:1785 D0 26 94 09     	shl	byte ptr [0994h],1h
0800:1789 D1 FB           	sar	bx,1h
0800:178B D1 FB           	sar	bx,1h
0800:178D 2B D8           	sub	bx,ax
0800:178F 89 1E 88 09     	mov	[0988h],bx
0800:1793 A1 7E 09        	mov	ax,[097Eh]
0800:1796 2B 06 7C 09     	sub	ax,[097Ch]
0800:179A A3 95 09        	mov	[0995h],ax
0800:179D 1E              	push	ds
0800:179E 46              	inc	si
0800:179F A1 84 09        	mov	ax,[0984h]
0800:17A2 8E D8           	mov	ds,ax
0800:17A4 AD              	lodsw
0800:17A5 46              	inc	si
0800:17A6 8A 14           	mov	dl,[si]
0800:17A8 8B DE           	mov	bx,si
0800:17AA 1F              	pop	ds
0800:17AB FE C0           	inc	al
0800:17AD 50              	push	ax
0800:17AE 25 FF 00        	and	ax,0FFh
0800:17B1 A3 8C 09        	mov	[098Ch],ax
0800:17B4 8A F0           	mov	dh,al
0800:17B6 58              	pop	ax
0800:17B7 86 C4           	xchg	ah,al
0800:17B9 25 FF 00        	and	ax,0FFh
0800:17BC D1 E0           	shl	ax,1h
0800:17BE A3 8E 09        	mov	[098Eh],ax
0800:17C1 A3 90 09        	mov	[0990h],ax
0800:17C4 32 E4           	xor	ah,ah
0800:17C6 F6 E6           	mul	dh
0800:17C8 03 D8           	add	bx,ax
0800:17CA A1 8A 09        	mov	ax,[098Ah]
0800:17CD 2B 06 80 09     	sub	ax,[0980h]
0800:17D1 79 2B           	jns	17FEh

l0800_17D3:
0800:17D3 F7 D8           	neg	ax
0800:17D5 3B 06 8C 09     	cmp	ax,[098Ch]
0800:17D9 72 03           	jc	17DEh

l0800_17DB:
0800:17DB E9 8C 00        	jmp	186Ah

l0800_17DE:
0800:17DE 8B 16 8E 09     	mov	dx,[098Eh]
0800:17E2 F6 E2           	mul	dl
0800:17E4 03 F0           	add	si,ax
0800:17E6 03 D8           	add	bx,ax
0800:17E8 A1 8C 09        	mov	ax,[098Ch]
0800:17EB 03 06 8A 09     	add	ax,[098Ah]
0800:17EF 2B 06 80 09     	sub	ax,[0980h]
0800:17F3 78 75           	js	186Ah

l0800_17F5:
0800:17F5 A3 8C 09        	mov	[098Ch],ax
0800:17F8 A1 80 09        	mov	ax,[0980h]
0800:17FB A3 8A 09        	mov	[098Ah],ax

l0800_17FE:
0800:17FE A1 82 09        	mov	ax,[0982h]
0800:1801 2B 06 8A 09     	sub	ax,[098Ah]
0800:1805 78 63           	js	186Ah

l0800_1807:
0800:1807 74 61           	jz	186Ah

l0800_1809:
0800:1809 3B 06 8C 09     	cmp	ax,[098Ch]
0800:180D 73 03           	jnc	1812h

l0800_180F:
0800:180F A3 8C 09        	mov	[098Ch],ax

l0800_1812:
0800:1812 2E C7 06 B3 14 00 00 	mov	word ptr cs:[14B3h],0h
0800:1819 A1 88 09        	mov	ax,[0988h]
0800:181C 0B C0           	or	ax,ax
0800:181E 79 23           	jns	1843h

l0800_1820:
0800:1820 01 06 8E 09     	add	[098Eh],ax
0800:1824 F7 D8           	neg	ax
0800:1826 03 F0           	add	si,ax
0800:1828 03 D8           	add	bx,ax
0800:182A 3B 06 90 09     	cmp	ax,[0990h]
0800:182E 77 3A           	ja	186Ah

l0800_1830:
0800:1830 75 07           	jnz	1839h

l0800_1832:
0800:1832 A0 94 09        	mov	al,[0994h]
0800:1835 0A C0           	or	al,al
0800:1837 74 31           	jz	186Ah

l0800_1839:
0800:1839 33 C0           	xor	ax,ax
0800:183B A3 88 09        	mov	[0988h],ax
0800:183E 2E FF 06 B3 14  	inc	word ptr cs:[14B3h]

l0800_1843:
0800:1843 A1 95 09        	mov	ax,[0995h]
0800:1846 D1 E0           	shl	ax,1h
0800:1848 2B 06 88 09     	sub	ax,[0988h]
0800:184C 78 1C           	js	186Ah

l0800_184E:
0800:184E 74 1A           	jz	186Ah

l0800_1850:
0800:1850 2E C7 06 B1 14 00 00 	mov	word ptr cs:[14B1h],0h
0800:1857 3B 06 8E 09     	cmp	ax,[098Eh]
0800:185B 77 10           	ja	186Dh

l0800_185D:
0800:185D A3 8E 09        	mov	[098Eh],ax
0800:1860 2E C7 06 B1 14 01 00 	mov	word ptr cs:[14B1h],1h
0800:1867 EB 04           	jmp	186Dh
0800:1869                            90                            .      

l0800_186A:
0800:186A E9 94 00        	jmp	1901h

l0800_186D:
0800:186D A1 8A 09        	mov	ax,[098Ah]
0800:1870 A3 92 09        	mov	[0992h],ax
0800:1873 25 FE 00        	and	ax,0FEh
0800:1876 BA 28 00        	mov	dx,28h
0800:1879 F6 E2           	mul	dl
0800:187B 03 06 88 09     	add	ax,[0988h]
0800:187F F7 06 92 09 01 00 	test	word ptr [0992h],1h
0800:1885 74 03           	jz	188Ah

l0800_1887:
0800:1887 80 C4 20        	add	ah,20h

l0800_188A:
0800:188A 03 F8           	add	di,ax
0800:188C B8 00 20        	mov	ax,2000h
0800:188F 2B 06 8E 09     	sub	ax,[098Eh]
0800:1893 A3 8A 09        	mov	[098Ah],ax
0800:1896 A1 8E 09        	mov	ax,[098Eh]
0800:1899 2D 50 00        	sub	ax,50h
0800:189C 05 00 20        	add	ax,2000h
0800:189F A3 88 09        	mov	[0988h],ax
0800:18A2 8B 16 84 09     	mov	dx,[0984h]
0800:18A6 83 3E 97 09 01  	cmp	word ptr [0997h],1h
0800:18AB 74 57           	jz	1904h

l0800_18AD:
0800:18AD 80 3E 94 09 00  	cmp	byte ptr [0994h],0h
0800:18B2 74 03           	jz	18B7h

l0800_18B4:
0800:18B4 E9 A0 00        	jmp	1957h

l0800_18B7:
0800:18B7 8B 0E 8E 09     	mov	cx,[098Eh]
0800:18BB 8C DD           	mov	bp,ds
0800:18BD 8E DA           	mov	ds,dx

l0800_18BF:
0800:18BF 8A 27           	mov	ah,[bx]
0800:18C1 43              	inc	bx
0800:18C2 26 22 25        	and	ah,es:[di]
0800:18C5 AC              	lodsb
0800:18C6 0A C4           	or	al,ah
0800:18C8 AA              	stosb
0800:18C9 E2 F4           	loop	18BFh

l0800_18CB:
0800:18CB 8E DD           	mov	ds,bp
0800:18CD 03 36 90 09     	add	si,[0990h]
0800:18D1 2B 36 8E 09     	sub	si,[098Eh]
0800:18D5 03 1E 90 09     	add	bx,[0990h]
0800:18D9 2B 1E 8E 09     	sub	bx,[098Eh]
0800:18DD A1 92 09        	mov	ax,[0992h]
0800:18E0 25 01 00        	and	ax,1h
0800:18E3 35 01 00        	xor	ax,1h
0800:18E6 A3 92 09        	mov	[0992h],ax
0800:18E9 74 0C           	jz	18F7h

l0800_18EB:
0800:18EB 03 3E 8A 09     	add	di,[098Ah]
0800:18EF FF 0E 8C 09     	dec	word ptr [098Ch]
0800:18F3 75 C2           	jnz	18B7h

l0800_18F5:
0800:18F5 74 0A           	jz	1901h

l0800_18F7:
0800:18F7 2B 3E 88 09     	sub	di,[0988h]
0800:18FB FF 0E 8C 09     	dec	word ptr [098Ch]
0800:18FF 75 B6           	jnz	18B7h

l0800_1901:
0800:1901 E9 61 FD        	jmp	1665h

l0800_1904:
0800:1904 8B 0E 8E 09     	mov	cx,[098Eh]
0800:1908 8C DD           	mov	bp,ds
0800:190A 8E DA           	mov	ds,dx
0800:190C 33 DB           	xor	bx,bx

l0800_190E:
0800:190E 26 8A 1D        	mov	bl,es:[di]
0800:1911 2E 8A A7 B1 13  	mov	ah,cs:[bx+13B1h]
0800:1916 AC              	lodsb
0800:1917 22 C4           	and	al,ah
0800:1919 0A C3           	or	al,bl
0800:191B AA              	stosb
0800:191C E2 F0           	loop	190Eh

l0800_191E:
0800:191E 8E DD           	mov	ds,bp
0800:1920 03 36 90 09     	add	si,[0990h]
0800:1924 2B 36 8E 09     	sub	si,[098Eh]
0800:1928 03 1E 90 09     	add	bx,[0990h]
0800:192C 2B 1E 8E 09     	sub	bx,[098Eh]
0800:1930 A1 92 09        	mov	ax,[0992h]
0800:1933 25 01 00        	and	ax,1h
0800:1936 35 01 00        	xor	ax,1h
0800:1939 A3 92 09        	mov	[0992h],ax
0800:193C 74 0C           	jz	194Ah

l0800_193E:
0800:193E 03 3E 8A 09     	add	di,[098Ah]
0800:1942 FF 0E 8C 09     	dec	word ptr [098Ch]
0800:1946 75 BC           	jnz	1904h

l0800_1948:
0800:1948 74 B7           	jz	1901h

l0800_194A:
0800:194A 2B 3E 88 09     	sub	di,[0988h]
0800:194E FF 0E 8C 09     	dec	word ptr [098Ch]
0800:1952 75 B0           	jnz	1904h

l0800_1954:
0800:1954 E9 0E FD        	jmp	1665h

l0800_1957:
0800:1957 8B 0E 8E 09     	mov	cx,[098Eh]
0800:195B 8A E9           	mov	ch,cl
0800:195D 8A 0E 94 09     	mov	cl,[0994h]
0800:1961 8C DD           	mov	bp,ds
0800:1963 8E DA           	mov	ds,dx
0800:1965 2E 83 3E B3 14 00 	cmp	word ptr cs:[14B3h],0h
0800:196B 74 19           	jz	1986h

l0800_196D:
0800:196D 26 8B 15        	mov	dx,es:[di]
0800:1970 8A 67 FF        	mov	ah,[bx-1h]
0800:1973 B0 FF           	mov	al,0FFh
0800:1975 F9              	stc
0800:1976 D3 D8           	rcr	ax,cl
0800:1978 22 D0           	and	dl,al
0800:197A 8A 64 FF        	mov	ah,[si-1h]
0800:197D 32 C0           	xor	al,al
0800:197F D3 E8           	shr	ax,cl
0800:1981 0A D0           	or	dl,al
0800:1983 26 88 15        	mov	es:[di],dl

l0800_1986:
0800:1986 0A ED           	or	ch,ch
0800:1988 74 27           	jz	19B1h

l0800_198A:
0800:198A 26 8B 15        	mov	dx,es:[di]
0800:198D 8A 27           	mov	ah,[bx]
0800:198F 43              	inc	bx
0800:1990 B0 FF           	mov	al,0FFh
0800:1992 F9              	stc
0800:1993 D3 D8           	rcr	ax,cl
0800:1995 86 E0           	xchg	al,ah
0800:1997 23 D0           	and	dx,ax
0800:1999 AC              	lodsb
0800:199A 8A E0           	mov	ah,al
0800:199C 32 C0           	xor	al,al
0800:199E D3 E8           	shr	ax,cl
0800:19A0 86 E0           	xchg	al,ah
0800:19A2 80 FD 01        	cmp	ch,1h
0800:19A5 74 39           	jz	19E0h

l0800_19A7:
0800:19A7 0B D0           	or	dx,ax
0800:19A9 26 89 15        	mov	es:[di],dx
0800:19AC 47              	inc	di
0800:19AD FE CD           	dec	ch
0800:19AF 75 D9           	jnz	198Ah

l0800_19B1:
0800:19B1 8C DA           	mov	dx,ds
0800:19B3 8E DD           	mov	ds,bp
0800:19B5 03 36 90 09     	add	si,[0990h]
0800:19B9 2B 36 8E 09     	sub	si,[098Eh]
0800:19BD 03 1E 90 09     	add	bx,[0990h]
0800:19C1 2B 1E 8E 09     	sub	bx,[098Eh]
0800:19C5 A1 92 09        	mov	ax,[0992h]
0800:19C8 25 01 00        	and	ax,1h
0800:19CB 35 01 00        	xor	ax,1h
0800:19CE A3 92 09        	mov	[0992h],ax
0800:19D1 74 1D           	jz	19F0h

l0800_19D3:
0800:19D3 03 3E 8A 09     	add	di,[098Ah]
0800:19D7 FF 0E 8C 09     	dec	word ptr [098Ch]
0800:19DB 74 1D           	jz	19FAh

l0800_19DD:
0800:19DD E9 77 FF        	jmp	1957h

l0800_19E0:
0800:19E0 2E 83 3E B1 14 00 	cmp	word ptr cs:[14B1h],0h
0800:19E6 74 BF           	jz	19A7h

l0800_19E8:
0800:19E8 0A D0           	or	dl,al
0800:19EA 26 88 15        	mov	es:[di],dl
0800:19ED 47              	inc	di
0800:19EE EB C1           	jmp	19B1h

l0800_19F0:
0800:19F0 2B 3E 88 09     	sub	di,[0988h]
0800:19F4 FF 0E 8C 09     	dec	word ptr [098Ch]
0800:19F8 75 E3           	jnz	19DDh

l0800_19FA:
0800:19FA E9 68 FC        	jmp	1665h

l0800_19FD:
0800:19FD D1 E0           	shl	ax,1h
0800:19FF A3 8E 09        	mov	[098Eh],ax
0800:1A02 A3 90 09        	mov	[0990h],ax
0800:1A05 A1 8A 09        	mov	ax,[098Ah]
0800:1A08 2B 06 80 09     	sub	ax,[0980h]
0800:1A0C 79 28           	jns	1A36h

l0800_1A0E:
0800:1A0E F7 D8           	neg	ax
0800:1A10 3B 06 8C 09     	cmp	ax,[098Ch]
0800:1A14 73 56           	jnc	1A6Ch

l0800_1A16:
0800:1A16 8B 16 8E 09     	mov	dx,[098Eh]
0800:1A1A D1 EA           	shr	dx,1h
0800:1A1C F7 E2           	mul	dx
0800:1A1E 03 F0           	add	si,ax
0800:1A20 A1 8C 09        	mov	ax,[098Ch]
0800:1A23 03 06 8A 09     	add	ax,[098Ah]
0800:1A27 2B 06 80 09     	sub	ax,[0980h]
0800:1A2B 78 74           	js	1AA1h

l0800_1A2D:
0800:1A2D A3 8C 09        	mov	[098Ch],ax
0800:1A30 A1 80 09        	mov	ax,[0980h]
0800:1A33 A3 8A 09        	mov	[098Ah],ax

l0800_1A36:
0800:1A36 A1 82 09        	mov	ax,[0982h]
0800:1A39 2B 06 8A 09     	sub	ax,[098Ah]
0800:1A3D 78 62           	js	1AA1h

l0800_1A3F:
0800:1A3F 74 60           	jz	1AA1h

l0800_1A41:
0800:1A41 3B 06 8C 09     	cmp	ax,[098Ch]
0800:1A45 73 03           	jnc	1A4Ah

l0800_1A47:
0800:1A47 A3 8C 09        	mov	[098Ch],ax

l0800_1A4A:
0800:1A4A 2E C7 06 B3 14 00 00 	mov	word ptr cs:[14B3h],0h
0800:1A51 A1 88 09        	mov	ax,[0988h]
0800:1A54 2E A3 B5 14     	mov	cs:[14B5h],ax
0800:1A58 0B C0           	or	ax,ax
0800:1A5A 79 1C           	jns	1A78h

l0800_1A5C:
0800:1A5C 01 06 8E 09     	add	[098Eh],ax
0800:1A60 F7 D8           	neg	ax
0800:1A62 8B D0           	mov	dx,ax
0800:1A64 D1 EA           	shr	dx,1h
0800:1A66 03 F2           	add	si,dx
0800:1A68 3B 06 90 09     	cmp	ax,[0990h]

l0800_1A6C:
0800:1A6C 73 33           	jnc	1AA1h

l0800_1A6E:
0800:1A6E 33 C0           	xor	ax,ax
0800:1A70 A3 88 09        	mov	[0988h],ax
0800:1A73 2E FF 06 B3 14  	inc	word ptr cs:[14B3h]

l0800_1A78:
0800:1A78 2E C7 06 B1 14 00 00 	mov	word ptr cs:[14B1h],0h
0800:1A7F A1 95 09        	mov	ax,[0995h]
0800:1A82 D1 E0           	shl	ax,1h
0800:1A84 D1 E0           	shl	ax,1h
0800:1A86 D1 E0           	shl	ax,1h
0800:1A88 2B 06 88 09     	sub	ax,[0988h]
0800:1A8C 78 13           	js	1AA1h

l0800_1A8E:
0800:1A8E 74 11           	jz	1AA1h

l0800_1A90:
0800:1A90 3B 06 8E 09     	cmp	ax,[098Eh]
0800:1A94 73 0E           	jnc	1AA4h

l0800_1A96:
0800:1A96 A3 8E 09        	mov	[098Eh],ax
0800:1A99 2E FF 06 B1 14  	inc	word ptr cs:[14B1h]
0800:1A9E EB 04           	jmp	1AA4h
0800:1AA0 90                                              .               

l0800_1AA1:
0800:1AA1 E9 C1 FB        	jmp	1665h

l0800_1AA4:
0800:1AA4 A1 8A 09        	mov	ax,[098Ah]
0800:1AA7 BA 40 01        	mov	dx,140h
0800:1AAA F7 E2           	mul	dx
0800:1AAC 03 06 88 09     	add	ax,[0988h]
0800:1AB0 03 F8           	add	di,ax
0800:1AB2 B8 40 01        	mov	ax,140h
0800:1AB5 2E 83 3E B3 14 00 	cmp	word ptr cs:[14B3h],0h
0800:1ABB 74 0D           	jz	1ACAh

l0800_1ABD:
0800:1ABD 2E F7 06 B5 14 01 00 	test	word ptr cs:[14B5h],1h
0800:1AC4 74 16           	jz	1ADCh

l0800_1AC6:
0800:1AC6 40              	inc	ax
0800:1AC7 EB 13           	jmp	1ADCh
0800:1AC9                            90                            .      

l0800_1ACA:
0800:1ACA 2E 83 3E B1 14 00 	cmp	word ptr cs:[14B1h],0h
0800:1AD0 74 0A           	jz	1ADCh

l0800_1AD2:
0800:1AD2 2E F7 06 B5 14 01 00 	test	word ptr cs:[14B5h],1h
0800:1AD9 74 01           	jz	1ADCh

l0800_1ADB:
0800:1ADB 40              	inc	ax

l0800_1ADC:
0800:1ADC 2B 06 8E 09     	sub	ax,[098Eh]
0800:1AE0 A3 8A 09        	mov	[098Ah],ax
0800:1AE3 8B 16 84 09     	mov	dx,[0984h]
0800:1AE7 BB F0 0F        	mov	bx,0FF0h
0800:1AEA 8C DD           	mov	bp,ds
0800:1AEC D1 2E 8E 09     	shr	word ptr [098Eh],1h
0800:1AF0 D1 2E 90 09     	shr	word ptr [0990h],1h
0800:1AF4 83 3E 97 09 01  	cmp	word ptr [0997h],1h
0800:1AF9 74 41           	jz	1B3Ch

l0800_1AFB:
0800:1AFB 8B 0E 8E 09     	mov	cx,[098Eh]
0800:1AFF 8E DA           	mov	ds,dx

l0800_1B01:
0800:1B01 AC              	lodsb
0800:1B02 8A E0           	mov	ah,al
0800:1B04 22 C3           	and	al,bl
0800:1B06 74 0D           	jz	1B15h

l0800_1B08:
0800:1B08 AA              	stosb
0800:1B09 8A C4           	mov	al,ah
0800:1B0B 22 C7           	and	al,bh
0800:1B0D 74 13           	jz	1B22h

l0800_1B0F:
0800:1B0F AA              	stosb
0800:1B10 E2 EF           	loop	1B01h

l0800_1B12:
0800:1B12 EB 11           	jmp	1B25h
0800:1B14             90                                      .           

l0800_1B15:
0800:1B15 47              	inc	di
0800:1B16 8A C4           	mov	al,ah
0800:1B18 22 C7           	and	al,bh
0800:1B1A 74 06           	jz	1B22h

l0800_1B1C:
0800:1B1C AA              	stosb
0800:1B1D E2 E2           	loop	1B01h

l0800_1B1F:
0800:1B1F EB 04           	jmp	1B25h
0800:1B21    90                                            .              

l0800_1B22:
0800:1B22 47              	inc	di
0800:1B23 E2 DC           	loop	1B01h

l0800_1B25:
0800:1B25 8E DD           	mov	ds,bp
0800:1B27 03 36 90 09     	add	si,[0990h]
0800:1B2B 2B 36 8E 09     	sub	si,[098Eh]
0800:1B2F 03 3E 8A 09     	add	di,[098Ah]
0800:1B33 FF 0E 8C 09     	dec	word ptr [098Ch]
0800:1B37 75 C2           	jnz	1AFBh

l0800_1B39:
0800:1B39 E9 29 FB        	jmp	1665h

l0800_1B3C:
0800:1B3C 8B 0E 8E 09     	mov	cx,[098Eh]
0800:1B40 8E DA           	mov	ds,dx

l0800_1B42:
0800:1B42 AC              	lodsb
0800:1B43 8A E0           	mov	ah,al
0800:1B45 22 C3           	and	al,bl
0800:1B47 74 19           	jz	1B62h

l0800_1B49:
0800:1B49 26 80 3D 00     	cmp	byte ptr es:[di],0h
0800:1B4D 75 13           	jnz	1B62h

l0800_1B4F:
0800:1B4F AA              	stosb
0800:1B50 8A C4           	mov	al,ah
0800:1B52 22 C7           	and	al,bh
0800:1B54 74 1F           	jz	1B75h

l0800_1B56:
0800:1B56 26 80 3D 00     	cmp	byte ptr es:[di],0h
0800:1B5A 75 19           	jnz	1B75h

l0800_1B5C:
0800:1B5C AA              	stosb
0800:1B5D E2 E3           	loop	1B42h

l0800_1B5F:
0800:1B5F EB 17           	jmp	1B78h
0800:1B61    90                                            .              

l0800_1B62:
0800:1B62 47              	inc	di
0800:1B63 8A C4           	mov	al,ah
0800:1B65 22 C7           	and	al,bh
0800:1B67 74 0C           	jz	1B75h

l0800_1B69:
0800:1B69 26 80 3D 00     	cmp	byte ptr es:[di],0h
0800:1B6D 75 06           	jnz	1B75h

l0800_1B6F:
0800:1B6F AA              	stosb
0800:1B70 E2 D0           	loop	1B42h

l0800_1B72:
0800:1B72 EB 04           	jmp	1B78h
0800:1B74             90                                      .           

l0800_1B75:
0800:1B75 47              	inc	di
0800:1B76 E2 CA           	loop	1B42h

l0800_1B78:
0800:1B78 8E DD           	mov	ds,bp
0800:1B7A 03 36 90 09     	add	si,[0990h]
0800:1B7E 2B 36 8E 09     	sub	si,[098Eh]
0800:1B82 03 3E 8A 09     	add	di,[098Ah]
0800:1B86 FF 0E 8C 09     	dec	word ptr [098Ch]
0800:1B8A 75 B0           	jnz	1B3Ch

l0800_1B8C:
0800:1B8C E9 D6 FA        	jmp	1665h
0800:1B8F                                              00                .
0800:1B90 10 20 30 40 50 60 70 80 90 A0 B0 C0 D0 E0 F0 01 . 0@P`p.........
0800:1BA0 11 21 31 41 51 61 71 81 91 A1 B1 C1 D1 E1 F1 02 .!1AQaq.........
0800:1BB0 12 22 32 42 52 62 72 82 92 A2 B2 C2 D2 E2 F2 03 ."2BRbr.........
0800:1BC0 13 23 33 43 53 63 73 83 93 A3 B3 C3 D3 E3 F3 04 .#3CScs.........
0800:1BD0 14 24 34 44 54 64 74 84 94 A4 B4 C4 D4 E4 F4 05 .$4DTdt.........
0800:1BE0 15 25 35 45 55 65 75 85 95 A5 B5 C5 D5 E5 F5 06 .%5EUeu.........
0800:1BF0 16 26 36 46 56 66 76 86 96 A6 B6 C6 D6 E6 F6 07 .&6FVfv.........
0800:1C00 17 27 37 47 57 67 77 87 97 A7 B7 C7 D7 E7 F7 08 .'7GWgw.........
0800:1C10 18 28 38 48 58 68 78 88 98 A8 B8 C8 D8 E8 F8 09 .(8HXhx.........
0800:1C20 19 29 39 49 59 69 79 89 99 A9 B9 C9 D9 E9 F9 0A .)9IYiy.........
0800:1C30 1A 2A 3A 4A 5A 6A 7A 8A 9A AA BA CA DA EA FA 0B .*:JZjz.........
0800:1C40 1B 2B 3B 4B 5B 6B 7B 8B 9B AB BB CB DB EB FB 0C .+;K[k{.........
0800:1C50 1C 2C 3C 4C 5C 6C 7C 8C 9C AC BC CC DC EC FC 0D .,<L\l|.........
0800:1C60 1D 2D 3D 4D 5D 6D 7D 8D 9D AD BD CD DD ED FD 0E .-=M]m}.........
0800:1C70 1E 2E 3E 4E 5E 6E 7E 8E 9E AE BE CE DE EE FE 0F ..>N^n~.........
0800:1C80 1F 2F 3F 4F 5F 6F 7F 8F 9F AF BF CF DF EF FF 55 ./?O_o.........U
0800:1C90 8B EC 57 56 1E B8 84 41 8E D8 2E C7 06 B3 14 00 ..WV...A........
0800:1CA0 00 83 3E 4C 0E 00 75 03 E9 79 04 06 8B 7E 06 8B ..>L..u..y...~..
0800:1CB0 46 08 A3 86 09 8B 76 0A 8B 46 0C A3 84 09 8B 5E F.....v..F.....^
0800:1CC0 0E 8B 46 10 A3 8A 09 A1 7C 09 83 3E 4C 0E 01 74 ..F.....|..>L..t
0800:1CD0 02 D1 E0 D1 E0 D1 E0 03 F8 C6 06 94 09 00 83 3E ...............>
0800:1CE0 4C 0E 03 74 06 D1 FB D0 16 94 09 2B D8 89 1E 88 L..t.......+....
0800:1CF0 09 A1 7E 09 2B 06 7C 09 A3 95 09 1E 46 A1 84 09 ..~.+.|.....F...
0800:1D00 8E D8 AD 46 1F FE C0 50 25 FF 00 A3 8C 09 58 86 ...F...P%.....X.
0800:1D10 C4 25 FF 00 D1 E0 D1 E0 83 3E 4C 0E 01 74 03 E9 .%.......>L..t..
0800:1D20 54 02 A3 8E 09 A3 90 09 A1 8A 09 2B 06 80 09 79 T..........+...y
0800:1D30 26 F7 D8 3B 06 8C 09 73 7E 8B 16 8E 09 F6 E2 03 &..;...s~.......
0800:1D40 F0 A1 8C 09 03 06 8A 09 2B 06 80 09 78 69 A3 8C ........+...xi..
0800:1D50 09 A1 80 09 A3 8A 09 A1 82 09 2B 06 8A 09 78 57 ..........+...xW
0800:1D60 74 55 3B 06 8C 09 73 03 A3 8C 09 A1 88 09 0B C0 tU;...s.........
0800:1D70 79 16 01 06 8E 09 F7 D8 3B 06 90 09 73 39 33 C0 y.......;...s93.
0800:1D80 A3 88 09 2E FF 06 B3 14 A1 95 09 D1 E0 D1 E0 2B ...............+
0800:1D90 06 88 09 78 22 74 20 2E C7 06 B1 14 00 00 3B 06 ...x"t .......;.
0800:1DA0 8E 09 77 16 03 36 8E 09 2B F0 A3 8E 09 2E C7 06 ..w..6..+.......
0800:1DB0 B1 14 01 00 EB 04 90 E9 A5 00 A1 8A 09 8B D8 25 ...............%
0800:1DC0 FC 00 D1 E0 D1 E0 D1 E0 8B D0 D1 E0 D1 E0 03 C2 ................
0800:1DD0 03 06 88 09 83 E3 03 89 1E 92 09 74 07 8B CB 80 ...........t....
0800:1DE0 C4 20 E2 FB 03 F8 B8 00 20 2B 06 8E 09 A3 8A 09 . ...... +......
0800:1DF0 A1 8E 09 2D A0 00 05 00 60 A3 88 09 8B 16 84 09 ...-....`.......
0800:1E00 4E A1 92 09 86 E0 83 3E 97 09 01 74 64 80 3E 94 N......>...td.>.
0800:1E10 09 01 75 03 E9 A1 00 33 DB 8B 0E 86 09 8E C1 8B ..u....3........
0800:1E20 0E 8E 09 03 F1 8C DD 8E DA 8A 1C 0A DB 74 3C 2E .............t<.
0800:1E30 8A 9F 8F 1B 8A C3 2E 8A 9F B1 12 26 22 1D 0A C3 ...........&"...
0800:1E40 AA 4E E2 E5 8E DD 03 36 90 09 03 3E 8A 09 FE C4 .N.....6...>....
0800:1E50 80 E4 03 75 04 81 EF 60 7F FF 0E 8C 09 75 B8 07 ...u...`.....u..
0800:1E60 1F 5E 5F 5D CB 8A 1C 0A DB 75 C4 47 4E E2 F6 EB .^_].....u.GN...
0800:1E70 D3 33 DB 8B 0E 86 09 8E C1 8B 0E 8E 09 03 F1 8C .3..............
0800:1E80 DD 8E DA 8A 1C 2E 8A 87 8F 1B 26 8A 1D 2E 8A 9F ..........&.....
0800:1E90 B1 12 22 C3 26 08 05 47 4E E2 E8 8E DD 03 36 90 ..".&..GN.....6.
0800:1EA0 09 03 3E 8A 09 FE C4 80 E4 03 75 04 81 EF 60 7F ..>.......u...`.
0800:1EB0 FF 0E 8C 09 75 BB 74 A7 86 E0 A3 92 09 33 DB 8B ....u.t......3..
0800:1EC0 0E 86 09 8E C1 8B 0E 8E 09 03 F1 8C DD 8E DA 2E ................
0800:1ED0 83 3E B3 14 00 74 05 E8 5F 00 32 FF 8A 1C 2E 8A .>...t.._.2.....
0800:1EE0 9F 8F 1B 8A E3 2E 8A B7 B1 12 D1 EA D1 EA D1 EA ................
0800:1EF0 D1 EA 81 CA 0F F0 86 F2 26 23 15 32 C0 D1 E8 D1 ........&#.2....
0800:1F00 E8 D1 E8 D1 E8 86 E0 0B C2 AA 83 F9 01 74 5C 26 .............t\&
0800:1F10 88 25 4E E2 C7 8C DA 8E DD 03 36 90 09 03 3E 8A .%N.......6...>.
0800:1F20 09 FF 06 92 09 83 26 92 09 03 75 04 81 EF 60 7F ......&...u...`.
0800:1F30 FF 0E 8C 09 75 87 E9 26 FF 8A 5C 01 2E 8A 9F 8F ....u..&..\.....
0800:1F40 1B 8A E3 2E 8A B7 B1 12 D1 EA D1 EA D1 EA D1 EA ................
0800:1F50 81 CA 0F F0 86 F2 26 23 15 32 C0 D1 E8 D1 E8 D1 ......&#.2......
0800:1F60 E8 D1 E8 86 E0 0B C2 26 88 25 C3 2E 83 3E B1 14 .......&.%...>..
0800:1F70 00 74 9C 4E EB 9F D1 E0 A3 8E 09 A3 90 09 A1 8A .t.N............
0800:1F80 09 2B 06 80 09 79 28 F7 D8 3B 06 8C 09 73 50 8B .+...y(..;...sP.
0800:1F90 16 8E 09 D1 EA F7 E2 03 F0 A1 8C 09 03 06 8A 09 ................
0800:1FA0 2B 06 80 09 78 7A A3 8C 09 A1 80 09 A3 8A 09 A1 +...xz..........
0800:1FB0 82 09 2B 06 8A 09 78 68 74 66 3B 06 8C 09 73 03 ..+...xhtf;...s.
0800:1FC0 A3 8C 09 2E C7 06 B3 14 00 00 A1 88 09 2E A3 B5 ................
0800:1FD0 14 0B C0 79 16 01 06 8E 09 F7 D8 3B 06 90 09 73 ...y.......;...s
0800:1FE0 3F 33 C0 A3 88 09 2E FF 06 B3 14 2E C7 06 B1 14 ?3..............
0800:1FF0 00 00 A1 95 09 D1 E0 D1 E0 D1 E0 2B 06 88 09 78 ...........+...x
0800:2000 1F 74 1D 3B 06 8E 09 73 1A 8B 16 8E 09 D1 EA 03 .t.;...s........
0800:2010 F2 A3 8E 09 D1 E8 2B F0 2E FF 06 B1 14 EB 04 90 ......+.........
0800:2020 E9 3C FE A1 8A 09 BA 40 01 F7 E2 03 06 88 09 03 .<.....@........
0800:2030 F8 B8 40 01 2E 83 3E B3 14 00 74 0D 2E F7 06 B5 ..@...>...t.....
0800:2040 14 01 00 74 16 40 EB 13 90 2E 83 3E B1 14 00 74 ...t.@.....>...t
0800:2050 0A 2E F7 06 B5 14 01 00 74 01 40 2B 06 8E 09 A3 ........t.@+....
0800:2060 8A 09 8B 16 84 09 D1 2E 8E 09 D1 2E 90 09 4E 83 ..............N.
0800:2070 3E 97 09 01 74 4F 33 DB 8B 2E 86 09 8B 0E 8E 09 >...tO3.........
0800:2080 03 F1 8E C2 26 8A 04 4E 8A D8 2E 8A 87 8F 1B 8E ....&..N........
0800:2090 C5 8A E0 24 F0 74 0D AA 8A C4 24 0F 74 13 AA E2 ...$.t....$.t...
0800:20A0 E1 EB 11 90 47 8A C4 24 0F 74 06 AA E2 D4 EB 04 ....G..$.t......
0800:20B0 90 47 E2 CE 03 36 90 09 03 3E 8A 09 FF 0E 8C 09 .G...6...>......
0800:20C0 75 B4 E9 9A FD 33 DB 8B 2E 86 09 8B 0E 8E 09 03 u....3..........
0800:20D0 F1 8E C2 26 8A 1C 4E 2E 8A 87 8F 1B 8E C5 8A E0 ...&..N.........
0800:20E0 24 F0 74 19 26 80 3D 00 75 13 AA 8A C4 24 0F 74 $.t.&.=.u....$.t
0800:20F0 1F 26 80 3D 00 75 19 AA E2 D7 EB 17 90 47 8A C4 .&.=.u.......G..
0800:2100 24 0F 74 0C 26 80 3D 00 75 06 AA E2 C4 EB 04 90 $.t.&.=.u.......
0800:2110 47 E2 BE 03 36 90 09 03 3E 8A 09 FF 0E 8C 09 75 G...6...>......u
0800:2120 A4 E9 3B FD 06 8B 7E 06 8B 46 08 A3 86 09 8B 76 ..;...~..F.....v
0800:2130 0A 8B 46 0C A3 84 09 8B 5E 0E 8B 46 10 A3 8A 09 ..F.....^..F....
0800:2140 A1 7C 09 D1 E0 03 F8 88 1E 94 09 80 26 94 09 03 .|..........&...
0800:2150 D0 26 94 09 D1 FB D1 FB 2B D8 89 1E 88 09 A1 7E .&......+......~
0800:2160 09 2B 06 7C 09 A3 95 09 1E 46 A1 84 09 8E D8 AD .+.|.....F......
0800:2170 46 8A 14 8B DE 1F FE C0 50 25 FF 00 A3 8C 09 8A F.......P%......
0800:2180 F0 58 86 C4 25 FF 00 D1 E0 A3 8E 09 A3 90 09 32 .X..%..........2
0800:2190 E4 F6 E6 03 D8 A1 8A 09 2B 06 80 09 79 2B F7 D8 ........+...y+..
0800:21A0 3B 06 8C 09 72 03 E9 8F 00 8B 16 8E 09 F6 E2 03 ;...r...........
0800:21B0 F0 03 D8 A1 8C 09 03 06 8A 09 2B 06 80 09 78 78 ..........+...xx
0800:21C0 A3 8C 09 A1 80 09 A3 8A 09 A1 82 09 2B 06 8A 09 ............+...
0800:21D0 78 66 74 64 3B 06 8C 09 73 03 A3 8C 09 A1 88 09 xftd;...s.......
0800:21E0 0B C0 79 21 01 06 8E 09 F7 D8 3B 06 90 09 77 48 ..y!......;...wH
0800:21F0 75 07 A0 94 09 0A C0 74 3F 33 C0 A3 88 09 2E C7 u......t?3......
0800:2200 06 B3 14 01 00 A1 95 09 D1 E0 2B 06 88 09 78 28 ..........+...x(
0800:2210 74 26 2E C7 06 B1 14 00 00 3B 06 8E 09 77 1C 03 t&.......;...w..
0800:2220 36 8E 09 03 1E 8E 09 2B F0 2B D8 A3 8E 09 2E C7 6......+.+......
0800:2230 06 B1 14 01 00 EB 04 90 E9 24 FC A1 8A 09 A3 92 .........$......
0800:2240 09 25 FE 00 BA 28 00 F6 E2 03 06 88 09 F7 06 92 .%...(..........
0800:2250 09 01 00 74 03 80 C4 20 03 F8 8B 16 86 09 8E C2 ...t... ........
0800:2260 B8 00 20 2B 06 8E 09 A3 8A 09 A1 8E 09 2D 50 00 .. +.........-P.
0800:2270 80 C4 20 A3 88 09 8B 16 84 09 4E 4B 8C DD 83 3E .. .......NK...>
0800:2280 97 09 01 74 5F 80 3E 94 09 00 74 03 E9 A5 00 8B ...t_.>...t.....
0800:2290 0E 8E 09 03 F1 03 D9 8E DA 8A 04 8A 27 53 BB 99 ............'S..
0800:22A0 0A 8E DD D7 86 E0 D7 26 22 05 0A C4 26 88 05 4E .......&"...&..N
0800:22B0 5B 4B 47 E2 E2 03 36 90 09 03 1E 90 09 A1 92 09 [KG...6.........
0800:22C0 25 01 00 35 01 00 A3 92 09 74 0C 03 3E 8A 09 FF %..5.....t..>...
0800:22D0 0E 8C 09 75 BA 74 0A 2B 3E 88 09 FF 0E 8C 09 75 ...u.t.+>......u
0800:22E0 AE E9 7B FB 8B 0E 8E 09 03 F1 33 DB 8E DA 8A 1C ..{.......3.....
0800:22F0 8E DD 8A 87 99 0A 26 8A 1D 2E 22 87 B1 13 26 08 ......&..."...&.
0800:2300 05 4E 47 E2 E7 03 36 90 09 03 1E 90 09 A1 92 09 .NG...6.........
0800:2310 25 01 00 35 01 00 A3 92 09 74 0C 03 3E 8A 09 FF %..5.....t..>...
0800:2320 0E 8C 09 75 BF 74 0A 2B 3E 88 09 FF 0E 8C 09 75 ...u.t.+>......u
0800:2330 B3 E9 2B FB 8B 0E 8E 09 03 F1 03 D9 8A E9 8A 0E ..+.............
0800:2340 94 09 2E 83 3E B3 14 00 74 03 E8 77 00 0A ED 74 ....>...t..w...t
0800:2350 34 8E DA 8A 04 8A 27 53 BB 99 0A 8E DD D7 86 E0 4.....'S........
0800:2360 D7 8A F8 B3 FF F9 D3 DB 86 FB 32 C0 D3 E8 86 E0 ..........2.....
0800:2370 26 23 1D 80 FD 01 74 30 0B C3 26 89 05 4E 5B 4B &#....t0..&..N[K
0800:2380 47 FE CD 75 CC 03 36 90 09 03 1E 90 09 A1 92 09 G..u..6.........
0800:2390 25 01 00 35 01 00 A3 92 09 74 1C 03 3E 8A 09 FF %..5.....t..>...
0800:23A0 0E 8C 09 75 8F E9 B7 FA 2E 83 3E B1 14 00 74 C8 ...u......>...t.
0800:23B0 0A C3 26 88 05 EB C6 2B 3E 88 09 FF 0E 8C 09 74 ..&....+>......t
0800:23C0 E4 E9 70 FF 8E DA 8A 44 01 8A 67 01 53 BB 99 0A ..p....D..g.S...
0800:23D0 8E DD D7 86 E0 D7 8A F8 B3 FF F9 D3 DB 32 C0 D3 .............2..
0800:23E0 E8 26 22 1D 0A C3 26 88 05 5B C3 00 00 00 00 00 .&"...&..[......

;; InstallGameClockTimer_23F0: 0800:23F0
;;   Called from:
;;     2C7F:02AB (in InitializeGame_003C)
InstallGameClockTimer_23F0 proc
0800:23F0 55              	push	bp
0800:23F1 8B EC           	mov	bp,sp
0800:23F3 57              	push	di
0800:23F4 56              	push	si
0800:23F5 1E              	push	ds
0800:23F6 B8 6A 3A        	mov	ax,3A6Ah
0800:23F9 8E D8           	mov	ds,ax
0800:23FB 06              	push	es
0800:23FC B4 35           	mov	ah,35h
0800:23FE B0 1C           	mov	al,1Ch
0800:2400 CD 21           	int	21h
0800:2402 2E 8C 06 EE 23  	mov	cs:[23EEh],es
0800:2407 2E 89 1E EC 23  	mov	cs:[23ECh],bx
0800:240C B4 25           	mov	ah,25h
0800:240E B0 1C           	mov	al,1Ch
0800:2410 0E              	push	cs
0800:2411 1F              	pop	ds
0800:2412 8D 16 40 24     	lea	dx,[2440h]
0800:2416 CD 21           	int	21h
0800:2418 07              	pop	es
0800:2419 1F              	pop	ds
0800:241A 5E              	pop	si
0800:241B 5F              	pop	di
0800:241C 5D              	pop	bp
0800:241D CB              	retf

;; RestoreGameClockTimer_241E: 0800:241E
;;   Called from:
;;     2C7F:030C (in ShutdownGame_02E3)
RestoreGameClockTimer_241E proc
0800:241E 55              	push	bp
0800:241F 8B EC           	mov	bp,sp
0800:2421 57              	push	di
0800:2422 56              	push	si
0800:2423 1E              	push	ds
0800:2424 B8 6A 3A        	mov	ax,3A6Ah
0800:2427 8E D8           	mov	ds,ax
0800:2429 06              	push	es
0800:242A B4 25           	mov	ah,25h
0800:242C B0 1C           	mov	al,1Ch
0800:242E 2E 8E 1E EE 23  	mov	ds,cs:[23EEh]
0800:2433 2E 8B 16 EC 23  	mov	dx,cs:[23ECh]
0800:2438 CD 21           	int	21h
0800:243A 07              	pop	es
0800:243B 1F              	pop	ds
0800:243C 5E              	pop	si
0800:243D 5F              	pop	di
0800:243E 5D              	pop	bp
0800:243F CB              	retf

;; GameClockInt1CHandler_2440: 0800:2440
GameClockInt1CHandler_2440 proc
0800:2440 1E              	push	ds
0800:2441 50              	push	ax
0800:2442 B8 6A 3A        	mov	ax,3A6Ah
0800:2445 8E D8           	mov	ds,ax
0800:2447 83 3E 23 59 00  	cmp	word ptr [5923h],0h
0800:244C 74 04           	jz	2452h

l0800_244E:
0800:244E FF 0E 23 59     	dec	word ptr [5923h]

l0800_2452:
0800:2452 83 3E 25 59 00  	cmp	word ptr [5925h],0h
0800:2457 74 04           	jz	245Dh

l0800_2459:
0800:2459 FF 0E 25 59     	dec	word ptr [5925h]

l0800_245D:
0800:245D FF 06 1B 59     	inc	word ptr [591Bh]
0800:2461 75 04           	jnz	2467h

l0800_2463:
0800:2463 FF 06 1D 59     	inc	word ptr [591Dh]

l0800_2467:
0800:2467 FF 06 1F 59     	inc	word ptr [591Fh]
0800:246B 75 04           	jnz	2471h

l0800_246D:
0800:246D FF 06 21 59     	inc	word ptr [5921h]

l0800_2471:
0800:2471 58              	pop	ax
0800:2472 1F              	pop	ds
0800:2473 2E 83 3E EE 23 00 	cmp	word ptr cs:[23EEh],0h
0800:2479 74 05           	jz	2480h

l0800_247B:
0800:247B 2E FF 2E EC 23  	jmp	dword ptr cs:[23ECh]

l0800_2480:
0800:2480 CF              	iret
0800:2481    00 00                                         ..             

;; DrawCompositeTacticalTile_2483: 0800:2483
;;   Called from:
;;     2007:0377 (in DrawTacticalViewportCell_0328)
;;     2007:03B2 (in DrawTacticalViewportCell_0328)
;;     2007:03F0 (in DrawTacticalViewportCell_0328)
;;     2007:06FF (in RebuildTacticalViewport_0650)
DrawCompositeTacticalTile_2483 proc
0800:2483 55              	push	bp
0800:2484 8B EC           	mov	bp,sp
0800:2486 57              	push	di
0800:2487 56              	push	si
0800:2488 1E              	push	ds
0800:2489 B8 84 41        	mov	ax,4184h
0800:248C 8E D8           	mov	ds,ax
0800:248E 8B 76 0A        	mov	si,[bp+0Ah]
0800:2491 8B 56 0C        	mov	dx,[bp+0Ch]
0800:2494 8B 46 10        	mov	ax,[bp+10h]
0800:2497 25 FC 00        	and	ax,0FCh
0800:249A D1 E0           	shl	ax,1h
0800:249C D1 E0           	shl	ax,1h
0800:249E D1 E0           	shl	ax,1h
0800:24A0 8B D8           	mov	bx,ax
0800:24A2 D1 E0           	shl	ax,1h
0800:24A4 D1 E0           	shl	ax,1h
0800:24A6 03 C3           	add	ax,bx
0800:24A8 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:24AD 75 06           	jnz	24B5h

l0800_24AF:
0800:24AF D1 E0           	shl	ax,1h
0800:24B1 D1 E0           	shl	ax,1h
0800:24B3 D1 E0           	shl	ax,1h

l0800_24B5:
0800:24B5 8B F8           	mov	di,ax
0800:24B7 8B 46 0E        	mov	ax,[bp+0Eh]
0800:24BA 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:24BF 74 14           	jz	24D5h

l0800_24C1:
0800:24C1 D1 E0           	shl	ax,1h
0800:24C3 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:24C8 74 0B           	jz	24D5h

l0800_24CA:
0800:24CA D1 E0           	shl	ax,1h
0800:24CC 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:24D1 74 02           	jz	24D5h

l0800_24D3:
0800:24D3 D1 E0           	shl	ax,1h

l0800_24D5:
0800:24D5 03 F8           	add	di,ax
0800:24D7 8B 5E 06        	mov	bx,[bp+6h]
0800:24DA 8B 46 08        	mov	ax,[bp+8h]
0800:24DD 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:24E2 74 10           	jz	24F4h

l0800_24E4:
0800:24E4 0A FF           	or	bh,bh
0800:24E6 74 0C           	jz	24F4h

l0800_24E8:
0800:24E8 0A E4           	or	ah,ah
0800:24EA 74 08           	jz	24F4h

l0800_24EC:
0800:24EC FE CC           	dec	ah
0800:24EE FE CF           	dec	bh
0800:24F0 81 C2 00 08     	add	dx,800h

l0800_24F4:
0800:24F4 B9 05 00        	mov	cx,5h
0800:24F7 D3 E0           	shl	ax,cl
0800:24F9 D3 E3           	shl	bx,cl
0800:24FB 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2500 75 03           	jnz	2505h

l0800_2502:
0800:2502 E9 BA 00        	jmp	25BFh

l0800_2505:
0800:2505 D1 E0           	shl	ax,1h
0800:2507 D1 E0           	shl	ax,1h
0800:2509 D1 E3           	shl	bx,1h
0800:250B D1 E3           	shl	bx,1h
0800:250D 03 DE           	add	bx,si
0800:250F 03 F0           	add	si,ax
0800:2511 06              	push	es
0800:2512 B8 00 B8        	mov	ax,0B800h
0800:2515 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:251A 75 03           	jnz	251Fh

l0800_251C:
0800:251C B8 00 A0        	mov	ax,0A000h

l0800_251F:
0800:251F 8E C0           	mov	es,ax
0800:2521 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:2526 75 29           	jnz	2551h

l0800_2528:
0800:2528 8E DA           	mov	ds,dx
0800:252A BA 10 00        	mov	dx,10h

l0800_252D:
0800:252D B9 04 00        	mov	cx,4h

l0800_2530:
0800:2530 8B 07           	mov	ax,[bx]
0800:2532 22 24           	and	ah,[si]
0800:2534 0A C4           	or	al,ah
0800:2536 AA              	stosb
0800:2537 46              	inc	si
0800:2538 83 C3 02        	add	bx,2h
0800:253B E2 F3           	loop	2530h

l0800_253D:
0800:253D 81 C7 FC 1F     	add	di,1FFCh
0800:2541 80 F6 01        	xor	dh,1h
0800:2544 75 04           	jnz	254Ah

l0800_2546:
0800:2546 81 EF B0 3F     	sub	di,3FB0h

l0800_254A:
0800:254A FE CA           	dec	dl
0800:254C 75 DF           	jnz	252Dh

l0800_254E:
0800:254E E9 F4 00        	jmp	2645h

l0800_2551:
0800:2551 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2556 75 33           	jnz	258Bh

l0800_2558:
0800:2558 8E DA           	mov	ds,dx
0800:255A BA 10 00        	mov	dx,10h

l0800_255D:
0800:255D B9 08 00        	mov	cx,8h

l0800_2560:
0800:2560 8A 07           	mov	al,[bx]
0800:2562 B4 FF           	mov	ah,0FFh
0800:2564 A8 F0           	test	al,0F0h
0800:2566 74 03           	jz	256Bh

l0800_2568:
0800:2568 80 E4 0F        	and	ah,0Fh

l0800_256B:
0800:256B A8 0F           	test	al,0Fh
0800:256D 74 03           	jz	2572h

l0800_256F:
0800:256F 80 E4 F0        	and	ah,0F0h

l0800_2572:
0800:2572 22 24           	and	ah,[si]
0800:2574 0A C4           	or	al,ah
0800:2576 8A E0           	mov	ah,al
0800:2578 25 F0 0F        	and	ax,0FF0h
0800:257B AB              	stosw
0800:257C 46              	inc	si
0800:257D 43              	inc	bx
0800:257E E2 E0           	loop	2560h

l0800_2580:
0800:2580 81 C7 30 01     	add	di,130h
0800:2584 FE CA           	dec	dl
0800:2586 75 D5           	jnz	255Dh

l0800_2588:
0800:2588 E9 BA 00        	jmp	2645h

l0800_258B:
0800:258B 8E DA           	mov	ds,dx
0800:258D BA 10 00        	mov	dx,10h

l0800_2590:
0800:2590 B9 08 00        	mov	cx,8h

l0800_2593:
0800:2593 8A 07           	mov	al,[bx]
0800:2595 B4 FF           	mov	ah,0FFh
0800:2597 A8 F0           	test	al,0F0h
0800:2599 74 03           	jz	259Eh

l0800_259B:
0800:259B 80 E4 0F        	and	ah,0Fh

l0800_259E:
0800:259E A8 0F           	test	al,0Fh
0800:25A0 74 03           	jz	25A5h

l0800_25A2:
0800:25A2 80 E4 F0        	and	ah,0F0h

l0800_25A5:
0800:25A5 22 24           	and	ah,[si]
0800:25A7 0A C4           	or	al,ah
0800:25A9 AA              	stosb
0800:25AA 46              	inc	si
0800:25AB 43              	inc	bx
0800:25AC E2 E5           	loop	2593h

l0800_25AE:
0800:25AE 81 C7 F8 1F     	add	di,1FF8h
0800:25B2 79 04           	jns	25B8h

l0800_25B4:
0800:25B4 81 EF 60 7F     	sub	di,7F60h

l0800_25B8:
0800:25B8 FE CA           	dec	dl
0800:25BA 75 D4           	jnz	2590h

l0800_25BC:
0800:25BC E9 86 00        	jmp	2645h

l0800_25BF:
0800:25BF 8B F0           	mov	si,ax
0800:25C1 06              	push	es
0800:25C2 B8 00 A0        	mov	ax,0A000h
0800:25C5 8E C0           	mov	es,ax
0800:25C7 B8 00 A4        	mov	ax,0A400h
0800:25CA 8E D8           	mov	ds,ax
0800:25CC BA CE 03        	mov	dx,3CEh
0800:25CF B0 08           	mov	al,8h
0800:25D1 EE              	out	dx,al
0800:25D2 42              	inc	dx
0800:25D3 B0 FF           	mov	al,0FFh
0800:25D5 EE              	out	dx,al
0800:25D6 4A              	dec	dx
0800:25D7 B0 02           	mov	al,2h
0800:25D9 EE              	out	dx,al
0800:25DA 42              	inc	dx
0800:25DB 32 C0           	xor	al,al
0800:25DD EE              	out	dx,al
0800:25DE 2E C6 06 81 24 10 	mov	byte ptr cs:[2481h],10h

l0800_25E4:
0800:25E4 BA CE 03        	mov	dx,3CEh
0800:25E7 B0 05           	mov	al,5h
0800:25E9 EE              	out	dx,al
0800:25EA 42              	inc	dx
0800:25EB B0 08           	mov	al,8h
0800:25ED EE              	out	dx,al
0800:25EE 8A 27           	mov	ah,[bx]
0800:25F0 8A 47 01        	mov	al,[bx+1h]
0800:25F3 2E A2 82 24     	mov	cs:[2482h],al
0800:25F7 BA CE 03        	mov	dx,3CEh
0800:25FA B0 05           	mov	al,5h
0800:25FC EE              	out	dx,al
0800:25FD 42              	inc	dx
0800:25FE 32 C0           	xor	al,al
0800:2600 EE              	out	dx,al
0800:2601 4A              	dec	dx
0800:2602 B0 04           	mov	al,4h
0800:2604 EE              	out	dx,al
0800:2605 BA C4 03        	mov	dx,3C4h
0800:2608 B0 02           	mov	al,2h
0800:260A EE              	out	dx,al
0800:260B B5 00           	mov	ch,0h
0800:260D E8 3B 00        	call	264Bh
0800:2610 B5 01           	mov	ch,1h
0800:2612 E8 36 00        	call	264Bh
0800:2615 B5 02           	mov	ch,2h
0800:2617 E8 31 00        	call	264Bh
0800:261A B5 03           	mov	ch,3h
0800:261C E8 2C 00        	call	264Bh
0800:261F BA CE 03        	mov	dx,3CEh
0800:2622 B0 04           	mov	al,4h
0800:2624 EE              	out	dx,al
0800:2625 42              	inc	dx
0800:2626 B0 03           	mov	al,3h
0800:2628 EE              	out	dx,al
0800:2629 32 ED           	xor	ch,ch
0800:262B 83 C7 28        	add	di,28h
0800:262E 83 C6 02        	add	si,2h
0800:2631 83 C3 02        	add	bx,2h
0800:2634 2E FE 0E 81 24  	dec	byte ptr cs:[2481h]
0800:2639 75 A9           	jnz	25E4h

l0800_263B:
0800:263B BA C4 03        	mov	dx,3C4h
0800:263E B0 02           	mov	al,2h
0800:2640 EE              	out	dx,al
0800:2641 42              	inc	dx
0800:2642 B0 0F           	mov	al,0Fh
0800:2644 EE              	out	dx,al

l0800_2645:
0800:2645 07              	pop	es
0800:2646 1F              	pop	ds
0800:2647 5E              	pop	si
0800:2648 5F              	pop	di
0800:2649 5D              	pop	bp
0800:264A CB              	retf

;; CompositeEgaSpritePlane_264B: 0800:264B
;;   Called from:
;;     0800:260D (in DrawCompositeTacticalTile_2483)
;;     0800:2612 (in DrawCompositeTacticalTile_2483)
;;     0800:2617 (in DrawCompositeTacticalTile_2483)
;;     0800:261C (in DrawCompositeTacticalTile_2483)
CompositeEgaSpritePlane_264B proc
0800:264B BA CF 03        	mov	dx,3CFh
0800:264E 8A C5           	mov	al,ch
0800:2650 EE              	out	dx,al
0800:2651 BA C5 03        	mov	dx,3C5h
0800:2654 B0 01           	mov	al,1h
0800:2656 0A ED           	or	ch,ch
0800:2658 74 06           	jz	2660h

l0800_265A:
0800:265A D0 E0           	shl	al,1h
0800:265C FE CD           	dec	ch
0800:265E 75 FA           	jnz	265Ah

l0800_2660:
0800:2660 EE              	out	dx,al
0800:2661 8A 04           	mov	al,[si]
0800:2663 22 C4           	and	al,ah
0800:2665 0A 07           	or	al,[bx]
0800:2667 26 8A 2D        	mov	ch,es:[di]
0800:266A 26 88 05        	mov	es:[di],al
0800:266D 8A 44 01        	mov	al,[si+1h]
0800:2670 2E 22 06 82 24  	and	al,cs:[2482h]
0800:2675 0A 47 01        	or	al,[bx+1h]
0800:2678 26 8A 6D 01     	mov	ch,es:[di+1h]
0800:267C 26 88 45 01     	mov	es:[di+1h],al
0800:2680 C3              	ret
0800:2681    00 00                                         ..             

;; CopyBufferToVideoRegion_2683: 0800:2683
;;   Called from:
;;     0800:394C (in HideMouseCursorOverlayUnlocked_387D)
;;     0D73:3411 (in LoadAndPresentScreen_33C1)
;;     0D73:4816 (in ShowInvalidSaveVersionDialog_4611)
;;     1A1F:50FE (in ShowPendingNarrationPrompt_4FA6)
CopyBufferToVideoRegion_2683 proc
0800:2683 55              	push	bp
0800:2684 8B EC           	mov	bp,sp
0800:2686 57              	push	di
0800:2687 56              	push	si
0800:2688 1E              	push	ds
0800:2689 B8 84 41        	mov	ax,4184h
0800:268C 8E D8           	mov	ds,ax
0800:268E 80 3E 99 0B 00  	cmp	byte ptr [0B99h],0h
0800:2693 74 03           	jz	2698h

l0800_2695:
0800:2695 E9 98 01        	jmp	2830h

l0800_2698:
0800:2698 FE 06 99 0B     	inc	byte ptr [0B99h]
0800:269C 8B 7E 06        	mov	di,[bp+6h]
0800:269F 8B 56 08        	mov	dx,[bp+8h]
0800:26A2 8B 5E 0A        	mov	bx,[bp+0Ah]
0800:26A5 8B 4E 0C        	mov	cx,[bp+0Ch]
0800:26A8 D1 E1           	shl	cx,1h
0800:26AA D1 E1           	shl	cx,1h
0800:26AC D1 E1           	shl	cx,1h
0800:26AE 8B 76 0E        	mov	si,[bp+0Eh]
0800:26B1 8B 46 10        	mov	ax,[bp+10h]
0800:26B4 2E A3 81 26     	mov	cs:[2681h],ax
0800:26B8 06              	push	es
0800:26B9 83 FB 28        	cmp	bx,28h
0800:26BC 76 03           	jbe	26C1h

l0800_26BE:
0800:26BE BB 28 00        	mov	bx,28h

l0800_26C1:
0800:26C1 0B DB           	or	bx,bx
0800:26C3 75 03           	jnz	26C8h

l0800_26C5:
0800:26C5 EB 33           	jmp	26FAh
0800:26C7                      90                                .        

l0800_26C8:
0800:26C8 81 F9 C8 00     	cmp	cx,0C8h
0800:26CC 76 03           	jbe	26D1h

l0800_26CE:
0800:26CE B9 C8 00        	mov	cx,0C8h

l0800_26D1:
0800:26D1 0B C9           	or	cx,cx
0800:26D3 75 03           	jnz	26D8h

l0800_26D5:
0800:26D5 EB 23           	jmp	26FAh
0800:26D7                      90                                .        

l0800_26D8:
0800:26D8 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:26DD 74 52           	jz	2731h

l0800_26DF:
0800:26DF 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:26E4 75 03           	jnz	26E9h

l0800_26E6:
0800:26E6 E9 82 00        	jmp	276Bh

l0800_26E9:
0800:26E9 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:26EE 75 03           	jnz	26F3h

l0800_26F0:
0800:26F0 E9 CE 00        	jmp	27C1h

l0800_26F3:
0800:26F3 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:26F8 74 03           	jz	26FDh

l0800_26FA:
0800:26FA E9 28 01        	jmp	2825h

l0800_26FD:
0800:26FD D1 E7           	shl	di,1h
0800:26FF D1 E7           	shl	di,1h
0800:2701 D1 E7           	shl	di,1h
0800:2703 B8 00 0A        	mov	ax,0A00h
0800:2706 F7 E2           	mul	dx
0800:2708 03 F8           	add	di,ax
0800:270A 03 3E 9B 0B     	add	di,[0B9Bh]
0800:270E 8B D1           	mov	dx,cx
0800:2710 D1 E3           	shl	bx,1h
0800:2712 D1 E3           	shl	bx,1h
0800:2714 A1 9D 0B        	mov	ax,[0B9Dh]
0800:2717 8E C0           	mov	es,ax
0800:2719 2E A1 81 26     	mov	ax,cs:[2681h]
0800:271D 8E D8           	mov	ds,ax

l0800_271F:
0800:271F 8B CB           	mov	cx,bx

l0800_2721:
0800:2721 F3 A5           	rep movsw

l0800_2723:
0800:2723 2B FB           	sub	di,bx
0800:2725 2B FB           	sub	di,bx
0800:2727 81 C7 40 01     	add	di,140h
0800:272B 4A              	dec	dx
0800:272C 75 F1           	jnz	271Fh

l0800_272E:
0800:272E E9 F4 00        	jmp	2825h

l0800_2731:
0800:2731 D1 E7           	shl	di,1h
0800:2733 B8 40 01        	mov	ax,140h
0800:2736 F7 E2           	mul	dx
0800:2738 03 F8           	add	di,ax
0800:273A 03 3E 9B 0B     	add	di,[0B9Bh]
0800:273E 8B D1           	mov	dx,cx
0800:2740 A1 9D 0B        	mov	ax,[0B9Dh]
0800:2743 8E C0           	mov	es,ax
0800:2745 2E A1 81 26     	mov	ax,cs:[2681h]
0800:2749 8E D8           	mov	ds,ax

l0800_274B:
0800:274B 8B CB           	mov	cx,bx

l0800_274D:
0800:274D F3 A5           	rep movsw

l0800_274F:
0800:274F 2B FB           	sub	di,bx
0800:2751 2B FB           	sub	di,bx
0800:2753 81 C7 00 20     	add	di,2000h
0800:2757 8B CB           	mov	cx,bx

l0800_2759:
0800:2759 F3 A5           	rep movsw

l0800_275B:
0800:275B 2B FB           	sub	di,bx
0800:275D 2B FB           	sub	di,bx
0800:275F 81 EF B0 1F     	sub	di,1FB0h
0800:2763 83 EA 02        	sub	dx,2h
0800:2766 75 E3           	jnz	274Bh

l0800_2768:
0800:2768 E9 BA 00        	jmp	2825h

l0800_276B:
0800:276B D1 E7           	shl	di,1h
0800:276D D1 E7           	shl	di,1h
0800:276F B8 40 01        	mov	ax,140h
0800:2772 F7 E2           	mul	dx
0800:2774 03 F8           	add	di,ax
0800:2776 03 3E 9B 0B     	add	di,[0B9Bh]
0800:277A 8B D1           	mov	dx,cx
0800:277C D1 E3           	shl	bx,1h
0800:277E A1 9D 0B        	mov	ax,[0B9Dh]
0800:2781 8E C0           	mov	es,ax
0800:2783 2E A1 81 26     	mov	ax,cs:[2681h]
0800:2787 8E D8           	mov	ds,ax

l0800_2789:
0800:2789 8B CB           	mov	cx,bx

l0800_278B:
0800:278B F3 A5           	rep movsw

l0800_278D:
0800:278D 2B FB           	sub	di,bx
0800:278F 2B FB           	sub	di,bx
0800:2791 81 C7 00 20     	add	di,2000h
0800:2795 8B CB           	mov	cx,bx

l0800_2797:
0800:2797 F3 A5           	rep movsw

l0800_2799:
0800:2799 2B FB           	sub	di,bx
0800:279B 2B FB           	sub	di,bx
0800:279D 81 C7 00 20     	add	di,2000h
0800:27A1 8B CB           	mov	cx,bx

l0800_27A3:
0800:27A3 F3 A5           	rep movsw

l0800_27A5:
0800:27A5 2B FB           	sub	di,bx
0800:27A7 2B FB           	sub	di,bx
0800:27A9 81 C7 00 20     	add	di,2000h
0800:27AD 8B CB           	mov	cx,bx

l0800_27AF:
0800:27AF F3 A5           	rep movsw

l0800_27B1:
0800:27B1 2B FB           	sub	di,bx
0800:27B3 2B FB           	sub	di,bx
0800:27B5 81 EF 60 5F     	sub	di,5F60h
0800:27B9 83 EA 04        	sub	dx,4h
0800:27BC 75 CB           	jnz	2789h

l0800_27BE:
0800:27BE EB 65           	jmp	2825h
0800:27C0 90                                              .               

l0800_27C1:
0800:27C1 B8 40 01        	mov	ax,140h
0800:27C4 F7 E2           	mul	dx
0800:27C6 03 F8           	add	di,ax
0800:27C8 03 3E 9B 0B     	add	di,[0B9Bh]
0800:27CC A1 9D 0B        	mov	ax,[0B9Dh]
0800:27CF 8E C0           	mov	es,ax
0800:27D1 FA              	cli
0800:27D2 BA CE 03        	mov	dx,3CEh
0800:27D5 B8 05 00        	mov	ax,5h
0800:27D8 EE              	out	dx,al
0800:27D9 42              	inc	dx
0800:27DA 8A C4           	mov	al,ah
0800:27DC EE              	out	dx,al
0800:27DD 4A              	dec	dx
0800:27DE B8 08 FF        	mov	ax,0FF08h
0800:27E1 EE              	out	dx,al
0800:27E2 42              	inc	dx
0800:27E3 8A C4           	mov	al,ah
0800:27E5 EE              	out	dx,al
0800:27E6 8A FB           	mov	bh,bl
0800:27E8 B2 C4           	mov	dl,0C4h
0800:27EA B0 02           	mov	al,2h
0800:27EC EE              	out	dx,al
0800:27ED 42              	inc	dx
0800:27EE 2E A1 81 26     	mov	ax,cs:[2681h]
0800:27F2 8E D8           	mov	ds,ax

l0800_27F4:
0800:27F4 B0 01           	mov	al,1h
0800:27F6 EE              	out	dx,al
0800:27F7 AC              	lodsb
0800:27F8 26 86 05        	xchg	es:[di],al
0800:27FB B0 02           	mov	al,2h
0800:27FD EE              	out	dx,al
0800:27FE AC              	lodsb
0800:27FF 26 86 05        	xchg	es:[di],al
0800:2802 B0 04           	mov	al,4h
0800:2804 EE              	out	dx,al
0800:2805 AC              	lodsb
0800:2806 26 86 05        	xchg	es:[di],al
0800:2809 B0 08           	mov	al,8h
0800:280B EE              	out	dx,al
0800:280C 26 8A 05        	mov	al,es:[di]
0800:280F A4              	movsb
0800:2810 FE CB           	dec	bl
0800:2812 75 E0           	jnz	27F4h

l0800_2814:
0800:2814 8A DF           	mov	bl,bh
0800:2816 8A C3           	mov	al,bl
0800:2818 32 E4           	xor	ah,ah
0800:281A 2B F8           	sub	di,ax
0800:281C 83 C7 28        	add	di,28h
0800:281F E2 D3           	loop	27F4h

l0800_2821:
0800:2821 B0 0F           	mov	al,0Fh
0800:2823 EE              	out	dx,al
0800:2824 FB              	sti

l0800_2825:
0800:2825 07              	pop	es
0800:2826 B8 84 41        	mov	ax,4184h
0800:2829 8E D8           	mov	ds,ax
0800:282B C6 06 99 0B 00  	mov	byte ptr [0B99h],0h

l0800_2830:
0800:2830 1F              	pop	ds
0800:2831 5E              	pop	si
0800:2832 5F              	pop	di
0800:2833 5D              	pop	bp
0800:2834 CB              	retf

;; CopyVideoRegionToBuffer_2835: 0800:2835
;;   Called from:
;;     0800:3B36 (in ShowMouseCursorOverlayUnlocked_3A53)
;;     0D73:469E (in ShowInvalidSaveVersionDialog_4611)
;;     1A1F:4FD9 (in ShowPendingNarrationPrompt_4FA6)
CopyVideoRegionToBuffer_2835 proc
0800:2835 55              	push	bp
0800:2836 8B EC           	mov	bp,sp
0800:2838 57              	push	di
0800:2839 56              	push	si
0800:283A 1E              	push	ds
0800:283B B8 84 41        	mov	ax,4184h
0800:283E 8E D8           	mov	ds,ax
0800:2840 80 3E 9A 0B 00  	cmp	byte ptr [0B9Ah],0h
0800:2845 74 03           	jz	284Ah

l0800_2847:
0800:2847 E9 6C 01        	jmp	29B6h

l0800_284A:
0800:284A FE 06 9A 0B     	inc	byte ptr [0B9Ah]
0800:284E 8B 76 06        	mov	si,[bp+6h]
0800:2851 8B 56 08        	mov	dx,[bp+8h]
0800:2854 8B 5E 0A        	mov	bx,[bp+0Ah]
0800:2857 8B 4E 0C        	mov	cx,[bp+0Ch]
0800:285A D1 E1           	shl	cx,1h
0800:285C D1 E1           	shl	cx,1h
0800:285E D1 E1           	shl	cx,1h
0800:2860 8B 7E 0E        	mov	di,[bp+0Eh]
0800:2863 57              	push	di
0800:2864 8B 46 10        	mov	ax,[bp+10h]
0800:2867 06              	push	es
0800:2868 8E C0           	mov	es,ax
0800:286A 83 FB 28        	cmp	bx,28h
0800:286D 76 03           	jbe	2872h

l0800_286F:
0800:286F BB 28 00        	mov	bx,28h

l0800_2872:
0800:2872 0B DB           	or	bx,bx
0800:2874 75 03           	jnz	2879h

l0800_2876:
0800:2876 EB 30           	jmp	28A8h
0800:2878                         90                              .       

l0800_2879:
0800:2879 81 F9 C8 00     	cmp	cx,0C8h
0800:287D 76 03           	jbe	2882h

l0800_287F:
0800:287F B9 C8 00        	mov	cx,0C8h

l0800_2882:
0800:2882 0B C9           	or	cx,cx
0800:2884 75 03           	jnz	2889h

l0800_2886:
0800:2886 EB 20           	jmp	28A8h
0800:2888                         90                              .       

l0800_2889:
0800:2889 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:288E 74 49           	jz	28D9h

l0800_2890:
0800:2890 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2895 74 76           	jz	290Dh

l0800_2897:
0800:2897 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:289C 75 03           	jnz	28A1h

l0800_289E:
0800:289E E9 BC 00        	jmp	295Dh

l0800_28A1:
0800:28A1 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:28A6 74 03           	jz	28ABh

l0800_28A8:
0800:28A8 E9 FB 00        	jmp	29A6h

l0800_28AB:
0800:28AB D1 E6           	shl	si,1h
0800:28AD D1 E6           	shl	si,1h
0800:28AF D1 E6           	shl	si,1h
0800:28B1 B8 00 0A        	mov	ax,0A00h
0800:28B4 F7 E2           	mul	dx
0800:28B6 03 F0           	add	si,ax
0800:28B8 03 36 9B 0B     	add	si,[0B9Bh]
0800:28BC 8B D1           	mov	dx,cx
0800:28BE D1 E3           	shl	bx,1h
0800:28C0 D1 E3           	shl	bx,1h
0800:28C2 A1 9D 0B        	mov	ax,[0B9Dh]
0800:28C5 8E D8           	mov	ds,ax

l0800_28C7:
0800:28C7 8B CB           	mov	cx,bx

l0800_28C9:
0800:28C9 F3 A5           	rep movsw

l0800_28CB:
0800:28CB 2B F3           	sub	si,bx
0800:28CD 2B F3           	sub	si,bx
0800:28CF 81 C6 40 01     	add	si,140h
0800:28D3 4A              	dec	dx
0800:28D4 75 F1           	jnz	28C7h

l0800_28D6:
0800:28D6 E9 CD 00        	jmp	29A6h

l0800_28D9:
0800:28D9 D1 E6           	shl	si,1h
0800:28DB B8 40 01        	mov	ax,140h
0800:28DE F7 E2           	mul	dx
0800:28E0 03 F0           	add	si,ax
0800:28E2 03 36 9B 0B     	add	si,[0B9Bh]
0800:28E6 8B D1           	mov	dx,cx
0800:28E8 A1 9D 0B        	mov	ax,[0B9Dh]
0800:28EB 8E D8           	mov	ds,ax

l0800_28ED:
0800:28ED 8B CB           	mov	cx,bx

l0800_28EF:
0800:28EF F3 A5           	rep movsw

l0800_28F1:
0800:28F1 2B F3           	sub	si,bx
0800:28F3 2B F3           	sub	si,bx
0800:28F5 81 C6 00 20     	add	si,2000h
0800:28F9 8B CB           	mov	cx,bx

l0800_28FB:
0800:28FB F3 A5           	rep movsw

l0800_28FD:
0800:28FD 2B F3           	sub	si,bx
0800:28FF 2B F3           	sub	si,bx
0800:2901 81 EE B0 1F     	sub	si,1FB0h
0800:2905 83 EA 02        	sub	dx,2h
0800:2908 75 E3           	jnz	28EDh

l0800_290A:
0800:290A E9 99 00        	jmp	29A6h

l0800_290D:
0800:290D D1 E6           	shl	si,1h
0800:290F D1 E6           	shl	si,1h
0800:2911 B8 40 01        	mov	ax,140h
0800:2914 F7 E2           	mul	dx
0800:2916 03 F0           	add	si,ax
0800:2918 03 36 9B 0B     	add	si,[0B9Bh]
0800:291C 8B D1           	mov	dx,cx
0800:291E D1 E3           	shl	bx,1h
0800:2920 A1 9D 0B        	mov	ax,[0B9Dh]
0800:2923 8E D8           	mov	ds,ax

l0800_2925:
0800:2925 8B CB           	mov	cx,bx

l0800_2927:
0800:2927 F3 A5           	rep movsw

l0800_2929:
0800:2929 2B F3           	sub	si,bx
0800:292B 2B F3           	sub	si,bx
0800:292D 81 C6 00 20     	add	si,2000h
0800:2931 8B CB           	mov	cx,bx

l0800_2933:
0800:2933 F3 A5           	rep movsw

l0800_2935:
0800:2935 2B F3           	sub	si,bx
0800:2937 2B F3           	sub	si,bx
0800:2939 81 C6 00 20     	add	si,2000h
0800:293D 8B CB           	mov	cx,bx

l0800_293F:
0800:293F F3 A5           	rep movsw

l0800_2941:
0800:2941 2B F3           	sub	si,bx
0800:2943 2B F3           	sub	si,bx
0800:2945 81 C6 00 20     	add	si,2000h
0800:2949 8B CB           	mov	cx,bx

l0800_294B:
0800:294B F3 A5           	rep movsw

l0800_294D:
0800:294D 2B F3           	sub	si,bx
0800:294F 2B F3           	sub	si,bx
0800:2951 81 EE 60 5F     	sub	si,5F60h
0800:2955 83 EA 04        	sub	dx,4h
0800:2958 75 CB           	jnz	2925h

l0800_295A:
0800:295A EB 4A           	jmp	29A6h
0800:295C                                     90                      .   

l0800_295D:
0800:295D B8 40 01        	mov	ax,140h
0800:2960 F7 E2           	mul	dx
0800:2962 03 F0           	add	si,ax
0800:2964 03 36 9B 0B     	add	si,[0B9Bh]
0800:2968 A1 9D 0B        	mov	ax,[0B9Dh]
0800:296B 8E D8           	mov	ds,ax
0800:296D FA              	cli
0800:296E BA CE 03        	mov	dx,3CEh
0800:2971 B8 05 02        	mov	ax,205h
0800:2974 EE              	out	dx,al
0800:2975 42              	inc	dx
0800:2976 8A C4           	mov	al,ah
0800:2978 EE              	out	dx,al
0800:2979 4A              	dec	dx
0800:297A B0 04           	mov	al,4h
0800:297C EE              	out	dx,al
0800:297D 42              	inc	dx
0800:297E 8A E1           	mov	ah,cl

l0800_2980:
0800:2980 8A CB           	mov	cl,bl

l0800_2982:
0800:2982 32 C0           	xor	al,al
0800:2984 EE              	out	dx,al
0800:2985 8A 04           	mov	al,[si]
0800:2987 AA              	stosb
0800:2988 B0 01           	mov	al,1h
0800:298A EE              	out	dx,al
0800:298B 8A 04           	mov	al,[si]
0800:298D AA              	stosb
0800:298E B0 02           	mov	al,2h
0800:2990 EE              	out	dx,al
0800:2991 8A 04           	mov	al,[si]
0800:2993 AA              	stosb
0800:2994 B0 03           	mov	al,3h
0800:2996 EE              	out	dx,al
0800:2997 A4              	movsb
0800:2998 FE C9           	dec	cl
0800:299A 75 E6           	jnz	2982h

l0800_299C:
0800:299C 2B F3           	sub	si,bx
0800:299E 83 C6 28        	add	si,28h
0800:29A1 FE CC           	dec	ah
0800:29A3 75 DB           	jnz	2980h

l0800_29A5:
0800:29A5 FB              	sti

l0800_29A6:
0800:29A6 07              	pop	es
0800:29A7 B8 84 41        	mov	ax,4184h
0800:29AA 8E D8           	mov	ds,ax
0800:29AC C6 06 9A 0B 00  	mov	byte ptr [0B9Ah],0h
0800:29B1 8B C7           	mov	ax,di
0800:29B3 5F              	pop	di
0800:29B4 2B C7           	sub	ax,di

l0800_29B6:
0800:29B6 1F              	pop	ds
0800:29B7 5E              	pop	si
0800:29B8 5F              	pop	di
0800:29B9 5D              	pop	bp
0800:29BA CB              	retf

;; AdvanceFarPointerBy32K_29BB: 0800:29BB
;;   Called from:
;;     1A1F:0487 (in LoadTacticalIconResource_0468)
AdvanceFarPointerBy32K_29BB proc
0800:29BB 55              	push	bp
0800:29BC 8B EC           	mov	bp,sp
0800:29BE 57              	push	di
0800:29BF 56              	push	si
0800:29C0 1E              	push	ds
0800:29C1 B8 84 41        	mov	ax,4184h
0800:29C4 8E D8           	mov	ds,ax
0800:29C6 8B 46 06        	mov	ax,[bp+6h]
0800:29C9 8B 56 08        	mov	dx,[bp+8h]
0800:29CC 81 C2 00 08     	add	dx,800h
0800:29D0 1F              	pop	ds
0800:29D1 5E              	pop	si
0800:29D2 5F              	pop	di
0800:29D3 5D              	pop	bp
0800:29D4 CB              	retf

;; DrawHorizontalVideoRun_29D5: 0800:29D5
;;   Called from:
;;     3365:0070 (in DrawHorizontalSpan_0007)
DrawHorizontalVideoRun_29D5 proc
0800:29D5 55              	push	bp
0800:29D6 8B EC           	mov	bp,sp
0800:29D8 57              	push	di
0800:29D9 56              	push	si
0800:29DA 1E              	push	ds
0800:29DB B8 84 41        	mov	ax,4184h
0800:29DE 8E D8           	mov	ds,ax
0800:29E0 06              	push	es
0800:29E1 A1 9D 0B        	mov	ax,[0B9Dh]
0800:29E4 8E C0           	mov	es,ax
0800:29E6 8B 46 06        	mov	ax,[bp+6h]
0800:29E9 A3 9F 0B        	mov	[0B9Fh],ax
0800:29EC 8B 46 08        	mov	ax,[bp+8h]
0800:29EF A3 A1 0B        	mov	[0BA1h],ax
0800:29F2 8B 4E 0A        	mov	cx,[bp+0Ah]
0800:29F5 89 0E A3 0B     	mov	[0BA3h],cx
0800:29F9 8B 46 0C        	mov	ax,[bp+0Ch]
0800:29FC A3 A5 0B        	mov	[0BA5h],ax
0800:29FF 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2A04 74 11           	jz	2A17h

l0800_2A06:
0800:2A06 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2A0B 74 24           	jz	2A31h

l0800_2A0D:
0800:2A0D 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2A12 74 5B           	jz	2A6Fh

l0800_2A14:
0800:2A14 E9 9D 00        	jmp	2AB4h

l0800_2A17:
0800:2A17 A1 A1 0B        	mov	ax,[0BA1h]
0800:2A1A BA 40 01        	mov	dx,140h
0800:2A1D F7 E2           	mul	dx
0800:2A1F 03 06 9F 0B     	add	ax,[0B9Fh]
0800:2A23 8B F8           	mov	di,ax
0800:2A25 03 3E 9B 0B     	add	di,[0B9Bh]
0800:2A29 A1 A5 0B        	mov	ax,[0BA5h]

l0800_2A2C:
0800:2A2C F3 AA           	rep stosb

l0800_2A2E:
0800:2A2E EB 7E           	jmp	2AAEh
0800:2A30 90                                              .               

l0800_2A31:
0800:2A31 BA CE 03        	mov	dx,3CEh
0800:2A34 B8 05 02        	mov	ax,205h
0800:2A37 EE              	out	dx,al
0800:2A38 42              	inc	dx
0800:2A39 8A C4           	mov	al,ah
0800:2A3B EE              	out	dx,al
0800:2A3C 4A              	dec	dx
0800:2A3D B8 08 FF        	mov	ax,0FF08h
0800:2A40 EE              	out	dx,al
0800:2A41 42              	inc	dx
0800:2A42 8A C4           	mov	al,ah
0800:2A44 EE              	out	dx,al
0800:2A45 4A              	dec	dx
0800:2A46 BA 28 00        	mov	dx,28h
0800:2A49 A1 A1 0B        	mov	ax,[0BA1h]
0800:2A4C F6 E2           	mul	dl
0800:2A4E 8B 1E 9F 0B     	mov	bx,[0B9Fh]
0800:2A52 D1 EB           	shr	bx,1h
0800:2A54 D1 EB           	shr	bx,1h
0800:2A56 D1 EB           	shr	bx,1h
0800:2A58 03 C3           	add	ax,bx
0800:2A5A 8B F8           	mov	di,ax
0800:2A5C 03 3E 9B 0B     	add	di,[0B9Bh]
0800:2A60 8B 0E A3 0B     	mov	cx,[0BA3h]
0800:2A64 A1 A5 0B        	mov	ax,[0BA5h]
0800:2A67 26 8A 25        	mov	ah,es:[di]

l0800_2A6A:
0800:2A6A F3 AA           	rep stosb

l0800_2A6C:
0800:2A6C EB 40           	jmp	2AAEh
0800:2A6E                                           90                  . 

l0800_2A6F:
0800:2A6F B9 04 00        	mov	cx,4h
0800:2A72 D2 E0           	shl	al,cl
0800:2A74 0B 06 A5 0B     	or	ax,[0BA5h]
0800:2A78 8A E0           	mov	ah,al
0800:2A7A A3 A5 0B        	mov	[0BA5h],ax
0800:2A7D A1 A1 0B        	mov	ax,[0BA1h]
0800:2A80 24 FC           	and	al,0FCh
0800:2A82 BA 28 00        	mov	dx,28h
0800:2A85 F6 E2           	mul	dl
0800:2A87 8B 16 9F 0B     	mov	dx,[0B9Fh]
0800:2A8B D1 EA           	shr	dx,1h
0800:2A8D 03 C2           	add	ax,dx
0800:2A8F 8B 16 A1 0B     	mov	dx,[0BA1h]
0800:2A93 83 E2 03        	and	dx,3h
0800:2A96 74 07           	jz	2A9Fh

l0800_2A98:
0800:2A98 8B CA           	mov	cx,dx

l0800_2A9A:
0800:2A9A 80 C4 20        	add	ah,20h
0800:2A9D E2 FB           	loop	2A9Ah

l0800_2A9F:
0800:2A9F 8B F8           	mov	di,ax
0800:2AA1 03 3E 9B 0B     	add	di,[0B9Bh]
0800:2AA5 8B 0E A3 0B     	mov	cx,[0BA3h]
0800:2AA9 A1 A5 0B        	mov	ax,[0BA5h]

l0800_2AAC:
0800:2AAC F3 AA           	rep stosb

l0800_2AAE:
0800:2AAE 07              	pop	es
0800:2AAF 1F              	pop	ds
0800:2AB0 5E              	pop	si
0800:2AB1 5F              	pop	di
0800:2AB2 5D              	pop	bp
0800:2AB3 CB              	retf

l0800_2AB4:
0800:2AB4 25 03 00        	and	ax,3h
0800:2AB7 A3 A5 0B        	mov	[0BA5h],ax
0800:2ABA D0 E0           	shl	al,1h
0800:2ABC D0 E0           	shl	al,1h
0800:2ABE 0B 06 A5 0B     	or	ax,[0BA5h]
0800:2AC2 8A D8           	mov	bl,al
0800:2AC4 B1 04           	mov	cl,4h
0800:2AC6 D2 E0           	shl	al,cl
0800:2AC8 0A C3           	or	al,bl
0800:2ACA 8A E0           	mov	ah,al
0800:2ACC A3 A5 0B        	mov	[0BA5h],ax
0800:2ACF A1 A1 0B        	mov	ax,[0BA1h]
0800:2AD2 24 FE           	and	al,0FEh
0800:2AD4 BA 28 00        	mov	dx,28h
0800:2AD7 F6 E2           	mul	dl
0800:2AD9 8B 16 9F 0B     	mov	dx,[0B9Fh]
0800:2ADD D1 EA           	shr	dx,1h
0800:2ADF D1 EA           	shr	dx,1h
0800:2AE1 03 C2           	add	ax,dx
0800:2AE3 8B 16 A1 0B     	mov	dx,[0BA1h]
0800:2AE7 83 E2 01        	and	dx,1h
0800:2AEA 74 03           	jz	2AEFh

l0800_2AEC:
0800:2AEC 80 C4 20        	add	ah,20h

l0800_2AEF:
0800:2AEF 8B F8           	mov	di,ax
0800:2AF1 03 3E 9B 0B     	add	di,[0B9Bh]
0800:2AF5 8B 0E A3 0B     	mov	cx,[0BA3h]
0800:2AF9 A1 A5 0B        	mov	ax,[0BA5h]

l0800_2AFC:
0800:2AFC F3 AA           	rep stosb

l0800_2AFE:
0800:2AFE EB AE           	jmp	2AAEh

;; CopyVideoRegion_2B00: 0800:2B00
;;   Called from:
;;     3329:0091 (in CopyClippedVideoRegion_000E)
;;     3329:00ED (in CopyClippedVideoRegion_000E)
CopyVideoRegion_2B00 proc
0800:2B00 55              	push	bp
0800:2B01 8B EC           	mov	bp,sp
0800:2B03 57              	push	di
0800:2B04 56              	push	si
0800:2B05 1E              	push	ds
0800:2B06 B8 84 41        	mov	ax,4184h
0800:2B09 8E D8           	mov	ds,ax
0800:2B0B 06              	push	es
0800:2B0C 8B 46 06        	mov	ax,[bp+6h]
0800:2B0F 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2B14 74 14           	jz	2B2Ah

l0800_2B16:
0800:2B16 D1 E0           	shl	ax,1h
0800:2B18 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:2B1D 74 0B           	jz	2B2Ah

l0800_2B1F:
0800:2B1F D1 E0           	shl	ax,1h
0800:2B21 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2B26 74 02           	jz	2B2Ah

l0800_2B28:
0800:2B28 D1 E0           	shl	ax,1h

l0800_2B2A:
0800:2B2A A3 A9 0B        	mov	[0BA9h],ax
0800:2B2D 8B 46 08        	mov	ax,[bp+8h]
0800:2B30 A3 AD 0B        	mov	[0BADh],ax
0800:2B33 8B 46 0A        	mov	ax,[bp+0Ah]
0800:2B36 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2B3B 74 14           	jz	2B51h

l0800_2B3D:
0800:2B3D D1 E0           	shl	ax,1h
0800:2B3F 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:2B44 74 0B           	jz	2B51h

l0800_2B46:
0800:2B46 D1 E0           	shl	ax,1h
0800:2B48 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2B4D 74 02           	jz	2B51h

l0800_2B4F:
0800:2B4F D1 E0           	shl	ax,1h

l0800_2B51:
0800:2B51 A3 AB 0B        	mov	[0BABh],ax
0800:2B54 8B 46 0C        	mov	ax,[bp+0Ch]
0800:2B57 A3 AF 0B        	mov	[0BAFh],ax
0800:2B5A 8B 46 0E        	mov	ax,[bp+0Eh]
0800:2B5D 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2B62 74 0B           	jz	2B6Fh

l0800_2B64:
0800:2B64 D1 E0           	shl	ax,1h
0800:2B66 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:2B6B 74 02           	jz	2B6Fh

l0800_2B6D:
0800:2B6D D1 E0           	shl	ax,1h

l0800_2B6F:
0800:2B6F A3 B1 0B        	mov	[0BB1h],ax
0800:2B72 8B 46 10        	mov	ax,[bp+10h]
0800:2B75 A3 B3 0B        	mov	[0BB3h],ax
0800:2B78 8B 46 12        	mov	ax,[bp+12h]
0800:2B7B A3 B5 0B        	mov	[0BB5h],ax
0800:2B7E 8B 46 14        	mov	ax,[bp+14h]
0800:2B81 A3 A7 0B        	mov	[0BA7h],ax
0800:2B84 8B 7E 16        	mov	di,[bp+16h]
0800:2B87 8B 46 18        	mov	ax,[bp+18h]
0800:2B8A 8E C0           	mov	es,ax
0800:2B8C A1 AD 0B        	mov	ax,[0BADh]
0800:2B8F BA 28 00        	mov	dx,28h
0800:2B92 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2B97 74 1A           	jz	2BB3h

l0800_2B99:
0800:2B99 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2B9E 74 10           	jz	2BB0h

l0800_2BA0:
0800:2BA0 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2BA5 75 03           	jnz	2BAAh

l0800_2BA7:
0800:2BA7 25 FC 00        	and	ax,0FCh

l0800_2BAA:
0800:2BAA 25 FE 00        	and	ax,0FEh
0800:2BAD EB 04           	jmp	2BB3h
0800:2BAF                                              90                .

l0800_2BB0:
0800:2BB0 BA 40 01        	mov	dx,140h

l0800_2BB3:
0800:2BB3 F7 E2           	mul	dx
0800:2BB5 03 06 A9 0B     	add	ax,[0BA9h]
0800:2BB9 01 06 B5 0B     	add	[0BB5h],ax
0800:2BBD A1 AF 0B        	mov	ax,[0BAFh]
0800:2BC0 BA 28 00        	mov	dx,28h
0800:2BC3 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2BC8 74 1A           	jz	2BE4h

l0800_2BCA:
0800:2BCA 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2BCF 74 10           	jz	2BE1h

l0800_2BD1:
0800:2BD1 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2BD6 75 03           	jnz	2BDBh

l0800_2BD8:
0800:2BD8 25 FC 00        	and	ax,0FCh

l0800_2BDB:
0800:2BDB 25 FE 00        	and	ax,0FEh
0800:2BDE EB 04           	jmp	2BE4h
0800:2BE0 90                                              .               

l0800_2BE1:
0800:2BE1 BA 40 01        	mov	dx,140h

l0800_2BE4:
0800:2BE4 F7 E2           	mul	dx
0800:2BE6 03 06 AB 0B     	add	ax,[0BABh]
0800:2BEA 03 F8           	add	di,ax
0800:2BEC 8B 36 B5 0B     	mov	si,[0BB5h]
0800:2BF0 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2BF5 74 5F           	jz	2C56h

l0800_2BF7:
0800:2BF7 77 03           	ja	2BFCh

l0800_2BF9:
0800:2BF9 E9 D3 00        	jmp	2CCFh

l0800_2BFC:
0800:2BFC 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2C01 74 2D           	jz	2C30h

l0800_2C03:
0800:2C03 FA              	cli
0800:2C04 BA CE 03        	mov	dx,3CEh
0800:2C07 B8 05 01        	mov	ax,105h
0800:2C0A EE              	out	dx,al
0800:2C0B 42              	inc	dx
0800:2C0C 8A C4           	mov	al,ah
0800:2C0E EE              	out	dx,al
0800:2C0F 8B 1E B1 0B     	mov	bx,[0BB1h]
0800:2C13 8B 16 B3 0B     	mov	dx,[0BB3h]
0800:2C17 A1 A7 0B        	mov	ax,[0BA7h]
0800:2C1A 8E D8           	mov	ds,ax

l0800_2C1C:
0800:2C1C 8B CB           	mov	cx,bx

l0800_2C1E:
0800:2C1E F3 A4           	rep movsb

l0800_2C20:
0800:2C20 B8 28 00        	mov	ax,28h
0800:2C23 2B C3           	sub	ax,bx
0800:2C25 03 F0           	add	si,ax
0800:2C27 03 F8           	add	di,ax
0800:2C29 4A              	dec	dx
0800:2C2A 75 F0           	jnz	2C1Ch

l0800_2C2C:
0800:2C2C FB              	sti
0800:2C2D E9 99 00        	jmp	2CC9h

l0800_2C30:
0800:2C30 BD 40 01        	mov	bp,140h
0800:2C33 8B 16 B3 0B     	mov	dx,[0BB3h]
0800:2C37 8B 1E B1 0B     	mov	bx,[0BB1h]
0800:2C3B A1 A7 0B        	mov	ax,[0BA7h]
0800:2C3E 8E D8           	mov	ds,ax

l0800_2C40:
0800:2C40 8B CB           	mov	cx,bx

l0800_2C42:
0800:2C42 F3 A5           	rep movsw

l0800_2C44:
0800:2C44 8B C3           	mov	ax,bx
0800:2C46 D1 E0           	shl	ax,1h
0800:2C48 2B F0           	sub	si,ax
0800:2C4A 2B F8           	sub	di,ax
0800:2C4C 03 F5           	add	si,bp
0800:2C4E 03 FD           	add	di,bp
0800:2C50 4A              	dec	dx
0800:2C51 75 ED           	jnz	2C40h

l0800_2C53:
0800:2C53 EB 74           	jmp	2CC9h
0800:2C55                90                                    .          

l0800_2C56:
0800:2C56 8B 1E AD 0B     	mov	bx,[0BADh]
0800:2C5A 83 E3 03        	and	bx,3h
0800:2C5D 74 09           	jz	2C68h

l0800_2C5F:
0800:2C5F 8B C3           	mov	ax,bx

l0800_2C61:
0800:2C61 81 C6 00 20     	add	si,2000h
0800:2C65 48              	dec	ax
0800:2C66 75 F9           	jnz	2C61h

l0800_2C68:
0800:2C68 F7 06 AF 0B 03 00 	test	word ptr [0BAFh],3h
0800:2C6E 74 0D           	jz	2C7Dh

l0800_2C70:
0800:2C70 A1 AF 0B        	mov	ax,[0BAFh]
0800:2C73 25 03 00        	and	ax,3h

l0800_2C76:
0800:2C76 81 C7 00 20     	add	di,2000h
0800:2C7A 48              	dec	ax
0800:2C7B 75 F9           	jnz	2C76h

l0800_2C7D:
0800:2C7D B8 00 20        	mov	ax,2000h
0800:2C80 2B 06 B1 0B     	sub	ax,[0BB1h]
0800:2C84 A3 B7 0B        	mov	[0BB7h],ax
0800:2C87 A1 B1 0B        	mov	ax,[0BB1h]
0800:2C8A 2D A0 00        	sub	ax,0A0h
0800:2C8D 05 00 60        	add	ax,6000h
0800:2C90 8B 16 A7 0B     	mov	dx,[0BA7h]

l0800_2C94:
0800:2C94 8B 0E B1 0B     	mov	cx,[0BB1h]
0800:2C98 D1 E9           	shr	cx,1h
0800:2C9A 1E              	push	ds
0800:2C9B 8E DA           	mov	ds,dx

l0800_2C9D:
0800:2C9D F3 A5           	rep movsw

l0800_2C9F:
0800:2C9F 1F              	pop	ds
0800:2CA0 43              	inc	bx
0800:2CA1 83 E3 03        	and	bx,3h
0800:2CA4 74 07           	jz	2CADh

l0800_2CA6:
0800:2CA6 03 36 B7 0B     	add	si,[0BB7h]
0800:2CAA EB 03           	jmp	2CAFh
0800:2CAC                                     90                      .   

l0800_2CAD:
0800:2CAD 2B F0           	sub	si,ax

l0800_2CAF:
0800:2CAF FF 06 AF 0B     	inc	word ptr [0BAFh]
0800:2CB3 83 26 AF 0B 03  	and	word ptr [0BAFh],3h
0800:2CB8 74 07           	jz	2CC1h

l0800_2CBA:
0800:2CBA 03 3E B7 0B     	add	di,[0BB7h]
0800:2CBE EB 03           	jmp	2CC3h
0800:2CC0 90                                              .               

l0800_2CC1:
0800:2CC1 2B F8           	sub	di,ax

l0800_2CC3:
0800:2CC3 FF 0E B3 0B     	dec	word ptr [0BB3h]
0800:2CC7 75 CB           	jnz	2C94h

l0800_2CC9:
0800:2CC9 07              	pop	es
0800:2CCA 1F              	pop	ds
0800:2CCB 5E              	pop	si
0800:2CCC 5F              	pop	di
0800:2CCD 5D              	pop	bp
0800:2CCE CB              	retf

l0800_2CCF:
0800:2CCF 8B 1E AD 0B     	mov	bx,[0BADh]
0800:2CD3 F7 C3 01 00     	test	bx,1h
0800:2CD7 74 04           	jz	2CDDh

l0800_2CD9:
0800:2CD9 81 C6 00 20     	add	si,2000h

l0800_2CDD:
0800:2CDD F7 06 AF 0B 01 00 	test	word ptr [0BAFh],1h
0800:2CE3 74 04           	jz	2CE9h

l0800_2CE5:
0800:2CE5 81 C7 00 20     	add	di,2000h

l0800_2CE9:
0800:2CE9 B8 00 20        	mov	ax,2000h
0800:2CEC 2B 06 B1 0B     	sub	ax,[0BB1h]
0800:2CF0 A3 B7 0B        	mov	[0BB7h],ax
0800:2CF3 A1 B1 0B        	mov	ax,[0BB1h]
0800:2CF6 2D 50 00        	sub	ax,50h
0800:2CF9 05 00 20        	add	ax,2000h
0800:2CFC 8B 16 A7 0B     	mov	dx,[0BA7h]

l0800_2D00:
0800:2D00 8B 0E B1 0B     	mov	cx,[0BB1h]
0800:2D04 D1 E9           	shr	cx,1h
0800:2D06 1E              	push	ds
0800:2D07 8E DA           	mov	ds,dx

l0800_2D09:
0800:2D09 F3 A5           	rep movsw

l0800_2D0B:
0800:2D0B 1F              	pop	ds
0800:2D0C 43              	inc	bx
0800:2D0D 83 E3 01        	and	bx,1h
0800:2D10 74 07           	jz	2D19h

l0800_2D12:
0800:2D12 03 36 B7 0B     	add	si,[0BB7h]
0800:2D16 EB 03           	jmp	2D1Bh
0800:2D18                         90                              .       

l0800_2D19:
0800:2D19 2B F0           	sub	si,ax

l0800_2D1B:
0800:2D1B FF 06 AF 0B     	inc	word ptr [0BAFh]
0800:2D1F 83 26 AF 0B 01  	and	word ptr [0BAFh],1h
0800:2D24 74 07           	jz	2D2Dh

l0800_2D26:
0800:2D26 03 3E B7 0B     	add	di,[0BB7h]
0800:2D2A EB 03           	jmp	2D2Fh
0800:2D2C                                     90                      .   

l0800_2D2D:
0800:2D2D 2B F8           	sub	di,ax

l0800_2D2F:
0800:2D2F FF 0E B3 0B     	dec	word ptr [0BB3h]
0800:2D33 75 CB           	jnz	2D00h

l0800_2D35:
0800:2D35 EB 92           	jmp	2CC9h

;; FillFarMemoryBytes_2D37: 0800:2D37
FillFarMemoryBytes_2D37 proc
0800:2D37 55              	push	bp
0800:2D38 8B EC           	mov	bp,sp
0800:2D3A 57              	push	di
0800:2D3B 56              	push	si
0800:2D3C 1E              	push	ds
0800:2D3D B8 84 41        	mov	ax,4184h
0800:2D40 8E D8           	mov	ds,ax
0800:2D42 06              	push	es
0800:2D43 8B 7E 06        	mov	di,[bp+6h]
0800:2D46 8B 46 08        	mov	ax,[bp+8h]
0800:2D49 8E C0           	mov	es,ax
0800:2D4B 8B 4E 0A        	mov	cx,[bp+0Ah]
0800:2D4E 8A 46 0C        	mov	al,[bp+0Ch]

l0800_2D51:
0800:2D51 F3 AA           	rep stosb

l0800_2D53:
0800:2D53 07              	pop	es
0800:2D54 1F              	pop	ds
0800:2D55 5E              	pop	si
0800:2D56 5F              	pop	di
0800:2D57 5D              	pop	bp
0800:2D58 CB              	retf

;; ClearActiveVideoBuffer_2D59: 0800:2D59
;;   Called from:
;;     0D73:01C6 (in RunCampaignLoop_0006)
;;     0D73:032C (in InitializeTacticalScenario_0214)
;;     0D73:03AF (in RebuildTacticalVideoResources_0387)
;;     0D73:3284 (in LoadScreenPalette_324E)
;;     0D73:3297 (in LoadScreenPalette_324E)
;;     1A1F:4C01 (in HandleTacticalInput_4A9E)
;;     24C5:0387 (in DrawTacticalOverviewMap_037F)
;;     24C5:0408 (in ExitTacticalOverview_0401)
ClearActiveVideoBuffer_2D59 proc
0800:2D59 55              	push	bp
0800:2D5A 8B EC           	mov	bp,sp
0800:2D5C 57              	push	di
0800:2D5D 56              	push	si
0800:2D5E 1E              	push	ds
0800:2D5F B8 84 41        	mov	ax,4184h
0800:2D62 8E D8           	mov	ds,ax
0800:2D64 FA              	cli
0800:2D65 06              	push	es
0800:2D66 A1 9D 0B        	mov	ax,[0B9Dh]
0800:2D69 8E C0           	mov	es,ax
0800:2D6B 8B 3E 9B 0B     	mov	di,[0B9Bh]
0800:2D6F B9 00 20        	mov	cx,2000h
0800:2D72 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:2D77 74 2C           	jz	2DA5h

l0800_2D79:
0800:2D79 D0 E5           	shl	ch,1h
0800:2D7B 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2D80 74 23           	jz	2DA5h

l0800_2D82:
0800:2D82 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2D87 74 05           	jz	2D8Eh

l0800_2D89:
0800:2D89 D0 E5           	shl	ch,1h
0800:2D8B EB 18           	jmp	2DA5h
0800:2D8D                                        90                    .  

l0800_2D8E:
0800:2D8E B9 A0 0F        	mov	cx,0FA0h
0800:2D91 BA CE 03        	mov	dx,3CEh
0800:2D94 B8 05 02        	mov	ax,205h
0800:2D97 EE              	out	dx,al
0800:2D98 42              	inc	dx
0800:2D99 8A C4           	mov	al,ah
0800:2D9B EE              	out	dx,al
0800:2D9C 4A              	dec	dx
0800:2D9D B8 08 FF        	mov	ax,0FF08h
0800:2DA0 EE              	out	dx,al
0800:2DA1 42              	inc	dx
0800:2DA2 8A C4           	mov	al,ah
0800:2DA4 EE              	out	dx,al

l0800_2DA5:
0800:2DA5 8B C7           	mov	ax,di

l0800_2DA7:
0800:2DA7 F3 AB           	rep stosw

l0800_2DA9:
0800:2DA9 07              	pop	es
0800:2DAA FB              	sti
0800:2DAB 1F              	pop	ds
0800:2DAC 5E              	pop	si
0800:2DAD 5F              	pop	di
0800:2DAE 5D              	pop	bp
0800:2DAF CB              	retf

;; FillVideoRectangle_2DB0: 0800:2DB0
;;   Called from:
;;     356D:001A (in ClearActiveTextWindow_0006)
FillVideoRectangle_2DB0 proc
0800:2DB0 55              	push	bp
0800:2DB1 8B EC           	mov	bp,sp
0800:2DB3 57              	push	di
0800:2DB4 56              	push	si
0800:2DB5 1E              	push	ds
0800:2DB6 B8 84 41        	mov	ax,4184h
0800:2DB9 8E D8           	mov	ds,ax
0800:2DBB 06              	push	es
0800:2DBC A1 9D 0B        	mov	ax,[0B9Dh]
0800:2DBF 8E C0           	mov	es,ax
0800:2DC1 8B 5E 06        	mov	bx,[bp+6h]
0800:2DC4 8B 46 08        	mov	ax,[bp+8h]
0800:2DC7 D1 E0           	shl	ax,1h
0800:2DC9 D1 E0           	shl	ax,1h
0800:2DCB D1 E0           	shl	ax,1h
0800:2DCD 8B 4E 0A        	mov	cx,[bp+0Ah]
0800:2DD0 8B 56 0C        	mov	dx,[bp+0Ch]
0800:2DD3 D1 E2           	shl	dx,1h
0800:2DD5 D1 E2           	shl	dx,1h
0800:2DD7 D1 E2           	shl	dx,1h
0800:2DD9 89 16 B9 0B     	mov	[0BB9h],dx
0800:2DDD BA 28 00        	mov	dx,28h
0800:2DE0 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2DE5 74 2A           	jz	2E11h

l0800_2DE7:
0800:2DE7 D1 E2           	shl	dx,1h
0800:2DE9 D1 E3           	shl	bx,1h
0800:2DEB 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:2DF0 75 05           	jnz	2DF7h

l0800_2DF2:
0800:2DF2 D1 E8           	shr	ax,1h
0800:2DF4 EB 1B           	jmp	2E11h
0800:2DF6                   90                                  .         

l0800_2DF7:
0800:2DF7 D1 E2           	shl	dx,1h
0800:2DF9 D1 E1           	shl	cx,1h
0800:2DFB D1 E3           	shl	bx,1h
0800:2DFD 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2E02 75 07           	jnz	2E0Bh

l0800_2E04:
0800:2E04 D1 E8           	shr	ax,1h
0800:2E06 D1 E8           	shr	ax,1h
0800:2E08 EB 07           	jmp	2E11h
0800:2E0A                               90                          .     

l0800_2E0B:
0800:2E0B D1 E2           	shl	dx,1h
0800:2E0D D1 E1           	shl	cx,1h
0800:2E0F D1 E3           	shl	bx,1h

l0800_2E11:
0800:2E11 89 16 BB 0B     	mov	[0BBBh],dx
0800:2E15 F7 E2           	mul	dx
0800:2E17 03 C3           	add	ax,bx
0800:2E19 8B F8           	mov	di,ax
0800:2E1B 03 3E 9B 0B     	add	di,[0B9Bh]
0800:2E1F 89 0E BD 0B     	mov	[0BBDh],cx
0800:2E23 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2E28 74 6A           	jz	2E94h

l0800_2E2A:
0800:2E2A 8B 16 B9 0B     	mov	dx,[0BB9h]
0800:2E2E 8B 46 0E        	mov	ax,[bp+0Eh]
0800:2E31 8A E0           	mov	ah,al
0800:2E33 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2E38 74 1E           	jz	2E58h

l0800_2E3A:
0800:2E3A D0 E0           	shl	al,1h
0800:2E3C D0 E0           	shl	al,1h
0800:2E3E D0 E0           	shl	al,1h
0800:2E40 D0 E0           	shl	al,1h
0800:2E42 0A C4           	or	al,ah
0800:2E44 8A E0           	mov	ah,al
0800:2E46 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2E4B 74 0B           	jz	2E58h

l0800_2E4D:
0800:2E4D 25 33 33        	and	ax,3333h
0800:2E50 D0 E0           	shl	al,1h
0800:2E52 D0 E0           	shl	al,1h
0800:2E54 0A C4           	or	al,ah
0800:2E56 8A E0           	mov	ah,al

l0800_2E58:
0800:2E58 8B F7           	mov	si,di
0800:2E5A 8B 0E BD 0B     	mov	cx,[0BBDh]

l0800_2E5E:
0800:2E5E F3 AB           	rep stosw

l0800_2E60:
0800:2E60 8B FE           	mov	di,si
0800:2E62 03 3E BB 0B     	add	di,[0BBBh]
0800:2E66 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2E6B 74 22           	jz	2E8Fh

l0800_2E6D:
0800:2E6D 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:2E72 75 0D           	jnz	2E81h

l0800_2E74:
0800:2E74 81 C7 60 1F     	add	di,1F60h
0800:2E78 79 15           	jns	2E8Fh

l0800_2E7A:
0800:2E7A 81 EF 60 7F     	sub	di,7F60h
0800:2E7E EB 0F           	jmp	2E8Fh
0800:2E80 90                                              .               

l0800_2E81:
0800:2E81 81 C7 B0 1F     	add	di,1FB0h
0800:2E85 F7 C2 01 00     	test	dx,1h
0800:2E89 74 04           	jz	2E8Fh

l0800_2E8B:
0800:2E8B 81 EF B0 3F     	sub	di,3FB0h

l0800_2E8F:
0800:2E8F 4A              	dec	dx
0800:2E90 75 C6           	jnz	2E58h

l0800_2E92:
0800:2E92 74 2E           	jz	2EC2h

l0800_2E94:
0800:2E94 FA              	cli
0800:2E95 BA CE 03        	mov	dx,3CEh
0800:2E98 B8 05 02        	mov	ax,205h
0800:2E9B EE              	out	dx,al
0800:2E9C 42              	inc	dx
0800:2E9D 8A C4           	mov	al,ah
0800:2E9F EE              	out	dx,al
0800:2EA0 4A              	dec	dx
0800:2EA1 B8 08 FF        	mov	ax,0FF08h
0800:2EA4 EE              	out	dx,al
0800:2EA5 42              	inc	dx
0800:2EA6 8A C4           	mov	al,ah
0800:2EA8 EE              	out	dx,al
0800:2EA9 8B 16 B9 0B     	mov	dx,[0BB9h]
0800:2EAD 8B 46 0E        	mov	ax,[bp+0Eh]

l0800_2EB0:
0800:2EB0 8B F7           	mov	si,di
0800:2EB2 8B 0E BD 0B     	mov	cx,[0BBDh]

l0800_2EB6:
0800:2EB6 F3 AA           	rep stosb

l0800_2EB8:
0800:2EB8 8B FE           	mov	di,si
0800:2EBA 03 3E BB 0B     	add	di,[0BBBh]
0800:2EBE 4A              	dec	dx
0800:2EBF 75 EF           	jnz	2EB0h

l0800_2EC1:
0800:2EC1 FB              	sti

l0800_2EC2:
0800:2EC2 07              	pop	es
0800:2EC3 1F              	pop	ds
0800:2EC4 5E              	pop	si
0800:2EC5 5F              	pop	di
0800:2EC6 5D              	pop	bp
0800:2EC7 CB              	retf

;; CopyFarBytes32_2EC8: 0800:2EC8
;;   Called from:
;;     0D73:5658 (in BuildVgaDisplayBackingBuffer_5508)
;;     2FEA:01A2 (in BuildPlanarDisplayBackingBuffer_000A)
;;     3390:0DC6 (in ReadCachedResource)
CopyFarBytes32_2EC8 proc
0800:2EC8 55              	push	bp
0800:2EC9 8B EC           	mov	bp,sp
0800:2ECB 57              	push	di
0800:2ECC 56              	push	si
0800:2ECD 1E              	push	ds
0800:2ECE B8 84 41        	mov	ax,4184h
0800:2ED1 8E D8           	mov	ds,ax
0800:2ED3 8B 76 06        	mov	si,[bp+6h]
0800:2ED6 8B 56 08        	mov	dx,[bp+8h]
0800:2ED9 8B 7E 0A        	mov	di,[bp+0Ah]
0800:2EDC 8B 46 0C        	mov	ax,[bp+0Ch]
0800:2EDF 06              	push	es
0800:2EE0 8E C0           	mov	es,ax
0800:2EE2 8B 4E 0E        	mov	cx,[bp+0Eh]
0800:2EE5 8B 5E 10        	mov	bx,[bp+10h]
0800:2EE8 8E DA           	mov	ds,dx
0800:2EEA D1 E9           	shr	cx,1h
0800:2EEC 74 02           	jz	2EF0h

l0800_2EEE:
0800:2EEE F3 A5           	rep movsw

l0800_2EF0:
0800:2EF0 73 01           	jnc	2EF3h

l0800_2EF2:
0800:2EF2 A4              	movsb

l0800_2EF3:
0800:2EF3 0B DB           	or	bx,bx
0800:2EF5 74 08           	jz	2EFFh

l0800_2EF7:
0800:2EF7 B9 00 80        	mov	cx,8000h

l0800_2EFA:
0800:2EFA F3 A5           	rep movsw

l0800_2EFC:
0800:2EFC 4B              	dec	bx
0800:2EFD 75 F8           	jnz	2EF7h

l0800_2EFF:
0800:2EFF 07              	pop	es
0800:2F00 1F              	pop	ds
0800:2F01 5E              	pop	si
0800:2F02 5F              	pop	di
0800:2F03 5D              	pop	bp
0800:2F04 CB              	retf

;; Draw8x8VideoTile_2F05: 0800:2F05
;;   Called from:
;;     334D:005B (in DrawActiveTextWindowFrame_0001)
;;     334D:008D (in DrawActiveTextWindowFrame_0001)
;;     334D:00BF (in DrawActiveTextWindowFrame_0001)
;;     334D:00F4 (in DrawActiveTextWindowFrame_0001)
;;     3386:0054 (in DrawRepeatingFrameTileSequence_0008)
Draw8x8VideoTile_2F05 proc
0800:2F05 55              	push	bp
0800:2F06 8B EC           	mov	bp,sp
0800:2F08 57              	push	di
0800:2F09 56              	push	si
0800:2F0A 1E              	push	ds
0800:2F0B B8 84 41        	mov	ax,4184h
0800:2F0E 8E D8           	mov	ds,ax
0800:2F10 06              	push	es
0800:2F11 A1 9D 0B        	mov	ax,[0B9Dh]
0800:2F14 8E C0           	mov	es,ax
0800:2F16 8B 3E 9B 0B     	mov	di,[0B9Bh]
0800:2F1A 8B 76 06        	mov	si,[bp+6h]
0800:2F1D 8B 46 08        	mov	ax,[bp+8h]
0800:2F20 A3 BF 0B        	mov	[0BBFh],ax
0800:2F23 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:2F28 75 03           	jnz	2F2Dh

l0800_2F2A:
0800:2F2A EB 7A           	jmp	2FA6h
0800:2F2C                                     90                      .   

l0800_2F2D:
0800:2F2D 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:2F32 75 03           	jnz	2F37h

l0800_2F34:
0800:2F34 E9 96 00        	jmp	2FCDh

l0800_2F37:
0800:2F37 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:2F3C 75 2D           	jnz	2F6Bh

l0800_2F3E:
0800:2F3E 8B 46 0C        	mov	ax,[bp+0Ch]
0800:2F41 BA 00 0A        	mov	dx,0A00h
0800:2F44 F7 E2           	mul	dx
0800:2F46 8B 56 0A        	mov	dx,[bp+0Ah]
0800:2F49 D1 E2           	shl	dx,1h
0800:2F4B D1 E2           	shl	dx,1h
0800:2F4D D1 E2           	shl	dx,1h
0800:2F4F 03 C2           	add	ax,dx
0800:2F51 03 F8           	add	di,ax
0800:2F53 BA 08 00        	mov	dx,8h
0800:2F56 8E 1E BF 0B     	mov	ds,[0BBFh]
0800:2F5A FC              	cld
0800:2F5B BB 38 01        	mov	bx,138h

l0800_2F5E:
0800:2F5E B9 04 00        	mov	cx,4h

l0800_2F61:
0800:2F61 F3 A5           	rep movsw

l0800_2F63:
0800:2F63 03 FB           	add	di,bx
0800:2F65 4A              	dec	dx
0800:2F66 75 F6           	jnz	2F5Eh

l0800_2F68:
0800:2F68 EB 36           	jmp	2FA0h
0800:2F6A                               90                          .     

l0800_2F6B:
0800:2F6B 8B 46 0C        	mov	ax,[bp+0Ch]
0800:2F6E BA 40 01        	mov	dx,140h
0800:2F71 F7 E2           	mul	dx
0800:2F73 8B 56 0A        	mov	dx,[bp+0Ah]
0800:2F76 D1 E2           	shl	dx,1h
0800:2F78 D1 E2           	shl	dx,1h
0800:2F7A 03 C2           	add	ax,dx
0800:2F7C 03 F8           	add	di,ax
0800:2F7E B9 02 00        	mov	cx,2h
0800:2F81 8E 1E BF 0B     	mov	ds,[0BBFh]
0800:2F85 FC              	cld

l0800_2F86:
0800:2F86 A5              	movsw
0800:2F87 A5              	movsw
0800:2F88 81 C7 FC 1F     	add	di,1FFCh
0800:2F8C A5              	movsw
0800:2F8D A5              	movsw
0800:2F8E 81 C7 FC 1F     	add	di,1FFCh
0800:2F92 A5              	movsw
0800:2F93 A5              	movsw
0800:2F94 81 C7 FC 1F     	add	di,1FFCh
0800:2F98 A5              	movsw
0800:2F99 A5              	movsw
0800:2F9A 81 EF 64 5F     	sub	di,5F64h
0800:2F9E E2 E6           	loop	2F86h

l0800_2FA0:
0800:2FA0 07              	pop	es
0800:2FA1 1F              	pop	ds
0800:2FA2 5E              	pop	si
0800:2FA3 5F              	pop	di
0800:2FA4 5D              	pop	bp
0800:2FA5 CB              	retf

l0800_2FA6:
0800:2FA6 8B 46 0C        	mov	ax,[bp+0Ch]
0800:2FA9 BA 40 01        	mov	dx,140h
0800:2FAC F7 E2           	mul	dx
0800:2FAE 8B 56 0A        	mov	dx,[bp+0Ah]
0800:2FB1 D1 E2           	shl	dx,1h
0800:2FB3 03 C2           	add	ax,dx
0800:2FB5 03 F8           	add	di,ax
0800:2FB7 B9 04 00        	mov	cx,4h
0800:2FBA 8E 1E BF 0B     	mov	ds,[0BBFh]
0800:2FBE FC              	cld

l0800_2FBF:
0800:2FBF A5              	movsw
0800:2FC0 81 C7 FE 1F     	add	di,1FFEh
0800:2FC4 A5              	movsw
0800:2FC5 81 EF B2 1F     	sub	di,1FB2h
0800:2FC9 E2 F4           	loop	2FBFh

l0800_2FCB:
0800:2FCB EB D3           	jmp	2FA0h

l0800_2FCD:
0800:2FCD FA              	cli
0800:2FCE BA CE 03        	mov	dx,3CEh
0800:2FD1 B8 05 00        	mov	ax,5h
0800:2FD4 EE              	out	dx,al
0800:2FD5 42              	inc	dx
0800:2FD6 8A C4           	mov	al,ah
0800:2FD8 EE              	out	dx,al
0800:2FD9 4A              	dec	dx
0800:2FDA B8 08 FF        	mov	ax,0FF08h
0800:2FDD EE              	out	dx,al
0800:2FDE 42              	inc	dx
0800:2FDF 8A C4           	mov	al,ah
0800:2FE1 EE              	out	dx,al
0800:2FE2 4A              	dec	dx
0800:2FE3 B8 01 00        	mov	ax,1h
0800:2FE6 EE              	out	dx,al
0800:2FE7 42              	inc	dx
0800:2FE8 8A C4           	mov	al,ah
0800:2FEA EE              	out	dx,al
0800:2FEB 8B 46 0A        	mov	ax,[bp+0Ah]
0800:2FEE 03 F8           	add	di,ax
0800:2FF0 8B 46 0C        	mov	ax,[bp+0Ch]
0800:2FF3 BA 40 01        	mov	dx,140h
0800:2FF6 F7 E2           	mul	dx
0800:2FF8 03 F8           	add	di,ax
0800:2FFA 8E 1E BF 0B     	mov	ds,[0BBFh]
0800:2FFE B9 08 00        	mov	cx,8h
0800:3001 BA C4 03        	mov	dx,3C4h
0800:3004 B0 02           	mov	al,2h
0800:3006 EE              	out	dx,al
0800:3007 42              	inc	dx

l0800_3008:
0800:3008 B8 01 00        	mov	ax,1h
0800:300B EE              	out	dx,al
0800:300C 26 8A 05        	mov	al,es:[di]
0800:300F A4              	movsb
0800:3010 4F              	dec	di
0800:3011 B8 02 00        	mov	ax,2h
0800:3014 EE              	out	dx,al
0800:3015 26 8A 05        	mov	al,es:[di]
0800:3018 A4              	movsb
0800:3019 4F              	dec	di
0800:301A B8 04 00        	mov	ax,4h
0800:301D EE              	out	dx,al
0800:301E 26 8A 05        	mov	al,es:[di]
0800:3021 A4              	movsb
0800:3022 4F              	dec	di
0800:3023 B8 08 00        	mov	ax,8h
0800:3026 EE              	out	dx,al
0800:3027 26 8A 05        	mov	al,es:[di]
0800:302A A4              	movsb
0800:302B 83 C7 27        	add	di,27h
0800:302E E2 D8           	loop	3008h

l0800_3030:
0800:3030 B8 0F 00        	mov	ax,0Fh
0800:3033 EE              	out	dx,al
0800:3034 FB              	sti
0800:3035 E9 68 FF        	jmp	2FA0h

;; EGA_ConvertPackedScreenToPlanar_3038: 0800:3038
;;   Called from:
;;     0D73:0090 (in RunCampaignLoop_0006)
;;     0D73:0410 (in RebuildTacticalVideoResources_0387)
;;     1A1F:050D (in LoadTacticalIconResource_0468)
EGA_ConvertPackedScreenToPlanar_3038 proc
0800:3038 55              	push	bp
0800:3039 8B EC           	mov	bp,sp
0800:303B 57              	push	di
0800:303C 56              	push	si
0800:303D 1E              	push	ds
0800:303E B8 84 41        	mov	ax,4184h
0800:3041 8E D8           	mov	ds,ax
0800:3043 8B 76 06        	mov	si,[bp+6h]
0800:3046 8B 46 08        	mov	ax,[bp+8h]
0800:3049 06              	push	es
0800:304A 8E C0           	mov	es,ax
0800:304C 8B 46 0A        	mov	ax,[bp+0Ah]
0800:304F B9 40 1F        	mov	cx,1F40h
0800:3052 8E D8           	mov	ds,ax
0800:3054 BF 00 00        	mov	di,0h
0800:3057 FA              	cli
0800:3058 BA CE 03        	mov	dx,3CEh
0800:305B B8 05 02        	mov	ax,205h
0800:305E EE              	out	dx,al
0800:305F 42              	inc	dx
0800:3060 8A C4           	mov	al,ah
0800:3062 EE              	out	dx,al
0800:3063 4A              	dec	dx
0800:3064 B0 08           	mov	al,8h
0800:3066 EE              	out	dx,al
0800:3067 42              	inc	dx

l0800_3068:
0800:3068 B8 80 00        	mov	ax,80h
0800:306B EE              	out	dx,al
0800:306C 8A 05           	mov	al,[di]
0800:306E 26 8A 1C        	mov	bl,es:[si]
0800:3071 8A C3           	mov	al,bl
0800:3073 D0 E8           	shr	al,1h
0800:3075 D0 E8           	shr	al,1h
0800:3077 D0 E8           	shr	al,1h
0800:3079 D0 E8           	shr	al,1h
0800:307B 88 05           	mov	[di],al
0800:307D 8A 05           	mov	al,[di]
0800:307F B8 40 00        	mov	ax,40h
0800:3082 EE              	out	dx,al
0800:3083 88 1D           	mov	[di],bl
0800:3085 46              	inc	si
0800:3086 B8 20 00        	mov	ax,20h
0800:3089 EE              	out	dx,al
0800:308A 8A 05           	mov	al,[di]
0800:308C 26 8A 1C        	mov	bl,es:[si]
0800:308F 8A C3           	mov	al,bl
0800:3091 D0 E8           	shr	al,1h
0800:3093 D0 E8           	shr	al,1h
0800:3095 D0 E8           	shr	al,1h
0800:3097 D0 E8           	shr	al,1h
0800:3099 88 05           	mov	[di],al
0800:309B 8A 05           	mov	al,[di]
0800:309D B8 10 00        	mov	ax,10h
0800:30A0 EE              	out	dx,al
0800:30A1 88 1D           	mov	[di],bl
0800:30A3 46              	inc	si
0800:30A4 B8 08 00        	mov	ax,8h
0800:30A7 EE              	out	dx,al
0800:30A8 8A 05           	mov	al,[di]
0800:30AA 26 8A 1C        	mov	bl,es:[si]
0800:30AD 8A C3           	mov	al,bl
0800:30AF D0 E8           	shr	al,1h
0800:30B1 D0 E8           	shr	al,1h
0800:30B3 D0 E8           	shr	al,1h
0800:30B5 D0 E8           	shr	al,1h
0800:30B7 88 05           	mov	[di],al
0800:30B9 8A 05           	mov	al,[di]
0800:30BB B8 04 00        	mov	ax,4h
0800:30BE EE              	out	dx,al
0800:30BF 88 1D           	mov	[di],bl
0800:30C1 46              	inc	si
0800:30C2 B8 02 00        	mov	ax,2h
0800:30C5 EE              	out	dx,al
0800:30C6 8A 05           	mov	al,[di]
0800:30C8 26 8A 1C        	mov	bl,es:[si]
0800:30CB 8A C3           	mov	al,bl
0800:30CD D0 E8           	shr	al,1h
0800:30CF D0 E8           	shr	al,1h
0800:30D1 D0 E8           	shr	al,1h
0800:30D3 D0 E8           	shr	al,1h
0800:30D5 88 05           	mov	[di],al
0800:30D7 8A 05           	mov	al,[di]
0800:30D9 B8 01 00        	mov	ax,1h
0800:30DC EE              	out	dx,al
0800:30DD 88 1D           	mov	[di],bl
0800:30DF 46              	inc	si
0800:30E0 47              	inc	di
0800:30E1 E2 85           	loop	3068h

l0800_30E3:
0800:30E3 4A              	dec	dx
0800:30E4 B8 08 00        	mov	ax,8h
0800:30E7 EE              	out	dx,al
0800:30E8 42              	inc	dx
0800:30E9 8A C4           	mov	al,ah
0800:30EB EE              	out	dx,al
0800:30EC FB              	sti
0800:30ED 07              	pop	es
0800:30EE 1F              	pop	ds
0800:30EF 5E              	pop	si
0800:30F0 5F              	pop	di
0800:30F1 5D              	pop	bp
0800:30F2 CB              	retf
0800:30F3          00 00 00 00 00 00 00 00 00 00             ..........   

;; DrawEGAEncodedSprite_30FD: 0800:30FD
;;   Called from:
;;     0D73:5777 (in DrawClippedSprite_566E)
;;     3005:00EC (in DrawTacticalClippedSprite_0008)
DrawEGAEncodedSprite_30FD proc
0800:30FD 55              	push	bp
0800:30FE 8B EC           	mov	bp,sp
0800:3100 57              	push	di
0800:3101 56              	push	si
0800:3102 1E              	push	ds
0800:3103 B8 84 41        	mov	ax,4184h
0800:3106 8E D8           	mov	ds,ax
0800:3108 06              	push	es
0800:3109 BA 28 00        	mov	dx,28h
0800:310C A1 CD 0B        	mov	ax,[0BCDh]
0800:310F 2E A3 F9 30     	mov	cs:[30F9h],ax
0800:3113 F6 E2           	mul	dl
0800:3115 2E A3 F7 30     	mov	cs:[30F7h],ax
0800:3119 A1 CB 0B        	mov	ax,[0BCBh]
0800:311C 2E A3 FB 30     	mov	cs:[30FBh],ax
0800:3120 8B 7E 06        	mov	di,[bp+6h]
0800:3123 8B 46 08        	mov	ax,[bp+8h]
0800:3126 8E C0           	mov	es,ax
0800:3128 8B 76 0A        	mov	si,[bp+0Ah]
0800:312B 8B 46 0C        	mov	ax,[bp+0Ch]
0800:312E A3 C1 0B        	mov	[0BC1h],ax
0800:3131 8B 46 0E        	mov	ax,[bp+0Eh]
0800:3134 A3 C5 0B        	mov	[0BC5h],ax
0800:3137 D1 F8           	sar	ax,1h
0800:3139 D1 F8           	sar	ax,1h
0800:313B D1 F8           	sar	ax,1h
0800:313D A3 C3 0B        	mov	[0BC3h],ax
0800:3140 8B 56 10        	mov	dx,[bp+10h]
0800:3143 A1 C7 0B        	mov	ax,[0BC7h]
0800:3146 48              	dec	ax
0800:3147 2E A3 F3 30     	mov	cs:[30F3h],ax
0800:314B A1 C9 0B        	mov	ax,[0BC9h]
0800:314E 48              	dec	ax
0800:314F 2E A3 F5 30     	mov	cs:[30F5h],ax
0800:3153 8C DD           	mov	bp,ds
0800:3155 A1 C1 0B        	mov	ax,[0BC1h]
0800:3158 8E D8           	mov	ds,ax
0800:315A 46              	inc	si
0800:315B AD              	lodsw
0800:315C 8B D8           	mov	bx,ax
0800:315E 81 E3 FF 00     	and	bx,0FFh
0800:3162 43              	inc	bx
0800:3163 46              	inc	si
0800:3164 2E 3B 16 F9 30  	cmp	dx,cs:[30F9h]
0800:3169 7D 0F           	jge	317Ah

l0800_316B:
0800:316B 8B CA           	mov	cx,dx
0800:316D 2E 2B 0E FB 30  	sub	cx,cs:[30FBh]
0800:3172 79 16           	jns	318Ah

l0800_3174:
0800:3174 F7 D9           	neg	cx
0800:3176 3B CB           	cmp	cx,bx
0800:3178 7C 03           	jl	317Dh

l0800_317A:
0800:317A E9 D3 00        	jmp	3250h

l0800_317D:
0800:317D AD              	lodsw
0800:317E F6 C4 40        	test	ah,40h
0800:3181 74 FA           	jz	317Dh

l0800_3183:
0800:3183 E2 F8           	loop	317Dh

l0800_3185:
0800:3185 2E 8B 16 FB 30  	mov	dx,cs:[30FBh]

l0800_318A:
0800:318A 8E DD           	mov	ds,bp
0800:318C B8 28 00        	mov	ax,28h
0800:318F F7 E2           	mul	dx
0800:3191 03 F8           	add	di,ax
0800:3193 03 3E C3 0B     	add	di,[0BC3h]
0800:3197 8B 0E C5 0B     	mov	cx,[0BC5h]
0800:319B 83 E1 07        	and	cx,7h
0800:319E 8B 1E C3 0B     	mov	bx,[0BC3h]
0800:31A2 FA              	cli
0800:31A3 BA CE 03        	mov	dx,3CEh
0800:31A6 B8 05 02        	mov	ax,205h
0800:31A9 EE              	out	dx,al
0800:31AA 42              	inc	dx
0800:31AB 8A C4           	mov	al,ah
0800:31AD EE              	out	dx,al
0800:31AE 4A              	dec	dx
0800:31AF B0 08           	mov	al,8h
0800:31B1 EE              	out	dx,al
0800:31B2 42              	inc	dx
0800:31B3 A1 C1 0B        	mov	ax,[0BC1h]
0800:31B6 83 3E 97 09 01  	cmp	word ptr [0997h],1h
0800:31BB 75 03           	jnz	31C0h

l0800_31BD:
0800:31BD E9 97 00        	jmp	3257h

l0800_31C0:
0800:31C0 1E              	push	ds
0800:31C1 8E D8           	mov	ds,ax
0800:31C3 8B EF           	mov	bp,di

l0800_31C5:
0800:31C5 53              	push	bx

l0800_31C6:
0800:31C6 26 8A 05        	mov	al,es:[di]
0800:31C9 AC              	lodsb
0800:31CA 0A C9           	or	cl,cl
0800:31CC 75 3E           	jnz	320Ch

l0800_31CE:
0800:31CE 2E 3B 1E F5 30  	cmp	bx,cs:[30F5h]
0800:31D3 7F 34           	jg	3209h

l0800_31D5:
0800:31D5 2E 3B 1E F3 30  	cmp	bx,cs:[30F3h]
0800:31DA 7E 2D           	jle	3209h

l0800_31DC:
0800:31DC EE              	out	dx,al
0800:31DD AC              	lodsb
0800:31DE 26 88 05        	mov	es:[di],al

l0800_31E1:
0800:31E1 D0 E0           	shl	al,1h
0800:31E3 73 E1           	jnc	31C6h

l0800_31E5:
0800:31E5 47              	inc	di
0800:31E6 43              	inc	bx
0800:31E7 D0 E0           	shl	al,1h
0800:31E9 73 DB           	jnc	31C6h

l0800_31EB:
0800:31EB D0 E0           	shl	al,1h
0800:31ED 72 5F           	jc	324Eh

l0800_31EF:
0800:31EF 83 C5 28        	add	bp,28h
0800:31F2 2E 3B 2E F7 30  	cmp	bp,cs:[30F7h]
0800:31F7 73 55           	jnc	324Eh

l0800_31F9:
0800:31F9 8B FD           	mov	di,bp
0800:31FB 5B              	pop	bx
0800:31FC 8B C5           	mov	ax,bp
0800:31FE 2B C3           	sub	ax,bx
0800:3200 2E 3B 06 F7 30  	cmp	ax,cs:[30F7h]
0800:3205 73 48           	jnc	324Fh

l0800_3207:
0800:3207 EB BC           	jmp	31C5h

l0800_3209:
0800:3209 AC              	lodsb
0800:320A EB D5           	jmp	31E1h

l0800_320C:
0800:320C 32 E4           	xor	ah,ah
0800:320E 86 E0           	xchg	al,ah
0800:3210 D3 E8           	shr	ax,cl
0800:3212 2E 3B 1E F5 30  	cmp	bx,cs:[30F5h]
0800:3217 7F 30           	jg	3249h

l0800_3219:
0800:3219 2E 3B 1E F3 30  	cmp	bx,cs:[30F3h]
0800:321E 7E 29           	jle	3249h

l0800_3220:
0800:3220 8A E8           	mov	ch,al
0800:3222 26 8A 05        	mov	al,es:[di]
0800:3225 8A C4           	mov	al,ah
0800:3227 EE              	out	dx,al
0800:3228 AC              	lodsb
0800:3229 26 88 05        	mov	es:[di],al

l0800_322C:
0800:322C 2E 3B 1E F5 30  	cmp	bx,cs:[30F5h]
0800:3231 7D AE           	jge	31E1h

l0800_3233:
0800:3233 2E 3B 1E F3 30  	cmp	bx,cs:[30F3h]
0800:3238 7C A7           	jl	31E1h

l0800_323A:
0800:323A 26 8A 65 01     	mov	ah,es:[di+1h]
0800:323E 86 E8           	xchg	al,ch
0800:3240 EE              	out	dx,al
0800:3241 86 E8           	xchg	al,ch
0800:3243 26 88 45 01     	mov	es:[di+1h],al
0800:3247 EB 98           	jmp	31E1h

l0800_3249:
0800:3249 8A E8           	mov	ch,al
0800:324B AC              	lodsb
0800:324C EB DE           	jmp	322Ch

l0800_324E:
0800:324E 5B              	pop	bx

l0800_324F:
0800:324F 1F              	pop	ds

l0800_3250:
0800:3250 FB              	sti
0800:3251 07              	pop	es
0800:3252 1F              	pop	ds
0800:3253 5E              	pop	si
0800:3254 5F              	pop	di
0800:3255 5D              	pop	bp
0800:3256 CB              	retf

l0800_3257:
0800:3257 1E              	push	ds
0800:3258 8E D8           	mov	ds,ax
0800:325A BA CE 03        	mov	dx,3CEh
0800:325D B0 05           	mov	al,5h
0800:325F EE              	out	dx,al
0800:3260 42              	inc	dx
0800:3261 B0 0A           	mov	al,0Ah
0800:3263 EE              	out	dx,al
0800:3264 4A              	dec	dx
0800:3265 B0 02           	mov	al,2h
0800:3267 EE              	out	dx,al
0800:3268 42              	inc	dx
0800:3269 32 C0           	xor	al,al
0800:326B EE              	out	dx,al
0800:326C 4A              	dec	dx
0800:326D B0 08           	mov	al,8h
0800:326F EE              	out	dx,al
0800:3270 42              	inc	dx
0800:3271 8B EF           	mov	bp,di

l0800_3273:
0800:3273 53              	push	bx

l0800_3274:
0800:3274 0A C9           	or	cl,cl
0800:3276 75 39           	jnz	32B1h

l0800_3278:
0800:3278 83 FB 28        	cmp	bx,28h
0800:327B 73 31           	jnc	32AEh

l0800_327D:
0800:327D AC              	lodsb
0800:327E 26 22 05        	and	al,es:[di]
0800:3281 EE              	out	dx,al
0800:3282 AC              	lodsb
0800:3283 26 88 05        	mov	es:[di],al

l0800_3286:
0800:3286 D0 E0           	shl	al,1h
0800:3288 73 EA           	jnc	3274h

l0800_328A:
0800:328A 47              	inc	di
0800:328B 43              	inc	bx
0800:328C D0 E0           	shl	al,1h
0800:328E 73 E4           	jnc	3274h

l0800_3290:
0800:3290 D0 E0           	shl	al,1h
0800:3292 72 BA           	jc	324Eh

l0800_3294:
0800:3294 83 C5 28        	add	bp,28h
0800:3297 2E 3B 2E F7 30  	cmp	bp,cs:[30F7h]
0800:329C 73 B0           	jnc	324Eh

l0800_329E:
0800:329E 8B FD           	mov	di,bp
0800:32A0 5B              	pop	bx
0800:32A1 8B C5           	mov	ax,bp
0800:32A3 2B C3           	sub	ax,bx
0800:32A5 2E 3B 06 F7 30  	cmp	ax,cs:[30F7h]
0800:32AA 73 A3           	jnc	324Fh

l0800_32AC:
0800:32AC EB C5           	jmp	3273h

l0800_32AE:
0800:32AE AC              	lodsb
0800:32AF EB D5           	jmp	3286h

l0800_32B1:
0800:32B1 AC              	lodsb
0800:32B2 32 E4           	xor	ah,ah
0800:32B4 86 E0           	xchg	al,ah
0800:32B6 D3 E8           	shr	ax,cl
0800:32B8 2E 3B 1E F5 30  	cmp	bx,cs:[30F5h]
0800:32BD 7F 29           	jg	32E8h

l0800_32BF:
0800:32BF 8A E8           	mov	ch,al
0800:32C1 26 22 25        	and	ah,es:[di]
0800:32C4 8A C4           	mov	al,ah
0800:32C6 EE              	out	dx,al
0800:32C7 AC              	lodsb
0800:32C8 26 88 05        	mov	es:[di],al

l0800_32CB:
0800:32CB 2E 3B 1E F5 30  	cmp	bx,cs:[30F5h]
0800:32D0 7D B4           	jge	3286h

l0800_32D2:
0800:32D2 2E 3B 1E F3 30  	cmp	bx,cs:[30F3h]
0800:32D7 7C AD           	jl	3286h

l0800_32D9:
0800:32D9 86 E8           	xchg	al,ch
0800:32DB 26 22 45 01     	and	al,es:[di+1h]
0800:32DF EE              	out	dx,al
0800:32E0 86 E8           	xchg	al,ch
0800:32E2 26 88 45 01     	mov	es:[di+1h],al
0800:32E6 EB 9E           	jmp	3286h

l0800_32E8:
0800:32E8 8A E8           	mov	ch,al
0800:32EA AC              	lodsb
0800:32EB EB DE           	jmp	32CBh

;; RepackCgaAlternateScanlines_32ED: 0800:32ED
;;   Called from:
;;     0D73:33B7 (in LoadScreenAssetToWorkBuffer_32F4)
;;     35C2:007F (in CopyDecodedIconPage_000B)
RepackCgaAlternateScanlines_32ED proc
0800:32ED 55              	push	bp
0800:32EE 8B EC           	mov	bp,sp
0800:32F0 57              	push	di
0800:32F1 56              	push	si
0800:32F2 1E              	push	ds
0800:32F3 B8 84 41        	mov	ax,4184h
0800:32F6 8E D8           	mov	ds,ax
0800:32F8 8B 5E 06        	mov	bx,[bp+6h]
0800:32FB 8B F3           	mov	si,bx
0800:32FD 8B FE           	mov	di,si
0800:32FF 8B 46 08        	mov	ax,[bp+8h]
0800:3302 06              	push	es
0800:3303 8E C0           	mov	es,ax
0800:3305 8E D8           	mov	ds,ax
0800:3307 81 C6 40 3E     	add	si,3E40h
0800:330B 81 C7 80 7C     	add	di,7C80h
0800:330F FC              	cld

l0800_3310:
0800:3310 B9 20 00        	mov	cx,20h

l0800_3313:
0800:3313 F3 A5           	rep movsw

l0800_3315:
0800:3315 81 EE 80 00     	sub	si,80h
0800:3319 81 EF C0 00     	sub	di,0C0h
0800:331D 3B FB           	cmp	di,bx
0800:331F 75 EF           	jnz	3310h

l0800_3321:
0800:3321 07              	pop	es
0800:3322 1F              	pop	ds
0800:3323 5E              	pop	si
0800:3324 5F              	pop	di
0800:3325 5D              	pop	bp
0800:3326 CB              	retf

;; FillTandyPackedRectangle_3327: 0800:3327
;;   Called from:
;;     3471:005F (in FillVideoRectangle_000E)
FillTandyPackedRectangle_3327 proc
0800:3327 55              	push	bp
0800:3328 8B EC           	mov	bp,sp
0800:332A 57              	push	di
0800:332B 56              	push	si
0800:332C 1E              	push	ds
0800:332D B8 84 41        	mov	ax,4184h
0800:3330 8E D8           	mov	ds,ax
0800:3332 06              	push	es
0800:3333 8B 7E 06        	mov	di,[bp+6h]
0800:3336 D1 EF           	shr	di,1h
0800:3338 03 3E 9B 0B     	add	di,[0B9Bh]
0800:333C 8B 5E 08        	mov	bx,[bp+8h]
0800:333F 8B C3           	mov	ax,bx
0800:3341 24 FC           	and	al,0FCh
0800:3343 BA 28 00        	mov	dx,28h
0800:3346 F6 E2           	mul	dl
0800:3348 03 F8           	add	di,ax
0800:334A 8B D3           	mov	dx,bx
0800:334C 83 E2 03        	and	dx,3h
0800:334F 74 08           	jz	3359h

l0800_3351:
0800:3351 8B CA           	mov	cx,dx

l0800_3353:
0800:3353 81 C7 00 20     	add	di,2000h
0800:3357 E2 FA           	loop	3353h

l0800_3359:
0800:3359 8B 46 0A        	mov	ax,[bp+0Ah]
0800:335C 40              	inc	ax
0800:335D A3 CF 0B        	mov	[0BCFh],ax
0800:3360 8B 46 0C        	mov	ax,[bp+0Ch]
0800:3363 A3 D1 0B        	mov	[0BD1h],ax
0800:3366 8B 46 0E        	mov	ax,[bp+0Eh]
0800:3369 8A E0           	mov	ah,al
0800:336B B9 04 00        	mov	cx,4h
0800:336E D2 E0           	shl	al,cl
0800:3370 0A C4           	or	al,ah
0800:3372 8A E0           	mov	ah,al
0800:3374 A3 D3 0B        	mov	[0BD3h],ax
0800:3377 8B 1E 9D 0B     	mov	bx,[0B9Dh]
0800:337B 8E C3           	mov	es,bx
0800:337D 8B 1E D1 0B     	mov	bx,[0BD1h]

l0800_3381:
0800:3381 8B 0E CF 0B     	mov	cx,[0BCFh]

l0800_3385:
0800:3385 F3 AA           	rep stosb

l0800_3387:
0800:3387 2B 3E CF 0B     	sub	di,[0BCFh]
0800:338B FE C2           	inc	dl
0800:338D 80 E2 03        	and	dl,3h
0800:3390 74 09           	jz	339Bh

l0800_3392:
0800:3392 81 C7 00 20     	add	di,2000h
0800:3396 4B              	dec	bx
0800:3397 79 E8           	jns	3381h

l0800_3399:
0800:3399 78 07           	js	33A2h

l0800_339B:
0800:339B 81 EF 60 5F     	sub	di,5F60h
0800:339F 4B              	dec	bx
0800:33A0 79 DF           	jns	3381h

l0800_33A2:
0800:33A2 07              	pop	es
0800:33A3 1F              	pop	ds
0800:33A4 5E              	pop	si
0800:33A5 5F              	pop	di
0800:33A6 5D              	pop	bp
0800:33A7 CB              	retf

;; GetLargestFreeConventionalMemoryKB: 0800:33A8
;;   Called from:
;;     3390:0A3E (in InitializeResourceCache)
GetLargestFreeConventionalMemoryKB proc
0800:33A8 55              	push	bp
0800:33A9 8B EC           	mov	bp,sp
0800:33AB 57              	push	di
0800:33AC 56              	push	si
0800:33AD 1E              	push	ds
0800:33AE B8 84 41        	mov	ax,4184h
0800:33B1 8E D8           	mov	ds,ax
0800:33B3 B4 48           	mov	ah,48h
0800:33B5 BB 00 A0        	mov	bx,0A000h
0800:33B8 CD 21           	int	21h
0800:33BA 72 0E           	jc	33CAh

l0800_33BC:
0800:33BC 06              	push	es
0800:33BD 8E C0           	mov	es,ax
0800:33BF B4 49           	mov	ah,49h
0800:33C1 CD 21           	int	21h
0800:33C3 07              	pop	es
0800:33C4 B8 80 02        	mov	ax,280h
0800:33C7 EB 08           	jmp	33D1h
0800:33C9                            90                            .      

l0800_33CA:
0800:33CA 8B C3           	mov	ax,bx
0800:33CC B9 06 00        	mov	cx,6h
0800:33CF D3 E8           	shr	ax,cl

l0800_33D1:
0800:33D1 1F              	pop	ds
0800:33D2 5E              	pop	si
0800:33D3 5F              	pop	di
0800:33D4 5D              	pop	bp
0800:33D5 CB              	retf

;; DecodeLinearRleScreen_33D6: 0800:33D6
;;   Called from:
;;     35C2:0027 (in CopyDecodedIconPage_000B)
DecodeLinearRleScreen_33D6 proc
0800:33D6 55              	push	bp
0800:33D7 8B EC           	mov	bp,sp
0800:33D9 57              	push	di
0800:33DA 56              	push	si
0800:33DB 1E              	push	ds
0800:33DC B8 84 41        	mov	ax,4184h
0800:33DF 8E D8           	mov	ds,ax
0800:33E1 06              	push	es
0800:33E2 8B 76 06        	mov	si,[bp+6h]
0800:33E5 8B 46 08        	mov	ax,[bp+8h]
0800:33E8 8B 7E 0A        	mov	di,[bp+0Ah]
0800:33EB 8B 56 0C        	mov	dx,[bp+0Ch]
0800:33EE 8E C2           	mov	es,dx
0800:33F0 8E D8           	mov	ds,ax
0800:33F2 EB 08           	jmp	33FCh
0800:33F4             90                                      .           

l0800_33F5:
0800:33F5 46              	inc	si
0800:33F6 8B 04           	mov	ax,[si]
0800:33F8 46              	inc	si
0800:33F9 EB 12           	jmp	340Dh
0800:33FB                                  90                        .    

l0800_33FC:
0800:33FC BA 00 7D        	mov	dx,7D00h

l0800_33FF:
0800:33FF 33 DB           	xor	bx,bx
0800:3401 33 C0           	xor	ax,ax
0800:3403 8A 04           	mov	al,[si]
0800:3405 0A C0           	or	al,al
0800:3407 74 EC           	jz	33F5h

l0800_3409:
0800:3409 79 03           	jns	340Eh

l0800_340B:
0800:340B F6 D8           	neg	al

l0800_340D:
0800:340D 4B              	dec	bx

l0800_340E:
0800:340E 8B C8           	mov	cx,ax

l0800_3410:
0800:3410 46              	inc	si
0800:3411 8A 04           	mov	al,[si]

l0800_3413:
0800:3413 AA              	stosb
0800:3414 4A              	dec	dx
0800:3415 74 10           	jz	3427h

l0800_3417:
0800:3417 F7 C3 01 00     	test	bx,1h
0800:341B 75 05           	jnz	3422h

l0800_341D:
0800:341D E2 F1           	loop	3410h

l0800_341F:
0800:341F 46              	inc	si
0800:3420 EB DD           	jmp	33FFh

l0800_3422:
0800:3422 E2 EF           	loop	3413h

l0800_3424:
0800:3424 46              	inc	si
0800:3425 EB D8           	jmp	33FFh

l0800_3427:
0800:3427 07              	pop	es
0800:3428 1F              	pop	ds
0800:3429 5E              	pop	si
0800:342A 5F              	pop	di
0800:342B 5D              	pop	bp
0800:342C CB              	retf

;; DecodeColumnMajorRleScreen_342D: 0800:342D
;;   Called from:
;;     35C2:003D (in CopyDecodedIconPage_000B)
DecodeColumnMajorRleScreen_342D proc
0800:342D 55              	push	bp
0800:342E 8B EC           	mov	bp,sp
0800:3430 57              	push	di
0800:3431 56              	push	si
0800:3432 1E              	push	ds
0800:3433 B8 84 41        	mov	ax,4184h
0800:3436 8E D8           	mov	ds,ax
0800:3438 06              	push	es
0800:3439 8B 76 06        	mov	si,[bp+6h]
0800:343C 8B 46 08        	mov	ax,[bp+8h]
0800:343F 8B 7E 0A        	mov	di,[bp+0Ah]
0800:3442 8B 56 0C        	mov	dx,[bp+0Ch]
0800:3445 8E C2           	mov	es,dx
0800:3447 8E D8           	mov	ds,ax
0800:3449 EB 08           	jmp	3453h
0800:344B                                  90                        .    

l0800_344C:
0800:344C 46              	inc	si
0800:344D 8B 04           	mov	ax,[si]
0800:344F 46              	inc	si
0800:3450 EB 14           	jmp	3466h
0800:3452       90                                          .             

l0800_3453:
0800:3453 BA 00 7D        	mov	dx,7D00h
0800:3456 B3 C8           	mov	bl,0C8h

l0800_3458:
0800:3458 2A FF           	sub	bh,bh
0800:345A 2B C0           	sub	ax,ax
0800:345C 8A 04           	mov	al,[si]
0800:345E 0A C0           	or	al,al
0800:3460 74 EA           	jz	344Ch

l0800_3462:
0800:3462 79 04           	jns	3468h

l0800_3464:
0800:3464 F6 D8           	neg	al

l0800_3466:
0800:3466 FE CF           	dec	bh

l0800_3468:
0800:3468 8B C8           	mov	cx,ax

l0800_346A:
0800:346A 46              	inc	si
0800:346B 8A 04           	mov	al,[si]

l0800_346D:
0800:346D 26 88 05        	mov	es:[di],al
0800:3470 81 C7 A0 00     	add	di,0A0h
0800:3474 FE CB           	dec	bl
0800:3476 74 12           	jz	348Ah

l0800_3478:
0800:3478 4A              	dec	dx
0800:3479 74 17           	jz	3492h

l0800_347B:
0800:347B F6 C7 01        	test	bh,1h
0800:347E 75 05           	jnz	3485h

l0800_3480:
0800:3480 E2 E8           	loop	346Ah

l0800_3482:
0800:3482 46              	inc	si
0800:3483 EB D3           	jmp	3458h

l0800_3485:
0800:3485 E2 E6           	loop	346Dh

l0800_3487:
0800:3487 46              	inc	si
0800:3488 EB CE           	jmp	3458h

l0800_348A:
0800:348A B3 C8           	mov	bl,0C8h
0800:348C 81 EF FF 7C     	sub	di,7CFFh
0800:3490 EB E6           	jmp	3478h

l0800_3492:
0800:3492 07              	pop	es
0800:3493 1F              	pop	ds
0800:3494 5E              	pop	si
0800:3495 5F              	pop	di
0800:3496 5D              	pop	bp
0800:3497 CB              	retf

;; ConvertPackedPixelsToEGAPlanar_3498: 0800:3498
;;   Called from:
;;     0D73:33E7 (in LoadAndPresentScreen_33C1)
ConvertPackedPixelsToEGAPlanar_3498 proc
0800:3498 55              	push	bp
0800:3499 8B EC           	mov	bp,sp
0800:349B 57              	push	di
0800:349C 56              	push	si
0800:349D 1E              	push	ds
0800:349E B8 84 41        	mov	ax,4184h
0800:34A1 8E D8           	mov	ds,ax
0800:34A3 06              	push	es
0800:34A4 8B 76 06        	mov	si,[bp+6h]
0800:34A7 8B 5E 08        	mov	bx,[bp+8h]
0800:34AA 8B 7E 0A        	mov	di,[bp+0Ah]
0800:34AD 8B 46 0C        	mov	ax,[bp+0Ch]
0800:34B0 8E C0           	mov	es,ax
0800:34B2 8B 4E 0E        	mov	cx,[bp+0Eh]
0800:34B5 D1 E9           	shr	cx,1h
0800:34B7 8E DB           	mov	ds,bx

l0800_34B9:
0800:34B9 AC              	lodsb
0800:34BA E8 26 00        	call	34E3h
0800:34BD E8 23 00        	call	34E3h
0800:34C0 AC              	lodsb
0800:34C1 E8 1F 00        	call	34E3h
0800:34C4 E8 1C 00        	call	34E3h
0800:34C7 AC              	lodsb
0800:34C8 E8 18 00        	call	34E3h
0800:34CB E8 15 00        	call	34E3h
0800:34CE AC              	lodsb
0800:34CF E8 11 00        	call	34E3h
0800:34D2 E8 0E 00        	call	34E3h
0800:34D5 8B C3           	mov	ax,bx
0800:34D7 AB              	stosw
0800:34D8 8B C2           	mov	ax,dx
0800:34DA AB              	stosw
0800:34DB E2 DC           	loop	34B9h

l0800_34DD:
0800:34DD 07              	pop	es
0800:34DE 1F              	pop	ds
0800:34DF 5E              	pop	si
0800:34E0 5F              	pop	di
0800:34E1 5D              	pop	bp
0800:34E2 CB              	retf
0800:34E3          D0 E0 D0 D6 D0 E0 D0 D2 D0 E0 D0 D7 D0    .............
0800:34F0 E0 D0 D3 C3                                     ....            

;; EnableHardwareInterrupts: 0800:34F4
;;   Called from:
;;     34B8:0037 (in CalibrateVideoTiming_000A)
;;     34B8:006D (in CalibrateVideoTiming_000A)
;;     34E6:0073 (in PollUiRegionSelection_0003)
;;     34E6:0169 (in PollUiRegionSelection_0003)
;;     34E6:0392 (in PollUiRegionSelection_0003)
EnableHardwareInterrupts proc
0800:34F4 FB              	sti
0800:34F5 CB              	retf

;; DisableHardwareInterrupts: 0800:34F6
;;   Called from:
;;     34B8:0022 (in CalibrateVideoTiming_000A)
;;     34B8:0052 (in CalibrateVideoTiming_000A)
;;     34E6:005C (in PollUiRegionSelection_0003)
;;     34E6:0143 (in PollUiRegionSelection_0003)
DisableHardwareInterrupts proc
0800:34F6 FA              	cli
0800:34F7 CB              	retf

;; InitializeCgaPixelTranslationTables_34F8: 0800:34F8
;;   Called from:
;;     2C7F:028F (in InitializeGame_003C)
InitializeCgaPixelTranslationTables_34F8 proc
0800:34F8 55              	push	bp
0800:34F9 8B EC           	mov	bp,sp
0800:34FB 57              	push	di
0800:34FC 56              	push	si
0800:34FD 1E              	push	ds
0800:34FE B8 84 41        	mov	ax,4184h
0800:3501 8E D8           	mov	ds,ax
0800:3503 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:3508 75 62           	jnz	356Ch

l0800_350A:
0800:350A 8B 76 06        	mov	si,[bp+6h]
0800:350D 8B 46 08        	mov	ax,[bp+8h]
0800:3510 06              	push	es
0800:3511 8E C0           	mov	es,ax
0800:3513 BF D5 0D        	mov	di,0DD5h
0800:3516 B9 20 00        	mov	cx,20h

l0800_3519:
0800:3519 26 8A 04        	mov	al,es:[si]
0800:351C 88 05           	mov	[di],al
0800:351E 46              	inc	si
0800:351F 47              	inc	di
0800:3520 E2 F7           	loop	3519h

l0800_3522:
0800:3522 BE D5 0B        	mov	si,0BD5h
0800:3525 BF D5 0C        	mov	di,0CD5h
0800:3528 32 C9           	xor	cl,cl
0800:352A 33 D2           	xor	dx,dx

l0800_352C:
0800:352C 32 E4           	xor	ah,ah
0800:352E 8A C1           	mov	al,cl
0800:3530 D0 E8           	shr	al,1h
0800:3532 D0 E8           	shr	al,1h
0800:3534 D0 E8           	shr	al,1h
0800:3536 D0 E8           	shr	al,1h
0800:3538 8A D0           	mov	dl,al
0800:353A 8A C1           	mov	al,cl
0800:353C 24 0F           	and	al,0Fh
0800:353E BB D5 0D        	mov	bx,0DD5h
0800:3541 03 DA           	add	bx,dx
0800:3543 8A 2F           	mov	ch,[bx]
0800:3545 2B DA           	sub	bx,dx
0800:3547 D0 E5           	shl	ch,1h
0800:3549 D0 E5           	shl	ch,1h
0800:354B 03 D8           	add	bx,ax
0800:354D 0A 6F 10        	or	ch,[bx+10h]
0800:3550 2B D8           	sub	bx,ax
0800:3552 88 2C           	mov	[si],ch
0800:3554 46              	inc	si
0800:3555 03 DA           	add	bx,dx
0800:3557 8A 6F 10        	mov	ch,[bx+10h]
0800:355A 2B DA           	sub	bx,dx
0800:355C D0 E5           	shl	ch,1h
0800:355E D0 E5           	shl	ch,1h
0800:3560 03 D8           	add	bx,ax
0800:3562 0A 2F           	or	ch,[bx]
0800:3564 88 2D           	mov	[di],ch
0800:3566 47              	inc	di
0800:3567 FE C1           	inc	cl
0800:3569 75 C1           	jnz	352Ch

l0800_356B:
0800:356B 07              	pop	es

l0800_356C:
0800:356C 1F              	pop	ds
0800:356D 5E              	pop	si
0800:356E 5F              	pop	di
0800:356F 5D              	pop	bp
0800:3570 CB              	retf

;; ConvertCgaPackedPixels_3571: 0800:3571
;;   Called from:
;;     0D73:33A0 (in LoadScreenAssetToWorkBuffer_32F4)
;;     35C2:006A (in CopyDecodedIconPage_000B)
ConvertCgaPackedPixels_3571 proc
0800:3571 55              	push	bp
0800:3572 8B EC           	mov	bp,sp
0800:3574 57              	push	di
0800:3575 56              	push	si
0800:3576 1E              	push	ds
0800:3577 B8 84 41        	mov	ax,4184h
0800:357A 8E D8           	mov	ds,ax
0800:357C 06              	push	es
0800:357D 8B 76 06        	mov	si,[bp+6h]
0800:3580 8B 46 08        	mov	ax,[bp+8h]
0800:3583 A3 F5 0D        	mov	[0DF5h],ax
0800:3586 8B 7E 0A        	mov	di,[bp+0Ah]
0800:3589 8B 56 0C        	mov	dx,[bp+0Ch]
0800:358C 8B 5E 0E        	mov	bx,[bp+0Eh]
0800:358F 88 1E F7 0D     	mov	[0DF7h],bl
0800:3593 8B 4E 10        	mov	cx,[bp+10h]
0800:3596 8B EA           	mov	bp,dx
0800:3598 32 F6           	xor	dh,dh

l0800_359A:
0800:359A BB D5 0B        	mov	bx,0BD5h

l0800_359D:
0800:359D 8A 16 F7 0D     	mov	dl,[0DF7h]

l0800_35A1:
0800:35A1 A1 F5 0D        	mov	ax,[0DF5h]
0800:35A4 8E C0           	mov	es,ax
0800:35A6 26 8A 04        	mov	al,es:[si]
0800:35A9 46              	inc	si
0800:35AA D7              	xlat
0800:35AB D0 E0           	shl	al,1h
0800:35AD D0 E0           	shl	al,1h
0800:35AF D0 E0           	shl	al,1h
0800:35B1 D0 E0           	shl	al,1h
0800:35B3 8A E0           	mov	ah,al
0800:35B5 26 8A 04        	mov	al,es:[si]
0800:35B8 D7              	xlat
0800:35B9 46              	inc	si
0800:35BA 0A C4           	or	al,ah
0800:35BC 8E C5           	mov	es,bp
0800:35BE AA              	stosb
0800:35BF FE CA           	dec	dl
0800:35C1 74 05           	jz	35C8h

l0800_35C3:
0800:35C3 E2 DC           	loop	35A1h

l0800_35C5:
0800:35C5 EB 0B           	jmp	35D2h
0800:35C7                      90                                .        

l0800_35C8:
0800:35C8 80 F6 01        	xor	dh,1h
0800:35CB 74 CD           	jz	359Ah

l0800_35CD:
0800:35CD BB D5 0C        	mov	bx,0CD5h
0800:35D0 EB CB           	jmp	359Dh

l0800_35D2:
0800:35D2 07              	pop	es
0800:35D3 1F              	pop	ds
0800:35D4 5E              	pop	si
0800:35D5 5F              	pop	di
0800:35D6 5D              	pop	bp
0800:35D7 CB              	retf

;; ConvertCgaPackedPixelsAndBuildMask_35D8: 0800:35D8
;;   Called from:
;;     0D73:411D (in LoadGraphicsResourceToBuffers_4099)
;;     34DF:0068 (in LoadPackedIconPageDirect_0003)
ConvertCgaPackedPixelsAndBuildMask_35D8 proc
0800:35D8 55              	push	bp
0800:35D9 8B EC           	mov	bp,sp
0800:35DB 57              	push	di
0800:35DC 56              	push	si
0800:35DD 1E              	push	ds
0800:35DE B8 84 41        	mov	ax,4184h
0800:35E1 8E D8           	mov	ds,ax
0800:35E3 8B 76 06        	mov	si,[bp+6h]
0800:35E6 8B 46 08        	mov	ax,[bp+8h]
0800:35E9 06              	push	es
0800:35EA 8E C0           	mov	es,ax
0800:35EC B9 80 3E        	mov	cx,3E80h
0800:35EF 33 D2           	xor	dx,dx
0800:35F1 8B 46 0A        	mov	ax,[bp+0Ah]
0800:35F4 C6 06 F7 0D 50  	mov	byte ptr [0DF7h],50h
0800:35F9 0B C0           	or	ax,ax
0800:35FB 74 05           	jz	3602h

l0800_35FD:
0800:35FD C6 06 F7 0D 04  	mov	byte ptr [0DF7h],4h

l0800_3602:
0800:3602 BB D5 0B        	mov	bx,0BD5h

l0800_3605:
0800:3605 8A 16 F7 0D     	mov	dl,[0DF7h]

l0800_3609:
0800:3609 26 8A 04        	mov	al,es:[si]
0800:360C D7              	xlat
0800:360D D0 E0           	shl	al,1h
0800:360F D0 E0           	shl	al,1h
0800:3611 D0 E0           	shl	al,1h
0800:3613 D0 E0           	shl	al,1h
0800:3615 8A E0           	mov	ah,al
0800:3617 26 8A 44 01     	mov	al,es:[si+1h]
0800:361B D7              	xlat
0800:361C 0A C4           	or	al,ah
0800:361E 26 86 04        	xchg	es:[si],al
0800:3621 46              	inc	si
0800:3622 32 E4           	xor	ah,ah
0800:3624 A8 F0           	test	al,0F0h
0800:3626 74 03           	jz	362Bh

l0800_3628:
0800:3628 80 CC C0        	or	ah,0C0h

l0800_362B:
0800:362B A8 0F           	test	al,0Fh
0800:362D 74 03           	jz	3632h

l0800_362F:
0800:362F 80 CC 30        	or	ah,30h

l0800_3632:
0800:3632 26 8A 04        	mov	al,es:[si]
0800:3635 A8 F0           	test	al,0F0h
0800:3637 74 03           	jz	363Ch

l0800_3639:
0800:3639 80 CC 0C        	or	ah,0Ch

l0800_363C:
0800:363C A8 0F           	test	al,0Fh
0800:363E 74 03           	jz	3643h

l0800_3640:
0800:3640 80 CC 03        	or	ah,3h

l0800_3643:
0800:3643 F6 D4           	not	ah
0800:3645 26 88 24        	mov	es:[si],ah
0800:3648 46              	inc	si
0800:3649 FE CA           	dec	dl
0800:364B 74 05           	jz	3652h

l0800_364D:
0800:364D E2 BA           	loop	3609h

l0800_364F:
0800:364F EB 0E           	jmp	365Fh
0800:3651    90                                            .              

l0800_3652:
0800:3652 49              	dec	cx
0800:3653 74 0A           	jz	365Fh

l0800_3655:
0800:3655 80 F6 01        	xor	dh,1h
0800:3658 74 A8           	jz	3602h

l0800_365A:
0800:365A BB D5 0C        	mov	bx,0CD5h
0800:365D EB A6           	jmp	3605h

l0800_365F:
0800:365F 07              	pop	es
0800:3660 1F              	pop	ds
0800:3661 5E              	pop	si
0800:3662 5F              	pop	di
0800:3663 5D              	pop	bp
0800:3664 CB              	retf

;; ConfigureMouseCursorOverlay_3665: 0800:3665
;;   Called from:
;;     0D73:003D (in RunCampaignLoop_0006)
;;     0D73:03ED (in RebuildTacticalVideoResources_0387)
ConfigureMouseCursorOverlay_3665 proc
0800:3665 55              	push	bp
0800:3666 8B EC           	mov	bp,sp
0800:3668 57              	push	di
0800:3669 56              	push	si
0800:366A 1E              	push	ds
0800:366B B8 84 41        	mov	ax,4184h
0800:366E 8E D8           	mov	ds,ax

l0800_3670:
0800:3670 83 3E FE 0D 00  	cmp	word ptr [0DFEh],0h
0800:3675 75 F9           	jnz	3670h

l0800_3677:
0800:3677 FF 06 FE 0D     	inc	word ptr [0DFEh]
0800:367B 9A 7D 38 00 08  	call	far 0800h:387Dh
0800:3680 8B 46 06        	mov	ax,[bp+6h]
0800:3683 A3 1C 0E        	mov	[0E1Ch],ax
0800:3686 8B 46 08        	mov	ax,[bp+8h]
0800:3689 A3 1E 0E        	mov	[0E1Eh],ax
0800:368C 8B 46 0A        	mov	ax,[bp+0Ah]
0800:368F A3 28 0E        	mov	[0E28h],ax
0800:3692 8B 46 0C        	mov	ax,[bp+0Ch]
0800:3695 A3 2A 0E        	mov	[0E2Ah],ax
0800:3698 9A 53 3A 00 08  	call	far 0800h:3A53h
0800:369D FF 0E FE 0D     	dec	word ptr [0DFEh]
0800:36A1 1F              	pop	ds
0800:36A2 5E              	pop	si
0800:36A3 5F              	pop	di
0800:36A4 5D              	pop	bp
0800:36A5 CB              	retf

;; InitializeMouseSupport_36A6: 0800:36A6
;;   Called from:
;;     2C7F:02A1 (in InitializeGame_003C)
InitializeMouseSupport_36A6 proc
0800:36A6 55              	push	bp
0800:36A7 8B EC           	mov	bp,sp
0800:36A9 57              	push	di
0800:36AA 56              	push	si
0800:36AB 1E              	push	ds
0800:36AC B8 84 41        	mov	ax,4184h
0800:36AF 8E D8           	mov	ds,ax
0800:36B1 58              	pop	ax
0800:36B2 50              	push	ax
0800:36B3 A3 FC 0D        	mov	[0DFCh],ax
0800:36B6 8E D8           	mov	ds,ax
0800:36B8 06              	push	es
0800:36B9 33 D2           	xor	dx,dx
0800:36BB B8 40 02        	mov	ax,240h
0800:36BE 52              	push	dx
0800:36BF 50              	push	ax
0800:36C0 9A B5 00 56 0D  	call	far 0D56h:00B5h
0800:36C5 83 C4 04        	add	sp,4h
0800:36C8 BE 84 41        	mov	si,4184h
0800:36CB 8E DE           	mov	ds,si
0800:36CD 83 FA 00        	cmp	dx,0h
0800:36D0 75 0C           	jnz	36DEh

l0800_36D2:
0800:36D2 B8 FF FF        	mov	ax,0FFFFh
0800:36D5 C7 06 10 0E 00 00 	mov	word ptr [0E10h],0h
0800:36DB E9 8E 00        	jmp	376Ch

l0800_36DE:
0800:36DE A3 24 0E        	mov	[0E24h],ax
0800:36E1 89 16 26 0E     	mov	[0E26h],dx
0800:36E5 B8 33 35        	mov	ax,3533h
0800:36E8 CD 21           	int	21h
0800:36EA C7 06 08 0E A0 00 	mov	word ptr [0E08h],0A0h
0800:36F0 C7 06 0A 0E 64 00 	mov	word ptr [0E0Ah],64h
0800:36F6 FF 06 0E 0E     	inc	word ptr [0E0Eh]
0800:36FA C7 06 16 0E 3F 01 	mov	word ptr [0E16h],13Fh
0800:3700 C7 06 1A 0E C7 00 	mov	word ptr [0E1Ah],0C7h
0800:3706 8C C0           	mov	ax,es
0800:3708 0B C3           	or	ax,bx
0800:370A 74 08           	jz	3714h

l0800_370C:
0800:370C 26 8A 1F        	mov	bl,es:[bx]
0800:370F 80 FB CF        	cmp	bl,0CFh
0800:3712 75 0C           	jnz	3720h

l0800_3714:
0800:3714 B8 00 00        	mov	ax,0h
0800:3717 C7 06 10 0E 00 00 	mov	word ptr [0E10h],0h
0800:371D EB 4D           	jmp	376Ch
0800:371F                                              90                .

l0800_3720:
0800:3720 B8 00 00        	mov	ax,0h
0800:3723 CD 33           	int	33h
0800:3725 3D FF FF        	cmp	ax,0FFFFh
0800:3728 75 EA           	jnz	3714h

l0800_372A:
0800:372A C7 06 0C 0E 00 00 	mov	word ptr [0E0Ch],0h
0800:3730 B8 03 00        	mov	ax,3h
0800:3733 CD 33           	int	33h
0800:3735 81 F9 A0 00     	cmp	cx,0A0h
0800:3739 74 06           	jz	3741h

l0800_373B:
0800:373B C7 06 0C 0E 01 00 	mov	word ptr [0E0Ch],1h

l0800_3741:
0800:3741 B9 A0 00        	mov	cx,0A0h
0800:3744 BA 64 00        	mov	dx,64h
0800:3747 C7 06 10 0E 01 00 	mov	word ptr [0E10h],1h
0800:374D 83 3E 0C 0E 01  	cmp	word ptr [0E0Ch],1h
0800:3752 75 02           	jnz	3756h

l0800_3754:
0800:3754 D1 E1           	shl	cx,1h

l0800_3756:
0800:3756 B8 04 00        	mov	ax,4h
0800:3759 CD 33           	int	33h
0800:375B B8 0C 00        	mov	ax,0Ch
0800:375E B9 1F 00        	mov	cx,1Fh
0800:3761 0E              	push	cs
0800:3762 07              	pop	es
0800:3763 8D 16 72 37     	lea	dx,[3772h]
0800:3767 CD 33           	int	33h
0800:3769 B8 01 00        	mov	ax,1h

l0800_376C:
0800:376C 07              	pop	es
0800:376D 1F              	pop	ds
0800:376E 5E              	pop	si
0800:376F 5F              	pop	di
0800:3770 5D              	pop	bp
0800:3771 CB              	retf
0800:3772       1E 50 9C B8 84 41 8E D8 83 3E 12 0E 00 75   .P...A...>...u
0800:3780 79 A1 02 0E 0B C0 74 0B F7 C3 04 00 74 05 83 E3 y.....t.....t...
0800:3790 03 0B D8 39 1E 00 0E 74 0C A1 00 0E 33 C3 0B 06 ...9...t....3...
0800:37A0 04 0E A3 04 0E 89 1E 00 0E 83 FB 00 74 06 C7 06 ............t...
0800:37B0 06 0E 01 00 83 3E FE 0D 00 75 3F C7 06 FE 0D 01 .....>...u?.....
0800:37C0 00 83 3E 0C 0E 01 75 02 D1 E9 89 0E 08 0E 89 16 ..>...u.........
0800:37D0 0A 0E A1 08 0E 39 06 20 0E 75 09 A1 0A 0E 39 06 .....9. .u....9.
0800:37E0 22 0E 74 10 53 51 52 9A 7D 38 00 08 9A 53 3A 00 ".t.SQR.}8...S:.
0800:37F0 08 5A 59 5B C7 06 FE 0D 00 00 9D 58 1F CB       .ZY[.......X..  

;; ShutdownMouseSupport_37FE: 0800:37FE
;;   Called from:
;;     2C7F:0316 (in ShutdownGame_02E3)
ShutdownMouseSupport_37FE proc
0800:37FE 55              	push	bp
0800:37FF 8B EC           	mov	bp,sp
0800:3801 57              	push	di
0800:3802 56              	push	si
0800:3803 1E              	push	ds
0800:3804 B8 84 41        	mov	ax,4184h
0800:3807 8E D8           	mov	ds,ax
0800:3809 83 3E 10 0E 00  	cmp	word ptr [0E10h],0h
0800:380E 74 10           	jz	3820h

l0800_3810:
0800:3810 06              	push	es
0800:3811 B8 0C 00        	mov	ax,0Ch
0800:3814 B9 00 00        	mov	cx,0h
0800:3817 0E              	push	cs
0800:3818 07              	pop	es
0800:3819 8D 16 72 37     	lea	dx,[3772h]
0800:381D CD 33           	int	33h
0800:381F 07              	pop	es

l0800_3820:
0800:3820 1F              	pop	ds
0800:3821 5E              	pop	si
0800:3822 5F              	pop	di
0800:3823 5D              	pop	bp
0800:3824 CB              	retf

;; IsMouseCursorInsideRectangle_3825: 0800:3825
;;   Called from:
;;     34E6:015A (in PollUiRegionSelection_0003)
IsMouseCursorInsideRectangle_3825 proc
0800:3825 55              	push	bp
0800:3826 8B EC           	mov	bp,sp
0800:3828 57              	push	di
0800:3829 56              	push	si
0800:382A 1E              	push	ds
0800:382B B8 84 41        	mov	ax,4184h
0800:382E 8E D8           	mov	ds,ax
0800:3830 8B 4E 06        	mov	cx,[bp+6h]
0800:3833 8B 76 0A        	mov	si,[bp+0Ah]
0800:3836 8B 56 08        	mov	dx,[bp+8h]
0800:3839 8B 7E 0C        	mov	di,[bp+0Ch]

l0800_383C:
0800:383C 83 3E FE 0D 00  	cmp	word ptr [0DFEh],0h
0800:3841 75 F9           	jnz	383Ch

l0800_3843:
0800:3843 FF 06 FE 0D     	inc	word ptr [0DFEh]
0800:3847 A1 20 0E        	mov	ax,[0E20h]
0800:384A A3 F8 0D        	mov	[0DF8h],ax
0800:384D A1 22 0E        	mov	ax,[0E22h]
0800:3850 A3 FA 0D        	mov	[0DFAh],ax
0800:3853 39 0E F8 0D     	cmp	[0DF8h],cx
0800:3857 7C 18           	jl	3871h

l0800_3859:
0800:3859 39 36 F8 0D     	cmp	[0DF8h],si
0800:385D 7F 12           	jg	3871h

l0800_385F:
0800:385F 39 16 FA 0D     	cmp	[0DFAh],dx
0800:3863 7C 0C           	jl	3871h

l0800_3865:
0800:3865 39 3E FA 0D     	cmp	[0DFAh],di
0800:3869 7F 06           	jg	3871h

l0800_386B:
0800:386B B8 01 00        	mov	ax,1h
0800:386E EB 04           	jmp	3874h
0800:3870 90                                              .               

l0800_3871:
0800:3871 B8 00 00        	mov	ax,0h

l0800_3874:
0800:3874 FF 0E FE 0D     	dec	word ptr [0DFEh]
0800:3878 1F              	pop	ds
0800:3879 5E              	pop	si
0800:387A 5F              	pop	di
0800:387B 5D              	pop	bp
0800:387C CB              	retf

;; HideMouseCursorOverlayUnlocked_387D: 0800:387D
;;   Called from:
;;     0800:367B (in ConfigureMouseCursorOverlay_3665)
;;     0800:397E (in HideMouseCursorOverlay_3968)
;;     0800:39F0 (in SetMouseCursorPositionUnlocked_398C)
HideMouseCursorOverlayUnlocked_387D proc
0800:387D 55              	push	bp
0800:387E 8B EC           	mov	bp,sp
0800:3880 57              	push	di
0800:3881 56              	push	si
0800:3882 1E              	push	ds
0800:3883 B8 84 41        	mov	ax,4184h
0800:3886 8E D8           	mov	ds,ax
0800:3888 83 3E 12 0E 00  	cmp	word ptr [0E12h],0h
0800:388D 74 03           	jz	3892h

l0800_388F:
0800:388F E9 D1 00        	jmp	3963h

l0800_3892:
0800:3892 83 3E 0E 0E 00  	cmp	word ptr [0E0Eh],0h
0800:3897 75 46           	jnz	38DFh

l0800_3899:
0800:3899 A1 20 0E        	mov	ax,[0E20h]
0800:389C A3 2C 0E        	mov	[0E2Ch],ax
0800:389F 2B 06 1C 0E     	sub	ax,[0E1Ch]
0800:38A3 A3 30 0E        	mov	[0E30h],ax
0800:38A6 A1 22 0E        	mov	ax,[0E22h]
0800:38A9 A3 2E 0E        	mov	[0E2Eh],ax
0800:38AC 2B 06 1E 0E     	sub	ax,[0E1Eh]
0800:38B0 A3 32 0E        	mov	[0E32h],ax
0800:38B3 A1 30 0E        	mov	ax,[0E30h]
0800:38B6 D1 F8           	sar	ax,1h
0800:38B8 D1 F8           	sar	ax,1h
0800:38BA D1 F8           	sar	ax,1h
0800:38BC 3D FD FF        	cmp	ax,0FFFDh
0800:38BF 7E 1E           	jle	38DFh

l0800_38C1:
0800:38C1 3D 28 00        	cmp	ax,28h
0800:38C4 7D 19           	jge	38DFh

l0800_38C6:
0800:38C6 A3 30 0E        	mov	[0E30h],ax
0800:38C9 05 03 00        	add	ax,3h
0800:38CC A3 34 0E        	mov	[0E34h],ax
0800:38CF 83 3E 30 0E 00  	cmp	word ptr [0E30h],0h
0800:38D4 7D 0C           	jge	38E2h

l0800_38D6:
0800:38D6 C7 06 30 0E 00 00 	mov	word ptr [0E30h],0h
0800:38DC EB 11           	jmp	38EFh
0800:38DE                                           90                  . 

l0800_38DF:
0800:38DF EB 78           	jmp	3959h
0800:38E1    90                                            .              

l0800_38E2:
0800:38E2 83 3E 34 0E 28  	cmp	word ptr [0E34h],28h
0800:38E7 7E 06           	jle	38EFh

l0800_38E9:
0800:38E9 C7 06 34 0E 28 00 	mov	word ptr [0E34h],28h

l0800_38EF:
0800:38EF A1 32 0E        	mov	ax,[0E32h]
0800:38F2 D1 F8           	sar	ax,1h
0800:38F4 D1 F8           	sar	ax,1h
0800:38F6 D1 F8           	sar	ax,1h
0800:38F8 3D FD FF        	cmp	ax,0FFFDh
0800:38FB 7E 5C           	jle	3959h

l0800_38FD:
0800:38FD 3D 19 00        	cmp	ax,19h
0800:3900 7D 57           	jge	3959h

l0800_3902:
0800:3902 A3 32 0E        	mov	[0E32h],ax
0800:3905 05 03 00        	add	ax,3h
0800:3908 A3 36 0E        	mov	[0E36h],ax
0800:390B 83 3E 32 0E 00  	cmp	word ptr [0E32h],0h
0800:3910 7D 09           	jge	391Bh

l0800_3912:
0800:3912 C7 06 32 0E 00 00 	mov	word ptr [0E32h],0h
0800:3918 EB 0E           	jmp	3928h
0800:391A                               90                          .     

l0800_391B:
0800:391B 83 3E 36 0E 19  	cmp	word ptr [0E36h],19h
0800:3920 7E 06           	jle	3928h

l0800_3922:
0800:3922 C7 06 36 0E 19 00 	mov	word ptr [0E36h],19h

l0800_3928:
0800:3928 FF 36 26 0E     	push	word ptr [0E26h]
0800:392C FF 36 24 0E     	push	word ptr [0E24h]
0800:3930 A1 36 0E        	mov	ax,[0E36h]
0800:3933 2B 06 32 0E     	sub	ax,[0E32h]
0800:3937 50              	push	ax
0800:3938 A1 34 0E        	mov	ax,[0E34h]
0800:393B 2B 06 30 0E     	sub	ax,[0E30h]
0800:393F 50              	push	ax
0800:3940 FF 36 32 0E     	push	word ptr [0E32h]
0800:3944 FF 36 30 0E     	push	word ptr [0E30h]
0800:3948 8E 1E FC 0D     	mov	ds,[0DFCh]
0800:394C 9A 83 26 00 08  	call	far 0800h:2683h
0800:3951 83 C4 0C        	add	sp,0Ch
0800:3954 B8 84 41        	mov	ax,4184h
0800:3957 8E D8           	mov	ds,ax

l0800_3959:
0800:3959 FF 06 0E 0E     	inc	word ptr [0E0Eh]
0800:395D 75 04           	jnz	3963h

l0800_395F:
0800:395F FF 0E 0E 0E     	dec	word ptr [0E0Eh]

l0800_3963:
0800:3963 1F              	pop	ds
0800:3964 5E              	pop	si
0800:3965 5F              	pop	di
0800:3966 5D              	pop	bp
0800:3967 CB              	retf

;; HideMouseCursorOverlay_3968: 0800:3968
;;   Called from:
;;     0D73:01C1 (in RunCampaignLoop_0006)
;;     0D73:0291 (in InitializeTacticalScenario_0214)
;;     0D73:0309 (in InitializeTacticalScenario_0214)
;;     0D73:245B (in ShowConfirmationDialog_2448)
;;     0D73:25FD (in RunMainMenuSelection_25F5)
;;     0D73:2799 (in RunInGameMenu_274D)
;;     0D73:2A9F (in OpenModalTextWindow_2A5D)
;;     0D73:2AEE (in RestoreModalTextWindow_2AEE)
;;     0D73:2ECA (in ShowScenarioMessage_2E7C)
;;     0D73:2F90 (in AnimateTitleTextLine_2F5F)
;;     0D73:2FC8 (in AnimateTitleTextLine_2F5F)
;;     0D73:3022 (in AnimateTitleTextLine_2F5F)
;;     0D73:305D (in AnimateTitleTextLine_2F5F)
;;     0D73:3147 (in RunTitleAndMainMenu_309C)
;;     0D73:31EC (in RunTitleAndMainMenu_309C)
;;     0D73:33EE (in LoadAndPresentScreen_33C1)
;;     0D73:3617 (in PrepareMissionDateScreen_35AA)
;;     0D73:365C (in DrawMissionHeaderFrame_365C)
;;     0D73:3792 (in DisplayMissionDate_376C)
;;     0D73:38A8 (in DisplayMissionDate_376C)
;;     0D73:38F8 (in DisplayMissionDate_376C)
;;     0D73:3935 (in DisplayMissionDate_376C)
;;     0D73:39F4 (in DisplayMissionDate_376C)
;;     0D73:3A85 (in DisplayMissionDate_376C)
;;     0D73:3B32 (in ShowMissionFollowupMessage_3AE4)
;;     0D73:3DFA (in UpdateTextEntryCursorBlink_3DA9)
;;     0D73:4322 (in EditTextField_4317)
;;     0D73:4681 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:47C8 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:47F9 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:4897 (in SaveGame_4866)
;;     0D73:4A2C (in SaveGame_4866)
;;     0D73:4ECF (in ShowSaveLoadMenu_4EC7)
;;     0D73:501D (in ShowSaveLoadMenu_4EC7)
;;     0D73:50C4 (in ShowSaveLoadMenu_4EC7)
;;     0D73:5289 (in RenameSaveSlot_5233)
;;     0D73:5339 (in RenameSaveSlot_5233)
;;     0D73:53E3 (in WaitForAcknowledgement_53E1)
;;     0D73:5472 (in PromptYesNo_546F)
;;     0D73:5789 (in ShowScenarioCompletionStatus_5789)
;;     1A1F:1202 (in FocusTacticalViewOnUnit_11F7)
;;     1A1F:41C5 (in RunGameOptionsMenu_417F)
;;     1A1F:41F3 (in RunGameOptionsMenu_417F)
;;     1A1F:4238 (in RunGameOptionsMenu_417F)
;;     1A1F:42C3 (in RunGameOptionsMenu_417F)
;;     1A1F:447E (in RenderPendingNarration_4447)
;;     1A1F:4628 (in RenderPendingNarration_4447)
;;     1A1F:4FB8 (in ShowPendingNarrationPrompt_4FA6)
;;     1A1F:50DD (in ShowPendingNarrationPrompt_4FA6)
;;     2007:07D4 (in DrawTacticalCellOutline_07C9)
;;     2007:09DA (in DrawClippedWeaponTraceLine_0926)
;;     2007:0DE5 (in DrawTacticalEffectSprite_0DDB)
;;     2007:0EBF (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:0F25 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:0F7A (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:1145 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:11E8 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:1360 (in DrawBeveledMenuButton_132C)
;;     2007:15A8 (in RedrawTacticalViewport_159F)
;;     2007:1640 (in DrawCampaignClock_15FF)
;;     2007:1692 (in DrawCampaignClock_15FF)
;;     2007:16BF (in RedrawTacticalStatusPanel_16BA)
;;     2007:16F0 (in AdvanceImpactSpriteAnimations_16E8)
;;     2007:17E6 (in AdvanceTacticalProjectiles_17DE)
;;     2007:1D3D (in RefreshTacticalDisplay_1D06)
;;     2007:1DE7 (in DrawCampaignClockSeparator_1DCC)
;;     2208:00C8 (in RunTacticalUnitCommandMenu_000B)
;;     2208:031C (in RunTacticalUnitCommandMenu_000B)
;;     2208:14C4 (in RunTacticalGameOptionsMenu_148A)
;;     2507:0541 (in SelectUnitClass_0501)
;;     2507:0694 (in SelectUnitTypeFromList_0625)
;;     2507:0A7F (in DrawUnitAllegianceHeader_0A20)
;;     2507:4842 (in DrawUnitStatusScreen_483A)
;;     2507:4A2C (in DrawUnitStatusScreen_483A)
;;     2B34:0504 (in DrawTacticalUnitControlPanel_04C2)
;;     34E6:020E (in PollUiRegionSelection_0003)
;;     34E6:030B (in PollUiRegionSelection_0003)
;;     34E6:0488 (in PollUiRegionSelection_0003)
;;     34E6:06EC (in PollUiRegionSelection_0003)
;;     3568:0014 (in RunUiRegionSelectionLoop_0007)
;;     3568:0049 (in RunUiRegionSelectionLoop_0007)
;;     358E:0019 (in RunSingleUiRegionSelection_000C)
;;     358E:004B (in RunSingleUiRegionSelection_000C)
;;     35CA:0014 (in ToggleActiveUiRegionHighlight_0009)
HideMouseCursorOverlay_3968 proc
0800:3968 55              	push	bp
0800:3969 8B EC           	mov	bp,sp
0800:396B 57              	push	di
0800:396C 56              	push	si
0800:396D 1E              	push	ds
0800:396E B8 84 41        	mov	ax,4184h
0800:3971 8E D8           	mov	ds,ax

l0800_3973:
0800:3973 83 3E FE 0D 00  	cmp	word ptr [0DFEh],0h
0800:3978 75 F9           	jnz	3973h

l0800_397A:
0800:397A FF 06 FE 0D     	inc	word ptr [0DFEh]
0800:397E 9A 7D 38 00 08  	call	far 0800h:387Dh
0800:3983 FF 0E FE 0D     	dec	word ptr [0DFEh]
0800:3987 1F              	pop	ds
0800:3988 5E              	pop	si
0800:3989 5F              	pop	di
0800:398A 5D              	pop	bp
0800:398B CB              	retf

;; SetMouseCursorPositionUnlocked_398C: 0800:398C
;;   Called from:
;;     0800:3A17 (in SetMouseCursorPosition_39FB)
;;     0800:3A47 (in MoveMouseCursorRelative_3A23)
SetMouseCursorPositionUnlocked_398C proc
0800:398C 83 3E 12 0E 00  	cmp	word ptr [0E12h],0h
0800:3991 75 67           	jnz	39FAh

l0800_3993:
0800:3993 3B 0E 14 0E     	cmp	cx,[0E14h]
0800:3997 7C 0D           	jl	39A6h

l0800_3999:
0800:3999 3B 0E 16 0E     	cmp	cx,[0E16h]
0800:399D 7E 0B           	jle	39AAh

l0800_399F:
0800:399F 8B 0E 16 0E     	mov	cx,[0E16h]
0800:39A3 EB 05           	jmp	39AAh
0800:39A5                90                                    .          

l0800_39A6:
0800:39A6 8B 0E 14 0E     	mov	cx,[0E14h]

l0800_39AA:
0800:39AA 89 0E 08 0E     	mov	[0E08h],cx
0800:39AE 3B 16 18 0E     	cmp	dx,[0E18h]
0800:39B2 7C 0D           	jl	39C1h

l0800_39B4:
0800:39B4 3B 16 1A 0E     	cmp	dx,[0E1Ah]
0800:39B8 7E 0B           	jle	39C5h

l0800_39BA:
0800:39BA 8B 16 1A 0E     	mov	dx,[0E1Ah]
0800:39BE EB 05           	jmp	39C5h
0800:39C0 90                                              .               

l0800_39C1:
0800:39C1 8B 16 18 0E     	mov	dx,[0E18h]

l0800_39C5:
0800:39C5 89 16 0A 0E     	mov	[0E0Ah],dx
0800:39C9 83 3E 10 0E 00  	cmp	word ptr [0E10h],0h
0800:39CE 74 0E           	jz	39DEh

l0800_39D0:
0800:39D0 83 3E 0C 0E 01  	cmp	word ptr [0E0Ch],1h
0800:39D5 75 02           	jnz	39D9h

l0800_39D7:
0800:39D7 D1 E1           	shl	cx,1h

l0800_39D9:
0800:39D9 B8 04 00        	mov	ax,4h
0800:39DC CD 33           	int	33h

l0800_39DE:
0800:39DE A1 08 0E        	mov	ax,[0E08h]
0800:39E1 39 06 20 0E     	cmp	[0E20h],ax
0800:39E5 75 09           	jnz	39F0h

l0800_39E7:
0800:39E7 A1 0A 0E        	mov	ax,[0E0Ah]
0800:39EA 39 06 22 0E     	cmp	[0E22h],ax
0800:39EE 74 0A           	jz	39FAh

l0800_39F0:
0800:39F0 9A 7D 38 00 08  	call	far 0800h:387Dh
0800:39F5 9A 53 3A 00 08  	call	far 0800h:3A53h

l0800_39FA:
0800:39FA C3              	ret

;; SetMouseCursorPosition_39FB: 0800:39FB
;;   Called from:
;;     1A1F:140C (in FocusTacticalViewOnUnit_11F7)
SetMouseCursorPosition_39FB proc
0800:39FB 55              	push	bp
0800:39FC 8B EC           	mov	bp,sp
0800:39FE 57              	push	di
0800:39FF 56              	push	si
0800:3A00 1E              	push	ds
0800:3A01 B8 84 41        	mov	ax,4184h
0800:3A04 8E D8           	mov	ds,ax
0800:3A06 8B 4E 06        	mov	cx,[bp+6h]
0800:3A09 8B 56 08        	mov	dx,[bp+8h]

l0800_3A0C:
0800:3A0C 83 3E FE 0D 00  	cmp	word ptr [0DFEh],0h
0800:3A11 75 F9           	jnz	3A0Ch

l0800_3A13:
0800:3A13 FF 06 FE 0D     	inc	word ptr [0DFEh]
0800:3A17 E8 72 FF        	call	398Ch
0800:3A1A FF 0E FE 0D     	dec	word ptr [0DFEh]
0800:3A1E 1F              	pop	ds
0800:3A1F 5E              	pop	si
0800:3A20 5F              	pop	di
0800:3A21 5D              	pop	bp
0800:3A22 CB              	retf

;; MoveMouseCursorRelative_3A23: 0800:3A23
MoveMouseCursorRelative_3A23 proc
0800:3A23 55              	push	bp
0800:3A24 8B EC           	mov	bp,sp
0800:3A26 57              	push	di
0800:3A27 56              	push	si
0800:3A28 1E              	push	ds
0800:3A29 B8 84 41        	mov	ax,4184h
0800:3A2C 8E D8           	mov	ds,ax
0800:3A2E 8B 4E 06        	mov	cx,[bp+6h]
0800:3A31 8B 56 08        	mov	dx,[bp+8h]

l0800_3A34:
0800:3A34 83 3E FE 0D 00  	cmp	word ptr [0DFEh],0h
0800:3A39 75 F9           	jnz	3A34h

l0800_3A3B:
0800:3A3B FF 06 FE 0D     	inc	word ptr [0DFEh]
0800:3A3F 03 0E 08 0E     	add	cx,[0E08h]
0800:3A43 03 16 0A 0E     	add	dx,[0E0Ah]
0800:3A47 E8 42 FF        	call	398Ch
0800:3A4A FF 0E FE 0D     	dec	word ptr [0DFEh]
0800:3A4E 1F              	pop	ds
0800:3A4F 5E              	pop	si
0800:3A50 5F              	pop	di
0800:3A51 5D              	pop	bp
0800:3A52 CB              	retf

;; ShowMouseCursorOverlayUnlocked_3A53: 0800:3A53
;;   Called from:
;;     0800:3698 (in ConfigureMouseCursorOverlay_3665)
;;     0800:39F5 (in SetMouseCursorPositionUnlocked_398C)
;;     0800:3B90 (in ShowMouseCursorOverlay_3B7A)
ShowMouseCursorOverlayUnlocked_3A53 proc
0800:3A53 55              	push	bp
0800:3A54 8B EC           	mov	bp,sp
0800:3A56 57              	push	di
0800:3A57 56              	push	si
0800:3A58 1E              	push	ds
0800:3A59 B8 84 41        	mov	ax,4184h
0800:3A5C 8E D8           	mov	ds,ax
0800:3A5E 83 3E 12 0E 00  	cmp	word ptr [0E12h],0h
0800:3A63 75 64           	jnz	3AC9h

l0800_3A65:
0800:3A65 83 3E 0E 0E 00  	cmp	word ptr [0E0Eh],0h
0800:3A6A 74 5D           	jz	3AC9h

l0800_3A6C:
0800:3A6C FF 0E 0E 0E     	dec	word ptr [0E0Eh]
0800:3A70 83 3E 0E 0E 00  	cmp	word ptr [0E0Eh],0h
0800:3A75 75 52           	jnz	3AC9h

l0800_3A77:
0800:3A77 A1 08 0E        	mov	ax,[0E08h]
0800:3A7A A3 20 0E        	mov	[0E20h],ax
0800:3A7D A3 38 0E        	mov	[0E38h],ax
0800:3A80 2B 06 1C 0E     	sub	ax,[0E1Ch]
0800:3A84 A3 3C 0E        	mov	[0E3Ch],ax
0800:3A87 A3 44 0E        	mov	[0E44h],ax
0800:3A8A A1 0A 0E        	mov	ax,[0E0Ah]
0800:3A8D A3 22 0E        	mov	[0E22h],ax
0800:3A90 A3 3A 0E        	mov	[0E3Ah],ax
0800:3A93 2B 06 1E 0E     	sub	ax,[0E1Eh]
0800:3A97 A3 3E 0E        	mov	[0E3Eh],ax
0800:3A9A A3 46 0E        	mov	[0E46h],ax
0800:3A9D A1 3C 0E        	mov	ax,[0E3Ch]
0800:3AA0 D1 F8           	sar	ax,1h
0800:3AA2 D1 F8           	sar	ax,1h
0800:3AA4 D1 F8           	sar	ax,1h
0800:3AA6 3D FD FF        	cmp	ax,0FFFDh
0800:3AA9 7E 1E           	jle	3AC9h

l0800_3AAB:
0800:3AAB 3D 28 00        	cmp	ax,28h
0800:3AAE 7D 19           	jge	3AC9h

l0800_3AB0:
0800:3AB0 A3 3C 0E        	mov	[0E3Ch],ax
0800:3AB3 05 03 00        	add	ax,3h
0800:3AB6 A3 40 0E        	mov	[0E40h],ax
0800:3AB9 83 3E 3C 0E 00  	cmp	word ptr [0E3Ch],0h
0800:3ABE 7D 0C           	jge	3ACCh

l0800_3AC0:
0800:3AC0 C7 06 3C 0E 00 00 	mov	word ptr [0E3Ch],0h
0800:3AC6 EB 11           	jmp	3AD9h
0800:3AC8                         90                              .       

l0800_3AC9:
0800:3AC9 E9 A9 00        	jmp	3B75h

l0800_3ACC:
0800:3ACC 83 3E 40 0E 28  	cmp	word ptr [0E40h],28h
0800:3AD1 7E 06           	jle	3AD9h

l0800_3AD3:
0800:3AD3 C7 06 40 0E 28 00 	mov	word ptr [0E40h],28h

l0800_3AD9:
0800:3AD9 A1 3E 0E        	mov	ax,[0E3Eh]
0800:3ADC D1 F8           	sar	ax,1h
0800:3ADE D1 F8           	sar	ax,1h
0800:3AE0 D1 F8           	sar	ax,1h
0800:3AE2 3D FD FF        	cmp	ax,0FFFDh
0800:3AE5 7E E2           	jle	3AC9h

l0800_3AE7:
0800:3AE7 3D 19 00        	cmp	ax,19h
0800:3AEA 7D DD           	jge	3AC9h

l0800_3AEC:
0800:3AEC A3 3E 0E        	mov	[0E3Eh],ax
0800:3AEF 05 03 00        	add	ax,3h
0800:3AF2 A3 42 0E        	mov	[0E42h],ax
0800:3AF5 83 3E 3E 0E 00  	cmp	word ptr [0E3Eh],0h
0800:3AFA 7D 09           	jge	3B05h

l0800_3AFC:
0800:3AFC C7 06 3E 0E 00 00 	mov	word ptr [0E3Eh],0h
0800:3B02 EB 0E           	jmp	3B12h
0800:3B04             90                                      .           

l0800_3B05:
0800:3B05 83 3E 42 0E 19  	cmp	word ptr [0E42h],19h
0800:3B0A 7E 06           	jle	3B12h

l0800_3B0C:
0800:3B0C C7 06 42 0E 19 00 	mov	word ptr [0E42h],19h

l0800_3B12:
0800:3B12 FF 36 26 0E     	push	word ptr [0E26h]
0800:3B16 FF 36 24 0E     	push	word ptr [0E24h]
0800:3B1A A1 42 0E        	mov	ax,[0E42h]
0800:3B1D 2B 06 3E 0E     	sub	ax,[0E3Eh]
0800:3B21 50              	push	ax
0800:3B22 A1 40 0E        	mov	ax,[0E40h]
0800:3B25 2B 06 3C 0E     	sub	ax,[0E3Ch]
0800:3B29 50              	push	ax
0800:3B2A FF 36 3E 0E     	push	word ptr [0E3Eh]
0800:3B2E FF 36 3C 0E     	push	word ptr [0E3Ch]
0800:3B32 8E 1E FC 0D     	mov	ds,[0DFCh]
0800:3B36 9A 35 28 00 08  	call	far 0800h:2835h
0800:3B3B 83 C4 0C        	add	sp,0Ch
0800:3B3E B8 84 41        	mov	ax,4184h
0800:3B41 8E D8           	mov	ds,ax
0800:3B43 B8 00 00        	mov	ax,0h
0800:3B46 50              	push	ax
0800:3B47 FF 36 46 0E     	push	word ptr [0E46h]
0800:3B4B FF 36 44 0E     	push	word ptr [0E44h]
0800:3B4F FF 36 2A 0E     	push	word ptr [0E2Ah]
0800:3B53 FF 36 28 0E     	push	word ptr [0E28h]
0800:3B57 B8 6A 3A        	mov	ax,3A6Ah
0800:3B5A 8E D8           	mov	ds,ax
0800:3B5C FF 36 66 B6     	push	word ptr [0B666h]
0800:3B60 FF 36 64 B6     	push	word ptr [0B664h]
0800:3B64 B8 84 41        	mov	ax,4184h
0800:3B67 8E D8           	mov	ds,ax
0800:3B69 8E 1E FC 0D     	mov	ds,[0DFCh]
0800:3B6D 9A 6E 56 73 0D  	call	far 0D73h:566Eh
0800:3B72 83 C4 0E        	add	sp,0Eh

l0800_3B75:
0800:3B75 1F              	pop	ds
0800:3B76 5E              	pop	si
0800:3B77 5F              	pop	di
0800:3B78 5D              	pop	bp
0800:3B79 CB              	retf

;; ShowMouseCursorOverlay_3B7A: 0800:3B7A
;;   Called from:
;;     0D73:006F (in RunCampaignLoop_0006)
;;     0D73:01CB (in RunCampaignLoop_0006)
;;     0D73:0349 (in InitializeTacticalScenario_0214)
;;     0D73:246D (in ShowConfirmationDialog_2448)
;;     0D73:2715 (in RunMainMenuSelection_25F5)
;;     0D73:27FE (in RunInGameMenu_274D)
;;     0D73:2AE7 (in OpenModalTextWindow_2A5D)
;;     0D73:2B23 (in RestoreModalTextWindow_2AEE)
;;     0D73:2EEC (in ShowScenarioMessage_2E7C)
;;     0D73:2FBF (in AnimateTitleTextLine_2F5F)
;;     0D73:2FEF (in AnimateTitleTextLine_2F5F)
;;     0D73:3049 (in AnimateTitleTextLine_2F5F)
;;     0D73:308C (in AnimateTitleTextLine_2F5F)
;;     0D73:317C (in RunTitleAndMainMenu_309C)
;;     0D73:3221 (in RunTitleAndMainMenu_309C)
;;     0D73:3418 (in LoadAndPresentScreen_33C1)
;;     0D73:363F (in PrepareMissionDateScreen_35AA)
;;     0D73:3766 (in DrawMissionHeaderFrame_365C)
;;     0D73:387B (in DisplayMissionDate_376C)
;;     0D73:38CF (in DisplayMissionDate_376C)
;;     0D73:391F (in DisplayMissionDate_376C)
;;     0D73:39C7 (in DisplayMissionDate_376C)
;;     0D73:3A41 (in DisplayMissionDate_376C)
;;     0D73:3AB1 (in DisplayMissionDate_376C)
;;     0D73:3B54 (in ShowMissionFollowupMessage_3AE4)
;;     0D73:3E0B (in UpdateTextEntryCursorBlink_3DA9)
;;     0D73:4531 (in EditTextField_4317)
;;     0D73:47A3 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:47D9 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:481E (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:48A8 (in SaveGame_4866)
;;     0D73:4A3D (in SaveGame_4866)
;;     0D73:4FD2 (in ShowSaveLoadMenu_4EC7)
;;     0D73:502E (in ShowSaveLoadMenu_4EC7)
;;     0D73:514D (in ShowSaveLoadMenu_4EC7)
;;     0D73:52CD (in RenameSaveSlot_5233)
;;     0D73:537D (in RenameSaveSlot_5233)
;;     0D73:545F (in WaitForAcknowledgement_53E1)
;;     0D73:54A2 (in PromptYesNo_546F)
;;     0D73:57D2 (in ShowScenarioCompletionStatus_5789)
;;     1A1F:0B34 (in RunTacticalInteractionLoop_0613)
;;     1A1F:1413 (in FocusTacticalViewOnUnit_11F7)
;;     1A1F:41DD (in RunGameOptionsMenu_417F)
;;     1A1F:422E (in RunGameOptionsMenu_417F)
;;     1A1F:42A8 (in RunGameOptionsMenu_417F)
;;     1A1F:42CD (in RunGameOptionsMenu_417F)
;;     1A1F:44AD (in RenderPendingNarration_4447)
;;     1A1F:4687 (in RenderPendingNarration_4447)
;;     1A1F:50A8 (in ShowPendingNarrationPrompt_4FA6)
;;     1A1F:5106 (in ShowPendingNarrationPrompt_4FA6)
;;     2007:083D (in DrawTacticalCellOutline_07C9)
;;     2007:0A42 (in DrawClippedWeaponTraceLine_0926)
;;     2007:0E12 (in DrawTacticalEffectSprite_0DDB)
;;     2007:0EDF (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:0F6C (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:10DA (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:11CD (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:1209 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:14D4 (in DrawBeveledMenuButton_132C)
;;     2007:15F7 (in RedrawTacticalViewport_159F)
;;     2007:1661 (in DrawCampaignClock_15FF)
;;     2007:16B3 (in DrawCampaignClock_15FF)
;;     2007:16DA (in RedrawTacticalStatusPanel_16BA)
;;     2007:17D3 (in AdvanceImpactSpriteAnimations_16E8)
;;     2007:1AD8 (in AdvanceTacticalProjectiles_17DE)
;;     2007:1D5A (in RefreshTacticalDisplay_1D06)
;;     2007:1E05 (in DrawCampaignClockSeparator_1DCC)
;;     2208:030A (in RunTacticalUnitCommandMenu_000B)
;;     2208:047E (in RunTacticalUnitCommandMenu_000B)
;;     2208:1611 (in RunTacticalGameOptionsMenu_148A)
;;     24C5:0421 (in ExitTacticalOverview_0401)
;;     2507:05A5 (in SelectUnitClass_0501)
;;     2507:073D (in SelectUnitTypeFromList_0625)
;;     2507:0AA6 (in DrawUnitAllegianceHeader_0A20)
;;     2507:4A07 (in DrawUnitStatusScreen_483A)
;;     2507:4E3A (in DrawUnitStatusScreen_483A)
;;     2B34:0FD0 (in DrawTacticalUnitControlPanel_04C2)
;;     34E6:0028 (in PollUiRegionSelection_0003)
;;     34E6:026F (in PollUiRegionSelection_0003)
;;     34E6:036C (in PollUiRegionSelection_0003)
;;     34E6:04E9 (in PollUiRegionSelection_0003)
;;     34E6:074D (in PollUiRegionSelection_0003)
;;     3568:0026 (in RunUiRegionSelectionLoop_0007)
;;     358E:0027 (in RunSingleUiRegionSelection_000C)
;;     35CA:0043 (in ToggleActiveUiRegionHighlight_0009)
ShowMouseCursorOverlay_3B7A proc
0800:3B7A 55              	push	bp
0800:3B7B 8B EC           	mov	bp,sp
0800:3B7D 57              	push	di
0800:3B7E 56              	push	si
0800:3B7F 1E              	push	ds
0800:3B80 B8 84 41        	mov	ax,4184h
0800:3B83 8E D8           	mov	ds,ax

l0800_3B85:
0800:3B85 83 3E FE 0D 00  	cmp	word ptr [0DFEh],0h
0800:3B8A 75 F9           	jnz	3B85h

l0800_3B8C:
0800:3B8C FF 06 FE 0D     	inc	word ptr [0DFEh]
0800:3B90 9A 53 3A 00 08  	call	far 0800h:3A53h
0800:3B95 FF 0E FE 0D     	dec	word ptr [0DFEh]
0800:3B99 1F              	pop	ds
0800:3B9A 5E              	pop	si
0800:3B9B 5F              	pop	di
0800:3B9C 5D              	pop	bp
0800:3B9D CB              	retf

;; NormalizeFarPointer_3B9E: 0800:3B9E
;;   Called from:
;;     3390:0DA7 (in ReadCachedResource)
NormalizeFarPointer_3B9E proc
0800:3B9E 55              	push	bp
0800:3B9F 8B EC           	mov	bp,sp
0800:3BA1 57              	push	di
0800:3BA2 56              	push	si
0800:3BA3 1E              	push	ds
0800:3BA4 B8 84 41        	mov	ax,4184h
0800:3BA7 8E D8           	mov	ds,ax
0800:3BA9 8B 46 06        	mov	ax,[bp+6h]
0800:3BAC 8B 56 08        	mov	dx,[bp+8h]

l0800_3BAF:
0800:3BAF 3D 10 00        	cmp	ax,10h
0800:3BB2 72 06           	jc	3BBAh

l0800_3BB4:
0800:3BB4 42              	inc	dx
0800:3BB5 2D 10 00        	sub	ax,10h
0800:3BB8 75 F5           	jnz	3BAFh

l0800_3BBA:
0800:3BBA 1F              	pop	ds
0800:3BBB 5E              	pop	si
0800:3BBC 5F              	pop	di
0800:3BBD 5D              	pop	bp
0800:3BBE CB              	retf

;; DOS_PrintCharacter: 0800:3BBF
;;   Called from:
;;     3327:001C (in DOS_PrintString)
DOS_PrintCharacter proc
0800:3BBF 55              	push	bp
0800:3BC0 8B EC           	mov	bp,sp
0800:3BC2 57              	push	di
0800:3BC3 56              	push	si
0800:3BC4 1E              	push	ds
0800:3BC5 B8 84 41        	mov	ax,4184h
0800:3BC8 8E D8           	mov	ds,ax
0800:3BCA 8A 56 06        	mov	dl,[bp+6h]
0800:3BCD B4 06           	mov	ah,6h
0800:3BCF CD 21           	int	21h
0800:3BD1 1F              	pop	ds
0800:3BD2 5E              	pop	si
0800:3BD3 5F              	pop	di
0800:3BD4 5D              	pop	bp
0800:3BD5 CB              	retf
0800:3BD6                   00 00 00 00 00 00 00 00 00 00       ..........
0800:3BE0 00 00 00 00 00 00 00 01 02 03 00 01 02 03 00 01 ................
0800:3BF0 02 03 00 01 02 03                               ......          
l0800_3BF6	dw	0x0000
dw	0x5555
dw	0xAAAA
dw	0xFFFF
l0800_3BFE	dw	0x0000
dw	0x1111
dw	0x2222
dw	0x3333
dw	0x4444
dw	0x5555
dw	0x6666
dw	0x7777
dw	0x8888
dw	0x9999
dw	0xAAAA
dw	0xBBBB
dw	0xCCCC
dw	0xDDDD
dw	0xEEEE
dw	0xFFFF
0800:3C1E                                           00 00               ..
0800:3C20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ............... 
l0800_3C2F	dw	0x3C5F
dw	0x3C77
dw	0x3C97
dw	0x3CB7
dw	0x3CD7
dw	0x3CF7
dw	0x3D17
dw	0x3D37
dw	0x3D57
dw	0x3D77
dw	0x3D9F
dw	0x3DC7
dw	0x3DEF
dw	0x3E17
dw	0x3E3F
dw	0x3E67
dw	0x3E8F
dw	0x3EB7
dw	0x3EE7
dw	0x3F17
dw	0x3F47
dw	0x3F77
dw	0x3FA7
dw	0x3FD7
0800:3C5F                                              6F                o
0800:3C60 3C 70 3C 71 3C 72 3C 73 3C 74 3C 75 3C 76 3C 80 <p<q<r<s<t<u<v<.
0800:3C70 40 20 10 08 04 02 01 87 3C 89 3C 8B 3C 8D 3C 8F @ ......<.<.<.<.
0800:3C80 3C 91 3C 93 3C 95 3C C0 00 60 00 30 00 18 00 0C <.<.<.<..`.0....
0800:3C90 00 06 00 03 00 01 80 A7 3C A9 3C AB 3C AD 3C AF ........<.<.<.<.
0800:3CA0 3C B1 3C B3 3C B5 3C E0 00 70 00 38 00 1C 00 0E <.<.<.<..p.8....
0800:3CB0 00 07 00 03 80 01 C0 C7 3C C9 3C CB 3C CD 3C CF ........<.<.<.<.
0800:3CC0 3C D1 3C D3 3C D5 3C F0 00 78 00 3C 00 1E 00 0F <.<.<.<..x.<....
0800:3CD0 00 07 80 03 C0 01 E0 E7 3C E9 3C EB 3C ED 3C EF ........<.<.<.<.
0800:3CE0 3C F1 3C F3 3C F5 3C F8 00 7C 00 3E 00 1F 00 0F <.<.<.<..|.>....
0800:3CF0 80 07 C0 03 E0 01 F0 07 3D 09 3D 0B 3D 0D 3D 0F ........=.=.=.=.
0800:3D00 3D 11 3D 13 3D 15 3D FC 00 7E 00 3F 00 1F 80 0F =.=.=.=..~.?....
0800:3D10 C0 07 E0 03 F0 01 F8 27 3D 29 3D 2B 3D 2D 3D 2F .......'=)=+=-=/
0800:3D20 3D 31 3D 33 3D 35 3D FE 00 7F 00 3F 80 1F C0 0F =1=3=5=....?....
0800:3D30 E0 07 F0 03 F8 01 FC 47 3D 49 3D 4B 3D 4D 3D 4F .......G=I=K=M=O
0800:3D40 3D 51 3D 53 3D 55 3D FF 00 7F 80 3F C0 1F E0 0F =Q=S=U=....?....
0800:3D50 F0 07 F8 03 FC 01 FE 67 3D 69 3D 6B 3D 6D 3D 6F .......g=i=k=m=o
0800:3D60 3D 71 3D 73 3D 75 3D FF 80 7F C0 3F E0 1F F0 0F =q=s=u=....?....
0800:3D70 F8 07 FC 03 FE 01 FF 87 3D 8A 3D 8D 3D 90 3D 93 ........=.=.=.=.
0800:3D80 3D 96 3D 99 3D 9C 3D FF C0 00 7F E0 00 3F F0 00 =.=.=.=......?..
0800:3D90 1F F8 00 0F FC 00 07 FE 00 03 FF 00 01 FF 80 AF ................
0800:3DA0 3D B2 3D B5 3D B8 3D BB 3D BE 3D C1 3D C4 3D FF =.=.=.=.=.=.=.=.
0800:3DB0 E0 00 7F F0 00 3F F8 00 1F FC 00 0F FE 00 07 FF .....?..........
0800:3DC0 00 03 FF 80 01 FF C0 D7 3D DA 3D DD 3D E0 3D E3 ........=.=.=.=.
0800:3DD0 3D E6 3D E9 3D EC 3D FF F0 00 7F F8 00 3F FC 00 =.=.=.=......?..
0800:3DE0 1F FE 00 0F FF 00 07 FF 80 03 FF C0 01 FF E0 FF ................
0800:3DF0 3D 02 3E 05 3E 08 3E 0B 3E 0E 3E 11 3E 14 3E FF =.>.>.>.>.>.>.>.
0800:3E00 F8 00 7F FC 00 3F FE 00 1F FF 00 0F FF 80 07 FF .....?..........
0800:3E10 C0 03 FF E0 01 FF F0 27 3E 2A 3E 2D 3E 30 3E 33 .......'>*>->0>3
0800:3E20 3E 36 3E 39 3E 3C 3E FF FC 00 7F FE 00 3F FF 00 >6>9><>......?..
0800:3E30 1F FF 80 0F FF C0 07 FF E0 03 FF F0 01 FF F8 4F ...............O
0800:3E40 3E 52 3E 55 3E 58 3E 5B 3E 5E 3E 61 3E 64 3E FF >R>U>X>[>^>a>d>.
0800:3E50 FE 00 7F FF 00 3F FF 80 1F FF C0 0F FF E0 07 FF .....?..........
0800:3E60 F0 03 FF F8 01 FF FC 77 3E 7A 3E 7D 3E 80 3E 83 .......w>z>}>.>.
0800:3E70 3E 86 3E 89 3E 8C 3E FF FF 00 7F FF 80 3F FF C0 >.>.>.>......?..
0800:3E80 1F FF E0 0F FF F0 07 FF F8 03 FF FC 01 FF FE 9F ................
0800:3E90 3E A2 3E A5 3E A8 3E AB 3E AE 3E B1 3E B4 3E FF >.>.>.>.>.>.>.>.
0800:3EA0 FF 80 7F FF C0 3F FF E0 1F FF F0 0F FF F8 07 FF .....?..........
0800:3EB0 FC 03 FF FE 01 FF FF C7 3E CB 3E CF 3E D3 3E D7 ........>.>.>.>.
0800:3EC0 3E DB 3E DF 3E E3 3E FF FF C0 00 7F FF E0 00 3F >.>.>.>........?
0800:3ED0 FF F0 00 1F FF F8 00 0F FF FC 00 07 FF FE 00 03 ................
0800:3EE0 FF FF 00 01 FF FF 80 F7 3E FB 3E FF 3E 03 3F 07 ........>.>.>.?.
0800:3EF0 3F 0B 3F 0F 3F 13 3F FF FF E0 00 7F FF F0 00 3F ?.?.?.?........?
0800:3F00 FF F8 00 1F FF FC 00 0F FF FE 00 07 FF FF 00 03 ................
0800:3F10 FF FF 80 01 FF FF C0 27 3F 2B 3F 2F 3F 33 3F 37 .......'?+?/?3?7
0800:3F20 3F 3B 3F 3F 3F 43 3F FF FF F0 00 7F FF F8 00 3F ?;???C?........?
0800:3F30 FF FC 00 1F FF FE 00 0F FF FF 00 07 FF FF 80 03 ................
0800:3F40 FF FF C0 01 FF FF E0 57 3F 5B 3F 5F 3F 63 3F 67 .......W?[?_?c?g
0800:3F50 3F 6B 3F 6F 3F 73 3F FF FF F8 00 7F FF FC 00 3F ?k?o?s?........?
0800:3F60 FF FE 00 1F FF FF 00 0F FF FF 80 07 FF FF C0 03 ................
0800:3F70 FF FF E0 01 FF FF F0 87 3F 8B 3F 8F 3F 93 3F 97 ........?.?.?.?.
0800:3F80 3F 9B 3F 9F 3F A3 3F FF FF FC 00 7F FF FE 00 3F ?.?.?.?........?
0800:3F90 FF FF 00 1F FF FF 80 0F FF FF C0 07 FF FF E0 03 ................
0800:3FA0 FF FF F0 01 FF FF F8 B7 3F BB 3F BF 3F C3 3F C7 ........?.?.?.?.
0800:3FB0 3F CB 3F CF 3F D3 3F FF FF FE 00 7F FF FF 00 3F ?.?.?.?........?
0800:3FC0 FF FF 80 1F FF FF C0 0F FF FF E0 07 FF FF F0 03 ................
0800:3FD0 FF FF F8 01 FF FF FC E7 3F EB 3F EF 3F F3 3F F7 ........?.?.?.?.
0800:3FE0 3F FB 3F FF 3F 03 40 FF FF FF 00 7F FF FF 80 3F ?.?.?.@........?
0800:3FF0 FF FF C0 1F FF FF E0 0F FF FF F0 07 FF FF F8 03 ................
0800:4000 FF FF FC 01 FF FF FE                            .......         
l0800_4007	dw	0x0000
dw	0x0300
dw	0x0C00
dw	0x0F00
dw	0x3000
dw	0x3300
dw	0x3C00
dw	0x3F00
dw	0xC000
dw	0xC300
dw	0xCC00
dw	0xCF00
dw	0xF000
dw	0xF300
dw	0xFC00
dw	0xFF00
dw	0x0003
dw	0x0303
dw	0x0C03
dw	0x0F03
dw	0x3003
dw	0x3303
dw	0x3C03
dw	0x3F03
dw	0xC003
dw	0xC303
dw	0xCC03
dw	0xCF03
dw	0xF003
dw	0xF303
dw	0xFC03
dw	0xFF03
dw	0x000C
dw	0x030C
dw	0x0C0C
dw	0x0F0C
dw	0x300C
dw	0x330C
dw	0x3C0C
dw	0x3F0C
dw	0xC00C
dw	0xC30C
dw	0xCC0C
dw	0xCF0C
dw	0xF00C
dw	0xF30C
dw	0xFC0C
dw	0xFF0C
dw	0x000F
dw	0x030F
dw	0x0C0F
dw	0x0F0F
dw	0x300F
dw	0x330F
dw	0x3C0F
dw	0x3F0F
dw	0xC00F
dw	0xC30F
dw	0xCC0F
dw	0xCF0F
dw	0xF00F
dw	0xF30F
dw	0xFC0F
dw	0xFF0F
dw	0x0030
dw	0x0330
dw	0x0C30
dw	0x0F30
dw	0x3030
dw	0x3330
dw	0x3C30
dw	0x3F30
dw	0xC030
dw	0xC330
dw	0xCC30
dw	0xCF30
dw	0xF030
dw	0xF330
dw	0xFC30
dw	0xFF30
dw	0x0033
dw	0x0333
dw	0x0C33
dw	0x0F33
dw	0x3033
dw	0x3333
dw	0x3C33
dw	0x3F33
dw	0xC033
dw	0xC333
dw	0xCC33
dw	0xCF33
dw	0xF033
dw	0xF333
dw	0xFC33
dw	0xFF33
dw	0x003C
dw	0x033C
dw	0x0C3C
dw	0x0F3C
dw	0x303C
dw	0x333C
dw	0x3C3C
dw	0x3F3C
dw	0xC03C
dw	0xC33C
dw	0xCC3C
dw	0xCF3C
dw	0xF03C
dw	0xF33C
dw	0xFC3C
dw	0xFF3C
dw	0x003F
dw	0x033F
dw	0x0C3F
dw	0x0F3F
dw	0x303F
dw	0x333F
dw	0x3C3F
dw	0x3F3F
dw	0xC03F
dw	0xC33F
dw	0xCC3F
dw	0xCF3F
dw	0xF03F
dw	0xF33F
dw	0xFC3F
dw	0xFF3F
dw	0x00C0
dw	0x03C0
dw	0x0CC0
dw	0x0FC0
dw	0x30C0
dw	0x33C0
dw	0x3CC0
dw	0x3FC0
dw	0xC0C0
dw	0xC3C0
dw	0xCCC0
dw	0xCFC0
dw	0xF0C0
dw	0xF3C0
dw	0xFCC0
dw	0xFFC0
dw	0x00C3
dw	0x03C3
dw	0x0CC3
dw	0x0FC3
dw	0x30C3
dw	0x33C3
dw	0x3CC3
dw	0x3FC3
dw	0xC0C3
dw	0xC3C3
dw	0xCCC3
dw	0xCFC3
dw	0xF0C3
dw	0xF3C3
dw	0xFCC3
dw	0xFFC3
dw	0x00CC
dw	0x03CC
dw	0x0CCC
dw	0x0FCC
dw	0x30CC
dw	0x33CC
dw	0x3CCC
dw	0x3FCC
dw	0xC0CC
dw	0xC3CC
dw	0xCCCC
dw	0xCFCC
dw	0xF0CC
dw	0xF3CC
dw	0xFCCC
dw	0xFFCC
dw	0x00CF
dw	0x03CF
dw	0x0CCF
dw	0x0FCF
dw	0x30CF
dw	0x33CF
dw	0x3CCF
dw	0x3FCF
dw	0xC0CF
dw	0xC3CF
dw	0xCCCF
dw	0xCFCF
dw	0xF0CF
dw	0xF3CF
dw	0xFCCF
dw	0xFFCF
dw	0x00F0
dw	0x03F0
dw	0x0CF0
dw	0x0FF0
dw	0x30F0
dw	0x33F0
dw	0x3CF0
dw	0x3FF0
dw	0xC0F0
dw	0xC3F0
dw	0xCCF0
dw	0xCFF0
dw	0xF0F0
dw	0xF3F0
dw	0xFCF0
dw	0xFFF0
dw	0x00F3
dw	0x03F3
dw	0x0CF3
dw	0x0FF3
dw	0x30F3
dw	0x33F3
dw	0x3CF3
dw	0x3FF3
dw	0xC0F3
dw	0xC3F3
dw	0xCCF3
dw	0xCFF3
dw	0xF0F3
dw	0xF3F3
dw	0xFCF3
dw	0xFFF3
dw	0x00FC
dw	0x03FC
dw	0x0CFC
dw	0x0FFC
dw	0x30FC
dw	0x33FC
dw	0x3CFC
dw	0x3FFC
dw	0xC0FC
dw	0xC3FC
dw	0xCCFC
dw	0xCFFC
dw	0xF0FC
dw	0xF3FC
dw	0xFCFC
dw	0xFFFC
dw	0x00FF
dw	0x03FF
dw	0x0CFF
dw	0x0FFF
dw	0x30FF
dw	0x33FF
dw	0x3CFF
dw	0x3FFF
dw	0xC0FF
dw	0xC3FF
dw	0xCCFF
dw	0xCFFF
dw	0xF0FF
dw	0xF3FF
dw	0xFCFF
dw	0xFFFF
l0800_4207	dw	0x0000
dw	0x0F00
dw	0xF000
dw	0xFF00
dw	0x000F
dw	0x0F0F
dw	0xF00F
dw	0xFF0F
dw	0x00F0
dw	0x0FF0
dw	0xF0F0
dw	0xFFF0
dw	0x00FF
dw	0x0FFF
dw	0xF0FF
dw	0xFFFF

;; DrawFontGlyph_4227: 0800:4227
;;   Called from:
;;     0800:4836 (in DrawTextString_470B)
DrawFontGlyph_4227 proc
0800:4227 55              	push	bp
0800:4228 8B EC           	mov	bp,sp
0800:422A 57              	push	di
0800:422B 56              	push	si
0800:422C 1E              	push	ds
0800:422D B8 84 41        	mov	ax,4184h
0800:4230 8E D8           	mov	ds,ax
0800:4232 06              	push	es
0800:4233 B8 6A 3A        	mov	ax,3A6Ah
0800:4236 8E D8           	mov	ds,ax
0800:4238 8B 36 C1 84     	mov	si,[84C1h]
0800:423C 8E 06 C3 84     	mov	es,[84C3h]
0800:4240 8B 5E 06        	mov	bx,[bp+6h]
0800:4243 43              	inc	bx
0800:4244 D1 E3           	shl	bx,1h
0800:4246 26 8B 18        	mov	bx,es:[bx+si]
0800:4249 8B 56 08        	mov	dx,[bp+8h]
0800:424C 81 FA 40 01     	cmp	dx,140h
0800:4250 72 03           	jc	4255h

l0800_4252:
0800:4252 E9 86 00        	jmp	42DBh

l0800_4255:
0800:4255 8B C2           	mov	ax,dx
0800:4257 2E A2 E2 3B     	mov	cs:[3BE2h],al
0800:425B 26 8A 8C 03 01  	mov	cl,es:[si+103h]
0800:4260 2E 88 0E E0 3B  	mov	cs:[3BE0h],cl
0800:4265 03 C1           	add	ax,cx
0800:4267 3D 40 01        	cmp	ax,140h
0800:426A 77 6F           	ja	42DBh

l0800_426C:
0800:426C 8B FA           	mov	di,dx
0800:426E 8B 56 0A        	mov	dx,[bp+0Ah]
0800:4271 81 FA C8 00     	cmp	dx,0C8h
0800:4275 73 64           	jnc	42DBh

l0800_4277:
0800:4277 8B C2           	mov	ax,dx
0800:4279 2E A2 E3 3B     	mov	cs:[3BE3h],al
0800:427D 26 8A 8C 02 01  	mov	cl,es:[si+102h]
0800:4282 2E 88 0E E1 3B  	mov	cs:[3BE1h],cl
0800:4287 03 C1           	add	ax,cx
0800:4289 3D C8 00        	cmp	ax,0C8h
0800:428C 77 4D           	ja	42DBh

l0800_428E:
0800:428E 03 F3           	add	si,bx
0800:4290 32 E4           	xor	ah,ah
0800:4292 2E A0 E0 3B     	mov	al,cs:[3BE0h]
0800:4296 FE C8           	dec	al
0800:4298 3C 18           	cmp	al,18h
0800:429A 73 3F           	jnc	42DBh

l0800_429C:
0800:429C 8B E8           	mov	bp,ax
0800:429E 04 07           	add	al,7h
0800:42A0 D0 E8           	shr	al,1h
0800:42A2 D0 E8           	shr	al,1h
0800:42A4 D0 E8           	shr	al,1h
0800:42A6 2E A2 2C 3C     	mov	cs:[3C2Ch],al
0800:42AA D1 E5           	shl	bp,1h
0800:42AC 2E 8B AE 2F 3C  	mov	bp,cs:[bp+3C2Fh]
0800:42B1 B8 84 41        	mov	ax,4184h
0800:42B4 8E D8           	mov	ds,ax
0800:42B6 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:42BB 74 21           	jz	42DEh

l0800_42BD:
0800:42BD 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:42C2 75 03           	jnz	42C7h

l0800_42C4:
0800:42C4 E9 55 01        	jmp	441Ch

l0800_42C7:
0800:42C7 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:42CC 75 03           	jnz	42D1h

l0800_42CE:
0800:42CE E9 DD 02        	jmp	45AEh

l0800_42D1:
0800:42D1 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:42D6 75 03           	jnz	42DBh

l0800_42D8:
0800:42D8 E9 93 03        	jmp	466Eh

l0800_42DB:
0800:42DB E9 27 04        	jmp	4705h

l0800_42DE:
0800:42DE D1 EF           	shr	di,1h
0800:42E0 D1 EF           	shr	di,1h
0800:42E2 2E 80 26 E2 3B 03 	and	byte ptr cs:[3BE2h],3h
0800:42E8 32 E4           	xor	ah,ah
0800:42EA 2E A0 E2 3B     	mov	al,cs:[3BE2h]
0800:42EE D1 E0           	shl	ax,1h
0800:42F0 03 E8           	add	bp,ax
0800:42F2 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:42F6 8B C2           	mov	ax,dx
0800:42F8 25 FE 03        	and	ax,3FEh
0800:42FB BA 28 00        	mov	dx,28h
0800:42FE F7 E2           	mul	dx
0800:4300 2E 80 26 E3 3B 01 	and	byte ptr cs:[3BE3h],1h
0800:4306 74 03           	jz	430Bh

l0800_4308:
0800:4308 05 00 20        	add	ax,2000h

l0800_430B:
0800:430B 03 F8           	add	di,ax
0800:430D 32 E4           	xor	ah,ah
0800:430F 2E A0 2C 3C     	mov	al,cs:[3C2Ch]
0800:4313 2E A3 DE 3B     	mov	cs:[3BDEh],ax
0800:4317 D1 E0           	shl	ax,1h
0800:4319 8B D8           	mov	bx,ax
0800:431B B8 00 20        	mov	ax,2000h
0800:431E 2B C3           	sub	ax,bx
0800:4320 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:4324 8B C3           	mov	ax,bx
0800:4326 2D 50 00        	sub	ax,50h
0800:4329 05 00 20        	add	ax,2000h
0800:432C 2E A3 D8 3B     	mov	cs:[3BD8h],ax
0800:4330 B8 84 41        	mov	ax,4184h
0800:4333 8E D8           	mov	ds,ax
0800:4335 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4339 A1 9D 0B        	mov	ax,[0B9Dh]
0800:433C 8C C2           	mov	dx,es
0800:433E 8E C0           	mov	es,ax
0800:4340 8E DA           	mov	ds,dx
0800:4342 2E 8A 3E E4 3B  	mov	bh,cs:[3BE4h]
0800:4347 B1 04           	mov	cl,4h
0800:4349 D2 E7           	shl	bh,cl
0800:434B 2E 0A 3E E5 3B  	or	bh,cs:[3BE5h]

l0800_4350:
0800:4350 2E 8A 2E 2C 3C  	mov	ch,cs:[3C2Ch]
0800:4355 33 C0           	xor	ax,ax
0800:4357 8A DC           	mov	bl,ah

l0800_4359:
0800:4359 32 C0           	xor	al,al
0800:435B 8A 24           	mov	ah,[si]
0800:435D 2E 8A 0E E2 3B  	mov	cl,cs:[3BE2h]
0800:4362 D3 E8           	shr	ax,cl
0800:4364 86 C4           	xchg	ah,al
0800:4366 0A C3           	or	al,bl
0800:4368 8A DC           	mov	bl,ah
0800:436A 8A CF           	mov	cl,bh
0800:436C 53              	push	bx
0800:436D 32 E4           	xor	ah,ah
0800:436F BA 00 00        	mov	dx,0h
0800:4372 F6 C1 F0        	test	cl,0F0h
0800:4375 74 0D           	jz	4384h

l0800_4377:
0800:4377 2E 22 46 00     	and	al,cs:[bp+0h]
0800:437B 8B D8           	mov	bx,ax
0800:437D D1 E3           	shl	bx,1h
0800:437F 2E 8B 97 07 40  	mov	dx,cs:[bx+4007h]

l0800_4384:
0800:4384 F6 C1 0F        	test	cl,0Fh
0800:4387 74 38           	jz	43C1h

l0800_4389:
0800:4389 F6 D0           	not	al
0800:438B 2E 22 46 00     	and	al,cs:[bp+0h]
0800:438F 8B D8           	mov	bx,ax
0800:4391 D1 E3           	shl	bx,1h
0800:4393 2E 8B 87 07 40  	mov	ax,cs:[bx+4007h]
0800:4398 8B D8           	mov	bx,ax
0800:439A 0B C2           	or	ax,dx
0800:439C F7 D0           	not	ax
0800:439E 26 23 05        	and	ax,es:[di]
0800:43A1 2E 23 1E 20 3C  	and	bx,cs:[3C20h]
0800:43A6 2E 23 16 1E 3C  	and	dx,cs:[3C1Eh]
0800:43AB 0B C3           	or	ax,bx
0800:43AD 0B C2           	or	ax,dx
0800:43AF 5B              	pop	bx
0800:43B0 26 89 05        	mov	es:[di],ax
0800:43B3 80 FD 00        	cmp	ch,0h
0800:43B6 74 36           	jz	43EEh

l0800_43B8:
0800:43B8 83 C7 02        	add	di,2h
0800:43BB 46              	inc	si
0800:43BC 45              	inc	bp
0800:43BD FE CD           	dec	ch
0800:43BF EB 98           	jmp	4359h

l0800_43C1:
0800:43C1 B8 00 00        	mov	ax,0h
0800:43C4 8B D8           	mov	bx,ax
0800:43C6 0B C2           	or	ax,dx
0800:43C8 F7 D0           	not	ax
0800:43CA 26 23 05        	and	ax,es:[di]
0800:43CD 2E 23 1E 20 3C  	and	bx,cs:[3C20h]
0800:43D2 2E 23 16 1E 3C  	and	dx,cs:[3C1Eh]
0800:43D7 0B C3           	or	ax,bx
0800:43D9 0B C2           	or	ax,dx
0800:43DB 5B              	pop	bx
0800:43DC 26 89 05        	mov	es:[di],ax
0800:43DF 80 FD 00        	cmp	ch,0h
0800:43E2 74 0A           	jz	43EEh

l0800_43E4:
0800:43E4 83 C7 02        	add	di,2h
0800:43E7 46              	inc	si
0800:43E8 45              	inc	bp
0800:43E9 FE CD           	dec	ch
0800:43EB E9 6B FF        	jmp	4359h

l0800_43EE:
0800:43EE 2E 2B 2E DE 3B  	sub	bp,cs:[3BDEh]
0800:43F3 2E 80 36 E3 3B 01 	xor	byte ptr cs:[3BE3h],1h
0800:43F9 74 0F           	jz	440Ah

l0800_43FB:
0800:43FB 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:4400 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4405 74 12           	jz	4419h

l0800_4407:
0800:4407 E9 46 FF        	jmp	4350h

l0800_440A:
0800:440A 2E 2B 3E D8 3B  	sub	di,cs:[3BD8h]
0800:440F 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4414 74 03           	jz	4419h

l0800_4416:
0800:4416 E9 37 FF        	jmp	4350h

l0800_4419:
0800:4419 E9 E9 02        	jmp	4705h

l0800_441C:
0800:441C D1 EF           	shr	di,1h
0800:441E 2E 80 26 E2 3B 01 	and	byte ptr cs:[3BE2h],1h
0800:4424 32 E4           	xor	ah,ah
0800:4426 2E A0 E2 3B     	mov	al,cs:[3BE2h]
0800:442A D1 E0           	shl	ax,1h
0800:442C 03 E8           	add	bp,ax
0800:442E 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:4432 8B C2           	mov	ax,dx
0800:4434 25 FC 03        	and	ax,3FCh
0800:4437 BA 28 00        	mov	dx,28h
0800:443A F7 E2           	mul	dx
0800:443C 2E 80 26 E3 3B 03 	and	byte ptr cs:[3BE3h],3h
0800:4442 74 0C           	jz	4450h

l0800_4444:
0800:4444 32 ED           	xor	ch,ch
0800:4446 2E 8A 0E E3 3B  	mov	cl,cs:[3BE3h]

l0800_444B:
0800:444B 05 00 20        	add	ax,2000h
0800:444E E2 FB           	loop	444Bh

l0800_4450:
0800:4450 03 F8           	add	di,ax
0800:4452 32 E4           	xor	ah,ah
0800:4454 2E A0 2C 3C     	mov	al,cs:[3C2Ch]
0800:4458 2E A3 DE 3B     	mov	cs:[3BDEh],ax
0800:445C D1 E0           	shl	ax,1h
0800:445E 40              	inc	ax
0800:445F D1 E0           	shl	ax,1h
0800:4461 8B D8           	mov	bx,ax
0800:4463 B8 00 20        	mov	ax,2000h
0800:4466 2B C3           	sub	ax,bx
0800:4468 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:446C 8B C3           	mov	ax,bx
0800:446E 2D A0 00        	sub	ax,0A0h
0800:4471 05 00 60        	add	ax,6000h
0800:4474 2E A3 D8 3B     	mov	cs:[3BD8h],ax
0800:4478 B8 84 41        	mov	ax,4184h
0800:447B 8E D8           	mov	ds,ax
0800:447D 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4481 A1 9D 0B        	mov	ax,[0B9Dh]
0800:4484 8C C2           	mov	dx,es
0800:4486 8E C0           	mov	es,ax
0800:4488 8E DA           	mov	ds,dx
0800:448A 2E 8A 3E E4 3B  	mov	bh,cs:[3BE4h]
0800:448F B1 04           	mov	cl,4h
0800:4491 D2 E7           	shl	bh,cl
0800:4493 2E 0A 3E E5 3B  	or	bh,cs:[3BE5h]
0800:4498 2E 8A 0E E2 3B  	mov	cl,cs:[3BE2h]

l0800_449D:
0800:449D 2E 8A 2E 2C 3C  	mov	ch,cs:[3C2Ch]
0800:44A2 33 C0           	xor	ax,ax
0800:44A4 8A DC           	mov	bl,ah

l0800_44A6:
0800:44A6 51              	push	cx
0800:44A7 32 C0           	xor	al,al
0800:44A9 8A 24           	mov	ah,[si]
0800:44AB D3 E8           	shr	ax,cl
0800:44AD 86 C4           	xchg	ah,al
0800:44AF 0A C3           	or	al,bl
0800:44B1 8A DC           	mov	bl,ah
0800:44B3 8A CF           	mov	cl,bh
0800:44B5 8A E8           	mov	ch,al
0800:44B7 53              	push	bx
0800:44B8 32 E4           	xor	ah,ah
0800:44BA BA 00 00        	mov	dx,0h
0800:44BD F6 C1 F0        	test	cl,0F0h
0800:44C0 74 15           	jz	44D7h

l0800_44C2:
0800:44C2 2E 22 46 00     	and	al,cs:[bp+0h]
0800:44C6 8B D8           	mov	bx,ax
0800:44C8 D0 EB           	shr	bl,1h
0800:44CA D0 EB           	shr	bl,1h
0800:44CC D0 EB           	shr	bl,1h
0800:44CE D0 EB           	shr	bl,1h
0800:44D0 D1 E3           	shl	bx,1h
0800:44D2 2E 8B 97 07 42  	mov	dx,cs:[bx+4207h]

l0800_44D7:
0800:44D7 F6 C1 0F        	test	cl,0Fh
0800:44DA 75 06           	jnz	44E2h

l0800_44DC:
0800:44DC B8 00 00        	mov	ax,0h
0800:44DF EB 18           	jmp	44F9h
0800:44E1    90                                            .              

l0800_44E2:
0800:44E2 F6 D0           	not	al
0800:44E4 2E 22 46 00     	and	al,cs:[bp+0h]
0800:44E8 8B D8           	mov	bx,ax
0800:44EA D0 EB           	shr	bl,1h
0800:44EC D0 EB           	shr	bl,1h
0800:44EE D0 EB           	shr	bl,1h
0800:44F0 D0 EB           	shr	bl,1h
0800:44F2 D1 E3           	shl	bx,1h
0800:44F4 2E 8B 87 07 42  	mov	ax,cs:[bx+4207h]

l0800_44F9:
0800:44F9 8B D8           	mov	bx,ax
0800:44FB 0B C2           	or	ax,dx
0800:44FD F7 D0           	not	ax
0800:44FF 26 23 05        	and	ax,es:[di]
0800:4502 2E 23 1E 20 3C  	and	bx,cs:[3C20h]
0800:4507 2E 23 16 1E 3C  	and	dx,cs:[3C1Eh]
0800:450C 0B C3           	or	ax,bx
0800:450E 0B C2           	or	ax,dx
0800:4510 26 89 05        	mov	es:[di],ax
0800:4513 83 C7 02        	add	di,2h
0800:4516 8A C5           	mov	al,ch
0800:4518 32 E4           	xor	ah,ah
0800:451A BA 00 00        	mov	dx,0h
0800:451D F6 C1 F0        	test	cl,0F0h
0800:4520 74 10           	jz	4532h

l0800_4522:
0800:4522 2E 22 46 00     	and	al,cs:[bp+0h]
0800:4526 8B D8           	mov	bx,ax
0800:4528 83 E3 0F        	and	bx,0Fh
0800:452B D1 E3           	shl	bx,1h
0800:452D 2E 8B 97 07 42  	mov	dx,cs:[bx+4207h]

l0800_4532:
0800:4532 F6 C1 0F        	test	cl,0Fh
0800:4535 75 06           	jnz	453Dh

l0800_4537:
0800:4537 B8 00 00        	mov	ax,0h
0800:453A EB 13           	jmp	454Fh
0800:453C                                     90                      .   

l0800_453D:
0800:453D F6 D0           	not	al
0800:453F 2E 22 46 00     	and	al,cs:[bp+0h]
0800:4543 8B D8           	mov	bx,ax
0800:4545 83 E3 0F        	and	bx,0Fh
0800:4548 D1 E3           	shl	bx,1h
0800:454A 2E 8B 87 07 42  	mov	ax,cs:[bx+4207h]

l0800_454F:
0800:454F 8B D8           	mov	bx,ax
0800:4551 0B C2           	or	ax,dx
0800:4553 F7 D0           	not	ax
0800:4555 26 23 05        	and	ax,es:[di]
0800:4558 2E 23 1E 20 3C  	and	bx,cs:[3C20h]
0800:455D 2E 23 16 1E 3C  	and	dx,cs:[3C1Eh]
0800:4562 0B C3           	or	ax,bx
0800:4564 0B C2           	or	ax,dx
0800:4566 26 89 05        	mov	es:[di],ax
0800:4569 5B              	pop	bx
0800:456A 59              	pop	cx
0800:456B 80 FD 00        	cmp	ch,0h
0800:456E 74 0A           	jz	457Ah

l0800_4570:
0800:4570 83 C7 02        	add	di,2h
0800:4573 46              	inc	si
0800:4574 45              	inc	bp
0800:4575 FE CD           	dec	ch
0800:4577 E9 2C FF        	jmp	44A6h

l0800_457A:
0800:457A 2E 2B 2E DE 3B  	sub	bp,cs:[3BDEh]
0800:457F 2E A0 E3 3B     	mov	al,cs:[3BE3h]
0800:4583 FE C0           	inc	al
0800:4585 24 03           	and	al,3h
0800:4587 2E A2 E3 3B     	mov	cs:[3BE3h],al
0800:458B 74 0F           	jz	459Ch

l0800_458D:
0800:458D 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:4592 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4597 74 12           	jz	45ABh

l0800_4599:
0800:4599 E9 01 FF        	jmp	449Dh

l0800_459C:
0800:459C 2E 2B 3E D8 3B  	sub	di,cs:[3BD8h]
0800:45A1 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:45A6 74 03           	jz	45ABh

l0800_45A8:
0800:45A8 E9 F2 FE        	jmp	449Dh

l0800_45AB:
0800:45AB E9 57 01        	jmp	4705h

l0800_45AE:
0800:45AE 2E 80 26 E2 3B 07 	and	byte ptr cs:[3BE2h],7h
0800:45B4 32 E4           	xor	ah,ah
0800:45B6 2E A0 E2 3B     	mov	al,cs:[3BE2h]
0800:45BA D1 E0           	shl	ax,1h
0800:45BC 03 E8           	add	bp,ax
0800:45BE 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:45C2 D1 EF           	shr	di,1h
0800:45C4 D1 EF           	shr	di,1h
0800:45C6 D1 EF           	shr	di,1h
0800:45C8 8B C2           	mov	ax,dx
0800:45CA BA 28 00        	mov	dx,28h
0800:45CD F7 E2           	mul	dx
0800:45CF 03 F8           	add	di,ax
0800:45D1 B8 28 00        	mov	ax,28h
0800:45D4 2E 2A 06 2C 3C  	sub	al,cs:[3C2Ch]
0800:45D9 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:45DD 32 E4           	xor	ah,ah
0800:45DF 2E A0 2C 3C     	mov	al,cs:[3C2Ch]
0800:45E3 2E A3 DE 3B     	mov	cs:[3BDEh],ax
0800:45E7 B8 84 41        	mov	ax,4184h
0800:45EA 8E D8           	mov	ds,ax
0800:45EC 03 3E 9B 0B     	add	di,[0B9Bh]
0800:45F0 A1 9D 0B        	mov	ax,[0B9Dh]
0800:45F3 8C C2           	mov	dx,es
0800:45F5 8E C0           	mov	es,ax
0800:45F7 8E DA           	mov	ds,dx
0800:45F9 FA              	cli
0800:45FA BA CE 03        	mov	dx,3CEh
0800:45FD B8 05 02        	mov	ax,205h
0800:4600 EE              	out	dx,al
0800:4601 42              	inc	dx
0800:4602 8A C4           	mov	al,ah
0800:4604 EE              	out	dx,al
0800:4605 4A              	dec	dx
0800:4606 B0 08           	mov	al,8h
0800:4608 EE              	out	dx,al
0800:4609 42              	inc	dx
0800:460A 2E 8A 1E E4 3B  	mov	bl,cs:[3BE4h]
0800:460F 2E 8A 3E E5 3B  	mov	bh,cs:[3BE5h]

l0800_4614:
0800:4614 2E 8A 2E 2C 3C  	mov	ch,cs:[3C2Ch]
0800:4619 33 C0           	xor	ax,ax

l0800_461B:
0800:461B 8A D4           	mov	dl,ah
0800:461D 32 C0           	xor	al,al
0800:461F 8A 24           	mov	ah,[si]
0800:4621 2E 8A 0E E2 3B  	mov	cl,cs:[3BE2h]
0800:4626 D3 E8           	shr	ax,cl
0800:4628 86 C4           	xchg	ah,al
0800:462A 0A C2           	or	al,dl
0800:462C BA CF 03        	mov	dx,3CFh
0800:462F 0A DB           	or	bl,bl
0800:4631 74 0A           	jz	463Dh

l0800_4633:
0800:4633 2E 22 46 00     	and	al,cs:[bp+0h]
0800:4637 EE              	out	dx,al
0800:4638 8A CB           	mov	cl,bl
0800:463A 26 86 0D        	xchg	es:[di],cl

l0800_463D:
0800:463D 0A FF           	or	bh,bh
0800:463F 74 0C           	jz	464Dh

l0800_4641:
0800:4641 F6 D0           	not	al
0800:4643 2E 22 46 00     	and	al,cs:[bp+0h]
0800:4647 EE              	out	dx,al
0800:4648 8A CF           	mov	cl,bh
0800:464A 26 86 0D        	xchg	es:[di],cl

l0800_464D:
0800:464D 80 FD 00        	cmp	ch,0h
0800:4650 74 07           	jz	4659h

l0800_4652:
0800:4652 47              	inc	di
0800:4653 46              	inc	si
0800:4654 45              	inc	bp
0800:4655 FE CD           	dec	ch
0800:4657 EB C2           	jmp	461Bh

l0800_4659:
0800:4659 2E 2B 2E DE 3B  	sub	bp,cs:[3BDEh]
0800:465E 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:4663 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4668 75 AA           	jnz	4614h

l0800_466A:
0800:466A FB              	sti
0800:466B E9 97 00        	jmp	4705h

l0800_466E:
0800:466E 2E A0 E0 3B     	mov	al,cs:[3BE0h]
0800:4672 FE C8           	dec	al
0800:4674 D0 E8           	shr	al,1h
0800:4676 D0 E8           	shr	al,1h
0800:4678 D0 E8           	shr	al,1h
0800:467A 2E A2 2C 3C     	mov	cs:[3C2Ch],al
0800:467E 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:4682 8B C2           	mov	ax,dx
0800:4684 BA 40 01        	mov	dx,140h
0800:4687 F7 E2           	mul	dx
0800:4689 03 F8           	add	di,ax
0800:468B B8 40 01        	mov	ax,140h
0800:468E 32 F6           	xor	dh,dh
0800:4690 2E 8A 16 E0 3B  	mov	dl,cs:[3BE0h]
0800:4695 2B C2           	sub	ax,dx
0800:4697 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:469B B8 84 41        	mov	ax,4184h
0800:469E 8E D8           	mov	ds,ax
0800:46A0 03 3E 9B 0B     	add	di,[0B9Bh]
0800:46A4 A1 9D 0B        	mov	ax,[0B9Dh]
0800:46A7 8C C2           	mov	dx,es
0800:46A9 8E C0           	mov	es,ax
0800:46AB 8E DA           	mov	ds,dx
0800:46AD 2E 8A 1E E4 3B  	mov	bl,cs:[3BE4h]
0800:46B2 2E 8A 3E E5 3B  	mov	bh,cs:[3BE5h]

l0800_46B7:
0800:46B7 2E 8A 2E 2C 3C  	mov	ch,cs:[3C2Ch]
0800:46BC 8B D5           	mov	dx,bp

l0800_46BE:
0800:46BE AC              	lodsb
0800:46BF 2E 8A 66 00     	mov	ah,cs:[bp+0h]
0800:46C3 B1 80           	mov	cl,80h

l0800_46C5:
0800:46C5 84 E1           	test	cl,ah
0800:46C7 74 2E           	jz	46F7h

l0800_46C9:
0800:46C9 84 C1           	test	cl,al
0800:46CB 74 15           	jz	46E2h

l0800_46CD:
0800:46CD 0A DB           	or	bl,bl
0800:46CF 74 18           	jz	46E9h

l0800_46D1:
0800:46D1 26 88 1D        	mov	es:[di],bl
0800:46D4 47              	inc	di
0800:46D5 D0 E9           	shr	cl,1h
0800:46D7 75 EC           	jnz	46C5h

l0800_46D9:
0800:46D9 0A ED           	or	ch,ch
0800:46DB 74 1A           	jz	46F7h

l0800_46DD:
0800:46DD 45              	inc	bp
0800:46DE FE CD           	dec	ch
0800:46E0 EB DC           	jmp	46BEh

l0800_46E2:
0800:46E2 0A FF           	or	bh,bh
0800:46E4 74 03           	jz	46E9h

l0800_46E6:
0800:46E6 26 88 3D        	mov	es:[di],bh

l0800_46E9:
0800:46E9 47              	inc	di
0800:46EA D0 E9           	shr	cl,1h
0800:46EC 75 D7           	jnz	46C5h

l0800_46EE:
0800:46EE 0A ED           	or	ch,ch
0800:46F0 74 05           	jz	46F7h

l0800_46F2:
0800:46F2 45              	inc	bp
0800:46F3 FE CD           	dec	ch
0800:46F5 EB C7           	jmp	46BEh

l0800_46F7:
0800:46F7 8B EA           	mov	bp,dx
0800:46F9 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:46FE 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4703 75 B2           	jnz	46B7h

l0800_4705:
0800:4705 07              	pop	es
0800:4706 1F              	pop	ds
0800:4707 5E              	pop	si
0800:4708 5F              	pop	di
0800:4709 5D              	pop	bp
0800:470A CB              	retf

;; DrawTextString_470B: 0800:470B
;;   Called from:
;;     0D73:3EC4 (in DrawCenteredClippedText_3E35)
;;     0D73:3F49 (in DrawCenteredClippedText_3E35)
;;     0D73:3FE4 (in DrawLeftAlignedClippedText_3F57)
;;     0D73:408B (in DrawRightAlignedClippedText_3FF2)
;;     2007:0211 (in DrawTileAlignedText_01EE)
;;     2507:4B94 (in DrawUnitStatusScreen_483A)
;;     2507:4D4F (in DrawUnitStatusScreen_483A)
;;     2507:4DE8 (in DrawUnitStatusScreen_483A)
;;     2507:60FC (in DrawRangeAndSpeedStatHeaders_60D2)
;;     2507:613B (in DrawExperienceAndGunneryHeaders_6112)
;;     2B34:045E (in DrawCombatRatingDescription_0422)
;;     356F:00FD (in RenderTextToActiveWindow_000B)
;;     356F:019E (in RenderTextToActiveWindow_000B)
DrawTextString_470B proc
0800:470B 55              	push	bp
0800:470C 8B EC           	mov	bp,sp
0800:470E 57              	push	di
0800:470F 56              	push	si
0800:4710 1E              	push	ds
0800:4711 B8 84 41        	mov	ax,4184h
0800:4714 8E D8           	mov	ds,ax
0800:4716 06              	push	es
0800:4717 2E C7 06 28 3C 40 01 	mov	word ptr cs:[3C28h],140h
0800:471E B8 6A 3A        	mov	ax,3A6Ah
0800:4721 8E D8           	mov	ds,ax
0800:4723 8E 06 C3 84     	mov	es,[84C3h]
0800:4727 2E 8C 06 2D 3C  	mov	cs:[3C2Dh],es
0800:472C 8B 3E C1 84     	mov	di,[84C1h]
0800:4730 32 E4           	xor	ah,ah
0800:4732 26 8A 85 02 01  	mov	al,es:[di+102h]
0800:4737 2E A3 24 3C     	mov	cs:[3C24h],ax
0800:473B 8B 76 06        	mov	si,[bp+6h]
0800:473E 8B 46 08        	mov	ax,[bp+8h]
0800:4741 8E C0           	mov	es,ax
0800:4743 8B 5E 0A        	mov	bx,[bp+0Ah]
0800:4746 2E 3B 1E 28 3C  	cmp	bx,cs:[3C28h]
0800:474B 72 03           	jc	4750h

l0800_474D:
0800:474D E9 F8 00        	jmp	4848h

l0800_4750:
0800:4750 2E 89 1E 22 3C  	mov	cs:[3C22h],bx
0800:4755 8B 4E 0C        	mov	cx,[bp+0Ch]
0800:4758 8A 46 0E        	mov	al,[bp+0Eh]
0800:475B 2E A2 E4 3B     	mov	cs:[3BE4h],al
0800:475F 8A 46 10        	mov	al,[bp+10h]
0800:4762 2E A2 E5 3B     	mov	cs:[3BE5h],al
0800:4766 B8 84 41        	mov	ax,4184h
0800:4769 8E D8           	mov	ds,ax
0800:476B 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:4770 74 0A           	jz	477Ch

l0800_4772:
0800:4772 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:4777 74 44           	jz	47BDh

l0800_4779:
0800:4779 EB 6C           	jmp	47E7h
0800:477B                                  90                        .    

l0800_477C:
0800:477C 57              	push	di
0800:477D 2E A0 E4 3B     	mov	al,cs:[3BE4h]
0800:4781 25 0F 00        	and	ax,0Fh
0800:4784 8B F8           	mov	di,ax
0800:4786 2E 8A 85 E6 3B  	mov	al,cs:[di+3BE6h]
0800:478B 25 03 00        	and	ax,3h
0800:478E 8B F8           	mov	di,ax
0800:4790 D1 E7           	shl	di,1h
0800:4792 2E 8B 85 F6 3B  	mov	ax,cs:[di+3BF6h]
0800:4797 2E A3 1E 3C     	mov	cs:[3C1Eh],ax
0800:479B 2E A0 E5 3B     	mov	al,cs:[3BE5h]
0800:479F 25 0F 00        	and	ax,0Fh
0800:47A2 8B F8           	mov	di,ax
0800:47A4 2E 8A 85 E6 3B  	mov	al,cs:[di+3BE6h]
0800:47A9 25 03 00        	and	ax,3h
0800:47AC 8B F8           	mov	di,ax
0800:47AE D1 E7           	shl	di,1h
0800:47B0 2E 8B 85 F6 3B  	mov	ax,cs:[di+3BF6h]
0800:47B5 2E A3 20 3C     	mov	cs:[3C20h],ax
0800:47B9 5F              	pop	di
0800:47BA EB 2B           	jmp	47E7h
0800:47BC                                     90                      .   

l0800_47BD:
0800:47BD 57              	push	di
0800:47BE 2E A0 E4 3B     	mov	al,cs:[3BE4h]
0800:47C2 25 0F 00        	and	ax,0Fh
0800:47C5 8B F8           	mov	di,ax
0800:47C7 D1 E7           	shl	di,1h
0800:47C9 2E 8B 85 FE 3B  	mov	ax,cs:[di+3BFEh]
0800:47CE 2E A3 1E 3C     	mov	cs:[3C1Eh],ax
0800:47D2 2E A0 E5 3B     	mov	al,cs:[3BE5h]
0800:47D6 25 0F 00        	and	ax,0Fh
0800:47D9 8B F8           	mov	di,ax
0800:47DB D1 E7           	shl	di,1h
0800:47DD 2E 8B 85 FE 3B  	mov	ax,cs:[di+3BFEh]
0800:47E2 2E A3 20 3C     	mov	cs:[3C20h],ax
0800:47E6 5F              	pop	di

l0800_47E7:
0800:47E7 26 80 3C 00     	cmp	byte ptr es:[si],0h
0800:47EB 74 5B           	jz	4848h

l0800_47ED:
0800:47ED 26 80 3C 0D     	cmp	byte ptr es:[si],0Dh
0800:47F1 75 0D           	jnz	4800h

l0800_47F3:
0800:47F3 2E 8B 1E 22 3C  	mov	bx,cs:[3C22h]
0800:47F8 2E 03 0E 24 3C  	add	cx,cs:[3C24h]
0800:47FD 46              	inc	si
0800:47FE EB E7           	jmp	47E7h

l0800_4800:
0800:4800 06              	push	es
0800:4801 2E 8E 06 2D 3C  	mov	es,cs:[3C2Dh]
0800:4806 32 E4           	xor	ah,ah
0800:4808 26 8A 85 03 01  	mov	al,es:[di+103h]
0800:480D 2E A3 26 3C     	mov	cs:[3C26h],ax
0800:4811 8B D3           	mov	dx,bx
0800:4813 03 D0           	add	dx,ax
0800:4815 07              	pop	es
0800:4816 2E 3B 16 28 3C  	cmp	dx,cs:[3C28h]
0800:481B 76 0A           	jbe	4827h

l0800_481D:
0800:481D 2E 8B 1E 22 3C  	mov	bx,cs:[3C22h]
0800:4822 2E 03 0E 24 3C  	add	cx,cs:[3C24h]

l0800_4827:
0800:4827 81 F9 C8 00     	cmp	cx,0C8h
0800:482B 73 1B           	jnc	4848h

l0800_482D:
0800:482D 51              	push	cx
0800:482E 53              	push	bx
0800:482F 26 8A 04        	mov	al,es:[si]
0800:4832 25 7F 00        	and	ax,7Fh
0800:4835 50              	push	ax
0800:4836 9A 27 42 00 08  	call	far 0800h:4227h
0800:483B 83 C4 02        	add	sp,2h
0800:483E 5B              	pop	bx
0800:483F 59              	pop	cx
0800:4840 2E 03 1E 26 3C  	add	bx,cs:[3C26h]
0800:4845 46              	inc	si
0800:4846 EB 9F           	jmp	47E7h

l0800_4848:
0800:4848 07              	pop	es
0800:4849 1F              	pop	ds
0800:484A 5E              	pop	si
0800:484B 5F              	pop	di
0800:484C 5D              	pop	bp
0800:484D CB              	retf

;; XorVideoRectangle_484E: 0800:484E
;;   Called from:
;;     0D73:3AA9 (in DisplayMissionDate_376C)
;;     0D73:513F (in ShowSaveLoadMenu_4EC7)
;;     0D73:52C5 (in RenameSaveSlot_5233)
;;     0D73:5375 (in RenameSaveSlot_5233)
;;     0D73:5457 (in WaitForAcknowledgement_53E1)
;;     34E6:0267 (in PollUiRegionSelection_0003)
;;     34E6:0364 (in PollUiRegionSelection_0003)
;;     34E6:04E1 (in PollUiRegionSelection_0003)
;;     34E6:0745 (in PollUiRegionSelection_0003)
;;     3599:0119 (in HighlightUiRegionSelection_0009)
;;     35AB:0169 (in BeginUiRegionSelection_000B)
;;     35CA:0037 (in ToggleActiveUiRegionHighlight_0009)
XorVideoRectangle_484E proc
0800:484E 55              	push	bp
0800:484F 8B EC           	mov	bp,sp
0800:4851 57              	push	di
0800:4852 56              	push	si
0800:4853 1E              	push	ds
0800:4854 B8 84 41        	mov	ax,4184h
0800:4857 8E D8           	mov	ds,ax
0800:4859 06              	push	es
0800:485A 8B 7E 06        	mov	di,[bp+6h]
0800:485D 83 FF 00        	cmp	di,0h
0800:4860 7C 0C           	jl	486Eh

l0800_4862:
0800:4862 81 FF 40 01     	cmp	di,140h
0800:4866 7C 09           	jl	4871h

l0800_4868:
0800:4868 BF 3F 01        	mov	di,13Fh
0800:486B EB 04           	jmp	4871h
0800:486D                                        90                    .  

l0800_486E:
0800:486E BF 00 00        	mov	di,0h

l0800_4871:
0800:4871 8B 56 08        	mov	dx,[bp+8h]
0800:4874 83 FA 00        	cmp	dx,0h
0800:4877 7C 0C           	jl	4885h

l0800_4879:
0800:4879 81 FA C8 00     	cmp	dx,0C8h
0800:487D 7C 09           	jl	4888h

l0800_487F:
0800:487F BA C7 00        	mov	dx,0C7h
0800:4882 EB 04           	jmp	4888h
0800:4884             90                                      .           

l0800_4885:
0800:4885 BA 00 00        	mov	dx,0h

l0800_4888:
0800:4888 8B 46 0A        	mov	ax,[bp+0Ah]
0800:488B 3D 00 00        	cmp	ax,0h
0800:488E 7C 0B           	jl	489Bh

l0800_4890:
0800:4890 3D 40 01        	cmp	ax,140h
0800:4893 7C 09           	jl	489Eh

l0800_4895:
0800:4895 B8 3F 01        	mov	ax,13Fh
0800:4898 EB 04           	jmp	489Eh
0800:489A                               90                          .     

l0800_489B:
0800:489B B8 00 00        	mov	ax,0h

l0800_489E:
0800:489E 3B C7           	cmp	ax,di
0800:48A0 7D 01           	jge	48A3h

l0800_48A2:
0800:48A2 97              	xchg	di,ax

l0800_48A3:
0800:48A3 8B DF           	mov	bx,di
0800:48A5 80 E3 07        	and	bl,7h
0800:48A8 2E 88 1E 2A 3C  	mov	cs:[3C2Ah],bl
0800:48AD 8A F8           	mov	bh,al
0800:48AF 80 E7 07        	and	bh,7h
0800:48B2 2B C7           	sub	ax,di
0800:48B4 40              	inc	ax
0800:48B5 8B C8           	mov	cx,ax
0800:48B7 3D 08 00        	cmp	ax,8h
0800:48BA 7E 0A           	jle	48C6h

l0800_48BC:
0800:48BC 32 ED           	xor	ch,ch
0800:48BE B1 08           	mov	cl,8h
0800:48C0 2A CB           	sub	cl,bl
0800:48C2 02 CF           	add	cl,bh
0800:48C4 FE C1           	inc	cl

l0800_48C6:
0800:48C6 2E 89 0E DE 3B  	mov	cs:[3BDEh],cx
0800:48CB 2B C1           	sub	ax,cx
0800:48CD D1 E8           	shr	ax,1h
0800:48CF D1 E8           	shr	ax,1h
0800:48D1 D1 E8           	shr	ax,1h
0800:48D3 2E A2 E0 3B     	mov	cs:[3BE0h],al
0800:48D7 8B 46 0C        	mov	ax,[bp+0Ch]
0800:48DA 3D 00 00        	cmp	ax,0h
0800:48DD 7C 0B           	jl	48EAh

l0800_48DF:
0800:48DF 3D C8 00        	cmp	ax,0C8h
0800:48E2 7C 09           	jl	48EDh

l0800_48E4:
0800:48E4 B8 C7 00        	mov	ax,0C7h
0800:48E7 EB 04           	jmp	48EDh
0800:48E9                            90                            .      

l0800_48EA:
0800:48EA B8 00 00        	mov	ax,0h

l0800_48ED:
0800:48ED 3B C2           	cmp	ax,dx
0800:48EF 7D 01           	jge	48F2h

l0800_48F1:
0800:48F1 92              	xchg	dx,ax

l0800_48F2:
0800:48F2 2E 88 16 E3 3B  	mov	cs:[3BE3h],dl
0800:48F7 2B C2           	sub	ax,dx
0800:48F9 40              	inc	ax
0800:48FA 2E A2 E1 3B     	mov	cs:[3BE1h],al
0800:48FE 8B 46 0E        	mov	ax,[bp+0Eh]
0800:4901 2E A2 E4 3B     	mov	cs:[3BE4h],al
0800:4905 2E 8B 0E DE 3B  	mov	cx,cs:[3BDEh]
0800:490A 49              	dec	cx
0800:490B 8B E9           	mov	bp,cx
0800:490D 80 C1 07        	add	cl,7h
0800:4910 D0 E9           	shr	cl,1h
0800:4912 D0 E9           	shr	cl,1h
0800:4914 D0 E9           	shr	cl,1h
0800:4916 D1 E5           	shl	bp,1h
0800:4918 2E 8B AE 2F 3C  	mov	bp,cs:[bp+3C2Fh]
0800:491D B8 84 41        	mov	ax,4184h
0800:4920 8E D8           	mov	ds,ax
0800:4922 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:4927 74 21           	jz	494Ah

l0800_4929:
0800:4929 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:492E 75 03           	jnz	4933h

l0800_4930:
0800:4930 E9 30 01        	jmp	4A63h

l0800_4933:
0800:4933 83 3E 4C 0E 02  	cmp	word ptr [0E4Ch],2h
0800:4938 75 03           	jnz	493Dh

l0800_493A:
0800:493A E9 97 02        	jmp	4BD4h

l0800_493D:
0800:493D 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:4942 75 03           	jnz	4947h

l0800_4944:
0800:4944 E9 54 03        	jmp	4C9Bh

l0800_4947:
0800:4947 E9 F6 03        	jmp	4D40h

l0800_494A:
0800:494A 57              	push	di
0800:494B 2E A0 E4 3B     	mov	al,cs:[3BE4h]
0800:494F 25 0F 00        	and	ax,0Fh
0800:4952 8B F8           	mov	di,ax
0800:4954 2E 8A 85 E6 3B  	mov	al,cs:[di+3BE6h]
0800:4959 25 03 00        	and	ax,3h
0800:495C 8B F8           	mov	di,ax
0800:495E D1 E7           	shl	di,1h
0800:4960 2E 8B 85 F6 3B  	mov	ax,cs:[di+3BF6h]
0800:4965 2E A3 1E 3C     	mov	cs:[3C1Eh],ax
0800:4969 5F              	pop	di
0800:496A D1 EF           	shr	di,1h
0800:496C D1 EF           	shr	di,1h
0800:496E 32 E4           	xor	ah,ah
0800:4970 2E A0 2A 3C     	mov	al,cs:[3C2Ah]
0800:4974 24 03           	and	al,3h
0800:4976 D1 E0           	shl	ax,1h
0800:4978 03 E8           	add	bp,ax
0800:497A 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:497E 2E 8A 46 00     	mov	al,cs:[bp+0h]
0800:4982 2E A2 2A 3C     	mov	cs:[3C2Ah],al
0800:4986 B0 00           	mov	al,0h
0800:4988 0A C9           	or	cl,cl
0800:498A 74 05           	jz	4991h

l0800_498C:
0800:498C 45              	inc	bp
0800:498D 2E 8A 46 00     	mov	al,cs:[bp+0h]

l0800_4991:
0800:4991 2E A2 2B 3C     	mov	cs:[3C2Bh],al
0800:4995 8B C2           	mov	ax,dx
0800:4997 25 FE 03        	and	ax,3FEh
0800:499A BA 28 00        	mov	dx,28h
0800:499D F7 E2           	mul	dx
0800:499F 2E 80 26 E3 3B 01 	and	byte ptr cs:[3BE3h],1h
0800:49A5 74 03           	jz	49AAh

l0800_49A7:
0800:49A7 05 00 20        	add	ax,2000h

l0800_49AA:
0800:49AA 03 F8           	add	di,ax
0800:49AC 32 E4           	xor	ah,ah
0800:49AE 2E A0 E0 3B     	mov	al,cs:[3BE0h]
0800:49B2 40              	inc	ax
0800:49B3 2E 80 3E 2B 3C 00 	cmp	byte ptr cs:[3C2Bh],0h
0800:49B9 74 01           	jz	49BCh

l0800_49BB:
0800:49BB 40              	inc	ax

l0800_49BC:
0800:49BC D1 E0           	shl	ax,1h
0800:49BE 8B D8           	mov	bx,ax
0800:49C0 B8 00 20        	mov	ax,2000h
0800:49C3 2B C3           	sub	ax,bx
0800:49C5 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:49C9 8B C3           	mov	ax,bx
0800:49CB 2D 50 00        	sub	ax,50h
0800:49CE 05 00 20        	add	ax,2000h
0800:49D1 2E A3 D8 3B     	mov	cs:[3BD8h],ax
0800:49D5 B8 84 41        	mov	ax,4184h
0800:49D8 8E D8           	mov	ds,ax
0800:49DA 03 3E 9B 0B     	add	di,[0B9Bh]
0800:49DE A1 9D 0B        	mov	ax,[0B9Dh]
0800:49E1 8E C0           	mov	es,ax
0800:49E3 2E 8A 2E E0 3B  	mov	ch,cs:[3BE0h]

l0800_49E8:
0800:49E8 32 FF           	xor	bh,bh
0800:49EA 2E 8A 1E 2A 3C  	mov	bl,cs:[3C2Ah]
0800:49EF D1 E3           	shl	bx,1h
0800:49F1 26 8B 05        	mov	ax,es:[di]
0800:49F4 2E 8B 16 1E 3C  	mov	dx,cs:[3C1Eh]
0800:49F9 2E 23 97 07 40  	and	dx,cs:[bx+4007h]
0800:49FE 33 C2           	xor	ax,dx
0800:4A00 26 89 05        	mov	es:[di],ax
0800:4A03 83 C7 02        	add	di,2h
0800:4A06 0A ED           	or	ch,ch
0800:4A08 74 11           	jz	4A1Bh

l0800_4A0A:
0800:4A0A 2E 8B 1E 1E 3C  	mov	bx,cs:[3C1Eh]
0800:4A0F 8A CD           	mov	cl,ch

l0800_4A11:
0800:4A11 26 31 1D        	xor	es:[di],bx
0800:4A14 83 C7 02        	add	di,2h
0800:4A17 FE C9           	dec	cl
0800:4A19 75 F6           	jnz	4A11h

l0800_4A1B:
0800:4A1B 2E 8A 1E 2B 3C  	mov	bl,cs:[3C2Bh]
0800:4A20 0A DB           	or	bl,bl
0800:4A22 74 19           	jz	4A3Dh

l0800_4A24:
0800:4A24 32 FF           	xor	bh,bh
0800:4A26 D1 E3           	shl	bx,1h
0800:4A28 26 8B 05        	mov	ax,es:[di]
0800:4A2B 2E 8B 16 1E 3C  	mov	dx,cs:[3C1Eh]
0800:4A30 2E 23 97 07 40  	and	dx,cs:[bx+4007h]
0800:4A35 33 C2           	xor	ax,dx
0800:4A37 26 89 05        	mov	es:[di],ax
0800:4A3A 83 C7 02        	add	di,2h

l0800_4A3D:
0800:4A3D 2E 80 36 E3 3B 01 	xor	byte ptr cs:[3BE3h],1h
0800:4A43 74 0F           	jz	4A54h

l0800_4A45:
0800:4A45 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:4A4A 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4A4F 75 97           	jnz	49E8h

l0800_4A51:
0800:4A51 E9 EC 02        	jmp	4D40h

l0800_4A54:
0800:4A54 2E 2B 3E D8 3B  	sub	di,cs:[3BD8h]
0800:4A59 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4A5E 75 88           	jnz	49E8h

l0800_4A60:
0800:4A60 E9 DD 02        	jmp	4D40h

l0800_4A63:
0800:4A63 57              	push	di
0800:4A64 2E A0 E4 3B     	mov	al,cs:[3BE4h]
0800:4A68 25 0F 00        	and	ax,0Fh
0800:4A6B 8B F8           	mov	di,ax
0800:4A6D D1 E7           	shl	di,1h
0800:4A6F 2E 8B 85 FE 3B  	mov	ax,cs:[di+3BFEh]
0800:4A74 2E A3 1E 3C     	mov	cs:[3C1Eh],ax
0800:4A78 5F              	pop	di
0800:4A79 D1 EF           	shr	di,1h
0800:4A7B 32 E4           	xor	ah,ah
0800:4A7D 2E A0 2A 3C     	mov	al,cs:[3C2Ah]
0800:4A81 24 01           	and	al,1h
0800:4A83 D1 E0           	shl	ax,1h
0800:4A85 03 E8           	add	bp,ax
0800:4A87 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:4A8B 2E 8A 46 00     	mov	al,cs:[bp+0h]
0800:4A8F 2E A2 2A 3C     	mov	cs:[3C2Ah],al
0800:4A93 B0 00           	mov	al,0h
0800:4A95 0A C9           	or	cl,cl
0800:4A97 74 05           	jz	4A9Eh

l0800_4A99:
0800:4A99 45              	inc	bp
0800:4A9A 2E 8A 46 00     	mov	al,cs:[bp+0h]

l0800_4A9E:
0800:4A9E 2E A2 2B 3C     	mov	cs:[3C2Bh],al
0800:4AA2 8B C2           	mov	ax,dx
0800:4AA4 25 FC 03        	and	ax,3FCh
0800:4AA7 BA 28 00        	mov	dx,28h
0800:4AAA F7 E2           	mul	dx
0800:4AAC 2E 80 26 E3 3B 03 	and	byte ptr cs:[3BE3h],3h
0800:4AB2 74 0C           	jz	4AC0h

l0800_4AB4:
0800:4AB4 32 ED           	xor	ch,ch
0800:4AB6 2E 8A 0E E3 3B  	mov	cl,cs:[3BE3h]

l0800_4ABB:
0800:4ABB 05 00 20        	add	ax,2000h
0800:4ABE E2 FB           	loop	4ABBh

l0800_4AC0:
0800:4AC0 03 F8           	add	di,ax
0800:4AC2 32 E4           	xor	ah,ah
0800:4AC4 2E A0 E0 3B     	mov	al,cs:[3BE0h]
0800:4AC8 40              	inc	ax
0800:4AC9 2E 80 3E 2B 3C 00 	cmp	byte ptr cs:[3C2Bh],0h
0800:4ACF 74 01           	jz	4AD2h

l0800_4AD1:
0800:4AD1 40              	inc	ax

l0800_4AD2:
0800:4AD2 D1 E0           	shl	ax,1h
0800:4AD4 D1 E0           	shl	ax,1h
0800:4AD6 8B D8           	mov	bx,ax
0800:4AD8 B8 00 20        	mov	ax,2000h
0800:4ADB 2B C3           	sub	ax,bx
0800:4ADD 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:4AE1 8B C3           	mov	ax,bx
0800:4AE3 2D A0 00        	sub	ax,0A0h
0800:4AE6 05 00 60        	add	ax,6000h
0800:4AE9 2E A3 D8 3B     	mov	cs:[3BD8h],ax
0800:4AED B8 84 41        	mov	ax,4184h
0800:4AF0 8E D8           	mov	ds,ax
0800:4AF2 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4AF6 A1 9D 0B        	mov	ax,[0B9Dh]
0800:4AF9 8E C0           	mov	es,ax
0800:4AFB 2E 8A 2E E0 3B  	mov	ch,cs:[3BE0h]
0800:4B00 D0 E5           	shl	ch,1h

l0800_4B02:
0800:4B02 32 E4           	xor	ah,ah
0800:4B04 2E A0 2A 3C     	mov	al,cs:[3C2Ah]
0800:4B08 8A C8           	mov	cl,al
0800:4B0A 8B D8           	mov	bx,ax
0800:4B0C D0 EB           	shr	bl,1h
0800:4B0E D0 EB           	shr	bl,1h
0800:4B10 D0 EB           	shr	bl,1h
0800:4B12 D0 EB           	shr	bl,1h
0800:4B14 D1 E3           	shl	bx,1h
0800:4B16 26 8B 05        	mov	ax,es:[di]
0800:4B19 2E 8B 16 1E 3C  	mov	dx,cs:[3C1Eh]
0800:4B1E 2E 23 97 07 42  	and	dx,cs:[bx+4207h]
0800:4B23 33 C2           	xor	ax,dx
0800:4B25 26 89 05        	mov	es:[di],ax
0800:4B28 83 C7 02        	add	di,2h
0800:4B2B 8A D9           	mov	bl,cl
0800:4B2D 83 E3 0F        	and	bx,0Fh
0800:4B30 D1 E3           	shl	bx,1h
0800:4B32 26 8B 05        	mov	ax,es:[di]
0800:4B35 2E 8B 16 1E 3C  	mov	dx,cs:[3C1Eh]
0800:4B3A 2E 23 97 07 42  	and	dx,cs:[bx+4207h]
0800:4B3F 33 C2           	xor	ax,dx
0800:4B41 26 89 05        	mov	es:[di],ax
0800:4B44 83 C7 02        	add	di,2h
0800:4B47 0A ED           	or	ch,ch
0800:4B49 74 11           	jz	4B5Ch

l0800_4B4B:
0800:4B4B 2E 8B 1E 1E 3C  	mov	bx,cs:[3C1Eh]
0800:4B50 8A CD           	mov	cl,ch

l0800_4B52:
0800:4B52 26 31 1D        	xor	es:[di],bx
0800:4B55 83 C7 02        	add	di,2h
0800:4B58 FE C9           	dec	cl
0800:4B5A 75 F6           	jnz	4B52h

l0800_4B5C:
0800:4B5C 2E A0 2B 3C     	mov	al,cs:[3C2Bh]
0800:4B60 0A C0           	or	al,al
0800:4B62 74 41           	jz	4BA5h

l0800_4B64:
0800:4B64 32 E4           	xor	ah,ah
0800:4B66 8A C8           	mov	cl,al
0800:4B68 8B D8           	mov	bx,ax
0800:4B6A D0 EB           	shr	bl,1h
0800:4B6C D0 EB           	shr	bl,1h
0800:4B6E D0 EB           	shr	bl,1h
0800:4B70 D0 EB           	shr	bl,1h
0800:4B72 D1 E3           	shl	bx,1h
0800:4B74 26 8B 05        	mov	ax,es:[di]
0800:4B77 2E 8B 16 1E 3C  	mov	dx,cs:[3C1Eh]
0800:4B7C 2E 23 97 07 42  	and	dx,cs:[bx+4207h]
0800:4B81 33 C2           	xor	ax,dx
0800:4B83 26 89 05        	mov	es:[di],ax
0800:4B86 83 C7 02        	add	di,2h
0800:4B89 8A D9           	mov	bl,cl
0800:4B8B 83 E3 0F        	and	bx,0Fh
0800:4B8E D1 E3           	shl	bx,1h
0800:4B90 26 8B 05        	mov	ax,es:[di]
0800:4B93 2E 8B 16 1E 3C  	mov	dx,cs:[3C1Eh]
0800:4B98 2E 23 97 07 42  	and	dx,cs:[bx+4207h]
0800:4B9D 33 C2           	xor	ax,dx
0800:4B9F 26 89 05        	mov	es:[di],ax
0800:4BA2 83 C7 02        	add	di,2h

l0800_4BA5:
0800:4BA5 2E A0 E3 3B     	mov	al,cs:[3BE3h]
0800:4BA9 FE C0           	inc	al
0800:4BAB 24 03           	and	al,3h
0800:4BAD 2E A2 E3 3B     	mov	cs:[3BE3h],al
0800:4BB1 74 0F           	jz	4BC2h

l0800_4BB3:
0800:4BB3 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:4BB8 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4BBD 74 12           	jz	4BD1h

l0800_4BBF:
0800:4BBF E9 40 FF        	jmp	4B02h

l0800_4BC2:
0800:4BC2 2E 2B 3E D8 3B  	sub	di,cs:[3BD8h]
0800:4BC7 2E FE 0E E1 3B  	dec	byte ptr cs:[3BE1h]
0800:4BCC 74 03           	jz	4BD1h

l0800_4BCE:
0800:4BCE E9 31 FF        	jmp	4B02h

l0800_4BD1:
0800:4BD1 E9 6C 01        	jmp	4D40h

l0800_4BD4:
0800:4BD4 D1 EF           	shr	di,1h
0800:4BD6 D1 EF           	shr	di,1h
0800:4BD8 D1 EF           	shr	di,1h
0800:4BDA 32 E4           	xor	ah,ah
0800:4BDC 2E A0 2A 3C     	mov	al,cs:[3C2Ah]
0800:4BE0 D1 E0           	shl	ax,1h
0800:4BE2 03 E8           	add	bp,ax
0800:4BE4 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:4BE8 2E 8A 46 00     	mov	al,cs:[bp+0h]
0800:4BEC 2E A2 2A 3C     	mov	cs:[3C2Ah],al
0800:4BF0 B0 00           	mov	al,0h
0800:4BF2 0A C9           	or	cl,cl
0800:4BF4 74 05           	jz	4BFBh

l0800_4BF6:
0800:4BF6 45              	inc	bp
0800:4BF7 2E 8A 46 00     	mov	al,cs:[bp+0h]

l0800_4BFB:
0800:4BFB 2E A2 2B 3C     	mov	cs:[3C2Bh],al
0800:4BFF 8B C2           	mov	ax,dx
0800:4C01 BA 28 00        	mov	dx,28h
0800:4C04 F7 E2           	mul	dx
0800:4C06 03 F8           	add	di,ax
0800:4C08 32 E4           	xor	ah,ah
0800:4C0A B0 27           	mov	al,27h
0800:4C0C 2E 2A 06 E0 3B  	sub	al,cs:[3BE0h]
0800:4C11 2E 80 3E 2B 3C 00 	cmp	byte ptr cs:[3C2Bh],0h
0800:4C17 74 02           	jz	4C1Bh

l0800_4C19:
0800:4C19 FE C8           	dec	al

l0800_4C1B:
0800:4C1B 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:4C1F B8 84 41        	mov	ax,4184h
0800:4C22 8E D8           	mov	ds,ax
0800:4C24 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4C28 A1 9D 0B        	mov	ax,[0B9Dh]
0800:4C2B 8E C0           	mov	es,ax
0800:4C2D FA              	cli
0800:4C2E BA CE 03        	mov	dx,3CEh
0800:4C31 B8 05 02        	mov	ax,205h
0800:4C34 EE              	out	dx,al
0800:4C35 42              	inc	dx
0800:4C36 8A C4           	mov	al,ah
0800:4C38 EE              	out	dx,al
0800:4C39 4A              	dec	dx
0800:4C3A B8 03 18        	mov	ax,1803h
0800:4C3D EE              	out	dx,al
0800:4C3E 42              	inc	dx
0800:4C3F 8A C4           	mov	al,ah
0800:4C41 EE              	out	dx,al
0800:4C42 4A              	dec	dx
0800:4C43 B0 08           	mov	al,8h
0800:4C45 EE              	out	dx,al
0800:4C46 42              	inc	dx
0800:4C47 2E 8A 2E E0 3B  	mov	ch,cs:[3BE0h]
0800:4C4C 2E 8A 3E E1 3B  	mov	bh,cs:[3BE1h]
0800:4C51 2E 8A 1E E4 3B  	mov	bl,cs:[3BE4h]

l0800_4C56:
0800:4C56 2E A0 2A 3C     	mov	al,cs:[3C2Ah]
0800:4C5A EE              	out	dx,al
0800:4C5B 8A C3           	mov	al,bl
0800:4C5D 26 86 05        	xchg	es:[di],al
0800:4C60 47              	inc	di
0800:4C61 0A ED           	or	ch,ch
0800:4C63 74 0F           	jz	4C74h

l0800_4C65:
0800:4C65 B0 FF           	mov	al,0FFh
0800:4C67 EE              	out	dx,al
0800:4C68 8A CD           	mov	cl,ch

l0800_4C6A:
0800:4C6A 8A C3           	mov	al,bl
0800:4C6C 26 86 05        	xchg	es:[di],al
0800:4C6F 47              	inc	di
0800:4C70 FE C9           	dec	cl
0800:4C72 75 F6           	jnz	4C6Ah

l0800_4C74:
0800:4C74 2E A0 2B 3C     	mov	al,cs:[3C2Bh]
0800:4C78 0A C0           	or	al,al
0800:4C7A 74 07           	jz	4C83h

l0800_4C7C:
0800:4C7C EE              	out	dx,al
0800:4C7D 8A C3           	mov	al,bl
0800:4C7F 26 86 05        	xchg	es:[di],al
0800:4C82 47              	inc	di

l0800_4C83:
0800:4C83 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:4C88 FE CF           	dec	bh
0800:4C8A 75 CA           	jnz	4C56h

l0800_4C8C:
0800:4C8C BA CE 03        	mov	dx,3CEh
0800:4C8F B8 03 00        	mov	ax,3h
0800:4C92 EE              	out	dx,al
0800:4C93 42              	inc	dx
0800:4C94 8A C4           	mov	al,ah
0800:4C96 EE              	out	dx,al
0800:4C97 FB              	sti
0800:4C98 E9 A5 00        	jmp	4D40h

l0800_4C9B:
0800:4C9B 2E 8B 6E 00     	mov	bp,cs:[bp+0h]
0800:4C9F 2E 8A 46 00     	mov	al,cs:[bp+0h]
0800:4CA3 2E A2 2A 3C     	mov	cs:[3C2Ah],al
0800:4CA7 B0 00           	mov	al,0h
0800:4CA9 0A C9           	or	cl,cl
0800:4CAB 74 05           	jz	4CB2h

l0800_4CAD:
0800:4CAD 45              	inc	bp
0800:4CAE 2E 8A 46 00     	mov	al,cs:[bp+0h]

l0800_4CB2:
0800:4CB2 2E A2 2B 3C     	mov	cs:[3C2Bh],al
0800:4CB6 8B C2           	mov	ax,dx
0800:4CB8 BA 40 01        	mov	dx,140h
0800:4CBB F7 E2           	mul	dx
0800:4CBD 03 F8           	add	di,ax
0800:4CBF B8 40 01        	mov	ax,140h
0800:4CC2 2E 2B 06 DE 3B  	sub	ax,cs:[3BDEh]
0800:4CC7 32 F6           	xor	dh,dh
0800:4CC9 2E 8A 16 E0 3B  	mov	dl,cs:[3BE0h]
0800:4CCE D1 E2           	shl	dx,1h
0800:4CD0 D1 E2           	shl	dx,1h
0800:4CD2 D1 E2           	shl	dx,1h
0800:4CD4 2B C2           	sub	ax,dx
0800:4CD6 2E A3 D6 3B     	mov	cs:[3BD6h],ax
0800:4CDA B8 84 41        	mov	ax,4184h
0800:4CDD 8E D8           	mov	ds,ax
0800:4CDF 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4CE3 A1 9D 0B        	mov	ax,[0B9Dh]
0800:4CE6 8E C0           	mov	es,ax
0800:4CE8 2E 8A 2E E0 3B  	mov	ch,cs:[3BE0h]
0800:4CED 2E 8A 3E E1 3B  	mov	bh,cs:[3BE1h]
0800:4CF2 2E 8A 1E E4 3B  	mov	bl,cs:[3BE4h]
0800:4CF7 B2 80           	mov	dl,80h

l0800_4CF9:
0800:4CF9 2E A0 2A 3C     	mov	al,cs:[3C2Ah]
0800:4CFD 8A CA           	mov	cl,dl

l0800_4CFF:
0800:4CFF 84 C1           	test	cl,al
0800:4D01 74 08           	jz	4D0Bh

l0800_4D03:
0800:4D03 26 30 1D        	xor	es:[di],bl
0800:4D06 47              	inc	di
0800:4D07 D0 E9           	shr	cl,1h
0800:4D09 75 F4           	jnz	4CFFh

l0800_4D0B:
0800:4D0B 0A ED           	or	ch,ch
0800:4D0D 74 12           	jz	4D21h

l0800_4D0F:
0800:4D0F B0 FF           	mov	al,0FFh
0800:4D11 8A F5           	mov	dh,ch

l0800_4D13:
0800:4D13 8A CA           	mov	cl,dl

l0800_4D15:
0800:4D15 26 30 1D        	xor	es:[di],bl
0800:4D18 47              	inc	di
0800:4D19 D0 E9           	shr	cl,1h
0800:4D1B 75 F8           	jnz	4D15h

l0800_4D1D:
0800:4D1D FE CE           	dec	dh
0800:4D1F 75 F2           	jnz	4D13h

l0800_4D21:
0800:4D21 2E A0 2B 3C     	mov	al,cs:[3C2Bh]
0800:4D25 0A C0           	or	al,al
0800:4D27 74 0E           	jz	4D37h

l0800_4D29:
0800:4D29 8A CA           	mov	cl,dl

l0800_4D2B:
0800:4D2B 84 C1           	test	cl,al
0800:4D2D 74 08           	jz	4D37h

l0800_4D2F:
0800:4D2F 26 30 1D        	xor	es:[di],bl
0800:4D32 47              	inc	di
0800:4D33 D0 E9           	shr	cl,1h
0800:4D35 75 F4           	jnz	4D2Bh

l0800_4D37:
0800:4D37 2E 03 3E D6 3B  	add	di,cs:[3BD6h]
0800:4D3C FE CF           	dec	bh
0800:4D3E 75 B9           	jnz	4CF9h

l0800_4D40:
0800:4D40 07              	pop	es
0800:4D41 1F              	pop	ds
0800:4D42 5E              	pop	si
0800:4D43 5F              	pop	di
0800:4D44 5D              	pop	bp
0800:4D45 CB              	retf
0800:4D46                   55 8B EC 57 56 1E B8 84 41 8E       U..WV...A.
0800:4D50 D8 06 B8 84 41 8E C0 BE 48 0E 32 E4 26 8A 04 D0 ....A...H.2.&...
0800:4D60 E8 D0 E8 26 D0 54 02 26 D0 54 01 F5 26 1A 04 D0 ...&.T.&.T..&...
0800:4D70 E8 26 D0 1C 26 8A 04 26 32 44 01 07 1F 5E 5F 5D .&..&..&2D...^_]
0800:4D80 CB                                              .               

;; DOS_SelectDefaultDrive: 0800:4D81
;;   Called from:
;;     3593:0015 (in SelectResourceDrive_0008)
;;     3593:002C (in SelectResourceDrive_0008)
DOS_SelectDefaultDrive proc
0800:4D81 55              	push	bp
0800:4D82 8B EC           	mov	bp,sp
0800:4D84 57              	push	di
0800:4D85 56              	push	si
0800:4D86 1E              	push	ds
0800:4D87 B8 84 41        	mov	ax,4184h
0800:4D8A 8E D8           	mov	ds,ax
0800:4D8C 8B 56 06        	mov	dx,[bp+6h]
0800:4D8F B4 0E           	mov	ah,0Eh
0800:4D91 CD 21           	int	21h
0800:4D93 1F              	pop	ds
0800:4D94 5E              	pop	si
0800:4D95 5F              	pop	di
0800:4D96 5D              	pop	bp
0800:4D97 CB              	retf

;; BIOS_SelectCgaPalette: 0800:4D98
;;   Called from:
;;     2C7F:0284 (in InitializeGame_003C)
BIOS_SelectCgaPalette proc
0800:4D98 55              	push	bp
0800:4D99 8B EC           	mov	bp,sp
0800:4D9B 57              	push	di
0800:4D9C 56              	push	si
0800:4D9D 1E              	push	ds
0800:4D9E B8 84 41        	mov	ax,4184h
0800:4DA1 8E D8           	mov	ds,ax
0800:4DA3 8B 5E 06        	mov	bx,[bp+6h]
0800:4DA6 B7 01           	mov	bh,1h
0800:4DA8 B4 0B           	mov	ah,0Bh
0800:4DAA CD 10           	int	10h
0800:4DAC 1F              	pop	ds
0800:4DAD 5E              	pop	si
0800:4DAE 5F              	pop	di
0800:4DAF 5D              	pop	bp
0800:4DB0 CB              	retf

;; EGA_SetPaletteRegister_4DB1: 0800:4DB1
;;   Called from:
;;     2B2D:0050 (in LoadVideoPalette_0004)
EGA_SetPaletteRegister_4DB1 proc
0800:4DB1 55              	push	bp
0800:4DB2 8B EC           	mov	bp,sp
0800:4DB4 57              	push	di
0800:4DB5 56              	push	si
0800:4DB6 1E              	push	ds
0800:4DB7 B8 84 41        	mov	ax,4184h
0800:4DBA 8E D8           	mov	ds,ax
0800:4DBC 8B 5E 06        	mov	bx,[bp+6h]
0800:4DBF 8B 4E 08        	mov	cx,[bp+8h]
0800:4DC2 B8 40 00        	mov	ax,40h
0800:4DC5 8E C0           	mov	es,ax
0800:4DC7 26 8B 16 63 00  	mov	dx,es:[0063h]
0800:4DCC 80 C2 06        	add	dl,6h
0800:4DCF 52              	push	dx
0800:4DD0 FA              	cli
0800:4DD1 EC              	in	al,dx
0800:4DD2 B2 C0           	mov	dl,0C0h
0800:4DD4 8A C3           	mov	al,bl
0800:4DD6 EE              	out	dx,al
0800:4DD7 8A C1           	mov	al,cl
0800:4DD9 EE              	out	dx,al
0800:4DDA 5A              	pop	dx
0800:4DDB EC              	in	al,dx
0800:4DDC B2 C0           	mov	dl,0C0h
0800:4DDE B0 20           	mov	al,20h
0800:4DE0 EE              	out	dx,al
0800:4DE1 FB              	sti
0800:4DE2 1F              	pop	ds
0800:4DE3 5E              	pop	si
0800:4DE4 5F              	pop	di
0800:4DE5 5D              	pop	bp
0800:4DE6 CB              	retf

;; SetVideoAdapterType_4DE7: 0800:4DE7
;;   Called from:
;;     2C7F:035D (in SetVideoModeForAdapter_0350)
;;     34DF:0031 (in LoadPackedIconPageDirect_0003)
;;     34DF:0058 (in LoadPackedIconPageDirect_0003)
SetVideoAdapterType_4DE7 proc
0800:4DE7 55              	push	bp
0800:4DE8 8B EC           	mov	bp,sp
0800:4DEA 57              	push	di
0800:4DEB 56              	push	si
0800:4DEC 1E              	push	ds
0800:4DED B8 84 41        	mov	ax,4184h
0800:4DF0 8E D8           	mov	ds,ax
0800:4DF2 8B 46 06        	mov	ax,[bp+6h]
0800:4DF5 A3 4C 0E        	mov	[0E4Ch],ax
0800:4DF8 1F              	pop	ds
0800:4DF9 5E              	pop	si
0800:4DFA 5F              	pop	di
0800:4DFB 5D              	pop	bp
0800:4DFC CB              	retf

;; ReadEGAPlanarTile_4DFD: 0800:4DFD
;;   Called from:
;;     3495:011A (in Capture8x8VideoTile_000B)
ReadEGAPlanarTile_4DFD proc
0800:4DFD 55              	push	bp
0800:4DFE 8B EC           	mov	bp,sp
0800:4E00 57              	push	di
0800:4E01 56              	push	si
0800:4E02 1E              	push	ds
0800:4E03 B8 84 41        	mov	ax,4184h
0800:4E06 8E D8           	mov	ds,ax
0800:4E08 06              	push	es
0800:4E09 FA              	cli
0800:4E0A BA CE 03        	mov	dx,3CEh
0800:4E0D B8 05 02        	mov	ax,205h
0800:4E10 EE              	out	dx,al
0800:4E11 42              	inc	dx
0800:4E12 8A C4           	mov	al,ah
0800:4E14 EE              	out	dx,al
0800:4E15 4A              	dec	dx
0800:4E16 B8 08 00        	mov	ax,8h
0800:4E19 EE              	out	dx,al
0800:4E1A 42              	inc	dx
0800:4E1B 8A C4           	mov	al,ah
0800:4E1D EE              	out	dx,al
0800:4E1E 4A              	dec	dx
0800:4E1F 8B 7E 06        	mov	di,[bp+6h]
0800:4E22 8B 46 08        	mov	ax,[bp+8h]
0800:4E25 8E C0           	mov	es,ax
0800:4E27 8B 76 0A        	mov	si,[bp+0Ah]
0800:4E2A 8B 46 0C        	mov	ax,[bp+0Ch]
0800:4E2D BA 40 01        	mov	dx,140h
0800:4E30 F7 E2           	mul	dx
0800:4E32 03 F0           	add	si,ax
0800:4E34 B8 00 A2        	mov	ax,0A200h
0800:4E37 8E D8           	mov	ds,ax
0800:4E39 B9 08 00        	mov	cx,8h
0800:4E3C BA CE 03        	mov	dx,3CEh
0800:4E3F B0 04           	mov	al,4h
0800:4E41 EE              	out	dx,al
0800:4E42 42              	inc	dx

l0800_4E43:
0800:4E43 33 C0           	xor	ax,ax
0800:4E45 EE              	out	dx,al
0800:4E46 8A 04           	mov	al,[si]
0800:4E48 AA              	stosb
0800:4E49 B8 01 00        	mov	ax,1h
0800:4E4C EE              	out	dx,al
0800:4E4D 8A 04           	mov	al,[si]
0800:4E4F AA              	stosb
0800:4E50 B8 02 00        	mov	ax,2h
0800:4E53 EE              	out	dx,al
0800:4E54 8A 04           	mov	al,[si]
0800:4E56 AA              	stosb
0800:4E57 B8 03 00        	mov	ax,3h
0800:4E5A EE              	out	dx,al
0800:4E5B 8A 04           	mov	al,[si]
0800:4E5D AA              	stosb
0800:4E5E 83 C6 28        	add	si,28h
0800:4E61 E2 E0           	loop	4E43h

l0800_4E63:
0800:4E63 FB              	sti
0800:4E64 07              	pop	es
0800:4E65 1F              	pop	ds
0800:4E66 5E              	pop	si
0800:4E67 5F              	pop	di
0800:4E68 5D              	pop	bp
0800:4E69 CB              	retf

;; Tandy_LoadPaletteRegisters_4E6A: 0800:4E6A
;;   Called from:
;;     2B2D:0025 (in LoadVideoPalette_0004)
Tandy_LoadPaletteRegisters_4E6A proc
0800:4E6A 55              	push	bp
0800:4E6B 8B EC           	mov	bp,sp
0800:4E6D 57              	push	di
0800:4E6E 56              	push	si
0800:4E6F 1E              	push	ds
0800:4E70 B8 84 41        	mov	ax,4184h
0800:4E73 8E D8           	mov	ds,ax
0800:4E75 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:4E7A 75 29           	jnz	4EA5h

l0800_4E7C:
0800:4E7C 8B 76 06        	mov	si,[bp+6h]
0800:4E7F 8B 46 08        	mov	ax,[bp+8h]
0800:4E82 06              	push	es
0800:4E83 8E C0           	mov	es,ax
0800:4E85 B9 10 00        	mov	cx,10h
0800:4E88 B3 10           	mov	bl,10h

l0800_4E8A:
0800:4E8A BA DA 03        	mov	dx,3DAh
0800:4E8D EC              	in	al,dx
0800:4E8E 8A C3           	mov	al,bl
0800:4E90 EE              	out	dx,al
0800:4E91 26 8A 04        	mov	al,es:[si]
0800:4E94 BA DE 03        	mov	dx,3DEh
0800:4E97 EE              	out	dx,al
0800:4E98 FE C3           	inc	bl
0800:4E9A 46              	inc	si
0800:4E9B E2 ED           	loop	4E8Ah

l0800_4E9D:
0800:4E9D BA DA 03        	mov	dx,3DAh
0800:4EA0 EC              	in	al,dx
0800:4EA1 B0 0F           	mov	al,0Fh
0800:4EA3 EE              	out	dx,al
0800:4EA4 07              	pop	es

l0800_4EA5:
0800:4EA5 1F              	pop	ds
0800:4EA6 5E              	pop	si
0800:4EA7 5F              	pop	di
0800:4EA8 5D              	pop	bp
0800:4EA9 CB              	retf

;; IsVerticalRetraceActive_4EAA: 0800:4EAA
;;   Called from:
;;     34B8:00B9 (in CalibrateVideoTiming_000A)
IsVerticalRetraceActive_4EAA proc
0800:4EAA 55              	push	bp
0800:4EAB 8B EC           	mov	bp,sp
0800:4EAD 57              	push	di
0800:4EAE 56              	push	si
0800:4EAF 1E              	push	ds
0800:4EB0 B8 84 41        	mov	ax,4184h
0800:4EB3 8E D8           	mov	ds,ax
0800:4EB5 BA DA 03        	mov	dx,3DAh
0800:4EB8 EC              	in	al,dx
0800:4EB9 24 08           	and	al,8h
0800:4EBB 32 E4           	xor	ah,ah
0800:4EBD 1F              	pop	ds
0800:4EBE 5E              	pop	si
0800:4EBF 5F              	pop	di
0800:4EC0 5D              	pop	bp
0800:4EC1 CB              	retf

;; WaitForVerticalRetraceEdge_4EC2: 0800:4EC2
;;   Called from:
;;     2B2D:000D (in LoadVideoPalette_0004)
;;     334A:0015 (in WaitVerticalRetraces_000C)
WaitForVerticalRetraceEdge_4EC2 proc
0800:4EC2 55              	push	bp
0800:4EC3 8B EC           	mov	bp,sp
0800:4EC5 57              	push	di
0800:4EC6 56              	push	si
0800:4EC7 1E              	push	ds
0800:4EC8 B8 84 41        	mov	ax,4184h
0800:4ECB 8E D8           	mov	ds,ax
0800:4ECD 8A 5E 06        	mov	bl,[bp+6h]
0800:4ED0 BA DA 03        	mov	dx,3DAh
0800:4ED3 80 FB 01        	cmp	bl,1h
0800:4ED6 74 0C           	jz	4EE4h

l0800_4ED8:
0800:4ED8 EC              	in	al,dx
0800:4ED9 A8 08           	test	al,8h
0800:4EDB 74 FB           	jz	4ED8h

l0800_4EDD:
0800:4EDD EC              	in	al,dx
0800:4EDE A8 08           	test	al,8h
0800:4EE0 75 FB           	jnz	4EDDh

l0800_4EE2:
0800:4EE2 74 0A           	jz	4EEEh

l0800_4EE4:
0800:4EE4 EC              	in	al,dx
0800:4EE5 A8 08           	test	al,8h
0800:4EE7 75 FB           	jnz	4EE4h

l0800_4EE9:
0800:4EE9 EC              	in	al,dx
0800:4EEA A8 08           	test	al,8h
0800:4EEC 74 FB           	jz	4EE9h

l0800_4EEE:
0800:4EEE 1F              	pop	ds
0800:4EEF 5E              	pop	si
0800:4EF0 5F              	pop	di
0800:4EF1 5D              	pop	bp
0800:4EF2 CB              	retf

;; DrawVerticalSpan_4EF3: 0800:4EF3
;;   Called from:
;;     3365:002D (in DrawHorizontalSpan_0007)
;;     3365:0093 (in DrawHorizontalSpan_0007)
;;     3365:0133 (in DrawClippedAxisAlignedLine_00A6)
DrawVerticalSpan_4EF3 proc
0800:4EF3 55              	push	bp
0800:4EF4 8B EC           	mov	bp,sp
0800:4EF6 57              	push	di
0800:4EF7 56              	push	si
0800:4EF8 1E              	push	ds
0800:4EF9 B8 84 41        	mov	ax,4184h
0800:4EFC 8E D8           	mov	ds,ax
0800:4EFE 06              	push	es
0800:4EFF A1 9D 0B        	mov	ax,[0B9Dh]
0800:4F02 8E C0           	mov	es,ax
0800:4F04 8B 7E 06        	mov	di,[bp+6h]
0800:4F07 8B 46 08        	mov	ax,[bp+8h]
0800:4F0A A3 50 0E        	mov	[0E50h],ax
0800:4F0D 8B 46 0A        	mov	ax,[bp+0Ah]
0800:4F10 A3 52 0E        	mov	[0E52h],ax
0800:4F13 8B 46 0C        	mov	ax,[bp+0Ch]
0800:4F16 A3 54 0E        	mov	[0E54h],ax
0800:4F19 83 3E 4C 0E 03  	cmp	word ptr [0E4Ch],3h
0800:4F1E 74 0A           	jz	4F2Ah

l0800_4F20:
0800:4F20 83 3E 4C 0E 00  	cmp	word ptr [0E4Ch],0h
0800:4F25 75 2C           	jnz	4F53h

l0800_4F27:
0800:4F27 E9 F2 00        	jmp	501Ch

l0800_4F2A:
0800:4F2A A1 50 0E        	mov	ax,[0E50h]
0800:4F2D BA 40 01        	mov	dx,140h
0800:4F30 F7 E2           	mul	dx
0800:4F32 03 F8           	add	di,ax
0800:4F34 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4F38 8B 0E 52 0E     	mov	cx,[0E52h]
0800:4F3C 2B 0E 50 0E     	sub	cx,[0E50h]
0800:4F40 41              	inc	cx
0800:4F41 A1 54 0E        	mov	ax,[0E54h]
0800:4F44 8C C3           	mov	bx,es
0800:4F46 8E DB           	mov	ds,bx

l0800_4F48:
0800:4F48 88 05           	mov	[di],al
0800:4F4A 81 C7 40 01     	add	di,140h
0800:4F4E E2 F8           	loop	4F48h

l0800_4F50:
0800:4F50 E9 C3 00        	jmp	5016h

l0800_4F53:
0800:4F53 83 3E 4C 0E 01  	cmp	word ptr [0E4Ch],1h
0800:4F58 74 4B           	jz	4FA5h

l0800_4F5A:
0800:4F5A FA              	cli
0800:4F5B BA CE 03        	mov	dx,3CEh
0800:4F5E B8 05 02        	mov	ax,205h
0800:4F61 EE              	out	dx,al
0800:4F62 42              	inc	dx
0800:4F63 8A C4           	mov	al,ah
0800:4F65 EE              	out	dx,al
0800:4F66 4A              	dec	dx
0800:4F67 8B CF           	mov	cx,di
0800:4F69 B8 08 80        	mov	ax,8008h
0800:4F6C 83 E1 07        	and	cx,7h
0800:4F6F 74 02           	jz	4F73h

l0800_4F71:
0800:4F71 D2 EC           	shr	ah,cl

l0800_4F73:
0800:4F73 EE              	out	dx,al
0800:4F74 42              	inc	dx
0800:4F75 8A C4           	mov	al,ah
0800:4F77 EE              	out	dx,al
0800:4F78 4A              	dec	dx
0800:4F79 8B 16 50 0E     	mov	dx,[0E50h]
0800:4F7D B8 28 00        	mov	ax,28h
0800:4F80 F6 E2           	mul	dl
0800:4F82 D1 EF           	shr	di,1h
0800:4F84 D1 EF           	shr	di,1h
0800:4F86 D1 EF           	shr	di,1h
0800:4F88 03 F8           	add	di,ax
0800:4F8A 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4F8E A1 54 0E        	mov	ax,[0E54h]

l0800_4F91:
0800:4F91 26 8A 25        	mov	ah,es:[di]
0800:4F94 26 88 05        	mov	es:[di],al
0800:4F97 83 C7 28        	add	di,28h
0800:4F9A 42              	inc	dx
0800:4F9B 3B 16 52 0E     	cmp	dx,[0E52h]
0800:4F9F 7E F0           	jle	4F91h

l0800_4FA1:
0800:4FA1 FB              	sti
0800:4FA2 EB 72           	jmp	5016h
0800:4FA4             90                                      .           

l0800_4FA5:
0800:4FA5 B9 04 00        	mov	cx,4h
0800:4FA8 D3 E0           	shl	ax,cl
0800:4FAA 0B 06 54 0E     	or	ax,[0E54h]
0800:4FAE BB 0F 00        	mov	bx,0Fh
0800:4FB1 F7 C7 01 00     	test	di,1h
0800:4FB5 75 05           	jnz	4FBCh

l0800_4FB7:
0800:4FB7 B9 04 00        	mov	cx,4h
0800:4FBA D3 E3           	shl	bx,cl

l0800_4FBC:
0800:4FBC 23 C3           	and	ax,bx
0800:4FBE A3 54 0E        	mov	[0E54h],ax
0800:4FC1 F6 D3           	not	bl
0800:4FC3 A1 50 0E        	mov	ax,[0E50h]
0800:4FC6 24 FC           	and	al,0FCh
0800:4FC8 BA 28 00        	mov	dx,28h
0800:4FCB F6 E2           	mul	dl
0800:4FCD 8B 0E 50 0E     	mov	cx,[0E50h]
0800:4FD1 83 E1 03        	and	cx,3h
0800:4FD4 74 05           	jz	4FDBh

l0800_4FD6:
0800:4FD6 80 C4 20        	add	ah,20h
0800:4FD9 E2 FB           	loop	4FD6h

l0800_4FDB:
0800:4FDB D1 EF           	shr	di,1h
0800:4FDD 03 F8           	add	di,ax
0800:4FDF 03 3E 9B 0B     	add	di,[0B9Bh]
0800:4FE3 8B 16 50 0E     	mov	dx,[0E50h]
0800:4FE7 8B 0E 52 0E     	mov	cx,[0E52h]
0800:4FEB 2B 0E 50 0E     	sub	cx,[0E50h]
0800:4FEF 41              	inc	cx
0800:4FF0 8A FA           	mov	bh,dl
0800:4FF2 8B 16 54 0E     	mov	dx,[0E54h]
0800:4FF6 06              	push	es
0800:4FF7 1F              	pop	ds

l0800_4FF8:
0800:4FF8 8A 05           	mov	al,[di]
0800:4FFA 22 C3           	and	al,bl
0800:4FFC 0B C2           	or	ax,dx
0800:4FFE 88 05           	mov	[di],al
0800:5000 FE C7           	inc	bh
0800:5002 80 E7 03        	and	bh,3h
0800:5005 74 09           	jz	5010h

l0800_5007:
0800:5007 81 C7 00 20     	add	di,2000h
0800:500B E2 EB           	loop	4FF8h

l0800_500D:
0800:500D EB 07           	jmp	5016h
0800:500F                                              90                .

l0800_5010:
0800:5010 81 EF 60 5F     	sub	di,5F60h
0800:5014 E2 E2           	loop	4FF8h

l0800_5016:
0800:5016 07              	pop	es
0800:5017 1F              	pop	ds
0800:5018 5E              	pop	si
0800:5019 5F              	pop	di
0800:501A 5D              	pop	bp
0800:501B CB              	retf

l0800_501C:
0800:501C 25 03 00        	and	ax,3h
0800:501F A3 54 0E        	mov	[0E54h],ax
0800:5022 D1 E0           	shl	ax,1h
0800:5024 D1 E0           	shl	ax,1h
0800:5026 0B 06 54 0E     	or	ax,[0E54h]
0800:502A 8B D8           	mov	bx,ax
0800:502C B9 04 00        	mov	cx,4h
0800:502F D3 E0           	shl	ax,cl
0800:5031 0B C3           	or	ax,bx
0800:5033 BB 03 00        	mov	bx,3h
0800:5036 8B CF           	mov	cx,di
0800:5038 83 E1 03        	and	cx,3h
0800:503B 83 F1 03        	xor	cx,3h
0800:503E 74 04           	jz	5044h

l0800_5040:
0800:5040 03 C9           	add	cx,cx
0800:5042 D3 E3           	shl	bx,cl

l0800_5044:
0800:5044 23 C3           	and	ax,bx
0800:5046 A3 54 0E        	mov	[0E54h],ax
0800:5049 F6 D3           	not	bl
0800:504B A1 50 0E        	mov	ax,[0E50h]
0800:504E 24 FE           	and	al,0FEh
0800:5050 BA 28 00        	mov	dx,28h
0800:5053 F6 E2           	mul	dl
0800:5055 D1 EF           	shr	di,1h
0800:5057 D1 EF           	shr	di,1h
0800:5059 03 F8           	add	di,ax
0800:505B 03 3E 9B 0B     	add	di,[0B9Bh]
0800:505F 8B 16 50 0E     	mov	dx,[0E50h]
0800:5063 83 E2 01        	and	dx,1h
0800:5066 74 04           	jz	506Ch

l0800_5068:
0800:5068 81 C7 00 20     	add	di,2000h

l0800_506C:
0800:506C 8B 0E 52 0E     	mov	cx,[0E52h]
0800:5070 2B 0E 50 0E     	sub	cx,[0E50h]
0800:5074 41              	inc	cx
0800:5075 8A FA           	mov	bh,dl
0800:5077 8B 16 54 0E     	mov	dx,[0E54h]
0800:507B 06              	push	es
0800:507C 1F              	pop	ds

l0800_507D:
0800:507D 8A 05           	mov	al,[di]
0800:507F 22 C3           	and	al,bl
0800:5081 0B C2           	or	ax,dx
0800:5083 88 05           	mov	[di],al
0800:5085 80 F7 01        	xor	bh,1h
0800:5088 74 08           	jz	5092h

l0800_508A:
0800:508A 81 C7 00 20     	add	di,2000h
0800:508E E2 ED           	loop	507Dh

l0800_5090:
0800:5090 EB 84           	jmp	5016h

l0800_5092:
0800:5092 81 EF B0 1F     	sub	di,1FB0h
0800:5096 E2 E5           	loop	507Dh

l0800_5098:
0800:5098 E9 7B FF        	jmp	5016h
0800:509B                                  00 00 00 00 00            .....
0800:50A0 00                                              .               

;; DrawVgaRleSprite_50A1: 0800:50A1
;;   Called from:
;;     0D73:572B (in DrawClippedSprite_566E)
DrawVgaRleSprite_50A1 proc
0800:50A1 55              	push	bp
0800:50A2 8B EC           	mov	bp,sp
0800:50A4 57              	push	di
0800:50A5 56              	push	si
0800:50A6 1E              	push	ds
0800:50A7 B8 84 41        	mov	ax,4184h
0800:50AA 8E D8           	mov	ds,ax
0800:50AC 06              	push	es
0800:50AD FC              	cld
0800:50AE 8B 7E 06        	mov	di,[bp+6h]
0800:50B1 8B 46 08        	mov	ax,[bp+8h]
0800:50B4 8E C0           	mov	es,ax
0800:50B6 8B 76 0A        	mov	si,[bp+0Ah]
0800:50B9 8B 46 0C        	mov	ax,[bp+0Ch]
0800:50BC A3 56 0E        	mov	[0E56h],ax
0800:50BF 8B 5E 0E        	mov	bx,[bp+0Eh]
0800:50C2 8B 46 10        	mov	ax,[bp+10h]
0800:50C5 A3 5C 0E        	mov	[0E5Ch],ax
0800:50C8 A1 7C 09        	mov	ax,[097Ch]
0800:50CB D1 E0           	shl	ax,1h
0800:50CD D1 E0           	shl	ax,1h
0800:50CF D1 E0           	shl	ax,1h
0800:50D1 03 F8           	add	di,ax
0800:50D3 C6 06 66 0E 00  	mov	byte ptr [0E66h],0h
0800:50D8 2B D8           	sub	bx,ax
0800:50DA 89 1E 5A 0E     	mov	[0E5Ah],bx
0800:50DE A1 7E 09        	mov	ax,[097Eh]
0800:50E1 2B 06 7C 09     	sub	ax,[097Ch]
0800:50E5 A3 67 0E        	mov	[0E67h],ax
0800:50E8 1E              	push	ds
0800:50E9 46              	inc	si
0800:50EA A1 56 0E        	mov	ax,[0E56h]
0800:50ED 8E D8           	mov	ds,ax
0800:50EF AD              	lodsw
0800:50F0 46              	inc	si
0800:50F1 1F              	pop	ds
0800:50F2 FE C0           	inc	al
0800:50F4 50              	push	ax
0800:50F5 25 FF 00        	and	ax,0FFh
0800:50F8 A3 5E 0E        	mov	[0E5Eh],ax
0800:50FB 58              	pop	ax
0800:50FC 86 C4           	xchg	ah,al
0800:50FE 25 FF 00        	and	ax,0FFh
0800:5101 D1 E0           	shl	ax,1h
0800:5103 D1 E0           	shl	ax,1h
0800:5105 D1 E0           	shl	ax,1h
0800:5107 A3 60 0E        	mov	[0E60h],ax
0800:510A A3 62 0E        	mov	[0E62h],ax
0800:510D A1 5C 0E        	mov	ax,[0E5Ch]
0800:5110 2B 06 80 09     	sub	ax,[0980h]
0800:5114 79 40           	jns	5156h

l0800_5116:
0800:5116 01 06 5E 0E     	add	[0E5Eh],ax
0800:511A 7F 03           	jg	511Fh

l0800_511C:
0800:511C E9 A2 00        	jmp	51C1h

l0800_511F:
0800:511F F7 D8           	neg	ax
0800:5121 8B D0           	mov	dx,ax
0800:5123 A1 60 0E        	mov	ax,[0E60h]
0800:5126 2E A3 9B 50     	mov	cs:[509Bh],ax
0800:512A 57              	push	di
0800:512B 06              	push	es
0800:512C 8B FE           	mov	di,si
0800:512E A1 56 0E        	mov	ax,[0E56h]
0800:5131 8E C0           	mov	es,ax

l0800_5133:
0800:5133 2E 8B 0E 9B 50  	mov	cx,cs:[509Bh]

l0800_5138:
0800:5138 33 C0           	xor	ax,ax

l0800_513A:
0800:513A F2 AE           	repne scasb

l0800_513C:
0800:513C 74 02           	jz	5140h

l0800_513E:
0800:513E E3 09           	jcxz	5149h

l0800_5140:
0800:5140 26 8A 05        	mov	al,es:[di]
0800:5143 47              	inc	di
0800:5144 41              	inc	cx
0800:5145 2B C8           	sub	cx,ax
0800:5147 75 EF           	jnz	5138h

l0800_5149:
0800:5149 4A              	dec	dx
0800:514A 75 E7           	jnz	5133h

l0800_514C:
0800:514C 8B F7           	mov	si,di
0800:514E 07              	pop	es
0800:514F 5F              	pop	di
0800:5150 A1 80 09        	mov	ax,[0980h]
0800:5153 A3 5C 0E        	mov	[0E5Ch],ax

l0800_5156:
0800:5156 A1 82 09        	mov	ax,[0982h]
0800:5159 2B 06 5C 0E     	sub	ax,[0E5Ch]
0800:515D 78 62           	js	51C1h

l0800_515F:
0800:515F 74 60           	jz	51C1h

l0800_5161:
0800:5161 3B 06 5E 0E     	cmp	ax,[0E5Eh]
0800:5165 73 03           	jnc	516Ah

l0800_5167:
0800:5167 A3 5E 0E        	mov	[0E5Eh],ax

l0800_516A:
0800:516A 2E C7 06 9B 50 00 00 	mov	word ptr cs:[509Bh],0h
0800:5171 A1 5A 0E        	mov	ax,[0E5Ah]
0800:5174 0B C0           	or	ax,ax
0800:5176 79 15           	jns	518Dh

l0800_5178:
0800:5178 01 06 60 0E     	add	[0E60h],ax
0800:517C F7 D8           	neg	ax
0800:517E 2E A3 9B 50     	mov	cs:[509Bh],ax
0800:5182 3B 06 62 0E     	cmp	ax,[0E62h]
0800:5186 73 39           	jnc	51C1h

l0800_5188:
0800:5188 33 C0           	xor	ax,ax
0800:518A A3 5A 0E        	mov	[0E5Ah],ax

l0800_518D:
0800:518D 2E C7 06 9D 50 00 00 	mov	word ptr cs:[509Dh],0h
0800:5194 A1 67 0E        	mov	ax,[0E67h]
0800:5197 D1 E0           	shl	ax,1h
0800:5199 D1 E0           	shl	ax,1h
0800:519B D1 E0           	shl	ax,1h
0800:519D 2B 06 5A 0E     	sub	ax,[0E5Ah]
0800:51A1 78 1E           	js	51C1h

l0800_51A3:
0800:51A3 74 1C           	jz	51C1h

l0800_51A5:
0800:51A5 3B 06 60 0E     	cmp	ax,[0E60h]
0800:51A9 73 19           	jnc	51C4h

l0800_51AB:
0800:51AB A3 60 0E        	mov	[0E60h],ax
0800:51AE A1 62 0E        	mov	ax,[0E62h]
0800:51B1 2E 2B 06 9B 50  	sub	ax,cs:[509Bh]
0800:51B6 2B 06 60 0E     	sub	ax,[0E60h]
0800:51BA 2E A3 9D 50     	mov	cs:[509Dh],ax
0800:51BE EB 04           	jmp	51C4h
0800:51C0 90                                              .               

l0800_51C1:
0800:51C1 E9 9C 00        	jmp	5260h

l0800_51C4:
0800:51C4 A1 5C 0E        	mov	ax,[0E5Ch]
0800:51C7 BA 40 01        	mov	dx,140h
0800:51CA F7 E2           	mul	dx
0800:51CC 03 06 5A 0E     	add	ax,[0E5Ah]
0800:51D0 03 F8           	add	di,ax
0800:51D2 8B EF           	mov	bp,di
0800:51D4 A1 60 0E        	mov	ax,[0E60h]
0800:51D7 2E A3 9F 50     	mov	cs:[509Fh],ax
0800:51DB 8B 16 5E 0E     	mov	dx,[0E5Eh]
0800:51DF A1 56 0E        	mov	ax,[0E56h]
0800:51E2 8E D8           	mov	ds,ax
0800:51E4 33 C0           	xor	ax,ax
0800:51E6 8C C3           	mov	bx,es

l0800_51E8:
0800:51E8 2E 8B 0E 9B 50  	mov	cx,cs:[509Bh]
0800:51ED E3 23           	jcxz	5212h

l0800_51EF:
0800:51EF 8C D8           	mov	ax,ds
0800:51F1 8E DB           	mov	ds,bx
0800:51F3 8E C0           	mov	es,ax
0800:51F5 87 F7           	xchg	di,si

l0800_51F7:
0800:51F7 33 C0           	xor	ax,ax

l0800_51F9:
0800:51F9 F2 AE           	repne scasb

l0800_51FB:
0800:51FB 74 02           	jz	51FFh

l0800_51FD:
0800:51FD E3 09           	jcxz	5208h

l0800_51FF:
0800:51FF 26 8A 05        	mov	al,es:[di]
0800:5202 47              	inc	di
0800:5203 41              	inc	cx
0800:5204 2B C8           	sub	cx,ax
0800:5206 7F EF           	jg	51F7h

l0800_5208:
0800:5208 8C C0           	mov	ax,es
0800:520A 8E C3           	mov	es,bx
0800:520C 8E D8           	mov	ds,ax
0800:520E 87 F7           	xchg	di,si
0800:5210 33 C0           	xor	ax,ax

l0800_5212:
0800:5212 2B F9           	sub	di,cx
0800:5214 2E 03 0E 9F 50  	add	cx,cs:[509Fh]
0800:5219 7E 12           	jle	522Dh

l0800_521B:
0800:521B AC              	lodsb
0800:521C 0A C0           	or	al,al
0800:521E 74 06           	jz	5226h

l0800_5220:
0800:5220 AA              	stosb
0800:5221 E2 F8           	loop	521Bh

l0800_5223:
0800:5223 EB 08           	jmp	522Dh
0800:5225                90                                    .          

l0800_5226:
0800:5226 AC              	lodsb
0800:5227 03 F8           	add	di,ax
0800:5229 2B C8           	sub	cx,ax
0800:522B 7F EE           	jg	521Bh

l0800_522D:
0800:522D 2E 03 0E 9D 50  	add	cx,cs:[509Dh]
0800:5232 E3 23           	jcxz	5257h

l0800_5234:
0800:5234 8C D8           	mov	ax,ds
0800:5236 8E DB           	mov	ds,bx
0800:5238 8E C0           	mov	es,ax
0800:523A 87 F7           	xchg	di,si

l0800_523C:
0800:523C 33 C0           	xor	ax,ax

l0800_523E:
0800:523E F2 AE           	repne scasb

l0800_5240:
0800:5240 74 02           	jz	5244h

l0800_5242:
0800:5242 E3 09           	jcxz	524Dh

l0800_5244:
0800:5244 41              	inc	cx
0800:5245 26 8A 05        	mov	al,es:[di]
0800:5248 47              	inc	di
0800:5249 2B C8           	sub	cx,ax
0800:524B 75 EF           	jnz	523Ch

l0800_524D:
0800:524D 8C C0           	mov	ax,es
0800:524F 8E C3           	mov	es,bx
0800:5251 8E D8           	mov	ds,ax
0800:5253 87 F7           	xchg	di,si
0800:5255 33 C0           	xor	ax,ax

l0800_5257:
0800:5257 81 C5 40 01     	add	bp,140h
0800:525B 8B FD           	mov	di,bp
0800:525D 4A              	dec	dx
0800:525E 75 88           	jnz	51E8h

l0800_5260:
0800:5260 07              	pop	es
0800:5261 1F              	pop	ds
0800:5262 5E              	pop	si
0800:5263 5F              	pop	di
0800:5264 5D              	pop	bp
0800:5265 CB              	retf
0800:5266                   00 00 00 00 00 00 00 00 2E 8F       ..........
0800:5270 06 66 52 2E 8F 06 68 52 2E 8C 1E 6A 52 FC 8E 06 .fR...hR...jR...
0800:5280 7B 00 BE 80 00 32 E4 26 AC 40 8C C5 87 D6 93 8B {....2.&.@......
0800:5290 36 75 00 83 C6 02 B9 01 00 80 3E 7D 00 03 72 11 6u........>}..r.
0800:52A0 8E 06 77 00 8B FE B1 7F 32 C0 F2 AE E3 76 80 F1 ..w.....2....v..
0800:52B0 7F 83 EC 02 B8 01 00 03 C3 03 C1 25 FE FF 8B FC ...........%....
0800:52C0 2B F8 72 60 8B E7 8C C0 8E D8 8C D0 8E C0 51 49 +.r`..........QI
0800:52D0 F3 A4 32 C0 AA 8E DD 87 F2 87 D9 8B C3 8B D0 43 ..2............C
0800:52E0 E8 19 00 77 07 72 42 E8 12 00 77 F9 3C 20 74 08 ...w.rB...w.< t.
0800:52F0 3C 0D 74 04 3C 09 75 E8 32 C0 EB E4 0B C0 74 07 <.t.<.u.2.....t.
0800:5300 42 AA 0A C0 75 01 43 86 E0 32 C0 F9 E3 15 AC 49 B...u.C..2.....I
0800:5310 2C 22 74 0F 04 22 3C 5C 75 07 80 3C 22 75 02 AC ,"t.."<\u..<"u..
0800:5320 49 0B F6 C3 EA AF 01 00 08 59 03 CA 2E 8E 1E 6A I........Y.....j
0800:5330 52 89 1E 6B 00 43 03 DB 03 DB 8B F4 8B EC 2B EB R..k.C........+.
0800:5340 72 E2 8B E5 89 2E 6D 00 8C 16 6F 00 E3 11 89 76 r.....m...o....v
0800:5350 00 8C 56 02 83 C5 04 36 AC 0A C0 E0 FA 74 ED 33 ..V....6.....t.3
0800:5360 C0 89 46 00 89 46 02 2E FF 2E 66 52 8E 06 77 00 ..F..F....fR..w.
0800:5370 33 FF 06 FF 36 79 00 9A 02 00 CD 38 83 C4 02 8B 3...6y.....8....
0800:5380 D8 07 A3 71 00 89 16 73 00 1E 8E DA 0B C2 75 05 ...q...s......u.
0800:5390 EA AF 01 00 08 33 C0 B9 FF FF 89 3F 8C 47 02 83 .....3.....?.G..
0800:53A0 C3 04 F2 AE 26 38 05 75 F1 89 07 89 47 02 1F CB ....&8.u....G...

;; AddSignedOffsetToFarPointer: 0800:53B0
;;   Called from:
;;     38CD:00A5 (in SplitFarHeapFreeBlock_007F)
;;     38CD:0104 (in SplitFarHeapFreeBlock_007F)
;;     38FE:00EC (in AdjustProgramBreak)
;;     398D:0108 (in CoalesceFarHeapSuccessor_00BD)
;;     398D:023C (in FreeAndCoalesceFarHeapBlock_021A)
;;     398D:02FF (in FreeFarHeapAllocation)
AddSignedOffsetToFarPointer proc
0800:53B0 0B C9           	or	cx,cx
0800:53B2 7D 0D           	jge	53C1h

l0800_53B4:
0800:53B4 F7 D3           	not	bx
0800:53B6 F7 D1           	not	cx
0800:53B8 83 C3 01        	add	bx,1h
0800:53BB 83 D1 00        	adc	cx,0h
0800:53BE EB 2D           	jmp	53EDh
0800:53C0 90                                              .               

l0800_53C1:
0800:53C1 03 C3           	add	ax,bx
0800:53C3 73 04           	jnc	53C9h

l0800_53C5:
0800:53C5 81 C2 00 10     	add	dx,1000h

l0800_53C9:
0800:53C9 8A E9           	mov	ch,cl
0800:53CB B1 04           	mov	cl,4h
0800:53CD D2 E5           	shl	ch,cl
0800:53CF 02 F5           	add	dh,ch
0800:53D1 8A E8           	mov	ch,al
0800:53D3 D3 E8           	shr	ax,cl
0800:53D5 03 D0           	add	dx,ax
0800:53D7 8A C5           	mov	al,ch
0800:53D9 25 0F 00        	and	ax,0Fh
0800:53DC CB              	retf
0800:53DD                                        0B C9 7D              ..}
0800:53E0 0C F7 D3 F7 D1 83 C3 01 83 D1 00 EB D4          .............   

l0800_53ED:
0800:53ED 2B C3           	sub	ax,bx
0800:53EF 73 04           	jnc	53F5h

l0800_53F1:
0800:53F1 81 EA 00 10     	sub	dx,1000h

l0800_53F5:
0800:53F5 8A F9           	mov	bh,cl
0800:53F7 B1 04           	mov	cl,4h
0800:53F9 D2 E7           	shl	bh,cl
0800:53FB 32 DB           	xor	bl,bl
0800:53FD 2B D3           	sub	dx,bx
0800:53FF 8A E8           	mov	ch,al
0800:5401 D3 E8           	shr	ax,cl
0800:5403 03 D0           	add	dx,ax
0800:5405 8A C5           	mov	al,ch
0800:5407 25 0F 00        	and	ax,0Fh
0800:540A CB              	retf

;; CompareNormalizedFarPointers: 0800:540B
;;   Called from:
;;     38CD:0035 (in UnlinkFarHeapFreeBlock_0017)
;;     38CD:00E4 (in SplitFarHeapFreeBlock_007F)
;;     38CD:023C (in AllocateFarHeapBytes)
;;     38CD:0263 (in AllocateFarHeapBytes)
;;     38CD:02F6 (in AllocateFarHeapBytes)
;;     38FE:00A3 (in SetProgramBreak)
;;     38FE:00B8 (in SetProgramBreak)
;;     38FE:0105 (in AdjustProgramBreak)
;;     38FE:011A (in AdjustProgramBreak)
;;     398D:002F (in InsertFarHeapFreeBlock_001E)
;;     398D:00E4 (in CoalesceFarHeapSuccessor_00BD)
;;     398D:014A (in ReleaseFarHeapTail_0135)
;;     398D:01BB (in ReleaseFarHeapTail_0135)
;;     398D:0277 (in FreeAndCoalesceFarHeapBlock_021A)
CompareNormalizedFarPointers proc
0800:540B 51              	push	cx
0800:540C 8A E8           	mov	ch,al
0800:540E B1 04           	mov	cl,4h
0800:5410 D3 E8           	shr	ax,cl
0800:5412 03 D0           	add	dx,ax
0800:5414 8A C5           	mov	al,ch
0800:5416 8A E3           	mov	ah,bl
0800:5418 D3 EB           	shr	bx,cl
0800:541A 59              	pop	cx
0800:541B 03 CB           	add	cx,bx
0800:541D 8A DC           	mov	bl,ah
0800:541F 25 0F 00        	and	ax,0Fh
0800:5422 83 E3 0F        	and	bx,0Fh
0800:5425 3B D1           	cmp	dx,cx
0800:5427 75 02           	jnz	542Bh

l0800_5429:
0800:5429 3B C3           	cmp	ax,bx

l0800_542B:
0800:542B CB              	retf

;; MultiplyUnsignedLong_542C: 0800:542C
;;   Called from:
;;     1A1F:0436 (in LoadTacticalIconSetResources_03D4)
;;     1A1F:1101 (in LoadUnitTemplateRecord_10CD)
;;     1A1F:58CF (in TranslateTacticalMouseInput_5755)
;;     1A1F:5913 (in TranslateTacticalMouseInput_5755)
;;     3A07:0039 (in ConvertLocalDateTimeToEpochSeconds_0001)
;;     3A07:0050 (in ConvertLocalDateTimeToEpochSeconds_0001)
;;     3A07:00EE (in ConvertLocalDateTimeToEpochSeconds_0001)
;;     3A07:0107 (in ConvertLocalDateTimeToEpochSeconds_0001)
;;     3A3C:0146 (in InitializeTimezoneFromEnvironment)
MultiplyUnsignedLong_542C proc
0800:542C 56              	push	si
0800:542D 96              	xchg	si,ax
0800:542E 92              	xchg	dx,ax
0800:542F 85 C0           	test	ax,ax
0800:5431 74 02           	jz	5435h

l0800_5433:
0800:5433 F7 E3           	mul	bx

l0800_5435:
0800:5435 91              	xchg	cx,ax
0800:5436 85 C0           	test	ax,ax
0800:5438 74 04           	jz	543Eh

l0800_543A:
0800:543A F7 E6           	mul	si
0800:543C 03 C8           	add	cx,ax

l0800_543E:
0800:543E 96              	xchg	si,ax
0800:543F F7 E3           	mul	bx
0800:5441 03 D1           	add	dx,cx
0800:5443 5E              	pop	si
0800:5444 CB              	retf

;; DivideUnsignedLong_5445: 0800:5445
;;   Called from:
;;     1A1F:58D6 (in TranslateTacticalMouseInput_5755)
;;     1A1F:591A (in TranslateTacticalMouseInput_5755)
;;     3390:0AC9 (in InitializeResourceCache)
;;     39CC:0065 (in CaptureLocalClockSnapshot_000F)
DivideUnsignedLong_5445 proc
0800:5445 33 C9           	xor	cx,cx
0800:5447 EB 0D           	jmp	5456h
0800:5449                            B9 01 00 EB 08 B9 02          .......
0800:5450 00 EB 03 B9 03 00                               ......          

l0800_5456:
0800:5456 55              	push	bp
0800:5457 56              	push	si
0800:5458 57              	push	di
0800:5459 8B EC           	mov	bp,sp
0800:545B 8B F9           	mov	di,cx
0800:545D 8B 46 0A        	mov	ax,[bp+0Ah]
0800:5460 8B 56 0C        	mov	dx,[bp+0Ch]
0800:5463 8B 5E 0E        	mov	bx,[bp+0Eh]
0800:5466 8B 4E 10        	mov	cx,[bp+10h]
0800:5469 0B C9           	or	cx,cx
0800:546B 75 08           	jnz	5475h

l0800_546D:
0800:546D 0B D2           	or	dx,dx
0800:546F 74 69           	jz	54DAh

l0800_5471:
0800:5471 0B DB           	or	bx,bx
0800:5473 74 65           	jz	54DAh

l0800_5475:
0800:5475 F7 C7 01 00     	test	di,1h
0800:5479 75 1C           	jnz	5497h

l0800_547B:
0800:547B 0B D2           	or	dx,dx
0800:547D 79 0A           	jns	5489h

l0800_547F:
0800:547F F7 DA           	neg	dx
0800:5481 F7 D8           	neg	ax
0800:5483 83 DA 00        	sbb	dx,0h
0800:5486 83 CF 0C        	or	di,0Ch

l0800_5489:
0800:5489 0B C9           	or	cx,cx
0800:548B 79 0A           	jns	5497h

l0800_548D:
0800:548D F7 D9           	neg	cx
0800:548F F7 DB           	neg	bx
0800:5491 83 D9 00        	sbb	cx,0h
0800:5494 83 F7 04        	xor	di,4h

l0800_5497:
0800:5497 8B E9           	mov	bp,cx
0800:5499 B9 20 00        	mov	cx,20h
0800:549C 57              	push	di
0800:549D 33 FF           	xor	di,di
0800:549F 33 F6           	xor	si,si

l0800_54A1:
0800:54A1 D1 E0           	shl	ax,1h
0800:54A3 D1 D2           	rcl	dx,1h
0800:54A5 D1 D6           	rcl	si,1h
0800:54A7 D1 D7           	rcl	di,1h
0800:54A9 3B FD           	cmp	di,bp
0800:54AB 72 0B           	jc	54B8h

l0800_54AD:
0800:54AD 77 04           	ja	54B3h

l0800_54AF:
0800:54AF 3B F3           	cmp	si,bx
0800:54B1 72 05           	jc	54B8h

l0800_54B3:
0800:54B3 2B F3           	sub	si,bx
0800:54B5 1B FD           	sbb	di,bp
0800:54B7 40              	inc	ax

l0800_54B8:
0800:54B8 E2 E7           	loop	54A1h

l0800_54BA:
0800:54BA 5B              	pop	bx
0800:54BB F7 C3 02 00     	test	bx,2h
0800:54BF 74 06           	jz	54C7h

l0800_54C1:
0800:54C1 8B C6           	mov	ax,si
0800:54C3 8B D7           	mov	dx,di
0800:54C5 D1 EB           	shr	bx,1h

l0800_54C7:
0800:54C7 F7 C3 04 00     	test	bx,4h
0800:54CB 74 07           	jz	54D4h

l0800_54CD:
0800:54CD F7 DA           	neg	dx
0800:54CF F7 D8           	neg	ax
0800:54D1 83 DA 00        	sbb	dx,0h

l0800_54D4:
0800:54D4 5F              	pop	di
0800:54D5 5E              	pop	si
0800:54D6 5D              	pop	bp
0800:54D7 CA 08 00        	retf	8h

l0800_54DA:
0800:54DA F7 F3           	div	bx
0800:54DC F7 C7 02 00     	test	di,2h
0800:54E0 74 02           	jz	54E4h

l0800_54E2:
0800:54E2 8B C2           	mov	ax,dx

l0800_54E4:
0800:54E4 33 D2           	xor	dx,dx
0800:54E6 EB EC           	jmp	54D4h

;; ShiftLeft32_DXAX_54E8: 0800:54E8
;;   Called from:
;;     0D73:465D (in ShowInvalidSaveVersionDialog_4611)
;;     2C7F:03C1 (in AddBytesToFarPointer)
;;     2FEA:00FA (in BuildPlanarDisplayBackingBuffer_000A)
ShiftLeft32_DXAX_54E8 proc
0800:54E8 80 F9 10        	cmp	cl,10h
0800:54EB 73 10           	jnc	54FDh

l0800_54ED:
0800:54ED 8B D8           	mov	bx,ax
0800:54EF D3 E0           	shl	ax,cl
0800:54F1 D3 E2           	shl	dx,cl
0800:54F3 F6 D9           	neg	cl
0800:54F5 80 C1 10        	add	cl,10h
0800:54F8 D3 EB           	shr	bx,cl
0800:54FA 0B D3           	or	dx,bx
0800:54FC CB              	retf

l0800_54FD:
0800:54FD 80 E9 10        	sub	cl,10h
0800:5500 8B D0           	mov	dx,ax
0800:5502 33 C0           	xor	ax,ax
0800:5504 D3 E2           	shl	dx,cl
0800:5506 CB              	retf

;; ShiftRight32_DXAX_5507: 0800:5507
;;   Called from:
;;     2C7F:0131 (in InitializeGame_003C)
;;     2C7F:03EA (in AddBytesToFarPointer)
ShiftRight32_DXAX_5507 proc
0800:5507 80 F9 10        	cmp	cl,10h
0800:550A 73 10           	jnc	551Ch

l0800_550C:
0800:550C 8B DA           	mov	bx,dx
0800:550E D3 E8           	shr	ax,cl
0800:5510 D3 EA           	shr	dx,cl
0800:5512 F6 D9           	neg	cl
0800:5514 80 C1 10        	add	cl,10h
0800:5517 D3 E3           	shl	bx,cl
0800:5519 0B C3           	or	ax,bx
0800:551B CB              	retf

l0800_551C:
0800:551C 80 E9 10        	sub	cl,10h
0800:551F 8B C2           	mov	ax,dx
0800:5521 33 D2           	xor	dx,dx
0800:5523 D3 E8           	shr	ax,cl
0800:5525 CB              	retf

;; CalculateFarPointerByteDistance_5526: 0800:5526
;;   Called from:
;;     398B:001E (in GetAvailableHeapBytes)
CalculateFarPointerByteDistance_5526 proc
0800:5526 57              	push	di
0800:5527 8B F9           	mov	di,cx
0800:5529 8A EE           	mov	ch,dh
0800:552B B1 04           	mov	cl,4h
0800:552D D3 E2           	shl	dx,cl
0800:552F D2 ED           	shr	ch,cl
0800:5531 03 D0           	add	dx,ax
0800:5533 80 D5 00        	adc	ch,0h
0800:5536 8B C7           	mov	ax,di
0800:5538 D3 E7           	shl	di,cl
0800:553A D2 EC           	shr	ah,cl
0800:553C 03 DF           	add	bx,di
0800:553E 80 D4 00        	adc	ah,0h
0800:5541 2B D3           	sub	dx,bx
0800:5543 1A EC           	sbb	ch,ah
0800:5545 8A C5           	mov	al,ch
0800:5547 98              	cbw
0800:5548 92              	xchg	dx,ax
0800:5549 5F              	pop	di
0800:554A CB              	retf

;; CopyFarMemory: 0800:554B
;;   Called from:
;;     0D73:4942 (in SaveGame_4866)
;;     0D73:49C2 (in SaveGame_4866)
;;     0D73:49F2 (in SaveGame_4866)
;;     0D73:4C99 (in LoadGame_4B86)
;;     0D73:4D21 (in LoadGame_4B86)
;;     0D73:4D51 (in LoadGame_4B86)
;;     1A1F:2D35 (in ExecuteSceneInstructions_2A4E)
;;     2007:1A0D (in AdvanceTacticalProjectiles_17DE)
;;     2208:003A (in RunTacticalUnitCommandMenu_000B)
;;     2208:050F (in RunTacticalUnitCommandMenu_000B)
;;     2208:0592 (in RunTacticalUnitCommandMenu_000B)
;;     2208:24BA (in InitializeScenarioUnitFromTemplate_2472)
;;     30F1:002E (in PrepareScenarioUnitRosters_0006)
;;     30F1:009F (in PrepareScenarioUnitRosters_0006)
;;     30F1:00C5 (in PrepareScenarioUnitRosters_0006)
;;     30F1:00FB (in PrepareScenarioUnitRosters_0006)
;;     30F1:011E (in PrepareScenarioUnitRosters_0006)
;;     30F1:0130 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0142 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0154 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0199 (in PrepareScenarioUnitRosters_0006)
;;     30F1:01AB (in PrepareScenarioUnitRosters_0006)
;;     30F1:01BD (in PrepareScenarioUnitRosters_0006)
;;     30F1:01D6 (in PrepareScenarioUnitRosters_0006)
;;     30F1:01EF (in PrepareScenarioUnitRosters_0006)
;;     30F1:0214 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0237 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0249 (in PrepareScenarioUnitRosters_0006)
;;     30F1:025B (in PrepareScenarioUnitRosters_0006)
;;     30F1:026D (in PrepareScenarioUnitRosters_0006)
;;     30F1:02BA (in PrepareScenarioUnitRosters_0006)
;;     30F1:02D3 (in PrepareScenarioUnitRosters_0006)
;;     30F1:02E5 (in PrepareScenarioUnitRosters_0006)
;;     30F1:02F7 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0329 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0355 (in PrepareScenarioUnitRosters_0006)
;;     30F1:036D (in PrepareScenarioUnitRosters_0006)
;;     30F1:0387 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0399 (in PrepareScenarioUnitRosters_0006)
;;     30F1:03C9 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0401 (in PrepareScenarioUnitRosters_0006)
;;     30F1:042D (in PrepareScenarioUnitRosters_0006)
;;     30F1:0445 (in PrepareScenarioUnitRosters_0006)
;;     30F1:045F (in PrepareScenarioUnitRosters_0006)
;;     30F1:0471 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0483 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0495 (in PrepareScenarioUnitRosters_0006)
;;     30F1:04C5 (in PrepareScenarioUnitRosters_0006)
;;     30F1:04FD (in PrepareScenarioUnitRosters_0006)
;;     30F1:052E (in PrepareScenarioUnitRosters_0006)
;;     30F1:0566 (in PrepareScenarioUnitRosters_0006)
;;     30F1:0599 (in PrepareScenarioUnitRosters_0006)
;;     30F1:05C7 (in PrepareScenarioUnitRosters_0006)
;;     30F1:05FF (in PrepareScenarioUnitRosters_0006)
;;     30F1:0626 (in PrepareScenarioUnitRosters_0006)
;;     30F1:065E (in PrepareScenarioUnitRosters_0006)
;;     30F1:0696 (in PrepareScenarioUnitRosters_0006)
;;     30F1:06ED (in PrepareScenarioUnitRosters_0006)
;;     30F1:0716 (in PrepareScenarioUnitRosters_0006)
;;     30F1:075E (in PrepareScenarioUnitRosters_0006)
;;     30F1:078A (in PrepareScenarioUnitRosters_0006)
;;     30F1:07D3 (in PrepareScenarioUnitRosters_0006)
;;     30F1:080E (in PrepareScenarioUnitRosters_0006)
;;     30F1:085B (in PrepareScenarioUnitRosters_0006)
;;     30F1:0C26 (in CompactScenarioLances_0B8F)
;;     30F1:0C4C (in CompactScenarioLances_0B8F)
;;     30F1:0CC8 (in CompactScenarioLances_0B8F)
;;     30F1:0CE4 (in CompactScenarioLances_0B8F)
;;     30F1:0D31 (in CompactScenarioLances_0B8F)
;;     30F1:0D4D (in CompactScenarioLances_0B8F)
;;     30F1:0ED4 (in PromoteReserveUnitsForCampaignStage_0E96)
;;     30F1:0F69 (in PromoteReserveUnitsForCampaignStage_0E96)
;;     30F1:102C (in PromoteReserveUnitsForCampaignStage_0E96)
CopyFarMemory proc
0800:554B 55              	push	bp
0800:554C 8B EC           	mov	bp,sp
0800:554E 56              	push	si
0800:554F 57              	push	di
0800:5550 1E              	push	ds
0800:5551 C5 76 06        	lds	si,[bp+6h]
0800:5554 C4 7E 0A        	les	di,[bp+0Ah]
0800:5557 FC              	cld
0800:5558 D1 E9           	shr	cx,1h

l0800_555A:
0800:555A F3 A5           	rep movsw

l0800_555C:
0800:555C 13 C9           	adc	cx,cx

l0800_555E:
0800:555E F3 A4           	rep movsb
