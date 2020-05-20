disk_load:
        pusha
        push dx             ; Save how many sectors were requested
        
        mov ah, 0x02        ; BIOS read
        mov al, dh          ; Number of sectors to read
        mov ch, 0x00        ; Cylinder number
        mov cl, 0x02        ; Sector number
        mov dh, 0x00        ; Head number
        
        int 0x13            ; BIOS read
        
        jc disk_error       ; Jmp if error
        
        pop dx
        cmp dh, al          ; Cmp if all the requested sectors were read
        jne disk_error      ; Jmp if error
        popa
        ret

disk_error:
        mov bx, DISK_ERROR_MSG
        call print_string
        jmp $               ; Loop and hang

DISK_ERROR_MSG:
        db "Error reading disk", 0
