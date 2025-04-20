//`timescale 1ns / 1ps

// CU takes 7-bit opcode input
module Control_Unit
(
    input [6:0] Opcode, // Intructions opcode
    output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, // Output Signals - control signals for various components of the processor
    output reg [1:0] ALUOp 
);
// CASE STATEMENT - decodes opcode and sets control signal according to 7-bit opcode
    always @ (*) // Block of code should run whenever signal/variable in this block changes.
        begin
            case (Opcode)
            7'b0110011: //R type
             begin
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;
                ALUOp = 2'b10; // ALU Operation for R-Type Instructions
             end
            7'b0000011: //ld
             begin
                Branch = 0;
                MemRead = 1;
                MemtoReg = 1;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00; // ALU Operation for ld Instructions
             end
            7'b0010011: //addi
               begin
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
                ALUOp = 2'b00; // ALU Operation for I-Type Instructions addi
              end
             7'b0100011: //S type
              begin
                Branch = 0;
                MemRead = 0;
                MemtoReg = 1'bX;
                MemWrite = 1;
                ALUSrc = 1;
                RegWrite = 0;
                ALUOp = 2'b00; // ALU Operation for S-Type Instructions
               end
            7'b1100011: //SB
             begin
            Branch = 1; // Branch Instruction
            MemRead = 0;
            MemtoReg = 1'bX;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            ALUOp = 2'b01; // ALU Operation for R-Type Instructions
             end
        endcase
    end
endmodule

//The control unit in a processor is responsible for coordinating and managing the execution of instructions by generating control signals that regulate the operation of various functional units within the processor. 
// 1.Instruction Decoding: It examines the opcode of each instruction fetched from memory to determine the type of operation it represents.
// 2. Control Signal Generation: Based on the decoded opcode, the control unit generates control signals that instruct different parts of the processor on how to execute the instruction. These control signals might include signals to enable/disable memory access, set ALU operations, select register operands, control branching, and manage data flow.
