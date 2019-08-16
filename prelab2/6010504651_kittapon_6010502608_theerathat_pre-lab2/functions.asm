# Translating functions in MIPS assembly
# Original C program file: functions.c
# By Paruj R.
# 6 Aug. 2019

.data # data section

new_line: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

fact:
	# push $ra and old $fp on to the stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)

	# set $fp to the current value of $sp (top of stack)
	addu $fp, $zero, $sp

  # reserve space for the two local variables i and f
  # we may never interact with these locations but just want to
  # follow the stack convention here; notice at this point $sp and $fp differ
  addi $sp, $sp, -8

	# get the argument n and put it in $t0, allocated for the i variable
  # select $t0 as it is in caller-saved set, and since this is a leaf function,
  # the callee does not need to save and restore $t0
	lw $t0, 8($fp)

  # allocate $t1 for the f variable and let $t2 = 1
  li $t1, 1
  li $t2, 1

  loop_entry:
  # if (!(1 < i)), goto loop_exit
  slt $t4, $t2, $t0
  beq $t4, $zero, loop_exit

  # f = f * i
  mul $t1, $t1, $t0

  # i--
  addiu $t0, $t0, -1

  j loop_entry

  loop_exit:
  # deallocate the stack memory by adjusting the stack
	# pointer by 8 as we have allocated 8 bytes of the stack
	# memory for the local variables i and f
  addi $sp, $sp, 8

  # restore the return address value to $ra and the previous
	# frame pointer value to $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack memory by adjusting the stack
	# pointer by 8 as we have allocated 8 bytes of the stack
	# memory to save the value of $ra and the value of $fp
	# for the previous frame
	addi $sp, $sp, 8

	# return the value in the f variable (in $t1) by placing it to $v0
	addu $v0, $zero, $t1

	# jump to an instruction at the address specified in $ra whose value
	# has just been restored
	jr $ra

sum_two_fact:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)

	addu $fp, $zero, $sp

  # reserve space for the three local variables x, y, and z
  addi $sp, $sp, -12

  # allocate $t0 to x; $t1 to y; $t2 to z
  # allocate $s0 to a; $s1 to b
 
  addi $sp, $sp, -4
  sw $s0, 0($sp) # save 1000

  # call fact(a)
  lw $s0, 8($fp) # load a
  addi $sp, $sp, -4
  sw $s0, 0($sp) 
  jal fact

  # the return value is in $v0, so move it to x allocated to $t0
  # because $t0 is in the caller-saved set, and we need it after
  # a call to fact(b), we need to save it before the call, then
  # restore it after the call
  addu $t0, $v0, $zero

	# adjust the stack pointer
  addi $sp, $sp, 4

  # save x  
  addi $sp, $sp, -4
  sw $t0, 0($sp) 

  # call fact(b)
  lw $s1, 12($fp) # load b
  addi $sp, $sp, -4
  sw $s1, 0($sp)
  jal fact

  # the return value is in $v0, so move it to y ($t1)
  addu $t1, $v0, $zero

  # load x and adjust stack
  addi $sp, $sp, 4
  lw $t0, 0($sp)

  # adjust the stack pointer
  addi $sp, $sp, 4

  # z = x + y
  addu $t2, $t0, $t1

  # deallocate the stack memory by adjusting the stack
	# pointer by 12 as we have allocated 12 bytes of the stack
	# memory for the local variables x, y, and z
  lw $s0 ,0($sp)
  addi $sp, $sp, 4  
  addi $sp, $sp, 12

  # restore $ra and $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack memory
	addi $sp, $sp, 8

	# return the value in the z variable (in $t2) by placing it to $v0
	addu $v0, $zero, $t2

	jr $ra

main:
  # assign init_result to $s0
  # select $s0 as it is in the callee-saved set, so
  # we do not have to save and restore it
  li $s0, 1000

  # call sum_two_fact by placing the two arguments on the stack
  # although, we overwrite $t0 and $t1, which are in the caller-saved set, we
  # do not need to save them as they will not be needed after the call
  li $t0, 3
  li $t1, 5
  addi $sp, $sp, -8
  sw $t1, 4($sp)
  sw $t0, 0($sp)
  jal sum_two_fact

  # adjust the stack pointer to deallocate the stack memory allocated for the two arguments
  addi $sp, $sp, 8

  # init_result += temp
  # temp has the return value from calling sum_two_fact and it is in $v0
  addu $s0, $s0, $v0

	# print result
	addu $a0, $zero, $s0
	li $v0, 1
	syscall

  # add new line
	li $v0, 4
	la $a0, new_line
	syscall

	# exit
	li $v0, 10
	syscall
