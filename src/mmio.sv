module mmio (    
    input logic clk,
    input logic memwrite,
    input logic memread,
    input logic [31:0] addr,
    input logic [31:0] writedata,
    output logic [31:0] readdata,

    // io signals
    input logic [15:0] sw,
    output logic [15:0] hex
);
    // data memory

    logic [31:0] data_mem [4095:0];
    always @* readdata = (addr == 32'd2002) ? {16'b0, sw}
        : data_mem[addr];

    always @(posedge clk) begin
        if (memwrite) data_mem[addr] <= writedata;
    end

    // memory-mapped io

    always @* hex = data_mem[32'd2000][15:0];

endmodule
