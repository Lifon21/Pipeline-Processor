//`timescale 1ns / 1ps
module Branch(
    input Branch,  // Signal indicating whether branch instruction is currently being executed
    input ZERO, // A signal indicating whether the result of a comparison operation is zero.
    input Isgreater,
    input [3:0] funct, // Function bits extracted from the instruction, which determine the branch condition.
    output reg switch_branch // This signal determines whether to execute the branch based on the condition evaluated.
    );
    
    always @(*) begin
        if(Branch) begin
        // Checks different branch conditions based on function bits
        // Zero=-true indicates previous operation resulted in zero    
            case({funct[2:0]})
                3'b000: switch_branch = ZERO ? 1:0; // ZERO is true so switch_branch set to 1 (branch should be taken)
                3'b001: switch_branch = ZERO ? 0:1;
                3'b101: switch_branch =Isgreater ? 1:0;
            endcase
          end
        else
        // If Branch is not asserted, indicating no branch instruction is being executed, switch_branch is set to 0, indicating that no branch should be taken.
           switch_branch=0; 
     end
endmodule
