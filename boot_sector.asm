[org 0x7c00] 
        ; -- print message --
        mov bx, boot_message
        call print_string

        ; -- disk load --
        mov [BOOT_DRIVE], dl    ; save boot drive
        
        mov bp, 0x9000          ; set stack
        mov sp, bp
        
        mov bx, 0x9000          ; set location to read to
        mov dh, 1               ; number of sectors to read
        mov dl, [BOOT_DRIVE]    ; set boot drive
        call disk_load          ; load disk contents to memory
        
        mov bx, [0x9000]        ; read contents from disk
        call print_hex          ; print

        ; -- switch --
        call switch_to_pm
        
        jmp $

%include "disk_load.asm"
%include "gdt.asm"
%include "print_hex.asm"
%include "print_string.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 32]

BEGIN_PM:
        mov ebx, boot_message_pm
        call print_string_pm
        jmp $

boot_message:
        db "Booting Operating System in 16-bit real mode", 0

boot_message_pm:
        db "Booting Operating System in 32-bit protected mode", 0

BOOT_DRIVE:
        db 0


times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0x1337
