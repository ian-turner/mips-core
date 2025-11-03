module controlunit (
    input logic [5:0] opcode, funct,
    output logic [1:0] alusrcB,
    output logic regdest,
    regwrite,
    alusrcA,
    jump,
    jump_return,
    branch,
    memread,
    memwrite,
    memtoreg
);

    always_comb begin
        regdest = 1'b0;
        regwrite = 1'b0;
        jump = 1'b0;
        jump_return = 1'b0;
        branch = 1'b0;
        alusrcA = 1'b0;
        alusrcB = 2'b0;
        memread = 1'b0;
        memwrite = 1'b0;
        memtoreg = 1'b0;

        case (opcode)
            6'h00 : begin
                // R-type instructions
                regwrite = 1'b1;
                regdest = 1'b1;
                case (funct)
                    6'h00, 6'h02: begin // sll, srl
                        alusrcA = 1'b1;
                        alusrcB = 2'd2;
                    end
                    6'h08 : jump_return = 1'b1; // jr
                endcase
            end
            6'h08, 6'h09 : begin
                // addi, addiu
                regwrite = 1'b1;
                alusrcB = 2'b1;
            end
            6'h23 : begin
                // lw
                regwrite = 1'b1;
                alusrcB = 2'b1;
                memread = 1'b1;
                memtoreg = 1'b1;
            end
            6'h2B : begin
                // sw
                memwrite = 1'b1;
                alusrcB = 2'b1;
            end
            6'h04 : begin
                // beq
                branch = 1'b1;
                alusrcB = 2'd0;
            end
            6'h02 : jump = 1'b1;
        endcase
    end

endmodule
