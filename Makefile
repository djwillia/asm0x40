arch ?= x86_64
kernel := build/kernel-$(arch).bin
iso := build/os-$(arch).iso

linker_script := linker.ld
grub_cfg := grub.cfg
assembly_source_files := $(wildcard *.asm)
assembly_object_files := $(patsubst %.asm, \
    %.o, $(assembly_source_files))

.PHONY: all clean run iso

all: $(kernel) $(iso)

clean:
	rm -rf build $(assembly_object_files) $(kernel)

run: $(iso)
	@qemu-system-x86_64 -cdrom $(iso) -display none -serial stdio

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p build/isofiles/boot/grub
	@cp $(kernel) build/isofiles/boot/kernel.bin
	@cp $(grub_cfg) build/isofiles/boot/grub
	grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
	@rm -r build/isofiles

$(kernel): $(assembly_object_files) $(linker_script)
	@mkdir -p build
	ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files)

# compile assembly files
%.o: %.asm
	@mkdir -p $(shell dirname $@)
	nasm -felf64 $< -o $@
