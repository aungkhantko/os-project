disk_load:
	push dx		; save states
	mov ah, 0x02	; BIOS read function
	mov al, dh	; Read DH number of sectors
	mov ch, 0x00	; Cylinder 0
	mov dh, 0x00	; Head 0
	mov cl, 0x02	; Start reading from sector 2

	int 0x13	; BIOS read interrupt

	jc disk_error	; Jump if error

	pop dx		; Restore dx
	cmp dh, al	; Check if dh sectors are read
	jne disk_error	; Jump if not
	ret		; Return

disk_error:
	mov bx, DISK_ERR_MSG
	call print_string
	jmp $

DISK_ERR_MSG:
	db "Disk read error", 0
