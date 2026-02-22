#!/bin/bash
WORK_DIR="work"
LOG_DIR="logs"
SIM_OPTIONS="-sv_seed random -voptargs=+acc -debugDB"

if ! [ -d questa_related_files/ ]; then
mkdir -p "questa_related_files/logs"
fi
cd "questa_related_files"

vlib $WORK_DIR
vmap work $WORK_DIR

vlog -work work -l $LOG_DIR/compile_rtl.log \
-f ../rtl.files \
-f ../../03.Regfile/rtl.files \
-f ../../02.ALU/rtl.files
vlog -work work -l $LOG_DIR/compile_tb.log  ../lab_04_tb_CYBERcobra.sv

vsim $SIM_OPTIONS -suppress 7033 -l $LOG_DIR/simulation.log \
-do "do wave.do; run -all; quit" work.lab_04_tb_CYBERcobra