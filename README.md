# OS project

### To do 
- [ ] Set up GDT
- [ ] Set up IDT
- [ ] Switch to protected mode

### Notes

`boot.asm` contains the bootloader code. Boot signature `0x55AA` at the end of the first 512 bytes. The bootloader is running in real mode. Bootloader responsible for setting up environment and switching control to the kernel.

Real mode is a 16-bit mode on x86 processors. Processors run in real mode before switching to protected mode. BIOS functions are easily accessible in real mode. Amount of memory available is restricted and no security mechanisms.

Protected mode allows virtual address spaces, security features, etc. However, requires the programmer to set up interrupt tables, global descriptor tables, etc.

Real mode uses segmentation to address memory in the form A:B where `physical address = (A * 0x10) + B`. Segments overlap.

Protected mode also uses logical addresses in the form A:B, however, A is a selector. A selector is an offset in the Global Descriptor Table, where each descriptor describes the properties of each segment.

> "The memory management facilities of the IA-32 architecture are divided into two parts: segmentation and paging.
Segmentation provides a mechanism of isolating individual code, data, and stack modules so that multiple
programs (or tasks) can run on the same processor without interfering with one another. Paging provides a mech-
anism for implementing a conventional demand-paged, virtual-memory system where sections of a program’s
execution environment are mapped into physical memory as needed. Paging can also be used to provide isolation
between multiple tasks. When operating in protected mode, some form of segmentation must be used. There is
no mode bit to disable segmentation. The use of paging, however, is optional."
> "segmentation converts logical addresses to linear addresses. Paging (or linear-address
translation) is the process of translating linear addresses so that they can be used to access memory or I/O
devices. Paging translates each linear address to a physical address and determines, for each translation, what
accesses to the linear address are allowed (the address’s access rights) and the type of caching used for such
accesses (the address’s memory type)" - Intel Manual
