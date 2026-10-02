;;; Segment 3593 (3593:0000)

l358E_0050:
358E:0050 8B C6           	mov	ax,si
358E:0052 EB 00           	jmp	0054h

l358E_0054:
358E:0054 5F              	pop	di
358E:0055 5E              	pop	si
358E:0056 5D              	pop	bp
358E:0057 CB              	retf

;; SelectResourceDrive_0008: 3593:0008
;;   Called from:
;;     3390:0091 (in OpenTrackedFile)
SelectResourceDrive_0008 proc
3593:0008 55              	push	bp
3593:0009 8B EC           	mov	bp,sp
3593:000B 83 3E 68 B6 00  	cmp	word ptr [0B668h],0h
3593:0010 75 20           	jnz	0032h

l3593_0012:
3593:0012 33 C0           	xor	ax,ax
3593:0014 50              	push	ax
3593:0015 9A 81 4D 00 08  	call	far 0800h:4D81h
3593:001A 59              	pop	cx
3593:001B 83 3E 62 B6 00  	cmp	word ptr [0B662h],0h
3593:0020 74 10           	jz	0032h

l3593_0022:
3593:0022 83 7E 06 00     	cmp	word ptr [bp+6h],0h
3593:0026 7E 0A           	jle	0032h

l3593_0028:
3593:0028 B8 01 00        	mov	ax,1h
3593:002B 50              	push	ax
3593:002C 9A 81 4D 00 08  	call	far 0800h:4D81h
