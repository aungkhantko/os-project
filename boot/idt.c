#include "../kernel/system.h"

struct idt_entry {
	unsigned short offset_low;
	unsigned short selector;
	unsigned char zero;
	unsigned char flags;
	unsigned short offset_high;
} __attribute__((packed));

struct idt_ptr {
	unsigned short limit;
	unsigned int base;
} __attribute__((packed));

struct idt_entry idt[256];
struct idt_ptr idtptr;

extern void idt_load();

void idt_set_gate(unsigned char num, unsigned long offset, 
		unsigned short selector, unsigned char flags) {
	idt[num].offset_low = (offset & 0xFFFF);
	idt[num].offset_high = (offset >> 16) & 0xFFFF;

	idt[num].selector = selector;
	idt[num].zero = 0;
	idt[num].flags = flags;
}

void idt_install() {
	idtptr.limit = (sizeof (struct idt_entry) * 256) - 1;
	idtptr.base = &idt;	

	memset(&idt, 0, sizeof(struct idt_entry) * 256);
	idt_load();
}
