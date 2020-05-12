    [org 0x7c00] 
    mov ah, 0x0e   
    mov bx, boot_message 
    call print_string

    jmp $

boot_message:
    db "Booting Operating System", 0

%include "print_string.asm"
%include "print_hex.asm"

    times 510-($-$$) db 0
    dw 0xaa55
