module memory
(
    input clk,
    input done,
    input[6:0] index,
    input write,
    input[31:0] write_data,
    output[31:0] out
);
    reg [31:0] mem [0:127];

    initial
	begin
		$readmemh("file/mem.dat", mem);
	end
    assign out = mem[index];

    always@ (posedge clk)
        if(write)
            mem[index] = write_data;
	
    always @(posedge done)
        $writememh("file/output.dat", mem);
endmodule