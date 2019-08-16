#This MIPS assembly program translates from the following C snippet

# for (i=0; i<9; i++)
#    A[i] = B[i] + C[D[i]]

.data # data section
D: .word 1, 3, 7, 8, 0, 0, 0, 0, 0
C: .word 0, 10, 0, 20, 0, 0, 0, 30, 40
B: .word 100, 200, 300, 400, 0, 0, 0, 0, 0
A: .space 36

.text # text section

.globl main # call main by SPIM

main:
# initialize i and load starting addresses for A, B, C, and D arrays
li $10, 0
la $20, D
la $21, C
la $22, B
la $23, A
loop_entry:
# if i >= 9 goto loop_exit; use $11 to hold intermediate result for beq comparison
slti $11, $10, 9
beq $11, $0, loop_exit

# get C[D[i]] to temp1 variable $11; $11 also used to hold intermediate results, for example, the address of D[i]
sll $11, $10, 2
addu $11, $11, $20
lw $11, 0($11)
sll $11, $11, 2
addu $11, $11, $21
lw $11, 0($11)

# get B[i] to temp2 variable $12; $12 also used to hold intermediate results, for example, the address of B[i]
sll $12, $10, 2
addu $12, $12, $22
lw $12, 0($12)

# temp2 = B[i] + C[D[i]]
addu $12, $11, $12

# A[i] = temp2
sll $11, $10, 2
addu $11, $11, $23
sw $12, 0($11)

# i++
addiu $10, $10, 1

j loop_entry

loop_exit:
li	$v0, 10
syscall
