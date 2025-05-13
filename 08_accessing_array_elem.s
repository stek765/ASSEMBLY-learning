/*
==============================
ACCESSING ARRAY ELEMENTS IN ASSEMBLY (EASY EXPLANATION)
==============================

Imagine this in C:
    int array[] = {5, 20, 33, 80};
    int x = array[i];

In Assembly, there's no "array" type.
You only have memory addresses and you must calculate where each element is.

When we declare:
    array: .quad 5, 20, 33, 80

Each number takes 8 bytes (because .quad = 64-bit).
So the memory layout looks like this:

    array[0] → at address: array + 0 * 8
    array[1] → at address: array + 1 * 8
    array[2] → at address: array + 2 * 8
    etc...

To read array[i] in Assembly:
    - Put the index (i) into a register (e.g., %rbx)
    - Multiply it by 8 (because each element is 8 bytes)
    - Add the result to the base address of the array

GOOD NEWS: Assembly does this for you with this syntax:
    array(, %rbx, 8)

This means:
    address = array + (index_in_rbx * 8)

So this line:
    movq array(, %rbx, 8), %rax

...does exactly what this would do in C:
    rax = array[rbx];

It goes to the right memory slot and loads the value.


/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
==============================
          SUMMARY: 

DIFFERENT WAYS TO ACCESS ARRAYS:
==============================

There are two common ways to access arrays in Assembly:

────────────────────────────────────
1. POINTER-BASED ACCESS → (%rbx)
────────────────────────────────────
- You store the address of the array into a register.
- Then you dereference the register to get the value at that memory.

Example:
    movq $array, %rbx      ; %rbx = address of array[0]
    movq (%rbx), %rax      ; %rax = value at array[0]

To move to the next element:
    addq $8, %rbx          ; go to array[1]
    movq (%rbx), %rax      ; %rax = value at array[1]

This is similar to using a pointer in C:
    int* p = array;
    x = *p;
    p++;

───────────────────────────────────────────────
2. INDEXED ACCESS → array(, %rbx, 8)
───────────────────────────────────────────────
VALUE(BASEREG, IDXREG, MULTIPLIER) => address = VALUE + BASEREG + IDXREG * MULTIPLIER

- You treat the array like a normal array in C.
- You keep the index (i) in a register like %rbx.
- Assembly calculates the offset for you: array + i * 8

Example:
    movq $2, %rbx                  ; %rbx = index i
    movq array(, %rbx, 8), %rax    ; %rax = array[2]

This is equivalent to:
    int x = array[i];

────────────────────────────────────
📌 WHEN TO USE WHAT?
────────────────────────────────────
Use (%reg)      → when you're scanning with a pointer
Use label(, %reg, 8) → when you're scanning with an index

Both work well. Use the one that matches your logic.
==============================

*/




.globl _start

.section .data
# Number of elements in the array
array_size: .quad 7

# Array of 7 quadwords (64-bit integers)
array: .quad 5, 20, 33, 80, 52, 10, 1

.section .text
_start:
    ### Initialization ###
    movq array_size, %rcx     # %rcx = number of elements (loop counter)
    movq $0, %rbx             # %rbx = index of the first element
    movq $0, %rdi             # %rdi = max value found (initially 0)

    ### Edge case: if array is empty, exit ###
    cmpq $0, %rcx             # Compare array_size with 0
    je end_program            # If size is 0, exit

    ### Loop through the array ###
find_max:
    movq array(, %rbx, 8), %rax  # Load current element into %rax
    cmpq %rdi, %rax              # Compare it with current max (%rdi)
    jbe skip                     # If max >= current, skip updating
    movq %rax, %rdi              # Update max with current value

skip:
    incq %rbx                    # Move to next element (increment index)
    loopq find_max            # Decrement %rcx and loop if not zero

### Exit program ###
end_program:
    movq $60, %rax            # syscall: exit
    movq %rdi, %rdi           # exit(%rdi) → return max as exit code
    syscall




# - - - - - -
/* LEA (Load Effective Address):  LEA is like a calculator for addresses!!

LEA is used to calculate addresses without accessing memory. So it's efficient compared to MOV or ADD 
and it's dynamic.

EXAMPLE:
    lea array(, %rbx, 8), %rax
    (This loads the address of array[rbx] into rax without accessing the memory)

    or 

    leaq (%rbx,%rcx,4), %rax    -> AT&T SYNTAX 
    (Having rbx as the base address of an array, i can use lea to calculate
    the address with a dynamic index in rcx and a multiplier of 4)

    lea rax, [rbx + rcx*4]  -> INTEL SYNTAX
*/

