;;; Segment 39E3 (39E3:0000)
39E3:0000 8B C7 8C C2 EB 00                               ......          

l39DC_0076:
39DC:0076 5F              	pop	di
39DC:0077 5E              	pop	si
39DC:0078 8B E5           	mov	sp,bp
39DC:007A 5D              	pop	bp
39DC:007B CB              	retf
39DC:007C                                     55 8B EC B4             U...
39DC:0080 35 8A 46 06 CD 21 8B C3 8C C2 EB 00 5D CB       5.F..!......].  

;; DOS_SetInterruptVector: 39E3:001E
;;   Called from:
;;     34A7:0070 (in InstallCriticalErrorHandler_0059)
DOS_SetInterruptVector proc
39E3:001E 55              	push	bp
39E3:001F 8B EC           	mov	bp,sp
