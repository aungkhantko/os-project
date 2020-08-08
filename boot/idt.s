.extern idtptr
.global idt_load

.global isr0
.global isr1
.global isr2
.global isr3
.global isr4
.global isr5
.global isr6
.global isr7

idt_load:
	lidt (idtptr)
	ret

isr0:
	cli
	push $0
	push $0
	jmp isr_common_stub

isr1:
	cli
	push $0
	push $1
	jmp isr_common_stub

isr2:
	cli
	push $0
	push $2
	jmp isr_common_stub


isr3:
	cli
	push $0
	push $3
	jmp isr_common_stub

isr4:
	cli
	push $0
	push $4
	jmp isr_common_stub

isr5:
	cli
	push $0
	push $5
	jmp isr_common_stub

isr6:
	cli
	push $0
	push $6
	jmp isr_common_stub

isr7:
	cli
	push $0
	push $7
	jmp isr_common_stub

.extern fault_handler

isr_common_stub:
	pusha
	push %ds
	push %es
	push %fs
	push %gs
	mov $0x10, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %esp, %eax
	push %eax
	mov fault_handler, %eax
	call %eax
	pop %eax
	pop %gs
	pop %fs
	pop %es
	pop %ds
	popa
	add $8, %esp
	iret
