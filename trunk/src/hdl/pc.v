module pc
(
    input clk, rst, en,
    input[6:0] input_data,
    input sel,
    output[6:0] out
);
    wire[6:0] adder_out, mux_out, reg_out;
    
    adder_7bit adder(reg_out, 7'b0000001, adder_out);
    mux_7bit_2_1 mux2_1(adder_out, input_data, sel, mux_out);
    reg_7bit my_reg(clk, rst, en, mux_out, reg_out);

    assign out = reg_out;
endmodule
