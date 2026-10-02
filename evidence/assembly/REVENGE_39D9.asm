;;; Segment 39D9 (39D9:0000)
39D9:0000 F7 E2 C4 5E 06 26 89 47 04 8B E5 5D CB          ...^.&.G...].   

;; DOS_GetSystemDate: 39D9:000D
;;   Called from:
;;     39CC:001F (in CaptureLocalClockSnapshot_000F)
;;     39CC:0037 (in CaptureLocalClockSnapshot_000F)
DOS_GetSystemDate proc
39D9:000D 55              	push	bp
39D9:000E 8B EC           	mov	bp,sp
39D9:0010 B4 2A           	mov	ah,2Ah
39D9:0012 CD 21           	int	21h
39D9:0014 C4 5E 06        	les	bx,[bp+6h]
39D9:0017 26 89 0F        	mov	es:[bx],cx
39D9:001A C4 5E 06        	les	bx,[bp+6h]
39D9:001D 26 89 57 02     	mov	es:[bx+2h],dx
39D9:0021 5D              	pop	bp
39D9:0022 CB              	retf

;; DOS_GetSystemTime: 39D9:0023
;;   Called from:
;;     39CC:002B (in CaptureLocalClockSnapshot_000F)
DOS_GetSystemTime proc
39D9:0023 55              	push	bp
39D9:0024 8B EC           	mov	bp,sp
39D9:0026 B4 2C           	mov	ah,2Ch
39D9:0028 CD 21           	int	21h
39D9:002A C4 5E 06        	les	bx,[bp+6h]
39D9:002D 26 89 0F        	mov	es:[bx],cx
