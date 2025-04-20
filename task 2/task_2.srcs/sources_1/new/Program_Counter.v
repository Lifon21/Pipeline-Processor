//`timescale 1ns / 1ps
module Program_Counter
(
    input clk, reset,
    input [63:0] PC_In,
    output reg [63:0] PC_Out
);

reg reset_force; // flag - variable to force 0th value after reset


initial 
PC_Out <= 64'd0; // Initialise value of PC to 0

// Always block triggered by positive edge of clock or positive edge of reset
always @(posedge clk or posedge reset) 
begin
     // If reset is asserted or reset_force is set, reset the Program Counter to 0
    if (reset || reset_force) begin
        PC_Out = 64'd0; // Reset PC
        reset_force <= 0; // Reset flag
        end  
    else
    PC_Out = PC_In; // Otherwise, update Program Counter with input value
end

// Always block triggered by negative edge of reset
always @(negedge reset) reset_force <= 1;

endmodule
