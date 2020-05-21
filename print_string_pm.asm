[bits 32]
; constants
VIDEO_MEMORY equ 0xb8000                ; start of video memory
WHITE_ON_BLACK equ 0x0f

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
