# One could also think to store multiple values in a single register
# it's a little more complicated, but it makes the code faster 

# Using little endian method, we can store multiple values in a single register starting from the 
# least significant byte (LSB) to the most significant byte (MSB)
# Example with the phrase 'This is a string of characters' => 'etc..' 's' 'i' ' ' 's' 'i' 'h' 'T'

# We then use the rotate instruction "rol" and "ror" to rotate the bits in the register
# ─────────────────────────────────────────────────────────────────────────────────────────────


# This program will count the number of lowercase letters in the string "This is a string of characters" 
# using the little endian method (so by storing the "string" into a single register)
.globl _start

.section .data
mytext:
    .ascii "This is a string of characters. \0" 

.section .text
_start:
    ### Initialize registers ###
    
    movq $mytext, %rbx     # rbx will be used as a pointer to the string
    movq $0, %rdi          # rdi will be used as a counter for lowercase letters

mainloop:
    movq (%rbx), %rax # Load the next 8 characters from the string into rax

byte1: 
    cmpb $0, %al  # '\0'
    je finish
    cmpb $'a', %al  # compare with 'a'
    jb byte2
    cmpb $'z', %al  # compare with 'z'
    ja byte2
    incq %rdi  # Increment the counter in rdi

byte2:
    cmpb $0, %ah # look in the upper register of rax if there's '\0'
    je finish

    cmpb $'a', %ah  # compare with 'a'
    jb byte3
    cmpb $'z', %ah  # compare with 'z'  
    ja byte3
    incq %rdi  # Increment the counter in rdi

byte3:
    # now we have to rotate the bits in rax to get the next byte
    rorq $16, %rax # rotate right 16 bits

    # and repeat the process
    cmpb $0, %al  
    je finish
    cmpb $'a', %al 
    jb byte2
    cmpb $'z', %al  
    ja byte2
    incq %rdi  

byte4:
    cmpb $0, %ah 
    je finish

    cmpb $'a', %ah 
    jb byte3
    cmpb $'z', %ah   
    ja byte3
    incq %rdi  

byte5:
    # rotate again
    rorq $16, %rax # rotate right 16 bits

    # and repeat the process
    cmpb $0, %al  
    je finish
    cmpb $'a', %al 
    jb byte2
    cmpb $'z', %al  
    ja byte2
    incq %rdi  

byte6:
    cmpb $0, %ah 
    je finish

    cmpb $'a', %ah 
    jb byte3
    cmpb $'z', %ah   
    ja byte3
    incq %rdi  

byte7:
    # rotate again
    rorq $16, %rax # rotate right 16 bits

    # and repeat the process
    cmpb $0, %al  
    je finish
    cmpb $'a', %al 
    jb byte2
    cmpb $'z', %al  
    ja byte2
    incq %rdi  

byte8:
    cmpb $0, %ah 
    je finish

    cmpb $'a', %ah 
    jb loopcontrol
    cmpb $'z', %ah   
    ja loopcontrol
    incq %rdi  


# byte1-8 -> 64 bit of the register

loopcontrol:
    addq $8, %rbx # move to the next 8 bytes (in this case non ghe nè)
    jmp mainloop

finish:
    movq $60, %rax          # syscall: exit
    syscall


# ─────────────────────────────────────────────────────────────────────────────────────────────
# there are several byte-oriented operations:
/*
    xchg: this instruction exchanges the contents of two registers
    bswap: this instruction reverses the byte order of a register
    ror: this instruction rotates the bits in a register to the right
    rol: this instruction rotates the bits in a register to the left
    shr: this instruction shifts the bits in a register to the right but fills the leftmost bits with 0
    shl: this instruction shifts the bits in a register to the left but fills the rightmost bits with 0
*/

