;;; Segment 3989 (3989:0000)
3989:0000 C7 FF 8B E5 8B 56 08 8B 46 06 EB 00             .....V..F...    

l3985_004C:
3985:004C 5D              	pop	bp
3985:004D CB              	retf

;; DOS_GetSetFileAttributes: 3989:000E
;;   Called from:
;;     3915:0079 (in CRT_OpenFile)
;;     3915:0171 (in CRT_OpenFile)
DOS_GetSetFileAttributes proc
3989:000E 55              	push	bp
3989:000F 8B EC           	mov	bp,sp
3989:0011 1E              	push	ds
3989:0012 B4 43           	mov	ah,43h
3989:0014 8A 46 0A        	mov	al,[bp+0Ah]
3989:0017 8B 4E 0C        	mov	cx,[bp+0Ch]
3989:001A C5 56 06        	lds	dx,[bp+6h]
3989:001D CD 21           	int	21h
3989:001F 1F              	pop	ds
