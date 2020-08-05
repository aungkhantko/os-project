.global gdt_install
.global gdt_flush
.extern gdtptr 
gdt_flush:
	cli
	lgdt (gdtptr)
	mov $0x10, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss
	jmp $0x08,$flush
flush:
	ret
