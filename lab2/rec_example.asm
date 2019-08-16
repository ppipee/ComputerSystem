.data # data section

new_line: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

rec_func:
    # push $ra and old $fp on to the stack
	addiu $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addu $fp, $zero, $sp # set $fp to top of stack

    lw $s0, 8($fp) # load argument n ($s0 = n)
    # if n > 0 go to end_func
    slt $s1, $zero, $s0
    beqz $s1, end_func

    # print n before call function and new line
	li $v0, 1
	addu $a0, $zero, $s0
	syscall
	li $v0, 4
	la $a0, new_line
	syscall

    # call function rec_func(n-2)
    addi $sp, $sp, -4
    addi $s2, $s0, -2 # n = n-2
    sw $s2, 0($sp)
    jal rec_func
    addi $sp, $sp, 4 # adjust stack pointer


    # call function rec_func(n-3)
    lw $s0, 8($fp) # load new n
    addi $sp, $sp, -4 # allocate memory for pass parameter
    addi $s2, $s0, -3 # n = n-3
    sw $s2, 0($sp)
    jal rec_func
    addi $sp, $sp, 4 # adjust stack pointer


    # print n after call function and new line
    lw $s0, 8($fp) # load new n
	li $v0, 1
	addu $a0, $zero, $s0 
	syscall
    li $v0, 4
	la $a0, new_line
	syscall

    end_func:

    # restore the return address 
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	# deallocate the stack memory 
	addi $sp, $sp, 8
	# jump to address of $ra 
	jr $ra

main:
    addi $t0, $zero, 5 # set $t0 = 5
    # store $to in stack
    addiu $sp, $sp, -4 
    sw $t0, 0($sp)

    jal rec_func
    add $v0, $zero, $zero # return 0

# call exit once everything is done
li $v0, 10
syscall