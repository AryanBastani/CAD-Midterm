module adder_7bit
(
    input[6:0] a, b,
    output[6:0] out
);
    assign out = a+ b;
endmodule