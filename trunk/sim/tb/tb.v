module tb();
	reg clk = 1, rst = 1;
    reg[6:0] x = 7'b0000100,
        y = 9'b1001010, z = 9'b1010100;
    wire mem_wr, done;
    wire[31:0] mem_out, mem_in;
    wire[6:0] mem_index;

    circuit my_circuit(clk, rst, x, y, z, mem_out,
        mem_index, mem_in, mem_wr, done);

    memory my_memory(clk, done, mem_index,
        mem_wr, mem_in, mem_out);

    always
        #5 clk = ~clk;
        initial begin
            #1 rst = 0;
            #100000 $stop;
        end
endmodule
