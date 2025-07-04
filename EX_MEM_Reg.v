`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:48:10 PM
// Design Name: 
// Module Name: EX_MEM_Reg
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

module EX_MEM_Reg(
    input wire clk, reset,
    input wire [31:0] ALUResult_in, WriteData_in,
    input wire [4:0] WriteReg_in,
    input wire RegWrite_in, MemRead_in, MemWrite_in, MemtoReg_in,
    output reg [31:0] ALUResult_out, WriteData_out,
    output reg [4:0] WriteReg_out,
    output reg RegWrite_out, MemRead_out, MemWrite_out, MemtoReg_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ALUResult_out <= 0; WriteData_out <= 0; WriteReg_out <= 0;
            RegWrite_out <= 0; MemRead_out <= 0; MemWrite_out <= 0; MemtoReg_out <= 0;
        end else begin
            ALUResult_out <= ALUResult_in; WriteData_out <= WriteData_in;
            WriteReg_out <= WriteReg_in;
            RegWrite_out <= RegWrite_in; MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in; MemtoReg_out <= MemtoReg_in;
        end
    end
endmodule
