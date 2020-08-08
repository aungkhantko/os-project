all: boot.bin

run: boot.bin
	qemu-system-i386 $<

boot.bin: boot.asm print.asm
	nasm -f bin $< -o $@
