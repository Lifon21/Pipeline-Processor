//`timescale 1ns / 1ps

module InstructionParser
(
    input [31:0] instruction, // Input Instruction
    output [6:0] opcode,      // Output opcode field (7 bits)
    output [4:0] rd,          // Ouput destination register field (5 bits)
    output [2:0] funct3,      // Output funct3 field (3 bits)
    output [4:0] rs1,        //  Output source register 1 field (5 bits)
    output [4:0] rs2,        //  Output source register 2 field (5 bits)
    output [6:0] funct7      // Output funct7 field (7 bits)
);
assign opcode = instruction [6:0]; // Extract opcode from bits 6 to 0 of the instruction
assign rd = instruction [11:7];    // Extract destination register from bits 11 to 7 of the instruction
assign funct3 = instruction [14:12];  // Extract funct3 from bits 14 to 12 of the instruction
assign rs1 = instruction [19:15];   // Extract source register 1 from bits 19 to 15 of the instruction
assign rs2 = instruction [24:20];  // Extract source register 2 from bits 24 to 20 of the instruction
assign funct7 = instruction [31:25];  // Extract funct7 from bits 31 to 25 of the instruction
endmodule
