`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:44:39 PM
// Design Name: 
// Module Name: ID_Stage
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
// ID Stage//
module ID_Stage(
    input wire clk,
    input wire reset,
    input wire [31:0] PC,
    input wire [31:0] Instruction,
    input wire RegWrite,
    input wire [4:0] WriteReg,
    input wire [31:0] WriteData,
    output wire [4:0] Rs,
    output wire [4:0] Rt,
    output wire [4:0] Rd,
    output wire [5:0] Opcode,
    output wire [5:0] Funct,
    output reg [31:0] ReadData1,
    output reg [31:0] ReadData2,
    output reg [31:0] SignExtImm
);
    reg [31:0] RegFile[0:31];
    integer i;
    assign Rs = Instruction[25:21];
    assign Rt = Instruction[20:16];
    assign Rd = Instruction[15:11];
    assign Opcode = Instruction[31:26];
    assign Funct = Instruction[5:0];

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            for(i=0;i<32;i=i+1)
                RegFile[i]<=i;
        end else if(RegWrite && WriteReg!=0) begin
            RegFile[WriteReg]<=WriteData;
        end
    end

    always @(*) begin
        ReadData1=RegFile[Rs];
        ReadData2=RegFile[Rt];
        SignExtImm={{16{Instruction[15]}},Instruction[15:0]};
    end
endmodule
