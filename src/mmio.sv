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
    logic [31:0] data_mem [1023:0];

    // reading from memory/io
    always @* readdata = (addr == 32'h404) ? {16'b0, sw}
        : data_mem[addr];

    always @(posedge clk) begin
        // writing to memory/io
        if (memwrite) begin
            case (addr)
                32'h400 : hex <= writedata;
                default : data_mem[addr] <= writedata;
            endcase
        end
    end

endmodule
