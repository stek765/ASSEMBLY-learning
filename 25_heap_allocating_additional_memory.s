/*
As your program runs, if it needs more memory, it can ask the OS to allocate
more space (moving the Program Break). This is called dynamic memory allocation.
The OS will give you a chunk of memory, and you can use it as you like.

in C for example we use malloc() and free() to allocate and deallocate memory.
 - malloc() takes one parameter: the number of bytes to allocate and returns a pointer to the allocated memory.
 - free()   takes one parameter: the pointer to the memory to deallocate.


MALLOC is the high level idea (malloc uses brk or mmap underneath)
BRK    is the low level idea  (extend the classical heap)
MMAP   is a more flexible way to allocate memory (map memory at pleasure)


(mmap location can be override by the linux kernel and is limited to allocating in page size increments, 4096 bytes) [arrotonda alla page size piu vicina]
mmap takes a lot of parameters, but the most important ones are:

- addr:     the address to map the memory to   (or NULL to let the OS choose)
- length:   the size of the memory to allocate
- prot:     the protection flags               (read, write, execute)
- flags:    the flags for the mapping          (shared, private, etc)
- fd:       the file descriptor to map         (or -1 for anonymous memory)
- offset:   the offset in the file to map      (or 0 for anonymous memory)

munmap is the opposite of mmap, it unmaps the memory that was mapped with mmap.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
*/

# EXAMPLE OF USAGE:
# mov rax, 12        syscall brk → estende l'heap (classico, usato da malloc)
# mov rax, 9         syscall mmap → mappa memoria ovunque (più flessibile di brk)

.global _start
.section .text

_start:
    movq $60, %rax  # syscall: exit
    syscall


    