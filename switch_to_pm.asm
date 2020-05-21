[bits 16]
; Switch to protected mode
switch_to_pm:
        cli                     ; clear interrupt vector table
        lgdt [gdt_descriptor]   ; load global descriptor table

        mov eax, cr0            ; set first bit of the control 
        or eax, 0x1             ; register to switch to 32-bit
        mov cr0, eax            ; mode

        jmp CODE_SEG:init_pm    ; make a far jump to a different
                                ; segment to flush instructions

[bits 32]
init_pm:
        mov ax, DATA_SEG        ; Update registers and 
        mov ds, ax              ; segment pointers
        mov ss, ax
        mov es, ax
        mov fs, ax
        mov gs, ax

        mov ebp, 0x90000        ; Update stack
        mov esp, ebp
        
        call BEGIN_PM 
