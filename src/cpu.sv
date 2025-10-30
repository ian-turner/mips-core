module cpu #(parameter PROG_MEM_WORDS = 1024) (
    input logic clk,
    input logic reset,
    input logic [31:0] mem_readdata,
    output logic memread,
    output logic memwrite,
    output logic [31:0] mem_addr,
    output logic [31:0] mem_writedata
);

    // program and data memory, program counter

    logic [11:0] program_counter;
    logic [31:0] program_mem [PROG_MEM_WORDS-1:0];

    logic [31:0] instruction;
    assign instruction = program_mem[program_counter];

    initial $readmemh("prog.hex", program_mem, 0);

    // defining outputs for decoder

    logic [5:0] opcode;
    logic [4:0] rs;
    logic [4:0] rt;
    logic [4:0] rd;
    logic [4:0] shamt;
    logic [5:0] funct;
    logic [31:0] immediate;
    logic [11:0] jumpaddr;

    decoder decoder_ (
        .instruction(instruction),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),
        .immediate(immediate),
        .jumpaddr(jumpaddr)
    );

    // defining wires for control signals

    logic regdest;
    logic regwrite;
    logic [1:0] alusrc;
    logic jump;
    logic branch;
    logic memtoreg;

    controlunit controlunit_ (
        .opcode(opcode),
        .funct(funct),
        .regdest(regdest),
        .regwrite(regwrite),
        .alusrc(alusrc),
        .jump(jump),
        .branch(branch),
        .memread(memread),
        .memwrite(memwrite),
        .memtoreg(memtoreg)
    );

    // alu

    logic alu_zero;
    logic [3:0] aluop;
    logic [31:0] alu_result;

    alucontrol alucontrol_ (
        .opcode(opcode),
        .funct(funct),
        .aluop(aluop)
    );

    alu alu_ (
        .op(aluop),
        .A((alusrc == 2'd2) ? reg_readdata2 : reg_readdata1),
        .B((alusrc == 2'd0) ? reg_readdata2 : (alusrc == 2'd1) ? immediate : shamt),
        .result(alu_result),
        .zero(alu_zero)
    );

    // memory I/O

    always @* mem_addr = alu_result;
    always @* mem_writedata = reg_readdata2;

    // register file

    logic [31:0] reg_readdata1;
    logic [31:0] reg_readdata2;

    regfile regfile_ (
        .clk(clk),
        .regwrite(regwrite),
        .rs1(rs),
        .rs2(rt),
        .rd(regdest ? rd : rt),
        .readdata1(reg_readdata1),
        .readdata2(reg_readdata2),
        .writedata(memtoreg ? mem_readdata : alu_result)
    );

    // branching logic
    logic [11:0] branchaddr;
    assign branchaddr = program_counter + immediate[11:0] + 12'b1;

    always @(posedge clk) begin
        if (reset) begin
            program_counter <= 12'b0;
        end else begin
            program_counter <= (branch && alu_zero) ? branchaddr : jump ? jumpaddr : program_counter + 12'b1;
        end
    end

endmodule
