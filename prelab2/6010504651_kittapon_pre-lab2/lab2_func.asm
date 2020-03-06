.data # data section
print_text: .asciiz "Result = "
new_line: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

min_three:
    # push $ra and old $fp on to the stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	# set $fp to the current value of $sp (top of stack)
	addu $fp, $zero, $sp
  
    lw $s0,8($fp) # load parameter x
    lw $s1,12($fp) # load parameter y
    lw $s2,16($fp) # load parameter z
    
    # if x>=y go to z_lt_y
    slt $s3, $s0, $s1
    beqz $s3, z_lt_y
    # x_lt_y
        # if z >= x go to min_x
        slt $s3, $s2, $s0
        beqz $s3, min_x
        # check z < x
            addiu $s4, $s2, 0 # $s4 = z
            j exit_check # exit check min
        min_x:
            addiu $s4, $s1, 0 # $s4 = x
            j exit_check # exit check min
    z_lt_y:
        # if z >= y go to min_y
        slt $s3, $s2, $s1 
        beqz $s3, min_y
        # check z < y
            addiu $s4, $s2, 0 # $s4 = z
            j exit_check # exit check min
        min_y:
            addiu $s4, $s1, 0 # $s4 = y
    exit_check:


    # restore $ra and $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack memory
	addi $sp, $sp, 8

    # return z 
    addu $v0, $zero, $s4
    jr $ra 

max_three:
    # push $ra and old $fp on to the stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	# set $fp to the current value of $sp (top of stack)
	addu $fp, $zero, $sp

    # allocate $t0, $t1
    addi $sp, $sp, -8    
    # save $s0,$s1
    addi $sp, $sp, -8
    sw $s1, 4($sp) 
    sw $s0, 0($sp)
    
    lw $s0,8($fp) # load parameter x
    lw $s1,12($fp) # load parameter y
    lw $s2,16($fp) # load parameter z

    add $t2, $s0, $zero # max = x
    # if_fst
        slt $t1, $t2, $s1 # check max < y
        beqz $t1, if_sec # if max >= ylet's check z > max
        add $t2, $s1, $zero # max = y    
    if_sec:
        slt $t1, $t2, $s2 # check max < z
        # if max < z max = z
        beqz $t1, if_sec 
        add $t2, $s2, $zero 

    lw $s0,0($sp) # load s0
    lw $s1,4($sp) # load s1
	addi $sp, $sp, 16    # adjust stack pointer
    
    # restore $ra and $fp
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	# deallocate the stack memory
	addi $sp, $sp, 8

    # return min value
    addu $v0, $zero, $t2
    jr $ra    

foo:
    # push $ra and old $fp on to the stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	# set $fp to the current value of $sp (top of stack)
	addu $fp, $zero, $sp
    
    li $t0, 0xbeef # z = 0xbeef
    lw $s0, 8($fp) # load x
    lw $s1, 12($fp) # load y
    
    # call function max_three
    addiu $sp, $sp, -12 # stack for argument in function max_three
    xor $t1, $s1, $s0 # y^x
    sw $t1, 8($sp)
    xor $t1, $s0, $t0 # x^z
    sw $t1, 4($sp)
    xor $t1, $s1, $t0 # y^z
    sw $t1, 0($sp) 
    jal max_three 
    # z = max_three
    addu $t0, $v0, $zero 
    # adjust the stack pointer
    # addiu $sp, $sp, 12

    # call function min_three and sent three argument to stack
    # addiu $sp, $sp, -12
    sw $t0,8($sp) 
    sw $s1,4($sp)
    sw $s0,0($sp)
    jal min_three
    # z = min three
    addu $t0, $zero, $v0

    # adjust SP
    addiu $sp, $sp, 12
    lw $ra, 4($sp)
	lw $fp, 0($sp)
    addiu $sp, $sp, 8
    # return z 
    addu $v0, $zero, $t0
    jr $ra

main:
    # initial data to t0 t1
    li $t0, 0xabcd
    li $t1, 0xdead

    # store value to t1 in stack pointer
    addiu $sp, $sp, -8
    sw $t1, 4($sp)
    sw $t0, 0($sp)
    jal foo # jump to address of function foo

    # adjust the stack pointer
    addiu $sp, $sp, 8
    
    addiu $t0, $v0, 0 # foo = value from function foo
    
    # print text
	li $v0, 4
	la $a0, print_text 
	syscall
    # print result
	li $v0, 1
	addu $a0, $zero, $t0
	syscall
    # add new line
	li $v0, 4
	la $a0, new_line
	syscall

    # call exit once everything is done
    li $v0, 10
    syscall