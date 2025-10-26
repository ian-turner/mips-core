module cpu (
    input logic clk,
    input logic reset
);

    // program and data memory, program counter

    logic [11:0] program_counter;
    logic [31:0] program_mem [4095:0];
    logic [31:0] data_mem [4095:0];

    logic [31:0] instruction;
    assign instruction = program_mem[program_counter];

    initial $readmemh("build/mem.hex", program_mem, 0, 2);

    // defining outputs for decoder

    logic [5:0] opcode;
    logic [4:0] rs;
    logic [4:0] rt;
    logic [4:0] rd;
    logic [4:0] shamt;
    logic [5:0] funct;
    logic [31:0] immediate;

    decoder decoder_ (
        .instruction(instruction),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),
        .immediate(immediate)
    );

    // defining wires for control signals

    logic regdest;
    logic regwrite;
    logic alusrc;
    logic pcsrc;
    logic memread;
    logic memwrite;
    logic memtoreg;

    controlunit controlunit_ (
        .opcode(opcode),
        .regdest(regdest),
        .regwrite(regwrite),
        .alusrc(alusrc),
        .pcsrc(pcsrc),
        .memread(memread),
        .memwrite(memwrite),
        .memtoreg(memtoreg)
    );

    // register file

    logic [31:0] reg_readdata1;
    logic [31:0] reg_readdata2;

    regfile regfile_ (
        .clk(clk),
        .regwrite(regwrite),
        .rs1(rs),
        .readdata1(reg_readdata1),
        .readdata2(reg_readdata2)
    );

    always @(posedge clk) begin
        if (reset) begin
            program_counter <= 12'b0;
        end else begin
            program_counter <= program_counter + 12'b1;
        end
    end

endmodule
