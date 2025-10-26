`timescale 1ns / 1ps `default_nettype none

module top (
    input wire logic clk,
    input logic btnC,
    input logic btnU,
    input logic btnL,
    input logic btnR,
    input logic btnD,
    input logic [15:0] sw,
    output logic [3:0] anode,
    output logic [7:0] segment,
    output logic [15:0] led
);

    logic [25:0] counter;

    always @(posedge clk) begin
        counter <= counter + 26'b1;
    end

    hexdriver hexdriver_ (
        .clk(clk),
        .data({15'b0, counter[25]}),
        .anode(anode),
        .seg(segment)
    );

endmodule
