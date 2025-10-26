`timescale 1ns / 1ps `default_nettype none

module hexdriver (
    input wire logic clk,
    input logic [15:0] data,
    output logic [3:0] anode,
    output logic [7:0] seg
);

    // driving anode
    logic [15:0] anode_counter;
    logic anode_clk = anode_counter[15];

    initial begin
        anode = 4'b0111;
    end

    always_ff @(posedge clk) begin
        anode_counter <= anode_counter + 16'b1;
    end

    always_ff @(posedge anode_clk) begin
        anode <= {anode[2:0], anode[3]};
    end

    // selecting segment output
    logic [3:0] seg_data;

    always @* begin
        case (anode)
            4'b1110: seg_data = data[3:0];
            4'b1101: seg_data = data[7:4];
            4'b1011: seg_data = data[11:8];
            4'b0111: seg_data = data[15:12];
            default: seg_data = 4'b0;
        endcase
    end

    always_comb begin
        case (seg_data)
            4'h0: seg = 8'b11000000;
            4'h1: seg = 8'b11111001;
            4'h2: seg = 8'b10100100;
            4'h3: seg = 8'b10110000;
            4'h4: seg = 8'b10011001;
            4'h5: seg = 8'b10010010;
            4'h6: seg = 8'b10000010;
            4'h7: seg = 8'b11111000;
            4'h8: seg = 8'b10000000;
            4'h9: seg = 8'b10010000;
            4'hA: seg = 8'b10001000;
            4'hB: seg = 8'b10000011;
            4'hC: seg = 8'b11000110;
            4'hD: seg = 8'b10100001;
            4'hE: seg = 8'b10000110;
            4'hF: seg = 8'b10001110;
            default: seg = 8'b11111111;
        endcase
    end

endmodule
