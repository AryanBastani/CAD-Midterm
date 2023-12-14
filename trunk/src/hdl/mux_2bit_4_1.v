module mux_2bit_4_1
(
    input[1:0] i0,
    input[1:0] i1,
    input[1:0] i2,
    input[1:0] i3,
    input[1:0] sel, 
    output[1:0] y
);
	assign y = (sel==2'b00) ? i0 :
        	(sel==2'b01) ? i1 :
 		(sel==2'b10) ? i2 : i3;
endmodule
