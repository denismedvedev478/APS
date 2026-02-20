#!/bin/bash
WORK_DIR="work"
LOG_DIR="logs"
SIM_OPTIONS="-sv_seed random -voptargs=+acc -debugDB -c"

if ! [ -d questa_related_files/ ]; then
mkdir -p "questa_related_files/logs"
fi
cd "questa_related_files"

vlib $WORK_DIR
vmap work $WORK_DIR

vlog -work work -suppress 2244 -l $LOG_DIR/compile_rtl.log -f ../rtl.files
vlog -work work -suppress 2244 -l $LOG_DIR/compile_tb.log  ../lab_02_tb_alu.sv

vsim $SIM_OPTIONS -l $LOG_DIR/simulation.log -do "do wave.do; run -all; quit" work.lab_02_tb_alu