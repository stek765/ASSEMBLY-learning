# Assembly Jump Instructions Overview:

/* 
JZ (Jump if Zero) – jumps if ZF = 1 (result was zero)
JZ zero_label

JNZ (Jump if Not Zero) – jumps if ZF = 0 (result was not zero)
JNZ not_zero_label

JC (Jump if Carry) – jumps if CF = 1 (carry occurred)
JC carry_label

JNC (Jump if No Carry) – jumps if CF = 0 (no carry)
JNC no_carry_label

JE (Jump if Equal) – same as JZ
JE equal_label

JNE (Jump if Not Equal) – same as JNZ
JNE not_equal_label

JA (Jump if Above) – jumps if greater (unsigned): CF = 0 and ZF = 0
JA above_label

JAE (Jump if Above or Equal) – unsigned ≥ : CF = 0
JAE above_equal_label

JB (Jump if Below) – unsigned < : CF = 1
JB below_label

JBE (Jump if Below or Equal) – unsigned ≤ : CF = 1 or ZF = 1
JBE below_equal_label
*/

# - - - - - - - - - - - - - - - 
# Jump usage example (calculate 2^3):

.globl _start
.section .text

_start:
    movq $2, %rbx          # %rbx = 2
    movq $3, %rcx          # %rcx = 3
    movq $1, %rax          # %rax = 1 (result)

    cmpq $0, %rcx          # if the exponent is 0, we are done
    je complete            # jump to complete if exponent is 0


# entro in mainloop se il jmp non viene eseguito
mainloop:
    mulq %rbx              # multiply the result by the base
    loopq mainloop        # decrement the exponent and loop if not zero


complete:
    movq %rax, %rdi        # move the result to %rdi
    movq $60, %rax         # syscall: exit
    syscall                # exit(%rdi)
    