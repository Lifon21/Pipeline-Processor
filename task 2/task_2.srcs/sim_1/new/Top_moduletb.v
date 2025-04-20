module Top_moduletb();
                    
  
    // Declare signals
    reg clk, reset;       
    wire [4:0] rd_out, rs1_out, rs2_out; 
    wire [63:0] ReadData1_out, ReadData2_out, IDEX_ReadData1_out, IDEX_ReadData2_out; 
    wire [4:0] IDEX_rd_out; 
    wire [63:0] EXMEM_ReadData2_out; 
    wire [4:0] EXMEM_rd_out;
    wire [63:0] MEMWB_DM_Read_Data_out;
    wire [4:0] MEMWB_rd_out;

    // Instantiate the Risc-V pipelined processor
    Risc_V_pipelined_processor ris(
        clk, reset, rd_out, rs1_out, rs2_out, ReadData1_out, ReadData2_out, 
        IDEX_ReadData1_out, IDEX_ReadData2_out, IDEX_rd_out,
        EXMEM_ReadData2_out, EXMEM_rd_out, MEMWB_DM_Read_Data_out, MEMWB_rd_out
    );

    // Initialize signals
   initial               
                      
 begin                
                      
  clk = 1'b0;         
                      
  reset = 1'b1;       
                      
  #10 reset = 1'b0;   
 end                  
                      
                      
always                
                      
 #5 clk = ~clk;       
                      
endmodule
