.data # data section
arr: .word 24, 13, 9, -16 
arr2: .word 8, 7, -11, 3 

.text # text section

.globl main # call main by SPIM

main:
la $8, arr 
la $9, arr2 
# 0 
lw $11, 0($8) 
lw $12, 0($9) 
mul $7, $11, $12
add $10, $10, $7
# 1 
lw $11, 4($8) 
lw $12, 4($9) 
mul $7, $11, $12
add $10, $10, $7
# 2 
lw $11, 8($8) 
lw $12, 8($9) 
mul $7, $11, $12
add $10, $10, $7
# 3 
lw $11, 12($8) 
lw $12, 12($9) 
mul $7, $11, $12
add $10, $10, $7

# li	$v0, 10
move $2, $10
syscall
