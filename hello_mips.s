.equ NR_exit, 4001
.equ NR_write, 4004
.equ stdout, 1

.equ v0, 2
.equ a0, 4
.equ a1, 5
.equ a2, 6
.equ gp, 28

.globl _start

.text
.set noreorder

/* XXX: does this need PIC prologue? */
_start:
	li	$a0, stdout
	la	$a1, orig + 8
	li	$a2, length
	li	$v0, NR_write
	syscall

	li	$a0, 0
	li	$v0, NR_exit
	syscall

.type _start,function
