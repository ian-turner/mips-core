module mmio (    
    input logic clk,
    input logic memwrite,
    input logic memread,
    input logic [31:0] addr,
    input logic [31:0] writedata,
    output logic [31:0] readdata,

    // io signals
    input logic btnC,
    input logic btnU,
    input logic btnL,
    input logic btnR,
    input logic btnD,
    input logic [15:0] sw,
    output logic [15:0] hex,
    output logic [15:0] led
);
    logic [31:0] data_mem [1023:0];

    // reading from memory/io
    always @* begin
        case (addr)
            32'h404 : readdata = {16'b0, sw};
            32'h408 : readdata = {31'b0, btnC};
            32'h40C : readdata = {31'b0, btnU};
            32'h410 : readdata = {31'b0, btnL};
            32'h414 : readdata = {31'b0, btnR};
            32'h418 : readdata = {31'b0, btnD};
            default : readdata = data_mem[addr];
        endcase
    end

    always @(posedge clk) begin
        // writing to memory/io
        if (memwrite) begin
            case (addr)
                32'h400 : hex <= writedata;
                32'h41C : led <= writedata;
                default : data_mem[addr] <= writedata;
            endcase
        end
    end

endmodule
