CFLAGS=-O2 -g -ffreestanding -Wall -Wextra
LIBS=-nostdlib -lk -lgcc

KERNEL_OBJS=kernel/kernel.o

OBJS=crti.o crtbegin.o $(KERNEL_OBJS) crtend.o crtn.o

LINK_LIST=crti.o crtbegin.o $(KERNEL_OBJS) $(LIBS) crtend.o crtn.o

all: os-image

os-image: $(OBJS) boot/linker.ld
	i686-elf-gcc -T boot/linker.ld -o $@ $(CFLAGS) $(LINK_LIST)
