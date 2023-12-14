module buffer_1_4
(
    input clk,
    input rst,
    input ld,
    input[1:0] col,
    input[7:0] data_in,
    output[31:0] data_out
);
    reg[7:0] buffer[0:3];
    integer i, j;
    always@ (posedge clk or posedge rst)
    begin
        if(rst)
        begin
            for(i = 0; i < 4; i = i + 1)
            begin
                buffer[i] = 8'b0;
            end
        end
        else if(ld)
            buffer[col] = data_in;
    end
    assign data_out = {buffer[0], buffer[1],
        buffer[2], buffer[3]};
endmodule