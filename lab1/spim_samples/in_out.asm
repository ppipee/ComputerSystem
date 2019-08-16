
.data # data section

array_a: .space 40
new_line: .asciiz "\n"
enter_prompt: .asciiz "Enter a number: "
output_prompt1: .asciiz "Number "
output_prompt2: .asciiz " is "

.text # text section

.globl main # call main by SPIM

main:
la	$t0, array_a
li	$t1, 10
loop:
# prompt for input
li	$v0, 4
la	$a0, enter_prompt
syscall
# read in the value
li	$v0, 5
syscall
# store each value read in to location addressed by $t0
sw	$v0, ($t0)
# advance $t0 by 4
addiu	$t0, $t0, 4
# $t1 is a loop controlled variable
sub	$t1, $t1, 1
# go to loop if numbers inputted still less than 10
bnez	$t1, loop

# out of loop when we got 10 numbers
li	$t1, 0
la	$t0, array_a
li	$t4, 10
# loop2 will print out the 10 numbers you just typed in
loop2:
li	$v0, 4
la	$a0, output_prompt1
syscall
li	$v0, 1
addiu	$a0, $t1, 1
syscall
li	$v0, 4
la	$a0, output_prompt2
syscall
li	$v0, 1
lw	$a0, ($t0)
syscall
li	$v0, 4
la	$a0, new_line
syscall
addiu	$t0, $t0, 4
add	$t1, $t1, 1
bne	$t1, $t4, loop2
# call exit once everything is done
li	$v0, 10
syscall
