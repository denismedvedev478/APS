onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab_05_tb_decoder/DUT/fetched_instr_i
add wave -noupdate /lab_05_tb_decoder/DUT/illegal_instr_o
add wave -noupdate /lab_05_tb_decoder/DUT/opcode
add wave -noupdate /lab_05_tb_decoder/DUT/rd
add wave -noupdate /lab_05_tb_decoder/DUT/funct3
add wave -noupdate /lab_05_tb_decoder/DUT/rs1
add wave -noupdate /lab_05_tb_decoder/DUT/rs2
add wave -noupdate /lab_05_tb_decoder/DUT/funct7
add wave -noupdate /lab_05_tb_decoder/DUT/imm_I
add wave -noupdate /lab_05_tb_decoder/DUT/imm_U
add wave -noupdate /lab_05_tb_decoder/DUT/imm_S
add wave -noupdate /lab_05_tb_decoder/DUT/imm_B
add wave -noupdate /lab_05_tb_decoder/DUT/imm_J
add wave -noupdate /lab_05_tb_decoder/DUT/imm_Z
add wave -noupdate -divider {New Divider}
add wave -noupdate -color Magenta /lab_05_tb_decoder/a_sel_check
add wave -noupdate /lab_05_tb_decoder/DUT/a_sel_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/b_sel_check
add wave -noupdate /lab_05_tb_decoder/DUT/b_sel_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/alu_op_check
add wave -noupdate /lab_05_tb_decoder/DUT/alu_op_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/csr_op_check
add wave -noupdate /lab_05_tb_decoder/DUT/csr_op_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/csr_we_check
add wave -noupdate /lab_05_tb_decoder/DUT/csr_we_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/mem_req_check
add wave -noupdate /lab_05_tb_decoder/DUT/mem_req_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/mem_we_check
add wave -noupdate /lab_05_tb_decoder/DUT/mem_we_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/mem_size_check
add wave -noupdate /lab_05_tb_decoder/DUT/mem_size_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/gpr_we_check
add wave -noupdate /lab_05_tb_decoder/DUT/gpr_we_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/wb_sel_check
add wave -noupdate /lab_05_tb_decoder/DUT/wb_sel_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/branch_check
add wave -noupdate /lab_05_tb_decoder/DUT/branch_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/jal_check
add wave -noupdate /lab_05_tb_decoder/DUT/jal_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/jalr_check
add wave -noupdate /lab_05_tb_decoder/DUT/jalr_o
add wave -noupdate -color Magenta /lab_05_tb_decoder/mret_check
add wave -noupdate /lab_05_tb_decoder/DUT/mret_o
add wave -noupdate /lab_05_tb_decoder/err_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {301 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
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
WaveRestoreZoom {237 ns} {580 ns}
