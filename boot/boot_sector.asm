[org 0x7c00] 
KERNEL_OFFSET equ 0x1000

        ; set up stack 
        mov bp, 0x9000       
        mov sp, bp

        ; print booting message 
        mov bx, BOOT_MSG
        call print_string

        ; save disk drive
        mov [BOOT_DRIVE], dl    


        ; load kernel code into memory
        call load_kernel
        call switch_to_pm
       
        jmp $

%include "./boot/disk_load.asm"
%include "./boot/gdt.asm"
%include "./boot/print_string.asm"
%include "./boot/switch_to_pm.asm"

[bits 16]
load_kernel:
        mov bx, KERNEL_OFFSET
        mov dh, 1
        mov dl, [BOOT_DRIVE]
        call disk_load
        ret

[bits 32]
begin_pm:
        mov ebx, BOOT_MSG_PM
        call print_string_pm
        call KERNEL_OFFSET
        jmp $

BOOT_MSG:
        db "Booting Operating System in 16-bit real mode", 0

BOOT_MSG_PM:
        db "Booting Operating System in 32-bit protected mode", 0

BOOT_DRIVE:
        db 0

times 510-($-$$) db 0
dw 0xaa55
