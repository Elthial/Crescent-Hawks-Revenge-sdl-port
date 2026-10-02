;;; Segment 35CA (35CA:0000)
35CA:0000 ED 32 00 08 59 59                               .2..YY          

l35C2_0086:
35C2:0086 5E              	pop	si
35C2:0087 5D              	pop	bp
35C2:0088 CB              	retf

;; ToggleActiveUiRegionHighlight_0009: 35CA:0009
;;   Called from:
;;     0D73:2488 (in ShowConfirmationDialog_2448)
;;     0D73:2737 (in RunMainMenuSelection_25F5)
;;     0D73:2827 (in RunInGameMenu_274D)
;;     1A1F:42C8 (in RunGameOptionsMenu_417F)
;;     1A1F:50CD (in ShowPendingNarrationPrompt_4FA6)
;;     2507:05CC (in SelectUnitClass_0501)
;;     2507:0762 (in SelectUnitTypeFromList_0625)
ToggleActiveUiRegionHighlight_0009 proc
35CA:0009 56              	push	si
35CA:000A 8B 36 AE 7F     	mov	si,[7FAEh]
35CA:000E 8B C6           	mov	ax,si
35CA:0010 0B C0           	or	ax,ax
35CA:0012 75 05           	jnz	0019h

l35CA_0014:
35CA:0014 9A 68 39 00 08  	call	far 0800h:3968h

l35CA_0019:
35CA:0019 FF 36 52 B6     	push	word ptr [0B652h]
35CA:001D A1 5A B6        	mov	ax,[0B65Ah]
35CA:0020 03 06 54 B6     	add	ax,[0B654h]
35CA:0024 48              	dec	ax
35CA:0025 50              	push	ax
35CA:0026 A1 58 B6        	mov	ax,[0B658h]
35CA:0029 03 06 56 B6     	add	ax,[0B656h]
35CA:002D 48              	dec	ax
35CA:002E 50              	push	ax
35CA:002F FF 36 5A B6     	push	word ptr [0B65Ah]
35CA:0033 FF 36 58 B6     	push	word ptr [0B658h]
35CA:0037 9A 4E 48 00 08  	call	far 0800h:484Eh
35CA:003C 83 C4 0A        	add	sp,0Ah
35CA:003F 0B F6           	or	si,si
