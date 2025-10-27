module alucontrol (
    input logic [5:0] opcode,
    input logic [5:0] funct,
    output logic [3:0] aluop
);

    always_comb begin
        aluop = 4'b0000;
        if (opcode == 6'h08) aluop = 4'b0010; // addi
        else if (opcode == 6'h00 && funct == 6'h20) aluop = 4'd2; // add
        else if (opcode == 6'h23 || opcode == 6'h2B) aluop = 4'd2; // lw, sw
        else if (opcode == 6'h00 && funct == 6'h00) aluop = 4'd3; // sll
    end

endmodule
