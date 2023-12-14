module adder_12bit
(
    input[11:0] a, b,
    output[11:0] out
);
    wire[12:0] full_out;
    assign full_out = a + b;
    assign out = full_out[11:0];
endmodule