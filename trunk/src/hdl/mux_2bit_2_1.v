module mux_2bit_2_1
(
    input[1:0] i0, i1,
    input sel, 
    output [1:0]y
);
	assign y = sel ? i1 : i0;
endmodule