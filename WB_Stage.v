`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:51:45 PM
// Design Name: 
// Module Name: WB_Stage
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

module WB_Stage(
    input wire [31:0] ReadData,
    input wire [31:0] ALUResult,
    input wire MemtoReg,
    output wire [31:0] WriteData
);
    assign WriteData = MemtoReg ? ReadData : ALUResult;
endmodule
