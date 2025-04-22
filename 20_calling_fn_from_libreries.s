# there are 2 types of libraries available on Linux: static and shared libraries

# static libraries -> libX.a where X is the name of the library (.a stands for archive)
# shared libraries -> libX.so where X is the name of the library (.so stands for shared object)

# to tell the linker to link the file and include functions from the library:
# ld file.o -static -lc -o file  

# -static = link statically, incorporate the library into the executable (adds about 500KB to the executable)
# -lc     = link the C library

# - - - - - - - -

# We use main instead of _start because of the compiler GCC 

# - - - - - - - - - - - - - - - - -
/*

.globl main
.section .text

main:
    # this is a functionm but there are no local variables, so we don't need to create a stack frame

    # first parameter is -5
    movq $-5, %rdi
    
    # call the function
    call abs

    # the result is already in %rax, so we can just return

    # since main is called from the standard C library, we need to exit using the C library instead
    # of using syscall
    ret
*/
# - - - - - - - - - - - - - - - - -


# we use gcc to take care of assembling and linking all the needed components using:
# gcc absmain.s -static -o absmain

# when using gcc, it automatically links the C library, so we don't need to specify -lc
# but we can use -l syntax to specify the library we want to link with
# for example, to link with the math library, we can use -lm






.globl _start
.section .text
_start:
    # exit
    movq $60, %rax
    syscall


