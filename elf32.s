/* Custom ELF header for the binary */
/* Inspired by http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html */
/* via https://github.com/kmcallister/tiny-rust-demo */
/* via https://github.com/def-/nim-binary-size */

ehdr:
	.byte	0x7f, 0x45, 0x4C, 0x46 /* ELFMAG */
	.byte	0x01		/* EI_CLASS = ELFCLASS32 */
	.byte	ELF_data	/* EI_DATA = ELFDATA2LSB or ELFDATA2MSB */
	.byte	0x01		/* EI_VERSION = EV_CURRENT */
	.byte	0x00		/* EI_OSABI = ELFOSABI_SYSV */

	/* This padding is a perfect place to put a string constant! */
hello:	.asciz "Hello!\n"	/* must be *exactly* 8 bytes long */

	.short	2		/* e_type = executable */
	.short	ELF_machine	/* e_machine */
	.long	1		/* e_version */
	.long	_start		/* e_entry */
	.long	phdr-ehdr	/* e_phoff */
	.long	0		/* e_shoff */
	.long	0		/* e_flags */
	.short	ehdrsize	/* e_ehsize */
	.short	phdrsize	/* e_phentsize */
.ifeq ELF_data - 2
	/* collapse-ehdr-onto-phdr trick does not work on bigendian arches */
	.short	1		/* e_phnum */
	.short	0		/* e_shentsize */
	.short	0		/* e_shnum */
	.short	0		/* e_shstrndx */
.endif

phdr:
	.long	1		/* p_type = loadable program segment & e_phnum,e_sh* */
	.long	0		/* p_offset */
	.long	orig		/* p_vaddr */
	.long	orig		/* p_paddr */
	.long	filesize	/* p_filesz */
	.long	filesize	/* p_memsz */
	.long	7		/* p_flags */
	.long	0x1000		/* p_align */

.ifeq ELF_data - 2
.equ ehdrsize, phdr-ehdr
.else
.equ ehdrsize, phdr-ehdr+8 /* including phdr overlap */
.endif
.equ phdrsize, .-phdr

.equ length, 7
.globl hello
.globl length
