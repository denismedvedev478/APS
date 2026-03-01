module tb_oneshot;
logic [31:0] fetched_instr_i;
logic [1:0]   a_sel_o;
logic [2:0]   b_sel_o;
logic [4:0]   alu_op_o;
logic [2:0]   csr_op_o;
logic         csr_we_o;
logic         mem_req_o;
logic         mem_we_o;
logic [2:0]   mem_size_o;
logic         gpr_we_o;
logic [1:0]   wb_sel_o;
logic         illegal_instr_o;
logic         branch_o;
logic         jal_o;
logic         jalr_o;
logic         mret_o;

initial begin
    //fetched_instr_i = 32'b011001111101_00000_110_11010_1110011; //CSR_RSI Bullshit
    fetched_instr_i = '0;
    fetched_instr_i = 32'b011001111101_00000_110_11010_1110011;
    #0 $display("csr_we_o: %b", csr_we_o);
    #0 $finish;
end

decoder DUT(.*);

endmodule