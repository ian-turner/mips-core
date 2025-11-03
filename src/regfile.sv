module regfile (
    input logic clk,
    input logic regwrite,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] writedata,
    output logic [31:0] readdata1,
    output logic [31:0] readdata2
);

    logic [31:0] mem [31:0];

    assign readdata1 = rs1 == 5'b0 ? 32'b0 : mem[rs1];
    assign readdata2 = rs2 == 5'b0 ? 32'b0 : mem[rs2];

    always_ff @(posedge clk) begin
        if (regwrite) mem[rd] <= writedata;
    end

    initial begin
        mem[29] = 32'd1000;
    end

endmodule
