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
