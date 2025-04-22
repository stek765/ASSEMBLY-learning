/* i modi in assembly per scrivere decimali, binari, ottali e esadecimali:

 1. decimale: 1234                 (default)
 2. binario: 0b0000010011010010    (0b)
 3. ottale: 01234                  (0)
 4. esadecimale: 0x1234            (0x)

 - - - - - - - - - - - - - - - - - - - - - - -

 Signed integers in assembly are represented using 2's complement (complemento a 2):
 1. Se il numero è positivo, il bit più significativo (MSB) è 0. | positive -> 01111111 = 127
 2. Se il numero è negativo, il bit più significativo (MSB) è 1. | negative -> 10000000 = -128

 11111111 = -1

 HOW TO CALCULATE A NEGATIVE NUMBER:
 1) WRITE THE POSITIVE NUMBER IN BINARY 
 2) INVERT THE BITS (0 -> 1, 1 -> 0)
 3) ADD 1 TO THE RESULT

 - - - - - - - - - - - - - - - - - - - - - - -

 Add and Sub with signed numbers are the same as with unsigned numbers
 it's on us to interpret the result as signed or unsigned

 but we can use the instruction "cmp" to compare signed numbers
 cmp is used to compare two numbers and set the flags accordingly

 the flags are:
 - ZF: zero flag (set if the result is zero)
 - SF: sign flag (set if the result is negative)
 - OF: overflow flag (set if the result is too large to be represented)
 - CF: carry flag (set if there was a carry out of the most significant bit)


 we can use the flags to determine if the result is negative or positive

 jz: jump if zero
 jnz: jump if not zero

 js: jump if sign
 jns: jump if not sign

 jo: jump if overflow
 jno: jump if not overflow

 jc: jump if carry
 jnc: jump if not carry

 jg: jump if greater
 jge: jump if greater or equal

 jl: jump if less
 jle: jump if less or equal
*/

# - - - - - - - - - - - - - - - - - - - - - - - -
.globl _start
.section .text
_start:
    movq $60, %rax # syscall: exit
    syscall
