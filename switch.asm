[bits 16]
; Switch to protected mode
switch_to_pm:
        cli                     ; disable interrupts
        lgdt [gdt_descriptor]   ; load gdt

        mov eax, cr0            ; set protection enable (PE) bit
        or eax, 0x1		; to enter protected mode
        mov cr0, eax

        jmp CODE_SEG:init_pm 

[bits 32]
init_pm:
        mov ax, DATA_SEG        ; Update registers and 
        mov ds, ax
        mov ss, ax
        mov es, ax
        mov fs, ax
        mov gs, ax

        mov ebp, 0x90000        ; Update stack
        mov esp, ebp
        
        call protected_mode
