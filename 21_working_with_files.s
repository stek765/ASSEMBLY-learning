# C library makes so much easier to work with files, in fact it does most of the work for us
# it uses a data structure called FILE to represent a file. We'll use an opaque pointer
# to this structure to refer to the file in our program.

# - - - BASIC OPERATIONS WITH FILES - - - 
# to OPEN a file      -> fopen   (filename, mode)            [mode: r, w, a, r+ (read/write)] 
# to READ from a file -> fread   (buffer, size, count, file)
# to WRITE to a file  -> fprintf (file, format, args...)     [format for example: "%d apples to %s"]
# to CLOSE a file     -> fclose  (file)
# - - - - - - - - - - - - - - - - - - - -

# the open results in the opaque FILE pointer, that we store and use to refer to the file
# if the open fails, %rax = 0 instead of the pointer (called null pointer!!)



# example of program that open a file called myout.txt, write two formatted strings to the file, and then close the file:
.global main

.section .data
filename: 
    .ascii "myfile.txt\0"
openmode:
    .ascii "w\0" # open  MODE for writing
formatstring1:
    .ascii "The age of %s is %d. \n\0"
sallyname:
    .ascii "Sally\0"
sallyage:
    .quad 53
formatstring2:
    .ascii "%d and %s's favorite numbers.\n\0"
joshname:
    .ascii "Josh\0"
joshfavoritefirst:
    .quad 7
joshfavoritesecond:
    .quad 13

.equ LOCAL_FILEPTR, -8 # local variable to store the file pointer

.section .text
main:
    enter $16, $0
    /* posso anche scriverlo:
        push %rbp
        mov %rsp, %rbp
        sub $16, %rsp
    */

    # open the file for writing
    movq $filename, %rdi # filename
    movq $openmode, %rsi # openmode
    call fopen  

    # write the first string
    movq %rax, LOCAL_FILEPTR(%rbp)       # store the file pointer in a local variable!!!

    movq $formatstring1, %rsi # format string
    movq $sallyname, %rdx     # name    
    movq $sallyage, %rcx      # age
    movq $0, %rax             # rax = 0, standard for fprintf!!
    call fprintf

    # write the second string
    movq LOCAL_FILEPTR(%rbp), %rdi       # file pointer
    movq $formatstring2, %rsi # format string
    movq $joshfavoritefirst, %rdx # first favorite number
    movq $joshfavoritesecond, %rcx # second favorite number
    movq $joshname, %r8      # name
    movq $0, %rax            # rax = 0, so we can use it as a dummy variable
    call fprintf

    # close the file
    movq LOCAL_FILEPTR(%rbp), %rdi       # file pointer
    call fclose

    # return
    movq $0, %rax

    leave
    /* posso scrivere: 
        mov %rbp, %rsp
        pop %rbp
    */
    ret

    # - - - - - - -
    # gcc file.s -static -o file
