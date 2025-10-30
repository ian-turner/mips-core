#!/bin/bash

# compiles C code to MIPS32 machine code

INPUT="$1"

clang \
    --target=mipsel-unknown-elf \
    -march=mips32 \
    -mabi=32 \
    -O0 \
    -fno-pic \
    -mno-abicalls \
    -fno-stack-protector \
    -ffreestanding \
    -nostdlib \
    -S \
    "$INPUT" \
    -o "build/prog.asm"

python mars_clean.py build/prog.asm build/prog_cleaned.asm

java -jar mars.jar a dump .text HexText build/prog.hex build/prog_cleaned.asm
