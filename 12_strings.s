# in Assemlby we can store string in 2 ways:
# 1. string with a fixed size
# 2. string with a dynamic size


# the first is simply hardcoding the string space in the code, example:
.section .data

.globl people
.globl PERSON_RECORD_SIZE

# Ogni record persona ha:
# - 32 byte per il nome (stringa con \0 alla fine)
# - 5 campi numerici da 8 byte = 40 byte
# → Totale: 72 byte
.equ PERSON_RECORD_SIZE, 72

people:
    # Persona 1
    .ascii "Gilbert Keith Chester\0"     # 22 byte (+ \0), gli altri 10 saranno padding
    .space 10                            # completa fino a 32 byte
    .quad 200, 10, 2, 74, 20             # peso, scarpe, capelli, altezza, età

    # Persona 2
    .ascii "Jonathan Bartlett\0"         # 18 byte
    .space 14                            # padding fino a 32
    .quad 180, 10, 3, 70, 25

# Altri record si aggiungono uno dopo l'altro

.section .text
.globl _start
_start:
    mov $60, %rax
    xor %rdi, %rdi
    syscall



