
.data # data section

first: .asciiz "My first assembly program:\n"
hello: .asciiz "Hello World!\n"

.text # text section

.globl main # call main by SPIM

main:
# print string at "first" address
li	$v0, 4
la	$a0, first
syscall
# print string at "hello" address
li	$v0, 4
la	$a0, hello
syscall
# call exit once everything is done
li	$v0, 10
syscall
