module table_buffer
(
    input clk,
    input rst,
    input ld,
    input[1:0] row,
    input[1:0] col,
    input[127:0] data_in,
    output[7:0] data_out
);
    reg[7:0] buffer[0:3][0:3];
    integer i, j;
    always@ (posedge clk or posedge rst)
    begin
        if(rst)
        begin
            for(i = 0; i < 4; i = i + 1)
            begin
                for(j = 0; j < 4; j = j + 1)
                begin
                    buffer[i][j] = 8'b0;
                end
            end
        end
        else if(ld)
        begin
            {buffer[0][0], buffer[0][1], buffer[0][2],
                buffer[0][3], buffer[1][0], buffer[1][1],
                buffer[1][2], buffer[1][3], buffer[2][0],
                buffer[2][1], buffer[2][2], buffer[2][3],
                buffer[3][0], buffer[3][1], buffer[3][2],
                buffer[3][3]} = data_in;
        end
    end
    assign data_out = buffer[row][col];
endmodule