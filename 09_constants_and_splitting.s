# THIS FILE IS LINKED WITH 09-1_tallest.s   (just one time: assemble it=> as file.s -o file.o then link it with the main file => ld file.o main_file.o -o executable)
# ────────────────────────────────────────
# Constants are VERY IMPORTANT when save you from chaing by hand all the values in your code
# just imagine what would be like if we had to add 1 more camp in the struct.. we would have to change all the offsets in the code
# ────────────────────────────────────────
# By splitting i mean separating the the program in multiple files to reuse the code

.section .data

.globl people, numpeople

numpeople:
    # calculate the number of people in array:
    .quad (endofpeople - people) / PERSON_RECORD_SIZE

people:
    # array of people (weight, hair color (1 red,2 brown,3 blonde,4 black), height, age)
    .quad 200, 2, 74, 20    # Persona 1
    .quad 280, 2, 72, 44    # Persona 2
    .quad 150, 1, 68, 30    # Persona 3
    .quad 250, 2, 70, 11    # Persona 4
    .quad 180, 4, 69, 65    # Persona 5
endofpeople: # Marks the end of the people array

# Describe the components of the struct: (global constants)
.globl WEIGHT_OFFSET, HAIR_OFFSET, HEIGHT_OFFSET, AGE_OFFSET
.equ WEIGHT_OFFSET, 0
.equ HAIR_OFFSET, 8
.equ HEIGHT_OFFSET, 16
.equ AGE_OFFSET, 24

# Total size of the struct
.globl PERSON_RECORD_SIZE
.equ PERSON_RECORD_SIZE, 32
