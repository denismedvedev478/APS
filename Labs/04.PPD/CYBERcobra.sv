module CYBERcobra 
import memory_pkg::*;
(
  input  logic         clk_i,
  input  logic         rst_i,
  input  logic [15:0]  sw_i,
  output logic [31:0]  out_o
);
logic flag; // alu flag

logic[31:0]  instruction;
logic[31:31] J;
logic[30:30] B;
logic[29:28] WS;
logic[27:23] ALUop;
logic[22:18] RA1;
logic[17:13] RA2;
logic[12:5]  PC_offset;
logic[4:0]   WA;

logic[27:5]  RF_const;

logic jump;
assign jump = J || (B && flag);

assign {J, B, WS, ALUop, RA1, RA2, PC_offset, WA} = instruction;

assign RF_const = instruction[27:5];

logic[31:0] PC;
always_ff @(posedge clk_i or posedge rst_i) begin
  if (rst_i)
    PC <= '0;
  else if (jump)
    PC <= PC + (PC_offset<<2);
  else
    PC <= PC + 32'h4;
end

instr_mem u_insrt_mem(
  .read_addr_i({'0, PC[$clog2(INSTR_MEM_SIZE_BYTES)-1:0]}),
  .read_data_o(instruction)
);

logic[31:0] WD;
logic[31:0] res;
always_comb begin
  case(WS)
  2'b00: WD = $signed({{5{RF_const[27]}}, RF_const});
  2'b01: WD = res;
  2'b10: WD = $signed({{16{sw_i[15]}}, sw_i});
  2'b11: WD = '0;
  endcase
end
logic WE;
assign WE = ~(J || B);

logic[31:0] RD1, RD2;
register_file u_register_file(
  .clk_i         (clk_i),
  .read_addr1_i  (RA1),
  .read_addr2_i  (RA2),
  .write_addr_i  (WA ),
  .write_data_i  (WD ),
  .write_enable_i(WE ),
  .read_data1_o  (RD1),
  .read_data2_o  (RD2)
);

alu u_alu
(
  .alu_op_i (ALUop),
  .a_i      (RD1),
  .b_i      (RD2),

  .result_o (res),
  .flag_o   (flag)
);

assign out_o = res;

endmodule