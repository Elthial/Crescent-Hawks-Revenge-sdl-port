;;; Segment 39F3 (39F3:0000)

;; CaptureInterruptSegmentState_0000: 39F3:0000
;;   Called from:
;;     39E5:001A (in InvokeInterruptWithRegisterBlocks)
CaptureInterruptSegmentState_0000 proc
39F3:0000 55              	push	bp
39F3:0001 8B EC           	mov	bp,sp
39F3:0003 56              	push	si
39F3:0004 8C C0           	mov	ax,es
39F3:0006 C4 76 06        	les	si,[bp+6h]
39F3:0009 26 89 04        	mov	es:[si],ax
39F3:000C 26 8C 4C 02     	mov	es:[si+2h],cs
