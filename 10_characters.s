# Characters, as usua, are approached with the ASCII table, which was created
# back when we had an 8-bit limitation of space..
# Of course today it had to be changed into something called UNICODE because 1 byte isn't enough to 
# represent all the characters in the world (> 255)

# To help the transition from ASCII to UNICODE, we have the UTF-8 encoding, which is backwards compatible with ASCII
# UTF-8 uses 1 byte for the first 128 characters (0-127) and 2 or more bytes for the rest of the characters
# UTF-8 is a variable-length encoding scheme, meaning that characters can be represented using 1 to 4 bytes
# ─────────────────────────────────────────────────────────────────────────────────────────────

# program example that counts the lowercase letters in a string:
.globl _start

.section .data
mytext:
    # .ascii is used to define a string of characters
    .ascii "This is a string of characters. \0" # \0 is used to terminate the string, is the null character (ASCII 0, zero)
    # ASCII code for single characters  
    # .byte 84, 104, 105, 115    # 'T' 'h' 'i' 's' 

.section .text
_start:
    ### Initialize registers ###
    movq $0, %rdi          # rdi will be used as a counter for lowercase letters
    movq $0, %rsi          # rsi will be used as a pointer to the string
    movq $mytext, %rbx     # rbx will be used as a pointer to the string

mainloop:
    movb (%rbx), %al # Load the next character from the string into al whch is the lower 8 bits of rax

    # quit if we reach the null terminator
    cmpb $0, %al  # '\0'
    je finish

    cmpb $'a', %al  # compare with 'a'
    jb loopcontrol

    cmpb $'z', %al  # compare with 'z'
    ja loopcontrol
    
    # If we reach here, it means we have a lowercase letter
    incq %rdi  # Increment the counter in rdi

loopcontrol:
    incq %rbx  # Move to the next character in the string
    jmp mainloop

finish:
    movq $60, %rax          # syscall: exit
    syscall
     
