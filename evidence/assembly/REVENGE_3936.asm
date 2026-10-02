;;; Segment 3936 (3936:0000)
3936:0000 EB 0A                                           ..              

l3934_0022:
3934:0022 EB 08           	jmp	002Ch

l3934_0024:
3934:0024 50              	push	ax
3934:0025 9A 04 00 C3 38  	call	far 38C3h:0004h
3934:002A EB 00           	jmp	002Ch

l3934_002C:
3934:002C 5D              	pop	bp
3934:002D CB              	retf

;; CRT_CloseFile: 3936:000E
;;   Called from:
;;     2C7F:04D4 (in LoadMediaConfiguration_047A)
;;     2C7F:0526 (in LoadMediaConfiguration_047A)
;;     2C7F:0540 (in LoadMediaConfiguration_047A)
;;     3390:0279 (in CloseTrackedFile)
;;     3390:0641 (in CanOpenFileForRead)
;;     3390:068E (in CanOpenFileForWrite)
;;     3390:0BBC (in InitializeResourceCache)
;;     3477:017B (in LoadFontResource_000B)
CRT_CloseFile proc
3936:000E 55              	push	bp
3936:000F 8B EC           	mov	bp,sp
3936:0011 56              	push	si
3936:0012 8B 76 06        	mov	si,[bp+6h]
3936:0015 0B F6           	or	si,si
3936:0017 7C 05           	jl	001Eh

l3936_0019:
3936:0019 83 FE 14        	cmp	si,14h
3936:001C 7C 0B           	jl	0029h

l3936_001E:
3936:001E B8 06 00        	mov	ax,6h
3936:0021 50              	push	ax
3936:0022 9A 04 00 C3 38  	call	far 38C3h:0004h
3936:0027 EB 13           	jmp	003Ch

l3936_0029:
3936:0029 8B DE           	mov	bx,si
3936:002B D1 E3           	shl	bx,1h
3936:002D C7 87 2A 71 FF FF 	mov	word ptr [bx+712Ah],0FFFFh
