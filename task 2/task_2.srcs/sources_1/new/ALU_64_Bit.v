module ALU_64_Bit
(
    // Input & Output ports
    input [63:0]a, b,  // A & B - 64 bit each
    input [3:0] ALUOp,  // ALU Operation code (4 bits)
    output reg [63:0] Result,  // Result of ALU Operation (64 bits)
    output reg ZERO,  // Ouput indicating if result is zero
    output reg Is_greater  // Ouput indicating if 'a' > 'b'
    );
    
    localparam [3:0]
    // ALU Operation Code for bitwise: AND, OR, addition, subtraction, NOR
    AND = 4'b0000,
    OR = 4'b0001,
    ADD = 4'b0010,
    SUB = 4'b0110,
    NOR = 4'b1100;

   always @ (ALUOp, a, b)
      begin
       // Perform ALU Operation accordingly
        case (ALUOp)
        AND: Result = a & b;
        OR: Result = a | b;
        ADD: Result = a + b;
        SUB: Result = a - b;
        NOR: Result = ~(a | b);
        
        4'b0111: Result = a << b;
        endcase
      if (Result ==64'd0)
        ZERO=1'b1;  // Set ZERO to 1 is result is 0
      else
        ZERO=1'b0;  // Otherwise set ZERO to 0
      
      Is_greater= (a > b) ? 1'b1 : 1'b0;
      end
  
endmodule
