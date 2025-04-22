/*
 General-purpose registers in x86-64 architecture:

 rax: register often used to store return values from functions.
 rbx: typically used as a base pointer in some addressing modes.
 rcx: commonly used as a counter in loops or string operations.
 rdx: often used for I/O operations or as an additional argument register.

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 this ones are intended to be used as pointers:

 rsi: Source index register, typically used in string and memory operations as a source pointer.
 rdi: Destination index register, often used in string and memory operations as a destination pointer.
 rbp: Base pointer register, traditionally used to point to the base of the current stack frame.
 rsp: Stack pointer register, always pointing to the top of the stack.

 r8 to r15: Extended general-purpose registers available in 64-bit mode, used for additional arguments or temporary storage.

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 You can write a binary number using the prefix 0b, for example:
 movq $0b101010, %rax  

 You can write a hexadecimal number using the prefix 0x, for example:
 movq $0xFF, %rax

 You can write a decimal number using the prefix $ (dollar sign), for example:
 movq $255, %rax

*/













.globl _start
.section .text
_start:
    movq $60, %rax          # syscall: exit
    movq $3, %rdi           # status code: 3
    syscall                 # invoke the syscall (S.O. call)



