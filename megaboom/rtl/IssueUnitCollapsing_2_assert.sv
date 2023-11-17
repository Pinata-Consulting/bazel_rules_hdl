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
module IssueUnitCollapsing_2_assert(
  input issue_slots_39_grant,
        issue_slots_38_grant,
        issue_slots_37_grant,
        issue_slots_36_grant,
        issue_slots_35_grant,
        issue_slots_34_grant,
        issue_slots_33_grant,
        issue_slots_32_grant,
        issue_slots_31_grant,
        issue_slots_30_grant,
        issue_slots_29_grant,
        issue_slots_28_grant,
        issue_slots_27_grant,
        issue_slots_26_grant,
        issue_slots_25_grant,
        issue_slots_24_grant,
        issue_slots_23_grant,
        issue_slots_22_grant,
        issue_slots_21_grant,
        issue_slots_20_grant,
        issue_slots_19_grant,
        issue_slots_18_grant,
        issue_slots_17_grant,
        issue_slots_16_grant,
        issue_slots_15_grant,
        issue_slots_14_grant,
        issue_slots_13_grant,
        issue_slots_12_grant,
        issue_slots_11_grant,
        issue_slots_10_grant,
        issue_slots_9_grant,
        issue_slots_8_grant,
        issue_slots_7_grant,
        issue_slots_6_grant,
        issue_slots_5_grant,
        issue_slots_4_grant,
        issue_slots_3_grant,
        issue_slots_2_grant,
        issue_slots_1_grant,
        issue_slots_0_grant,
        reset,
        clock
);

  wire _GEN = {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, issue_slots_0_grant} + {1'h0, issue_slots_1_grant}} + {1'h0, {1'h0, issue_slots_2_grant} + {1'h0, issue_slots_3_grant} + {1'h0, issue_slots_4_grant}}} + {1'h0, {1'h0, {1'h0, issue_slots_5_grant} + {1'h0, issue_slots_6_grant}} + {1'h0, {1'h0, issue_slots_7_grant} + {1'h0, issue_slots_8_grant} + {1'h0, issue_slots_9_grant}}}} + {1'h0, {1'h0, {1'h0, {1'h0, issue_slots_10_grant} + {1'h0, issue_slots_11_grant}} + {1'h0, {1'h0, issue_slots_12_grant} + {1'h0, issue_slots_13_grant} + {1'h0, issue_slots_14_grant}}} + {1'h0, {1'h0, {1'h0, issue_slots_15_grant} + {1'h0, issue_slots_16_grant}} + {1'h0, {1'h0, issue_slots_17_grant} + {1'h0, issue_slots_18_grant} + {1'h0, issue_slots_19_grant}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, issue_slots_20_grant} + {1'h0, issue_slots_21_grant}} + {1'h0, {1'h0, issue_slots_22_grant} + {1'h0, issue_slots_23_grant} + {1'h0, issue_slots_24_grant}}} + {1'h0, {1'h0, {1'h0, issue_slots_25_grant} + {1'h0, issue_slots_26_grant}} + {1'h0, {1'h0, issue_slots_27_grant} + {1'h0, issue_slots_28_grant} + {1'h0, issue_slots_29_grant}}}} + {1'h0, {1'h0, {1'h0, {1'h0, issue_slots_30_grant} + {1'h0, issue_slots_31_grant}} + {1'h0, {1'h0, issue_slots_32_grant} + {1'h0, issue_slots_33_grant} + {1'h0, issue_slots_34_grant}}} + {1'h0, {1'h0, {1'h0, issue_slots_35_grant} + {1'h0, issue_slots_36_grant}} + {1'h0, {1'h0, issue_slots_37_grant} + {1'h0, issue_slots_38_grant} + {1'h0, issue_slots_39_grant}}}}} < 6'h5;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed: [issue] window giving out too many grants.\n    at issue-unit.scala:172 assert (PopCount(issue_slots.map(s => s.grant)) <= issueWidth.U, \"[issue] window giving out too many grants.\")\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset)
      assert__assert: assert(_GEN);
  end // always @(posedge)
endmodule
