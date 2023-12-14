module controller
(
    input clk,
    input rst,
    input filt_cout,
    input input_j_cout,
    input calc_done,
    input write_mem_cout,
    input table_cout,
    input it_ends,
    output reg x_sel, y_sel, z_sel,
    output reg filt_ld,
    output reg filt_count_en,
    output reg filt_row_sel,
    output reg tab_count_ld,
    output reg table_ld,
    output reg input_count_en,
    output reg input_en,
    output reg mac_ld,
    output reg count_13_en,
    output reg calc_count_en,
    output reg wr_count_en,
    output reg write_buf_ld,
    output reg[1:0] input_i_sel,
    output reg x_en, y_en, z_en,
    output reg[1:0] mem_in_sel,
    output reg mem_wr,
    output reg mac_rst,
    output reg wr_data_sel,
    output reg shift_en,
    output reg in_count_en,
    output reg in_count_ld,
    output reg done
);
    parameter [4:0]
        state0 = 5'b00000,
        state1 = 5'b00001,
        state2 = 5'b00010,
        state3 = 5'b00011,
        state4 = 5'b00100,
        state5 = 5'b00101,
        state6 = 5'b00110,
        state7 = 5'b00111,
	    state8 = 5'b01000,
        state9 = 5'b01001,
        state10 = 5'b01010,
        state11 = 5'b01011,
        state12 = 5'b01100,
        state13 = 5'b01101,
        state14 = 5'b01110,
        state15 = 5'b01111,
        state16 = 5'b10000,
        state17 = 5'b10001;

    reg [4:0] ps = state0;
    reg [4:0] ns;

    always@(ps or filt_cout or input_j_cout or
        calc_done or write_mem_cout or
        table_cout or it_ends)
    begin
        ns = state0;
        case (ps)
            state0: ns = state1;
            state1: ns = filt_cout? state2 : state1;
            state2: ns = input_j_cout? state3 : state2;
	        state3: ns = input_j_cout? state4 : state3;
            state4: ns = input_j_cout? state5 : state4;
            state5: ns = input_j_cout? state6 : state5;
            state6: ns = state7;
            state7: ns = state8;
	        state8: ns = calc_done ? state9 : state8;
            state9: ns = write_mem_cout ? state12 :
                it_ends ? state16 : state10;
            state10: ns = table_cout ? state15
                : state11;
            state11: ns = state7;
            state12: ns = it_ends ? state16 : state13;
            state13: ns = it_ends ? state17 : state14;
            state14: ns = table_cout ? state15 : state11;
            state15: ns = state5;
            state16: ns = state13;
            state17: ns = state17;
        endcase
    end

    always @(ps) 
    begin
        {x_sel, y_sel, z_sel, x_en, y_en, z_en,
        mem_in_sel, filt_ld, filt_count_en, input_en,
        input_count_en, tab_count_ld, table_ld, calc_count_en,
        input_i_sel, mac_ld, count_13_en,
        wr_count_en, write_buf_ld, mac_rst, in_count_en,
        in_count_ld, mem_wr, shift_en} = 26'b0;
        case (ps)
            state0: {x_sel, y_sel, z_sel, x_en,
                y_en, z_en, filt_row_sel,
                in_count_ld} = 8'b1_1_1_1_1_1_0_1;
            state1: {mem_in_sel, filt_ld,
                filt_count_en, y_sel, y_en} = 6'b01_1_1_0_1;
            state2: {mem_in_sel, input_en, input_i_sel,
                input_count_en, x_sel, x_en} = 8'b00_1_00_1_0_1;
            state3: {mem_in_sel, input_en, input_i_sel,
                input_count_en, x_sel, x_en} = 8'b00_1_01_1_0_1;
            state4: {mem_in_sel, input_en, input_i_sel,
                input_count_en, x_sel, x_en} = 8'b00_1_10_1_0_1;
            state5: {mem_in_sel, input_en, input_i_sel,
                input_count_en, x_sel, x_en} = 8'b00_1_11_1_0_1;
            state6: {tab_count_ld, wr_data_sel} = 2'b1_0;
            state7: {table_ld, filt_row_sel, z_sel, mac_rst} = 4'b1_1_0_1;
	        state8: {mac_ld, calc_count_en} = 2'b11;
            state9: write_buf_ld = 1'b1;
            state10: wr_count_en = 1'b1;
            state11: count_13_en = 1'b1;
            state12: wr_count_en = 1'b1;
            state13: {mem_in_sel, mem_wr} = 3'b10_1;
            state14: z_en = 1'b1;
            state15: {in_count_en, input_i_sel,
                table_ld, shift_en} = 5'b1_11_1_1;
            state16: wr_data_sel = 1'b1;
            state17: done = 1'b1;
        endcase
    end

    always @(posedge clk, posedge rst)
    begin
        if(rst)
            ps <= state0;
        else
            ps <= ns;
    end
endmodule