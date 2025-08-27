module gf180mcu_fd_io__dvdd_tail (DVDD, DVSS, VSS);
        inout   DVDD;
        inout   DVSS;
        inout   VSS;
        supply1 DVDD;
endmodule

module gf180mcu_fd_io__dvss_tail (DVDD, DVSS, VDD);
        inout   DVDD;
        inout   DVSS;
        inout   VDD;
        supply0 DVSS;
endmodule
