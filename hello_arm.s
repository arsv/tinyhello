.equ NR_write, 4
.equ NR_exit, 1
.equ stdout, 1

.globl _start

_start:
	ldr	r0, =stdout
	ldr	r1, =hello
	ldr	r2, =length
	ldr	r7, =NR_write
	swi	0

	mov	r0, #0
	ldr	r7, =NR_exit
	swi	0
