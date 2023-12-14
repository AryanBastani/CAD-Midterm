module mux_7bit_3_1
(
    input[6:0] i0,
    input[6:0] i1,
    input[6:0] i2,
    input[1:0] sel, 
    output[6:0] y
);
	assign y = (sel==2'b00) ? i0 :
        (sel==2'b01) ? i1 : i2;
endmodule