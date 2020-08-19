; BIOS checks for a boot signature 0x55, 0xAA
; loads the boot sector at 0x0000:0x7c00 
; (segment 0, address 0x7c00)

[org 0x7c00]	; code loaded to 0x7c00
	mov [BOOT_DRIVE], dl	; Save drive number
				; BIOS saves drive number to dl by default

	mov bp, 0x8000		; Set up stack at 0x8000
	mov sp, bp		; Set stack pointer to base pointer

	mov dh, 2		; Number of sectors to read
	mov dl, [BOOT_DRIVE]	; Drive number
	mov bx, 0x9000		; Memory to read to
	call disk_load		; Call disk_load

	mov bx, [0x9000]	; test disk_load 0xbaba
	call print_hex

	mov bx, [0x9000 + 512]	; test disk_load 0xdede
	call print_hex

	mov bx, BOOT_MSG	; print boot message
	call print_string

	call switch_to_pm

	jmp $

%include "print.asm"
%include "disk.asm"
%include "vga.asm"
%include "gdt.asm"
%include "switch.asm"

protected_mode:
	mov ebx, BOOT_MSG32
	call print_string_vga
	jmp $

BOOT_DRIVE:
	db 0

BOOT_MSG:
	db "Booting Operating System in 16-bit real mode", 0

BOOT_MSG32:
	db "Booting into 32-bit protected mode", 0

times 510-($-$$) db 0
dw 0xaa55	; boot signature

times 256 dw 0xbaba
times 256 dw 0xdede
