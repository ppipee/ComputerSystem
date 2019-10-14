main:
	addu $s1, $zero, $zero					# 5
	addu $s3, $zero, $zero					# 6
	addiu $sp, $sp, -4						# 7
	addiu $s0, $0, 5						# 8
	jal HAILSTONE							# 9
	sw $s0, 0($sp)							# 10
	addiu $sp, $sp, 4						# 57
	addu $s1, $s1, $v0						# 58
	addiu $sp, $sp, -12						# 59
	sw $s1, 8($sp)							# 60
	addiu $s1, $s1, 1						# 61
	sw $s1, 4($sp)							# 62
	addiu $s1, $s1, 1						# 63
	sw $s1, 0($sp)							# 64
	lw $s2, 8($sp)							# 65
	addu $s3, $s2, $zero					# 66
	lw $s2, 4($sp)							# 67
	addu $s3, $s2, $s3						# 68
	lw $s2, 0($sp)							# 69
	addu $s3, $s2, $s3						# 70
	nop										
	nop										
	nop										
	nop										
	nop										

HAILSTONE:
	addiu $sp, $sp, -8						# 11
	sw $ra, 4($sp)							# 12
	sw $fp, 0($sp)							# 13
	addu $fp, $sp, $zero					# 14
	lw $t0, 8($fp)							# 15
	addiu $t1, $zero, 1						# 16
	addu $t2, $zero, $zero					# 17
WHILE:
	beq $t0, $t1, WHILE_OUT					# 18, 26, 32, 38, 44, 50
	andi $t3, $t0, 1						# 19, 27, 33, 39, 45, 51
WHILE_IN:
	bne $t3, $zero, ELSE					# 20, 28, 34, 40, 46
	addiu $t2, $t2, 1						# 21, 29, 35, 41, 47
IF:
	j WHILE									#     30, 36, 42, 48
	sra $t0, $t0, 1							#     31, 37, 43, 49

ELSE:
	addu $t4, $t0, $t0						# 22
	addu $t0, $t0, $t4						# 23
	j WHILE									# 24
	addiu $t0, $t0, 1						# 25

WHILE_OUT:
	lw $ra, 4($sp)							# 52
	lw $fp, 0($sp)							# 53
	addiu $sp, $sp, 8						# 54
	jr $ra									# 55
	addu $v0, $t2, $zero					# 56

