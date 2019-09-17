// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2018.2
// Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Sobel (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        src_rows_V_dout,
        src_rows_V_empty_n,
        src_rows_V_read,
        src_cols_V_dout,
        src_cols_V_empty_n,
        src_cols_V_read,
        src_data_stream_V_dout,
        src_data_stream_V_empty_n,
        src_data_stream_V_read,
        dst_data_stream_V_din,
        dst_data_stream_V_full_n,
        dst_data_stream_V_write,
        order_dout,
        order_empty_n,
        order_read
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] src_rows_V_dout;
input   src_rows_V_empty_n;
output   src_rows_V_read;
input  [31:0] src_cols_V_dout;
input   src_cols_V_empty_n;
output   src_cols_V_read;
input  [7:0] src_data_stream_V_dout;
input   src_data_stream_V_empty_n;
output   src_data_stream_V_read;
output  [7:0] dst_data_stream_V_din;
input   dst_data_stream_V_full_n;
output   dst_data_stream_V_write;
input  [31:0] order_dout;
input   order_empty_n;
output   order_read;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg src_rows_V_read;
reg src_cols_V_read;
reg src_data_stream_V_read;
reg dst_data_stream_V_write;
reg order_read;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    src_rows_V_blk_n;
reg    src_cols_V_blk_n;
reg    order_blk_n;
wire   [0:0] tmp_i_fu_150_p2;
reg   [0:0] tmp_i_reg_156;
reg    ap_block_state1;
reg   [31:0] src_rows_V_read_reg_160;
reg   [31:0] src_cols_V_read_reg_165;
wire    grp_Filter2D_fu_120_ap_start;
wire    grp_Filter2D_fu_120_ap_done;
wire    grp_Filter2D_fu_120_ap_idle;
wire    grp_Filter2D_fu_120_ap_ready;
wire    grp_Filter2D_fu_120_p_src_data_stream_V_read;
wire   [7:0] grp_Filter2D_fu_120_p_dst_data_stream_V_din;
wire    grp_Filter2D_fu_120_p_dst_data_stream_V_write;
reg   [1:0] grp_Filter2D_fu_120_p_kernel_val_0_V_1_read;
reg   [1:0] grp_Filter2D_fu_120_p_kernel_val_0_V_2_read;
reg   [2:0] grp_Filter2D_fu_120_p_kernel_val_1_V_0_read;
reg   [3:0] grp_Filter2D_fu_120_p_kernel_val_1_V_2_read;
reg   [1:0] grp_Filter2D_fu_120_p_kernel_val_2_V_0_read;
reg   [2:0] grp_Filter2D_fu_120_p_kernel_val_2_V_1_read;
reg    grp_Filter2D_fu_120_ap_start_reg;
reg    ap_block_state1_ignore_call0;
wire    ap_CS_fsm_state2;
reg    ap_block_state2_on_subcall_done;
reg   [1:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 grp_Filter2D_fu_120_ap_start_reg = 1'b0;
end

Filter2D grp_Filter2D_fu_120(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_Filter2D_fu_120_ap_start),
    .ap_done(grp_Filter2D_fu_120_ap_done),
    .ap_idle(grp_Filter2D_fu_120_ap_idle),
    .ap_ready(grp_Filter2D_fu_120_ap_ready),
    .p_src_rows_V_read(src_rows_V_read_reg_160),
    .p_src_cols_V_read(src_cols_V_read_reg_165),
    .p_src_data_stream_V_dout(src_data_stream_V_dout),
    .p_src_data_stream_V_empty_n(src_data_stream_V_empty_n),
    .p_src_data_stream_V_read(grp_Filter2D_fu_120_p_src_data_stream_V_read),
    .p_dst_data_stream_V_din(grp_Filter2D_fu_120_p_dst_data_stream_V_din),
    .p_dst_data_stream_V_full_n(dst_data_stream_V_full_n),
    .p_dst_data_stream_V_write(grp_Filter2D_fu_120_p_dst_data_stream_V_write),
    .p_kernel_val_0_V_1_read(grp_Filter2D_fu_120_p_kernel_val_0_V_1_read),
    .p_kernel_val_0_V_2_read(grp_Filter2D_fu_120_p_kernel_val_0_V_2_read),
    .p_kernel_val_1_V_0_read(grp_Filter2D_fu_120_p_kernel_val_1_V_0_read),
    .p_kernel_val_1_V_2_read(grp_Filter2D_fu_120_p_kernel_val_1_V_2_read),
    .p_kernel_val_2_V_0_read(grp_Filter2D_fu_120_p_kernel_val_2_V_0_read),
    .p_kernel_val_2_V_1_read(grp_Filter2D_fu_120_p_kernel_val_2_V_1_read)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_Filter2D_fu_120_ap_start_reg <= 1'b0;
    end else begin
        if (((~((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (tmp_i_fu_150_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1)) | (~((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (tmp_i_fu_150_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1)))) begin
            grp_Filter2D_fu_120_ap_start_reg <= 1'b1;
        end else if ((grp_Filter2D_fu_120_ap_ready == 1'b1)) begin
            grp_Filter2D_fu_120_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src_cols_V_read_reg_165 <= src_cols_V_dout;
        src_rows_V_read_reg_160 <= src_rows_V_dout;
        tmp_i_reg_156 <= tmp_i_fu_150_p2;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((((tmp_i_reg_156 == 1'd1) & (1'b1 == ap_CS_fsm_state2)) | ((tmp_i_reg_156 == 1'd0) & (1'b1 == ap_CS_fsm_state2)))) begin
        dst_data_stream_V_write = grp_Filter2D_fu_120_p_dst_data_stream_V_write;
    end else begin
        dst_data_stream_V_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        if ((tmp_i_reg_156 == 1'd1)) begin
            grp_Filter2D_fu_120_p_kernel_val_0_V_1_read = 2'd0;
        end else if ((tmp_i_reg_156 == 1'd0)) begin
            grp_Filter2D_fu_120_p_kernel_val_0_V_1_read = 2'd2;
        end else begin
            grp_Filter2D_fu_120_p_kernel_val_0_V_1_read = 'bx;
        end
    end else begin
        grp_Filter2D_fu_120_p_kernel_val_0_V_1_read = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        if ((tmp_i_reg_156 == 1'd1)) begin
            grp_Filter2D_fu_120_p_kernel_val_0_V_2_read = 2'd1;
        end else if ((tmp_i_reg_156 == 1'd0)) begin
            grp_Filter2D_fu_120_p_kernel_val_0_V_2_read = 2'd3;
        end else begin
            grp_Filter2D_fu_120_p_kernel_val_0_V_2_read = 'bx;
        end
    end else begin
        grp_Filter2D_fu_120_p_kernel_val_0_V_2_read = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        if ((tmp_i_reg_156 == 1'd1)) begin
            grp_Filter2D_fu_120_p_kernel_val_1_V_0_read = 3'd6;
        end else if ((tmp_i_reg_156 == 1'd0)) begin
            grp_Filter2D_fu_120_p_kernel_val_1_V_0_read = 3'd0;
        end else begin
            grp_Filter2D_fu_120_p_kernel_val_1_V_0_read = 'bx;
        end
    end else begin
        grp_Filter2D_fu_120_p_kernel_val_1_V_0_read = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        if ((tmp_i_reg_156 == 1'd1)) begin
            grp_Filter2D_fu_120_p_kernel_val_1_V_2_read = 4'd2;
        end else if ((tmp_i_reg_156 == 1'd0)) begin
            grp_Filter2D_fu_120_p_kernel_val_1_V_2_read = 4'd0;
        end else begin
            grp_Filter2D_fu_120_p_kernel_val_1_V_2_read = 'bx;
        end
    end else begin
        grp_Filter2D_fu_120_p_kernel_val_1_V_2_read = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        if ((tmp_i_reg_156 == 1'd1)) begin
            grp_Filter2D_fu_120_p_kernel_val_2_V_0_read = 2'd3;
        end else if ((tmp_i_reg_156 == 1'd0)) begin
            grp_Filter2D_fu_120_p_kernel_val_2_V_0_read = 2'd1;
        end else begin
            grp_Filter2D_fu_120_p_kernel_val_2_V_0_read = 'bx;
        end
    end else begin
        grp_Filter2D_fu_120_p_kernel_val_2_V_0_read = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        if ((tmp_i_reg_156 == 1'd1)) begin
            grp_Filter2D_fu_120_p_kernel_val_2_V_1_read = 3'd0;
        end else if ((tmp_i_reg_156 == 1'd0)) begin
            grp_Filter2D_fu_120_p_kernel_val_2_V_1_read = 3'd2;
        end else begin
            grp_Filter2D_fu_120_p_kernel_val_2_V_1_read = 'bx;
        end
    end else begin
        grp_Filter2D_fu_120_p_kernel_val_2_V_1_read = 'bx;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        order_blk_n = order_empty_n;
    end else begin
        order_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        order_read = 1'b1;
    end else begin
        order_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src_cols_V_blk_n = src_cols_V_empty_n;
    end else begin
        src_cols_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src_cols_V_read = 1'b1;
    end else begin
        src_cols_V_read = 1'b0;
    end
end

always @ (*) begin
    if ((((tmp_i_reg_156 == 1'd1) & (1'b1 == ap_CS_fsm_state2)) | ((tmp_i_reg_156 == 1'd0) & (1'b1 == ap_CS_fsm_state2)))) begin
        src_data_stream_V_read = grp_Filter2D_fu_120_p_src_data_stream_V_read;
    end else begin
        src_data_stream_V_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src_rows_V_blk_n = src_rows_V_empty_n;
    end else begin
        src_rows_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src_rows_V_read = 1'b1;
    end else begin
        src_rows_V_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((1'b1 == ap_CS_fsm_state2) & (1'b0 == ap_block_state2_on_subcall_done))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_ignore_call0 = ((ap_start == 1'b0) | (order_empty_n == 1'b0) | (src_cols_V_empty_n == 1'b0) | (src_rows_V_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state2_on_subcall_done = (((tmp_i_reg_156 == 1'd1) & (grp_Filter2D_fu_120_ap_done == 1'b0)) | ((tmp_i_reg_156 == 1'd0) & (grp_Filter2D_fu_120_ap_done == 1'b0)));
end

assign dst_data_stream_V_din = grp_Filter2D_fu_120_p_dst_data_stream_V_din;

assign grp_Filter2D_fu_120_ap_start = grp_Filter2D_fu_120_ap_start_reg;

assign tmp_i_fu_150_p2 = ((order_dout == 32'd0) ? 1'b1 : 1'b0);

endmodule //Sobel
