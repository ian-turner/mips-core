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

    logic memread;
    logic memwrite;
    logic [31:0] mem_addr;
    logic [31:0] mem_writedata;
    logic [31:0] mem_readdata;

    logic [15:0] hex;

    mmio mmio_ (
        .clk(clk),
        .memread(memread),
        .memwrite(memwrite),
        .addr(mem_addr),
        .writedata(mem_writedata),
        .readdata(mem_readdata),

        .hex(hex),
        .led(led),
        .sw(sw),
        .btnC(btnC),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD)
    );

    cpu cpu_ (
        .clk(clk),
        .reset(btnL && btnR),
        .memread(memread),
        .memwrite(memwrite),
        .mem_addr(mem_addr),
        .mem_writedata(mem_writedata),
        .mem_readdata(mem_readdata)
    );

    hexdriver hexdriver_ (
        .clk(clk),
        .data(hex),
        .anode(anode),
        .seg(segment)
    );

endmodule
