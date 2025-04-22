.globl _start
.section .text
_start: 
    movq $3, %rdi          # %rdi = 3
    movq %rdi, %rax        # %rax = %rdi
    addq %rdi, %rax        # %rax += %rdi
    mulq %rdi              # %rax *= %rdi
    movq $2, %rdi          # %rdi = 2
    subq %rdi, %rax        # %rax -= %rdi
    movq $4, %rdi          # %rdi = 4
    incq %rdi              # %rdi++
    movq $2, %rbx          # %rbx = 2
    divq %rbx              # %rax = %rdi / %rbx
    movq $60, %rax         # %rax = 60 (exit)
    syscall                # exit(%rdi) = 5


    ### Documentation Comment
    /*
     1. **MOVQ (Move Quadword)**:
        - Used to transfer data between registers, memory, or immediate values.
        - Syntax: `movq source, destination`
        - Ensure that the source and destination are compatible in size (64-bit for `movq`).
        - Example: `movq %rax, %rbx` moves the value in `%rax` to `%rbx`.
    
     2. **SUB (Subtract)**:
        - Performs subtraction between two operands and stores the result in the destination.
        - Syntax: `sub source, destination`
        - The destination operand is updated with the result of `destination - source`.
        - Example: `sub $5, %rax` subtracts 5 from `%rax`.
    
     4. **MULQ (Unsigned Multiply)**:
        - Multiplies the value in `%rax` by the source operand.
        - Syntax: `mulq source`
        - The result is stored in `%rax` (low 64 bits) and `%rdx` (high 64 bits).
        - Example: `mulq %rbx` multiplies `%rax` by `%rbx`.

     5. **INCQ (Increment)**:
        - Increments the value of the destination operand by 1.
        - Syntax: `incq destination`
        - Example: `incq %rdi` increments `%rdi` by 1.

     6. **DIVQ (Unsigned Divide)**:
        - Divides the value in `%rax` by the source operand.
        - Syntax: `divq source`
        - The quotient is stored in `%rax`, and the remainder is stored in `%rdx`.
        - Example: `divq %rbx` divides `%rax` by `%rbx`.

     7. **ADDQ (Add Quadword)**:
        - Adds the source operand to the destination operand.
        - Syntax: `addq source, destination`
        - The destination operand is updated with the result.
        - Example: `addq %rbx, %rax` adds `%rbx` to `%rax`.

     8. **SYSCALL (System Call)**:
        - Executes a system call based on the values in specific registers.
        - Syntax: `syscall`
        - Example: `movq $60, %rax; syscall` exits the program with the status in `%rdi`.
    
    */

    