.data # data section

.text # text section

.globl main # call main by SPIM

main:


# call exit once everything is done
li $v0, 10
syscall