import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_counter(dut):
	dut._log.info("start")
	clock = Clock(dut.clk, 40, units="ns")
	cocotb.start_soon(clock.start())
	
	dut.vdd.value = 1
	dut.rst_n.value = 0
	dut.oeb.value = 0
	dut.web.value = 1
	await ClockCycles(dut.clk, 10)
	dut.rst_n.value = 1
	await ClockCycles(dut.clk, 300)
	assert dut.count.value == 300
	dut.count_set.value = 10000
	dut.oeb.value = 1
	dut.web.value = 0
	await ClockCycles(dut.clk, 1)
	dut.oeb.value = 0
	dut.web.value = 1
	assert dut.count.value == 10000
	await ClockCycles(dut.clk, 6)
	assert dut.count.value == 10005
	dut.oeb.value = 1
	await ClockCycles(dut.clk, 5)
	assert dut.count.value == 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'
	dut.oeb.value = 0
	await ClockCycles(dut.clk, 5)
	assert dut.count.value == 10015
