// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_72(
  input         clock,
                reset,
                io_enq_valid,
  input  [1:0]  io_enq_bits_param,
  input  [31:0] io_enq_bits_address,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
  output [1:0]  io_deq_bits_param,
  output [3:0]  io_deq_bits_size,
  output [4:0]  io_deq_bits_source,
  output [31:0] io_deq_bits_address,
  output [15:0] io_deq_bits_mask,
  output        io_deq_bits_corrupt
);

  reg  wrap;
  reg  wrap_1;
  reg  maybe_full;
  wire ptr_match = wrap == wrap_1;
  wire empty = ptr_match & ~maybe_full;
  wire full = ptr_match & maybe_full;
  wire do_enq = ~full & io_enq_valid;
  wire do_deq = io_deq_ready & ~empty;
  always @(posedge clock) begin
    if (reset) begin
      wrap <= 1'h0;
      wrap_1 <= 1'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        wrap <= wrap - 1'h1;
      if (do_deq)
        wrap_1 <= wrap_1 - 1'h1;
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_2x3 ram_opcode_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (3'h6),
    .R0_data (io_deq_bits_opcode)
  );
  ram_param_2x2 ram_param_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_param),
    .R0_data (io_deq_bits_param)
  );
  ram_2x4 ram_size_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (4'h6),
    .R0_data (io_deq_bits_size)
  );
  ram_2x5 ram_source_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (5'h0),
    .R0_data (io_deq_bits_source)
  );
  ram_address_2x32 ram_address_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_address),
    .R0_data (io_deq_bits_address)
  );
  ram_mask_2x16 ram_mask_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (16'hFFFF),
    .R0_data (io_deq_bits_mask)
  );
  ram_2x1 ram_corrupt_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_corrupt)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~empty;
endmodule

