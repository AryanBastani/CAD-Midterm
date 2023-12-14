module mac
(
    input clk, rst,
    input[7:0] i0, i1,
    input ld,
    output[11:0] out_data
);
    wire[7:0] mult_out;
    wire[11:0] add_out, reg_out;

    multiplier_8bit multiplier(i0, i1, mult_out);
    adder_12bit adder(reg_out, {4'b0, mult_out}, add_out);
    reg_12bit my_reg(clk, rst, ld, add_out, reg_out);

    assign out_data = reg_out;
endmodule