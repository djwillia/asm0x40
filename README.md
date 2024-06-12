
asm0x40
=======

There's a fair amount of boilerplate assembly that needs to happen to
boot from qemu into 64-bit mode, including multiboot headers, setting
up initial page tables, gdt, getting the serial console up and
running, packaging into something bootable, etc.

Hopefully this is good and simple enough for new OS projects to start
from.

Here are some good resources that this is based on:

https://github.com/winksaville/baremetal-x86_64/tree/master?tab=readme-ov-file
https://os.phil-opp.com/entering-longmode/
https://www.cs.vu.nl/~herbertb/misc/writingkernels.txt
https://mars-research.github.io/posts/2020/10/hello-world-on-bare-metal/

