module alu (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [3:0] op,
    output logic zero,
    output logic [31:0] result
);

    assign result =
        (op == 4'b0000) ? A & B :
        (op == 4'b0001) ? A | B :
        (op == 4'b0010) ? A + B :
        (op == 4'b0110) ? A - B :
        (op == 4'b0111) ? (A < B) :
        (op == 4'b1100) ? ~(A | B) :
        32'b0;

endmodule
