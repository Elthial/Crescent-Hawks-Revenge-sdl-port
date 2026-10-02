;;; Segment 34A7 (34A7:0000)
34A7:0000 C4 08                                           ..              

l3495_0122:
3495:0122 5F              	pop	di
3495:0123 5E              	pop	si
3495:0124 5D              	pop	bp
3495:0125 CB              	retf
3495:0126                   55 8B EC 33 C0 50 9A 94 00 A7       U..3.P....
3495:0130 34 59 5D CB                                     4Y].            

;; InstallDefaultCriticalErrorHandler_0014: 34A7:0014
;;   Called from:
;;     2C7F:0296 (in InitializeGame_003C)
InstallDefaultCriticalErrorHandler_0014 proc
34A7:0014 0E              	push	cs
34A7:0015 B8 06 00        	mov	ax,6h
34A7:0018 50              	push	ax
34A7:0019 9A 59 00 A7 34  	call	far 34A7h:0059h
34A7:001E 59              	pop	cx
34A7:001F 59              	pop	cx
34A7:0020 CB              	retf
34A7:0021    50 53 51 52 06 1E 56 57 55 BD 6A 3A 8E DD 8B  PSQR..VWU.j:...
34A7:0030 EC 8B C4 A3 8C B8 FF 76 04 FF 76 00 FF 76 10 8B .......v..v..v..
34A7:0040 46 02 25 FF 00 50 FF 1E 88 B8 8B E5 89 46 10 5D F.%..P.......F.]
34A7:0050 5F 5E 1F 07 5A 59 5B 58 CF                      _^..ZY[X.       

;; InstallCriticalErrorHandler_0059: 34A7:0059
;;   Called from:
;;     34A7:0019 (in InstallDefaultCriticalErrorHandler_0014)
InstallCriticalErrorHandler_0059 proc
34A7:0059 55              	push	bp
34A7:005A 8B EC           	mov	bp,sp
34A7:005C C4 5E 06        	les	bx,[bp+6h]
34A7:005F 8C 06 8A B8     	mov	[0B88Ah],es
34A7:0063 89 1E 88 B8     	mov	[0B888h],bx
34A7:0067 0E              	push	cs
34A7:0068 B8 21 00        	mov	ax,21h
34A7:006B 50              	push	ax
34A7:006C B8 24 00        	mov	ax,24h
34A7:006F 50              	push	ax
34A7:0070 9A 1E 00 E3 39  	call	far 39E3h:001Eh
34A7:0075 8B E5           	mov	sp,bp
34A7:0077 5D              	pop	bp
34A7:0078 CB              	retf
34A7:0079                            55 8B EC 56 57 8B 46          U..VW.F
34A7:0080 06 8B 26 8C B8 5D 5F 5E 1F 07 5A 59 5B 44 44 CF ..&..]_^..ZY[DD.
34A7:0090 5F 5E 5D CB 55 8B EC 56 57 33 C0 50 33 C0 50 B8 _^].U..VW3.P3.P.
34A7:00A0 54 00 50 9A 07 00 68 3A 83 C4 06 8B 46 06 8B 2E T.P...h:....F...
34A7:00B0 8C B8 83 C5 1A 8B E5 80 4E 14 01 5B 59 5A 5E 5F ........N..[YZ^_
