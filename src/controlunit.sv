module controlunit (
    input logic [5:0] opcode,
    output logic regdest,
    output logic regwrite,
    output logic alusrc,
    output logic jump,
    output logic memread,
    output logic memwrite,
    output logic memtoreg
);

    always_comb begin
        regdest = 1'b0;
        regwrite = 1'b0;
        jump = 1'b0;
        alusrc = 1'b0;
        memread = 1'b0;
        memwrite = 1'b0;
        memtoreg = 1'b0;

        case (opcode)
            6'h00 : begin
                // R-type instructions
                regwrite = 1'b1;
                regdest = 1'b1;
            end
            6'h08 : begin
                // addi
                regwrite = 1'b1;
                alusrc = 1'b1;
            end
            6'h23 : begin
                // lw
                regwrite = 1'b1;
                alusrc = 1'b1;
                memread = 1'b1;
                memtoreg = 1'b1;
            end
            6'h2B : begin
                // sw
                memwrite = 1'b1;
                alusrc = 1'b1;
            end
            6'h02 : jump = 1'b1;
        endcase
    end

endmodule
