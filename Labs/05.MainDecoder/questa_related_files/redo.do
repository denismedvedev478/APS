vlib work
vmap work work

vlog -work work -l logs/compile_rtl.log \
-f ../rtl.files \
-f ../../03.Regfile/rtl.files \
-f ../../02.ALU/rtl.files
vlog -work work -l logs/compile_tb.log ../lab_05_tb_decoder.sv

vsim -sv_seed 390509001 -voptargs=+acc -debugDB -l logs/simulation.log -do "do wave.do; run -all; quit" work.lab_05_tb_decoder