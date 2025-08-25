`default_nettype none

module user_project_example(
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

assign io_cs = 43'h0;
assign io_sl = 43'h0;
assign io_pd = 43'h0;
assign io_pu = {2'b11, 41'h0};

wire OE  = !io_in[41];
wire WEb = io_in[42];

assign io_oe = {2'b00, {41{OE}}};
assign io_ie = ~io_oe;
assign const_one = 1'b1;
assign const_zero = 1'b0;

reg [40:0] count;
assign io_out = {2'b00, count};

always @(posedge clk_i) begin
	if(!rst_n) begin
		count <= 0;
	end else begin
		count <= count + 1;
		if(!WEb) count <= io_in[40:0];
	end
end

endmodule
