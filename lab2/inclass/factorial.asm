# An example program for SPIM
# Calculating the factorial of an input number using recursion
# By Paruj R.
# 6 Aug. 2019

.data # data section

new_line: .asciiz "\n"
enter_prompt: .asciiz "Enter a number: "
done: .asciiz "Done with factorial.\n"

.text # text section

.globl main # call main by SPIM

fact:
	# push $ra and old $fp on to the stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)

	# set $fp to the current value of $sp (top of stack)
	addu $fp, $zero, $sp

	# get the first argument (the parameter n to calculate n!)
	lw $t0, 8($fp)

	# if n < 1 branch to termination_case
	slti $t1, $t0, 1
	bne $t1, $zero, termination_case

	# we reach this recursive case when n >=1, so
	# push argument n - 1 ($t1) on the stack
	# and jump back (recurse) to fact
	addi $t1, $t0, -1
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	jal fact

	# we reach this when recursion starts unwinding (return from
	# calling fact with n - 1 argument), so we deallocate the stack by adjusting the
	# stack pointer by 4 since we have allocated 4 bytes on the stack
	# to push an argument before the call to fact
	addi $sp, $sp, 4

	# load the value n to multiply with the return value from calling
	# fact(n-1); this return value is in $v0; the new return value (also in $v0) will
	# be n multiplied by this $v0
	lw $t0, 8($fp)
	mul $v0, $v0, $t0

	# restore the return address value to $ra and the previous
	# frame pointer value to $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack frame by adjusting the stack
	# pointer by 8 as we have allocated 8 bytes of the stack
	# memory to save the value of $ra and the value of $fp
	# for the previous frame
	addi $sp, $sp, 8

	# jump to an instruction at the address specified in $ra whose value
	# has just been restored
	jr $ra

termination_case:
	# restore the return address value to $ra and the previous
	# frame pointer value to $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack frame by adjusting the stack
	# pointer by 8 as we have allocated 8 bytes of the stack
	# memory to save the value of $ra and the value of $fp
	# for the previous frame
	addi $sp, $sp, 8

	# return 1 by placing the one constant to $v0
	addi $v0, $zero, 1

	# jump to an instruction at the address specified in $ra whose value
	# has just been restored
	jr $ra

main:
	li $v0, 4
	la $a0, enter_prompt
	syscall
	li $v0, 5
	syscall
	addi $sp, $sp, -4
	sw $v0, 0($sp)
	jal fact
	addi $sp, $sp, 4
	#print factorial of input number
	addu $a0, $zero, $v0
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, new_line
	syscall
	li $v0, 4
	la $a0, done
	syscall
	# exit
	li $v0, 10
	syscall
