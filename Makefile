ARCH = x86_64
CROSS =

AS = $(CROSS)as
LD = $(CROSS)ld
OBJCOPY = $(CROSS)objcopy

# For arm and arm64 ld cannot produce flat binaries directly.
# See binutils/ld/emultempl/armelf.em around the definition
# of arm_elf_create_output_section_statements()
NEEDSCOPY = arm arm64 mips mipsel mips64 mips64el
USEOBJCOPY = $(if $(filter $(NEEDSCOPY),$(ARCH)),yes,no)

hello: hello_$(ARCH)

ifeq ($(USEOBJCOPY),yes)

.INTERMEDIATE: hello_$(ARCH).elf
hello_$(ARCH).elf: elf_$(ARCH).o hello_$(ARCH).o tiny.ld
	$(LD) -T tiny.ld -o $@ $(filter %.o, $^)
hello_$(ARCH): hello_$(ARCH).elf
	$(OBJCOPY) -O binary $< $@

else

hello_$(ARCH): elf_$(ARCH).o hello_$(ARCH).o tiny.ld
	$(LD) --oformat binary -T tiny.ld -o $@ $(filter %.o, $^)

endif

%.o: %.s
	$(AS) -o $@ $<

# Build *el (little-endian variant) from the same source.
%el.o: %.s
	$(AS) -o $@ $<

clean:
	rm -f *.o *.elf
