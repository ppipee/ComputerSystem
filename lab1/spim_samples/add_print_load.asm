
.data # data section
value: .word 123, 456, 0, 0xabcdffee # data for addition

.text # text section

.globl main # call main by SPIM

main:
la $t0, value # load address value into $t0
lw $t1, 0($t0) # load word 0(value) into $t1
lw $t2, 4($t0) # load word 4(value) into $t2
add $t3, $t1, $t2 # add two numbers into $t3
sw $t3, 8($t0) # store word $t3 into 8($t0)

lb $t4, 12($t0) # load byte (signed) 12(value) into $t4
lw $t5, 12($t0) # load word 12(value) into $t5
lbu $t6, 12($t0) # load byte (unsigned) 12(value) into $t4
	
# print $t1 + $t2 value
li	$v0, 1
move	$a0, $t3
syscall

li	$v0, 10
syscall
