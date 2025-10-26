`timescale 1ns/1ps


module testbench;
    logic clk;
    logic reset;

    logic memwrite;
    logic memread;
    logic [31:0] mem_addr;
    logic [31:0] mem_writedata;
    logic [31:0] mem_readdata;

    logic [15:0] hex;

    mmio mmio_ (
        .clk(clk),
        .memwrite(memwrite),
        .memread(memread),
        .addr(mem_addr),
        .writedata(mem_writedata),
        .readdata(mem_readdata),

        .sw(16'd53),
        .hex(hex)
    );

    cpu cpu_ (
        .clk(clk),
        .reset(reset),
        .memwrite(memwrite),
        .memread(memread),
        .mem_addr(mem_addr),
        .mem_writedata(mem_writedata),
        .mem_readdata(mem_readdata)
    );

    initial begin
        $dumpfile("build/testbench.vcd");
        $dumpvars(0,testbench);

        // initializing clock and pulsing reset
        clk = 1'b1;
        reset = 1'b1;
        #1;

        clk = 1'b0;
        reset = 1'b0;
        #1;

        // driving clock for num ticks
        for (int i=0; i<100; i++) begin
            clk <= ~clk;
            #1;
        end
    end
endmodule
