#!/bin/bash
PRJ_DIR=$(pwd)

verilator --lint-only -Wall --bbox-unsup +1800-2017ext+* -sv -I $PRJ_DIR \
alu_opcodes_pkg.sv \
csr_pkg.sv \
decoder_pkg.sv