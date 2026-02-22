module register_file
import memory_pkg::*;
#( 
    parameter ADDR_WIDTH=5,
    parameter WIDTH=32 
)(
    input  logic                 clk_i,
    input  logic[ADDR_WIDTH-1:0] read_addr1_i,
    input  logic[ADDR_WIDTH-1:0] read_addr2_i,
    input  logic[ADDR_WIDTH-1:0] write_addr_i,
    
    input  logic[WIDTH-1:0]      write_data_i,
    input  logic                 write_enable_i,
    output logic[WIDTH-1:0]      read_data1_o,
    output logic[WIDTH-1:0]      read_data2_o
);

logic [WIDTH-1:0] rf_mem [WIDTH];

/*initial begin
  for (int i = 0; i < WIDTH; i++)
    rf_mem[i] = '0;
end*/

always_comb begin : comb_read_addr1_i
    if (read_addr1_i == '0) begin
        read_data1_o = '0;
    end
    /*else if (write_enable_i && read_addr1_i == write_addr_i) begin
        read_data1_o = write_data_i;
    end*/
    else begin
        read_data1_o = rf_mem[read_addr1_i[ADDR_WIDTH-1:0]];
    end
end

always_comb begin : comb_read_addr2_i
    if (read_addr2_i == '0) begin
        read_data2_o = '0;
    end
    /*else if (write_enable_i && read_addr2_i == write_addr_i) begin
        read_data2_o = write_data_i;
    end*/
    else begin
        read_data2_o = rf_mem[read_addr2_i[ADDR_WIDTH-1:0]];
    end
end

always_ff @(posedge clk_i) begin : ff_write_addr
    if (write_enable_i && write_addr_i != '0) begin
        rf_mem[write_addr_i[ADDR_WIDTH-1:0]] = write_data_i;    
    end
end

endmodule
