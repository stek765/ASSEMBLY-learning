/* 
The CONVENTION FOR FUNCTION CALLS is know as ABI (Application Binary Interface), in Linux x86_64 V-ABI:

 • Preservation of registers: %rbp, %rbx, and %r12-%r15 must be preserved (so can't overwrite them)
 • Passing INPUT parameters: the first 6 parameters are passed in THIS ORDER:
                                                                    %rdi, 
                                                                    %rsi, 
                                                                    %rdx, 
                                                                    %rcx, 
                                                                    %r8,
                                                                    %r9

 • Returning output parameters: %rax
 • Moving the stack pointer: %rbp = used to store the value of the current stack frame (don't change it)
                             %rsp = used to point to the top of the stack (you can change it)
*/
# - - - - - - - - - - - - - - - - - - - - - - - - - -



# STACK WITH FUNCTIONS:

# 1) When the program starts, it gets allocated a stack space of 2MB (default) and a heap space of 128MB (default)
# The stack grows downwards (from high memory to low memory) and the heap grows upwards (from low memory to high memory)

# 2) %rsp = points to the top of the stack (the last value pushed onto the stack). 
#           It update automatically every time you push or pop a value from the stack

# 3) _start my code:       -      %rbp = has random value (so we need to save it)

# - - FUNCTION CALL - -  (call function_name)
# 5) push function_name         // push the function address onto the stack !!!
# 6) jmp function_name

# - - FUNCTION BEGINS - -
# 7) push %rbp                  // save the old base pointer
# 8) mov %rsp, %rbp             // rbp = top of the stack (where rsp points to)
# 9) sub $8, %rsp               // decide how much space to allocate on the stack for local variables

# - - FUNCTION WORKS - -
# ...            // do some work here  ( a + b ) -> gets saved in %rax DEFAULT!!!!

# - - FUNCTION ENDS - -
# 10) mov %rbp, %rsp            // restore the stack pointer to the old base pointer
# 11) pop %rbp                  // take the old base pointer from the stack
# 12) ret                       // return to the caller (5) (pop the return address from the stack and jump to it)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# - - ALTERNATIVE: ENTER and LEAVE - -
# Instead of:
#   push %rbp
#   mov %rsp, %rbp
#   sub $X, %rsp
#   ...
#   mov %rbp, %rsp
#   pop %rbp
# 
# You can use:
#   enter $X, $0     // X = space to allocate for local variables (stack frame), 0 = nesting level
#   ...
#   leave            // equivalent to: mov %rbp, %rsp + pop %rbp
#
# Note: Less commonly used today because they are slightly slower and less explicit in modern compilers









.globl _start
.section .text

_start:
    movq $60, %rax # syscall: exit
    syscall







