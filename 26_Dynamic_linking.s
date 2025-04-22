# Dynamic linking is a method of linking libraries to a program at runtime rather than at compile time.
# This means that the program can use shared libraries (Linux: shared objects, Windows: dynamic link libraries, Mac: dynamic libraries)
# which are loaded into memory only when needed (no copy of the library in the executable).
# This can save memory and disk space, and allows for easier updates to the libraries.

# Dynamic linking is done using the dynamic linker/loader, which is a part of the operating system.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# link_example.s:
.globl main

.section .data
output: .ascii "Hello, world!\n\0"

.section .text
main:
    enter $0, $0

    movq stdout, %rdi
    movq $output, %rsi
    call fprintf

    movq $0, %rax

    leave
    ret 

# Typically we execute the program with:
# $ gcc -static link_example.s  -o  link_example (this will create a static executable)

# if we run "strip link_example" -> we make the executable smaller by removing all the symbols and debugging information.

# if we run ldd link_example -> "not a dynamic executable"
# the file has a format known as "ELF" (Executable and Linkable Format).
# this format is used by the loader of the OS to load the file in memory and execute it. (there's no STACK OR HEAP here)

# We can use the -S flag to generate an assembly file from the C code:
# $ gcc -S link_example.c 

# We can inspect the file with:
# objdump -x link_example  (will show all the metadata in the ELF format, 
#                           WHICH ARE USED BY THE OS TO LOAD THE FILE IN MEMORY)
# for example:
# Idx Name          Size      VMA               LMA               File off  Algn
# 5  .text         0007ae10  00000000004010d0  00000000004010d0   000010d0  2**4
#                 CONTENTS, ALLOC, LOAD, READONLY, CODE

# (VMA = Virtual Memory Address, LMA = Load Memory Address)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# To LINK the program with the C library DINAMICALLY, we can use the following command:
# gcc -rdynamic link_example.s -o link_example (this will create a dynamic executable that is WAY SMALLER than the static one)

# if we run "ldd" -> 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x0000004002839000),  /lib64/ld-linux-x86-64.so.2 (0x0000004000000000)




