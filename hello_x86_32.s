.equ NR_write, 0x01
.equ NR_exit,  0x3C
.equ stdout, 1

.globl _start

/* Without those 0x40000000, it's not a true x86_32.
   It works nonetheless, despite being linked against
   ELF32 header. */

_start:
	xor	%eax, %eax
	mov	$NR_write, %eax
	/*orl	$0x40000000, %eax*/
	mov	$stdout, %edi
	lea	hello, %esi
	mov	$length, %edx
	syscall

	xor	%edi, %edi
	mov	$NR_exit, %eax
	/*orl	$0x40000000, %eax*/
	syscall
