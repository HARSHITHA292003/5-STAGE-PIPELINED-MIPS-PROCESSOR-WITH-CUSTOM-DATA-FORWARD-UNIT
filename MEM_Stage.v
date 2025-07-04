`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:49:26 PM
// Design Name: 
// Module Name: MEM_Stage
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
module MEM_Stage(
    input wire clk,
    input wire [31:0] ALUResult,
    input wire [31:0] WriteData,
    input wire MemRead,
    input wire MemWrite,
    output reg [31:0] ReadData
);
    reg [31:0] DMem[0:255];
    integer i;
    initial begin
        for(i=0;i<256;i=i+1) DMem[i]=0;
    end

    always @(posedge clk) begin
        if (MemWrite)
            DMem[ALUResult[9:2]] <= WriteData;
        if (MemRead)
            ReadData <= DMem[ALUResult[9:2]];
    end
endmodule
