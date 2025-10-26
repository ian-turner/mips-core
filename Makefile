current_dir := ${CURDIR}
TARGET := basys3
TOP := top
SOURCES := $(shell find ${current_dir} -type f -name "*.sv")

XDC := ${current_dir}/basys3.xdc

include ./common.mk
