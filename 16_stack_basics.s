/*
 What is the stack? (on x86-64 systems, stack space default is limited to 2 megabytes):
	•	It’s a special area in memory that works like a LIFO (Last In, First Out) structure.
	•	You push data onto the stack to save it temporarily.
	•	You pop data from the stack to retrieve it.
	•	It’s also used for function calls, to store return addresses and parameters.

push eax  
pop ebx    
*/

# Esempio fattoriali usando lo stack:
# 5! = 5 * 4 * 3 * 2 * 1

.globl _start

.section .data
value:
    .quad 5 # The number to calculate the factorial of

.section .text
_start:
    ### Initialize Registers ###    
    pushq $0    # Push 0 onto the stack to stop the loop
    movq value, %rax # Load the value from memory into rax

# Push all the values from 1 to n (5 in this case) to the stack
pushvalues:
    pushq %rax # Push the current value of rax onto the stack
    decq %rax
    jnz pushvalues # Jump to pushvalues if rax is not zero

    movq $1, %rax # Initialize rax to 1 (the factorial result)

multiply:
    popq %rcx       # Pop the top value from the stack into rcx
    cmpq $0, %rcx   # Check if the stack is empty
    je complete     # If it is, jump to complete

    mulq %rcx    # Multiply rax by rcx

    jmp multiply # Jump back to multiply

complete:
    movq %rax , %rdi  # Move the result into rdi for printing
    movq $60, %rax   # syscall: exit
    syscall



    
