print_hex:
    pusha               ; save registers
    mov ax, 5           ; use ax as counter
    mov dx, bx          ; copy contents of bx to dx

print_hex_loop:
    cmp ax, 2           ; to format hex value to 0x0000
    jl print            ; if offset < 2 end loop and print
    mov cx, dx          ; copy value of dx to cx
    and cx, 0xF         ; and contents of cx with 0xF 0b1111

    cmp cx, 0x9         ; if hex value > 9, offset of 0x57
    jg greater 
    add cx, 0x30        ; add 0x30 to get ASCII representation of hex 
    jmp continue

greater:
    add cx, 0x57        ; add 0x57 to get ASCII representation of hex

continue:
    mov bx, HEX_OUT     ; get offset in memory location HEX_OUT
    add bx, ax          ; add offset in memory location
    mov byte [bx], cl   ; put one byte of data at offset 
    sub ax, 1           ; decrement counter for loop
    shr dx, 4           ; shift right by 4
    jmp print_hex_loop  ; repeat

print:
    mov bx, HEX_OUT     ; place address of HEX_OUT in bx
    call print_string   ; print string
    popa
    ret
    
HEX_OUT:
    db '0x0000', 0      ; Hex to print
