module instr_mem
import memory_pkg::INSTR_MEM_SIZE_BYTES;
import memory_pkg::INSTR_MEM_SIZE_WORDS;
#(
  parameter ADDR_WIDTH = $clog2(INSTR_MEM_SIZE_BYTES)
)
(
  input  logic [ADDR_WIDTH-1:0] read_addr_i,
  output logic [31:0] read_data_o
);

logic [ADDR_WIDTH-1:0] ROM [INSTR_MEM_SIZE_WORDS];


initial begin
$readmemh("program.mem", ROM);
end

assign read_data_o = ROM[read_addr_i[ADDR_WIDTH-1:2]];

endmodule
