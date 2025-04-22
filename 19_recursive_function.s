# function to calculate factorial of a number in a recursive way
# each time the function is called, a NEW stack frame is created!

# in each recursive calls, the result has to be stored in the stack 
# otherwise it would get overwritten by the next function call (%rax)

/* AN EXAMPLE OF THE IDEA:
    enter $16, $0            # 16 bytes stack frame
    mov %rdi, -8(%rbp)       # store first param (a)
    mov %rsi, -16(%rbp)      # store second param (b)

    mov -8(%rbp), %rax       # load a into rax
    add -16(%rbp), %rax      # add b to rax
*/

# factorial function using recursion:
.globl factorial
.section .text

factorial:
    enter $16, $0  # aligned to 16 bytes

    cmpq $1, %rdi
    jne continue

    movq $1, %rax
    leave 
    ret 

continue:
    movq %rdi, -8(%rbp) # store n in local variable
    decq %rdi # n = n - 1
    call factorial # recursive call

    mulq -8(%rbp) # multiply the result by n
    leave
    ret

# IT'S A BEST PRACTICE TO USE .equ TO DEFINE STACK FRAME OFFSET
# .equ LOCAL_NUM, -8   (not global obviously, and always with LOCAL_...)

# we us it like this:  movq %rdi,  LOCAL_NUM(%rbp)









.globl _start
.section .text
_start:
    # exit
    movq $60, %rax
    syscall



    