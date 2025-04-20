module RegisterFile
(
    input clk, reset, RegWrite,
    input [63:0] WriteData,  // Data to be written onto register file
    input [4:0] RS1, RS2, RD,  // Source & Destination register addresses
    output reg [63:0] ReadData1, ReadData2  // Data read from specified soursce registers  
);

// Array of 32 Registers (64 bits)
reg [63:0] Registers [31:0]; //initialize Registers with random values (using 'initial' block)
//integer i;

initial
begin
// Initialize registers with 0
    Registers[0] = 64'd0;
    Registers[1] = 64'd0;
    Registers[2] = 64'd0;
    Registers[3] = 64'd0;
    Registers[4] = 64'd0;
    Registers[5] = 64'd0;
    Registers[6] = 64'd0;
    Registers[7] = 64'd0;
    Registers[8] = 64'd0;
    Registers[9] = 64'd0;
    Registers[10] = 64'd0;
    Registers[11] = 64'd0;
    Registers[12] = 64'd0;
    Registers[13] = 64'd0;
    Registers[14] = 64'd0;
    Registers[15] = 64'd0;
    Registers[16] = 64'd0;
    Registers[17] = 64'd0;
    Registers[18] = 64'd0;
    Registers[19] = 64'd0;
    Registers[20] = 64'd0;
    Registers[21] = 64'd0; //register x21 = 1
    Registers[22] = 64'd0;
    Registers[23] = 64'd0;
    Registers[24] = 64'd0;
    Registers[25] = 64'd0;
    Registers[26] = 64'd0;
    Registers[27] = 64'd0;
    Registers[28] = 64'd0;
    Registers[29] = 64'd0;
    Registers[30] = 64'd0;
    Registers[31] = 64'd0;
    
end


always @(negedge clk ) begin
    
    if (RegWrite) begin
        Registers[RD] = WriteData;
    end
end

always@(*) begin
// Read data from specified source registers
    ReadData1 = reset ? 0 : Registers[RS1];
    ReadData2 = reset ? 0 : Registers[RS2];
end

endmodule 

//  It provides storage for a set of registers. In this case, there are 32 registers
// The module allows reading data from two specified registers (RS1 and RS2). The values stored in these registers are output as ReadData1 and ReadData2. If the reset signal is asserted, indicating a reset condition, the read data outputs are set to zero.
//  It supports writing data into one specified register (RD). The data to be written is provided as WriteData. The write operation is synchronized with the falling edge of the clock (clk). The write occurs only when the RegWrite signal is asserted, indicating that a write operation is enabled.