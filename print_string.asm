; -- print_string --
print_string:
        pusha                           ; save registers
        mov ah, 0x0e                    ; set mode
loop:
        mov cx, [bx]                    ; copy contents of bx to cx
        cmp cl, 0x0                     ; compare lower byte to 0x0
        je end                          ; if null-byte jump to end
        mov al, cl                      ; mov lower byte of cx to al
        int 0x10                        ; print
        add bx, 0x1                     ; go to next character
        jmp loop                        ; loop
end:
        mov al, 0x20
        int 0x10
        popa
        ret

; -- print_hex --
print_hex:
        pusha                           ; save registers
        mov ax, 5                       ; use ax as counter
        mov dx, bx                      ; copy contents of bx to dx
print_hex_loop:
        cmp ax, 2                       ; to format hex value to 0x0000
        jl print                        ; if offset < 2 end loop and print
        mov cx, dx                      ; copy value of dx to cx
        and cx, 0xF                     ; and contents of cx with 0xF 0b1111

        cmp cx, 0x9                     ; if hex value > 9, offset of 0x57
        jg greater
        add cx, 0x30                    ; add 0x30 to get ASCII representation of hex
        jmp continue
greater:
        add cx, 0x57                    ; add 0x57 to get ASCII representation of hex
continue:
        mov bx, HEX_OUT                 ; get offset in memory location HEX_OUT
        add bx, ax                      ; add offset in memory location
        mov byte [bx], cl               ; put one byte of data at offset
        sub ax, 1                       ; decrement counter for loop
        shr dx, 4                       ; shift right by 4
        jmp print_hex_loop              ; repeat
print:
        mov bx, HEX_OUT                 ; place address of HEX_OUT in bx
        call print_string               ; print string
        popa
        ret

HEX_OUT:
        db '0x0000', 0                  ; Hex to print


[bits 32]
; constants
VIDEO_MEMORY equ 0xb8000                ; start of video memory
WHITE_ON_BLACK equ 0x0f

; -- print_string_pm --
print_string_pm:
        pusha
        mov edx, VIDEO_MEMORY
print_string_pm_loop:
        mov al, [ebx]                   ; char stored at ebx
        mov ah, WHITE_ON_BLACK          ; mov attributes

        cmp al, 0                       ; if null character, end
        je print_string_pm_done

        mov [edx], ax                   ; move char to video memory
        add ebx, 1                      ; move to next character
        add edx, 2                      ; move to next video memory
                                        ; cell
        jmp print_string_pm_loop
print_string_pm_done:
        popa
        ret
