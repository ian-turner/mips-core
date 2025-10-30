#!/bin/bash

set -e

F4PGA_INSTALL_DIR=~/opt/f4pga
F4PGA_FAM=xc7
export F4PGA_SHARE_DIR="$F4PGA_INSTALL_DIR/$F4PGA_FAM/share/f4pga"

mkdir -p build/basys3
cp build/prog.hex build/basys3/prog.hex
TARGET="basys3" make
openFPGALoader -b basys3 build/basys3/top.bit
