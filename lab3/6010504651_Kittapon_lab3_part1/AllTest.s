
# addiu , $t1 and $t2 must have value are 1 and 2
addiu $t1, $zero, 1
addiu $t2, $zero, 1

# sw , word address (24bit) 1 in RAM  = 1 
sw $t1, 0($zero)

# lw, $t3 = 1
lw $t3, 0($zero)

# andi, word address (24 bits) 1  = 1
andi $t4, $zero, 1
sw $t4, 1($zero)

# ori, word address 2 = 1
ori $t4, $zero, 1
sw $t4, 2($zero)

# xori, word address 3 = 0
xori $t4, $zero, 1
sw $t4, 3($zero)

# slti, word address 4 = 0 
slti $t4, $t1, 0
sw $t4, 4($zero)

# sltiu, word address 5 = 1
sltiu $t4, $zero, 1
sw $t4, 5($zero)

# addu , word address 6 = 1
addu $t4, $t1, $zero
sw $t4, 6($zero)

# subu, word address 7 = -1
addiu $t4, $t1, 2
subu $t4, $t4, $t1 
sw $t4, 7($zero)

# and, word address 8 = 1
and $t4, $t1, $t1
sw $t4, 8($zero)

# or, word address 9 = 1 
or $t4, $t1, $t1
sw $t4, 9($zero)

# xor, word address 10 = 0
xor $t4, $zero, $zero
sw $t4, 10($zero)

# nor, word address 11 = 1
nor $t4, $zero, $zero
sw $t4, 11($zero)

# slt, word address 12 = 0
slt $t4, $t1, $t1
sw $t4, 12($zero)

# sltu, word address 13 = 1 
sltu $t4, $zero, $t1
sw $t4, 13($zero)

# sll, word address 14 = 2
sll $t4, $t1, 1
sw $t4, 14($zero)

# srl, word address 15 = 0
srl $t4, $t1, 1
sw $t4, 15($zero)

# sra, word address 16 = 0
sra $t4, $t1, 1
sw $t4, 16($zero)

# beq, $t5 = 1
beq $zero, $zero, branch
addiu $t5, $zero, 1
branch:
addiu $t5, $zero, 1

# bne, $t6 = 2
addiu $t6, $zero, 0
bne $zero, $zero, branch
addiu $t6, $t6, 1
branch:
addiu $t6, $t6, 1


# j, $t7 = 1 
addu $t7, $t7, $zero
j jump
addiu $t7, $t7, 1
jump:
addiu $t7, $t7, 1

# jr, jal , $t8 = 1
jump:
addiu $t8, $zero, 1
jr $31
main:
jal jump
addiu $t9, $zero, 2





