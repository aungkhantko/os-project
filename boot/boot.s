.set ALIGN,    1<<0
.set MEMINFO,  1<<1
.set FLAGS,    ALIGN | MEMINFO
.set MAGIC,    0x1BADB002
.set CHECKSUM, -(MAGIC + FLAGS)
 
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

.global gdt_install

.section .text
.global _start
.type _start, @function
_start:
	mov $stack_top, %esp
	
	call gdt_install
	call kernel_main

	cli
1:	hlt
	jmp 1b
 
.size _start, . - _start

.global gdt_flush
.extern gp
gdt_flush:
	cli
	lgdt (gp)
	mov $0x10, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss
	jmp $0x08,$flush
flush:
	ret
