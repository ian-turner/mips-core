module datamem (    
    input logic clk,
    input logic memwrite,
    input logic memread,
    input logic [31:0] addr,
    input logic [31:0] writedata,
    output logic [31:0] readdata
);
    logic [31:0] data_mem [4095:0];

    always @* readdata = data_mem[addr];

    always @(posedge clk) begin
        if (memwrite) data_mem[addr] <= writedata;
    end

endmodule
