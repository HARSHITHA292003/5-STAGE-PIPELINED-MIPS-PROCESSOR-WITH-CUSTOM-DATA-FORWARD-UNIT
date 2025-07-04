`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:37:41 PM
// Design Name: 
// Module Name: MIPS_Processor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// =====================
// Top-Level MIPS Processor
// =====================
module MIPS_Processor(
    input wire clk,
    input wire reset
);

    // PC and IF Stage
    wire [31:0] PC, PCNext, IF_Instruction, PCPlus4;
    assign PCPlus4 = PC + 4;

    // Hazard signals
    wire Stall;
    wire PCWrite = ~Stall;

    // IF Stage
    IF_Stage IF_Stage_inst (
        .clk(clk),
        .reset(reset),
        .PCWrite(PCWrite),
        .PCNext(PCNext),
        .PC(PC),
        .Instruction(IF_Instruction)
    );

    // IF/ID Pipeline Register
    wire [31:0] IFID_PCPlus4, IFID_Instruction;
    IF_ID_Reg IF_ID (
        .clk(clk),
        .reset(reset),
        .PCPlus4_in(PCPlus4),
        .Instruction_in(IF_Instruction),
        .Stall(Stall),
        .PCPlus4_out(IFID_PCPlus4),
        .Instruction_out(IFID_Instruction)
    );

    // Decode stage signals
    wire [5:0] opcode = IFID_Instruction[31:26];
    wire [4:0] rs = IFID_Instruction[25:21];
    wire [4:0] rt = IFID_Instruction[20:16];
    wire [4:0] rd = IFID_Instruction[15:11];
    wire [15:0] imm = IFID_Instruction[15:0];
    wire [5:0] funct = IFID_Instruction[5:0];

    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
    wire [3:0] ALUOp;

    // Control Unit
    Control_Unit ctrl (
        .opcode(opcode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUOp(ALUOp)
    );

    // Register File
    wire [31:0] RD1, RD2;
    wire [31:0] WB_WriteData;
    wire [4:0] WB_WriteReg;
    wire WB_RegWrite, WB_MemtoReg;

    Register_File regfile (
        .clk(clk),
        .RegWrite(WB_RegWrite),
        .ReadReg1(rs),
        .ReadReg2(rt),
        .WriteReg(WB_WriteReg),
        .WriteData(WB_WriteData),
        .ReadData1(RD1),
        .ReadData2(RD2)
    );

    // Sign Extend
    wire [31:0] SignExtImm = {{16{imm[15]}}, imm};

    // ID/EX Pipeline Register
    wire [31:0] IDEX_RD1, IDEX_RD2, IDEX_Imm;
    wire [4:0] IDEX_Rs, IDEX_Rt, IDEX_Rd;
    wire [3:0] IDEX_ALUOp;
    wire IDEX_RegDst, IDEX_ALUSrc, IDEX_MemtoReg, IDEX_RegWrite, IDEX_MemRead, IDEX_MemWrite;
    wire [5:0] IDEX_Funct;

    ID_EX_Reg idex (
        .clk(clk),
        .reset(reset),
        .flush_ID_EX(1'b0),
        .ReadData1_in(RD1),
        .ReadData2_in(RD2),
        .SignExtImm_in(SignExtImm),
        .Rs_in(rs),
        .Rt_in(rt),
        .Rd_in(rd),
        .Funct_in(funct),
        .ALUOp_in(ALUOp),
        .RegDst_in(RegDst),
        .ALUSrc_in(ALUSrc),
        .MemtoReg_in(MemtoReg),
        .RegWrite_in(RegWrite),
        .MemRead_in(MemRead),
        .MemWrite_in(MemWrite),
        .ReadData1_out(IDEX_RD1),
        .ReadData2_out(IDEX_RD2),
        .SignExtImm_out(IDEX_Imm),
        .Rs_out(IDEX_Rs),
        .Rt_out(IDEX_Rt),
        .Rd_out(IDEX_Rd),
        .Funct_out(IDEX_Funct),
        .ALUOp_out(IDEX_ALUOp),
        .RegDst_out(IDEX_RegDst),
        .ALUSrc_out(IDEX_ALUSrc),
        .MemtoReg_out(IDEX_MemtoReg),
        .RegWrite_out(IDEX_RegWrite),
        .MemRead_out(IDEX_MemRead),
        .MemWrite_out(IDEX_MemWrite)
    );

    // Forwarding Unit
    wire [1:0] ForwardA, ForwardB;
    wire [4:0] EXMEM_WriteReg, MEMWB_WriteReg;
    wire EXMEM_RegWrite, MEMWB_RegWrite;

    Forwarding_Unit fwd (
        .EX_RS(IDEX_Rs),
        .EX_RT(IDEX_Rt),
        .MEM_RD(EXMEM_WriteReg),
        .MEM_RegWrite(EXMEM_RegWrite),
        .WB_RD(MEMWB_WriteReg),
        .WB_RegWrite(MEMWB_RegWrite),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

    // Hazard Detection
    Hazard_Unit hazard (
        .ID_RS(rs),
        .ID_RT(rt),
        .EX_RT(IDEX_Rt),
        .EX_MemRead(IDEX_MemRead),
        .Stall(Stall)
    );

    // ALU Input Selection
    wire [31:0] EXMEM_ALUResult, WB_WriteData_Buffer;
    wire [31:0] ALU_A = (ForwardA == 2'b00) ? IDEX_RD1 :
                        (ForwardA == 2'b10) ? EXMEM_ALUResult :
                        (ForwardA == 2'b01) ? WB_WriteData : IDEX_RD1;

    wire [31:0] ALU_B_in = (ForwardB == 2'b00) ? IDEX_RD2 :
                           (ForwardB == 2'b10) ? EXMEM_ALUResult :
                           (ForwardB == 2'b01) ? WB_WriteData : IDEX_RD2;

    // EX Stage
    wire [31:0] ALUResult;
    wire [4:0] EX_WriteReg;

    EX_Stage ex (
        .ReadData1(ALU_A),
        .ReadData2(ALU_B_in),
        .SignExtImm(IDEX_Imm),
        .Rt(IDEX_Rt),
        .Rd(IDEX_Rd),
        .ALUOp(IDEX_ALUOp),
        .RegDst(IDEX_RegDst),
        .ALUSrc(IDEX_ALUSrc),
        .ALUResult(ALUResult),
        .WriteReg(EX_WriteReg)
    );

    // EX/MEM Pipeline Register
    wire [31:0] EXMEM_WriteData;
    wire EXMEM_MemRead, EXMEM_MemWrite, EXMEM_MemtoReg;

    EX_MEM_Reg exmem (
        .clk(clk),
        .reset(reset),
        .ALUResult_in(ALUResult),
        .WriteData_in(ALU_B_in),
        .WriteReg_in(EX_WriteReg),
        .RegWrite_in(IDEX_RegWrite),
        .MemRead_in(IDEX_MemRead),
        .MemWrite_in(IDEX_MemWrite),
        .MemtoReg_in(IDEX_MemtoReg),
        .ALUResult_out(EXMEM_ALUResult),
        .WriteData_out(EXMEM_WriteData),
        .WriteReg_out(EXMEM_WriteReg),
        .RegWrite_out(EXMEM_RegWrite),
        .MemRead_out(EXMEM_MemRead),
        .MemWrite_out(EXMEM_MemWrite),
        .MemtoReg_out(EXMEM_MemtoReg)
    );

    // MEM Stage
    wire [31:0] MEM_ReadData;

    MEM_Stage mem (
        .clk(clk),
        .ALUResult(EXMEM_ALUResult),
        .WriteData(EXMEM_WriteData),
        .MemRead(EXMEM_MemRead),
        .MemWrite(EXMEM_MemWrite),
        .ReadData(MEM_ReadData)
    );

    // MEM/WB Pipeline Register
    wire [31:0] MEMWB_ReadData, MEMWB_ALUResult;
    wire MEMWB_MemtoReg;

    MEM_WB_Reg memwb (
        .clk(clk),
        .reset(reset),
        .ReadData_in(MEM_ReadData),
        .ALUResult_in(EXMEM_ALUResult),
        .WriteReg_in(EXMEM_WriteReg),
        .RegWrite_in(EXMEM_RegWrite),
        .MemtoReg_in(EXMEM_MemtoReg),
        .ReadData_out(MEMWB_ReadData),
        .ALUResult_out(MEMWB_ALUResult),
        .WriteReg_out(MEMWB_WriteReg),
        .RegWrite_out(MEMWB_RegWrite),
        .MemtoReg_out(MEMWB_MemtoReg)
    );

    // WB Stage
    WB_Stage wb (
        .ReadData(MEMWB_ReadData),
        .ALUResult(MEMWB_ALUResult),
        .MemtoReg(MEMWB_MemtoReg),
        .WriteData(WB_WriteData)
    );

    // PC Update
    assign PCNext = PCPlus4;

endmodule
