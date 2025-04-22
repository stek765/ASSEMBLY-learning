# My first program from the book
# This program will exit with a status code of 3 ($echo?)
# - - - - - - - - - -


# Anything that starts with a . is an instruction to the assembler, called a directive
.global _start      # Tell the assembler not to discard the _start simbol, which is the entry point of the program
.section .text      # The section of the program that contains the code (text section)

# The assembler will put the code in the .text section
# The assembler will put the data in the .data section

# The _start label is the entry point of the program:
_start:
    # Exit with status code 0
    movq $60, %rax      # move a quadword (64 bits) into the rax register
    movq $3, %rdi       # status code: 3
    syscall             # invoke the syscall (S.O. call)
    

    