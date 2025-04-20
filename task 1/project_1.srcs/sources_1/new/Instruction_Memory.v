//`timescale 1ns / 1ps

module Instruction_Memory
(
    input [63:0] Inst_Address,
    output [31:0] Instruction
);

// Declare memory to store instructions
reg [7:0] memory [131:0]; // Memory array to store instructions - each instruction is 8 bits 

// Initialise array with Instructions
initial 
begin
// INSTRUCTION 1: addi x10, x0, 0x100
memory[0]  = 8'h13;
memory[1]  = 8'h05;
memory[2]  = 8'h40;
memory[3]  = 8'h00;

// INSTRUCTION 2: addi x11, x0, 7
memory[4]  = 8'h93;
memory[5]  = 8'h05;
memory[6]  = 8'h70;
memory[7]  = 8'h00;

// INSTRUCTION 3: bne x10, x0, ELSE
memory[8]  = 8'h63;
memory[9]  = 8'h16;
memory[10] = 8'h05;
memory[11] = 8'h00;

// INSTRUCTION 4: bne x11, x0, ELSE
memory[12] = 8'h63;
memory[13] = 8'h94;
memory[14] = 8'h05;
memory[15] = 8'h00;

// INSTRUCTION 5: beq x0, x0, EXIT1
memory[16] = 8'h63;
memory[17] = 8'h0C;
memory[18] = 8'h00;
memory[19] = 8'h04;

// INSTRUCTION 6: addi x18, x0, 0
memory[20] = 8'h13;
memory[21] = 8'h09;
memory[22] = 8'h00;
memory[23] = 8'h00;

// INSTRUCTION 7: beq x18, x11, EXIT1
memory[24] = 8'h63;
memory[25] = 8'h06;
memory[26] = 8'hB9;
memory[27] = 8'h04;

// INSTRUCTION 8: add x19, x0, x18
memory[28] = 8'hB3;
memory[29] = 8'h09;
memory[30] = 8'h20;
memory[31] = 8'h01;

// INSTRUCTION 9: beq x19, x11, EXIT2
memory[32] = 8'h63;
memory[33] = 8'h8E;
memory[34] = 8'hB9;
memory[35] = 8'h02;

// INSTRUCTION 10: slli x5, x18, 2
memory[36] = 8'h93;
memory[37] = 8'h12;
memory[38] = 8'h39;
memory[39] = 8'h00;

// INSTRUCTION 11: slli x6, x19, 2
memory[40] = 8'h13;
memory[41] = 8'h93;
memory[42] = 8'h39;
memory[43] = 8'h00;

// INSTRUCTION 12: add x5, x5, x10
memory[44] = 8'hB3;
memory[45] = 8'h82;
memory[46] = 8'hA2;
memory[47] = 8'h00;

// INSTRUCTION 13: add x6, x6, x10
memory[48] = 8'h33;
memory[49] = 8'h03;
memory[50] = 8'hA3;
memory[51] = 8'h00;

// INSTRUCTION 14: ld x28, 0(x5)
memory[52] = 8'h03;
memory[53] = 8'hBE;
memory[54] = 8'h02;
memory[55] = 8'h00;

// INSTRUCTION 15: ld x29, 0(x6)
memory[56] = 8'h83;
memory[57] = 8'h3E;
memory[58] = 8'h03;
memory[59] = 8'h00;

// INSTRUCTION 16: bge x28, x29, 24
memory[60] = 8'h63;
memory[61] = 8'h5C;
memory[62] = 8'hDE;
memory[63] = 8'h01;

// INSTRUCTION 17: add x30, x0, x28
memory[64] = 8'h33;
memory[65] = 8'h0F;
memory[66] = 8'hC0;
memory[67] = 8'h01;

// INSTRUCTION 18: add x28, x0, x29
memory[68] = 8'h33;
memory[69] = 8'h0E;
memory[70] = 8'hD0;
memory[71] = 8'h01;

// INSTRUCTION 19: add x29, x0, x30
memory[72] = 8'hB3;
memory[73] = 8'h0E;
memory[74] = 8'hE0;
memory[75] = 8'h01;

// sd x28, 0(x5)
memory[76] = 8'h23;
memory[77] = 8'hB0;
memory[78] = 8'hC2;
memory[79] = 8'h01;

// sd x29, 0(x6)
memory[80] = 8'h23;
memory[81] = 8'h30;
memory[82] = 8'hD3;
memory[83] = 8'h01;

// addi x19, x19, 1
memory[84] = 8'h93;
memory[85] = 8'h89;
memory[86] = 8'h19;
memory[87] = 8'h00;

// beq x0, x0, BUBBLE2
memory[88] = 8'hE3;
memory[89] = 8'h04;
memory[90] = 8'h00;
memory[91] = 8'hFC;

// addi x18, x18, 1
memory[92] = 8'h13;
memory[93] = 8'h09;
memory[94] = 8'h19;
memory[95] = 8'h00;

// beq x0, x0, BUBBLE1
memory[96] = 8'hE3;
memory[97] = 8'h0C;
memory[98] = 8'h00;
memory[99] = 8'hFA;

// beq x0, x0, 4
memory[100] = 8'h63;
memory[101] = 8'h02;
memory[102] = 8'h00;
memory[103] = 8'h00;

// addi x0, x0, 0
memory[104] = 8'h13;
memory[105] = 8'h00;
memory[106] = 8'h00;
memory[107] = 8'h00;



end

// Assign output instruction from memory based on input instruction address
assign Instruction = {memory[Inst_Address+3], memory[Inst_Address+2],
       memory[Inst_Address+1], memory[Inst_Address]}; 

endmodule

// The Instruction_Memory module is responsible for storing and providing instructions based on the given instruction address.
// It has an input Inst_Address for specifying the address of the instruction to be fetched and an output Instruction for providing the fetched instruction.
// The Instruction output is assigned by concatenating the four bytes of the instruction stored in memory at the specified address.
