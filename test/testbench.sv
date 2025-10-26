`timescale 1ns/1ps


module testbench;
    logic clk;
    logic reset;

    // device under test (the cpu module)
    cpu cpu_ (clk, reset);

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
