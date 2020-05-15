[org 0x7c00] 
    mov [BOOT_DRIVE], dl

    mov bp, 0x8000
    mov sp, bp

    mov bx, 0x9000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    
    mov bx, [0x9000]
    call print_hex

    jmp $

%include "disk_load.asm"
%include "print_string.asm"
%include "print_hex.asm"

boot_message:
    db "Booting Operating System", 0

BOOT_DRIVE:
    db 0


times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xadde
times 256 dw 0xefbe    
