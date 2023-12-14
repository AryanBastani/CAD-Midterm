module reg_12bit
(
    input clk,
    input rst,
    input ld,
    input[11:0] in,
    output reg[11:0] out
);
    always@ (posedge clk or posedge rst)
        begin
            if(rst)
	     	    out = 0;
            else if(ld)
                out = in;
            else
                out = out;
        end
endmodule