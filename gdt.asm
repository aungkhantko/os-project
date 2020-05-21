; GDT
; Base address (32 bits) defines where segment begins
; Segment limit (20 bits) defines size of segment
; Flags (12 bits)
; GDT segment descriptor 8-byte structure
; bits 0 - 15           segment limit
; bits 15 - 31          base address
; bits 32 - 39          base address
; bits 40 - 43          type flags
;                       (code, conforming, readable, accessed)
; bits 44 - 47          other flags
;                       (descriptor type, privilege level, present)
; bits 48 - 51          segment limit                       
; bits 52 - 55          other flags
;                       (available for use by system software,
;                       64-bit code segment, default op size,
;                       granularity)
; bits 56 - 63          base address
gdt_start:

gdt_null:                               ; null descriptor
        dd 0x0
        dd 0x0

gdt_code:                               ; code segment descriptor
        dw 0xffff                       ; segment limit (bits 0 - 15)
        dw 0x0                          ; base address (bits 0 - 15)
        db 0x0                          ; base address (bits 16 - 23)
        db 10011010b                    ; type flags
        db 11001111b                    ; other flags
        db 0x0                          ; base address (bits 24 - 31)

gdt_data:                               ; data segment descriptor
        dw 0xffff                       ; segment limit (bits 0 -15)
        dw 0x0                          ; base address (bits 0 - 15)
        db 0x0                          ; base address (bits 16 -23)
        db 10010010b                    ; type flags
        db 11001111b                    ; other flags 
        db 0x0                          ; base address (bits 24 - 31)

gdt_end:

gdt_descriptor:                         ; gdt descriptor
        dw gdt_end - gdt_start - 1      ; declare size of gdt descriptor
        dd gdt_start                    ; declare address of gdt

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
