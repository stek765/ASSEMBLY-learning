/*
the GNU assembler has a whole plethora od directives such as .secction, .quad, .ascii, .equ etc..
Now we will look at some of the most common and useful assembler directives:

- - - - - - - - - - - - -
RESERVING SPACE FOR DATA
- - - - - - - - - - - - -
• Alongside .quad and .byte:
  - .short (16 bits)
  - .long  (32 bits)
  - .skip  (allocate space)  or  .space  or  .zero (mydata: .space 1000 -> reserve 1000 bytes and point to the starting address)

• Alongside .ascii:
  - .string (is the same as .ascii but adds a null terminator)

- - - - - - - - - - - - -
CODE AND DATA ALIGNMENT
- - - - - - - - - - - - -
In computers, the address that a value starts in memory matters and it's important to align it properly.
ALIGNING is a process of arranging data in memory so that it is stored at a specific address to make it work faster.

in most computers we deal with 8-byte word, then it's best to align data on 8-byte boundaries.
BUT some vector instructions require 16-byte alignment, so it's best to align data on 16-byte boundaries as a STANDARD.

there are several alignment functions avaible on the GNU assembler:
- .balign  (align to the next 8-byte boundary)
- .p2align (align to the next 2^n byte boundary)
- .align   (align to the next n byte boundary) [NOT RECCOMENDED]

- - - - - - - - - - - - -
OTHER SECTIONS AND DIRECTIVES:
- - - - - - - - - - - - -
- .section .rodata (read-only data)
- .section .bss (uninitialized data)

- - - - - - - - - - - - -
LOCAL AND GLOBAL VALUES
- - - - - - - - - - - - -
– .global (make a symbol available to other files)
– .local (make a symbol local to the file)
- .lcomm (allocate space in the .bss section, local by default)

- - - - - - - - - - - - -
INCLUDING OTHER CODE
- - - - - - - - - - - - -
- .include (include another file)
- .incbin (include binary data) (e.g. .incbin "mydata.bin")

- - - - - - - - - - - - -
ANNOTING CODE
- - - - - - - - - - - - -
– .type (set the type of a symbol, for .globl the type directive lets the linker know what kind of symbol it is.
        wheter function (specified by @function) or data (specified by @object)).
    
e.g. .global main, mydata
     .type main, @function
     .type mydata, @object




*/





.globl _start
.section .text

_start:
  movq $60, %rax  # syscall: exit
  syscall


  