// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Jul 27 23:33:34 2020
// Host        : LAPTOP-6PEOUARA running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/verilog_docs/snake_picture/snake_picture.srcs/sources_1/ip/Picture_R_Rom/Picture_R_Rom_stub.v
// Design      : Picture_R_Rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module Picture_R_Rom(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[17:0],douta[3:0]" */;
  input clka;
  input ena;
  input [17:0]addra;
  output [3:0]douta;
endmodule
