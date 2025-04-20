module Top_moduletb();
reg clk, reset;
wire [63:0] index1,index2,index3,index4,index5,index6,index7;

// Instantiating the RISCV Processor
RISC_V_Processor risc_v
(
    .clk(clk),
    .reset(reset),
    .elem1(index1),
    .elem2(index2),
    .elem3(index3),
    .elem4(index4),
    .elem5(index5),
    .elem6(index6),
    .elem7(index7)
    
);
initial 
 begin 
  
  clk = 1'b0; 
   
  reset = 1'b1; 
   
  #10 reset = 1'b0; // After a delay of 10 time units (#10), reset is de-asserted (reset = 1'b0), initiating the processor's operation.
 end 
always  
 #1 clk = ~clk; 
endmodule

