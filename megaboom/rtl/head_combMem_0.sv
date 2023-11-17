// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// VCS coverage exclude_file
module head_combMem_0(
  input  [5:0] R0_addr,
  input        R0_en,
               R0_clk,
  input  [5:0] W0_addr,
  input        W0_en,
               W0_clk,
  input  [4:0] W0_data,
  input  [5:0] W1_addr,
  input        W1_en,
               W1_clk,
  input  [4:0] W1_data,
  output [4:0] R0_data
);

  reg [4:0] Memory[0:35];
  always @(posedge W0_clk) begin
    if (W0_en)
      Memory[W0_addr] <= W0_data;
    if (W1_en)
      Memory[W1_addr] <= W1_data;
  end // always @(posedge)
  assign R0_data = R0_en ? Memory[R0_addr] : 5'bx;
endmodule

