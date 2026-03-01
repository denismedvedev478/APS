package illegal_check_pkg;
    import decoder_pkg::*;

    function automatic logic is_csr_immI_illegal(input[11:0] imm_I);
        case (imm_I)
            12'h304,
            12'h305,
            12'h340,
            12'h341,
            12'h342: return 0;
            default: return 1;
        endcase
    endfunction

    function automatic logic is_csr_funct3_illegal(input[2:0] funct3);
        if (funct3 == 3'b000 || funct3 == 3'b100)
            return 1;
        else 
            return 0;
    endfunction

    function automatic logic is_mret_illegal(input[31:0] instruction);
        if (instruction != 32'b0011000_00010_00000_000_00000_1110011)
            return 1;
        else
            return 0;
    endfunction

    function automatic logic is_misc_mem_illegal(input[2:0] funct3);
        if (funct3 != 3'b000)
            return 1;
        else
            return 0;
    endfunction

    function automatic logic is_jalr_illegal(input[2:0] funct3);
        if (funct3 != 3'b000)
            return 1;
        else
            return 0;
    endfunction

    function automatic logic is_branch_illegal(input[2:0] funct3);
        if (funct3 == 3'b010 || funct3 == 3'b011)
            return 1;
        else
            return 0;
    endfunction

    function automatic logic is_store_illegal(input [2:0] mem_size);
        if (mem_size >= 3'd3) // skip BU and HU
            return 1;
        else
            return 0;
    endfunction

    function automatic logic is_load_illegal(input [2:0] mem_size);
        if (mem_size >= 3'd6 || mem_size == 3'b011)
            return 1;
        else
            return 0;
    endfunction

    function automatic logic is_op_imm_alu_illegal(input [4:0] alu_op);
        case (alu_op)
            ALU_ADD, ALU_SUB, ALU_XOR, ALU_OR, ALU_AND, ALU_SRL, ALU_SLL, 
            ALU_SRA, ALU_LTS, ALU_LTU, ALU_GES, ALU_GEU, ALU_EQ, ALU_NE, ALU_SLTS, 
            ALU_SLTU: return 1'b0;
            default: return 1'b1;
        endcase
    endfunction

    function automatic logic is_op_alu_illegal(input [4:0] alu_op);
        case (alu_op)
            ALU_ADD, ALU_SUB, ALU_XOR, ALU_OR, ALU_AND, ALU_SRL, ALU_SLL, 
            ALU_SRA, ALU_LTS, ALU_LTU, ALU_GES, ALU_GEU, ALU_EQ, ALU_NE, ALU_SLTS, 
            ALU_SLTU: return 1'b0;
            default: return 1'b1;
        endcase
    endfunction
endpackage