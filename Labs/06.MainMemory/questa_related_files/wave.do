onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab_06_tb_data_mem/DUT/ready_o
add wave -noupdate /lab_06_tb_data_mem/DUT/clk_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /lab_06_tb_data_mem/DUT/mem_req_i
add wave -noupdate /lab_06_tb_data_mem/DUT/addr_i
add wave -noupdate /lab_06_tb_data_mem/DUT/write_enable_i
add wave -noupdate /lab_06_tb_data_mem/DUT/write_data_i
add wave -noupdate -radix binary /lab_06_tb_data_mem/DUT/byte_enable_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /lab_06_tb_data_mem/DUT/mem_req_i
add wave -noupdate /lab_06_tb_data_mem/DUT/read_data_o
add wave -noupdate -divider {New Divider}
add wave -noupdate /lab_06_tb_data_mem/DUT/curr_word
add wave -noupdate /lab_06_tb_data_mem/DUT/wdata_bytes
add wave -noupdate /lab_06_tb_data_mem/DUT/cword_bytes_new
add wave -noupdate /lab_06_tb_data_mem/DUT/rdata_buf
add wave -noupdate -divider {New Divider}
add wave -noupdate /lab_06_tb_data_mem/DUT/ram
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 294
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
WaveRestoreZoom {906 ns} {1420 ns}
