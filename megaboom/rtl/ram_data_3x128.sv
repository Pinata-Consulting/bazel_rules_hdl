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
module ram_data_3x128(
  input  [1:0]   R0_addr,
  input          R0_en,
                 R0_clk,
  input  [1:0]   W0_addr,
  input          W0_en,
                 W0_clk,
  input  [127:0] W0_data,
  output [127:0] R0_data
);

  reg [127:0] Memory[0:2];
  always @(posedge W0_clk) begin
    if (W0_en)
      Memory[W0_addr] <= W0_data;
  end // always @(posedge)
  assign R0_data = R0_en ? Memory[R0_addr] : 128'bx;
endmodule

