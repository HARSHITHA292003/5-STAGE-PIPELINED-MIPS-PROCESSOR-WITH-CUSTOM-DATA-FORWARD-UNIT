`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:53:54 PM
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
    input wire [4:0] EX_RS, EX_RT,
    input wire [4:0] MEM_RD,
    input wire MEM_RegWrite,
    input wire [4:0] WB_RD,
    input wire WB_RegWrite,
    output reg [1:0] ForwardA, ForwardB
);
    always @(*) begin
        ForwardA = 2'b00;
        ForwardB = 2'b00;
        if (MEM_RegWrite && MEM_RD != 0 && MEM_RD == EX_RS)
            ForwardA = 2'b10;
        if (MEM_RegWrite && MEM_RD != 0 && MEM_RD == EX_RT)
            ForwardB = 2'b10;
        if (WB_RegWrite && WB_RD != 0 && WB_RD == EX_RS && !(MEM_RegWrite && MEM_RD != 0 && MEM_RD == EX_RS))
            ForwardA = 2'b01;
        if (WB_RegWrite && WB_RD != 0 && WB_RD == EX_RT && !(MEM_RegWrite && MEM_RD != 0 && MEM_RD == EX_RT))
            ForwardB = 2'b01;
    end
endmodule