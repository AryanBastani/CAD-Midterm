module multiplier_8bit
(
    input[7:0] a, b,
    output[7:0] out
);
    wire[15:0] full_out;
    assign full_out = a * b;
    assign out = full_out[15:8];
endmodule