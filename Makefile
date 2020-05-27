all: kernel.bin boot_sector.bin

kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.o : kernel.c
	i386-elf-gcc -ffreestanding -c $^ -o $@

kernel_entry.o : kernel_entry.asm
	nasm $^ -f elf -o $@

boot_sector.bin: boot_sector.asm
	nasm $^ -f bin -o $@

clean:
	rm *.bin *.o
