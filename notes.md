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
