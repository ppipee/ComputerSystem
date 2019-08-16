.data # data section
new_line: .asciiz "\n"
text_expo1: .asciiz "Expo1 result: "
text_expo2: .asciiz "\nExpo2 result: "
text_expo3: .asciiz "\nExpo3 result: "

.text # text section

.globl main # call main by SPIM

expo1:

expo2:

expo3:

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
    addiu $t2, $zero, $v0 # result = value from function expo1
    # print "text expo1"
	li $v0, 4
	la $a0, text_expo1
	syscall
    # print result of expo1
	li $v0, 1
	addu $a0, $zero, $t2
	syscall

    jal expo2
    addiu $t2, $zero, $v0 # result = value from function expo1
    # print "text expo1"
	li $v0, 4
	la $a0, text_expo3
	syscall
    # print result of expo1
	li $v0, 1
	addu $a0, $zero, $t2
	syscall

    jal expo3
    addiu $t2, $zero, $v0 # result = value from function expo1
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