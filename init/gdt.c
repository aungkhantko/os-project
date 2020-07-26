/*
First four bytes
	bits 0 to 16 - segment limit low
	bits 16 to 31 - base address low
Second four bytes
	bits 0 to 7 - base address middle
	bits 8 to 15 - segment type (bits 8 to 11), descriptor type (bit 12),
			privilege level (bits 13 and 14), segment present (bit 15)
	bits 16 to 23 - segment limit high (bits 16 to 19), available (bit 20),
			64-bit code segment (bit 21), default OP size (bit 22),
			granularity (bit 23)
	bits 24 to 31 - base address high
*/

struct gdt_entry {
	unsigned short limit_low;
	unsigned short base_low;
	unsigned char base_middle;
	unsigned char access;
	unsigned char granularity;
	unsigned char base_high;
} __attribute__((packed));

struct gdt_ptr {
	unsigned short limit;
	unsigned int base;
} __attribute__((packed));

/* Null segment, code segment and data segment */
struct gdt_entry gdt[3];
struct gdt_ptr gp;

extern void gdt_flush();

void gdt_set_descriptor(int num, unsigned long base, unsigned long limit, 
		unsigned char access, unsigned char gran) {
	gdt[num].base_low = (base & 0xFFFF);
	gdt[num].base_middle = (base >> 16) & 0xFF;
	gdt[num].base_high = (base >> 24) & 0xFF;

	gdt[num].limit_low = (limit & 0xFFFF);
	gdt[num].granularity = (limit >> 16) & 0xF;

	gdt[num].granularity |= gran & 0xF0;
	gdt[num].access = access;
}

void gdt_install() {
	gp.limit = (sizeof(struct gdt_entry) * 3) - 1;
	gp.base = &gdt;

	/* Null descriptor */
	gdt_set_descriptor(0, 0, 0, 0, 0);

	/* Code segment */
	gdt_set_descriptor(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);

	/* Data segment */
	gdt_set_descriptor(2, 0, 0xFFFFFFFF, 0x92, 0xCF);

	gdt_flush();
}
