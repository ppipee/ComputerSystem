# jump should execute correct
# initial
addiu $t0,$zero,4
addiu $t1,$zero,4


# t3 = 15
bne $t0,$t1,BNE
beq $t0,$t1,BEQ
before:
beq $t3,$t0,BEQ
bne $t0,$zero,BNE
BEQ:
addiu $t3,$zero,5
j before
BNE:
addiu $t3,$t3,10
