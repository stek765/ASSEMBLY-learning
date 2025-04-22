# Calculate the tallest person in an array of structures:


.globl _start
.section .text

_start:
    ### Initialize Registers ###
    leaq people, %rbx      # %rbx = address of people array
    movq numpeople, %rcx   # %rcx = number of people
    movq $0, %rdi          # %rdi = max height found (initially 0)

    ### Check Preconditions ###
    # _if there are no records, finish
    cmpq $0, %rcx
    je end_program          # If numpeople == 0, jump to end_program

    ### Main Loop ###
mainloop:  
    movq HEIGHT_OFFSET(%rbx), %rax  # %rax = height of current person
    cmpq %rdi, %rax                 # Compare current height with max height
    jle skip                        # If current height <= max height, skip

    movq %rax, %rdi             # Update max height with current height

skip:
    addq PERSON_RECORD_SIZE, %rbx # Move to the next person
    loopq mainloop          # Decrement %rcx and loop if not zero
    
    ### Exit Program ###
end_program:
    movq $60, %rax          # syscall: exit
    syscall

