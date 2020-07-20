all: os-image
	make clean

run: all
	qemu-system-i386 -kernel os-image

os-image: boot.o kernel.o
	i686-elf-gcc -T boot/linker.ld -o os-image -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

boot.o: boot/boot.s
	i686-elf-as boot/boot.s -o boot.o

kernel.o: kernel/kernel.c
	i686-elf-gcc -c kernel/kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

clean:
	rm -rf *.o
