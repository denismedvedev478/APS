module tb_bebra;

logic [31:0] mem = 32'h1234_5678;
integer i = 0;
initial begin
    #1;
    //mem[i*8 +: 8];
    i++;
    #1 //mem[i*8 +: 8];
    i++;
    #1 //mem[i*8 +: 8];
    i++;
    #1 //mem[i*8 +: 8];
    i++;
    #1 $finish;
end

initial begin
    $monitor("%d) access: %h", i, mem[i*8 +: 8]);
end

endmodule