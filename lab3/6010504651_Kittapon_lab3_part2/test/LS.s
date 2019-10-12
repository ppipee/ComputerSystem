# initial and addiu should execute correct
addiu $t0, $zero, 5
addiu $t1, $zero, 10

# sw , word address (24bit) 1 in RAM  = 1 
sw $t1, 0($zero)
lw $t3, 0($zero)        # $t3 = 10

