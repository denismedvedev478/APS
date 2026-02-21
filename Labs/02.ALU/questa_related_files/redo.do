vlib work
vmap work work

vlog -work work -l logs/compile_rtl.log -f ../rtl/rtl.files
vlog -work work -l logs/compile_tb.log ../tb/tb_top.sv

vsim -sv_seed random -voptargs=+acc -debugDB -l logs/simulation.log -do "do wave.do; run -all; quit" work.tb_top