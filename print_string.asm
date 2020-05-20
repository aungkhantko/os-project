print_string:
        pusha                   ; save registers
        mov ah, 0x0e            ; set mode
loop:
        mov cx, [bx]            ; copy contents of bx to cx
        cmp cl, 0x0             ; compare lower byte to 0x0
        je end                  ; if null-byte jump to end
        mov al, cl              ; mov lower byte of cx to al
        int 0x10                ; print
        add bx, 0x1             ; go to next character
        jmp loop                ; loop
end:
        popa
        ret
