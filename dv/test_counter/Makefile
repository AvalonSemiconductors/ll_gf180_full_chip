SIM ?= vicarus
TOPLEVEL_LANG ?= verilog

COMPILE_ARGS += -DSIM
VERILOG_SOURCES += $(PWD)/tb.v
VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_io/verilog/gf180mcu_fd_io.v

ifneq ($(GL),yes)
VERILOG_SOURCES += $(PWD)/../includes.rtl.v
else
COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
COMPILE_ARGS += -DUSE_POWER_PINS
VERILOG_SOURCES += $(PWD)/../includes.gl.v
VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/gf180mcu_fd_sc_mcu7t5v0.v
endif

TOPLEVEL = tb

MODULE = test

include $(shell cocotb-config --makefiles)/simulators/Makefile.icarus

.PHONY: clean sim
