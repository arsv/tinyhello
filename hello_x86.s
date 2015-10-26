.equ NR_write, 4
.equ NR_exit, 1
.equ stdout, 1

.globl _start

_start:
	xor	%eax, %eax
	mov	$NR_write, %al
	mov	$stdout, %ebx
	lea	hello, %ecx
	mov	$length, %edx
	int	$0x80

	xor	%ebx, %ebx
	mov	$NR_exit, %eax
	int	$0x80
