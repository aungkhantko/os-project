CC=i686-elf-gcc
CFLAGS=-O2 -g -ffreestanding -Wall -Wextra
LDFLAGS=-nostdlib -lgcc

CRTI_OBJ=init/crti.o
CRTBEGIN_OBJ:=$(shell $(CC) $(CFLAGS) -print-file-name=crtbegin.o)
CRTEND_OBJ:=$(shell $(CC) $(CFLAGS) -print-file-name=crtend.o)
CRTN_OBJ=init/crtn.o

OBJS=kernel/system.o init/isr.o init/gdt.o init/idt.o boot/boot.o kernel/kernel.o
LINKER=boot/linker.ld
LINK_LIST=$(CRTI_OBJ) $(CRTBEGIN_OBJ) $(OBJS) $(CRTEND_OBJ) $(CRTN_OBJ)

all: os-image.iso

run: os-image.iso
	qemu-system-i386 -cdrom $<


os-image.iso: os-image.bin grub.cfg
	mkdir -p isodir/boot/grub
	cp os-image.bin isodir/boot/os-image.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o os-image.iso isodir

os-image.bin: boot/linker.ld $(LINK_LIST)
	$(CC) -T $(LINKER) -o $@ $(CFLAGS) $(LINK_LIST) $(LDFLAGS)

%.o: %.c
	$(CC) -c $< -o $@ -std=gnu99 $(CFLAGS)

%.o: %.s
	$(CC) -c $< -o $@ $(CFLAGS)

clean:
	find . -name "*.o" -type f -delete
