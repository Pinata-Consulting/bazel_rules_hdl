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
module ram_predicated_combMem(
  input  [1:0] R0_addr,
  input        R0_en,
               R0_clk,
  input  [1:0] W0_addr,
  input        W0_en,
               W0_clk,
               W0_data,
  output       R0_data
);

  reg Memory[0:2];
  always @(posedge W0_clk) begin
    if (W0_en)
      Memory[W0_addr] <= W0_data;
  end // always @(posedge)
  assign R0_data = R0_en ? Memory[R0_addr] : 1'bx;
endmodule

