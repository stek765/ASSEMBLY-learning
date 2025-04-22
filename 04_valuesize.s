
# In assembly, registers can have different sections representing different sizes (64-bit, 32-bit, 16-bit, 8-bit).

# For example, the RAX register (64-bit) has the following subdivisions:
# - EAX:        32-bit part of the RAX register.
# - AX:         16-bit part of the RAX register.
# - AH and AL:  8-bit parts of the AX register (AL is the lower part, AH is the upper part).

# This allows access to specific portions of the register for operations
# that require less space, optimizing resource usage.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# This comment explains the suffixes used in assembly language instructions to denote operand sizes:
# - 'b' (byte): Refers to an 8-bit operand.
# - 'w' (word): Refers to a 16-bit operand.
# - 'l' (long): Refers to a 32-bit operand.
# - 'q' (quadword): Refers to a 64-bit operand.
# These suffixes are typically appended to instructions to specify the size of the data being operated on.

# For example:
#   - 'movb' operates on 8-bit values.
#   - 'movw' operates on 16-bit values.
#   - 'movl' operates on 32-bit values.
#   - 'movq' operates on 64-bit values.
# Understanding these suffixes is crucial for writing and debugging assembly code, as they determine the size of registers and memory locations involved in operations.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


.globl _start
.section .text
_start:
    # Esempio di utilizzo di RAX, EAX, AX, AH e AL
    movq $0x1234567890abcdef, %rax  # Carica un valore a 64-bit in RAX      | (RAX = 0x1234567890ABCDEF)
    movl %eax, %ebx                 # Copia la parte a 32-bit (EAX) in EBX  | (EAX = 0x90ABCDEF), (EBX = 0x90ABCDEF)
    movw %ax, %cx                   # Copia la parte a 16-bit (AX) in CX    | (AX = 0xCDEF),      (CX = 0xCDEF)
    movb %al, %dl                   # Copia la parte a 8-bit (AL) in DL     | (AL = 0xEF),        (DL = 0xEF)
    movb $0x12, %ah                 # Carica un valore a 8-bit (AH)         | (AH = 0x12)
    
    # Uscita dal programma
    movq $60, %rax                  # syscall: exit
    xorq %rdi, %rdi                 # status code: 0
    syscall                         

    