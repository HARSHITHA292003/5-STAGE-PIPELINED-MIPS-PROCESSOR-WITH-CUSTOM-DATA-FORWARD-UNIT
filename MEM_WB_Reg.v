`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:50:40 PM
// Design Name: 
// Module Name: MEM_WB_Reg
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

module MEM_WB_Reg(
    input wire clk, reset,
    input wire [31:0] ReadData_in, ALUResult_in,
    input wire [4:0] WriteReg_in,
    input wire RegWrite_in, MemtoReg_in,
    output reg [31:0] ReadData_out, ALUResult_out,
    output reg [4:0] WriteReg_out,
    output reg RegWrite_out, MemtoReg_out
);
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            ReadData_out<=0; ALUResult_out<=0; WriteReg_out<=0;
            RegWrite_out<=0; MemtoReg_out<=0;
        end else begin
            ReadData_out<=ReadData_in; ALUResult_out<=ALUResult_in;
            WriteReg_out<=WriteReg_in;
            RegWrite_out<=RegWrite_in; MemtoReg_out<=MemtoReg_in;
        end
    end
endmodule
