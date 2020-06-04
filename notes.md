# Boot sector programming
- boot sector 512 or 4096 bytes in size (512 bytes in this project)
- ends with magic number 0xaa55 (boot sector signature)
- initially boots in 16-bit real mode to support older operating systems
- modern operating systems switch to 32-bit or 64-bit after
- interrupts used to execute higher priority instructions
- BIOS sets up a table called the interrupt service routines (ISRs)
- data is passed to interrupt routines through registers
- BIOS stores boot drive in dl on start so useful to save for later operations

# Switching to 32-bit protected mode
- need to set up the Global Descriptor Table (GDT)
- GDT defines memory segments and their protected mode attributes
- Required to load a kernel compiled from a higher level language to 32-bit instructions
- Cannot use BIOS once in 32-bit protected mode
- Protected mode handles interrupts differently
- 16-bit interrupt handlers won't work in 32-bit mode
- Clear interrupt vector table, load global descriptor table, flush old instructions

# I/O
- memory mapped input/output
- direct memory access

# Screen
- memory mapped
- the screen has two internal registers, the control register and the data register
which can be used to query location of the cursor

# Summary
- OS boots into 16-bit real mode which exists on all x86 processors, and then switch into 
protected mode (32-bit in our case so far) before executing kernel code. Although protected mode 
prevents us from using BIOS interrupts, it enables the CPU to use more memory and set protection 
on memory. First of all, kernel code is loaded into memory. Next, interrupts are disabled and the 
GDT is loaded. Currently the GDT has two segments descriptors (code and data). The GDT is currently 
very simple and a higher level language will be used later to build upon it. After the GDT has 
been set up, a control register is set to switch into 32-bit mode and starts executing kernel code
which was earlier loaded into memory.

# More notes and questions on stuff (mostly to self)
- In a higher level operating system each process has its own set of registers? Segment registers
allow us to access a wide range of memory? If a GDT has only one code segment descriptor and one
data segment register, the process can only have one code and one data registers . However, different
proccesses can have their own and thus access different parts of memory. (More into LDT stuff?) 
[https://stackoverflow.com/questions/37554399/what-is-the-use-of-defining-a-global-descriptor-table] (https://stackoverflow.com/questions/37554399/what-is-the-use-of-defining-a-global-descriptor-table)

# Syntax and other stuff
```
$           ; Adress of current instruction
$$          ; Address of the beginning of the current section
$-$$        ; Length of section
int 0x10    ; Interrupt for BIOS video service
            ; Higher byte of ax used for mode
            ; Lower byte of axcharacter to print
int 0x13    ; BIOS disk read service
            ; ah 0x02 for read sector function
            ; al for number sectors to read
            ; dl for drive number
            ; ch for cylinder number
            ; dh for head number
            ; cl for sector on disk 
```
