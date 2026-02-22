onerror {resume}
quietly virtual function -install /lab_04_tb_CYBERcobra/DUT -env /lab_04_tb_CYBERcobra/#INITIAL#29 { &{/lab_04_tb_CYBERcobra/DUT/J, /lab_04_tb_CYBERcobra/DUT/B, /lab_04_tb_CYBERcobra/DUT/WS, /lab_04_tb_CYBERcobra/DUT/ALUop, /lab_04_tb_CYBERcobra/DUT/RA1, /lab_04_tb_CYBERcobra/DUT/RA2, /lab_04_tb_CYBERcobra/DUT/PC_offset, /lab_04_tb_CYBERcobra/DUT/WA }} decoded_instr
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab_04_tb_CYBERcobra/OUT
add wave -noupdate /lab_04_tb_CYBERcobra/clk
add wave -noupdate /lab_04_tb_CYBERcobra/rstn
add wave -noupdate /lab_04_tb_CYBERcobra/sw_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/clk_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/rst_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/sw_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/out_o
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/flag
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/instruction
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/decoded_instr
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/J
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/B
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/WS
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/ALUop
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/RA1
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/RA2
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/PC_offset
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/WA
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/RF_const
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/jump
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/PC
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/WD
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/res
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/WE
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/RD1
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/RD2
add wave -noupdate -divider {instruction memory}
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_insrt_mem/read_addr_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_insrt_mem/read_data_o
add wave -noupdate -divider ALU
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_alu/alu_op_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_alu/a_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_alu/b_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_alu/result_o
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_alu/flag_o
add wave -noupdate -divider regfile
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/clk_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/read_addr1_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/read_addr2_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/write_addr_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/write_data_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/write_enable_i
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/read_data1_o
add wave -noupdate /lab_04_tb_CYBERcobra/DUT/u_register_file/read_data2_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 334
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {121 ns}
