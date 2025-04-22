# Virtual Memory, Memory Map, Execution Flow 
# Assembly + Virtual Memory
# ================================


# --------------------------------
# MEMORY IS LINEAR (NOT VERTICAL)
# --------------------------------
# Think of RAM as a huge line of bytes:
#
#  [0x000000000000] First address
#  [0x000000000001]
#  ...
#  [0x00007FFFFFFFF] Last user-space address (47-bit limit) (SHOUDL BE 64-BIT, but they are way to many bits)


# LINUX uses 47-bit virtual addresses.
# Each memory address = 1 byte
# 2^47 = 128 TB addressable space (on x86-64 Linux)
#
# Your program uses virtual addresses.
# The OS + CPU translates them to real RAM locations!!!!!

# --------------------------------
# MEMORY LAYOUT OF A PROCESS
# (simplified and visual)
# --------------------------------
#     Virtual Address Space (↑ RAM from the top)
#
#     0x7FFFFFFFFFFF  ─────▶ [ STACK     ]  ← grows downward
#     0x7Fxxxxxx....         [ mmap      ]  ← shared libs, files
#     0x0060xxxx....         [ HEAP      ]  ← malloc, grows upward
#     0x00400000             [ CODE      ]  ← your instructions
#     0x0030xxxx....         [ DATA/BSS  ]  ← globals, static vars
#     0x000000000000         [ NULL PAGE ]  ← protected (crash if used)

# The OS gives only what's needed.
# Other regions are unused, or reserved.



# --------------------------------
# WHERE INSTRUCTIONS GO
# --------------------------------
# Your code (like mov/add/etc) is loaded into the
# "CODE" section (also called .text segment).
# Each instruction is turned into bytes in memory.

.globl _start
.section .text


_start:
    mov $1, %rax     # occupies 5 bytes in the .text/code section 
                      # in binary: # 0xB8 0x01 0x00 0x00 0x00

    add $2, %rax      # occupies 3 bytes (for example)
    nop             # 1 byte (No Operation - filler)

# These instructions live in virtual memory,
# and are fetched by the CPU, translated to real RAM.

# --------------------------------
# STACK EXAMPLE
# --------------------------------
# The stack stores local variables & function frames.
# It grows downward (toward lower addresses).
# Example: pushing value to stack

    push %rax        # write RAX to stack (uses memory at ESP)
    pop %rax         # restore it from stack



# When there's a miss in the RAM, the CPU fetches the data from the disk (called a page fault -> SWAP).






# EXIT PROGRAM
    movq $60, %rax  
    syscall







