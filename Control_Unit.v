`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:53:02 PM
// Design Name: 
// Module Name: Control_Unit
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

module Control_Unit(
    input wire [5:0] opcode,
    output wire RegDst, ALUSrc, MemtoReg, RegWrite,
    output wire MemRead, MemWrite,
    output wire [3:0] ALUOp
);
    assign RegDst = (opcode == 6'b000000);
    assign ALUSrc = (opcode == 6'b100011 || opcode == 6'b101011 || opcode == 6'b001000); // lw, sw, addi
    assign MemtoReg = (opcode == 6'b100011); // lw
    assign RegWrite = (opcode == 6'b000000 || opcode == 6'b100011 || opcode == 6'b001000); // R-type, lw, addi
    assign MemRead = (opcode == 6'b100011);
    assign MemWrite = (opcode == 6'b101011);
    assign ALUOp = (opcode == 6'b000000) ? 4'b0010 : // R-type add
                   (opcode == 6'b100011 || opcode == 6'b101011 || opcode == 6'b001000) ? 4'b0010 : // lw/sw/addi
                   4'b0000;
endmodule
