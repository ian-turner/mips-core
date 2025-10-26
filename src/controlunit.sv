module controlunit (
    input logic [5:0] opcode,
    output logic regdest,
    output logic regwrite,
    output logic alusrc,
    output logic pcsrc,
    output logic memread,
    output logic memwrite,
    output logic memtoreg
);

    always_comb begin
        regdest = 1'b0;
        regwrite = 1'b0;
        pcsrc = 1'b0;
        alusrc = 1'b0;
        memread = 1'b0;
        memwrite = 1'b0;
        memtoreg = 1'b0;

        
    end

endmodule
