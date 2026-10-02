;;; Segment 3965 (3965:0000)
3965:0000 EB 08                                           ..              

l3961_0042:
3961:0042 50              	push	ax
3961:0043 9A 04 00 C3 38  	call	far 38C3h:0004h
3961:0048 EB 00           	jmp	004Ah

l3961_004A:
3961:004A 5D              	pop	bp
3961:004B CB              	retf

;; DOS_SeekFile: 3965:000C
;;   Called from:
;;     3390:060E (in SeekTrackedFile)
;;     3477:0088 (in LoadFontResource_000B)
;;     3477:011B (in LoadFontResource_000B)
;;     393C:00AA (in ReadFileWithTextTranslation)
;;     3961:001B (in DOS_WriteFile)
DOS_SeekFile proc
3965:000C 55              	push	bp
3965:000D 8B EC           	mov	bp,sp
3965:000F 8B 5E 06        	mov	bx,[bp+6h]
3965:0012 D1 E3           	shl	bx,1h
3965:0014 81 A7 2A 71 FF FD 	and	word ptr [bx+712Ah],0FDFFh
3965:001A B4 42           	mov	ah,42h
3965:001C 8A 46 0C        	mov	al,[bp+0Ch]
3965:001F 8B 5E 06        	mov	bx,[bp+6h]
3965:0022 8B 4E 0A        	mov	cx,[bp+0Ah]
3965:0025 8B 56 08        	mov	dx,[bp+8h]
3965:0028 CD 21           	int	21h
3965:002A 72 02           	jc	002Eh

l3965_002C:
3965:002C EB 09           	jmp	0037h

l3965_002E:
3965:002E 50              	push	ax
3965:002F 9A 04 00 C3 38  	call	far 38C3h:0004h
