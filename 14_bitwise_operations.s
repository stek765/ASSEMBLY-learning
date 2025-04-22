# Most usefull bitwise operations (they change the bits of a number):

# AND -> &      (example: 0b00001111 & 0b00001010 = 0b00001010) or (andb %al %bl)
# OR  -> |
# XOR -> ^
# NOR -> ~(A | B) 
# NOT -> ~
# Left Shift  -> <<
# Right Shift -> >>

# the most used are AND, OR and XOR, NOT:
# AND is used to clear bits or for masking  (example: 0b00001111 & 0b00001010 = 0b00001010)
# OR is used to set bits                    (example: 0b00001111 | 0b00001010 = 0b00001111)
# XOR is used to toggle bits                (example: 0b00001111 ^ 0b00001010 = 0b00000101)

# another usefull operation is TEST:
# TEST is used to test bits without changing them (example: testb $0b0000001 , %bl -> jnz .. perché %bl != condition)  )

# - - - - - - - - - - - - - - - - - - - - - - - -
.globl _start
.section .text
_start:
    movq $60, %rax # syscall: exit
    syscall

    