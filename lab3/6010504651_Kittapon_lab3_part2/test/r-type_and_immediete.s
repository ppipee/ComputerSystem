# initial , 'addiu' should correct 
addiu $t1, $zero, 5
addiu $t2, $zero, 10

# testing
addu $t3, $t1, $t2          # $t3 = 15
subu $t4, $t2, $t1          # $t4 = 5
and $t5, $t1, $t2           # $t5 = 0
or $t6, $t1, $t2            # $t6 = 15
xor $t7, $t1, $t2           # $t7 = 15
nor $t8, $zero, $zero       # $t8 = 0
slt $t9, $t1, $t2           # $t9 = 1
sltu $s0, $t2, $t1          # $s0 = 0
sll $s1, $t1, 2             # $s1 = 20
srl $s2, $t2, 1             # $s2 = 5
sra $s3, $t1, 1             # $s3 = 2

andi $s4, $t1, 1            # $s4 = 1
ori $s5, $t1, 10            # $s5 = 15
xori $s6, $t1, 10           # $s6 = 15
slti $s7, $t1, 10           # $s7 = 1
# sltiu $s8, $t2, 5           # $s8 = 0