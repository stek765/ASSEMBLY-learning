# adding fixed-lenght data sections to programs, like assing a value to a variable:
# this program will initialize 3 quadwords of data, ad 2 of them and store the result last one
.globl _start

.section .data
first_value: .quad 4
second_value: .quad 6
final_result: .quad 0

.section .text
_start:
    # Load values into registers
    movq first_value,  %rbx       
    movq second_value, %rcx      

    # perform addition
    addq %rbx, %rcx

    # Store the result in final_result
    movq %rcx, final_result

    # Exit with status code 0
    movq $60, %rax              
    movq final_result, %rdi  
    syscall             


