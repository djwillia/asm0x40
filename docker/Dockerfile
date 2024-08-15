FROM ubuntu:22.04 

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y \
    make build-essential gcc nasm grub2 xorriso qemu-system-x86
RUN DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y \
    strace 
    
