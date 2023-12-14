module datapath
(
    input[6:0] x, y, z,
    input clk, rst,
    input x_sel, y_sel, z_sel,
    input x_en, y_en, z_en,
    input filt_ld,
    input tab_count_ld,
    input table_ld,
    input filt_count_en,
    input filt_row_sel,
    input input_count_en, 
    input input_en,
    input count_13_en,
    input mac_ld,
    input calc_count_en,
    input wr_count_en,
    input write_buf_ld,
    input mac_rst,
    input wr_data_sel,
    input shift_en,
    input in_count_en,
    input in_count_ld,
    input[1:0] input_i_sel,
    input[1:0] mem_in_sel,
    input[31:0] mem_out,
    output[6:0] mem_index,
    output[31:0] mem_in,
    output filt_cout,
    output input_j_cout,
    output calc_done,
    output write_mem_cout,
    output it_ends,
    output table_cout
);
    wire[6:0] x_pc_out, y_pc_out, z_pc_out;
    wire[7:0] out_filter, out_table, mac_out;
    wire[11:0] full_mac_out;
    wire[1:0] filt_count_out, out_input_j,
        table_row, table_col,
        filt_row, wr_buff_col;
    wire[31:0] mem_in0, mem_in1;
    wire[127:0] input_out;
    wire[3:0] table_index, in_count_out;
    wire in_cout;

// addres of memory to write or read:
    pc x_pc(clk, rst, x_en, x, x_sel, x_pc_out);
    pc y_pc(clk, rst, y_en, y, y_sel, y_pc_out);
    pc z_pc(clk, rst, z_en, z, z_sel, z_pc_out);
    mux_7bit_3_1 mem_in_mux(x_pc_out, y_pc_out,
        z_pc_out, mem_in_sel, mem_index);

// reading filter_buffer from memory:
    counter_2bit filt_counter(clk, rst, filt_count_en,
        filt_count_out, filt_cout);
    mux_2bit_2_1 filt_row_mux(filt_count_out, table_row,
        filt_row_sel, filt_row);
    filter_buffer filt_buff(clk, rst, filt_ld,
        filt_row, table_col, mem_out, out_filter);
// reading 4*16 input from memory:
    counter_2bit input_count_j(clk, rst, input_count_en,
        out_input_j, input_j_cout);
    buffer_4_16 input_buffer(clk, rst, shift_en, input_en,
        input_i_sel, out_input_j, table_index, mem_out, input_out);
    counter_4bit input_counter(clk, rst, in_count_en,
    in_count_ld, 4'b0011, in_count_out, in_cout); 
    
// output of counter is showing the number
// of 4*4 buffer that we are reading from 8*8 buffer
// and it changes from 3 to 15 (we need 13 4*4 buffer)
// so we should load 3 to the counter at the first:
    counter_4bit table_counter(clk, rst, count_13_en,
        tab_count_ld, 4'b0011, table_index, table_cout);

    table_buffer input_table(clk, rst, table_ld, table_row,
        table_col, input_out, out_table);
    
// calculation correlation:
    counter_2bit table_j_counter(clk, rst, calc_count_en,
        table_col, table_j_cout);
    counter_2bit table_i_counter(clk, rst, table_j_cout,
        table_row, table_i_cout);
    mac my_mac(clk, mac_rst, out_filter, out_table,
        mac_ld, full_mac_out);
    assign calc_done = (table_i_cout & table_j_cout);

    counter_2bit write_mem_counter(clk, rst, wr_count_en,
        wr_buff_col, write_mem_cout);
    assign mac_out = full_mac_out[11:4];
    buffer_1_4 write_buffer(clk, rst, write_buf_ld,
        wr_buff_col, mac_out, mem_in0);
    assign mem_in1 = {mem_in0[31:24], 24'b0};
    mux_32bit_2_1 wr_data_mux(mem_in0, mem_in1,
        wr_data_sel, mem_in);

    assign it_ends = table_cout & in_cout;
endmodule