`default_nettype none

module user_project_wrapper(
`ifdef USE_POWER_PINS
	inout wire VSS,
	inout wire VDD,
`endif
	input clk_i,
	input rst_n,
	
	output [42:0] io_out,
	input [42:0] io_in,
	output [42:0] io_oe,
	output [42:0] io_cs,
	output [42:0] io_sl,
	output [42:0] io_pu,
	output [42:0] io_pd,
	output [42:0] io_ie,
	output const_one,
	output const_zero
);

user_project_example user_project_example(
`ifdef USE_POWER_PINS
	.VSS(VSS),
	.VDD(VDD),
`endif
	.clk_i(clk_i),
	.rst_n(rst_n),
	.io_out(io_out),
	.io_in(io_in),
	.io_oe(io_oe),
	.io_cs(io_cs),
	.io_sl(io_sl),
	.io_pu(io_pu),
	.io_pd(io_pd),
	.io_ie(io_ie),
	.const_one(const_one),
	.const_zero(const_zero)
);

endmodule
