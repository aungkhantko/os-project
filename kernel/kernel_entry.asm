; start exeution of kernel code 
; in the main function
[bits 32]
[extern main]
call main
jmp $
