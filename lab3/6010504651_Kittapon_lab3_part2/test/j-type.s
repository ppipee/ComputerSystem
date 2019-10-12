# addiu should excecute correct
# $t8 = 1
# $t9 = 2
jal jump
addiu $t9, $zero, 2
j exit
jump:
addiu $t8, $zero, 1
jr $31
exit:
