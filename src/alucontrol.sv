module alucontrol (
    input logic [5:0] opcode,
    input logic [5:0] funct,
    output logic [3:0] aluop
);

    always_comb begin
        aluop = 4'b0000;
        if (opcode == 6'h08) aluop = 4'b0010; // addi
    end

endmodule
