/*
A list of usefull instruction you should know:

1. More JUMP instructions: short, near, far, indirect:
    - short jump: a jump that is within the 127 bytes of the current instruction
    - near jump: a jump that is within the 2GB of the current instruction (it's the typical jump that we think of)
    - far jump: a jump that is outside of the current code segment (not used in modern x86-64)
    - indirect jump: a jump to an address stored in a register or memory location

2. Scanning for Bits:
    - bsf: bit scan forward (find the first set (1) bit)
    - bsr: bit scan reverse (find the last set bit)
    - bt:  bit test (test a specific bit in a register or memory location)
    - btr: bit test and reset (test a specific bit and reset it to 0)
    - btc: bit test and complement (test a specific bit and toggle it)



3. Managing status Flags:
    - clc: clear carry flag
    - stc: set carry flag
    - cld: clear direction flag
    - lah: load the common flags from EFLAGS register to %ah
    - sah: stores the common flags from ah to  EFLAGS register

4. Copying block of memory (very fast):
    - rep movsb: copy a block of memory from source to destination
    - rep stosb: copy a block of memory from destination to source
    - rep cmpsb: compare a block of memory from source to destination
    - rep scasb: scan a block of memory from source to destination

5. Length of a string:
    - strlen: get the length of a string
    - strnlen: get the length of a string with a maximum length
    - strlcpy: copy a string with a maximum length
    - strlcat: concatenate a string with a maximum length

*/

# - - - - - - - - - - - - - - - - - - - - - - - -
.globl _start
.section .text
_start:
    movq $60, %rax # syscall: exit
    syscall

    