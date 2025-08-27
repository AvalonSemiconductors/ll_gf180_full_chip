`default_nettype none
`timescale 1ns/1ps

module tb (
	input clk,
	input rst_n,
	input vdd,
	input oeb,
	input web,
	output [40:0] count,
	input [40:0] count_set
);

initial begin
	$dumpfile ("tb.vcd");
	$dumpvars (0, tb);
	#1;
end

wire [44:0] digital_pad;
assign digital_pad[41] = oeb;
assign digital_pad[42] = web;
assign digital_pad[43] = rst_n;
assign digital_pad[44] = clk;
assign count = digital_pad[40:0];
assign digital_pad[40:0] = web ? 41'hzzzzzzzzzzz : count_set;

`ifdef USE_POWER_PINS
tri1 vddcore;
tri0 vsscore;
`endif

chip chip(
`ifdef USE_POWER_PINS
	.vddcore(vddcore),
	.vsscore(vsscore),
`endif
	.digital_pad(digital_pad)
);

endmodule
