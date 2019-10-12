main:
	#init
	addu $sp, $zero, $zero
	addu $ra, $zero, $zero

	addiu $sp, $sp, -4 #for n argument
	#you can change this line to whatever you want
	addiu $t0, $zero, 5
	sw $t0, 0($sp)

	jal hailstone
	addiu $t0, $zero, 1

	j EXIT
# hailstone(int n) need one argument
hailstone:
	addiu $sp, $sp, -8
	sw $ra, 4($sp) #store add address of$ra
	sw $fp, 0($sp) #store address of $fp
	addu $fp, $sp, $zero

	lw $s0, 8($fp) #load argument n
	addiu $s1, $zero, 1 # 1

	#if n==1 return 0
	beq $s0, $s1, R_zero

	#n%2 = n&(2-1) = n&1
	andi $s2, $s0, 1
	#if (n%2) == 0
	beq $s2, $zero, R_1
	#else
R_2:
	#load next function
	#we need to assign new n/2
	addiu $sp, $sp, -4
	#we know $s0 is n and we need to make n+1
	addu $s4, $s0, $s0 #n*2
	addu $s4, $s4, $s0 #n*2+n = 3*n
	addiu $s4, $s4, 1 #n+1
	sw $s4, 0($sp) #store augment
	jal hailstone #recursive
	#when it out
	#we don't need n anymore and don't need to load for use
	addiu $sp, $sp, 4
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	addiu $sp, $sp, 8
	addiu $a0, $a0, 1 #return 1+recusive
	jr $ra
R_zero:

	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 8
	#we will use a0 to return this function
	addiu $a0, $a0, 0 #return 0
	jr $ra

R_1:
	#load next function
	#we need to assign new n/2
	addiu $sp, $sp, -4
	#we know $s0 is n and we need to make n/2 use SRA
	sra $s3, $s0, 1 #n/2
	sw $s3, 0($sp) #store augment
	jal hailstone #recursive
	#when it out
	#we don't need n anymore and don't need to load for use
	addiu $sp, $sp, 4
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	addiu $sp, $sp, 8
	addiu $a0, $a0, 1 #return 1+recursive
	jr $ra
EXIT:
	#just exit we must use syscall
	#but it can't
	#we will just move a0 to t0
	addu $t0, $a0, $zero
