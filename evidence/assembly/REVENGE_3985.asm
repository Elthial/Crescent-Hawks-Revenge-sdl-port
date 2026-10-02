;;; Segment 3985 (3985:0000)
3985:0000 8B 46 06 EB 00                                  .F...           

l3983_0025:
3983:0025 5F              	pop	di
3983:0026 5E              	pop	si
3983:0027 5D              	pop	bp
3983:0028 CB              	retf

;; FillFarMemoryBytes: 3985:0009
;;   Called from:
;;     3985:003E (in FarMemorySet)
FillFarMemoryBytes proc
3985:0009 55              	push	bp
3985:000A 8B EC           	mov	bp,sp
3985:000C 56              	push	si
3985:000D 57              	push	di
3985:000E C4 7E 06        	les	di,[bp+6h]
3985:0011 8B 4E 0A        	mov	cx,[bp+0Ah]
3985:0014 8A 46 0C        	mov	al,[bp+0Ch]
3985:0017 8A E0           	mov	ah,al
3985:0019 FC              	cld
3985:001A F7 C7 01 00     	test	di,1h
3985:001E 74 04           	jz	0024h

l3985_0020:
3985:0020 E3 09           	jcxz	002Bh

l3985_0022:
3985:0022 AA              	stosb
3985:0023 49              	dec	cx

l3985_0024:
3985:0024 D1 E9           	shr	cx,1h

l3985_0026:
3985:0026 F3 AB           	rep stosw

l3985_0028:
3985:0028 73 01           	jnc	002Bh

l3985_002A:
3985:002A AA              	stosb

l3985_002B:
3985:002B 5F              	pop	di
3985:002C 5E              	pop	si
3985:002D 5D              	pop	bp
3985:002E CB              	retf

;; FarMemorySet: 3985:002F
;;   Called from:
;;     3A3C:0104 (in InitializeTimezoneFromEnvironment)
FarMemorySet proc
3985:002F 55              	push	bp
3985:0030 8B EC           	mov	bp,sp
3985:0032 FF 76 0A        	push	word ptr [bp+0Ah]
3985:0035 FF 76 0C        	push	word ptr [bp+0Ch]
3985:0038 FF 76 08        	push	word ptr [bp+8h]
3985:003B FF 76 06        	push	word ptr [bp+6h]
3985:003E 0E              	push	cs
3985:003F E8 C7 FF        	call	0009h
