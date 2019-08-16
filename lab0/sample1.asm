
.data # data section
my_array: .word 100, -200, 500, 0 # define an array of int containing four elements

.text # text section

.globl main # call main by SPIM

main:
la $8, my_array # move address of my_array (&my_array) into $8
lw $9, 0($8) # load my_array[0] into $9
lw $10, 4($8) # load my_array[1] into $10
add $11, $9, $10 # add the two numbers into $11
lw $9, 8($8) # load my_array[2] into $9
add $11, $11, $9 # add the number in $11 to it and accumulate to $11
sw $11, 12($t0) # store the added result to my_array[3]

# you have two put these two lines in for your code to run properly
# we will explain about them later
li	$v0, 10
syscall
