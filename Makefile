CC=i686-elf-gcc
CFLAGS=-O2 -g -ffreestanding -Wall -Wextra
LDFLAGS=-nostdlib -lgcc

CRTI_OBJ=boot/crti.o
CRTBEGIN_OBJ:=$(shell $(CC) $(CFLAGS) -print-file-name=crtbegin.o)
CRTEND_OBJ:=$(shell $(CC) $(CFLAGS) -print-file-name=crtend.o)
CRTN_OBJ=boot/crtn.o

OBJS=boot/boot.o kernel/kernel.o
LINKER=boot/linker.ld
LINK_LIST=$(CRTI_OBJ) $(CRTBEGIN_OBJ) $(OBJS) $(CRTEND_OBJ) $(CRTN_OBJ)

all: os-image

os-image: boot/linker.ld $(LINK_LIST)
	$(CC) -T $(LINKER) -o $@ $(CFLAGS) $(LINK_LIST) $(LDFLAGS)
	clean

%.o: %.c
	$(CC) -c $< -o $@ -std=gnu99 $(CFLAGS)

%.o: %.s
	$(CC) -c $< -o $@ $(CFLAGS)

clean:
	find . -name "*.o" -type f -delete
