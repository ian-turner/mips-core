module alucontrol (
    input logic [5:0] opcode, funct,
    output logic [3:0] aluop
);

    always_comb begin
        aluop = 4'd0;

        case (opcode)
            6'h23, 6'h2B, 6'h08, 6'h09 : aluop = 4'd2; // lw, sw, addi, addiu
            6'h04 : aluop = 4'd6; // beq
            6'h00 : begin
                case (funct) 
                    6'h00 : aluop = 4'd3; // sll
                    6'h02 : aluop = 4'd4; // srl
                    6'h20 : aluop = 4'd2; // add
                endcase
            end
        endcase
    end

endmodule
