`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:55:07 PM
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit(
    input wire [4:0] ID_RS, ID_RT,
    input wire [4:0] EX_RT,
    input wire EX_MemRead,
    output reg Stall
);
    always @(*) begin
        Stall = 0;
        if (EX_MemRead && (EX_RT == ID_RS || EX_RT == ID_RT))
            Stall = 1;
    end
endmodule
module Register_File(
    input wire clk,
    input wire RegWrite,
    input wire [4:0] ReadReg1, ReadReg2,
    input wire [4:0] WriteReg,
    input wire [31:0] WriteData,
    output wire [31:0] ReadData1, ReadData2
);
    reg [31:0] regs[0:31];
    integer i;


 always @(posedge clk) begin
        if (RegWrite && WriteReg != 0)
            regs[WriteReg] <= WriteData;
    end

    assign ReadData1 = regs[ReadReg1];
    assign ReadData2 = regs[ReadReg2];

    initial begin
        for(i=0;i<32;i=i+1)
            regs[i] = i;
    end
endmodule

