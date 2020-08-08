# OS project

### To do 
- [ ] Set up GDT
- [ ] Set up IDT
- [ ] Switch to protected mode

### Notes

`boot.asm` contains the bootloader code. Boot signature `0x55AA` at the end of the first 512 bytes. The bootloader is running in real mode. Bootloader responsible for setting up environment and switching control to the kernel.

Real mode is a 16-bit mode on x86 processors. Processors run in real mode before switching to protected mode. BIOS functions are easily accessible in real mode. Amount of memory available is restricted and no security mechanisms.

Protected mode allows virtual address spaces, security features, etc. However, requires the programmer to set up interrupt tables, global descriptor tables, etc.
