;;; Segment 3A04 (3A04:0000)

l39F8_00C0:
39F8:00C0 8B 56 FE        	mov	dx,[bp-2h]
39F8:00C3 8B 46 FC        	mov	ax,[bp-4h]
39F8:00C6 EB 00           	jmp	00C8h

l39F8_00C8:
39F8:00C8 8B E5           	mov	sp,bp
39F8:00CA 5D              	pop	bp
39F8:00CB CB              	retf

;; UppercaseStringInPlace: 3A04:000C
;;   Called from:
;;     2C7F:05BD (in LoadMediaConfiguration_047A)
;;     2C7F:0694 (in ApplyVideoConfigOption_0669)
;;     2C7F:0758 (in ApplyMusicConfigOption_072D)
;;     2C7F:07F9 (in ApplySoundConfigOption_07CE)
;;     2C7F:0876 (in ApplySoundConfigOption_07CE)
;;     2C7F:08F5 (in ApplyInputDeviceConfigOption_08CA)
;;     3390:06A8 (in GetResourceDriveMask)
;;     3390:0A8A (in InitializeResourceCache)
;;     3390:0C0B (in IsResourceCached)
;;     3390:0C92 (in FindResourceDescriptorIndex)
UppercaseStringInPlace proc
3A04:000C 55              	push	bp
3A04:000D 8B EC           	mov	bp,sp
3A04:000F 56              	push	si
3A04:0010 FC              	cld
3A04:0011 1E              	push	ds
3A04:0012 C5 76 06        	lds	si,[bp+6h]
3A04:0015 8B D6           	mov	dx,si
3A04:0017 EB 0B           	jmp	0024h

l3A04_0019:
3A04:0019 2C 61           	sub	al,61h
3A04:001B 3C 19           	cmp	al,19h
3A04:001D 77 05           	ja	0024h

l3A04_001F:
3A04:001F 04 41           	add	al,41h
3A04:0021 88 44 FF        	mov	[si-1h],al

l3A04_0024:
3A04:0024 AC              	lodsb
3A04:0025 22 C0           	and	al,al
3A04:0027 75 F0           	jnz	0019h

l3A04_0029:
3A04:0029 8B C2           	mov	ax,dx
3A04:002B 8C DA           	mov	dx,ds
3A04:002D 1F              	pop	ds
3A04:002E 5E              	pop	si
3A04:002F 5D              	pop	bp
