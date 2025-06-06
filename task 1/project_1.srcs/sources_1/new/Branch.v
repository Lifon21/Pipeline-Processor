// `timescale 1ns / 1ps

module Branch(
    input Branch,
    input ZERO,
    input Isgreater,
    input [3:0] funct,
    output reg switch_branch
);

always @(*) begin
    if (Branch) begin
        case (funct[2:0])
            3'b000: switch_branch = ZERO ? 1 : 0;        // BEQ
            3'b001: switch_branch = ZERO ? 0 : 1;        // BNE
            3'b101: switch_branch = Isgreater ? 1 : 0;   // BGT
            default: switch_branch = 0;
        endcase
    end else begin
        switch_branch = 0;
    end
end

endmodule
