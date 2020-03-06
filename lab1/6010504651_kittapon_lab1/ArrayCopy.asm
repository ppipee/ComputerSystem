
.data # data section

source: .word 3, 1, 4, 1, 5, 9, 0
dest: .space 40

.text # text section

.globl main # call main by SPIM

main:
li $t0, 0 # k=0
la $t1, source # load address  of source to $t1
la $t2, dest # load address of dest

for_loop:
sll $t3, $t0, 2 # k=k*4

addu $t4, $t3, $t1 # sum address of source and k  source[k]
lw $t5, 0($t4) # load source[k] to $t5

beq $t5, $0, end_loop # if source[k]==0 go to end_loop
add $t6, $t3, $t2 # sum address of dest and k dest[k]
sw $t5, 0($t6) # dest[k] = source[k]
addi $t0, $t0, 1 # k+=1
j for_loop
end_loop:

# call exit once everything is done
li	$v0, 10
syscall
