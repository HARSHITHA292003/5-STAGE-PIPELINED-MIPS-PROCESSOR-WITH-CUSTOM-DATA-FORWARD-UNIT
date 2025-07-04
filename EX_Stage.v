`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:47:20 PM
// Design Name: 
// Module Name: EX_Stage
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

module EX_Stage(
    input wire [31:0] ReadData1, ReadData2, SignExtImm,
    input wire [4:0] Rt, Rd,
    input wire [3:0] ALUOp,
    input wire RegDst, ALUSrc,
    output wire [31:0] ALUResult,
    output wire [4:0] WriteReg
);
    wire [31:0] SrcB = ALUSrc ? SignExtImm : ReadData2;
    assign WriteReg = RegDst ? Rd : Rt;

    assign ALUResult = (ALUOp == 4'b0010) ? (ReadData1 + SrcB) :
                       (ALUOp == 4'b0110) ? (ReadData1 - SrcB) :
                       (ALUOp == 4'b0000) ? (ReadData1 & SrcB) :
                       (ALUOp == 4'b0001) ? (ReadData1 | SrcB) :
                       32'b0;
endmodule
