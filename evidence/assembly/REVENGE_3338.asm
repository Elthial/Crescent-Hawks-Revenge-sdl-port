;;; Segment 3338 (3338:0000)
3338:0000 00 08 83 C4 14                                  .....           

l3329_00F5:
3329:00F5 5F              	pop	di
3329:00F6 5E              	pop	si
3329:00F7 5D              	pop	bp
3329:00F8 CB              	retf

;; SelectTextWindow_0009: 3338:0009
;;   Called from:
;;     0D73:2A69 (in OpenModalTextWindow_2A5D)
;;     0D73:2B2C (in RestoreModalTextWindow_2AEE)
;;     0D73:30A7 (in RunTitleAndMainMenu_309C)
;;     0D73:4621 (in ShowInvalidSaveVersionDialog_4611)
;;     0D73:4824 (in ShowInvalidSaveVersionDialog_4611)
;;     1A1F:4241 (in RunGameOptionsMenu_417F)
;;     1A1F:42B1 (in RunGameOptionsMenu_417F)
;;     1A1F:44BF (in RenderPendingNarration_4447)
;;     1A1F:4690 (in RenderPendingNarration_4447)
;;     2007:0F01 (in DrawSelectedUnitStatusPanel_0E19)
;;     2007:16E0 (in RedrawTacticalStatusPanel_16BA)
;;     2B34:0F8D (in DrawTacticalUnitControlPanel_04C2)
;;     3349:000F (in SelectAndClearTextWindow_0009)
SelectTextWindow_0009 proc
3338:0009 55              	push	bp
3338:000A 8B EC           	mov	bp,sp
3338:000C 56              	push	si
3338:000D 8B 76 06        	mov	si,[bp+6h]
3338:0010 83 3E 40 62 00  	cmp	word ptr [6240h],0h
3338:0015 74 5E           	jz	0075h

l3338_0017:
3338:0017 A1 38 62        	mov	ax,[6238h]
3338:001A 8B 1E 2E 62     	mov	bx,[622Eh]
3338:001E B1 04           	mov	cl,4h
3338:0020 D3 E3           	shl	bx,cl
3338:0022 81 C3 3A 06     	add	bx,63Ah
3338:0026 50              	push	ax
3338:0027 1E              	push	ds
3338:0028 07              	pop	es
3338:0029 58              	pop	ax
3338:002A 26 89 47 08     	mov	es:[bx+8h],ax
3338:002E A1 3A 62        	mov	ax,[623Ah]
3338:0031 8B 1E 2E 62     	mov	bx,[622Eh]
3338:0035 B1 04           	mov	cl,4h
3338:0037 D3 E3           	shl	bx,cl
3338:0039 81 C3 3A 06     	add	bx,63Ah
3338:003D 50              	push	ax
3338:003E 1E              	push	ds
3338:003F 07              	pop	es
3338:0040 58              	pop	ax
3338:0041 26 89 47 0A     	mov	es:[bx+0Ah],ax
3338:0045 A1 3C 62        	mov	ax,[623Ch]
3338:0048 8B 1E 2E 62     	mov	bx,[622Eh]
3338:004C B1 04           	mov	cl,4h
3338:004E D3 E3           	shl	bx,cl
3338:0050 81 C3 3A 06     	add	bx,63Ah
3338:0054 50              	push	ax
3338:0055 1E              	push	ds
3338:0056 07              	pop	es
3338:0057 58              	pop	ax
3338:0058 26 89 47 0C     	mov	es:[bx+0Ch],ax
3338:005C A1 3E 62        	mov	ax,[623Eh]
3338:005F 8B 1E 2E 62     	mov	bx,[622Eh]
3338:0063 B1 04           	mov	cl,4h
3338:0065 D3 E3           	shl	bx,cl
3338:0067 81 C3 3A 06     	add	bx,63Ah
3338:006B 50              	push	ax
3338:006C 1E              	push	ds
3338:006D 07              	pop	es
3338:006E 58              	pop	ax
3338:006F 26 89 47 0E     	mov	es:[bx+0Eh],ax
3338:0073 EB 06           	jmp	007Bh

l3338_0075:
3338:0075 C7 06 40 62 01 00 	mov	word ptr [6240h],1h

l3338_007B:
3338:007B 89 36 2E 62     	mov	[622Eh],si
3338:007F 8B DE           	mov	bx,si
3338:0081 B1 04           	mov	cl,4h
3338:0083 D3 E3           	shl	bx,cl
3338:0085 81 C3 3A 06     	add	bx,63Ah
3338:0089 1E              	push	ds
3338:008A 07              	pop	es
3338:008B 26 8B 07        	mov	ax,es:[bx]
3338:008E A3 30 62        	mov	[6230h],ax
3338:0091 8B DE           	mov	bx,si
3338:0093 B1 04           	mov	cl,4h
3338:0095 D3 E3           	shl	bx,cl
3338:0097 81 C3 3A 06     	add	bx,63Ah
3338:009B 1E              	push	ds
3338:009C 07              	pop	es
3338:009D 26 8B 47 02     	mov	ax,es:[bx+2h]
3338:00A1 A3 32 62        	mov	[6232h],ax
3338:00A4 8B DE           	mov	bx,si
3338:00A6 B1 04           	mov	cl,4h
3338:00A8 D3 E3           	shl	bx,cl
3338:00AA 81 C3 3A 06     	add	bx,63Ah
3338:00AE 1E              	push	ds
3338:00AF 07              	pop	es
3338:00B0 26 8B 47 04     	mov	ax,es:[bx+4h]
3338:00B4 A3 34 62        	mov	[6234h],ax
3338:00B7 8B DE           	mov	bx,si
3338:00B9 B1 04           	mov	cl,4h
3338:00BB D3 E3           	shl	bx,cl
3338:00BD 81 C3 3A 06     	add	bx,63Ah
3338:00C1 1E              	push	ds
3338:00C2 07              	pop	es
3338:00C3 26 8B 47 06     	mov	ax,es:[bx+6h]
3338:00C7 A3 36 62        	mov	[6236h],ax
3338:00CA 8B DE           	mov	bx,si
3338:00CC B1 04           	mov	cl,4h
3338:00CE D3 E3           	shl	bx,cl
3338:00D0 81 C3 3A 06     	add	bx,63Ah
3338:00D4 1E              	push	ds
3338:00D5 07              	pop	es
3338:00D6 26 8B 47 08     	mov	ax,es:[bx+8h]
3338:00DA A3 38 62        	mov	[6238h],ax
3338:00DD 8B DE           	mov	bx,si
3338:00DF B1 04           	mov	cl,4h
3338:00E1 D3 E3           	shl	bx,cl
3338:00E3 81 C3 3A 06     	add	bx,63Ah
3338:00E7 1E              	push	ds
3338:00E8 07              	pop	es
3338:00E9 26 8B 47 0A     	mov	ax,es:[bx+0Ah]
3338:00ED A3 3A 62        	mov	[623Ah],ax
3338:00F0 8B DE           	mov	bx,si
3338:00F2 B1 04           	mov	cl,4h
3338:00F4 D3 E3           	shl	bx,cl
3338:00F6 81 C3 3A 06     	add	bx,63Ah
3338:00FA 1E              	push	ds
3338:00FB 07              	pop	es
3338:00FC 26 8B 47 0C     	mov	ax,es:[bx+0Ch]
3338:0100 A3 3C 62        	mov	[623Ch],ax
3338:0103 8B DE           	mov	bx,si
3338:0105 B1 04           	mov	cl,4h
3338:0107 D3 E3           	shl	bx,cl
3338:0109 81 C3 3A 06     	add	bx,63Ah
3338:010D 1E              	push	ds
3338:010E 07              	pop	es
3338:010F 26 8B 47 0E     	mov	ax,es:[bx+0Eh]
