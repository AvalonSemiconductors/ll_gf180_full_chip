#!/usr/bin/env python3

# Based on https://github.com/TinyTapeout/tt-multiplexer/blob/ihp2025/ol2/tt_top/build.py by Sylvain Munaut

import os
import glob

from librelane.common import Path
from librelane.flows.sequential import SequentialFlow
from librelane.steps.openroad import OpenROADStep
from librelane.steps import Step, Yosys, OpenROAD, Magic, Misc, KLayout, Odb, Netgen, Checker

def macro_config(entries):
    macros = {}
    for name, path, instance, x, y in entries:
        sdir = f"{path}/runs/"
        files = list(filter(os.path.isdir, glob.glob(sdir + "*")))
        files.sort(key=lambda x: os.path.getmtime(x))
        latest_run_dir = files[-1]
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

class TopFlow(SequentialFlow):

    Steps = [
        Yosys.JsonHeader,
        Yosys.Synthesis,
        Checker.YosysUnmappedCells,
        Checker.YosysSynthChecks,
        OpenROAD.Floorplan,
        Odb.SetPowerConnections,
        Odb.ManualMacroPlacement,
        OpenROAD.CutRows,
        Odb.AddPDNObstructions,
        OpenROAD.GeneratePDN,
        Odb.RemovePDNObstructions,
        Odb.AddRoutingObstructions,
        OpenROAD.GlobalPlacementSkipIO,
        OpenROAD.IOPlacement,
        Odb.CustomIOPlacement,
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
        Magic.WriteLEF,
        KLayout.XOR,
        Checker.XOR,
        Magic.SpiceExtraction,
        Checker.IllegalOverlap,
        Netgen.LVS,
        Checker.LVS,
        Magic.DRC,
        Checker.MagicDRC,
        Checker.SetupViolations,
        Checker.HoldViolations,
        Checker.MaxSlewViolations,
        Checker.MaxCapViolations,
        Misc.ReportManufacturability
    ]

if __name__ == '__main__':

    PDK_ROOT = os.getenv('PDK_ROOT')
    PDK = 'gf180mcuD'

    sources = [
        "dir::src/user_project_wrapper.v"
    ]

    die_area = [0.00, 0.00, 2904.00, 4124.00]
    padding = 25
    flow_cfg = {
        "DESIGN_NAME": "user_project_wrapper",
        "VERILOG_FILES": sources,
        "MACROS": macro_config([
            ("user_project_example", "../projects/user_project_example", "user_project_example", 500, 500)
        ]),
        "CLOCK_PORT": "clk_i",
        "CLOCK_PERIOD": 25,
        "VERILOG_POWER_DEFINE": "USE_POWER_PINS",
        "VDD_NETS": ["VDD"],
        "GND_NETS": ["VSS"],
        "PDN_MACRO_CONNECTIONS": [
            "user_project_example VDD VSS VDD VSS"
        ],
        "DIE_AREA": die_area,
        "CORE_AREA": [die_area[0] + padding + 0.2, die_area[1] + padding + 0.44, die_area[2] - padding, die_area[3] - padding],
        "FP_SIZING" : "absolute",
        "PDN_MULTILAYER": True,
        "PDN_ENABLE_RAILS": False,
        "RT_MAX_LAYER": "Metal5",
        "PDN_CORE_RING": True,
        "PDN_CORE_RING_VWIDTH": 5,
        "PDN_CORE_RING_HWIDTH": 5,
        "PDN_CORE_RING_VOFFSET": 3,
        "PDN_CORE_RING_HOFFSET": 3,
        "PDN_CORE_RING_VSPACING": 2,
        "PDN_CORE_RING_HSPACING": 2,
        "PDN_HPITCH": 28.0,
        "PDN_VPITCH": 28.0,
        "IO_PIN_H_LENGTH": 2,
        "IO_PIN_V_LENGTH": 2,
        "TOP_MARGIN_MULT": 1,
        "BOTTOM_MARGIN_MULT": 1,
        "LEFT_MARGIN_MULT": 6,
        "RIGHT_MARGIN_MULT": 6,
        "IO_PIN_ORDER_CFG": "dir::pin_order.cfg",
        "MAGIC_DEF_LABELS": False,
        "MAGIC_WRITE_LEF_PINONLY": True
    }

    flow = TopFlow(flow_cfg, design_dir=".", pdk_root=PDK_ROOT, pdk=PDK)
    flow.start(tag="latest", overwrite=True)

