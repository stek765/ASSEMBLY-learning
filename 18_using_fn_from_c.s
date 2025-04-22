/* 

We can call our function from another programming language, such as C.

- - - - - - - - - 
C FILE:
int exponent (int, int);
int main(){
    return exponent(4, 2);
}
- - - - - - - - - 

 ASSEMBLY FILE:
 has the exponent function

 => we can compile like this: gcc File.c File.s -o File

*/












.globl _start
.section .text
_start:

    # Exit the program
    movq $60, %rax
    xor %rdi, %rdi
    syscall


