# Boot sector programming
- boot sector 512 or 4096 bytes in size (512 bytes in this project)
- ends with magic number 0xaa55 (boot sector signature)
- initially boots in 16-bit real mode to support older operating systems
- modern operating systems switch to 32-bit or 64-bit after
- interrupts used to execute higher priority instructions
- BIOS sets up a table called the interrupt service routines (ISRs)
- data is passed to interrupt routines through registers

# Syntax and other stuff
```
$           ; Adress of current instruction
$$          ; Address of the beginning of the current section
$-$$        ; Length of section
int 0x10    ; Interrupt for BIOS video service
            ; Higher byte used for mode
            ; Lower byte character to print
```
