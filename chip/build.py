#!/usr/bin/env python3

# Based on https://github.com/TinyTapeout/tt-multiplexer/blob/ihp2025/ol2/tt_top/build.py by Sylvain Munaut

import os
import glob

from librelane.common import Path
from librelane.flows.sequential import SequentialFlow
from librelane.steps.openroad import OpenROADStep
from librelane.steps import Step, Yosys, OpenROAD, Magic, Misc, KLayout, Odb, Netgen, Checker


@Step.factory.register()
class PadRing(OpenROADStep):

    id = "AS.Top.PadRing"
    name = "Creates Pad Ring"

    def get_script_path(self):
        return os.path.join(
            os.path.dirname(__file__),
            "padring.tcl"
        )

class TopFlow(SequentialFlow):

    Steps = [
        Yosys.JsonHeader,
        Yosys.Synthesis,
        Checker.YosysUnmappedCells,
        Checker.YosysSynthChecks,
        OpenROAD.Floorplan,
        Odb.SetPowerConnections,
        PadRing,
        Odb.ManualMacroPlacement,
        OpenROAD.CutRows,
        Odb.AddPDNObstructions,
        OpenROAD.GeneratePDN,
        Odb.RemovePDNObstructions,
        Odb.AddRoutingObstructions,
        OpenROAD.GlobalPlacement,
        Odb.WriteVerilogHeader,
        Checker.PowerGridViolations,
        OpenROAD.DetailedPlacement,
        OpenROAD.GlobalRouting,
        OpenROAD.DetailedRouting,
        Odb.RemoveRoutingObstructions,
        Checker.TrDRC,
        Odb.ReportDisconnectedPins,
        Checker.DisconnectedPins,
        Odb.ReportWireLength,
        Checker.WireLength,
        Odb.CellFrequencyTables,
        OpenROAD.RCX,
        OpenROAD.STAPostPNR,
        OpenROAD.IRDropReport,
        Magic.StreamOut,
        KLayout.StreamOut,
        KLayout.XOR,
        Checker.XOR,
        Magic.SpiceExtraction,
        Checker.IllegalOverlap,
        Netgen.LVS,
        #Checker.LVS,
        #Magic.DRC,
        #Checker.MagicDRC,
        #Checker.SetupViolations,
        Checker.HoldViolations,
        Checker.MaxSlewViolations,
        Checker.MaxCapViolations,
        Misc.ReportManufacturability
    ]

def latest_dir_for(path):
    sdir = f"{path}/runs/"
    files = list(filter(os.path.isdir, glob.glob(sdir + "*")))
    files.sort(key=lambda x: os.path.getmtime(x))
    return files[-1]
    
def macro_config(entries):
    macros = {}
    for name, path, instance, x, y in entries:
        latest_run_dir = latest_dir_for(path)
        macro = {
            "gds": [f"dir::{latest_run_dir}/final/gds/{name}.gds"],
            "lef": [f"dir::{latest_run_dir}/final/lef/{name}.lef"],
            "pnl": [f"dir::{latest_run_dir}/final/pnl/{name}.pnl.v"],
            "spef": {
                "min_*": [f"dir::{latest_run_dir}/final/spef/min/{name}.min.spef"],
                "nom_*": [f"dir::{latest_run_dir}/final/spef/nom/{name}.nom.spef"],
                "max_*": [f"dir::{latest_run_dir}/final/spef/max/{name}.max.spef"],
            },
            "lib": {},
            "instances": {
                instance: {
                    "location": [x, y],
                    "orientation": "N",
                }
            }
        }
        for corner in os.listdir(f"{latest_run_dir}/final/lib"):
            macro["lib"][corner] = [f"dir::{latest_run_dir}/final/lib/{corner}/{name}__{corner}.lib"]
        macros[name] = macro
    return macros


if __name__ == '__main__':

    PDK_ROOT = os.getenv('PDK_ROOT')
    PDK = 'gf180mcuD'

    sources = [
        "dir::src/chip.v",
        f"dir::{latest_dir_for("../user_project_wrapper")}/final/pnl/user_project_wrapper.pnl.v",
        "dir::../custom_power_pads/verilog/custom_power_pads.v"
    ]

    die_area = [0.00, 0.00, 3880.00, 5100.00]
    padring_size = 390
    flow_cfg = {
        "DESIGN_NAME": "chip",
        "VERILOG_FILES": sources,
        "MACROS": macro_config([
            ("user_project_wrapper", "../user_project_wrapper", "user_project_wrapper", 488, 488)
        ]),
        "CLOCK_PORT": "digital_pad[44]",
        "CLOCK_PERIOD": 35,
        "VERILOG_POWER_DEFINE": "USE_POWER_PINS",
        "VDD_NETS": ["vddcore"],
        "GND_NETS": ["vsscore"],
        "PDN_MACRO_CONNECTIONS": [
            "user_project_wrapper vddcore vsscore VDD VSS"
        ],
        #"IGNORE_DISCONNECTED_MODULES": [
        #    "gf180mcu_fd_io__bi_24t",
        #    "gf180mcu_fd_io__in_c",
        #    "gf180mcu_fd_io__asig_5p0"
        #],
        "EXTRA_LIBS": [
            "pdk_dir::libs.ref/gf180mcu_fd_io/lib/gf180mcu_fd_io__tt_025C_5v00.lib",
            "dir::../custom_power_pads/lib/custom_power_pads.lib"
        ],
        "EXTRA_LEFS": [
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__dvss.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__dvdd.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__in_c.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__in_s.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__bi_t.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__bi_24t.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__asig_5p0.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__cor.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__fill10.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__fill5.lef",
            "pdk_dir::libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__fill1.lef",
            "dir::../custom_power_pads/lef/gf180mcu_fd_io__dvdd_tail.lef",
            "dir::../custom_power_pads/lef/gf180mcu_fd_io__dvss_tail.lef"
        ],
        "EXTRA_GDS": [
            "pdk_dir::libs.ref/gf180mcu_fd_io/gds/gf180mcu_fd_io.gds",
            "dir::../custom_power_pads/gds/gf180mcu_fd_io__dvdd_tail.gds",
            "dir::../custom_power_pads/gds/gf180mcu_fd_io__dvss_tail.gds"
        ],
        "DIE_AREA": die_area,
        "CORE_AREA": [die_area[0] + padring_size, die_area[1] + padring_size, die_area[2] - padring_size, die_area[3] - padring_size],
        "FP_SIZING" : "absolute",
        "PDN_MULTILAYER": True,
        "PDN_CORE_RING": True,
        "PDN_ENABLE_RAILS": False,
        "PDN_CORE_RING_VWIDTH": 6,
        "PDN_CORE_RING_HWIDTH": 6,
        "PDN_CORE_RING_VOFFSET": 3,
        "PDN_CORE_RING_HOFFSET": 3,
        "PDN_CORE_RING_VSPACING": 2,
        "PDN_CORE_RING_HSPACING": 2,
        "PDN_HPITCH": 28.0,
        "PDN_VPITCH": 28.0,
        "FP_PDN_CFG": "dir::pdn.tcl"
    }

    flow = TopFlow(flow_cfg, design_dir=".", pdk_root=PDK_ROOT, pdk=PDK)
    flow.start(tag="chip", overwrite=True)

