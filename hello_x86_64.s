.equ NR_write, 1
.equ NR_exit, 0x3C
.equ stdout, 1

.globl _start

_start:
	mov	$length, %edx
	mov	$hello, %esi
	mov	$stdout, %edi
	mov	$NR_write, %eax
	syscall

	xor	%edi, %edi
	mov	$NR_exit, %eax
	syscall
