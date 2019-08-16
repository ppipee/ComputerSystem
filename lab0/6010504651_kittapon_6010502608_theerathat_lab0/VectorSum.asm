.data # data section
arr: .word 100, 200, 300, 400 
arr2: .word 10, 20, 30, 40 
arr3: .word 0, 0, 0, 0

.text # text section

.globl main # call main by SPIM

main:
la $8, arr 
la $9, arr2 
la $10, arr3 

# 0 
lw $11, 0($8) 
lw $12, 0($9) 
add $13, $11, $12
sw $13, 0($t2)
# 1 
lw $11, 4($8) 
lw $12, 4($9) 
add $13, $11, $12
sw $13, 4($t2)
# 2 
lw $11, 8($8) 
lw $12, 8($9) 
add $13, $11, $12
sw $13, 8($t2)
# 3 
lw $11, 12($8) 
lw $12, 12($9) 
add $13, $11, $12
sw $13, 12($t2)

li	$v0, 10
syscall
