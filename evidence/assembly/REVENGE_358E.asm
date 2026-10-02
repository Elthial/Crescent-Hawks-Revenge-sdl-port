;;; Segment 358E (358E:0000)
358E:0000 3E 62                                           >b              

l356F_01F2:
356F:01F2 C4 5E 06        	les	bx,[bp+6h]
356F:01F5 26 C6 07 00     	mov	byte ptr es:[bx],0h
356F:01F9 5E              	pop	si
356F:01FA 5D              	pop	bp
356F:01FB CB              	retf

;; RunSingleUiRegionSelection_000C: 358E:000C
;;   Called from:
;;     0D73:247B (in ShowConfirmationDialog_2448)
;;     0D73:2818 (in RunInGameMenu_274D)
;;     0D73:4FE5 (in ShowSaveLoadMenu_4EC7)
;;     0D73:52E6 (in RenameSaveSlot_5233)
;;     0D73:54AF (in PromptYesNo_546F)
;;     1A1F:5D66 (in RunOptionsMenuSelection_5D5E)
;;     2507:05BF (in SelectUnitClass_0501)
;;     2507:0755 (in SelectUnitTypeFromList_0625)
RunSingleUiRegionSelection_000C proc
358E:000C 55              	push	bp
358E:000D 8B EC           	mov	bp,sp
358E:000F 56              	push	si
358E:0010 57              	push	di
358E:0011 8B 3E AE 7F     	mov	di,[7FAEh]
358E:0015 0B FF           	or	di,di
358E:0017 75 05           	jnz	001Eh

l358E_0019:
358E:0019 9A 68 39 00 08  	call	far 0800h:3968h

l358E_001E:
358E:001E FF 76 06        	push	word ptr [bp+6h]
358E:0021 9A 09 00 99 35  	call	far 3599h:0009h
358E:0026 59              	pop	cx
358E:0027 9A 7A 3B 00 08  	call	far 0800h:3B7Ah
358E:002C C7 06 A4 7F 00 00 	mov	word ptr [7FA4h],0h

l358E_0032:
358E:0032 B8 01 00        	mov	ax,1h
358E:0035 50              	push	ax
358E:0036 FF 76 06        	push	word ptr [bp+6h]
358E:0039 9A 03 00 E6 34  	call	far 34E6h:0003h
358E:003E 59              	pop	cx
358E:003F 59              	pop	cx
358E:0040 8B F0           	mov	si,ax
358E:0042 83 FE FF        	cmp	si,0FFh
358E:0045 74 EB           	jz	0032h

l358E_0047:
358E:0047 0B FF           	or	di,di
358E:0049 74 05           	jz	0050h

l358E_004B:
358E:004B 9A 68 39 00 08  	call	far 0800h:3968h
