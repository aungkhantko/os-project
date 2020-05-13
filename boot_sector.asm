    [org 0x7c00] 
    mov ah, 0x0e
    mov bx, boot_message 
    call print_string
    mov bx, [inspect]
    call print_hex

    jmp $

%include "print_string.asm"
%include "print_hex.asm"

inspect:
    db "AAAA", 0

boot_message:
    db "Booting Operating System", 0

    times 510-($-$$) db 0
    dw 0xaa55
