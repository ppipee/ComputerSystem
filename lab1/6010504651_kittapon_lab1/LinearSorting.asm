.data # data section
arr_a: .word 0, 2, 1, 6, 4, 3, 5, 3
arr_b: .word 0, 0, 0, 0, 0, 0, 0, 0
arr_c: .word 0, 0, 0, 0, 0, 0, 0

txt_sum_a: .asciiz "A[] = \n"
txt_sum_b: .asciiz "B[] = \n"
new_line: .asciiz "\n"
print_space: .asciiz " "

.text # text section

.globl main # call main by SPIM

main:
# load address and init variable
la $t0, arr_a
la $t1, arr_b
la $t2, arr_c
li $t3, 8 # n = 8
li $t4, 7 # k = 7

li $t5, 1 # i = 1
fst_loop:
# if i >= n exit first loop
slt $t6, $t5, $t3
beq $t6, $0, exit_fst

# load a[i] from address 
sll $t6, $t5, 2 # i*=4
addu $t6, $t6, $t0
lw $t7, 0($t6) # load a[i]

# load c[a[i]] from address 
sll $t7, $t7, 2 # a[i] * =4
addu $t7, $t7, $t2
lw $t8, 0($t7) # load c[a[i]]

addi $t8, $t8, 1 # c[a[i]]++
sw $t8, 0($t7) # store c[a[i]]++ to c[a[i]]

addi $t5, $t5, 1 # i++
j fst_loop

exit_fst:

li $t5, 2 # i = 2
sec_loop:
# if i>=k exit second loop
slt $t6, $t5, $t4
beq $t6, $0, exit_sec

# load c[i] from address
sll $t6, $t5, 2 # i*=4
addu $t6, $t6, $t2 # get address of c[i]
lw $t7, 0($t6) # get c[i]

# load c[i-1] from address
addiu $t8, $t6, -4 # i-=1
lw $t9, 0($t8) # get c[i-1]

add $t7, $t7, $t9 # c[i] + c[i-1]
sw $t7,0($t6) # c[i] = c[i]+c[i-1]

addi $t5,$t5,1 # i++
j sec_loop

exit_sec:

addi $t5, $t3, -1 # i = n - 1
trd_loop:
# if i < 1 exit loop
slti $t6, $t5, 1
bne $t6, $0, exit_trd

# load a[i] from address
sll $t6, $t5, 2 # i*=4
addu $t6, $t6, $t0
lw $t6, 0($t6) # a[i]
# load c[a[i]] from address
sll $t7, $t6, 2 # a[i]*=4
addu $t7, $t7, $t2
lw $t8, 0($t7) # c[a[i]]
# load b[c[a[i]]] from address
sll $t9, $t8, 2 # c[a[i]]*=4
addu $t9, $t9, $t1 
sw $t6, 0($t9) # b[c[a[i]]] = a[i]


# c[a[i]]--
sub $t8,$t8,1
sw  $t8,0($t7)

addi $t5, $t5, -1 # i--
j trd_loop
exit_trd:

# print string at "txt_sum_a" address
li	$v0, 4
la	$a0, txt_sum_a
syscall
li $t4, 0 # initial i = 0
# loop print value a[i]
print_a:
# if i>=n exit loop a
slt $t5, $t4, $t3 
beq $t5, $0, exit_print_a
# print space " "
li	$v0, 4
la	$a0, print_space
syscall
sll $t5, $t4, 2 # i*=4
addu $t5, $t5, $t0 # sum address  
li	$v0, 1 
lw $a0,0($t5) # load data a[i] to $a0
syscall
addi $t4, $t4, 1 # i++
j print_a
exit_print_a:
# print string at "new_line" address
li	$v0, 4
la	$a0, new_line
syscall

# print string at "txt_sum_b" address
li	$v0, 4
la	$a0, txt_sum_b
syscall
li $t4, 0 # initial i = 0
# loop print value b[i]
print_b:
# if i>=n exit loop b
slt $t5, $t4, $t3 
beq $t5, $0, exit_print_b
# print space " "
li	$v0, 4
la	$a0, print_space
syscall
sll $t5, $t4, 2 # i*=4
addu $t5, $t5, $t1 # sum address  
li	$v0, 1 
lw $a0,0($t5) # load data b[i] to $a0
syscall
addi $t4, $t4, 1 # i++
j print_b
exit_print_b:
# print string at "new_line" address
li	$v0, 4
la	$a0, new_line
syscall


# call exit once everything is done
li $v0, 10
syscall
