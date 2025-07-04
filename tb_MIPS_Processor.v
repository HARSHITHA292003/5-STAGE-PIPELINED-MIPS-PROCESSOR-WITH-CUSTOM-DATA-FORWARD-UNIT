`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:57:17 PM
// Design Name: 
// Module Name: tb_MIPS_Processor
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



module tb_MIPS_Processor;

  // Clock and reset
  reg clk = 0;
  reg reset = 1;

  // Instantiate the DUT
  MIPS_Processor DUT (
    .clk(clk),
    .reset(reset)
  );

  // Clock generation: 10ns period (100 MHz)
  always #5 clk = ~clk;

  // Initialize instruction memory
  initial begin
    // Hold reset
    reset = 1;

    // Load sample instructions into instruction memory
    // Note: Use correct name DUT.IF_Stage_inst.IMEM[index]
    DUT.IF_Stage_inst.IMEM[0] = 32'b000000_00001_00010_00011_00000_100000; // ADD $3, $1, $2
    DUT.IF_Stage_inst.IMEM[1] = 32'b000000_00011_00010_00100_00000_100010; // SUB $4, $3, $2
    DUT.IF_Stage_inst.IMEM[2] = 32'b100011_00001_00101_0000000000000100;   // LW $5, 4($1)
    DUT.IF_Stage_inst.IMEM[3] = 32'b101011_00010_00101_0000000000001000;   // SW $5, 8($2)
    DUT.IF_Stage_inst.IMEM[4] = 32'b000000_00101_00011_00110_00000_100000; // ADD $6, $5, $3
    DUT.IF_Stage_inst.IMEM[5] = 32'b000000_00000_00000_00000_00000_000000; // NOP
    DUT.IF_Stage_inst.IMEM[6] = 32'b000000_00000_00000_00000_00000_000000; // NOP
    DUT.IF_Stage_inst.IMEM[7] = 32'b000000_00000_00000_00000_00000_000000; // NOP

    // Release reset after some cycles
    #20;
    reset = 0;
  end

  // Monitor important pipeline values
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    $display("Time\tPC\t\tInstruction\t\tALUResult\t\tMemReadData");
    $monitor("%0t\t%h\t%h\t%h\t%h",
      $time,
      DUT.PC,
      DUT.IF_Instruction,
      DUT.EXMEM_ALUResult,
      DUT.MEMWB_ReadData
    );
  end
  // End simulation after fixed time
  initial begin
    #500;
    $finish;
  end

endmodule
