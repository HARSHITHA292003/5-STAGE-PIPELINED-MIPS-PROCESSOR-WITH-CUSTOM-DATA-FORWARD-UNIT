`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:42:00 PM
// Design Name: 
// Module Name: IF_Stage
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
// IF Stage
// =====================
module IF_Stage(
    input wire clk,
    input wire reset,
    input wire PCWrite,
    input wire [31:0] PCNext,
    output reg [31:0] PC,
    output reg [31:0] Instruction
);
    reg [31:0] IMEM [0:255];
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 0; 
            // Expanded instruction set (40 instructions)
            IMEM[0]  <= 32'h8C220004; // lw   $2, 4($1)
            IMEM[1]  <= 32'h00432020; // add  $4, $2, $3
            IMEM[2]  <= 32'hAC250008; // sw   $5, 8($1)
            IMEM[3]  <= 32'h10430002; // beq  $2, $3, 2
            IMEM[4]  <= 32'h20440005; // addi $4, $2, 5
            IMEM[5]  <= 32'h00853822; // sub  $7, $4, $5
            IMEM[6]  <= 32'h10A70003; // beq  $5, $7, 3
            IMEM[7]  <= 32'hAC27000C; // sw   $7, 12($1)
            IMEM[8]  <= 32'h2008000A; // addi $8, $0, 10
            IMEM[9]  <= 32'h01095020; // add  $10, $8, $9
            IMEM[10] <= 32'h014B5822; // sub  $11, $10, $11
            IMEM[11] <= 32'h00000000; // nop
            IMEM[12] <= 32'h08000003; // j    12
            IMEM[13] <= 32'hAC280010; // sw   $8, 16($1)
            IMEM[14] <= 32'h8C290010; // lw   $9, 16($1)
            IMEM[15] <= 32'h012A6024; // and  $12, $9, $10
            IMEM[16] <= 32'h014B6825; // or   $13, $10, $11
            IMEM[17] <= 32'h018C702A; // slt  $14, $12, $12
            IMEM[18] <= 32'h11C00003; // beq  $14, $0, 3
            IMEM[19] <= 32'h8C220004; // lw   $2, 4($1)
            IMEM[20] <= 32'h00432020; // add  $4, $2, $3
            IMEM[21] <= 32'hAC250008; // sw   $5, 8($1)
            IMEM[22] <= 32'h10430002; // beq  $2, $3, 2
            IMEM[23] <= 32'h20440005; // addi $4, $2, 5
            IMEM[24] <= 32'h00853822; // sub  $7, $4, $5
            IMEM[25] <= 32'h10A70003; // beq  $5, $7, 3
            IMEM[26] <= 32'hAC27000C; // sw   $7, 12($1)
            IMEM[27] <= 32'h2008000A; // addi $8, $0, 10
            IMEM[28] <= 32'h01095020; // add  $10, $8, $9
            IMEM[29] <= 32'h014B5822; // sub  $11, $10, $11
            IMEM[30] <= 32'hAC280010; // sw   $8, 16($1)
            IMEM[31] <= 32'h8C290010; // lw   $9, 16($1)
            IMEM[32] <= 32'h012A6024; // and  $12, $9, $10
            IMEM[33] <= 32'h014B6825; // or   $13, $10, $11
            IMEM[34] <= 32'h018C702A; // slt  $14, $12, $12
            IMEM[35] <= 32'h11C00003; // beq  $14, $0, 3
            IMEM[36] <= 32'h00000000; // nop
            IMEM[37] <= 32'h00000000; // nop
            IMEM[38] <= 32'h00000000; // nop
            IMEM[39] <= 32'h08000001; // j    4

            // Remaining instructions set to nop
            for (i = 40; i < 256; i = i + 1)
                IMEM[i] = 32'h00000000;
        end else if (PCWrite) begin
            PC <= PCNext;
        end
    end

    always @(*) begin
        Instruction = IMEM[PC[9:2]]; // Word-aligned
    end
endmodule
