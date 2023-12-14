module adder_8bit
(
    input[7:0] a, b,
    output[7:0] out
);
    wire[8:0] full_out;
    assign full_out = a + b;
    assign out = full_out[8:1];
endmodule