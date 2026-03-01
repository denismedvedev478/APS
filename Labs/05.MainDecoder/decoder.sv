module decoder
    import decoder_pkg::*;
    import illegal_check_pkg::*;
(
    input  logic [31:0]  fetched_instr_i,
    output logic [1:0]   a_sel_o,
    output logic [2:0]   b_sel_o,
    output logic [4:0]   alu_op_o,
    output logic [2:0]   csr_op_o,
    output logic         csr_we_o,
    output logic         mem_req_o,
    output logic         mem_we_o,
    output logic [2:0]   mem_size_o,
    output logic         gpr_we_o,
    output logic [1:0]   wb_sel_o,
    output logic         illegal_instr_o,
    output logic         branch_o,
    output logic         jal_o,
    output logic         jalr_o,
    output logic         mret_o
);
// a backpressure with illegal_instr_o will be created
logic csr_we_raw, mem_req_raw, mem_we_raw, gpr_we_raw, branch_raw, jal_raw, jalr_raw, mret_raw;

localparam MAGIC_MEM_SIZE = 3'b011;
enum logic[1:0] {AS_rs1=2'd0, AS_pc=2'd1, AS_0=2'd2 } A_SEL_TYPE;
enum logic[2:0] {BS_rs2=3'd0, BS_imm_I=3'd1, BS_imm_U=3'd2, BS_imm_S=3'd3, BS_4=3'd4} B_SEL_TYPE;
enum logic[1:0] {WBS_alu=2'd0, WBS_mrd=2'd1, WBS_cwd=2'd2 } WB_SEL_TYPE; //mrd=mem_rd, cwd=csr_wd
enum logic[2:0] {LDST_B=3'd0, LDST_H=3'd1, LDST_W=3'd2, LDST_BU=3'd3, LDST_HU=3'd4 } MEM_SIZE_TYPE;

// most frequent allocations
logic [6:0]   opcode;
logic [11:7]  rd;
logic [14:12] funct3;
logic [19:15] rs1;
logic [24:20] rs2;
logic [31:25] funct7;
assign {funct7, rs2, rs1, funct3, rd, opcode} = fetched_instr_i;

logic [11:0] imm_I;
logic [31:0] imm_U;
logic [11:0] imm_S;
logic [11:0] imm_B;
logic [20:0] imm_J;
logic [4:0]  imm_Z;
assign imm_I = fetched_instr_i[31:20];
assign imm_U = {fetched_instr_i[31:12], 12'h000};
assign imm_S = {fetched_instr_i[31:25], fetched_instr_i[11:7]};
assign imm_B = {fetched_instr_i[31], fetched_instr_i[7], fetched_instr_i[30:25], fetched_instr_i[11:8] };
assign imm_J = {fetched_instr_i[31], fetched_instr_i[19:12], fetched_instr_i[20], fetched_instr_i[30:21], 1'b0};
assign imm_Z = fetched_instr_i[19:15];

always_comb begin
    {a_sel_o, b_sel_o, alu_op_o, csr_op_o, csr_we_raw, mem_req_raw, mem_we_raw} = '0;
    mem_size_o = MAGIC_MEM_SIZE;
    {gpr_we_raw, wb_sel_o, branch_raw, jal_raw, jalr_raw, mret_raw} = '0;
    illegal_instr_o = opcode[1:0] != 2'b11;

    //$display("1)illegal_instr_o = opcode[1:0] != 2'b11: %b", opcode[1:0] != 2'b11);
    case (opcode)
        {OP_OPCODE, 2'b11}: begin //00_000_11
            alu_op_o = {funct7[31:30], funct3};
            a_sel_o  = AS_rs1;
            b_sel_o  = BS_rs2;
            gpr_we_raw = 1'b1;
            wb_sel_o = WBS_alu;
            illegal_instr_o = is_op_alu_illegal(alu_op_o);
        end
        {OP_IMM_OPCODE, 2'b11}: begin //00_100_11
            if (funct3 == 3'b101)
                alu_op_o = {imm_I[11:10], funct3};            
            else
                alu_op_o = {2'b00, funct3};
            a_sel_o  = AS_rs1;
            b_sel_o  = BS_imm_I;
            gpr_we_raw = 1'b1;
            wb_sel_o = WBS_alu;
            illegal_instr_o = is_op_imm_alu_illegal(alu_op_o);
        end
        {LUI_OPCODE, 2'b11}: begin //01_101_11
            // make it work like
            // alu_op_o = ADD
            // rs1=0
            // rs2=BS_imm_U
            alu_op_o = alu_opcodes_pkg::ALU_ADD;
            a_sel_o = AS_0;
            b_sel_o = BS_imm_U;
            gpr_we_raw = 1'b1;
            wb_sel_o = WBS_alu;
        end
        {AUIPC_OPCODE, 2'b11}: begin //00_101_11
            alu_op_o = alu_opcodes_pkg::ALU_ADD;
            a_sel_o = AS_pc;
            b_sel_o = BS_imm_U;
            gpr_we_raw = 1'b1;
            wb_sel_o = WBS_alu;
        end
        {LOAD_OPCODE, 2'b11}: begin //00_000_11
            alu_op_o = alu_opcodes_pkg::ALU_ADD;
            a_sel_o = AS_rs1;
            b_sel_o = BS_imm_I;
            gpr_we_raw = 1'b1;
            wb_sel_o = WBS_mrd;
            mem_req_raw  = 1'b1;
            mem_we_raw   = 1'b0;
            mem_size_o = funct3;
            illegal_instr_o = is_load_illegal(funct3);
        end
        {STORE_OPCODE, 2'b11}: begin //01_000_11
            alu_op_o = alu_opcodes_pkg::ALU_ADD;
            a_sel_o = AS_rs1;
            b_sel_o = BS_imm_S;
            mem_req_raw  = 1'b1;
            mem_we_raw   = 1'b1;
            mem_size_o = funct3;
            illegal_instr_o = is_store_illegal(funct3);
        end
        {BRANCH_OPCODE, 2'b11}: begin //11_000_11
            alu_op_o = {2'b11, funct3};
            a_sel_o = AS_rs1;
            b_sel_o = BS_rs2;
            branch_raw = 1'b1;
            illegal_instr_o = is_branch_illegal(funct3);
        end
        {JALR_OPCODE, 2'b11}: begin //11_001_11
            jalr_raw = 1'b1;
            gpr_we_raw = 1;
            alu_op_o = alu_opcodes_pkg::ALU_ADD;
            a_sel_o = AS_pc;
            b_sel_o = BS_4;
            wb_sel_o = WBS_alu;
            illegal_instr_o = is_jalr_illegal(funct3);
        end
        {JAL_OPCODE, 2'b11}: begin //11_011_11
            jal_raw = 1'b1;
            gpr_we_raw = 1;
            alu_op_o = alu_opcodes_pkg::ALU_ADD;
            a_sel_o = AS_pc;
            b_sel_o = BS_4;
            wb_sel_o = WBS_alu;
        end
        {MISC_MEM_OPCODE, 2'b11}: begin //00_011_11
            // fence only
            // do nothing?
            mem_size_o = MAGIC_MEM_SIZE;
            illegal_instr_o = is_misc_mem_illegal(funct3);
        end
        {SYSTEM_OPCODE, 2'b11}: begin //b11_100_11
            if (funct3 == 3'b000 && imm_I[11:1]=='0) begin // ecall ebreak
                illegal_instr_o = 1;
            end
            else if (fetched_instr_i == {7'b0011000, 5'b00010, 5'b00000, 3'b000, 5'b00000, 7'b1110011}) begin           // mret
                mret_raw = 1'b1;
                mem_size_o = MAGIC_MEM_SIZE;
            end
            else begin
                gpr_we_raw = 1'b1;
                wb_sel_o   = WBS_cwd;

                csr_op_o   = funct3;
                csr_we_raw = 1'b1;       
                case (funct3)
                    CSR_RW, CSR_RWI:  begin //3'b001, 3'b101
                    end
                    CSR_RS, CSR_RSI:  begin //3'b010, 3'b110
                        if (rs1 == 5'b00000) begin
                            csr_we_raw = 1'b1; // should be 0 because  https://docs.riscv.org/reference/isa/unpriv/zicsr.html#csrsideeffects
                        end
                    end
                    CSR_RC, CSR_RCI:  begin //3'b011, 3'b111
                    end
                    default: 
                        illegal_instr_o = 1;
                endcase
            end
        end
        default:
            illegal_instr_o = 1;
    endcase
end

always_comb begin : backpressure_process
    {csr_we_o, mem_req_o, mem_we_o, gpr_we_o, branch_o, jal_o, jalr_o, mret_o} = 
        illegal_instr_o ? 
        '0 :
        {csr_we_raw, mem_req_raw, mem_we_raw, gpr_we_raw, branch_raw, jal_raw, jalr_raw, mret_raw};
    
end

endmodule