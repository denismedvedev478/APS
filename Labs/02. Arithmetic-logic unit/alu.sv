module alu 
import alu_opcodes_pkg::*;
#( 
    parameter WIDTH=32 
)(
    input  logic[alu_opcodes_pkg::ALU_OP_WIDTH-1:0] alu_op_i,
    input  logic[WIDTH-1:0] a_i,
    input  logic[WIDTH-1:0] b_i,
    output logic[WIDTH-1:0] result_o,
    output logic            flag_o
);

always_comb begin : alu_op_case
    result_o = '0;
    flag_o = '0;
    case (alu_op_i)
        alu_opcodes_pkg::ALU_ADD:  result_o = a_i + b_i;
        alu_opcodes_pkg::ALU_SUB:  result_o = a_i - b_i;
        
        alu_opcodes_pkg::ALU_XOR:  result_o = a_i ^ b_i;
        alu_opcodes_pkg::ALU_OR:   result_o = a_i | b_i;
        alu_opcodes_pkg::ALU_AND:  result_o = a_i & b_i;
        
        alu_opcodes_pkg::ALU_SRL:  result_o = a_i >> b_i[4:0];
        alu_opcodes_pkg::ALU_SLL:  result_o = a_i << b_i[4:0];
        alu_opcodes_pkg::ALU_SRA:  result_o = $signed(a_i) >>> b_i[4:0];
        
        alu_opcodes_pkg::ALU_LTS:  flag_o = ($signed(a_i) < $signed(b_i)); // Less Than Signed
        alu_opcodes_pkg::ALU_LTU:  flag_o = ($unsigned(a_i) < $unsigned(b_i)); // Less Than Unsigned
        alu_opcodes_pkg::ALU_GES:  flag_o = ($signed(a_i) >= $signed(b_i));     // Great [or] Equal signed
        alu_opcodes_pkg::ALU_GEU:  flag_o = ($unsigned(a_i) >= $unsigned(b_i)); // Great [or] Equal unsigned
        alu_opcodes_pkg::ALU_EQ:   flag_o = (a_i == b_i);                       // Equal
        alu_opcodes_pkg::ALU_NE:   flag_o = (a_i != b_i);                       // Not Equal
        alu_opcodes_pkg::ALU_SLTS: result_o = $signed(a_i) < $signed(b_i);
        alu_opcodes_pkg::ALU_SLTU: result_o = $unsigned(a_i) < $unsigned(b_i);
        default: begin
            result_o = '0;
            flag_o = '0;
        end
    endcase
end
endmodule
