module data_mem
import memory_pkg::DATA_MEM_SIZE_BYTES;
import memory_pkg::DATA_MEM_SIZE_WORDS;
(
    input  logic        clk_i,
    input  logic        mem_req_i,
    input  logic        write_enable_i,
    input  logic [ 3:0] byte_enable_i,
    input  logic [31:0] addr_i,
    input  logic [31:0] write_data_i,
    output logic [31:0] read_data_o,
    output logic        ready_o
);

/*
ячейка - синоним слова WORD
ячейки - 32битные, адресация должна быть побайтовая. 
addr_i указывает на конкретный байт. но из этой информации мы должны получить текущую ячейку, и с ней проводить операции.
*/

typedef logic [31:0] WORD;
typedef logic [7:0] BYTES_WORD [3:0];
localparam WORD_WIDTH = 32;
logic [WORD_WIDTH-1:0] ram [memory_pkg::DATA_MEM_SIZE_WORDS] = '{default: 32'h00000000};

logic [$clog2(DATA_MEM_SIZE_WORDS)-1:0] word_addr;
assign word_addr = addr_i[$clog2(DATA_MEM_SIZE_BYTES)-1:0] / 4;

WORD curr_word;
assign curr_word = ram[word_addr];
BYTES_WORD wdata_bytes;
generate
    genvar i;
    for (i = 0; i < 4; i++) begin
        assign wdata_bytes[i] = write_data_i[i*8 +: 8];
    end
endgenerate

BYTES_WORD cword_bytes_new;
always_comb begin
    cword_bytes_new = BYTES_WORD'(curr_word);
    for (int i = 0; i < 4; i++) begin // replace current_word's bytes with wdata_bytes foreach BE[i]==1
        if (byte_enable_i[i]) begin
            cword_bytes_new[i] = wdata_bytes[i];
        end
    end
end

logic [31:0] rdata_buf = 32'h00000000;
always_ff @(posedge clk_i) begin
    if (mem_req_i) begin
        if (write_enable_i) begin
            ram[word_addr] <= WORD'(cword_bytes_new); // *
        end
        else begin
            rdata_buf <= curr_word;
        end
    end
end

assign read_data_o = rdata_buf;
assign ready_o = 1;

endmodule
// ____________
// * —— https://verificationacademy.com/forums/t/efficient-way-to-convert-unpacked-array-to-packed-array-and-vice-versa/41489/2        
// we can also perform { >> byte {cword_bytes}}; saving endianness