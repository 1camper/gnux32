# gnux32
Unofficial overlay for Gentoo Linux for x32 ABI + glibc (default/linux/amd64/17.0/x32)

This overlay contains ebuilds with patches that fix x32 problems.

## Goals
Currently goal is trying to get popular packages and necessary developer tools for a working desktop.

### What is x32?
x32 ABI is a 32-bit (4-bytes) per integer, long, pointer using all of the x86_64 general purpose registers identified as (rax,rbx,rcx,r11-r15,rsi,rdi) and using sse registers.  Long-long integers are 8 bytes.  C/C++ programs will use __ILP32__ preprocessor checks to distinguish between 32/64 bit systems.  The build system may also compare sizeof(void*) to see if it has 4 bytes for 32-bit for 8 bytes and 64-bit for LP64 (longs are 8 bytes as well as pointers) and __x86_64__ defined.  

### Advantages of this platform

#### x32 ABI vs x86 ABI
x32 is better than x86 because the compiler can utilize the x86_64 calling convention by dumping arguments to the registers first before dumping additional arguments on the stack.  The compiler can futher optimize the code by reducing the number of instructions executed and utilize the full register and 64 bit instructions.

#### x32 ABI vs x86_64 ABI
x32 is better than x86_64 because of reduced pointer size and reduced virtual space.  Reduced virtual space is better safeguard against memory hogs and better memory/cache locality to reduce cache/page miss in theory.

### Disadvantages
32-bit pointers need to be translated when entering the kernel. On the other hand side x32 is inherently not affected by meltdown (spectre is a problem though), the overhead caused by pointer translation should be of the same order as meltdown mitigation.

## How to get started
Follow the Gentoo handbook using a current stage3 for x32. Make sure to update gcc from this overlay and emerge -e system before building anything else.

## Sources and credits of patches
Some patches/ebuilds from mulsx32 overlay (https://github.com/orsonteodoro/muslx32)

## What you can do to help?
* Regression testing needs to be done for any platform the ebuilds support not just x32, patches are being applied unconditionally
* Some patched assembler code needs more testing on harware that supports those instruction sets: AVX/AVX2/AV512/XOP/FMA4 ... Unfortunately Intel SDE does not support x32 ELF binaries at this time. 
* Submit ebuilds + patches

### Where can we meet on IRC?
#gentoo-gnux32 on freenode

## WIP - packages with patches that need more work
package | notes
--- | ---
app-office/libreoffice | fails tests.

### currently working on:
ffmpeg + dependencies

### wishlist - will get there eventually (no particular order)
valgrind
jit
rust
firefox
thunderbird
icedtea?
chromium
spidermonkey
