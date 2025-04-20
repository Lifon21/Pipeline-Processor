//`timescale 1ns / 1ps

module Imm_Gen
(
    input [31:0] ins,  // Input Instruction
    output reg [63:0] imm_data  // Output immediate value
);

reg [11:0] ld_imm;  // Load immediate value
reg [11:0] sd_imm;  // Store immediate value
reg [11:0] br_imm;  // Branch immediate value
wire [1:0] sel;  // Selector for Intruction type
 
assign sel = ins [6:5];  // Determine instruction type based on opcode bits [6:5]
// Define local parameters for instruction types
localparam [1:0]
ld_ins = 2'b00,
sd_ins = 2'b01,
br_ins = 2'b11;

    always @ (ins)
    begin
        case (sel)
        ld_ins: //I-type instruction
            begin
            ld_imm = ins [31:20];  // Extract immediate value
            imm_data = {{52{ins[31]}}, ld_imm};  // Sign-extend immediate value
            end
        sd_ins: //S-type instruction
            begin
            sd_imm = {ins [31:25], ins[11:7]};  // Extract immediate value
            imm_data = {{52{ins[31]}}, sd_imm}; // Sign-extend immediate value
            end
        br_ins: //Branch-type instruction
            begin
            br_imm = {ins [31], ins [7], ins [30:25], ins [11:8]};  // Extract immediate value
            imm_data = {{52{ins[31]}}, br_imm};  // Sign-extend immediate value
            end
        default: imm_data = 64'h0000000000000000;  // Default case
        endcase
    end
endmodule

// The Imm_Gen module is responsible for generating immediate values used in different types of instructions (I-type, S-type, and branch instructions).
// It takes an input instruction ins (32 bits) and generates a corresponding 64-bit immediate value imm_data.
// The module includes registers ld_imm, sd_imm, and br_imm to store immediate values for different instruction types.
// A wire sel is used to select the instruction type based on bits [6:5] of the input instruction

