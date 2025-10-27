module controlunit (
    input logic [5:0] opcode,
    input logic [5:0] funct,
    output logic regdest,
    output logic regwrite,
    output logic [1:0] alusrc,
    output logic jump,
    output logic branch,
    output logic memread,
    output logic memwrite,
    output logic memtoreg
);

    always_comb begin
        regdest = 1'b0;
        regwrite = 1'b0;
        jump = 1'b0;
        branch = 1'b0;
        alusrc = 2'b0;
        memread = 1'b0;
        memwrite = 1'b0;
        memtoreg = 1'b0;

        case (opcode)
            6'h00 : begin
                // R-type instructions
                regwrite = 1'b1;
                regdest = 1'b1;
                if (funct == 6'h00 || funct == 6'h02) begin // sll, srl
                    alusrc = 2'd2;
                end
            end
            6'h08 : begin
                // addi
                regwrite = 1'b1;
                alusrc = 2'b1;
            end
            6'h23 : begin
                // lw
                regwrite = 1'b1;
                alusrc = 2'b1;
                memread = 1'b1;
                memtoreg = 1'b1;
            end
            6'h2B : begin
                // sw
                memwrite = 1'b1;
                alusrc = 2'b1;
            end
            6'h04 : begin
                // beq
                branch = 1'b1;
                alusrc = 2'b1;
            end
            6'h02 : jump = 1'b1;
        endcase
    end

endmodule
