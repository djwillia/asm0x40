NAME := asm0x40
kernel := $(NAME).bin
iso := $(NAME).iso

WD := $(shell pwd)
DOCKER := docker run --rm -v ${WD}:/os-build -w /os-build os-build

linker_script := linker.ld
grub_cfg := grub.cfg
assembly_source_files := $(wildcard *.asm)
assembly_object_files := $(patsubst %.asm, \
    %.o, $(assembly_source_files))

.PHONY: all clean run iso

all: $(kernel) $(iso)

.PHONY: docker
docker: docker/Dockerfile
	docker build --network=host --progress=auto -t os-build docker

clean:
	@echo "CLEAN"
	rm -rf build $(assembly_object_files) $(kernel) $(iso)

run: $(iso)
	$(DOCKER) qemu-system-x86_64 -cdrom $(iso) -display none -serial stdio

$(iso): $(kernel) $(grub_cfg)
	@echo "MKISO $@"
	mkdir -p isofiles/boot/grub
	cp $(kernel) isofiles/boot/kernel.bin
	cp $(grub_cfg) isofiles/boot/grub
	$(DOCKER) grub-mkrescue -o $(iso) isofiles 2> /dev/null
	rm -r isofiles

$(kernel): $(assembly_object_files) $(linker_script)
	@echo "LINK $(@)"
	$(DOCKER) ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files)

# compile assembly files
%.o: %.asm
	@echo "NASM $<"
	$(DOCKER) nasm -felf64 $< -o $@

$(V).SILENT:
