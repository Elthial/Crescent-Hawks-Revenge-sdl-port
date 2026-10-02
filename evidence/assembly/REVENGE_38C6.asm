;;; Segment 38C6 (38C6:0000)

l38C3_0030:
38C3:0030 8B C6           	mov	ax,si
38C3:0032 A3 7F 00        	mov	[007Fh],ax
38C3:0035 B8 FF FF        	mov	ax,0FFFFh
38C3:0038 EB 00           	jmp	003Ah

l38C3_003A:
38C3:003A 5E              	pop	si
38C3:003B 5D              	pop	bp
38C3:003C CA 02 00        	retf	2h
38C3:003F                                              CB                .

;; RunExitHandlersAndTerminate_0010: 38C6:0010
;;   Called from:
;;     0D56:00AB (in PrintAllocationErrorAndExit)
;;     0D73:485A (in ShowInvalidSaveVersionDialog_4611)
;;     3390:002F (in ShutdownAndExit)
RunExitHandlersAndTerminate_0010 proc
38C6:0010 55              	push	bp
38C6:0011 8B EC           	mov	bp,sp
38C6:0013 EB 0C           	jmp	0021h

l38C6_0015:
38C6:0015 8B 1E 18 70     	mov	bx,[7018h]
38C6:0019 D1 E3           	shl	bx,1h
38C6:001B D1 E3           	shl	bx,1h
38C6:001D FF 9F 08 B8     	call	dword ptr [bx+0B808h]

l38C6_0021:
38C6:0021 A1 18 70        	mov	ax,[7018h]
38C6:0024 FF 0E 18 70     	dec	word ptr [7018h]
38C6:0028 0B C0           	or	ax,ax
38C6:002A 75 E9           	jnz	0015h

l38C6_002C:
38C6:002C FF 1E 0A 70     	call	dword ptr [700Ah]
38C6:0030 FF 1E 0E 70     	call	dword ptr [700Eh]
38C6:0034 FF 1E 12 70     	call	dword ptr [7012h]
38C6:0038 FF 76 06        	push	word ptr [bp+6h]
38C6:003B 9A 0D 01 00 08  	call	far 0800h:010Dh
38C6:0040 59              	pop	cx
38C6:0041 5D              	pop	bp
38C6:0042 CB              	retf
38C6:0043          55 8B EC 83 3E 18 70 20 75 05 B8 01 00    U...>.p u....
38C6:0050 EB 1E 8B 56 08 8B 46 06 8B 1E 18 70 D1 E3 D1 E3 ...V..F....p....
38C6:0060 89 97 0A B8 89 87 08 B8 FF 06 18 70 33 C0 EB 00 ...........p3...
