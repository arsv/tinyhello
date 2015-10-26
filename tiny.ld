ENTRY(_start)

/* Same origin for all arches */
orig = 0x00400000;

SECTIONS {
	.text orig : { *(.text) *(.rodata) }
	filesize = . - orig;
}
