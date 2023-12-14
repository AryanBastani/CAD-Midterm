module buffer_4_16
(
    input clk,
    input rst,
    input shift_en,
    input ld,
    input[1:0] row,
    input[1:0] col,
    input[3:0] table_index,
    input[31:0] data_in,
    output reg[127:0] data_out
);
    reg[7:0] buffer[0:3][0:15];
    integer i, j;
    always@ (posedge clk or posedge rst)
    begin
        if(rst)
        begin
            for(i = 0; i < 4; i = i + 1)
            begin
                for(j = 0; j < 16; j = j + 1)
                begin
                    buffer[i][j] = 8'b0;
                end
            end
        end
        else if(ld)
        begin
            buffer[row][{col[1:0], 2'b00}] = data_in[31:24];
            buffer[row][{col[1:0], 2'b00} + 1] = data_in[23:16];
            buffer[row][{col[1:0], 2'b00} + 2] = data_in[15:8];
            buffer[row][{col[1:0], 2'b00} + 3] = data_in[7:0];
        end
        else if(shift_en)
        begin
            for(j = 0; j < 16; j = j + 1)
            begin
                for(i = 0; i < 3; i = i + 1)
                begin
                    buffer[i][j] = buffer[i + 1][j];
                end
            end
        end
    end
    assign data_out = {buffer[0][table_index - 3], buffer[0][table_index - 2],
        buffer[0][table_index - 1], buffer[0][table_index],
        buffer[1][table_index - 3], buffer[1][table_index - 2],
        buffer[1][table_index - 1], buffer[1][table_index],
        buffer[2][table_index - 3], buffer[2][table_index - 2],
        buffer[2][table_index - 1], buffer[2][table_index],
        buffer[3][table_index - 3], buffer[3][table_index - 2],
        buffer[3][table_index - 1], buffer[3][table_index]};
endmodule