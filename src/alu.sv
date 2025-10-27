module alu (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [3:0] op,
    output logic zero,
    output logic [31:0] result
);

    assign result =
        (op == 4'd0) ? A & B :
        (op == 4'd1) ? A | B :
        (op == 4'd2) ? A + B :
        (op == 4'd3) ? A << B :
        (op == 4'd4) ? A >> B :
        (op == 4'd6) ? A - B :
        (op == 4'b0111) ? (A < B) :
        (op == 4'b1100) ? ~(A | B) :
        32'b0;

    assign zero = result == 32'b0;

endmodule
