# Translating functions in MIPS assembly
# Original C program file: mystery.c
# By Paruj R.
# 13 Aug. 2019

.data # data section

new_line: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

mystery:
	# push $ra and old $fp on to the stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)

	# set $fp to the current value of $sp (top of stack)
	addu $fp, $zero, $sp

	# get the argument b and put it in $t0
	lw $t0, 12($fp)

  # if (0 == b)), goto termination_case
  beq $t0, $zero, termination_case

	# get the argument a and put it in $t1
	lw $t1, 8($fp)

	# save the caller-save $t1 on the stack
	addi $sp, $sp, -4
	sw $t1, 0($sp)

	# $t2 = b - 1
	addi $t2, $t0, -1

	# push two arguments, a and b-1 on the stack
	addi $sp, $sp, -8
	sw $t2, 4($sp)
	sw $t1, 0($sp)

	# recurse back to mystery
	jal mystery

	# adjust the stack pointer
	addi $sp, $sp, 8

	# restore the a value
	lw $t1, 0($sp)

	# adjust the stack pointer
	addi $sp, $sp, 4

	# prepare the return value
	addu $v0, $t1, $v0

	# restore the return address value to $ra and the previous
	# frame pointer value to $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack frame
	addi $sp, $sp, 8

	# jump to an instruction at the address specified in $ra whose value
	# has just been restored
	jr $ra

termination_case:
	# return 0 by resetting $v0 to 0
	addu $v0, $zero, $zero

	# restore the return address value to $ra and the previous
	# frame pointer value to $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack frame
	addi $sp, $sp, 8

	# jump to an instruction at the address specified in $ra whose value
	# has just been restored
	jr $ra

main:
  # call mystery by placing the two arguments on the stack
  # although, we overwrite $t0 and $t1, which are in the caller-saved set, we
  # do not need to save them as they will not be needed after the call
  li $t0, 25
  li $t1, 7
  addi $sp, $sp, -8
  sw $t1, 4($sp)
  sw $t0, 0($sp)
  jal mystery

  # adjust the stack pointer to deallocate the stack memory allocated for the two arguments
  addi $sp, $sp, 8

	# print result
	addu $a0, $zero, $v0
	li $v0, 1
	syscall

  # add new line
	li $v0, 4
	la $a0, new_line
	syscall

	# exit
	li $v0, 10
	syscall
