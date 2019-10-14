main:
	addu $s1, $zero, $zero			# 5
	addu $s3, $zero, $zero			# 6
	addiu $sp, $sp, -4				# 7
	addiu $s0, $0, 5				# 8
	sw $s0, 0($sp)					# 9
	jal HAILSTONE          			# 10
	nop								# 11
	addiu $sp, $sp, 4				# 74
	addu $s1, $s1, $v0				# 75
	addiu $sp, $sp, -12				# 76
	sw $s1, 8($sp)					# 77
	addiu $s1, $s1, 1				# 78
	sw $s1, 4($sp)					# 79
	addiu $s1, $s1, 1				# 80
	sw $s1, 0($sp)					# 81
	lw $s2, 8($sp)					# 82
	addu $s3, $s2, $zero			# 83
	lw $s2, 4($sp)				    # 84
	addu $s3, $s2, $s3              # 85
	lw $s2, 0($sp)					# 86
	addu $s3, $s2, $s3	            # 87
	nop								
	nop								
	nop								
	nop								
	nop								

HAILSTONE:
	addiu $sp, $sp, -8				# 12
	sw $ra, 4($sp)					# 13
	sw $fp, 0($sp)					# 14
	addu $fp, $sp, $zero			# 15
	lw $t0, 8($fp)					# 16
	addiu $t1, $zero, 1				# 17
	addu $t2, $zero, $zero          # 18
WHILE:
	beq $t0, $t1, WHILE_OUT         # 19  30  39  48  57  66
	nop # delayed slot				# 20  31  40  49  58  67
WHILE_IN:
	addiu $t2, $t2, 1               # 21  32  41  50  59
	andi $t3, $t0, 1				# 22  33  42  51  60
	bne $t3, $zero, ELSE			# 23  34  43  52  61
	nop # delayed slot              # 24  35  44  53  62
IF:
	sra $t0, $t0, 1      			#     36  45  54  63
	j WHILE							#	  37  46  55  64
	nop								# 	  38  47  56  65
ELSE:
	addu $t4, $t0, $t0              # 25
	addu $t0, $t0, $t4              # 26
	addiu $t0, $t0, 1    			# 27
	j WHILE							# 28
	nop								# 29
WHILE_OUT:
	lw $ra, 4($sp)				    # 68
	lw $fp, 0($sp)					# 69
	addiu $sp, $sp, 8				# 70
	addu $v0, $t2, $zero			# 71
	jr $ra							# 72
	nop								# 73