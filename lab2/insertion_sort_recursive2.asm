.data # data section
new_line: .asciiz "\n"
space: .asciiz " "
data: .word 132470, 324545, 73245, 93245, 80324542, 244, 2, 66, 236, 327, 236, 21544
.text # text section

.globl main # call main by SPIM

printArray: 
    # push $ra and old $fp on to the stack
	addiu $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addu $fp, $zero, $sp # set $fp to top of stack

    addiu $sp, $sp, -4 # allocate memory for "i"
    # allocate memory for array data {132470, 324545, 73245, 93245, 80324542, 244, 2, 66, 236, 327, 236, 21544}
    li $s0, 0 # set i = 0
    lw $s1, 12($fp) # load N from stack
    lw $s2, 8($fp) # load address of arr

    loop_print:
        # if i>=n go to end loop
        slt $s3, $s0, $s1 
        beqz $s3, end_print
        
        sll $s3, $s0, 2 # calculate position on stack i*4
        # addi $s3, $s3, 8 # position + 8 for pass $fp, $ra
        addu $s3, $s3, $s2 # sum position and base address
        lw $s4, 0($s3) # load address of arr from stack pointer
        # lw $s4, 0 ($s4) # load arr data 
        addi $s0, $s0, 1 # i++
        # print arr[i]
        li $v0, 1 
        addi $a0, $s4, 0
        syscall
        # print space
        li $v0, 4
        la $a0, space
        syscall

        j loop_print
    end_print:

    # print new line
    li $v0, 4
	la $a0, new_line
	syscall

    addiu $sp, $sp, 4 # adjust stack pointer
    # restore the return address 
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	# deallocate the stack memory 
	addi $sp, $sp, 8
	# jump to address of $ra 
    jr $ra

insertionSortRecursive:
    # push $ra and old $fp on to the stack
	addiu $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addu $fp, $zero, $sp # set $fp to top of stack

    addiu $sp, $sp, -8 # allocate memory for "last" and "j"    
    
    lw $s0, 12($fp) # load parameter N
    lw $s1, 8($fp) # load address array
    # if n>1 go to after_base_case
    slti $s2, $s0, 1
    beqz $s2, after_base_case
    # base case
    # return
        addiu $sp, $sp, 8 # adjust stack pointer
        # restore the return address 
        lw $ra, 4($sp)
        lw $fp, 0($sp)
        # deallocate the stack memory 
        addi $sp, $sp, 8
        # jump to address of $ra 
        jr $ra
    after_base_case:

    addi $s2, $s0, -1 # n-=1
    # allocate memory for send argument
    addiu $sp, $sp, -8
    sw $s2, 4($sp) # send argument n-1 to stack
    sw $s1, 0($sp) # send argument address of arr to stack

    jal insertionSortRecursive # recursive

    addiu $sp, $sp, 8 # adjust stack pointer

    lw $s0, 12($fp) # load new N
    lw $s1, 8($fp) # load new address of array

    # load address arr[n-1]
    addi $s2, $s0, -1 # n-=1
    sll $s2, $s2, 2 # n*4
    addu $s2, $s2, $s1 # n*4 + base address of array 
    lw $s2, 0($s2) # load array data from address arr[n-1] (last = arr[n-])
    addi $s3, $s0, -2 # j = n-2

    while:
        # load arr[j] 
        sll $s4, $s3, 2 # j*4
        addu $s4, $s4, $s1 # j*4 + base address 
        lw $s4, 0($s4) # load data of arr[j]
        slt $s5, $s2, $s4 # last < add[j] 

        slti $s6, $s3, 0 # j<0
        not $s6, $s6 # j >=0
        and $s8, $s5, $s6 # j>=0 && arr[j] > last 
        beqz $s8, end_while # if condition is 0 go to end loop while

        # load address arr[j+1]
        addi $s5, $s3, 1 # j+1
        sll $s5, $s5, 2 # (j+1)*4
        addu $s5, $s5, $s1 # sum with base address
        
        sw $s4, 0($s5) # arr[j+1] = arr[j]

        addi $s3, $s3, -1 # j--
        j while
    end_while:

    # load address of arr[j+1]
    addi $s7, $s3, 1 # j+1
    sll $s7, $s7, 2 # (j+1)*4
    addu $s7, $s7, $s1 # j sum with base address
    sw $s2, 0($s7) # arr[j+1] = last 

    # return
    addiu $sp, $sp, 8 # adjust stack pointer
    # restore the return address 
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    # deallocate the stack memory 
    addiu $sp, $sp, 8
    # jump to address of $ra 
    jr $ra




main:
    li $t1, 12 # define N = 12
    # la $t0, data # load address array

    # declare data of array
    addiu $sp, $sp, -48
    li $t0, 132470
    sw $t0, 0($sp)
    li $t0, 324545
    sw $t0, 4($sp)
    li $t0, 73245
    sw $t0, 8($sp)
    li $t0, 93245
    sw $t0, 12($sp)
    li $t0, 80324542
    sw $t0, 16($sp)
    li $t0, 244
    sw $t0, 20($sp)
    li $t0, 2
    sw $t0, 24($sp)
    li $t0, 66
    sw $t0, 28($sp)
    li $t0, 236
    sw $t0, 32($sp)
    li $t0, 327
    sw $t0, 36($sp)
    li $t0, 236
    sw $t0, 40($sp)
    li $t0, 21544
    sw $t0, 44($sp)
    addiu $t0, $sp, 0 # set base address of array data

    addiu $sp, $sp, -8
    sw $t1, 4($sp) # send argument N 
    sw $t0, 0($sp) # send address of array

    jal printArray
    jal insertionSortRecursive
    jal printArray
    addiu $sp, $sp, 8

# call exit once everything is done
li $v0, 10
syscall