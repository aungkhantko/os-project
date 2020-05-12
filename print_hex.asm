; Convert hex bytes to their
; ASCII representation
print_byte:
    pusha
    mov bx, dx
    cmp bx, 0xA
    mov ah, 0x0e
    jge greater
; convert 0..9 to ASCII
    add bx, 0x30
    mov al, bl
    int 0x10
    jmp end
; convert A..F to ASCII
greater:
    add bx, 0x57
    mov al, bl
    int 0x10
    jmp end
