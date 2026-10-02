;;; Segment 39C4 (39C4:0000)
39C4:0000 00                                              .               

l39C0_0041:
39C0:0041 8B E5           	mov	sp,bp
39C0:0043 5D              	pop	bp
39C0:0044 CB              	retf

;; ParseSignedDecimalLong: 39C4:0005
;;   Called from:
;;     3A3C:013A (in InitializeTimezoneFromEnvironment)
ParseSignedDecimalLong proc
39C4:0005 55              	push	bp
39C4:0006 8B EC           	mov	bp,sp
39C4:0008 56              	push	si
39C4:0009 57              	push	di
39C4:000A 06              	push	es
39C4:000B 55              	push	bp
39C4:000C C4 76 06        	les	si,[bp+6h]
39C4:000F FC              	cld
39C4:0010 2B C0           	sub	ax,ax
39C4:0012 99              	cwd
39C4:0013 B9 0A 00        	mov	cx,0Ah
39C4:0016 B7 00           	mov	bh,0h
39C4:0018 BF 29 70        	mov	di,7029h

l39C4_001B:
39C4:001B 26 8A 1C        	mov	bl,es:[si]
39C4:001E 46              	inc	si
39C4:001F F6 01 01        	test	byte ptr [bx+di],1h
39C4:0022 75 F7           	jnz	001Bh

l39C4_0024:
39C4:0024 BD 00 00        	mov	bp,0h
39C4:0027 80 FB 2B        	cmp	bl,2Bh
39C4:002A 74 06           	jz	0032h

l39C4_002C:
39C4:002C 80 FB 2D        	cmp	bl,2Dh
39C4:002F 75 05           	jnz	0036h

l39C4_0031:
39C4:0031 45              	inc	bp

l39C4_0032:
39C4:0032 26 8A 1C        	mov	bl,es:[si]
39C4:0035 46              	inc	si

l39C4_0036:
39C4:0036 80 FB 39        	cmp	bl,39h
39C4:0039 77 2F           	ja	006Ah

l39C4_003B:
39C4:003B 80 EB 30        	sub	bl,30h
39C4:003E 72 2A           	jc	006Ah

l39C4_0040:
39C4:0040 F7 E1           	mul	cx
39C4:0042 03 C3           	add	ax,bx
39C4:0044 12 D6           	adc	dl,dh
39C4:0046 74 EA           	jz	0032h

l39C4_0048:
39C4:0048 EB 12           	jmp	005Ch

l39C4_004A:
39C4:004A 8B FA           	mov	di,dx
39C4:004C B9 0A 00        	mov	cx,0Ah
39C4:004F F7 E1           	mul	cx
39C4:0051 97              	xchg	di,ax
39C4:0052 87 D1           	xchg	cx,dx
39C4:0054 F7 E2           	mul	dx
39C4:0056 92              	xchg	dx,ax
39C4:0057 97              	xchg	di,ax
39C4:0058 03 C3           	add	ax,bx
39C4:005A 13 D1           	adc	dx,cx

l39C4_005C:
39C4:005C 26 8A 1C        	mov	bl,es:[si]
39C4:005F 46              	inc	si
39C4:0060 80 FB 39        	cmp	bl,39h
39C4:0063 77 05           	ja	006Ah

l39C4_0065:
39C4:0065 80 EB 30        	sub	bl,30h
39C4:0068 73 E0           	jnc	004Ah

l39C4_006A:
39C4:006A 4D              	dec	bp
39C4:006B 7C 07           	jl	0074h

l39C4_006D:
39C4:006D F7 DA           	neg	dx
39C4:006F F7 D8           	neg	ax
39C4:0071 83 DA 00        	sbb	dx,0h

l39C4_0074:
39C4:0074 5D              	pop	bp
39C4:0075 07              	pop	es
39C4:0076 EB 00           	jmp	0078h

l39C4_0078:
39C4:0078 5F              	pop	di
39C4:0079 5E              	pop	si
39C4:007A 5D              	pop	bp
39C4:007B CB              	retf
39C4:007C                                     55 8B EC FF             U...
