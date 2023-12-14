module counter_4bit
(
    input clk,
    input rst,
    input en,
    input ld,
    input[3:0] data_in,
    output reg[3:0] data_out,
    output cout
);
    always@ (posedge clk or posedge rst)
    begin
        if(rst)
            data_out = 4'b0;
        else if(ld)
            data_out = data_in;
        else if(en)
            data_out = data_out + 1;
        else
            data_out = data_out;
    end
    assign cout = &data_out;
endmodule