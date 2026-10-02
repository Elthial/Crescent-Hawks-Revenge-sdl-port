;;; Segment 397F (397F:0000)
397F:0000 FF                                              .               

l397E_0011:
397E:0011 F2 AE           	repne scasb

l397E_0013:
397E:0013 8B C1           	mov	ax,cx
397E:0015 F7 D0           	not	ax
397E:0017 48              	dec	ax
397E:0018 EB 00           	jmp	001Ah

l397E_001A:
397E:001A 5F              	pop	di
397E:001B 5E              	pop	si
397E:001C 5D              	pop	bp
397E:001D CB              	retf

;; FarStringCompare: 397F:000E
;;   Called from:
;;     0D73:508E (in ShowSaveLoadMenu_4EC7)
;;     2C7F:05E0 (in LoadMediaConfiguration_047A)
;;     2C7F:06B8 (in ApplyVideoConfigOption_0669)
;;     2C7F:077C (in ApplyMusicConfigOption_072D)
;;     2C7F:081E (in ApplySoundConfigOption_07CE)
;;     2C7F:0919 (in ApplyInputDeviceConfigOption_08CA)
;;     3390:06D3 (in GetResourceDriveMask)
;;     3390:0C36 (in IsResourceCached)
;;     3390:0CBD (in FindResourceDescriptorIndex)
FarStringCompare proc
397F:000E 55              	push	bp
397F:000F 8B EC           	mov	bp,sp
397F:0011 56              	push	si
397F:0012 57              	push	di
397F:0013 8C DA           	mov	dx,ds
397F:0015 FC              	cld
397F:0016 33 C0           	xor	ax,ax
397F:0018 8B D8           	mov	bx,ax
397F:001A C4 7E 0A        	les	di,[bp+0Ah]
397F:001D 8B F7           	mov	si,di
397F:001F 32 C0           	xor	al,al
397F:0021 B9 FF FF        	mov	cx,0FFFFh

l397F_0024:
397F:0024 F2 AE           	repne scasb

l397F_0026:
397F:0026 F7 D1           	not	cx
397F:0028 8B FE           	mov	di,si
397F:002A C5 76 06        	lds	si,[bp+6h]

l397F_002D:
397F:002D F3 A6           	rep cmpsb

l397F_002F:
397F:002F 8A 44 FF        	mov	al,[si-1h]
397F:0032 26 8A 5D FF     	mov	bl,es:[di-1h]
397F:0036 2B C3           	sub	ax,bx
397F:0038 8E DA           	mov	ds,dx
397F:003A EB 00           	jmp	003Ch

l397F_003C:
397F:003C 5F              	pop	di
397F:003D 5E              	pop	si
397F:003E 5D              	pop	bp
397F:003F CB              	retf
