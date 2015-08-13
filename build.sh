# Create output directories, if necessary.
mkdir -p bin/boot
mkdir -p bin/kernel/libc

# Assemble the boot code.
nasm -isrc/boot/ -o bin/boot/bootsect src/boot/bootsect.asm
nasm -isrc/boot/ -o bin/boot/setup src/boot/setup.asm

# Compile the kernel.
gcc -Wall -m32 -ffreestanding -nostdinc -c \
    -Isrc/kernel/include/ \
    -Isrc/kernel/libc/include/ \
    -o bin/kernel/kernel.o src/kernel/kernel.c
    
gcc -Wall -m32 -ffreestanding -nostdinc  -c \
    -Isrc/kernel/include/ \
    -Isrc/kernel/libc/include/ \
    -o bin/kernel/main.o src/kernel/main.c
    
gcc -Wall -m32 -ffreestanding -nostdinc -c \
    -Isrc/kernel/include/ \
    -o bin/kernel/text.o \
    src/kernel/text.c

gcc -Wall -m32 -ffreestanding -nostdinc -c \
    -Isrc/kernel/include/ \
    -Isrc/kernel/libc/include/ \
    -o bin/kernel/libc/stdlib.o \
    src/kernel/libc/stdlib.c
    
gcc -Wall -m32 -ffreestanding -nostdinc -c \
    -Isrc/kernel/include/ \
    -Isrc/kernel/libc/include/ \
    -o bin/kernel/libc/string.o \
    src/kernel/libc/string.c  
    
# Link the kernel object files.
ld -m elf_i386 -Ttext 0 -o bin/kernel/kernel.tmp \
    bin/kernel/kernel.o \
    bin/kernel/main.o \
    bin/kernel/text.o \
    bin/kernel/libc/stdlib.o \
    bin/kernel/libc/string.o

# Extract necessary sections from linked image.
objcopy -O binary \
    -j .text \
    -j .data \
    -j .rodata \
    --pad-to=16384 \
    bin/kernel/kernel.tmp \
    bin/kernel/kernel

# Create floppy disk file.
cat bin/boot/bootsect bin/boot/setup bin/kernel/kernel > bin/richos.flp