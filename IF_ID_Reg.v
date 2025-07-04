`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:43:36 PM
// Design Name: 
// Module Name: IF_ID_Reg
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
// IF/ID Register
// =====================
module IF_ID_Reg(
    input wire clk,
    input wire reset,
    input wire Stall,  // renamed from IF_ID_Write
    input wire [31:0] PCPlus4_in,
    input wire [31:0] Instruction_in,
    output reg [31:0] PCPlus4_out,
    output reg [31:0] Instruction_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PCPlus4_out <= 0;
            Instruction_out <= 0;
        end else if (!Stall) begin
            PCPlus4_out <= PCPlus4_in;
            Instruction_out <= Instruction_in;
        end
    end
endmodule

