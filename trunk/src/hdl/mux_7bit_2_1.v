module mux_7bit_2_1
(
    input[6:0] i0,
    input[6:0] i1,
    input sel, 
    output[6:0] y
);
	assign y = sel ? i1 : i0;
endmodule