> The System V Application Binary Interface is a set of specifications that detail calling conventions, object file formats, executable file formats, dynamic linking semantics, and much more for systems that complies with the X/Open Common Application Environment Specification and the System V Interface Definition. It is today the standard ABI used by the major Unix operating systems such as Linux, the BSD systems, and many others. The Executable and Linkable Format (ELF) is part of the System V ABI.
>
> Toolchains such as i686-elf-gcc generate code and executable files according to this ABI. 
>
> The System V ABI (as used by i686-elf-gcc, x86\_64-elf-gcc, and other ELF platforms) specifies use of five different object files that together handle program initialization. These are traditionally called crt0.o, crti.o, crtbegin.o, crtend.o, and crtn.o. Together these object files implement two special functions: \_init which runs the global constructors and other initialization tasks, and \_fini that runs the global destructors and other termination tasks. 
>
> (https://wiki.osdev.org/System\_V\_ABI)

`crt{i, begin, end, n}.o` provide initialization and termination functions which will be linked in and called from `boot.o`.

> The GRUB bootloader to bootload your kernel using the Multiboot boot protocol that loads us into 32-bit protected mode with paging disabled.
>
> The ELF as the executable format that gives us control of where and how the kernel is loaded.
>
> (https://wiki.osdev.org/Bare\_Bones)
