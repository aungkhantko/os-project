; BIOS checks for a boot signature 0x55, 0xAA
; loads the boot sector at 0x0000:0x7c00 
; (segment 0, address 0x7c00)

[org 0x7c00]	; code loaded to 0x7c00
mov bx, BOOT_MSG
call print_string

mov ax, 0x1337
mov bx, ax
call print_hex
jmp $

%include "print.asm"

BOOT_MSG:
	db "Booting Operating System in 16-bit real mode", 0

times 510-($-$$) db 0
dw 0xaa55	; boot signature
