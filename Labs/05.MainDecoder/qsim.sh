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

vlog -work work -l $LOG_DIR/compile_rtl.log -f ../rtl.files 
vlog -work work -l $LOG_DIR/compile_tb.log  ../tb_oneshot.sv

vsim $SIM_OPTIONS -l $LOG_DIR/simulation.log \
-do "do wave.do; run -all; quit" work.tb_oneshot