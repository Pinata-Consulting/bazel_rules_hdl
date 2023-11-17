// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLBuffer_15(
  input          clock,
                 reset,
                 auto_in_a_valid,
  input  [2:0]   auto_in_a_bits_opcode,
                 auto_in_a_bits_param,
  input  [3:0]   auto_in_a_bits_size,
  input  [4:0]   auto_in_a_bits_source,
  input  [31:0]  auto_in_a_bits_address,
  input  [15:0]  auto_in_a_bits_mask,
  input  [127:0] auto_in_a_bits_data,
  input          auto_in_b_ready,
                 auto_in_c_valid,
  input  [2:0]   auto_in_c_bits_opcode,
                 auto_in_c_bits_param,
  input  [3:0]   auto_in_c_bits_size,
  input  [4:0]   auto_in_c_bits_source,
  input  [31:0]  auto_in_c_bits_address,
  input  [127:0] auto_in_c_bits_data,
  input          auto_in_d_ready,
                 auto_in_e_valid,
  input  [3:0]   auto_in_e_bits_sink,
  input          auto_out_a_ready,
                 auto_out_b_valid,
  input  [1:0]   auto_out_b_bits_param,
  input  [31:0]  auto_out_b_bits_address,
  input          auto_out_c_ready,
                 auto_out_d_valid,
  input  [2:0]   auto_out_d_bits_opcode,
  input  [1:0]   auto_out_d_bits_param,
  input  [3:0]   auto_out_d_bits_size,
  input  [4:0]   auto_out_d_bits_source,
  input  [3:0]   auto_out_d_bits_sink,
  input          auto_out_d_bits_denied,
  input  [127:0] auto_out_d_bits_data,
  input          auto_out_d_bits_corrupt,
  output         auto_in_a_ready,
                 auto_in_b_valid,
  output [2:0]   auto_in_b_bits_opcode,
  output [1:0]   auto_in_b_bits_param,
  output [3:0]   auto_in_b_bits_size,
  output [4:0]   auto_in_b_bits_source,
  output [31:0]  auto_in_b_bits_address,
  output [15:0]  auto_in_b_bits_mask,
  output         auto_in_b_bits_corrupt,
                 auto_in_c_ready,
                 auto_in_d_valid,
  output [2:0]   auto_in_d_bits_opcode,
  output [1:0]   auto_in_d_bits_param,
  output [3:0]   auto_in_d_bits_size,
  output [4:0]   auto_in_d_bits_source,
  output [3:0]   auto_in_d_bits_sink,
  output         auto_in_d_bits_denied,
  output [127:0] auto_in_d_bits_data,
  output         auto_in_d_bits_corrupt,
                 auto_in_e_ready,
                 auto_out_a_valid,
  output [2:0]   auto_out_a_bits_opcode,
                 auto_out_a_bits_param,
  output [3:0]   auto_out_a_bits_size,
  output [4:0]   auto_out_a_bits_source,
  output [31:0]  auto_out_a_bits_address,
  output [15:0]  auto_out_a_bits_mask,
  output [127:0] auto_out_a_bits_data,
  output         auto_out_a_bits_corrupt,
                 auto_out_b_ready,
                 auto_out_c_valid,
  output [2:0]   auto_out_c_bits_opcode,
                 auto_out_c_bits_param,
  output [3:0]   auto_out_c_bits_size,
  output [4:0]   auto_out_c_bits_source,
  output [31:0]  auto_out_c_bits_address,
  output [127:0] auto_out_c_bits_data,
  output         auto_out_c_bits_corrupt,
                 auto_out_d_ready,
                 auto_out_e_valid,
  output [3:0]   auto_out_e_bits_sink
);

  wire        _nodeOut_e_q_io_enq_ready;
  wire        _nodeOut_c_q_io_enq_ready;
  wire        _nodeIn_b_q_io_deq_valid;
  wire [2:0]  _nodeIn_b_q_io_deq_bits_opcode;
  wire [1:0]  _nodeIn_b_q_io_deq_bits_param;
  wire [3:0]  _nodeIn_b_q_io_deq_bits_size;
  wire [4:0]  _nodeIn_b_q_io_deq_bits_source;
  wire [31:0] _nodeIn_b_q_io_deq_bits_address;
  wire [15:0] _nodeIn_b_q_io_deq_bits_mask;
  wire        _nodeIn_b_q_io_deq_bits_corrupt;
  wire        _nodeIn_d_q_io_deq_valid;
  wire [2:0]  _nodeIn_d_q_io_deq_bits_opcode;
  wire [1:0]  _nodeIn_d_q_io_deq_bits_param;
  wire [3:0]  _nodeIn_d_q_io_deq_bits_size;
  wire [4:0]  _nodeIn_d_q_io_deq_bits_source;
  wire [3:0]  _nodeIn_d_q_io_deq_bits_sink;
  wire        _nodeIn_d_q_io_deq_bits_denied;
  wire        _nodeIn_d_q_io_deq_bits_corrupt;
  wire        _nodeOut_a_q_io_enq_ready;
  Queue_70 nodeOut_a_q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_a_valid),
    .io_enq_bits_opcode  (auto_in_a_bits_opcode),
    .io_enq_bits_param   (auto_in_a_bits_param),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_address (auto_in_a_bits_address),
    .io_enq_bits_mask    (auto_in_a_bits_mask),
    .io_enq_bits_data    (auto_in_a_bits_data),
    .io_deq_ready        (auto_out_a_ready),
    .io_enq_ready        (_nodeOut_a_q_io_enq_ready),
    .io_deq_valid        (auto_out_a_valid),
    .io_deq_bits_opcode  (auto_out_a_bits_opcode),
    .io_deq_bits_param   (auto_out_a_bits_param),
    .io_deq_bits_size    (auto_out_a_bits_size),
    .io_deq_bits_source  (auto_out_a_bits_source),
    .io_deq_bits_address (auto_out_a_bits_address),
    .io_deq_bits_mask    (auto_out_a_bits_mask),
    .io_deq_bits_data    (auto_out_a_bits_data),
    .io_deq_bits_corrupt (auto_out_a_bits_corrupt)
  );
  Queue_71 nodeIn_d_q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_out_d_valid),
    .io_enq_bits_opcode  (auto_out_d_bits_opcode),
    .io_enq_bits_param   (auto_out_d_bits_param),
    .io_enq_bits_size    (auto_out_d_bits_size),
    .io_enq_bits_source  (auto_out_d_bits_source),
    .io_enq_bits_sink    (auto_out_d_bits_sink),
    .io_enq_bits_denied  (auto_out_d_bits_denied),
    .io_enq_bits_data    (auto_out_d_bits_data),
    .io_enq_bits_corrupt (auto_out_d_bits_corrupt),
    .io_deq_ready        (auto_in_d_ready),
    .io_enq_ready        (auto_out_d_ready),
    .io_deq_valid        (_nodeIn_d_q_io_deq_valid),
    .io_deq_bits_opcode  (_nodeIn_d_q_io_deq_bits_opcode),
    .io_deq_bits_param   (_nodeIn_d_q_io_deq_bits_param),
    .io_deq_bits_size    (_nodeIn_d_q_io_deq_bits_size),
    .io_deq_bits_source  (_nodeIn_d_q_io_deq_bits_source),
    .io_deq_bits_sink    (_nodeIn_d_q_io_deq_bits_sink),
    .io_deq_bits_denied  (_nodeIn_d_q_io_deq_bits_denied),
    .io_deq_bits_data    (auto_in_d_bits_data),
    .io_deq_bits_corrupt (_nodeIn_d_q_io_deq_bits_corrupt)
  );
  Queue_72 nodeIn_b_q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_out_b_valid),
    .io_enq_bits_param   (auto_out_b_bits_param),
    .io_enq_bits_address (auto_out_b_bits_address),
    .io_deq_ready        (auto_in_b_ready),
    .io_enq_ready        (auto_out_b_ready),
    .io_deq_valid        (_nodeIn_b_q_io_deq_valid),
    .io_deq_bits_opcode  (_nodeIn_b_q_io_deq_bits_opcode),
    .io_deq_bits_param   (_nodeIn_b_q_io_deq_bits_param),
    .io_deq_bits_size    (_nodeIn_b_q_io_deq_bits_size),
    .io_deq_bits_source  (_nodeIn_b_q_io_deq_bits_source),
    .io_deq_bits_address (_nodeIn_b_q_io_deq_bits_address),
    .io_deq_bits_mask    (_nodeIn_b_q_io_deq_bits_mask),
    .io_deq_bits_corrupt (_nodeIn_b_q_io_deq_bits_corrupt)
  );
  Queue_73 nodeOut_c_q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_c_valid),
    .io_enq_bits_opcode  (auto_in_c_bits_opcode),
    .io_enq_bits_param   (auto_in_c_bits_param),
    .io_enq_bits_size    (auto_in_c_bits_size),
    .io_enq_bits_source  (auto_in_c_bits_source),
    .io_enq_bits_address (auto_in_c_bits_address),
    .io_enq_bits_data    (auto_in_c_bits_data),
    .io_deq_ready        (auto_out_c_ready),
    .io_enq_ready        (_nodeOut_c_q_io_enq_ready),
    .io_deq_valid        (auto_out_c_valid),
    .io_deq_bits_opcode  (auto_out_c_bits_opcode),
    .io_deq_bits_param   (auto_out_c_bits_param),
    .io_deq_bits_size    (auto_out_c_bits_size),
    .io_deq_bits_source  (auto_out_c_bits_source),
    .io_deq_bits_address (auto_out_c_bits_address),
    .io_deq_bits_data    (auto_out_c_bits_data),
    .io_deq_bits_corrupt (auto_out_c_bits_corrupt)
  );
  Queue_74 nodeOut_e_q (
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (auto_in_e_valid),
    .io_enq_bits_sink (auto_in_e_bits_sink),
    .io_enq_ready     (_nodeOut_e_q_io_enq_ready),
    .io_deq_valid     (auto_out_e_valid),
    .io_deq_bits_sink (auto_out_e_bits_sink)
  );
  assign auto_in_a_ready = _nodeOut_a_q_io_enq_ready;
  assign auto_in_b_valid = _nodeIn_b_q_io_deq_valid;
  assign auto_in_b_bits_opcode = _nodeIn_b_q_io_deq_bits_opcode;
  assign auto_in_b_bits_param = _nodeIn_b_q_io_deq_bits_param;
  assign auto_in_b_bits_size = _nodeIn_b_q_io_deq_bits_size;
  assign auto_in_b_bits_source = _nodeIn_b_q_io_deq_bits_source;
  assign auto_in_b_bits_address = _nodeIn_b_q_io_deq_bits_address;
  assign auto_in_b_bits_mask = _nodeIn_b_q_io_deq_bits_mask;
  assign auto_in_b_bits_corrupt = _nodeIn_b_q_io_deq_bits_corrupt;
  assign auto_in_c_ready = _nodeOut_c_q_io_enq_ready;
  assign auto_in_d_valid = _nodeIn_d_q_io_deq_valid;
  assign auto_in_d_bits_opcode = _nodeIn_d_q_io_deq_bits_opcode;
  assign auto_in_d_bits_param = _nodeIn_d_q_io_deq_bits_param;
  assign auto_in_d_bits_size = _nodeIn_d_q_io_deq_bits_size;
  assign auto_in_d_bits_source = _nodeIn_d_q_io_deq_bits_source;
  assign auto_in_d_bits_sink = _nodeIn_d_q_io_deq_bits_sink;
  assign auto_in_d_bits_denied = _nodeIn_d_q_io_deq_bits_denied;
  assign auto_in_d_bits_corrupt = _nodeIn_d_q_io_deq_bits_corrupt;
  assign auto_in_e_ready = _nodeOut_e_q_io_enq_ready;
endmodule
