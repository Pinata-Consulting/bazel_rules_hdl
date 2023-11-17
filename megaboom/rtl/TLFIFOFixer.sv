// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLFIFOFixer(
  input          clock,
                 reset,
                 auto_in_1_a_valid,
  input  [2:0]   auto_in_1_a_bits_opcode,
                 auto_in_1_a_bits_param,
  input  [3:0]   auto_in_1_a_bits_size,
  input  [4:0]   auto_in_1_a_bits_source,
  input  [31:0]  auto_in_1_a_bits_address,
  input  [15:0]  auto_in_1_a_bits_mask,
  input  [127:0] auto_in_1_a_bits_data,
  input          auto_in_1_a_bits_corrupt,
                 auto_in_1_b_ready,
                 auto_in_1_c_valid,
  input  [2:0]   auto_in_1_c_bits_opcode,
                 auto_in_1_c_bits_param,
  input  [3:0]   auto_in_1_c_bits_size,
  input  [4:0]   auto_in_1_c_bits_source,
  input  [31:0]  auto_in_1_c_bits_address,
  input  [127:0] auto_in_1_c_bits_data,
  input          auto_in_1_c_bits_corrupt,
                 auto_in_1_d_ready,
                 auto_in_1_e_valid,
  input  [3:0]   auto_in_1_e_bits_sink,
  input          auto_in_0_a_valid,
  input  [2:0]   auto_in_0_a_bits_opcode,
                 auto_in_0_a_bits_param,
  input  [3:0]   auto_in_0_a_bits_size,
                 auto_in_0_a_bits_source,
  input  [31:0]  auto_in_0_a_bits_address,
  input  [15:0]  auto_in_0_a_bits_mask,
  input  [127:0] auto_in_0_a_bits_data,
  input          auto_in_0_a_bits_corrupt,
                 auto_in_0_d_ready,
                 auto_out_1_a_ready,
                 auto_out_1_b_valid,
  input  [1:0]   auto_out_1_b_bits_param,
  input  [31:0]  auto_out_1_b_bits_address,
  input          auto_out_1_c_ready,
                 auto_out_1_d_valid,
  input  [2:0]   auto_out_1_d_bits_opcode,
  input  [1:0]   auto_out_1_d_bits_param,
  input  [3:0]   auto_out_1_d_bits_size,
  input  [4:0]   auto_out_1_d_bits_source,
  input  [3:0]   auto_out_1_d_bits_sink,
  input          auto_out_1_d_bits_denied,
  input  [127:0] auto_out_1_d_bits_data,
  input          auto_out_1_d_bits_corrupt,
                 auto_out_0_a_ready,
                 auto_out_0_d_valid,
  input  [2:0]   auto_out_0_d_bits_opcode,
  input  [1:0]   auto_out_0_d_bits_param,
  input  [3:0]   auto_out_0_d_bits_size,
                 auto_out_0_d_bits_source,
                 auto_out_0_d_bits_sink,
  input          auto_out_0_d_bits_denied,
  input  [127:0] auto_out_0_d_bits_data,
  input          auto_out_0_d_bits_corrupt,
  output         auto_in_1_a_ready,
                 auto_in_1_b_valid,
  output [1:0]   auto_in_1_b_bits_param,
  output [31:0]  auto_in_1_b_bits_address,
  output         auto_in_1_c_ready,
                 auto_in_1_d_valid,
  output [2:0]   auto_in_1_d_bits_opcode,
  output [1:0]   auto_in_1_d_bits_param,
  output [3:0]   auto_in_1_d_bits_size,
  output [4:0]   auto_in_1_d_bits_source,
  output [3:0]   auto_in_1_d_bits_sink,
  output         auto_in_1_d_bits_denied,
  output [127:0] auto_in_1_d_bits_data,
  output         auto_in_1_d_bits_corrupt,
                 auto_in_0_a_ready,
                 auto_in_0_d_valid,
  output [2:0]   auto_in_0_d_bits_opcode,
  output [1:0]   auto_in_0_d_bits_param,
  output [3:0]   auto_in_0_d_bits_size,
                 auto_in_0_d_bits_source,
                 auto_in_0_d_bits_sink,
  output         auto_in_0_d_bits_denied,
  output [127:0] auto_in_0_d_bits_data,
  output         auto_in_0_d_bits_corrupt,
                 auto_out_1_a_valid,
  output [2:0]   auto_out_1_a_bits_opcode,
                 auto_out_1_a_bits_param,
  output [3:0]   auto_out_1_a_bits_size,
  output [4:0]   auto_out_1_a_bits_source,
  output [31:0]  auto_out_1_a_bits_address,
  output [15:0]  auto_out_1_a_bits_mask,
  output [127:0] auto_out_1_a_bits_data,
  output         auto_out_1_a_bits_corrupt,
                 auto_out_1_b_ready,
                 auto_out_1_c_valid,
  output [2:0]   auto_out_1_c_bits_opcode,
                 auto_out_1_c_bits_param,
  output [3:0]   auto_out_1_c_bits_size,
  output [4:0]   auto_out_1_c_bits_source,
  output [31:0]  auto_out_1_c_bits_address,
  output [127:0] auto_out_1_c_bits_data,
  output         auto_out_1_c_bits_corrupt,
                 auto_out_1_d_ready,
                 auto_out_1_e_valid,
  output [3:0]   auto_out_1_e_bits_sink,
  output         auto_out_0_a_valid,
  output [2:0]   auto_out_0_a_bits_opcode,
                 auto_out_0_a_bits_param,
  output [3:0]   auto_out_0_a_bits_size,
                 auto_out_0_a_bits_source,
  output [31:0]  auto_out_0_a_bits_address,
  output [15:0]  auto_out_0_a_bits_mask,
  output [127:0] auto_out_0_a_bits_data,
  output         auto_out_0_a_bits_corrupt,
                 auto_out_0_d_ready
);

  assign auto_in_1_a_ready = auto_out_1_a_ready;
  assign auto_in_1_b_valid = auto_out_1_b_valid;
  assign auto_in_1_b_bits_param = auto_out_1_b_bits_param;
  assign auto_in_1_b_bits_address = auto_out_1_b_bits_address;
  assign auto_in_1_c_ready = auto_out_1_c_ready;
  assign auto_in_1_d_valid = auto_out_1_d_valid;
  assign auto_in_1_d_bits_opcode = auto_out_1_d_bits_opcode;
  assign auto_in_1_d_bits_param = auto_out_1_d_bits_param;
  assign auto_in_1_d_bits_size = auto_out_1_d_bits_size;
  assign auto_in_1_d_bits_source = auto_out_1_d_bits_source;
  assign auto_in_1_d_bits_sink = auto_out_1_d_bits_sink;
  assign auto_in_1_d_bits_denied = auto_out_1_d_bits_denied;
  assign auto_in_1_d_bits_data = auto_out_1_d_bits_data;
  assign auto_in_1_d_bits_corrupt = auto_out_1_d_bits_corrupt;
  assign auto_in_0_a_ready = auto_out_0_a_ready;
  assign auto_in_0_d_valid = auto_out_0_d_valid;
  assign auto_in_0_d_bits_opcode = auto_out_0_d_bits_opcode;
  assign auto_in_0_d_bits_param = auto_out_0_d_bits_param;
  assign auto_in_0_d_bits_size = auto_out_0_d_bits_size;
  assign auto_in_0_d_bits_source = auto_out_0_d_bits_source;
  assign auto_in_0_d_bits_sink = auto_out_0_d_bits_sink;
  assign auto_in_0_d_bits_denied = auto_out_0_d_bits_denied;
  assign auto_in_0_d_bits_data = auto_out_0_d_bits_data;
  assign auto_in_0_d_bits_corrupt = auto_out_0_d_bits_corrupt;
  assign auto_out_1_a_valid = auto_in_1_a_valid;
  assign auto_out_1_a_bits_opcode = auto_in_1_a_bits_opcode;
  assign auto_out_1_a_bits_param = auto_in_1_a_bits_param;
  assign auto_out_1_a_bits_size = auto_in_1_a_bits_size;
  assign auto_out_1_a_bits_source = auto_in_1_a_bits_source;
  assign auto_out_1_a_bits_address = auto_in_1_a_bits_address;
  assign auto_out_1_a_bits_mask = auto_in_1_a_bits_mask;
  assign auto_out_1_a_bits_data = auto_in_1_a_bits_data;
  assign auto_out_1_a_bits_corrupt = auto_in_1_a_bits_corrupt;
  assign auto_out_1_b_ready = auto_in_1_b_ready;
  assign auto_out_1_c_valid = auto_in_1_c_valid;
  assign auto_out_1_c_bits_opcode = auto_in_1_c_bits_opcode;
  assign auto_out_1_c_bits_param = auto_in_1_c_bits_param;
  assign auto_out_1_c_bits_size = auto_in_1_c_bits_size;
  assign auto_out_1_c_bits_source = auto_in_1_c_bits_source;
  assign auto_out_1_c_bits_address = auto_in_1_c_bits_address;
  assign auto_out_1_c_bits_data = auto_in_1_c_bits_data;
  assign auto_out_1_c_bits_corrupt = auto_in_1_c_bits_corrupt;
  assign auto_out_1_d_ready = auto_in_1_d_ready;
  assign auto_out_1_e_valid = auto_in_1_e_valid;
  assign auto_out_1_e_bits_sink = auto_in_1_e_bits_sink;
  assign auto_out_0_a_valid = auto_in_0_a_valid;
  assign auto_out_0_a_bits_opcode = auto_in_0_a_bits_opcode;
  assign auto_out_0_a_bits_param = auto_in_0_a_bits_param;
  assign auto_out_0_a_bits_size = auto_in_0_a_bits_size;
  assign auto_out_0_a_bits_source = auto_in_0_a_bits_source;
  assign auto_out_0_a_bits_address = auto_in_0_a_bits_address;
  assign auto_out_0_a_bits_mask = auto_in_0_a_bits_mask;
  assign auto_out_0_a_bits_data = auto_in_0_a_bits_data;
  assign auto_out_0_a_bits_corrupt = auto_in_0_a_bits_corrupt;
  assign auto_out_0_d_ready = auto_in_0_d_ready;
endmodule

