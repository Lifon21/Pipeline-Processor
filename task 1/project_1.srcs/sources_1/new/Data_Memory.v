//`timescale 1ns / 1ps

module Data_Memory
(
    input [63:0] Mem_Addr,
    input [63:0] Write_Data,
    input clk,
    input MemWrite, MemRead,
    output [63:0] Read_Data,
    output [63:0] element1,
    output [63:0] element2,
    output [63:0] element3,
    output [63:0] element4,
    output [63:0] element5,
    output [63:0] element6,
    output [63:0] element7
    );

reg [7:0] memory [63:0];
reg [63:0] temp_data;
integer i;
        assign element7 = memory[52];
        assign element6 = memory[44];
        assign element5 = memory[36];
        assign element4 = memory[28];
        assign element3 = memory[20];
        assign element2 = memory[12];
        assign element1 = memory[4];
        
initial begin
for (i=0 ;i<64 ; i = i + 1) begin
    memory[i] = 0;
end
memory[4]= 8'b00011101;
memory[12] = 8'b001010100;
memory[20]  = 8'b01001110;
memory[28] = 8'b00101111;
memory[36] = 8'b10000100;
memory[44] = 8'b00000110;
memory[52] = 8'b00010001;
end


always @(negedge clk) begin
    if (MemWrite) begin
        memory[Mem_Addr] = Write_Data[7:0];
        memory[Mem_Addr+1] = Write_Data[15:8];
        memory[Mem_Addr+2] = Write_Data[23:16];
        memory[Mem_Addr+3] = Write_Data[31:24];
        memory[Mem_Addr+4] = Write_Data[39:32];
        memory[Mem_Addr+5] = Write_Data[47:40];
        memory[Mem_Addr+6] = Write_Data[55:48];
        memory[Mem_Addr+7] = Write_Data[63:56];
    end
end


always @(*) begin
    if (MemRead) begin
        temp_data <= {memory[Mem_Addr+7], memory[Mem_Addr+6], memory[Mem_Addr+5], memory[Mem_Addr+4], memory[Mem_Addr+3], memory[Mem_Addr+2], memory[Mem_Addr+1], memory[Mem_Addr]};
    end
end

assign Read_Data = temp_data;


endmodule
