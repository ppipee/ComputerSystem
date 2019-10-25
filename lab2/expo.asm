.data # data section
new_line: .asciiz "\n"
text_expo1: .asciiz "Expo1 result: "
text_expo2: .asciiz "\nExpo2 result: "
text_expo3: .asciiz "\nExpo3 result: "

.text # text section

.globl main # call main by SPIM

expo1:
    # push $ra and old $fp on to the stack
	addiu $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addu $fp, $zero, $sp # set $fp to top of stack

    lw $s0, 8($fp) # load parameter x 
    lw $s1, 12($fp) # load parameter n
    
    addiu $sp, $sp, -4 # allocate "i"
    
    # initial value
    li $s2, 0 # i=0
    li $s3, 1 # result=1

    loop:
        # if i >= n exit loop
        slt $s4, $s2, $s1 
        beqz $s4, exit_loop
        mul $s3, $s3, $s0 # result *=x
        addi $s2, $s2, 1 # i++
        j loop        
    exit_loop:

    # adjust stack pointer
    addiu $sp, $sp, 4 
    
    # load ra and fp from adress and adjust stack pointer
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addiu $sp, $sp, 8

    # return result
    add $v0, $s3, $zero
    jr $ra

expo2:
    # push $ra and old $fp on to the stack
	addiu $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addu $fp, $zero, $sp # set $fp to top of stack

    lw $s0, 8($fp) # load parameter x 
    lw $s1, 12($fp) # load parameter n
    
    bnez $s1, recur_expo2 # if n!==0 call expo again

    # load ra and fp from adress and adjust stack pointer
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addiu $sp, $sp, 8
    # return 1
    addi $v0, $zero, 1
    jr $ra

    recur_expo2:

        addi $s3, $s1, -1 # n = n-1
        # pass argument x and n
        addiu $sp, $sp, -8
        sw $s3, 4($sp) # n
        sw $s0 0($sp) # x    
        
        jal expo2
        addiu $sp, $sp, 8 # adjust stack pointer


        # load ra and fp from adress and adjust stack pointer
        lw $ra, 4($sp)
        lw $fp, 0($sp)
        addiu $sp, $sp, 8
        # return value from function of expo2
        mul $v0, $v0, $s0 # expo2(x,n-1)*x
        jr $ra

expo3:
    # push $ra and old $fp on to the stack
	addiu $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addu $fp, $zero, $sp # set $fp to top of stack

    lw $s0, 8($fp) # load parameter x 
    lw $s1, 12($fp) # load parameter n

    addiu $sp, $sp, -8 # allocate for vairables ("fh" and "sh")  
    
    bnez $s1, recur_expo3
    # if n==0
        addiu $sp, $sp, 8 # adjust stack pointer
        # load ra and fp from adress and adjust stack pointer
        lw $ra, 4($sp)
        lw $fp, 0($sp)
        addiu $sp, $sp, 8
        # return 1
        addi $v0, $zero, 1
        jr $ra

    recur_expo3:
        sra $s2, $s1, 1 # n/=2
        
        # store x and n/2 on stack 
        addiu $sp, $sp, -8 
        sw $s2, 4($sp) # n/2 , $s2 will change value to 0 but in stack is n/2
        sw $s0, 0($sp) # x
    
        jal expo3 # expo3(x,n/2)
        addi $s3, $v0, 0 # fh = value from callback function expo3
        
        # line below make program run slow so I just comment that
        # jal expo3 # expo3(x,n/2) 
        addi $s4, $v0, 0 # sh = value from callback function expo3
        
        addiu $sp, $sp, 8 # adjust stack pointer

        lw $s1, 12($fp) # load new n from stack 
        and $s1, $s1, 1 # check last bit is zero or one
        mul $v0, $s3, $s4 # fh*sh            
        beqz $s1, return_expo3 # if $s1 (n%2) == 0 return fh*sh
        mul $v0, $v0, $s0 # x*fh*sh
        return_expo3:

        addiu $sp, $sp, 8 # adjust stack pointer
        # load ra and fp from adress and adjust stack pointer
        lw $ra, 4($sp)
        lw $fp, 0($sp)
        addiu $sp, $sp, 8
        # return $v0
        jr $ra

main:
    addiu $sp, $sp, -4 # allocate for "result" variable
    
    # set default 4 and 7
    li $t0, 4
    li $t1, 7

    # pass argument 4 and 7
    addiu $sp, $sp, -8
    sw $t1, 4($sp)
    sw $t0 0($sp)

    jal expo1
    addu $t2, $zero, $v0 # result = value from function expo1
    # print "text expo1"
	li $v0, 4
	la $a0, text_expo1
	syscall
    # print result of expo1
	li $v0, 1
	addu $a0, $zero, $t2
	syscall

    jal expo2
    addu $t2, $zero, $v0 # result = value from function expo1
    # print "text expo1"
	li $v0, 4
	la $a0, text_expo2
	syscall
    # print result of expo1
	li $v0, 1
	addu $a0, $zero, $t2
	syscall

    jal expo3
    addu $t2, $zero, $v0 # result = value from function expo1
    # print "text expo1"
	li $v0, 4
	la $a0, text_expo3
	syscall
    # print result of expo1
	li $v0, 1
	addu $a0, $zero, $t2
	syscall
    # print new line
	li $v0, 4
	la $a0, new_line
	syscall

    # adjust stack pointer
    addiu $sp, $sp, 8 
    # return 0
    li $v0, 0 

# call exit once everything is done
li $v0, 10
syscall