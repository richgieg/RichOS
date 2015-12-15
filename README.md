# [The RichOS Project](http://richgieg.com/richos)

I started this project so I have a playground to
exercise my problem solving skills and grow my computer science knowledge. I
enjoy writing low-level software like this. There's something exciting about
having full control over the machine. Sure, I'm just reinventing the wheel...
but I think it's really fun!

This project is in its very early stages at this time. Here are some points of
interest:

- My development environment is Ubuntu 15.04 x86-64.
- NASM, GCC, ld, and objcopy are all required to build the OS.
- Upon successful execution of the build script (build.sh) there will be a
flat binary file bin/richos.flp.
- I test RichOS using VMware Player, pointing the virtual floppy drive to
bin/richos.flp.
- I also test RichOS on a physical machine by writing bin/richos.flp to a USB
flash drive, starting at the first sector, then setting my PC to boot from the
USB flash drive in floppy emulation mode.
- The boot code is written in mostly 16-bit x86 assembly with a small portion of
32-bit x86 assembly to do some environment setup after switching the CPU from
real mode to protected mode.
- The kernel code is written in C, compiled to 32-bit x86 machine code.
- NASM is used to assemble the boot code and GCC is used to compile the kernel.
- Some code in src/boot/bootsect.asm and src/boot/setup.asm borrows heavily from
early Linux boot code, but the rest is original.
- All code in src/kernel/ is original, including my (very incomplete) version
of the C standard library.

Goals for the near future:

- Complete the parts of the C standard library that are most useful to the
kernel.
- Create basic memory management services.
- Write basic interrupt service routines and populate interrupt descriptor table.
- Create a driver for the keyboard.

Goals for the distant future:

- Create drivers for the floppy disk drive and hard disk drive.
- Engineer a custom file system, or create a driver for an existing one.
- Create memory management system utilizing paged virtual memory.
- Implement an experimental user mode consisting of a JavaScript interpreter as
the sole API for applications.

There's a lot to be done but there's only so much time in a day. Slowly but
surely! I think it would be fun to collaborate if anyone is interested.
Let me know.

My website:
[http://www.richgieg.com](http://www.richgieg.com)

Thanks for looking. 

Sincerely,

Rich
