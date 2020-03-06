.data # data section
arr_a: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
arr_b: .word 0x7fffffff, 0x7ffffffe, 0x7ffffffd, 0x7ffffffc, 0x7ffffffb, 0x7ffffffa, 0x7ffffff9, 0x7ffffff8, 0x7ffffff7, 0x7ffffff6

txt_sum_a: .asciiz "Sum a = "
txt_sum_b: .asciiz "Sum b = "
new_line: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

main:
# load address of a and b to $t9,$t10 and initial i and sum
la $t9, arr_a
la $t8, arr_b
li $t0, 0 # i=0
add $t1, $0, $0 # sum=0

for_loop:
# if i>= 20 exit loop
slti $t2, $t0, 20
beq $t2, $0, loop_exit

sll $t3, $t0, 2 # i*4
addu $t3, $t3, $t9 # sum address "a" and i
lw $t4,0($t3) # load a[i]
add $t1,$t1,$t4 # sum += a[i]
addi $t0,$t0,1 # i++
j for_loop

loop_exit:
# print string at "txt_sum_a" address
li	$v0, 4
la	$a0, txt_sum_a
syscall
# print value sum
li	$v0, 1
addi $a0, $t1, 0
syscall
# print string at "new_line" address
li	$v0, 4
la	$a0, new_line
syscall

# sum b

li $t0, 0 # i=0
add $t1, $0, $0 # sum=0

for_loop_b:
# if i>= 10 exit loop
slti $t2, $t0, 10
beq $t2, $0, loop_exit_b

sll $t3, $t0, 2 # i*4
addu $t3, $t3, $t8 # sum address "a" and i
lb $t4,0($t3) # load a[i]
add $t1,$t1,$t4 # sum += a[i]
addi $t0,$t0,1 # i++
j for_loop_b

loop_exit_b:
# print string at "txt_sum_a" address
li	$v0, 4
la	$a0, txt_sum_b
syscall
# print value sum
li	$v0, 1
addi $a0, $t1, 0

syscall
# print string at "new_line" address
li	$v0, 4
la	$a0, new_line
syscall

# call exit once everything is done
li $v0, 10
syscall