.equ NR_write, 64
.equ NR_exit, 93
.equ stdout, 1

.globl _start

_start:
	ldr	x0, =stdout
	ldr	x1, =hello
	ldr	x2, =length
	ldr	x8, =NR_write
	svc	0

	mov	x0, #0
	ldr	x8, =NR_exit
	svc	0
