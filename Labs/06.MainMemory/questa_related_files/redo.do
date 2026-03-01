vlib work
vmap work work

vlog -work work -l logs/compile_rtl.log -f ../rtl.files
vlog -work work -l logs/compile_tb.log ../lab_06_tb_data_mem.sv

vsim -sv_seed random -voptargs=+acc -debugDB -l logs/simulation.log -do "do wave.do; run -all; quit" work.lab_06_tb_data_mem