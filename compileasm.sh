#!/bin/bash

# compiles assembly code to MIPS32 machine code

INPUT="$1"

java -jar mars.jar a dump .text HexText build/prog.hex "$INPUT"
