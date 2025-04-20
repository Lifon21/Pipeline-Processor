//`timescale 1ns / 1ps

module RISC_V_Processor(clk,reset, elem1,elem2,elem3, elem4, elem5, elem6, elem7);
input clk,reset;
output wire[63:0] elem1,elem2,elem3, elem4, elem5, elem6, elem7;

// Internal Wires for module connections
wire [63:0] PC_to_IM;
wire [31:0] IM_to_parse;
wire [6:0] opcode_out; 
wire[4:0] rd_out;
wire [2:0] funct3_out;
wire [6:0] funct7_out;
wire [4:0] rs1_out, rs2_out;
wire Branch_out, MemRead_out, MemtoReg_out, MemWrite_out, ALUSrc_out, RegWrite_out;
wire Is_Greater_out;
wire [1:0] ALUOp_out;
wire [63:0] mux_to_reg;
wire [63:0] mux_to_pc_in;
wire [3:0] ALU_C_Operation;
wire pc_mux_sel_wire;
wire [63:0] imm_adder_to_mux;
wire [63:0] imm_to_adder;
wire [63:0] fixed_4 = 64'd4;
wire [63:0] PC_plus_4_to_mux;
wire [63:0] DM_Read_Data_out;
wire [63:0] alu_result_out;
wire zero_out;
wire [63:0] alu_mux_out;
wire [3:0] funct_in;
wire [63:0] imm_data_out;
wire [63:0] ReadData1_out, ReadData2_out;

// Control unit: decodes opcode and outputs control signals
Control_Unit control(opcode_out,Branch_out,MemRead_out,MemtoReg_out,MemWrite_out,ALUSrc_out,RegWrite_out,ALUOp_out);

// Program counter: holds the address of the current instruction
Program_Counter program_counter(clk,reset,mux_to_pc_in,PC_to_IM);

// Immediate generator: extracts and sign-extends immediate values
Imm_Gen imm_generator(IM_to_parse,imm_data_out);

// Instruction memory: fetches instruction from memory
Instruction_Memory instr_memory(PC_to_IM,IM_to_parse);

// Instruction parser: breaks instruction into fields
InstructionParser instr_parser(IM_to_parse,opcode_out,rd_out,funct3_out,rs1_out,rs2_out,funct7_out);

// 64-bit ALU: performs arithmetic and logic operations
ALU_64_Bit alu_unit(ReadData1_out,alu_mux_out,ALU_C_Operation,alu_result_out,zero_out,Is_Greater_out);

// Register file: stores general-purpose registers
RegisterFile reg_file(clk,reset,RegWrite_out,mux_to_reg, rs1_out,rs2_out,rd_out,ReadData1_out,ReadData2_out);

// Extract function bits for ALU control
assign funct_in = {IM_to_parse[30],IM_to_parse[14:12]};

// ALU control: determines ALU operation based on funct and ALUOp
ALU_Control alu_control(ALUOp_out,funct_in,ALU_C_Operation);

// ALU input MUX: selects between immediate and register value
MUX alu_input_mux(imm_data_out,ReadData2_out,ALUSrc_out,alu_mux_out);

// Data memory: reads/writes data and outputs observed elements
Data_Memory data_memory(alu_result_out,ReadData2_out,clk,MemWrite_out,MemRead_out,DM_Read_Data_out,elem1,elem2,elem3,elem4, elem5, elem6, elem7);

// Write-back MUX: selects ALU result or memory output for register write
MUX writeback_mux(DM_Read_Data_out,alu_result_out,MemtoReg_out,mux_to_reg);

// PC increment by 4
Adder pc_plus_4_adder(PC_to_IM,fixed_4,PC_plus_4_to_mux);

// Shift left immediate value by 1 (for branch offset)
assign imm_to_adder = imm_data_out << 1;

// PC + Immediate offset adder
Adder branch_target_adder(PC_to_IM, imm_to_adder,imm_adder_to_mux);

// Branch control: decides whether to take the branch
Branch branch_logic(Branch_out, zero_out, Is_Greater_out,funct_in,pc_mux_sel_wire);

// PC MUX: selects next PC based on branch decision
MUX pc_select_mux(imm_adder_to_mux,PC_plus_4_to_mux,pc_mux_sel_wire,mux_to_pc_in);

endmodule
