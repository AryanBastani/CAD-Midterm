module counter_2bit
(
    input clk,
    input rst,
    input en,
    output reg[1:0] data_out,
    output cout
);
    always@ (posedge clk or posedge rst)
    begin
        if(rst)
            data_out = 0;
        else if(en)
            data_out = data_out + 1;
        else
            data_out = data_out;
    end
    assign cout = &data_out;
endmodule