/*
==========================
POINTERS & MEMORY ACCESS (VERY IMPORTANT)
==========================

We have a variable called `array`, which stores a list of numbers in memory:
  array: [5, 20, 30]

Here’s how different syntax forms work in Assembly:

1. `$array` — Immediate address:
   - Gives you the **memory address** where the array starts.
   - It's like asking: "Where is the drawer located in memory?"

2. `array` — Direct memory access:
   - Retrieves the **value stored** at the label `array` (i.e., the first element).
   - It's like opening the drawer and taking the first item.

3. `%rsi` (or any register) — Pointer register:
   - When you do `movq $array, %rsi`, you're putting the array’s address into a register.
   - The register now acts like a **finger pointing** to the drawer.

4. `(%rsi)` — Dereferencing:
   - Tells the CPU: “Go to the address stored in %rsi and fetch the value there.”
   - Equivalent to `*rsi` in C.

Why is this useful?
---------------------
This allows us to read the array **dynamically**, without hardcoding values.
- We don’t need to know that the first value is 5.
- If the array changes, the program still works.
- We can loop through the array using pointer arithmetic:
    (%rsi), (%rsi + 8), (%rsi + 16), etc.

In contrast, **hardcoding** would mean doing:
    movq $5, %rax
Which only works if you’re sure the value is 5 — not flexible at all.

Summary:
---------
  $array     → the address of the array (like &array)
  array      → the value at the label (first element)
  %rsi       → a register holding the address (the pointer)
  (%rsi)     → the value in memory pointed to by %rsi (*rsi in C)

→ Pointer-based access gives flexibility, reusability, and dynamic array traversal.
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

    movq $array, %rbx         # %rbx = address of the array (current pointer)

    # oppure per migliroare la leggibilità della riga sopra:  - - - - - - - -
    leaq array, %rbx          # (leaq = load effective address)
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    movq $0, %rdi             # %rdi = max value found (initially 0)

    ### Edge case: if array is empty, exit ###
    cmpq $0, %rcx             # Compare array_size with 0
    je end_program            # If size is 0, exit

    ### Loop through the array ###
find_max:
    movq (%rbx), %rax         # Load current element into %rax
    cmpq %rdi, %rax           # Compare it with current max (%rdi)
    jbe skip                  # If max >= current, skip updating
    movq %rax, %rdi           # Update max with current value

skip:
    addq $8, %rbx             # Move to next element (8 bytes per quadword)
    loopq find_max            # Decrement %rcx and loop if not zero

### Exit program ###
end_program:
    movq $60, %rax            # syscall: exit
    movq %rdi, %rdi           # exit(%rdi) → return max as exit code
    syscall


    