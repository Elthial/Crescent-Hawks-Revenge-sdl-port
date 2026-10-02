;;; Segment 38C3 (38C3:0000)

l38AE_0150:
38AE:0150 5D              	pop	bp
38AE:0151 5F              	pop	di
38AE:0152 5E              	pop	si
38AE:0153 CB              	retf

;; TranslateDOSError: 38C3:0004
;;   Called from:
;;     3913:001A (in DOS_ResizeMemoryBlock)
;;     3915:0018 (in DOS_CreateFile)
;;     3915:006B (in CRT_OpenFile)
;;     3915:00A6 (in CRT_OpenFile)
;;     392F:0047 (in DOS_OpenFile)
;;     3934:0025 (in DOS_DeviceIOControl)
;;     3936:0022 (in CRT_CloseFile)
;;     3939:002B (in DOS_CloseFile)
;;     3948:0021 (in DOS_ReadFile)
;;     3961:0043 (in DOS_WriteFile)
;;     3965:002F (in DOS_SeekFile)
;;     3978:0018 (in DOS_DeleteFile)
;;     3989:0026 (in DOS_GetSetFileAttributes)
;;     39C0:0039 (in GetFileLength)
;;     39E5:00D2 (in InvokeInterruptThunk_0043)
TranslateDOSError proc
38C3:0004 55              	push	bp
38C3:0005 8B EC           	mov	bp,sp
38C3:0007 56              	push	si
38C3:0008 8B 76 06        	mov	si,[bp+6h]
38C3:000B 0B F6           	or	si,si
38C3:000D 7C 14           	jl	0023h

l38C3_000F:
38C3:000F 83 FE 58        	cmp	si,58h
38C3:0012 76 03           	jbe	0017h

l38C3_0014:
38C3:0014 BE 57 00        	mov	si,57h

l38C3_0017:
38C3:0017 89 36 AE 6F     	mov	[6FAEh],si
38C3:001B 8A 84 B0 6F     	mov	al,[si+6FB0h]
38C3:001F 98              	cbw
38C3:0020 96              	xchg	si,ax
38C3:0021 EB 0D           	jmp	0030h

l38C3_0023:
38C3:0023 F7 DE           	neg	si
38C3:0025 83 FE 23        	cmp	si,23h
38C3:0028 77 EA           	ja	0014h

l38C3_002A:
38C3:002A C7 06 AE 6F FF FF 	mov	word ptr [6FAEh],0FFFFh
