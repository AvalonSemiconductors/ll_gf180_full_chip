`default_nettype none

module chip (
`ifdef CONNECT_POWER_PADS
    inout wire [8:0] power_pad_vdd,
    inout wire [8:0] power_pad_vss,
`endif
//`ifdef CONNECT ANALOG_PADS
    //inout wire [3:0] analog_pad,
//`endif
    inout wire [44:0] digital_pad
);

wire vsscore;
wire vddcore;
wire m_clk;
wire m_rstb;
//wire [3:0] analogs;
wire [42:0] io_in;
wire [42:0] io_out;
wire [42:0] io_oe;
wire [42:0] io_cs;
wire [42:0] io_sl;
wire [42:0] io_pu;
wire [42:0] io_pd;
wire [42:0] io_ie;

wire const_one;
wire const_zero;

//`ifndef CONNECT_ANALOG_PADS
//wire loop;
//`endif

user_project_wrapper user_project_wrapper (
`ifdef USE_POWER_PINS
	.VSS(vsscore),
	.VDD(vddcore),
`endif
	.clk_i(m_clk),
	.rst_n(m_rstb),
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

`ifdef CONNECT_POWER_PADS
assign power_pad_vss[0] = vsscore;
assign power_pad_vss[1] = vsscore;
assign power_pad_vss[2] = vsscore;
assign power_pad_vss[3] = vsscore;
assign power_pad_vss[4] = vsscore;
assign power_pad_vss[5] = vsscore;
assign power_pad_vss[6] = vsscore;
assign power_pad_vss[7] = vsscore;
assign power_pad_vss[8] = vsscore;
assign power_pad_vdd[0] = vddcore;
assign power_pad_vdd[1] = vddcore;
assign power_pad_vdd[2] = vddcore;
assign power_pad_vdd[3] = vddcore;
assign power_pad_vdd[4] = vddcore;
assign power_pad_vdd[5] = vddcore;
assign power_pad_vdd[6] = vddcore;
assign power_pad_vdd[7] = vddcore;
assign power_pad_vdd[8] = vddcore;
`endif

/*`ifdef CONNECT_ANALOG_PADS
assign analog_pad[0] = analogs[0];
assign analog_pad[1] = analogs[1];
assign analog_pad[2] = analogs[2];
assign analog_pad[3] = analogs[3];
`endif*/

// IO_WEST
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_20     (.PAD(digital_pad[24]), .Y(io_in[24]), .A(io_out[24]), .OE(io_oe[24]), .IE(io_ie[24]), .SL(io_sl[24]), .CS(io_cs[24]), .PD(io_pd[24]), .PU(io_pu[24]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvdd     pad_w_19     (.DVDD(power_pad_vdd[0]));
(* keep *) gf180mcu_fd_io__dvdd     pad_w_18     (.DVDD(power_pad_vdd[1]));
(* keep *) gf180mcu_fd_io__dvss     pad_w_17     (.DVSS(power_pad_vss[0]));
`else
(* keep *) gf180mcu_fd_io__dvdd     pad_w_19     ();
(* keep *) gf180mcu_fd_io__dvdd     pad_w_18     ();
(* keep *) gf180mcu_fd_io__dvss     pad_w_17     ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_16     (.PAD(digital_pad[25]), .Y(io_in[25]), .A(io_out[25]), .OE(io_oe[25]), .IE(io_ie[25]), .SL(io_sl[25]), .CS(io_cs[25]), .PD(io_pd[25]), .PU(io_pu[25]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_15     (.PAD(digital_pad[26]), .Y(io_in[26]), .A(io_out[26]), .OE(io_oe[26]), .IE(io_ie[26]), .SL(io_sl[26]), .CS(io_cs[26]), .PD(io_pd[26]), .PU(io_pu[26]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_14     (.PAD(digital_pad[27]), .Y(io_in[27]), .A(io_out[27]), .OE(io_oe[27]), .IE(io_ie[27]), .SL(io_sl[27]), .CS(io_cs[27]), .PD(io_pd[27]), .PU(io_pu[27]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_13     (.PAD(digital_pad[28]), .Y(io_in[28]), .A(io_out[28]), .OE(io_oe[28]), .IE(io_ie[28]), .SL(io_sl[28]), .CS(io_cs[28]), .PD(io_pd[28]), .PU(io_pu[28]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_12     (.PAD(digital_pad[29]), .Y(io_in[29]), .A(io_out[29]), .OE(io_oe[29]), .IE(io_ie[29]), .SL(io_sl[29]), .CS(io_cs[29]), .PD(io_pd[29]), .PU(io_pu[29]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_11     (.PAD(digital_pad[30]), .Y(io_in[30]), .A(io_out[30]), .OE(io_oe[30]), .IE(io_ie[30]), .SL(io_sl[30]), .CS(io_cs[30]), .PD(io_pd[30]), .PU(io_pu[30]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_10     (.PAD(digital_pad[31]), .Y(io_in[31]), .A(io_out[31]), .OE(io_oe[31]), .IE(io_ie[31]), .SL(io_sl[31]), .CS(io_cs[31]), .PD(io_pd[31]), .PU(io_pu[31]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvdd     pad_w_9      (.DVDD(power_pad_vdd[2]));
(* keep *) gf180mcu_fd_io__dvss     pad_w_8      (.DVSS(power_pad_vss[1]));
`else
(* keep *) gf180mcu_fd_io__dvdd     pad_w_9      ();
(* keep *) gf180mcu_fd_io__dvss     pad_w_8      ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_7      (.PAD(digital_pad[32]), .Y(io_in[32]), .A(io_out[32]), .OE(io_oe[32]), .IE(io_ie[32]), .SL(io_sl[32]), .CS(io_cs[32]), .PD(io_pd[32]), .PU(io_pu[32]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_6      (.PAD(digital_pad[33]), .Y(io_in[33]), .A(io_out[33]), .OE(io_oe[33]), .IE(io_ie[33]), .SL(io_sl[33]), .CS(io_cs[33]), .PD(io_pd[33]), .PU(io_pu[33]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_5      (.PAD(digital_pad[34]), .Y(io_in[34]), .A(io_out[34]), .OE(io_oe[34]), .IE(io_ie[34]), .SL(io_sl[34]), .CS(io_cs[34]), .PD(io_pd[34]), .PU(io_pu[34]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_4      (.PAD(digital_pad[35]), .Y(io_in[35]), .A(io_out[35]), .OE(io_oe[35]), .IE(io_ie[35]), .SL(io_sl[35]), .CS(io_cs[35]), .PD(io_pd[35]), .PU(io_pu[35]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_3      (.PAD(digital_pad[36]), .Y(io_in[36]), .A(io_out[36]), .OE(io_oe[36]), .IE(io_ie[36]), .SL(io_sl[36]), .CS(io_cs[36]), .PD(io_pd[36]), .PU(io_pu[36]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_w_2      (.PAD(digital_pad[37]), .Y(io_in[37]), .A(io_out[37]), .OE(io_oe[37]), .IE(io_ie[37]), .SL(io_sl[37]), .CS(io_cs[37]), .PD(io_pd[37]), .PU(io_pu[37]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvdd     pad_w_1      (.DVDD(power_pad_vdd[3]));
(* keep *) gf180mcu_fd_io__dvdd     pad_w_0      (.DVDD(power_pad_vdd[4]));
`else
(* keep *) gf180mcu_fd_io__dvdd     pad_w_1      ();
(* keep *) gf180mcu_fd_io__dvdd     pad_w_0      ();
`endif

// IO_SOUTH
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvss     pad_s_0      (.DVSS(power_pad_vss[2]));
`else
(* keep *) gf180mcu_fd_io__dvss     pad_s_0      ();
`endif
(* keep *) gf180mcu_fd_io__in_c     pad_s_1      (.PAD(digital_pad[43]), .Y(m_rstb), .PD(const_one), .PU(const_zero));
(* keep *) gf180mcu_fd_io__in_c     pad_s_2      (.PAD(digital_pad[44]), .Y(m_clk), .PD(const_zero), .PU(const_zero));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvss     pad_s_3      (.DVSS(power_pad_vss[3]));
`else
(* keep *) gf180mcu_fd_io__dvss     pad_s_3      ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_s_4      (.PAD(digital_pad[38]), .Y(io_in[38]), .A(io_out[38]), .OE(io_oe[38]), .IE(io_ie[38]), .SL(io_sl[38]), .CS(io_cs[38]), .PD(io_pd[38]), .PU(io_pu[38]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_s_5      (.PAD(digital_pad[39]), .Y(io_in[39]), .A(io_out[39]), .OE(io_oe[39]), .IE(io_ie[39]), .SL(io_sl[39]), .CS(io_cs[39]), .PD(io_pd[39]), .PU(io_pu[39]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_s_6      (.PAD(digital_pad[40]), .Y(io_in[40]), .A(io_out[40]), .OE(io_oe[40]), .IE(io_ie[40]), .SL(io_sl[40]), .CS(io_cs[40]), .PD(io_pd[40]), .PU(io_pu[40]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_s_7      (.PAD(digital_pad[41]), .Y(io_in[41]), .A(io_out[41]), .OE(io_oe[41]), .IE(io_ie[41]), .SL(io_sl[41]), .CS(io_cs[41]), .PD(io_pd[41]), .PU(io_pu[41]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_s_8      (.PAD(digital_pad[42]), .Y(io_in[42]), .A(io_out[42]), .OE(io_oe[42]), .IE(io_ie[42]), .SL(io_sl[42]), .CS(io_cs[42]), .PD(io_pd[42]), .PU(io_pu[42]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvss     pad_s_9      (.DVSS(power_pad_vss[4]));
(* keep *) gf180mcu_fd_io__dvdd     pad_s_10     (.DVDD(power_pad_vdd[5]));
`else
(* keep *) gf180mcu_fd_io__dvss     pad_s_9      ();
(* keep *) gf180mcu_fd_io__dvdd     pad_s_10     ();
`endif

// IO_EAST
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_0      (.PAD(digital_pad[0 ]), .Y(io_in[0 ]), .A(io_out[0 ]), .OE(io_oe[0 ]), .IE(io_ie[0 ]), .SL(io_sl[0 ]), .CS(io_cs[0 ]), .PD(io_pd[0 ]), .PU(io_pu[0 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_1      (.PAD(digital_pad[1 ]), .Y(io_in[1 ]), .A(io_out[1 ]), .OE(io_oe[1 ]), .IE(io_ie[1 ]), .SL(io_sl[1 ]), .CS(io_cs[1 ]), .PD(io_pd[1 ]), .PU(io_pu[1 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_2      (.PAD(digital_pad[2 ]), .Y(io_in[2 ]), .A(io_out[2 ]), .OE(io_oe[2 ]), .IE(io_ie[2 ]), .SL(io_sl[2 ]), .CS(io_cs[2 ]), .PD(io_pd[2 ]), .PU(io_pu[2 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_3      (.PAD(digital_pad[3 ]), .Y(io_in[3 ]), .A(io_out[3 ]), .OE(io_oe[3 ]), .IE(io_ie[3 ]), .SL(io_sl[3 ]), .CS(io_cs[3 ]), .PD(io_pd[3 ]), .PU(io_pu[3 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_4      (.PAD(digital_pad[4 ]), .Y(io_in[4 ]), .A(io_out[4 ]), .OE(io_oe[4 ]), .IE(io_ie[4 ]), .SL(io_sl[4 ]), .CS(io_cs[4 ]), .PD(io_pd[4 ]), .PU(io_pu[4 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_5      (.PAD(digital_pad[5 ]), .Y(io_in[5 ]), .A(io_out[5 ]), .OE(io_oe[5 ]), .IE(io_ie[5 ]), .SL(io_sl[5 ]), .CS(io_cs[5 ]), .PD(io_pd[5 ]), .PU(io_pu[5 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_6      (.PAD(digital_pad[6 ]), .Y(io_in[6 ]), .A(io_out[6 ]), .OE(io_oe[6 ]), .IE(io_ie[6 ]), .SL(io_sl[6 ]), .CS(io_cs[6 ]), .PD(io_pd[6 ]), .PU(io_pu[6 ]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvss     pad_e_7      (.DVSS(power_pad_vss[5]));
(* keep *) gf180mcu_fd_io__dvss     pad_e_8      (.DVSS(power_pad_vss[6]));
(* keep *) gf180mcu_fd_io__dvdd     pad_e_9      (.DVDD(power_pad_vdd[6]));
`else
(* keep *) gf180mcu_fd_io__dvss     pad_e_7      ();
(* keep *) gf180mcu_fd_io__dvss     pad_e_8      ();
(* keep *) gf180mcu_fd_io__dvdd     pad_e_9      ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_10     (.PAD(digital_pad[7 ]), .Y(io_in[7 ]), .A(io_out[7 ]), .OE(io_oe[7 ]), .IE(io_ie[7 ]), .SL(io_sl[7 ]), .CS(io_cs[7 ]), .PD(io_pd[7 ]), .PU(io_pu[7 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_11     (.PAD(digital_pad[8 ]), .Y(io_in[8 ]), .A(io_out[8 ]), .OE(io_oe[8 ]), .IE(io_ie[8 ]), .SL(io_sl[8 ]), .CS(io_cs[8 ]), .PD(io_pd[8 ]), .PU(io_pu[8 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_12     (.PAD(digital_pad[9 ]), .Y(io_in[9 ]), .A(io_out[9 ]), .OE(io_oe[9 ]), .IE(io_ie[9 ]), .SL(io_sl[9 ]), .CS(io_cs[9 ]), .PD(io_pd[9 ]), .PU(io_pu[9 ]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_13     (.PAD(digital_pad[10]), .Y(io_in[10]), .A(io_out[10]), .OE(io_oe[10]), .IE(io_ie[10]), .SL(io_sl[10]), .CS(io_cs[10]), .PD(io_pd[10]), .PU(io_pu[10]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_14     (.PAD(digital_pad[11]), .Y(io_in[11]), .A(io_out[11]), .OE(io_oe[11]), .IE(io_ie[11]), .SL(io_sl[11]), .CS(io_cs[11]), .PD(io_pd[11]), .PU(io_pu[11]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_15     (.PAD(digital_pad[12]), .Y(io_in[12]), .A(io_out[12]), .OE(io_oe[12]), .IE(io_ie[12]), .SL(io_sl[12]), .CS(io_cs[12]), .PD(io_pd[12]), .PU(io_pu[12]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvdd     pad_e_16     (.DVDD(power_pad_vdd[7]));
`else
(* keep *) gf180mcu_fd_io__dvdd     pad_e_16     ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_17     (.PAD(digital_pad[13]), .Y(io_in[13]), .A(io_out[13]), .OE(io_oe[13]), .IE(io_ie[13]), .SL(io_sl[13]), .CS(io_cs[13]), .PD(io_pd[13]), .PU(io_pu[13]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvdd     pad_e_18     (.DVDD(power_pad_vdd[8]));
`else
(* keep *) gf180mcu_fd_io__dvdd     pad_e_18     ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_e_19     (.PAD(digital_pad[14]), .Y(io_in[14]), .A(io_out[14]), .OE(io_oe[14]), .IE(io_ie[14]), .SL(io_sl[14]), .CS(io_cs[14]), .PD(io_pd[14]), .PU(io_pu[14]));

// IO_NORTH
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_10     (.PAD(digital_pad[15]), .Y(io_in[15]), .A(io_out[15]), .OE(io_oe[15]), .IE(io_ie[15]), .SL(io_sl[15]), .CS(io_cs[15]), .PD(io_pd[15]), .PU(io_pu[15]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvss     pad_n_9      (.DVSS(power_pad_vss[7]));
`else
(* keep *) gf180mcu_fd_io__dvss     pad_n_9      ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_8      (.PAD(digital_pad[16]), .Y(io_in[16]), .A(io_out[16]), .OE(io_oe[16]), .IE(io_ie[16]), .SL(io_sl[16]), .CS(io_cs[16]), .PD(io_pd[16]), .PU(io_pu[16]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_7      (.PAD(digital_pad[17]), .Y(io_in[17]), .A(io_out[17]), .OE(io_oe[17]), .IE(io_ie[17]), .SL(io_sl[17]), .CS(io_cs[17]), .PD(io_pd[17]), .PU(io_pu[17]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_6      (.PAD(digital_pad[18]), .Y(io_in[18]), .A(io_out[18]), .OE(io_oe[18]), .IE(io_ie[18]), .SL(io_sl[18]), .CS(io_cs[18]), .PD(io_pd[18]), .PU(io_pu[18]));
`ifdef CONNECT_POWER_PADS
(* keep *) gf180mcu_fd_io__dvss     pad_n_5      (.DVSS(power_pad_vss[8]));
`else
(* keep *) gf180mcu_fd_io__dvss     pad_n_5      ();
`endif
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_4      (.PAD(digital_pad[19]), .Y(io_in[19]), .A(io_out[19]), .OE(io_oe[19]), .IE(io_ie[19]), .SL(io_sl[19]), .CS(io_cs[19]), .PD(io_pd[19]), .PU(io_pu[19]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_3      (.PAD(digital_pad[20]), .Y(io_in[20]), .A(io_out[20]), .OE(io_oe[20]), .IE(io_ie[20]), .SL(io_sl[20]), .CS(io_cs[20]), .PD(io_pd[20]), .PU(io_pu[20]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_2      (.PAD(digital_pad[21]), .Y(io_in[21]), .A(io_out[21]), .OE(io_oe[21]), .IE(io_ie[21]), .SL(io_sl[21]), .CS(io_cs[21]), .PD(io_pd[21]), .PU(io_pu[21]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_1      (.PAD(digital_pad[22]), .Y(io_in[22]), .A(io_out[22]), .OE(io_oe[22]), .IE(io_ie[22]), .SL(io_sl[22]), .CS(io_cs[22]), .PD(io_pd[22]), .PU(io_pu[22]));
(* keep *) gf180mcu_fd_io__bi_24t   pad_n_0      (.PAD(digital_pad[23]), .Y(io_in[23]), .A(io_out[23]), .OE(io_oe[23]), .IE(io_ie[23]), .SL(io_sl[23]), .CS(io_cs[23]), .PD(io_pd[23]), .PU(io_pu[23]));

// IO_NORTH
/*`ifdef CONNECT_ANALOG_PADS
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_7  (.ASIG5V(analog_pad[0]));
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_6  (.ASIG5V(analog_pad[1]));
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_5  (.ASIG5V(analog_pad[2]));
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_4  (.ASIG5V(analog_pad[3]));
`else
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_7  (loop);
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_6  (loop);
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_5  (loop);
(* keep *) gf180mcu_fd_io__asig_5p0 pad_n_4  (loop);
`endif*/

endmodule
